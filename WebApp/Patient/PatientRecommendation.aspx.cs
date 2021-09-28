using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Text;
using System.Security.Cryptography;
using Attune.Podium.SmartAccessor;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;



public partial class Patient_PatientRecommendation : BasePage
{
    long visitID = -1;
    long patientID = -1;
    string Url = string.Empty;
    
    ArrayList al = new ArrayList();
    List<PatientRecommendationDtls> rTemplate = new List<PatientRecommendationDtls>();
    protected void Page_Load(object sender, EventArgs e)
    {
   
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        
        if (ViewState["SelectedProds"] != null)
        {
            al = (ArrayList)ViewState["SelectedProds"];
        }

        if (!IsPostBack)
        {
            ViewState["Url"] = Request.UrlReferrer.ToString();
            LoadResult();
        }

    }

    private void LoadResult()
    {
        Investigation_BL invBL = new Investigation_BL(base.ContextInfo);
        List<InvResultTemplate> lstInvResultTemplate = new List<InvResultTemplate>();
        List<PhysicianSchedule> lstschedules = new List<PhysicianSchedule>();
        List<Patient> patientList = new List<Patient>();

        invBL.GetPatientRecommendationTemplate(OrgID, "Recommendation", " ", out lstInvResultTemplate);
        if (lstInvResultTemplate.Count > 0)
        {
            if (rTemplate.Count == 0)
            {
                new Patient_BL(base.ContextInfo).GetPatientRecommendationDetails(OrgID, visitID, patientID, out  rTemplate, out lstschedules, out patientList); ;
            }
            GridView1.DataSource = lstInvResultTemplate;
            GridView1.DataBind();

        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        try
        {
            Investigation_BL invBL = new Investigation_BL(base.ContextInfo);
            List<InvResultTemplate> lstInvResultTemplate = new List<InvResultTemplate>();
            List<PatientRecommendationDtls> lstprecommendation = new List<PatientRecommendationDtls>();
            AddToViewState();
            int i = 1;
            PatientRecommendation precommendation = new PatientRecommendation();
            precommendation.PatientID = patientID;
            precommendation.PatientVisitId = visitID;
            precommendation.OrgID = OrgID;
            precommendation.OrgAddressID = ILocationID;
            precommendation.CreatedBy = LID;

            foreach (string lst in al)
            {
                PatientRecommendationDtls precommendationDtls = new PatientRecommendationDtls();
                precommendationDtls.ResultID = Convert.ToInt32(lst.Split('~')[0]);
                precommendationDtls.ResultValues = lst.Split('~')[2];
                precommendationDtls.SequenceNO = i;
                lstprecommendation.Add(precommendationDtls);
                i++;
            }
            if (al.Count  == 0)
            {
                RegisterStartupScript("Alert", " <script language ='javascript'>  alert('Enter the value'); </script>");

            }
            returnCode = invBL.SavePatientRecommendation(precommendation,lstprecommendation);


            lblText.Text = "Sucessfully Save";
            
            Response.Redirect(@"../Patient/PrintRecommendation.aspx?pid=" + patientID + "&vid=" + visitID, true);

            
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Saveing SavePatientRecommendation", ex);
        }
    }
    
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        string prodID = string.Empty;
        string prodFName = string.Empty;
       
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                FredCK.FCKeditorV2.FCKeditor f = (FredCK.FCKeditorV2.FCKeditor)e.Row.FindControl("fckInvDetails");
                string sPath = Request.Url.AbsolutePath;
                int iIndex = sPath.LastIndexOf("/");
                sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
                sPath = Request.ApplicationPath;
                sPath = sPath + "/FCKeditor/";
                f.BasePath = sPath;
                f.ToolbarSet = "Attune";
                f.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
                f.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";
                InvResultTemplate obj = (InvResultTemplate)e.Row.DataItem;
                for (int i = 0; i < al.Count; i++)
                {
                    prodFName = al[i].ToString();
                    prodID = prodFName.Split('~')[0].ToString();
                    if (obj.ResultID == Convert.ToInt64(prodID))
                    {
                        ((CheckBox)e.Row.FindControl("ChkResult")).Checked = true;
                        ((FredCK.FCKeditorV2.FCKeditor)e.Row.FindControl("fckInvDetails")).Value = prodFName.Split('~')[2].ToString();
                    }

                }

               
               
                if (rTemplate.Count > 0)
                {
                    ArrayList arList = new ArrayList();
                    foreach (PatientRecommendationDtls pR in rTemplate)
                    {
                        string str = ((Label)e.Row.FindControl("lblResultID")).Text;
                        if (pR.ResultID.ToString() == str)
                        {
                            ((CheckBox)e.Row.FindControl("ChkResult")).Checked = true;
                            ((FredCK.FCKeditorV2.FCKeditor)e.Row.FindControl("fckInvDetails")).Value = pR.ResultValues;
                        }
                        string strProduct=string.Empty;
                        strProduct = pR.ResultID.ToString() + "~" + pR.ResultName + "~" + pR.ResultValues;
                        arList.Add(strProduct);
                    }ViewState["SelectedProds"] = arList;
                }
            }
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Redirect to PatientRecommendationDtls Page", ex);
        }



             
    }
    //protected void btnBack_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        Response.Redirect(@"../Patient/PatientEMRPackage.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID, true);
    //    }
    //    catch (System.Threading.ThreadAbortException tae)
    //    {
    //        string ta = tae.ToString();
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
    //    }
    //}
    
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Url = ViewState["Url"].ToString() + "&BackBtn=Y";
        Response.Redirect(Url, true);
    }
    
    protected void btnGo_Click(object sender, EventArgs e)
    {
      
        Investigation_BL invBL = new Investigation_BL(base.ContextInfo);
        List<InvResultTemplate> lstInvResultTemplate = new List<InvResultTemplate>();
        string ResultName = txtName.Text.Trim();
        invBL.GetPatientRecommendationTemplate(OrgID, "Recommendation", ResultName, out lstInvResultTemplate);
        if (lstInvResultTemplate.Count > 0)
        {
            GridView1.DataSource = lstInvResultTemplate;
            GridView1.DataBind();

        }
    }
    
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
       

        if (e.NewPageIndex != -1)
        {
            AddToViewState();
            GridView1.PageIndex = e.NewPageIndex;
            LoadResult();
        }
    }

    void AddToViewState()
    {
        long prodID = -1;
        string prodName = string.Empty;
        string strProduct = string.Empty;

        bool blnExists = false;
        string ProductDetails = string.Empty;
        string[] hiddenIDs = new string[] { };
        ArrayList alTemp = al;

        foreach (GridViewRow row in GridView1.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkBox = (CheckBox)row.FindControl("ChkResult");

                if (chkBox.Checked)
                {
                    FredCK.FCKeditorV2.FCKeditor f = (FredCK.FCKeditorV2.FCKeditor)row.FindControl("fckInvDetails");

                    prodID = Convert.ToInt64(GridView1.DataKeys[row.RowIndex][0].ToString());
                    prodName = GridView1.DataKeys[row.RowIndex][1].ToString();
                    strProduct = prodID.ToString() + "~" + prodName+"~"+f.Value;

                    if (al.Count > 0)
                    {
                        for (int i = 0; i < al.Count; i++)
                        {
                            if (al[i].ToString() == strProduct)
                            {
                                blnExists = true;
                                break;
                            }
                        }
                        if (!blnExists)
                        {
                            alTemp.Add(strProduct);
                        }
                    }
                    else
                    {
                        alTemp.Add(strProduct);
                    }
                    blnExists = false;
                }
                else
                {
                    FredCK.FCKeditorV2.FCKeditor f = (FredCK.FCKeditorV2.FCKeditor)row.FindControl("fckInvDetails");
                    prodID = Convert.ToInt64(GridView1.DataKeys[row.RowIndex][0].ToString());
                    prodName = GridView1.DataKeys[row.RowIndex][1].ToString();
                    strProduct = prodID.ToString() + "~" + prodName + "~" + f.Value;

                    if (al.Count > 0)
                    {
                        for (int i = 0; i < al.Count; i++)
                        {

                            if (al[i].ToString() == strProduct)
                            {
                                blnExists = true;
                                break;
                            }
                        }
                        if (blnExists)
                        {
                            alTemp.Remove(strProduct);
                        }
                    }
                }
            }
        }
        ViewState["SelectedProds"] = alTemp;
    }
    
  
   
}

