using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Configuration;
using System.IO;

public partial class Lab_IPInvSampleCollection : BasePage
{
    public Lab_IPInvSampleCollection()
        : base("Lab\\IPInvSampleCollection.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long vid = -1;
    string sampleList = string.Empty;
    string gUID = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        lblErrorMessage.Text = "";
        try
        {
            if (Request.QueryString["vid"] != null)
            {
                vid = int.Parse(Request.QueryString.Get("vid"));
            }
            if (Request.QueryString["gUID"] != null)
            {
                gUID = Request.QueryString["gUID"].ToString();
            }
            if (!IsPostBack)
            {
                patientHeader.PatientVisitID = vid;

                List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
                List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
                List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
                List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
                List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
                List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
                List<InvDeptMaster> deptList = new List<InvDeptMaster>();
                List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();
                Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
                invbl.GetInvestigationSamplesCollect(vid, OrgID, RoleID, gUID, ILocationID, 22, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList, out lstSampleContainer);

                ddlSampleName.DataSource = lstInvSampleMaster;

                ddlSampleName.DataTextField = "SampleDesc";
                ddlSampleName.DataValueField = "SampleCode";
                ddlSampleName.DataBind();

                //if (lstInvDeptMaster.Count > 0)
                //{

                //    repDepts.DataSource = lstInvDeptMaster;
                //    repDepts.DataBind();

                //}

                List<InvGroupMaster> lstgroups = new List<InvGroupMaster>();
                List<InvestigationMaster> lstInvestigations = new List<InvestigationMaster>();
                new Investigation_BL(base.ContextInfo).GetInvestigationData(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.orgSpecific), out lstgroups, out lstInvestigations);
                int orgBased = OrgID;
                InvestigationControl1.OrgSpecific = orgBased;
                InvestigationControl1.LoadDatas(lstgroups, lstInvestigations);
            }
            if (ViewState["sampleList"] != null)
            {
                SetSampleList();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in IP INV Sample Collection", ex);
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            string sampleName = ddlSampleName.SelectedItem.Text;
            string sampleCode = ddlSampleName.SelectedValue;
            string statusValue = ddlStatus.SelectedValue;
            string statusName = ddlStatus.SelectedItem.Text;
            string barCode = Convert.ToString(txtBarCode.Text);
            string reason = txtRejectedReason.Text;

            if (ViewState["sampleList"] != null)
            {
                sampleList = ViewState["sampleList"].ToString();
            }

            #region Commented because Same Samples should be added

            //if (!sampleList.Contains("sampleName:" + sampleName + ",sampleCode:" + sampleCode))
            //{
            sampleList += "sampleName:" + sampleName +
                          ",sampleCode:" + sampleCode +
                          ",status:" + statusName +
                          ",statusValue:" + statusValue +
                          ",Barcode:" + barCode +
                          ",Reason:" + reason + "^";

            ViewState["sampleList"] = sampleList;

            //}
            //else
            //{

            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey", "alert('Already added')", true);

            //}

            #endregion
            SetSampleList();
            //if (ddlStatus.SelectedValue == "4")
            //{
            //    divreasontxt.Style.Add("display", "block");
            //    divRejectedReason.Style.Add("display", "block");
            //}
            //else
            //{
            //    divreasontxt.Style.Add("display", "none");
            //    divRejectedReason.Style.Add("display", "none");
            //}
            ddlStatus.SelectedValue = "3";
            txtBarCode.Text = "";
            txtRejectedReason.Text = "";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while excecuting investigation sample page", ex);
        }
    }

    public void SetSampleList()
    {
        List<PatientInvSample> lstSample = new List<PatientInvSample>();
        //PatientInvSample patSample = new PatientInvSample();
        SampleTracker smp = new SampleTracker();

        if (ViewState["sampleList"] != null)
        {
            sampleList = ViewState["sampleList"].ToString();
        }

        if (sampleList != string.Empty)
        {
            foreach (string list in sampleList.Split('^'))
            {
                if (list != string.Empty)
                {
                    PatientInvSample patSample = new PatientInvSample();

                    foreach (string values in list.Split(','))
                    {
                        string[] items = values.Split(':');
                        string invesValues = string.Empty;
                        if (items.Count() > 0)
                            invesValues = items[1];

                        switch (items[0])
                        {
                            case "sampleName":
                                patSample.SampleDesc = invesValues;
                                break;

                            case "sampleCode":
                                patSample.SampleCode = Convert.ToInt32(invesValues);
                                break;

                            case "Barcode":
                                patSample.BarcodeNumber = invesValues;
                                break;
                            case "Reason":
                                patSample.Reason = invesValues;
                                break;
                            case "status":
                                patSample.InvSampleStatusDesc = invesValues;
                                break;
                            case "statusValue":
                                patSample.InvSampleStatusID = Convert.ToInt64(invesValues);
                                break;
                        };

                    }

                    lstSample.Add(patSample);

                }
            }
        }

        rptSamples.DataSource = lstSample;
        rptSamples.DataBind();
    }

    protected void rptSamples_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            string newSampleList = string.Empty;

