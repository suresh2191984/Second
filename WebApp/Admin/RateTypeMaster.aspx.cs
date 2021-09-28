using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Collections;
using System.Web.Script.Serialization;
using System.Web.Services;


public partial class Admin_RateTypeMaster : BasePage
{
    long Returncode = -1;
    AdminReports_BL objBl;
    RateTypeMaster RTM = new RateTypeMaster();
    RateMaster objRateMaster;
    public static List<MetaData> lstRateCardTypes = new List<MetaData>();
    public Admin_RateTypeMaster()
        : base("Admin_RateTypeMaster_aspx")
    {
    }
    int currentPageNo = 1;
    int PageSize = 20;
    int totalRows = 0;
    int totalpage = 0;
    int totalrows1 = 0;

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        objBl = new AdminReports_BL(base.ContextInfo);
        try
        {
            if (!IsPostBack)
            {
                LoadGrid(e, currentPageNo, PageSize);
                //loaddata();
                // LoadRateOrgMapDetails();
                LoadRateOrgMappingGrid(e, currentPageNo, PageSize);
                LoadTrustedOrgDetails();
                LoadMetaDataVendorType();
                //AutoCompleteExtender2.ContextKey = OrgID.ToString();
                AutoCompleteExtender2.ContextKey = "Normal,Special";
                AutoCompleteExtender11.ContextKey = "DCP";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in RateType Page Loading", ex);
        }
    }

    public void LoadTrustedOrgDetails()
    {
        string strddlOrg = Resources.Admin_ClientDisplay.Admin_RateTypeMaster_aspx_03 == null ? "---Select Organisation---" : Resources.Admin_ClientDisplay.Admin_RateTypeMaster_aspx_03;
        try
        {
            List<Organization> lstorgn = new List<Organization>();
            AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
            objBl.GetSharingOrganizations(OrgID, out lstorgn);
            drpTrustedOrg.DataSource = lstorgn;//.FindAll(P => P.OrgID != OrgID);
            drpTrustedOrg.DataTextField = "Name";
            drpTrustedOrg.DataValueField = "OrgID";
            drpTrustedOrg.DataBind();
            //drpTrustedOrg.Items.Insert(0, "---Select Organisation---");
            drpTrustedOrg.Items.Insert(0, strddlOrg);
            drpTrustedOrg.Items[0].Value = "0";

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load TrustedOrg details", ex);
        }
    }



