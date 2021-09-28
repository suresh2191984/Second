using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using Attune.Kernel.TrustedOrg;
using System.Threading;
using System.Configuration;
using System.IO;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.BL;

public partial class CommonControls_Audit_History : Attune_BaseControl
{
    string Isdobweddingdate = string.Empty;
    public CommonControls_Audit_History()
        : base("PlatForm_CommonControls_Audit_History_ascx")
    {
    } 
    protected void Page_Load(object sender, EventArgs e)
    {
        Isdobweddingdate = GetConfigValue("Isdobweddingdate", OrgID);
    }

    public void ViewAudit_History(long ID, int OrgID, string Htype)
    {
        long returnCode = -1;
        Audit_BL AuditManagerBL = new Audit_BL(base.ContextInfo);
        if (Htype == "PATSRCH")
        {
            List<Patient_HIST> lstPatient_HIST = new List<Patient_HIST>();
            try
            {
                returnCode = AuditManagerBL.GetAudit_History(ID, OrgID, Htype, out lstPatient_HIST);
                trPatientHistory.Attributes.Add("class", "panelContent");
                trUserMaster.Attributes.Add("class", "hide");
                grdPatientHistory.Visible = true;
                grdLoginDetails.Visible = false;
                grdPatientHistory.DataSource = lstPatient_HIST;
                grdPatientHistory.DataBind();
                string isDayCare = GetConfigValue("IP as DayCare", OrgID);
                if (isDayCare == "Y")
                    grdPatientHistory.Columns[6].Visible = false;
                else
                    grdPatientHistory.Columns[6].Visible = true;

                var lst = (from obj in lstPatient_HIST
                           where obj.RelationName != null && obj.RelationName != ""
                           select obj).ToList();
                if (lst.Count == 0 && isDayCare != "Y")
                {
                    grdPatientHistory.Columns[6].Visible = false;
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while Loading Patient Audit_History", ex);
            }
        }
        else if (Htype == "USRMST")
        {
            List<Login_HIST> lstLogin_HIST = new List<Login_HIST>();
            List<Users_HIST> lstUsers_HIST = new List<Users_HIST>();
            try
            {
                returnCode = AuditManagerBL.GetAudit_History(ID, OrgID, Htype, out lstLogin_HIST, out lstUsers_HIST);
                trUserMaster.Attributes.Add("class", "panelContent");
                grdPatientHistory.Visible = false;
                grdLoginDetails.Visible = true;
                grdUser.Visible = true;
                grdLoginDetails.DataSource = lstLogin_HIST;
                grdLoginDetails.DataBind();
                grdUser.DataSource = lstUsers_HIST;
                grdUser.DataBind();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while loading User & Login Audit_History", ex);
            }
        }
        else if (Htype == "PRDTSRCH")
        {
            try
            {
                List<Products> lstProducts = new List<Products>();
                returnCode = AuditManagerBL.GetAudit_History(ID, OrgID, Htype, out lstProducts);
                grdProductHistory.DataSource = lstProducts;
                grdProductHistory.DataBind();
                string TAX_COLUMNHIDE = GetConfigValue("IsMiddleEast", OrgID);
                TAX_COLUMNHIDE = !string.IsNullOrEmpty(TAX_COLUMNHIDE) ? TAX_COLUMNHIDE : "N";
                if (TAX_COLUMNHIDE == "Y")
                {
                    grdProductHistory.Columns[6].Visible=false;
                }
                trProductHistory.Style.Add("display", "block");
                trUserMaster.Attributes.Add("class", "hide");
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error While Load Product Audit_History.", ex);
            }
        }
        else if (Htype == "SPLRSRCH")
        {
            try
            {
                int SupplierID = Convert.ToInt32(ID);
                List<Suppliers_HIST> lstSuppliers_HIST = new List<Suppliers_HIST>();
                returnCode = AuditManagerBL.GetAudit_History(SupplierID, OrgID, Htype, out lstSuppliers_HIST);
                grdSupplierHistory.DataSource = lstSuppliers_HIST;
                grdSupplierHistory.DataBind();
                trSupplierHistory.Style.Add("display", "block");
                trUserMaster.Attributes.Add("class", "hide");
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error While Load Supplier Audit_History.", ex);
            }
        }
        else if (Htype == "EMPTRACKER")
        {
            List<Patient_HIST> lstPatient_HIST = new List<Patient_HIST>();
            try
            {
                returnCode = AuditManagerBL.GetAudit_History(ID, OrgID, Htype, out lstPatient_HIST);
                trEmergencyPatient.Style.Add("display", "block");
                trPatientHistory.Attributes.Add("class", "hide");
                trUserMaster.Attributes.Add("class", "hide");
                grdPatientHistory.Visible = false;
                grdLoginDetails.Visible = false;
                GrdEmergencyPatient.DataSource = lstPatient_HIST;
                GrdEmergencyPatient.DataBind();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while Loading Patient Audit_History", ex);
            }
        }
    }
    protected void grdUser_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (Isdobweddingdate == "Y")
            {
                e.Row.Cells[2].Visible = false;
            }
        }
        if (e.Row.RowType == DataControlRowType.Header)
        {
            if (Isdobweddingdate == "Y")
            {
                e.Row.Cells[2].Visible = false;
            }
        }
    }
    protected void grdHistory_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.RowIndex == 0)
            {
                e.Row.CssClass = "grdcheck";
                e.Row.ToolTip = "Currunt status of the Product";
                e.Row.Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            }
        }
    }

    protected void grdHistory_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            //grdSupplierHistory.PageIndex = e.NewPageIndex;
            //long longID = Convert.ToInt64(hdnLongID.Value);
            //int intID = Convert.ToInt32(hdnintID.Value);
            //int OrgID = Convert.ToInt32(hdnOrgID.Value);
            //string Htype = hdnType.Value;
            //ViewAudit_History(longID, intID, OrgID, Htype);   
        }
    }


    protected void grdPatientHistory_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbl = ((Label)e.Row.FindControl("lblModifiedAt"));
            ((Label)e.Row.FindControl("lblModifiedAt")).Text = Convert.ToDateTime(lbl.Text) == DateTime.MinValue ? "-" : Convert.ToDateTime(lbl.Text).ToExternalDateTime();
        }
        
    }
}
