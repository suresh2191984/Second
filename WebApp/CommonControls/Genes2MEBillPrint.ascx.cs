
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using NumberToWord;
using System.Text;
using System.Collections.Specialized;
using Attune.Utilitie.Helper;
using Attune.Cryptography;
using Attune.Kernel.NumberToWordConversion;

public partial class CommonControls_Genes2MEBillPrint : BaseControl
{
      string SuburbanPrintFormat = string.Empty;
    string Amount = string.Empty;
    int intLines = 0;
    int intLimit = 5;
    int intCnt = 0;
    int strChatLimit = 35;
    public string NumtoWord = string.Empty;
    public bool isDynamicPrint { get; set; }
    int LineFooterLimit = 3;
    List<Config> lstConfigList = new List<Config>();
    public string IsFullBill { get; set; }
    string strcontact = Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_01 == null ? "Contact No" : Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_01;
    string strphy = Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_02 == null ? "Ref Doctor" : Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_02;
    string strcentre = Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_03 == null ? "Ref Centre" : Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_03;
    string strvisit = Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_04 == null ? "Visit No" : Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_04;
    string strclient = Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_05 == null ? "Client / Insurance Provider:" : Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_05;
    string strphyname = Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_06 == null ? "Ref. Physician Name:" : Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_06;
    string strrefund = Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_07 == null ? "Amount Refunded to the patient: Rs." : Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_07;
    string stronly = Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_08 == null ? "Only" : Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_08;
    string strbill = Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_09 == null ? "BILLED BY" : Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_09;
    string stramtreceived = Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_10 == null ? "amount received in words" : Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_10;
    string strdueamt = Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_11 == null ? "Due Amount in Words:" : Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_11;
    string strMale = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_060 == null ? "Male" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_060;
    string strFemale = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_059 == null ? "Female" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_059;
    string strVet = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_070 == null ? "Veterinary" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_070;
    string strNa = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_071 == null ? "NA" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_071;
    string strMonth = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062 == null ? "Month(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062;
    string strWeek = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063 == null ? "Week(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063;
    string strYear = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064 == null ? "Year(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064;
    string strDay = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061 == null ? "Day(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061;
    string strAM = Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_15 == null ? "Year(s)" : Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_15;
    string strPM = Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_16 == null ? "Day(s)" : Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_16;
    string strUnknownF = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_086 == null ? "UnKnown" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_086;
    public CommonControls_Genes2MEBillPrint()
        : base("CommonControls_AdvanceBillPrint_ascx")
    {
    }

