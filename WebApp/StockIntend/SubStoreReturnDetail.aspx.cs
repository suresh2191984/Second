using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.Text;
using System.IO;
using System.Web.Script.Serialization;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PerformingNextAction;
using Attune.Kernel.PlatForm.Common;

public partial class StockIntend_SubStoreReturnDetail : Attune_BasePage
{
    public StockIntend_SubStoreReturnDetail()
        : base("StockIntend_SubStoreIntendDetail.aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    InventoryCommon_BL inventoryBL;
    Intend objIntend;
    List<InventoryItemsBasket> lstIntendBasket;
    long TaskID = 0;
    DateTime DespatchDate;
    Locations objLocation = new Locations();
    IntendDetail objIntendDetail = new IntendDetail();
    List<Locations> lstLocation = new List<Locations>();
    List<Intend> lstIntend = new List<Intend>();
    List<InventoryItemsBasket> lstInventoryItemsBasket;
    List<InventoryItemsBasket> lstIntendDetail = new List<InventoryItemsBasket>();
    List<Users> lstcUsers = new List<Users>();
    List<Users> lstUsers = new List<Users>();

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Header.DataBind();
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["Appr"]) || !string.IsNullOrEmpty(Request.QueryString["tid"]))
            {
                btnApprove.Visible = true;
                if (!string.IsNullOrEmpty(Request.QueryString["tid"]))
                {



                    btnCancelIntend.Visible = true;
                }
            }


            if (Request.QueryString["intID"] != null)
            {

                LoadIntendDetailGrid(Convert.ToInt64(Request.QueryString["intID"]));
            }
            #region InHandQty

            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("HideInhandQty", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig != null && lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue == "Y")
                {
                    GridViewDetails.Columns[7].Visible = false;
                    GridViewDetails.Columns[8].Visible = false;

                }
            }
            #endregion
        }
    }

    private void Notification()
    {

        PageContextDetails.ButtonName = "btnIndentRise";
        PageContextDetails.ButtonValue = "IndentRise";

        var mailbuilder = new StringBuilder();
        divProjection.RenderControl(new HtmlTextWriter(new StringWriter(mailbuilder)));

        string mailContent = mailbuilder.ToString();
        #region Notification
        ActionManager am = new ActionManager(base.ContextInfo);
        PageContextDetails.PatientID = 0;
        PageContextDetails.RoleID = RoleID;
        PageContextDetails.AccessionNo = "0";
        PageContextDetails.LabNo = 0;
        PageContextDetails.FinalBillID = 0;
        PageContextDetails.RegPatientID = 0;
        PageContextDetails.RateType = "0";
        PageContextDetails.FeeID = "0";
        PageContextDetails.RefundNo = "0";
        PageContextDetails.BillNumber = "0";
        PageContextDetails.PhoneNo = "";
        PageContextDetails.ReceiptNo = "";
        PageContextDetails.MessageTemplate = mailContent.ToString();
        PageContextDetails.IndentNo = Convert.ToInt64(Request.QueryString["intID"]);
        long returnCode = am.PerformingNextStepNotification(PageContextDetails, "", "");
        #endregion

    }

    private void LoadIntendDetailGrid(long pIntendID)
    {
        string frmLocation = string.Empty;
        string toLocation = string.Empty;
        try
        {
            //objIntendDetail.IntendID = 2;
            if (Request.QueryString["pOrgid"] != null)
            {
                objIntendDetail.OrgID = Convert.ToInt32(Request.QueryString["pOrgid"]);
            }
            else
            {
                objIntendDetail.OrgID = OrgID;
            }
            objIntendDetail.OrgAddressID = ILocationID;
            //objIntendDetail.LocationID = InventoryLocationID;
            List<Organization> lstOrganization = new List<Organization>();
            new Organization_BL(ContextInfo).getOrganizationAddress(OrgID, ILocationID, out  lstOrganization);

            if (lstOrganization.Count > 0)
            {
                lblOrgName.Text = lstOrganization[0].Name;
                lblstreet.Text = lstOrganization[0].Address; //+ "," + lstOrganization[0].City;
                lblPhonenumber.Text = lstOrganization[0].PhoneNumber;
            }

            inventoryBL.GetIntendDetail(pIntendID, 0, objIntendDetail.OrgID, objIntendDetail.OrgAddressID, out lstIntendDetail, out lstIntend);
            //inventoryBL.GetInventoryIndentDetails(pIntendID, objIntendDetail.LocationID, objIntendDetail.OrgID, objIntendDetail.OrgAddressID, objIntendDetail.RaiseOrgID, objIntendDetail.Tolocationid, out lstIntendDetail, out lstIntend);
            //hdnRaiseqty.Value=lstIntendDetail[]
            if (lstIntend[0] != null)
            {
                frmLocation = lstIntend[0].LocName;
                toLocation = lstIntend[0].ToLocName;
            }

            GridViewDetails.Columns[7].HeaderText = frmLocation.Split('(')[0];
            GridViewDetails.Columns[8].HeaderText = toLocation.Split('(')[0];

            List<Config> lstConfig = new List<Config>();
            int iBillGroupID = 0;
            iBillGroupID = (int)ReportType.OPBill;

            new Configuration_BL(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Logo", OrgID, ILocationID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                //tblBillPrint.Style.Add("background-image", "url('" + lstConfig[0].ConfigValue.Trim() + "'); ");
                imgBillLogo.ImageUrl = lstConfig[0].ConfigValue.Trim();
                if (lstConfig[0].ConfigValue.Trim() != "")
                {
                    imgBillLogo.Visible = true;
                }
                else
                {
                    imgBillLogo.Visible = false;
                }
            }
            else
            {
                imgBillLogo.Visible = false;
            }

            GateWay headBL = new GateWay(base.ContextInfo);

            if (lstIntend!=null && lstIntend.Count > 0)
            {
                headBL.GetUserDetail(lstIntend[0].CreatedBy, out lstcUsers);
                lblIntendNo.Text = lstIntend[0].IntendNo;
                if (lstcUsers != null && lstcUsers.Count > 0)
                {
                lblRaiseBy.Text = lstcUsers[0].Name;
                }
                lblDate.Text = lstIntend[0].IntendDate.ToExternalDateTime();
                lblIndentRaiseTo.Text = lstIntend[0].LocName;
                lblIndentFrom.Text = lstIntend[0].ToLocName;
                if (lstIntend[0].Status == "Issued")
                {
                    btnApprove.Visible = false;
                    btnCancelIntend.Visible = false;
                }


                headBL.GetUserDetail(lstIntend[0].ApprovedBy, out lstUsers);

                if (lstUsers!=null && lstUsers.Count > 0)
                {
                    if (lstIntend[0].ApprovedAt.ToShortDateString() != "01/01/0001")
                    {
                        tdApproved.Visible = true;

                        approvedDateTD.InnerText = lstIntend[0].ApprovedAt.ToExternalDate();
                        approvedByTD.InnerHtml = lstUsers[0].Name;
                    }
                }
                else
                {
                    tdApproved.Visible = false;
                    approvedDateTD.InnerText = "--";
                    approvedByTD.InnerHtml = "--";
                }
                lblStatus.Text = lstIntend[0].Status;

                //if (Request.QueryString["Ismail"] != null)
                //{
                //    if (lstIntend[0].Status == "Approved")
                //        Notification();
                //}
            }

            if ((lstIntend[0].Status == "Pending"))
            {
                GridViewDetails.DataSource = lstIntendDetail;
                GridViewDetails.DataBind();
                GridViewDetails.Columns[2].Visible = false;
                GridViewDetails.Columns[4].Visible = false;
                GridViewDetails.Columns[5].Visible = false;
                GridViewDetails.Columns[7].Visible = false;
                GridViewDetails.Columns[8].Visible = false;
                // gvIntendDetail.DataBind();
                gvIntendDetail.Visible = false;
                GridViewDetails.Visible = true;
                Notification();
                // btnSave.Visible = false;

            }
            //else if ((lstIntend[0].Status == "Issued"))
            //{
            //    GridViewDetails.DataSource = lstIntendDetail;
            //    GridViewDetails.DataBind();
            //    // gvIntendDetail.DataBind();
            //    gvIntendDetail.Visible = false;
            //    GridViewDetails.Visible = true;
            //    btnSave.Visible = false;




            //}

            else if ((lstIntend[0].Status == "Received"))
            {
                GridViewDetails.DataSource = lstIntendDetail;
                GridViewDetails.DataBind();
                GridViewDetails.Columns[5].Visible = true;

                GridViewDetails.Visible = true;
                //btnSave.Visible = false;


            }

            else
            {

                GridViewDetails.DataSource = lstIntendDetail;
                GridViewDetails.DataBind();
                //gvIntendDetail.DataSource = lstIntendDetail;
                //gvIntendDetail.DataBind();
                //gvIntendDetail.Visible = true;
                GridViewDetails.Visible = true;
                GridViewDetails.Columns[7].Visible = false;
                GridViewDetails.Columns[8].Visible = false;
                //btnSave.Visible = false;
            }

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Loading Location - IntendViewDetail.aspx", Ex);
            //ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }

    }


    protected void btnBack_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["tid"])) { Response.Redirect("~/StockIntend/SubstoreSearch.aspx"); }
        else
        {
            Response.Redirect("~/StockIntend/SubstoreSearch.aspx");
        }
    }
    protected void btnIntend_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        long intendID = 0;
        long taskid = 0;
        decimal iQty;
        try
        {
            Button btn = (Button)sender;
            if (!string.IsNullOrEmpty(Request.QueryString["intID"]) && Request.QueryString["intID"] != "0" && !string.IsNullOrEmpty(Request.QueryString["tid"]))
            {
                Int64.TryParse(Request.QueryString["tid"], out taskid);
                Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
                taskBL.UpdateTask(taskid, TaskHelper.TaskStatus.Completed, LID);
                Int64.TryParse(Request.QueryString["intID"], out intendID);

                #region EditQty_while_Approve
                objIntend = new Intend();
                inventoryBL = new InventoryCommon_BL(base.ContextInfo);

                lstIntendBasket = new List<InventoryItemsBasket>();

                StockReceived objLocationStockInHand = new StockReceived();
                List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();

                foreach (GridViewRow gR in GridViewDetails.Rows)
                {
                    InventoryItemsBasket objINV = new InventoryItemsBasket();
                    TextBox txtRaisedquantity = (TextBox)gR.FindControl("txtRaisedquantity");
                    double RaisedQty = double.Parse(txtRaisedquantity.Text);
                        HiddenField hdnID = (HiddenField)gR.FindControl("hdnpID");
                        HiddenField hdnProductID = (HiddenField)gR.FindControl("hdnProductID");
                        HiddenField SellingUnit = (HiddenField)gR.FindControl("hdnSellingUnit");
                        HiddenField Batchno = (HiddenField)gR.FindControl("hdnpBatchNo");
                        HiddenField Expr = (HiddenField)gR.FindControl("hdnExp");
                        HiddenField hdnProductReceivedDetailsID = (HiddenField)gR.FindControl("hdnProductReceivedDetailsID");
                        HiddenField hdnReceivedUniqueNumber = (HiddenField)gR.FindControl("hdnReceivedUniqueNumber");
                        long IntendID = Convert.ToInt64(hdnID.Value);
                        long ProductID = Convert.ToInt64(hdnProductID.Value);
                        iQty = txtRaisedquantity.Text == "" ? 0 : Convert.ToDecimal(txtRaisedquantity.Text);
                        objINV.CategoryID = 0;
                        objINV.ProductID = ProductID;
                        objINV.BatchNo = Batchno.Value;
                        objINV.ExpiryDate = DateTime.Parse(Expr.Value);
                        objINV.Quantity = txtRaisedquantity.Text == "" ? 0 : Convert.ToDecimal(txtRaisedquantity.Text); 
                        objINV.ID = IntendID;
                        objINV.ProductReceivedDetailsID = Convert.ToInt64(hdnProductReceivedDetailsID.Value);
                        objINV.ReceivedUniqueNumber = Convert.ToInt64(hdnReceivedUniqueNumber.Value);
                        objINV.SellingUnit = SellingUnit.Value;
                         
                        lstInventoryItemsBasket.Add(objINV);
                }
                long IndentId = Convert.ToInt64(Request.QueryString["intID"].ToString());
                returnCode = inventoryBL.UpdatestockreturnApproved(IndentId, InventoryLocationID, OrgID, ILocationID, LID, 0, lstInventoryItemsBasket);
                if (Request.QueryString["intID"] != null)
                {
                    objIntend.IntendID = IndentId;
                }
                objIntend.CreatedBy = LID;
                objIntend.IntendDate = DateTime.Now;
                objIntend.OrgID = OrgID;
                objIntend.OrgAddressID = ILocationID;
                objIntend.LocationID = InventoryLocationID;
                DespatchDate = DateTime.Now;
                inventoryBL = new InventoryCommon_BL(base.ContextInfo);

                Response.Redirect(@"../StockIntend/ViewSubStoreStockdetails.aspx?ID=0&intID=" + Convert.ToInt64(IndentId) + "&LocationID=" + InventoryLocationID + "&Status=Received&ReceivedOrgID=" + OrgID + "&IndentType=Raised Indent&SearchType=View Indent", true);

               
                #endregion


            }
           
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Stock Return Details.", ex);
        }



    }

    protected void btnCancelIntend_Click(object sender, EventArgs e)
    {
        
        long returnCode = -1;
        long intendID = 0;
        long taskid = 0;
        decimal iQty;
        try
        {
            Button btn = (Button)sender;
            if (!string.IsNullOrEmpty(Request.QueryString["intID"]) && Request.QueryString["intID"] != "0" && !string.IsNullOrEmpty(Request.QueryString["tid"]))
            {
                Int64.TryParse(Request.QueryString["tid"], out taskid);
                Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
                taskBL.UpdateTask(taskid, TaskHelper.TaskStatus.Completed, LID);
                Int64.TryParse(Request.QueryString["intID"], out intendID);


                objIntend = new Intend();
                inventoryBL = new InventoryCommon_BL(base.ContextInfo);

                lstIntendBasket = new List<InventoryItemsBasket>();

                StockReceived objLocationStockInHand = new StockReceived();
                List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();

                foreach (GridViewRow gR in GridViewDetails.Rows)
                {
                    InventoryItemsBasket objINV = new InventoryItemsBasket();
                    TextBox txtRaisedquantity = (TextBox)gR.FindControl("txtRaisedquantity");
                    double RaisedQty = double.Parse(txtRaisedquantity.Text);
                        HiddenField hdnID = (HiddenField)gR.FindControl("hdnpID");
                        HiddenField hdnProductID = (HiddenField)gR.FindControl("hdnProductID");
                        HiddenField SellingUnit = (HiddenField)gR.FindControl("hdnSellingUnit");
                        HiddenField Batchno = (HiddenField)gR.FindControl("hdnpBatchNo");
                        HiddenField Expr = (HiddenField)gR.FindControl("hdnExp");
                        HiddenField hdnProductReceivedDetailsID = (HiddenField)gR.FindControl("hdnProductReceivedDetailsID");
                        HiddenField hdnReceivedUniqueNumber = (HiddenField)gR.FindControl("hdnReceivedUniqueNumber");
                        long IntendID = Convert.ToInt64(hdnID.Value);
                        long ProductID = Convert.ToInt64(hdnProductID.Value);
                        iQty = txtRaisedquantity.Text == "" ? 0 : Convert.ToDecimal(txtRaisedquantity.Text);
                        objINV.CategoryID = 0;
                        objINV.ProductID = ProductID;
                        objINV.BatchNo = Batchno.Value;
                        objINV.ExpiryDate = DateTime.Parse(Expr.Value);
                        objINV.Quantity = txtRaisedquantity.Text == "" ? 0 : Convert.ToDecimal(txtRaisedquantity.Text); ;
                        objINV.ID = IntendID;
                        objINV.SellingUnit = SellingUnit.Value;
                        objINV.ProductReceivedDetailsID = Convert.ToInt64(hdnProductReceivedDetailsID.Value);
                        objINV.ReceivedUniqueNumber = Convert.ToInt64(hdnReceivedUniqueNumber.Value);
                        lstInventoryItemsBasket.Add(objINV);
                }
                long IndentId =Convert.ToInt64(Request.QueryString["intID"].ToString());
                returnCode = inventoryBL.Updatestockreturncancel(IndentId, InventoryLocationID, OrgID, ILocationID, LID, 0, lstInventoryItemsBasket);
                Response.Redirect(@"../StockIntend/ViewSubStoreStockdetails.aspx?ID=0&intID=" + Convert.ToInt64(IndentId) + "&LocationID=" + InventoryLocationID + "&Status=Cancelled&ReceivedOrgID=" + OrgID + "&IndentType=Raised Indent&SearchType=View Indent", true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Cancel Intend Stock Return Details.", ex);
        }
    }



    private List<InventoryItemsBasket> GetBasketIntendDetail()
    {
        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();

        foreach (GridViewRow row in gvIntendDetail.Rows)
        {


            InventoryItemsBasket newBasket = new InventoryItemsBasket();


            newBasket.BatchNo = ((HiddenField)row.FindControl("hdnpBatchNo")).Value;
            newBasket.Quantity = Convert.ToDecimal(((HiddenField)row.FindControl("hdnpQuantity")).Value);
            newBasket.ID = Convert.ToInt64(((HiddenField)row.FindControl("hdnID")).Value);
            newBasket.ProductID = Convert.ToInt64(((HiddenField)row.FindControl("hdnpProductID")).Value);
            //newBasket.Amount = Convert.ToDecimal(listChild[3]) * Convert.ToDecimal(listChild[7]);
            //newBasket.Rate = Convert.ToDecimal(listChild[7]);
            //newBasket.Tax = Convert.ToDecimal(listChild[8]);
            //newBasket.ExpiryDate = DateTime.Parse(listChild[9]);
            //newBasket.Manufacture = DateTime.Now;
            //newBasket.AttributeDetail = "N";
            lstInventoryItemsBasket.Add(newBasket);


        }



        return lstInventoryItemsBasket;

    }



    protected void GridViewDetails_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TextBox txtRaisedquantity = new TextBox();
                HiddenField hdnIssuedQuantity = new HiddenField();
                HiddenField hdnProductID = new HiddenField();
                HiddenField hdnID = new HiddenField();
                HiddenField hdnBatchNo = new HiddenField();
                HiddenField hdnExpr = new HiddenField();
                TextBox txtRefundAmount = new TextBox();

                txtRaisedquantity = (TextBox)e.Row.FindControl("txtRaisedquantity");
                hdnID = (HiddenField)e.Row.FindControl("hdnpID");
                hdnProductID = (HiddenField)e.Row.FindControl("hdnpProductID");
                hdnBatchNo = (HiddenField)e.Row.FindControl("hdnpBatchNo");
                hdnExpr = (HiddenField)e.Row.FindControl("hdnExp");

                if (!string.IsNullOrEmpty(Request.QueryString["tid"]))
                {
                    GridViewDetails.Columns[3].Visible = true;
                    TextBox txtquantity = (TextBox)e.Row.FindControl("txtRaisedquantity");
                    txtquantity.Attributes.Add("class", "show");
                    Label lblRaisedquantity = (Label)e.Row.FindControl("lblRaisedquantity");
                    lblRaisedquantity.Attributes.Add("class", "hide");
                }
                else
                {
                    GridViewDetails.Columns[3].Visible = true;
                    TextBox txtquantity = (TextBox)e.Row.FindControl("txtRaisedquantity");
                    txtquantity.Attributes.Add("class", "hide");
                    Label lblRaisedquantity = (Label)e.Row.FindControl("lblRaisedquantity");
                    lblRaisedquantity.Attributes.Add("class", "show");
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading GridViewDetails_RowDataBound Details in ViewintendDetail.aspx.cs", ex);
            //ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }

    }

    protected void gvIntendDetail_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TextBox txtquantity = new TextBox();
                HiddenField hdnIssuedQuantity = new HiddenField();
                HiddenField hdnProductID = new HiddenField();
                HiddenField hdnID = new HiddenField();
                HiddenField hdnBatchNo = new HiddenField();
                TextBox txtRefundAmount = new TextBox();

                txtquantity = (TextBox)e.Row.FindControl("txtquantity");
                hdnIssuedQuantity = (HiddenField)e.Row.FindControl("hdnpQuantity");
                hdnID = (HiddenField)e.Row.FindControl("hdnpID");
                hdnProductID = (HiddenField)e.Row.FindControl("hdnpProductID");
                hdnBatchNo = (HiddenField)e.Row.FindControl("hdnpBatchNo");
                txtRefundAmount.Attributes.Add("readonly", "true");

                string sValidateQty = "ValidateReturnQty('" + hdnIssuedQuantity.ClientID + "','" + txtquantity.ClientID + "');";
                txtquantity.Attributes.Add("onBlur", sValidateQty);
                //string sFunQty = "funcChkAmountQty('" + hdnIssuedQuantity.ClientID +
                //                                   "','" + hdnIssuedAmount.ClientID +
                //                                   "','" + txtReturnQuantity.ClientID +
                //                                   "','" + txtRefundAmount.ClientID + "');";
                //string sFun = "funcChkAmount('" + hdnIssuedQuantity.ClientID +
                //                                 "','" + hdnIssuedAmount.ClientID +
                //                                 "','" + txtReturnQuantity.ClientID +
                //                                 "','" + txtRefundAmount.ClientID + "');";
                //txtReturnQuantity.Attributes.Add("onBlur", sFunQty);
                //txtRefundAmount.Attributes.Add("onBlur", sFun);
                //hdnValues.Value += hdnIssuedQuantity.ClientID + "~" + hdnIssuedAmount.ClientID + "~" + txtReturnQuantity.ClientID + "~" + txtRefundAmount.ClientID + "^";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Billing Details.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }

    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }
}
