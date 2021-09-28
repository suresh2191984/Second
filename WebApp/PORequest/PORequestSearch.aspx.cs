using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.DataAccessEngine;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PORequest.BL;
using Attune.Kernel.PlatForm.BL;


public partial class PORequest_PORequestSearch:Attune_BasePage
{
    public PORequest_PORequestSearch()
        : base("PORequest_PORequestSearch_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    InventoryCommon_BL inventoryBL;
    List<Organization> lstorgn = new List<Organization>();
    List<Locations> lstloc = new List<Locations>();
    List<InventoryOrdersMaster> lstOrders = new List<InventoryOrdersMaster>();
    List<PurchaseRequest> LstPurchaseRequest = new List<PurchaseRequest>();
    List<PurchaseRequestDetails> lstpdetails = new List<PurchaseRequestDetails>();
    string PORequestNo = string.Empty;
    string pStatus = string.Empty;
    string pType = string.Empty;
    int ReceivedOrgID = -1;
    int ReceivedOrgAddID = -1;
    int pToLocationID = 0;
    int requestsearchartypeid = 0;
    //static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        //txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
        //txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");
        if (!IsPostBack)
        {
            LoadOrgan();
            txtFrom.Text = DateTimeNow.ToExternalDate();
            txtTo.Text = DateTimeNow.ToExternalDate();
            requestsearchartypeid = Convert.ToInt32(TaskHelper.SearchType.Purchaserequest);
            actions();

        }

        //btngo.PostBackUrl = "~/Inventory/RaisedPurchaseOrder.aspx";

        
    }

