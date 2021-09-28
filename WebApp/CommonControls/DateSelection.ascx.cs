using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections.Generic;
public partial class CommonControls_DateSelection : BaseControl
{

    string strddlFeeCategory = Resources.CommonControls_ClientDisplay.CommonControls_DateSelection_ascx_01 == null ? "--Select--" : Resources.CommonControls_ClientDisplay.CommonControls_DateSelection_ascx_01;
    string strFromDate = string.Empty;
    string strToDate = string.Empty;

    public CommonControls_DateSelection()
        : base("CommonControls_DateSelection_ascx")
    {
    }

    #region "Initial"

    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
		LoadMeatData();
            #region currentWeek
            DateTime dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DateTime wkStDt = DateTime.MinValue;
            DateTime wkEndDt = DateTime.MinValue;
            wkStDt = dt.AddDays(0 - Convert.ToDouble(dt.DayOfWeek));
            wkEndDt = dt.AddDays(7 - Convert.ToDouble(dt.DayOfWeek));
            hdnFirstDayWeek.Value = wkStDt.ToString("dd/MM/yyyy");
            hdnLastDayWeek.Value = wkEndDt.ToString("dd/MM/yyyy");
            #endregion

            #region currentMonth
            DateTime dateNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone); //create DateTime with current date                  
            hdnFirstDayMonth.Value = dateNow.AddDays(-(dateNow.Day - 1)).ToString("dd/MM/yyyy"); //first day 
            dateNow = dateNow.AddMonths(1);
            hdnLastDayMonth.Value = dateNow.AddDays(-(dateNow.Day)).ToString("dd/MM/yyyy"); //last day
            #endregion

            #region currentYear
            hdnFirstDayYear.Value = "01/01/" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;
            hdnLastDayYear.Value = "31/12/" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;
            #endregion

            #region lastmonth
            DateTime dtlm = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMonths(-1);
            hdnLastMonthFirst.Value = dtlm.AddDays(-(dtlm.Day - 1)).ToString("dd/MM/yyyy");
            dtlm = dtlm.AddMonths(1);
            hdnLastMonthLast.Value = dtlm.AddDays(-(dtlm.Day)).ToString("dd/MM/yyyy");
            #endregion

            #region lastweek
            DateTime dt1 = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DateTime LwkStDt = DateTime.MinValue;
            DateTime LwkEndDt = DateTime.MinValue;
            hdnLastWeekFirst.Value = dt1.AddDays(-7 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd/MM/yyyy");
            hdnLastWeekLast.Value = dt1.AddDays(-1 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd/MM/yyyy");

            #endregion

            #region lastYear
            DateTime dt2 = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            string tempyear = dt2.AddYears(-1).ToString();
            string[] tyear = new string[5];
            tyear = tempyear.Split('/', '-');
            tyear = tyear[2].Split(' ');
            hdnLastYearFirst.Value = "01/01/" + tyear[0].ToString();
            hdnLastYearLast.Value = "31/12/" + tyear[0].ToString();
            #endregion

            //to bind grid with today's bills on pageload
            #region Today
            hdnTodayFirst.Value = OrgTimeZone;
            #endregion

            txtFromPeriod.Attributes.Add("onchange", "ExcedDate('" + txtFromPeriod.ClientID.ToString() + "','',0,0);");
            txtToPeriod.Attributes.Add("onchange", "ExcedDate('" + txtToPeriod.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToPeriod.ClientID.ToString() + "','"+txtFromPeriod.ClientID.ToString()+"',1,1);");
            ddlRegisterDate.SelectedValue = "-1";
        }

        if (IsPostBack)
        {
            if (hdnTempFrom.Value != "" && hdnTempTo.Value != "")
            {
                txtFromDate.Text = hdnTempFrom.Value;
                txtToDate.Text = hdnTempTo.Value;
                txtFromDate.Attributes.Add("disabled", "true");
                txtToDate.Attributes.Add("disabled", "true");
            }
            if (ddlRegisterDate.SelectedValue != "-1")
            {
                if (ddlRegisterDate.SelectedValue != "3")
                {
                    divRegDate.Style.Add("display", "block");
                    divRegCustomDate.Style.Add("display", "none");
                }
                if (ddlRegisterDate.SelectedValue == "3")
                {
                    divRegCustomDate.Style.Add("display", "block");
                    divRegDate.Style.Add("display", "none");
                }
            }

        }

    }
     public void LoadMeatData()
    {
        try
        {
           // ddlRegisterDate.Items.Insert(0, strddlFeeCategory);
            long returncode = -1;
            string domains = "CustomPeriodRange";
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
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var CustomPeriodRange = from child in lstmetadataOutput
                                 where child.Domain == "CustomPeriodRange"
                                 select child;
                if (CustomPeriodRange.Count() > 0)
                {
                    ddlRegisterDate.DataSource = CustomPeriodRange;
                    ddlRegisterDate.DataTextField = "DisplayText";
                    ddlRegisterDate.DataValueField = "Code";
                    ddlRegisterDate.DataBind();
                    ddlRegisterDate.SelectedValue = "Year(s)";
                   // ddlRegisterDate.Items.Insert(0, strddlFeeCategory);
                    ListItem li = new ListItem();
                    li.Text = strddlFeeCategory;
                    li.Value = "-1";
                    ddlRegisterDate.Items.Insert(0, li);
                }
                
             }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
    }

    #endregion

    #region "Events"
    #endregion



    public DateTime GetFromDate()
    {
        DateTime FromDate=Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        string FDate = "01/01/2010";
        if (ddlRegisterDate.SelectedValue != "-1" && ddlRegisterDate.SelectedValue != "3")
        {
           FromDate = Convert.ToDateTime(txtFromDate.Text);
        }
        else if (ddlRegisterDate.SelectedValue == "3")
        {
            FromDate = Convert.ToDateTime(txtFromPeriod.Text);
        }
        if (ddlRegisterDate.SelectedValue == "-1")
            FromDate = Convert.ToDateTime(FDate);
        return FromDate;
    }
    public DateTime GetToDate()
    {
        DateTime ToDate=Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        if (ddlRegisterDate.SelectedValue != "-1" && ddlRegisterDate.SelectedValue != "3")
        {
          ToDate = Convert.ToDateTime(txtToDate.Text);
        }
        else if (ddlRegisterDate.SelectedValue == "3")
        {
            ToDate = Convert.ToDateTime(txtToPeriod.Text);
        }
        return ToDate;
    }
}
