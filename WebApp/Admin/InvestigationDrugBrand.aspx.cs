using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;

public partial class Admin_InvestigationDrugBrand : BasePage
{
    public Admin_InvestigationDrugBrand()
        : base("Admin_InvestigationDrugBrand_aspx")
    {
    }
    long returnCode = -1;
    Patient_BL patientBL;
    List<InvestigationDrugBrand> lstInvDrugBrand = new List<InvestigationDrugBrand>();
    InvestigationDrugBrand invDrugBrand = new InvestigationDrugBrand();
    string brandName = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        patientBL = new Patient_BL(base.ContextInfo);
        btnRefresh.Visible = false;
        if (!IsPostBack)
        {
            GetDrugBrand();
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        string HdrWin = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02 == null ? "Information" : Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;
        string DisplayLable = Resources.Admin_ClientDisplay.Admin_InvestigationDrugBrand_aspx_02 == null ? "DrugBrand Is Successfully Added" : Resources.Admin_ClientDisplay.Admin_InvestigationDrugBrand_aspx_02;
        string DisplayLableUpdate = Resources.Admin_ClientDisplay.Admin_InvestigationDrugBrand_aspx_03 == null ? "DrugBrand Is Successfully Updated" : Resources.Admin_ClientDisplay.Admin_InvestigationDrugBrand_aspx_03;
        string DispSave = Resources.Admin_ClientDisplay.Admin_Analyzer_aspx_01 == null ? "Save" : Resources.Admin_ClientDisplay.Admin_Analyzer_aspx_01;
        string DispUpdate = Resources.Admin_ClientDisplay.Admin_AddOrChangeGroup_aspx_02 == null ? "Update" : Resources.Admin_ClientDisplay.Admin_AddOrChangeGroup_aspx_02;
        string DisNotExits = Resources.Admin_AppMsg.Admin_InvestigationDrugBrand_aspx_42 == null ? "Drug Name Already Exists" : Resources.Admin_AppMsg.Admin_InvestigationDrugBrand_aspx_42;
       long DrugID = -1;
        try
        {
            if (btnSave.Text == DispSave)
            {               
                invDrugBrand.BrandName = txtDrugName.Text;
                invDrugBrand.Code = txtDrugCode.Text;
                
                invDrugBrand.OrgID = OrgID;
                returnCode = patientBL.SaveInvestigationDrugBrand(invDrugBrand, out DrugID);
                if (returnCode == 0)
                {
                    txtDrugName.Text = "";
                    txtDrugCode.Text = "";
                    lblstatus.Visible = true;                    
                    btnRefresh.Visible = true;
                    hdnDrugID.Value = "";                    
                    //lblstatus.Text = "DrugBrand Is Successfully Added";
                    lblstatus.Text = DisplayLable;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + DisplayLable + "','" + HdrWin + "');", true);
                }
                else
                {
                    txtDrugName.Text = "";
                    txtDrugCode.Text = "";
                    lblstatus.Visible = true;
                    btnRefresh.Visible = true;
                    hdnDrugID.Value = "";
                    //lblstatus.Text = "DrugBrand Is Successfully Added";
                    lblstatus.Text = DisNotExits;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + DisNotExits + "','" + HdrWin + "');", true);
                }
            }
            else if (btnSave.Text == DispUpdate) 
            {                
                invDrugBrand.DrugID = Convert.ToInt64(hdnDrugID.Value);
                invDrugBrand.BrandName = txtDrugName.Text;
                invDrugBrand.Code = txtDrugCode.Text;
                invDrugBrand.OrgID = OrgID;
                invDrugBrand.ModifiedBy = LID;
                returnCode = patientBL.UpdateInvestigationDrugBrand(invDrugBrand);
                if (returnCode == 0)
                {
                    txtDrugName.Text = "";
                    txtDrugCode.Text = "";
                    lblstatus.Visible = true;                    
                    btnRefresh.Visible = true;
                    hdnDrugID.Value = "";
                    //lblstatus.Text = "DrugBrand Is Successfully Updated";
                    lblstatus.Text = DisplayLableUpdate;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + DisplayLableUpdate + "','" + HdrWin + "');", true);
                }
            }
            GetDrugBrand();
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception excep)
        {
            CLogger.LogError("Error while saving Brand Name", excep);
            //ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("InvestigationDrugBrand.aspx");
    }
    
    private void GetDrugBrand()
    {
        patientBL.GetInvestigationDrugBrand(OrgID, brandName, out lstInvDrugBrand);
        if (lstInvDrugBrand.Count > 0)
        {
            grdView.Visible = true;
            grdView.DataSource = lstInvDrugBrand;
            grdView.DataBind();
            lblstatus.Visible = false;
        }
    }
    protected void grdView_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdView.PageIndex = e.NewPageIndex;
            patientBL.GetInvestigationDrugBrand(OrgID, brandName, out lstInvDrugBrand);
            if (lstInvDrugBrand.Count > 0)
            {
                grdView.Visible = true;
                grdView.DataSource = lstInvDrugBrand;
                grdView.DataBind();
            }            
        }
    }
    //protected void grdView_RowCreated(object sender, GridViewRowEventArgs e)
    //{
    //    e.Row.Attributes.Add("onMouseOver", "this.style.background='#eeff00'");
    //    e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");
    //}
    protected void grdView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string DispUpdate = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_23 == null ? "Update" : Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_23;
        string DispSele = Resources.Admin_ClientDisplay.Admin_AddOrChangeGroup_aspx_01 == null ? "Select" : Resources.Admin_ClientDisplay.Admin_AddOrChangeGroup_aspx_01;
        try
        {
            if (e.CommandName == DispSele)
            {
                int RowIndex = Convert.ToInt32(e.CommandArgument);
                txtDrugName.Text = "";
                txtDrugName.Text = Convert.ToString(grdView.DataKeys[RowIndex][1]);
                hdnDrugID.Value = Convert.ToString(grdView.DataKeys[RowIndex][0]);
                txtDrugCode.Text = Convert.ToString(grdView.DataKeys[RowIndex][2]);
                //btnSave.Text = "Update";
                btnSave.Text = DispUpdate;
                txtDrugName.Focus();
                GridViewRow row = (GridViewRow)grdView.Rows[RowIndex];                
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Drug Details to Update", ex);
        }
    }
    protected override void Render(HtmlTextWriter writer)
    {
        for (int i = 0; i < this.grdView.Rows.Count; i++)
        {
            this.Page.ClientScript.RegisterForEventValidation(this.grdView.UniqueID, "Select$" + i);
        }
        base.Render(writer);
    }
    protected void grdView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
                e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
                e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdView, "Select$" + e.Row.RowIndex));               
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While loading Drug Details to Update", ex);
        }
    }
    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        Response.Redirect("InvestigationDrugBrand.aspx");         
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string DispCode = Resources.Admin_ClientDisplay.Admin_InvestigationDrugBrand_aspx_04 == null ? "Code" : Resources.Admin_ClientDisplay.Admin_InvestigationDrugBrand_aspx_04;
        string DispBrandName = Resources.Admin_ClientDisplay.Admin_InvestigationDrugBrand_aspx_05 == null ? "BrandName" : Resources.Admin_ClientDisplay.Admin_InvestigationDrugBrand_aspx_05;
        string brandName = string.Empty;
      
        if (rdoCode.Checked == true)
        {
            brandName = txtSearch.Text;
           // brandName = "/" + "Code" + brandName + "/";
            //brandName = brandName + "/" + "Code";
            brandName = brandName + "/" + DispCode;

        }

        if (rdoName.Checked == true)
        {
            brandName = txtSearch.Text;
            // brandName = "/" + "BrandName" + brandName + "/";
            brandName = brandName + "/" + DispBrandName;
        }



        patientBL.SearchInvestigationDrugBrand(OrgID, brandName, out lstInvDrugBrand);
        if (lstInvDrugBrand.Count > 0)
        {
            grdView.Visible = true;
            grdView.DataSource = lstInvDrugBrand;
            grdView.DataBind();
            lblstatus.Visible = false;
        }
        else
        {
            string DispNoMathing = Resources.Admin_ClientDisplay.Admin_InvestigationDrugBrand_aspx_06 == null ? "No Matching Records Found!" : Resources.Admin_ClientDisplay.Admin_InvestigationDrugBrand_aspx_06;
            lblstatus.Visible = true;
            grdView.Visible = false;
            //lblstatus.Text = "No Matching Records Found!";
            lblstatus.Text = DispNoMathing;
        }

    }
}
