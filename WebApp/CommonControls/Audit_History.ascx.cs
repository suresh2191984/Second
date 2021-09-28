using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections;
using Attune.Podium.Common;
using Attune.Podium.TrustedOrg;
using System.Threading;
using System.Configuration;
using System.IO;
public partial class CommonControls_Audit_History : BaseControl
{

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public CommonControls_Audit_History()
        : base("CommonControls_Audit_History_ascx")
    {
    }
	
    public void ViewAudit_History(long ID, int OrgID, string Htype)
    {
        long returnCode = -1;
        AuditManager_BL AuditManagerBL = new AuditManager_BL(base.ContextInfo);
        if (Htype == "PATSRCH")
        {
            List<Patient_HIST> lstPatient_HIST = new List<Patient_HIST>();
            try
            {
                returnCode = AuditManagerBL.GetAudit_History(ID, OrgID, Htype, out lstPatient_HIST);
                trPatientHistory.Style.Add("display", "block");
                trUserMaster.Style.Add("display", "none");
                grdPatientHistory.Visible = true;
                grdLoginDetails.Visible = false;
                grdPatientHistory.DataSource = lstPatient_HIST;
                grdPatientHistory.DataBind();
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
                trUserMaster.Style.Add("display", "block");
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
                trProductHistory.Style.Add("display", "block");
                trUserMaster.Style.Add("display", "none");
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
                trUserMaster.Style.Add("display", "none");
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error While Load Supplier Audit_History.", ex);
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

}
