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

public partial class Inventory_ViewIntendDetail : Attune_BasePage
{
    public Inventory_ViewIntendDetail()
        : base("StockIntend_ViewIntendDetail_aspx")
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
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Generate_Rejection_Intend", OrgID, ILocationID, out lstInventoryConfig);
          

            if (lstInventoryConfig != null && lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue == "Y")
                {
                    hdnRejectStatus.Value = "Y";
                }
            }
            HideOrShowUsageCount();
            if (!string.IsNullOrEmpty(Request.QueryString["Appr"]) || !string.IsNullOrEmpty(Request.QueryString["tid"]))
            {
                btnApprove.Visible = true;
                if (!string.IsNullOrEmpty(Request.QueryString["tid"]))
                {
                    if (hdnRejectStatus.Value == "Y")
                    {
                        btnReject.Visible = true;
                        //trRejectComments.Attributes.Add("class", "tabletr");
                    }
                    btnCancelIntend.Visible = true;
                   // btnCancelIntend.Attributes.Add("class", "show");
                }
            }
           

            if (Request.QueryString["intID"] != null)
            {
                 
                LoadIntendDetailGrid(Convert.ToInt64(Request.QueryString["intID"]));
            }
            /**----Hide packsize-------------*/
            //HideOrShowUsageCount();
            //if (hdnEnablePackSize.Value == "N")
            //{
            //    GridViewDetails.Columns[9].Visible = false;
            //}
            #region InHandQty

            List<InventoryConfig> lstInventoryConfig_InhandQty = new List<InventoryConfig>();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("HideInhandQty", OrgID, ILocationID, out lstInventoryConfig_InhandQty);
            if (lstInventoryConfig_InhandQty != null && lstInventoryConfig_InhandQty.Count > 0)
            {
                if (lstInventoryConfig_InhandQty[0].ConfigValue == "Y")
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
        string displayTip = Resources.StockIntend_ClientDisplay.StockIntend_ReceivedIndent_aspx_07;
        displayTip = displayTip == null ? "Submit" : displayTip;
        PageContextDetails.ButtonName = "btnRaiseIntend";
        PageContextDetails.ButtonValue = displayTip;

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
           // objIntendDetail.LocationID = InventoryLocationID;
            List<Organization> lstOrganization = new List<Organization>();
            new Organization_BL(ContextInfo).getOrganizationAddress(OrgID, ILocationID, out  lstOrganization);

            if (lstOrganization.Count > 0)
            {
                lblOrgName.Text = OrgName;// lstOrganization[0].OrgDisplayName;
                lblstreet.Text = lstOrganization[0].Address; //+ "," + lstOrganization[0].City;
                lblPhonenumber.Text = lstOrganization[0].PhoneNumber;
            }

            inventoryBL.GetIntendDetail(pIntendID, 0, objIntendDetail.OrgID, objIntendDetail.OrgAddressID,  out lstIntendDetail, out lstIntend);
            //inventoryBL.GetInventoryIndentDetails(pIntendID, objIntendDetail.LocationID, objIntendDetail.OrgID, objIntendDetail.OrgAddressID, objIntendDetail.RaiseOrgID, objIntendDetail.Tolocationid, out lstIntendDetail, out lstIntend);
            if (lstIntend[0] != null)
            {
                frmLocation = lstIntend[0].LocName;
                toLocation = lstIntend[0].ToLocName;
            }

            GridViewDetails.Columns[8].HeaderText = frmLocation.Split('(')[0];
            GridViewDetails.Columns[9].HeaderText = toLocation.Split('(')[0];

            List<Config> lstConfig = new List<Config>();
            int iBillGroupID = 0;
            iBillGroupID = (int)ReportType.OPBill;

            new Configuration_BL(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Logo", OrgID, ILocationID, out lstConfig);
            if (lstConfig!=null && lstConfig.Count > 0)
            {
                //tblBillPrint.Style.Add("background-image", "url('" + lstConfig[0].ConfigValue.Trim() + "'); ");
                imgBillLogo.ImageUrl = lstConfig[0].ConfigValue.Trim();
                if (lstConfig[0].ConfigValue.Trim() != "")
                {
                    imgBillLogo.Attributes.Add("class", "a-center");
                }
                else
                {
                    imgBillLogo.Attributes.Add("class", "hide");
                }
            }
            else
            {
                imgBillLogo.Attributes.Add("class", "hide");
            }

            GateWay headBL = new GateWay(base.ContextInfo);

            if (lstIntend.Count > 0)
            {
                headBL.GetUserDetail(lstIntend[0].CreatedBy, out lstcUsers);
                lblIntendNo.Text = lstIntend[0].IntendNo;
                lblRaiseBy.Text = lstcUsers[0].Name;
                lblDate.Text = lstIntend[0].IntendDate.ToExternalDateTime();
                lblIndentRaiseTo.Text = lstIntend[0].LocName;
                lblIndentFrom.Text = lstIntend[0].ToLocName;
                if (lstIntend[0].Status == "Issued")
                {
                    //btnApprove.Visible = false;
                    //btnCancelIntend.Visible = false;
                    btnCancelIntend.Attributes.Add("class", "hide");
                    btnApprove.Attributes.Add("class", "hide");
                    if (hdnRejectStatus.Value == "Y")
                    {
                        btnReject.Attributes.Add("class", "hide");
                    }
                }
                

                headBL.GetUserDetail(lstIntend[0].ApprovedBy, out lstUsers);

                if (lstUsers!=null && lstUsers.Count > 0)
                {
                    if (lstIntend[0].ApprovedAt.ToShortDateString() != "01/01/0001")
                    {
                        tdApproved.Attributes.Add("class", "show");
                        approvedDateTD.InnerText = lstIntend[0].ApprovedAt.ToExternalDateTime();
                        approvedByTD.InnerHtml = lstUsers[0].Name;
                    }
                }
                else
                {
                    tdApproved.Attributes.Add("class", "hide");
                    approvedDateTD.InnerText = "--";
                    approvedByTD.InnerHtml = "--";
                }
                lblStatus.Text = lstIntend[0].Status;
                if (hdnRejectStatus.Value == "Y")
                {
                    txtRejectComments.Text = lstIntend[0].RejectComments;

                }

                //if (Request.QueryString["Ismail"] != null)
                //{
                //    if (lstIntend[0].Status == "Approved")
                //        Notification();
                //}
            }

            if ((lstIntend[0].Status == "Pending" || lstIntend[0].Status =="Approved"))
            {
                GridViewDetails.DataSource = lstIntendDetail.Where(ID=>ID.Status!="Cancel");
                GridViewDetails.DataBind();
                GridViewDetails.Columns[3].Visible = false;
                GridViewDetails.Columns[4].Visible = true;
                GridViewDetails.Columns[5].Visible = false;
                GridViewDetails.Columns[6].Visible = false;
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
                GridViewDetails.DataSource = lstIntendDetail.Where(ID => ID.Status != "Cancel");
                GridViewDetails.DataBind();
                GridViewDetails.Columns[6].Visible = true;

                GridViewDetails.Visible = true;
                //btnSave.Visible = false;


            }

            else
            {

                GridViewDetails.DataSource = lstIntendDetail.Where(ID => ID.Status != "Cancel");
                GridViewDetails.DataBind();
                //gvIntendDetail.DataSource = lstIntendDetail;
                //gvIntendDetail.DataBind();
                //gvIntendDetail.Visible = true;
                Notification();
                GridViewDetails.Visible = true;
                GridViewDetails.Columns[8].Visible = false;
                GridViewDetails.Columns[9].Visible = false;
                
                //btnSave.Visible = false;
            }
            if (hdnEnablePackSize.Value == "Y")
            {
                GridViewDetails.Columns[10].Visible = true;
                GridViewDetails.Columns[11].Visible = false;
                GridViewDetails.Columns[12].Visible = false;
            }
            else
            {
                GridViewDetails.Columns[10].Visible = false;
                GridViewDetails.Columns[11].Visible = false;
                GridViewDetails.Columns[12].Visible = false;
            }

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Loading Location - IntendViewDetail.aspx", Ex);
        }

    }
 

    protected void btnBack_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["tid"])) { Response.Redirect(@"../InventoryCommon/Home.aspx", true); }
        else{
        Response.Redirect("~/StockIntend/RaiseIntend.aspx");}
    }
    protected void btnIntend_Click(object sender, EventArgs e)
    {
        //long returnCode = -1;
        //long pId = -1;
        //long intendID = 0;
        //long pIndID = 0;
        //long taskid = 0;
        //int flag = 0;
        try
        {
            Button btn = (Button)sender;
            IntendFlow(btn.CommandArgument, "Approved");
           
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
    private void IntendFlow(string CommandArgument,string Status)
    {
        long returnCode = -1;
        long pId = -1;
        long intendID = 0;
        long pIndID = 0;
        long taskid = 0;
        int flag = 0;
        try
        {
           // Button btn = (Button)sender;
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
 

                List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();

                foreach (GridViewRow gR in GridViewDetails.Rows)
                {
                    InventoryItemsBasket objINV = new InventoryItemsBasket();

                    TextBox txtRaisedquantity = (TextBox)gR.FindControl("txtRaisedquantity");
                    double RaisedQty = double.Parse(txtRaisedquantity.Text);
                    if (RaisedQty == 0.00) {
                        flag++;
                        string sPath = Resources.StockIntend_AppMsg.StockIntend_ViewIntendDetail_aspx_02;
                        sPath = sPath == null ? "Provide Quantity" : sPath;

                        string errorMsg = Resources.StockIntend_AppMsg.StockIntend_Error;
                        errorMsg = errorMsg == null ? "Error" : errorMsg;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Mm", "javascript:ValidationWindow('" + sPath + "','" + errorMsg + "');", true); 
                    }
                    else
                    {
                        HiddenField hdnID = (HiddenField)gR.FindControl("hdnpID");
                        HiddenField hdnProductID = (HiddenField)gR.FindControl("hdnProductID");
                        HiddenField SellingUnit = (HiddenField)gR.FindControl("hdnSellingUnit");
                        long IntendID = Convert.ToInt64(hdnID.Value);
                        long ProductID = Convert.ToInt64(hdnProductID.Value);
                        decimal iQty = txtRaisedquantity.Text == "" ? 0 : Convert.ToDecimal(txtRaisedquantity.Text);
                        objINV.CategoryID = 0;
                        objINV.ProductID = ProductID;
                        objINV.Quantity = iQty;
                        objINV.ID = IntendID;
                        objINV.SellingUnit = SellingUnit.Value;
                        lstInventoryItemsBasket.Add(objINV);
                    }
                    
                }
                if (Request.QueryString["intID"] != null)
                {
                    objIntend.IntendID = (Convert.ToInt64(Request.QueryString["intID"]));
                }
                if (hdnRejectStatus.Value == "Y")
                {
                    if (Status == "Reject")
                    {
                        objIntend.Status = StockOutFlowStatus.Rejected;
                        objIntend.RejectComments = hdnRejectReasonvalues.Value;
                    }
                    else
                    {
                        objIntend.Status = StockOutFlowStatus.Approved;
                    }
                }
                else
                {
                    objIntend.Status = StockOutFlowStatus.Approved;
                }
                objIntend.CreatedBy = LID;
                objIntend.IntendDate = DateTimeNow;
                objIntend.OrgID = OrgID;
                objIntend.OrgAddressID = ILocationID;
                objIntend.LocationID = InventoryLocationID;
                DespatchDate = DateTimeNow;

                if (lstInventoryItemsBasket.Count > 0 && flag == 0)
                {
                    inventoryBL = new InventoryCommon_BL(base.ContextInfo);
                    returnCode = inventoryBL.SaveIntend(objIntend, lstInventoryItemsBasket, 1, DespatchDate, out pIndID, out TaskID);
                    Response.Redirect(@"../InventoryCommon/Home.aspx", true);
                }
                // inventoryBL.UpdateStockIssue(intendID, "Approved", LID, OrgID, ILocationID, InventoryLocationID);
                //Notification();
                #endregion
              
               
            }
            else if (Request.QueryString["intID"] != null)
            {
                Int64.TryParse(Request.QueryString["intID"], out intendID);
                returnCode = inventoryBL.UpdateStockIssue(intendID, CommandArgument, LID, OrgID, InventoryLocationID, pId);
                if (returnCode == 0)
                {
                    Response.Redirect(@"../StockIntend/ViewIntendDetail.aspx?ID=" + pId + "&intID=" + intendID, true);
                }
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
    protected void btnRejectdummyconfirm_Click(object sender, EventArgs e)
    {
        try
        {
            Button btn = (Button)sender;
            IntendFlow(btn.CommandArgument,"Reject");
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
        long intendID = 0;
        long taskid = 0;
        try
        {
            Button btn = (Button)sender;
            if (!string.IsNullOrEmpty(Request.QueryString["intID"]) && Request.QueryString["intID"] != "0" && !string.IsNullOrEmpty(Request.QueryString["tid"]))
            {
                Int64.TryParse(Request.QueryString["tid"], out taskid);
                Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
                taskBL.UpdateTask(taskid, TaskHelper.TaskStatus.Completed, LID);
                Int64.TryParse(Request.QueryString["intID"], out intendID);
                inventoryBL.UpdateStockIssue(intendID, "Cancelled", LID, OrgID, ILocationID, InventoryLocationID);
                //  Notification();
                Response.Redirect(@"../InventoryCommon/Home.aspx", true);
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
            //newBasket.Manufacture = DateTimeUtility.GetServerDate();
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
                TextBox txtRefundAmount = new TextBox();
                Label lblRaisedquantity = (Label)e.Row.FindControl("lblRaisedquantity");
                TextBox txtquantity = (TextBox)e.Row.FindControl("txtRaisedquantity");
                txtRaisedquantity = (TextBox)e.Row.FindControl("txtRaisedquantity");
                hdnID = (HiddenField)e.Row.FindControl("hdnpID");
                hdnProductID = (HiddenField)e.Row.FindControl("hdnpProductID");
                hdnBatchNo = (HiddenField)e.Row.FindControl("hdnpBatchNo");

                if (hdnEnablePackSize.Value == "Y")
                {
                    HiddenField hdnpQuantity = (HiddenField)e.Row.FindControl("hdnpQuantity");

                    HiddenField hdnConvertQuantity = (HiddenField)e.Row.FindControl("hdnConvertQuantity");

                    decimal convertTotalQuantity = Convert.ToDecimal(hdnpQuantity.Value) / Convert.ToDecimal(hdnConvertQuantity.Value);

                    e.Row.Cells[11].Text = convertTotalQuantity.ToString();
                    e.Row.Cells[6].Text = lblRaisedquantity.Text + "(" + e.Row.Cells[6].Text + ")";
                    e.Row.Cells[9].Text = e.Row.Cells[11].Text + "(" + e.Row.Cells[9].Text + ")";
                }
                if (!string.IsNullOrEmpty(Request.QueryString["tid"]))
                {
                    GridViewDetails.Columns[3].Visible = true;
                    txtquantity.Attributes.Add("class", "hide");
                    lblRaisedquantity.Attributes.Add("class", "show");
                }
                else {
                    GridViewDetails.Columns[3].Visible = true;
                    txtquantity.Attributes.Add("class", "hide");
                    lblRaisedquantity.Attributes.Add("class", "show");
                }
                

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading GridViewDetails_RowDataBound Details in ViewintendDetail.aspx.cs", ex);
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
        }

    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void HideOrShowUsageCount()
    {
        List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
        new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("EnablePackSize", OrgID, ILocationID, out lstInventoryConfig);
        if (lstInventoryConfig.Count > 0)
        {

            hdnEnablePackSize.Value = lstInventoryConfig[0].ConfigValue.ToUpper();


        }
        else
        {

            hdnEnablePackSize.Value = "N";
        }

    }
}
