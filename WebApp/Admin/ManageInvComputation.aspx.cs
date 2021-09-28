using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using System.Collections;
using System.Data;
using System.Text;
using System.Web.Services;

public partial class Admin_ManageInvComputation : BasePage
{
    public Admin_ManageInvComputation():base("Admin_ManageInvComputation_aspx"){}
    long returnCode = -1;
    List<MasterCategories> lstCategories = new List<MasterCategories>();
    List<MasterCategories> lstCategoryNPattern = new List<MasterCategories>();
    List<MasterPatterns> lstPatterns = new List<MasterPatterns>();
    List<PatientInvestigation> lstInvestigations = new List<PatientInvestigation>();
    string strNoResult = Resources.Admin_AppMsg.Admin_ManageInvComputation_aspx_06 == null ? "No record(s) found" : Resources.Admin_AppMsg.Admin_ManageInvComputation_aspx_06;
    string strAlert = Resources.Admin_AppMsg.Admin_OrganisationLocation_aspx_Alert == null ? "Alert" : Resources.Admin_AppMsg.Admin_OrganisationLocation_aspx_Alert;
    string ddlSelect = Resources.Admin_AppMsg.Admin_drpSelect == null ? "----Select----" : Resources.Admin_AppMsg.Admin_drpSelect;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                LoadMeatData();
                LoadInvGroup();
                LoadGrid();
                
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while page load", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "Error while page load";
        }
    }

    protected void ddlInvGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlInvGroup.SelectedIndex > 0)
            {
                LoadInvestigationByGroup(ddlInvGroup.SelectedValue);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while selecting group", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "Error while selecting group";
        }
    }

    private void LoadInvestigationByGroup(string OrgGroupID)
    {
        try
        {
            ClearControl();
            string groupname = string.Empty;
            List<InvestigationMaster> lstInvMaster = new List<InvestigationMaster>();
            Investigation_BL objInvBL = new Investigation_BL(base.ContextInfo);
            returnCode = objInvBL.GetInvestigationByGroup(Int32.Parse(ddlInvGroup.SelectedValue), out lstInvMaster);
            if (lstInvMaster.Count > 0)
            {
                lblTargetInv.Visible = true;
                ddlTargetInv.Visible = true;
                tblContent.Visible = true;
                lstBoxInvestigation.DataSource = lstInvMaster;
                lstBoxInvestigation.DataTextField = "InvestigationName";
                lstBoxInvestigation.DataValueField = "InvestigationID";
                lstBoxInvestigation.DataBind();

                ddlTargetInv.DataSource = lstInvMaster;
                ddlTargetInv.DataTextField = "InvestigationName";
                ddlTargetInv.DataValueField = "InvestigationID";
                ddlTargetInv.DataBind();
                ddlTargetInv.Items.Insert(0, ddlSelect);
                LoadTable();
            }
            else
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "NoRecord", "ValidationWindow('" + strNoResult + "','" + strAlert + "');", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Investigation Group", ex);
            throw ex;
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            String pValidationText = hdnValidationText.Value.Replace("&gt;", ">");
            String pValidationRule = hdnValidationRule.Value;

            Investigation_BL objInvBL = new Investigation_BL(base.ContextInfo);
            returnCode = objInvBL.UpdateInvComputationRuleByGroup(Int32.Parse(ddlInvGroup.SelectedValue), pValidationText, pValidationRule);

            if (returnCode > 0)
            {
                LoadTable();
                LoadGrid();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Save", "Savemsg();Reset()", true);
            }
            else
            {
               // ErrorDisplay1.ShowError = true;
               // ErrorDisplay1.Status = "Error while saving record";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving record", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "Error while saving record";
        }
    }

    private void LoadInvGroup()
    {
        try
        {
            ClearControl();
            List<InvGroupMaster> lstInvGroupMaster = new List<InvGroupMaster>();
            Investigation_BL objInvBL = new Investigation_BL(base.ContextInfo);
            returnCode = objInvBL.getInvGroupName(OrgID, out lstInvGroupMaster);
            if (lstInvGroupMaster.Count > 0)
            {
                ddlInvGroup.DataSource = lstInvGroupMaster;
                ddlInvGroup.DataTextField = "GroupName";
                ddlInvGroup.DataValueField = "GroupID";
                ddlInvGroup.DataBind();
                ddlInvGroup.Items.Insert(0, ddlSelect);
            }
            else
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "NoRecord", "ValidationWindow('" + strNoResult + "','" + strAlert + "');", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Investigation Group", ex);
            throw ex;
        }
    }

    private void ClearControl()
    {
        try
        {
            lstBoxInvestigation.Items.Clear();
            lstBoxSelectedItems.Items.Clear();
            ddlTargetInv.Items.Clear();
            for (var i = 1; i < tblSelectedPatterns.Rows.Count; i++)
                tblSelectedPatterns.Rows.RemoveAt(i);
            lblTargetInv.Visible = false;
            ddlTargetInv.Visible = false;
            tblContent.Visible = false;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while clearing controls", ex);
            throw ex;
        }
    }

    private void LoadGrid()
    {
        try
        {
            Investigation_BL objInvBL = new Investigation_BL(base.ContextInfo);
            List<InvOrgGroup> lstInvOrgGroup = new List<InvOrgGroup>();
            returnCode = objInvBL.GetInvComputationRuleByGroup(OrgID, -1, out lstInvOrgGroup);
            if (lstInvOrgGroup.Count > 0)
            {
                returnCode = objInvBL.GetInvestigation(OrgID, out lstInvestigations);
                lnkPatterns.Visible = true;
                grdGroups.DataSource = lstInvOrgGroup;
                grdGroups.DataBind();
            }
            else
            {
                lnkPatterns.Visible = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading grid", ex);
            throw ex;
        }
    }

    protected void grdGroups_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                InvOrgGroup objInvOrgGroup = (InvOrgGroup)e.Row.DataItem;
                GridView grdPatterns = new GridView();
                grdPatterns = (GridView)e.Row.FindControl("grdPatterns");

                DataTable dataTable = new DataTable();
                dataTable.Columns.Add("DepInvestigationID", typeof(long));
                dataTable.Columns.Add("DependentInvestigation", typeof(string));
                dataTable.Columns.Add("Pattern", typeof(string));

                string[] validationRule = objInvOrgGroup.ValidationRule.Split('^');
                string depInvName = string.Empty;
                //Changed Int to Long by Arivalagan.kk//
                long depInvID = 0;
                foreach (string pattern in validationRule)
                {
                    string[] computationRule = pattern.Split('=');
                    var invName = ((from inv in lstInvestigations
                                    where Convert.ToString(inv.InvestigationID) == computationRule[0].Replace("[", "").Replace("]", "")
                                    select inv).Distinct());
                    if (invName.Any())
                    {
                        depInvName = invName.First().InvestigationName;
                        //Changed Int16 to ToInt64 by Arivalagan.kk//
                        depInvID = Convert.ToInt64(computationRule[0].Replace("[", "").Replace("]", ""));
                    }
                    else
                    {
                        var invID = ((from inv in lstInvestigations
                                    where inv.InvestigationName == computationRule[0]
                                    select inv).Distinct());
                        if (invID.Any())
                        {
                            depInvID = Convert.ToInt16(invID.First().InvestigationID);
                            depInvName = computationRule[0];
                        }
                    }
                    if (computationRule.Length >= 2)
                    {
                        dataTable.Rows.Add(depInvID, depInvName, GetFormulaWithInvName(computationRule[1], false));
                    }
                }
                grdPatterns.DataSource = dataTable;
                grdPatterns.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while binding grid", ex);
            throw ex;
        }
    }

    protected void grdGroups_PreRender(object sender, EventArgs e)
    {
        try
        {
            if (grdGroups.HeaderRow != null)
            {
                grdGroups.UseAccessibleHeader = true;
                grdGroups.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grid prerender", ex);
            throw ex;
        }
    }

    protected void lnkbtnEdit_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lb = (LinkButton)sender;
            GridViewRow childRow = (GridViewRow)lb.NamingContainer;
            GridViewRow parentRow = (GridViewRow)((LinkButton)sender).Parent.Parent.Parent.Parent.Parent.Parent;
            HiddenField hdnOrgGroupID = (HiddenField)parentRow.FindControl("hdnOrgGroupID");
            HiddenField hdnDepInvestigationID = (HiddenField)childRow.FindControl("hdnDepInvestigationID");
            ddlInvGroup.SelectedIndex = ddlInvGroup.Items.IndexOf(ddlInvGroup.Items.FindByValue(hdnOrgGroupID.Value));
            LoadInvestigationByGroup(hdnOrgGroupID.Value);
            
            if (ddlTargetInv.Items.Count > 0)
            {
                ddlTargetInv.SelectedIndex = ddlTargetInv.Items.IndexOf(ddlTargetInv.Items.FindByValue(hdnDepInvestigationID.Value));
            }
            int rowIndex = 0;
            foreach (TableRow row in tblSelectedPatterns.Rows)
            {
                if (row.Cells[0].Text == ddlTargetInv.SelectedItem.Text)
                    rowIndex = tblSelectedPatterns.Rows.GetRowIndex(row);
            }
            if (rowIndex > 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "FormulaEdit", "EditInvPattern(" + rowIndex + ")", true);
                mpePatternSelection.Hide();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while edit group investigation", ex);
            //ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "Error while edit group investigation";
        }
    }

    private void LoadTable()
    {
        try
        {
            Investigation_BL objInvBL = new Investigation_BL(base.ContextInfo);
            List<InvOrgGroup> lstInvOrgGroup = new List<InvOrgGroup>();
            returnCode = objInvBL.GetInvComputationRuleByGroup(OrgID, Int32.Parse(ddlInvGroup.SelectedValue), out lstInvOrgGroup);
            if (lstInvOrgGroup.Count > 0)
            {
                InvOrgGroup objInvOrgGroup = lstInvOrgGroup[0];
                if (lstBoxInvestigation.Items.Count > 0 && lstBoxOperator.Items.Count > 0 && !String.IsNullOrEmpty(objInvOrgGroup.ValidationRule))
                {
                    string[] validationRule = objInvOrgGroup.ValidationRule.Split('^');
                    foreach (string pattern in validationRule)
                    {
                        string[] computationRule = pattern.Split('=');
                        if (computationRule.Length >= 2)
                        {
                            string[] patternText = computationRule[1].Split('~');
                            Int32 rowCount = tblSelectedPatterns.Rows.Count;

                            TableRow row = new TableRow();

                            TableCell cell1 = new TableCell();
                            ListItem depItem = ddlTargetInv.Items.FindByValue(computationRule[0].Replace("[", "").Replace("]", ""));
                            if (depItem != null)
                                cell1.Text = depItem.Text;
                            else
                                cell1.Text = computationRule[0];
                            row.Cells.Add(cell1);

                            TableCell cell2 = new TableCell();
                            cell2.Text = GetFormulaWithInvName(computationRule[1], true);
                            row.Cells.Add(cell2);

                            TableCell cell3 = new TableCell();
                            cell3.Text = "<input id='btnEdit" + rowCount + "' name='Edit' value='Edit' type='button' onclick='EditInvPattern(" + rowCount + ");' style='background-color:Transparent;color: Blue;border-style:none;text-decoration:underline;cursor:pointer;'/>&nbsp;&nbsp;<input id='btnDelete" + rowCount + "' name='Delete' value='Delete' type='button' style='background-color:Transparent;color: Blue;border-style:none;text-decoration:underline;cursor:pointer;' onclick='DeleteInvPattern(this);'/>";
                            row.Cells.Add(cell3);

                            TableCell cell4 = new TableCell();
                            cell4.Attributes.Add("style", "display:none;");
                            cell4.Text = GetValidationText(pattern);
                            row.Cells.Add(cell4);

                            TableCell cell5 = new TableCell();
                            cell5.Attributes.Add("style", "display:none;");
                            cell5.Text = pattern;
                            row.Cells.Add(cell5);

                            tblSelectedPatterns.Rows.Add(row);
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading table", ex);
            throw ex;
        }
    }

    private String GetFormulaWithInvName(String validationRule, bool isGroupLevel)
    {
        StringBuilder valRule = new StringBuilder();
        try
        {
            string[] pattern = validationRule.Split('~');
            ListItem invItem;

            foreach (string str in pattern)
            {
                if (isGroupLevel)
                {
                    invItem = lstBoxInvestigation.Items.FindByValue(str.Replace("[", "").Replace("]", ""));
                    if (invItem != null)
                    {
                        valRule.Append(invItem.Text + " ");
                    }
                    else
                    {
                        valRule.Append(str + " ");
                    }
                }
                else
                {
                    var invName = ((from inv in lstInvestigations
                                    where Convert.ToString(inv.InvestigationID) == str.Replace("[", "").Replace("]", "")
                                    select inv).Distinct());
                    if (invName.Any())
                    {
                        valRule.Append(invName.First().InvestigationName + " ");
                    }
                    else
                    {
                        valRule.Append(str + " ");
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while replacing formula with investigation name", ex);
            throw ex;
        }
        return valRule.ToString().Trim();
    }

    private String GetValidationText(String validationRule)
    {
        StringBuilder validationText = new StringBuilder();
        String valText = string.Empty;
        ListItem oprItem = null;
        ListItem invItem = null;
        ListItem depItem = null;
        string value = string.Empty;
        try
        {
            string[] validationPattern = validationRule.Split('=');
            depItem = ddlTargetInv.Items.FindByValue(validationPattern[0].Replace("[", "").Replace("]", ""));
            string[] pattern = validationPattern[1].Split('~');
            foreach (string str in pattern)
            {
                value = str.Replace("[", "").Replace("]", "");
                oprItem = lstBoxOperator.Items.FindByText(str);
                if (str == "[" + value + "]")
                {
                    invItem = lstBoxInvestigation.Items.FindByValue(value);
                }
                else
                {
                    invItem = lstBoxInvestigation.Items.FindByValue(value);
                }
                if (oprItem != null)
                {
                    if (str == "Round")
                    {
                        validationText.Append("Math.round");
                    }
                    else if (str == "Power")
                    {
                        validationText.Append("Math.pow");
                    }
                    else
                    {
                        validationText.Append(oprItem.Value);
                    }
                }
                else if (invItem != null)
                {
                    validationText.Append("(parseFloat([" + invItem.Value + "]))");
                }
                else
                {
                    validationText.Append(str);
                }
            }
            validationText.Append(";");
            Int32 varCount = tblSelectedPatterns.Rows.Count;
            
            if (depItem != null)
            {
                valText = "var txtEditable" + varCount + " = false; if(document.getElementById('hdnEditableFormulaFields') != null){txtEditable" + varCount + " = document.getElementById('hdnEditableFormulaFields').value.indexOf('[" + depItem.Value + "]') >= 0 ? true : false;} if(!txtEditable" + varCount + "){ var temp" + varCount + " = " + validationText.ToString() + " if(isNaN(temp" + varCount + ")) {[" + depItem.Value + "] = '';} ";
                valText = valText + "else {["+ depItem.Value + "] = " + validationText.ToString() + "}}";
            }
            else
            {
                valText = "var txtEditable" + varCount + " = false; if(document.getElementById('hdnEditableFormulaFields') != null){txtEditable" + varCount + " = document.getElementById('hdnEditableFormulaFields').value.indexOf('" + validationPattern[0] + "') >= 0 ? true : false;} if(!txtEditable" + varCount + "){ var temp" + varCount + " = " + validationText.ToString() + " if(isNaN(temp" + varCount + ")) {" + validationPattern[0] + " = '';} ";
                valText = valText + "else {" + validationPattern[0] + " = " + validationText.ToString() + "}}";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting validation text", ex);
            throw ex;
        }
        return valText;
    }
    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "InvComputation";
            string[] Tempdata = domains.Split(',');
            //string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }


            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "InvComputation"
                                 select child;
                if (childItems.Count() > 0)
                {
                    lstBoxOperator.DataSource = childItems;
                    lstBoxOperator.DataTextField = "DisplayText";
                    lstBoxOperator.DataValueField = "Code";
                    lstBoxOperator.DataBind();


                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }
}
