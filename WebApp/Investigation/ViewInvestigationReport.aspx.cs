using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
public partial class Investigation_ViewInvestigationReport : BasePage
{
    List<InvestigationValues> lstInvestigationResult = new List<InvestigationValues>();
    long vid = 0;
    List<InvestigationValues> lstInvResult = new List<InvestigationValues>();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.QueryString["vid"] != null)
        {
            vid = Convert.ToInt32(Request.QueryString["vid"]);
            patientHeader.PatientVisitID = vid;
        }

        if (vid != 0)
        {
            List<PatientVisit> lstDemographic = new List<PatientVisit>();
            new Investigation_BL(base.ContextInfo).GetInvestigationResultByRoleID(vid, RoleID, OrgID, out lstDemographic, out lstInvestigationResult);
            if (lstDemographic.Count > 0)
            {
                lblPatientName.Text = lstDemographic[0].PatientName;
                // lblPatientNo.Text = lstDemographic[0].PatientID.ToString();
                lblAge.Text = lstDemographic[0].PatientAge.ToString();
                lblGender.Text = lstDemographic[0].Sex;
                lblReportedDate.Text = lstDemographic[0].VisitDate.ToString("dd/MM/yyyy hh:mm:ss");
                lblAttendedOn.Text = lstDemographic[0].VisitDate.ToString("dd/MM/yyyy hh:mm:ss");
                lblRefPhysician.Text = lstDemographic[0].ReferingPhysicianName;
                lblVisitID.Text = Convert.ToString(vid);
            }
            if (lstInvestigationResult.Count > 0)
            {
                var grpInvestigation = from grpResult in lstInvestigationResult
                                       group grpResult by new
                                       {
                                           grpResult.InvestigationID,
                                           //grpResult.Name,
                                           //grpResult.Value,
                                           //grpResult.InvestigationName
                                       } into result
                                       select result;

                foreach (var item in grpInvestigation)
                {
                    InvestigationValues iValues = new InvestigationValues();
                    iValues.InvestigationID = item.Key.InvestigationID;
                    iValues.InvestigationName = item.ElementAt(0).InvestigationName;
                    iValues.PerformingPhysicainName = item.ElementAt(0).PerformingPhysicainName;
                    iValues.PackageID = item.ElementAt(0).PackageID;
                    iValues.PackageName = item.ElementAt(0).PackageName;
                    lstInvResult.Add(iValues);

                }

                rptInvResult.DataSource = lstInvResult;
                rptInvResult.DataBind();
                //lblPhyName.Text = lstInvResult[0].PerformingPhysicainName;
            }
        }
    }
    protected void rptInvResult_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            List<InvReportMaster> lstrptMaster = new List<InvReportMaster>();
            InvestigationValues eInvvalues = (InvestigationValues)e.Item.DataItem;
            Repeater rptInvName = (Repeater)e.Item.FindControl("rptChildRepeater");

            var groupByResult = from lst in lstInvestigationResult
                                group lst by
                                new
                                {
                                    lst.InvestigationName,
                                    lst.Name,
                                    lst.Value,
                                    lst.InvestigationID
                                } into grp where grp.Key.InvestigationID ==eInvvalues.InvestigationID                                
                                select new
                                {
                                    Name = grp.Key.Name,
                                    Value = grp.Key.Value,
                                    InvestigationName = grp.Key.InvestigationName
                                    ,PerformingPhysicainName = eInvvalues.PerformingPhysicainName 
                                    
                                };
            rptInvName.DataSource = groupByResult;
            rptInvName.DataBind();
        }

    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(Request.ApplicationPath + "/Investigation/InvestigationResultsCapture.aspx?vid=" + vid);
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("",ex);
            
        }
    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            string path = string.Empty;
            List<Role> role = new List<Role>();
            Role roleid = new Role();
            roleid.RoleID = RoleID;
            role.Add(roleid);
            long taskID;
            returnCode = new Investigation_BL(base.ContextInfo).UpdateInvestigationStatus(vid, "Completed", OrgID, lstInvResult);
            if (returnCode == 0)
            {

                new Navigation().GetLandingPage(role, out path);
            }
            if (path != string.Empty)
            {
                  Response.Redirect(Request.ApplicationPath + path);
            }
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            string str = ex.ToString();
        }
    }
    protected void lnkPrint_Click(object sender, EventArgs e)
    {
        btnFinish_Click(sender, e);

    }
}
