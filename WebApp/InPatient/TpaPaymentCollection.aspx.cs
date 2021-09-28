using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using System.Collections;

public partial class InPatient_TpaPaymentCollection : BasePage
{
    decimal billAmount;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadpaymentDetails();
        }
    }
    protected void lnkhome_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            //Response.Redirect("../Reception/Home.aspx", true);
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath  + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    protected void bGo_Click(object sender, EventArgs e)
    {
        try
        {
            long finalBillID = -1;
            long VisitID = -1;
            long PatientID = -1;
            int TypeID = -1;
            decimal amount = 0, TDS = 0, RightOff = 0, TPADiscount = 0,TPAPreviousDiscAmt = 0;
            long returncode = -1;
            string Status = string.Empty;
            DateTime dt = System.DateTime.MinValue;
            List<PatientDueChart> pDueChrt = new List<PatientDueChart>();
            foreach (GridViewRow GR in grdTPA.Rows)
            {
                CheckBox cbox = (CheckBox)GR.FindControl("chkBox");
                if (cbox.Checked)
                {
                    PatientDueChart PDChart = new PatientDueChart();
                    PatientID = Convert.ToInt64(grdTPA.DataKeys[GR.RowIndex][0].ToString());
                    VisitID = Convert.ToInt64(grdTPA.DataKeys[GR.RowIndex][1].ToString());
                    finalBillID = Convert.ToInt64(grdTPA.DataKeys[GR.RowIndex][2].ToString());
                    TextBox txtAmt = (TextBox)GR.FindControl("txtTPAAmount");

                    TextBox txtDiscountAmt = (TextBox)GR.FindControl("txtDiscountAmt");
                    TextBox txtRemaks = (TextBox)GR.FindControl("txtRemaks");
                    Label lblSettledAmt = (Label)GR.FindControl("lblSettledAmt");
                    Label lblDisallowedAmt = (Label)GR.FindControl("lblDisallowedAmt");
                    TextBox txtApprovedBy = (TextBox)GR.FindControl("txtApprovedBy");
                    TextBox txtApprovedDate = (TextBox)GR.FindControl("txtApprovedDate");

                    HiddenField hdnSettledAmt = new HiddenField();
                    HiddenField hdnDisallowedAmt = new HiddenField();
                    hdnSettledAmt = (HiddenField)GR.FindControl("hdnSettledAmt");
                    hdnDisallowedAmt = (HiddenField)GR.FindControl("hdnDisallowedAmt");
                    Label lblPreviousDisc = (Label)GR.FindControl("lblPreviousDisc");

                    hdnSettledAmt.Value = hdnSettledAmt.Value;
                    hdnDisallowedAmt.Value = hdnDisallowedAmt.Value;

                    if (lblPreviousDisc.Text != string.Empty)
                    {
                        TPAPreviousDiscAmt = Convert.ToDecimal(lblPreviousDisc.Text);
                    }

                    if (txtAmt.Text != string.Empty)
                    {
                        amount = Convert.ToDecimal(txtAmt.Text);
                    }
                    TextBox txttds = (TextBox)GR.FindControl("txtTDS");
                    if (txttds.Text != string.Empty)
                    {
                        TDS = Convert.ToDecimal(txttds.Text);
                       
                    }
                    if (txtDiscountAmt.Text != string.Empty)
                    {
                        TPADiscount = Convert.ToDecimal(txtDiscountAmt.Text);
                    }
                    Label lblBillAmt = (Label)GR.FindControl("lblBillAmt");
                    Label lblTDSPaid = (Label)GR.FindControl("lblTDSPaid");
                    CheckBox chkBoxWO = (CheckBox)GR.FindControl("chkBoxWO");
                    Label lblTPAAmount = (Label)GR.FindControl("lblTPAAmount");
                    RightOff = 0;
                  
                    TypeID = Convert.ToInt32(((DropDownList)GR.FindControl("ddlCashType")).SelectedItem.Value);
                    string  ChequeNo =string.Empty;
                    string Bankname = ((TextBox)GR.FindControl("txtBankName")).Text;
                    TextBox txtChequeNo = (TextBox)GR.FindControl("txtChqNo");
                    if (txtChequeNo.Text != string.Empty)
                    {
                        ChequeNo =  txtChequeNo.Text;
                    }
                    Label lbl = ((Label)GR.FindControl("lblBillAmt"));
                    if (lbl.Text != string.Empty)
                    {
                        billAmount = Convert.ToDecimal(lbl.Text);
                        RightOff = (Convert.ToDecimal(lblBillAmt.Text) - (Convert.ToDecimal(lblTPAAmount.Text) + Convert.ToDecimal(lblTDSPaid.Text) + Convert.ToDecimal(txtAmt.Text) + TDS) - TPADiscount - TPAPreviousDiscAmt);                    
                    }
                    Status = ((DropDownList)GR.FindControl("ddlStatus")).SelectedItem.Value;

                    if (chkBoxWO.Checked && Status == "Completed")
                    {
                        Status = "Completed";
                    }
                    if (Status == "Completed" || chkBoxWO.Checked)
                    {
                        RightOff = (Convert.ToDecimal(lblBillAmt.Text) - (Convert.ToDecimal(lblTPAAmount.Text) + Convert.ToDecimal(lblTDSPaid.Text) + Convert.ToDecimal(txtAmt.Text) + TDS) - TPADiscount - TPAPreviousDiscAmt);
                        Status = "Completed";
                    }
                    else
                    {
                        RightOff = 0;
                    }
                    PDChart.FromDate = Convert.ToDateTime("01/01/1753");
                    if (Status == "Completed")
                    {
                        TextBox txtFrom = (TextBox)GR.FindControl("txtFrom");//TPASettlement Date
                        PDChart.FromDate = Convert.ToDateTime(txtFrom.Text);
                    }



                    TextBox txtFromCF = (TextBox)GR.FindControl("txtFromCF");//Claim Forwared Date
                    if(txtFromCF.Text!="")
                    {
                        PDChart.ToDate=Convert.ToDateTime(txtFromCF.Text);
                    }

                    PDChart.DetailsID = finalBillID;
                    PDChart.PatientID = PatientID;
                    PDChart.Amount = amount;
                    PDChart.TDS = TDS;
                    PDChart.RightOff = RightOff;
                    PDChart.CreatedBy = Convert.ToInt32(LID);
                    PDChart.TypeID = TypeID;
                    PDChart.Description = "TPA";
                    PDChart.VisitID = VisitID;
                    PDChart.BankNameorCardType = Bankname;
                    PDChart.ChequeorCardNumber = ChequeNo;
                    PDChart.Status = Status;
                    
                    PDChart.TPADiscountAmt = Convert.ToDecimal(txtDiscountAmt.Text == "" ? "0.00" : txtDiscountAmt.Text);
                    PDChart.TPASettledAmt = Convert.ToDecimal(hdnSettledAmt.Value == "" ? "0.00" : hdnSettledAmt.Value);
                    if (chkBoxWO.Checked && Status == "Completed")
                    {
                        PDChart.TPADisallowedAmt = 0;
                    }
                    else
                    {
                        PDChart.TPADisallowedAmt = Convert.ToDecimal(hdnDisallowedAmt.Value == "" ? "0.00" : hdnDisallowedAmt.Value);
                    }
                    PDChart.TPARemarks = txtRemaks.Text;
                    PDChart.TPAApproverName = txtApprovedBy.Text;
                    
                    PDChart.TPAApprovedDate = Convert.ToDateTime(txtApprovedDate.Text == "" ? "01/01/1753" : txtApprovedDate.Text);
                    if (chkBoxWO.Checked == true)
                        PDChart.TPAWriteOffApprover = LID;
                    else
                        PDChart.TPAWriteOffApprover = 0;
                    
                    pDueChrt.Add(PDChart);
                   

                }
            }
            if (pDueChrt.Count > 0)
            {
                returncode = new IP_BL(base.ContextInfo).InsertTPAPayment(pDueChrt, OrgID);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "dueChart", "javascript:alert('Check atleast one item and then click Save');", true);
            }
            if (returncode != -1)
            {
                long returnCode = -1;
                Response.Redirect("../Inpatient/TPAPayment.aspx", true);
                //List<Role> lstUserRole = new List<Role>();
                //string path = string.Empty;
                //Role role = new Role();
                //role.RoleID = RoleID;
                //lstUserRole.Add(role);
                //returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
                //Response.Redirect(Request.ApplicationPath  + path, true);
            }

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in save TpaPaymentCollection page", ex);
        }
    }
    protected void grdTPACollection_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Patient p = (Patient)e.Row.DataItem;          

                TextBox txtTPAAmount = (TextBox)e.Row.FindControl("txtTPAAmount");
                TextBox txtChqNo = (TextBox)e.Row.FindControl("txtChqNo");
                TextBox txtBankName = (TextBox)e.Row.FindControl("txtBankName");
                TextBox txtFrom = (TextBox)e.Row.FindControl("txtFrom");
                TextBox txtFromCF = (TextBox)e.Row.FindControl("txtFromCF");
                TextBox txtTDS = (TextBox)e.Row.FindControl("txtTDS");
                TextBox txtRemaks = (TextBox)e.Row.FindControl("txtRemaks");
                Label lblBillAmt = (Label)e.Row.FindControl("lblBillAmt");
                Label lblTPAAmount = (Label)e.Row.FindControl("lblTPAAmount");
                Label lblTDSPaid = (Label)e.Row.FindControl("lblTDSPaid");

                CheckBox chkBox = (CheckBox)e.Row.FindControl("chkBox");
                CheckBox chkBoxWO = (CheckBox)e.Row.FindControl("chkBoxWO");

                DropDownList ddlStatus = (DropDownList)e.Row.FindControl("ddlStatus");
                DropDownList ddlCashType = (DropDownList)e.Row.FindControl("ddlCashType");

                LinkButton lnkEdit = (LinkButton)e.Row.FindControl("lnkEdit");

                TextBox txtDiscountAmt = (TextBox)e.Row.FindControl("txtDiscountAmt");
                Label lblSettledAmt = (Label)e.Row.FindControl("lblSettledAmt");
                Label lblDisallowedAmt = (Label)e.Row.FindControl("lblDisallowedAmt");
                TextBox txtApprovedDate = (TextBox)e.Row.FindControl("txtApprovedDate");
                TextBox txtApprovedBy = (TextBox)e.Row.FindControl("txtApprovedBy");
                Label lblPreviousDisc = (Label)e.Row.FindControl("lblPreviousDisc");
                Label lblAdmissionDate = (Label)e.Row.FindControl("lblAdmissionDate");
                Label lblDischargeDate = (Label)e.Row.FindControl("lblDischargeDate");
                
                    
                HiddenField hdnSettledAmt = new HiddenField();
                HiddenField hdnDisallowedAmt = new HiddenField();

                hdnSettledAmt = (HiddenField)e.Row.FindControl("hdnSettledAmt");
                hdnDisallowedAmt = (HiddenField)e.Row.FindControl("hdnDisallowedAmt");

                hdnSettledAmt.Value = hdnSettledAmt.Value;
                hdnDisallowedAmt.Value = hdnDisallowedAmt.Value;

                HiddenField hdnAdmissionDate = new HiddenField();
                HiddenField hdnDischargeDate = new HiddenField();

                hdnAdmissionDate = (HiddenField)e.Row.FindControl("hdnAdmissionDate");
                hdnDischargeDate = (HiddenField)e.Row.FindControl("hdnDischargeDate");

                hdnAdmissionDate.Value = lblAdmissionDate.Text;
                hdnDischargeDate.Value = lblDischargeDate.Text;

                HiddenField hdnComments = new HiddenField();
                hdnComments = (HiddenField)e.Row.FindControl("hdnComments");
                //hdnComments.Value = p.Comments;

                string SettleCompareDate = "CompareDate('" + txtFrom.ClientID + "' , '" + hdnAdmissionDate.ClientID + "' ,'" + hdnDischargeDate.ClientID + "','" + txtRemaks.ClientID + "' );";
                string ApproveCompareDate = "CompareDate('" + txtApprovedDate.ClientID + "' , '" + hdnAdmissionDate.ClientID + "' ,'" + hdnDischargeDate.ClientID + "','" + txtRemaks.ClientID + "' );";

                txtFrom.Attributes.Add("onchange", SettleCompareDate);
                txtApprovedDate.Attributes.Add("onchange", ApproveCompareDate);

                string chkStatus = "chkStatus('" + lblDisallowedAmt.ClientID + "','" + ddlStatus.ClientID + "','" + chkBoxWO.ClientID + "');";
                ddlStatus.Attributes.Add("onchange", chkStatus);

                //string sComments = "PreviousPayments('"+ hdnComments.ClientID + "');";
                //string paymentClear = "PreviousPaymentsClear('" + hdnComments.ClientID + "');";
                //e.Row.Attributes.Add("onmouseover", sComments);
                //e.Row.Attributes.Add("onmouseout",paymentClear);

                //LinkButton lbtnFromDate = (LinkButton)e.Row.FindControl("lbtnFromDate");
                //lbtnFromDate.Attributes.Add("onclick", "NewCal('" + txtFromDate.ClientID + "','ddmmyyyy',true,12)");
                string sComments = "showModalPopup('" + hdnComments.ClientID + "');";
                e.Row.Cells[1].Attributes.Add("onclick", sComments);
                e.Row.Cells[1].ToolTip = "Show Previous Payments";

                
                //LinkButton lnkButton = (LinkButton)e.Row.FindControl("lnkButton");
                
                //lnkButton.Attributes.Add("onclientclick", sComments);

                string sFunProcedures = "CalcItemCost('" + lblBillAmt.ClientID +
                                                  "','" + lblTPAAmount.ClientID + "','" + lblTDSPaid.ClientID +
                                                  "','" + txtTPAAmount.ClientID +
                                                  "','" + txtTDS.ClientID + "','" + txtDiscountAmt.ClientID +
                                                  "','" + lblSettledAmt.ClientID + "','" + lblDisallowedAmt.ClientID +
                                                  "','" + hdnSettledAmt.ClientID + "','" + hdnDisallowedAmt.ClientID +
                                                  "','" + ddlStatus.ClientID + "','" + lblPreviousDisc.ClientID +
                                                  "','" + chkBoxWO.ClientID + "','" + txtApprovedBy.ClientID +
                                                  "','" + txtApprovedDate.ClientID + 
                                                  "');";

                txtTPAAmount.Attributes.Add("onchange", sFunProcedures);
                txtTPAAmount.Attributes.Add("onblur", sFunProcedures);
                txtTDS.Attributes.Add("onchange", sFunProcedures);
                txtTDS.Attributes.Add("onblur", sFunProcedures);
                txtDiscountAmt.Attributes.Add("onchange", sFunProcedures);
                txtDiscountAmt.Attributes.Add("onblur", sFunProcedures);


                string Expand = "javascript:expandTextBox('" + txtRemaks.ClientID + "');";
                string collapse = "javascript:collapseTextBox('" + txtRemaks.ClientID + "');";

                txtRemaks.Attributes.Add("onfocus", Expand);
                txtRemaks.Attributes.Add("onblur", collapse);


                string writeoff = "ClickWriteOff('" + chkBoxWO.ClientID + "','" + ddlStatus.ClientID + "','" + txtApprovedBy.ClientID + "','" + txtApprovedDate.ClientID + "' );";
                chkBoxWO.Attributes.Add("OnClick", writeoff);
                if (p.TPASettlementDate.ToString() == "01/01/0001 00:00:00")
                {
                    txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                }
                else
                {
                    txtFrom.Text = p.TPASettlementDate.ToString();
                }


                if (p.CliamForwardDate.ToString() == "01/01/0001 00:00:00")
                {
                    //txtFromCF.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                    txtFromCF.Text = "";
                }
                else
                {
                    txtFromCF.Text = p.CliamForwardDate.ToString();
                }
                //if (p.TDS > 0)
                //{
                //    lblTDSPaid.Visible = true;
                //}
                //else
                //{
                //    lblTDSPaid.Visible = false;
                //}
                if (Convert.ToDecimal(lblBillAmt.Text) > Convert.ToDecimal(lblTPAAmount.Text) && p.Status == "Completed")
                {
                    Label lblWriteOff = (Label)e.Row.FindControl("lblWriteOff");
                    lblWriteOff.Visible = true;
                    chkBoxWO.Checked = true;
                    hdnChkValues.Value += lblBillAmt.ClientID + "~" + lblTPAAmount.ClientID + "~" + txtTPAAmount.ClientID + "~" + txtChqNo.ClientID + "~" + txtBankName.ClientID + "~" + chkBox.ClientID + "~" + lblTDSPaid.ClientID + "~" + lblWriteOff.ClientID +"~"+txtTDS.ClientID+ "^";
                    txtTPAAmount.Enabled = false;
                    txtChqNo.Enabled = false;
                    txtBankName.Enabled = false;
                    txtFrom.Enabled = false;
                    txtFromCF.Enabled = false;
                    txtTDS.Enabled = false;
                    txtRemaks.Enabled = false;
                    txtDiscountAmt.Enabled = false;
                    ddlStatus.Enabled = false;
                    ddlCashType.Enabled = false;
                    txtApprovedDate.Enabled = false;
                    txtApprovedBy.Enabled = false;
                    chkBoxWO.Enabled = false;

                }
                else
                {
                    hdnChkValues.Value += lblBillAmt.ClientID + "~" + lblTPAAmount.ClientID + "~" + txtTPAAmount.ClientID + "~" + txtChqNo.ClientID + "~" + txtBankName.ClientID + "~" + chkBox.ClientID + "~" + lblTDSPaid.ClientID + "~" + "0" + "~" + txtTDS.ClientID + "^";
                }

                if (RoleName == RoleHelper.Admin)
                {
                    //grdTPA.Columns[12].Visible = true;
                    lnkEdit.Visible = true;
                   
                }
                else
                {
                    //grdTPA.Columns[12].Visible = false;
                    lnkEdit.Visible = false;
                }

                if (p.Status == "Completed")
                {
                    
                    ddlStatus.SelectedValue = "Completed";
                   
                  
                }

               

              
                  
               

               
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdResult_RowDataBound", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            string path = "/InPatient/TPAPayment.aspx";
            Response.Redirect(Request.ApplicationPath  + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    

    protected void grdTPACollection_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        long returnCode = -1;
        long visitID = -1;
        long patientID = -1;
        int rowIndex = -1;
        List<TPAPayments> lpaymentDetais = new List<TPAPayments>();
       
        if (e.CommandName == "OEdit")
        {
            rowIndex = Convert.ToInt32(e.CommandArgument);
            visitID = Convert.ToInt64(grdTPA.DataKeys[rowIndex][1]);
            patientID = Convert.ToInt64(grdTPA.DataKeys[rowIndex][0]);
            if (visitID != 0)
            {
                returnCode = new IP_BL(base.ContextInfo).GetPTPAPaymentDetails(visitID, patientID, OrgID, out lpaymentDetais);
            }
            if (lpaymentDetais.Count > 0)
            {

                //txtTDS.Text = "";
                //txtWriteOff.Text = "";
              
                gvTPAItems.DataSource = lpaymentDetais;
                gvTPAItems.DataBind();

                if (lpaymentDetais[0].TPAPaymentStatus == "Completed")
                {
                    ddlStatusC.SelectedValue = "Completed";
                    txtSettlementDate.Text = lpaymentDetais[0].TPASettlementDate.ToString();
                }
                else
                {
                    txtSettlementDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                }

                if (lpaymentDetais[0].CliamForwardDate != DateTime.MinValue)
                {

                    txtClaimFD.Text = lpaymentDetais[0].CliamForwardDate.ToString();
                }
                else
                {
                    txtClaimFD.Text = "";
                }

               
                ModelPopPaymentDetail.Show();
            }
        }
    }
   
   
    void LoadpaymentDetails()
    {
        List<Patient> lPat = new List<Patient>();
        List<Patient> lPatient = new List<Patient>();
        string sID=string.Empty;
        if ((PreviousPage != null) && (PreviousPage.IsCrossPagePostBack))
        {
            sID = ((HiddenField)PreviousPage.FindControl("hdnField")).Value;
            hdnVisitID.Value = sID;
        }
        else if (hdnVisitID.Value != string.Empty)
        {
            sID = hdnVisitID.Value;
        }
        
        foreach (string O in sID.Split('^'))
        {
            if (O != string.Empty)
            {
                Patient pt = new Patient();
                pt.PatientID = Convert.ToInt64(O.Split('~')[0]);
                pt.PatientVisitID = Convert.ToInt64(O.Split('~')[1]);
                pt.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                lPat.Add(pt);
            }
        }
        new IP_BL(base.ContextInfo).GetTPAPayment(lPat, OrgID, out lPatient);
        if (lPatient.Count > 0)
        {
            grdTPA.DataSource = lPatient;
            grdTPA.DataBind();
        }
    }
    protected void lnkHome_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            //Response.Redirect("../Reception/Home.aspx", true);
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath  + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void gvTPAItems_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        #region Commented by sami
        //if (e.CommandName == "OUpdate")
        //{
        //    List<TPAPayments> lpaymentDetais = new List<TPAPayments>();

        //    TPAPayments objpaymentDetais = new TPAPayments();
        //    PatientDueChart PDChart = new PatientDueChart();
        //    long TpaPaymentID = 0;
        //    long VisitID = 0;
        //    long returnCode = -1;
        //    decimal tempTotal = 0;
        //    decimal Total = 0;
        //    decimal DueDetails = 0;
        //    decimal WriteOff = 0;
        //    int RowIndex = Convert.ToInt32(e.CommandArgument);
        //    TpaPaymentID = Convert.ToInt64(gvTPAItems.DataKeys[RowIndex][0]);            
        //    VisitID = Convert.ToInt64(gvTPAItems.DataKeys[RowIndex][1]);
        //    DueDetails = Convert.ToInt64(gvTPAItems.DataKeys[RowIndex][2]);
        //    TextBox txtTPAAmount = (TextBox)gvTPAItems.Rows[RowIndex].FindControl("txtTPAAmount");
        //    TextBox txtTDS = (TextBox)gvTPAItems.Rows[RowIndex].FindControl("txtTDS");

        //    objpaymentDetais.Amount = Convert.ToDecimal(txtTPAAmount.Text);
        //    objpaymentDetais.TDS = Convert.ToDecimal(txtTDS.Text);
        //    objpaymentDetais.TPAPaymentID = TpaPaymentID;

        //    if (VisitID != 0)
        //    {
        //        returnCode = -1;
        //        returnCode = new IP_BL(base.ContextInfo).GetPTPAPaymentDetails(VisitID, 0, OrgID, out lpaymentDetais);

        //        if (lpaymentDetais.Count > 0)
        //        {

        //            var GrandTotal = from lstTPApaymentDetais in lpaymentDetais
        //                             where lstTPApaymentDetais.TPAPaymentID != TpaPaymentID
        //                             group lstTPApaymentDetais by lstTPApaymentDetais.VisitID into g
        //                             select new { CashFlowSummarySubTotal = g.Key, Amount = g.Sum(p => p.Amount) };

        //            foreach (var GrandTotalList in GrandTotal)
        //            {
        //                tempTotal = GrandTotalList.Amount;
        //            }
        //        }
        //    }
        //    Total = tempTotal + Convert.ToDecimal(txtTPAAmount.Text);

        //    if (Total > DueDetails)
        //    {
                //        ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('Amount Entered is greater than bill amount');", true);
        //        ModelPopPaymentDetail.Show();
        //    }
        //    else
        //    {


        //        returnCode = -1;
        //        returnCode = new IP_BL(base.ContextInfo).UpdatePaymentDetails(objpaymentDetais, OrgID, LID);
        //        if (returnCode > 0)
        //        {
        //            LoadpaymentDetails();
        //            lblStatus.Text = "Updated Sucessfully...!";
        //        }
        //    }

        //}
        #endregion
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        long finalBillID = -1, TPAPaymentID=-1;
        long VisitID = -1;      
        int TypeID = -1;
        decimal amount = 0, TDS = 0, WriteOff = 0;
        long returncode = -1;
        string Status = string.Empty;
        DateTime SettlementDate = DateTime.MinValue;
        DateTime ClaimForwaredDate = DateTime.MinValue;
        

        List<PatientDueChart> pDueChrt = new List<PatientDueChart>();
        foreach (GridViewRow GR in gvTPAItems.Rows)
        {

            PatientDueChart PDChart = new PatientDueChart();
            VisitID = Convert.ToInt64(gvTPAItems.DataKeys[GR.RowIndex]["VisitID"].ToString());
            TPAPaymentID = Convert.ToInt64(gvTPAItems.DataKeys[GR.RowIndex]["TPAPaymentID"].ToString());
            finalBillID = Convert.ToInt64(gvTPAItems.DataKeys[GR.RowIndex]["FinalBillID"].ToString());            
            billAmount = Convert.ToDecimal(gvTPAItems.DataKeys[GR.RowIndex]["DueDetails"].ToString());  
          

            TextBox txtTPAAmount = (TextBox)GR.FindControl("txtTPAAmount");
            TextBox txtTDS = (TextBox)GR.FindControl("txtTDS");
            TextBox txtChqNoC = (TextBox)GR.FindControl("txtChqNoC");
            TextBox txtBankNameC = (TextBox)GR.FindControl("txtBankNameC");
            DropDownList ddlCashTypeC = (DropDownList)GR.FindControl("ddlCashTypeC");
            

            if (txtTPAAmount.Text != string.Empty)
            {
                amount = Convert.ToDecimal(txtTPAAmount.Text);
            }

            if (txtTDS.Text != string.Empty)
            {
                TDS = Convert.ToDecimal(txtTDS.Text);
            }
            else
            {
                TDS = 0;
            }


            decimal ChequeNo = 0;
            Status = ddlStatusC.SelectedItem.Value;
            PDChart.DetailsID = TPAPaymentID;
            PDChart.PatientID = 0;
            PDChart.Amount = amount;
            PDChart.TDS = TDS;
            PDChart.RightOff = WriteOff;
            PDChart.CreatedBy = 0;
            PDChart.TypeID = Convert.ToInt32(ddlCashTypeC.SelectedValue);
            PDChart.Description = "TPA";
            PDChart.VisitID = VisitID;
            PDChart.BankNameorCardType = txtBankNameC.Text;
            PDChart.ChequeorCardNumber =(txtChqNoC.Text);
            PDChart.Status = Status;
            pDueChrt.Add(PDChart);
        }
        if (pDueChrt.Count > 0)
        {
            decimal d;
            d = pDueChrt.Sum(P => P.Amount);
            if (d <= billAmount)
            {
                if (Status == "Completed")
                {
                    WriteOff = billAmount - d;
                    SettlementDate = Convert.ToDateTime(txtSettlementDate.Text);
                }
                else
                {
                    SettlementDate = Convert.ToDateTime("1/1/1753");
                }
                if (txtClaimFD.Text != "")
                {
                    ClaimForwaredDate = Convert.ToDateTime(txtClaimFD.Text);
                }
                else
                {
                    ClaimForwaredDate = Convert.ToDateTime("1/1/1753");
                }
                returncode = new IP_BL(base.ContextInfo).UpdateTPAPaymentDetails(pDueChrt, OrgID, Status, WriteOff, finalBillID, SettlementDate, ClaimForwaredDate);
                if (returncode > 0)
                {
                    LoadpaymentDetails();
                    lblStatus.Text = "Updated Sucessfully...!";
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "Error", "javascript:alert('Amount Entered is greater than bill amount');", true);
                ModelPopPaymentDetail.Show();
            }
        }
    }
    protected void gvTPAItems_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TPAPayments Tpa = (TPAPayments)e.Row.DataItem;

            DropDownList ddlCashTypeC = (DropDownList)e.Row.FindControl("ddlCashTypeC");

            ddlCashTypeC.SelectedValue = Tpa.TypeID.ToString();
           
        }
    }
}
