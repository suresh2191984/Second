
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

public partial class CommonControls_Uniscanbillprint : BaseControl
{
    string SuburbanPrintFormat = string.Empty;
    string Amount = string.Empty;
    int intLines = 0;
    int intLimit = 5;
    int intCnt = 0;
    int strChatLimit = 35;
    public bool isDynamicPrint { get; set; }
    int LineFooterLimit = 3;
    List<Config> lstConfigList = new List<Config>();
    public string IsFullBill { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        string Logoright = string.Empty;
        Logoright = GetConfigValue("logoRight", OrgID);

        string Logohide = string.Empty;
        Logohide = GetConfigValue("logoHide_Anj", OrgID);
        if (!Page.IsPostBack)
        {
            //RemainDeposit.Visible = false;
            //lblHospitalName.InnerHtml = OrgName+"<br/>";            
            #region Commented code
            List<Config> lstConfig = new List<Config>();
            int iBillGroupID = 0;
            iBillGroupID = (int)ReportType.OPBill;
            
            string BillHeader = string.Empty;
            BillHeader = GetConfigValue("Bill Header Content", OrgID);
           
            if (BillHeader == "Y")
            {
            new GateWay().GetBillConfigDetails(iBillGroupID, "Header Logo", OrgID, ILocationID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                //tblBillPrint1.Style.Add("background-image", "url('" + lstConfig[0].ConfigValue.Trim() + "'); ");
                imgBillLogo.ImageUrl = lstConfig[0].ConfigValue.Trim();
                imglogo2.ImageUrl = lstConfig[0].ConfigValue.Trim();
              
                if (lstConfig[0].ConfigValue.Trim() != "")
                {
                    if (Logohide == "Y")
                    {
                        imgBillLogo.Visible = false;
                        imglogo2.Visible = false;
                    }
                    else
                    {
                    if (Logoright == "Y")
                    {
                        imgBillLogo.Visible = false;
                        tdlogoleft.Visible = true;
                        imglogo2.Visible = true;
                        tdBarcode.Visible = false;
                        
                        //tdBarcode.Style.Add("display", "none");
                       // tdlogoleft.Style.Add("display", "none");
                    }
                    else
                    {
                        tdBarcode.Visible = true;
                        tdlogoleft.Visible = true;
                        imgBillLogo.Visible = true;
                        imglogo2.Visible = false;
                        }
                    }
                }
                else
                {
                    imgBillLogo.Visible = false;
                    imglogo2.Visible = false;
                }
            }
            else
            {
                imgBillLogo.Visible = false;
                imglogo2.Visible = true;
            }

                 
            //new GateWay().GetBillConfigDetails(iBillGroupID, "Header Font", OrgID, ILocationID, out lstConfig);

            //if (lstConfig.Count > 0)
            //{
            //    lblHospitalName.Style.Add("font-family", lstConfig[0].ConfigValue.Trim());
            //}

            //new GateWay().GetBillConfigDetails(iBillGroupID, "Header Font Size", OrgID, ILocationID, out lstConfig);

            //if (lstConfig.Count > 0)
            //{
            //    lblHospitalName.Style.Add("font-size", lstConfig[0].ConfigValue.Trim());
            //}
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
                tblBillPrint1.Style.Add("font-family", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay().GetBillConfigDetails(iBillGroupID, "Contents Font Size", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint1.Style.Add("font-size", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay().GetBillConfigDetails(iBillGroupID, "Border Style", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint1.Style.Add("border-style", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay().GetBillConfigDetails(iBillGroupID, "Border Width", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint1.Width = lstConfig[0].ConfigValue.Trim();
            }

            }

            new GateWay().GetBillConfigDetails(iBillGroupID, "Footercontent", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                lblfooter.InnerHtml = lstConfig[0].ConfigValue.Trim().Replace(",,,,", ",");
                lblfooter.InnerHtml = lblfooter.InnerHtml.Replace(",,,", ",");
                lblfooter.InnerHtml = lblfooter.InnerHtml.Replace(",,", ",");
            }
 
            new GateWay().GetBillConfigDetails(iBillGroupID, "Contents Font", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint1.Style.Add("font-family", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay().GetBillConfigDetails(iBillGroupID, "Contents Font Size", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint1.Style.Add("font-size", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay().GetBillConfigDetails(iBillGroupID, "Border Style", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint1.Style.Add("border-style", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay().GetBillConfigDetails(iBillGroupID, "Border Width", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint1.Width = lstConfig[0].ConfigValue.Trim();
            }


       new GateWay().GetBillConfigDetails(iBillGroupID, "Contents Font", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint1.Style.Add("font-family", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay().GetBillConfigDetails(iBillGroupID, "Contents Font Size", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint1.Style.Add("font-size", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay().GetBillConfigDetails(iBillGroupID, "Border Style", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint1.Style.Add("border-style", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay().GetBillConfigDetails(iBillGroupID, "Border Width", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint1.Width = lstConfig[0].ConfigValue.Trim();
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
                        //imglogo2.ImageUrl = oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt];

                        if (imgBillLogo.ImageUrl.Length > 0)
                        {
                            imgBillLogo.Visible = true;
                           // imglogo2.Visible = true;
                            break;
                        }

                        else
                        {
                            imgBillLogo.Visible = false;
                           // imglogo2.Visible = false;
                            break;
                        }
                //case "Header Font":
                //    //lblHospitalName.Style.Add("font-family", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                //    break;
                //case "Header Font Size":
                //    //lblHospitalName.Style.Add("font-size", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                //    break;
                //case "Header Content":
                //    //lblHospitalName.InnerHtml = oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt];
                //    break;
                case "Contents Font":
                    tblBillPrint1.Style.Add("font-family", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Contents Font Size":
                    tblBillPrint1.Style.Add("font-size", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Border Style":
                    tblBillPrint1.Style.Add("border-style", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Border Width":
                    tblBillPrint1.Width = oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt];
                    break;
                default:
                    break;
            }
        }
    }
    #endregion

    public void BillPrinting(long visitID, long FinalbillID, int pdp)
    {
        try
        {
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
            }
            BillingEngine billingBL = new BillingEngine(base.ContextInfo);
            billingBL.GetBillPrintingDetails(visitID, out lstBillingDetail,
                                            out lstFinalBillDetail, out lstPatientDetails,
                                            out lstOrganization, out physicianName,
                                            out lstDuePaidDetails, FinalbillID, out lstTax, out splitstatus, out lstQualification);
            List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
            billingBL.pGetRefundBillingDetails(visitID, out lstBillingDetails, out amtReceived, out amtRefunded, out dChequeAmount, FinalbillID, 0);
            if ((lstBillingDetail != null && lstBillingDetail.Count > 0 && lstBillingDetail[0].LabNo != "" && lstBillingDetail[0].LabNo != "0" && lstBillingDetail[0].LabNo != "-1"))
            {
                trLabNo.Visible = true;
                trLabNo1.Visible = true;
                trLabNo2.Visible = true;
                lblLabNo.Text = lstBillingDetail[0].LabNo.ToString();
            }
            else
            {
                trLabNo.Visible = false;
                trLabNo1.Visible = false;
                trLabNo2.Visible = false;
            }

            if (LabNo != null)
            {
                trLabNo.Visible = true;
                trLabNo1.Visible = true;
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
                lblrefundamt.Text = "Amount Refunded to the patient: Rs." + amtRefunded.ToString() + " Only";
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

                    gvBillingDetail1.DataSource = lstdayOP;
                    gvBillingDetail1.DataBind();

                }
                else if (splitstatus == "DGEHS OP" && OrgID == 82)
                {
                    List<BillingDetails> lstTemp = new List<BillingDetails>();
                    lstTemp = AddConsultantDGEHS(lstBillingDetail);
                    var lstdayOP = (from lst in lstTemp
                                    where lst.FeeType.Trim() != "CON"
                                    select lst);

                    gvBillingDetail1.DataSource = lstdayOP;
                    gvBillingDetail1.DataBind();

                }
                else
                {

                    gvBillingDetail1.DataSource = lstBillingDetail;
                    gvBillingDetail1.DataBind();
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
                    gvBillingDetail1.Columns[2].Visible = true;
                }
                else
                {
                    gvBillingDetail1.Columns[2].Visible = false;
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
                    gvBillingDetail1.Columns[3].Visible = false;
                }
                else
                {
                    gvBillingDetail1.Columns[3].Visible = true;
                }


                lblName.Text = lstPatientDetails[0].Name;
                lblTitleName.Text = lstPatientDetails[0].TitleName;
                lblPatientNumber.Text = lstPatientDetails[0].PatientNumber.ToString();
                if(lstPatientDetails[0].EMail.Contains(","))
                {
                lblEmail.Text = lstPatientDetails[0].EMail.Replace(",",", ");
                }
                else
                {
                lblEmail.Text=lstPatientDetails[0].EMail.ToString();
                } 

                if (lstPatientDetails[0].SEX == "M")
                    lblSex.Text = "Male";
                else if (lstPatientDetails[0].SEX == "F")
                    lblSex.Text = "Female";
                else if (lstPatientDetails[0].SEX == "U")
                    lblSex.Text = "UnKnown";
                else
                    lblSex.Text = "";
                if (lstPatientDetails[0].MobileNumber != "")
                    lblPatPhoneNumber.Text = lstPatientDetails[0].MobileNumber;
                if (SuburbanPrintFormat == "Y")
                {
                    Rs_PatPhoneNo.Text = "Contact No";
                    lblPhy.Text = "Ref Doctor";
                    //lblRefHos.Text = "Ref Centre";
                }
               // string TPAName = string.Empty;


                //if (TPAName != "")
                //{
                //    lblTpaName.Text = TPAName;
                //    //tpaName = TPAName;
                //    lblTpaText1.Style.Add("font-size", "11px");
                //    lblTpaText1.Style.Add("font-weight", "700");
                //    lblTpaText1.Style.Add("font-weight", "Bold");
                //    lblTpaName.Style.Add("font-size", "11px");
                //    lblTpaName.Style.Add("font-weight", "700");

                //}


                //if (lstPatientDetails[0].ReferedHospitalName != "")
                //{
                //    //lblRefHos.Visible = true;
                //    //lblReferringHos.Visible = true;
                //    lblReferringHos.Text = lstPatientDetails[0].ReferedHospitalName;
                //    //tdReferringHos.InnerText = ":";
                //}
                //else
                //{
                //    lblRefHos.Visible = false;
                //    lblReferringHos.Visible = false;
                //    tdReferringHos.InnerText = "";
                //}
                if (lstPatientDetails[0].VersionNo.ToString() != "")
                {
                    lblVisitNumber.Visible = true;
                    Rs_VisitNumber.Visible = true;
                    if (SuburbanPrintFormat == "Y")
                    {
                        trLabNo.Visible = true;
                        trLabNo1.Visible = true;
                        trLabNo2.Visible = true;
                        //lLabNo.Visible = false;
                        lblLabNo.Visible = false;
                        //lLabNo.Text = "";
                        lblLabNo.Text = "";
                        Rs_VisitNumber.Text = "Visit No";
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
                if (lblSex.Text == "UnKnown" && lblAge.Text.Contains("UnKnown"))
                {
                    lblAge.Text = "UnKnown";
                    lblSex.Text = "";
                }
               
                IsFullBill = lstFinalBillDetail[0].VersionNo;

                //if (lstPatientDetails[0].PriorityID != "" && lstPatientDetails[0].PriorityID != null)
                //{
                //    if (lstPatientDetails[0].PriorityID.ToString() == "1")
                //    {
                //        lblpriority.Text = "Normal";
                //    }
                //    else if (lstPatientDetails[0].PriorityID.ToString() == "2")
                //    {
                //        lblpriority.Text = "Emergency";
                //    }

                //    else
                //    {
                //        lblpriority.Text = "VIP";
                //    }
                //}
                //else
                //{
                //    lblpriority.Text = "Normal";
                //}
                lblpatientHistory.Text = lstPatientDetails[0].Add1.ToString();
                //lblPatientaddress.Text = lstOrganization[0].Add1.ToString();
             //   lblModetype.Text = lstPatientDetails[0].DispatchType.ToString();
                //lblPickupdate.Text = lstPatientDetails[0].SamplePickupDate.ToString("dd/MMM/yyyy");

                //lblDoB.Text = lstPatientDetails[0].DOB.ToShortDateString();


                // Bind Final Bill detail

                 lblInvoiceNo0.Text = lstFinalBillDetail[0].BillNumber.ToString().Trim();

                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                new GateWay().GetInventoryConfigDetails("ShowDate_WithTime_BillPrint_Ascx", OrgID, ILocationID, out lstInventoryConfig);

                if (lstInventoryConfig.Count > 0 && lstInventoryConfig[0].ConfigValue == "Y")
                {
                    lblInvoiceDate.Text = lstFinalBillDetail[0].CreatedAt.ToString("dd/MMM/yy hh:mm tt");
                }
                else
                {
                    lblInvoiceDate.Text = lstFinalBillDetail[0].CreatedAt.ToString("dd/MMM/yyyy hh:mm tt ");
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
                if (IsFullBill == "Y")
                {

                   // Rs_VisitNumber.Visible = false;
                    trLabNo.Visible = true;
                    trLabNo2.Visible = true;
                    
                    lblInvoiceNo0.Text = lstBillingDetail[0].AttributeDetail.ToString();
                   
                 
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
                    trLabNo.Visible = true;
                    Rs_VisitNumber.Visible = true;
                    Rs_VisitNumber.Text = "Visit No";
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
                    trDiscount.Attributes.Add("display", "block");
                    lblDiscount.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].DiscountAmount);
                    hdnDiscount.Value = "1";
                }
                if (lstFinalBillDetail[0].EDCess > 0)
                {
                    trEDCess.Attributes.Add("display", "block");
                    lblEDCess.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].EDCess);
                    hdnEDCess.Value = "1";
                }
                if (lstFinalBillDetail[0].SHEDCess > 0)
                {
                    trSHEDCess.Attributes.Add("display", "block");
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

                    trServiceCharge.Attributes.Add("visibility", "visible");
                    lblServiceCharge.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].ServiceCharge);
                    hdnServiceCharge.Value = "1";
                }
                if (lstFinalBillDetail[0].TaxAmount > 0)
                {
                    trServiceCharge.Attributes.Add("visibility", "visible");
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
                    trRoundoff.Attributes.Add("display", "block");
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
                if (lstFinalBillDetail[0].Due > lstBillingDetail[0].WriteOffAmt)
                {
                    if (lstFinalBillDetail[0].Due > 0)
                    {
                        trDiscount.Attributes.Add("display", "block");
                        string DueAmmt = String.Format("{0:0.00}", lstFinalBillDetail[0].Due);
                        lblCurrentVisitDueText.Text = (DueAmmt);
                        hdnDue.Value = "1";
                    }
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
                    //lblAmount.Attributes.Add("display", "none");


                }
                //List<Config> lstConfig = new List<Config>();
                //GateWay gateWay = new GateWay();
                returnCode = gateWay.GetConfigDetails("DisplayCurrencyFormat", OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                {
                    lblDisplayAmount.Text = "Amount in words: (" + lstConfig[0].ConfigValue.ToString() + ") ";
                    lblDueAmountinWords.Text = "Due Amount in Words: (" + lstConfig[0].ConfigValue.ToString() + ") ";
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
                    lblDisplayAmount.Text = "Amount Received in Words: (" + CurrencyName + ") ";
                    lblDueAmountinWords.Text = "Due Amount in Words: (" + CurrencyName + ") ";
                }
                if (lblCurrentVisitDueText.Text != "")
                {
                    if (Convert.ToDouble(lblCurrentVisitDueText.Text) > 0)
                    {
                        if (int.Parse(lblCurrentVisitDueText.Text.Split('.')[1]) > 0)
                        {
                            lblDueAmount.Text = Utilities.FormatNumber2Word(num.Convert(lblCurrentVisitDueText.Text)) + " " + MinorCurrencyName + " Only";
                            lblDueAmountinWords.Text = lblDueAmountinWords.Text + " " + Utilities.FormatNumber2Word(num.Convert(lblCurrentVisitDueText.Text)) + " " + MinorCurrencyName + " Only";
                        }
                        else
                        {
                            lblDueAmount.Text = lblDueAmountinWords.Text + "  " + num.Convert(lblCurrentVisitDueText.Text) + " Only";
                            lblDueAmountinWords.Text = lblDueAmountinWords.Text + " " + num.Convert(lblCurrentVisitDueText.Text) + " Only";
                        }
                    }
                    if (lblCurrentVisitDueText.Text == "")
                    {
                        lblDueAmount.Attributes.Add("display", "none");
                        lblDueAmountinWords.Attributes.Add("display", "none");
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
                    TRDueAmt.Visible = false;
                }
                else if (lstFinalBillDetail[0].IsCreditBill != "Y" && (lblCurrentVisitDueText.Text != "0.00" && lblCurrentVisitDueText.Text != ""))
                {
                    lblTypeBill.Text = "DUE BILL";
                }
                else
                {
                    lblTypeBill.Text = "PAID BILL";
                }
                if (lstFinalBillDetail[0].IsDiscountPercentage == "Y")
                {

                    decimal n;
                    n = (lstFinalBillDetail[0].DiscountAmount / (lstFinalBillDetail[0].TDS + lstFinalBillDetail[0].TaxPercent)) * 100;
                    if (hdnIsRoundOff.Value == "ON")
                    {
                        discountpercent = "(" + Math.Round(n) + "%)";
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
                billingBL.GetPaymentMode(FinalbillID, visitID, ReceiptNo, payingPage, out lstPaymentType, out lstOtherCurrency, out lstDepositAmt);
                if (lstPaymentType.Count > 0)
                {
                    //lblPayment.Visible = true;

                    int flag = 0;
                    for (int i = 0; i < lstPaymentType.Count; i++)
                    {
                        if (flag == 0)
                        {
                            //appString = lstPaymentType[i].PayDetails + "-"+lstOtherCurrency[0].CurrencyName+"<br>";
                            appString = lstPaymentType[i].PayDetails + "<br>";
                        }
                        else
                        {
                            //appString = appString + lstPaymentType[i].PayDetails + "-"+lstOtherCurrency[0].CurrencyName+"<br>";
                            appString = appString + lstPaymentType[i].PayDetails + "<br>";
                        }
                        flag++;

                    }
                }
                else
                {
                   // lblPayment.Visible = false;
                }
                if (lstDepositAmt.Count > 0)
                {
                    //trDeposit.Attributes.Add("display", "block");
                    //lblDepositAmtUsed.Visible = true;
                    //lblDepositAmtUsed.Text = "Deposit Amount Used - " + lstDepositAmt[0].AmountUsed.ToString("0.00");
                    depamt = lstDepositAmt[0].AmountUsed;
                    //lblPayment.Visible = true;
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
                        lblPayingCurrency.Text = "Paying Currency: (" + lstOtherCurrency[0].CurrencyName + ")";
                        //Label1.Text = "Remaining Deposit Amount : (" + lstOtherCurrency[0].CurrencyName + ")";

                        if (int.Parse(totothercuramt.ToString().Split('.')[1]) > 0)
                        {
                            lblPayingCurrencyinWords.Text = Utilities.FormatNumber2Word(num.Convert(totothercuramt.ToString())) + " " + MinorCurrencyName + " " + "Only";
                        }
                        else
                        {
                            lblPayingCurrencyinWords.Text = num.Convert(totothercuramt.ToString()) + "Only";
                        }
                        trPayingCurrency.Attributes.Add("display", "block");
                        hdnPayingCurrency.Value = "1";


                    }
                    else
                    {
                        hdnPayingCurrency.Value = "0";
                    }
                }
                //lblPaymentMode.Text = appString;
                //lblPayMode.InnerHtml = appString;

                #endregion
                string isUniscan = string.Empty;
                isUniscan = GetConfigValue("isUniscan", OrgID);
                if (isUniscan == "Y")
                {
                    trUniscan.Style.Add("display", "block");
                    trUniscan1.Style.Add("display", "block");
                    trUniscan2.Style.Add("display", "block");
                    trUniscan3.Style.Add("display", "block");
                }
                string isTATshow = string.Empty;
                isTATshow = GetConfigValue("isTATshow", OrgID);
                if (isTATshow == "N")
                {
                    trReportDate.Style.Add("display", "none");
                }
                else
                {
                    if (lstFinalBillDetail[0].TATDate > Convert.ToDateTime("01/01/1900"))
                    {
                        trReportDate.Style.Add("display", "block");
                        lblReportcommitDate.Text = "Date Of Delivery of Test Report  : " + lstFinalBillDetail[0].TATDate.ToString("dd/MMM/yyyy hh:mm:tt");

                    }
                    else
                    {
                        trReportDate.Style.Add("display", "none");
                    }
                }
                //lblBilledBy.Text = ("Billed By: (" + UserName + ")").ToUpper();

                lblBilledBy.Text = ("Billed By: (" + lstBillingDetail[0].BilledBy + ")").ToUpper();
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

                //lblNote.Text = "";
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
            //    tblBillPrint1.Visible = false;
	      lblTpaName1.Text = lstPatientDetails[0].TPAName;
                if (lstPatientDetails[0].TPAName == "GENERAL" || ClientTypeCode == "WAK" || ISCash == "Y")
                {
                    trAmountReceived.Style.Add("visibility", "visible");
                    TRAMTRcvd.Style.Add("display", "block");
                    lblTpaName1.Text = lstPatientDetails[0].TPAName;
             
                }
                //if (lblTpaName1.Text != "" || lblpatientHistory.Text != "" )
                //{
                //    if (lblTpaName1.Text != "GENERAL" || lblpatientHistory.Text != "")
                //    {
                //        tr2.Style.Add("display", "block");
                        if (lblTpaName1.Text == "GENERAL")
                        {
                            lblTpaName1.Visible = false;
                            //lblTpaText1.Visible = false;
                            //tdclient.Visible = false;
                           // tr2.Style.Add("display", "block");
                        
                        }
              //      }

                   
              //      //lblTpaName1.Visible = true;
              //      //lblTpaText1.Visible = true;
              //      //tdclient.Visible = true;
              //      //lblHistory.Visible = true;
              //      //tdhistory.Visible = true;
              //}
              //  //if (lblTpaName1.Text == "GENERAL")
                //{
                //    lblTpaName1.Visible = false;
                //}



                else
                {
                    trAmountReceived.Style.Add("visibility", "visible");
                    TRAMTRcvd.Style.Add("display", "none");
                }
                if (lstPatientDetails[0].TPAName != "" && lstPatientDetails[0].TPAName != null)
                {
                    if (SuburbanPrintFormat == "Y" && lstPatientDetails[0].TPAName == "GENERAL")
                    {
                        trFinalBillHeader.Attributes.Add("style", "display:none");
                    }
                    else
                    {
                        trFinalBillHeader.Attributes.Add("style", "display:block");
                        
                       // FinalBillHeader1.SetAttribute(lstPatientDetails[0].TPAAttributes, lstPatientDetails[0].TPAName);

                        trDue.Style.Add("visibility", "hidden");
                        hdnCleintFlag.Value = "Y";
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
                        tpa = "Client Name:" + (TPAAttributess + TPAName);
                    }

                    if (refphyName != "")
                    {
                        refphyName = "Ref. Physician Name:" + lblPhysician.Text;
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
                    //string paymode = lblPaymentMode.Text;
                    string grossbill = String.Format("{0:0.00}", lstFinalBillDetail[0].GrossBillValue);
                    string AmtResceived = lblDisplayAmount.Text + lblAmount.Text;
                    string PayingCurrency = lblPayingCurrency.Text + lblPayingCurrencyinWords.Text;
                    string Dueamounttxt = lblDueAmountinWords.Text;
                    string Dueamt = lblDueAmount.Text;
                    string RemainDepo = RemainDeposit.Text;
                    if (lstBillingDetail.Count > 0)
                    {
                        pUser = "Billed By: (" + lstBillingDetail[0].BilledBy.ToUpper() + ")";
                    }


                    PrinterHelper.PrintOPAmountDetails(ref objprint, NetValue.ToString(), RecAmount, grossbill, "",
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
                        string qString = string.Empty;
                        foreach (String queryString in lstQueryString)
                        {
                            qString = queryString + "&isvertical=false";
                            imgBarcode.ImageUrl = "../admin/BarcodeHandler.ashx?" + qString;
                        }
                        tdBarcode.Visible = true;
                        tblPatientDetails1.ColSpan = 5;
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
                        trLabNo.Style.Add("display", "none");
                        trLabNo1.Style.Add("display", "none");

                    }
                }
            }

            else
            {
                //ErrorDisplay1.ShowError = true;
                //ErrorDisplay1.Status = "There is no Bill for this Patient";
                tblBillPrint1.Visible = false;
            }

            //long LoginID = 3279;



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
    protected void gvBillingDetail1_RowDataBound(object sender, GridViewRowEventArgs e)
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
