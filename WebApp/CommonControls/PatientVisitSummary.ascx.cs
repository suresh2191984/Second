using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections;
using Attune.Podium.Common;
using Attune.Podium.TrustedOrg;

public partial class CommonControls_PatientVisitSummary : BaseControl
{
    long patientID = 0;
    long returnCode = -1;
    PatientVisit_BL PVBL;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int pOPCount = 0;
            int pIPCount = 0;
            //int ECount=0;
           // int TCount=0;
            string preVisitDate = string.Empty;
            string preVisitType = string.Empty;
            string pPatientNo = string.Empty;
            
            List<PatientEpisode> lstEpisode = new List<PatientEpisode>();
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            PVBL = new PatientVisit_BL(base.ContextInfo);
            returnCode = PVBL.GetPatientVisitSummary(patientID, out pOPCount, out pIPCount, out preVisitDate, out preVisitType, out pPatientNo);
            //returnCode = new PatientEpisode_BL(base.ContextInfo).CheckEpisodeforDuplicate(pEpisodeName, patientID, out ECount, out TCount);
            lblOPVisits.Text = pOPCount.ToString();
            lblIPVisits.Text = pIPCount.ToString();
            lblPno.Text = pPatientNo.ToString();
            if(preVisitDate.ToString()!="")
            {
                lblPreVisitDate.Text = String.Format("{0:dd/MM/yyyy}",Convert.ToDateTime(preVisitDate));
            }
            else{
                lblPreVisitDate.Text = "---";
            }
            if (preVisitType.ToString()!="")
            {
            lblPreVisitType.Text = preVisitType.ToString();
            }
            else{
                lblPreVisitType.Text = "---";
            }
        }
    }
}
