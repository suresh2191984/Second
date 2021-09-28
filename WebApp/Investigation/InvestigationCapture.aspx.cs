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

public partial class Investigation_CheckDisplay :BasePage
{
    public Investigation_CheckDisplay()
        : base("Investigation_InvestigationCapture_aspx")
    {
    }

    #region Initialization
    int pOrderedCount = -1;
  //  UserControl BioControl = null;
    //Control HematControl = null;
   // int PatternID = 0;
    string fileName = string.Empty;
    ArrayList lstControl = new ArrayList();
    ArrayList lstpatternID = new ArrayList();
    Control myControl = null;
    //List<OrderedInvestigations> lstOrdered = new List<OrderedInvestigations>();
    //List<InvestigationStatus> header = new List<InvestigationStatus>();
    List<PatientInvestigation> lstInvFiles = new List<PatientInvestigation>();
   // bool Selected = false;
    long vid = 0;
    long returnCode = -1;
   // long lresult = -1;
   // bool valid = false;

    List<InvestigationValues> lstHemat1 = new List<InvestigationValues>();
    List<InvestigationValues> lstHemat2 = new List<InvestigationValues>();
    List<InvestigationValues> lstHemat3 = new List<InvestigationValues>();
    List<InvestigationValues> lstHemat4 = new List<InvestigationValues>();
    List<InvestigationValues> lstHemat5 = new List<InvestigationValues>();
    List<InvestigationValues> lstHemat6 = new List<InvestigationValues>();
    List<InvestigationValues> lstFluid = new List<InvestigationValues>();
    List<InvestigationValues> lstWidel = new List<InvestigationValues>();
    List<InvestigationValues> lstCast = new List<InvestigationValues>();
    List<InvestigationValues> lstDiff = new List<InvestigationValues>();
    List<InvestigationValues> lstclinic12 = new List<InvestigationValues>();
    List<InvestigationValues> lstclinic13 = new List<InvestigationValues>();
    List<InvestigationValues> lstANA = new List<InvestigationValues>();
  
    List<InvestigationValues> lstMicBioPattern1 = new List<InvestigationValues>();
    List<InvestigationValues> lstFACellsPattern = new List<InvestigationValues>();
    List<InvestigationValues> lstFAChemistryPattern = new List<InvestigationValues>();
    List<InvestigationValues> lstFAImmunologyPattern = new List<InvestigationValues>();
    List<InvestigationValues> lstFACytologyPattern = new List<InvestigationValues>();
    List<InvestigationValues> lstFSmearPattern = new List<InvestigationValues>();


#endregion
    Investigation_BL DemoBL ;
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
    
    string gUID = string.Empty;
    string LabNo = string.Empty;
    string deptID=string.Empty;
    string InvCount = string.Empty;
    string REType = string.Empty;


