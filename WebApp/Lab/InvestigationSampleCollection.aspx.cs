using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class Investigation_InvestigationSample : BasePage
{
    long vid = 0;
    long tid = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["vid"] != null && Request.QueryString["tid"] != null)
            {
                try
                {
                    Investigation_BL InvestBL = new Investigation_BL(base.ContextInfo);
                    List<PatientInvestigation> lstInvest = new List<PatientInvestigation>();
                    vid = Convert.ToInt64(Request.QueryString["vid"]);
                    InvestBL.GetInvestigationSample(vid, out lstInvest);
                    loadInvestigation(lstInvest);

                    patientHeader.PatientVisitID = vid;
                    patientHeader.ShowVitalsDetails();
                }
                catch (Exception ex)
                {
                    CLogger.LogError("Error on pageload", ex);
                }
            }
        }
    }

    public void loadInvestigation(List<PatientInvestigation> lstInvest)
    {
        if (lstInvest.Count > 0)
        {
            CBL.Items.Clear();
            lblName.Text = "Collect Sample for the following Investigations";
            foreach (PatientInvestigation val in lstInvest)
            {
                CBL.Items.Add(new ListItem(val.InvestigationName, Convert.ToString(val.InvestigationID)));
            }
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            vid = Convert.ToInt64(Request.QueryString["vid"]);
            PatientInvestigation SampleCollect = null;
            List<PatientInvestigation> lstSample = new List<PatientInvestigation>();
            foreach (ListItem li in CBL.Items)
            {
                if (li.Selected)
                {
                    SampleCollect = new PatientInvestigation();
                    SampleCollect.InvestigationID = Convert.ToInt32(li.Value);
                    SampleCollect.PatientVisitID = vid;
                    SampleCollect.Status = "SAMPLE COLLECTED";
                    SampleCollect.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    lstSample.Add(SampleCollect);
                }
            }

            Investigation_BL updateBL = new Investigation_BL(base.ContextInfo);
            int count = 0;
            long result = updateBL.UpdateSampleCollected(lstSample, 1, out count);
            if (result == 0 && count == 0)
            {

                Int64.TryParse(Request.QueryString["tid"].ToString(), out tid);
                new Tasks_BL(base.ContextInfo).UpdateTask(tid, TaskHelper.TaskStatus.Completed, UID);
                Response.Redirect("~/Lab/Home.aspx");
            }
            else if (result == 0 && count > 0)
            {
                Response.Redirect("~/Lab/Home.aspx");
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while saving InvestigationSample", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("~/Lab/Home.aspx");
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }

    protected void chkSelectall_CheckedChanged(object sender, EventArgs e)
    {
        if (chkSelectall.Checked)
        {
            for (int i = 0; i < CBL.Items.Count; i++)
            {
                CBL.Items[i].Selected = true;

            }
        }
        else
        {
            for (int i = 0; i < CBL.Items.Count; i++)
            {
                CBL.Items[i].Selected = false;

            }
        }

    }
    protected void CBL_SelectedIndexChanged(object sender, EventArgs e)
    {
        int cnt = 0;
        foreach (ListItem li in CBL.Items)
        {
            if (li.Selected)
            {
                cnt++;
            }
        }

        if (cnt == CBL.Items.Count)
        {
            chkSelectall.Checked = true;
        }
        else
        {
            chkSelectall.Checked = false;
        }
    }
}
