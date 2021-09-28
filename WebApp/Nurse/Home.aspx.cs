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


public partial class Masters_NurseHome : BasePage
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        //uctlTaskList.onTaskSelectFailed += new EventHandler(uctlTaskList_onTaskSelectFailed);

        if (!IsPostBack)
        {
            if (InventoryLocationID == -1)
            {
                Department1.LoadLocationUserMap();
            }
        }
    }

    //protected void uctlTaskList_onTaskSelectFailed(object sender, EventArgs e)
    //{
    //    CommonControls_Tasks tsk = (CommonControls_Tasks)sender;
    //    long iPatientID = uctlTaskList.SelectedPatient;
    //    long iTaskID = uctlTaskList.SelectedTask;
    //    string redirectURL = uctlTaskList.RedirectURL;
    //    redirectURL = string.Format(redirectURL, iPatientID.ToString());

    //    Response.Redirect(redirectURL);
    //}

    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        try
        {
            Session["UserName"] = null;
            Response.Redirect("Home.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }

   
}
