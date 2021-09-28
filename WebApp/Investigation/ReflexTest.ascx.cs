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


public partial class Investigation_ReflexTest : BaseControl
{
    public Investigation_ReflexTest()
        : base("Investigation_ReflexTest_ascx")
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
            AutoCompleteExtender3.ContextKey = OrgID.ToString();
        }
        BindColumnsTogrdReflexorderedINV();
        BindColumnsTogrdReflexDatas();

        string strHasOrederableReflex = GetConfigValues("HasOrderableReflex", OrgID);
        if (strHasOrederableReflex == "Y")
        {
            chkIsBillable.Attributes.Add("style:display", "block");
            //chkIsBillable.Visible = false;
        }
    }

    //public void fnloadOrderedInvestigation(long vid, string ClientID, string gen)
    //{
    //    Investigation_BL Delta_BL = new Investigation_BL(new BaseClass().ContextInfo);
    //    List<OrderedInvestigations> lstOrderedInvestigations = new List<OrderedInvestigations>();
    //    List<OrderedInvestigations> lstOrderedInvestigationsParent = new List<OrderedInvestigations>();
    //    List<OrderedInvestigations> lstOrderedInvestigationsReflex = new List<OrderedInvestigations>();
    //    JavaScriptSerializer serializer = new JavaScriptSerializer();
    //    try
    //        {
    //        Delta_BL.GetPatientOrderedInvestigation(vid, pOrgid, 0, out lstOrderedInvestigations);
    //        if (lstOrderedInvestigations.Count > 0)
    //        {
    //            lstOrderedInvestigationsParent = lstOrderedInvestigations.Where(c => c.ReferredType == " " ).ToList();
    //            lstOrderedInvestigationsReflex = lstOrderedInvestigations.Where(c => c.ReferredType != " ").ToList();
    //            grdReflexOrderedInv.DataSource = lstOrderedInvestigationsParent;
    //            grdReflexOrderedInv.DataBind();                 
    //            hdnLstInvestigationQueueReflex.Value = serializer.Serialize(lstOrderedInvestigationsReflex);                                                             
    //            AutoCompleteExtender3.ContextKey = "COM" + "~" + ClientID + "~" + "N" + "~" + "" + "~" + gen;                
    //            ModalPopupExtender2.Show();
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while Reflex Test Added", ex);
    //    }
    //}

    private void BindColumnsTogrdReflexorderedINV()
    {
        DataTable Dt = new DataTable();
        //Dt.Columns.Add("S.No");
        Dt.Columns.Add("ID");
        Dt.Columns.Add("Name");
        Dt.Rows.Add();

        grdReflexordINV.DataSource = Dt;
        grdReflexordINV.DataBind();

    }

    private void BindColumnsTogrdReflexDatas()
    {
        DataTable Dt1 = new DataTable();

        Dt1.Columns.Add("Select");
        Dt1.Columns.Add("ID");
        Dt1.Columns.Add("Accession Number");
        Dt1.Columns.Add("Investigation Name");
        Dt1.Columns.Add("Status");
        Dt1.Rows.Add();

        grdReflexOrderedInv.DataSource = Dt1;
        grdReflexOrderedInv.DataBind();
        //grdReflexOrderedInv.Rows[0].Visible = false;
        grdReflexOrderedInv.Style.Add("visibility", "hidden");

    }

    public void saveInvestigationQueue(List<PatientInvestigation> lstReflex)
    {
        try
        {
            List<InvestigationQueue> lstInvestigationQueue = new List<InvestigationQueue>();
            List<InvestigationQueue> InvQueue = new List<InvestigationQueue>();
            List<InvestigationQueue> InvQueue1 = new List<InvestigationQueue>();
            List<FinalBill> lstFinalBill = new List<FinalBill>();
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            FinalBill objFinalBill;
            string strLstInvestigationQueue = hdnLstInvestigationQueue.Value;
            lstInvestigationQueue = serializer.Deserialize<List<InvestigationQueue>>(strLstInvestigationQueue);
            InvestigationQueue objInvest;
            long FinalbillId = -1;
            long returnCode = -1;
            long returnCode1 = -1;
            //List<InvestigationQueue> lstNewSample = lstInvestigationQueue.FindAll(P => P.Status == InvStatus.ReflexWithNewSample).ToList();
            List<InvestigationQueue> lstSameSample = lstInvestigationQueue.FindAll(P => P.Status == InvStatus.ReflexWithSameSample).ToList();

            if (lstInvestigationQueue.Count() > 0)
            {
                foreach (InvestigationQueue oInvestigationQueue in lstInvestigationQueue)
                {
                    objInvest = new InvestigationQueue();
                    objInvest.VisitID = Convert.ToInt64(visitID);
                    objInvest.UID = gUID;
                    objInvest.OrgID = OrgID;
                    objInvest.InvestigationID = oInvestigationQueue.InvestigationID;
                    objInvest.Type = oInvestigationQueue.Type;
                    objInvest.Status = oInvestigationQueue.Status;
                    objInvest.AccessionNumber = oInvestigationQueue.AccessionNumber;
                    objInvest.IsReportable = oInvestigationQueue.IsReportable;
                    objInvest.IsBillable = oInvestigationQueue.IsBillable;
                    objInvest.CreatedBy = LID;
                    objInvest.ParentName = oInvestigationQueue.ParentName;
                    objInvest.ParentInvId = oInvestigationQueue.ParentInvId;
                    InvQueue.Add(objInvest);
                }
                if (InvQueue.Count() > 0)
                {
                    InvBL = new Investigation_BL(base.ContextInfo);
                    returnCode = InvBL.SaveInvestigationQueue(InvQueue, OrgID);
                }
                if (lstInvestigationQueue.Count() > 0)
                {
                    foreach (InvestigationQueue oInvestigationQueue in lstInvestigationQueue)
                     {
                         objInvest = new InvestigationQueue();
                         objInvest.VisitID = Convert.ToInt64(visitID);
                         objInvest.UID = gUID;
                         objInvest.OrgID = OrgID;
                         objInvest.InvestigationID = oInvestigationQueue.InvestigationID;
                         objInvest.Type = oInvestigationQueue.Type;
                         objInvest.Status = oInvestigationQueue.Status;
                         objInvest.AccessionNumber = oInvestigationQueue.AccessionNumber;
                         objInvest.IsReportable = oInvestigationQueue.IsReportable;
                         objInvest.IsBillable = oInvestigationQueue.IsBillable;
                         objInvest.CreatedBy = LID;
                         objInvest.ParentName = oInvestigationQueue.ParentName;
                         objInvest.ParentInvId = oInvestigationQueue.ParentInvId;
                         if (objInvest.IsBillable == "Y")
                         {
                             InvQueue1.Add(objInvest);
                         }
                     }
                    if (InvQueue1.Count() > 0)
                    {
                        InvBL = new Investigation_BL();
                        returnCode1 = InvBL.SaveReFlexItemBilling(InvQueue1, OrgID, out lstFinalBill, base.ContextInfo);

                        if (lstFinalBill.Count() > 0)
                        {
                            foreach (FinalBill oFinalBill in lstFinalBill)
                            {
                              
                                ActionManager objActionManager = new ActionManager(base.ContextInfo);
                                PageContextkey PC = new PageContextkey();
                                PC.ButtonName = "btnReflexBilling";
                                PC.ButtonValue = "ReflexBilling";
                                PC.FinalBillID = oFinalBill.FinalBillID;
                                PC.BillNumber = oFinalBill.FinalBillID.ToString();
                                //PC.ID = Convert.ToInt64(ILocationID);
                                //PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
                                PC.RoleID = Convert.ToInt64(RoleID);
                                PC.OrgID = OrgID;
                                PC.PatientVisitID = oFinalBill.VisitID;
                                PC.PageID = Convert.ToInt64(PageID);
                                objActionManager.PerformingNextStepNotification(PC, "", "");
                            }
                        }
                    }
                }
            }
            if (lstSameSample.Count() > 0)
            {
                long orgId1 = OrgID;
                List<OrderedInvestigations> ordInves = new List<OrderedInvestigations>();
                foreach (InvestigationQueue oInvestigationQueue in lstSameSample)
                {
                    OrderedInvestigations objOrderInvest = new OrderedInvestigations();
                    objOrderInvest.ID = oInvestigationQueue.InvestigationID;
                    objOrderInvest.Name = oInvestigationQueue.InvestigationName;
                    objOrderInvest.VisitID = Convert.ToInt64(visitID);
                    objOrderInvest.Status = "SampleReceived";
                    objOrderInvest.PaymentStatus = "Paid";
                    objOrderInvest.CreatedBy = LID;
                    objOrderInvest.Type = oInvestigationQueue.Type;
                    objOrderInvest.OrgID = OrgID;
                    objOrderInvest.LabNo = LabNo;
                    objOrderInvest.ReferenceType = "F";
                    objOrderInvest.ReferedToLocation = ILocationID;
                    //Added By Prasanna.S to Save Labno in orderedinvestigation
                    objOrderInvest.ComplaintId = Convert.ToInt32(LabNo);
                    if (!String.IsNullOrEmpty(gUID))
                    {
                        objOrderInvest.UID = gUID;
                    }
                    objOrderInvest.ReferralID = oInvestigationQueue.AccessionNumber;
                    objOrderInvest.StudyInstanceUId ="0";
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
                    InvBL.GetInvestigationSamplesCollect(Convert.ToInt64(visitID), OrgID, RoleID, GUID, ILocationID, 22, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList, out lstSampleContainer);

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

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Reflex Test Added", ex);
        }
    }

    public void saveBatchwiseInvestigationQueue(List<PatientInvestigation> lstReflex)
    {
        try
        {
            List<InvestigationQueue> lstInvestigationQueue = new List<InvestigationQueue>();
            List<InvestigationQueue> InvQueue = new List<InvestigationQueue>();
            List<InvestigationQueue> InvQueue1 = new List<InvestigationQueue>();
             List<FinalBill> lstFinalBill = new List<FinalBill>();
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            FinalBill objFinalBill;
            string strLstInvestigationQueue = hdnLstInvestigationQueue.Value;
            lstInvestigationQueue = serializer.Deserialize<List<InvestigationQueue>>(strLstInvestigationQueue);
            InvestigationQueue objInvest;

            long returnCode = -1;
            long returnCode1 = -1;
            long FinalbillId = -1;
            //List<InvestigationQueue> lstNewSample = lstInvestigationQueue.FindAll(P => P.Status == InvStatus.ReflexWithNewSample).ToList();
            List<InvestigationQueue> lstSameSample = lstInvestigationQueue.FindAll(P => P.Status == InvStatus.ReflexWithSameSample).ToList();

            if (lstInvestigationQueue.Count() > 0)
            {
                foreach (InvestigationQueue oInvestigationQueue in lstInvestigationQueue)
                {
                    objInvest = new InvestigationQueue();
                    objInvest.VisitID = oInvestigationQueue.VisitID;
                    objInvest.UID = oInvestigationQueue.UID;
                    objInvest.OrgID = OrgID;
                    objInvest.InvestigationID = oInvestigationQueue.InvestigationID;
                    objInvest.Type = oInvestigationQueue.Type;
                    objInvest.Status = oInvestigationQueue.Status;
                    objInvest.AccessionNumber = oInvestigationQueue.AccessionNumber;
                    objInvest.IsReportable = oInvestigationQueue.IsReportable;
                    objInvest.IsBillable = oInvestigationQueue.IsBillable;
                    objInvest.CreatedBy = LID;
                    objInvest.ParentName = oInvestigationQueue.ParentName;
                    objInvest.ParentInvId = oInvestigationQueue.ParentInvId;
                    InvQueue.Add(objInvest);
                }
                if (InvQueue.Count() > 0)
                {
                    InvBL = new Investigation_BL(base.ContextInfo);
                    returnCode = InvBL.SaveInvestigationQueue(InvQueue, OrgID);
                }
            }
            if (lstInvestigationQueue.Count() > 0)
            {
                foreach (InvestigationQueue oInvestigationQueue in lstInvestigationQueue)
                {
                    objInvest = new InvestigationQueue();
                    objInvest.VisitID = oInvestigationQueue.VisitID;
                    objInvest.UID = oInvestigationQueue.UID;
                    objInvest.OrgID = OrgID;
                    objInvest.InvestigationID = oInvestigationQueue.InvestigationID;
                    objInvest.Type = oInvestigationQueue.Type;
                    objInvest.Status = oInvestigationQueue.Status;
                    objInvest.AccessionNumber = oInvestigationQueue.AccessionNumber;
                    objInvest.IsReportable = oInvestigationQueue.IsReportable;
                    objInvest.IsBillable = oInvestigationQueue.IsBillable;
                    objInvest.CreatedBy = LID;
                    objInvest.ParentName = oInvestigationQueue.ParentName;
                    objInvest.ParentInvId = oInvestigationQueue.ParentInvId;
                    if (objInvest.IsBillable == "Y")
                    {
                        InvQueue1.Add(objInvest);
                    }
                }
                if (InvQueue1.Count() > 0)
                {
                    InvBL = new Investigation_BL();
                    returnCode1 = InvBL.SaveReFlexItemBilling(InvQueue1, OrgID,out lstFinalBill, base.ContextInfo);

                    if (lstFinalBill.Count() > 0)
                    {
                        foreach (FinalBill oFinalBill in lstFinalBill)
                        {
                            objFinalBill = new FinalBill();
                            ActionManager objActionManager = new ActionManager(base.ContextInfo);
                            PageContextkey PC = new PageContextkey();
                            PC.ButtonName = "btnReflexBilling";
                            PC.ButtonValue = "ReflexBilling";
                            PC.FinalBillID = oFinalBill.FinalBillID;
                            PC.BillNumber = oFinalBill.FinalBillID.ToString();
                            //PC.ID = Convert.ToInt64(ILocationID);
                            //PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
                             PC.RoleID = Convert.ToInt64(RoleID);
                             PC.OrgID = OrgID;
                             PC.PatientVisitID = oFinalBill.VisitID;
                            PC.PageID = Convert.ToInt64(PageID);
                            objActionManager.PerformingNextStepNotification(PC, "", "");
                        }
                    }
                }
            }
            if (lstSameSample.Count() > 0)
            {
                long orgId1 = OrgID;
                List<OrderedInvestigations> ordInves = new List<OrderedInvestigations>();
                foreach (InvestigationQueue oInvestigationQueue in lstSameSample)
                {
                    OrderedInvestigations objOrderInvest = new OrderedInvestigations();
                    objOrderInvest.ID = oInvestigationQueue.InvestigationID;
                    objOrderInvest.Name = oInvestigationQueue.InvestigationName;
                    objOrderInvest.VisitID = oInvestigationQueue.VisitID;
                    objOrderInvest.Status = "SampleReceived";
                    objOrderInvest.PaymentStatus = "Paid";
                    objOrderInvest.CreatedBy = LID;
                    objOrderInvest.Type = oInvestigationQueue.Type;
                    objOrderInvest.OrgID = OrgID;
                    objOrderInvest.LabNo = oInvestigationQueue.LabNo;
                    objOrderInvest.ReferenceType = "F";
                    objOrderInvest.ReferedToLocation = ILocationID;
                    //Added By Prasanna.S to Save Labno in orderedinvestigation
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
                    InvBL = new Investigation_BL();
                    returnCode = InvBL.SaveOrderedInvestigation(ordInves, orgId1);

                    List<InvestigationQueue> lstInvDetails = (from s in lstSameSample
                                                              select new InvestigationQueue { VisitID = s.VisitID, UID = s.UID }).Distinct().ToList();
                    List<PatientInvestigation> lstPatientInvestigation;
                    List<InvSampleMaster> lstInvSampleMaster;
                    List<InvDeptMaster> lstInvDeptMaster;
                    List<CollectedSample> lstOrderedInvSample;
                    List<RoleDeptMap> lstRoleDept;
                    List<InvDeptMaster> deptList;
                    List<PatientInvSample> lstPatientInvSample;
                    List<SampleAttributes> lstSampleAttributes;
                    List<InvestigationValues> lstInvestigationValues;
                    List<InvestigationSampleContainer> lstSampleContainer;
                    List<PatientInvestigation> SaveInvestigation;
                    int pOrderedCount;
                    foreach (InvestigationQueue oInvestigationQueue in lstInvDetails)
                    {
                        lstPatientInvestigation = new List<PatientInvestigation>();
                        lstInvSampleMaster = new List<InvSampleMaster>();
                        lstInvDeptMaster = new List<InvDeptMaster>();
                        lstOrderedInvSample = new List<CollectedSample>();
                        lstRoleDept = new List<RoleDeptMap>();
                        deptList = new List<InvDeptMaster>();
                        lstPatientInvSample = new List<PatientInvSample>();
                        lstSampleAttributes = new List<SampleAttributes>();
                        lstInvestigationValues = new List<InvestigationValues>();
                        lstSampleContainer = new List<InvestigationSampleContainer>();
                        SaveInvestigation = new List<PatientInvestigation>();
                        pOrderedCount = -1;
                        InvBL.GetInvestigationSamplesCollect(oInvestigationQueue.VisitID, OrgID, RoleID, oInvestigationQueue.UID, ILocationID, 22, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList, out lstSampleContainer);

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
                            else
                            {
                                GUID = string.Empty;
                            }
                        }
                        if (SaveInvestigation.Count > 0)
                        {
                            returnCode = InvBL.SavePatientInvestigation(SaveInvestigation, OrgID, GUID, out pOrderedCount);
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Reflex Test Added", ex);
        }
    }


    protected void grdReflexOrderedInv_RowDataBound(Object sender, GridViewRowEventArgs e)
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
    public string GetConfigValues(string strConfigKey, int OrgID)
    {
        string strConfigValue = string.Empty;
        try
        {
            Int32 orgId = 0;
            
            orgId = OrgID;
             
            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(strConfigKey, orgId, out lstConfig);
            if (lstConfig.Count > 0)
                strConfigValue = lstConfig[0].ConfigValue;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    } 
}