    protected void Page_Load(object sender, EventArgs e)
    {
        DemoBL = new Investigation_BL(base.ContextInfo);
        try
        {
            if ((Request.QueryString["gUID"] != null) && (Request.QueryString["gUID"] != ""))
            {
                gUID = Request.QueryString["gUID"].ToString();
            }
            if ((Request.QueryString["DeptID"] != null) && (Request.QueryString["DeptID"] != ""))
            {
                deptID = Request.QueryString["DeptID"].ToString();
            }
            if ((Request.QueryString["LNO"] != null) && (Request.QueryString["LNO"] != ""))
            {
                LabNo = Request.QueryString["LNO"].ToString();
            }
            else if ((!string.IsNullOrEmpty(Request.QueryString["RNo"])))
            {
                LabNo = Request.QueryString["RNo"].ToString();
            }
            if ((Request.QueryString["REType"] != null) && (Request.QueryString["REType"] != ""))
            {
                REType = Request.QueryString["REType"].ToString();
            }
            vid = Convert.ToInt64(hdnVID.Value);
            if (!IsPostBack)
            {
                int j = 0;
                for (int i = 2009; i <= 2020; i++)
                {
                    ddlSearchYear.Items.Insert(j, Convert.ToString(i));
                    ddlSearchYear.Items[j].Value = Convert.ToString(i);
                    j += 1;
                }
                ddlSearchYear.SelectedValue = Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year.ToString();
                //List<PatientInvestigation> lstSampleDept1 = new List<PatientInvestigation>();
                //List<PatientInvSample> lstSampleDept2 = new List<PatientInvSample>();
                long pVisitID = 0;
                Int64.TryParse(Request.QueryString["vid"], out pVisitID);

                /* Commented by venkat
                new Investigation_BL(base.ContextInfo).GetWayToMethodKit(pVisitID, OrgID, RoleID, out lstSampleDept1, out lstSampleDept2);
                //returncode = new Investigation_BL(base.ContextInfo).GetWayToMethodKit(RoleID, OrgID, deptID, out display);
                if (lstSampleDept2.Count > 0)
                {
                    hdnHeaderName.Value = "";
                }
                if (lstSampleDept1.Count > 0)
                {
                    foreach (var item in lstSampleDept1)
                    {
                        if (item.Display == "Y")
                        {
                            hdnHeaderName.Value = "";
                            break;
                        }
                        else
                        {
                            hdnHeaderName.Value = "Imaging";
                        }
                    }
                }
                if (hdnHeaderName.Value == "Imaging")
                {
                    lnkCollectMoreSample.Visible = false;
                }
                  */
            }

            //if (Request.QueryString["vid"] != null)
            //{
            //    

            //    //Get the no.of investigations ordered and status(specific to an org.)
            //    DemoBL.GetInvestigatonCapture(10, OrgID,139, out lstOrdered, out header);
            //}
            //if (IsPostBack) //Commented by venky no need of this code heres
            //{
            //    DemoBL.GetInvestigatonCapture(vid, OrgID, RoleID, out lstOrdered, out header);
            //}

            if (!IsPostBack)
            {
                if (Request.QueryString["vid"] != null)
                {


                    Int64.TryParse(Request.QueryString["vid"].ToString(), out vid);
                    txtSearchTxt.Text = vid.ToString();
                    pnlSerch.Style.Add("display", "none");
                    tblReferred.Style.Add("display", "none");
                    btnGo_Click(sender, e);

                    long returnCode = -1;
                    //List<PatientVisit> visitList = new List<PatientVisit>();
                    //PatientVisit_BL visitBL = new PatientVisit_BL(base.ContextInfo);
                    //Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                    //returnCode = patientBL.GetLabVisitDetails(vid, OrgID, out visitList);
                    
                    //Code Comment by venkat
                    //List<Physician> lstPhysician = new List<Physician>();
                    //returnCode = visitBL.GetDoctorsForLab(OrgID, out lstPhysician);
                    //Code Comment by venkat ends
                    
                    //ddlDoctor.DataSource = lstPhysician;
                    //ddlDoctor.DataTextField = "PhysicianName";
                    //ddlDoctor.DataValueField = "PhysicianID";
                    //ddlDoctor.DataValueField = "LoginID";
                    //ddlDoctor.DataBind();
                    //ddlDoctor.Items.Insert(ddlDoctor.Items.Count, "Others");
                    //ddlDoctor.Items.Insert(ddlDoctor.Items.Count, "None");
                    //ddlDoctor.Items.Insert(ddlDoctor.Items.Count, "Self");

                    // code added for Updating Ref.Doc - begin
                    //ddlDoctor.SelectedValue = visitList[0].PhysicianID.ToString();
                    //ddlDoctor.Attributes.Add("onchange", "javascript:datachanged('"+ ddlDoctor.ClientID +"');");
                    // code added for Updating Ref.Doc - ends

                    //code added of sample not given drp - begins
                    //BindSampeStatusData();
                    //code added of sample not given drp - ends

                }
            }   
            hypLnkPrint.NavigateUrl = "PrintLabWorkList.aspx?vid=" + vid + "&gUID=" + gUID;
            if (RoleName == RoleHelper.SrLabTech)
            {
                IsTaskPicked();
            }

            if ((Request.QueryString["InvCount"] != null) && (Request.QueryString["InvCount"] != ""))
            {
                InvCount = Request.QueryString["InvCount"].ToString();
                if (InvCount == "1")
                {
                    foreach (GridViewRow item in GrdInv.Rows)
                    {
                        CheckBox chkInvID = (CheckBox)item.FindControl("chkSel");
                        HiddenField lblInvID = (HiddenField)item.FindControl("lblAccessionNumber");
                       
                            if (HdnInvID.Value != "")
                                HdnInvID.Value += "," + lblInvID.Value;
                            else
                                HdnInvID.Value += lblInvID.Value;
                        
                        
                    }
                    btnFinish_Click(sender, e);
                     
                    //Response.Redirect("../KernelV2/#!/resultcapture-new?vid=" + vid + "&pid=" + hdnPID.Value + "&gUID=" + gUID + "&LNo=" + LabNo + "&Invid=" + HdnInvID.Value + "&DeptID=" + deptID + "&POrgID=" + OrgID, true);

                }
            }
        }
        catch (Exception EX)
        {
            CLogger.LogError("Error in InvestigationCapture Page", EX);
        }
    }
    private void IsTaskPicked()
    {
        long AssignedTo = -1;
        Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
        investigationBL.GetTaskPickedByDetails(vid, LID, out AssignedTo);
        if (AssignedTo != -1 && AssignedTo != 0 && AssignedTo != LID && AssignedTo == 1)
        {
            Response.Redirect("~/Lab/Home.aspx?alert=y",true);
        }
        
    }
    protected void Button1_Click(object sender, EventArgs e)
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


