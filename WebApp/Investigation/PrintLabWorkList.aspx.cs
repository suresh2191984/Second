using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;

public partial class Investigation_PrintLabWorkList : BasePage
{
    List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
    List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
    List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
    List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
    List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
    List<InvDeptMaster> deptList = new List<InvDeptMaster>();
    List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
    List<SampleAttributes> lstSampleAttributes = new List<SampleAttributes>();
    List<InvestigationValues> lstInvestigationValues = new List<InvestigationValues>();
    List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();
    List<PatientInvestigation> SaveInvestigation = new List<PatientInvestigation>();
    int pOrderedCount = -1;
    long returnCode = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string gUID = string.Empty;
            long pVisitID = 0;
            Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
            List<InvestigationOrgMapping> lstOrgMapping = new List<InvestigationOrgMapping>();
            if ((Request.QueryString["gUID"] != null)&&(Request.QueryString["gUID"] != ""))
            {
                gUID = Request.QueryString["gUID"].ToString();
            }
            Int64.TryParse(Request.QueryString["vid"], out pVisitID);

            investigationBL.GetInvestigationSamplesCollect(pVisitID, OrgID, RoleID, gUID,ILocationID,22, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList, out lstSampleContainer);

            foreach (PatientInvestigation patient in lstPatientInvestigation)
            {

                PatientInvestigation objInvest = new PatientInvestigation();
                objInvest.InvestigationID = patient.InvestigationID;
                objInvest.InvestigationName = patient.InvestigationName;
                objInvest.PatientVisitID = patient.PatientVisitID;
                objInvest.GroupID = patient.GroupID;
                objInvest.GroupName = patient.GroupName;
                objInvest.Status = patient.Status;
                objInvest.CollectedDateTime = patient.CreatedAt;
                objInvest.CreatedBy = LID;
                objInvest.Type = patient.Type;
                objInvest.OrgID = OrgID;
                objInvest.InvestigationMethodID = 0;
                objInvest.KitID = 0;
                objInvest.InstrumentID = 0;
                objInvest.UID = patient.UID;
                SaveInvestigation.Add(objInvest);
            }
            if (lstPatientInvestigation.Count > 0)
            {
                if (lstPatientInvestigation[0].UID != null)
                {
                    gUID = lstPatientInvestigation[0].UID;
                }
            }


            if (SaveInvestigation.Count > 0)
            {
                returnCode = new Investigation_BL(base.ContextInfo).SavePatientInvestigation(SaveInvestigation, OrgID, gUID, out pOrderedCount);
            }




            investigationBL.GetLabWorkListForVisit(pVisitID, OrgID, RoleID, gUID, out lstOrgMapping);
            if (lstOrgMapping.Count > 0)
            {
                TableRow rowh = new TableRow();
                TableCell cell1h = new TableCell();
                TableCell cell2h = new TableCell();
                TableCell cell3h = new TableCell();
                TableCell cell4h = new TableCell();
                cell1h.Attributes.Add("align", "left");
                cell1h.Text = "<u>Investigation</u>";
                cell2h.Attributes.Add("align", "left");
                cell2h.Text = "<u>Result</u>";
                cell3h.Attributes.Add("align", "left");
                cell3h.Text = "&nbsp;&nbsp;&nbsp;&nbsp;"+"<u>Units</u>"+"&nbsp;&nbsp;&nbsp;&nbsp;";
                cell4h.Attributes.Add("align", "left");
                cell4h.Text = "<u>Comments</u>";
                rowh.Cells.Add(cell1h);
                rowh.Cells.Add(cell2h);
                rowh.Cells.Add(cell3h);
                rowh.Cells.Add(cell4h);
                rowh.Font.Bold = true;
                
                rowh.Style.Add("font-size", "14px");
                listTab.Rows.Add(rowh);
                foreach (InvestigationOrgMapping objIOM in lstOrgMapping)
                {
                    TableRow row = new TableRow();
                    TableCell cell1 = new TableCell();
                    TableCell cell2 = new TableCell();
                    TableCell cell3 = new TableCell();
                    TableCell cell4 = new TableCell();
                    cell1.Attributes.Add("align", "left");
                    cell1.Text = objIOM.InvestigationName;
                    
                        cell2.Attributes.Add("align", "left");
                        if (objIOM.InvestigationName != "" && objIOM.UOMCode!= null)
                        {
                            cell2.Text = "_____________________";
                            cell3.Attributes.Add("align", "left");
                            cell3.Text = "&nbsp;&nbsp;&nbsp;&nbsp;" + objIOM.UOMCode + "&nbsp;&nbsp;&nbsp;&nbsp;";
                            cell4.Attributes.Add("align", "left");
                            cell4.Text = "_____________________";
                        }
                       
                    row.Cells.Add(cell1);
                    row.Cells.Add(cell2);
                    row.Cells.Add(cell3);
                    row.Cells.Add(cell4);
                    listTab.Rows.Add(row);
                    
                }
            }
        }
        catch (Exception ex)
        {
           
        }
    }
   
}
