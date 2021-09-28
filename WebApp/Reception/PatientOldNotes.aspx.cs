using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Attune.Solution.BusinessComponent;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.FileUpload;
using Attune.Podium.Common;

public partial class Reception_PatientOldNotes : BasePage
{

    public Reception_PatientOldNotes()
        : base("Reception\\PatientOldNotes.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }



    long patientOldNotes = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        ImageUploadManager1.BatchID = 0;
    }
    protected void btnAttach_Click(object sender, EventArgs e)
    {
        long patientID = 0;
        int visitType = 2;
        long returnCode = -1;
        long visitID = 0;
        string PerformingPhyName = txtDrname.Text;
        string performingOrgName = txtCCName.Text;
        string PerformingOrgLocation = txtCLocation.Text;
        DateTime docDate = Convert.ToDateTime(txtDocDate.Text);
        string docTitle = txtdTitle.Text;

        if (Int64.TryParse(Request.QueryString["PID"].ToString(), out patientID))
        {
            if (Request.QueryString["vid"] == null)
            {

                returnCode = new Patient_BL(base.ContextInfo).SavePatientVisitForUpload(patientID, 0, OrgID, ILocationID, visitType, performingOrgName
                                                                        , PerformingOrgLocation, docTitle, docDate,
                                                                        PerformingPhyName, out patientOldNotes);
            }
            else
            {

                visitID = Convert.ToInt64(Request.QueryString["vid"]);
                returnCode = new Patient_BL(base.ContextInfo).SavePatientVisitForUpload(0, visitID, OrgID, ILocationID, visitType, performingOrgName
                                                                        , PerformingOrgLocation, docTitle, docDate,
                                                                        PerformingPhyName, out patientOldNotes);

            }
            if (returnCode == 0)
            {
                hidPOldnotesID.Value = patientOldNotes.ToString();
                //Panel3.Style.Add("display", "block");
                pnlSavebtn.Enabled = true;
                ImageUploadManager1.PatientNotesID = Convert.ToInt64(hidPOldnotesID.Value);
                ImageUploadManager1.EnableState = false;
                Panel1.Enabled = false;
            }
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            System.Collections.Hashtable List = ImageUploadManager1.GetFileURL();
            long returncode = -1;
            PatientOldNotesFileMapping eFilemapping;
            List<PatientOldNotesFileMapping> lPOFileMapping = new List<PatientOldNotesFileMapping>();
            FileUploadManager objFileUploadManager = new FileUploadManager(base.ContextInfo);
            if (List.Count > 0)
            {
                foreach (string key in List.Keys)
                {
                    string url = ((string)List[key]).Split('~')[1];
                    string FileType = ((string)List[key]).Split('~')[2];
                    long fileID = objFileUploadManager.WriteToDB(url, FileType);
                    //string ImageDescription = ((string)List[key]).Split
                    if (fileID != -1)
                    {
                        eFilemapping = new PatientOldNotesFileMapping();
                        eFilemapping.FileID = fileID;
                        eFilemapping.PatienOldNotesID = Convert.ToInt64(hidPOldnotesID.Value);
                        lPOFileMapping.Add(eFilemapping);
                    }
                }
                returncode = new Patient_BL(base.ContextInfo).SavePatientOldNotesFilemapping(lPOFileMapping);
            }
            else
            {
                string sPath = "Reception\\\\PatientOldNotes.aspx.cs_4";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "oldnotes", "javascript:alert('"+ sPath +"');", true);
                //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "oldnotes", "javascript:alert('Please Upload File and then Save');", true);
            }

            if (returncode == 0)
            {
                List<Role> lstUserRole = new List<Role>();
                string path = string.Empty;
                Role role = new Role();
                role.RoleID = RoleID;
                lstUserRole.Add(role);
                returncode = new Navigation().GetLandingPage(lstUserRole, out path);
                Response.Redirect(Request.ApplicationPath + path, true);
            }
        }
        catch (System.Threading.ThreadAbortException tAbortEx)
        {
            string te = tAbortEx.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While SavePatientOldNotesFilemapping in PatientOldnotes.aspx", ex);
        }
    }
}
