using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Web.UI.HtmlControls;
using System.IO;
using AjaxControlToolkit;
public partial class Admin_TestInvestigation :BasePage
{
    public Admin_TestInvestigation()
        : base("Admin_TestInvestigation_aspx")
    {
    }
    string StrDispSel = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_20 == null ? "--Select--" : Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_20;
      
    public string Update_Msg = Resources.AppMessages.Update_Message;
    List<InvestigationMaster> objSearch = new List<InvestigationMaster>();
    List<InvestigationMaster> objmapSearch = new List<InvestigationMaster>();
    List<InvDeptMaster> ObjInvDep = new List<InvDeptMaster>();
    List<InvestigationOrgMapping> lstInvOrg = new List<InvestigationOrgMapping>();
    List<InvestigationOrgMapping> IOMAll = new List<InvestigationOrgMapping>();
    List<InvestigationOrgMapping> IOMSelect = new List<InvestigationOrgMapping>();
    List<InvestigationHeader> objHeader = new List<InvestigationHeader>();
    List<InvestigationMaster> objMap = new List<InvestigationMaster>();
    List<InvestigationOrgMapping> objLoadInvMap = new List<InvestigationOrgMapping>();
    Investigation_BL ObjInv ;
    List<InvDeptMaster> lstDpt = new List<InvDeptMaster>();
    string UP = Resources.ClientSideDisplayTexts.Admin_TestInvestigation_UP;
    string DOWN = Resources.ClientSideDisplayTexts.Admin_TestInvestigation_Down;
    long returnCode = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        ObjInv = new Investigation_BL(base.ContextInfo);
        try
        {
            if (!IsPostBack)
            {
                Label label1 = (Label)ManageInvestigation.FindControl("Label1");
                Label label2 = (Label)ManageInvestigation.FindControl("Label2");
                Label label3 = (Label)ManageInvestigation.FindControl("Label3");
                //label1.Text = "Master Investigation";
                label1.Text = Resources.ClientSideDisplayTexts.Admin_Testinvestigation_MasterInvestigation;
                //label2.Text = "Mapped Investigation";
                label2.Text = Resources.ClientSideDisplayTexts.Admin_Testinvestigation_MappedInvestigation;
                //label3.Text = "Lab";
                label3.Text = Resources.ClientSideDisplayTexts.Admin_Testinvestigation_Lab;
                RadioButton Radio1 = (RadioButton)ManageInvestigation.FindControl("rdoInvestigation");
                RadioButton Radio2 = (RadioButton)ManageInvestigation.FindControl("rdoGroup");
                Radio1.Visible = false;
                Radio2.Visible = false;
                //fill();
                //loadInvestigationgrid();
                //returnCode = ObjInv.GetInvforDept(OrgID, out lstDpt);
                //if (lstDpt.Count > 0)
                //{
                //    ddldptname.DataSource = lstDpt;
                //    ddldptname.DataTextField = "DeptName";
                //    ddldptname.DataValueField = "DeptId";
                //    ddldptname.DataBind();
                //    ddldptname.Items.Insert(0, "---Select--->");
                //}
                tprint.Attributes.Add("Style", "Display:None");
                HdnLoad.Value = String.Empty;
                HdnOrgID.Value = OrgID.ToString();
                ddldptname.Attributes.Add("onchange", "call();");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Page Load", ex);
        }

    }
    protected void loaddropdown()
    {
        try
        {
            returnCode = ObjInv.GetInvforDept(OrgID, out lstDpt);
            if (lstDpt.Count > 0)
            {
                ddldptname.DataSource = lstDpt;
                ddldptname.DataTextField = "DeptName";
                ddldptname.DataValueField = "DeptId";
                ddldptname.DataBind();
                ddldptname.Items.Insert(0, StrDispSel);
                ddldptname.SelectedIndex = 0;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured while loading dropdown", ex);
        }

    }
    protected void loaddata(List<InvestigationOrgMapping> lstmap)
    {
        try
        {
            if (lstmap.Count > 0)
            {
                System.Data.DataTable dt = new DataTable();
                DataColumn dbCol1 = new DataColumn("InvestigationID");
                DataColumn dbCol2 = new DataColumn("InvestigationName");
                DataColumn dbCol3 = new DataColumn("OrgId");
                DataColumn dbCol4 = new DataColumn("DeptId");
                DataColumn dbCol5 = new DataColumn("HeaderID");
                DataColumn dbCol6 = new DataColumn("Display");
                DataColumn dbCol7 = new DataColumn("DisplayText");
                DataColumn dbCol8 = new DataColumn("ReferenceRange");
                DataColumn dbCol9 = new DataColumn("SequenceNo");
                DataColumn dbCol10 = new DataColumn("SampleCode");
                DataColumn dbCol11 = new DataColumn("MethodID");
                DataColumn dbCol12 = new DataColumn("PrincipleID");
                DataColumn dbCol13 = new DataColumn("KitID");
                DataColumn dbCol14 = new DataColumn("InstrumentID");
                DataColumn dbCol15 = new DataColumn("QCData");
                DataColumn dbCol16 = new DataColumn("Interpretation");
                DataColumn dbCol17 = new DataColumn("SampleContainerID");
                DataColumn dbCol18 = new DataColumn("UOMID");
                DataColumn dbCol19 = new DataColumn("UOMCode");
                DataColumn dbCol20 = new DataColumn("LoginID");
                DataColumn dbCol21 = new DataColumn("PanicRange");
                DataColumn dbCol22 = new DataColumn("AutoApproveLoginID");
                DataColumn dbCol23 = new DataColumn("ReferenceRangeString");

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
                dt.Columns.Add(dbCol17);
                dt.Columns.Add(dbCol18);
                dt.Columns.Add(dbCol19);
                dt.Columns.Add(dbCol20);
                dt.Columns.Add(dbCol21);
                dt.Columns.Add(dbCol22);
                dt.Columns.Add(dbCol23);
                

                foreach (InvestigationOrgMapping org in lstmap)
                {
                    DataRow dr = dt.NewRow();
                    dr["InvestigationID"] = org.InvestigationID;
                    dr["OrgID"] = OrgID;
                    dr["DeptID"] = "";
                    dr["HeaderID"] = "";
                    dr["InvestigationName"] = org.InvestigationName;
                    dr["Display"] = "";
                    dr["DisplayText"] = "";
                    dr["ReferenceRange"] = "";
                    dr["SequenceNo"] = org.SequenceNo;
                    dr["SampleCode"] = "";
                    dr["MethodID"] = "";
                    dr["PrincipleID"] = "";
                    dr["KitID"] = "";
                    dr["InstrumentID"] = "";
                    dr["QCData"] = "";
                    dr["Interpretation"] = "";
                    dr["SampleContainerID"] = "";
                    dr["UOMID"] = "";
                    dr["UOMCode"] = "";
                    dr["LoginID"] = "";
                    dr["PanicRange"] = "";
                    dr["AutoApproveLoginID"] = "";
                    dr["ReferenceRangeString"] = org.ReferenceRangeString;
                    dt.Rows.Add(dr);
                }
                ViewState["Reckon"] = dt;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Sequence Investigation", ex);
        }
    }
    protected void ddldptname_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            string s = ddldptname.SelectedItem.Text;
            if (ddldptname.SelectedIndex > 0)
            {
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "checkforchanges();", true);
                //if (Convert.ToInt32(HdnCount.Value) == 0)
                //{
                    //Get the investigation for the corresponding dept
                    returnCode = ObjInv.pGetInvDeptData(OrgID, int.Parse(ddldptname.SelectedValue), out lstInvOrg);
                    if (lstInvOrg.Count > 0)
                    {
                        gvReckon.DataSource = lstInvOrg;
                        gvReckon.DataBind();
                        loaddata(lstInvOrg);
                        gv.Attributes.Add("style", "display:block");
                        tprint.Attributes.Add("style", "display:table");
                    }
                    else//the data for the department is empty. Clear the bind list
                    {
                        gvReckon.DataSource = null;
                        gvReckon.DataBind();
                    }
                //}
                //else
                //{
                //    if (MessageBox.Show("Changes not saved.Do you want to continue without saving?", "Confirm continue", MessageBoxButtons.YesNo) == DialogResult.Yes)
                //    {
                //        HdnCount.Value = "0";
                //        returnCode = ObjInv.pGetInvDeptData(OrgID, int.Parse(ddldptname.SelectedValue), out lstInvOrg);
                //        if (lstInvOrg.Count > 0)
                //        {
                //            gvReckon.DataSource = lstInvOrg;
                //            gvReckon.DataBind();
                //            loaddata(lstInvOrg);
                //            gv.Attributes.Add("style", "display:block");
                //            tprint.Attributes.Add("style", "display:block");
                //        }
                //    }
                //    else
                //    {
                        //ddldptname.Items.FindByText(HdnSelected.Value.ToString()).Selected = true;
                        //ddldptname.Items.FindByText(s.ToString()).Selected = false;
                    //}
                //}
            }
            else
            {
                gvReckon.DataSource = null;
                gvReckon.DataBind();
                tprint.Attributes.Add("style", "display:none");
                string sPath = "Admin\\\\TestInvestigation.aspx.cs_6";
                ClientScript.RegisterStartupScript(this.GetType(), "m", "ShowAlertMsg('" + sPath + "');", true);
                //ClientScript.RegisterStartupScript(this.GetType(), "m", "alert('Select the department');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Sequence Investigation", ex);
        }
    }
    public void filldata()
    {
        try
        {
            gvReckon.DataSource = null;
            gvReckon.DataBind();
            tprint.Attributes.Add("Style", "Display:None");
            ddldptname.SelectedIndex = 0;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Sequence Investigation", ex);
        }
    }
    protected void btnSequenceSave_Click(object sender, EventArgs e)
    {
        try
        {
            InvestigationOrgMapping Inv = new InvestigationOrgMapping();
            List<InvestigationOrgMapping> lstInvOrg = new List<InvestigationOrgMapping>();
            Investigation_BL objInv = new Investigation_BL(base.ContextInfo);
            DataTable dt = (DataTable)ViewState["Reckon"];
            returnCode = objInv.pUpdateInvSequence(dt, OrgID, int.Parse(ddldptname.SelectedValue));
            if (returnCode == 0)
            {
                filldata();
                HdnCount.Value = "0";
                // this.Page.RegisterStartupScript("key1", "<script language='javascript' >alert('Changes saved successfully.'); </script>");
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "m", "alert('"+Update_Msg+"');", true);
                //ScriptManager.RegisterStartupScript(Page,this.GetType(), "m", "alert('Changes saved successfully.');", true);
            }
            
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Saving Sequence Investigation", ex);
        }
    }
    protected void Gvbound(object se, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string strScript = "SelectInvSeqRowCommon('" + ((RadioButton)e.Row.FindControl("rdbcheck")).ClientID + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdbcheck")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdbcheck")).Attributes.Add("onclick", strScript);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Gvbound in Investigation Master", ex);
        }
    }
    protected void gvReckon_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            DataTable dt = (DataTable)ViewState["Reckon"];
            int selRow = Convert.ToInt32(e.CommandArgument);
            int swapRow = 0;
            //int MoveRow = 0;
            int rowindex = 0;
            int count = gvReckon.Rows.Count;
            if (dt != null && dt.Rows.Count > 0)
            {
                if (e.CommandName == UP )
                {
                    if (selRow > 0)
                    {
                        swapRow = selRow - 1;
                        string strTempDtlID = dt.Rows[selRow]["InvestigationID"].ToString();
                        string strTempValue = dt.Rows[selRow]["InvestigationName"].ToString();
                        dt.Rows[selRow]["InvestigationID"] = dt.Rows[swapRow]["InvestigationID"];
                        dt.Rows[selRow]["InvestigationName"] = dt.Rows[swapRow]["InvestigationName"];
                        dt.Rows[swapRow]["InvestigationName"] = strTempValue;
                        dt.Rows[swapRow]["InvestigationID"] = strTempDtlID;
                        gvReckon.DataSource = dt;
                        gvReckon.DataBind();
                    }
                }
                else if (e.CommandName == DOWN)
                {
                    if (selRow < dt.Rows.Count - 1)
                    {
                        swapRow = selRow + 1;
                        string strTempDtlID = dt.Rows[selRow]["InvestigationID"].ToString();
                        string strTempValue = dt.Rows[selRow]["InvestigationName"].ToString();
                        dt.Rows[selRow]["InvestigationID"] = dt.Rows[swapRow]["InvestigationID"];
                        dt.Rows[selRow]["InvestigationName"] = dt.Rows[swapRow]["InvestigationName"];
                        dt.Rows[swapRow]["InvestigationName"] = strTempValue;
                        dt.Rows[swapRow]["InvestigationID"] = strTempDtlID;
                        gvReckon.DataSource = dt;
                        gvReckon.DataBind();
                    }
                }
                if (e.CommandName == "Move")
                {
                    foreach (GridViewRow GR in gvReckon.Rows)
                    {
                        RadioButton rdb = (RadioButton)GR.FindControl("rdbcheck");
                        if (rdb.Checked)
                        {
                            rowindex = GR.RowIndex;
                            if (rowindex > selRow)
                            {
                                for (int i = rowindex; i > selRow; i--)
                                {
                                    string strTempDtlID = dt.Rows[i]["InvestigationID"].ToString();
                                    string strTempValue = dt.Rows[i]["InvestigationName"].ToString();
                                    dt.Rows[i]["InvestigationID"] = dt.Rows[i - 1]["InvestigationID"];
                                    dt.Rows[i]["InvestigationName"] = dt.Rows[i - 1]["InvestigationName"];
                                    dt.Rows[i - 1]["InvestigationID"] = strTempDtlID;
                                    dt.Rows[i - 1]["InvestigationName"] = strTempValue;
                                }
                            }
                            else if (rowindex < selRow)
                            {
                                for (int i = rowindex; i < selRow; i++)
                                {
                                    string strTempDtlID = dt.Rows[i]["InvestigationID"].ToString();
                                    string strTempValue = dt.Rows[i]["InvestigationName"].ToString();
                                    dt.Rows[i]["InvestigationID"] = dt.Rows[i + 1]["InvestigationID"];
                                    dt.Rows[i]["InvestigationName"] = dt.Rows[i + 1]["InvestigationName"];
                                    dt.Rows[i + 1]["InvestigationID"] = strTempDtlID;
                                    dt.Rows[i + 1]["InvestigationName"] = strTempValue;
                                }
                            }
                            gvReckon.DataSource = dt;
                            gvReckon.DataBind();
                        }
                    }
                }
            }
            ViewState["Reckon"] = dt;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Sequence Investigation", ex);
        }
    }
    //public void fill()
    //{
    //    try
    //    {            
    //        ObjInv.GetInvList(OrgID, out objMap);
    //        Session["search"] = new List<InvestigationMaster>();
    //        Session["search"] = objMap;
    //        if (objMap.Count > 0)
    //        {
    //            txt_search.Text = String.Empty;
    //            txt_searchmap.Text = String.Empty;
    //            //split the mapped and unmapped Investigation using LINQ
    //            var temp = from s in objMap
    //                       where s.IsMapped == "Y"
    //                       orderby s.InvestigationName 
    //                       select s;

    //            var tempmap = from map in objMap
    //                          where map.IsMapped == "N"
    //                          orderby map.InvestigationName 
    //                          select map;         

    //            chkGrpMap.DataSource = temp;
    //            chkGrpMap.DataValueField = "InvestigationID";
    //            chkGrpMap.DataTextField = "InvestigationName";
    //            chkGrpMap.DataBind();

    //            chklstGrp.DataSource = tempmap;
    //            chklstGrp.DataValueField = "InvestigationID";
    //            chklstGrp.DataTextField = "InvestigationName";
    //            chklstGrp.DataBind();
    //        }                
    //                            }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while Load Investigation", ex);
    //    }
    //}
    public void loaddeptHeader(DropDownList ddlBoxU, DropDownList ddlBox, long Dept, long Head)
    {
        try
        {
            long Returncode = -1;
            if ((ObjInvDep.Count == 0) && (objHeader.Count==0))
            {
                Returncode = ObjInv.getOrgDepartHeadName(OrgID, out ObjInvDep, out objHeader);
            }
            ddlBoxU.DataSource = ObjInvDep;
            ddlBoxU.DataTextField = "DeptName";
            ddlBoxU.DataValueField = "DeptID";
            ddlBoxU.DataBind();
            ddlBoxU.Items.Insert(0, StrDispSel);
            ddlBoxU.Items[0].Value = "0";
            ddlBoxU.SelectedValue = Dept.ToString();

            ddlBox.DataSource = objHeader;
            ddlBox.DataTextField = "HeaderName";
            ddlBox.DataValueField = "HeaderID";
            ddlBox.DataBind();
            ddlBox.Items.Insert(0, StrDispSel);
            ddlBox.Items[0].Value = "0";
            ddlBox.SelectedValue = Head.ToString();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Loading Department and Header",ex);
        }
    }
    public void loadInvestigationgrid()
    {
        try
        {
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);          
            List<InvDeptMaster> ObjInvDep = new List<InvDeptMaster>();
             List<InvestigationHeader> objHeader = new List<InvestigationHeader>();
            long Returncode = -1;            
            Returncode = ObjInv.GetInvForMDMAddInv(OrgID, "MAP", out objLoadInvMap);            
            Session["map"] = new List<InvestigationOrgMapping>();
            Session["map"] = objLoadInvMap;
            var map = from s in objLoadInvMap
                      where s.DeptID == 0
                      select s;
            IOMSelect = map.ToList();
            if (map.Count() > 0)
            {
                grdResult.DataSource = map.ToList();
                grdResult.DataBind();
                show.Checked = false;
            }
            else
            {
                grdResult.DataSource = objLoadInvMap;
                grdResult.DataBind();
                show.Checked = true;
            }            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Loading data in Mapping Grid", ex);
        }
    }
    //protected void btnInvAdd_Click(object sender, EventArgs e)
    //{
    //    try
    //    {            
    //        List<InvestigationOrgMapping> lstIOM = new List<InvestigationOrgMapping>();
    //        Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
    //        long returnCode = -1;
    //        //Get the Selected Item in checkboxlist using LINQ.
    //        IEnumerable<ListItem> allChecked = (from ListItem item in chklstGrp.Items
    //                                       where item.Selected
    //                                       select item);            

    //        foreach (ListItem item in allChecked)
    //        {
    //            InvestigationOrgMapping objmap = new InvestigationOrgMapping();
    //            objmap.InvestigationID = Int64.Parse(item.Value);
    //            objmap.InvestigationName = item.Text;
    //            objmap.OrgID = OrgID;
    //            lstIOM.Add(objmap);
    //        }
    //        if (lstIOM.Count > 0)
    //        {
    //            returnCode = ObjInv.SaveInvestigationName(lstIOM);
    //            ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:alert('Changes saved successfully.');", true);
    //            fill();
    //        //loadInvestigationgrid();
    //        }                 

    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error Occured in Add Investigation", ex);
    //    }
    //}

    //protected void btnInvRemove_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        List<InvestigationOrgMapping> lstIOM = new List<InvestigationOrgMapping>();
    //        Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
    //        long returnCode = -1;
    //        string inv;
    //        //InvestigationOrgMapping objmap = new InvestigationOrgMapping();
    //        //Get the Selected Item in checkboxlist using LINQ.
    //        IEnumerable<ListItem> allChecked = (from item in chkGrpMap.Items.Cast<ListItem>()
    //                                            where item.Selected
    //                                            select item);

    //        foreach (ListItem item in allChecked)
    //        {
    //            InvestigationOrgMapping objmap = new InvestigationOrgMapping();
    //            objmap.InvestigationID = Int64.Parse(item.Value);
    //            objmap.InvestigationName = item.Text;
    //            objmap.OrgID = OrgID;
    //            lstIOM.Add(objmap);
    //        }
    //        if (lstIOM.Count > 0)
    //        {
    //            returnCode = ObjInv.DeleteInvestigationName(lstIOM,out inv);
    //            ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('Removed Successfully "+inv+" The other investigations are ordered, hence they cannot be removed.  ');", true);
    //            fill();
    //        }       
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error Occured in Remove Investigation", ex);
    //    }
    //}

    //protected void btnmassearch_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        string srch=txt_search.Text.Trim();          
            
    //     // using LINQ search the investigation
    //        objSearch = (List<InvestigationMaster>)Session["search"];
    //        var search = from find in objSearch
    //                         where find.IsMapped=="N" &&
    //                         find.InvestigationName.Contains(srch.ToUpper())
    //                         orderby find.InvestigationName.ToUpper()               
    //                     select find;

    //        if (search.Count() > 0)
    //        {
    //            chklstGrp.DataSource = search;
    //            chklstGrp.DataValueField = "InvestigationID";
    //            chklstGrp.DataTextField = "InvestigationName";
    //            chklstGrp.DataBind();
    //        }
    //        else
    //        {
    //            ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found');", true);

    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error occured in Master Investigation Search", ex);
    //    }
    //}
    //protected void btnmapsearch_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        string srch = txt_searchmap.Text.Trim();            
    //        // using LINQ search the investigation
    //        objSearch = (List<InvestigationMaster>)Session["search"];
    //        var search = from find in objSearch
    //                     where find.IsMapped == "Y" &&
    //                     find.InvestigationName.Contains(srch.ToUpper())
    //                     orderby find.InvestigationName.ToUpper()
    //                     select find;

    //        if (search.Count() > 0)
    //        {
    //            chkGrpMap.DataSource = search;
    //            chkGrpMap.DataValueField = "InvestigationID";
    //            chkGrpMap.DataTextField = "InvestigationName";
    //            chkGrpMap.DataBind();
    //        }
    //        else
    //        {
    //            ScriptManager.RegisterStartupScript(Page, this.GetType(), "hide", "javascript:alert('No Matching Records found');", true);
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error occured in Mapped Investigation Search", ex);
    //    }
    //}
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                InvestigationOrgMapping inv = new InvestigationOrgMapping();
                e.Row.Cells[0].Text = Convert.ToString((e.Row.RowIndex + 1) + (grdResult.PageIndex * grdResult.PageCount));
                inv = (InvestigationOrgMapping)e.Row.DataItem;
                HiddenField hdn = (HiddenField)e.Row.FindControl("lblInvestigationId");
                DropDownList ddldept = (DropDownList)e.Row.FindControl("ddlDept");
                DropDownList ddlhead = (DropDownList)e.Row.FindControl("ddlHeader");
                CheckBox chk = (CheckBox)e.Row.FindControl("chkselect");
                ddldept.Attributes.Add("OnChange", "select('" + chk.ClientID + "')");
                ddlhead.Attributes.Add("OnChange", "select('" + chk.ClientID + "')");
                HdnDeptvalid.Value += ddldept.ClientID + "~" + ddlhead.ClientID + "~" + hdn.ClientID + "~" + chk.ClientID + "^";  
                loaddeptHeader(ddldept, ddlhead, inv.DeptID, inv.HeaderID);                          
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }
    }
    protected void show_CheckedChanged(object sender, EventArgs e)
    {
        try
        {            
            List<InvestigationOrgMapping> invorg = new List<InvestigationOrgMapping>();
            List<InvestigationOrgMapping> invmaporg = new List<InvestigationOrgMapping>();
            invorg = (List<InvestigationOrgMapping>) Session["map"];
            var select = from s in invorg
                         where s.DeptID == 0
                         select s;
            invmaporg = select.ToList();
            if (show.Checked == true)
            {
                grdResult.DataSource = invorg;
                grdResult.DataBind();
            }
            else
            {
                grdResult.DataSource = invmaporg;
                grdResult.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in checkbox in mapping", ex);
        }
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grdResult.PageIndex = e.NewPageIndex;           
            List<InvestigationOrgMapping> invorg = new List<InvestigationOrgMapping>();            
            invorg = (List<InvestigationOrgMapping>)Session["map"];
            if (invorg.Count() > 0)
            {
                grdResult.DataSource = invorg;
                grdResult.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }
    }
    protected void btninves_Click(object sender, EventArgs e)
    {
        try
        {
            string srch = txtinvestigation.Text.Trim(); 
            List<InvestigationOrgMapping> invorg = new List<InvestigationOrgMapping>();
            List<InvestigationOrgMapping> invresultorg = new List<InvestigationOrgMapping>();
            invorg = (List<InvestigationOrgMapping>)Session["map"];
            var search = from find in invorg
                         where 
                         find.InvestigationName.StartsWith(srch.ToUpper())
                         orderby find.InvestigationName.ToUpper()
                         select find;
            invresultorg = search.ToList();
            if (invresultorg.Count() > 0)
            {
                grdResult.DataSource = invresultorg;
                grdResult.DataBind();
            }
            else
            {
                grdResult.DataSource = null;
                grdResult.DataBind();
            }
           
            txtinvestigation.Text = String.Empty;
            show.Checked = true;

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured while search mapped Investigation in Mapping Department and Header", ex);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            List<InvestigationOrgMapping> objMap = new List<InvestigationOrgMapping>();
            long returnCode = -1;
            foreach (string str in HdnUpdateDept.Value.Split('^'))
            {
                if (str != "")
                {
                    InvestigationOrgMapping objGpMas = new InvestigationOrgMapping();
                    string[] list = str.Split('~');
                    objGpMas.InvestigationID = Int64.Parse(list[0]);
                    objGpMas.DeptID = Int16.Parse(list[1]);
                    objGpMas.HeaderID = Int64.Parse(list[2]);
                    objGpMas.OrgID = OrgID;
                    objMap.Add(objGpMas);
                }
            }
            if (objMap.Count > 0)
            {
                returnCode = ObjInv.SaveInvestigationName(objMap);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:alert('"+Update_Msg+"');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:alert('Changes saved successfully.');", true);
                HdnUpdateDept.Value = String.Empty;
                loadInvestigationgrid();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured while saving Investigation in Mapping Dept. and Header", ex);
        }
    }

    protected void TabContainer1_ActiveTabChanged(object sender, EventArgs e)
    {
        try
        {

            //if (TabContainer1.ActiveTabIndex == 1)
            //{
            //    loadInvestigationgrid();
            //}
            if (TabContainer1.ActiveTabIndex == 1)
            {
                HdnCount.Value = "0";
                loaddropdown();
                gvReckon.DataSource = null;
                gvReckon.DataBind();
            }
            if (TabContainer1.ActiveTabIndex == 0)
            {
                ManageInvestigation.fill();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in changed tab container", ex);
        }
    }
}


