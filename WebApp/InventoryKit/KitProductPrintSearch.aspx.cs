using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Data.SqlClient;
using Attune.Kernel.BusinessEntities;
using System.Text.RegularExpressions;
using Attune.Kernel.PlatForm.Utility;
//using Attune.Utilitie.Helper;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryKit.BL;
using Attune.Kernel.PlatForm.BL;


public partial class InventoryKit_KitProductPrintSearch :Attune_BasePage 
{
    public InventoryKit_KitProductPrintSearch()
        : base("InventoryKit_KitProductPrintSearch_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    string strBillFromDate = string.Empty;
    string strBillToDate = string.Empty;
     string KitBatchNo = string.Empty;
     string Status = string.Empty;
    long KitID=0;
    List<InventoryItemsBasket> lstKitDetail = new List<InventoryItemsBasket>();
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    List<KitMaster> lstKitMaster = new List<KitMaster>();
    InventoryKit_BL inventoryKitBL;
    //static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryKitBL = new InventoryKit_BL(base.ContextInfo);
        if (!IsPostBack)
        {

            loadKitNames();
            LoadStatus();
            LoadRegDate();
           // txtFrom.Text = dat.ToString("dd/MM/yyyy"); 

            KitBatchNo = txtKitBatchNo.Text == "" ? "" : txtKitBatchNo.Text.Trim();
            KitID = ddlKitNames.SelectedItem.Value == "0" ? 0 : Convert.ToInt64(ddlKitNames.SelectedValue);
            Status = ddlStatus.SelectedItem.Value == "0" ? "" : ddlStatus.SelectedItem.Text ;
            DateTime d = DateTimeUtility.GetServerDate();
            DateTime dat = new DateTime(d.Year, d.Month, 1);
            strBillFromDate =  dat.ToString(); 
            strBillToDate  = DateTimeUtility.GetServerDate().ToString();
            loadKitproductSearch(KitID, KitBatchNo, strBillFromDate, strBillToDate,Status);
          
            loadActionList();
            

            #region currentWeek
            DateTime dt = DateTimeUtility.GetServerDate();
            DateTime wkStDt = DateTime.MinValue;
            DateTime wkEndDt = DateTime.MinValue;
            wkStDt = dt.AddDays(0 - Convert.ToDouble(dt.DayOfWeek));
            wkEndDt = dt.AddDays(7 - Convert.ToDouble(dt.DayOfWeek));
            hdnFirstDayWeek.Value = wkStDt.ToExternalDate();
            hdnLastDayWeek.Value = wkEndDt.ToExternalDate();
            #endregion

            #region currentMonth
            DateTime dateNow = DateTimeUtility.GetServerDate(); //create DateTime with current date                  
            hdnFirstDayMonth.Value = dateNow.AddDays(-(dateNow.Day - 1)).ToExternalDate(); //first day 
            dateNow = dateNow.AddMonths(1);
            hdnLastDayMonth.Value = dateNow.AddDays(-(dateNow.Day)).ToExternalDate(); //last day
            #endregion

            #region currentYear
            hdnFirstDayYear.Value = "01-01-" + DateTimeUtility.GetServerDate().Year;
            hdnLastDayYear.Value = "31-12-" + DateTimeUtility.GetServerDate().Year;
            #endregion

            #region lastmonth
            DateTime dtlm = DateTimeUtility.GetServerDate().AddMonths(-1);
            hdnLastMonthFirst.Value = dtlm.AddDays(-(dtlm.Day - 1)).ToString();
            dtlm = dtlm.AddMonths(1);
            hdnLastMonthLast.Value = dtlm.AddDays(-(dtlm.Day)).ToString();
            #endregion

            #region lastweek
            DateTime dt1 = DateTimeUtility.GetServerDate();
            DateTime LwkStDt = DateTime.MinValue;
            DateTime LwkEndDt = DateTime.MinValue;
            hdnLastWeekFirst.Value = dt1.AddDays(-7 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd-MM-yyyy");
            hdnLastWeekLast.Value = dt1.AddDays(-1 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd-MM-yyyy");

            #endregion

            #region lastYear
            DateTime dt2 = DateTimeUtility.GetServerDate();
            string tempyear = dt2.AddYears(-1).ToString();
            string[] tyear = new string[5];
            tyear = tempyear.Split('/', '-');
            tyear = tyear[2].Split(' ');
            hdnLastYearFirst.Value = "01-01-" + tyear[0].ToString();
            hdnLastYearLast.Value = "31-12-" + tyear[0].ToString();
            #endregion

        }


        ////if (IsPostBack)
        ////{
        ////    if (hdnTempFrom.Value != "" && hdnTempTo.Value != "")
        ////    {
        ////        txtFromDate.Text = hdnTempFrom.Value;
        ////        txtToDate.Text = hdnTempTo.Value;
        ////        txtFromDate.Attributes.Add("disabled", "true");
        ////        txtToDate.Attributes.Add("disabled", "true");
        ////    }

        ////}


    }

    protected void loadKitproductSearch( long KitID,string  KitBatchNo,string  strBillFromDate, string strBillToDate,string Status)

    {

        inventoryKitBL.loadKitproductSearch(KitID, KitBatchNo, strBillFromDate, strBillToDate, OrgID, InventoryLocationID,Status, out lstKitDetail);
        
        if(lstKitDetail.Count >0)
        {
            grdResult.DataSource =lstKitDetail;
            grdResult.DataBind();
            grdResult.Visible = true;
        }
    }
    protected void LoadRegDate()
    {
        List<MetaData> lstMetadata = GetMetaData("CustomPeriodRange");
        if (lstMetadata.Count > 0)
        {
            ddlRegisterDate.DataSource = lstMetadata;
            ddlRegisterDate.DataTextField = "DisplayText";
            ddlRegisterDate.DataValueField = "Code";
            ddlRegisterDate.DataBind();
            ListItem ddlselect = GetMetaData("Select", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            ddlRegisterDate.Items.Insert(0, ddlselect);
        }
    }
    protected void LoadStatus()
    {
        List<MetaData> lstMetadata = GetMetaData("KitStatus");
        if (lstMetadata.Count > 0)
        {
            ddlStatus.DataSource = lstMetadata;
            ddlStatus.DataTextField = "DisplayText";
            ddlStatus.DataValueField = "Code";
            ddlStatus.DataBind();
            ListItem ddlselect = GetMetaData("Select", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            ddlStatus.Items.Insert(0, ddlselect);
        }
    }
    protected void loadActionList()
    {
        try
        {
            long returnCode = -1;
            List<ActionMaster> lstActionMaster = new List<ActionMaster>();

            returnCode = new ActionManager_BL(base.ContextInfo).GetActions(RoleID, (int)TaskHelper.SearchType.KitBatchProductSearch, out lstActionMaster); //returnCode = patBL.GetSearchActionsByPage(RoleID, type, out pages);
          //  ddlAction.Items.Clear();

            #region Load Action Menu to Drop Down List
            if (lstActionMaster.Count > 0)
            {
                //lstActionsMaster = lstActionMaster.ToList();
                #region Add View State ActionList
                string temp = string.Empty;
                foreach (ActionMaster objActionMaster in lstActionMaster)
                {
                    temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
                }
                ViewState.Add("ActionList", temp);
                #endregion
                ddlAction.DataSource = lstActionMaster;
                ddlAction.DataTextField = "ActionName";
                ddlAction.DataValueField = "ActionCode";
                ddlAction.DataBind();
            }
            #endregion
            //foreach (ActionMaster src in lstActionMaster)
            //{
            //    ddlAction.Items.Add(new ListItem(src.ActionName, src.PageURL + "~" + src.ActionID));


            //}

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - loadActionList", ex);

        }
    }

    
    private void loadKitNames()
    {
        inventoryKitBL.GetKitDetails(OrgID,out lstKitMaster);
        ddlKitNames.DataSource = lstKitMaster;
        ddlKitNames.DataTextField="ProductName";
        ddlKitNames.DataValueField = "ProductID";
        ddlKitNames.DataBind();
        ListItem ddlselect = GetMetaData("Select", "0");
                    if (ddlselect == null)
                    {
                        ddlselect = new ListItem() { Text = "Select", Value = "0" };
                    }
                    ddlKitNames.Items.Insert(0, ddlselect);
}

    protected void btnGo_Click(object sender, EventArgs e)
    {
        hdnpopUp.Value = "N";

        try
        {
            string queryString = string.Empty;
            string id = string.Empty;
            string strUrl = string.Empty;
            string[] listValue = ddlAction.SelectedValue.Split('~');
            //if (ddlAction.SelectedItem.Text == "View KitBatch Product")
            //{
            //    queryString = Request.ApplicationPath + listValue[0] + "?KitID=" + hdnMasterKitID.Value + "&MasterKitID=" + hdnKitID.Value + "&KitBatchNo=" + hdnBatchNo.Value + "&Lid=" + hdnLID.Value + "&Status=" + hdnStatus.Value;
            //     Response.Redirect(queryString, true);
            //  //  ScriptManager.RegisterStartupScript(Page, this.GetType(), "POPUP", "PrintPopup();", true);
            //}
            //else
            //{
            //    queryString = listValue[0] + "?KitID=" + hdnMasterKitID.Value + "&MasterKitID=" + hdnKitID.Value + "&KitBatchNo=" + hdnBatchNo.Value + "&Lid=" + hdnLID.Value + "&Status=" + hdnStatus.Value;
            //    Response.Redirect(Request.ApplicationPath + queryString, true);


            //}

            #region Get Redirect URL
            QueryMaster objQueryMaster = new QueryMaster();
            Utilities objUtilities = new Utilities();
            string RedirectURL = string.Empty;
            string QueryString = string.Empty;
            //if (lstActionsMaster.Exists(p => p.ActionCode == ddlAction.SelectedValue))
            //{
            //    QueryString = lstActionsMaster.Find(p => p.ActionCode == ddlAction.SelectedValue).QueryString;
            //}

            #region View State Action List
            string ActCode = ddlAction.SelectedValue;
            string ActionList = ViewState["ActionList"].ToString();
            foreach (string CompareList in ActionList.Split('^'))
            {
                if (CompareList.Split('~')[0] == ActCode)
                {
                    QueryString = CompareList.Split('~')[1];
                    break;
                }
            }
            #endregion
            objQueryMaster.Querystring = QueryString;
            objQueryMaster.KitIdentity = hdnMasterKitID.Value;
            objQueryMaster.MasterIdentity = hdnKitID.Value;
            objQueryMaster.KitBatchNumber = hdnBatchNo.Value;
            objQueryMaster.LoginID = hdnLID.Value;
            objQueryMaster.StatusValue = hdnStatus.Value;
            Attune_UtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
           // objUtilities.GetRedirectURL(objQueryMaster, out RedirectURL);
            if (!String.IsNullOrEmpty(RedirectURL))
            {
                if (ddlAction.SelectedValue == "View_KitBatch_Product")
                {
                    Response.Redirect(RedirectURL, true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "POPUP", "PrintPopup();", true);
                }
                else
                {
                    Response.Redirect(RedirectURL, true);
                }
            }
            else
            {
                string strerrorMsg = Resources.InventoryKit_ClientDisplay.InventoryKit_InvKitCancel_aspx_02 == null ? "Alert" : Resources.InventoryKit_ClientDisplay.InventoryKit_InvKitCancel_aspx_02;
                string struserMsg = Resources.InventoryKit_ClientDisplay.InventoryKit_KitProductPrintSearch_aspx_01 == null ? "InventoryKit_KitProductPrintSearch_aspx_01" : Resources.InventoryKit_ClientDisplay.InventoryKit_KitProductPrintSearch_aspx_01;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ValidationWindow('"+ struserMsg +"','"+ strerrorMsg +"');", true);
            }
            #endregion


        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                InventoryItemsBasket IOM = new InventoryItemsBasket();
                IOM = (InventoryItemsBasket)e.Row.DataItem;          
                    Label lblBillID = (Label)e.Row.FindControl("lblBillID");
                    Button barcode = (Button)e.Row.FindControl("btnBarcode");

                    string strScript = "INVRowCommon('" + ((RadioButton)e.Row.FindControl("rdSel")).ClientID + "','" + IOM.ProductID + "','" + IOM.BatchNo + "','" + IOM.ID + "','" + IOM.LocationID + "','" + IOM.Name + "');";
                    ((RadioButton)e.Row.FindControl("rdSel")).Attributes.Add("onmouseover", "this.class='pointer';");
                    ((RadioButton)e.Row.FindControl("rdSel")).Attributes.Add("onclick", strScript);
                    string strScript1 = "barCode('" + IOM.ProductID + "','" + IOM.BatchNo + "','" + OrgID + "','" + BarcodeCategory.KitBatchNo + "');";
                    barcode.Attributes.Add("onclick", strScript1);
                    //if (hdnBarcode.Value.ToString() == "Y")
                    //{
                    //    inventoryKitBL.GetKitCancelDetails(IOM.ProductID, IOM.BatchNo, OrgID, ILocationID, LID, InventoryLocationID, Status, "BarCode", "Y", out lstInventoryItemsBasket);
                    //}
                   if (IOM.HasBatchNo == "N")
                    {
                        barcode.Enabled = true;
                      
                                              
                    }
                    else
                    {
                        if (RoleName == "Administrator")
                        {
                            barcode.Enabled = true;
                        }
                        else
                        {
                            barcode.Enabled = false;
                        }

                    }
            }
             
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Intend.", ex);
        }
    }

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        
        try
        {
            if (e.CommandName == "Barcode")
            {
                string Barcode = Convert.ToString(e.CommandArgument);
                string[] arg = new string[2];
                arg = Barcode.Split(',');
                long  ID = Convert.ToInt32(arg[0]);
                string batchno = Convert.ToString(arg[1]);
                if (hdnBarcode.Value.ToString() == "Y")
                {
                    inventoryKitBL.GetKitCancelDetails(ID, batchno, OrgID, ILocationID, LID, InventoryLocationID, Status, "BarCode", "Y", out lstInventoryItemsBasket);
                }
            }

        }
    catch (Exception ex)
    {
        CLogger.LogError("Error while Loading Barcode", ex);
    }

    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnKitSearch_Click(sender, e);
        }
    }



    protected void btnKitSearch_Click(object sender, EventArgs e)
    {
        KitBatchNo = txtKitBatchNo.Text == "" ? "" : txtKitBatchNo.Text.Trim();
        KitID = ddlKitNames.SelectedItem.Value == "0" ? 0 : Convert.ToInt64(ddlKitNames.SelectedValue);
        Status = ddlStatus.SelectedItem.Value =="0" ? "" : ddlStatus.SelectedItem.Text;


        string strSelect=Resources.InventoryKit_ClientDisplay.InventoryKit_KitProductPrintSearch_aspx_02 == null?"Select":Resources.InventoryKit_ClientDisplay.InventoryKit_KitProductPrintSearch_aspx_02;
        if (ddlRegisterDate.SelectedItem.Text != strSelect)
        {
            if ((txtFromDate.Text != "" && txtToDate.Text != ""))
            {

                strBillFromDate = txtFromDate.Text.ToInternalDate().ToString();
                strBillToDate = txtToDate.Text.ToInternalDate().ToString();

            }
            else if (txtFromPeriod.Text != "" && txtToPeriod.Text != "")
            {
                strBillFromDate = txtFromPeriod.Text.ToInternalDate().ToString();
                strBillToDate = txtToPeriod.Text.ToInternalDate().ToString();
            }
          
        }
        else
        {

            DateTime d = DateTimeUtility.GetServerDate();
            DateTime dat = new DateTime(d.Year, d.Month, 1);
            strBillFromDate = dat.ToString("dd/MM/yyyy");
            strBillToDate = DateTimeUtility.GetServerDate().ToString("dd- MM-yyyy");
            
            //strBillFromDate = DateTimeUtility.GetServerDate().ToString("dd-MM-yyyy");
            //strBillToDate = DateTimeUtility.GetServerDate().ToString("dd-MM-yyyy");
        }


        //strBillFromDate =txtFromDate.Text;
        //strBillToDate =txtToDate.Text;
        loadKitproductSearch(KitID, KitBatchNo, strBillFromDate, strBillToDate, Status);
        loadActionList();
}
}
