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


public partial class StockIntend_RaiseIntend : Attune_BasePage
{
    public StockIntend_RaiseIntend()
        : base("StockIntend_RaiseIntend_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    InventoryCommon_BL inventoryBL;
    Intend objIntend;
    List<InventoryItemsBasket> lstProjectionLocation;
    List<InventoryItemsBasket> lstIntendBasket;
    List<KitStudyDetails> lstEpiKitDetails;
    List<KitStudyDetails> lstitemEpiKitDetails;
    List<Intend> lstIntend;
    long pIntendID = 0;
    string Comments = string.Empty;
    int ReceivedOrgID = -1;
    int ReceivedOrgAddID = -1;
    long TaskID = 0;
    List<Organization> lstorgn = new List<Organization>();
    List<Locations> lstloc = new List<Locations>();
    List<Locations> lstloc1 = new List<Locations>();

    DateTime DespatchDate;
    int MinimumShelfLife = 0;
    Int32 locid = 0;
    int EpiID = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        CtConfig.Value = GetConfigValue("CTORG", OrgID);
        if (!IsPostBack)
        {
            //LoadLocationName();

            HideOrShowUsageCount();
            HideOrShowTotalQty();
            txtOrderedUnit.Attributes.Add("class", "mini");
            string IsConsignConfig = string.Empty;
            IsConsignConfig = GetConfigValue("Is Consignment Product", OrgID);
            if (IsConsignConfig == "Y")
            {
                tdIsConsignment.Attributes.Remove("class");
                tdIsConsignment.Attributes.Add("class", "displaytd");
            }
            if (hdnEnablePackSize.Value == "N")
            {
                TdlblPackSize.Attributes.Add("class", "hide");
                TdTxtPackSize.Attributes.Add("class", "hide");
                txtOrderedUnit.Attributes.Add("class", "mini hide");
            }
            if (hdnTotalqty.Value == "N")
            {               
               TdlblTotQty.Attributes.Add("class", "hide");
               TdtxtTotQty.Attributes.Add("class", "hide");
            }
            if (GetInventoryConfigDetailsValue("Generate_Rejection_Intend", OrgID, 0).Equals("Y"))
            {
                hdnRejectionStatus.Value = "Y";
            }
            if (GetInventoryConfigDetailsValue("Generate_Automatic_Po", OrgID, 0).Equals("Y"))
            {
                hdnAutomaticPO.Value = "Y";
            }
            IsCtParentOrg();
            LoadOrgan();
            tdRaisedOnBehalf.Attributes.Add("class", "hide");
            tdddlBehalfOf.Attributes.Add("class", "hide");
            tdlblRejectComments.Attributes.Add("class", "hide");
            tdtxtRejectComments.Attributes.Add("class", "hide");
            // ddlTrustedOrg.SelectedValue = OrgID.ToString(); // for loading orgid in Raised Loc DropDown
            //InventoryCommon_BL inventoryBL1 = new InventoryCommon_BL(base.ContextInfo);
            TrustedOrg_BL lstTrustedOrg = new TrustedOrg_BL(base.ContextInfo);
            lstTrustedOrg.GetSharingOrgList(OrgID, out lstorgn, out lstloc);

            AutoCompleteExtender6.ContextKey = OrgID.ToString();
            if (CtConfig.Value == "Y")
            {
                btnBack.Attributes.Add("class", "hide");
                if (hdnIsCtParentOrg.Value == "Y")
                {
                    trSelectOption.Attributes.Add("class", "show");
                    tblProjection.Attributes.Add("class", "hide");
                    SetCTLabels();
                    lstloc = lstloc.FindAll(p => p.LocationTypeID == 4 && p.OrgID == OrgID).ToList();
                    hdnToLocationID.Value = lstloc[0].LocationID.ToString();
                    AutoCompleteProduct.ContextKey = "RAC" + "~" + Convert.ToInt32(hdnToLocationID.Value) + "~" + OrgID + "~" + txtMinimunlife.Text;
                    string sval = "RAC" + "~" + Convert.ToInt32(hdnToLocationID.Value) + "~" + OrgID + "~" + txtMinimunlife.Text + "~" + ddlOnBehalfOf.SelectedItem.Value;
                    AutoCompleteProduct.ContextKey = sval;
                }
                else
                {
                    List<Locations> lstlocforChildCT = new List<Locations>();
                    trSelectOption.Attributes.Add("class", "show");
                    tblProjection.Attributes.Add("class", "hide");
                    SetCTLabels();
                    lstlocforChildCT = lstloc.FindAll(p => p.LocationTypeID == 4 && p.OrgID == Int32.Parse(hdnParentOrgID.Value)).ToList();
                    hdnToLocationID.Value = lstlocforChildCT[0].LocationID.ToString();
                    AutoCompleteProduct.ContextKey = "RAC" + "~" + InventoryLocationID + "~" + OrgID + "~" + txtMinimunlife.Text + "~" + ddlOnBehalfOf.SelectedItem.Value;
                    string sval = "RAC" + "~" + InventoryLocationID + "~" + OrgID + "~" + txtMinimunlife.Text + "~" + ddlOnBehalfOf.SelectedItem.Value;
                    AutoCompleteProduct.ContextKey = sval;

                }
            }
            else
            {
                trSelectOption.Attributes.Add("class", "hide");
                tblProjection.Attributes.Add("class", "w-100p");
                if (Convert.ToInt16(ddlTrustedOrg.SelectedItem.Value) > 0)
                {
                    //AutoCompleteProduct.ContextKey = "RAC" + "~" + ddlLocation.SelectedItem.Value + "~" + ddlTrustedOrg.SelectedItem.Value + "~" + txtMinimunlife.Text;
                    string sval = "RAC" + "~" + ddlLocation.SelectedItem.Value + "~" + ddlTrustedOrg.SelectedItem.Value + "~" + txtMinimunlife.Text + "~" + ddlOnBehalfOf.SelectedItem.Value;
                    AutoCompleteProduct.ContextKey = sval;

                }
            }
            if (Request.QueryString["intID"] != null)
            {
                txtDate.Text = DateTimeUtility.GetServerDate().ToExternalDate();
                Int64.TryParse(Request.QueryString["intID"], out pIntendID);
                LoadIntendDetailGrid(pIntendID);
                trApproveBlock.Attributes.Add("class", "show");
                trSubmit.Attributes.Add("class", "hide");
            }
            else
            {
                txtDate.Text = DateTimeUtility.GetServerDate().ToExternalDate();
                LoadProjectionList();
                trApproveBlock.Attributes.Add("class", "hide");
            }

            HideOrShowUsageCount();


        }

        if (Convert.ToInt16(ddlTrustedOrg.SelectedItem.Value) > 0)
        { // ScriptManager.RegisterStartupScript(Page, GetType(), "ALt", "Setlocation();", true);
            //ddlLocation.Attributes.Add("onchange", "locationdetails()");
            AutoCompleteProduct.ContextKey = "RAC" + "~" + ddlLocation.SelectedItem.Value + "~" + ddlTrustedOrg.SelectedItem.Value + "~" + txtMinimunlife.Text + "~" + ddlOnBehalfOf.SelectedItem.Value;
        }

        if (GetInventoryConfigDetailsValue("HideInhandQty", OrgID, 0).Equals("Y"))
        {
            lblInhandQty.Attributes.Add("class", "hide");
            txtInhandQty.Attributes.Add("class", "hide");
            trShelfSize.Attributes.Add("class", "hide");
        }
        else
        {
            lblInhandQty.Attributes.Add("class", "tabletd w-20p");
            txtInhandQty.Attributes.Add("class", "w-20p");
            trShelfSize.Attributes.Add("class", "hide");
        }



        if (GetConfigValue("CTCHILDORG", OrgID) == "Y")
        {
            tdSitename1.Attributes.Add("class", "hide");
            tdSitename2.Attributes.Add("class", "hide");
        }
        if (hdnRejectionStatus.Value == "Y")
        {
            if (Request.QueryString["intID"] != null)
            {
                tdlblRejectComments.Attributes.Add("class", "show");
                tdtxtRejectComments.Attributes.Add("class", "show");
                ACX2responsesOPPmt.Attributes.Add("class", "hide");
                trApproveBlock.Attributes.Add("class", "hide");
                trSubmit.Attributes.Add("class", "tabletr");
            }
        }
    }


