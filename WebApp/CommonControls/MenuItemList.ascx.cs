using System;
using System.Data;
using System.Collections;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Linq;

public partial class CommonControls_MenuItemList : BaseControl
{
    public CommonControls_MenuItemList() : base("CommonControls_MenuItemList_ascx") { }
    /// <summary>
    /// Remove the comments(///) in order to continue on mapping Actions To the Roles
    /// </summary>
    /// 
    public string MenuHeaderText { get; set; }
    List<RoleMenuInfo> lstUCRoleMenuInfo = new List<RoleMenuInfo>();
    List<RoleMenuInfo> lstUCRoleMenuInfoAll = new List<RoleMenuInfo>();
    List<GetReportDetails> lstReportItems = new List<GetReportDetails>();
    List<GetReportDetails> lstGroupItems = new List<GetReportDetails>();
    Report_BL objreportBL;
    static string var1;
    static int tempVar = 0;
    public string save_mesge = Resources.AppMessages.Save_Message;
    public string fail_mesge = Resources.AppMessages.Failed_Message;
    public string strAlert = Resources.Admin_AppMsg.Admin_MenuMapper_aspx_Alert;
    /// <summary>
    /// Add a DisplayText of the MenuItem If that MenuItem Has the same dispalytext 
    /// and different menuid
    /// </summary>
    /// 
    string[] MultiDisplayText = new string[] { "Patient Search",
                                               "Cash Closure",
                                               "Receipt Search",
                                               "ReceiptSearch",
                                               "Stock Details",
                                               "Change Password",
                                               "BillSearch",
                                               "Bill Search"
                                             };
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
        }
        ///Page.GetPostBackEventReference(btnAction);
    }
    public void GetReports(long RoleID, long OrgID)
    {

        long returnCode = -1;
        objreportBL = new Report_BL(base.ContextInfo);
        returnCode = objreportBL.GetReportItems(RoleID, OrgID, out lstGroupItems, out lstReportItems);

        IEnumerable<GetReportDetails> list = (from l in lstReportItems
                                              group l by new { l.ReportGroupID, l.ReportGroupText } into g
                                              select new GetReportDetails
                                              {
                                                  ReportGroupID = g.Key.ReportGroupID,
                                                  ReportGroupText = g.Key.ReportGroupText,
                                              }).Distinct().ToList();
        RptrReports.DataSource = list;
        RptrReports.DataBind();
    }

    public void BindMenuList(List<RoleMenuInfo> lstRoleMenuInfo, List<RoleMenuInfo> lstRoleMenuInfoAll, long CurrentRoleID, int CurrentOrgID)
    {
        tempVar = 0;
        hdnRoleID.Value = CurrentRoleID.ToString();
        hdnOrgID.Value = CurrentOrgID.ToString();

        lstUCRoleMenuInfo = lstRoleMenuInfo;
        lstUCRoleMenuInfoAll = lstRoleMenuInfoAll;

        foreach (RoleMenuInfo allItem in lstUCRoleMenuInfoAll)
        {
            if (lstUCRoleMenuInfo.Exists(P => P.IsMapped == "Y" && P.ParentID == allItem.ParentID && P.DisplayText == allItem.DisplayText && P.MenuID == allItem.MenuID))
            {
                allItem.IsMapped = "Y";
            }
        }
        IEnumerable<RoleMenuInfo> list = (from l in lstUCRoleMenuInfoAll
                                          group l by new { l.ParentID, l.MenuHeader } into g
                                          select new RoleMenuInfo
                                          {
                                              ParentID = g.Key.ParentID,
                                              MenuHeader = g.Key.MenuHeader,
                                          }).Distinct().ToList();
        rptUCHolder.DataSource = list;
        rptUCHolder.DataBind();
        GetReports(Convert.ToInt64(hdnRoleID.Value),Convert.ToInt64(hdnOrgID.Value));
    }

    protected void RptrReports_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        GetReportDetails objGetReportDet = (GetReportDetails)e.Item.DataItem;
        CheckBoxList chkReports = (CheckBoxList)e.Item.FindControl("chkReports");
        CheckBox chkSelectAll = (CheckBox)e.Item.FindControl("chkSelectAll");
        Panel pnlMenu1 = (Panel)e.Item.FindControl("pnlMenu1");
        loadReportItem(lstReportItems.FindAll(p => p.ReportGroupID == objGetReportDet.ReportGroupID), chkReports, pnlMenu1);
        
        string str = "chkAll('" + var1 + "|" + tempVar + "|"+this.ID+"')";
        chkSelectAll.Attributes.Add("onclick", "javascript:" + str);
    }

    protected void loadReportItem(List<GetReportDetails> lstReportItems, CheckBoxList chkReports, Panel pnlMenu1)
    {

        pnlMenu1.GroupingText = lstReportItems[0].ReportGroupText;
        chkReports.DataSource = lstReportItems;
        chkReports.DataTextField = "ReportDisplayText";
        chkReports.DataValueField = "ReportPath";
        chkReports.DataBind();

        foreach (ListItem item in chkReports.Items)
        {
            hdnReports.Value += item.Text + "~";
            item.Selected = lstReportItems.Exists(P => P.IsMapped == "Y" && P.ReportID.ToString() == item.Value.Split('^')[1].Split('~')[1]);
        }
        hdnReports.Value += pnlMenu1.GroupingText + "^";
        var1 = hdnReports.Value;
        tempVar = tempVar + 1;
    }


    protected void rptUCHolder_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        RoleMenuInfo objRoleMenuInfo = (RoleMenuInfo)e.Item.DataItem;
        CheckBoxList chkMenu = (CheckBoxList)e.Item.FindControl("chkMenu");
        Panel pnlMenu = (Panel)e.Item.FindControl("pnlMenu");
        loadMenuListItems(lstUCRoleMenuInfoAll.FindAll(p => p.ParentID == objRoleMenuInfo.ParentID), chkMenu, pnlMenu);
    }

    protected void loadMenuListItems(List<RoleMenuInfo> lstRoleMenuInfo, CheckBoxList chkMenu, Panel pnlMenu)
    {
        pnlMenu.GroupingText = lstRoleMenuInfo[0].MenuHeader;

        chkMenu.DataSource = lstRoleMenuInfo;
        chkMenu.DataTextField = "DisplayText";
        chkMenu.DataValueField = "Description";
        chkMenu.DataBind();

        foreach (ListItem item in chkMenu.Items)
        {
            item.Selected = lstRoleMenuInfo.Exists(P => P.IsMapped == "Y" && P.MenuID.ToString() == item.Value.Split('~')[0]);  //&& P.DisplayText == item.Text  item.Value.Split('~')[0]
            if (MultiDisplayText.Contains(item.Text))
            {
                item.Text += "(" + item.Value.Split('~')[1] + ")";
            }
            if (item.Text == "Reports")
            {
                item.Text += "<input onclick='ShowEditModal(name,this);' aa='sample' name='" + RoleID + "~" + OrgID + " '  value = 'View' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
            }
        }
    }
    public List<RoleMenuInfo> GetMenuItems()
    {
        foreach (RepeaterItem item in rptUCHolder.Items)
        {
            CheckBoxList chkMenu = (CheckBoxList)item.FindControl("chkMenu");
            HiddenField hdnParentID = (HiddenField)item.FindControl("hdnParentID");
            foreach (ListItem litem in chkMenu.Items)
            {
                RoleMenuInfo objRoleMenuInfo = new RoleMenuInfo();

                objRoleMenuInfo.IsMapped = litem.Selected == true ? "Y" : "N";
                objRoleMenuInfo.MenuID = int.Parse(litem.Value.Split('~')[0]);
                objRoleMenuInfo.ParentID = int.Parse(hdnParentID.Value);
                objRoleMenuInfo.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                objRoleMenuInfo.ModifiedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

                lstUCRoleMenuInfo.Add(objRoleMenuInfo);
            }
        }
        return lstUCRoleMenuInfo;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        lstReportItems = GetMappedReports();
        DataTable DtRptList = GetReportDataTable(lstReportItems);
        returnCode = new Report_BL(base.ContextInfo).SaveMappedReports(RoleID,OrgID,DtRptList);
        if (returnCode >= 0)
        {
            //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Success", "alert('"+ save_mesge +"');", true);
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Success", "javascript:ValidationWindow('" + save_mesge + "','" + strAlert + "');", true);
        }
        else
        { 
            
            //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Failed", "alert('"+fail_mesge +"');", true);
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Failed", "javascript:ValidationWindow('" + fail_mesge + "','" + strAlert + "');", true);
        }
        lstReportItems.Clear();
        lstGroupItems.Clear();
    }
    public List<GetReportDetails> GetMappedReports()
    {
        foreach (RepeaterItem item in RptrReports.Items)
        {
            CheckBoxList chkReports = (CheckBoxList)item.FindControl("chkReports");
            HiddenField hdnGroupID = (HiddenField)item.FindControl("hdnGroupID");
            foreach (ListItem litem in chkReports.Items)
            {
                GetReportDetails objGetReportDet = new GetReportDetails();

                objGetReportDet.ReportDisplayText = litem.Selected == true ? "Y" : "N";
                objGetReportDet.ReportID = int.Parse(litem.Value.Split('^')[1].Split('~')[1]);
                objGetReportDet.ReportGroupID = int.Parse(hdnGroupID.Value);
                objGetReportDet.OrgID =Convert.ToInt64(hdnOrgID.Value);
                objGetReportDet.RoleID = Convert.ToInt32(hdnRoleID.Value);

                lstReportItems.Add(objGetReportDet);
            }
        }
        return lstReportItems;
    }
    private DataTable GetReportDataTable(List<GetReportDetails> lstReportItems)
    {
        System.Data.DataTable dt = new DataTable();

        try
        {

            DataColumn dbCol1 = new DataColumn("UserMenuID");
            DataColumn dbCol2 = new DataColumn("MenuID");
            DataColumn dbCol3 = new DataColumn("RoleID");
            DataColumn dbCol4 = new DataColumn("RoleName");
            DataColumn dbCol5 = new DataColumn("ParentID");
            DataColumn dbCol6 = new DataColumn("DisplayText");
            DataColumn dbCol7 = new DataColumn("MenuHeader");
            DataColumn dbCol8 = new DataColumn("IsMapped");
            DataColumn dbCol9 = new DataColumn("HasAction");
            DataColumn dbCol10 = new DataColumn("CreatedAt");
            DataColumn dbCol11 = new DataColumn("ModifiedAt");
            DataColumn dbCol12 = new DataColumn("CreatedBy");
            DataColumn dbCol13 = new DataColumn("ModifiedBy");
            DataColumn dbCol14 = new DataColumn("Description");
            DataColumn dbCol15 = new DataColumn("OrgID");
            DataColumn dbCol16 = new DataColumn("OrgAddressID");

            dt.Columns.Add(dbCol1);
            dt.Columns.Add(dbCol2);
            dt.Columns.Add(dbCol3);
            dt.Columns.Add(dbCol4);
            dt.Columns.Add(dbCol5);
            dt.Columns.Add(dbCol6);
            dt.Columns.Add(dbCol7);
            dt.Columns.Add(dbCol8);
            dt.Columns.Add(dbCol9);
            dt.Columns.Add(dbCol10);
            dt.Columns.Add(dbCol11);
            dt.Columns.Add(dbCol12);
            dt.Columns.Add(dbCol13);
            dt.Columns.Add(dbCol14);
            dt.Columns.Add(dbCol15);
            dt.Columns.Add(dbCol16);

            DataRow dr;
            foreach (GetReportDetails objRPT in lstReportItems)
            {
                dr = dt.NewRow();

                dr["UserMenuID"] = "";
                dr["MenuID"] = objRPT.ReportGroupID;
                dr["RoleID"] = objRPT.RoleID;
                dr["RoleName"] = "";
                dr["ParentID"] = objRPT.ReportID;
                dr["DisplayText"] = "";
                dr["MenuHeader"] = "";
                dr["IsMapped"] = objRPT.ReportDisplayText;
                dr["HasAction"] = "";
                dr["CreatedAt"] = "";
                dr["ModifiedAt"] = "";
                dr["CreatedBy"] = "";
                dr["ModifiedBy"] = "";
                dr["Description"] = "";
                dr["OrgID"] = objRPT.OrgID;
                dr["OrgAddressID"] = "";

                dt.Rows.Add(dr);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Executing GetReportDataTable", ex);
        }
        return dt;
    }
}
