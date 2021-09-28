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
using Attune.Podium.BusinessEntities;
using System.Collections.Generic;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Linq;

public partial class Physician_FirstDialysis : BasePage
{
    int complaintID = 2;
    string drugIDs = string.Empty;
    long visitID = 0;
    long pid = 0;
    long selTaskID = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["vid"] != null)
        {
            visitID = Convert.ToInt64(Request.QueryString["vid"]);
        }
        selTaskID = Convert.ToInt64(Request.QueryString["tid"]);
        //complaintID = GetComplaintID("Dialysis");

        if (isValidHit())
        {
            try
            {
                if (!IsPostBack)
                {
                    GetHistory();
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError( "Error while executing page load in FirstDialysis.aspx", ex);
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "Unable to retrieve page information. Pl. try later";                
            }
        }
    }

    private bool isValidHit()
    {
        visitID = Convert.ToInt64(Request.QueryString["vid"]);
        selTaskID = Convert.ToInt32(Request.QueryString["tid"]);

        if (visitID <= 0 || UID <= 0)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Invalid input for page.";            
            pnl1.Visible = false;
            pnlButton.Visible = false;
            //advMedicine.Visible = false;
            return false;
        }
        return true;
    }

    void GetHistory()
    {
        Uri_BL URIBL = new Uri_BL(base.ContextInfo);
        List<History> histories = new List<History>();
        histories = URIBL.GetHistoryByComplaintName("HaemoDialysis", out complaintID);
        tvwHistory.NodeStyle.CssClass = "details_value3";
        AddChildNode(tvwHistory.Nodes[0], histories);
    }

    void AddChildNode(TreeNode parent, List<History> histories)
    {
        int parentID;
        parentID = Convert.ToInt32(parent.Value);
        var queryHistory = from his in histories
                           where his.ParentID == parentID
                           select his;

        foreach (var his in queryHistory)
        {
            TreeNode tn = new TreeNode();
            tn.Text = his.HistoryName;
            tn.Value = his.HistoryID.ToString();
            tn.ShowCheckBox = his.HasChild == 0 ? true : false;
            tn.PopulateOnDemand = false;
            tn.SelectAction = TreeNodeSelectAction.None;
            tn.NavigateUrl = string.Empty;
            parent.ChildNodes.Add(tn);
            if (his.HasChild != 0)
            {
                AddChildNode(tn, histories);
            }
        }

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        string ErrorText = "Error Inserting Dialysis Details. Pl. try agin later or contact Admin";
        long taskID = -1;
        if (ValidatePage())
        {
            long returnCode = -1;
            
            DialysisDetails dd = GetDialysisDetails();
            List<PatientHistory> lph = GetSelectedHistory();
            List<PatientPrescription> lpp = GetPatientPrescription();
            Tasks iTask = GetInsertTask();
            Tasks uTask = GetUpdateTask();
            
            try
            {
                Dialysis_BL dbl = new Dialysis_BL(base.ContextInfo);
                returnCode = dbl.SaveDialysisDetails(dd, lph, lpp);

                if (returnCode == 0)
                {
                    ErrorText = "Unable to update task details. Please contact Admin";    
                    Tasks_BL tbl = new Tasks_BL(base.ContextInfo);
                    returnCode = tbl.UpdateAndCreateTask(iTask, uTask, out taskID);
                    Response.Redirect("~/Nurse/Home.aspx",true);
                }
            }
            catch (System.Threading.ThreadAbortException tae)
            {
                string thread = tae.ToString();
            }

            catch (Exception ex)
            {
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = ErrorText;                
                CLogger.LogError("Error while executing btnSave_Click " + ErrorText, ex);
            }
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Tasks_BL tbl = new Tasks_BL(base.ContextInfo);
            tbl.UpdateTask(selTaskID, TaskHelper.TaskStatus.Pending, UID);
            Response.Redirect("~\\Nurse\\Home.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error Updating Task in DialysisRecord's Cancel button click :", ex);
        }

    }

    private bool ValidatePage()
    {
        string errtxt = "";

        if ((!chkFirst.Checked) && tDate.Text.Equals(string.Empty))
        {
            errtxt = "Pl. enter the earlier Dialysis Date.";
            return false;
        }
        
        return true;
    }

    private DialysisDetails GetDialysisDetails()
    {
        DialysisDetails dd = new DialysisDetails();

        dd.IsFirstDialysis = chkFirst.Checked;
        dd.PatientVisitID = visitID;
        dd.CreatedBy = LID;
        if (!chkFirst.Checked)
        {
            dd.DialysisSince = Convert.ToDateTime(tDate.Text);
        }
        else
        {
            dd.DialysisSince = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        }

        return dd;
    }

    private List<PatientHistory> GetSelectedHistory()
    {
        List<PatientHistory> lph = new List<PatientHistory>();
        PatientHistory ph;
        foreach (TreeNode tn in tvwHistory.CheckedNodes)
        {
            if (tn.Checked)
            {
                ph = new PatientHistory();
                ph.HistoryID = Convert.ToInt32(tn.Value);
                ph.CreatedBy = LID;
                ph.PatientVisitID = visitID;
                lph.Add(ph);
            }
        }
        return lph;
    }

    private List<PatientPrescription> GetPatientPrescription()
    {
        List<PatientPrescription> lpp = new List<PatientPrescription>();
        List<DrugDetails> ldd = advMedicine.GetPrescription(visitID);

        PatientPrescription pp = new PatientPrescription();
        
        foreach (DrugDetails dd in ldd)
        {
           // pp.DrugID = dd.DrugID;
            pp.PatientVisitID = dd.PatientVisitID;
            pp.BrandName = dd.DrugName;
            pp.Dose = dd.Dose;
            pp.Formulation = dd.DrugFormulation;
            pp.ROA = dd.ROA;
            pp.DrugFrequency = dd.DrugFrequency;
            pp.Duration = dd.Days;
            pp.PatientVisitID = visitID;
            pp.CreatedBy = LID;
            lpp.Add(pp);

          
        }

        return lpp;
    }

    private Tasks GetInsertTask()
    {
        Tasks tsk = new Tasks();
        Hashtable htDispText = new Hashtable();
        Hashtable htURL = new Hashtable();

        htURL.Add("PatientVisitID", visitID.ToString());
        //htURL.Add("ComplaintID", complaintID.ToString());

        Dialysis_BL dialysisBl = new Dialysis_BL(base.ContextInfo);
        dialysisBl.GetHTParamsForPreDialysisTask(visitID, out pid, out htDispText);

        tsk.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.PreDialysis);
        tsk.PatientID = pid;
        tsk.PatientVisitID = visitID;
        tsk.OrgID = OrgID;
        tsk.CreatedBy = LID;
        tsk.DispTextFiller = htDispText;
        tsk.URLFiller = htURL;
        return tsk;
    }

    private Tasks GetUpdateTask()
    {
        Tasks tsk = new Tasks();

        tsk.TaskID = selTaskID;
        tsk.TaskStatusID = Convert.ToInt32(TaskHelper.TaskStatus.Completed);
        tsk.ModifiedBy = LID;

        return tsk;
    }
}