    private void LoadOrgan()
    {

        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        //inventoryBL = new Inventory_BL(base.ContextInfo);
        TrustedOrg_BL lstTrustedOrg = new TrustedOrg_BL(base.ContextInfo);
        lstTrustedOrg.GetSharingOrgList(OrgID, out lstorgn, out lstloc);
        ddlTrustedOrg.DataSource = lstorgn;

        ddlTrustedOrg.DataTextField = "Name";
        ddlTrustedOrg.DataValueField = "OrgID";
        ddlTrustedOrg.DataBind();
        ddlTrustedOrg.Items.Insert(0, GetMetaData("Select", "0"));
        ddlTrustedOrg.Items[0].Value = "0";


        #region Set Default ParentOrgID (used old config itself)
        int parentID = 0;
        List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
        new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("NeedTo_Show_All_VAT_Percentage", OrgID, ILocationID, out lstInventoryConfig);
        if (lstInventoryConfig != null && lstInventoryConfig.Count > 0)
        {
            if (lstInventoryConfig[0].ConfigValue == "Y")
            {
                if (lstorgn != null && lstorgn.Count > 0 && !string.IsNullOrEmpty(lstorgn[0].ParentOrgID.ToString()))
                {
                    parentID = lstorgn[0].ParentOrgID;
                    //ddlTrustedOrg.Items.FindByValue(lstorgn[0].ParentOrgID.ToString()).Selected = true;
                    //hdnToOrgID.Value = lstorgn[0].ParentOrgID.ToString();
                }
            }
        }
        if (lstorgn != null && lstorgn.Count > 0 && !string.IsNullOrEmpty(lstorgn[0].ParentOrgID.ToString()))
        {
            ddlTrustedOrg.SelectedValue = lstorgn[0].ParentOrgID.ToString();
        }
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadlocation", "Javascript:GetLocationlist();", true);

        #endregion

        lstloc.RemoveAll(P => P.LocationID == InventoryLocationID);
        if (GetInventoryConfigDetailsValue("DisasbleSubStoreRaiseIndent", OrgID, 0).Equals("Y"))
        {
            lstloc.RemoveAll(P => P.LocationTypeCode != "CS" && P.LocationTypeCode != "CS-POS");
        }
        ddlLocation.DataSource = lstloc;
        ddlLocation.DataTextField = "LocationName";
        ddlLocation.DataValueField = "LocationID";
        ddlLocation.DataBind();
        ddlLocation.Items.Insert(0, GetMetaData("Select", "0"));
        //lstloc.RemoveAll(P => P.LocationID == InventoryLocationID);
        foreach (var item in lstloc)
        {
            hdnlocation.Value += item.OrgID + "~" + item.LocationID + "~" + item.LocationName + "~" + Convert.ToString(item.IsDefaults) + "^";

        }
        if (hdnIsCtParentOrg.Value == "Y")
        {
            //TrustedOrg_BL lstTrustedOrg = new TrustedOrg_BL(base.ContextInfo);
            lstTrustedOrg.GetSharingOrgList(OrgID, out lstorgn, out lstloc);

            ddlBehalfOfTrustedOrg.DataSource = lstorgn;
            ddlBehalfOfTrustedOrg.DataTextField = "Name";
            ddlBehalfOfTrustedOrg.DataValueField = "OrgID";
            ddlBehalfOfTrustedOrg.DataBind();
            ddlBehalfOfTrustedOrg.Items.Insert(0, GetMetaData("Select", "0"));
            ddlBehalfOfTrustedOrg.Items[0].Value = "0";
            ddlBehalfOfTrustedOrg.SelectedValue = OrgID.ToString();
            if (lstorgn.Count == 1)
            {
                ddlBehalfOfTrustedOrg.SelectedValue = OrgID.ToString();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadlocation", "Javascript:GetBehalfOfLocationlist();", true);
            }
            lstloc = lstloc.FindAll(P => P.OrgID == OrgID);
            ddlOnBehalfOf.DataSource = lstloc;
            ddlOnBehalfOf.DataTextField = "LocationName";
            ddlOnBehalfOf.DataValueField = "LocationID";
            ddlOnBehalfOf.DataBind();
            ddlOnBehalfOf.Items.Insert(0, GetMetaData("Select", "0"));
            //lstloc.RemoveAll(P => P.LocationID == InventoryLocationID);
            foreach (var item in lstloc)
            {
                hdnBehalfOflocation.Value += item.OrgID + "~" + item.LocationID + "~" + item.LocationName + "^";

            }
        }
        else
        {
            //If Org is Not CT and also Not Parrent Org
            //TrustedOrg_BL lstTrustedOrg = new TrustedOrg_BL(base.ContextInfo);
            lstTrustedOrg.GetSharingOrgList(OrgID, out lstorgn, out lstloc);
            lstorgn = lstorgn.FindAll(p => p.OrgID == OrgID);
            ddlBehalfOfTrustedOrg.DataSource = lstorgn;
            ddlBehalfOfTrustedOrg.DataTextField = "Name";
            ddlBehalfOfTrustedOrg.DataValueField = "OrgID";
            ddlBehalfOfTrustedOrg.DataBind();
            ddlBehalfOfTrustedOrg.Items.Insert(0, GetMetaData("Select", "0"));
            ddlBehalfOfTrustedOrg.Items[0].Value = "0";
            if (lstorgn.Count == 1)
            {
                ddlBehalfOfTrustedOrg.SelectedValue = OrgID.ToString();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadlocation", "Javascript:GetBehalfOfLocationlist();", true);
            }

            new Master_BL(base.ContextInfo).GetInvLocationDetail(OrgID, ILocationID, out lstloc1);
            //  lstloc1 = lstloc.FindAll (P =>P.OrgID == Convert.ToInt16(OrgID) );
            ddlOnBehalfOf.DataSource = lstloc1;
            ddlOnBehalfOf.DataTextField = "LocationName";
            ddlOnBehalfOf.DataValueField = "LocationID";
            ddlOnBehalfOf.DataBind();
            ddlOnBehalfOf.Items.Insert(0, GetMetaData("Select", "0"));
            locid = InventoryLocationID;
            ddlOnBehalfOf.SelectedItem.Value = locid.ToString();
            foreach (var item in lstloc)
            {
                hdnBehalfOflocation.Value += item.OrgID + "~" + item.LocationID + "~" + item.LocationName + "^";

            }
        }
        //  new Inventory_BL(base.ContextInfo).GetInvLocationDetail(OrgID, ILocationID, out lstloc1);
        ////  lstloc1 = lstloc.FindAll (P =>P.OrgID == Convert.ToInt16(OrgID) );
        //  ddlOnBehalfOf.DataSource = lstloc1;
        //  ddlOnBehalfOf.DataTextField = "LocationName";
        //  ddlOnBehalfOf.DataValueField = "LocationID";
        //  ddlOnBehalfOf.DataBind();
        //  ddlOnBehalfOf.Items.Insert(0, new ListItem("--Select--", "0"));
        //  locid = InventoryLocationID;
        // // ddlOnBehalfOf.SelectedItem.Value = Convert.ToInt32(locid.ToString());

        //ddlOnBehalfOf.SelectedItem.Value=InventoryLocationID   
    }


