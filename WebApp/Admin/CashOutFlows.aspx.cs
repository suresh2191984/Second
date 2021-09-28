using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;

public partial class Admin_CashOutFlows : BasePage
{
    public Admin_CashOutFlows()
    {
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        ddlLocation.SelectedValue = Convert.ToString(ILocationID);
        ddlLocationSearch.SelectedValue = Convert.ToString(ILocationID);
        ExpenseDateLoad();
        AutoCompleteExtender3.ContextKey =Convert.ToString(OrgID);
        if (!IsPostBack)
        {
            loadlocations(RoleID, OrgID);
            LoadCashExpense();

            long returncode1 = -1;
            string domains1 = "CustomPeriodRange";
            string[] Tempdata1 = domains1.Split(',');
            string LangCode1 = "en-GB";
            List<MetaData> lstmetadataInput1 = new List<MetaData>();
            List<MetaData> lstmetadataOutput1 = new List<MetaData>();

            MetaData objMeta1;

            for (int i = 0; i < Tempdata1.Length; i++)
            {
                objMeta1 = new MetaData();
                objMeta1.Domain = Tempdata1[i];
                lstmetadataInput1.Add(objMeta1);

            }
            returncode1 = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput1, OrgID, LangCode1, out lstmetadataOutput1);
            if (lstmetadataOutput1.Count > 0)
            {
                /********Changed By Arivalagan.kk*******/
                MetaData objdefault = new MetaData();
                objdefault.DisplayText = "--Select--";
                objdefault.Code = "-1";
                lstmetadataOutput1.Insert(0, objdefault);

                ddlRegisterDate.DataSource = lstmetadataOutput1;
                ddlRegisterDate.DataTextField = "DisplayText";
                ddlRegisterDate.DataValueField = "Code";
                ddlRegisterDate.DataBind();
                //ddlRegisterDate.Items.Insert(0, strSelect);
                //ddlRegisterDate.Items[0].Value = "-1";
                //ListItem li = new ListItem();
                //li.Text = strSelect;
                //li.Value = "--Select--";
                //ddlRegisterDate.Items.Add( li);
                ddlRegisterDate.SelectedValue = "--Select--";
                /********End Changed By Arivalagan.kk*******/
            }
        }
    }
    protected void loadlocations(long uroleID, long intOrgID)
    {
        try
        {
            long returnCode = -1;
            Attune.Solution.BusinessComponent.PatientVisit_BL patientBL = new Attune.Solution.BusinessComponent.PatientVisit_BL(base.ContextInfo);
            List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
            returnCode = patientBL.GetLocation(intOrgID, LID, uroleID, out lstLocation);
            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "Location";
            ddlLocation.DataValueField = "AddressID";
            ddlLocation.DataBind();
            
            ddlLocationSearch.DataSource = lstLocation;
            ddlLocationSearch.DataTextField = "Location";
            ddlLocationSearch.DataValueField = "AddressID";
            ddlLocationSearch.DataBind();
            ddlLocationSearch.Items.Insert(0, "--Select--");
            ddlLocationSearch.Items[0].Value = "-1";
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured during GetLocation", ex);
        }
    }
    public void LoadCashExpense()
    {
        Physician_BL PhysicianBL = new Physician_BL(base.ContextInfo);
        List<CashExpenseMaster> lstCashExpense = new List<CashExpenseMaster>();
        PhysicianBL.GetCashExpenseByOrg(OrgID, out lstCashExpense);


        if (lstCashExpense.Count > 0)
        {
            ddlPay.DataSource = lstCashExpense;
            ddlPay.DataTextField = "HeadName";
            ddlPay.DataValueField = "HeadDesc";
            ddlPay.DataBind();

            ddlpaySearch.DataSource = lstCashExpense;
            ddlpaySearch.DataTextField = "HeadName";
            ddlpaySearch.DataValueField = "HeadDesc";
            ddlpaySearch.DataBind();
            ddlpaySearch.Items.Insert(0, "--Select--");
            ddlpaySearch.Items[0].Value = "-1";
        }
    }
    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "DateAttributes";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }


            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "DateAttributes"
                                 select child;
                if (childItems.Count() > 0)
                {
                    //ddlDOBDWMY.DataSource = childItems;
                    //ddlDOBDWMY.DataTextField = "DisplayText";
                    //ddlDOBDWMY.DataValueField = "Code";
                    //ddlDOBDWMY.DataBind();
                    //ddlDOBDWMY.SelectedValue = "Year(s)";
                }


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }
    protected void bsave_Click(object sender, EventArgs e)
    {
        System.Data.DataTable dtAdvancePaidDetails = new System.Data.DataTable();
        dtAdvancePaidDetails = PaymentTypeDetails1.GetAmountReceivedDetails();
        List<CashFlowTransactions> lstCashFlowTransactions = new List<CashFlowTransactions>();
        CashOutFlow objCashoutFlow = new CashOutFlow();
        String Remarks = txtRemarks.Value;
        DateTime expdate= DateTime.Now;
        if (txtExpdate.Text != "")
        {
             expdate = Convert.ToDateTime(txtExpdate.Text);
        }
       
        
        DateTime dummy = DateTime.Now;
        string VoucherNO = "";
        long OutFlowID = -1;
        long retval = -1;
        if (dtAdvancePaidDetails.Rows.Count >0)
        retval = new BillingEngine(base.ContextInfo).InsertCashFlow(Convert.ToInt32(hdnEmpID.Value), txtPayrece.Text, ddlPay.SelectedItem.Value, "OFF", Decimal.Zero, Decimal.Zero, Decimal.Zero, expdate, dummy, Remarks, "New", Convert.ToInt32(LID), OrgID,
               dtAdvancePaidDetails, Decimal.Zero, out VoucherNO, out OutFlowID, lstCashFlowTransactions, objCashoutFlow, ILocationID);
        if (retval >= 0)
        {
            String usrMsg5 = "Saved Successfully";
            String Information = "Alter";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ValidationWindow('" + usrMsg5 + "','" + Information + "');", true);
        }
        txtother.Text = "";
        txtExpdate.Text = "";
        txtPayrece.Text = "";
        hdnEmpID.Value = "0";
        txtRemarks.Value = "";
        ((HiddenField)PaymentTypeDetails1.FindControl("hdfPaymentType")).Value = "";
        ((HiddenField)PaymentTypeDetails1.FindControl("hdnPaymentsDeleted")).Value = "";

      
    }
    public void ExpenseDateLoad()
    {
        DateTime dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        DateTime wkStDt = DateTime.MinValue;
        DateTime wkEndDt = DateTime.MinValue;
        wkStDt = dt.AddDays(1 - Convert.ToDouble(dt.DayOfWeek));
        wkEndDt = dt.AddDays(7 - Convert.ToDouble(dt.DayOfWeek));
        hdnFirstDayWeek.Value = wkStDt.ToString("dd-MM-yyyy");
        hdnLastDayWeek.Value = wkEndDt.ToString("dd-MM-yyyy");
        DateTime dateNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone); //create DateTime with current date                  
        hdnFirstDayMonth.Value = dateNow.AddDays(-(dateNow.Day - 1)).ToString("dd-MM-yyyy"); //first day 
        dateNow = dateNow.AddMonths(1);
        hdnLastDayMonth.Value = dateNow.AddDays(-(dateNow.Day)).ToString("dd-MM-yyyy"); //last day


        DateTime OrgDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        hdnFirstDayYear.Value = "01-01-" + OrgDateTime.Year;
        hdnLastDayYear.Value = "31-12-" + OrgDateTime.Year;

        #region lastmonth
        DateTime dtlm = OrgDateTime.AddMonths(-1);
        hdnLastMonthFirst.Value = dtlm.AddDays(-(dtlm.Day - 1)).ToString("dd-MM-yyyy");
        dtlm = dtlm.AddMonths(1);
        hdnLastMonthLast.Value = dtlm.AddDays(-(dtlm.Day)).ToString("dd-MM-yyyy");
        #endregion

        #region lastweek
        DateTime dt1 = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        DateTime LwkStDt = DateTime.MinValue;
        DateTime LwkEndDt = DateTime.MinValue;
        hdnLastWeekFirst.Value = dt1.AddDays(-7 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd-MM-yyyy");
        hdnLastWeekLast.Value = dt1.AddDays(-1 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd-MM-yyyy");

        #endregion

        #region lastYear
        DateTime dt2 = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        string tempyear = dt2.AddYears(-1).ToString();
        string[] tyear = new string[5];
        tyear = tempyear.Split('/', '-');
        tyear = tyear[2].Split(' ');
        hdnLastYearFirst.Value = "01-01-" + tyear[0].ToString();
        hdnLastYearLast.Value = "31-12-" + tyear[0].ToString();
        #endregion

    }
    protected void loadlocationsSearch(long uroleID, long intOrgID)
    {
        try
        {
            long returnCode = -1;
            Attune.Solution.BusinessComponent.PatientVisit_BL patientBL = new Attune.Solution.BusinessComponent.PatientVisit_BL(base.ContextInfo);
            List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
            returnCode = patientBL.GetLocation(intOrgID, LID, uroleID, out lstLocation);
            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "Location";
            ddlLocation.DataValueField = "AddressID";
            ddlLocation.DataBind();
            ddlLocation.Items.Insert(0, "--Select--");
            ddlLocation.Items[0].Value = "-1";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured during GetLocation", ex);
        }
    }
}
