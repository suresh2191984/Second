using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Text;
using System.Data;
using System.Web.UI.HtmlControls;
using System.IO;
using AjaxControlToolkit;

public partial class CommonControls_SequenceArrangement : BaseControl
{
    public CommonControls_SequenceArrangement()
        : base("CommonControls_SequenceArrangement_ascx")
    {
    }
    string Select = Resources.CommonControls_ClientDisplay.CommonControls_SequenceArrangement_ascx_05 == null ? "---Select---" : Resources.CommonControls_ClientDisplay.CommonControls_SequenceArrangement_ascx_05;
    List<InvDeptMaster> lstDpt = new List<InvDeptMaster>();
    List<InvestigationOrgMapping> lstInvOrg = new List<InvestigationOrgMapping>();
    List<InvestigationOrgMapping> IOMAll = new List<InvestigationOrgMapping>();
    List<InvestigationOrgMapping> IOMSelect = new List<InvestigationOrgMapping>();
    List<InvestigationMaster> objMap = new List<InvestigationMaster>();
    List<InvestigationOrgMapping> objLoadInvMap = new List<InvestigationOrgMapping>();
    Investigation_BL ObjInv;
    PatientVisit_BL ObjPatVisit;
    List<InvGroupMaster> lstgrp = new List<InvGroupMaster>();
    List<InvGroupMaster> objGrpMap = new List<InvGroupMaster>();
    List<OrderedInvestigations> objInvGrp = new List<OrderedInvestigations>();
    List<OrderedInvestigations> objInvPkg = new List<OrderedInvestigations>();
    List<InvOrgGroup> lstGrp = new List<InvOrgGroup>();
    List<InvOrgGroup> lstPkg = new List<InvOrgGroup>();
    List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
    List<InvDeptMaster> lstDeptMaster = new List<InvDeptMaster>();
    List<InvestigationHeader> lstManageHeader = new List<InvestigationHeader>();
    long returnCode = 0;
    string groupname;
    string Pkgname;
    int GroupID;
    int PkgID;
    int DeptID;
    string DtCode;
    string DeptName;
    string UserHeaderText = Resources.CommonControls_AppMsg.CommonControls_SequenceArrangement_ascx_0034 == null ? "Alert" : Resources.CommonControls_AppMsg.CommonControls_SequenceArrangement_ascx_0034;
    string alertdisplay = Resources.CommonControls_AppMsg.CommonControls_SequenceArrangement_ascx_0035 == null ? "Changes saved successfully." : Resources.CommonControls_AppMsg.CommonControls_SequenceArrangement_ascx_0035;
    string dep = Resources.CommonControls_AppMsg.CommonControls_SequenceArrangement_ascx_0037 == null ? "Select the department" : Resources.CommonControls_AppMsg.CommonControls_SequenceArrangement_ascx_0037;
    string up= Resources.CommonControls_AppMsg.CommonControls_SequenceArrangement_ascx_0038 == null ? "Content Moved UP !!" : Resources.CommonControls_AppMsg.CommonControls_SequenceArrangement_ascx_0038;
    string down = Resources.CommonControls_AppMsg.CommonControls_SequenceArrangement_ascx_0039 == null ? "Content Moved down !!" : Resources.CommonControls_AppMsg.CommonControls_SequenceArrangement_ascx_0038;
    string content = Resources.CommonControls_AppMsg.CommonControls_SequenceArrangement_ascx_0040 == null ? "Content Moved UP !!" : Resources.CommonControls_AppMsg.CommonControls_SequenceArrangement_ascx_0039;
    protected void Page_Load(object sender, EventArgs e)
    {
        ObjInv = new Investigation_BL(base.ContextInfo);
        ObjPatVisit = new PatientVisit_BL(base.ContextInfo);

        try
        {
            if (!IsPostBack)
            {
                returnCode = ObjInv.pGetGrpData(OrgID, GroupID, out lstGrp);
                returnCode = ObjInv.pGetSequencepkg(OrgID, PkgID, out lstPkg);
                if (lstGrp.Count > 0)
                {
                    ddldptname.DataSource = lstGrp;
                    ddldptname.DataTextField = "DisplayText";
                    ddldptname.DataValueField = "OrgGroupID";
                    ddldptname.DataBind();
                    ddldptname.Items.Insert(0, Select);
                }
                if (lstPkg.Count > 0)
                {
                    ddlpkgname.DataSource = lstPkg;
                    ddlpkgname.DataTextField = "DisplayText";
                    ddlpkgname.DataValueField = "OrgGroupID";
                    ddlpkgname.DataBind();
                    ddlpkgname.Items.Insert(0, Select);
                }
                else
                {
                    ddlpkgname.Items.Insert(0, Select);
                }

                returnCode = ObjInv.GetDeptSequence(OrgID, out lstDpt);
                loaddeptseq();
                loadDepartments();
                loaddepartmentname();
                LoadRole();
                tprint.Attributes.Add("Style", "Display:none");
                HdnLoad.Value = String.Empty;
                LoadManageHeader();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Page Load", ex);
        }
    }
	public void LoadManageHeader()
    {
        ObjInv = new Investigation_BL(base.ContextInfo);
        try
        {
            returnCode = ObjInv.GetDepartmentHeaders(out lstManageHeader);
            if (lstManageHeader.Count > 0)
            {
              //  gvManageHeader.DataSource = lstManageHeader;
               // gvManageHeader.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in load DepartmentsHeader", ex);
        }
    }
    public void loadDepartments()
    {
        ObjPatVisit = new PatientVisit_BL(base.ContextInfo);
        try
        {
            returnCode = ObjPatVisit.GetDepartment(OrgID, LID, 0, out lstInvDeptMaster, out lstDeptMaster);
           // ddlDeptName.DataSource = lstDeptMaster;
           // ddlDeptName.DataTextField = "DeptName";
           // ddlDeptName.DataValueField = "RoleID";
           //// ddlDeptName.DataBind();
           // ddlDeptName.Items.Insert(0, Select);
           // ddlDeptName.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in load Departments", ex);
        }
    }
    protected void loaddata(List<OrderedInvestigations> lstmap,string Type)
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
                DataColumn dbCol6 = new DataColumn("Type");
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
                DataColumn dbCol24 = new DataColumn("PrintSeparately");


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
                dt.Columns.Add(dbCol24);

                foreach (OrderedInvestigations org in lstmap)
                {

                    DataRow dr = dt.NewRow();
                    dr["InvestigationID"] = org.InvestigationID;
                    dr["OrgID"] = OrgID;
                    dr["DeptID"] = "";
                    dr["HeaderID"] = "";
                    dr["InvestigationName"] = org.InvestigationName;
                    dr["Type"] = org.Type;
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
                    dr["ReferenceRangeString"] = "";
                    dr["PrintSeparately"] = org.PrintSeparately;

                    dt.Rows.Add(dr);

                }
                if (Type == "GRP")
                {
                    ViewState["Reckon"] = dt;
                }
                else if (Type == "PKG")
                {
                    ViewState["ReckonPkg"] = dt;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Sequence Investigation", ex);
        }
    }

    protected void loaddept(List<InvDeptMaster> lstdeptseq)
    {
        try
        {
            if (lstdeptseq.Count > 0)
            {
                System.Data.DataTable dtt = new DataTable();
                DataColumn dbCol1 = new DataColumn("DeptID");
                DataColumn dbCol2 = new DataColumn("DeptName");
                DataColumn dbCol3 = new DataColumn("OrgId");
                DataColumn dbCol4 = new DataColumn("Display");
                DataColumn dbCol5 = new DataColumn("SequenceNO");
                DataColumn dbCol6 = new DataColumn("Code");

                dtt.Columns.Add(dbCol1);
                dtt.Columns.Add(dbCol2);
                dtt.Columns.Add(dbCol3);
                dtt.Columns.Add(dbCol4);
                dtt.Columns.Add(dbCol5);
                dtt.Columns.Add(dbCol6);

                foreach (InvDeptMaster org in lstdeptseq)
                {
                    DataRow dr = dtt.NewRow();
                    dr["DeptID"] = org.DeptID;
                    dr["DeptName"] = org.DeptName;
                    dr["OrgId"] = org.OrgID;
                    dr["Display"] = org.Display;
                    dr["SequenceNO"] = org.SequenceNo;
                    dr["Code"] = org.Code;
                    dtt.Rows.Add(dr);

                }
                ViewState["Reckonn"] = dtt;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Sequence Investigation", ex);
        }
    }


    protected void ddldptname_SelectedIndexChanged(object sender, EventArgs e)
    {
        ObjInv = new Investigation_BL(base.ContextInfo);
        try
        {
            if (ddldptname.SelectedIndex > 0)
            {
                returnCode = ObjInv.pGetInvANDGroup(OrgID, int.Parse(ddldptname.SelectedValue), out objInvGrp, out groupname);
                if (objInvGrp.Count > 0)
                {
                    //gvReckon.DataSource = objInvGrp;
                    //gvReckon.DataBind();
                    loaddata(objInvGrp,"GRP");
                    if (ViewState["Reckon"] != null)
                    {
                        DataTable dt = (DataTable)ViewState["Reckon"];
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            gvReckon.DataSource = dt;
                            gvReckon.DataBind();
                        }
                        gv.Attributes.Add("style", "display:block");
                        tprint.Attributes.Add("style", "display:block");
                    }
                }
                else
                {
                    gvReckon.DataSource = null;
                    gvReckon.DataBind();
                }
            }
            else
            {
                gvReckon.DataSource = null;
                gvReckon.DataBind();
                tprint.Attributes.Add("style", "display:none");
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + dep + "','" + UserHeaderText + "');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "m", "alert('Select the department');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Sequence Investigation", ex);
        }
    }


    protected void ddlpkgname_SelectedIndexChanged(object sender, EventArgs e)
    {
        ObjInv = new Investigation_BL(base.ContextInfo);
        try
        {
            if (ddlpkgname.SelectedIndex > 0)
            {
                returnCode = ObjInv.pGetPKG(OrgID, int.Parse(ddlpkgname.SelectedValue), out objInvPkg, out Pkgname);
                if (objInvPkg.Count > 0)
                {
                    //gvReckon.DataSource = objInvGrp;
                    //gvReckon.DataBind();
                    loaddata(objInvPkg, "PKG");
                    if (ViewState["ReckonPkg"] != null)
                    {
                        DataTable dt1 = (DataTable)ViewState["ReckonPkg"];
                        if (dt1 != null && dt1.Rows.Count > 0)
                        {
                            gvReckonPkg.DataSource = dt1;
                            gvReckonPkg.DataBind();
                        }
                        gv1.Attributes.Add("style", "display:block");
                        tprint.Attributes.Add("style", "display:block");
                    }
                }
                else
                {
                    gvReckonPkg.DataSource = null;
                    gvReckonPkg.DataBind();
                }
            }
            else
            {
                gvReckonPkg.DataSource = null;
                gvReckonPkg.DataBind();
                tprint.Attributes.Add("style", "display:none");
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + dep + "','" + UserHeaderText + "');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "m", "alert('Select the department');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Package Sequence", ex);
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
            Investigation_BL objInv = new Investigation_BL(base.ContextInfo);
            DataTable dt = (DataTable)ViewState["Reckon"];
            returnCode = objInv.pUpdateInvANDGrpSequence(dt, OrgID, int.Parse(ddldptname.SelectedValue));
            if (returnCode == 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + alertdisplay + "','" + UserHeaderText + "');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "m", "alert('Changes saved successfully.');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Saving Sequence Investigation", ex);
        }
    }

    protected void btnpkgSequenceSave_Click(object sender, EventArgs e)
    {
        try
        {
            Investigation_BL objInv = new Investigation_BL(base.ContextInfo);
            DataTable dt1 = (DataTable)ViewState["ReckonPkg"];
            returnCode = objInv.pUpdatePkgSequence(dt1, OrgID, int.Parse(ddlpkgname.SelectedValue));
            if (returnCode == 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + alertdisplay + "','" + UserHeaderText + "');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "m", "alert('Changes saved successfully.');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Saving package Sequence ", ex);
        }
    }


    //protected void saveDept_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        Investigation_BL objInv = new Investigation_BL(base.ContextInfo);
    //        DataTable dtt = (DataTable)ViewState["Reckonn"];
    //        returnCode = objInv.pUpdateDeptSequenceNo(dtt, OrgID);
    //        if (returnCode == 0)
    //        {
    //            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + alertdisplay + "','" + UserHeaderText + "');", true);
    //            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "m", "alert('Changes saved successfully.');", true);
    //            //txtDeptadd.Text =  string.Empty;
    //            //txtCode.Text =  string.Empty;
           
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error occured in Saving Sequence", ex);
    //    }
    //}
    protected void Gvbound(object se, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView obj = (DataRowView)e.Row.DataItem;
                CheckBox chkPrintSeparately = (CheckBox)e.Row.FindControl("chkPrintSeparately");
                if (chkPrintSeparately != null)
                {

                    chkPrintSeparately.Checked = obj["PrintSeparately"] != null ? Convert.ToString(obj["PrintSeparately"]) == "Y" ? true : false : false;
                }
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
    protected void Divbound(object se, GridViewRowEventArgs e)
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

    //protected void GrdDept_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    try
    //    {
    //        DataTable dtt = (DataTable)ViewState["Reckonn"];
    //        int selRow = Convert.ToInt32(e.CommandArgument);
    //        int swapRow = 0;
    //        int rowindex = 0;
    //        int count = GrdDept.Rows.Count;
    //        if (dtt != null && dtt.Rows.Count > 0)
    //        {
    //            if (e.CommandName == "UP")
    //            {
    //                if (selRow > 0)
    //                {
    //                    swapRow = selRow - 1;
    //                    string strTempDtlID = dtt.Rows[selRow]["DeptID"].ToString();
    //                    string strTempValue = dtt.Rows[selRow]["DeptName"].ToString();
    //                    string strTempCode= dtt.Rows[selRow]["Code"].ToString().ToUpper();
    //                    dtt.Rows[selRow]["DeptID"] = dtt.Rows[swapRow]["DeptID"];
    //                    dtt.Rows[selRow]["DeptName"] = dtt.Rows[swapRow]["DeptName"];
    //                    dtt.Rows[selRow]["Code"] = dtt.Rows[swapRow]["Code"];
    //                    dtt.Rows[swapRow]["DeptName"] = strTempValue;
    //                    dtt.Rows[swapRow]["DeptID"] = strTempDtlID;
    //                    dtt.Rows[swapRow]["Code"] = strTempCode;
    //                    GrdDept.DataSource = dtt;
    //                    GrdDept.DataBind();
    //                }
    //                if (selRow > 0)
    //                {
    //                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + up + "','" + UserHeaderText + "');", true);
    //                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "dd", "alert('Content Moved UP !!');", true);
    //                }
    //            }
    //            else if (e.CommandName == "DOWN")
    //            {
    //                if (selRow < dtt.Rows.Count - 1)
    //                {
    //                    swapRow = selRow + 1;
    //                    string strTempDtlID = dtt.Rows[selRow]["DeptID"].ToString();
    //                    string strTempValue = dtt.Rows[selRow]["DeptName"].ToString();
    //                    string strTempCode = dtt.Rows[selRow]["Code"].ToString().ToUpper();
    //                    dtt.Rows[selRow]["DeptID"] = dtt.Rows[swapRow]["DeptID"];
    //                    dtt.Rows[selRow]["DeptName"] = dtt.Rows[swapRow]["DeptName"];
    //                    dtt.Rows[selRow]["Code"] = dtt.Rows[swapRow]["Code"];
    //                    dtt.Rows[swapRow]["DeptName"] = strTempValue;
    //                    dtt.Rows[swapRow]["DeptID"] = strTempDtlID;
    //                    dtt.Rows[swapRow]["Code"] = strTempCode;
    //                    GrdDept.DataSource = dtt;
    //                    GrdDept.DataBind();
    //                }
    //                if (selRow < dtt.Rows.Count - 1)
    //                {
    //                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + down + "','" + UserHeaderText + "');", true);
    //                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "dd", "alert('Content Moved DOWN !!');", true);
    //                }
    //            }
    //            if (e.CommandName == "Move")
    //            {
    //                foreach (GridViewRow GR in GrdDept.Rows)
    //                {
    //                    RadioButton rdb = (RadioButton)GR.FindControl("rdbcheck");
    //                    if (rdb.Checked)
    //                    {
    //                        rowindex = GR.RowIndex;
    //                        if (rowindex > selRow)
    //                        {
    //                            for (int i = rowindex; i > selRow; i--)
    //                            {
    //                                string strTempDtlID = dtt.Rows[i]["DeptID"].ToString();
    //                                string strTempValue = dtt.Rows[i]["DeptName"].ToString();
    //                                string strTempCode = dtt.Rows[i]["Code"].ToString().ToUpper();
    //                                dtt.Rows[i]["DeptID"] = dtt.Rows[i - 1]["DeptID"];
    //                                dtt.Rows[i]["DeptName"] = dtt.Rows[i - 1]["DeptName"];
    //                                dtt.Rows[i]["Code"] = dtt.Rows[i - 1]["Code"];
    //                                dtt.Rows[i - 1]["DeptID"] = strTempDtlID;
    //                                dtt.Rows[i - 1]["DeptName"] = strTempValue;
    //                                dtt.Rows[i - 1]["Code"] = strTempCode;
    //                            }
    //                        }
    //                        else if (rowindex < selRow)
    //                        {
    //                            for (int i = rowindex; i < selRow; i++)
    //                            {
    //                                string strTempDtlID = dtt.Rows[i]["DeptID"].ToString();
    //                                string strTempValue = dtt.Rows[i]["DeptName"].ToString();
    //                                string strTempCode = dtt.Rows[i]["Code"].ToString().ToUpper();
    //                                dtt.Rows[i]["DeptID"] = dtt.Rows[i + 1]["DeptID"];
    //                                dtt.Rows[i]["DeptName"] = dtt.Rows[i + 1]["DeptName"];
    //                                dtt.Rows[i]["Code"] = dtt.Rows[i + 1]["Code"];
    //                                dtt.Rows[i + 1]["DeptID"] = strTempDtlID;
    //                                dtt.Rows[i + 1]["DeptName"] = strTempValue;
    //                                dtt.Rows[i + 1]["Code"] = strTempCode;
    //                            }
    //                        }
    //                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + content + "','" + UserHeaderText + "');", true);
    //                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "dd", "alert('Content Moved !!');", true);
    //                        //GrdDept.DataSource = dtt;
    //                        //GrdDept.DataBind();
    //                    }

    //                }
    //            }
    //        }
    //        ViewState["Reckonn"] = dtt;
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error occured in Sequence Investigation", ex);
    //    }
    //}

    protected void loaddeptseq()
    {
        if (lstDpt.Count > 0)
        {
            //GrdDept.DataSource = lstDpt;
            //GrdDept.DataBind();
            loaddept(lstDpt);
        }
    }
    protected void ChkPrintSeparately_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            CheckBox chkPrintSeparately = (CheckBox)sender;
            GridViewRow gr = (GridViewRow)chkPrintSeparately.Parent.Parent;
            Int32 selRow = gr.RowIndex;
            DataTable dt = (DataTable)ViewState["Reckon"];
            if (dt != null && dt.Rows.Count > 0)
            {
                if (chkPrintSeparately != null)
                {
                    string printSeparately = "N";
                    printSeparately = chkPrintSeparately.Checked ? "Y" : "N";

                    dt.Rows[selRow]["PrintSeparately"] = printSeparately;
                    gvReckon.DataSource = dt;
                    gvReckon.DataBind();
                }
            }
            ViewState["Reckon"] = dt;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in changing print separately", ex);
        }
    }


    protected void ChkPrintSeparatelypackage(object sender, EventArgs e)
    {
        try
        {
            CheckBox chkPrintSeparately = (CheckBox)sender;
            GridViewRow gr = (GridViewRow)chkPrintSeparately.Parent.Parent;
            Int32 selRow = gr.RowIndex;
            DataTable dt1 = (DataTable)ViewState["ReckonPkg"];
            if (dt1 != null && dt1.Rows.Count > 0)
            {
                if (chkPrintSeparately != null)
                {
                    string printSeparately = "N";
                    printSeparately = chkPrintSeparately.Checked ? "Y" : "N";

                    dt1.Rows[selRow]["PrintSeparately"] = printSeparately;
                    gvReckonPkg.DataSource = dt1;
                    gvReckonPkg.DataBind();
                }
            }
            ViewState["ReckonPkg"] = dt1;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in changing print separately for package", ex);
        }
    }
  


    protected void gvReckon_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            DataTable dt = (DataTable)ViewState["Reckon"];
            int selRow = Convert.ToInt32(e.CommandArgument);
            int swapRow = 0;
            int rowindex = 0;
            int count = gvReckon.Rows.Count;
            if (dt != null && dt.Rows.Count > 0)
            {
                if (e.CommandName == "UP")
                {
                    if (selRow > 0)
                    {
                        swapRow = selRow - 1;
                        string strTempDtlID = dt.Rows[selRow]["InvestigationID"].ToString();
                        string strTempValue = dt.Rows[selRow]["InvestigationName"].ToString();
                        string strTemptype = dt.Rows[selRow]["Type"].ToString();
                        string strPrintSeparately = dt.Rows[selRow]["PrintSeparately"].ToString();
                        dt.Rows[selRow]["InvestigationID"] = dt.Rows[swapRow]["InvestigationID"];
                        dt.Rows[selRow]["InvestigationName"] = dt.Rows[swapRow]["InvestigationName"];
                        dt.Rows[selRow]["Type"] = dt.Rows[swapRow]["Type"];
                        dt.Rows[selRow]["PrintSeparately"] = dt.Rows[swapRow]["PrintSeparately"];
                        dt.Rows[swapRow]["InvestigationName"] = strTempValue;
                        dt.Rows[swapRow]["InvestigationID"] = strTempDtlID;
                        dt.Rows[swapRow]["Type"] = strTemptype;
                        dt.Rows[swapRow]["PrintSeparately"] = strPrintSeparately;
                        gvReckon.DataSource = dt;
                        gvReckon.DataBind();
                    }
                    if (selRow > 0)
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + up + "','" + UserHeaderText + "');", true);
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "dd", "alert('Content Moved UP !!');", true);
                    }
                }
                else if (e.CommandName == "DOWN")
                {
                    if (selRow < dt.Rows.Count - 1)
                    {
                        swapRow = selRow + 1;
                        string strTempDtlID = dt.Rows[selRow]["InvestigationID"].ToString();
                        string strTempValue = dt.Rows[selRow]["InvestigationName"].ToString();
                        string strTemptype = dt.Rows[selRow]["Type"].ToString();
                        string strPrintSeparately = dt.Rows[selRow]["PrintSeparately"].ToString();
                        dt.Rows[selRow]["InvestigationID"] = dt.Rows[swapRow]["InvestigationID"];
                        dt.Rows[selRow]["InvestigationName"] = dt.Rows[swapRow]["InvestigationName"];
                        dt.Rows[selRow]["Type"] = dt.Rows[swapRow]["Type"];
                        dt.Rows[selRow]["PrintSeparately"] = dt.Rows[swapRow]["PrintSeparately"];
                        dt.Rows[swapRow]["InvestigationName"] = strTempValue;
                        dt.Rows[swapRow]["InvestigationID"] = strTempDtlID;
                        dt.Rows[swapRow]["Type"] = strTemptype;
                        dt.Rows[swapRow]["PrintSeparately"] = strPrintSeparately;
                        gvReckon.DataSource = dt;
                        gvReckon.DataBind();
                    }
                    if (selRow < dt.Rows.Count - 1)
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + down + "','" + UserHeaderText + "');", true);
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "dd", "alert('Content Moved DOWN !!');", true);
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
                                    string strTemptype = dt.Rows[selRow]["Type"].ToString();
                                    string strPrintSeparately = dt.Rows[selRow]["PrintSeparately"].ToString();
                                    dt.Rows[i]["InvestigationID"] = dt.Rows[i - 1]["InvestigationID"];
                                    dt.Rows[i]["InvestigationName"] = dt.Rows[i - 1]["InvestigationName"];
                                    dt.Rows[i]["Type"] = dt.Rows[i - 1]["Type"];
                                    dt.Rows[i]["PrintSeparately"] = dt.Rows[i - 1]["PrintSeparately"];
                                    dt.Rows[i - 1]["InvestigationID"] = strTempDtlID;
                                    dt.Rows[i - 1]["InvestigationName"] = strTempValue;
                                    dt.Rows[i - 1]["Type"] = strTemptype;
                                    dt.Rows[i - 1]["PrintSeparately"] = strPrintSeparately;
                                }
                                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + content + "','" + UserHeaderText + "');", true);
                                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "nn", "alert('Content moved !!');", true);
                            }
                            else if (rowindex < selRow)
                            {
                                for (int i = rowindex; i < selRow; i++)
                                {
                                    string strTempDtlID = dt.Rows[i]["InvestigationID"].ToString();
                                    string strTempValue = dt.Rows[i]["InvestigationName"].ToString();
                                    string strTemptype = dt.Rows[i]["Type"].ToString();
                                    string strPrintSeparately = dt.Rows[i]["PrintSeparately"].ToString();
                                    dt.Rows[i]["InvestigationID"] = dt.Rows[i + 1]["InvestigationID"];
                                    dt.Rows[i]["InvestigationName"] = dt.Rows[i + 1]["InvestigationName"];
                                    dt.Rows[i]["Type"] = dt.Rows[i + 1]["Type"];
                                    dt.Rows[i]["PrintSeparately"] = dt.Rows[i + 1]["PrintSeparately"];
                                    dt.Rows[i + 1]["InvestigationID"] = strTempDtlID;
                                    dt.Rows[i + 1]["InvestigationName"] = strTempValue;
                                    dt.Rows[i + 1]["Type"] = strTemptype;
                                    dt.Rows[i + 1]["PrintSeparately"] = strPrintSeparately;
                                }
                                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + content + "','" + UserHeaderText + "');", true);
                                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "nn", "alert('Content moved !!');", true);
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

    protected void gvReckonPkg_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            DataTable dt1 = (DataTable)ViewState["ReckonPkg"];
            int selRow = Convert.ToInt32(e.CommandArgument);
            int swapRow = 0;
            int rowindex = 0;
            int count = gvReckonPkg.Rows.Count;
            if (dt1 != null && dt1.Rows.Count > 0)
            {
                if (e.CommandName == "UP")
                {
                    if (selRow > 0)
                    {
                        swapRow = selRow - 1;
                        string strTempDtlID = dt1.Rows[selRow]["InvestigationID"].ToString();
                        string strTempValue = dt1.Rows[selRow]["InvestigationName"].ToString();
                        string strTemptype = dt1.Rows[selRow]["Type"].ToString();
                        string strPrintSeparately = dt1.Rows[selRow]["PrintSeparately"].ToString();
                        dt1.Rows[selRow]["InvestigationID"] = dt1.Rows[swapRow]["InvestigationID"];
                        dt1.Rows[selRow]["InvestigationName"] = dt1.Rows[swapRow]["InvestigationName"];
                        dt1.Rows[selRow]["Type"] = dt1.Rows[swapRow]["Type"];
                        dt1.Rows[selRow]["PrintSeparately"] = dt1.Rows[swapRow]["PrintSeparately"];
                        dt1.Rows[swapRow]["InvestigationName"] = strTempValue;
                        dt1.Rows[swapRow]["InvestigationID"] = strTempDtlID;
                        dt1.Rows[swapRow]["Type"] = strTemptype;
                        dt1.Rows[swapRow]["PrintSeparately"] = strPrintSeparately;
                        gvReckonPkg.DataSource = dt1;
                        gvReckonPkg.DataBind();
                    }
                    if (selRow > 0)
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + up + "','" + UserHeaderText + "');", true);
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "dd", "alert('Content Moved UP !!');", true);
                    }
                }
                else if (e.CommandName == "DOWN")
                {
                    if (selRow < dt1.Rows.Count - 1)
                    {
                        swapRow = selRow + 1;
                        string strTempDtlID = dt1.Rows[selRow]["InvestigationID"].ToString();
                        string strTempValue = dt1.Rows[selRow]["InvestigationName"].ToString();
                        string strTemptype = dt1.Rows[selRow]["Type"].ToString();
                        string strPrintSeparately = dt1.Rows[selRow]["PrintSeparately"].ToString();
                        dt1.Rows[selRow]["InvestigationID"] = dt1.Rows[swapRow]["InvestigationID"];
                        dt1.Rows[selRow]["InvestigationName"] = dt1.Rows[swapRow]["InvestigationName"];
                        dt1.Rows[selRow]["Type"] = dt1.Rows[swapRow]["Type"];
                        dt1.Rows[selRow]["PrintSeparately"] = dt1.Rows[swapRow]["PrintSeparately"];
                        dt1.Rows[swapRow]["InvestigationName"] = strTempValue;
                        dt1.Rows[swapRow]["InvestigationID"] = strTempDtlID;
                        dt1.Rows[swapRow]["Type"] = strTemptype;
                        dt1.Rows[swapRow]["PrintSeparately"] = strPrintSeparately;
                        gvReckonPkg.DataSource = dt1;
                        gvReckonPkg.DataBind();
                    }
                    if (selRow < dt1.Rows.Count - 1)
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + down + "','" + UserHeaderText + "');", true);
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "dd", "alert('Content Moved DOWN !!');", true);
                    }
                }
                if (e.CommandName == "Move")
                {
                    foreach (GridViewRow GR in gvReckonPkg.Rows)
                    {
                        RadioButton rdb = (RadioButton)GR.FindControl("rdbcheck");
                        if (rdb.Checked)
                        {
                            rowindex = GR.RowIndex;
                            if (rowindex > selRow)
                            {
                                for (int i = rowindex; i > selRow; i--)
                                {
                                    string strTempDtlID = dt1.Rows[i]["InvestigationID"].ToString();
                                    string strTempValue = dt1.Rows[i]["InvestigationName"].ToString();
                                    string strTemptype = dt1.Rows[selRow]["Type"].ToString();
                                    string strPrintSeparately = dt1.Rows[selRow]["PrintSeparately"].ToString();
                                    dt1.Rows[i]["InvestigationID"] = dt1.Rows[i - 1]["InvestigationID"];
                                    dt1.Rows[i]["InvestigationName"] = dt1.Rows[i - 1]["InvestigationName"];
                                    dt1.Rows[i]["Type"] = dt1.Rows[i - 1]["Type"];
                                    dt1.Rows[i]["PrintSeparately"] = dt1.Rows[i - 1]["PrintSeparately"];
                                    dt1.Rows[i - 1]["InvestigationID"] = strTempDtlID;
                                    dt1.Rows[i - 1]["InvestigationName"] = strTempValue;
                                    dt1.Rows[i - 1]["Type"] = strTemptype;
                                    dt1.Rows[i - 1]["PrintSeparately"] = strPrintSeparately;
                                }
                                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + content + "','" + UserHeaderText + "');", true);
                                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "nn", "alert('Content moved !!');", true);
                            }
                            else if (rowindex < selRow)
                            {
                                for (int i = rowindex; i < selRow; i++)
                                {
                                    string strTempDtlID = dt1.Rows[i]["InvestigationID"].ToString();
                                    string strTempValue = dt1.Rows[i]["InvestigationName"].ToString();
                                    string strTemptype = dt1.Rows[i]["Type"].ToString();
                                    string strPrintSeparately = dt1.Rows[i]["PrintSeparately"].ToString();
                                    dt1.Rows[i]["InvestigationID"] = dt1.Rows[i + 1]["InvestigationID"];
                                    dt1.Rows[i]["InvestigationName"] = dt1.Rows[i + 1]["InvestigationName"];
                                    dt1.Rows[i]["Type"] = dt1.Rows[i + 1]["Type"];
                                    dt1.Rows[i]["PrintSeparately"] = dt1.Rows[i + 1]["PrintSeparately"];
                                    dt1.Rows[i + 1]["InvestigationID"] = strTempDtlID;
                                    dt1.Rows[i + 1]["InvestigationName"] = strTempValue;
                                    dt1.Rows[i + 1]["Type"] = strTemptype;
                                    dt1.Rows[i + 1]["PrintSeparately"] = strPrintSeparately;
                                }
                                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + content + "','" + UserHeaderText + "');", true);
                                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "nn", "alert('Content moved !!');", true);
                            }
                            gvReckonPkg.DataSource = dt1;
                            gvReckonPkg.DataBind();
                        }
                    }
                }
            }
            ViewState["ReckonPkg"] = dt1;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Sequence Investigation", ex);
        }

    }



    //protected void btnDeptsave_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        long DeptCode = Convert.ToInt64(ddlDeptName.SelectedValue);
    //        string Code = txtCode.Text.Trim().ToUpper();
    //        string DeptName = ddlDeptName.SelectedValue == "0" ? txtDeptadd.Text.Trim() : ddlDeptName.SelectedItem.Text;
    //        Investigation_BL objInv = new Investigation_BL(base.ContextInfo);
    //        List<InvDeptMaster> lstDept = new List<InvDeptMaster>();

    //        returnCode = objInv.pInsertDeptName(OrgID, DeptName, DeptCode,Code, out lstDept);
    //        if (returnCode == 0)
    //        {
    //            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + alertdisplay + "','" + UserHeaderText + "');", true);
    //           // ScriptManager.RegisterStartupScript(Page, this.GetType(), "m", "alert('Changes saved successfully.');", true);
    //            ClearData();
    //            loadgrid();
    //            loadDepartments();
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error occured in Saving Sequence", ex);
    //    }
    //}
    protected void loadgrid()
    {
        ObjInv = new Investigation_BL(base.ContextInfo);
        returnCode = ObjInv.GetDeptSequence(OrgID, out lstDpt);
        //GrdDept.DataSource = lstDpt;
        //GrdDept.DataBind();
        loaddept(lstDpt);
    }
    protected void ClearData()
    {
        //txtDeptadd.Text = string.Empty;
        //txtCode.Text = string.Empty;
    }

    //protected void TabContainer1_ActiveTabChanged(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        if (TabContainer1.ActiveTabIndex == 1)
    //        {
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error occured in changed tab container", ex);
    //    }
    //}

    //protected void GrdDept_RowUpdating(object sender, GridViewUpdateEventArgs e)
    //{
    //    Investigation_BL objInv = new Investigation_BL(base.ContextInfo);
    //    DataTable dtt = (DataTable)ViewState["Reckonn"];
    //    Label DeptmentID = (Label)GrdDept.Rows[e.RowIndex].FindControl("DeptID");
    //    Label lbldept = (Label)GrdDept.Rows[e.RowIndex].FindControl("lbldept");
    //    TextBox Txtdept = (TextBox)GrdDept.Rows[e.RowIndex].FindControl("Txtdept");
    //    RadioButton chkActive =
    //      (RadioButton)GrdDept.Rows[e.RowIndex].FindControl("rdbcheck");
    //    TextBox TxtCode = (TextBox)GrdDept.Rows[e.RowIndex].FindControl("TxtCode");

    //    DeptName = Txtdept.Text;
    //    DeptID = Convert.ToInt16(DeptmentID.Text);
    //    DtCode = TxtCode.Text.Trim().ToUpper();
    //    returnCode = objInv.pUpdateDeptSequence(dtt, OrgID, DeptID, DeptName,DtCode);
    //    if (returnCode == 0)
    //    {
    //        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + alertdisplay + "','" + UserHeaderText + "');", true);
    //        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "m", "alert('Changes updated successfully.');",
    //           // true);
    //        GrdDept.EditIndex = -1;
    //        loadgrid();
    //    }
    //}
    //protected void GrdDept_RowEditing(object sender, GridViewEditEventArgs e)
    //{
    //    GrdDept.EditIndex = e.NewEditIndex;
    //    loadgrid();
    //}
    //protected void GrdDept_RowCancelingEdit(object sender,
    //                          GridViewCancelEditEventArgs e)
    //{
    //    GrdDept.EditIndex = -1;
    //    loadgrid();
    //}
    protected void gvReckon_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {

    }
    protected void loaddepartmentname()
    {
        try
        {
            List<InvDeptMaster> lstDpt = new List<InvDeptMaster>();
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            returnCode = ObjInv.GetDeptSequence(OrgID, out lstDpt);
            if (lstDpt.Count > 0)
            {
                //checkLst.DataSource = lstDpt;
                //checkLst.DataTextField = "DeptName";
                //checkLst.DataValueField = "DeptID";
                //checkLst.DataBind();
                checkAll(false);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in load Departments", ex);
        }
    }
    public void checkAll(Boolean chk)
    {
        //foreach (ListItem item in checkLst.Items)
        //{
        //    item.Selected = chk;
        //}
    }
    private void LoadRole()
    {
        try
        {
            Role_BL roleBL = new Role_BL(base.ContextInfo);
            List<Role> lstrole = new List<Role>();

            returnCode = roleBL.GetRoleName(OrgID, out lstrole);


            if (lstrole.Count > 0)
            {

                //ddlRole.DataSource = lstrole;
                //ddlRole.DataTextField = "RoleDescription";
                //ddlRole.DataValueField = "RoleID";
                //ddlRole.DataBind();
                //ddlRole.Items.Insert(0, Select);
                //ddlRole.Items[0].Value = "0";


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in load Role", ex);
        }
    }
    //protected void btnSave_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        long returnCode = -1;
    //        long RoleID = Convert.ToInt64(ddlRole.SelectedItem.Value);
    //        List<RoleDeptMap> lstRoleDeptMap = new List<RoleDeptMap>();

    //        foreach (ListItem item in checkLst.Items)
    //        {
    //            if (item.Selected)
    //            {
    //                RoleDeptMap objRoleDeptMap = new RoleDeptMap();
    //                objRoleDeptMap.DeptID = Convert.ToInt32(item.Value);
    //                objRoleDeptMap.RoleID = RoleID;
    //                lstRoleDeptMap.Add(objRoleDeptMap);
    //            }
    //        }
    //        Role_BL objRole_BL = new Role_BL(base.ContextInfo);
    //        returnCode = objRole_BL.InsertMapDetails(lstRoleDeptMap);
    //        if (returnCode > 0)
    //        {
    //            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + alertdisplay + "','" + UserHeaderText + "');", true);
    //            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "m", "alert('Changes updated successfully.');",
    //               //true);
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error occured in Saving Sequence Investigation", ex);
    //    }
          
    //}
    //protected void ddlRole_SelectedIndexChanged1(object sender, EventArgs e)
    //{
        
    //    chkCheckAll.Checked = false;
    //    checkAll(false);
    //    try
    //    { 
    //        long RoleID = Convert.ToInt64(ddlRole.SelectedItem.Value);
    //        List<RoleDeptMap> lstDeptID = new List<RoleDeptMap>();
    //        Role_BL objRole_BL = new Role_BL(base.ContextInfo);
    //        objRole_BL.GetDeptID(RoleID, out lstDeptID);
    //        foreach (var item in lstDeptID)
    //        {
    //            foreach (ListItem chkItem in checkLst.Items)
    //            {
    //                if (item.DeptID == Convert.ToInt32(chkItem.Value))
    //                {
    //                     chkItem.Selected = true;
                                             
    //                }
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error occured in Sequence Investigation", ex);
    //    }
       
                  
       
    //}
    //protected void gvManageHeader_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    try
    //    {
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error occured in Sequence Investigation", ex);
    //    }
    //}
    //protected void gvManageHeader_RowUpdating(object sender, GridViewUpdateEventArgs e)
    //{
    //    Investigation_BL objInv = new Investigation_BL(base.ContextInfo);
    //    Label DeptmentID = (Label)gvManageHeader.Rows[e.RowIndex].FindControl("lblDeptID");
    //    Label lbldept = (Label)gvManageHeader.Rows[e.RowIndex].FindControl("lbldeptName");
    //    TextBox Txtdept = (TextBox)gvManageHeader.Rows[e.RowIndex].FindControl("txtdeptName");
    //    CheckBox chkActive = (CheckBox)gvManageHeader.Rows[e.RowIndex].FindControl("chkIsActive");
        
    //    long HeaderID = Convert.ToInt16(DeptmentID.Text); ;
    //    string HeaderName = Txtdept.Text;
    //    bool IsActive;
    //    if(chkActive.Checked == true){
    //        IsActive = true;
    //    }
    //    else{
    //        IsActive = false;
    //    }

    //    returnCode = objInv.pUpdateManageHeader(HeaderID, HeaderName, IsActive);
    //    if (returnCode == 0)
    //    {
    //        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + alertdisplay + "','" + UserHeaderText + "');", true);
    //        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "m", "alert('Changes updated successfully.');",true);
    //        gvManageHeader.EditIndex = -1;
    //        LoadManageHeader();
    //    }
    //}
    //protected void gvManageHeader_RowEditing(object sender, GridViewEditEventArgs e)
    //{
    //    gvManageHeader.EditIndex = e.NewEditIndex;
    //    LoadManageHeader();
        
    //}
    //protected void gvManageHeader_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    //{
    //    gvManageHeader.EditIndex = -1;
    //    LoadManageHeader();
        
    //}
    //protected void btnAdd_Click(object sender, EventArgs e)
    //{
    //    Investigation_BL objInv = new Investigation_BL(base.ContextInfo);
    //    string HeaderName = txtHeaderName.Text;
    //    bool IsActive;
    //    if (chkIsActive.Checked == true)
    //    {
    //        IsActive = true;
    //    }
    //    else
    //    {
    //        IsActive = false;
    //    }

    //    returnCode = objInv.pSaveManageHeader(HeaderName, IsActive);
    //    if (returnCode == 0)
    //    {
    //        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + alertdisplay + "','" + UserHeaderText + "');", true);
    //        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "m", "alert('Changes Saved successfully.');", true);
    //        gvManageHeader.EditIndex = -1;
    //        txtHeaderName.Text = "";
    //        chkIsActive.Checked = false;
    //        LoadManageHeader();
    //    }
    //}
}
