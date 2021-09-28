using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.DataAccessEngine;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Solution.BusinessComponent;
using System.Collections;



public partial class CommonControls_FeesEntry : BaseControl
{
    long patientVisitID = 0; long billDetailsID = -1;
    bool procedure = false;
    bool physician = false;
    bool investigation = false;
    bool immunization = false;
    long physicianID = 0;
    long procedureID = 0;
    long patientID = 0;
    long rateID = 0;
    int iCount = 0;
    int unchk = 0;
    bool loadDBData;
    string PaymentLogic = string.Empty;
    private bool isEmpty = true;
    long invClientID = 0;
    decimal zeroAmount = 0;
    long returnCode = -1;
    long taskID = -1;
    long ptaskID = -1;
    long createTaskID = -1;
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    Tasks task = new Tasks();
    Tasks_BL taskBL ;
    bool casualty = false;
    bool healthpackage = false;
    string gUID = string.Empty;
    private List<BillingFeeDetails> lstUnChecked = new List<BillingFeeDetails>();
    private List<FeeTypeMaster> lstFeeTypeMaster = new List<FeeTypeMaster>();
    long BillID = 0;
    string LabNo = string.Empty;

    Investigation_BL invbl;

    public long PatientVisitID
    {
        get { return patientVisitID; }
        set { patientVisitID = value; }
    }
    public bool Procedure
    {
        get { return procedure; }
        set { procedure = value; }
    }
    public bool Investigation
    {
        get { return investigation; }
        set { investigation = value; }
    }
    public bool Consulting
    {
        get { return physician; }
        set { physician = value; }
    }
    public bool HealthPackage
    {
        get { return healthpackage; }
        set { healthpackage = value; }
    }
    public bool Immunization
    {
        get { return immunization; }
        set { immunization = value; }
    }
    public long PhysicianID
    {
        get { return physicianID; }
        set { physicianID = value; }
    }
    public long ProcedureID
    {
        get { return procedureID; }
        set { procedureID = value; }
    }
    public long PatientID
    {
        get { return patientID; }
        set { patientID = value; }
    }
    public long RateID
    {
        get { return rateID; }
        set { rateID = value; }
    }
    public bool LoadDBData
    {
        get { return loadDBData; }
        set { loadDBData = value; }
    }
    public decimal ZeroAmt
    {
        get {
            return zeroAmount;

        }
    }
    string _sCheckAll;
    public string sCheckAll
    {
        get { return _sCheckAll; }
        set { _sCheckAll = value; }
    }
    public bool Casualty
    {
        get { return casualty; }
        set { casualty = value; }
    }

    public List<FeeTypeMaster> LstFeeTypeMaster
    {
        get { return lstFeeTypeMaster; }
        set { lstFeeTypeMaster = value; }
    }
    
    private void LoadFeeType()
    {
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);

