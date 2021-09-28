﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.IO;
using Attune.Podium.BillingEngine;
using System.Data;
using System.Text;
using System.Security.Cryptography;
using System.Collections;
using System.Web.Script.Serialization;
using Attune.Podium.PerformingNextAction;


public partial class Investigation_SynopticTest : BaseControl
{

    public Investigation_SynopticTest()
        : base("Investigation_SynopticTest_ascx")
    {

    }
    private long visitID = 0;
    public long VisitID
    {
        get { return visitID; }
        set
        {
            visitID = value;
        }
    }

    private string labNo = string.Empty;
    public string LabNo
    {
        get { return labNo; }
        set
        {
            labNo = value;
        }
    }

    private string gUID = string.Empty;
    public string GUID
    {
        get { return gUID; }
        set
        {
            gUID = value;
        }
    }

    private int pOrgid = -1;
    public int POrgid
    {
        get { return pOrgid; }
        set
        {
            pOrgid = value;
        }
    }
    Investigation_BL InvBL;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            AutoCompleteExtender1.ContextKey = OrgID.ToString();
        }
        BindColumnsTogrdSynopticTestINV();
        BindColumnsTogrdSynopticTestDatas();
    }
    private void BindColumnsTogrdSynopticTestINV()
    {
        DataTable Dt = new DataTable();
        Dt.Columns.Add("ID");
        Dt.Columns.Add("Name");
        Dt.Rows.Add();

        grdSynopticTestINV.DataSource = Dt;
        grdSynopticTestINV.DataBind();

    }
    private void BindColumnsTogrdSynopticTestDatas()
    {
        DataTable Dt1 = new DataTable();

        Dt1.Columns.Add("Select");
        Dt1.Columns.Add("ID");
        Dt1.Columns.Add("Accession Number");
        Dt1.Columns.Add("Investigation Name");
        Dt1.Columns.Add("Status");
        Dt1.Rows.Add();

        grdSynopticTestOrderedInv.DataSource = Dt1;
        grdSynopticTestOrderedInv.DataBind();
        grdSynopticTestOrderedInv.Style.Add("visibility", "hidden");

    }
    // public void saveInvestigationQueue(List<PatientInvestigation> lstReflex)
    public void saveInvestigationQueue()
    {
        try
        {
            List<InvestigationQueue> lstInvestigationQueue = new List<InvestigationQueue>();
            List<InvestigationQueue> InvQueue = new List<InvestigationQueue>();
            List<InvestigationQueue> InvQueue1 = new List<InvestigationQueue>();
            List<FinalBill> lstFinalBill = new List<FinalBill>();
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string strLstInvestigationQueue = hdnLstInvestigationQueue.Value;
            lstInvestigationQueue = serializer.Deserialize<List<InvestigationQueue>>(strLstInvestigationQueue);
            long returnCode = -1;
            List<InvestigationQueue> lstSameSample = lstInvestigationQueue.ToList();

            if (lstSameSample.Count() > 0)
            {
                long orgId1 = OrgID;
                List<OrderedInvestigations> ordInves = new List<OrderedInvestigations>();
                foreach (InvestigationQueue oInvestigationQueue in lstSameSample)
                {
                    OrderedInvestigations objOrderInvest = new OrderedInvestigations();
                    objOrderInvest.ID = oInvestigationQueue.InvestigationID;
                    objOrderInvest.Name = oInvestigationQueue.InvestigationName;
                    //objOrderInvest.VisitID = Convert.ToInt64(visitID);
                    //objOrderInvest.Status = "SampleReceived";
                    objOrderInvest.VisitID = oInvestigationQueue.VisitID;
                    objOrderInvest.Status = oInvestigationQueue.Status;
                    objOrderInvest.PaymentStatus = "Paid";
                    objOrderInvest.CreatedBy = LID;
                    objOrderInvest.Type = oInvestigationQueue.Type;
                    objOrderInvest.OrgID = OrgID;
                    objOrderInvest.LabNo = oInvestigationQueue.LabNo;
                    objOrderInvest.ReferenceType = "S";
                    objOrderInvest.ReferedToLocation = ILocationID;
                    objOrderInvest.ComplaintId = Convert.ToInt32(oInvestigationQueue.LabNo);
                    if (!String.IsNullOrEmpty(oInvestigationQueue.UID))
                    {
                        objOrderInvest.UID = oInvestigationQueue.UID;
                    }
                    objOrderInvest.ReferralID = oInvestigationQueue.AccessionNumber;
                    objOrderInvest.StudyInstanceUId = "0";
                    ordInves.Add(objOrderInvest);
                }
                if (ordInves.Count() > 0)
                {
                    InvBL = new Investigation_BL(base.ContextInfo);
                    returnCode = InvBL.SaveOrderedInvestigation(ordInves, orgId1);

                    List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
                    List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
                    List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
                    List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
                    List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
                    List<InvDeptMaster> deptList = new List<InvDeptMaster>();
                    List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
                    List<SampleAttributes> lstSampleAttributes = new List<SampleAttributes>();
                    List<InvestigationValues> lstInvestigationValues = new List<InvestigationValues>();
                    List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();
                    List<PatientInvestigation> SaveInvestigation = new List<PatientInvestigation>();
                    int pOrderedCount = -1;

                    PatientVisit_BL objPatientVisit_BL = new PatientVisit_BL();
                    int TaskActionID = -1;
                    int VisitPurposeID = Convert.ToInt32(TaskHelper.VisitPurpose.LabInvestigation);
                    int OtherID = RoleID;
                    List<TaskActions> lstTaskActions = new List<TaskActions>();
                    objPatientVisit_BL.GetTaskActionID(OrgID, VisitPurposeID, RoleID, out lstTaskActions);
                    if (lstTaskActions.Count > 0)
                    {
                        if (lstTaskActions[0].TaskActionID > 0)
                        {
                            TaskActionID = lstTaskActions[0].TaskActionID;
                        }
                        else
                        {
                            TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Approval);
                        }
                    }
                    else
                    {
                        TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Approval);
                    }

                    InvBL.GetInvestigationSamplesCollect(ordInves[0].VisitID, OrgID, RoleID, ordInves[0].UID, ILocationID, TaskActionID,
                        out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept,
                        out lstOrderedInvSample, out deptList, out lstSampleContainer);

                    foreach (PatientInvestigation patient in lstPatientInvestigation)
                    {

                        PatientInvestigation objPatientInvest = new PatientInvestigation();
                        objPatientInvest.InvestigationID = patient.InvestigationID;
                        objPatientInvest.InvestigationName = patient.InvestigationName;
                        objPatientInvest.PatientVisitID = patient.PatientVisitID;
                        objPatientInvest.GroupID = patient.GroupID;
                        objPatientInvest.GroupName = patient.GroupName;
                        objPatientInvest.Status = patient.Status;
                        objPatientInvest.AccessionNumber = patient.AccessionNumber;
                        objPatientInvest.CollectedDateTime = patient.CreatedAt;
                        objPatientInvest.CreatedBy = LID;
                        objPatientInvest.Type = patient.Type;
                        objPatientInvest.OrgID = OrgID;
                        objPatientInvest.InvestigationMethodID = 0;
                        objPatientInvest.KitID = 0;
                        objPatientInvest.InstrumentID = 0;
                        objPatientInvest.UID = patient.UID;
                        SaveInvestigation.Add(objPatientInvest);
                    }
                    if (lstPatientInvestigation.Count() > 0)
                    {
                        if (lstPatientInvestigation[0].UID != null)
                        {
                            GUID = lstPatientInvestigation[0].UID;
                        }
                    }
                    if (SaveInvestigation.Count > 0)
                    {
                        returnCode = InvBL.SavePatientInvestigation(SaveInvestigation, OrgID, GUID, out pOrderedCount);
                    }
                    //String CurrentPagePath = HttpContext.Current.Request.Url.AbsoluteUri;
                    ////Response.Redirect(CurrentPagePath);

                    //String originalPath = new Uri(HttpContext.Current.Request.Url.AbsoluteUri).OriginalString;

                    //CLogger.LogInfo("Synoptic");

                    //CLogger.LogInfo(CurrentPagePath);

                    //CLogger.LogInfo(originalPath);
                    
                    //Response.Redirect(CurrentPagePath);

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Synoptic Test Added", ex);
        }
    }
  
    protected void grdSynopticTestOrderedInv_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {

            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[1].Visible = false;
                e.Row.Cells[2].Visible = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Reflex Test Added", ex);
        }
    }
    private string CreateUniqueDecimalString()
    {
        string uniqueDecimalString = "1.2.840.113619.";
        uniqueDecimalString += GetUniqueKey() + ".";
        uniqueDecimalString += GetUniqueKey();
        return uniqueDecimalString;
    }
    private string GetUniqueKey()
    {
        int maxSize = 10;
        char[] chars = new char[62];
        string a;
        //a = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        a = "0123456789012345678901234567890123456789012345678901234567890123456789";
        chars = a.ToCharArray();
        int size = maxSize;
        byte[] data = new byte[1];
        RNGCryptoServiceProvider crypto = new RNGCryptoServiceProvider();
        crypto.GetNonZeroBytes(data);
        size = maxSize;
        data = new byte[size];
        crypto.GetNonZeroBytes(data);
        StringBuilder result = new StringBuilder(size);
        foreach (byte b in data)
        { result.Append(chars[b % (chars.Length - 1)]); }
        return result.ToString();
    }
    
    protected void btnSaveSynopticTest_Click(object sender, EventArgs e)
    {
        //saveInvestigationQueue();
    }
}
