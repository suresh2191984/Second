using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.Xml;
using System.Web.Script.Serialization;
using System.Text;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PerformingNextAction;
using Attune.Kernel.StockIndent.BL;


public partial class StockIntend_SubstoreSearch : Attune_BasePage
{
    public StockIntend_SubstoreSearch()
        : base("StockIntend_SubstoreSearch.aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    InventoryCommon_BL inventoryBL;
    List<Locations> lstLocation;
    List<Intend> lstIntend;
    // int toLocationID = 0;
    string intendtype = string.Empty;
    string pType = string.Empty;
    //int ReceivedOrgID = -1;
    int ReceivedOrgAddID = -1;
    List<Organization> lstorgn = new List<Organization>();
    List<Locations> lstloc = new List<Locations>();
    List<Locations> lstTrustOrgFindOrgAddid = new List<Locations>();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            //ddlLocation.Items.Insert(0, "--ALL--");
            //ddlLocation.Items[0].Value = "-1";
            txtFrom.Text = DateTime.Now.ToExternalDate();
            txtTo.Text = DateTime.Now.ToExternalDate();
            divAction.Attributes.Add("class", "hide");
            loadActionList();
            LoadOrgan();
            //BindDrp();
            ScriptManager.RegisterStartupScript(Page, GetType(), "ALt", "checkboxSelection('" + CheckRaisedFrom.ClientID + "');", true);
        }

        
        LocationTypeCheck();
        hdnInventoryLocationID.Value = InventoryLocationID.ToString();
        LoadIntendGrid();
    }
    //public void BindDrp()
    //{
    //    List<MetaData> lstitem = new List<MetaData>();
    //    lstitem = GetMetaData("Search");
    //    ddlStatus.DataSource = lstitem;
    //    ddlStatus.DataTextField = "DisplayText";
    //    ddlStatus.DataValueField = "Code";
    //    ddlStatus.DataBind();

    //    ListItem ddlselect = GetMetaData("Select", "0");
    //    if (ddlselect == null)
    //    {
    //        ddlselect = new ListItem() { Text = "Select", Value = "0" };
    //    }
    //    ddlStatus.Items.Insert(0, ddlselect);
        
    //}
    private void LoadOrgan()
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        //inventoryBL = new Inventory_BL(base.ContextInfo);
        TrustedOrg_BL lstTrustedOrg = new TrustedOrg_BL(base.ContextInfo);
        lstTrustedOrg.GetSharingOrgList(OrgID, out lstorgn, out lstloc);

        //if (Request.QueryString["IsTransfer"] != null)
        //{
        //    ddlTrustedOrg.DataSource = lstorgn.FindAll(p => p.OrganizationID == OrgID);
        //}
        //else
        //{
        //    ddlTrustedOrg.DataSource = lstorgn.FindAll(p => p.OrganizationID == OrgID);
        //}
        ddlTrustedOrg.DataSource = lstorgn;
        ddlTrustedOrg.DataTextField = "Name";
        ddlTrustedOrg.DataValueField = "orgid";
        ddlTrustedOrg.DataBind();
        //Arun
        ListItem ddlselect = GetMetaData("ALL", "0");
        if (ddlselect == null)
        {
            ddlselect = new ListItem() { Text = "ALL", Value = "0" };
        }
        ddlTrustedOrg.Items.Insert(0, ddlselect);
        //end 
        ddlTrustedOrg.Items[0].Value = "0";

        if (Request.QueryString["IsTransfer"] != null)
        {

            ddlTrustedOrg.SelectedValue = OrgID.ToString();
            ddlTrustedOrg.Enabled = false;

            ddlIndentType.Items.Clear();
            ddlIndentType.Items.Insert(0, "Raised Stock Issue");
            ddlIndentType.Items.Insert(1, "Stock Issue");
            ddlIndentType.Items[0].Value = "0";
            ddlIndentType.Items[1].Value = "1";

            Rs_IndentType.Text = "Stock Issue Type";
            LoadToLocationName(OrgID, ILocationID);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadlocation", "Javascript:GetLocationlist();", true);

        }
        lstloc.RemoveAll(P => P.LocationID == InventoryLocationID);
        foreach (var item in lstloc)
        {
            hdnlocation.Value += item.OrgID + "~" + item.LocationID + "~" + item.LocationName + "^";

        }
        if (lstorgn.Count > 0)
        {
            ddlLocation.DataSource = lstloc;
            ddlLocation.DataTextField = "LocationName";
            ddlLocation.DataValueField = "LocationID";
            ddlLocation.DataBind();
            //Arun
            ListItem dddlselect = GetMetaData("ALL", "0");
            if (dddlselect == null)
            {
                dddlselect = new ListItem() { Text = "ALL", Value = "0" };
            }
            ddlLocation.Items.Insert(0, dddlselect);
            //end
            ddlLocation.Items[0].Value = "-1";
        }
        //   ddlTrustedOrg.SelectedValue = OrgID.ToString();
    }

    private void LocationTypeCheck()
    {

        try
        {

            inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            lstLocation = new List<Locations>();
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            //int OrgAddid = 0;
            inventoryBL.GetLocationTypeCheck(OrgID, ILocationID, InventoryLocationID, out lstLocation);
            hdnCurrentlocation.Value = InventoryLocationID.ToString();
            if (lstLocation.Count > 0)
            {
                hdnCS.Value = lstLocation[0].LocationTypeCode.ToString();
                intendtype = lstLocation[0].LocationTypeCode.ToString();
            }
            if ((intendtype == "POS") || (intendtype == "POD"))
            {
                CheckRaisedFrom.Visible = false;
                CheckRaisedTo.Visible = false;

            }
            else
            {
                CheckRaisedFrom.Visible = true;
                CheckRaisedTo.Visible = true;
            }
            LoadClear();
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Location Details", Ex);
        }


    }


    private void LoadClear()
    {
        gvIntend.DataSource = null;
        gvIntend.DataBind();
        gvStockTansfer.DataSource = null;
        gvStockTansfer.DataBind();
    }


    #region Binding Intend to the Grid
    /// <summary>
    /// It loads all intend raised by the locations based on the filters
    /// like Date, Intend No and Location
    /// </summary>
    /// 

    private void LoadIntendGrid()
    {
        try
        {
            Intend objIntend = new Intend();
            inventoryBL = new InventoryCommon_BL(base.ContextInfo);

            string strStatus = string.Empty;
            switch (ddlStatus.SelectedItem.Value)
            {
                case "1":

                    strStatus = Resources.StockIntend_ClientDisplay.StockIntend_SubstoreSearch_aspx_08;
                    break;

                case "2":

                    strStatus = Resources.StockIntend_ClientDisplay.StockIntend_SubstoreSearch_aspx_05;
                    break;

                case "3":
                    strStatus = Resources.StockIntend_ClientDisplay.StockIntend_SubstoreSearch_aspx_01;
                    break;

                case "4":
                    strStatus = Resources.StockIntend_ClientDisplay.StockIntend_SubstoreSearch_aspx_02;
                    break;

                case "5":
                    strStatus = "Cancelled";
                    //strStatus = Resources.ClientSideDisplayTexts.Inventory_Intend_PartialIssued;
                    break;

                default:
                    strStatus = "0";
                    break;
            }

            //if (ddlFromLocation.SelectedValue == "-1" && ddlLocation.SelectedValue == "-1")
            //{
            //    lstIntend = new List<Intend>();
            //    objIntend.IntendNo = txtIntendNo.Text;
            //    objIntend.LocationID = Int32.Parse(hdnCurrentlocation.Value);
            //    objIntend.OrgID = OrgID;
            //    objIntend.OrgAddressID = ILocationID;
            //    objIntend.Status = strStatus;
            //    objIntend.ToLocationID = Int32.Parse(ddlLocation.SelectedValue);
            //    objIntend.RaiseOrgID = Int32.Parse(ddlTrustedOrg.SelectedValue) > 0 ? Int32.Parse(ddlTrustedOrg.SelectedValue) : 0;
            //    pType = ddlIndentType.SelectedItem.Value;
            //}
            //else
            //{
            lstIntend = new List<Intend>();
            objIntend.IntendNo = txtIntendNo.Text;
            //objIntend.LocationID = Int32.Parse(ddlFromLocation.SelectedValue);
            objIntend.LocationID = InventoryLocationID;
            objIntend.OrgID = OrgID;
            objIntend.OrgAddressID = ILocationID;
            if (strStatus == "Approved")
            {
                objIntend.Status = "Received";
            }
            else
            {
                objIntend.Status = strStatus;
            }
           
            //objIntend.ToLocationID = Int32.Parse(hdnTolocationID.Value);
            if (!ddlLocation.SelectedValue.Equals("0") && !ddlLocation.SelectedValue.Equals("-1"))
            {
                objIntend.ToLocationID = Int32.Parse(ddlLocation.SelectedValue);
            }
            if (!ddlTrustedOrg.SelectedValue.Equals("0") && !ddlTrustedOrg.SelectedValue.Equals("-1"))
            {
                objIntend.RaiseOrgID = Int32.Parse(ddlTrustedOrg.SelectedValue) > 0 ? Int32.Parse(ddlTrustedOrg.SelectedValue) : 0;
            }
            pType = ddlIndentType.SelectedItem.Value;
            //}

            if (Request.QueryString["IsTransfer"] != null)
            {
                base.ContextInfo.AdditionalInfo = "STR";
                inventoryBL.GetSubStoreSearch(txtFrom.Text.Trim().ToInternalDate().ToString(), txtTo.Text.Trim().ToInternalDate().ToString(),
                                    objIntend.IntendNo, objIntend.LocationID, objIntend.OrgID,
                                    objIntend.OrgAddressID, objIntend.Status, objIntend.ToLocationID, pType, objIntend.RaiseOrgID, ReceivedOrgAddID, out lstIntend);
         
            }
            else
            {
                ContextInfo.AdditionalInfo = "";
                inventoryBL.GetSubStoreSearch(txtFrom.Text.Trim().ToInternalDate().ToString(), txtTo.Text.Trim().ToInternalDate().ToString(),
                                         objIntend.IntendNo, objIntend.LocationID, objIntend.OrgID,
                                         objIntend.OrgAddressID, objIntend.Status, objIntend.ToLocationID, pType, objIntend.RaiseOrgID, ReceivedOrgAddID, out lstIntend);
            }
            if (lstIntend.Count > 0)
            {
                if (Request.QueryString["IsTransfer"] != null)
                {
                    if (Request.QueryString["IsTransfer"] == "Y")
                    {

                        gvStockTansfer.DataSource = lstIntend;
                        gvStockTansfer.Columns[3].Visible = true;
                        gvStockTansfer.DataBind();
                        gvStockTansfer.Visible = true;
                    }
                    else
                    {
                        gvIntend.DataSource = lstIntend;
                        gvIntend.Columns[3].Visible = true;
                        gvIntend.DataBind();
                        gvIntend.Visible = true;
                    }
                }
                else
                {
                    gvStockTansfer.Visible = false;
                    gvIntend.DataSource = lstIntend;
                    gvIntend.Columns[3].Visible = true;
                    gvIntend.DataBind();
                    gvIntend.Visible = true;
                }
            }
            divAction.Attributes.Add("class", "show");
            if (lstIntend.Count == 0)
            {
                gvIntend.Visible = false;
                divAction.Attributes.Add("class", "hide");
            }
            //if (intendtype == "CS-POS" || intendtype == "CS")
             // {
             //  if ((CheckRaisedFrom.Checked != true) && (CheckRaisedTo.Checked != true))
             //   {
            //        gvIntend.DataSource = null;
             //       gvIntend.DataBind();
             //   }
          //  }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Loading Location - IntendViewDetail.aspx", Ex);
        }
    }


    #endregion

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadIntendGrid();
        loadActionList();
    }


    protected void gvIntend_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvIntend.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
    }



    #region Loading ActionList DropDown
    /// <summary>
    /// This method loads the dropdown with available action for the specific location
    /// where the actions like "View Intend", "Issue Intend" and "Approve Intend"
    /// </summary>
    protected void loadActionList()
    {
        try
        {
            long returnCode = 0;
            List<ActionMaster> lstActionMaster = new List<ActionMaster>();
            List<ActionMaster> lstActionMaster_pos = new List<ActionMaster>();
            inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            lstLocation = new List<Locations>();
            List<Locations> lstLocationCS = new List<Locations>();
            //if (Request.QueryString["IsTransfer"] != null)
            //{
            //    if (Request.QueryString["IsTransfer"] == "Y")
            //    {
            //        hdnIsTransfer.Value = "Y";
            //        returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, (int)TaskHelper.SearchType.StockIssueType, out lstActionMaster);

            //    }
            //    else
            //    {
            returnCode = new ActionManager_BL(base.ContextInfo).GetActions(RoleID, (int)TaskHelper.SearchType.SubstoreReturnSearch, out lstActionMaster);

            //    }
            //}
            //else
            //{

            //    returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, (int)TaskHelper.SearchType.IntendSearch, out lstActionMaster);
            //}
            Cache["lstActionMaster"] = lstActionMaster;
            ddlAction.Items.Clear();
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            int OrgAddid = 0;
            new Master_BL(ContextInfo).GetInvLocationDetail(OrgID, OrgAddid, out lstLocation);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - loadActionList", ex);
        }
    }
    #endregion

    /// <summary>
    /// It Bounds the radio button in each row with IntendID, Status
    /// this helps to proceed with an appropriate action in the Actionlist
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvIntend_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Intend ObjIntendTemp = new Intend();
                ObjIntendTemp = (Intend)e.Row.DataItem;
                //string strScript = "SelectIntendRowCommon('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + ObjIntendTemp.IntendID + "','" + ObjIntendTemp.Status + "','" + ObjIntendTemp.LocationID + "','" + ObjIntendTemp.IntendReceivedID + "','" + ObjIntendTemp.IntendReceivedDetailID + "','" + ObjIntendTemp.ToLocationID + "','" + ObjIntendTemp.RaiseOrgID + "','" + ObjIntendTemp.OrgID  + "');";
                string strScript = "";
                strScript = "SelectIntendRowCommon('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + ObjIntendTemp.IntendID + "','" + ObjIntendTemp.Status + "','" + ObjIntendTemp.LocationID + "','" + ObjIntendTemp.IntendReceivedID + "','" + ObjIntendTemp.IntendReceivedDetailID + "','" + ObjIntendTemp.ToLocationID + "','" + ObjIntendTemp.RaiseOrgID + "','" + ObjIntendTemp.OrgID + "','" + ObjIntendTemp.TaskId + "');";
                //if (CheckRaisedTo.Checked)
                {
                    strScript = "SelectIntendRowCommon('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + ObjIntendTemp.IntendID + "','" + ObjIntendTemp.Status + "','" + ObjIntendTemp.ToLocationID + "','" + ObjIntendTemp.IntendReceivedID + "','" + ObjIntendTemp.IntendReceivedDetailID + "','" + ObjIntendTemp.LocationID + "','" + ObjIntendTemp.RaiseOrgID + "','" + ObjIntendTemp.OrgID + "','" + ObjIntendTemp.TaskId + "');";
                }
                //
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.class='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
                RadioButton rdoSelect = (RadioButton)e.Row.FindControl("rdSel");
            }

            if (ddlIndentType.SelectedValue.Equals("0"))
            {
                gvIntend.Columns[7].Visible = false;
            }
            else
            {
                gvIntend.Columns[7].Visible = true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Intend.", ex);
        }
    }

    /// <summary>
    /// This method redirects the page to perform the intended action
    /// which is selected from the ActionList DropDown
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    /// 
    protected void btnGO_Click(object sender, EventArgs e)
    {
        try
        {
            string queryString = string.Empty;
            string id = string.Empty;


            string[] listValue = hdnDDLActionValue.Value.Split('~'); //ddlAction.SelectedValue.Split('~');

            if (hdnDDLActionText.Value == Resources.StockIntend_ClientDisplay.StockIntend_SubstoreSearch_aspx_03)
            {
                queryString += listValue[0] + "?Appr='Y'&intID=" + hdnId.Value + "&tid=" + hdnTaskId.Value;
            }
            else if (hdnDDLActionText.Value == Resources.StockIntend_ClientDisplay.StockIntend_SubstoreSearch_aspx_07)
            {
               // queryString += listValue[0] + "?ID=" + hdnIntendReceivedID.Value + "&intID=" + hdnId.Value + "&LocationID=" + hdnTolocationID.Value + "&ReceivedOrgID=" + hdnReceivedOrgID.Value;
                queryString += listValue[0] + "?ID=" + hdnIntendReceivedID.Value + "&intID=" + hdnId.Value + "&LocationID=" + hdnTolocationID.Value + "&ReceivedOrgID=" + hdnorgid.Value;
            }
            else if (hdnDDLActionText.Value == Resources.StockIntend_ClientDisplay.StockIntend_SubstoreSearch_aspx_06)
            {
                queryString += listValue[0] + "?ID=" + hdnIntendReceivedID.Value + "&intID=" + hdnId.Value + "&LocationID=" + hdnTolocationID.Value + "&ReceivedOrgID=" + hdnorgid.Value + "&Status=" + hdnStatus.Value;
               
            }
            else if ((hdnDDLActionText.Value == Resources.StockIntend_ClientDisplay.StockIntend_SubstoreSearch_aspx_09))
            {

                queryString += listValue[0] + "?ID=" + hdnIntendReceivedID.Value + "&intID=" + hdnId.Value + "&LocationID=" + hdnTolocationID.Value + "&Status=" + hdnStatus.Value + "&ReceivedOrgID=" + hdnReceivedOrgID.Value + "&IndentType=" + ddlIndentType.SelectedItem.Text.ToString() + "&SearchType=" + hdnDDLActionText.Value.ToString();

            }else
                if (hdnDDLActionText.Value == Resources.StockIntend_ClientDisplay.StockIntend_SubstoreSearch_aspx_02)
                {
                    queryString += listValue[0] + "?Appr='Y'&intID=" + hdnId.Value + "&tid=" + hdnTaskId.Value;
                }
                else
            {
                //queryString += listValue[0] + "?Appr='Y'&intID=" + hdnId.Value + "&tid=" + hdnTaskId.Value;
                queryString += listValue[0] + "?ID=" + hdnIntendReceivedID.Value + "&intID=" + hdnId.Value + "&LocationID=" + hdnTolocationID.Value + "&Status=" + hdnStatus.Value + "&ReceivedOrgID=" + hdnReceivedOrgID.Value;

            }

            if (Request.QueryString["IsTransfer"] != null)
            {
                Response.Redirect(Request.ApplicationPath + queryString + "&IsTransfer=Y", true);

            }
            else
            {
                Response.Redirect(Request.ApplicationPath + queryString, true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    #region Loading Location DropDown
    /// <summary>
    /// Loading all locations in an org except "Central Store Type"
    /// </summary>
    /// <param name="OrgId">Organisation ID</param>
    /// <param name="OrgAddrId">Organisation Address ID</param>
    /// 


    private void LoadToLocationName(int OrgId, int OrgAddrId)
    {

        int TOrgAddid = 0;
        try
        {
            ddlLocation.Items.Clear();
            inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            lstLocation = new List<Locations>();
            List<Locations> lstRLocation = new List<Locations>();
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            // int OrgAddid = 0;
            //int OrgAddid = ILocationID;
            //new GateWay(base.ContextInfo).GetInventoryConfigDetails("Locations_BasedOn_Org", OrgID, ILocationID, out lstInventoryConfig);
            //if (lstInventoryConfig.Count > 0)
            //{
            //    if (lstInventoryConfig[0].ConfigValue == "Y")
            //    {
            //        OrgAddid = 0;
            //    }
            //    else
            //    {
            //        OrgAddid = ILocationID;
            //    }
            //}
            TrustedOrg_BL lstTrustedOrg = new TrustedOrg_BL(base.ContextInfo);
            lstTrustedOrg.GetSharingOrgList(OrgID, out lstorgn, out lstloc);

            lstTrustOrgFindOrgAddid = lstloc.FindAll(p => p.OrgID == int.Parse(ddlTrustedOrg.SelectedValue));

            TOrgAddid = lstTrustOrgFindOrgAddid[0].OrgAddressID;

            inventoryBL.GetInvTOLocationDetail(int.Parse(ddlTrustedOrg.SelectedValue), TOrgAddid, "", "", out lstLocation);
            //lstRLocation = lstLocation.FindAll(P => P.LocationID != (Convert.ToInt16(InventoryLocationID)));
            string ConfigValue = GetConfigValue("LocationFilter", OrgID);
            if (ConfigValue.ToLower().Equals("locationfilter"))
            {
                List<Locations> lstFiltered = new List<Locations>();
                lstFiltered = lstLocation.FindAll(P => (P.LocationID == InventoryLocationID));
                int getParentLocationID = 0;
                if (!lstFiltered.Equals(null))
                {
                    if (lstFiltered.Count > 0)
                    {
                        getParentLocationID = lstFiltered[0].ParentLocationID;
                    }
                }

                List<Locations> lstFilteredLocation = new List<Locations>();
                lstFilteredLocation = lstLocation.FindAll(P => (P.ParentLocationID == getParentLocationID));

                ddlLocation.DataSource = lstFilteredLocation;
                ddlLocation.DataTextField = "LocationName";
                ddlLocation.DataValueField = "LocationID";
                ddlLocation.DataBind();
                ListItem ddlselect = GetMetaData("ALL", "-1");
                if (ddlselect == null)
                {
                    ddlselect = new ListItem() { Text = "ALL", Value = "-1" };
                }
                ddlLocation.Items.Insert(0, ddlselect);
                ddlLocation.Items[0].Value = "-1";

                //ddlFromLocation.DataSource = lstFilteredLocation;
                //ddlFromLocation.DataTextField = "LocationName";
                //ddlFromLocation.DataValueField = "LocationID";
                //ddlFromLocation.DataBind();
                //ddlFromLocation.Items.Insert(0, "--ALL--");
                //ddlFromLocation.Items[0].Value = "-1";
            }
            else
            {

                ddlLocation.DataSource = lstLocation;
                ddlLocation.DataTextField = "LocationName";
                ddlLocation.DataValueField = "LocationID";
                ddlLocation.DataBind();
                ListItem ddlselect = GetMetaData("ALL", "0");
                if (ddlselect == null)
                {
                    ddlselect = new ListItem() { Text = "ALL", Value = "0" };
                }
                ddlLocation.Items.Insert(0, ddlselect);
                ddlLocation.Items[0].Value = "-1";

                //ddlFromLocation.DataSource = lstLocation;
                //ddlFromLocation.DataTextField = "LocationName";
                //ddlFromLocation.DataValueField = "LocationID";
                //ddlFromLocation.DataBind();
                //ddlFromLocation.Items.Insert(0, "--ALL--");
                //ddlFromLocation.Items[0].Value = "-1";
            }


        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Location Details", Ex);
        }

    }



    #endregion

    protected void ddlTrustedOrg_SelectedIndexChanged1(object sender, EventArgs e)
    {
        if (ddlTrustedOrg.SelectedItem.Value != "0")
        {
            LoadToLocationName(int.Parse(ddlTrustedOrg.SelectedValue), ILocationID);
        }
        //else
        //{
        //    LoadToLocationName(OrgID, ILocationID);
        //}
    }


    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        Configuration_BL objGateway = new Configuration_BL(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig!=null && lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }

    protected void gvtranfer_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Intend ObjIntendTemp = new Intend();
                ObjIntendTemp = (Intend)e.Row.DataItem;
                //string strScript = "SelectIntendRowCommon('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + ObjIntendTemp.IntendID + "','" + ObjIntendTemp.Status + "','" + ObjIntendTemp.LocationID + "','" + ObjIntendTemp.IntendReceivedID + "','" + ObjIntendTemp.IntendReceivedDetailID + "','" + ObjIntendTemp.ToLocationID + "','" + ObjIntendTemp.RaiseOrgID + "','" + ObjIntendTemp.OrgID  + "');";
                string strScript = "";
                strScript = "SelectIntendRowCommon('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + ObjIntendTemp.IntendID + "','" + ObjIntendTemp.Status + "','" + ObjIntendTemp.LocationID + "','" + ObjIntendTemp.IntendReceivedID + "','" + ObjIntendTemp.IntendReceivedDetailID + "','" + ObjIntendTemp.ToLocationID + "','" + ObjIntendTemp.RaiseOrgID + "','" + ObjIntendTemp.OrgID  + "');";
                //if (CheckRaisedTo.Checked)
                {
                    strScript = "SelectIntendRowCommon('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + ObjIntendTemp.IntendID + "','" + ObjIntendTemp.Status + "','" + ObjIntendTemp.ToLocationID + "','" + ObjIntendTemp.IntendReceivedID + "','" + ObjIntendTemp.IntendReceivedDetailID + "','" + ObjIntendTemp.LocationID + "','" + ObjIntendTemp.RaiseOrgID + "','" + ObjIntendTemp.OrgID  + "');";
                }
                //
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.class='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
                RadioButton rdoSelect = (RadioButton)e.Row.FindControl("rdSel");
            }

            if (ddlIndentType.SelectedValue.Equals("0"))
            {
                gvIntend.Columns[7].Visible = false;
            }
            else
            {
                gvIntend.Columns[7].Visible = true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Intend.", ex);
        }
    }
    protected void gvtranfer_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvStockTansfer.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
    }


}
