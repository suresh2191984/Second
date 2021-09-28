using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Data;

public partial class CommonControls_AddNewInvestigation : BaseControl
{
    string ModifiedBy = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        AutoInvName.CompletionSetCount = 0;
        AutoGname.CompletionSetCount = 0;
        if (IsCorporateOrg == "Y")
        {
            trAdnew.Style.Add("display", "none");
        }
    }
    protected void lnkAddnew_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            //returncode = new Investigation_BL(base.ContextInfo).getdept
            List<InvDeptMaster> listOfdept = new List<InvDeptMaster>();
            returnCode = new Investigation_BL(base.ContextInfo).GetInvforDept(OrgID, out listOfdept);
            ddlDept.DataSource = listOfdept;
            ddlDept.DataTextField = "DeptName";
            ddlDept.DataValueField = "DeptID";
            ddlDept.DataBind();

            List<InvestigationHeader> listHeader = new List<InvestigationHeader>();
            
            returnCode = new Investigation_BL(base.ContextInfo).getOrgHeaderName(out listHeader);
            ddlHeader.DataSource = listHeader;
            ddlHeader.DataTextField = "HeaderName";
            ddlHeader.DataValueField = "HeaderID";
            ddlHeader.DataBind();
            ddlHeader.SelectedValue = "10";
            programmaticModalPopup.Show();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in lnkAddnew_Click", ex);
        }
    }
    protected void Save_Click(object sender, EventArgs e)
    {
        long returncode = -1;
        try
        {
            if (hdnInvID.Value == string.Empty)
            {
                if (rbList.SelectedItem.Value == "1")
                {

                    string InvName = txtInvname.Text;
                    int DeptID = -1;
                    int HeaderID = -1;
                    DeptID = Convert.ToInt32(ddlDept.SelectedItem.Value);
                    HeaderID = Convert.ToInt32(ddlHeader.SelectedItem.Value);
                    returncode = new Investigation_BL(base.ContextInfo).InsertNewInvestigation(InvName, DeptID, HeaderID, 0, 0, OrgID);
                    if (returncode != 0)
                    {
                        txtInvname.Text = string.Empty;
                        lblStatus.Visible = true;
                        rbList.SelectedValue = "1";
                        pnlInv.Style.Add("display", "block");
                        pnlGrp.Style.Add("display", "none");

                        lblStatus.Text = "Investigation saved Successfully...!";
                    }
                    else
                    {
                        lblStatus.Visible = true;
                        lblStatus.Text = "Error while saving new Investigation...!";
                    }
                }
                else if (rbList.SelectedItem.Value == "2")
                {
                    List<InvestigationOrgMapping> lOrg = new List<InvestigationOrgMapping>();
                    string GroupName = txtGroupName.Text;
                    string BillingName = string.Empty;
                    BillingName = txtGroupName.Text;
                    string GroupCode = string.Empty;
                    string remarks = string.Empty;
                    string status = string.Empty;
                    string Pkgcode = string.Empty;
                    int CutOffTimeValue=0;
                    string CutOffTimeType=string.Empty;
                    string Gender = string.Empty;
                    string IsServiceTaxable = string.Empty;
                    short ScheduleType = 0;
                    DataTable dtCodingSchemeMaster = new DataTable();
                    dtCodingSchemeMaster.Columns.Add("CodeLabel");
                    dtCodingSchemeMaster.Columns.Add("CodeTextbox");
                    dtCodingSchemeMaster.Columns.Add("CodeMasterID");
                    dtCodingSchemeMaster.AcceptChanges(); 
                    returncode = new Investigation_BL().SaveInvestigationGrpName(lOrg, GroupName, BillingName, 0, 0, 2, "GRP", OrgID, ModifiedBy, GroupCode, remarks, status, Pkgcode, string.Empty, dtCodingSchemeMaster, CutOffTimeValue, CutOffTimeType, Gender, IsServiceTaxable, ScheduleType,true);
                    if (returncode != -1)
                    {
                        txtGroupName.Text = string.Empty;
                        lblStatus.Visible = true;
                        rbList.SelectedValue = "2";
                        lblStatus.Text = "Group Investigation saved Successfully...!";
                        pnlInv.Style.Add("display", "none");
                        pnlGrp.Style.Add("display", "block");

                    }
                }
                programmaticModalPopup.Show();

            }
            else
            {  long returnCode = -1;
                if (rbList.SelectedItem.Value == "1")
                {
                    long InvestigationID = 0;
                    Int64.TryParse(hdnInvID.Value, out InvestigationID);
                    List<InvestigationOrgMapping> lOrgMapping = new List<InvestigationOrgMapping>();
                    InvestigationOrgMapping OrgMapping = new InvestigationOrgMapping();

                    OrgMapping.InvestigationID = InvestigationID;
                    OrgMapping.DisplayText = string.Empty;
                    OrgMapping.ReferenceRange = string.Empty;
                    OrgMapping.DeptID =Convert.ToInt16(ddlDept.SelectedItem.Value);
                    OrgMapping.HeaderID = Convert.ToInt16(ddlHeader.SelectedItem.Value);
                    OrgMapping.OrgID =OrgID;
                    lOrgMapping.Add(OrgMapping);

                    returnCode = new Investigation_BL(base.ContextInfo).SaveInvestigationName(lOrgMapping);
                    if (returncode != 0)
                    {
                        txtInvname.Text = string.Empty;
                        lblStatus.Visible = true;
                        rbList.SelectedValue = "1";
                        pnlInv.Style.Add("display", "block");
                        pnlGrp.Style.Add("display", "none");

                        lblStatus.Text = "Investigation saved Successfully...!";
                    }
                    else
                    {
                        lblStatus.Visible = true;
                        lblStatus.Text = "Error while saving new Investigation...!";
                    }
                }
                else if (rbList.SelectedItem.Value == "2")
                {
                    List<InvestigationOrgMapping> lInvestigationDetail = new List<InvestigationOrgMapping>();
                    InvestigationOrgMapping eOrgMapping = new InvestigationOrgMapping();
                    eOrgMapping.InvestigationID =Convert.ToInt16(hdnInvID.Value);
                    eOrgMapping.DisplayText = "";
                    eOrgMapping.ReferenceRange = "";
                    lInvestigationDetail.Add(eOrgMapping);
                    string GroupCode = string.Empty;
                    string remarks = string.Empty;
                    string status = string.Empty;
                    string pkgcode = string.Empty;
                    string BillingName = string.Empty;
                    int CutOffTimeValue = 0;
                    string CutOffTimeType = string.Empty;
                    string Gender = string.Empty;
                    string IsServiceTaxable = string.Empty;
                    short ScheduleType = 0;
                    DataTable dtCodingSchemeMaster = new DataTable();
                    dtCodingSchemeMaster.Columns.Add("CodeLabel");
                    dtCodingSchemeMaster.Columns.Add("CodeTextbox");
                    dtCodingSchemeMaster.Columns.Add("CodeMasterID");
                    dtCodingSchemeMaster.AcceptChanges(); 
                    returnCode = new Investigation_BL().SaveInvestigationGrpName(lInvestigationDetail, "", BillingName, 0, 0, 7, "GRP", OrgID, ModifiedBy, GroupCode, remarks, status, pkgcode, string.Empty, dtCodingSchemeMaster, CutOffTimeValue, CutOffTimeType, Gender, IsServiceTaxable, ScheduleType,true);
                    if (returnCode != -1)
                    {
                        txtGroupName.Text = string.Empty;
                        lblStatus.Visible = true;
                        rbList.SelectedValue = "2";
                        lblStatus.Text = "Group Investigation saved Successfully...!";
                        pnlInv.Style.Add("display", "none");
                        pnlGrp.Style.Add("display", "block");

                    }
                }
                programmaticModalPopup.Show();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in save new investigation", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        programmaticModalPopup.Hide();
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Items", "javascript:LoadOrdItems();", true);
    }
}
