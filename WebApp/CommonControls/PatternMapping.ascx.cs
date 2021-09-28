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
using System.Text;
using System.Linq;

public partial class CommonControls_PatternMapping : BaseControl
{
    List<InvestigationMaster> lstPatternForINV = new List<InvestigationMaster>();
    // List<InvestigationPattern> lstpattern = new List<InvestigationPattern>();
    List<InvestigationPattern> lstpattern1 = new List<InvestigationPattern>();
    List<InvestigationMaster> lstInvestigation = new List<InvestigationMaster>();
    List<PatternMapping> lstpatternmapping = new List<PatternMapping>();
    List<InvReportMaster> lstInvReportMaster = new List<InvReportMaster>();
    List<InvReportMapping> lstInvReportMapping = new List<InvReportMapping>();
    int InvestigationID, PatternID;
    long returnCode = -1;
    string InvName = string.Empty;
    string UserHeaderText = Resources.Investigation_AppMsg.Investigation_PatternMappingForInvestigation_009 == null ? "Alert" : Resources.Investigation_AppMsg.Investigation_PatternMappingForInvestigation_009;
    string select = Resources.Investigation_ClientDisplay.Investigation_PatternMappingForInvestigation_0089 == null ? "---Select---" : Resources.Investigation_ClientDisplay.Investigation_PatternMappingForInvestigation_0089;
    string depart = Resources.Investigation_ClientDisplay.Investigation_PatternMappingForInvestigation_0090 == null ? "Select the PatternName" : Resources.Investigation_ClientDisplay.Investigation_PatternMappingForInvestigation_0090;
    string Preview = Resources.Investigation_ClientDisplay.Investigation_PatternMappingForInvestigation_0091 == null ? "Preview" : Resources.Investigation_ClientDisplay.Investigation_PatternMappingForInvestigation_0091;
    public CommonControls_PatternMapping()
        : base("CommonControls_PatternMapping_ascx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        //pgetpattern method used to here for convert from list to hashtable
        returnCode = new Investigation_BL(base.ContextInfo).pGetPattern(InvestigationID, PatternID, out lstpattern1);
        returnCode = new Investigation_BL(base.ContextInfo).GetINVandPatternChange(InvName, out lstPatternForINV);
        
        if (!IsPostBack)
        {
            loadgrid();
            Hashtable investigationpat = new Hashtable();
            investigationpat.Add("Pattern1", "PattrenValue");
            foreach (InvestigationPattern Pat in lstpattern1)
            {
                if (!investigationpat.ContainsKey(Pat.PatternID.ToString()))
                {
                    investigationpat.Add(Pat.PatternID.ToString(), Pat.PatternName);
                }
                

            }
            ViewState["LoadControl"] = investigationpat;
           
        } 

    }
    protected void loadgrid()
    {
        try
        {
            returnCode = new Investigation_BL(base.ContextInfo).GetInvReportTemplateList(out lstInvReportMaster, out lstInvReportMapping);
            //
            returnCode = new Investigation_BL(base.ContextInfo).GetINVandPatternChange(InvName, out lstPatternForINV);
            Investigation_BL invBL = new Investigation_BL(base.ContextInfo);
            grdpat.DataSource = lstPatternForINV;
            grdpat.DataBind();
            returnCode = new Investigation_BL(base.ContextInfo).pGetPattern(InvestigationID, PatternID, out lstpattern1);
            ddlpatternName.DataSource = lstpattern1;
            ddlpatternName.DataTextField = "DisplayText";
            ddlpatternName.DataValueField = "PatternID";
            ddlpatternName.DataBind();
            ddlpatternName.Items.Insert(0, select);
           // div1.Style.Add("display", "block");


            if (TabContainer1_TabPanel2_PM_rdoInvestigation.Checked == true)
            {
                div1.Style.Add("display", "block");
                div2.Style.Add("display", "none");
            }
            else
            {
                div2.Style.Add("display", "block");
                div1.Style.Add("display", "none");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadGrid", ex);
        }
    }
    public void grdpat_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            DropDownList ddlPattern = (DropDownList)e.Row.FindControl("ddlPattern");
            Label inv = (Label)e.Row.FindControl("InvestigationName");
            CheckBox chkSelect = (CheckBox)e.Row.FindControl("chkSelect");
            InvestigationMaster IP = (InvestigationMaster)e.Row.DataItem;
            ddlPattern.DataSource = lstpattern1;
            ddlPattern.DataTextField = "Displaytext";
            ddlPattern.DataValueField = "PatternID";
            ddlPattern.DataBind();
            //DropDown Value is Selected for equalent Investigation
            ddlPattern.SelectedValue = IP.PatternID.ToString();
            ddlPattern.Items.Insert(0, select);
            //If We are change the DropDown value,automatically checkBox is enabled
            ddlPattern.Attributes.Add("onchange", "javascript:DropCheck('" + ddlPattern.ClientID + "','" + chkSelect.ClientID + "');");

            DropDownList ddlReportTemplate = (DropDownList)e.Row.FindControl("ddlReportTemplate");
            var temp = from s in lstInvReportMaster
                       where s.OrgID == OrgID
                       orderby s.ReportTemplateName
                       select s;
            ddlReportTemplate.DataSource = temp;
            ddlReportTemplate.DataTextField = "ReportTemplateName";
            ddlReportTemplate.DataValueField = "TemplateID";
            ddlReportTemplate.DataBind();
            ddlReportTemplate.Items.Insert(0, select);
            ddlReportTemplate.Attributes.Add("onchange", "javascript:DropCheck('" + ddlReportTemplate.ClientID + "','" + chkSelect.ClientID + "');");

            List<InvReportMapping> lstRM = new List<InvReportMapping>();
            lstRM = lstInvReportMapping.FindAll(P => P.InvestigationID == IP.InvestigationID);
            if (lstRM.Count > 0)
            {
                ddlReportTemplate.SelectedValue = lstRM[0].TemplateID.ToString();
            }
        }
          
    }
    protected void grdpat_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdpat.PageIndex = e.NewPageIndex;
            loadgrid();
        }

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            //CHECKED DATAROW ONLY SAVE IN THE DATABASE

            long returnCode = -1;
            //ErrorDisplay1.ShowError = false;
            Investigation_BL OrdInv = new Investigation_BL(base.ContextInfo);
            List<PatternMapping> lstOrderinvestication = new List<PatternMapping>();
            List<InvReportMapping> lstRptMapSave = new List<InvReportMapping>();
            PatternMapping lstitem;
            foreach (GridViewRow row in grdpat.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    lstitem = new PatternMapping();
                    CheckBox chkBox = (CheckBox)row.FindControl("chkSelect");
                    DropDownList ddlPattern = (DropDownList)row.FindControl("ddlPattern");
                    Label lblInvestigationNo = (Label)row.FindControl("lblInvestigationNo");

                    DropDownList ddlRptMap = (DropDownList)row.FindControl("ddlReportTemplate");

                    if (chkBox.Checked)
                    {
                        lstitem.InvestigationID = Convert.ToInt64(lblInvestigationNo.Text);
                        lstitem.PatternID = Convert.ToInt64(ddlPattern.SelectedValue.ToString());
                        lstOrderinvestication.Add(lstitem);

                        InvReportMapping rowRptMap = new InvReportMapping();
                        rowRptMap.InvestigationID = Convert.ToInt64(lblInvestigationNo.Text);
                        rowRptMap.TemplateID = Convert.ToInt32(ddlRptMap.SelectedValue.ToString());
                        lstRptMapSave.Add(rowRptMap);
                        
                    }
                       //grdpat.DataBind();
                       
                        

                }

            }
            if (lstOrderinvestication.Count > 0)
            {

                Investigation_BL invBL = new Investigation_BL(base.ContextInfo);
                returnCode = invBL.pSavePattern(lstOrderinvestication, lstRptMapSave);
                loadgrid();
                if (returnCode == 0)
                {
                    Div3.Style.Add("display", "none");
                    // loadgrid();                   
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "aa", "alert('Changes saved successfully.');", true);
                    string UserDisplayText = Resources.Investigation_AppMsg.Investigation_PatternMappingForInvestigation_008 == null ? "Changes Saved successfully." : Resources.Investigation_AppMsg.Investigation_PatternMappingForInvestigation_008;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + UserDisplayText + "','" + UserHeaderText + "');", true);
                }
                div1.Style.Add("display", "block");
                div2.Style.Add("display", "none");

            }
            else
            {
                //ErrorDisplay1.ShowError = true;
                // ErrorDisplay1.Status = "Please select a record and then Save";
                Div3.Style.Add("display", "none");
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "aa", "alert('Please select a record and then Save');", true);
                string UserDisplayText1 = Resources.Investigation_AppMsg.Investigation_PatternMappingForInvestigation_007 == null ? "Please select a record and then Save" : Resources.Investigation_AppMsg.Investigation_PatternMappingForInvestigation_007;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + UserDisplayText1 + "','" + UserHeaderText + "');", true);

            } 

           


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in save button", ex);
        }

       // div1.Style.Add("display", "block");
    
    
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            long Returncode = -1;
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            Returncode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            //INVESTIGATION NAME IS SEND THROUGH INVNAME AND MATCHES RECORDS ONLY DISPLY IN THE GRID
            InvName = TabContainer1_TabPanel2_PM_txtSearch.Text;
            returnCode = new Investigation_BL(base.ContextInfo).GetINVandPatternChange(InvName.Trim(), out lstPatternForINV);
            if (returnCode == 0)
            {
                loadgrid();
               // div1.Style.Add("display", "block");
            }

           TabContainer1_TabPanel2_PM_txtSearch.Text = "";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in investigation search ", ex);
        }
    }
    protected void ddlpatternName_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            //if user is select any PatternName from dropdownlist,that containing investigation is displayed
            if (ddlpatternName.SelectedIndex > 0)
            {
                returnCode = new Investigation_BL(base.ContextInfo).pGetPatternInvestigation(int.Parse(ddlpatternName.SelectedValue), OrgID, out lstInvestigation);
                if (lstInvestigation.Count > 0)
                {
                    grdptn.DataSource = lstInvestigation;
                    grdptn.DataBind();
                    //div1.Visible = true;
                    div2.Style.Add("display", "block");
                    div1.Style.Add("display", "none"); 
                }
                else
                {
                    grdptn.DataSource = null;
                    grdptn.DataBind();
                }
            }
            else
            {
                grdptn.DataSource = null;
                grdptn.DataBind();
               ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + UserHeaderText + "','" + depart + "');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "m", "alert('Select the PatternName');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Selecting PatternMapping", ex);
        }
    }
    protected void grdptn_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                grdptn.PageIndex = e.NewPageIndex;

                if (ddlpatternName.SelectedIndex > 0)
                {
                    returnCode = new Investigation_BL(base.ContextInfo).pGetPatternInvestigation(int.Parse(ddlpatternName.SelectedValue), OrgID, out lstInvestigation);
                    grdptn.DataSource = lstInvestigation;
                    grdptn.DataBind();
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in PageIndexChange", ex);
        }

    }
    protected void PatternLoad_Click(object sender, EventArgs e)
    {
        try
        {
            //PATTERN CONTROL CAN BE SEE AS FIGURE SO THAT LOADCONTROL IS USING
            int PatternID = Convert.ToInt32(ddlpatternName.SelectedValue);
            Hashtable investigationpat = new Hashtable();
            investigationpat = (Hashtable)ViewState["LoadControl"];
            foreach (string Var in investigationpat.Keys)
            {
                if (Var == PatternID.ToString())
                {
                    Control ctrl = LoadControl(investigationpat[Var].ToString());
                    panel1.Controls.Add(ctrl);
                    ModalPopupExtender1.Show();
                    break;
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in PatternMapping ", ex);
        }

    }
    protected void grdpat_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {

            if (e.CommandName == Preview)
            {
                //SELECTED ROW VALUE ONLY DISPLAY THE LOAD CONTROL.  
                int rowid = Convert.ToInt16(e.CommandArgument);
                DropDownList ddlPattern = (DropDownList)grdpat.Rows[rowid].FindControl("ddlPattern");
                int PatternID = Convert.ToInt32(ddlPattern.SelectedValue);
                Hashtable investigationpat = new Hashtable();
                investigationpat = (Hashtable)ViewState["LoadControl"];
                foreach (string Var in investigationpat.Keys)
                {
                    if (Var == PatternID.ToString())
                    {
                        Control ctrl1 = LoadControl(investigationpat[Var].ToString());
                        panel2.Controls.Add(ctrl1);
                        ModalPopupExtender2.Show();
                        div1.Style.Add("display", "block");
                        Div3.Style.Add("display", "block");
                        break;
                    }
                } 

            }
        }
        catch (Exception ea)
        {
            CLogger.LogError("Error occured in PatternMapping Control", ea);
        }
    }

}