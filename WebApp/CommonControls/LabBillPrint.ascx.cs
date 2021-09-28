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

public partial class CommonControls_LabBillPrint : BaseControl
{
    string Amount = string.Empty;
    int intLines = 0;
    int intLimit = 5;
    int intCnt = 0;
    int strChatLimit = 35;
    public bool isDynamicPrint { get; set; }
    int LineFooterLimit = 3;
    List<Config> lstConfigList = new List<Config>();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    #region LoadBillConfigMetadata
    public void LoadBillConfigMetadata(int OrgID, long OrgAddressID)
    {
        //List<Config> lstConfig = new List<Config>();
        int iBillGroupID = 0;
        iBillGroupID = (int)ReportType.OPBill;
        if (lstConfigList.Count == 0)
        {
            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "", OrgID, OrgAddressID, out lstConfigList);
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
                    tblBillPrint.Style.Add("font-family", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Contents Font Size":
                    tblBillPrint.Style.Add("font-size", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Border Style":
                    tblBillPrint.Style.Add("border-style", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Border Width":
                    tblBillPrint.Width = oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt];
                    break;
                default:
                    break;
            }
        }
    }
    #endregion


    public string getprinter()
    {
        return tdPrint.InnerHtml;
    }


    List<BillingDetails> lstBillingDetail = new List<BillingDetails>();
    public void LABBillPrinting(long visitID, long FinalbillID, int pdp, string lstSampleIds)
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
            
            List<FinalBill> lstFinalBillDetail = new List<FinalBill>();
            List<Patient> lstPatientDetails = new List<Patient>();
            List<Organization> lstOrganization = new List<Organization>();
            List<DuePaidDetail> lstDuePaidDetails = new List<DuePaidDetail>();
            List<Taxmaster> lstTax = new List<Taxmaster>();
            List<OrderedInvestigations> lstOrderInv = new List<OrderedInvestigations>();
            BillingEngine billingBL = new BillingEngine(base.ContextInfo);
            billingBL.GetvisitBillingInvestigationandDept(visitID, out lstBillingDetail,
                                            out lstFinalBillDetail, out lstPatientDetails,
                                            out lstOrganization,
                                            out lstDuePaidDetails, FinalbillID, OrgID, lstSampleIds);

            List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
            billingBL.pGetRefundBillingDetails(visitID, out lstBillingDetails, out amtReceived, out amtRefunded, out dChequeAmount, FinalbillID, 0);
             


            List<BillingDetails> lstbilldetails = new List<BillingDetails>();
            var lstbill = (from hname in lstBillingDetail
                           select hname.FORENAME).Distinct();
            foreach (var obj in lstbill)
            {
                BillingDetails pdc = new BillingDetails();
                pdc.FORENAME = obj;
                lstbilldetails.Add(pdc);
            }
            grdTestReport.DataSource = lstbilldetails;
            grdTestReport.DataBind();
                

              
                lblName.Text = lstPatientDetails[0].Name;
                lblTitleName.Text = lstPatientDetails[0].TitleName;
                lblPatientNumber.Text = lstPatientDetails[0].PatientNumber.ToString();
                //if (lstPatientDetails[0].SEX == "M")
                 //   lblSex.Text = "Male";
               // else
                 //   lblSex.Text = "Female";
                if (lstPatientDetails[0].MobileNumber != "")
                    lblPatPhoneNumber.Text = lstPatientDetails[0].MobileNumber;
                if (!string.IsNullOrEmpty(lstPatientDetails[0].TPAName))
                {
                    lblClientName.Text = lstPatientDetails[0].TPAName;
                }
                 
                 
                if (lstPatientDetails[0].VersionNo != "")
                {
                    lblVisitNumber.Visible = true;
                    Rs_VisitNumber.Visible = true;
 // lblVisitNumber.Text = "/" + lstPatientDetails[0].VersionNo;
                    lblVisitNumber.Text = lstPatientDetails[0].VersionNo;
                }
                else
                {
                    lblVisitNumber.Visible = false;
                    Rs_VisitNumber.Visible = false;
                }
                 lblAge.Text = lstPatientDetails[0].Age.ToString() + " /" +lstPatientDetails[0].SEX;
                //lblDoB.Text = lstPatientDetails[0].DOB.ToShortDateString();


