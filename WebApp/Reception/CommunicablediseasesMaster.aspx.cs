using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.TrustedOrg;
using System.Collections;
public partial class Reception_CommunicableDiseaseMaster : BasePage
{
    public Reception_CommunicableDiseaseMaster()
        : base("Reception\\CommunicableDiseaseMaster.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    public string ComplaintHeader { get; set; }
    public string DefaultComplaintID { get; set; }
    public int ComplaintID { get; set; }
    public string ComplaintName { get; set; }
    public string AddBtnVisible { get; set; }
    public string save_mesg = Resources.AppMessages.Update_Message; 
    long returnCode = -1;
    List<CommunicableDiseaseMaster> lstCommunicableDiseases;


    Patient_BL patientBL;

    protected void Page_Load(object sender, EventArgs e)
    {

        //lblComplaint.Text = ComplaintHeader;
        //setCommunicableDisease(List<CommunicableDiseaseMaster>);
        ComplaintICDCode1.ComplaintHeader = "Complaint Name";
        ComplaintICDCode1.SetWidth(500);

        if (!IsPostBack)
        {
            LoadC();
        }
    }

    protected void LoadC()
    {
        lstCommunicableDiseases = new List<CommunicableDiseaseMaster>();
        patientBL = new Patient_BL(base.ContextInfo);
        returnCode = patientBL.GetCommunicableDiseases(OrgID, out lstCommunicableDiseases);
        if (lstCommunicableDiseases.Count > 0)
        {
            ComplaintICDCode1.setCommunicableDisease(lstCommunicableDiseases);
            ComplaintICDCode1.LoadComplaintItems();

        }

    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Reception/Home.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {

        long returnCode = -1;
        List<CommunicableDiseaseMaster> CDS = new List<CommunicableDiseaseMaster>();
        CDS = ComplaintICDCode1.GetCommunicableDiseases(OrgID);
        patientBL = new Patient_BL(base.ContextInfo);
            returnCode = patientBL.SaveCommunicableDiseases(OrgID, ILocationID, CDS, LID);

            if (returnCode > 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('"+ save_mesg +"');", true);
                LoadC();
            }
        }

    
}