    protected void Page_Load(object sender, EventArgs e)
    {
         if (!Page.IsPostBack)
        {
            //RemainDeposit.Visible = false;
            //lblHospitalName.InnerHtml = OrgName+"<br/>";            
            #region Commented code
            List<Config> lstConfig = new List<Config>();
            int iBillGroupID = 0;
            iBillGroupID = (int)ReportType.OPBill;
            string BillHeader = string.Empty;

            string GST = string.Empty;

            GST = GetConfigValue("GSTTAX", OrgID);

            string declaration = "<u>Declaration</u><br/>1) We declare that this invoice shows the actual price<br/>of the goods described and that all particulars are true and correct.<br/>2) Any Discrepancy invoice, should be notified within<br/>24 hours receipt of Invoice.<br/>3) Interest on over due bills will be charged @21%";
             lblDeclaration.Text = declaration;
            if (String.IsNullOrEmpty(GST))
            {
                trGstDetails.Visible = false;


            }
            else
            {
                trGstDetails.Visible = true;

            }
            BillHeader = GetConfigValue("Bill Header Content", OrgID);
            if (BillHeader == "Y")
            {
            new GateWay().GetBillConfigDetails(iBillGroupID, "Header Logo", OrgID, ILocationID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                //tblGBillPrint.Style.Add("background-image", "url('" + lstConfig[0].ConfigValue.Trim() + "'); ");
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

                
            new GateWay().GetBillConfigDetails(iBillGroupID, "Footer Logo", OrgID, ILocationID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                footerLogo.ImageUrl = lstConfig[0].ConfigValue.Trim();
                
            }
            new GateWay().GetBillConfigDetails(iBillGroupID, "Footer Sign", OrgID, ILocationID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                imgSign.ImageUrl = lstConfig[0].ConfigValue.Trim();

            }

            new GateWay().GetBillConfigDetails(iBillGroupID, "Header Font", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                lblHospitalName.Style.Add("font-family", lstConfig[0].ConfigValue.Trim());
            }

            new GateWay().GetBillConfigDetails(iBillGroupID, "Header Font Size", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                lblHospitalName.Style.Add("font-size", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay().GetBillConfigDetails(iBillGroupID, "Header Content", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                lblHospitalName.InnerHtml = lstConfig[0].ConfigValue.Trim().Replace(",,,,", ",");
                lblHospitalName.InnerHtml = lblHospitalName.InnerHtml.Replace(",,,", ",");
                lblHospitalName.InnerHtml = lblHospitalName.InnerHtml.Replace(",,", ",");
            
            }

            //---------------------------------------------------------------------------------------------
            new GateWay().GetBillConfigDetails(iBillGroupID, "Contents Font", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblGBillPrint.Style.Add("font-family", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay().GetBillConfigDetails(iBillGroupID, "Contents Font Size", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblGBillPrint.Style.Add("font-size", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay().GetBillConfigDetails(iBillGroupID, "Border Style", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
               //// tblGBillPrint.Style.Add("border-style", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay().GetBillConfigDetails(iBillGroupID, "Border Width", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblGBillPrint.Width = lstConfig[0].ConfigValue.Trim();
            }

            }
             
            #endregion
        }
        

    }

    #region LoadBillConfigMetadata
    public void LoadBillConfigMetadata(int OrgID, long OrgAddressID)
    {
        //List<Config> lstConfig = new List<Config>();
        int iBillGroupID = 0;
        iBillGroupID = (int)ReportType.OPBill;
        if (lstConfigList.Count == 0)
        {
            new GateWay().GetBillConfigDetails(iBillGroupID, "", OrgID, OrgAddressID, out lstConfigList);
        }
        int nConfigElements = lstConfigList.Count;
        string[] sTempConfigElements;
        NameValueCollection oNV = new NameValueCollection();
        for (int nCnt = 0; nCnt < nConfigElements; nCnt++)
        {
            sTempConfigElements = lstConfigList[nCnt].ConfigValue.Split('^');
            if (sTempConfigElements != null && sTempConfigElements.Length == 2)
            {
                oNV.Add(sTempConfigElements[0], sTempConfigElements[1]);
            }
        }
        for (int nCnt = 0; nCnt < oNV.Count; nCnt++)
        {
            switch (oNV.GetKey(nCnt))
            {
                case "Header Logo":
                    imgBillLogo.ImageUrl = oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt];
                    if (imgBillLogo.ImageUrl.Length > 0)
                        imgBillLogo.Visible = true;
                    else
                        imgBillLogo.Visible = false;
                    break;
                case "Header Font":
                    lblHospitalName.Style.Add("font-family", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Header Font Size":
                    lblHospitalName.Style.Add("font-size", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Header Content":
                    lblHospitalName.InnerHtml = oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt];
                    break;
                case "Contents Font":
                    tblGBillPrint.Style.Add("font-family", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Contents Font Size":
                    tblGBillPrint.Style.Add("font-size", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Border Style":
                    tblGBillPrint.Style.Add("border-style", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Border Width":
                    tblGBillPrint.Width = oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt];
                    break;
                default:
                    break;
            }
        }
    }
    #endregion
    public string HSNSAC_No=string.Empty;
    public void BillPrinting(long visitID, long FinalbillID, int pdp)
    {
        try
        {


            string Discountonbill = string.Empty;
            Discountonbill = GetConfigValue("Discountonbill", OrgID);
            if (Discountonbill != "Y")
            {
                gvBillingDetail.Columns[5].Visible = false;
                gvBillingDetail.Columns[6].Visible = false;
            }
            else
            {

                gvBillingDetail.Columns[5].Visible = true;
                gvBillingDetail.Columns[6].Visible = true;

            }
            string IsRoundOff = string.Empty;
            IsRoundOff = GetConfigValue("PatientCommonRoundOffPattern", OrgID);
            if (String.IsNullOrEmpty(IsRoundOff))
            {
                hdnIsRoundOff.Value = "ON";
            }
            else
            {
                hdnIsRoundOff.Value = "OFF";
            }
            NumtoWord = GetConfigValue("NumberToWord", OrgID);
            int serviceFlag = 0;
            string LabNo = Convert.ToString(Request.QueryString["Labno"]);
            string physicianName = string.Empty;
            string splitstatus = string.Empty;
            string discountpercent = string.Empty;

            decimal amtReceived = 0;
            decimal amtRefunded = 0;
            decimal dChequeAmount = 0;
            List<BillingDetails> lstBillingDetail = new List<BillingDetails>();
            List<FinalBill> lstFinalBillDetail = new List<FinalBill>();
            List<Patient> lstPatientDetails = new List<Patient>();
            List<Organization> lstOrganization = new List<Organization>();
            List<DuePaidDetail> lstDuePaidDetails = new List<DuePaidDetail>();
            List<Taxmaster> lstTax = new List<Taxmaster>();
            List<OrderedInvestigations> lstOrderInv = new List<OrderedInvestigations>();
            List<PatientQualification> lstQualification = new List<PatientQualification>();
            if (Request.QueryString["isFB"] != null && Request.QueryString["isFB"].ToString() == "Y")
            {
                base.ContextInfo.AdditionalInfo = "FULLBILL";
            } base.ContextInfo.AdditionalInfo = "FULLBILL";
            BillingEngine billingBL = new BillingEngine(base.ContextInfo);
            billingBL.GetBillPrintingDetails(visitID, out lstBillingDetail,
                                            out lstFinalBillDetail, out lstPatientDetails,
                                            out lstOrganization, out physicianName,
                                            out lstDuePaidDetails, FinalbillID, out lstTax, out splitstatus, out lstQualification);

            List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
            billingBL.pGetRefundBillingDetails(visitID, out lstBillingDetails, out amtReceived, out amtRefunded, out dChequeAmount, FinalbillID, 0);
            /*Added by Arivalagan for co payment logic*/
            //if (lstFinalBillDetail[0].TpaDue > 0)

         //   if (Discountonbill == "Y")
          //  {
                if (!string.IsNullOrEmpty(lstPatientDetails[0].Add1) || !string.IsNullOrEmpty(lstPatientDetails[0].Add2) || !string.IsNullOrEmpty(lstPatientDetails[0].Add3))
                {

                    //Tr2.Visible = true;
                    //lblpatientaddress2.Text = lstPatientDetails[0].Add1.ToString() + " " + lstPatientDetails[0].Add2.ToString() + " " + lstPatientDetails[0].Add3.ToString();
                  
                }
          //  }
            string MedimaBill = string.Empty;

            MedimaBill = GetConfigValue("BillheaderNameChanges", OrgID);


            //string GSTCode = string.Empty;
            //GSTCode = GetConfigValue("GSTTAX", OrgID);

            //if (GSTCode == "Y" && lstFinalBillDetail.Count > 0)
            //{
            //    Label5.Text = lstFinalBillDetail[0].Comments;
            //}
            if (lstPatientDetails.Count > 0)
            {
                HSNSAC_No= lstPatientDetails[0].OtherOrgflag.ToString();
                lblPGSTSCODE.Text ="Code : " + lstPatientDetails[0].StateCode.ToString();
                string address1=lstPatientDetails[0].Add1.ToUpper() + " " + lstPatientDetails[0].Add2.ToUpper() + " " + lstPatientDetails[0].Add3.ToUpper();
                if (address1.Length > 45)
                {
                    lblPtAddress.Text = address1.Substring(0, 45) + "<br/>" + address1.Substring(45);
                }
                else
                {
                    lblPtAddress.Text = address1.ToString();
                }
                
                if (lstPatientDetails[0].TPAName.ToString() != "" && lstPatientDetails[0].TPAName.ToLower() != "general")
                {
                   
                    string address12=lstPatientDetails[0].Address.ToUpper();
                    if (address12.Length > 45)
                    {
                        lblClientAddress.Text = address12.Substring(0, 45) + "<br/>" + address12.Substring(45);
                    }
                    else
                    {
                        lblClientAddress.Text = address12;
                    }
                    if (!String.IsNullOrEmpty(lstPatientDetails[0].Comments))
                    {
                        lblCStateName.Text = lstPatientDetails[0].Comments.ToUpper();
                    }
                    if (!String.IsNullOrEmpty(lstPatientDetails[0].MetaTypeID))
                    {
                        lblCGSTIN1.Text = lstPatientDetails[0].MetaTypeID.ToString();
                    }
                    if (!String.IsNullOrEmpty(lstPatientDetails[0].MetaValueID))
                    {
                        lblCPan.Text = lstPatientDetails[0].MetaValueID.ToString();
                    }
                    if (!String.IsNullOrEmpty(lstPatientDetails[0].SecuredCode))
                    {
                        lblCGSTSCODE.Text = "Code : " + lstPatientDetails[0].SecuredCode.ToString();
                    }
                    if (!String.IsNullOrEmpty(lstPatientDetails[0].TPAName))
                    {
                        lblCliName.Text = lstPatientDetails[0].TPAName.ToUpper();
                    }
                   

                }
                else if (lstPatientDetails[0].TPAName.ToString() == "" || lstPatientDetails[0].TPAName.ToLower() == "general")
                {
                  //  lblPGSTIN1.Text = lstPatientDetails[0].SecuredCode.ToString();
                }
            }

            if (String.IsNullOrEmpty(MedimaBill))
            {

                lblHeader.Text = "BILL OF SUPPLY";

            }

            else
            {

                lblHeader.Text = MedimaBill;

            }
            string OneDiaBill = string.Empty;

            OneDiaBill = GetConfigValue("OneDiaBill", OrgID);

            if (!String.IsNullOrEmpty(OneDiaBill))
            {
                if (lstFinalBillDetail[0].IsCreditBill == "Y")
                {
                    lblHeader.Text = "Pro Forma Invoice";
                }
                else
                {
                    lblHeader.Text = "Invoice";
                }

            }
          

            if (lstFinalBillDetail[0].IsCopay == "Y")
            {

                CoPayAmount.Style.Add("display", "block");
                AmountDetails.Style.Add("display", "none");
                lblCopayAmount.Text = string.Format("{0:0.00}", Convert.ToInt64(lstFinalBillDetail[0].TpaDue));
                hdnRound.Value = lblCopayAmount.Text;
                hdncopayamount.Value = lblCopayAmount.Text;
                // Page.RegisterClientScriptBlock("hideAmtColumn","<Script>hideColumn();</Script>");

                hdfRoundcalc.Value = "1";
            }
            else
            {
                AmountDetails.Style.Add("display", "block");
                CoPayAmount.Style.Add("display", "none");

            }
            /*Added by Arivalagan for co payment logic*/
            if ((lstBillingDetail != null && lstBillingDetail.Count > 0 && lstBillingDetail[0].LabNo != "" && lstBillingDetail[0].LabNo != "0" && lstBillingDetail[0].LabNo != "-1"))
            {
                //trLabNo.Visible = true;
                //trLabNo1.Visible = true;
                trLabNo2.Visible = true;
                lblLabNo.Text = lstBillingDetail[0].LabNo.ToString();
            }
            else
            {
                //trLabNo.Visible = false;
                //trLabNo1.Visible = false;
                trLabNo2.Visible = false;
            }

            if (LabNo != null)
            {
                //trLabNo.Visible = true;
                //trLabNo1.Visible = true;
                trLabNo2.Visible = true;
                lblLabNo.Text = LabNo;
            }

            //if (lstOrderInv[0].LabNo > 0 & OrgID == 78)
            //{
            //    trLabNo.Visible = true;
            //    lblLabNo.Text = lstOrderInv[0].LabNo.ToString();
            //}
            //else
            //{
            //    trLabNo.Visible = false;
            //}

            if (amtRefunded > 0)
            {
                lblrefundamt.Visible = true;
                lblrefundamt.Text = strrefund + amtRefunded.ToString() + " " + stronly;
            }
            if (lstBillingDetail.Count > 0 && lstFinalBillDetail[0].GrossBillValue > 0)
            {
               

                GetUserImage(lstBillingDetail[0].CreatedBy);
                if (pdp == 1)
                {
                    //Added By Arivalagan.KK Display duplicate bill print//
                    tdDupBill.Style.Add("display", "table-cell");
                    lblDupBill.Visible = true;
                }
                else
                {
                    lblDupBill.Visible = false;
                }
                // Bind Billing details
                long vpur;
                Int64.TryParse(Request.QueryString["visitPur"], out vpur);
                string clientName = string.Empty;
                clientName = Request.QueryString["ClientName"];
                if (splitstatus == "CGHS OP" && OrgID == 82)
                {
                    List<BillingDetails> lstTemp = new List<BillingDetails>();
                    lstTemp = AddConsultantCGHS(lstBillingDetail);
                    var lstdayOP = (from lst in lstTemp
                                    where lst.FeeType.Trim() != "CON"
                                    select lst);

                    gvBillingDetail.DataSource = lstdayOP;
                    gvBillingDetail.DataBind();

                }
                else if (splitstatus == "DGEHS OP" && OrgID == 82)
                {
                    List<BillingDetails> lstTemp = new List<BillingDetails>();
                    lstTemp = AddConsultantDGEHS(lstBillingDetail);
                    var lstdayOP = (from lst in lstTemp
                                    where lst.FeeType.Trim() != "CON"
                                    select lst);

                    gvBillingDetail.DataSource = lstdayOP;
                    gvBillingDetail.DataBind();

                }
                else
                {

                    gvBillingDetail.DataSource = lstBillingDetail;
                    gvBillingDetail.DataBind();
                }
                if (gvBillingDetail.Rows.Count > 0)
                {
                    
                    gvBillingDetail.FooterRow.Cells[1].Text = "Total  ";
                    gvBillingDetail.FooterRow.Cells[1].Style.Add("text-align", "right");
                    gvBillingDetail.FooterRow.Cells[11].Text =  lstFinalBillDetail[0].NetValue.ToString();
                    gvBillingDetail.FooterRow.Cells[11].Style.Add("text-align", "right");
                    gvBillingDetail.FooterRow.Style.Add("border-top","1px solid grey");
                    
                }

                string isDueBill = "N";
                string isCreditBill = string.Empty;
                for (int i = 0; i < lstBillingDetail.Count; i++)
                {
                    if (lstBillingDetail[i].FeeId == -2)
                    {
                        isDueBill = "Y";
                    }
                    if (lstBillingDetail[i].ServiceCode != "" && lstBillingDetail[i].ServiceCode != null)
                    {
                        serviceFlag = 1;
                    }

                }
                //This below code is used to show and hide Service cdoe column in Grid added by suresh

                if (serviceFlag == 1)
                {
                    gvBillingDetail.Columns[2].Visible = true;
                }
                else
                {
                    gvBillingDetail.Columns[2].Visible = false;
                }
                //End
                List<Config> lstConfig = new List<Config>();
                GateWay gateWay = new GateWay();
                long returnCode = gateWay.GetConfigDetails("SuburbanPrintBillFormat", OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                {

                    SuburbanPrintFormat = lstConfig[0].ConfigValue.ToUpper();
                    if (lstConfig[0].ConfigValue.ToUpper() == "Y")
                    {
                        //Rs_PatPhoneNo.Text = "Contact No";
                        //lblLabNo.Text = "";

                    }


                }

                if (SuburbanPrintFormat == "Y")
                {
                    gvBillingDetail.Columns[3].Visible = false;
                }
                else
                {
                    gvBillingDetail.Columns[3].Visible = true;
                }


                lblName.Text = lstPatientDetails[0].Name;
                lblTitleName.Text = lstPatientDetails[0].TitleName;
                lblPatientNumber.Text = lstPatientDetails[0].PatientNumber.ToString();
                if (lstPatientDetails[0].StateName != null)
                {
                    lblPStateName.Text = lstPatientDetails[0].StateName.ToString();
                }
                if (!string.IsNullOrEmpty(lstPatientDetails[0].RegistrationRemarks))
                {
                    lblRegistrationRemarks.Text = lstPatientDetails[0].RegistrationRemarks;

                }
                else
                {
                    lblRegistrationRemarks.Visible = false;
                    lblRRHeading.Visible = false;
                }

                if (String.IsNullOrEmpty(MedimaBill))
                {

                    if (lstPatientDetails[0].EMail.Contains(","))
                    {

                        lblEmail.Text = lstPatientDetails[0].EMail.Replace(",", ", ");

                    }

                    else
                    {

                        lblEmail.Text = lstPatientDetails[0].EMail.ToString();

                    }

                }

                else
                {

                    lblEmail.Visible = false;

                    //lblmail1.Visible = false;

                    lblmail.Visible = false;

                }


                //lblAddress.Text = lstPatientDetails[0].Add1.ToString() + ' ' + lstPatientDetails[0].Add2.ToString();
                //if (lstFinalBillDetail[0].TATDate.ToString("dd/MM/yyyy") != "01/01/1753")
                if (lstFinalBillDetail[0].TATDate > Convert.ToDateTime("01/01/1900"))
                {
                    lbldeliverydate.Text = lstFinalBillDetail[0].TATDate.ToString("dd/MMM/yyyy hh:mm:tt");
                }
                else
                {
                    lbldeliverydate.Text = "";
                }

                if (!string.IsNullOrEmpty(lstPatientDetails[0].LoginName))
                {
                    //Added by arivalagn.kk//
                    tdUserName.Style.Add("display", "table-cell");
                    lblLoginName.Text = lstPatientDetails[0].LoginName.ToString();
                    //commented by arivalagn.kk//
                    //lblUserName.Visible = true;
                }
                string EncryptedPassword = string.Empty;
                string DecryptedPassword = string.Empty;
                string strDNSURL = string.Empty;
                if (!string.IsNullOrEmpty(lstPatientDetails[0].Password))
                {
                    EncryptedPassword = lstPatientDetails[0].Password;
                    CCryptography objDecryptor = new CCryptFactory().GetDecryptor();
                    objDecryptor.Crypt(EncryptedPassword, out DecryptedPassword);
                    lblPassword.Text = DecryptedPassword;
                    strDNSURL = GetConfigValue("IsDNSURL", OrgID);
                    if (!string.IsNullOrEmpty(strDNSURL))
                    {
                        lblLoginurl.Text = strDNSURL;
                    }
                    else
                    {

                        lblLoginurl.Text = "http://" + Request.Url.Authority + ":8082/" + Request.Url.Segments[1] + "Home.aspx";
                    }
                    lblPass.Visible = true;
                    lblURL.Visible = true;
                }
                if (lstPatientDetails[0].SEX == "M")
                    lblSex.Text = strMale;
                else if (lstPatientDetails[0].SEX == "F")
                    lblSex.Text = strFemale;
                else if (lstPatientDetails[0].SEX == "V")
                    lblSex.Text = strVet;
                else if (lstPatientDetails[0].SEX == "N")
                    lblSex.Text = strNa;
                else if (lstPatientDetails[0].SEX == "U")
                    lblSex.Text = strUnknownF;
                else
                    lblSex.Text = "";




                if (String.IsNullOrEmpty(MedimaBill))
                {

                    if (lstPatientDetails[0].MobileNumber != "")
                    {

                        lblPatPhoneNumber.Text = lstPatientDetails[0].MobileNumber;

                    }

                }

                else
                {

                    Rs_PatPhoneNo.Visible = false;

                    //Rs_PatPhoneNo1.Visible = false;

                    lblPatPhoneNumber.Visible = false;

                }



                if (SuburbanPrintFormat == "Y")
                {
                    Rs_PatPhoneNo.Text = strcontact;
                    // lblPhy.Text = "Ref Doctor";
                    lblPhy.Text = strphy;
                   //// lblRefHos.Text = strcentre;
                }


                if (lstPatientDetails[0].ReferedHospitalName != "")
                {
                    //lblRefHos.Visible = true;
                    //lblReferringHos.Visible = true;
                    lblReferringHos.Text = lstPatientDetails[0].ReferedHospitalName;
                    //tdReferringHos.InnerText = ":";
                }
                else
                {
                    ////lblRefHos.Visible = false;
                    lblReferringHos.Visible = false;
                   ///// tdReferringHos.InnerText = "";
                }
                if (lstPatientDetails[0].VersionNo.ToString() != "")
                {
                    lblVisitNumber.Visible = true;
                    Rs_VisitNumber.Visible = true;
                    if (SuburbanPrintFormat == "Y")
                    {
                       //// trLabNo.Visible = true;
                        //// trLabNo1.Visible = true;
                        trLabNo2.Visible = true;
                        //lLabNo.Visible = false;
                        lblLabNo.Visible = false;
                        //lLabNo.Text = "";
                        lblLabNo.Text = "";
                        Rs_VisitNumber.Text = strvisit;
                        lblVisitNumber.Text = lstPatientDetails[0].VersionNo.ToString();
                    }
                    else
                    {
                        lblVisitNumber.Text = "  /" + lstPatientDetails[0].VersionNo.ToString();
                    }
                }
                else
                {
                    lblVisitNumber.Visible = false;
                    Rs_VisitNumber.Visible = false;
                }
                lblAge.Text = lstPatientDetails[0].Age.ToString();
                string str = lblAge.Text;
                string[] strage = str.Split(' ');
                if (strage[1] == "Year(s)")
                {
                    lblAge.Text = strage[0] + " " + strYear;
                }
                else if (strage[1] == "Month(s)")
                {
                    lblAge.Text = strage[0] + " " + strMonth;
                }
                else if (strage[1] == "Day(s)")
                {
                    lblAge.Text = strage[0] + " " + strDay;
                }
                else if (strage[1] == "Week(s)")
                {
                    lblAge.Text = strage[0] + " " + strWeek;
                }
                else if (strage[1] == "UnKnown")
                {
                    lblAge.Text = strage[0] + " " + strUnknownF;


                }
                else
                {
                    lblAge.Text = strage[0] + " " + strYear;
                }
                IsFullBill = lstFinalBillDetail[0].VersionNo;

                if (lstPatientDetails[0].PriorityID != "" && lstPatientDetails[0].PriorityID != null)
                {
                    lbldeliverydate.Text = lstPatientDetails[0].PriorityID.ToString();
                }
                else
                {
                    lblDeliver.Visible = false;
                    lbldeliverydate.Visible = false;
                }
                if (String.IsNullOrEmpty(MedimaBill))
                {

                    lblpatientHistory.Text = lstPatientDetails[0].DetailHistory.ToString();

                }

                else
                {

                    lblHistory.Visible = false;

                    lblHistory2.Visible = false;

                    lblpatientHistory.Visible = false;

                }

                if (String.IsNullOrEmpty(MedimaBill))
                {

                  ////  lblModetype.Text = lstPatientDetails[0].DispatchType.ToString();

                }

                else
                {

                    ////  lblModedelivirey.Visible = false;

                    //// lblModedelivirey2.Visible = false;

                    ////  lblModetype.Visible = false;

                }
                //lblPickupdate.Text = lstPatientDetails[0].SamplePickupDate.ToString("dd/MMM/yyyy");

                //lblDoB.Text = lstPatientDetails[0].DOB.ToShortDateString();


                // Bind Final Bill detail

                lblInvoiceNo.Text = lstFinalBillDetail[0].BillNumber.ToString().Trim();
                string[] tempdate;
                string invoiceDate = string.Empty;
                invoiceDate = lstFinalBillDetail[0].CreatedAt.ToString("dd/MM/yy hh:mm tt");
                tempdate = invoiceDate.Split(' ');
                if (tempdate[2] == "AM")
                {
                    invoiceDate = tempdate[0] + ' ' + tempdate[1] + ' ' + strAM;
                }
                else if (tempdate[2] == "PM")
                {
                    invoiceDate = tempdate[0] + ' ' + tempdate[1] + ' ' + strPM;
                }
                else
                {
                    invoiceDate = tempdate[0] + ' ' + tempdate[1] + ' ' + strAM;
                }

                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                new GateWay().GetInventoryConfigDetails("ShowDate_WithTime_BillPrint_Ascx", OrgID, ILocationID, out lstInventoryConfig);

                if (lstInventoryConfig.Count > 0 && lstInventoryConfig[0].ConfigValue == "Y")
                {
                    // lblInvoiceDate.Text = lstFinalBillDetail[0].CreatedAt.ToString("dd/MMM/yy hh:mm tt");
                    lblInvoiceDate.Text = invoiceDate;
                }
                else
                {
                    //lblInvoiceDate.Text = lstFinalBillDetail[0].CreatedAt.ToString("dd/MMM/yyyy hh:mm tt ");
                    lblInvoiceDate.Text = invoiceDate;
                }

                if (string.IsNullOrEmpty(lstPatientDetails[0].ReferingPhysicianName))
                {
                    if (OrgID == 74)
                    {
                        lblPhysician.Visible = true;
                        lblPhysician.Text = "-";
                        //tdPhysician.InnerText = ":";
                    }
                    else
                    {
                        //lblPhy.Visible = false;
                        lblPhysician.Visible = false;
                        //tdPhysician.InnerText = "";
                        //phyDetails.Visible = false;
                    }
                }
                else
                {
                    lblPhy.Visible = true;
                    lblPhysician.Visible = true;
                    //tdPhysician.InnerText = ":";
                    // Code modified by Vijay TV on 16-Feb-2011 for Bug tracker ID 785 begins
                    //lblPhysician.Text = physicianName;
                    lblPhysician.Text = lstPatientDetails[0].ReferingPhysicianName; // Show Referring Physician name in the header
                    //phyDetails.Visible = true;
                    // Code modified by Vijay TV on 16-Feb-2011 for Bug tracker ID 785 ends
                }
                lblRefHospital1.Text = lstPatientDetails[0].ReferedHospitalName;
                if (IsFullBill == "Y")
                {

                    // Rs_VisitNumber.Visible = false;
                    //trLabNo.Visible = true;
                    trLabNo2.Visible = true;

                    lblInvoiceNo.Text = lstBillingDetail[0].AttributeDetail.ToString();


                    if (lstPatientDetails[0].ReferedHospitalName != "")
                    {

                    }
                    else
                    {

                    }
                }
                else
                {
                    if (lstPatientDetails[0].ReferedHospitalName != "")
                    {

                    }
                    else
                    {

                    }
                    //trLabNo.Visible = true;
                    Rs_VisitNumber.Visible = true;
                    Rs_VisitNumber.Text = strvisit;
                    lblVisitNumber.Visible = true;
                    lblVisitNumber.Text = lstPatientDetails[0].VersionNo;

                }

                if (lstFinalBillDetail[0].StdDedID > 0)
                {
                    if (lstFinalBillDetail[0].StdDedType == "V")
                        lblDeduction.Text = String.Format("{0:0.00}", Convert.ToInt64(lstFinalBillDetail[0].StdDedValue));
                    else if (lstFinalBillDetail[0].StdDedType == "P")
                        lblDeduction.Text = String.Format("{0:0.00}", (Convert.ToInt64(lstFinalBillDetail[0].StdDedValue) * lstFinalBillDetail[0].GrossBillValue / 100));
                }
                else
                {
                    lblDeduction.Text = "0.00";
                }

                if (lstFinalBillDetail[0].DiscountAmount > 0)
                {
                   // trDiscount.Attributes.Add("display", "table-row");
                    lblDiscount.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].DiscountAmount);
                    hdnDiscount.Value = "1";
                }
                if (lstFinalBillDetail[0].EDCess > 0)
                {
                    trEDCess.Attributes.Add("display", "table-row");
                    lblEDCess.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].EDCess);
                    hdnEDCess.Value = "1";
                }
                if (lstFinalBillDetail[0].SHEDCess > 0)
                {
                    trSHEDCess.Attributes.Add("display", "table-row");
                    lblSHEDCess.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].SHEDCess);
                    hdnSHEDCess.Value = "1";
                }
                // ====================
                decimal sum = lstFinalBillDetail[0].GrossBillValue;
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "validateround('" + sum.ToString() + "');", true);
                //lblGrossAmount.Text = hdnRoundOff.Value;
                //===================
                lblGrossAmount.Text = String.Format("{0:0.00}", sum);
                //lblGrossAmount.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].GrossBillValue);
                if (lstFinalBillDetail[0].ServiceCharge > 0)
                {
                    trServiceCharge.Attributes.Add("display", "table-row");
                    lblServiceCharge.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].ServiceCharge);
                    hdnServiceCharge.Value = "1";
                }
                if (lstFinalBillDetail[0].TaxAmount > 0)
                {
                    trServiceCharge.Attributes.Add("display", "table-row");
                    lblTaxAmount.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].TaxAmount);
                    hdnTaxAmount.Value = "1";
                }
                string IsTaxdisclaimer = string.Empty;
                IsTaxdisclaimer = GetConfigValue("Taxdisclaimer", OrgID);
                if (!String.IsNullOrEmpty(IsTaxdisclaimer))
                {
                    if (IsTaxdisclaimer == "Y")
                    {
                        if (lstPatientDetails[0].PayerID == 1)
                        {
                            // trTaxDetails.Attributes.Add("display", "block");
                            lblTaxDetails.Visible = true;
                            lblTaxDetails.Text = "*This amount is subject to " + String.Format("{0:0.##}", lstFinalBillDetail[0].TaxPercent) + "% GST";
                        }
                    }
                }
                //lblServiceCharge.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].ServiceCharge);
                if (lstFinalBillDetail[0].RoundOff != 0)
                {
                    trRoundoff.Attributes.Add("display", "table-row");
                    lblRoundOff.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].RoundOff);
                    hdnRoundoff.Value = "1";
                }
                //lblPreviousDue.Text = "0.00";
                //decimal gt;
                //if (hdnIsRoundOff.Value == "ON")
                //{
                //    //gt = Math.Round(lstFinalBillDetail[0].NetValue);
                //}
                //else
                //{
                //    //gt = lstFinalBillDetail[0].NetValue;
                //}
                // lblGrandTotal.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].NetValue);
                lblGrandTotal.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].NetValue);
                //lblAmountRecieved.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].AmountReceived);
                ////if (lstFinalBillDetail[0].Due > 0)
                ////{

                //decimal Ar;
                //if (hdnIsRoundOff.Value == "ON")
                //{
                //    Ar = Math.Round(lstFinalBillDetail[0].AmountReceived);
                //}
                //else
                //{
                //    Ar = lstFinalBillDetail[0].AmountReceived;
                //}
                //lblAmountRecieved.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].AmountReceived);
                lblAmountRecieved.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].AmountReceived);
               
                if (lstFinalBillDetail[0].RemainDeposit > 0)
                {
                    RemainDeposit.Visible = true;
                    Label1.Visible = true;
                    RemainDeposit.Text = " " + (lstFinalBillDetail[0].RemainDeposit).ToString();

                }
                else
                {
                    RemainDeposit.Visible = false;
                    Label1.Visible = false;
                }
                if (lstFinalBillDetail[0].Due > 0)
                {
                  //  trDiscount.Attributes.Add("display", "table-row");
                    string DueAmmt = String.Format("{0:0.00}", lstFinalBillDetail[0].Due);
                    lblCurrentVisitDueText.Text = (DueAmmt);
                    hdnDue.Value = "1";
                }
                //lblCurrentVisitDueText.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].Due);
                if (isDueBill != "Y" && lstFinalBillDetail[0].CurrentDue > 0)
                {
                    trPreviousDue.Attributes.Add("display", "none");
                    lblPreviousDue.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].CurrentDue);
                    hdnPreviousDue.Value = "1";
                }
                else
                {
                    if (lstFinalBillDetail[0].CurrentDue > 0)
                    {
                        trPreviousDue.Attributes.Add("display", "none");
                        lblPreviousDue.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].CurrentDue);
                        hdnPreviousDue.Value = "1";
                    }
                    else
                    {
                        lblPreviousDue.Text = String.Format("{0:0.00}", "0");
                    }
                }
                if (isDueBill != "Y")
                {
                    decimal nv;
                    //if (hdnIsRoundOff.Value == "ON")
                    //{
                    //    nv = Math.Round(lstFinalBillDetail[0].NetValue);//+ lstFinalBillDetail[0].CurrentDue
                    //}
                    //else
                    //{
                    //    nv = lstFinalBillDetail[0].NetValue;//+ lstFinalBillDetail[0].CurrentDue
                    //}
                    // lblNetValue.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].NetValue + lstFinalBillDetail[0].CurrentDue);
                    lblNetValue.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].NetValue);
                    hdnRound.Value = lblNetValue.Text;
                    hdfRoundcalc.Value = "1";
                    //decimal sum =Math.Round( lstFinalBillDetail[0].NetValue + lstFinalBillDetail[0].CurrentDue);
                    ////ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "validateround('" + sum.ToString() + "');", true);
                    ////lblGrossAmount.Text = hdnRoundOff.Value;
                    //lblGrossAmount.Text =String.Format("{0:0.00}", sum);

                }
                else
                {
                    //decimal nv;
                    //if (hdnIsRoundOff.Value == "ON")
                    //{
                    //    nv = Math.Round(lstFinalBillDetail[0].NetValue);
                    //}
                    //else
                    //{
                    //    nv = lstFinalBillDetail[0].NetValue;
                    //}
                    //lblNetValue.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].NetValue);
                    lblNetValue.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].NetValue);
                    hdnRound.Value = lblNetValue.Text;
                    hdfRoundcalc.Value = "1";
                }
                //}
                //else
                //{

                //    lblCurrentVisitDueLabel.Visible = false;
                //    lblCurrentVisitDueText.Visible = false;

                //}

                //if (lstFinalBillDetail[0].IsCreditBill == "Y")
                //{

                //}
                NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
                Attune.Kernel.NumberToWordConversion.Attune_NumberToWord obj = new Attune.Kernel.NumberToWordConversion.Attune_NumberToWord();
                if (NumtoWord == "Y")
                {
                    lblAmount.Text = obj.ConvertToWord(lblAmountRecieved.Text, base.ContextInfo.LanguageCode) + " Sólo";
                    //ConvertToWord
                }
                else
                {
                    //NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
                    if (Convert.ToDouble(lblAmountRecieved.Text.Split('/')[0]) > 0)
                    {
                        if (int.Parse(lblAmountRecieved.Text.Split('/')[0].Split('.')[1]) > 0)
                        {
                            lblAmount.Text = Utilities.FormatNumber2Word(num.Convert(lblAmountRecieved.Text.Split('/')[0])) + " " + MinorCurrencyName + " Only";
                        }
                        else
                        {
                            lblAmount.Text = num.Convert(lblAmountRecieved.Text.Split('/')[0]) + " Only";
                        }
                    }
                    else
                    {
                        lblAmount.Text = " Zero Only";
                        lblPayingCurrencyinWords.Text = " Zero Only";
                        //lblAmount.Attributes.Add("display", "none");


                    }
                }
                if (NumtoWord == "Y")
                {
                    lblDueAmount.Text = obj.ConvertToWord(lblCurrentVisitDueText.Text) + " Sólo";
                    //ConvertToWord
                }
                else
                {
                    if (lblCurrentVisitDueText.Text != "")
                    {
                        if (Convert.ToDouble(lblCurrentVisitDueText.Text) > 0)
                        {
                            if (int.Parse(lblCurrentVisitDueText.Text.Split('.')[1]) > 0)
                            {
                                lblDueAmount.Text = Utilities.FormatNumber2Word(num.Convert(lblCurrentVisitDueText.Text)) + " " + MinorCurrencyName + " Only";
                            }
                            else
                            {
                                lblDueAmount.Text = num.Convert(lblCurrentVisitDueText.Text) + " Only";
                            }

                        }
                        if (lblCurrentVisitDueText.Text == "")
                        {
                            lblDueAmount.Attributes.Add("display", "none");
                            lblDueAmountinWords.Attributes.Add("display", "none");
                        }
                    }
                }

                //else
                //{
                //    lblDueAmount.Text = " Zero Only";
                //    //lblAmount.Visible = false;
                //    //lblAmount.Style.Add("display", "none");
                //}

                #region for KMH Changes

                if (lstFinalBillDetail[0].IsCreditBill == "Y")
                {
                    //Updated by BalaMahesh For MetroPolis
                    lblTypeBill.Text = "BILL";
                    TRAMTRcvd.Visible = false;
                    TRDueAmt.Attributes.Add("display", "none");
                    tdUserName.Attributes.Add("colspan", "2");
                    // TRDueAmt.Visible = false;
                }
                else if (lstFinalBillDetail[0].IsCreditBill != "Y" && (lblCurrentVisitDueText.Text != "0.00" && lblCurrentVisitDueText.Text != ""))
                {
                    lblTypeBill.Text = "DUE BILL";
                }
                else
                {
                    lblTypeBill.Text = "BILL CUM RECEIPT";
                }
                if (lstFinalBillDetail[0].IsDiscountPercentage == "Y")
                {

                    decimal n;
                    n = (lstFinalBillDetail[0].DiscountAmount / (lstFinalBillDetail[0].TDS + lstFinalBillDetail[0].TaxPercent)) * 100;
                    if (hdnIsRoundOff.Value == "ON")
                    {
                        //discountpercent = "(" + Math.Round(n) + "%)";
                        discountpercent = "(" + decimal.Round(n, 2).ToString() + "%)";
                    }
                    else
                    {
                        discountpercent = "(" + n + "%)";
                    }

                    lblDiscountPercent.Text = discountpercent;
                }
                string ReceiptNo = string.Empty;
                int payingPage = 1;
                decimal depamt = 0;
                List<PaymentType> lstPaymentType = new List<PaymentType>();
                List<PaymentType> lstOtherCurrency = new List<PaymentType>();
                List<PaymentType> lstDepositAmt = new List<PaymentType>();
                string appString = string.Empty;
                base.ContextInfo.AdditionalInfo = "";
                billingBL.GetPaymentMode(FinalbillID, visitID, ReceiptNo, payingPage, out lstPaymentType, out lstOtherCurrency, out lstDepositAmt);
                if (lstPaymentType.Count > 0)
                {
                    lblPayment.Visible = true;

                    int flag = 0;
                    for (int i = 0; i < lstPaymentType.Count; i++)
                    {
                        if (flag == 0)
                        {
                            //appString = lstPaymentType[i].PayDetails + "-"+lstOtherCurrency[0].CurrencyName+"<br>";
                            //if (!string.IsNullOrEmpty(lstPaymentType[i].PayDetails))
                            //{
                            //    appString = lstPaymentType[i].PayDetails + "<br>";
                            //}
                             if (!string.IsNullOrEmpty(lstPaymentType[i].PaymentName))
                            {
                                appString = lstPaymentType[i].PaymentName + "<br>";
                            }
                        }
                        else
                        {
                            //appString = appString + lstPaymentType[i].PayDetails + "-"+lstOtherCurrency[0].CurrencyName+"<br>";
                            if (!string.IsNullOrEmpty(lstPaymentType[i].PayDetails))
                            {
                                appString = appString + lstPaymentType[i].PayDetails + "<br>";
                            }
                            else if (!string.IsNullOrEmpty(lstPaymentType[i].PaymentName))
                            {
                                appString = appString + " " + lstPaymentType[i].PaymentName + "<br>";
                            }
                        }
                        flag++;

                    }
                }
                else
                {
                    lblPayment.Visible = false;
                }
                if (lstDepositAmt.Count > 0)
                {
                    //trDeposit.Attributes.Add("display", "block");
                    lblDepositAmtUsed.Visible = true;
                    lblDepositAmtUsed.Text = "Deposit Amount Used - " + lstDepositAmt[0].AmountUsed.ToString("0.00");
                    depamt = lstDepositAmt[0].AmountUsed;
                    lblPayment.Visible = true;
                }
                if (lstOtherCurrency.Count > 0)
                {
                    if (lstOtherCurrency[0].CurrencyName != null && lstOtherCurrency[0].OtherCurrencyAmount != null)
                    {
                        decimal othercuramt = 0, totothercuramt = 0;
                        decimal servicecharge = 0;


                        othercuramt = Convert.ToDecimal(lstOtherCurrency[0].OtherCurrencyAmount);
                        servicecharge = Convert.ToDecimal(lstFinalBillDetail[0].ServiceCharge);
                        servicecharge = servicecharge == null ? 0 : servicecharge;
                        totothercuramt = othercuramt + servicecharge + depamt;

                        //lblOtherCurrency.Text = "<br>" + "<b>Paying Currency/Amount = </b>" + lstOtherCurrency[0].CurrencyName + " - " + totothercuramt.ToString();
                        lblPayingCurrency.Text = "Amount Chargeble: (" + lstOtherCurrency[0].CurrencyName + ")";
                        //Label1.Text = "Remaining Deposit Amount : (" + lstOtherCurrency[0].CurrencyName + ")";

                        if (int.Parse(totothercuramt.ToString().Split('.')[1]) > 0)
                        {
                            lblPayingCurrencyinWords.Text = Utilities.FormatNumber2Word(num.Convert(totothercuramt.ToString())) + " " + MinorCurrencyName + " " + "Only";
                        }
                        else
                        {
                            lblPayingCurrencyinWords.Text = num.Convert(totothercuramt.ToString()) + "Only";
                            lblPayingCurrencyinWords.Text = num.Convert(lstFinalBillDetail[0].AmountReceived.ToString()) + " " + "Only";
                        }
                        trPayingCurrency.Attributes.Add("display", "table-row");
                        hdnPayingCurrency.Value = "1";


                    }
                    else
                    {
                        hdnPayingCurrency.Value = "0";
                    }
                }
                lblPaymentMode.Text = appString;
                //lblPayMode.InnerHtml = appString;
                #endregion

                //List<Config> lstConfig = new List<Config>();
                //GateWay gateWay = new GateWay();

                long returnCode1 = -1;
                List<Config> lstConfigs = new List<Config>();
                returnCode1 = gateWay.GetConfigDetails("DisplayServiceTax", OrgID, out lstConfigs);
                if (lstConfigs.Count > 0)
                {
                    if (lstConfigs[0].ConfigValue == "N")
                    {
                        lblservicetax.Style.Add("display", "none");
                        lblCategoryservice.Style.Add("display", "none");
                    }
                }
                returnCode = gateWay.GetConfigDetails("DisplayCurrencyFormat", OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                {
                    lblDisplayAmount.Text = stramtreceived + " " + lstConfig[0].ConfigValue.ToString();
                    lblDueAmountinWords.Text = strdueamt + lstConfig[0].ConfigValue.ToString();
                    Label1.Text = "Remaining Deposit Amount : (" + lstConfig[0].ConfigValue + ")";
                    decimal dec = 0.00m;
                    if (decimal.TryParse(lblCurrentVisitDueText.Text, out dec))
                    {
                        lblDueAmountinWords.Style.Add("display", (dec == decimal.Zero ? "none" : "block"));
                    }
                    else
                    {
                        lblDueAmountinWords.Style.Add("display", "none");
                    }
                }


                else
                {
                    lblDisplayAmount.Text = stramtreceived + CurrencyName;
                    lblDueAmountinWords.Text = strdueamt + CurrencyName;
                }
                if (lstFinalBillDetail[0].TATDate > Convert.ToDateTime("01/01/1900"))
                {
                    trReportDate.Style.Add("display", "table-row");
                    lblReportcommitDate.Text = "Please have your report collected at : " + "<b>" + lstFinalBillDetail[0].TATDate.ToString("dd/MM/yyyy hh:mm:tt");

                }
                else
                {
                    trReportDate.Style.Add("display", "none");
                }
                //lblBilledBy.Text = ("Billed By: (" + UserName + ")").ToUpper();
                string billedby_sign;
                billedby_sign = GetConfigValue("BIlledbySign", OrgID);
                if (billedby_sign == "Y")
                {

                    // lblBilledBy.Text = ( strbill+"(ADMIN");

                    lblBilledBy.Text = (strbill + "(" + lstBillingDetail[0].BilledBy.ToUpper() + ")");

                }
                else
                {
                    lblBilledBy.Text = (strbill + lstBillingDetail[0].BilledBy).ToUpper();
                }
                string PatientPortal = string.Empty;
                if (!string.IsNullOrEmpty(lstPatientDetails[0].EMail))
                {
                    if (!string.IsNullOrEmpty(lstPatientDetails[0].DispatchType))
                    {
                        if (lstPatientDetails[0].DispatchType.Contains("Email"))
                        {
                            /*
                             * Code Add By Syed To Show the Default URL in Bill Print for Patient Portal Login
                             * Request.Url="http://115.112.134.132/Lims_staging1.13/Reception/PrintPage.aspx?pid=001"
                             * Request.AppRelativeCurrentExecutionFilePath=~/Reception/PrintPage.aspx?pid=001                            
                             * Remove '~' from AppRelativeCurrentExecutionFilePath
                             * Replace Url String By AppRelativeCurrentExecutionFilePath string, example 'Welcome'.Replace('come','')=> Wel
                             * so we get the Actual Path http://115.112.134.132/Lims_staging1.13/ 
                             */
                            string sPath = string.Empty;
                            sPath = Request.Url.ToString().Replace(Request.AppRelativeCurrentExecutionFilePath.Remove(0, 1).ToString(), "");
                            sPath = sPath.Split('?')[0] + "/";
                            PatientPortal = "<b>" + "*" + "</b>" + "You can view your reports in following link, " + sPath + ". Your username is " + lstPatientDetails[0].PatientNumber.ToString() + " and Password is abc@123" + "<br>";
                            //PatientPortal = "<b>" + "*" + "</b>" + "You can view your reports in following link, http://115.112.134.132/Lims_staging1.13/ . Your username is " + lstPatientDetails[0].PatientNumber.ToString() + " and Password is abc@123" + "<br>";
                        }
                    }
                }
                //Comment by Prabakar//
                //lblNote.Text = PatientPortal + "<b>" + "Note :" + "</b>" + "Dispatch – Kindly collect reports during lab dispatch hours (Between – mornings 9:30-10: am and evening 5:30-7:30 pm on all weekdays, and up to 2pm on Sundays)";

                lblNote.Text = "";
                if (lstTax.Count > 0)
                {
                    dvTaxDetails.Visible = true;
                    string sTableHTML = "<table width='100%'>";
                    foreach (Taxmaster tm in lstTax)
                    {
                        if (tm.TaxAmount > 0)
                        {
                            sTableHTML += "<tr><td> " + tm.TaxName + " : </td><td>&nbsp;&nbsp;&nbsp;</td><td align='right'>" + String.Format("{0:0.00}", ((lstFinalBillDetail[0].GrossBillValue - lstFinalBillDetail[0].DiscountAmount) * (tm.TaxPercent / 100))) + "<td/></tr>";
                        }
                    }

                    sTableHTML += "</table>";
                    dvTaxDetails.InnerHtml = sTableHTML;
                }
                else
                {
                    dvTaxDetails.Visible = false;
                }




                #region TPAAttribute
                string TPAAttributes = (lstPatientDetails[0].TPAAttributes == null) ? "" : lstPatientDetails[0].TPAAttributes;

                // if (TPAAttributes != "" || lstPatientDetails[0].TPAName != "")
                string ClientTypeCode = lstPatientDetails[0].NewPassword.Trim();
                string ISCash = lstPatientDetails[0].ReportStatus.Trim();
                if (lstPatientDetails[0].TPAName == "GENERAL" || ClientTypeCode == "WAK" || ISCash == "Y")
                {
                    trAmountReceived.Style.Add("display", "table-row");
                  //  TRAMTRcvd.Style.Add("display", "block");
                }
                else
                {
                    trAmountReceived.Style.Add("display", "none");
                   // TRAMTRcvd.Style.Add("display", "none");
                }
                if (lstPatientDetails[0].TPAName != "" && lstPatientDetails[0].TPAName != null)
                {
                    if (SuburbanPrintFormat == "Y" && lstPatientDetails[0].TPAName == "GENERAL")
                    {
                        trFinalBillHeader.Attributes.Add("style", "display:none");
                    }
                    else
                    {
                        //trFinalBillHeader.Attributes.Add("style", "display:table-row");
                        //FinalBillHeader1.SetAttribute(lstPatientDetails[0].TPAAttributes, lstPatientDetails[0].TPAName);
                        //trDue.Style.Add("display", "none");
                        //hdnCleintFlag.Value = "Y";
                    }
                }
                else
                {
                    trFinalBillHeader.Attributes.Add("style", "display:none");
                }
                #endregion

                ////sample print
                #region Modified Billing Print
                //List<Config> lstConfig = new List<Config>();
                int iBillGroupID = 0;
                string isDynamic = "N";
                iBillGroupID = (int)ReportType.OPBill;
                if (lstConfigList.Count == 0)
                {
                    new GateWay().GetBillConfigDetails(iBillGroupID, "", OrgID, ILocationID, out lstConfigList);
                }
                if (lstConfigList.Count > 0)
                {
                    isDynamic = lstConfigList.Find(a => a.ConfigValue.Split('^')[0] == "Dynamic Print").ConfigValue.Split('^')[1].ToString();
                }
                if (isDynamic == "Y" && lstFinalBillDetail != null && lstFinalBillDetail.Count > 0)
                {
                    isDynamicPrint = true;
                    int ConfigCount = lstConfigList.Count;
                    string[] configKeyValue;
                    NameValueCollection Objnvc = new NameValueCollection();
                    for (int i = 0; i < ConfigCount; i++)
                    {
                        configKeyValue = lstConfigList[i].ConfigValue.Split('^');
                        if (configKeyValue != null & configKeyValue.Length == 2)
                        {
                            Objnvc.Add(configKeyValue[0], configKeyValue[1]);
                        }
                    }
                    for (int j = 0; j < Objnvc.Count; j++)
                    {
                        switch (Objnvc.GetKey(j))
                        {
                            case "Print_LineItem_Limit":
                                intLimit = Convert.ToInt32(Objnvc[j]) == 0 ? intLimit : Convert.ToInt32(Objnvc[j]);
                                break;
                            case "Print_Char_Limit":
                                strChatLimit = Convert.ToInt32(Objnvc[j]) == 0 ? strChatLimit : Convert.ToInt32(Objnvc[j]);
                                break;
                            case "Line_Footer_Limit":
                                LineFooterLimit = Convert.ToInt32(Objnvc[j]) == 0 ? LineFooterLimit : Convert.ToInt32(Objnvc[j]);
                                break;
                        }

                    }
                    //new GateWay().GetBillConfigDetails(iBillGroupID, "Print_LineItem_Limit", OrgID, ILocationID, out lstConfig);
                    //if (lstConfig.Count > 0)
                    //{
                    //    intLimit = Convert.ToInt32(lstConfig[0].ConfigValue) == 0 ? intLimit : Convert.ToInt32(lstConfig[0].ConfigValue);
                    //}
                    //new GateWay().GetBillConfigDetails(iBillGroupID, "Print_Char_Limit", OrgID, ILocationID, out lstConfig);
                    //if (lstConfig.Count > 0)
                    //{
                    //    strChatLimit = Convert.ToInt32(lstConfig[0].ConfigValue) == 0 ? strChatLimit : Convert.ToInt32(lstConfig[0].ConfigValue);
                    //}
                    // new GateWay().GetBillConfigDetails(iBillGroupID, "Line_Footer_Limit", OrgID, ILocationID, out lstConfig);
                    //if (lstConfig.Count > 0)
                    //{
                    //    LineFooterLimit = Convert.ToInt32(lstConfig[0].ConfigValue) == 0 ? LineFooterLimit : Convert.ToInt32(lstConfig[0].ConfigValue);
                    //}



                    StringBuilder objprint = new StringBuilder();
                    string TPAAttributess = (lstPatientDetails[0].TPAAttributes == null) ? "" : lstPatientDetails[0].TPAAttributes;
                    string TPAName = lstPatientDetails[0].TPAName.ToString();
                    string tpa = string.Empty;
                    string refphyName = lblPhysician.Text;

                    if (TPAAttributess != "" || TPAName != "")
                    {
                        tpa = strclient + (TPAAttributess + TPAName);
                    }

                    if (refphyName != "")
                    {
                        refphyName = strphyname + lblPhysician.Text;
                    }
                    if (pdp == 1)
                        lblTypeBill.Text = lblTypeBill.Text + "( Duplicate Copy)";


                    PrinterHelper.PrintStartAndEnd(ref objprint, "S");

                    objprint.Append("<table id='tblBill' width=100% border=0 cellspacing=0 cellpading=0>" +
                             "<tr>" +
                                "<td height=15 colspan=5 width=10% id='tdDisplay' align=center style=font-weight:bold;>" + lblTypeBill.Text + "</td>" +
                            "</tr> </table>");

                    PrinterHelper.PrintOPPatientDetails(ref objprint, lstPatientDetails[0].Name, lstPatientDetails[0].Age + "/" + lstPatientDetails[0].SEX, lstFinalBillDetail[0].BillNumber.ToString(), lstFinalBillDetail[0].CreatedAt.ToString(), lstPatientDetails[0].PatientNumber, lstBillingDetail[0].LabNo.ToString());

                    objprint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0>" +
                            "<tr>" +
                               "<td colspan=3 width=10%>" + refphyName + "</td>" +
                           "</tr>" +
                           "<tr>" +
                               "<td colspan=3 width=10%>" + tpa + "</td>" +
                           "</tr>"
                           + "</table>");
                    objprint.Append("<table  width=100% border=0 cellspacing=1 cellpading=1>" +
                            "<tr style=font-weight:bold;>" +
                               "<td width=10%>S.NO</td>" +
                               "<td width=50%>Description</td>" +

                               "<td width=20% align=right>Units </td>" +
                               "<td width=20% align=right>Amount </td>" +
                           "</tr> ");
                    string ItemValues = "";
                    int breakLineCount = 0;
                    string perPrintTest = "";
                    int tempLineItem = 0;
                    int pageNo = 1;
                    bool isFooterBreak = true;
                    int LastPageLimit = 0;
                    int NoPages = 0;
                    NoPages = Math.DivRem(lstBillingDetail.Count, intLimit, out LastPageLimit);

                    foreach (BillingDetails item in lstBillingDetail)
                    {
                        intCnt = intCnt + 1;
                        ItemValues = item.FeeDescription.ToWordWrap(strChatLimit, out breakLineCount);
                        if ((intLines + breakLineCount) > intLimit && breakLineCount != intLimit)
                        {
                            perPrintTest = "<tr>" +
                               "<td width=10%>" + intCnt + "</td>" +
                               "<td width=50%>" + ItemValues + "</td>" +

                               "<td width=20% align=right>" + item.Quantity + " </td>" +
                               "<td width=20% align=right>" + item.Amount.ToString("0.00") + " </td>" +
                           "</tr>";
                        }
                        else
                        {
                            objprint.Append("<tr>" +
                                "<td width=10%>" + intCnt + "</td>" +
                                "<td width=50%>" + ItemValues + "</td>" +

                                "<td width=20% align=right>" + item.Quantity + " </td>" +
                                "<td width=20% align=right>" + item.Amount.ToString("0.00") + " </td>" +
                            "</tr>");
                        }
                        if (intCnt != lstBillingDetails.Count || perPrintTest != "")
                        {
                            intLines = (intLines + breakLineCount) == intLimit ? (intLines + breakLineCount) + 1 : (intLines + breakLineCount);
                        }

                        if (isFooterBreak != false && LastPageLimit > 0 && LastPageLimit <= LineFooterLimit)
                        {
                            isFooterBreak = false;
                        }

                        if (intLines > intLimit)
                        {
                            if (intCnt <= lstBillingDetail.Count)
                            {
                                pageNo = pageNo + 1;
                                objprint.Append("</table><p style=\"page-break-before:always\"></p>");
                                objprint.Append("<table  width=100% border=0 cellspacing=2 cellpading=2>" +
                                            "<tr>" + "<td align=center>(" + pageNo + ")</td>" + "</tr> </table>");
                                PrinterHelper.PrintOPPatientDetails(ref objprint, lstPatientDetails[0].Name, lstPatientDetails[0].Age + "/" + lstPatientDetails[0].SEX, lstFinalBillDetail[0].BillNumber.ToString(), lstFinalBillDetail[0].CreatedAt.ToString(), lstPatientDetails[0].PatientNumber, lstBillingDetail[0].LabNo.ToString());
                                tempLineItem = intLines;
                                intLines = 0;
                                objprint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0>" +
                            "<tr>" +
                               "<td height=30 colspan=3 width=10%>&nbsp;</td>" +

                           "</tr> </table>" +
                           "<table  width=100% border=0 cellspacing=1 cellpading=1>" +
                             "<tr style=font-weight:bold;>" +
                                "<td width=10%>S.no</td>" +
                                "<td width=50%>Description</td>" +

                                "<td width=20% align=right>Quantity </td>" +
                                "<td width=20% align=right>Amount </td>" +
                            "</tr> "
                           );
                                if (perPrintTest != "")
                                {
                                    intLines = breakLineCount;
                                    objprint.Append(perPrintTest);
                                    perPrintTest = "";

                                }
                            }
                        }
                    }
                    objprint.Append("</table>");
                    if (isFooterBreak)
                    {
                        pageNo = pageNo + 1;
                        objprint.Append("<p style=\"page-break-before:always\"></p>");
                        objprint.Append("<table  width=100% border=0 cellspacing=2 cellpading=2>" +
                                    "<tr>" + "<td align=center>(" + pageNo + ")</td>" + "</tr> </table>");
                        PrinterHelper.PrintOPPatientDetails(ref objprint, lstPatientDetails[0].Name, lstPatientDetails[0].Age + "/" + lstPatientDetails[0].SEX, lstFinalBillDetail[0].BillNumber.ToString(), lstFinalBillDetail[0].CreatedAt.ToString(), lstPatientDetails[0].PatientNumber, lstBillingDetail[0].LabNo.ToString());
                    }
                    decimal NetValue = lstFinalBillDetail[0].NetValue;
                    string RecAmount;
                    if (hdnIsRoundOff.Value == "ON")
                    {
                        RecAmount = String.Format("{0:0.00}", Math.Round(lstFinalBillDetail[0].AmountReceived));
                    }
                    else
                    {
                        RecAmount = String.Format("{0:0.00}", (lstFinalBillDetail[0].AmountReceived));
                    }
                    string pUser = "";
                    string paymode = lblPaymentMode.Text;
                    string grossbill = String.Format("{0:0.00}", lstFinalBillDetail[0].GrossBillValue);
                    string AmtResceived = lblDisplayAmount.Text + lblAmount.Text;
                    string PayingCurrency = lblPayingCurrency.Text + lblPayingCurrencyinWords.Text;
                    string Dueamounttxt = lblDueAmountinWords.Text;
                    string Dueamt = lblDueAmount.Text;
                    string RemainDepo = RemainDeposit.Text;
                    if (lstBillingDetail.Count > 0)
                    {
                        pUser = strbill + (" + lstBillingDetail[0].BilledBy.ToUpper() + ");
                    }


                    PrinterHelper.PrintOPAmountDetails(ref objprint, NetValue.ToString(), RecAmount, grossbill, paymode,
                        (lblTaxAmount.Text).ToString(), (lblDiscount.Text).ToString(),
                        (lblRoundOff.Text).ToString(), (lblServiceCharge.Text).ToString(),
                    discountpercent, lblCurrentVisitDueText.Text, lblNetValue.Text, AmtResceived,
                    PayingCurrency, pUser, Dueamounttxt, Dueamt, RemainDepo, depamt.ToString());

                    PrinterHelper.PrintStartAndEnd(ref objprint, "E");
                    tdPrint.InnerHtml = objprint.ToString();
                }
                #endregion

                /////sample print
                string IsBillWithBarcode = string.Empty;
                IsBillWithBarcode = GetConfigValue("PrintBillBarcode", OrgID);
                if (IsBillWithBarcode == "Y")
                {
                    List<String> lstQueryString = new List<String>();
                    BarcodeHelper objBarcodeHelper = new BarcodeHelper();
                    returnCode = objBarcodeHelper.GetBarcodeQueryString(OrgID, Convert.ToString(visitID), string.Empty, FinalbillID, BarcodeCategory.Bill, out lstQueryString);
                    if (lstQueryString.Count > 0)
                    {
                        foreach (String queryString in lstQueryString)
                        {
                            imgBarcode.ImageUrl = "../admin/BarcodeHandler.ashx?" + queryString;
                        }
                        tdBarcode.Visible = true;
                        tblPatientDetails.ColSpan = 5;
                    }
                    else
                    {
                        tdBarcode.Visible = false;
                    }
                }
                else
                {
                    tdBarcode.Visible = false;
                }
                if (SuburbanPrintFormat != "Y")
                {
                    if (lblLabNo.Text == "")
                    {
                       // trLabNo.Style.Add("display", "none");
                       // trLabNo1.Style.Add("display", "none");

                    }
                }
            }

            else
            {
                //ErrorDisplay1.ShowError = true;
                //ErrorDisplay1.Status = "There is no Bill for this Patient";
                tblGBillPrint.Visible = false;
            }

            //long LoginID = 3279;
            string patient_port;
            patient_port = GetConfigValue("Remove Bill Patient Port", OrgID);
            if (patient_port == "Y")
            {



                //commented & changed by arivalagn.kk//
                //lblUserName.Visible = false;
                //lblLoginName.Visible = false;
                tdUserName.Style.Add("dispay", "none");

                lblPass.Visible = false;
                lblPassword.Visible = false;
                lblURL.Visible = false;
                lblLoginurl.Visible = false;

            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get bill details for printing in Bill Printing page", ex);
        }
    }
    public string getprinter()
    {
        return tdPrint.InnerHtml;
    }
    protected void gvBillingDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //Co-payment//
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label label1 = e.Row.FindControl("lblhsn") as Label;
            label1.Text = HSNSAC_No.ToString();
        }
        if (e.Row.RowType == DataControlRowType.Header || e.Row.RowType == DataControlRowType.DataRow)
        {

            if (hdncopayamount.Value != null && hdncopayamount.Value != "")
            {
                e.Row.Cells[5].Visible = false;
            }
            // end Co-payment//
        }
        else
        {
            GateWay gateWay = new GateWay();
            List<Config> lstConfig = new List<Config>();
            long returnCode = gateWay.GetConfigDetails("Amount(Rs)", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                if (lstConfig[0].ConfigValue.ToUpper() == "Y")
                {
                    Amount = "Amount(Rs)";
                }

            }
            if (e.Row.RowType == DataControlRowType.Header)
            {
                if (Amount == "Amount(Rs)")
                {
                    e.Row.Cells[5].Text = "Amount(Rs)";
                }
                else
                {
                    e.Row.Cells[5].Text = "Amount";
                }
            }
        }
        //gvBillingDetail.GridLines = GridLines.Horizontal;
        //foreach (TableCell tc in e.Row.Cells)
        //{
        //    tc.Attributes["style"] = "border-color: #c3cecc";
        //}



    }

    public List<BillingDetails> AddConsultantDGEHS(List<BillingDetails> lstdetails)
    {

        List<BillingDetails> lstdet = lstdetails;

        int count = lstdetails.Count;
        for (int i = 0; i < count; i++)
        {
            if (lstdetails[i].FeeType == "CON")
            {
                decimal Quantitycount;
                Quantitycount = lstdetails[i].Quantity;
                BillingDetails lstitem1;
                for (int j = 0; j < Quantitycount; j++)
                {
                    lstitem1 = new BillingDetails();
                    lstitem1.FeeDescription = "CONSULTATION 1st Visit - CGHS  S.NO - 1.4.2(By Specialist)";
                    lstitem1.Amount = 61.00m;
                    lstitem1.Quantity = 1.00m;
                    lstdet.Add(lstitem1);
                    lstitem1 = null;
                    //
                    lstitem1 = new BillingDetails();
                    lstitem1.FeeDescription = "REFRACTION - CGHS  S.NO - 4.6";
                    lstitem1.Amount = 81.00m;
                    lstitem1.Quantity = 1.00m;
                    lstdet.Add(lstitem1);
                    lstitem1 = null;
                    //

                }
            }
        }
        return lstdet;
    }
    public List<BillingDetails> AddConsultantCGHS(List<BillingDetails> lstdetails)
    {

        List<BillingDetails> lstdet = lstdetails;

        int count = lstdetails.Count;
        for (int i = 0; i < count; i++)
        {
            if (lstdetails[i].FeeType == "CON")
            {
                decimal Quantitycount;
                Quantitycount = lstdetails[i].Quantity;
                BillingDetails lstitem1;
                for (int j = 0; j < Quantitycount; j++)
                {
                    lstitem1 = new BillingDetails();
                    lstitem1.FeeDescription = "CONSULTATION - CGHS  S.NO - 50";
                    lstitem1.Amount = 50.00m;
                    lstitem1.Quantity = 1.00m;
                    lstdet.Add(lstitem1);
                    lstitem1 = null;
                    //
                    lstitem1 = new BillingDetails();
                    lstitem1.FeeDescription = "REFRACTION - CGHS  S.NO - 63";
                    lstitem1.Amount = 36.00m;
                    lstitem1.Quantity = 1.00m;
                    lstdet.Add(lstitem1);
                    lstitem1 = null;
                    //
                    lstitem1 = new BillingDetails();
                    lstitem1.FeeDescription = "NCT - CGHS  S.NO - 50";
                    lstitem1.Amount = 50.00m;
                    lstitem1.Quantity = 1.00m;
                    lstdet.Add(lstitem1);
                    decimal amt;
                    amt = lstdetails[i].Amount / lstdetails[i].Quantity;
                    if (amt == 226)
                    {
                        lstitem1 = null;
                        //
                        lstitem1 = new BillingDetails();
                        lstitem1.FeeDescription = "INDIRECT OPTHALMOSCOPE - CGHS  S.NO - 64";
                        lstitem1.Amount = 90.00m;
                        lstitem1.Quantity = 1.00m;
                        lstdet.Add(lstitem1);
                    }
                }
            }
        }
        return lstdet;
    }
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay();
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
    public void GetUserImage(long logID)
    {
        long returnCode = -1;
        Attune.Podium.BusinessEntities.Login login = new Attune.Podium.BusinessEntities.Login();
        Role_BL roleBL = new Role_BL();
        returnCode = roleBL.GetUserImage(OrgID, logID, out login);
        byte[] byteArray = login.ImageSource;
        if (byteArray != null && byteArray.Count() > 0)
        {
            imgView.Visible = true;
            imgView.Src = "~/Admin/UserImageHandler.ashx?OrgID=" + OrgID + "&LoginID=" + logID;
        }
        else
        {
            imgView.Visible = false;
        }
    }

}
