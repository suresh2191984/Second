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
using Attune.Podium.Common;
using System.Collections;
using System.Data;
using System.Text;

public partial class ANC_ViewCaseSheet : BasePage
{
    long patientVisitID = -1;
    long patientID = -1;
    long taskID = -1;
    long returnCode = -1;

    protected void Page_Load(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"].ToString(), out patientVisitID);
        Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);

        if (!IsPostBack)
        {
            ancCS.LoadCaseSheetDetails(patientVisitID, patientID);
            PatientHeader1.PatientID = patientID;
        }
    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["tid"].ToString(), out taskID);

        new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);

        List<Role> lstUserRole1 = new List<Role>();
        string path1 = string.Empty;
        Role role1 = new Role();
        role1.RoleID = RoleID;
        lstUserRole1.Add(role1);
        returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
        Response.Redirect(Request.ApplicationPath + path1, true);
    }

    protected void btnClose_Click(object sender, EventArgs e)
    {
        try
        {
            Int64.TryParse(Request.QueryString["tid"].ToString(), out taskID);

            new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);

            List<Role> lstUserRole1 = new List<Role>();
            string path1 = string.Empty;
            Role role1 = new Role();
            role1.RoleID = RoleID;
            lstUserRole1.Add(role1);
            returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
            Response.Redirect(Request.ApplicationPath + path1, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ANC - View Case Sheet.ascx", ex);
        }
    }
}