    public void actions()
    {
        long returnCode = -1;
        ActionManager_BL nurseBL = new ActionManager_BL(base.ContextInfo);
        List<ActionMaster> lstActionMaster = new List<ActionMaster>(); //List<SearchActions> pages = new List<SearchActions>(); 

        returnCode = nurseBL.GetActions(RoleID, requestsearchartypeid, out lstActionMaster); //returnCode = nurseBL.GetSearchActions(RoleID, OP, out pages); 

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
            dList.DataSource = lstActionMaster;
            dList.DataTextField = "ActionName";
            //dList.DataValueField = "PageURL";
            dList.DataValueField = "ActionCode";
            dList.DataBind();
        }
        
    }

    private void LoadOrgan()
    {
       
        //inventoryBL = new Inventory_BL(base.ContextInfo);
        new TrustedOrg_BL(ContextInfo).GetSharingOrgList(OrgID, out lstorgn, out lstloc);

        ddlTrustedOrg.DataSource = lstorgn;
        ddlTrustedOrg.DataTextField = "Name";
        ddlTrustedOrg.DataValueField = "OrgID";
        ddlTrustedOrg.DataBind();
        ListItem ddlselect = GetMetaData("Select", "0");
        if (ddlselect == null)
        {
            ddlselect = new ListItem() { Text = "Select", Value = "0" };
        }
        ddlTrustedOrg.Items.Insert(0, ddlselect);
        //ddlTrustedOrg.Items.Insert(0, GetMetaData("Select", "0"));
        ddlTrustedOrg.Items[0].Value = "0";

        ddlLocation.DataSource = lstloc;
        ddlLocation.DataTextField = "LocationName";
        ddlLocation.DataValueField = "LocationID";
        ddlLocation.DataBind();
        ddlLocation.DataBind();
      
        if (ddlselect == null)
        {
            ddlselect = new ListItem() { Text = "Select", Value = "0" };
        }
        ddlLocation.Items.Insert(0, ddlselect);
      //  ddlLocation.Items.Insert(0, GetMetaData("Select", "0"));
      
        foreach (var item in lstloc)
        {
            hdnlocation.Value += item.OrgID + "~" + item.LocationID + "~" + item.LocationName + "^";

        }






    }

    public void pickdata()
    {
        string PORequestid=string.Empty;
        string poid =string.Empty;
        foreach (GridViewRow row in grdResult.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkBox = (CheckBox)row.FindControl("chkBox");
                HiddenField hdnrequestid = (HiddenField)row.FindControl("hdnRequestID");
           
                if (chkBox.Checked)
                {
                    poid = hdnrequestid.Value;
                }
                PORequestid += poid + '^';
            }
        }
        hdnpoids.Value = PORequestid;
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            //LoadStockInHand();
           
        }

    }
 
    protected void btnsearch_Click(object sender, EventArgs e)
    {
        try
        {
            PORequest_BL poreqBL = new PORequest_BL(base.ContextInfo);
            string fromdate = txtFrom.Text.ToInternalDate().ToString();
            string todate = txtTo.Text.ToInternalDate().ToString();

            PORequestNo = txtPrno.Text;
            //pStatus = ddlstatus.SelectedItem.Text=;
            pStatus = "";
            ReceivedOrgID = Convert.ToInt32(hdnSelectOrgid.Value) > 0 ? Convert.ToInt32(hdnSelectOrgid.Value) : 0;
            pToLocationID = Convert.ToInt32(hdnLocationID.Value) > 0 ? Convert.ToInt32(hdnLocationID.Value) : 0;

            poreqBL.GetPurchaseRequestSearch(Convert.ToDateTime(fromdate), Convert.ToDateTime(todate), PORequestNo, InventoryLocationID, OrgID, ILocationID, pStatus, pToLocationID,
                                                pType, ReceivedOrgID, ReceivedOrgAddID, out LstPurchaseRequest, out lstpdetails);

            
                grdResult.DataSource = LstPurchaseRequest;
                grdResult.DataBind();

                ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadSrd", "   GetLocationlist();Setlocationdetails('" + pToLocationID + "')", true);
        }
            
        catch (Exception Ex)
        {
            CLogger.LogError("Error while GetPurchaseRequestSearch Inventory_BL", Ex);

        }
    }
    protected void btngo_Click(object sender, EventArgs e)
    {
        try
        {
            //switch (dList.SelectedItem.Text)
            //{
            //    case "View & Print Order":
            //        Response.Redirect(Request.ApplicationPath + dList.SelectedValue.ToString() + "?PORID=" + hdnPRequestID.Value.ToString());
            //         break;
            //    case "RaisePO":
            //         //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "req", "javascript:return requestvalidation();", true);
            //         //pickdata();
            //         Response.Redirect(Request.ApplicationPath + dList.SelectedValue.ToString() + "?PORID=" + hdnPRequestID.Value.ToString());
            //        break;
            //}

            #region Get Redirect URL
            QueryMaster objQueryMaster = new QueryMaster();
             
            string RedirectURL = string.Empty;
            string QueryString = string.Empty;
            //if (lstActionsMaster.Exists(p => p.ActionCode == dList.SelectedValue))
            //{
            //    QueryString = lstActionsMaster.Find(p => p.ActionCode == dList.SelectedValue).QueryString;
            //}
            #region View State Action List
            string ActCode = dList.SelectedValue;
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
            objQueryMaster.PORequestID = hdnPRequestID.Value.ToString();
            Attune_UtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
            if (!String.IsNullOrEmpty(RedirectURL))
            {
                Response.Redirect(RedirectURL, true);
            }
            else
            {
                string Message = Resources.PORequest_AppMsg.PORequest_PORequestSearch_aspx_03;
                if (Message == null)
                {
                    Message = "URL Not Found";
                }
                string Error = Resources.PORequest_AppMsg.PORequest_Error;
                if (Error == null)
                {
                    Error = "Error";
                }

                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ValidationWindow('" + Message + "','" + Error + "' ');", true);
            }
            #endregion
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - Purchase request ", ex);
           
        }
    }
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                List<PurchaseRequestDetails> templist = new List<PurchaseRequestDetails>();
                 
                PurchaseRequest po = (PurchaseRequest)e.Row.DataItem;

                templist = lstpdetails.FindAll(p => p.PurchaseRequestID == po.PurchaseRequestID);
                string strScript = "SelectINVRowCommon('" + ((CheckBox)e.Row.Cells[1].FindControl("chkBox")).ClientID + "','" + 
                                                               po.PurchaseRequestID + "','" +po.RaiseOrgID+"','" +po.OrgID+"','" +po.PurchaseRequestNo+"');";
                //((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((CheckBox)e.Row.Cells[0].FindControl("chkBox")).Attributes.Add("onclick", strScript);
                string strtemp = GetToolTip(templist);
                e.Row.Cells[2].Attributes.Add("onmouseover", "this.className='colornw';showTooltip(event,'" + strtemp + "');return false;");
                e.Row.Cells[2].Attributes.Add("onmouseout", "this.style.color='Black';hideTooltip();");
                e.Row.Cells[2].Attributes.Add("class", "att");
             }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("", Ex);
        }
    }
    private string GetToolTip(List<PurchaseRequestDetails> tempList)
    {
        string ProductName = Resources.PORequest_ClientDisplay.PORequest_PORequestSearch_aspx_05;
        if (ProductName == null)
        {
            ProductName = "Product Name";
        }

        string Quantity = Resources.PORequest_ClientDisplay.PORequest_PORequestSearch_aspx_06;
        if (Quantity == null)
        {
            Quantity = "Quantity";
        }
        string Units = Resources.PORequest_ClientDisplay.PORequest_PORequestSearch_aspx_07;
        if (Units == null)
        {
            Units = "Unit";
        }
        string TableHead = "";
        string TableDate = "";
        TableHead = "<table border=\"1\" cellpadding=\"2\"cellspacing=\"2\"><tr style=\"font-weight: bold;\"><td>ProductName</td><td>Quantity</td><td>Units</td></tr>";
                foreach (PurchaseRequestDetails item in tempList)
                {
                    TableDate += "<tr>  <td>" + item.Description + "</td><td>" + item.Quantity.ToString() + "</td><td>" + item.Unit + "</td></tr>";
                }
                
        return TableHead + TableDate + "</table> ";
    }
    
}
