using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using System.Text;
using NumberToWord;
using System.Collections.Specialized;
 

public partial class CommonControls_InvoicePrinting : BaseControl
{
    BillingEngine Bl;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
        }
    }
    #region LoadBillConfigMetadata
    public void LoadBillConfigMetadata(int OrgID, long OrgAddressID)
    {
        List<Config> lstConfig = new List<Config>();
        int iBillGroupID = 0;
        iBillGroupID = (int)ReportType.OPBill;
        new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "", OrgID, OrgAddressID, out lstConfig);
        int nConfigElements = lstConfig.Count;
        string[] sTempConfigElements;
        NameValueCollection oNV = new NameValueCollection();
        for (int nCnt = 0; nCnt < nConfigElements; nCnt++)
        {
            sTempConfigElements = lstConfig[nCnt].ConfigValue.Split('^');
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
    public void LoadDetails(long InvoiceID)
    {
        List<Invoice> lstInvoice = new List<Invoice>();
        List<BillingDetails> lstInvoiceBill = new List<BillingDetails>();
         NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
        long ClientID;
        string ClientNAme = string.Empty;
        string Period=string.Empty;
        string Monthof;

        if (Request.QueryString["CID"] != null)
        {
            ClientID = Convert.ToInt64(Request.QueryString["CID"]);
        }
        if (Request.QueryString["CName"] != null)
        {
            ClientNAme = (Request.QueryString["CName"]);
        }
        Bl = new BillingEngine(base.ContextInfo);
        Bl.GetInvoicePrinting(InvoiceID, OrgID, ILocationID, out lstInvoice, out lstInvoiceBill);

        Period = (lstInvoice[0].FromDate.ToString("dd/MM/yyyy") + " TO " + lstInvoice[0].ToDate.ToString("dd/MM/yyyy"));
        Monthof=lstInvoice[0].FromDate.ToString("Y");
       
        if (lstInvoice.Count > 0)
        {   

            lblInvoiceFor.Text = "";
            lblInvoiceDate.Text = lstInvoice[0].CreatedAt.ToString("dd/MM/yyyy");
            lblAddress.Text = lstInvoiceBill[0].ItemType;
            lblTotal.Text = lstInvoice[0].GrossValue.ToString();
            lblNetValue.Text = lstInvoice[0].NetValue.ToString();
            lblDisAmt.Text = lstInvoice[0].Discount.ToString();         
            lblInvoiceNo.Text = lstInvoice[0].InvoiceNumber;
            lblbillNo.Text = lstInvoice[0].InvoiceNumber;
            lblDt.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            lblmonth.Text = Monthof;
            lblTOValue.Text = ClientNAme;
            lblCAddress.Text = lblHospitalName.InnerText;
            lblEmail.Text = lstInvoiceBill[0].ProductKey;
            lblamtof.Text = lstInvoice[0].NetValue.ToString();
            lblTermsandConditions.Text = lstInvoiceBill[0].Remarks;
            lblPANNO.Text = lstInvoiceBill[0].ServiceCode;
            lblServiceTaxNo.Text = lstInvoiceBill[0].IsTaxable;
            lblSiteAt.Text = lstInvoiceBill[0].AttributeDetail;
            lblAddress.Text = lstInvoiceBill[0].ItemType;
            lblInvoiceFor.Text = lstInvoiceBill[0].Perphyname;
            lblPeriod.Text = Period;
            lblfPeriod.Text = Period;           
            lblAmounts.Text = Utilities.FormatNumber2Word(num.Convert(lblNetValue.Text))+ " only";
            grdInvoiceBill.DataSource = lstInvoiceBill;
            grdInvoiceBill.DataBind();
            

        }
    }
}
