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
using System.Collections;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Admin_DashBoard :BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            WebPartManager1.DisplayMode = WebPartManager.BrowseDisplayMode;
        }
        GetDaywise();
        

    }

    private void GetDaywise()
    {
        DateTime pFDT;
        DateTime pTDT;
        
        BillingEngine objBillingEngine = new BillingEngine(base.ContextInfo);

        List<ReceivedAmount> lstINDAmtReceivedDetails = new List<ReceivedAmount>();
        List<ReceivedAmount> lstINDIPAmtReceivedDetails = new List<ReceivedAmount>();
        string sstatus = string.Empty;
        
        long retval = -1;
        string sAllAmtReceivedID = string.Empty;

        //---------------------------DAILY------------------------------------------------------
        DateLogic(out pFDT, out pTDT, "Pie", "D");
        retval = objBillingEngine.GetAmountReceivedReport(OrgID, pFDT, pTDT,
                                                            out lstINDAmtReceivedDetails,
                                                            out lstINDIPAmtReceivedDetails);

        revenueDisplay1.sControlType = "D";
        //revenueDisplay1.Attributes.Add("title", "test");
        revenueDisplay1.ChartDraw(lstINDAmtReceivedDetails, lstINDIPAmtReceivedDetails);

        //---------------------------WEEKLY------------------------------------------------------
        DateLogic(out pFDT, out pTDT, "Pie", "W");
        retval = objBillingEngine.GetAmountReceivedReport(OrgID, pFDT, pTDT,
                                                           out lstINDAmtReceivedDetails,
                                                           out lstINDIPAmtReceivedDetails);

        RevenueWeekly1.sControlType = "W";
        RevenueWeekly1.ChartDraw(lstINDAmtReceivedDetails, lstINDIPAmtReceivedDetails);

        //---------------------------MONTHLY------------------------------------------------------
        DateLogic(out pFDT, out pTDT, "Pie", "M");
        retval = objBillingEngine.GetAmountReceivedReport(OrgID, pFDT, pTDT,
                                                           out lstINDAmtReceivedDetails,
                                                           out lstINDIPAmtReceivedDetails);
        revenueMonthly1.sControlType = "M";
        revenueMonthly1.ChartDraw(lstINDAmtReceivedDetails, lstINDIPAmtReceivedDetails);

        //---------------------------QUARTERLY---------------------------------------------------------
        DateLogic(out pFDT, out pTDT, "Pie", "Q");
        retval = objBillingEngine.GetAmountReceivedReport(OrgID, pFDT, pTDT,
                                                           out lstINDAmtReceivedDetails,
                                                           out lstINDIPAmtReceivedDetails);
        revenueQuarterly1.sControlType = "Q";
        revenueQuarterly1.ChartDraw(lstINDAmtReceivedDetails, lstINDIPAmtReceivedDetails);
        
        //---------------------------ANNUAL------------------------------------------------------
        //DateLogic(out pFDT, out pTDT, "Pie", "A");
        //retval = objBillingEngine.GetAmountReceivedReport(OrgID, pFDT, pTDT,
        //                                                   out lstINDAmtReceivedDetails,
        //                                                   out lstINDIPAmtReceivedDetails);
        //revenueAnnual1.sControlType = "A";
        //revenueAnnual1.ChartDraw(lstINDAmtReceivedDetails, lstINDIPAmtReceivedDetails);

    //------------------------------------------------------------------------------------------

        //---------------------------DAILY------------------------------------------------------
        //DateLogic(out pFDT, out pTDT, "Line", "D");
        retval = objBillingEngine.GetAmountReceivedDaywiseReport(OrgID, "D",
                                                            out lstINDAmtReceivedDetails);

        LineDaily.sControlType = "D";
        LineDaily.ChartDraw(lstINDAmtReceivedDetails);

        //---------------------------WEEKLY------------------------------------------------------
        //DateLogic(out pFDT, out pTDT, "Line", "W");
        retval = objBillingEngine.GetAmountReceivedDaywiseReport(OrgID, "W",
                                                           out lstINDAmtReceivedDetails);

        LineWeekly.sControlType = "W";
        LineWeekly.ChartDraw(lstINDAmtReceivedDetails);

        //---------------------------MONTHLY------------------------------------------------------
        //DateLogic(out pFDT, out pTDT, "Line", "M");
        retval = objBillingEngine.GetAmountReceivedDaywiseReport(OrgID, "M",
                                                           out lstINDAmtReceivedDetails );
        LineMonthly.sControlType = "M";
        LineMonthly.ChartDraw(lstINDAmtReceivedDetails);

        //---------------------------QUARTERLY---------------------------------------------------------
        //DateLogic(out pFDT, out pTDT, "Line", "Q");
        retval = objBillingEngine.GetAmountReceivedDaywiseReport(OrgID, "Q",
                                                           out lstINDAmtReceivedDetails );
        LineQuarterly.sControlType = "Q";
        LineQuarterly.ChartDraw(lstINDAmtReceivedDetails);

        //---------------------------ANNUAL------------------------------------------------------

        //DateLogic(out pFDT, out pTDT, "Line", "A");
        //retval = objBillingEngine.GetAmountReceivedDaywiseReport(OrgID, pFDT, pTDT,
        //                                                   out lstINDAmtReceivedDetails,
        //                                                   out lstINDIPAmtReceivedDetails);
        //LineDisplay5.sControlType = "A";
        //LineDisplay5.ChartDraw(lstINDAmtReceivedDetails, lstINDIPAmtReceivedDetails);
    }

    private void DateLogic(out DateTime sFromDate, out DateTime sToDate, string sType, string sDuration)
    {
        sFromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        sToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        

        if (sType == "Pie")
        {
            if (sDuration == "D")
            {
                DateTime.TryParse(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString(), out sFromDate);
                DateTime.TryParse(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString(), out sToDate);
            }
            else if (sDuration == "W")
            {
                int iDays = Convert.ToInt32(Convert.ToDateTime(new BasePage().OrgDateTimeZone).DayOfWeek - DayOfWeek.Sunday);
                DateTime.TryParse(Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(-iDays).ToShortDateString(), out sFromDate);
                DateTime.TryParse(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString(), out sToDate);
            }
            else if (sDuration == "M")
            {
                string iMonth = Convert.ToDateTime(new BasePage().OrgDateTimeZone).Month.ToString();
                string iYear = Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year.ToString();
                DateTime.TryParse("1/" + iMonth + "/" + iYear , out sFromDate);
                DateTime.TryParse(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString(), out sToDate);
            }
            else if (sDuration == "Q")
            {
                int iMonth = Convert.ToDateTime(new BasePage().OrgDateTimeZone).Month;
                int iYear = Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;
                string sStartDate = "";
                if (iMonth <= 3)
                {
                    sStartDate = "01/01/" + iYear;
                }
                else if (iMonth > 3 && iMonth <= 6)
                {
                    sStartDate = "01/04/" + iYear;
                }
                else if (iMonth > 6 && iMonth <= 9)
                {
                    sStartDate = "01/06/" + iYear;
                }
                else if (iMonth > 9 && iMonth <= 12)
                {
                    sStartDate = "01/09/" + iYear;
                }

                DateTime.TryParse(sStartDate, out sFromDate);
                DateTime.TryParse(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString(), out sToDate);

            }
            else if (sDuration == "A")
            {
                int iYear = Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;
                DateTime.TryParse("01/01/"+iYear, out sFromDate);
                DateTime.TryParse(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString(), out sToDate);
            }
        }

        //if (sType == "Line")
        //{
        //    if (sDuration == "D")
        //    {
        //        DateTime.TryParse(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString(), out sFromDate);
        //        DateTime.TryParse(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString(), out sToDate);
        //    }
        //    else if (sDuration == "W")
        //    {
        //        DateTime.TryParse(Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(-30).ToShortDateString(), out sFromDate);
        //        DateTime.TryParse(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString(), out sToDate);
        //    }
        //    else if (sDuration == "M")
        //    {
        //        DateTime.TryParse(Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddYears(-1).ToShortDateString(), out sFromDate);
        //        DateTime.TryParse(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString(), out sToDate);
        //    }
        //    else if (sDuration == "Q")
        //    {
        //        DateTime.TryParse(Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddYears(-1).ToShortDateString(), out sFromDate);
        //        DateTime.TryParse(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString(), out sToDate);

        //    }
        //    else if (sDuration == "A")
        //    {
        //        int iYear = Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;
        //        DateTime.TryParse("01/01/" + iYear, out sFromDate);
        //        DateTime.TryParse(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString(), out sToDate);
        //    }
        //}

    }

    protected void lnkHome_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Home.aspx", true);
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while executing GetWeek()", ex);
        }
    }
    protected string getdate(string sType)
    {
        return "Breakupfor "+Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString();

    }
}