    protected void btncheck_Click(object sender, EventArgs e)
    {


        


    }


    protected void btnFinish_Click(object sender, EventArgs e)
    {
       
        try
        {
            List<InvestigationValues> lstInvestigation = new List<InvestigationValues>();
            foreach (GridViewRow item in GrdInv.Rows)
            {
                CheckBox chkInvID = (CheckBox)item.FindControl("chkSel");
                HiddenField lblInvID = (HiddenField)item.FindControl("lblAccessionNumber");
                if (chkInvID.Checked)
                {                   
                    if (HdnInvID.Value != "")
                        HdnInvID.Value += "," + lblInvID.Value;
                    else
                        HdnInvID.Value += lblInvID.Value;
                }
                /*when No Check Box is selected All IDs are stored in Hiddenfield(HdnAllInvID) and it's value is passed in query string*/
                /*All IDs stored Region Start*/
                if (chkInvID.Enabled == true)
                {
                    if (HdnAllInvID.Value != "")
                        HdnAllInvID.Value += "," + lblInvID.Value;
                    else
                        HdnAllInvID.Value += lblInvID.Value;
                }
                /*All IDs stored Region End*/
            }

            //string strConfigKey = "NormalFlow";
            //string configValue = GetConfigValue(strConfigKey,OrgID);

            //if (configValue == "True")
            //{
               //Excecute this code if Groupmapping is not done for the corresponding organisation
                Investigation_BL InvestigationBL = new Investigation_BL(base.ContextInfo);
                List<PatientInvestigation> listOfInvestigations = new List<PatientInvestigation>();

                //InvestigationBL.GetInvestigationForVisit(vid, OrgID, out listOfInvestigations);

                //List<PatientInvestigation> orderedInves = GetOrderedList(); old code change by venkat

                List<PatientInvestigation> orderedInves = new List<PatientInvestigation>();  GetOrderedList();
                List<PatientInvestigation> patInves = new List<PatientInvestigation>();
                List<PatientInvestigation> SaveInvestigation = new List<PatientInvestigation>();
              
                if (orderedInves.Count > 0)
                {
                    foreach (PatientInvestigation patient in orderedInves)
                    {
                        PatientInvestigation objInvest = new PatientInvestigation();
                        objInvest.InvestigationID = patient.InvestigationID;
                        objInvest.InvestigationName = patient.InvestigationName;
                        objInvest.PatientVisitID = vid;
                        objInvest.GroupID = patient.GroupID;
                        objInvest.GroupName = patient.GroupName;
                        //objInvest.Status = "Paid";
                        objInvest.Status = "SampleReceived";
                        objInvest.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                        objInvest.CreatedBy = LID;
                        objInvest.Type = patient.Type;
                        objInvest.OrgID = OrgID;
                        SaveInvestigation.Add(objInvest);
                    }
                }

                //Check wether already inserted data in Patient Investigation table for current visit
                //if (listOfInvestigations.Count() == 0)
                //{
                    //Save investigations into patient Investigstion table                

                    Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
                    invbl.GetInvestigationSamplesCollect(vid, OrgID, RoleID, gUID, ILocationID,63, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList, out lstSampleContainer);
          
                    foreach (PatientInvestigation patient in lstPatientInvestigation)
                    {
                         
                        PatientInvestigation objInvest = new PatientInvestigation();
                        objInvest.InvestigationID = patient.InvestigationID;
                        objInvest.InvestigationName = patient.InvestigationName;
                        objInvest.PatientVisitID = patient.PatientVisitID;
                        objInvest.GroupID = patient.GroupID;
                        objInvest.GroupName = patient.GroupName;
                        objInvest.Status = patient.Status;
                        objInvest.CollectedDateTime = patient.CreatedAt;
                        objInvest.CreatedBy = LID;
                        objInvest.Type = patient.Type;
                        objInvest.OrgID = OrgID;
                        objInvest.InvestigationMethodID = 0;
                        objInvest.KitID = 0;
                        objInvest.InstrumentID = 0;
                        objInvest.UID = patient.UID;
                        SaveInvestigation.Add(objInvest);
                    }
                    if (lstPatientInvestigation.Count > 0)
                    {
                        if (lstPatientInvestigation[0].UID != null)
                        {
                            gUID = lstPatientInvestigation[0].UID;
                        }
                    }




               //// code added for updating Ref. Doctor - begins

               //     if (hdnRefDoctor.Value != "" && hdnRefDoctor.Value != null)
               //     {
               //         Int32 physicianID = Convert.ToInt32(hdnRefDoctor.Value);
               //         long pVisitID = 0;
               //         Int64.TryParse(Request.QueryString["vid"], out pVisitID);

               //         returnCode = new Investigation_BL(base.ContextInfo).UpdateRefDoctorName(pVisitID, physicianID, OrgID);
               //     }
               //// code added for updating Ref. Doctor - ends


                    // code addded for Sample Not given status - begin
                    //returnCode = UpdateSampleStatus();
                    // code addded for Sample Not given status - ends


                if (SaveInvestigation.Count > 0)
                {
                   

                    returnCode = new Investigation_BL(base.ContextInfo).SavePatientInvestigation(SaveInvestigation, OrgID,gUID, out pOrderedCount);
                }
                if ((returnCode == 0) || (returnCode == -1 && SaveInvestigation.Count == 0))
                {
                    if (HdnInvID.Value == "")
                    {
                    HdnInvID.Value = HdnAllInvID.Value;
                }
                string configValue = GetConfigValue("AngularPage", OrgID);
                if (configValue !="Y")
                {
                    /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                    string configResultValue = GetConfigValue("LabTech_Complete_Validate_Approval", OrgID);
                    if (configResultValue == "Y" && RoleName == "Physician Assistant")
                    {
                        Response.Redirect("InvestigationResultsCaptureBulk.aspx?vid=" + vid + "&pid=" + hdnPID.Value + "&gUID=" + gUID + "&LNo=" + LabNo + "&Invid=" + HdnInvID.Value + "&DeptID=" + deptID + "&POrgID=" + OrgID, true);
                    }
                    else
                    {
                        Response.Redirect("InvestigationResultsCapture.aspx?vid=" + vid + "&pid=" + hdnPID.Value + "&gUID=" + gUID + "&LNo=" + LabNo + "&Invid=" + HdnInvID.Value + "&DeptID=" + deptID + "&POrgID=" + OrgID, true);
                    }
                    /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                }
                else
                {
                    Response.Redirect("../KernelV2/#!/resultcapture-new/" + vid + "/" + hdnPID.Value + "/" + gUID + "/" + LabNo + "/" + HdnInvID.Value + "/" + deptID + "/" + OrgID, true);
                }
                //Response.Redirect("../KernelV2/#!/resultcapture-new?vid=" + vid + "&pid=" + hdnPID.Value + "&gUID=" + gUID + "&LNo=" + LabNo + "&Invid=" + HdnInvID.Value + "&DeptID=" + deptID + "&POrgID=" + OrgID, true);
            }
            //}
            //else
            //{
            //    returnCode = -1;
            //    List<PatientInvestigation> orderedInves = GetOrderedList();
            //    List<PatientInvestigation> patInves = new List<PatientInvestigation>();

            //    foreach (PatientInvestigation patient in orderedInves)
            //    {
            //        PatientInvestigation objInvest = new PatientInvestigation();
            //        objInvest.InvestigationID = patient.InvestigationID;
            //        objInvest.InvestigationName = patient.InvestigationName;
            //        objInvest.PatientVisitID = vid;
            //        objInvest.GroupID = patient.GroupID;
            //        objInvest.GroupName = patient.GroupName;
            //        objInvest.Status = "Paid";
            //        objInvest.CreatedBy = LID;
            //        objInvest.Type = patient.Type;
            //        objInvest.OrgID = OrgID;
            //        patInves.Add(objInvest);
            //    }

            //    returnCode = new Investigation_BL(base.ContextInfo).SavePatientInvestigation(patInves, OrgID, out pOrderedCount);
            //    if (returnCode == 0)
            //    {
            //        Response.Redirect("InvestigationResultsCapture.aspx?vid=" + vid, true);
            //    }
            //}

        }

        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            //ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
           // CLogger.LogError("Error in InvestigationCapture.aspx.cs, while executing SavePatientInvSampleResults", ex);
        }
    }
    public List<PatientInvestigation> GetOrderedList()
    {
        List<PatientInvestigation> lstpatInves = new List<PatientInvestigation>();
        PatientInvestigation PatientInves;
        long id = 0;
        string hidValue = iconHid.Value;
        string strInvName = string.Empty;
        foreach (string splitString in hidValue.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');

                if (lineItems.Length > 2)
                {
                        PatientInves = new PatientInvestigation();
                        id = Convert.ToInt64(lineItems[0]);
                        strInvName = lineItems[1];
                        string type = lineItems[2];
                        PatientInves.Type = type;
                        if (type.ToUpper() == "INV")
                        {
                            PatientInves.InvestigationID = id;
                            PatientInves.InvestigationName = strInvName;
                        }
                        lstpatInves.Add(PatientInves);
                }
            }
        }
        return lstpatInves;
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            if (RoleName == RoleHelper.SrLabTech)
            {
                updateTaskPickedBy("1");
            }
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtSearchTxt.Text != "")
            {
                FetchDetail();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Enter Only numeric value to search", ex);
        }
    }
    public string GetConfigValue(string configKey,int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();
        
        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
    protected void GrdInv_RowBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            OrderedInvestigations PI = (OrderedInvestigations)e.Row.DataItem;
            if (PI.Status == "Completed" || PI.Status == "Approve" || PI.Status == "Retest" || PI.Status == "Validate" || PI.Status == "OutSource" || PI.Status == "SampleTransferred")
            {
                /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                if (RoleName != "Physician Assistant" || PI.Status == "Approve")
                {
                    ((CheckBox)e.Row.Cells[0].FindControl("chkSel")).Enabled = false;
                }
                /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
            }
            //if ((PI.Type == "GRP") || (PI.Type == "PKG"))
            //{
            //    ((CheckBox)e.Row.Cells[0].FindControl("chkSel")).Enabled = false; ;
            //}
            if (HdnTestCheckBoxId.Value == "")
            {
                if (((CheckBox)e.Row.FindControl("chkSel")).Enabled == true)
                {

                    HdnTestCheckBoxId.Value = ((CheckBox)e.Row.FindControl("chkSel")).ClientID;
                }
            }
            else
            {
                if (((CheckBox)e.Row.FindControl("chkSel")).Enabled == true)
                {
                    HdnTestCheckBoxId.Value += '~' + ((CheckBox)e.Row.FindControl("chkSel")).ClientID;
                }
            }
        }
    }
    //code added for grdinv page index change - begins

    private void FetchDetail()
    {
        hdnVID.Value = txtSearchTxt.Text;
        vid = Convert.ToInt64(hdnVID.Value);
        PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo);
        Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
        //Statement Added to change Search by BillID and VisitID
        string year = ddlSearchYear.SelectedValue;
        patientVisitBL.GetVisitIDByBillID(vid, OrgID, year, out vid);
        //end of statement
        hdnVID.Value = vid.ToString();
        vid = Convert.ToInt64(hdnVID.Value);

        List<PatientVisit> visitList = new List<PatientVisit>();

        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        returnCode = patientBL.GetLabVisitDetails(vid, OrgID, out visitList);

        if (visitList.Count > 0)
        {
            dInves.Style.Add("display", "block");
            DrName.Text = visitList[0].ReferingPhysicianName;
            HospitalName.Text = visitList[0].HospitalName;

            if (visitList[0].CollectionCentreName != null && visitList[0].CollectionCentreName != "")
            {
                trCC.Style.Add("display", "table");
                CollectionCentre.Text = visitList[0].CollectionCentreName;
            }
            else
            {
                trCC.Style.Add("display", "none");
            }
            if (visitList[0].ExternalVisitID != null)
            {
               // lblVisitNo.Text = visitList[0].ExternalVisitID.ToString();
            }
            else
            {
               // lblVisitNo.Text = vid.ToString();
            }
            //lblPatientName.Text = visitList[0].TitleName + " " + visitList[0].PatientName;
           // lblPatientNo.Text = Convert.ToString(visitList[0].PatientNumber);
            //lblDate.Text = Convert.ToString(visitList[0].VisitDate.ToString("dd/MM/yyyy"));
            hdnPID.Value = Convert.ToString(visitList[0].PatientID);
            if (visitList[0].Sex == "M")
            {
               // lblGender.Text = "[Male]";
            }
            else
            {
               // lblGender.Text = "[Female]";
            }
           // lblAge.Text = visitList[0].PatientAge.ToString();
            

        }
        else
        {
            dInves.Style.Add("display", "none");
        }
        List<OrderedInvestigations> tmplstorderInv = new List<OrderedInvestigations>();
        List<OrderedInvestigations> lstorderInv = new List<OrderedInvestigations>();
        //DemoBL.GetInvestigatonCapture(vid, OrgID, RoleID, out lstOrdered, out header);
        LoginDetail objLoginDetail = new LoginDetail();
        objLoginDetail.LoginID = LID;
        objLoginDetail.RoleID = RoleID;
        objLoginDetail.Orgid = OrgID;        

        DemoBL.GetInvestigationSamplesCollect(vid, OrgID, RoleID, gUID,ILocationID,63, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList, out lstSampleContainer);
        DemoBL.GetInvestigationForVisit(vid, OrgID, ILocationID, objLoginDetail, out tmplstorderInv);
        lstorderInv = tmplstorderInv.FindAll(P=>P.Status!= InvStatus.WithholdCompletion);
        if (REType == "WHResultEntry")
        {
            lstorderInv = tmplstorderInv.FindAll(P => P.Status == InvStatus.WithholdCompletion);
        }
        else
        {
            lstorderInv = tmplstorderInv.FindAll(P => P.Status != InvStatus.WithholdCompletion);
        }
        if (lstPatientInvestigation.Count > 0)
        {
            int departID = Convert.ToInt32(deptID);
            dlInvName.DataSource = lstPatientInvestigation;
            dlInvName.DataBind();
            ordInvTab.Style.Add("display", "block");
            if (Convert.ToInt32(deptID) == -1)
            {
                List<OrderedInvestigations> FilterValue = new List<OrderedInvestigations>();
                IEnumerable<OrderedInvestigations> FilterValue20 = (from list in lstorderInv
                                                           group list by new
                                                           {
                                                               list.AccessionNumber,
                                                               list.InvestigationID,
                                                               list.InvestigationName,
                                                               list.Status,
                                                               list.UID,
                                                               list.ResCaptureLoc,
                                                               list.DisplayStatus
                                                               

                                                           } into g1
                                                           select new OrderedInvestigations
                                                           {                                                              
                                                               AccessionNumber = g1.Key.AccessionNumber,
                                                               InvestigationID = g1.Key.InvestigationID,
                                                               InvestigationName = g1.Key.InvestigationName,
                                                               Status = g1.Key.Status   ,
                                                               UID=g1.Key.UID,
                                                               ResCaptureLoc=g1.Key.ResCaptureLoc,
                                                               DisplayStatus=g1.Key.DisplayStatus

                                                           }).ToList();
                FilterValue = FilterValue20.ToList();
                GrdInv.DataSource = FilterValue.FindAll(O => O.UID == gUID && O.ResCaptureLoc == ILocationID);
            }
            else
            {
                GrdInv.DataSource = lstorderInv.FindAll(O => O.UID == gUID && O.ResCaptureLoc == ILocationID && O.DeptID == deptID);
            }
            //&& O.DeptID == deptID 
            GrdInv.DataBind();
            CheakInv.Style.Add("display", "table");
        }
        else
        {
            ordInvTab.Style.Add("display", "none");
        }
        
        investigationBL.GetInvestigationValues(vid, OrgID, gUID, out lstInvestigationValues);
        if (lstInvestigationValues.Count > 0)
        {
            grdResult.DataSource = lstInvestigationValues;
            grdResult.DataBind();
            //resultValuesTab.Style.Add("display", "block");
        }
        else
        {
            resultValuesTab.Style.Add("display", "none");
        }
        //List<PatientInvestigation> lstInvestigations = new List<PatientInvestigation>();
        //investigationBL.GetInvestigationByClientID(OrgID, 0, "INV", out lstInvestigations);
        //if (lstInvestigations.Count > 0)
        //{
        //    listINV.Visible = true;
        //    lblInvestigation.Visible = true;
        //    listINV.DataSource = lstInvestigations;
        //    listINV.DataTextField = "InvestigationName";
        //    listINV.DataValueField = "InvestigationID";
        //    listINV.DataBind();
        //}
        if (lstPatientInvestigation.Count > 0)
        {
            ucSCTab.Style.Add("display", "table");
            lblResult.Visible = false;
        }
        else
        {
            lblResult.Visible = true;
            ucSCTab.Style.Add("display", "none");
        }
        completeDIV.Style.Add("display", "block");

        //string strConfigKey = "NormalFlow";
        //string configValue = GetConfigValue(strConfigKey, OrgID);
        //if (configValue == "Y")
        //{
        //    listINV.Visible = false;
        //    lblInvestigation.Visible = false;
        //}
        //else
        //{
        //listINV.Visible = true;
        //lblInvestigation.Visible = true;
        //}
        string hdnVal = HdnInvID.Value; 
        if (RoleName == RoleHelper.SrLabTech)
        {
            
            updateTaskPickedBy("0");
        }

    }

    private void updateTaskPickedBy(string Type)
    {
                new Investigation_BL(base.ContextInfo).UpdateTaskPickedByDetails(Type, vid, LID);
    }

    protected void GrdInv_PageSelectedIndexChange(object sender, GridViewPageEventArgs e )
    {
        try
        {
            GrdInv.PageIndex = e.NewPageIndex;
            FetchDetail();
          
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Investigation result Entry pageIndex", ex);
        }

    }
    protected void dlInvName_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        string strRR = Resources.Investigation_ClientDisplay.Investigation_InvestigationCapture_aspx_02 == null ? "RR" : Resources.Investigation_ClientDisplay.Investigation_InvestigationCapture_aspx_02;
        string strRC = Resources.Investigation_ClientDisplay.Investigation_InvestigationCapture_aspx_03 == null ? "RC" : Resources.Investigation_ClientDisplay.Investigation_InvestigationCapture_aspx_03;
        string strRF = Resources.Investigation_ClientDisplay.Investigation_InvestigationCapture_aspx_04 == null ? "RF" : Resources.Investigation_ClientDisplay.Investigation_InvestigationCapture_aspx_04;

        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Label lblStatus = (Label)e.Item.FindControl("lblStatus");
            Label lblDisplayStatus = (Label)e.Item.FindControl("lblDisplayStatus");
            Label lblInvName = (Label)e.Item.FindControl("lblInvName");
           // Label Label1 = (Label)e.Item.FindControl("Label1");
           // Label Label2 = (Label)e.Item.FindControl("Label2");
            Label lblPackageName = (Label)e.Item.FindControl("lblPackageName");
            Label status = (Label)e.Item.FindControl("lblPatientStatus");
            PatientInvestigation oPINV = (PatientInvestigation)e.Item.DataItem;
            lblPackageName.Text = String.IsNullOrEmpty(oPINV.PackageName) ? string.Empty : "<br/><span style='padding-left:25px;font-size:9px;'>(" + oPINV.PackageName + ")</span>";

            if (status.Text == "Recheck")
            {
                status.Text = strRR.Trim();
                status.BackColor = System.Drawing.Color.Yellow;
                status.ForeColor = System.Drawing.Color.Black;
            }
            if (status.Text == "Retest")
            {
                status.Text = strRC.Trim();
                status.BackColor = System.Drawing.Color.Yellow;
                status.ForeColor = System.Drawing.Color.Black;
            }
            if (lblStatus.Text == "OutSource")
            {
                lblInvName.ForeColor = System.Drawing.Color.OrangeRed;
                lblStatus.ForeColor = System.Drawing.Color.OrangeRed;
                lblDisplayStatus.ForeColor = System.Drawing.Color.OrangeRed;
                Label1.ForeColor = System.Drawing.Color.OrangeRed;
                Label2.ForeColor = System.Drawing.Color.OrangeRed;
            }
             if (lblStatus.Text == "Recheck")
            {
                status.Text = strRR.Trim();
                status.BackColor = System.Drawing.Color.Yellow;
                status.ForeColor = System.Drawing.Color.Black;
            }
            if (status.Text == "ReflexTest")
            {
                status.Text = strRF.Trim();
                status.BackColor = System.Drawing.Color.Yellow;
                status.ForeColor = System.Drawing.Color.Black;
            }
        }
    }
    //code added for grdinv page index change - ends

    // code addded for Sample Not given status - begin
    //private long UpdateSampleStatus()
    //{
    //    List<SampleTracker> lstST = new List<SampleTracker>();
    //    SampleTracker ST = new SampleTracker();
    //    long returnCode = -1;
    //    long VisitID = 0;
    //    Int64.TryParse(Request.QueryString["vid"], out VisitID);
    //    for (int i = 0; i < grdSampleNotGiven.Rows.Count; i++)
    //    {
    //        GridViewRow row = grdSampleNotGiven.Rows[i];
    //        bool isChecked = ((CheckBox)row.FindControl("chkSelect")).Checked;
    //        if (isChecked)
    //        {
    //            DropDownList drpSampleStatus = (DropDownList)row.FindControl("drpSampleStatus");
    //            HiddenField hdnSampleID = (HiddenField)row.FindControl("HdnSampleID");
    //            ST.SampleID = Convert.ToInt32(hdnSampleID.Value);
    //            ST.InvSampleStatusID = Convert.ToInt32(drpSampleStatus.SelectedValue);
    //            ST.PatientVisitID = VisitID;
    //            ST.OrgID = OrgID;
    //            lstST.Add(ST);
    //        }
    //    }
    //    returnCode = new Investigation_BL(base.ContextInfo).SaveSampleTrackerStatus(lstST);
    //    return returnCode;
    //}
    //protected void btnUpdateSampleStatus_Click(object sender, EventArgs e)
    //{
    //    long returnCode = UpdateSampleStatus();
    //    List<SampleTracker> lstST = new List<SampleTracker>();
    //    Investigation_BL invBL = new Investigation_BL(base.ContextInfo);
    //    HdnCheckBoxId.Value = "";
    //    HdnDropDownId.Value = "";
    //    returnCode = invBL.GetSampleNotGiven(OrgID, vid, out lstST);
    //    if (lstST.Count > 0)
    //    {
    //        tbltrSampleNotGiven.Visible = true;
    //        ACX2responses3.Visible = true;
    //        grdSampleNotGiven.DataSource = lstST;
    //        grdSampleNotGiven.DataBind();
    //    }
    //    else
    //    {
    //        tbltrSampleNotGiven.Visible = false;
    //        ACX2responses3.Visible = false;
    //    }
    //}
    //private void BindSampeStatusData()
    //{
    //    List<SampleTracker> lstST = new List<SampleTracker>();
    //    Investigation_BL invBL = new Investigation_BL(base.ContextInfo);
    //    returnCode = invBL.GetSampleNotGiven(OrgID, vid, out lstST);
    //    if (lstST.Count > 0)
    //    {
    //        tbltrSampleNotGiven.Visible = true;
    //        ACX2responses3.Visible = true;
    //        grdSampleNotGiven.DataSource = lstST;
    //        grdSampleNotGiven.DataBind();
    //    }
    //    else
    //    {
    //        tbltrSampleNotGiven.Visible = false;
    //        ACX2responses3.Visible = false;
    //    }
    //}

    //protected void grdSampleNotGiven_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        ((DropDownList)e.Row.FindControl("drpSampleStatus")).Attributes.Add("disabled", "true");
    //        ((CheckBox)e.Row.FindControl("chkSelect")).Attributes.Add("onclick", "javascript:EnableSampleDropDown('" + ((CheckBox)e.Row.FindControl("chkSelect")).ClientID + "','" + ((DropDownList)e.Row.FindControl("drpSampleStatus")).ClientID + "');");
    //        if (HdnCheckBoxId.Value == "")
    //        { HdnCheckBoxId.Value = ((CheckBox)e.Row.FindControl("chkSelect")).ClientID; }
    //        else { HdnCheckBoxId.Value += '~' + ((CheckBox)e.Row.FindControl("chkSelect")).ClientID; }

    //        if (HdnDropDownId.Value == "")
    //        { HdnDropDownId.Value = ((DropDownList)e.Row.FindControl("drpSampleStatus")).ClientID; }
    //        else { HdnDropDownId.Value += '~' + ((DropDownList)e.Row.FindControl("drpSampleStatus")).ClientID; }
    //    }

    //    if (e.Row.RowType == DataControlRowType.Header)
    //    {
    //        ((CheckBox)e.Row.FindControl("chkSelectAll")).Attributes.Add("onclick", "javascript:SelectAll('" + ((CheckBox)e.Row.FindControl("chkSelectAll")).ClientID + "')");
    //    }
    //}
    // code addded for Sample Not given status - ends

    
}


