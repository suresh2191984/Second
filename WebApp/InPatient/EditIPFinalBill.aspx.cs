using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using System.Collections;
using System.Web.UI.HtmlControls;

public partial class InPatient_EditIPFinalBill:BasePage
{
   
#region DeclarationRegion
    long patientVisitID;
    List<PatientDueChart> lstDueChart = new List<PatientDueChart>();
    List<PatientDueChart> lstBedBooking = new List<PatientDueChart>();
    List<PatientDueChart> lstBedBookingRoomType = new List<PatientDueChart>();
    #endregion 
    long patientID = -1;
    string EditIPBill = string.Empty;
    string patientName = string.Empty;
    string vType = string.Empty;
    string dischargeStatus = string.Empty;
    string VisitState = string.Empty;
    string sEditableUser = string.Empty;
    DateTime dischargeDate;
    string PaymentStatus = string.Empty;
    char s;
    List<Config> lstConfig;
    int savebill = 0;
    decimal pPreAuthAmount = 0;
    decimal GrossBillAmount = 0;
    decimal DueAmount = 0;
    decimal PaidAmount = 0;
    string IsCreditBill = string.Empty;
    bool flag = true;
    protected void Page_Load(object sender, EventArgs e)
    {
        btnSaveTemp.Visible = false;
        btnSave.Visible = true;
        if (Request.QueryString["PNAME"] != null)
        {
            patientName = Request.QueryString["PNAME"].ToString();
        }
        if (Request.QueryString["PID"] != null)
        {
            patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
        }
        if (Request.QueryString["VID"] != null)
        {
            patientVisitID = Convert.ToInt64(Request.QueryString["VID"].ToString());
        }
        if (Request.QueryString["vType"] != null)
        {
            vType = Request.QueryString["vType"].ToString();
        }

        if (Request.QueryString["ADMC"] != null)
        {
            chkDischarge.Enabled = false;
        }
        if (Request.QueryString["EIPBill"] != null)
        {
            int k = Convert.ToInt32(Request.QueryString["vType"]);
            EditIPBill = Request.QueryString["EIPBill"].ToString();
            //chkDischarge.Checked = true;
            //chkDischarge.Enabled = false;
            //chkNonReimburse.Enabled = false;
           
           //trCoPayment.Visible = false;
            hdnEditIPBill.Value = Request.QueryString["EIPBill"].ToString();

        }//=============================================
      
        //pGetIPBillSettlement
        //trPaymentControl.Visible = true;
        if (IsPostBack)
        {
            if (Request.QueryString["EIPBill"] != null)
            {
                //int k = Convert.ToInt32(Request.QueryString["vType"]);
                //EditIPBill = Request.QueryString["EIPBill"].ToString();
                //chkDischarge.Checked = true;
                //chkDischarge.Enabled = false;
                //chkNonReimburse.Enabled = false;
                //trCoPayment.Visible = false;
            }

        }
        if (!IsPostBack)
        {
            if (Request.QueryString["EIPBill"] != null)
            {
                //int k = Convert.ToInt32(Request.QueryString["vType"]);
                //EditIPBill = Request.QueryString["EIPBill"].ToString();
                chkDischarge.Checked = true;
                chkDischarge.Enabled = false;
                chkNonReimburse.Enabled = false;
                //trCoPayment.Visible = false;
            }
            txtDischargeDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
            long visitID = 0;
            //if (Request.QueryString["VID"] != null)
            //{
            //    visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
            //    patientVisitID = visitID;
            //}
            hdn.Value = "";

            long patientID = 0;
            if (Request.QueryString["PID"] != null)
            {
                patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
            }
            string sPaymentType = "";
            if (Request.QueryString["PTYPE"] != null)
            {
                sPaymentType = Request.QueryString["PTYPE"].ToString();
            }
           // LoadCorporateMaster();
            GetCorporateDiscount();
            decimal dAdvanceAmount = 0;
            decimal dTotalAmount = 0;
            decimal dTotalDue = 0;
            decimal dPreviousRefund = 0;
            decimal pTotSurgeryAdv = 0;
            decimal pTotSurgeryAmt = 0;
            decimal dPayerTotal = 0;

            if (Request.QueryString["CKVA"] != null)
            {
                string stv = Request.QueryString["CKVA"].ToString();
                //if (stv.ToUpper() == "Y")
                //{
                //    chkShowUnbilled.Checked = true;
                //}
                //else
                //{
                //    chkShowUnbilled.Checked = false;
                //}
            }
            else
            {
                string stv = GetConfigValue("ShowUnbilled", OrgID);
                //if (stv.ToUpper() == "Y")
                //{
                //    chkShowUnbilled.Checked = true;
                //}
                //else
                //{
                //    chkShowUnbilled.Checked = false;
                //}
            }
            int iBillGroupID2 = 0;
            iBillGroupID2 = (int)ReportType.IPBill;

            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID2, "SplitFBillDA", OrgID, ILocationID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                if (lstConfig[0].ConfigValue.Trim() == "Y")
                {
                    s = 'Y';
                }
            }
            chkShowUnbilled.Checked = false;
            
            chkShowUnbilled.Style.Add("display", "none");

            hdnfrm.Value = "";
            //LoadCorporateMaster();
            GetCorporateDiscount();
            setValues();
            long rateID=0;
            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
            if (lstPatientVisitDetails.Count > 0)
            {
                rateID = lstPatientVisitDetails[0].RateID;

                LoadFeeType(lstPatientVisitDetails[0].VisitType);
            }
            //AutoCompleteConsultant.ContextKey = "CON~" + OrgID.ToString() + "~" + rateID.ToString();
            AutoCompleteConsultant.ContextKey = OrgID.ToString();
            LoadDiscount();

        }
     
    }

    private void LoadFeeType(int VisitType)
    {
        List<FeeTypeMaster> lstFeeTypeMaster = new List<FeeTypeMaster>();
        new BillingEngine(base.ContextInfo).GetFeeType(OrgID, (VisitType == 0 ? "OP" : "IP"), out lstFeeTypeMaster);
        if (lstFeeTypeMaster.Count > 0)
        {
            ddlFeeType.DataSource = lstFeeTypeMaster;
            ddlFeeType.DataTextField = "FeeTypeDesc";
            ddlFeeType.DataValueField = "FeeType";
            ddlFeeType.DataBind();
            ddlFeeType.Items.Insert(0, "--Select Type--");
        }
    }

    protected void gvIndentRoomType_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                PatientDueChart BMaster = (PatientDueChart)e.Row.DataItem;
                //var childItems = from child in lstBedBooking
                //                 where child.RoomTypeName == BMaster.RoomTypeName
                //                 select child;
                List<PatientDueChart> childItems = (from child in lstBedBooking
                                                     where child.RoomTypeName == BMaster.RoomTypeName
                                                     select child).ToList();

                hdnroomtype.Value += BMaster.RoomTypeName;

                GridView childGrid = (GridView)e.Row.FindControl("gvIndentRoomDetails");
                childGrid.DataSource = childItems;
                childGrid.DataBind();
                decimal dtotalAmount = 0;
                decimal NonMedicalAmt = 0;
                decimal MedicalAmt = 0;
                decimal TpaNetAmt = 0;
                decimal ExcessAmt = 0;
                foreach (GridViewRow row1 in childGrid.Rows)
                {
                    TextBox txtUnitPrice = new TextBox();
                    TextBox txtQuantity = new TextBox();
                    TextBox txtAmount = new TextBox();
                    TextBox txtTo = new TextBox();
                    Label lblTo = new Label();
                    Label lblFrom = new Label();
                    Label Comments = new Label();
                    HiddenField hdnAmount = new HiddenField();
                    HiddenField hdnOldPrice = new HiddenField();
                    HiddenField hdnOldQuantity = new HiddenField();
                    //ImageButton ImgBntCalc = new ImageButton();
                    HtmlAnchor ahr = new HtmlAnchor();

                    TextBox txtIndvDiscount = new TextBox();
                    txtIndvDiscount = (TextBox)row1.FindControl("txtDiscount");
                    CheckBox chkVal = (CheckBox)row1.FindControl("chkID");
                    Comments = (Label)row1.FindControl("Comments");
                    lblTo = (Label)row1.FindControl("lblTo");
                    lblFrom = (Label)row1.FindControl("lblFrom");
                   TextBox  txtFrom = (TextBox)row1.FindControl("txtFrom");
                    txtTo = (TextBox)row1.FindControl("txtTo");
                    //ImgBntCalc = (ImageButton)row1.FindControl("ImgBntCalc");
                    txtUnitPrice = (TextBox)row1.FindControl("txtUnitPrice");
                    txtQuantity = (TextBox)row1.FindControl("txtQuantity");
                    txtAmount = (TextBox)row1.FindControl("txtAmount");
                    hdnAmount = (HiddenField)row1.FindControl("hdnAmount");
                    hdnOldPrice = (HiddenField)row1.FindControl("hdnOldPrice");
                    hdnOldQuantity = (HiddenField)row1.FindControl("hdnOldQuantity");
                    ahr = (HtmlAnchor)row1.FindControl("ahrImgBtn");
                    HtmlAnchor ahrfrm = (HtmlAnchor)row1.FindControl("ahrImgBtnfrm");

                    CheckBox chkIsReImbursableItem = (CheckBox)row1.FindControl("chkIsReImbursableItem");

                    hdn.Value += txtFrom.ClientID + "~" + txtQuantity.ClientID + "~" + txtUnitPrice.ClientID + "~" + txtAmount.ClientID + "~" + txtTo.ClientID + "~" + BMaster.RoomTypeName + "^";
                    string sFunProcedures = "CalcItemCost('" + txtUnitPrice.ClientID +
                                                    "','" + txtQuantity.ClientID + "','" + txtAmount.ClientID +
                                                    "','" + hdnAmount.ClientID +
                                                    "','" + hdnOldPrice.ClientID + "','" + hdnOldQuantity.ClientID +
                                                    "','" + txtGross.ClientID + "','" + txtDiscount.ClientID +
                                                    "','" + txtRecievedAdvance.ClientID +
                                                    "','" + txtGrandTotal.ClientID +
                                                    "','" + hdnGross.ClientID +
                                                    "','" + txtIndvDiscount.ClientID +
                                                    "','" + hdnDiscountArray.ClientID +
                                                    "','" + hdnNonMedical.ClientID +
                                                    "','" + lblNonReimbuse.ClientID +
                                                    "','" + hdnMedical.ClientID +
                                                    "','" + lblReimburse.ClientID +
                                                    "','" + chkIsReImbursableItem.ClientID + "','OTHER" +
                                                    "');";

                    string scalcDays = "calcDays('" + txtFrom.ClientID +
                                                   "','" + txtTo.ClientID +
                                                   "','" + txtUnitPrice.ClientID +
                                                   "','" + txtQuantity.ClientID + "','" + txtAmount.ClientID +
                                                   "','" + hdnAmount.ClientID +
                                                   "','" + hdnOldPrice.ClientID + "','" + hdnOldQuantity.ClientID +
                                                   "','" + txtGross.ClientID + "','" + txtDiscount.ClientID +
                                                   "','" + txtRecievedAdvance.ClientID + "','" + txtGrandTotal.ClientID +
                                                   "','" + hdnGross.ClientID +
                                                   "','" + Comments.Text.Trim().Split('~')[1] +
                                                   "','" + txtIndvDiscount.ClientID +
                                                   "','" + hdnDiscountArray.ClientID + 
                                                   "','" + BMaster.RoomTypeName +
                                                   "','" + hdnNonMedical.ClientID +
                                                   "','" + lblNonReimbuse.ClientID +
                                                   "','" + hdnMedical.ClientID +
                                                   "','" + lblReimburse.ClientID +
                                                   "','" + chkIsReImbursableItem.ClientID + "','OTHER" +"');";

                    string sCalcOptional = "checkOptional('" + txtFrom.ClientID +
                                                  "','" + txtTo.ClientID +
                                                  "','" + txtUnitPrice.ClientID +
                                                  "','" + txtQuantity.ClientID + "','" + txtAmount.ClientID +
                                                  "','" + hdnAmount.ClientID +
                                                  "','" + hdnOldPrice.ClientID + "','" + hdnOldQuantity.ClientID +
                                                  "','" + txtGross.ClientID + "','" + txtDiscount.ClientID +
                                                  "','" + txtRecievedAdvance.ClientID + "','" + txtGrandTotal.ClientID +
                                                  "','" + hdnGross.ClientID +
                                                  "','" + Comments.Text.Trim().Split('~')[1] +
                                                  "','" + chkVal.ClientID +
                                                  "','" + txtIndvDiscount.ClientID +
                                                  "','" + hdnDiscountArray.ClientID +
                                                  "','" + hdnNonMedical.ClientID +
                                                  "','" + lblNonReimbuse.ClientID +
                                                  "','" + hdnMedical.ClientID +
                                                  "','" + lblReimburse.ClientID +
                                                  "','" + chkIsReImbursableItem.ClientID + "','OTHER" + "');";
                    

                    txtTo.Attributes.Add("onchange", scalcDays);
                    txtTo.Attributes.Add("onblur", scalcDays);
                    txtFrom.Attributes.Add("onBlur", scalcDays);
                    txtUnitPrice.Attributes.Add("onBlur", sFunProcedures);
                    txtQuantity.Attributes.Add("onBlur", sFunProcedures);
                    txtIndvDiscount.Attributes.Add("onBlur", sFunProcedures);

                    hdnDiscountArray.Value = txtIndvDiscount.ClientID + "|" + hdnDiscountArray.Value.Trim();

                    chkVal.Attributes.Add("OnClick", sCalcOptional);
                    //OnClick="Javascript:alert('id');" 

                    dtotalAmount += Convert.ToDecimal(txtAmount.Text);
                    ahr.HRef = "javascript:NewCal('" + txtTo.ClientID + "','ddmmyyyy',true,12);";
                    ahrfrm.HRef = "javascript:NewCal('" + txtFrom.ClientID + "','ddmmyyyy',true,12);";
                    //txtQuantity.Enabled = true;
                    //txtUnitPrice.Enabled = true;
                    if (txtUnitPrice.Text == "0.00")
                    {
                        row1.BackColor = System.Drawing.Color.Tomato;
                    }
                    if (Comments.Text.Trim().Split('~')[0].ToLower() == "n")
                    {
                        txtTo.Visible = false;
                        ahr.Visible = false;
                        ahrfrm.Visible = false;
                        lblTo.Visible = true;
                        lblFrom.Visible = true;
                        txtFrom.Visible = false;
                        txtUnitPrice.Enabled = false;
                        txtAmount.Enabled = false;

                        //chkIsReImbursableItem.Enabled = true;
                        txtQuantity.Enabled = false;
                        txtIndvDiscount.Enabled = false;
                    }
                    else
                    {
                        txtTo.Visible = true;
                        ahr.Visible = true;
                        lblTo.Visible = false;
                        ahrfrm.Visible = true;
                        lblFrom.Visible = false;
                        txtFrom.Visible = true;
                        
                        txtUnitPrice.Enabled = true;
                        txtAmount.Enabled = true;
                        txtQuantity.Enabled = true;
                        txtIndvDiscount.Enabled = true;
                        
                        if (Comments.Text.Trim().Split('~')[2].ToLower() == "n")
                        {
                            chkVal.Enabled = false;
                        }
                        else
                        {
                            chkVal.Enabled = true;
                        }
                        //chkIsReImbursableItem.Enabled = false;
                    }
                   
                    //chkIsReImbursableItem.Checked = true;

                    if (chkIsReImbursableItem.Checked)
                    {

                        TpaNetAmt += Convert.ToDecimal(txtAmount.Text);
                        MedicalAmt += Convert.ToDecimal(txtAmount.Text);
                    }
                    else
                    {
                         NonMedicalAmt += Convert.ToDecimal(txtAmount.Text);
                    }

                    string CalcNonReimbursable = "doCalcNonReimbursable('" + txtAmount.ClientID +
                                                    "','" + hdnAmount.ClientID +
                                                    "','" + hdnNonMedical.ClientID +
                                                    "','" + lblNonReimbuse.ClientID +
                                                    "','" + hdnMedical.ClientID +
                                                    "','" + lblReimburse.ClientID +
                                                    "','" + chkIsReImbursableItem.ClientID + "');";

                    chkIsReImbursableItem.Attributes.Add("OnClick", CalcNonReimbursable);
                   // commented on 25-02-2011
                   // row1.Cells[row1.Cells.Count-1].Visible = false;
                   // childGrid.HeaderRow.Cells[row1.Cells.Count - 1].Visible = false;
                    row1.Cells[row1.Cells.Count - 1].Style.Add("display", "none"); 
                    childGrid.HeaderRow.Cells[row1.Cells.Count - 1].Style.Add("display", "none");
                }
                txtGross.Text = (Convert.ToDecimal(txtGross.Text) + Convert.ToDecimal(dtotalAmount)).ToString();
                lblNonReimbuse.Text = hdnNonMedical.Value = (Convert.ToDecimal(lblNonReimbuse.Text == "" ? "0.00" : lblNonReimbuse.Text) + NonMedicalAmt).ToString("0.00");
                lblReimburse.Text = hdnMedical.Value =  (Convert.ToDecimal(lblReimburse.Text == "" ? "0.00" : lblReimburse.Text) + MedicalAmt).ToString("0.00");
                //txtExcess.Text = TpaNetAmt.ToString("0.00");
            }
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading grid in IPBillSettlement.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        savebill = 0;
        PaymentStatus = "Paid";
        long visitID = 0;
        if (Request.QueryString["VID"] != null)
        {
            visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        }

        long patientID = 0;
        if (Request.QueryString["PID"] != null)
        {
            patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
        }

        string sPaymentType = "";
        if (Request.QueryString["PTYPE"] != null)
        {
            sPaymentType = Request.QueryString["PTYPE"].ToString();
        }
        decimal amtreceived = 0;
        long sStartID = 0;
        long sEndID = 0;
        long IPInterID = 0;
        string sType = "";

        string receiptNo = savedetails(out amtreceived, out sStartID, out sEndID, out IPInterID, out sType);
        if (Request.QueryString["PNAME"] != null)
        {
            patientName = Request.QueryString["PNAME"].ToString();
        }
        string stv = "";
        if (chkShowUnbilled.Checked)
        { stv = "Y"; }
        else { stv = "N"; }

        string prvou = string.Empty;
        if (ChkRefund.Checked == true)
            prvou = "Y";
        else
            prvou = "N";

        Response.Redirect("~/InPatient/EditIPViewBill.aspx?PID="
            + patientID
            + "&VID=" + visitID
            + "&PNAME=" + "&vType=IP&BP=Y&RNO=" + receiptNo
            + "&AMT=" + amtreceived.ToString()
            + "&SID=" + sStartID.ToString()
            + "&EID=" + sEndID.ToString()
            + "&INTID=" + IPInterID.ToString()
            + "&rType=" + sType
            + "&CKVA=" + stv
            + "&Print=" + prvou
            + "&GB=Y", true);
    }
    protected void btnSaveBill_Click(object sender, EventArgs e)
    {
        savebill = 1;
        try
        {
            long sStartID = 0;
            long sEndID = 0;
            long IPInterID = 0;
            string sType = "";
            long visitID = 0;
            PaymentStatus = "Saved";
           
            decimal amtreceived = 0;
            //savedetails(out amtreceived, out sStartID, out sEndID, out IPInterID, out sType);

            
            //added by suresh

            if (Request.QueryString["VID"] != null)
            {
                visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
            }
            long patientID = 0;
            if (Request.QueryString["PID"] != null)
            {
                patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
            }
            
            if (Request.QueryString["PNAME"] != null)
            {
                patientName = Request.QueryString["PNAME"].ToString();
            }
            string stv = "";
            if (chkShowUnbilled.Checked)
            { stv = "Y"; }
            else { stv = "N"; }

            string receiptNo = savedetails(out amtreceived, out sStartID, out sEndID, out IPInterID, out sType);


            string skey = "../InPatient/IPViewBill.aspx?PID="
           + patientID
           + "&VID=" + visitID
           + "&PNAME=" + "&vType=IP&BP=Y&RNO=" + receiptNo
           + "&AMT=" + amtreceived.ToString()
           + "&SID=" + sStartID.ToString()
           + "&EID=" + sEndID.ToString()
           + "&INTID=" + IPInterID.ToString()
           + "&rType=" + sType
           + "&CKVA=" + stv
           + "&IsPopup=" + "Y"
           + "&CCPage=Y"
           + "";


            Response.Redirect("~/InPatient/IPViewBill.aspx?PID="
             + patientID
             + "&VID=" + visitID
             + "&PNAME=" + "&vType=IP&BP=Y&RNO=" + receiptNo
             + "&AMT=" + amtreceived.ToString()
             + "&SID=" + sStartID.ToString()
             + "&EID=" + sEndID.ToString()
             + "&INTID=" + IPInterID.ToString()
             + "&rType=" + sType
             + "&CKVA=" + stv, true);

           //Response.Redirect("IPBillSettlement.aspx?PID=" + patientID + "&VID=" + patientVisitID + "&PNAME=" + patientName + "&vType=" + vType, true);


            //this.Page.RegisterStartupScript("sky",
            //  "<script language='javascript'> window.open('" + skey + "', '', 'letf=0,top=0,height=640,width=800,toolbar=0,scrollbars=1,status=0');</script>");

            //setValues();

            //end





            //List<Role> lstUserRole = new List<Role>();
            //string path = string.Empty;
            //Role role = new Role();
            //role.RoleID = RoleID;
            //lstUserRole.Add(role);
            //long returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            //Response.Redirect(Request.ApplicationPath  + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    private string savedetails(out decimal dReceived,out long sStartID,out long sEndID,out long IPInterID,out string sType)
    {
        long visitID = 0;
        dReceived = 0;
        string ReceiptNO = string.Empty;
        if (Request.QueryString["VID"] != null)
        {
            visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        }

        long patientID = 0;
        if (Request.QueryString["PID"] != null)
        {
            patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
        }

        decimal FinalAmount = 0;

        string sPaymentType = "";
        if (Request.QueryString["PTYPE"] != null)
        {
            sPaymentType = Request.QueryString["PTYPE"].ToString();
        }

        decimal dServiceCharge = 0;
        decimal.TryParse(hdnServiceCharge.Value, out dServiceCharge);
        dServiceCharge += Convert.ToDecimal(hdnPrevServiceCharge.Value.ToString().Trim());

        List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
        if (gvIndents.Visible == true)
        {
            foreach (GridViewRow row in gvIndents.Rows)
            {
                TextBox txtUnitPrice = new TextBox();
                TextBox txtQuantity = new TextBox();
                TextBox txtAmount = new TextBox();
                HiddenField hdnAmount = new HiddenField();

                TextBox txtItemisedDiscount = (TextBox)row.FindControl("txtDiscount");
                Label lblCommentsgvI = new Label();
                TextBox txtServiceCode = new TextBox();
                
               

                txtUnitPrice = (TextBox)row.FindControl("txtUnitPrice");
                txtQuantity = (TextBox)row.FindControl("txtQuantity");
                txtAmount = (TextBox)row.FindControl("txtAmount");
                hdnAmount = (HiddenField)row.FindControl("hdnAmount");
                lblCommentsgvI = (Label)row.FindControl("lblCommentsgvI");
                txtServiceCode = (TextBox)row.FindControl("txtServiceCode");

                PatientDueChart _PatientDueChart = new PatientDueChart();
                _PatientDueChart.DetailsID = Convert.ToInt64(row.Cells[0].Text);
                _PatientDueChart.FeeID = Convert.ToInt64(row.Cells[2].Text);
                _PatientDueChart.FeeType = row.Cells[1].Text;
                Label chkID = (Label)row.FindControl("chkID");
                _PatientDueChart.Description = chkID.Text.Trim().Split('(')[0] ;

                txtAmount.Text = txtAmount.Text == "" ? txtUnitPrice.Text : txtAmount.Text;
                hdnAmount.Value = (hdnAmount.Value == null || hdnAmount.Value == "") ? txtAmount.Text : hdnAmount.Value;
                _PatientDueChart.Amount = Convert.ToDecimal(txtUnitPrice.Text.ToString());
                _PatientDueChart.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                _PatientDueChart.FromDate = Convert.ToDateTime(row.Cells[7].Text);
                _PatientDueChart.ToDate = Convert.ToDateTime(row.Cells[8].Text);
                _PatientDueChart.Unit = Convert.ToDecimal(txtQuantity.Text.ToString());

                _PatientDueChart.ServiceCode = txtServiceCode.Text.ToString();

                if (txtQuantity.Text != "0")
                {
                    if (PaymentStatus == "Saved")
                    {
                        if (chkDischarge.Checked)
                        {
                            _PatientDueChart.Status = "Paid";
                        }
                        else
                        {

                            if (lblCommentsgvI.Text == "Ordered" || lblCommentsgvI.Text == "Pending")
                            {
                                _PatientDueChart.Status = PaymentStatus;
                            }

                            else
                            {
                                _PatientDueChart.Status = lblCommentsgvI.Text;
                            }
                        }
                        
                    }
                    else
                    {
                        _PatientDueChart.Status = PaymentStatus;
                    }
                }
                else
                {
                    _PatientDueChart.Status = "Deleted";
                }
                _PatientDueChart.FromTable = row.Cells[13].Text.Trim();
                _PatientDueChart.DiscountAmount = Convert.ToDecimal(txtItemisedDiscount.Text.Trim() == "" ? "0" : txtItemisedDiscount.Text.Trim());

                FinalAmount += _PatientDueChart.Amount;

                if (((CheckBox)row.FindControl("chkIsReImbursableItem")).Checked)
                {
                    _PatientDueChart.IsReimbursable = "Y";
                }
                else
                {
                    _PatientDueChart.IsReimbursable = "N";
                }

                lstPatientDueChart.Add(_PatientDueChart);
            }
        }
        //GridView grdView = (GridView)gvIndentRoomType.FindControl("gvIndentRoomDetails");
        if (gvIndentRoomType.Visible == true)
        {
            foreach (GridViewRow row in gvIndentRoomType.Rows)
            {
                GridView grdView = (GridView)row.FindControl("gvIndentRoomDetails");
                foreach (GridViewRow row1 in grdView.Rows)
                {
                    TextBox txtUnitPrice = new TextBox();
                    TextBox txtQuantity = new TextBox();
                    TextBox txtAmount = new TextBox();
                    Label Comments = new Label();
                    HiddenField hdnAmount = new HiddenField();
                    // Label lblFrom = new Label();
                    TextBox txtFrom = new TextBox();
                    TextBox txtTo = new TextBox();
                    CheckBox chkVal = new CheckBox();
                    Label lblDescrip = new Label();
                    TextBox txtItemisedDiscount = (TextBox)row1.FindControl("txtDiscount");

                    txtUnitPrice = (TextBox)row1.FindControl("txtUnitPrice");
                    txtQuantity = (TextBox)row1.FindControl("txtQuantity");
                    txtAmount = (TextBox)row1.FindControl("txtAmount");
                    hdnAmount = (HiddenField)row1.FindControl("hdnAmount");
                    lblDescrip = (Label)row1.FindControl("lblDescrip");

                    // lblFrom = (Label)row1.FindControl("lblFrom");
                    txtFrom = (TextBox)row1.FindControl("txtFrom");
                    txtTo = (TextBox)row1.FindControl("txtTo");
                    chkVal = (CheckBox)row1.FindControl("chkID");
                    Comments = (Label)row1.FindControl("Comments");

                    PatientDueChart _PatientDueChart = new PatientDueChart();

                    //Modified By sami
                    //_PatientDueChart.DetailsID = Convert.ToInt64(row1.Cells[2].Text);//Convert.ToInt64(row1.Cells[0].Text);
                    //_PatientDueChart.FeeID = Convert.ToInt64(row1.Cells[0].Text);//Convert.ToInt64(row1.Cells[2].Text);
                    _PatientDueChart.FeeID = Convert.ToInt64(row1.Cells[2].Text);//Convert.ToInt64(row1.Cells[0].Text);
                    _PatientDueChart.DetailsID = Convert.ToInt64(row1.Cells[0].Text);//Convert.ToInt64(row1.Cells[2].Text);


                    _PatientDueChart.FeeType = row1.Cells[1].Text;
                    _PatientDueChart.Description = lblDescrip.Text.Trim();


                    txtAmount.Text = txtAmount.Text == "" ? txtUnitPrice.Text : txtAmount.Text;
                    hdnAmount.Value = (hdnAmount.Value == null || hdnAmount.Value == "") ? txtAmount.Text : hdnAmount.Value;
                    _PatientDueChart.Amount = Convert.ToDecimal(txtUnitPrice.Text.ToString());
                    _PatientDueChart.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

                    DateTime dtDate = new DateTime();
                    // DateTime.TryParse(lblFrom.Text.Trim(), out dtDate);
                    DateTime.TryParse(txtFrom.Text.Trim(), out dtDate);
                    _PatientDueChart.FromDate = dtDate;
                    DateTime.TryParse(txtTo.Text.Trim(), out dtDate);
                    _PatientDueChart.ToDate = dtDate;
                    _PatientDueChart.Unit = Convert.ToDecimal(txtQuantity.Text.ToString());

                    if (txtQuantity.Text != "0")
                    {
                        if(PaymentStatus=="Saved")
                        {
                            if (chkDischarge.Checked)
                            {
                                _PatientDueChart.Status = "Paid";
                            }
                            else
                            {
                                if (Comments.Text.Trim().Split('~')[0].ToLower() == "n")
                                {
                                    _PatientDueChart.Status = "Paid";
                                }
                                else
                                {
                                    _PatientDueChart.Status = PaymentStatus;
                                }
                            }
                        }
                        else
                        {
                            _PatientDueChart.Status = PaymentStatus;
                        }
                    }
                    else
                    {
                        _PatientDueChart.Status = "Deleted";
                    }
                    _PatientDueChart.FromTable = row1.Cells[10].Text.Trim();
                    _PatientDueChart.DiscountAmount = Convert.ToDecimal(txtItemisedDiscount.Text.Trim() == "" ? "0" : txtItemisedDiscount.Text.Trim());

                    FinalAmount += _PatientDueChart.Amount;

                    if (((CheckBox)row1.FindControl("chkIsReImbursableItem")).Checked)
                    {
                        _PatientDueChart.IsReimbursable = "Y";
                    }
                    else
                    {
                        _PatientDueChart.IsReimbursable = "N";
                    }

                    lstPatientDueChart.Add(_PatientDueChart);
                }
            }
        }
        if (gvMedicalItems.Visible == true)
        {
            foreach (GridViewRow row in gvMedicalItems.Rows)
            {
                TextBox txtUnitPrice = new TextBox();
                TextBox txtQuantity = new TextBox();
                TextBox txtAmount = new TextBox();
                HiddenField hdnAmount = new HiddenField();
                HiddenField hdnphyDate = new HiddenField();
                TextBox txtItemisedDiscount = (TextBox)row.FindControl("txtDiscount");
                Label lblCommentsgvMI = new Label();
                

                txtUnitPrice = (TextBox)row.FindControl("txtUnitPrice");
                txtQuantity = (TextBox)row.FindControl("txtQuantity");
                txtAmount = (TextBox)row.FindControl("txtAmount");
                hdnAmount = (HiddenField)row.FindControl("hdnAmount");
                lblCommentsgvMI = (Label)row.FindControl("lblCommentsgvMI");
                hdnphyDate = (HiddenField)row.FindControl("hdnphyDate");


                PatientDueChart _PatientDueChart = new PatientDueChart();
                _PatientDueChart.DetailsID = Convert.ToInt64(row.Cells[0].Text);
                _PatientDueChart.FeeID = Convert.ToInt64(row.Cells[2].Text);
                _PatientDueChart.FeeType = row.Cells[1].Text;
                _PatientDueChart.Description = row.Cells[3].Text ;
                _PatientDueChart.BatchNo = row.Cells[4].Text;
                if (row.Cells[5].Text == "-")
                {
                    _PatientDueChart.ExpiryDate = DateTime.Parse("01/01/1753");
                }
                else
                {
                    DateTime dtexpDate = new DateTime();
                    DateTime.TryParse(row.Cells[5].Text.Trim(), out dtexpDate);
                    _PatientDueChart.ExpiryDate = dtexpDate;
                }

                txtAmount.Text = txtAmount.Text == "" ? txtUnitPrice.Text : txtAmount.Text;
                hdnAmount.Value = (hdnAmount.Value == null || hdnAmount.Value == "") ? txtAmount.Text : hdnAmount.Value;
                _PatientDueChart.Amount = Convert.ToDecimal(txtUnitPrice.Text.ToString());
                _PatientDueChart.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                DateTime dtDate = new DateTime();
                DateTime.TryParse(hdnphyDate.Value.Trim(), out dtDate);
                _PatientDueChart.ToDate = dtDate;
                _PatientDueChart.FromDate = dtDate;
                _PatientDueChart.Unit = Convert.ToDecimal(txtQuantity.Text.ToString());
                if (txtQuantity.Text != "0")
                {
                    if (PaymentStatus == "Saved")
                    {
                        if (chkDischarge.Checked)
                        {
                            _PatientDueChart.Status = "Paid";
                        }
                        else
                        {
                            if (lblCommentsgvMI.Text == "Ordered" || lblCommentsgvMI.Text == "Pending")
                            {
                                _PatientDueChart.Status = PaymentStatus;
                            }

                            else
                            {
                                _PatientDueChart.Status = lblCommentsgvMI.Text;
                            }
                        }
                    }

                    else
                    {
                        _PatientDueChart.Status = PaymentStatus;
                    }
                }
                else
                {
                    _PatientDueChart.Status = "Deleted";
                }
                _PatientDueChart.FromTable = row.Cells[14].Text.Trim();
                _PatientDueChart.DiscountAmount = Convert.ToDecimal(txtItemisedDiscount.Text.Trim() == "" ? "0" : txtItemisedDiscount.Text.Trim());

                FinalAmount += _PatientDueChart.Amount;

                if (((CheckBox)row.FindControl("chkIsReImbursableItem")).Checked)
                {
                    _PatientDueChart.IsReimbursable = "Y";
                }
                else
                {
                    _PatientDueChart.IsReimbursable = "N";
                }

                lstPatientDueChart.Add(_PatientDueChart);
            }
        }

        string isCreditBill = "";
        if (chkisCreditTransaction.Checked == true)
        {
            isCreditBill = "Y";
        }
        else
        {
            isCreditBill = "N";
        }

        txtGross.Text = FinalAmount.ToString();

        txtDiscount.Text = txtDiscount.Text == "" ? "0" : txtDiscount.Text;
        txtRecievedAdvance.Text = txtRecievedAdvance.Text == "" ? "0" : txtRecievedAdvance.Text;
        txtGrandTotal.Text = txtGrandTotal.Text == "" ? "0" : txtGrandTotal.Text;
        hdnAmountReceived.Value = hdnAmountReceived.Value == "" ? "0" : hdnAmountReceived.Value;

        decimal pAmtReceived = Convert.ToDecimal(hdnAmountReceived.Value.ToString());
        decimal pAdvanceReceived = Convert.ToDecimal(txtRecievedAdvance.Text);
        decimal pPreviousDue = Convert.ToDecimal(txtPreviousDue.Text);
        decimal PreviousAmountReceived = Convert.ToDecimal(txtPreviousAmountPaid.Text);
        decimal pAmountReceived = pAmtReceived;
        decimal pRoundOff = 0;
        decimal.TryParse(hdnRoundOff.Value, out pRoundOff);
        //decima

        decimal pRefundAmount = 0;

        string sreasonforRefund = "";
        int payamenttype = 0;
        string bankname = string.Empty;
        long checkno = 0;
        if (ChkRefund.Checked == true)
        {
            pRefundAmount = Convert.ToDecimal(txtRefundAmount.Text);
            sreasonforRefund = txtReasonForRefund.Text;
            payamenttype = Convert.ToInt16(ddlPayMode.SelectedItem.Value);
            
            if (ddlPayMode.SelectedItem.Value == "2")
            {
                bankname = txtBankName.Text;
                checkno = Convert.ToInt64(txtCardNo.Text);

            }
        }

        decimal pDiscountAmount = Convert.ToDecimal(txtDiscount.Text);
        string pDiscountReason = txtDiscountReason.Text;
        decimal pDue = 0;
        decimal ptax = 0;
        decimal.TryParse(txtTax.Text, out ptax);

        if (pAmountReceived == FinalAmount)
        {
            pDue = 0;
        }
        else
        {
            //pDue = FinalAmount - pDiscountAmount + ptax - pAmountReceived;
            pDue = (FinalAmount + pRoundOff - pDiscountAmount + ptax - pAdvanceReceived - pAmountReceived - PreviousAmountReceived + pPreviousDue);
        }

        decimal pGrossBillValue = (FinalAmount + pPreviousDue) -
            (pDiscountAmount + pAdvanceReceived);
        // decimal pGrossBillValue =Convert.ToDecimal (txtGross.Text);

        decimal pnetValue = (FinalAmount + pRoundOff + ptax - pDiscountAmount);

        decimal pNonMedicalAmtPaid = decimal.Zero;
        decimal pCoPayment = decimal.Zero;
        decimal pExcess = decimal.Zero;

        pNonMedicalAmtPaid = hdnNonMedical.Value == "" || Convert.ToDecimal(hdnNonMedical.Value) == 0 ? decimal.Zero : Convert.ToDecimal(hdnNonMedical.Value);
        pCoPayment = hdnCoPaymentFinal.Value == "" || Convert.ToDecimal(hdnCoPaymentFinal.Value) == 0 ? decimal.Zero : Convert.ToDecimal(hdnCoPaymentFinal.Value);
        pExcess = hdnExcess.Value == "" || Convert.ToDecimal(hdnExcess.Value) == 0 ? decimal.Zero : Convert.ToDecimal(hdnExcess.Value);

        System.Data.DataTable dtAmtReceivedDetails = new System.Data.DataTable();
        dtAmtReceivedDetails = PaymentType.GetAmountReceivedDetails();

        PaymentType.clearDatas();


        // code added for discharge date - begins
        if (chkDischarge.Checked)
        {
            dischargeStatus = "Discharged";
            dischargeDate = Convert.ToDateTime(txtDischargeDate.Text);

        }
        else
        {
            dischargeDate = Convert.ToDateTime("01/01/2001");
        }
        // code added for discharge date - ends

        List<TaxBillDetails> lstTaxBill = new List<TaxBillDetails>();
        //hard coded for KMH
        if (OrgID == 78)
        {
            lstTaxBill = getTaxForKMH();
        }
        else
        {
            lstTaxBill = getTaxDetails();
        }

        if (Request.QueryString["ADMC"] != null)
        {
            VisitState = "ADMC";
        }
        ReceiptNO = string.Empty;
        sStartID = 0;
        sEndID = 0;
        IPInterID = 0;
        sType = "";

        if (chkShowUnbilled.Checked && hdnIsBilledBefore.Value == "Y")
        {
            pNonMedicalAmtPaid = pNonMedicalAmtPaid + Convert.ToDecimal(hdnNonReimburseFields.Value.Split('~')[0]);
           pCoPayment = pCoPayment + Convert.ToDecimal(hdnNonReimburseFields.Value.Split('~')[1]);
            pExcess = pExcess + Convert.ToDecimal(hdnNonReimburseFields.Value.Split('~')[2]);
            pDiscountAmount += Convert.ToDecimal(hdnDiscountDetails.Value.Split('~')[0]);
            pDiscountReason = hdnDiscountDetails.Value.Split('~')[1] == "" ? pDiscountReason : hdnDiscountDetails.Value.Split('~')[1];
        }
        else
        {
           // pDiscountAmount needs a hdn
            
        }

        //if (savebill == 1)
        //{
        //    new PatientVisit_BL(base.ContextInfo).pSaveIPFinalBill(lstPatientDueChart, visitID, LID, OrgID,
        //                                                               pAmountReceived, pRefundAmount, sreasonforRefund,payamenttype, bankname, checkno,
        //                                                               pDiscountAmount, pDue,
        //                                                               pGrossBillValue, isCreditBill,
        //                                                               pnetValue, pAdvanceReceived,
        //                                                               dtAmtReceivedDetails, pAmtReceived,
        //                                                               LID, dischargeStatus, dischargeDate,
        //                                                               lstTaxBill, pDiscountReason, dServiceCharge, VisitState,
        //                                                               pNonMedicalAmtPaid, pCoPayment, pExcess,
        //                                                               out ReceiptNO, out sStartID, out sEndID, out IPInterID, out sType, pRoundOff);
        //}
        //else


        new PatientVisit_BL(base.ContextInfo).EditIPFinalBillAfterDischarge(lstPatientDueChart, visitID, LID, OrgID,
                                                                     pAmountReceived, pRefundAmount, sreasonforRefund, payamenttype, bankname, checkno,
                                                                     pDiscountAmount, pDue,
                                                                     pGrossBillValue, isCreditBill,
                                                                     pnetValue, pAdvanceReceived,
                                                                     dtAmtReceivedDetails, pAmtReceived,
                                                                     LID, dischargeStatus, dischargeDate,
                                                                     lstTaxBill, pDiscountReason, dServiceCharge, VisitState,
                                                                     pNonMedicalAmtPaid, pExcess,
                                                                     out ReceiptNO, out sStartID, out sEndID, out IPInterID, out sType, pRoundOff);
        //}
        dReceived = pAmountReceived;
        hdnAmountReceived.Value = "";
        return ReceiptNO;

        //Sami Added New lines

       

    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            long returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath  + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void gvIndents_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            PatientDueChart pdc = (PatientDueChart)e.Row.DataItem;
            if (pdc.IsReimbursable != "N")
            {
                ((CheckBox)e.Row.FindControl("chkIsReImbursableItem")).Checked = true;
            }
            else
            {
                ((CheckBox)e.Row.FindControl("chkIsReImbursableItem")).Checked = false;
            }





        }



       
        e.Row.Cells[0].Visible = false;
        e.Row.Cells[1].Visible = false;
        e.Row.Cells[2].Visible = false;
        e.Row.Cells[9].Visible = false;
        e.Row.Cells[10].Visible = false;
        //e.Row.Cells[12].Visible = true;
        
    }

    protected void gvIndents1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            decimal NonMedicalAmt = 0;
            decimal TpaNetAmt = 0;
            decimal ExcessAmt = 0;
            PatientDueChart pdc = (PatientDueChart)e.Row.DataItem;
            if (pdc.IsReimbursable != "N")
            {
                ((CheckBox)e.Row.FindControl("chkIsReImbursableItem")).Checked = true;
            }
            else
            {
                ((CheckBox)e.Row.FindControl("chkIsReImbursableItem")).Checked = false;
            }
           // txtExcess.Text =Convert.ToDecimal(txtExcess.Text==""?"0.00":txtExcess.Text) + TpaNetAmt.ToString("0.00");
        }
        ///====================================================================================
        if (s == 'Y')
        {
            //Label txtUnitPrice = (Label)e.Row.FindControl("txtUnitPrice");
            Label chkID1 = (Label)e.Row.FindControl("chkID");



            if ((e.Row.Cells[1].Text == "SPKG"))
            {


                string[] s1 = chkID1.Text.Split('~');
                chkID1.Text = s1[0].ToString();
                //txtUnitPrice.Text = s1[2].ToString();

            }
        }
        //======================================================================================
        e.Row.Cells[0].Visible = false;
        e.Row.Cells[1].Visible = false;
        e.Row.Cells[2].Visible = false;
        e.Row.Cells[3].Visible = false;
        //e.Row.Cells[11].Visible = false;
        e.Row.Cells[12].Visible = false;
        e.Row.Cells[13].Visible = false;
    }
    protected void gvPharmacy_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            PatientDueChart pdc = (PatientDueChart)e.Row.DataItem;
            if (pdc.IsReimbursable != "N")
            {
                ((CheckBox)e.Row.FindControl("chkIsReImbursableItem")).Checked = true;
            }
            else
            {
                ((CheckBox)e.Row.FindControl("chkIsReImbursableItem")).Checked = false;
            }
            if(pdc.ExpiryDate<DateTime.Parse("01/01/1900"))
            {
                e.Row.Cells[5].Text = "-";
            }
            if (pdc.BatchNo == "")
            {
                e.Row.Cells[4].Text = "-";
            }
        }
       

        e.Row.Cells[0].Visible = false;
        e.Row.Cells[1].Visible = false;
        e.Row.Cells[2].Visible = false;

        e.Row.Cells[10].Visible = false;
        //e.Row.Cells[11].Visible = false;
        e.Row.Cells[14].Visible = false;
    }
    protected void gridAttributesAdd(GridView gvDataGrid)
    {
        decimal dtotalAmount = 0;
        string sStatus = "";
        string sFeetype="";

        decimal NonMedicalAmt = 0;
        decimal TpaNetAmt = 0;
        decimal ExcessAmt = 0;
        decimal MedicalAmt = 0;

        foreach (GridViewRow row in gvDataGrid.Rows)
        {
            TextBox txtUnitPrice = new TextBox();
            TextBox txtQuantity = new TextBox();
            TextBox txtAmount = new TextBox();
            HiddenField hdnAmount = new HiddenField();
            HiddenField hdnOldPrice = new HiddenField();
            HiddenField hdnOldQuantity = new HiddenField();
            Label lblComments = (Label)row.FindControl("lblComments");
            lblComments.Text = lblComments.Text.Split('~')[0];

            txtUnitPrice = (TextBox)row.FindControl("txtUnitPrice");
            txtQuantity = (TextBox)row.FindControl("txtQuantity");
            txtAmount = (TextBox)row.FindControl("txtAmount");

            hdnAmount = (HiddenField)row.FindControl("hdnAmount");
            hdnOldPrice = (HiddenField)row.FindControl("hdnOldPrice");
            hdnOldQuantity = (HiddenField)row.FindControl("hdnOldQuantity");
            TextBox txtIndvDiscount = new TextBox();
            txtIndvDiscount = (TextBox)row.FindControl("txtDiscount");
            CheckBox chkIsReImbursableItem = (CheckBox)row.FindControl("chkIsReImbursableItem");
            string sFunProcedures = "CalcItemCost('" + txtUnitPrice.ClientID +
                                            "','" + txtQuantity.ClientID + "','" + txtAmount.ClientID +
                                            "','" + hdnAmount.ClientID +
                                            "','" + hdnOldPrice.ClientID + "','" + hdnOldQuantity.ClientID +
                                            "','" + txtGross.ClientID + "','" + txtDiscount.ClientID +
                                            "','" + txtRecievedAdvance.ClientID + 
                                            "','" + txtGrandTotal.ClientID + 
                                            "','" + hdnGross.ClientID +
                                            "','" + txtIndvDiscount.ClientID +
                                            "','" + hdnDiscountArray.ClientID +
                                            "','" + hdnNonMedical.ClientID +
                                            "','" + lblNonReimbuse.ClientID +
                                            "','" + hdnMedical.ClientID +
                                            "','" + lblReimburse.ClientID +
                                            "','" + chkIsReImbursableItem.ClientID + "','OTHER" +
                                            "');";

            txtUnitPrice.Attributes.Add("onBlur", sFunProcedures);
            txtQuantity.Attributes.Add("onBlur", sFunProcedures);
            txtIndvDiscount.Attributes.Add("onBlur", sFunProcedures);

            dtotalAmount += Convert.ToDecimal(txtAmount.Text);
            hdnDiscountArray.Value = txtIndvDiscount.ClientID + "|" + hdnDiscountArray.Value.Trim();
             
            long lEditRoleID = 0;
            Int64.TryParse(sEditableUser,out lEditRoleID);

            //if ((RoleName.ToLower() != "Administrator") && (lEditRoleID != RoleID))
            //{
                sStatus = row.Cells[12].Text.Trim();

              //  chkIsReImbursableItem.Enabled = false;
            //To enable the data in text box

                sFeetype = row.Cells[1].Text.Trim();
                //if ((sStatus.ToLower() == "ordered") || (sStatus.ToLower() == "pending") || (sStatus.ToLower() == "saved"))
                //{
                //    txtQuantity.Enabled = sFeetype.ToUpper() != "PRM" ? true : false;
                //    txtUnitPrice.Enabled = true;
                //    txtAmount.Enabled = true;
                //    txtIndvDiscount.Enabled = true;
                //    //chkIsReImbursableItem.Enabled = true;
                //}
                //else
                //{
                //    txtQuantity.Enabled = false;
                //    txtUnitPrice.Enabled = false;
                //    txtAmount.Enabled = false;
                //    txtIndvDiscount.Enabled = false;
                //    //chkIsReImbursableItem.Enabled = false;
                //}
            //}
            if (txtUnitPrice.Text == "0.00")
            {
                row.BackColor = System.Drawing.Color.Tomato;
            }

            
            //chkIsReImbursableItem.Checked = true;
            string CalcNonReimbursable = "doCalcNonReimbursable('" + txtAmount.ClientID +
                                                    "','" + hdnAmount.ClientID +
                                                    "','" + hdnNonMedical.ClientID +
                                                    "','" + lblNonReimbuse.ClientID +
                                                    "','" + hdnMedical.ClientID +
                                                    "','" + lblReimburse.ClientID +
                                                    "','" + chkIsReImbursableItem.ClientID + "');";

            chkIsReImbursableItem.Attributes.Add("OnClick", CalcNonReimbursable);



            if (chkIsReImbursableItem.Checked)
            {

                TpaNetAmt += Convert.ToDecimal(txtAmount.Text);
                MedicalAmt += Convert.ToDecimal(txtAmount.Text);
            }
            else
            {
                NonMedicalAmt += Convert.ToDecimal(txtAmount.Text);
            }

        }
        txtGross.Text = (Convert.ToDecimal(txtGross.Text) + Convert.ToDecimal(dtotalAmount)).ToString();
        lblNonReimbuse.Text = hdnNonMedical.Value = (Convert.ToDecimal(lblNonReimbuse.Text == "" ? "0.00" : lblNonReimbuse.Text) + NonMedicalAmt).ToString("0.00");
        lblReimburse.Text = hdnMedical.Value = (Convert.ToDecimal(lblReimburse.Text == "" ? "0.00" : lblReimburse.Text) + MedicalAmt).ToString("0.00");
        //txtExcess.Text = TpaNetAmt.ToString("0.00");
    }

    protected void btnAddAmt_Click(object sender, EventArgs e)
    {
        try
        {
            long visitID = 0;
            if (Request.QueryString["VID"] != null)
            {
                visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
            }

            long patientID = 0;
            if (Request.QueryString["PID"] != null)
            {
                patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
            }
            string pType = "PNOW";
             
            PatientDueChart pDueChart = new PatientDueChart();
            pDueChart.DetailsID = 0;
            pDueChart.VisitID = visitID;
            pDueChart.PatientID = patientID;
            //pDueChart.FeeType = "OTH";
            //pDueChart.FeeID = -1;
            pDueChart.Description = txtFeeDesc.Text;

            pDueChart.Amount = Convert.ToDecimal(txtAmnt.Text);
            pDueChart.FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            pDueChart.ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            if (pType.ToLower() == "pnow")
            {
                pDueChart.Status = "Pending";//
                pDueChart.Comments = txtAmnt.Text.Trim();
            }
            else
            {
                pDueChart.Comments = "0";
                pDueChart.Status = "Pending";
            }

            pDueChart.Unit = 1;

            pDueChart.CreatedBy = Convert.ToInt32(LID);

            if (chkNonReimburse.Checked)
            {
                pDueChart.IsReimbursable = "Y";
            }
            else
            {
                pDueChart.IsReimbursable = "N";
            }

            pDueChart.FeeType = ddlFeeType.SelectedValue == "LAB" ? "INV" : ddlFeeType.SelectedValue;

            if (ddlFeeType.SelectedValue.Equals("CON"))
            {
                pDueChart.FeeID = long.Parse(hdnFilterPhysicianID.Value);
            }
            else
            {
                pDueChart.FeeID = -1;
            }
            string InterimBillNo = string.Empty;
            new PatientVisit_BL(base.ContextInfo).InsertAdditionalBillItems(pDueChart, pType, out InterimBillNo);

            Response.Redirect("EditIPFinalBill.aspx?PID=" + patientID + "&VID=" + patientVisitID + "&PNAME=" + patientName + "&vType=" + vType, false);
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in EditIPFinalBill", ex);
        }
    }

    protected string NumberConvert(object a, object b)
    {
        decimal c = 0;
        c = (decimal)a * (decimal)b;
        return c.ToString("0.00");
    }

    //public void LoadCorporateMaster()
    //{
    //    IP_BL invBL = new IP_BL(base.ContextInfo);
    //    List<CorporateMaster> lstCorporateMaster = new List<CorporateMaster>();
    //    invBL.GetCorporateMaster(OrgID, out lstCorporateMaster);
    //    ddlCorporate.DataSource = lstCorporateMaster;
    //    ddlCorporate.DataTextField = "CorporateName";
    //    ddlCorporate.DataValueField = "CorporateID";
    //    ddlCorporate.DataBind();
    //    ddlCorporate.Items.Insert(0, "---Select---");
    //    ddlCorporate.Items[0].Value = "0";
    //}

    public void GetCorporateDiscount()
    {
        BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
        List<CorporateMaster> lstCorporateMaster = new List<CorporateMaster>();
        PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo);
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        patientVisitBL.GetCorporateClientByVisit(patientVisitID, out lstPatientVisit);
        if (lstPatientVisit.Count > 0)
        {
            hdnCorporateDiscount.Value += lstPatientVisit[0].Discount + "~" + lstPatientVisit[0].DiscountType + "^";
            //if (lstPatientVisit[0].CorporateID != 0)
            //{
            //    ddlCorporate.SelectedValue = lstPatientVisit[0].CorporateID.ToString();
            //    ddlCorporate.Enabled = false;
            //} 
            //if (lstPatientVisit[0].ClientID == 0)
            //{
            //billingEngineBL.GetCorporateDiscount(OrgID, out lstCorporateMaster);
            //if (lstCorporateMaster.Count > 0)
            //{
            //    foreach (CorporateMaster objCorporateMaster in lstCorporateMaster)
            //    {
            //        hdnCorporateDiscount.Value += objCorporateMaster.CorporateID + "~" + objCorporateMaster.CorporateName + "~" + objCorporateMaster.Discount + "~" + objCorporateMaster.DiscountType + "^";
            //    }
            //}
            //}
        }
    }

    protected void LoadTaxForKMH(List<Taxmaster> lstTaxes)
    {
        if(lstTaxes.Count > 0)
        hdnTaxAmount.Value = txtTax.Text = lstTaxes[0].TaxAmount.ToString();
    }

    protected void LoadTaxMaster(List<Taxmaster> lstTaxes)
     {
         BillingEngine billBL = new BillingEngine(base.ContextInfo);
        List<Taxmaster> lstTaxMaster = new List<Taxmaster>();
        billBL.GetTaxDetails(OrgID, out lstTaxMaster);
        bool? isPresent = false;

        string sHtml = "";
         

        foreach (Taxmaster tm in lstTaxMaster)
        {
            foreach (Taxmaster tms in lstTaxes)
            {
                if (tm.TaxID == tms.TaxID)
                {
                    //if (tm.TaxName == "Custom")
                    //{
                    //    isPresent = true;
                    //    tm.TaxAmount = lstTaxes[0].TaxAmount;
                    //}
                    //else
                    //{
                        isPresent = true;
                        tm.TaxPercent = lstTaxes[0].TaxPercent;
                        hdnManualTaxPercentage.Value = lstTaxes[0].TaxPercent.ToString();
                    //}
                }
                
            }
            if (isPresent == false)
            {
                //if (tm.TaxName == "Custom")
                //{
                //    sHtml += " <input type='checkbox' id='chktax#" + tm.TaxID + "' value='" + tm.TaxAmount + "' runat='server' onclick='chkCustomTax(this.id,this.value);' > " + tm.TaxName + "</input> </br>";
                //}
                //else
                //{
                    sHtml += " <input type='checkbox' id='chktax#" + tm.TaxID + "' value='" + tm.TaxPercent + "' runat='server' onclick='chkTaxPayment(this.id,this.value);' > " + tm.TaxName + "</input> </br>";
                //}
            }
            else
            {
                //if (tm.TaxName == "Custom")
                //{
                //    sHtml += " <input type='checkbox' id='chktax#" + tm.TaxID + "' value='" + tm.TaxAmount + "' runat='server' checked='true' onclick='chkCustomTax(this.id,this.value);' > " + tm.TaxName + "</input> </br>";
                //    this.Page.RegisterStartupScript("kx", "<script language='javascript' >chkCustomTax('chktax#" + tm.TaxID + "','" + tm.TaxAmount + "');</script>");
                //}
                //else
                //{
                    sHtml += " <input type='checkbox' id='chktax#" + tm.TaxID + "' value='" + tm.TaxPercent + "' runat='server' checked='true' onclick='chkTaxPayment(this.id,this.value);' > " + tm.TaxName + "</input> </br>";
                    this.Page.RegisterStartupScript("ky", "<script language='javascript' >chkTaxPayment('chktax#" + tm.TaxID + "','" + tm.TaxPercent + "');</script>");
                //}
               
            }
            isPresent = false;
        }
        dvTaxDetails.InnerHtml = sHtml;
    }

    private List<TaxBillDetails> getTaxForKMH()
    {
        string ta = string.Empty;
        ta = hdnTaxAmount.Value;
        List<TaxBillDetails> lstTax = new List<TaxBillDetails>();
        decimal percent = (Convert.ToDecimal(ta) * 100) / Convert.ToDecimal(txtGross.Text);
        lstTax.Add(new TaxBillDetails() { TaxID = 0, TaxAmount = Convert.ToDecimal(ta), TaxPercent = percent });
        return lstTax;
    }

    private List<TaxBillDetails> getTaxDetails()
    {
        string ta = string.Empty;
        ta = hdnTaxAmount.Value;
        List<TaxBillDetails> lstTax = new List<TaxBillDetails>();
        if (hdfTax.Value != null)
        {
            foreach (string sValue in hdfTax.Value.ToString().Split('>'))
            {
                if (sValue != "")
                {
                    TaxBillDetails tTax = new TaxBillDetails();
                    tTax.TaxID = Convert.ToInt32(sValue.Split('~')[0].Split('#')[1]);
                    if (hdnManualTaxPercentage.Value == "0")
                    {
                        tTax.TaxPercent = Convert.ToDecimal(sValue.Split('~')[1]);
                    }
                    else
                    {
                        tTax.TaxPercent = Convert.ToDecimal(hdnManualTaxPercentage.Value);
                    }
                    tTax.TaxAmount = Convert.ToDecimal(hdnTaxAmount.Value);
                    lstTax.Add(tTax);
                }
            }
        }
        //if (lstTax.Count == 0)
        //{
        //    decimal percent = (Convert.ToDecimal(ta) * 100) / Convert.ToDecimal(txtGross.Text);
        //    lstTax.Add(new TaxBillDetails(){ TaxID = 0, TaxAmount = Convert.ToDecimal(ta), TaxPercent = percent});
        //}
        return lstTax;
    }

    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }

    protected void chkShowUnbilled_CheckedChanged(object sender, EventArgs e)
    {
        setValues();
        //hdnNonMedical.Value = lblNonReimbuse.Text;
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "Reload", "javascript:calculateDiscountForCorporate();",true);
    }
    private void setValues()
    {
        long visitID = 0;
        hdnDiscountArray.Value = "";
        if (Request.QueryString["VID"] != null)
        {
            visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
            patientVisitID = visitID;
        }
        long patientID = 0;
        if (Request.QueryString["PID"] != null)
        {
            patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
        }
        string sPaymentType = "";
        if (Request.QueryString["PTYPE"] != null)
        {
            sPaymentType = Request.QueryString["PTYPE"].ToString();
        }
        decimal dAdvanceAmount = 0;
        decimal dTotalAmount = 0;
        decimal dTotalDue = 0;
        decimal dPreviousRefund = 0;
        decimal pTotSurgeryAdv = 0;
        decimal pTotSurgeryAmt = 0;
        decimal dPayerTotal = 0;
        hdnGross.Value = "0";
        txtGross.Text = "0";
        txtTax.Text = "0";
        
        hdfTax.Value = "";
        hdnTaxAmount.Value = "0";
        txtServiceCharge.Text = "0";
        hdnServiceCharge.Value = "0";
        hdnPrevServiceCharge.Value = "0";
        PatientHeader.PatientID = patientID;
        PatientHeader.PatientVisitID = visitID;

        //newly added
        hdnCoPaymentFinal.Value=hdnExcess.Value=lblNonReimbuse.Text = hdnNonMedical.Value = "0.00";
        lblReimburse.Text = hdnMedical.Value = "0.00";

        txtExcess.Text = "0.00";

        List<Patient> lstPatientDetail = new List<Patient>();
        List<Organization> lstOrganization = new List<Organization>();
        List<Physician> physicianName = new List<Physician>();
        List<Taxmaster> lstTaxes = new List<Taxmaster>();
        List<FinalBill> lstFinalBill = new List<FinalBill>();
        List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();
        string strConfigKey = "IsSurgeryAdvance";
        string configValue = GetConfigValue(strConfigKey, OrgID);

        //This lines added fro getting preauth amount and checking the creditbill


        BillingEngine be = new BillingEngine(base.ContextInfo);
        decimal Copercent = -1;
        be.CheckIsCreditBill(visitID, out PaidAmount, out GrossBillAmount, out DueAmount, out IsCreditBill, out lstVisitClientMapping);
        if (IsCreditBill == "Y")
        {
            chkisCreditTransaction.Checked = true;
            string rVal = GetConfigValue("RoundOffTPAAmt", OrgID);
            hdnDefaultRoundoff.Value = rVal == "" ? "0" : rVal;
            rVal = GetConfigValue("TPARoundOffPattern", OrgID);
            hdnRoundOffType.Value = rVal;

            trNonReimburse.Attributes.Add("display", "block");
            trCoPayment.Style.Add("display", "block");
            trExcess.Style.Add("display", "block");

        }
        else
        {
            string rVal = GetConfigValue("RoundOffPatAmt", OrgID);
            hdnDefaultRoundoff.Value = rVal == "" ? "0" : rVal;
            rVal = GetConfigValue("PatientRoundOffPattern", OrgID);
            hdnRoundOffType.Value = rVal;

            chkisCreditTransaction.Enabled = false;
            trNonReimburse.Style.Add("display", "none");
           trCoPayment.Style.Add("display", "none");
            trExcess.Style.Add("display", "none");

        }

        if (pPreAuthAmount > 0 && IsCreditBill == "Y")
        {
            Preauth.Style.Add("display", "block");
            lblPreAuthAmount.Text = pPreAuthAmount.ToString();
        }

        decimal pNonMedicalAmtPaid = decimal.Zero;
        decimal pCoPayment = decimal.Zero;
        decimal pExcess = decimal.Zero;
        string AdmissionDate ="01/01/1753";
        string MaxBillDate = "01/01/1753";
        string IsVisitHaveChild = string.Empty;
        new PatientVisit_BL(base.ContextInfo).GetIPBillSettlement(visitID, patientID, OrgID,
                                                    out dTotalAmount, out dAdvanceAmount,
                                                    out dTotalDue, out dPreviousRefund,
                                                    out lstDueChart, out lstBedBooking, out pTotSurgeryAdv,
                                                    out pTotSurgeryAmt,
                                                    out lstPatientDetail, out lstOrganization,
                                                    out physicianName, out lstTaxes,
                                                    out lstFinalBill, out dPayerTotal,
                                                    out pNonMedicalAmtPaid, out pCoPayment, out pExcess, out AdmissionDate,
                                                    out MaxBillDate, out IsVisitHaveChild,0);
        //if (lstTaxes.Count > 0)
        //{
        
        //}
        if (OrgID == 78)
        {
            LoadTaxForKMH(lstTaxes);
        }
        else
        {
            LoadTaxMaster(lstTaxes);
        }

        hdnAdmissionDate.Value = DateTime.Parse(AdmissionDate).ToString();
        hdnMaxBillDate.Value = DateTime.Parse(MaxBillDate).ToString();

        txtCopercent.Text = lstFinalBill.Count > 0 ? lstVisitClientMapping[0].CopaymentPercent.ToString("0.00") : "0.00";
        txtNonMedical.Text = pNonMedicalAmtPaid > 0 ? pNonMedicalAmtPaid.ToString("0.00") : 0.ToString("0.00");
        txtExcess.Text = pExcess > 0 ? pExcess.ToString("0.00") : 0.ToString("0.00");
        txtCoPayment.Text = pCoPayment > 0 ? pCoPayment.ToString("0.00") : 0.ToString("0.00");

            hdnIsBilledBefore.Value = lstDueChart.Where(w => w.Status == "Paid").Select(w => w).Count() > 0 ? "Y" : "N";

            hdnNonReimburseFields.Value = pNonMedicalAmtPaid.ToString() +"~"+ pExcess.ToString() +"~"+ pCoPayment.ToString();
        
        if (chkShowUnbilled.Checked && hdnIsBilledBefore.Value == "Y")
        {
            decimal dueSum = (from lst in lstDueChart
                              where lst.Status == "Paid" && lst.FeeType != "ROM"
                              select lst.Amount).Sum();


            decimal roomSum = (from lst in lstBedBooking
                               where lst.Status == "Paid"
                               select lst.Amount).Sum();

            //ScriptManager.RegisterStartupScript(this, this.GetType(), "chumma", "alert('" + (roomSum+dueSum).ToString() + "');", true);
            hdnUnBilledAdvanceReceived.Value = (roomSum + dueSum).ToString();

            lstDueChart = (from lst in lstDueChart
                           where /*lst.FromTable != "BDT" && */ lst.Status != "Paid" && lst.Status != "Saved"
                           select lst).ToList();

            lstBedBooking = (from lst in lstBedBooking
                             where /*lst.FromTable != "BDT" && */ lst.Status != "Paid" && lst.Status != "Saved"
                             select lst).ToList();


        }
        //txtThirdParty.Text = String.Format("{0:0.00}", dPayerTotal.ToString());
        if (lstFinalBill.Count > 0)
        {
            hdnPrevServiceCharge.Value = String.Format("{0:0.00}", lstFinalBill[0].ServiceCharge);
            txtPrevServiceCharge.Text = hdnPrevServiceCharge.Value.ToString();
            txtDiscount.Text = lstFinalBill[0].DiscountAmount.ToString();
            if (lstFinalBill[0].DiscountReason != null)
            {
                txtDiscountReason.Text = lstFinalBill[0].DiscountReason.Trim();
            }
            if (lstFinalBill[0].DiscountAmount > 0)
            {
                txtDiscountReason.Style.Remove("display");
                txtDiscountReason.Style.Add("display", "block");
            }
            hdnDiscountDetails.Value = lstFinalBill[0].DiscountAmount.ToString() + "~" + (lstFinalBill[0].DiscountReason == null ? string.Empty : lstFinalBill[0].DiscountReason.Trim());
        }
        if ((pTotSurgeryAmt - pTotSurgeryAdv) > 0 && configValue == "Y")
        {
            Response.Redirect("~/InPatient/SurgeryAdvance.aspx?PID=" + patientID + "&VID=" + visitID + "&PNAME=" + patientName + "&vType=IP&msg=yes");
            // Respo
        }
        else
        {
            if (lstDueChart.Count > 0)
            {
                List<PatientDueChart> lstIndents = (from listInd in lstDueChart
                                                    where listInd.FeeType != "PRM" && listInd.FeeType != "ROM"
                                                    select listInd).OrderBy(p => p.FeeType).ThenBy(g => g.FromDate).ToList();

                gvIndents.DataSource = lstIndents;
                gvIndents.DataBind();
                if (lstIndents.Count > 0)
                {
                    dvTreatmentCharges.Visible = true;
                    gvIndents.Visible = true;
                }
                else
                {
                    dvTreatmentCharges.Visible = false;
                }

                List<PatientDueChart> lstPharmacy = (from listInd in lstDueChart
                                                     where listInd.FeeType == "PRM"
                                                     select listInd).OrderBy(p=>p.FromDate).ToList();

                gvMedicalItems.DataSource = lstPharmacy;
                gvMedicalItems.DataBind();
                if (lstPharmacy.Count > 0)
                {
                    dvpharmacy.Visible = true;
                    gvMedicalItems.Visible = true;
                }
                else
                {
                    dvpharmacy.Visible = false;
                }
                gridAttributesAdd(gvMedicalItems);
                gridAttributesAdd(gvIndents);
            }
            else
            {
                dvTreatmentCharges.Visible = false;
                gvIndents.Visible = false;
                gvMedicalItems.Visible = false;
                dvpharmacy.Visible = false;
            }
            if (lstBedBooking.Count > 0)
            {
                var list = (from list1 in lstBedBooking
                            select list1.RoomTypeName).Distinct();

                foreach (var obj in list)
                {
                    PatientDueChart pdc = new PatientDueChart();
                    pdc.RoomTypeName = obj;
                    lstBedBookingRoomType.Add(pdc);
                }
                if (lstBedBookingRoomType.Count > 0)
                {
                    trRoomCharges.Style.Add("Display", "block");
                }
                hdnfrm.Value = lstPatientDetail[0].RegistrationDTTM.ToString();
                gvIndentRoomType.DataSource = lstBedBookingRoomType;
                gvIndentRoomType.DataBind();
                gvIndentRoomType.Visible = true;
            }
            else
            {
                trRoomCharges.Style.Add("Display", "none");
                gvIndentRoomType.Visible = false;
            }
            //txtRecievedAdvance.Text = (dAdvanceAmount + pTotSurgeryAdv).ToString();
            if (chkShowUnbilled.Checked && hdnIsBilledBefore.Value=="Y")
            {
                txtPreviousAmountPaid.Text = "0";
                hdnUnBilledPreviousReceived.Value = dTotalAmount.ToString();
                txtPrevServiceCharge.Text = "0";
                hdnPrevServiceCharge.Value = "0";
                txtDiscount.Text = "0";
                txtRecievedAdvance.Text = "0.00";
                txtThirdParty.Text = "0.00";
                txtDiscount.Text = "0.00";
                txtDiscountReason.Text = "";
                //txtRecievedAdvance.Text = hdnUnBilledAdvanceReceived.Value;
                //hdnUnBilledAdvanceReceived.Value = (dAdvanceAmount + pTotSurgeryAdv - dPreviousRefund).ToString();
            }
            else
            {
                txtThirdParty.Text = String.Format("{0:0.00}", dPayerTotal.ToString());
                hdnUnBilledPreviousReceived.Value = "0";
                txtPreviousAmountPaid.Text = dTotalAmount.ToString();
                txtRecievedAdvance.Text = (dAdvanceAmount + pTotSurgeryAdv).ToString();
            }

            List<FinalBill> lstDueDetail = new List<FinalBill>();
            BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
            string visittype = "";
            long finalBillID = -1;
            billingEngineBL.GetDueDetails(OrgID, patientID, visitID, out finalBillID, out lstDueDetail, out visittype);
            double dueAmount = 0;
            //for (int i = 0; i < lstDueDetail.Count; i++)
            //{
            int iCount = lstDueDetail.Count == 0 ? 1 : lstDueDetail.Count;
            if (lstDueDetail.Count > 0)
            {
                Double.TryParse(lstDueDetail[iCount-1].CurrentDue.ToString(), out dueAmount);
            }
            txtPreviousDue.Text = dueAmount.ToString();
            txtPreviousRefund.Text = dPreviousRefund.ToString();

            //txtGrandTotal.Text = Convert.ToString(Convert.ToDecimal(txtGross.Text) - dAdvanceAmount);
            //txtGrandTotal.Text = Convert.ToString(Convert.ToDecimal(txtGross.Text)+Convert.ToDecimal(hdnPrevServiceCharge.Value) - (Convert.ToDecimal(txtPreviousAmountPaid.Text) +
            //                        Convert.ToDecimal(txtRecievedAdvance.Text)) + Convert.ToDecimal(txtPreviousDue.Text));
            if (Convert.ToDecimal(txtGrandTotal.Text) < 0)
            {
                txtRefundAmount.Text = txtGrandTotal.Text.Replace("-", "");
                txtGrandTotal.Text = "0";
                if (dPreviousRefund <= (Convert.ToDecimal(txtRefundAmount.Text) + dPreviousRefund))
                {
                    txtRefundAmount.Text = Convert.ToString(Convert.ToDecimal(txtRefundAmount.Text) - dPreviousRefund);
                }
                else
                {
                    txtRefundAmount.Text = "0";
                }
            }
            //else
            //{
            //    txtRefundAmount.Text = "0";
            //}
            txtRefundAmount.Text = txtRefundAmount.Text == "" ? "0" : txtRefundAmount.Text;
            if (Convert.ToDecimal(txtRefundAmount.Text) < 0)
            {
                txtGrandTotal.Text = txtRefundAmount.Text.Replace("-", "");
                txtRefundAmount.Text = "0";
            }

            hdnGross.Value = txtGross.Text;
            if (lstPatientDetail.Count > 0)
            {

                //if (!chkShowUnbilled.Checked && flag)
                //{
                //    hdnUnBilledAdvanceReceived.Value = hdnGross.Value;
                //    flag = !flag;
                //}

                if (lstPatientDetail[0].TPAID > 0)
                {
                    tpaDetails.Visible = true;
                    txtThirdParty.Style.Add("display", "true");
                }
            }
            List<Config> lstConfig = new List<Config>();
            GateWay gateWay = new GateWay(base.ContextInfo);
            long returnCode = gateWay.GetConfigDetails("EditableUser", OrgID, out lstConfig);
            sEditableUser = "0";
            if (lstConfig.Count > 0)
            {
                for (int i = 0; i < lstConfig.Count; i++)
                {
                    if (RoleID == Convert.ToInt64(lstConfig[i].ConfigValue.Trim()))
                        sEditableUser = lstConfig[0].ConfigValue.ToString().Trim();
                }
            }
            long lEditRoleID = 0;
            Int64.TryParse(sEditableUser, out lEditRoleID);
            chkDischarge.Style.Add("display", "block");
            btnSave.Visible = true;
            btnSaveTemp.Visible = true;

            #region comment
            //if (IsCreditBill == "Y")
            //{
            //    chkisCreditTransaction.Enabled = false;
            //doCalculation();

            //txtNonMedical.Text = hdnNonMedical.Value = hdnNonMedical.Value.Trim().Equals(string.Empty) ? 0.ToString("0.00") : hdnNonMedical.Value;

            ////decimal TpaNetBill = Convert.ToDecimal(txtGrandTotal.Text) - Convert.ToDecimal(hdnNonMedical.Value) - Convert.ToDecimal(txtPreviousDue.Text);

            //decimal TpaNetBill = Convert.ToDecimal(txtGross.Text) - Convert.ToDecimal(hdnNonMedical.Value);
            //                        //dTotalAmount -
            //                        //Convert.ToDecimal(txtThirdParty.Text)-
            //                        // - 
            //                        //Convert.ToDecimal(txtPreviousDue.Text);

            //decimal tmpDue = Convert.ToDecimal(hdnNonMedical.Value) + Convert.ToDecimal(txtPreviousDue.Text);
            //decimal tmpAdv = Convert.ToDecimal(txtPreviousAmountPaid.Text) + Convert.ToDecimal(txtRecievedAdvance.Text) - Convert.ToDecimal(txtRefundAmount.Text);

            //txtCoPayment.Text = getCoPayment(pPreAuthAmount).ToString("0.00");

            //if (TpaNetBill > pPreAuthAmount)
            //{
            //    if (tmpDue > tmpAdv)
            //    {
            //        txtDue.Text = (tmpDue - tmpAdv).ToString("0.00");
            //        txtExcess.Text = 0.ToString("0.00");
            //    }
            //    else
            //    {
            //        txtCoPayment.Text = (tmpAdv - tmpDue).ToString("0.00");
            //        tmpAdv = tmpAdv - tmpDue;
            //        if ((TpaNetBill - pPreAuthAmount) < tmpAdv)
            //        {
            //            //txtCoPayment.Text = (tmpAdv - (TpaNetBill - pPreAuthAmount)).ToString("0.00");
            //            txtCoPayment.Text = ((tmpAdv - (TpaNetBill - pPreAuthAmount)) > getCoPayment(pPreAuthAmount) ? getCoPayment(pPreAuthAmount) : (tmpAdv - (TpaNetBill - pPreAuthAmount))).ToString("0.00");
            //            txtExcess.Text = ((tmpAdv - (TpaNetBill - pPreAuthAmount)) > getCoPayment(pPreAuthAmount) ? (tmpAdv - (TpaNetBill - pPreAuthAmount))-getCoPayment(pPreAuthAmount) : decimal.Zero).ToString("0.00");
            //        }
            //        else
            //        {
            //            txtDue.Text = ((TpaNetBill - pPreAuthAmount) - tmpAdv).ToString("0.00");
            //            txtCoPayment.Text = 0.ToString("0.00");
            //            txtExcess.Text = 0.ToString("0.00");
            //        }
            //    }
            //    txtTpaDue.Text = pPreAuthAmount > decimal.Zero && Convert.ToDecimal(txtThirdParty.Text) < pPreAuthAmount ? (pPreAuthAmount - Convert.ToDecimal(txtThirdParty.Text)).ToString("0.00") : Convert.ToDecimal(txtThirdParty.Text).Equals(decimal.Zero) ? pPreAuthAmount.ToString("0.00") : decimal.Zero.ToString("0.00");
            //}
            //else
            //{
            //    txtTpaDue.Text = Convert.ToDecimal(txtThirdParty.Text) < TpaNetBill && Convert.ToDecimal(txtThirdParty.Text) > decimal.Zero ? (TpaNetBill - Convert.ToDecimal(txtThirdParty.Text)).ToString("0.00") : TpaNetBill.ToString("0.00");

            //    if (tmpDue > tmpAdv)
            //    {
            //        txtDue.Text = (tmpDue - tmpAdv).ToString("0.00");
            //    }
            //    else
            //    {
            //        txtCoPayment.Text = (tmpAdv - tmpDue).ToString("0.00");
            //    }
            //}

            //trPaidAmt.Visible = Convert.ToDecimal(lblPaidAmt.Text).Equals(decimal.Zero) ? false : true;
            //trCoPay.Visible = Convert.ToDecimal(lblCoPayment.Text).Equals(decimal.Zero) ? false : true;
            //trTPADue.Visible = Convert.ToDecimal(lblTPADue.Text).Equals(decimal.Zero) ? false : true;

            //}
            //else
            //{
            //    chkisCreditTransaction.Enabled = true;
            //}
            #endregion

        }
        #region  try
        //protected decimal getCoPayment(decimal PreAuthAmount)
        //{
        //    int CoPayPercent = 100;
        //    return PreAuthAmount.Equals(decimal.Zero) ? decimal.Zero : (PreAuthAmount * CoPayPercent) / 100;
        //}

        //protected void doCalculation()
        //{
        //    txtNonMedical.Text = hdnNonMedical.Value = hdnNonMedical.Value == "" ? 0.ToString("0.00") : hdnNonMedical.Value;

        //   // decimal TpaNetBill = Convert.ToDecimal(txtGrandTotal.Text) + Convert.ToDecimal(txtThirdParty.Text) + Convert.ToDecimal(txtPreviousAmountPaid.Text) + Convert.ToDecimal(txtRecievedAdvance.Text) - Convert.ToDecimal(txtDiscount.Text) - Convert.ToDecimal(txtPreviousDue.Text) - Convert.ToDecimal(hdnNonMedical.Value);

        //    decimal TpaNetBill = Convert.ToDecimal(txtGross.Text) - Convert.ToDecimal(hdnNonMedical.Value);
        //    decimal TpaAmtPaid = Convert.ToDecimal(txtThirdParty.Text);
        //    decimal TpaDue = 0;
        //    decimal TpaPatDue = 0;

        //    decimal PatDue = Convert.ToDecimal(hdnNonMedical.Value) + Convert.ToDecimal(txtPreviousDue.Text);
        //    decimal NRIDue = Convert.ToDecimal(hdnNonMedical.Value);
        //    decimal totAdv = Convert.ToDecimal(txtPreviousAmountPaid.Text) + Convert.ToDecimal(txtRecievedAdvance.Text) - Convert.ToDecimal(txtPreviousRefund.Text);

        //    if (TpaNetBill > pPreAuthAmount)
        //    {
        //        if (pPreAuthAmount == 0)
        //        {
        //            TpaPatDue = TpaNetBill;
        //            TpaDue = 0;
        //        }
        //        else
        //        {
        //            TpaDue = pPreAuthAmount > 0 && TpaAmtPaid < pPreAuthAmount ? pPreAuthAmount - TpaAmtPaid : TpaAmtPaid == 0 ? pPreAuthAmount : 0;
        //            TpaPatDue = Convert.ToDecimal(TpaNetBill - pPreAuthAmount);
        //        }
        //    }
        //    else
        //    {
        //        TpaDue = TpaAmtPaid < TpaNetBill && TpaAmtPaid > 0 ? TpaNetBill - TpaAmtPaid : TpaNetBill;
        //    }

        //    decimal totDue = PatDue + TpaPatDue;
        //    decimal Excess;
        //    decimal CoPay;

        //    if (totDue > totAdv)
        //    {
        //        totDue = totDue - totAdv;
        //        Excess = 0;
        //        CoPay = 0;
        //    }
        //    else
        //    {
        //        totAdv = totAdv - totDue;
        //        totDue = 0;
        //        CoPay = totAdv;
        //        Excess = 0;
        //    }

        //    txtDue.Text = Convert.ToDecimal(totDue).ToString("0.00");
        //    txtTpaDue.Text= Convert.ToDecimal(TpaDue).ToString("0.00");
        //    txtCoPayment.Text = Convert.ToDecimal(CoPay).ToString("0.00");
        //    txtExcess.Text = Convert.ToDecimal(Excess).ToString("0.00");

        //}

        #endregion
    }

    protected void gvIndentRoomType_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in changing date ", ex);
        }
    }

    protected void lnkBack_Click(object sender, EventArgs e)
    {

        try
        {//==============================
            if (EditIPBill == "Edit")
            {
                Response.Redirect("~/Billing/HospitalBillSearch.aspx", true);
            }
            else
            {
                Response.Redirect("IPBillSettlementHome.aspx", true);
            }
        }//================================
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Home Page", ex);
        }
    }

    public void LoadDiscount()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<DiscountMaster> getDiscount = new List<DiscountMaster>();
            retCode = patBL.GetLabDiscount(OrgID, out getDiscount);
            if (retCode == 0)
            {

                ddDiscountPercent.DataSource = getDiscount;
                ddDiscountPercent.DataTextField = "DiscountName";
                ddDiscountPercent.DataValueField = "Discount";
                ddDiscountPercent.DataBind();
                ddDiscountPercent.Items.Insert(0, "--Select--");
                ddDiscountPercent.Items[0].Value = "select";
                if (getDiscount.Count > 0)
                {
                    ddDiscountPercent.Style.Add("display", "block");
                    tdDiscountLabel.Style.Add("display", "block");
                }
                else
                {
                    ddDiscountPercent.Style.Add("display", "none");
                    tdDiscountLabel.Style.Add("display", "none");
                }
            }
            else
            {
                ddDiscountPercent.DataSource = null;
                ddDiscountPercent.DataBind();
                ddDiscountPercent.Items.Insert(0, "--Select--");
                ddDiscountPercent.Items[0].Value = "select";
                ddDiscountPercent.Style.Add("display", "none");
                tdDiscountLabel.Style.Add("display", "none");
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Lab Discount Details.", ex);
        }
    }
    }