        List<PatientVisitDetails> lstPatientVisitDetail = new List<PatientVisitDetails>();
        returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetail);
        if (lstPatientVisitDetail.Count > 0)
        {
            List<FeeTypeMaster> lstFeeTypeMaster = new List<FeeTypeMaster>();
            new BillingEngine(base.ContextInfo).GetFeeType(OrgID, (lstPatientVisitDetail[0].VisitType == 0 ? "OP" : "IP"), out lstFeeTypeMaster);

            if (lstFeeTypeMaster.Count > 0)
            {
                ddlFeeType.DataSource = lstFeeTypeMaster;
                ddlFeeType.DataTextField = "FeeTypeDesc";
                ddlFeeType.DataValueField = "FeeType";
                ddlFeeType.DataBind();
                ddlFeeType.Items.Insert(0, "--Select Type--");
            }
        }
      
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        taskBL = new Tasks_BL(base.ContextInfo);
        invbl = new Investigation_BL(base.ContextInfo);
        if (!Page.IsPostBack)
        {
            investigation = true;
            //loadData();
            LoadFeeType();
        }
        
        //AutoCompleteConsultant.ContextKey = "CON~" + OrgID.ToString() + "~" + rateID.ToString();
        AutoCompleteConsultant.ContextKey = OrgID.ToString();
        
        if (gvFeesEntry.Rows.Count > 0)
        {
            BillingFeeDetails Unchked1 = new BillingFeeDetails();
            unchk = 0;
            lstUnChecked.Clear();
            foreach (GridViewRow gr in gvFeesEntry.Rows)
            {
                if (((CheckBox)gr.FindControl("chkTest")).Checked == false)
                {
                    BillingFeeDetails Unchked = new BillingFeeDetails();
                    TextBox txtUCAmount = (TextBox)gr.FindControl("txtAmount");
                    Label lblUCDesc = (Label)gr.FindControl("lblDescription");
                    Label lblUCID = (Label)gr.FindControl("lblID");

                    long UCID = Convert.ToInt64(lblUCID.Text);
                    string UCDesc = lblUCDesc.Text;
                    Unchked.ID = UCID;
                    Unchked.Amount = Convert.ToDecimal(txtUCAmount.Text == "" ? "0" : txtUCAmount.Text);
                    Unchked.Descrip = UCDesc;
                    lstUnChecked.Insert(unchk, Unchked);
                    unchk++;
                }
            }
        }
    }

    protected void gvFeesEntry_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txt = (TextBox)e.Row.FindControl("txtAmount");
            CheckBox chk = (CheckBox)e.Row.FindControl("chkTest");

            txt.Attributes.Add("onKeyDown", "return validatenumber(event);");
            //((CheckBox)e.Row.FindControl("chkTest")).Checked = true;
            chk.Checked = true;
            Label lblisVariable = (Label)e.Row.FindControl("lblisVariable");
            Label lblIDVAL =(Label)e.Row.FindControl("lblID");

            if (lblisVariable.Text == "N")
            {
                txt.Enabled = false;
            }
            else
            {
                if (IsAmountEditable == "Y")
                {
                    txt.Enabled = true;
                }
                else
                {
                    if (decimal.Parse(txt.Text.Trim()) == 0)
                    {
                        txt.Enabled = true;
                        e.Row.BackColor = System.Drawing.Color.Tomato;
                    }
                    else
                    {
                        txt.Enabled = false;
                    }
                }
            }
            if (Consulting == true)
            {
                //((CheckBox)e.Row.FindControl("chkTest")).Enabled = false;
                chk.Enabled = false;
            }
            if (loadDBData)
            {
                e.Row.Visible = true;
            }
            else if (lblIDVAL.Text == "-1")
            {
                e.Row.Visible = true;
            }
            else if ((e.Row.RowIndex == 0) && (loadDBData == false))
            {
                //((CheckBox)e.Row.FindControl("chkTest")).Checked = false;
                if (Request.QueryString["SPP"] != "Y")
                {
                    chk.Checked = false;
                    e.Row.Visible = false;
                }
            }
            else
            {
                //((CheckBox)e.Row.FindControl("chkTest")).Enabled = false;
                //((CheckBox)e.Row.FindControl("chkTest")).Checked = true;
                chk.Enabled = false;
                chk.Checked = true;
                e.Row.Visible = true;
            }
            if (Casualty == true)
            {
                chk.Checked = false;
            }
            BillingFeeDetails bfd = (BillingFeeDetails)e.Row.DataItem;
            foreach (BillingFeeDetails pBdf in lstUnChecked)
            {
                if ((pBdf.ID == bfd.ID) && (chk.Enabled)) 
                {
                    chk.Checked = false;
                    break;
                }
            }
            if (bfd.IsChecked == "Y")
            {
                chk.Checked = true;
            }
            else if (bfd.IsChecked == "N")
            {
                chk.Checked = false;
            }

            if (bfd.IsReimbursable != "N")
            {
                ((CheckBox)e.Row.FindControl("chkIsReImbursableItem")).Checked = true;
            }
            else
            {
                ((CheckBox)e.Row.FindControl("chkIsReImbursableItem")).Checked = false;
            }
        }

        //if (e.Row.RowType == DataControlRowType.Footer)
        //{
            //TextBox txtFooterAmount = (TextBox)e.Row.FindControl("txtFooterAmount");
            //txtFooterAmount.Attributes.Add("onKeyDown", "return validatenumber(event);");
        //}
        
    }
    public void loadData()
    {
        invbl = new Investigation_BL(base.ContextInfo);
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        //Load physician fees details
        if (Request.QueryString["isDoc"] != null && Request.QueryString["isDoc"].ToString() != "")
        {
            Consulting = true;
        }
        if (Consulting)
        {
            BillingEngine billingBL = new BillingEngine(base.ContextInfo);
            List<BillingFeeDetails> lstPhysicianFees = new List<BillingFeeDetails>();
            billingBL.GetPhysicianFeesDetails(patientVisitID, PhysicianID, OrgID, out lstPhysicianFees);
            BillingFeeDetails bill = new BillingFeeDetails();
            bill.IsVariable = "Y";

            gvFeesEntry.DataSource = lstPhysicianFees;
            gvFeesEntry.DataBind();
            //lstUnChecked.Clear();
        }

        // Load procedure fees details
        if (Procedure)
        {
            BillingEngine billingBL = new BillingEngine(base.ContextInfo);
            List<BillingFeeDetails> lstProcedureFeesDetails = new List<BillingFeeDetails>();
            billingBL.GetProcedureFeesDetails(patientVisitID, ProcedureID, OrgID, out lstProcedureFeesDetails,sCheckAll);

            if (lstProcedureFeesDetails.Count > 0)
            {
                gvFeesEntry.DataSource = lstProcedureFeesDetails;
                gvFeesEntry.DataBind();
            }
            else
            {
                Int64.TryParse(Request.QueryString["tid"], out taskID);
                new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);
                List<Role> lstUserRole1 = new List<Role>();
                string path1 = string.Empty;
                Role role1 = new Role();
                role1.RoleID = RoleID;
                lstUserRole1.Add(role1);
                returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
                Response.Redirect(Request.ApplicationPath + path1, true);
            }


        }

        // Load Investigation fees details
        if (Investigation)
        {
            BillingEngine billingBL = new BillingEngine(base.ContextInfo);

            invbl.getOrgClientID(patientVisitID, out invClientID);

            List<BillingFeeDetails> lstInvestigationFeesDetails = new List<BillingFeeDetails>();
            //billingBL.GetInvestigationFeesDetails(PatientVisitID, OrgID, invClientID, out lstInvestigationFeesDetails);
            billingBL.GetOrderedInvestigationFeesDetails(PatientVisitID, OrgID, invClientID, out lstInvestigationFeesDetails);

            if (lstInvestigationFeesDetails.Count > 0)
            {
                gvFeesEntry.DataSource = lstInvestigationFeesDetails;
                gvFeesEntry.DataBind();
            }
            else
            {
                Int64.TryParse(Request.QueryString["tid"], out taskID);
                new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);
                List<Role> lstUserRole1 = new List<Role>();
                string path1 = string.Empty;
                Role role1 = new Role();
                role1.RoleID = RoleID;
                lstUserRole1.Add(role1);
                returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
                Response.Redirect(Request.ApplicationPath + path1, true);
            }
        }
        if (Immunization)
        {
            BillingEngine billingBL = new BillingEngine(base.ContextInfo);
            List<BillingFeeDetails> lstImmunization = new List<BillingFeeDetails>();
            billingBL.GetPatientBabyVaccFeeDetails(PatientVisitID, PatientID, out lstImmunization);
            if (lstImmunization.Count > 0)
            {
                gvFeesEntry.DataSource = lstImmunization;
                gvFeesEntry.DataBind();
            }
        }
        if (Casualty)
        {
            BillingEngine billingBL = new BillingEngine(base.ContextInfo);
            List<BillingFeeDetails> lstCasualtyFees = new List<BillingFeeDetails>();
            billingBL.GetCasualtyFees(OrgID, out lstCasualtyFees);
            if (lstCasualtyFees.Count > 0)
            {
                MasterControl1.Visible = true;
                MasterControl1.TableType = FeeType.type.Casuality;
                MasterControl1.Text = "ADD New Casuality";
                gvFeesEntry.DataSource = lstCasualtyFees;
                gvFeesEntry.DataBind();
            }
        }
        if (HealthPackage)
        {
            BillingEngine billingBL = new BillingEngine(base.ContextInfo);

            invbl.getOrgClientID(patientVisitID, out invClientID);

            List<BillingFeeDetails> lstInvestigationFeesDetails = new List<BillingFeeDetails>();
            //billingBL.GetInvestigationFeesDetails(PatientVisitID, OrgID, invClientID, out lstInvestigationFeesDetails);
            billingBL.GetOrderedInvestigationFeesDetails(PatientVisitID, OrgID, invClientID, out lstInvestigationFeesDetails);

            if (lstInvestigationFeesDetails.Count > 0)
            {
                gvFeesEntry.DataSource = lstInvestigationFeesDetails;
                gvFeesEntry.DataBind();
            }
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        invbl = new Investigation_BL(base.ContextInfo);
        taskBL = new Tasks_BL(base.ContextInfo); 
        BillingEngine billingBL = new BillingEngine(base.ContextInfo);

        List<SaveBillingDetails> lstBillingDetails = new List<SaveBillingDetails>();
        SaveBillingDetails save;
        
        string BillNumber = string.Empty;
        foreach (GridViewRow row in gvFeesEntry.Rows)
        {
            if (((CheckBox)row.FindControl("chkTest")).Checked == true)
            {
                decimal amount1;
                //set private variable indicating the list to be empty as false
                isEmpty = false;

                TextBox txtAmount = (TextBox)row.FindControl("txtAmount");
                Label lblDesc = (Label)row.FindControl("lblDescription");
                Label lblID = (Label)row.FindControl("lblID");
                Label lblIsGroup = (Label)row.FindControl("lblisGroup");
                Label lblFeeType = (Label)row.FindControl("lblFeeType");
                if (Request.QueryString["isDoc"] != null && Request.QueryString["isDoc"].ToString() != "")
                {
                    lblFeeType.Text = "CON";
                }

                long ID = Convert.ToInt64(lblID.Text);
                string description = lblDesc.Text;
                if (txtAmount.Text != "")
                {
                    amount1 = Convert.ToDecimal(txtAmount.Text);
                    zeroAmount += amount1;
                }
                else
                {
                    amount1 = 0;
                    zeroAmount += amount1;
                }
                string isGroup = lblIsGroup.Text;
                save = new SaveBillingDetails();

                save.ID = ID;
                save.Amount = amount1;
                save.Description = description;
                save.IsGroup = isGroup;
                save.FeeType = lblFeeType.Text.Trim();

                if (((CheckBox)row.FindControl("chkIsReImbursableItem")).Checked)
                {
                    save.IsReimbursable = "Y";
                }
                else
                {
                    save.IsReimbursable = "N";
                }

                lstBillingDetails.Add(save);
            }
        }

        if (zeroAmount != 0)
        {

            //TextBox txtFooterDescription = (TextBox)gvFeesEntry.FooterRow.FindControl("txtFooterDescription");
            //TextBox txtFooterAmount = (TextBox)gvFeesEntry.FooterRow.FindControl("txtFooterAmount");
            //if (Convert.ToDouble(txtFooterAmount.Text == "" ? "0" : txtFooterAmount.Text) > 0)
            //{
            //    //set private variable indicating the list to be empty as false
            //    isEmpty = false;

            //    save = new SaveBillingDetails();
            //    save.ID = -1;
            //    save.Description = txtFooterDescription.Text;
            //    save.Amount = Convert.ToDecimal(txtFooterAmount.Text);
            //    lstBillingDetails.Add(save);
            //}
            long billDetailsID = 0; Int64.TryParse(Request.QueryString["bdid"], out billDetailsID);
            // Save Consulting Billing information
            if (Consulting)
            {
                billingBL.CreateConsultingBillingEntry(OrgID,out BillID,out BillNumber,PatientVisitID, LID, lstBillingDetails,ILocationID, billDetailsID);
            }

            // Save Procedure billing information
            if (Procedure)
            {
                billingBL.CreateProcedureBillingEntry(OrgID,PatientVisitID,out BillID, LID, lstBillingDetails,ILocationID);
            }

            // Save Investigation billing information
            if (Investigation)
            {
                
                invbl.getOrgClientID(PatientVisitID, out invClientID);
                billingBL.CreateInvestigationBillingEntry(OrgID, out BillID, PatientVisitID, LID, invClientID, lstBillingDetails, ILocationID, out LabNo);
            }
            if (Immunization)
            {
                billingBL.CreateImmunizationBillingEntry(OrgID, out BillID, PatientVisitID, LID, lstBillingDetails,ILocationID);
            }
            if (Casualty)
            {
                billingBL.CreateCasualtyBillingEntry(OrgID, out BillID, PatientVisitID, LID, lstBillingDetails, ILocationID);
            }
            if (HealthPackage)
            {
                invbl.getOrgClientID(PatientVisitID, out invClientID);
                billingBL.CreateInvestigationBillingEntry(OrgID, out BillID, PatientVisitID, LID, invClientID, lstBillingDetails, ILocationID, out LabNo);
            }
        }
        else
        {
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int64.TryParse(Request.QueryString["ptid"], out ptaskID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            Int64.TryParse(Request.QueryString["tid"], out taskID);

            if (Convert.ToString(Request.QueryString["ftype"]) == "INV")
            {
                new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);

                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
                returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample), patientVisitID, 0,
                    patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber,lstPatientVisitDetails[0].TokenNumber,"");
                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.PatientVisitID = patientVisitID;
                task.PatientID = patientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;
                //Create task               
                returnCode = new Tasks_BL(base.ContextInfo).CreateTaskAllowDuplicate(task, out createTaskID);
            }
            else if (Convert.ToString(Request.QueryString["ftype"]) == "PRO")
            {
                returnCode = taskBL.UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
                returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(Convert.ToInt64(Request.QueryString["ptid"]), TaskHelper.TaskStatus.Pending, UID);

                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
                Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverCaseSheet), patientVisitID, 0, patientID,
                    lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "PRO", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber,"");

                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverDialysisCaseSheet);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.PatientVisitID = patientVisitID;
                task.PatientID = patientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;
                //Create collection task
                returnCode = taskBL.CreateTask(task, out createTaskID);
            }
            else
            {
                returnCode = taskBL.UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
                returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(Convert.ToInt64(Request.QueryString["ptid"]), TaskHelper.TaskStatus.Pending, UID);

                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
                Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverCaseSheet), patientVisitID, 0, patientID,
                    lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "CON", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber,"");

                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverCaseSheet);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.PatientVisitID = patientVisitID;
                task.PatientID = patientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;
                //Create collection task
                returnCode = taskBL.CreateTask(task, out createTaskID);
            }
 
        }
       // return BillID;

    }
    protected void gvFeesEntry_RowEditing(object sender, GridViewEditEventArgs e)
    {

    }

    public bool SaveFeesDetails(out long BillID)
    {
        taskBL = new Tasks_BL(base.ContextInfo);
        invbl = new Investigation_BL(base.ContextInfo);
        //Duplicate of Save Function to return BillID
        BillingEngine billingBL = new BillingEngine(base.ContextInfo);
        List<SaveBillingDetails> lstBillingDetails = new List<SaveBillingDetails>();
        SaveBillingDetails save;
        BillID = 0;
        string BillNumber = string.Empty;
        int idx = 0;
        foreach (GridViewRow row in gvFeesEntry.Rows)
        {
            if (((CheckBox)row.FindControl("chkTest")).Checked == true)
            {
                decimal amount1;
                //set private variable indicating the list to be empty as false
                isEmpty = false;

                TextBox txtAmount = (TextBox)row.FindControl("txtAmount");
                Label lblDesc = (Label)row.FindControl("lblDescription");
                Label lblID = (Label)row.FindControl("lblID");
                Label lblIsGroup = (Label)row.FindControl("lblisGroup");
                Label lblFeeType = (Label)row.FindControl("lblFeeType");
                if (Request.QueryString["isDoc"] != null && Request.QueryString["isDoc"].ToString() != "")
                {
                    lblFeeType.Text = "CON";
                }
                


                long ID = Convert.ToInt64(lblID.Text);
                string description = lblDesc.Text;
                if (txtAmount.Text != "")
                {
                    amount1 = Convert.ToDecimal(txtAmount.Text);
                    zeroAmount += amount1;
                }
                else
                {
                    amount1 = 0;
                    zeroAmount += amount1;
                }
                string isGroup = lblIsGroup.Text;
                save = new SaveBillingDetails();

                save.ID = ID;
                save.Amount = amount1;
                save.Description = description;
                save.IsGroup = isGroup;
                save.FeeType = lblFeeType.Text.Trim();
                if (((CheckBox)row.FindControl("chkIsReImbursableItem")).Checked)
                {
                    save.IsReimbursable = "Y";
                }
                else
                {
                    save.IsReimbursable = "N";
                }
                lstBillingDetails.Add(save);
            }
            idx++;
        }

        if (zeroAmount != 0)
        {

            //TextBox txtFooterDescription = (TextBox)gvFeesEntry.FooterRow.FindControl("txtFooterDescription");
            //TextBox txtFooterAmount = (TextBox)gvFeesEntry.FooterRow.FindControl("txtFooterAmount");
            //if (Convert.ToDouble(txtFooterAmount.Text == "" ? "0" : txtFooterAmount.Text) > 0)
            //{
            //    //set private variable indicating the list to be empty as false
            //    isEmpty = false;

            //    save = new SaveBillingDetails();
            //    save.ID = -1;
            //    save.Description = txtFooterDescription.Text;
            //    save.Amount = Convert.ToDecimal(txtFooterAmount.Text);
            //    lstBillingDetails.Add(save);

            //}
            long proTaskStatusID = -1;
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            List<OrderedPhysiotherapy> lstOrderedPhysiotherapy = new List<OrderedPhysiotherapy>();
            returnCode = patientBL.GetOrderedPhysio(patientID, patientVisitID, LID, out lstOrderedPhysiotherapy, out proTaskStatusID);
            if (lstOrderedPhysiotherapy.Count > 0)
            {
                foreach (var item in lstOrderedPhysiotherapy)
                {
                    save = new SaveBillingDetails();
                    save.ID = item.ProcedureID;//Procfeeid
                    save.Amount = item.ModifiedBy;
                    save.Quantity = item.OdreredQty;
                    save.Description = item.ProcedureName;
                    save.FeeType = "PRO";
                    lstBillingDetails.Add(save);

                }
                returnCode = taskBL.UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
                returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(Convert.ToInt64(Request.QueryString["ptid"]), TaskHelper.TaskStatus.Pending, UID);

                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
                Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverCaseSheet), patientVisitID, 0, patientID,
                    lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "PRO", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");

                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.PerformPhysiotherapy);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.PatientVisitID = patientVisitID;
                task.PatientID = patientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;
                gUID = Guid.NewGuid().ToString();
                //Create collection task
                returnCode = taskBL.CreateTask(task, out createTaskID);
            }

            long billDetailsID = 0; Int64.TryParse(Request.QueryString["bdid"], out billDetailsID);
            // Save Consulting Billing information
            if (Consulting)
            {
                billingBL.CreateConsultingBillingEntry(OrgID, out BillID, out BillNumber, PatientVisitID, LID, lstBillingDetails, ILocationID, billDetailsID);
            }

            // Save Procedure billing information
            if (Procedure)
            {

                billingBL.CreateProcedureBillingEntry(OrgID, PatientVisitID, out BillID, LID, lstBillingDetails,ILocationID);
            }

            // Save Investigation billing information
            if (Investigation)
            {
                invbl.getOrgClientID(PatientVisitID, out invClientID);
                billingBL.CreateInvestigationBillingEntry(OrgID, out BillID, PatientVisitID, LID, invClientID, lstBillingDetails,ILocationID, out LabNo);
            }
            if (Immunization)
            {
                billingBL.CreateImmunizationBillingEntry(OrgID, out BillID, PatientVisitID, LID, lstBillingDetails,ILocationID);
            }
            if (Casualty)
            {
                billingBL.CreateCasualtyBillingEntry(OrgID, out BillID, PatientVisitID, LID, lstBillingDetails, ILocationID);
            }
            if (HealthPackage)
            {
                invbl.getOrgClientID(PatientVisitID, out invClientID);
                billingBL.CreateInvestigationBillingEntry(OrgID, out BillID, PatientVisitID, LID, invClientID, lstBillingDetails, ILocationID, out LabNo);
            }
        }
        else
        {
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int64.TryParse(Request.QueryString["ptid"], out ptaskID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            Int64.TryParse(Request.QueryString["tid"], out taskID);

            if (Convert.ToString(Request.QueryString["ftype"]) == "INV")
            {
                new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);

                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
                returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample), patientVisitID, 0,
                    patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber,"");
                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.PatientVisitID = patientVisitID;
                task.PatientID = patientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;
                //Create task               
                returnCode = new Tasks_BL(base.ContextInfo).CreateTaskAllowDuplicate(task, out createTaskID);
            }
            else if (Convert.ToString(Request.QueryString["ftype"]) == "PRO")
            {
                returnCode = taskBL.UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
                returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(Convert.ToInt64(Request.QueryString["ptid"]), TaskHelper.TaskStatus.Pending, UID);

                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
                Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverCaseSheet), patientVisitID, 0, patientID,
                    lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "PRO", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber,"");

                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverDialysisCaseSheet);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.PatientVisitID = patientVisitID;
                task.PatientID = patientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;
                gUID = Guid.NewGuid().ToString();
                //Create collection task
                returnCode = taskBL.CreateTask(task, out createTaskID);
            }
            else if (Convert.ToString(Request.QueryString["ftype"]) == "HEALTHPKG")
            {
                List<PatientInvestigation> lstSampleDept1 = new List<PatientInvestigation>();
                List<PatientInvSample> lstSampleDept2 = new List<PatientInvSample>();
                List<InvestigationValues> lstInvResult = new List<InvestigationValues>();
                new Investigation_BL(base.ContextInfo).GetDeptToTrackSamples(patientVisitID, OrgID, RoleID, gUID, out lstSampleDept1, out lstSampleDept2);


                foreach (var item in lstSampleDept1)
                {
                    if (item.Display == "Y")
                    {
                        Int64.TryParse(Request.QueryString["pid"], out patientID);
                        long createTaskID = -1;
                        List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                        returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
                        returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample),
                                     patientVisitID, 0, patientID, lstPatientVisitDetails[0].TitleName + " " +
                                     lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                     , out dText, out urlVal, 0, "", 0,"");
                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.OrgID = OrgID;
                        task.PatientVisitID = patientVisitID;
                        task.PatientID = patientID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        //Create task               
                        returnCode = new Tasks_BL(base.ContextInfo).CreateTaskAllowDuplicate(task, out createTaskID);
                        break;

                    }
                }
                foreach (var item in lstSampleDept1)
                {
                    if (item.Display == "Y")
                    {
                        InvestigationValues inValues = new InvestigationValues();
                        inValues.InvestigationID = item.InvestigationID;
                        inValues.PerformingPhysicainName = item.PerformingPhysicainName;
                        inValues.PackageID = item.PackageID;
                        inValues.PackageName = item.PackageName;

                        lstInvResult.Add(inValues);
                    }
                }

                returnCode = new Investigation_BL(base.ContextInfo).UpdateInvestigationStatus(patientVisitID, "SampleReceived", OrgID, lstInvResult);

            }
            else
            {
                returnCode = taskBL.UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
                returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(Convert.ToInt64(Request.QueryString["ptid"]), TaskHelper.TaskStatus.Pending, UID);

                int specialityID = -1;
                int followUP = -1;
                returnCode = new ANC_BL(base.ContextInfo).GetANCSpecilaityID(patientVisitID, out specialityID, out followUP);

                if (specialityID != Convert.ToInt32(TaskHelper.speciality.ANC))
                {
                    List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                    returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
                    Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverCaseSheet), patientVisitID, 0, patientID,
                        lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "CON", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber,"");

                    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverCaseSheet);
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.RoleID = RoleID;
                    task.OrgID = OrgID;
                    task.PatientVisitID = patientVisitID;
                    task.PatientID = patientID;
                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    task.CreatedBy = LID;
                    //Create collection task
                    returnCode = taskBL.CreateTask(task, out createTaskID);
                }
            }
        }
        return isEmpty;
    }




    

    public long GetSaveFeeDetail(out List<SaveBillingDetails> lstSaveInvestigationDet)
    {
        lstSaveInvestigationDet = new List<SaveBillingDetails>();
        SaveBillingDetails save;
        foreach (GridViewRow row in gvFeesEntry.Rows)
        {
            if (((CheckBox)row.FindControl("chkTest")).Checked == true)
            {
                decimal amount1;
                TextBox txtAmount = (TextBox)row.FindControl("txtAmount");
                Label lblDesc = (Label)row.FindControl("lblDescription");
                Label lblID = (Label)row.FindControl("lblID");
                Label lblIsGroup = (Label)row.FindControl("lblisGroup");
                Label lblFeeType = (Label)row.FindControl("lblFeeType");
                long ID = Convert.ToInt64(lblID.Text);
                string description = lblDesc.Text;
                if (txtAmount.Text != "")
                {
                    amount1 = Convert.ToDecimal(txtAmount.Text);
                }
                else
                {
                    amount1 = 0;
                }
                string isGroup = lblIsGroup.Text;
                save = new SaveBillingDetails();

                save.ID = ID;
                save.Amount = amount1;
                save.Description = description;
                save.IsGroup = isGroup;
                save.FeeType = lblFeeType.Text.Trim();
                if (((CheckBox)row.FindControl("chkIsReImbursableItem")).Checked)
                {
                    save.IsReimbursable = "Y";
                }
                else
                {
                    save.IsReimbursable = "N";
                }
                lstSaveInvestigationDet.Add(save);
            }
        }

        return 0;
    }

    protected void gvFeesEntry_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

    }
    protected void gvFeesEntry_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        
        //TextBox txtFooterDescription = (TextBox)gvFeesEntry.FooterRow.FindControl("txtFooterDescription");
        //TextBox txtFooterAmount = (TextBox)gvFeesEntry.FooterRow.FindControl("txtFooterAmount");

        TextBox txtFooterDescription = (TextBox)txtFeeDesc;
        TextBox txtFooterAmount = (TextBox)txtAmnt;

        List<BillingFeeDetails> lstPhysicianFees = new List<BillingFeeDetails>();
        
        BillingFeeDetails bill1 = new BillingFeeDetails();
        iCount = 0;

        foreach (GridViewRow row in gvFeesEntry.Rows)
        {
            BillingFeeDetails bill = new BillingFeeDetails();
            Label lblSNo = (Label)row.FindControl("lblSno");
            Label lblDesc = (Label)row.FindControl("lblDescription");    
            TextBox txtAmount = (TextBox)row.FindControl("txtAmount");
            Label lblIsVariable = (Label)row.FindControl("lblisVariable");
            Label lblID = (Label)row.FindControl("lblID");
            Label lblIsGroup = (Label)row.FindControl("lblisGroup");
            CheckBox cbCheck = (CheckBox)row.FindControl("chkTest");
            Label lblFeeType = (Label)row.FindControl("lblFeeType");
            
            long ID = Convert.ToInt64(lblID.Text);
            string description = lblDesc.Text;

            bill.SNo = Convert.ToInt64(lblSNo.Text);
            bill.Descrip = description;
            bill.Amount = Convert.ToDecimal(txtAmount.Text == "" ? "0" : txtAmount.Text);
            bill.IsVariable = lblIsVariable.Text;
            bill.ID = ID;
            bill.IsGroup = lblIsGroup.Text;
            bill.FeeType = lblFeeType.Text;
            if (cbCheck.Checked == true)
            {
                bill.IsChecked = "Y";
            }
            else
            {
                bill.IsChecked = "N";
            }
            if(((CheckBox)row.FindControl("chkIsReImbursableItem")).Checked)
            {
                bill.IsReimbursable = "Y";
            }
            else{
                bill.IsReimbursable = "N";
            }
            //iCount = lstPhysicianFees.Count;
            lstPhysicianFees.Insert(iCount, bill);
            //ViewState.Add(iCount.ToString(), bill);
            iCount++;
        }
       
        bill1.Amount = Convert.ToDecimal(txtFooterAmount.Text == "" ? "0" : txtFooterAmount.Text);
        //bill1.Descrip = txtFooterDescription.Text.Trim();
        bill1.IsChecked = "Y";
        iCount = lstPhysicianFees.Count;
        bill1.FeeType = ddlFeeType.SelectedValue == "LAB" ? "INV" : ddlFeeType.SelectedValue;
        if(chkNonReimburse.Checked)
        {
            bill1.IsReimbursable = "Y";
        }else{
            bill1.IsReimbursable = "N";
        }
        if (ddlFeeType.SelectedValue.Equals("CON"))
        {
            bill1.ID = long.Parse(hdnFilterPhysicianID.Value);
            bill1.Descrip = txtConsultant.Text.Trim();
        }
        else
        {
            bill1.ID = long.Parse(hdnFeeID.Value);
            bill1.Descrip = txtName.Text.Trim();
        }
        lstPhysicianFees.Insert(iCount, bill1);
        gvFeesEntry.DataSource = lstPhysicianFees;
        gvFeesEntry.DataBind();
        hdnAmount.Value = "";

        //foreach (BillingFeeDetails bfd in lstPhysicianFees)
        //{
        //    hdnAmount.Value += bfd.Amount + "~";
        //}
        doReset();
    }

    protected void doReset()
    {
        txtFeeDesc.Text = txtAmnt.Text = txtConsultant.Text = string.Empty;
        ddlFeeType.SelectedIndex = 0;
        chkNonReimburse.Checked = true;
    }

    protected void gvFeesEntry_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    public void loadDifferenceAmount()
    {
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["bdid"], out billDetailsID);
        //Load physician fees details
        if (Consulting)
        {
            BillingEngine billingBL = new BillingEngine(base.ContextInfo);
            List<BillingFeeDetails> lstPhysicianFees = new List<BillingFeeDetails>();
            billingBL.GetPhysicianFeeDetailsReAssigned(patientVisitID, PhysicianID, OrgID, billDetailsID, out lstPhysicianFees);
            BillingFeeDetails bill = new BillingFeeDetails();
            bill.IsVariable = "Y";

            gvFeesEntry.DataSource = lstPhysicianFees;
            gvFeesEntry.DataBind();
            //lstUnChecked.Clear();
        }
    }
}