    private void LoadProjectionList()
    {
        try
        {
            inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            lstProjectionLocation = new List<InventoryItemsBasket>();
            inventoryBL.GetProjectionListDetail(InventoryLocationID, OrgID, ILocationID, out lstProjectionLocation);
            if (lstProjectionLocation.Count > 0)
            {
                hdncontrols.Value = string.Empty;
                gvIntendProjectionList.DataSource = lstProjectionLocation;
                gvIntendProjectionList.DataBind();
                ACX2OPPmt.Attributes.Add("class", "hide");
                ACX2minusOPPmt.Attributes.Add("class", "show");
                ACX2responsesOPPmt.Attributes.Add("class", "show");
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Loading Location - ProjectionListViewDetail.aspx", Ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    private void LoadLocationName()
    {
        try
        {
            List<Locations> lstLocation = new List<Locations>();
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            int OrgAddid = 0;
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
            new Master_BL(base.ContextInfo).GetInvLocationDetail(OrgID, OrgAddid, out lstLocation);
            lstLocation.Remove(lstLocation.Find(p => p.LocationID == InventoryLocationID));
            lstLocation.Remove(lstLocation.Find(p => p.LocationTypeCode == "POS" || p.LocationTypeCode == "POD"));
            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "LocationName";
            ddlLocation.DataValueField = "LocationID";
            ddlLocation.DataBind();
            ddlLocation.Items.Insert(0, GetMetaData("Select", "0"));



        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Location Details", Ex);
        }
    }

    private void LoadIntendDetailGrid(long pIntendID)
    {
        try
        {
            inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            objIntend = new Intend();
            lstProjectionLocation = new List<InventoryItemsBasket>();
            lstIntend = new List<Intend>();
            //inventoryBL.GetIntendDetail(pIntendID, objIntend.LocationID, OrgID, ILocationID, out lstProjectionLocation, out lstIntend);
            new StockIndent_BL(base.ContextInfo).GetInventoryIndentDetails(pIntendID, objIntend.LocationID, OrgID, ILocationID, objIntend.RaiseOrgID, objIntend.ToLocationID, out lstProjectionLocation, out lstIntend);

            if (lstProjectionLocation.Count > 0)
            {
                hdncontrols.Value = string.Empty;
                gvIntendProjectionList.DataSource = lstProjectionLocation;
                gvIntendProjectionList.DataBind();
                ACX2OPPmt.Attributes.Add("class", "hide");
                ACX2minusOPPmt.Attributes.Add("class", "show");
                ACX2responsesOPPmt.Attributes.Add("class", "show");
                if (lstIntend.Count > 0)
                {

                    ddlLocation.SelectedItem.Value = lstIntend[0].ToLocationID.ToString();
                }
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Loading Location - IntendViewDetail.aspx", Ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    protected void btnRaiseIntend_Click(object sender, EventArgs e)
    {
        btnRaiseIntend.Enabled = false;
        long returnCode = -1;
        long returnCod = -1;
        long pIndID = 0;
        objIntend = new Intend();
        lstIntendBasket = new List<InventoryItemsBasket>();
        if (Request.QueryString["intID"] != null)
        {
            Int64.TryParse(Request.QueryString["intID"], out pIntendID);
            objIntend.IntendID = pIntendID;
        }
        if (CtConfig.Value == "Y")
        {
            int LocationID = 0;
            if (hdnInventoryLocationID.Value != "")
            {
                Int32.TryParse(hdnInventoryLocationID.Value, out LocationID);
            }
            else
            {
                Int32.TryParse(hdnLocationID.Value, out LocationID);
            }
            objIntend.LocationID = LocationID;
            objIntend.ToLocationID = Convert.ToInt32(hdnToLocationID.Value);
            objIntend.RaiseOrgID = Convert.ToInt32(hdnToOrgID.Value);
        }
        else
        {
            objIntend.LocationID = InventoryLocationID;
            objIntend.ToLocationID = Convert.ToInt16(ddlLocation.SelectedItem.Value) == 0 ? 0 : Convert.ToInt16(ddlLocation.SelectedItem.Value);
            objIntend.RaiseOrgID = int.Parse(hdnSelectOrgid.Value);
        }

        objIntend.IntendDate = DateTimeUtility.GetServerDate();

        //if (GetConfigValue("Required_intend_Approval", OrgID).Equals("Y"))
        if (GetInventoryConfigDetailsValue("Required_intend_Approval", OrgID, 0).Equals("Y"))
        {
            objIntend.Status = StockOutFlowStatus.Pending;
        }
        else
        {
            objIntend.Status = StockOutFlowStatus.Approved;
        }
        objIntend.CreatedBy = LID;
        objIntend.OrgID = OrgID;
        objIntend.OrgAddressID = ILocationID;
        objIntend.Comments = txtComments.Text;
        lstIntendBasket = GetIntendList();
        MinimumShelfLife = Convert.ToInt16(txtMinimunlife.Text) > 0 ? Convert.ToInt16(txtMinimunlife.Text) : 0;
        DespatchDate = txtDate.Text.ToInternalDate();
        lstitemEpiKitDetails = GetKitStudyDetails();

        if (lstIntendBasket.Count > 0)
        {
            inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            returnCode = inventoryBL.SaveIntend(objIntend, lstIntendBasket, MinimumShelfLife, DespatchDate, out pIndID, out TaskID);
            hdnIndentId.Value = pIndID.ToString();
            if (lstitemEpiKitDetails.Count > 0)
            {
                returnCod = inventoryBL.SaveKitStudyDetails(pIndID, lstitemEpiKitDetails);
            }
        }
        else
        {
            string sPath = "Inventory\\\\RaiseIntend.aspx.cs_30";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "CheckProduct", "javascript:ShowAlertMsg('" + sPath + "');", true);
            btnRaiseIntend.Enabled = true;
        }
        if (pIndID > 0)
        {
            Response.Redirect(@"~/StockIntend/ViewIntendDetail.aspx?intID=" + pIndID.ToString());
        }
        else
        {
            //ErrorDisplay1.Visible = true;
            //ErrorDisplay1.Status = "Indent Saving Failed";
        }
    }

    private List<InventoryItemsBasket> GetIntendList()
    {

        InventoryItemsBasket newBasket;
        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
        List<InventoryItemsBasket> lstInventoryItemsBasketForKit = new List<InventoryItemsBasket>();
        if (!string.IsNullOrEmpty(hdnProductList.Value))
        {
            lstInventoryItemsBasket = new JavaScriptSerializer().Deserialize<List<InventoryItemsBasket>>(hdnProductList.Value);
			 if (hdnEnablePackSize.Value == "Y")
            {
                lstInventoryItemsBasket.ForEach(p => p.Quantity = p.TotalQty);
            }
        }
      /*  foreach (string listParent in hdnProductList.Value.Split('^'))
        {
            if (listParent != "")
            {
                string Isreimbursable = string.Empty;
                newBasket = new InventoryItemsBasket();
                string[] listChild = listParent.Split('~');
                newBasket.ProductID = Convert.ToInt64(listChild[1]);
                newBasket.SellingUnit = listChild[4];
                newBasket.ProductName = listChild[0];
                newBasket.Quantity = Convert.ToDecimal(listChild[5]);
                newBasket.ExpiryDate = DateTimeUtility.GetServerDate();
                newBasket.Manufacture = DateTimeUtility.GetServerDate();
                newBasket.ParentProductID = Convert.ToInt64(listChild[3]);
                if (hdnEnablePackSize.Value == "Y")
                {
                    newBasket.Quantity = Convert.ToDecimal(listChild[5]) * Convert.ToDecimal(listChild[6]);
                    
                }
                newBasket.ProductReceivedDetailsID = Convert.ToInt64(listChild[9]);
                lstInventoryItemsBasket.Add(newBasket);
            }
        } */
        foreach (string listParent in hdnKitList.Value.Split('^'))
        {
            if (listParent != "")
            {
                string Isreimbursable = string.Empty;
                newBasket = new InventoryItemsBasket();
                string[] listChild = listParent.Split('~');
                newBasket.ProductID = Convert.ToInt64(listChild[1]);
                newBasket.SellingUnit = listChild[4];
                newBasket.ProductName = listChild[0];
                // newBasket.Quantity = Convert.ToDecimal(listChild[5]);
                newBasket.RECQuantity = Convert.ToDecimal(listChild[6]);
                newBasket.ExpiryDate = DateTimeUtility.GetServerDate();
                newBasket.Manufacture = DateTimeUtility.GetServerDate();
                newBasket.ParentProductID = Convert.ToInt64(listChild[3]);
                newBasket.Providedby = Convert.ToInt64(listChild[3]);
                lstInventoryItemsBasketForKit.Add(newBasket);
            }
        }
        if (lstInventoryItemsBasketForKit.Count > 0)
        {
            IEnumerable<InventoryItemsBasket> FilterValue = (from list in lstInventoryItemsBasketForKit
                                                             group list by new
                                                             {
                                                                 list.ProductID,
                                                                 list.SellingUnit,
                                                                 list.ProductName,
                                                                 list.ExpiryDate,
                                                                 list.Manufacture,
                                                                 list.parentProductID,
                                                                 list.Providedby
                                                             } into g1
                                                             select new InventoryItemsBasket
                                                             {
                                                                 ProductID = g1.Key.ProductID,
                                                                 SellingUnit = g1.Key.SellingUnit,
                                                                 ProductName = g1.Key.ProductName,
                                                                 Quantity = g1.Sum(Q => Q.RECQuantity),
                                                                 ExpiryDate = g1.Key.ExpiryDate,
                                                                 Manufacture = g1.Key.Manufacture,
                                                                 ParentProductID = g1.Key.parentProductID,
                                                                 Providedby = g1.Key.parentProductID
                                                             }).ToList();

            foreach (InventoryItemsBasket ob in FilterValue)
            {
                lstInventoryItemsBasket.Add(ob);

            }
        }
        return lstInventoryItemsBasket;
    }



    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect(@"~/StockIntend/Intend.aspx");
    }

    protected void btnAddNew_Click1(object sender, EventArgs e)
    {
        try
        {
            lstProjectionLocation = new List<InventoryItemsBasket>();
            InventoryItemsBasket objtemp = new InventoryItemsBasket();
            lstProjectionLocation = GetTempIntendList();
            objtemp.ProductID = Int64.Parse(hdnProductID.Value);
            objtemp.SellingUnit = hdnSellingUnit.Value;
            objtemp.ProductName = txtProductName.Text;
            objtemp.Quantity = Decimal.Parse(txtQuantity.Text);


            objtemp.InHandQuantity = Decimal.Parse(txtInhandQuantity.Text);
            objtemp.BatchNo = hdnBatchNo.Value;
            objtemp.ParentProductID = Int64.Parse(hdnPProductID.Value);

            lstProjectionLocation.Add(objtemp);

            hdncontrols.Value = string.Empty;
            gvIntendProjectionList.DataSource = lstProjectionLocation;
            gvIntendProjectionList.DataBind();
            //ddlLocation.SelectedItem.Value = hdnSelectLocation.Value; 
            ACX2OPPmt.Attributes.Add("class", "hide");
            ACX2minusOPPmt.Attributes.Add("class", "show");
            ACX2responsesOPPmt.Attributes.Add("class", "show");
            txtQuantity.Text = string.Empty;
            hdnProductID.Value = "";
            hdnSellingUnit.Value = "";
            hdnBatchNo.Value = "";
            txtUnit.Text = string.Empty;
            txtProductName.Text = string.Empty;
            txtInhandQuantity.Text = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Adding New Product - IndentViewDetail.aspx", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    private List<InventoryItemsBasket> GetTempIntendList()
    {
        InventoryItemsBasket objtemp;
        lstProjectionLocation = new List<InventoryItemsBasket>();
        foreach (GridViewRow item in gvIntendProjectionList.Rows)
        {
            objtemp = new InventoryItemsBasket();
            CheckBox chkUpdate = (CheckBox)item.FindControl("chkProduct");
            objtemp.ProductID = Convert.ToInt64(((HiddenField)item.FindControl("hdnProductID")).Value);

            objtemp.ID = Convert.ToInt64(((HiddenField)item.FindControl("hdnID")).Value);
            objtemp.SellingUnit = ((HiddenField)item.FindControl("hdnUnit")).Value;
            objtemp.Quantity = Convert.ToDecimal(((TextBox)item.FindControl("txtQuantity")).Text);
            objtemp.ProductName = ((Label)item.FindControl("lblProductName")).Text;
            objtemp.ExpiryDate = DateTimeUtility.GetServerDate();
            objtemp.Manufacture = DateTimeUtility.GetServerDate();
            objtemp.InHandQuantity = Convert.ToDecimal(((TextBox)item.FindControl("txtInhandQty")).Text);
            objtemp.BatchNo = ((HiddenField)item.FindControl("hdnBatchNo")).Value;
            objtemp.ParentProductID = Convert.ToInt64(((HiddenField)item.FindControl("hdnParentProductID")).Value);
            if (CtConfig.Value == "Y")
            {
                objtemp.ReceivedOrgID = Convert.ToInt32(hdnToOrgID.Value);//Convert.ToInt32(hdnSelectOrgid.Value);
            }
            else
            {
                objtemp.ReceivedOrgID = Convert.ToInt32(hdnSelectOrgid.Value);
            }
            objtemp.LocationID = Convert.ToInt16(hdnSelectLocation.Value);
            lstProjectionLocation.Add(objtemp);
        }
        return lstProjectionLocation;
    }

    protected void btnApproveIntend_Click(object sender, EventArgs e)
    {
        try
        {

            long returnCode = -1;
            long pIndID = 0;
            objIntend = new Intend();
            inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            lstIntendBasket = new List<InventoryItemsBasket>();
            if (Request.QueryString["intID"] != null)
            {
                Int64.TryParse(Request.QueryString["intID"], out pIntendID);
                objIntend.IntendID = pIntendID;
            }
            objIntend.Status = StockOutFlowStatus.Approved;
            objIntend.CreatedBy = LID;
            objIntend.IntendDate = DateTimeUtility.GetServerDate();
            objIntend.OrgID = OrgID;
            objIntend.OrgAddressID = ILocationID;
            objIntend.LocationID = InventoryLocationID;
            objIntend.ToLocationID = int.Parse(hdnSelectOrgid.Value);
            objIntend.RaiseOrgID = int.Parse(hdnSelectOrgid.Value);
            lstIntendBasket = GetIntendList();
            MinimumShelfLife = Convert.ToInt16(txtMinimunlife.Text);
            DespatchDate = Convert.ToDateTime(txtDate.Text);
            if (lstIntendBasket.Count > 0)
            {
                returnCode = inventoryBL.SaveIntend(objIntend, lstIntendBasket, MinimumShelfLife, DespatchDate, out pIndID, out TaskID);
                if (returnCode == 0)
                {
                    Response.Redirect(@"~/StockIntend/ViewIntendDetail.aspx?intID=" + pIntendID.ToString());
                }
                else
                {
                    //ErrorDisplay1.ShowError = true;
                    //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
                }
            }
            else
            {
                string sPath = "Inventory\\\\RaiseIntend.aspx.cs_30";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "CheckProduct", "javascript:ShowAlertMsg('" + sPath + "');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "CheckProduct", "javascript:alert('Select atleast one product');", true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Updating Approval details in Intend.aspx", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    protected void btnCancelIntend_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            long orderID = 0;
            if (Request.QueryString["intID"] != null)
            {
                orderID = Int64.Parse(Request.QueryString["intID"]);
                hdnintID.Value = Request.QueryString["intID"];
            }
            string status = StockOutFlowStatus.Cancelled;
            returnCode = inventoryBL.UpdateInventoryApproval("Intend", orderID, status, LID, OrgID, ILocationID);
            Response.Redirect(@"~/StockIntend/ViewIntendDetail.aspx?intID=" + orderID.ToString());
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Updating Approval details in Intend.aspx", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    protected void gvIntendProjectionList_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        //if (Request.QueryString["intID"] == null)
        //{
        //    e.Row.Cells[3].Visible = false;
        //}
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            hdncontrols.Value += ((CheckBox)e.Row.FindControl("chkProduct")).ClientID + "~" + ((TextBox)e.Row.FindControl("txtQuantity")).ClientID + "~" + ((TextBox)e.Row.FindControl("txtInhandQty")).ClientID + "~" + ((TextBox)e.Row.FindControl("txtInhandQty")).ClientID + "^";
        }
    }




    protected void btnViewEpiDetails_Click(object sender, EventArgs e)
    {
        try
        {
            inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            List<EpisodeVisitDetails> lstEpisode = new List<EpisodeVisitDetails>();
            List<ProductEpisodeVisitMapping> lstProducts = new List<ProductEpisodeVisitMapping>();
            EpiID = Convert.ToInt32(hdnProtocalID.Value);
            //hdnSiteID.Value = EpiID.ToString();
            int InvLocID = 0;
            if (CtConfig.Value == "Y")
            {
                if (hdnInventoryLocationID.Value != "")
                {
                    Int32.TryParse(hdnInventoryLocationID.Value, out InvLocID);
                }
                else
                {
                    Int32.TryParse(hdnLocationID.Value, out InvLocID);
                    // InvLocID = Convert.ToInt32(hdnLocationID.Value);//Convert.ToInt32(ddlOnBehalfOf.SelectedValue);
                }

            }
            else
            {
                InvLocID = Convert.ToInt32(ddlOnBehalfOf.SelectedValue);
            }
            inventoryBL.GetProtocalDetails(EpiID, OrgID, InvLocID, out lstEpisode, out lstProducts);

            //Convert ListValue in to HiddenValue
            string ProductsList = string.Empty;
            JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
            ProductsList = oJavaScriptSerializer.Serialize(lstProducts);
            hdnProductsList.Value = ProductsList;

            ACX2responsesOPPmt.Attributes.Add("class", "hide");
            //if (lstEpisode.Count > 0)
            //{
            GrdEpisodeDetails.DataSource = lstEpisode;
            GrdEpisodeDetails.DataBind();
            // }
            if (hdnProductList.Value != "")
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "IsDefault", "Tblist(); SelectOption();GetBehalfOfLocationlist();setBehalfOflocationdetails(" + hdnBehalfOfSelectLocation.Value + ");", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "IsDefault", "SelectOption();GetBehalfOfLocationlist();setBehalfOflocationdetails(" + hdnBehalfOfSelectLocation.Value + ")", true);
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Loading ", Ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }

    }
    protected void GrdEpisodeDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        string Kitdetails = string.Empty;
        string NoOfKits = string.Empty;
        long kitId = 0;
        string description = string.Empty;
        EpisodeVisitDetails L1 = (EpisodeVisitDetails)e.Row.DataItem;

        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            Label kitName = (Label)e.Row.FindControl("lblKitName");
            TextBox NoKits = (TextBox)e.Row.FindControl("txtNoOfKits");
            Label lblNoKits = (Label)e.Row.FindControl("lblNoOfKits");
            CheckBox chkVisit = (CheckBox)e.Row.FindControl("chkVisit");
            Label lblStockinhand = (Label)e.Row.FindControl("lblStockInhand");
            Label lblUnit = (Label)e.Row.FindControl("lblUnit");
            Label lblKitID = (Label)e.Row.FindControl("lblKitID");
            HiddenField hdnNoOfsites = (HiddenField)e.Row.FindControl("hdnNoOfsites");
            Label lblParentProductID = (Label)e.Row.FindControl("lblParentProductID");
            // Kitdetails= CustomiseAttributeString(kitName.Text);

            Kitdetails = (kitName.Text);
            kitName.Text = Kitdetails.Split('~')[1];
            NoOfKits = Kitdetails.Split('~')[2];
            NoKits.Text = (Convert.ToUInt32(NoOfKits) * (Convert.ToInt32(hdnNoOfsites.Value) / Convert.ToInt32(NoOfKits))).ToString();
            lblNoKits.Text = (Convert.ToUInt32(NoOfKits) * (Convert.ToInt32(hdnNoOfsites.Value) / Convert.ToInt32(NoOfKits))).ToString();
            //NoKits.Text = hdnNoOfsites.Value * NoOfKits;
            kitId = Convert.ToInt64(Kitdetails.Split('~')[0]);
            long StudyID = -1;
            long SiteID = -1;
            long EpisodeVisitID = -1;
            int LocationID = -1;
            string IsIssued = "N";
            StudyID = L1.EpisodeID;
            SiteID = L1.SiteID;
            EpisodeVisitID = L1.EpisodeVisitId;
            if (CtConfig.Value == "Y")
            {
                if (hdnInventoryLocationID.Value != "")
                {
                    Int32.TryParse(hdnInventoryLocationID.Value, out LocationID);
                }
                else
                {
                    Int32.TryParse(hdnLocationID.Value, out LocationID);
                    //LocationID = Convert.ToInt32(hdnLocationID.Value);//Convert.ToInt32(ddlOnBehalfOf.SelectedValue);
                }
            }
            else
            {
                LocationID = Convert.ToInt32(ddlOnBehalfOf.SelectedValue);
            }
            string Description = GetKitdetils(kitId, StudyID, SiteID, EpisodeVisitID, LocationID, out IsIssued);
            if (IsIssued == "Y")
            {
                chkVisit.Enabled = true;
                chkVisit.Checked = true;
            }
            var Val = Description.Split('~');
            lblStockinhand.Text = Val[5];
            lblUnit.Text = Val[2];
            lblKitID.Text = Val[1];
            lblParentProductID.Text = Val[3];
        }
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.Header)
        {
            e.Row.Cells[7].Attributes.Add("class", "hide");
            e.Row.Cells[9].Attributes.Add("class", "hide");
            e.Row.Cells[10].Attributes.Add("class", "hide");
            e.Row.Cells[11].Attributes.Add("class", "hide");
            e.Row.Cells[12].Attributes.Add("class", "hide");
        }


    }
    string CustomiseAttributeString(string XMLString)
    {
        string HdnText = string.Empty;
        XmlDocument Doc = new XmlDocument();
        Doc.LoadXml(XMLString);
        string str = Doc.InnerXml;
        int count = Doc.GetElementsByTagName("KitDetails").Count;
        foreach (XmlNode xmNode in Doc.GetElementsByTagName("KitDetail"))
        {
            //HdnText =xmNode["Name"].InnerText;
            HdnText += xmNode["ID"].InnerText + "~" + xmNode["Name"].InnerText + "~" + xmNode["Value"].InnerText;

        }


        return HdnText;
    }

    public string GetKitdetils(long productID, long StudyID, long SiteID, long EpisodeVisitID, int CurrenrtInvLocationID, out string IsIssued)
    {
        IsIssued = string.Empty;
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        List<Products> lstProducts = new List<Products>();
        int OrgAddressID = ILocationID;
        int ToLocationID = 0;
        if (CtConfig.Value == "Y")
        {
            ToLocationID = Convert.ToInt32(hdnToLocationID.Value);//Convert.ToInt32(ddlLocation.SelectedValue);
        }
        else
        {
            ToLocationID = Convert.ToInt32(ddlLocation.SelectedValue);
        }
        string Description = string.Empty;
        inventoryBL.GetProtocolKitdetails(OrgID, OrgAddressID, ToLocationID, productID, StudyID, SiteID, EpisodeVisitID, CurrenrtInvLocationID, out lstProducts);
        if (lstProducts.Count > 0)
        {
            Description = lstProducts[0].Description;
            IsIssued = lstProducts[0].Specification1;
        }
        return Description;
    }

    private List<KitStudyDetails> GetKitStudyDetails()
    {

        KitStudyDetails ObjEpi;
        lstEpiKitDetails = new List<KitStudyDetails>();
        foreach (string listParent in hdnKitstudyDetails.Value.Split('^'))
        {
            if (listParent != "")
            {
                string Isreimbursable = string.Empty;
                ObjEpi = new KitStudyDetails();
                string[] listChild = listParent.Split('~');
                ObjEpi.KitID = listChild[0];
                ObjEpi.SiteID = Convert.ToInt64(listChild[1]);
                ObjEpi.EpisodeVisitId = Convert.ToInt32(listChild[2]);
                ObjEpi.OrgID = OrgID;
                ObjEpi.ActualRaiseQty = Convert.ToInt32(listChild[3]);
                ObjEpi.RaisedQty = Convert.ToInt32(listChild[4]);
                ObjEpi.StudyID = Convert.ToInt64(hdnProtocalID.Value);
                if (CtConfig.Value == "Y")
                {
                    ObjEpi.ToLocationID = Convert.ToInt32(hdnToLocationID.Value);//Convert.ToInt32(ddlLocation.SelectedValue);
                    int LocationID = 0;
                    if (hdnInventoryLocationID.Value != "")
                    {
                        Int32.TryParse(hdnInventoryLocationID.Value, out LocationID);
                    }
                    else
                    {
                        Int32.TryParse(hdnLocationID.Value, out LocationID);
                        //LocationID = Convert.ToInt32(hdnLocationID.Value);//Convert.ToInt32(ddlOnBehalfOf.SelectedValue);
                    }

                    ObjEpi.LocationID = LocationID;// Convert.ToInt32(hdnLocationID.Value);//Convert.ToInt32(ddlOnBehalfOf.SelectedValue);
                }
                else
                {
                    ObjEpi.ToLocationID = Convert.ToInt32(ddlLocation.SelectedValue);
                    ObjEpi.LocationID = Convert.ToInt32(ddlOnBehalfOf.SelectedValue);
                }
                ObjEpi.OrgAddID = ILocationID;
                lstEpiKitDetails.Add(ObjEpi);
            }
        }
        return lstEpiKitDetails;
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
    public void IsCtParentOrg()
    {
        string CTORG = "N";
        hdnIsCtParentOrg.Value = "N";
        if (!string.IsNullOrEmpty(GetConfigValue("CTORG", OrgID)))
        {
            CTORG = GetConfigValue("CTORG", OrgID);
        }
        if (CTORG == "Y")
        {
            List<Organization> lstOrganisation = new List<Organization>();
            List<Organization> lstOrganisationParent = new List<Organization>();
            long lresult = new Organization_BL(base.ContextInfo).pGetOrgLoction(out lstOrganisation);
            lstOrganisationParent = lstOrganisation.FindAll(p => p.OrgID == p.ParentOrgID && p.OrgID == OrgID);
            if (lstOrganisationParent.Count > 0)
            {
                hdnIsCtParentOrg.Value = "Y";

            }
            else
            {
                lstOrganisation = lstOrganisation.FindAll(p => p.OrgID == OrgID);
                int ParentOrgID = lstOrganisation[0].ParentOrgID;
                hdnParentOrgID.Value = ParentOrgID.ToString();
                hdnInventoryLocationID.Value = InventoryLocationID.ToString();
                hdnToOrgID.Value = ParentOrgID.ToString();
                hdnLocationID.Value = InventoryLocationID.ToString();
                AutoCompleteProduct1.ContextKey = "RAC" + "~" + InventoryLocationID + "~" + OrgID + "~" + "0";
            }
        }

    }
    string strSelectCT=Resources.StockIntend_ClientDisplay.StockIntend_RaiseIntend_aspx_13;
    string strCRO = Resources.StockIntend_ClientDisplay.StockIntend_RaiseIntend_aspx_14;
    string strIntendcorp = Resources.StockIntend_ClientDisplay.StockIntend_RaiseIntend_aspx_15;
    string strIntendbehaf = Resources.StockIntend_ClientDisplay.StockIntend_RaiseIntend_aspx_16;
	
	
    private void SetCTLabels()
    {
        lablTrusted.Text = strSelectCT;
        lblBehalfOrg.Text = strCRO;
        lblIntentToLoc.Text = strIntendcorp;
        lblBehalfLoc.Text = strIntendbehaf;


    }
    public long SendSMS()
    {
        long retrunCode = -1;
        List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
        ActionManager am = new ActionManager(base.ContextInfo);
        List<NotificationAudit> NotifyAudit = new List<NotificationAudit>();
        PageContextkey PC = new PageContextkey();
        if (Request.QueryString["intID"] != null)
        {
            Int64.TryParse(Request.QueryString["intID"], out pIntendID);
        }
        PC.PatientID = Convert.ToInt32(hdnLocationID.Value);
        PC.RoleID = Convert.ToInt64(RoleID);
        PC.OrgID = OrgID;
        PC.ButtonName = btnRaiseIntend.ID;
        PC.ButtonValue = btnRaiseIntend.Text;
        PC.ID = Convert.ToInt64(hdnIndentId.Value);
        PC.PageID = Convert.ToInt64(hdnProtocalID.Value);
        PC.ContextType = "RaiseIndent";
        lstpagecontextkeys.Add(PC);
        retrunCode = am.PerformingMultipleNextStep(lstpagecontextkeys);
        return retrunCode;
    }


    public string GetInventoryConfigDetailsValue(string configKey, int orgID, int OrgAddressID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        Configuration_BL objGateway = new Configuration_BL(new Attune_BaseClass().ContextInfo);
        List<InventoryConfig> lstConfig = new List<InventoryConfig>();

        returncode = objGateway.GetInventoryConfigDetails(configKey, orgID, OrgAddressID, out lstConfig);
        if (lstConfig!=null && lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
    protected void HideOrShowUsageCount()
    {
        List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
        new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("EnablePackSize", OrgID, ILocationID, out lstInventoryConfig);
        if (lstInventoryConfig.Count > 0)
        {

            hdnEnablePackSize.Value = lstInventoryConfig[0].ConfigValue;


        }
        else
        {

            hdnEnablePackSize.Value = "N";
        }

    }
    protected void HideOrShowTotalQty()
    {
        List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
        new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("TotalSize", OrgID, ILocationID, out lstInventoryConfig);
        if (lstInventoryConfig.Count > 0)
        {

            hdnTotalqty.Value = lstInventoryConfig[0].ConfigValue;


        }
        else
        {

            hdnTotalqty.Value = "N";
        }

    }

}