    private void LoadMetaDataVendorType()
    {
        string strddlSelect = Resources.Admin_ClientDisplay.Admin_RateTypeMaster_aspx_04 == null ? "--Select--" : Resources.Admin_ClientDisplay.Admin_RateTypeMaster_aspx_04;
        try
        {
            long returncode = -1;
            string domains = "Vendor Type";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            // string LangCode = string.Empty;
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
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            lstRateCardTypes = lstmetadataOutput;
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "Vendor Type" && child.ParentID == 0 //orderby child .MetaDataID
                                 select child;
                drpVendorType.DataSource = childItems;
                drpVendorType.DataTextField = "DisplayText";
                drpVendorType.DataValueField = "Code";
                drpVendorType.DataBind();
                //drpVendorType.Items.Insert(0, "--Select--");
                drpVendorType.Items.Insert(0, strddlSelect);
                drpVendorType.Items[0].Value = "0";
                drpVendorSubType.Items.Insert(0, strddlSelect);


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Vendor Type  Meta Data ", ex);

        }
    }
    protected void drpVendorType_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadMetaDataVendorSubType();
        drpVendorType.Focus();
    }



    //public void LoadRateOrgMapDetails()
    //{
    // try
    //{
    //long returnCode = -1;
    //List<RateRefOrgMapping> lstRateTypeMaster = new List<RateRefOrgMapping>();
    //returnCode = objBl.GetRateOrgMapping(OrgID, out lstRateTypeMaster);

    //grdRateOrgMapping.DataSource = lstRateTypeMaster;
    // grdRateOrgMapping.DataBind();
    //pnlRateOrgMap.Style.Add("display", "none");
    //if (lstRateTypeMaster.Count > 1)
    // {
    //  pnlRateOrgMap.Style.Add("display", "block");
    //}
    //}
    // catch (Exception ex)
    // {
    //    CLogger.LogError("Error in load Rate Organisation Mapping details", ex);
    //}
    //}
    //public void loaddata()
    //{
    //  try
    // {
    //    List<RateMaster> lstRateType = new List<RateMaster>();
    //  string OrgType = "COrg";
    //  Returncode = objBl.pGetRateTypeMaster(OrgID, OrgType, out lstRateType);
    // if (lstRateType.Count > 0)
    // {
    //   gvRateTypes.DataSource = lstRateType;
    //   gvRateTypes.DataBind();
    // }

    //}
    // catch (Exception ex)
    // {
    //    CLogger.LogError("Error in load data", ex);
    // }
    // }

    protected void gvRateTypes_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                LinkButton lnkbtn = (LinkButton)e.Row.FindControl("lnkEdit");
                objRateMaster = (RateMaster)e.Row.DataItem;
                if (objRateMaster.RateCode.ToUpper() == "GENERAL")
                {
                    lnkbtn.Enabled = false;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Row DataBound in Rate Types", ex);
        }
    }
    protected void gvRateTypes_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            int pid = 0;
            Label lblid = (Label)gvRateTypes.Rows[e.RowIndex].FindControl("lblid");
            if (lblid.Text != String.Empty)
            {
                pid = int.Parse(lblid.Text);
                Returncode = objBl.pDeleteRateType(OrgID, txtName.Text.Trim().ToUpper(), pid);
                if (Returncode > 0)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "delete", "javascript:ButtonDeleteClickMessage('4');", true);
                    //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Admin\\RateTypeMaster.aspx.cs_4").ToString();
                    //if (sUserMsg != null)
                    //{
                    //    ClientScript.RegisterStartupScript(this.GetType(), "delete", "alert('" + sUserMsg + "')", true);
                    //}
                    //else
                    //{
                    //    ClientScript.RegisterStartupScript(this.GetType(), "delete", "alert('Deleted successfully');", true);
                    //}
                }
                LoadGrid(e, currentPageNo, PageSize);
                //loaddata();
                Hdnupdate.Value = String.Empty;
                txtName.Text = String.Empty;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Delete Rate Types", ex);
        }
    }

    protected void btnsave_Click1(object sender, EventArgs e)
    {


        try
        {
            long PolicyID = 0;
            string VendorType = string.Empty;
            string VendorSubType = string.Empty;
            string Comments = string.Empty;
            if (Hdnupdate.Value == String.Empty)
            {
                long returnCode = -1;
                if (!String.IsNullOrEmpty(hdnPolicyID.Value) && hdnPolicyID.Value.Length > 0)
                    PolicyID = Convert.ToInt64(hdnPolicyID.Value);
                if (drpVendorType.SelectedIndex > 0)
                {
                    VendorType = drpVendorType.SelectedValue;
                }
                if (drpVendorSubType.SelectedIndex != 0)
                {
                    VendorSubType = drpVendorSubType.SelectedValue;
                }
                Comments = txtComments.Text;
                Returncode = objBl.pInsertRateType(OrgID, txtName.Text.Trim().ToUpper(), Convert.ToInt32(LID), PolicyID, VendorType, VendorSubType, Comments, out returnCode);
                if (returnCode > 0)
                {

                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "add", "javascript:ButtonClickMessage('7');", true);
                    //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Admin\\RateTypeMaster.aspx.cs_7").ToString();
                    //if (sUserMsg != null)
                    //{
                    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "add", "alert('" + sUserMsg + "')", true);
                    //}
                    //else
                    //{
                    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "add", "alert('Changes saved successfully.');", true);
                    //}
                }
                else if (returnCode == -1)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "addexists", "javascript:ButtonClickMessage('6');", true);
                    //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Admin\\RateTypeMaster.aspx.cs_6").ToString();
                    //if (sUserMsg != null)
                    //{
                    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "addexists", "alert('" + sUserMsg + "')", true);
                    //}
                    //else
                    //{
                    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "addexists", "alert('Already exist');", true);
                    //}
                }
            }
            else if (Hdnupdate.Value != String.Empty)
            {
                if (!String.IsNullOrEmpty(txtPolicyName.Text) && txtPolicyName.Text.Length > 0)
                    if (!String.IsNullOrEmpty(hdnPolicyID.Value) && hdnPolicyID.Value.Length > 0)
                        PolicyID = Convert.ToInt64(hdnPolicyID.Value);
                    else
                        PolicyID = 0;
                if (drpVendorType.SelectedIndex > 0)
                {
                    VendorType = drpVendorType.SelectedValue;
                }
                if (drpVendorSubType.SelectedIndex != 0)
                {
                    VendorSubType = drpVendorSubType.SelectedValue;
                }
                Comments = txtComments.Text;
                Returncode = objBl.UpdateRateType(OrgID, txtName.Text.Trim().ToUpper(), Convert.ToInt16(Hdnupdate.Value), Convert.ToInt32(LID), PolicyID, VendorType, VendorSubType, Comments);

                if (Returncode > 0)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "update", "javascript:ButtonClickMessage('7');", true);
                    //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Admin\\RateTypeMaster.aspx.cs_7").ToString();
                    //if (sUserMsg != null)
                    //{
                    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "update", "alert('" + sUserMsg + "')", true);
                    //}
                    //else
                    //{
                    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "update", "alert('Changes saved successfully.');", true);
                    //}
                }
                else if (Returncode == -1)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "updateexists", "javascript:ButtonAlreadyClickMessage('6');", true);
                    //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Admin\\RateTypeMaster.aspx.cs_6").ToString();
                    //if (sUserMsg != null)
                    //{
                    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "updateexists", "alert('" + sUserMsg + "')", true);
                    //}
                    //else
                    //{
                    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "updateexists", "alert('Already exist');", true);
                    //}
                }
            }
            LoadGrid(e, currentPageNo, PageSize);
            // loaddata();
            // LoadRateOrgMapDetails();
            string strSave = Resources.Admin_ClientDisplay.Admin_RateTypeMaster_aspx_05 == null ? "Save" : Resources.Admin_ClientDisplay.Admin_RateTypeMaster_aspx_05;
            LoadRateOrgMappingGrid(e, currentPageNo, PageSize);
            //btnsave.Text = "Save";
            btnsave.Text = strSave;
            Hdnupdate.Value = String.Empty;
            txtName.Text = String.Empty;
            txtPolicyName.Text = "";
            hdnPolicyID.Value = "";
            drpVendorType.SelectedValue = "0";
            drpVendorSubType.SelectedValue = "0";
            txtComments.Text = "";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "DisplayTab('" + "RAC" + "');", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Save Data in Rate Types", ex);
        }
    }


    private void LoadMetaDataVendorSubType()
    {
        string strddlSelect = Resources.Admin_ClientDisplay.Admin_RateTypeMaster_aspx_04 == null ? "--Select--" : Resources.Admin_ClientDisplay.Admin_RateTypeMaster_aspx_04;
        try
        {
            string DisplayText = string.Empty;
            if (drpVendorType.SelectedIndex > 0)
            {
                DisplayText = drpVendorType.SelectedValue;

                var ParentID = (from Parent in lstRateCardTypes
                                where Parent.Code == DisplayText && Parent.Domain == "Vendor Type" && Parent.ParentID == 0
                                select Parent.MetaDataID).FirstOrDefault();

                if (lstRateCardTypes.Count > 0)
                {
                    var childItems = from child in lstRateCardTypes
                                     where child.Domain == "Vendor Type" && child.ParentID == Convert.ToInt32(ParentID)
                                     select child;
                    drpVendorSubType.DataSource = childItems;
                    drpVendorSubType.DataTextField = "DisplayText";
                    drpVendorSubType.DataValueField = "Code";
                    drpVendorSubType.DataBind();
                    //drpVendorSubType.Items.Insert(0, "--Select--");
                    drpVendorSubType.Items.Insert(0, strddlSelect);
                    drpVendorSubType.Items[0].Value = "0";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "setMandatory();", true);

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading VendorSubType  Meta Data ", ex);

        }
    }


    protected void gvRateTypes_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string strUpdate = Resources.Admin_ClientDisplay.Admin_RateTypeMaster_aspx_06 == null ? "Update" : Resources.Admin_ClientDisplay.Admin_RateTypeMaster_aspx_06;
        try
        {
            List<RateMaster> lstRateType = new List<RateMaster>();
            string OrgType = "COrg";
            Returncode = objBl.pGetRateTypeMaster(OrgID, OrgType, out lstRateType);
            int RateId = 0;
            long PolicyID = 0;
            string VendorType = string.Empty;
            string VendorSubType = string.Empty;

            Int32 rowIndex = Convert.ToInt32(e.CommandArgument);
            RateId = Convert.ToInt32(gvRateTypes.DataKeys[rowIndex]["RateId"]);
            PolicyID = Convert.ToInt64(gvRateTypes.DataKeys[rowIndex]["DiscountPolicyID"]);
            VendorType = Convert.ToString(gvRateTypes.DataKeys[rowIndex]["Status"]);
            VendorSubType = Convert.ToString(gvRateTypes.DataKeys[rowIndex]["SubType"]);
            var s = lstRateType.Find(p => p.RateId == RateId);
            if (e.CommandName == "RateEdit")
            {
                txtName.Text = s.RateName.ToString();
                Hdnupdate.Value = s.RateId.ToString();
                drpVendorType.SelectedValue = s.Type.ToString();
                LoadMetaDataVendorSubType();
                if (!string.IsNullOrEmpty(s.SubType.ToString()))
                {
                    drpVendorSubType.SelectedValue = s.SubType.ToString();
                }
                else
                {
                    drpVendorSubType.SelectedValue = "0";
                }
                txtPolicyName.Text = "";
                hdnPolicyID.Value = "";
                if (!String.IsNullOrEmpty(s.Comments) && s.Comments.Length > 0)
                    txtComments.Text = s.Comments.ToString();
                if (!String.IsNullOrEmpty(s.RateTypeName) && s.RateTypeName.Length > 0)
                    txtPolicyName.Text = s.RateTypeName;
                hdnPolicyID.Value = s.DiscountPolicyID.ToString();
              //  btnsave.Text = "update";
                btnsave.Text = strUpdate;
                //  if (drpVendorType.SelectedValue == "Special")
                //  {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "setMandatory();", true);
                //}
            }

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data ", ex);
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            string flag = "0";
            if (grdRateOrgMapping.Rows.Count > 0)
            {
                for (int i = 0; i < grdRateOrgMapping.Rows.Count; i++)
                {
                    Label lblRateID = (Label)grdRateOrgMapping.Rows[i].Cells[2].FindControl("lblRateID");
                    Label lblOrgID = (Label)grdRateOrgMapping.Rows[i].Cells[4].FindControl("lblOrgID");

                    if (lblRateID.Text == hdnRateID.Value && lblOrgID.Text == drpTrustedOrg.SelectedValue)
                    {
                        flag = "1";

                        break;
                    }
                }
            }
            if (flag == "1")
            {string strAlert=Resources.Admin_AppMsg.Admin_RateTypeMaster_aspx_Alert==null?"Alert":Resources.Admin_AppMsg.Admin_RateTypeMaster_aspx_Alert;

                if (String.IsNullOrEmpty(txtTrustedOrgPolicyID.Text) && txtTrustedOrgPolicyID.Text.Length == 0)
                {

                    if (!String.IsNullOrEmpty(hdnRateID.Value) && hdnRateID.Value.Length > 0)
                    {
                        WebService objWS = new WebService();
                        int RateID = 0;
                        int TrustedOrgID = 0;
                        RateID = Convert.ToInt32(hdnRateID.Value);
                        if (Convert.ToInt32(drpTrustedOrg.SelectedValue) != 0)
                        {
                            TrustedOrgID = Convert.ToInt32(drpTrustedOrg.SelectedValue);
                            objWS.pSaveRateOrgMapping(RateID, TrustedOrgID, RateID, LID);
                        }
                    }
                    txtTrustedOrgPolicyID.Text = "";
                    hdnTrustedPolicyID.Value = "";
                }
                string sPath = "Admin\\\\RateTypeMaster.aspx.cs_9";
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert Exists", "alert('" + sPath + "');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert Exists", "javascript:ValidationWindow('" + sPath + "','" + strAlert + "');", true);
            }
            else
            {
                string QueryType = "INS";
                long PolicyID = 0;
                int RateID = 0;
                string hdnRateVa = Convert.ToString(hdnRateID.Value.TrimStart());
                string[] hdnRateVal = hdnRateVa.Split('|');              
             
                int drpTrustedOrgVal = Convert.ToInt32((drpTrustedOrg.SelectedValue));
                returnCode = objBl.SaveRateOrgMap(txtRateCard.Text.Trim(), Convert.ToInt32(hdnRateVal[0]), drpTrustedOrgVal, OrgID, PolicyID, QueryType, LID);
                LoadRateOrgMappingGrid(e, currentPageNo, PageSize);
                //LoadRateOrgMapDetails();
                txtRateCard.Text = "";
                txtTrustedOrgPolicyID.Text = "";
                hdnTrustedPolicyID.Value = "";
                drpTrustedOrg.SelectedIndex = 0;
            }
            txtRateCard.Focus();
            AutoCompleteExtender2.ContextKey = OrgID.ToString();
            AutoCompleteExtender11.ContextKey = "DCP";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "DisplayTab('" + "RACO" + "');", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Rate Organisation Mapping details", ex);
        }
    }

    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);
        return totalPages;
    }

    private int Calculate(double TotalRows1)
    {
        int totalpages1 = (int)Math.Ceiling(TotalRows1 / PageSize);
        return totalpages1;
    }


    private void LoadGrid(EventArgs e, int currentPageNo, int PageSize)
    {
        string RateTypeName = string.Empty;
        if (txtRateNameSearch.Text != null)
        {
            RateTypeName = txtRateNameSearch.Text;
        }
        else
        {

        }

        // GrdFooter1.Style.Add("display", "none");
        List<RateMaster> lstRateType = new List<RateMaster>();
        string OrgType = "COrg";
        Returncode = objBl.GetRateTypeMasterNew(OrgID, OrgType, RateTypeName, PageSize, currentPageNo, out totalRows, out lstRateType);
        if (lstRateType.Count > 0)
        {

        }

        if (lstRateType.Count > 0)
        {

            GrdFooter.Style.Add("display", "table-row");
            totalpage = totalRows;
            lblTotal.Text = CalculateTotalPages(totalRows).ToString();
            if (hdnCurrent.Value == "")
            {
                lblCurrent.Text = currentPageNo.ToString();
            }
            else
            {
                lblCurrent.Text = hdnCurrent.Value;
                currentPageNo = Convert.ToInt32(hdnCurrent.Value);
            }
            if (currentPageNo == 1)
            {
                btnPrevious.Enabled = false;
                if (Int32.Parse(lblTotal.Text) > 1)
                {
                    btnNext.Enabled = true;
                }
                else
                    btnNext.Enabled = false;
            }
            else
            {
                btnPrevious.Enabled = true;
                if (currentPageNo == Int32.Parse(lblTotal.Text))
                    btnNext.Enabled = false;
                else btnNext.Enabled = true;
            }
        }
        else
            GrdFooter.Style.Add("display", "none");
        if (lstRateType.Count > 0)
        {
            gvRateTypes.Visible = true;
            //lblResult.Visible = false;
            // lblResult.Text = "";
            gvRateTypes.DataSource = lstRateType;
            gvRateTypes.DataBind();
        }
        else
        {
            gvRateTypes.Visible = false;
            //lblResult.Visible = true;
            //lblResult.Text = "No matching records found";
        }
    }

    private void LoadRateOrgMappingGrid(EventArgs e, int currentPageNo, int PageSize)
    {

        string RateCardName = string.Empty;
        if (txtRateCardMapping.Text != null)
        {
            RateCardName = txtRateCardMapping.Text;
        }
        else
        {

        }
        long returnCode = -1;
        List<RateRefOrgMapping> lstRateTypeMaster = new List<RateRefOrgMapping>();
        returnCode = objBl.GetRateOrgMapping(OrgID, PageSize, RateCardName, currentPageNo, out totalrows1, out lstRateTypeMaster);


        //pnlRateOrgMap.Style.Add("display", "none");
        if (lstRateTypeMaster.Count > 1)
        {
            pnlRateOrgMap.Style.Add("display", "block");
        }
        else
        {
            trRateCardMapping.Style.Add("display", "table-row");
            trRateCardMapping1.Style.Add("display", "rable-row");
        }

        if (lstRateTypeMaster.Count > 0)
        {
            GrdFooter1.Style.Add("display", "table-row");
            totalpage = totalRows;
            lblTotal1.Text = Calculate(totalrows1).ToString();
            if (hdnCurrent1.Value == "")
            {
                lblCurrent1.Text = currentPageNo.ToString();
            }
            else
            {
                lblCurrent1.Text = hdnCurrent1.Value;
                currentPageNo = Convert.ToInt32(hdnCurrent1.Value);
            }
            if (currentPageNo == 1)
            {
                btnPrevious1.Enabled = false;
                if (Int32.Parse(lblTotal1.Text) > 1)
                {
                    btnNext1.Enabled = true;
                }
                else
                    btnNext1.Enabled = false;
            }
            else
            {
                btnPrevious1.Enabled = true;
                if (currentPageNo == Int32.Parse(lblTotal1.Text))
                    btnNext1.Enabled = false;
                else btnNext1.Enabled = true;
            }
        }
        else
            GrdFooter1.Style.Add("display", "none");
        if (lstRateTypeMaster.Count > 0)
        {
            grdRateOrgMapping.Visible = true;
            grdRateOrgMapping.DataSource = lstRateTypeMaster;
            grdRateOrgMapping.DataBind();
        }
        else
        {
            grdRateOrgMapping.Visible = false;
            //lblResult.Visible = true;
            //lblResult.Text = "No matching records found";
        }

        /* Changes Done By Dilip For Tab Not to NaviGate*/
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "DisplayTab('" + "RACO" + "');", true);
        /*Ended*/
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = txtpageNo.Text;
        LoadGrid(e, Convert.ToInt32(txtpageNo.Text), PageSize);
    }

    protected void btnNext1_Click(object sender, EventArgs e)
    {
        if (hdnCurrent1.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent1.Value) + 1;
            hdnCurrent1.Value = currentPageNo.ToString();
            LoadRateOrgMappingGrid(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent1.Text) + 1;
            hdnCurrent1.Value = currentPageNo.ToString();
            LoadRateOrgMappingGrid(e, currentPageNo, PageSize);
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "DisplayTab('" + "RACO" + "');", true);
        txtpageNo1.Text = "";
    }
    protected void btnPrevious1_Click(object sender, EventArgs e)
    {
        if (hdnCurrent1.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent1.Value) - 1;
            hdnCurrent1.Value = currentPageNo.ToString();
            LoadRateOrgMappingGrid(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent1.Text) - 1;
            hdnCurrent1.Value = currentPageNo.ToString();
            LoadRateOrgMappingGrid(e, currentPageNo, PageSize);
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "DisplayTab('" + "RACO" + "');", true);
        txtpageNo1.Text = "";
    }
    protected void btnGo1_Click(object sender, EventArgs e)
    {
        hdnCurrent1.Value = txtpageNo1.Text;
        LoadRateOrgMappingGrid(e, Convert.ToInt32(txtpageNo1.Text), PageSize);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "DisplayTab('" + "RACO" + "');", true);
    }


    protected void btnsearch_Click(object sender, EventArgs e)
    {
        if (txtRateNameSearch.Text != null)
        {
            LoadGrid(e, currentPageNo, PageSize);
        }
        else
        {
            LoadGrid(e, currentPageNo, PageSize);
        }
    }
    protected void btnmapping_Click(object sender, EventArgs e)
    {
        if (txtRateCardMapping.Text != null)
        {
            LoadRateOrgMappingGrid(e, currentPageNo, PageSize);
        }
        else
        {
            LoadRateOrgMappingGrid(e, currentPageNo, PageSize);
        }
		ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "DisplayTab('" + "RACO" + "');", true);
    }
}