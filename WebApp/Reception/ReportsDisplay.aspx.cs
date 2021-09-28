using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;

public partial class Reception_ReportSampleDisplay :BasePage
{
    #region Variable Declerations
    List<GetReportDetails> lstGroupItems = new List<GetReportDetails>();
    List<GetReportDetails> lstReportItems = new List<GetReportDetails>();
    long iUserTypeID = 0;
    long iOrgID = 0;
    Report_BL objreportBL ;
    long iReturnID = 0;
    #endregion
    protected void Page_Load(object sender, EventArgs e)
    {
          objreportBL = new Report_BL(base.ContextInfo);
        iUserTypeID = RoleID;
        iOrgID = OrgID;
        iReturnID = objreportBL.GetReportItems(iUserTypeID, iOrgID, out lstGroupItems, out lstReportItems);
        BindDynamicDatas(lstGroupItems,lstReportItems);
    }
    protected void BindDynamicDatas(List<GetReportDetails> lstGroupItems,List<GetReportDetails> lstReportItems)
    {
        int i = 0;
        foreach (GetReportDetails gGroupItem in lstGroupItems)
        {
            var ReportsDatas = from Reports in lstReportItems
                             where Reports.ReportGroupID == gGroupItem.ReportGroupID
                             select Reports;
            if (ReportsDatas.Count() > 0)
            {
                Control cntrlReport = LoadControl("~/CommonControls/ReportDisplay.ascx");
                UserControl ucntrlReport = (UserControl)cntrlReport;
                ucntrlReport.ID = "uctrlReports" + gGroupItem.ReportGroupID;
                ucntrlReport.Attributes.Add("Runat", "Server");

                divReportControls.Controls.AddAt(i, ucntrlReport);
                i++;
                DataList dlReports = (DataList)ucntrlReport.FindControl("dlReports");

                Label lblGroupName = (Label)ucntrlReport.FindControl("lblGroup");
                lblGroupName.Text = gGroupItem.ReportGroupText;
                dlReports.DataSource = ReportsDatas;
                dlReports.DataBind();
            }
        }
    }
}
