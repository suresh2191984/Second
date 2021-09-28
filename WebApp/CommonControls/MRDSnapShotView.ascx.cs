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
using System.Collections.Generic;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class CommonControls_MRDSnapShotView : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int pActiveIPList = -1;
            int pTodaysOPList = -1;
            int pTodaysSurgery = -1;
            int pLabCountsOP = -1;
            int pLabCountsIP = -1;
            int pLabCountsOPIP = -1;
            int pImagingCountsOP = -1;
            int pImagingCountsIP = -1;
            int pImagingCountsOPIP = -1;
            int pBirthCounts = -1;
            int pDischargeCounts = -1;
            int pInfectiousDisease = -1;
            int pNotifiableDiseases = -1;

            long returnCode = -1;
            DateTime dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

            returnCode = new Report_BL(base.ContextInfo).GetMRDSnapShotView(OrgID, dt, dt, out pActiveIPList, out pTodaysOPList, out pTodaysSurgery, out pBirthCounts, out pImagingCountsOP, out pImagingCountsIP, out pImagingCountsOPIP, out pLabCountsOP, out pLabCountsIP, out pLabCountsOPIP, out pDischargeCounts, out pInfectiousDisease, out pNotifiableDiseases);

            ActiveIPList.Text = pActiveIPList.ToString();
            TodaysOP.Text = pTodaysOPList.ToString();
            TodaysSurgery.Text = pTodaysSurgery.ToString();
            LabStatisticsOP.Text = pLabCountsOP.ToString();
            LabStatisticsIP.Text = pLabCountsIP.ToString();
            LabStatisticsOPIP.Text = pLabCountsOPIP.ToString();
            ImagingStatisticsOP.Text = pImagingCountsOP.ToString();
            ImagingStatisticsIP.Text = pImagingCountsIP.ToString();
            ImagingStatisticsOPIP.Text = pImagingCountsOPIP.ToString();
            DeliveryStatistics.Text = pBirthCounts.ToString();
            DischargeList.Text = pDischargeCounts.ToString();
            InfectiousDisease.Text = pInfectiousDisease.ToString();
            NotifiableDisease.Text = pNotifiableDiseases.ToString();
        }
    }
    protected void ActiveIPList_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(@"../Reports/IPDischargeAdmissionReport.aspx?status=ADM", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in MRD SnapShot View ActiveIPList_Click", ex);
        }
    }
    protected void TodaysOP_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(@"../Reports/ListofPatientsReport.aspx?status=TodaysOP", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in MRD SnapShot View TodaysOP_Click", ex);
        }
    }
    protected void TodaysSurgery_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(@"../Admin/SurgeryTeamWiseReport.aspx?status=SOI", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in MRD SnapShot View TodaysSurgery_Click", ex);
        }
    }
    protected void LabStatisticsOP_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(@"../Reports/LabStatisticsReport.aspx?status=LabOP", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in MRD SnapShot View LabStatisticsOP_Click", ex);
        }
    }
    protected void LabStatisticsIP_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(@"../Reports/LabStatisticsReport.aspx?status=LabIP", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in MRD SnapShot View LabStatisticsIP_Click", ex);
        }
    }
    protected void LabStatisticsOPIP_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(@"../Reports/LabStatisticsReport.aspx?status=LabOPIP", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in MRD SnapShot View LabStatisticsOPIP_Click", ex);
        }
    }
    protected void ImagingStatisticsOP_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(@"../Reports/ImgStatisticsReport.aspx?status=ImgOP", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in MRD SnapShot View ImagingStatisticsOP_Click", ex);
        }
    }
    protected void ImagingStatisticsIP_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(@"../Reports/ImgStatisticsReport.aspx?status=ImgIP", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in MRD SnapShot View ImagingStatisticsIP_Click", ex);
        }
    }
    protected void ImagingStatisticsOPIP_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(@"../Reports/ImgStatisticsReport.aspx?status=ImgOPIP", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in MRD SnapShot View ImagingStatisticsOPIP_Click", ex);
        }
    }
    protected void DeliveryStatistics_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(@"../Reports/BirthStatisticsReport.aspx?status=Birth", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in MRD SnapShot View DeliveryStatistics_Click", ex);
        }
    }
    protected void DischargeList_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(@"../Reports/IPDischargeAdmissionReport.aspx?status=DIS", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in MRD SnapShot View DischargeList_Click", ex);
        }
    }
    protected void InfectiousDisease_Click(object sender, EventArgs e)
    {
        try
        {
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in MRD SnapShot View InfectiousDisease_Click", ex);
        }
    }
    protected void NotifiableDisease_Click(object sender, EventArgs e)
    {
        try
        {
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in MRD SnapShot View NotifiableDisease_Click", ex);
        }
    }
}
