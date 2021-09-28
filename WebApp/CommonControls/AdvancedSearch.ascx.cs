using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;

public partial class CommonControls_AdvancedSearch : BaseControl
{
    public CommonControls_AdvancedSearch()
        : base("CommonControls_AdvancedSearch_ascx")
    {
    }

 

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public long loadList(string ExternalVisitID, string FromDate, string toDate, string PatientName,string patientnumber,string pVisitNumber)
    {
        long _dataCount = 0;
        try
        {
            long returncode = -1;
            
            List<OrganizationAddress> lAddress = new List<OrganizationAddress>();
            List<OrderedInvestigations> lstOrderinvestication = new List<OrderedInvestigations>();
            List<PatientVisit> lstpatientVisit = new List<PatientVisit>();
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo);
            returncode = patientBL.GetInvestigationOrgChange(ExternalVisitID, OrgID, FromDate, toDate, PatientName, patientnumber,pVisitNumber,out lstpatientVisit, out lstOrderinvestication);
            if (lstOrderinvestication.Count > 0)
            {
                grdResult.DataSource = lstOrderinvestication;
                grdResult.DataBind();
                _dataCount = Convert.ToInt64(lstOrderinvestication.Count);
            }
        }
        catch (Exception ex)
        {
            Attune.Podium.Common.CLogger.LogError("Error while load data investigation sample", ex);
        }
        return _dataCount;
    }
}
