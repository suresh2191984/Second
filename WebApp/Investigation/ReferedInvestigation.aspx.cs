using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;

public partial class Investigation_ReferedInvestigation : BasePage
{
    long patientVisitID = -1;
    long taskID = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        btnPrint.Attributes.Add("onclick", "return printMe()");
        if (!Page.IsPostBack)
        {
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int64.TryParse(Request.QueryString["tid"], out taskID);

            ReferedInvestigation1.PatientVisitID = patientVisitID;
            ReferedInvestigation1.LoadReferedInvestigation(patientVisitID);
            new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);


        }

    }
    protected void btnHome_Click(object sender, EventArgs e)
    {
        Response.Redirect("../Reception/Home.aspx", true);
    }
}
