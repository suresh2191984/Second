using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Text;
using System.Security.Cryptography;
using System.Web.UI.HtmlControls;
using Attune.Podium.SmartAccessor;


public partial class Patient_PatientEMRPackage : BasePage
{
    long visitID = -1;
    long patientID = -1;
    long taskID = -1;
    long returnCode = -1;
    bool blDig = true;
    bool blInves = true;
    Control myControl = null;
    List<PatientVitals> lstPatientVitals = new List<PatientVitals>();
    List<PatientExaminationAttribute> lstPEA = new List<PatientExaminationAttribute>();
    List<PatientExaminationAttribute> lstskin = new List<PatientExaminationAttribute>();
    List<PatientExaminationAttribute> lsthair = new List<PatientExaminationAttribute>();
    List<VitalsUOMJoin> lstVitalsUOMJoin = new List<VitalsUOMJoin>();
    List<PatientDiagnosticsAttribute> lstPDA = new List<PatientDiagnosticsAttribute>();
    List<PatientDiagnosticsAttribute> lstDiagonistics = new List<PatientDiagnosticsAttribute>();
    List<PatientExaminationAttribute> lstExam = new List<PatientExaminationAttribute>();
    List<PatientExaminationAttribute> lstAttribute = new List<PatientExaminationAttribute>();
    string btnVisible = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        Table tblResult = null;
        TableRow tr = null;
        TableCell tc = null;
        scm1.RegisterAsyncPostBackControl (tcEMR);
        if (Request.QueryString["pvid"] != null)
        {
            Int64.TryParse(Request.QueryString["pvid"], out visitID);
        }
        else
        {
            Int64.TryParse(Request.QueryString["vid"], out visitID);
        }
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        tbOrderInv.Visible = false;
        if (!IsPostBack)
        {
            try
            {
                #region load Exam
                tcEMR.ActiveTab = tpHistory;
                tbOrderInv.Visible = false;
                returnCode = new SmartAccessor(base.ContextInfo).GetPatientExamPackage(visitID, OrgID, out lstPEA, out lstVitalsUOMJoin, out lstExam, out lstAttribute);
                List<Patient> lstPatient = new List<Patient>();
                Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                Patient patient = new Patient();
                patientBL.GetPatientDetailsPassingVisitID(visitID, out lstPatient);
                if (lstPatient.Count > 0)
                    hdnSex.Value = lstPatient[0].SEX;

                if (Request.QueryString["vid"] != null && Request.QueryString["pid"] != null)
                {
                    PatientVitalsControl.VisitID = visitID;
                    if (lstVitalsUOMJoin.Count > 0)
                    {
                        PatientVitalsControl.LoadControls("U", patientID);
                    }
                    else
                    {
                        PatientVitalsControl.LoadControls("I", patientID);
                    }
                    if (lstPEA.Count > 0)
                    {
                        ucSkin.SetData(lstPEA);

                        ucHair.SetData(lstPEA);

                        ucNails.SetData(lstPEA);

                        ucScars.SetData(lstPEA);

                        ucEye.SetData(lstPEA);

                        ucEar.SetData(lstPEA);

                        ucFoot.SetData(lstPEA);

                        ucNeck.SetData(lstPEA);

                        ucRS.SetData(lstPEA);

                        OralCavity1.SetData(lstPEA);

                        NeurologicaExamination1.SetData(lstPEA);

                        RectalExamination1.SetData(lstPEA);

                        CardiovascularExam1.SetData(lstPEA);

                        AbdominalExam1.SetData(lstPEA);

                        //if (lstPatient[0].SEX == "M")
                        //{
                        //    GynaecologicalExam1.Visible = false;
                        //}
                        //else
                        //{
                        //    GynaecologicalExam1.SetData(lstPEA);
                        //}
                    }
                    else
                    {

                        //if (lstPatient[0].SEX == "M")
                        //{
                        //    GynaecologicalExam1.Visible = false;
                        //}
                        //else
                        //{
                        //    GynaecologicalExam1.SetData(lstPEA);
                        //}
                    }
                }

                if (lstAttribute.Count > 0)
                {

                    ucSkin.EditData(lstAttribute);

                    ucHair.EditData(lstAttribute);

                    ucNails.EditData(lstAttribute);

                    ucScars.EditData(lstAttribute);

                    ucEye.EditData(lstAttribute);

                    ucEar.EditData(lstAttribute);

                    ucFoot.EditData(lstAttribute);

                    ucNeck.EditData(lstAttribute);

                    ucRS.EditData(lstAttribute);

                    OralCavity1.EditData(lstAttribute);

                    NeurologicaExamination1.EditData(lstAttribute);

                    RectalExamination1.EditData(lstAttribute);

                    CardiovascularExam1.EditData(lstAttribute);

                    AbdominalExam1.EditData(lstAttribute);



                }

                #endregion



                #region Load DIAGNOSTICS
                returnCode = new SmartAccessor(base.ContextInfo).GetPatientDiagnosticsPackage(visitID, OrgID, out lstPDA, out lstDiagonistics);
                Diagnosticsl1.SetData(lstPDA);
                if (lstDiagonistics.Count > 0)
                {
                    Diagnosticsl1.EditData(lstDiagonistics);
                }
                //Diagnosticsl1.BindDropDown();

                //Diagnosticsl1.SetData(lstPDA);
                //Diagnosticsl1.BindDropDown();
                blDig = false;
                #endregion

                #region Load History
                ucHistory.LoadHistoryData(visitID);
                ucHistory.EditHistoryData(visitID);
                #endregion

                #region Load Investigation

                //List<InvGroupMaster> lstgroups = new List<InvGroupMaster>();
                //List<InvestigationMaster> lstInvestigations = new List<InvestigationMaster>();
                //new Investigation_BL(base.ContextInfo).GetInvestigationData(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.orgSpecific), out lstgroups, out lstInvestigations);
                //int orgBased = OrgID;
                //InvestigationControl1.OrgSpecific = orgBased;
                //InvestigationControl1.LoadDatas(lstgroups, lstInvestigations);

                List<PatientVisit> lPatientVisit = new List<PatientVisit>();
                int clientID = 0;
                new PatientVisit_BL(base.ContextInfo).GetCorporateClientByVisit(visitID, out lPatientVisit);
                if (lPatientVisit.Count > 0)
                {
                    clientID =Convert.ToInt32(lPatientVisit[0].ClientMappingDetailsID);
                }
                //Load Data's to investigation Control
                List<InvGroupMaster> lstgroups = new List<InvGroupMaster>();
                List<InvestigationMaster> lstInvestigations = new List<InvestigationMaster>();

                new Investigation_BL(base.ContextInfo).GetInvestigationDatabyComplaint(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.orgSpecific), 0, clientID, out lstgroups, out lstInvestigations);
                int orgBased = OrgID;
                //InvestigationControl1.OrgSpecific = orgBased;

                //inv comment for Health Screening ---
               // InvestigationControl1.LoadDatas(lstgroups, lstInvestigations);
                blInves = false;
                //InvestigationControl1.CtrlVisible = false;
                #endregion

                //#region Retrieve Ordered Investigations

                //List<OrderedInvestigations> lstOrderedInves = new List<OrderedInvestigations>();
                //List<OrderedInvestigations> oInvestigations = new List<OrderedInvestigations>();
                //new Investigation_BL(base.ContextInfo).GetOrderedInvestigation(OrgID, visitID, out lstOrderedInves, out oInvestigations);
                //if (oInvestigations.Count > 0)
                //{
                //    InvestigationControl1.loadOrderedList(oInvestigations);
                //}
                //#endregion
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Page Load", ex);
            }
        }
        else
        {
            blDig = false;
            blInves = false;
        }
    }

    //protected Control bind1(List<PatientExaminationAttribute> lstPEA)
    //{
    //    Control testpattern = null;
    //    TableRow row = new TableRow();
    //    TableCell cell = new TableCell();
    //    Table tbl = new Table();
    //    TableRow tr;
    //    TableCell tc;
    //    //testpattern = (IEMR)LoadControl("~/EMR/examinationpattern.ascx");
    //    try
    //    {
    //        var list = from S in lstPEA
    //                   where S.ExaminationID == 928
    //                   select S;
    //        CheckBox ChkBox = new CheckBox();
    //        tbl.BorderWidth = 1;
    //        tbl.CellPadding = 4;
    //        tbl.CellSpacing = 4;
    //        tbl.Width = 100;
    //        tbl.CssClass = "dataheaderInvCtrl";
            
    //        tr = new TableRow();
    //        tc = new TableCell();
    //        ChkBox.ID = "chk" + lstPEA[0].ExaminationID+ "";
            
    //        ChkBox.Text = lstPEA[0].ExaminationName;
    //        tc.ColumnSpan = 3;
    //        tc.Controls.Add(ChkBox);
    //        tr.Cells.Add(tc);
    //        tbl.Rows.Add(tr);
            
    //        tc = new TableCell();
    //        tr = new TableRow();            
            
    //        List<EMRAttributeClass> typelist = (from s in list
    //                                            where s.AttributeID == 1
    //                                            select new EMRAttributeClass
    //                                            {
    //                                                AttributeName = s.AttributeName,
    //                                                AttributevalueID = s.AttributevalueID,
    //                                                AttributeValueName = s.AttributeValueName
    //                                            }).ToList();

    //      //  testpattern.Attributeone = typelist[0].AttributeName;
    //        Label lbltype= new Label();
    //        //tc = new TableCell();
    //        //Label lbl = new Label();
    //        //lbl.Text = "Show";
    //        //tc.Controls.Add(lbl);
    //        //tr.Cells.Add(tc);
    //        lbltype.Text = typelist[0].AttributeName;
    //        tc.Controls.Add(lbltype);
    //        tc.Width = 100;
    //        tr.Cells.Add(tc);
    //        DropDownList DDL = new DropDownList();
    //        DDL.DataSource = typelist;
    //        DDL.DataTextField = "AttributeValueName";
    //        DDL.DataValueField = "AttributevalueID";
    //        DDL.DataBind();
           
    //        HtmlGenericControl div = new HtmlGenericControl();
    //        div.ID = "div" + typelist[0].AttributeID+ "";
    //        ChkBox.Attributes.Add("onclick", "showContent(" + lstPEA[0].ExaminationID + "," + typelist[0].AttributeID + ")");
    //        tr.ID = "tr" + typelist[0].AttributeID + "";
    //        tc = new TableCell();           
    //        tc.Controls.Add(DDL);
    //        tr.Cells.Add(tc);
    //        List<EMRAttributeClass> Lessionslist = (from s in list
    //                                                where s.AttributeID == 2
    //                                                select new EMRAttributeClass
    //                                                {
    //                                                    AttributeName = s.AttributeName,
    //                                                    AttributevalueID = s.AttributevalueID,
    //                                                    AttributeValueName = s.AttributeValueName
    //                                                }).ToList();
    //        //testpattern.Attributetwo = Lessionslist[0].AttributeName;
    //        //testpattern.bind(typelist, Lessionslist);
    //        tc = new TableCell();
    //        Label lbllessions = new Label();
    //        lbllessions.Text = Lessionslist[0].AttributeName;
    //        tc.Controls.Add(lbllessions);
    //        tr.Cells.Add(tc);
    //        DropDownList DDLtype = new DropDownList();
    //        DDLtype.DataSource = Lessionslist;
    //        DDLtype.DataTextField = "AttributeValueName";
    //        DDLtype.DataValueField = "AttributevalueID";
    //        DDLtype.DataBind();            
    //        tc = new TableCell();
    //        tc.Controls.Add(DDLtype);
    //        tr.Cells.Add(tc);
    //        //div.Controls.Add(tr);
    //        tbl.Controls.Add(tr);
    //        //cell.Controls.Add(tbl);
    //        //row.Cells.Add(cell);
    //        //drawNewPattern.Rows.Add(row);
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error occured in bind function", ex);
    //    }
    //    return tbl;
      
    //}
    //protected void History_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        Response.Redirect(@"../Patient/PatientHistoryPackage.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&emr=" + "HIS", true);
    //    }
    //    catch (System.Threading.ThreadAbortException tae)
    //    {
    //        string ta = tae.ToString();
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in Redirect to EMR History Page", ex);
    //    }
    //}
    //protected void Examination_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        Response.Redirect(@"../Patient/PatientExaminationPackage.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&emr=" + "EXM", true);
    //    }
    //    catch (System.Threading.ThreadAbortException tae)
    //    {
    //        string ta = tae.ToString();
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
    //    }
    //}
    protected void btnBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(@"../Patient/PatientEMRPackage.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
        }
    }
    protected void btnEMRExam_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(@"../Patient/PatientExaminationPackage.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&emr=" + "EXM", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PatientExaminationPackage", ex);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        try
        {
            btnSave.Enabled = false;
            #region SaveInvestigation
            List<OrderedInvestigations> lstPatientInvestigationHL = new List<OrderedInvestigations>();
            List<OrderedInvestigations> lstPatientInvestHL = new List<OrderedInvestigations>();
            lstPatientInvestHL = InvestigationControl1.GetINVListHOSLAB();
            List<OrderedInvestigations> orderedInvesHL = new List<OrderedInvestigations>();
            //List<PatientInvestigation> lstPI = new List<PatientInvestigation>();
            if (lstPatientInvestHL.Count > 0)
            {
                foreach (OrderedInvestigations inves in lstPatientInvestHL)
                {
                    OrderedInvestigations objInvest = new OrderedInvestigations();
                    //PatientInvestigation objPinv = new PatientInvestigation();
                    objInvest.ID = inves.ID;
                    //objPinv.InvestigationID = inves.ID;
                    objInvest.Name = inves.Name;
                    //objPinv.InvestigationName = inves.Name;
                    objInvest.VisitID = visitID;
                    //objPinv.PatientVisitID = visitID;
                    objInvest.OrgID = OrgID;
                    objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                    objInvest.Status = "Ordered";
                    objInvest.CreatedBy = LID;
                    objInvest.Type = inves.Type;
                    orderedInvesHL.Add(objInvest);
                    //lstPI.Add(objPinv);
                }
                
            }
            int pOrderedInvCnt = 0;
            string paymentstatus = "Pending";
            string gUID = Guid.NewGuid().ToString();
            string labno = string.Empty;
            
            //long retCode = new Investigation_BL(base.ContextInfo).SavePatientInvestigation(lstPI, OrgID, gUID, out pOrderedInvCnt); 
            //returnCode = new Investigation_BL(base.ContextInfo).SaveOrderedInvestigationHOS(orderedInvesHL, OrgID, out pOrderedInvCnt, paymentstatus, gUID, labno);
            //if (pOrderedInvCnt > 0)
            //{
            //    List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            //    returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
            //    Hashtable dText = new Hashtable();
            //    Hashtable urlVal = new Hashtable();
            //    Tasks task = new Tasks();
            //    Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);

            //    returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
            //    returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), visitID, 0,
            //        patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber,gUID);
                
            //    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.InvestigationPayment);
            //    task.DispTextFiller = dText;
            //    task.URLFiller = urlVal;
            //    task.RoleID = RoleID;
            //    task.OrgID = OrgID;
            //    task.PatientVisitID = visitID;
            //    task.PatientID = patientID;
            //    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            //    task.CreatedBy = LID;
            //    //create task
            //    returnCode = taskBL.CreateTask(task, out taskID);
            //}

            #endregion

            #region Examination Save
            SmartAccessor smrtAccessor = new SmartAccessor(base.ContextInfo);
            smrtAccessor.InitForSave();

            ArrayList attList = new ArrayList();
            ArrayList attListValues = new ArrayList();

            ucSkin.GetData(out attList, out attListValues);
            if ((attList.Count > 0) && (attListValues.Count > 0))
            {
                smrtAccessor.SetAll(attList, attListValues);
            }

            ucHair.GetData(out attList, out attListValues);
            if ((attList.Count > 0) && (attListValues.Count > 0))
            {
                smrtAccessor.SetAll(attList, attListValues);
            }

            ucNails.GetData(out attList, out attListValues);
            if ((attList.Count > 0) && (attListValues.Count > 0))
            {
                smrtAccessor.SetAll(attList, attListValues);
            }

            ucScars.GetData(out attList, out attListValues);
            if ((attList.Count > 0) && (attListValues.Count > 0))
            {
                smrtAccessor.SetAll(attList, attListValues);
            }

            ucEye.GetData(out attList, out attListValues);
            if ((attList.Count > 0) && (attListValues.Count > 0))
            {
                smrtAccessor.SetAll(attList, attListValues);
            }

            ucEar.GetData(out attList, out attListValues);
            if ((attList.Count > 0) && (attListValues.Count > 0))
            {
                smrtAccessor.SetAll(attList, attListValues);
            }

            ucFoot.GetData(out attList, out attListValues);
            if ((attList.Count > 0) && (attListValues.Count > 0))
            {
                smrtAccessor.SetAll(attList, attListValues);
            }


            ucNeck.GetData(out attList, out attListValues);
            if ((attList.Count > 0) && (attListValues.Count > 0))
            {
                smrtAccessor.SetAll(attList, attListValues);
            }

            ucRS.GetData(out attList, out attListValues);
            if ((attList.Count > 0) && (attListValues.Count > 0))
            {
                smrtAccessor.SetAll(attList, attListValues);
            }

            OralCavity1.GetData(out attList, out attListValues);
            if ((attList.Count > 0) && (attListValues.Count > 0))
            {
                smrtAccessor.SetAll(attList, attListValues);
            }

            NeurologicaExamination1.GetData(out attList, out attListValues);
            if ((attList.Count > 0) && (attListValues.Count > 0))
            {
                smrtAccessor.SetAll(attList, attListValues);
            }
            if (hdnSex.Value != "M")
            {
                GynaecologicalExam1.GetData(out attList, out attListValues);
                if ((attList.Count > 0) && (attListValues.Count > 0))
                {
                    smrtAccessor.SetAll(attList, attListValues);
                }
            }
            RectalExamination1.GetData(out attList, out attListValues);
            if ((attList.Count > 0) && (attListValues.Count > 0))
            {
                smrtAccessor.SetAll(attList, attListValues);
            }

            CardiovascularExam1.GetData(out attList, out attListValues);
            if ((attList.Count > 0) && (attListValues.Count > 0))
            {
                smrtAccessor.SetAll(attList, attListValues);
            }

            AbdominalExam1.GetData(out attList, out attListValues);
            if ((attList.Count > 0) && (attListValues.Count > 0))
            {
                smrtAccessor.SetAll(attList, attListValues);
            }

            PatientVitalsControl.GetPageValues(out lstPatientVitals);
            
            returnCode = new SmartAccessor(base.ContextInfo).InsertExaminationPKG(visitID, patientID, LID, OrgID, lstPatientVitals);
            #endregion

            #region History Save
            ucHistory.SaveData();
            #endregion

            #region Diagnostics Save
            Diagnosticsl1.GetData(out attList, out attListValues);
            smrtAccessor.SetAll(attList, attListValues);

            returnCode = new SmartAccessor(base.ContextInfo).InsertDiagnosticsPKG(visitID, patientID, LID, OrgID);
            #endregion


            if (Request.QueryString["Flow"] == "HealthScreening")
            {
                btnVisible = "&Flow=HealthScreening";
            }
            else
            {
                btnVisible = "";
            }

            new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);
            Response.Redirect(@"../Patient/ViewEMRPackages.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&pSex=" + hdnSex.Value + "&Show=Y" + btnVisible + "", true);
            
           
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PatientExaminationPackage", ex);
            btnSave.Enabled = true;
        }
    }
    //protected void btnEditPatientReg_Click(object sender, EventArgs e)
    //{
    //    try
    //    {

    //        Response.Redirect(@"../Reception/PatientRegistration.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&flag=" +"Emr"+ "", true);
          
    //    }
    //    catch (System.Threading.ThreadAbortException tae)
    //    {
    //        string ta = tae.ToString();
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in PatientExaminationPackage", ex);
    //    }
    //}
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

    private string CreateUniqueDecimalString()
    {
        string uniqueDecimalString = "1.2.840.113619.";
        uniqueDecimalString += GetUniqueKey() + ".";
        uniqueDecimalString += GetUniqueKey();
        return uniqueDecimalString;
    }
    protected void LoadData()
    {
        if (tcEMR.ActiveTab.ToString() == "2")
        {
            if (blDig == true)
            {
                #region Load DIAGNOSTICS
                returnCode = new SmartAccessor(base.ContextInfo).GetPatientDiagnosticsPackage(visitID, OrgID, out lstPDA, out lstDiagonistics);
                Diagnosticsl1.SetData(lstPDA);
                if (lstDiagonistics.Count > 0)
                {
                    Diagnosticsl1.EditData(lstDiagonistics);
                }
                //Diagnosticsl1.BindDropDown();

                //Diagnosticsl1.SetData(lstPDA);
                //Diagnosticsl1.BindDropDown();
                blDig = false;
                #endregion
            }
        }
        if (tcEMR.ActiveTab.ToString() == "3")
        {
            if (blInves == true)
            {
                #region Load Investigation

                //List<InvGroupMaster> lstgroups = new List<InvGroupMaster>();
                //List<InvestigationMaster> lstInvestigations = new List<InvestigationMaster>();
                //new Investigation_BL(base.ContextInfo).GetInvestigationData(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.orgSpecific), out lstgroups, out lstInvestigations);
                //int orgBased = OrgID;
                //InvestigationControl1.OrgSpecific = orgBased;
                //InvestigationControl1.LoadDatas(lstgroups, lstInvestigations);

                List<PatientVisit> lPatientVisit = new List<PatientVisit>();
                int clientID = 0;
                new PatientVisit_BL(base.ContextInfo).GetCorporateClientByVisit(visitID, out lPatientVisit);
                if (lPatientVisit.Count > 0)
                {
                    clientID =Convert.ToInt32(lPatientVisit[0].ClientMappingDetailsID);
                }
                //Load Data's to investigation Control
                List<InvGroupMaster> lstgroups = new List<InvGroupMaster>();
                List<InvestigationMaster> lstInvestigations = new List<InvestigationMaster>();
                new Investigation_BL(base.ContextInfo).GetInvestigationDatabyComplaint(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.orgSpecific), 0, clientID, out lstgroups, out lstInvestigations);
                int orgBased = OrgID;
                InvestigationControl1.OrgSpecific = orgBased;
                InvestigationControl1.LoadDatas(lstgroups, lstInvestigations);
                blInves = false;
                #endregion
            }
        }
    }


    
    
    //protected void tcEMR_ActiveTabChanged(object sender, EventArgs e)
    //{
    //    #region load Exam
    //    tcEMR.ActiveTab = tpHistory;
    //    returnCode = new SmartAccessor(base.ContextInfo).GetPatientExamPackage(visitID, OrgID, out lstPEA, out lstVitalsUOMJoin, out lstExam, out lstAttribute);
    //    List<Patient> lstPatient = new List<Patient>();
    //    Patient_BL patientBL = new Patient_BL(base.ContextInfo);
    //    Patient patient = new Patient();
    //    patientBL.GetPatientDetailsPassingVisitID(visitID, out lstPatient);
    //    if (lstPatient.Count > 0)
    //        hdnSex.Value = lstPatient[0].SEX;

    //    if (Request.QueryString["vid"] != null && Request.QueryString["pid"] != null)
    //    {
    //        PatientVitalsControl.VisitID = visitID;
    //        if (lstVitalsUOMJoin.Count > 0)
    //        {
    //            PatientVitalsControl.LoadControls("U", patientID);
    //        }
    //        else
    //        {
    //            PatientVitalsControl.LoadControls("I", patientID);
    //        }
    //        if (lstPEA.Count > 0)
    //        {
    //            ucSkin.SetData(lstPEA);

    //            ucHair.SetData(lstPEA);

    //            ucNails.SetData(lstPEA);

    //            ucScars.SetData(lstPEA);

    //            ucEye.SetData(lstPEA);

    //            ucEar.SetData(lstPEA);

    //            ucFoot.SetData(lstPEA);

    //            ucNeck.SetData(lstPEA);

    //            ucRS.SetData(lstPEA);

    //            OralCavity1.SetData(lstPEA);

    //            NeurologicaExamination1.SetData(lstPEA);

    //            RectalExamination1.SetData(lstPEA);

    //            CardiovascularExam1.SetData(lstPEA);

    //            AbdominalExam1.SetData(lstPEA);

    //            //if (lstPatient[0].SEX == "M")
    //            //{
    //            //    GynaecologicalExam1.Visible = false;
    //            //}
    //            //else
    //            //{
    //            //    GynaecologicalExam1.SetData(lstPEA);
    //            //}
    //        }
    //        else
    //        {

    //            //if (lstPatient[0].SEX == "M")
    //            //{
    //            //    GynaecologicalExam1.Visible = false;
    //            //}
    //            //else
    //            //{
    //            //    GynaecologicalExam1.SetData(lstPEA);
    //            //}
    //        }
    //    }

    //    if (lstAttribute.Count > 0)
    //    {

    //        ucSkin.EditData(lstAttribute);

    //        ucHair.EditData(lstAttribute);

    //        ucNails.EditData(lstAttribute);

    //        ucScars.EditData(lstAttribute);

    //        ucEye.EditData(lstAttribute);

    //        ucEar.EditData(lstAttribute);

    //        ucFoot.EditData(lstAttribute);

    //        ucNeck.EditData(lstAttribute);

    //        ucRS.EditData(lstAttribute);

    //        OralCavity1.EditData(lstAttribute);

    //        NeurologicaExamination1.EditData(lstAttribute);

    //        RectalExamination1.EditData(lstAttribute);

    //        CardiovascularExam1.EditData(lstAttribute);

    //        AbdominalExam1.EditData(lstAttribute);



    //    }

    //    #endregion
    //}
}
