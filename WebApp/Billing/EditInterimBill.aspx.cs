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

public partial class Billing_EditInterimBill : BasePage
{

    public Billing_EditInterimBill()
        : base("Billing\\EditInterimBill.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    string InterimBillNo = string.Empty;
    string sPage = string.Empty;
    long patientID = 0;
    long visitID = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        //pNumber=" + hdnFID.Value + "&pName=" + hdnpid.Value + "&iBillNo=" + hdnvid.Value + "&billdate=" + hdndate.Value;

        if (!IsPostBack)
        {
            List<Config> lstConfig = new List<Config>();
            int iBillGroupID = 0;
            iBillGroupID = (int)ReportType.Receipt;

            //Need Header In IPReceipt Print Page
            string strConfigKey = "NeedHeaderInIPR";
            string configValue = GetConfigValue(strConfigKey, OrgID);

            if (configValue == "Y")
            {
                new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Logo", OrgID, ILocationID, out lstConfig);
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


                new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Font", OrgID, ILocationID, out lstConfig);

                if (lstConfig.Count > 0)
                {
                    lblHospitalName.Style.Add("font-family", lstConfig[0].ConfigValue.Trim());
                }

                new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Font Size", OrgID, ILocationID, out lstConfig);

                if (lstConfig.Count > 0)
                {
                    lblHospitalName.Style.Add("font-size", lstConfig[0].ConfigValue.Trim());
                }
                new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Content", OrgID, ILocationID, out lstConfig);

                if (lstConfig.Count > 0)
                {
                    lblHospitalName.InnerHtml = lstConfig[0].ConfigValue.Trim();
                }
            }

            //---------------------------------------------------------------------------------------------
            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Contents Font", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint.Style.Add("font-family", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Contents Font Size", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint.Style.Add("font-size", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Border Style", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint.Style.Add("border-style", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Border Width", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint.Width = lstConfig[0].ConfigValue.Trim();
            }
        }

        string dDateNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
        if (Request.QueryString["billdate"] != null)
        {
            if (Request.QueryString["billdate"].ToString() != "")
            {
                dDateNow = Request.QueryString["billdate"].ToString();
                DateTime DTPaidDate = Convert.ToDateTime(dDateNow);
                dDateNow = DTPaidDate.ToString("dd/MM/yyyy hh:mm tt");
                lblRaisedDate.Text = dDateNow;
            }
            else
            {
                dDateNow = "";
            }
        }
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        InterimBillNo=Request.QueryString["ReferenceID"];


        sPage = "../Billing/PrintInterimBill.aspx?ReferenceID="
                     + InterimBillNo.ToString() + "&billDate="
                     + Convert.ToDateTime(dDateNow).ToString("dd/MM/yyyy hh:mm tt")
            //+ "&PNAME=" + patientName
                     + "&pid=" + patientID.ToString()
                     + "&vid=" + visitID.ToString()
                     + "&type=edt"
                     + "&PNAME=" + "";

        hdnFID.Value = sPage;


        if (!IsPostBack)
        {
            SetBillDetails(patientID, visitID);
        }
    }

