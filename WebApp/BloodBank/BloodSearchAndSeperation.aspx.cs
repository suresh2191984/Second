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
using System.Web.UI.HtmlControls;
using Attune.Podium.SmartAccessor;
using Attune.Podium.EMR;

public partial class BloodBank_BloodSearchAndSeperation : BasePage
{
    long visitID = 0;
    long returnCode = -1;
    long taskID = -1;
    List<BloodGroup> lstBloodGrp = new List<BloodGroup>();
    List<BloodComponent> lstBloodComponent = new List<BloodComponent>();
    List<BloodCapturedDetials> lstBloodCapture = new List<BloodCapturedDetials>();
    List<BloodCollectionDetails> lstBloodCollect = new List<BloodCollectionDetails>();
    List<BloodSeparationDetails> lstSeparationDetails = new List<BloodSeparationDetails>();
    List<Products> lstProducts = new List<Products>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
           returnCode = new BloodBank_BL(base.ContextInfo).GetBloodGroupsAndComponents(out lstBloodGrp, out lstBloodComponent);
           if (returnCode == 0)
           {
            
                if (lstBloodComponent.Count > 0)
                {           
                    ddlComponent.DataSource = lstBloodComponent;
                    ddlComponent.DataValueField = "BloodComponentID";
                    ddlComponent.DataTextField = "BloodComponentName";
                    ddlComponent.DataBind();
                }
            }
            LoadMetaData();
        }
    }
    public void LoadMetaData()
    {
        try
        {

            long returncode = -1;
            string domains = "BloodGroup,BloodComponent,BloodBagType";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";

            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            MetaData ObjMetadata=new MetaData();
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }


            returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {

                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "BloodGroup"
                                  select child;


                ddlSearchBloodGroup.DataSource = childItems2;
                ddlSearchBloodGroup.DataTextField = "DisplayText";
                ddlSearchBloodGroup.DataValueField = "Code";
                ddlSearchBloodGroup.DataBind();
                ddlSearchBloodGroup.Items.Insert(0, "--Select--");
                ddlSearchBloodGroup.Items[0].Value = "0";

                var childItems3 = from child in lstmetadataOutput
                                  where child.Domain == "BloodComponent"
                                  select child;


                ddlSearchBloodType.DataSource = childItems3;
                ddlSearchBloodType.DataTextField = "DisplayText";
                ddlSearchBloodType.DataValueField = "Code";
                ddlSearchBloodType.DataBind();
                ddlSearchBloodType.Items.Insert(0, "--Select--");
                ddlSearchBloodType.Items[0].Value = "0";

                //ddlComponent.DataSource = childItems3;
                //ddlComponent.DataTextField = "DisplayText";
                //ddlComponent.DataValueField = "Code";
                //ddlComponent.DataBind();
                //ddlComponent.Items.Insert(0, "--Select--");
                //ddlComponent.Items[0].Value = "0";

                var childItems4 = from child in lstmetadataOutput
                                  where child.Domain == "BloodBagType"
                                  select child;


                ddlSearchBagType.DataSource = childItems4;
                ddlSearchBagType.DataTextField = "DisplayText";
                ddlSearchBagType.DataValueField = "Code";
                ddlSearchBagType.DataBind();
                ddlSearchBagType.Items.Insert(0, "--Select--");
                ddlSearchBagType.Items[0].Value = "0";
                
                  var childItemsUnits= from child in lstmetadataOutput
                                  where child.Domain == "BloodComponentUnits"
                                  select child;
                
                 
                 
                //  var temp = lstmetadataOutput.FindAll(p => p.DisplayText =="ml").Distinct();

                  ddlUnits.DataSource = childItemsUnits;
                  ddlUnits.DataTextField = "DisplayText";
                  ddlUnits.DataValueField = "Code";
                  ddlUnits.DataBind();
                 

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
    }
    protected void grdBagList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow )
            {
                e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
                e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
                //e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdBagList, "Select$" + e.Row.RowIndex));
                e.Row.Cells[4].Attributes.Add("OnClick", "JavaScript:ShowDivSeperation(" + this.grdBagList.ID + "," + e.Row.RowIndex + "); return false");
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While loading Baglist grid", ex);
        }
    }    
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Home.aspx");
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string BagNo = txtSearchBagNo.Text;
        string BagType = ddlSearchBagType.SelectedItem.Text;
        if (ddlSearchBagType.SelectedValue == "0")
            BagType = "";
        string BloodGroup = ddlSearchBloodGroup.SelectedValue;
        if (ddlSearchBloodGroup.SelectedValue == "0")
            BloodGroup = "";
        string BloodType = ddlSearchBloodType.SelectedValue;
        if (ddlSearchBloodType.SelectedValue == "0")
            BloodType = "";
        //List<BloodCollectionDetails> lstBloodCollect = new List<BloodCollectionDetails>();
        returnCode = new BloodBank_BL(base.ContextInfo).SearchBloodBag(BagNo, BagType, BloodGroup, BloodType, OrgID,out lstBloodCollect);
        if (lstBloodCollect.Count > 0)
        {
            grdBagList.DataSource = lstBloodCollect;
            grdBagList.DataBind();
        }
        else
        {
            grdBagList.DataSource ="";
            grdBagList.DataBind();
            grdBagList.EmptyDataText = "There is no Blood bag for Separation!";
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        int StockReceivedTypeID = (Int32)StockReceivedTypes.BloodBank; 
        string[] str=hdnComponents.Value.Split('^');
        //110~A+Plasma Factors~bag123~200 ml ~02/2014^
      //  ddlComponent.Attributes.Add("onchange", "DdlOnChange('" + ddlComponent.ClientID + "')");
       
        for (int i = 0; i < str.Length-1; i++)
        {
            long HdnCompontId=0;
            string ProductName="";
            BloodSeparationDetails objSeparation = new BloodSeparationDetails();
            if (str[i] != "")
            {
                string[] list = str[i].Split('~');
                //string.split(/[^\s()*/%+-]+/)

                var pName = list[1].ToString();
                if (pName.Contains('+'))
                {
                    pName = pName.Replace("+", " (+)").ToString();
                }
                if (pName.Contains('-'))
                {
                    pName = pName.Replace("-", " (-)").ToString();
                }

                objSeparation.ProductName = pName + ' ' + list[3].ToString();
                objSeparation.BagNumber = list[2].ToString();
                objSeparation.Volume = list[3].ToString();
                objSeparation.ExpiryDate = Convert.ToDateTime(list[4].ToString());
                objSeparation.ParentbagNumber = hdnParentbagID.Value;
                objSeparation.BloodGroupName = hdnBloodGroup.Value;
                HdnCompontId = Convert.ToInt64(list[5].ToString());
                ProductName = pName;

                returnCode = new BloodBank_BL().GetBloodComponent(ProductName, HdnCompontId, out lstProducts);
                int count = lstProducts.Count();
                for (int j = 0; j < count; j++)
                {
                    objSeparation.ProductID = lstProducts[0].ProductID;

                }
            }

            lstSeparationDetails.Add(objSeparation);
         
        }
        returnCode = new BloodBank_BL(base.ContextInfo).InsertBloodSeparationDetails(lstSeparationDetails);
        if (returnCode > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "BloodCollection", "alert('Blood Separation successfully');", true);
        }


        //for(int i=0;i<str.Length;i++)
        //{
        //    BloodCollectionDetails objBloodCollect = new BloodCollectionDetails();
        //    if (str[i] != "")
        //    {
        //        string[] list = str[i].Split('~');
        //        objBloodCollect.BagNumber = list[2].ToString();
        //        objBloodCollect.BagType = "";
        //        objBloodCollect.BagCapacity = "";
        //        objBloodCollect.TubeID = "";
        //        objBloodCollect.BatchNo = "";
        //        objBloodCollect.BloodComponent = "0";
        //        objBloodCollect.BloodGroup = lblBloodGroupValue.Text;
        //        objBloodCollect.CollectedDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        //        objBloodCollect.SeperatedDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        //        objBloodCollect.ReconstitutedDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        //        objBloodCollect.ExpiryDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        //        objBloodCollect.AntiCoagulants = "";
        //    }
        //    lstBloodCollect.Add(objBloodCollect);
        //}

        //int RoleID = 0;
        //returnCode = new BloodBank_BL(base.ContextInfo).InsertBloodCollectionDetails(visitID, lstBloodCollect, lstBloodCapture, OrgID, ILocationID, LID, RoleID, InventoryLocationID);
           
        //for (int i = 0; i < chkAntiCoagulants.Items.Count; i++)
        //{
        //    if (chkAntiCoagulants .Items[i].Selected == true)
        //    {
        //        objBloodCollect.AntiCoagulants = objBloodCollect.AntiCoagulants + chkAntiCoagulants.Items[i].Text + "~";
        //    }
        //}
        
        //lstBloodCollect.Add(objBloodCollect);
        //foreach (string str in hdnRecords.Value.Split('^'))
        //{
        //    if (str != "")
        //    {
        //        BloodCapturedDetials objBloodCapture = new BloodCapturedDetials();
        //        string[] list = str.Split('~');
        //        objBloodCapture.PatientVisitID = visitID;
        //        objBloodCapture.CapturedTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        //        objBloodCapture.HeartRate = list[1].ToString();
        //        objBloodCapture.BloodPressure = list[2].ToString();
        //        objBloodCapture.Saturation = Convert.ToInt32(list[3]);
        //        objBloodCapture.Volume = Convert.ToInt32(list[4]);
        //        objBloodCapture.Condition = list[5].ToString();
        //        lstBloodCapture.Add(objBloodCapture);
        //    }
        //}
        //int RoleID = 0;
        //returnCode = new BloodBank_BL(base.ContextInfo).InsertBloodCollectionDetails(visitID, lstBloodCollect, lstBloodCapture, OrgID, ILocationID, LID,RoleID,InventoryLocationID);
      
    }
}