            if (e.CommandName == "Delete")
            {
                string SampleCode = ((Label)(e.Item.FindControl("lblSampleCode"))).Text;
                string SampleName = ((Label)(e.Item.FindControl("lblSampleName"))).Text;


                if (ViewState["sampleList"] != null)
                {
                    sampleList = ViewState["sampleList"].ToString();
                }

                if (sampleList != string.Empty)
                {
                    foreach (string list in sampleList.Split('^'))
                    {
                        if (list != string.Empty)
                        {
                            string sTempSampleValue = "sampleName:" + SampleName + ",sampleCode:" + SampleCode + ",";
                            if (!list.Contains(sTempSampleValue))
                            {
                                newSampleList += list + "^";
                            }
                        }
                    }
                    sampleList = newSampleList;
                    ViewState["sampleList"] = sampleList;
                    SetSampleList();
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while excecuting investigation sample page", ex);
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        long returncode = -1;
        int ret = -1;

        List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
        List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();

        PatientInvSample PatientInvSample = new PatientInvSample();

        IpInvSampleCollectionMaster ipscm = new IpInvSampleCollectionMaster();
        List<PatientInvestigation> orderedInves = new List<PatientInvestigation>();
        List<PatientInvestigation> lstPatientInvest = new List<PatientInvestigation>();
        if (rptSamples.Items.Count > 0)
        {


            ipscm.PatientVisitID = vid;
            ipscm.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
            ipscm.Status = "SampleReceived";
            ipscm.CreatedBy = LID;

            foreach (RepeaterItem repItem in this.rptSamples.Items)
            {
                //CheckBox chkSample = repItem.FindControl("chkSampleCollect") as CheckBox;
                //if (chkSample.Checked)
                //{
                Label lbSampleCode = repItem.FindControl("lblSampleCode") as Label;
                Label lbSampleDesc = repItem.FindControl("lblSampleName") as Label;
                Label lbStatusID = repItem.FindControl("lblstatusID") as Label;
                Label lbRejectedReason = repItem.FindControl("lblReason") as Label;
                Label lbtxBarCode = repItem.FindControl("lblBarcode") as Label;

                PatientInvSample = new PatientInvSample();
                PatientInvSample.PatientVisitID = vid;
                PatientInvSample.BarcodeNumber = lbtxBarCode.Text == "" ? "0" : lbtxBarCode.Text;
                PatientInvSample.SampleCode = int.Parse(lbSampleCode.Text);
                PatientInvSample.SampleDesc = lbSampleDesc.Text;
                lstPatientInvSample.Add(PatientInvSample);
            }


            lstPatientInvest = InvestigationControl1.GetOrderedList();

            if (lstPatientInvest.Count > 0)
            {
                foreach (PatientInvestigation inves in lstPatientInvest)
                {
                    PatientInvestigation objInvest = new PatientInvestigation();
                    objInvest.InvestigationID = inves.InvestigationID;
                    objInvest.InvestigationName = inves.InvestigationName;
                    objInvest.PatientVisitID = vid;
                    objInvest.GroupID = inves.GroupID;
                    objInvest.GroupName = inves.GroupName;
                    objInvest.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    objInvest.Status = "Ordered";
                    objInvest.CreatedBy = LID;
                    objInvest.Type = inves.Type;
                    orderedInves.Add(objInvest);
                }
                returncode = new Investigation_BL(base.ContextInfo).InsertIPInvestigation(ipscm, OrgID, lstPatientInvSample, orderedInves);

                List<Role> lstUserRole = new List<Role>();
                string path = string.Empty;
                Role role = new Role();
                role.RoleID = RoleID;
                lstUserRole.Add(role);
                returncode = new Navigation().GetLandingPage(lstUserRole, out path);
                Response.Redirect(Request.ApplicationPath + path, true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey1", "javascript:alert('Select investigations');", true);

                //lblErrorMessage.Text = "Select atleast 1 Investigation";
            }
        }
        else
        {
            //lblErrorMessage.Text = "Select Samples & Investigations";

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('Investigations and Samples ha to be selectede');", true);
        }

        //returncode = new Investigation_BL(base.ContextInfo).InsertIPInvestigation(ipscm, OrgID, lstPatientInvSample, orderedInves, out ret);


        //if (ret == 0)
        //{
        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('Investigations and Samples have been added');", true);


        //}
        //else
        //{
        //}

        //string invStatus = string.Empty;
        //new Investigation_BL(base.ContextInfo).getInvOrgSampleStatus(OrgID, "Paid", out invStatus);
        //returncode = new Investigation_BL(base.ContextInfo).updatePatientInvestigationStatus(vid, invStatus, DeptID, "Paid", out upis);
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        long returncode = -1;

        List<Role> lstUserRole = new List<Role>();
        string path = string.Empty;
        Role role = new Role();
        role.RoleID = RoleID;
        lstUserRole.Add(role);
        returncode = new Navigation().GetLandingPage(lstUserRole, out path);
        Response.Redirect(Request.ApplicationPath + path, true);
    }
}