    protected void SetBillDetails(long PatientID, long VisitID)
    {
        //lblName.Text = PatientName;
        lblReferenceNo.Text = InterimBillNo.ToString();
        NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();

        //lblRaisedDate.Text = RaisedDate;
        List<Config> lstConfig = new List<Config>();
        GateWay gateWay = new GateWay(base.ContextInfo);
        lstConfig = new List<Config>();
        gateWay = new GateWay(base.ContextInfo);
        BillingEngine objBillingBL = new BillingEngine(base.ContextInfo);
        List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
        List<Patient> lstPatient = new List<Patient>();
        List<PatientDueChart> lstDueChart = new List<PatientDueChart>();
        new PatientVisit_BL(base.ContextInfo).GetInterimDueChart(out lstDueChart, out lstPatient, OrgID, PatientID, VisitID, InterimBillNo,"N");

        gvIndents.DataSource = lstDueChart;
        gvIndents.DataBind();
        decimal totalAmount = 0;
        foreach (GridViewRow row in gvIndents.Rows)
        {
            TextBox amount = (TextBox)row.FindControl("txtAmount");
            totalAmount += Convert.ToDecimal(amount.Text);


            TextBox txt = (TextBox)row.FindControl("txtQuantity");
            TextBox txtunitprice = (TextBox)row.FindControl("txtunitPrice");
            TextBox txtAmount = (TextBox)row.FindControl("txtAmount");
            
            txt.Attributes.Add("onblur", "CalcuteItemSum('" + txt.ClientID + "','" + txtunitprice.ClientID + "','"+ txtAmount.ClientID+"' )");
            txtunitprice.Attributes.Add("onblur", "CalcuteItemSum('" + txt.ClientID + "','" + txtunitprice.ClientID + "','" + txtAmount.ClientID + "')");
            txtHidden.Value += "~"+ txtAmount.ClientID;
        }

        dvDetails.Visible = true;
        lblTotal.Text = ((decimal)totalAmount).ToString("0.00");
        dvAdvance.Visible = false;
        lblName.Text = lstPatient[0].Name;
        //lblPatientNumber.Text = lstPatient[0].PatientID.ToString();

        lblPNumber.Text = lstPatient[0].PatientNumber;
        lblAge.Text = lstPatient[0].Age;
        lblMobileNumber.Text = lstPatient[0].MobileNumber;
        lblAge.Text = lstPatient[0].Age;
        lblMobileNumber.Text = lstPatient[0].MobileNumber;


        if (Convert.ToDouble(lblTotal.Text.Split('/')[0]) > 0)
        {
            if (int.Parse(lblTotal.Text.Split('/')[0].ToString().Split('.')[1]) > 0)
            {
                LblAmount.Text = Utilities.FormatNumber2Word(num.Convert(lblTotal.Text.Split('/')[0])) + " " + MinorCurrencyName + " Only...";
            }
            else
            {
                LblAmount.Text = num.Convert(lblTotal.Text.Split('/')[0]) + " Only...";
            }
        }
        else
        {
            string strlbl = Resources.ClientSideDisplayTexts.Billing_EditInterimBill_aspx_cs_1;
            LblAmount.Text = strlbl;
        }
    }

    protected string NumberConvert(object a, object b)
    {
        decimal c = 0;
        c = (decimal)a * (decimal)b;
        return c.ToString("0.00");
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

    protected void btnSave_Click(object sender, EventArgs e)
    {
        List<PatientDueChart> lstpatientDueChart = new List<PatientDueChart>();
        PatientDueChart PDC;

        try
        {
            foreach (GridViewRow row in gvIndents.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    PDC = new PatientDueChart();
                    long detailsID = 0;
                    decimal unit = 0;
                    decimal amount = 0;

                    Int64.TryParse(gvIndents.DataKeys[row.RowIndex][0].ToString(), out detailsID);
                    TextBox txt = (TextBox)row.FindControl("txtQuantity");
                    TextBox txtunitprice = (TextBox)row.FindControl("txtunitPrice");
                    Decimal.TryParse(txt.Text, out unit);
                    Decimal.TryParse(txtunitprice.Text, out amount);

                    PDC.DetailsID = detailsID;
                    PDC.Unit = unit;
                    PDC.Amount = amount;
                    PDC.FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    PDC.ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

                    lstpatientDueChart.Add(PDC);
                    PDC = null;
                }
            }

            long retVal = new PatientVisit_BL(base.ContextInfo).UpdatePatientDueChart(lstpatientDueChart);

            if (retVal == 0 && sPage != string.Empty)
            {
                Response.Redirect(sPage);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error updating patient duechart", ex);
            
        }
    }

    protected void gvIndents_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (((PatientDueChart)(e.Row.DataItem)).Status == "Paid")
            {
                ((TextBox)e.Row.FindControl("txtQuantity")).Enabled=false;
                ((TextBox)e.Row.FindControl("txtunitPrice")).Enabled=false;

                e.Row.ToolTip = "The due for this item has already been cleared";
               
            }
        }
    }
}
