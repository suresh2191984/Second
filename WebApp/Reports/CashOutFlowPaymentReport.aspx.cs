using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;

public partial class Reports_CashOutFlowPaymentReport : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ExpenseDateLoad();
       
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
            ddlLocation.Items.Insert(0, "--Select--");
            ddlLocation.Items[0].Value = "-1";
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
            MetaData objdefault = new MetaData();
            
            ddlpay.DataSource = lstCashExpense;
            ddlpay.DataTextField = "HeadName";
            ddlpay.DataValueField = "HeadDesc";
            ddlpay.DataBind();
            ddlpay.Items.Insert(0, "--Select--");
            ddlpay.Items[0].Value = "-1";

        }
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

    protected void bsearch_Click(object sender, EventArgs e)
    {

    }
}
