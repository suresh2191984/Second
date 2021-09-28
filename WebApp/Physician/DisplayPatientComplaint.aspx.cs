using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;

public partial class Physician_DisplayPatientComplaint : BasePage
{
    long patientVisitID = -1;
    long previousVisitID = -1;
    long returnCode = -1;
    long patientID = -1;
    long taskID = -1;
    int complaintID = -1;
    int count;
    List<PatientComplaint> lstPatientComplaintDetail = new List<PatientComplaint>();
    protected void Page_Load(object sender, EventArgs e)
    {
        Int32.TryParse(Request.QueryString["count"], out count);
        if (count > 1)
        {
            string RDUrl = Request.Url.Query;
            Response.Redirect("../Physician/DisplayPatientComplaint.aspx" + RDUrl, true);
        }
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Int64.TryParse(Request.QueryString["pvid"], out previousVisitID);

      
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);

        if (!Page.IsPostBack)
        {
            getcomplaintdetails();
        }

    }
    protected void getcomplaintdetails()
    {
        List<PatientComplaint> lstPatientComplaintDetail = new List<PatientComplaint>();
        if (Request.QueryString["vid"] != null && Request.QueryString["pvid"] != null)
        {
            if (Request.QueryString["vid"].ToString() == Request.QueryString["pvid"].ToString())
                returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(patientVisitID, out lstPatientComplaintDetail);
            else
                returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(previousVisitID, out lstPatientComplaintDetail);
        }
        else
        {
            returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(patientVisitID, out lstPatientComplaintDetail);
        }



        rdolPatientComplaint.DataSource = lstPatientComplaintDetail;
        rdolPatientComplaint.DataTextField = "ComplaintName";
        rdolPatientComplaint.DataValueField = "ComplaintID";
        rdolPatientComplaint.DataBind();

        if (rdolPatientComplaint.Items.Count > 0)
            rdolPatientComplaint.Items[0].Selected = true;
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {

        try
        {
            returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(patientVisitID, out lstPatientComplaintDetail);
            for (int i = 0; i < rdolPatientComplaint.Items.Count; i++)
            {
                if (rdolPatientComplaint.Items[i].Selected == true)
                {
                    string complaintID = rdolPatientComplaint.Items[i].Value;
                    string complaintname = rdolPatientComplaint.Items[i].Text;


                    List<PatientComplaint> childItems = (from child in lstPatientComplaintDetail
                                                         where child.ComplaintName == complaintname
                                                         select child).ToList();
                   
                                                         
                                           

                    if (Request.QueryString["vid"] != null && Request.QueryString["pvid"] != null)
                    {
                        if (Request.QueryString["vid"].ToString() == Request.QueryString["pvid"].ToString())
                        {
                            if ((complaintID != "0") && (complaintID != "-1"))
                            {
                                Response.Redirect(@"../Physician/PatientDiagnose.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&id=" + complaintID + "&pvid=" + patientVisitID + "&tid=" + taskID + "", true);
                            }
                            else if (childItems[0].ComplaintType == "UNF")
                            {
                                Response.Redirect(@"../Physician/UnfoundDiagnosis.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&id=" + "0" + "&pvid=" + patientVisitID + "&tid=" + taskID + "", true);
                            }
                            else if (childItems[0].ComplaintType  == "QIC")
                            {
                                Response.Redirect(@"../Physician/QuickDiagnosis.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&tid=" + taskID + "&id=-1" + "", true);
                            }
                        }
                        else
                        {
                            if ((complaintID != "0") && (complaintID != "-1"))
                            {
                                Response.Redirect(@"../Physician/PatientDiagnose.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&id=" + complaintID + "&pvid=" + previousVisitID + "&tid=" + taskID + "", true);
                            }
                            else if (childItems[0].ComplaintType == "UNF")
                            {
                                Response.Redirect(@"../Physician/UnfoundDiagnosis.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&id=" + "0" + "&pvid=" + previousVisitID + "&tid=" + taskID + "", true);
                            }
                            else if (childItems[0].ComplaintType == "QIC")
                            {
                                Response.Redirect(@"../Physician/QuickDiagnosis.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&tid=" + taskID + "&id=-1" + "", true);
                            }
                        }
                    }
                    else
                    {
                        if ((complaintID != "0") && (complaintID != "-1"))
                        {
                            Response.Redirect(@"../Physician/PatientDiagnose.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&id=" + complaintID + "&pvid=" + patientVisitID + "&tid=" + taskID + "", true);
                        }
                        else if (childItems[0].ComplaintType == "UNF")
                        {
                            Response.Redirect(@"../Physician/UnfoundDiagnosis.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&id=" + "0" + "&pvid=" + patientVisitID + "&tid=" + taskID + "", true);
                        }
                        else if (childItems[0].ComplaintType == "QIC")
                        {
                            Response.Redirect(@"../Physician/QuickDiagnosis.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&tid=" + taskID + "&id=-1" + "", true);
                        }
                    }

                    //string complaintID = rdolPatientComplaint.Items[i].Value;
                    //Response.Redirect(@"../Physician/PatientDiagnose.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&id=" + complaintID + "&pvid=" + patientVisitID + "&tid=" + taskID + "", true);
                }
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
    protected void btnRemove_Click(object sender, EventArgs e)
    {
        string rmvPres = "ComplaintRemove";
        if (Request.QueryString["pvid"] != null && Request.QueryString["vid"] != null)
        {
            if (Convert.ToInt32(Request.QueryString["vid"]) ==
                Convert.ToInt32(Request.QueryString["pvid"]))
            {

                for (int i = 0; i < rdolPatientComplaint.Items.Count; i++)
                {
                    if (rdolPatientComplaint.Items[i].Selected == true)
                    {
                        Int32.TryParse(rdolPatientComplaint.Items[i].Value, out complaintID);
                        break;
                    }
                }
               
                Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
                returnCode = new Uri_BL(base.ContextInfo).DeletePatientDiagnoseDetail(complaintID, patientVisitID, rmvPres);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "delete", "alert('Previous complaint cannot be deleted')");
            }

        }

        getcomplaintdetails();
    }
    protected void btnAddMore_Click(object sender, EventArgs e)
    {
        try
        {
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int64.TryParse(Request.QueryString["tid"], out taskID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);

            Response.Redirect(@"../Physician/Diagnose.aspx?&vid=" + patientVisitID + "&tid=" + taskID + "&pid=" + patientID + "", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }

    protected void btnDone_Click(object sender, EventArgs e)
    {
        if (Request.QueryString["vid"] != null && Request.QueryString["pvid"] != null)
        {
            if (Request.QueryString["vid"].ToString() == Request.QueryString["pvid"].ToString())
            {
                Response.Redirect(@"../CaseSheet/ViewCaseSheet.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&id=" + complaintID + "&pvid=" + patientVisitID + "&tid=" + taskID + "", true);
            }
            else
                Response.Redirect(@"../CaseSheet/ViewCaseSheet.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&id=" + complaintID + "&pvid=" + previousVisitID + "&tid=" + taskID + "", true);
        }
        else
        {
            Response.Redirect(@"../CaseSheet/ViewCaseSheet.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&id=" + complaintID + "&pvid=" + patientVisitID + "&tid=" + taskID + "", true);
        }
    }



}