                // Bind Final Bill detail

 
                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                new GateWay(base.ContextInfo).GetInventoryConfigDetails("ShowDate_WithTime_BillPrint_Ascx", OrgID, ILocationID, out lstInventoryConfig);

                //if (lstInventoryConfig.Count > 0 && lstInventoryConfig[0].ConfigValue == "Y")
                //{
                 //}
                //else
                //{
                //    lblInvoiceDate.Text = lstFinalBillDetail[0].CreatedAt.ToString("dd/MMM/yyyy");
                //}

                lblPhysician.Text = lstPatientDetails[0].ReferingPhysicianName; 
                if (!string.IsNullOrEmpty(lstPatientDetails[0].RegistrationRemarks))
                {
                    lbltxtRemarks.Text = lstPatientDetails[0].RegistrationRemarks;
                }
                if (!string.IsNullOrEmpty(lstPatientDetails[0].PatientHistory))
                {
                    lbltxtHistory.Text = lstPatientDetails[0].PatientHistory;
                }

                #region MyRegion
		 
	
                // ====================
                //decimal sum = lstFinalBillDetail[0].GrossBillValue;
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "validateround('" + sum.ToString() + "');", true);
                //lblGrossAmount.Text = hdnRoundOff.Value;
                //===================             


                //lblPreviousDue.Text = "0.00";
                //decimal gt;
                //if (hdnIsRoundOff.Value == "ON")
                //{
                //    gt = Math.Round(lstFinalBillDetail[0].NetValue);
                //}
                //else
                //{
                //    gt = lstFinalBillDetail[0].NetValue;
                //}
                // lblGrandTotal.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].NetValue);
                // lblGrandTotal.Text = String.Format("{0:0.00}", gt);
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

                //if (isDueBill != "Y")
                //{
                //    decimal nv;
                //    if (hdnIsRoundOff.Value == "ON")
                //    {
                //        nv = Math.Round(lstFinalBillDetail[0].NetValue);//+ lstFinalBillDetail[0].CurrentDue
                //    }
                //    else
                //    {
                //        nv = lstFinalBillDetail[0].NetValue;//+ lstFinalBillDetail[0].CurrentDue
                //    }


                //}
                //else
                //{
                //    decimal nv;
                //    if (hdnIsRoundOff.Value == "ON")
                //    {
                //        nv = Math.Round(lstFinalBillDetail[0].NetValue);
                //    }
                //    else
                //    {
                //        nv = lstFinalBillDetail[0].NetValue;
                //    }

                //}

                //else
                //{
                //    lblDueAmount.Text = " Zero Only";
                //    //lblAmount.Visible = false;
                //    //lblAmount.Style.Add("display", "none");
                //}

            #endregion 
                #region TPAAttribute
                string TPAAttributes = (lstPatientDetails[0].TPAAttributes == null) ? "" : lstPatientDetails[0].TPAAttributes;

                // if (TPAAttributes != "" || lstPatientDetails[0].TPAName != "")
                 
                #endregion

                ////sample print
                long returnCode = -1;
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

            }
        
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get bill details for printing in Bill Printing page", ex);
        }
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
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }

    protected void grdTestReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblforename = (Label)e.Row.FindControl("lblforename");
                List<BillingDetails> lstlims = new List<BillingDetails>();
                BillingDetails RMaster = (BillingDetails)e.Row.DataItem;
                var childItems = from child in lstBillingDetail
                                 where child.FORENAME == lblforename.Text.Trim()
                                 //orderby child.DeptID descending
                                 select child;
                GridView childGrid = (GridView)e.Row.FindControl("gvBillingDetail");
                //count = childItems.Count();
                childGrid.DataSource = childItems;
                childGrid.DataBind();
                lstlims = childItems.ToList();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Investigation With Dept billing  Row Data Bound", ex);
        }
    }
}
