using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using System.Collections;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;

public partial class CommonControls_SurgeryPackageItems : BaseControl
{
    List<SurgeryPackageItems> lstSelectedSurgeryPKG = new List<SurgeryPackageItems>();
    List<SurgeryPackageItems> lstSurgeryPackageItems = new List<SurgeryPackageItems>();
    //protected long _VisitID = 0;

    //public long VisitID
    //{
    //    get { return _VisitID; }
    //    set { _VisitID = value; }
    //}

    long VisitID = -1;
    long PatientID = -1;
    long PkgID = -1;
    long returnCode = -1;
    ArrayList al = new ArrayList();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (ViewState["SelectedPkg"] != null)
        {
            al = (ArrayList)ViewState["SelectedPkg"];
        }

    }

    public void GetSurgeryPackage()
    {
        Int64.TryParse(Request.QueryString["vid"], out VisitID);
        Int64.TryParse(Request.QueryString["pid"], out PatientID);
       
        GetSurgeryPackage(OrgID, VisitID);
    }


    public void GetSurgeryPackage(int OrgID, long VisitID)
    {
        long returnCode = -1;
        returnCode = new SurgeryPackage_BL(base.ContextInfo).GetSurgeryPackage(OrgID, VisitID, out lstSurgeryPackageItems, out lstSelectedSurgeryPKG);
        gvSurgeryPkg.DataSource = lstSurgeryPackageItems;
        gvSurgeryPkg.DataBind();   
    }

    public List<PatientDueChart> GetSelectedSurgeryPackage()
    {
        List<PatientDueChart> lstSPPatientDueChart = new List<PatientDueChart>();

        AddToViewState();
      
        

        foreach (string lst in al)
        {
            PatientDueChart objSPDueChart = new PatientDueChart();
            //precommendationDtls.ResultID = Convert.ToInt32(lst.Split('~')[0]);
            //precommendationDtls.ResultValues = lst.Split('~')[2];

          //  lblPackageID.Text + "~" + lblPackageName.Text + "~" + lblAmount.Text + txtFromDate.Text + "~" + txtToDate.Text;

            objSPDueChart.FeeID = Convert.ToInt64(lst.Split('~')[0]);
            objSPDueChart.FeeType = "SPKG";
            objSPDueChart.Description = lst.Split('~')[1];
            objSPDueChart.Comments = "";
            objSPDueChart.Status = "Pending";
            objSPDueChart.FromDate = Convert.ToDateTime(lst.Split('~')[3]);
            objSPDueChart.ToDate = Convert.ToDateTime(lst.Split('~')[4]);
            objSPDueChart.Unit = 1;
            objSPDueChart.Amount = Convert.ToDecimal(lst.Split('~')[2]);
            objSPDueChart.PackageID = Convert.ToInt64(lst.Split('~')[0]);
            lstSPPatientDueChart.Add(objSPDueChart);
          
           
        }
        return lstSPPatientDueChart;



        //foreach (GridViewRow rows in gvSurgeryPkg.Rows)
        //{
        //    CheckBox chkSelected = (CheckBox)rows.FindControl("chkIDSelected");
        //    TextBox txtFromDate = (TextBox)rows.FindControl("txtFromDate");
        //    TextBox txtToDate = (TextBox)rows.FindControl("txtToDate");
        //    Label lblPackageName = (Label)rows.FindControl("lblPackageName");
        //    Label lblAmount = (Label)rows.FindControl("lblAmount");
        //    Label lblPackageID = (Label)rows.FindControl("lblPackageID");
        //    if (chkSelected.Checked)
        //    {

        //        PatientDueChart objSPDueChart = new PatientDueChart();

        //        objSPDueChart.FeeID = Convert.ToInt64(lblPackageID.Text);
        //        objSPDueChart.FeeType = "SPKG";
        //        objSPDueChart.Description = lblPackageName.Text;
        //        objSPDueChart.Comments = "";
        //        objSPDueChart.Status = "Pending";
        //        objSPDueChart.FromDate = Convert.ToDateTime(txtFromDate.Text);
        //        objSPDueChart.ToDate = Convert.ToDateTime(txtToDate.Text);
        //        objSPDueChart.Unit = 1;
        //        objSPDueChart.Amount = Convert.ToDecimal(lblAmount.Text);
        //        objSPDueChart.PackageID = Convert.ToInt64(lblPackageID.Text);

        //        lstSPPatientDueChart.Add(objSPDueChart);
        //    }

        //}

    }
    protected void gvSurgeryPkg_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        string PkgDetail = string.Empty;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtFromDate = (TextBox)e.Row.FindControl("txtFromDate");
            TextBox txtToDate = (TextBox)e.Row.FindControl("txtToDate");
            Label lblPkgDays = (Label)e.Row.FindControl("lblPkgDays");
            Label lblPackageID = (Label)e.Row.FindControl("lblPackageID");
            CheckBox chkSelected = (CheckBox)e.Row.FindControl("chkIDSelected");

            //LinkButton lbtnFromDate = (LinkButton)e.Row.FindControl("lbtnFromDate");
            //lbtnFromDate.Attributes.Add("onclick", "NewCal('" + txtFromDate.ClientID + "','ddmmyyyy',true,12)");

            //LinkButton lbtnToDate = (LinkButton)e.Row.FindControl("lbtnToDate");
            //lbtnToDate.Attributes.Add("onclick", "NewCal('" + txtToDate.ClientID + "','ddmmyyyy',true,12)");
           
            txtFromDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy hh:mm:ss");         
            txtToDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(int.Parse(lblPkgDays.Text) - 1).ToString("dd-MM-yyyy hh:mm:ss");
            for (int i = 0; i < al.Count; i++)
            {
                PkgDetail = al[i].ToString();
                long PkgID =Convert.ToInt64(PkgDetail.Split('~')[0].ToString());
                if (Convert.ToInt64(lblPackageID.Text) == PkgID)
                {
                    chkSelected.Checked = true; 
                }

            }

            foreach (SurgeryPackageItems objSurgeryPackageItems in lstSelectedSurgeryPKG)
            {
                if (objSurgeryPackageItems.PackageID == Convert.ToInt64(lblPackageID.Text))
                {
                    chkSelected.Enabled = false;
                }
            }

            
        }
    }
    protected void gvSurgeryPkg_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out VisitID);
        Int64.TryParse(Request.QueryString["pid"], out PatientID);


        if (e.CommandName == "OView")
        {
            int RowIndex = Convert.ToInt32(e.CommandArgument);
            PkgID = Convert.ToInt64(gvSurgeryPkg.DataKeys[RowIndex][0]);

            returnCode = -1;
            returnCode = new SurgeryPackage_BL(base.ContextInfo).GetOrderedSurgeryPkg(PkgID, VisitID, out lstSurgeryPackageItems, out lstSelectedSurgeryPKG);

            if (lstSurgeryPackageItems.Count > 0)
            {
                gvPackageDetailsSPI.DataSource = lstSurgeryPackageItems;
                gvPackageDetailsSPI.DataBind();
                ModelPopUpSPI.Show();
               
               
            }
        }
    }

    protected void BtnCloseSPI_Click(object sender, EventArgs e)
    {
        ModelPopUpSPI.Hide();
    }
    protected void gvSurgeryPkg_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            AddToViewState();
            gvSurgeryPkg.PageIndex = e.NewPageIndex;
            GetSurgeryPackage(OrgID, VisitID);
        }
    }


    void AddToViewState()
    {
      
        string strPkGDetail = string.Empty;

        bool blnExists = false;
      
        ArrayList alTemp = al;

        foreach (GridViewRow rows in gvSurgeryPkg.Rows)
        {
            if (rows.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkSelected = (CheckBox)rows.FindControl("chkIDSelected");
                TextBox txtFromDate = (TextBox)rows.FindControl("txtFromDate");
                TextBox txtToDate = (TextBox)rows.FindControl("txtToDate");
                Label lblPackageName = (Label)rows.FindControl("lblPackageName");
                Label lblAmount = (Label)rows.FindControl("lblAmount");
                Label lblPackageID = (Label)rows.FindControl("lblPackageID");

                if (chkSelected.Checked)
                {

                    strPkGDetail = lblPackageID.Text + "~" + lblPackageName.Text + "~" + lblAmount.Text + "~" + txtFromDate.Text + "~" + txtToDate.Text;

                    if (al.Count > 0)
                    {
                        for (int i = 0; i < al.Count; i++)
                        {
                            if (al[i].ToString() == strPkGDetail)
                            {
                                blnExists = true;
                                break;
                            }
                        }
                        if (!blnExists)
                        {
                            alTemp.Add(strPkGDetail);
                        }
                    }
                    else
                    {
                        alTemp.Add(strPkGDetail);
                    }
                }
                else
                {
                    strPkGDetail = lblPackageID.Text + "~" + lblPackageName.Text + "~" + lblAmount.Text + "~" + txtFromDate.Text + "~" + txtToDate.Text;


                    if (al.Count > 0)
                    {
                        for (int i = 0; i < al.Count; i++)
                        {

                            if (al[i].ToString() == strPkGDetail)
                            {
                                blnExists = true;
                                break;
                            }
                        }
                        if (blnExists)
                        {
                            alTemp.Remove(strPkGDetail);
                        }
                    }
                }
            }
        }
        ViewState["SelectedPkg"] = alTemp;
    }




    public void ClearData()
    {
        ViewState["SelectedPkg"] = null;
        GetSurgeryPackage(OrgID, VisitID);

    }
    public void GetSurgeryPackageIP(List<SurgeryPackageItems> lstSurgeryPackageItemsIP)
    {
        gvSurgeryPkg.DataSource = lstSurgeryPackageItemsIP;
        gvSurgeryPkg.DataBind();
    }
}
