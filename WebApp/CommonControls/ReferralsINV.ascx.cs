using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using NumberToWord;
using Attune.Solution.BusinessComponent;
using System.Collections;

public partial class CommonControls_ReferralsINV : BaseControl
{
    BillingEngine billingBL ;
    Investigation_BL invbl;
    List<BillingFeeDetails> lstProcedureFeesDetails = new List<BillingFeeDetails>();
    List<Physician> lstPhysician = new List<Physician>();
    Physician_BL PhysicianBL;
    List<Organization> lstorgs = new List<Organization>();
    List<BillingFeeDetails> lstInvestigationFeesDetails = new List<BillingFeeDetails>();
    Referrals_BL objReferrals_BL;
    PatientVisit_BL patientBL;
    List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
    private List<FeeTypeMaster> lstFeeTypeMaster = new List<FeeTypeMaster>();

    long patientVisitID = 0;
    long patientID = 0;
    int iCount = 0;
    long invClientID = 0;
    decimal zeroAmount = 0;
    long returnCode = -1;
    long taskID = -1;
    long ptaskID = -1;
    long createTaskID = -1;
    long ReferralID=0;
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    Tasks task = new Tasks();
    Tasks_BL taskBL;
    public string type { get; set; }
    public string strPaid { get; set; }
    string gUID = string.Empty;
   
    public List<FeeTypeMaster> LstFeeTypeMaster
    {
        get { return lstFeeTypeMaster; }
        set { lstFeeTypeMaster = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        taskBL = new Tasks_BL(base.ContextInfo);
        patientBL = new PatientVisit_BL(base.ContextInfo);
        objReferrals_BL = new Referrals_BL(base.ContextInfo);
        PhysicianBL = new Physician_BL(base.ContextInfo);
        invbl = new Investigation_BL(base.ContextInfo);
        if(!IsPostBack)
        {
            LoadFeeType();
        }
    }

    private void LoadFeeType()
    {
        ddlFeeType.DataSource = lstFeeTypeMaster;
        ddlFeeType.DataTextField = "FeeTypeDesc";
        ddlFeeType.DataValueField = "FeeType";
        ddlFeeType.DataBind();
        ddlFeeType.Items.Insert(0, "--Select Type--");
    }

    public long LoadInvestigations(long patientVisitID,long patientID)
    {
        invbl = new Investigation_BL(base.ContextInfo);
        long returncode = -1;
        try
        {
            invbl.getOrgClientID(patientVisitID, out invClientID);
            if (Request.QueryString["gUID"] != null)
            {
                gUID = Request.QueryString["gUID"].ToString();

            }

            List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisit);
            //AutoCompleteConsultant.ContextKey = "CON~" + OrgID.ToString() + "~" + lstPatientVisit[0].RateID.ToString();
            AutoCompleteConsultant.ContextKey = OrgID.ToString();
            billingBL = new BillingEngine(base.ContextInfo);
            billingBL.GetInvFeeDetails(patientVisitID, OrgID, invClientID, gUID,out lstInvestigationFeesDetails);


            var tempinv = from inv in lstInvestigationFeesDetails
                          orderby inv.ProcedureType
                          select inv;          
           
            if (lstInvestigationFeesDetails.Count > 0)
            {
                returncode = 0;
                gvInvestigations.DataSource = tempinv;
                gvInvestigations.DataBind();
                
            }
           

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading Investigation Fee ", ex);
        }
        return returncode;
    }

    public long LoadReferralsInvestigations( long ReferralID,long patientVisitID)
    {
        objReferrals_BL = new Referrals_BL(base.ContextInfo);
        try
        {
            new Referrals_BL(base.ContextInfo).GetOrgReferralsInvestigations(ReferralID, OrgID, ILocationID,patientVisitID, out lstInvestigationFeesDetails);
            var tempinv = from inv in lstInvestigationFeesDetails
                          orderby inv.ProcedureType
                          select inv;

            

            if (lstInvestigationFeesDetails.Count > 0)
            {
                gvInvestigations.DataSource = tempinv;
                gvInvestigations.DataBind();
                return 0;
            }
            else
            {
                returnCode = objReferrals_BL.GetALLLocation(OrgID, out lstLocation);
                OrganizationAddress obj = lstLocation.Find(p => p.Comments ==ILocationID.ToString()+"~"+ OrgID.ToString());


                gvInvestigations.DataSource = tempinv;
                gvInvestigations.EmptyDataText = "None of the Referred Investigations are performed in this " + obj.Location;
                gvInvestigations.DataBind();
                return -1;
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading Investigation Fee ", ex);
            return -1;
        }
    }

    protected void gvInvestigations_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (IsTrustedOrg == "N")
        {
            e.Row.Cells[3].Visible = false;
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            BillingFeeDetails inv = new BillingFeeDetails();
            inv = (BillingFeeDetails)e.Row.DataItem;
            DropDownList ddlPerformingOrg = (DropDownList)e.Row.FindControl("ddlPerformingOrg");
            TextBox txtAmount = ((TextBox)e.Row.FindControl("txtAmount"));
            CheckBox chk = (CheckBox)e.Row.FindControl("chkTest");
            Image imgPaid= (Image)e.Row.FindControl("imgPaid");
            loadlocations(ddlPerformingOrg, inv.ProcedureType);

            //HiddenField hdnFeeType = (HiddenField)e.Row.FindControl("hdnFeeType");
            //TextBox txtFeeType = ((TextBox)e.Row.FindControl("txtFeeType"));
            
            if (IsAmountEditable == "Y")
            {
                txtAmount.Enabled = true;
            }
            else if(Convert.ToDouble(txtAmount.Text) == 0.00)
            {
                txtAmount.Enabled = true;
            }
            else
            {
                txtAmount.Enabled = false;
            }

            if (type != "Ref")
            {

                if ((inv.ProcedureType == "Ordered") || (inv.ProcedureType == "SampleReceived") || (inv.ProcedureType == "Completed"))
                {
                    ddlPerformingOrg.SelectedValue = ILocationID.ToString() + "~" + OrgID.ToString();
                }
            }
            else
            {
                if (inv.ProcedureType == "paid")
                {
                    chk.Enabled = false;
                   
                    txtAmount.Enabled = false;
                    ddlPerformingOrg.Enabled = false;
                    imgPaid.Visible = true;
                    strPaid = "Paid";
                }
                ddlPerformingOrg.SelectedValue = ILocationID.ToString() + "~" + OrgID.ToString();
            }
            if (inv.IsChecked == "Y")
            {
                chk.Checked = true;
            }
            else if(inv.IsChecked == "N")
            {
                chk.Checked = false;
            }

            if (inv.IsReimbursable != "N")
            {
                ((CheckBox)e.Row.FindControl("chkIsReImbursableItem")).Checked = true;
            }
            else
            {
                ((CheckBox)e.Row.FindControl("chkIsReImbursableItem")).Checked = false;
            }
            //ddlPerformingOrg.Attributes.Add("onChange", "fnValues(" + ddlPerformingOrg.ClientID + "," + txtAmount.ClientID + ")");
        }
    }

    protected void loadlocations(DropDownList ddlLocation, string str)
    {
        objReferrals_BL = new Referrals_BL(base.ContextInfo);
        try
        {
            if (lstLocation.Count == 0)
            {
                returnCode = objReferrals_BL.GetALLLocation(OrgID, out lstLocation);
            }
            var tempLocation = from loc in lstLocation
                               where loc.OrgID != OrgID
                               select loc;

            if (type!="Ref")
            {
                if ((str == "Ordered") || (str == "SampleReceived") || (str == "Completed"))
                {

                    ddlLocation.DataSource = lstLocation;
                    ddlLocation.DataTextField = "Location";
                    ddlLocation.DataValueField = "Comments";
                    ddlLocation.DataBind();
                    ddlLocation.Items.Insert(0, "---Select---");
                    ddlLocation.Items[0].Value = "0~0";
                    if (lstLocation.Count == 1)
                    {
                        ddlLocation.Items[1].Selected = true;
                    }
                    else if (lstLocation.Count == 0 || lstLocation.Count > 1)
                    {
                        ddlLocation.SelectedValue = "0~0";
                    }
                }
                else
                {
                    ddlLocation.DataSource = tempLocation;
                    ddlLocation.DataTextField = "Location";
                    ddlLocation.DataValueField = "Comments";
                    ddlLocation.DataBind();
                    ddlLocation.Items.Insert(0, "---Select---");
                    ddlLocation.Items[0].Value = "0~0";

                }
            }
            else
            {
                ddlLocation.DataSource = lstLocation;
                ddlLocation.DataTextField = "Location";
                ddlLocation.DataValueField = "Comments";
                ddlLocation.DataBind();
                ddlLocation.Items.Insert(0, "---Select---");
                ddlLocation.Items[0].Value = "0";
                if (lstLocation.Count == 1)
                {
                    ddlLocation.Items[1].Selected = true;
                }
                else if (lstLocation.Count == 0 || lstLocation.Count > 1)
                {
                    ddlLocation.SelectedValue = "0~0";
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading Org ", ex);
        }







    }

    private void BindPerformingOrg(DropDownList ddlPerformingOrg)
    {
        objReferrals_BL = new Referrals_BL(base.ContextInfo);
        try
        {
            if (lstLocation.Count == 0)
            {
                returnCode = objReferrals_BL.GetALLLocation(OrgID, out lstLocation);
            }
            var tempLocation = from loc in lstLocation
                               where loc.OrgID != OrgID
                               select loc;

            ddlPerformingOrg.DataSource = lstLocation;
            ddlPerformingOrg.DataTextField = "Location";
            ddlPerformingOrg.DataValueField = "Comments";
            ddlPerformingOrg.DataBind();
            ddlPerformingOrg.Items.Insert(0, "--Select One--");
            ddlPerformingOrg.Items[0].Value = "0~0";


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading Org ", ex);
        }

    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            //TextBox txtFooterDescription = (TextBox)gvInvestigations.FooterRow.FindControl("txtFooterDescription");
            //TextBox txtFooterAmount = (TextBox)gvInvestigations.FooterRow.FindControl("txtFooterAmount");
            TextBox txtFooterDescription = (TextBox)txtFeeDesc;
            TextBox txtFooterAmount = (TextBox)txtAmnt;
            List<BillingFeeDetails> lstPhysicianFees = new List<BillingFeeDetails>();

            BillingFeeDetails bill1 = new BillingFeeDetails();
            iCount = 0;

            foreach (GridViewRow row in gvInvestigations.Rows)
            {
                BillingFeeDetails bill = new BillingFeeDetails();
                HiddenField hdnSNo = (HiddenField)row.FindControl("hdnSno");
                Label lblDescription = (Label)row.FindControl("lblDescription");
                TextBox txtAmount = (TextBox)row.FindControl("txtAmount");
                HiddenField hdnIsVariable = (HiddenField)row.FindControl("hdnisVariable");
                HiddenField hdnID = (HiddenField)row.FindControl("hdnID");
                HiddenField hdnIsGroup = (HiddenField)row.FindControl("hdnisGroup");
                CheckBox cbCheck = (CheckBox)row.FindControl("chkTest");
                
                HiddenField hdnFeeType = (HiddenField)row.FindControl("hdnFeeType");
                //TextBox txtFeeType = ((TextBox)row.FindControl("txtFeeType"));

                long ID = Convert.ToInt64(hdnID.Value);
                string description = lblDescription.Text;
                bill.ProcedureType = hdnSNo.Value;
                bill.Descrip = description;
                bill.Amount = Convert.ToDecimal(txtAmount.Text == "" ? "0" : txtAmount.Text);
                bill.IsVariable = hdnIsVariable.Value;
                bill.ID = ID;
                if (cbCheck.Checked == true)
                {
                    bill.IsChecked = "Y";
                }
                else
                {
                    bill.IsChecked = "N";
                }
                bill.IsGroup = hdnIsGroup.Value;

                if (((CheckBox)row.FindControl("chkIsReImbursableItem")).Checked)
                {
                    bill.IsReimbursable = "Y";
                }
                else
                {
                    bill.IsReimbursable = "N";
                }

                bill.FeeType = hdnFeeType.Value;

                lstPhysicianFees.Insert(iCount, bill);
                iCount++;
            }
            bill1.ID = -1;
            bill1.Amount = Convert.ToDecimal(txtFooterAmount.Text == "" ? "0" : txtFooterAmount.Text);
            bill1.Descrip = txtFooterDescription.Text.Trim();
            bill1.ProcedureType = "Ordered";
            bill1.IsChecked = "Y";

            bill1.FeeType = ddlFeeType.SelectedValue == "LAB" ? "INV" : ddlFeeType.SelectedValue;

            if (chkNonReimburse.Checked)
            {
                bill1.IsReimbursable = "Y";
            }
            else
            {
                bill1.IsReimbursable = "N";
            }
            if (ddlFeeType.SelectedValue.Equals("CON"))
            {
                bill1.ID = long.Parse(hdnFilterPhysicianID.Value);
            }
            else
            {
                bill1.ID = -1;
            }

            iCount = lstPhysicianFees.Count;
            lstPhysicianFees.Insert(iCount, bill1);
            gvInvestigations.DataSource = lstPhysicianFees;
            gvInvestigations.DataBind();
            
            doReset();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Adding Other Investigation ", ex);
        }

    }

    protected void doReset()
    {
        txtFeeDesc.Text = txtAmnt.Text = txtConsultant.Text = string.Empty;
        ddlFeeType.SelectedIndex = 0;
        chkNonReimburse.Checked = true;
    }

    public List<Referral> GetReferralsInvestigation()
    {
        List<Referral> lstReferrals = new List<Referral>();
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Referral objReferrals;
        try
        {
            foreach (GridViewRow row in gvInvestigations.Rows)
            {
                objReferrals = new Referral();
                HiddenField hdnSNo = (HiddenField)row.FindControl("hdnSno");
                DropDownList ddlPerformingOrg = (DropDownList)row.FindControl("ddlPerformingOrg");
                if (ddlPerformingOrg.SelectedValue != ILocationID.ToString() + "~" + OrgID.ToString() && ddlPerformingOrg.SelectedValue != "0~0")
                {
                        objReferrals.ReferedToOrgID = Int32.Parse(ddlPerformingOrg.SelectedValue.Split('~')[1]);
                        objReferrals.ReferedByOrgID = OrgID;
                        objReferrals.ReferedByVisitID = patientVisitID;
                        objReferrals.ReferralStatus = "Open";
                        objReferrals.ReferralVisitPurposeID = (int)TaskHelper.VisitPurpose.LabInvestigation;
                        objReferrals.ReferedToLocation = Int64.Parse(ddlPerformingOrg.SelectedValue.Split('~')[0]);
                        objReferrals.ReferedByLocation = ILocationID;
                        lstReferrals.Remove(lstReferrals.Find(p => p.ReferedToOrgID == objReferrals.ReferedToOrgID && p.ReferedToLocation == objReferrals.ReferedToLocation));
                        lstReferrals.Add(objReferrals);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Saving the Investigation Fee", ex);
        }
        return lstReferrals;
    }

    public long SaveFeesDetails(long patientVisitID, out string LabNo)
    {
        taskBL = new Tasks_BL(base.ContextInfo);
        patientBL = new PatientVisit_BL(base.ContextInfo);
        objReferrals_BL = new Referrals_BL(base.ContextInfo);
        PhysicianBL = new Physician_BL(base.ContextInfo);
        invbl = new Investigation_BL(base.ContextInfo);
        //
        billingBL = new BillingEngine(base.ContextInfo);
        List<SaveBillingDetails> lstBillingDetails = new List<SaveBillingDetails>();
        SaveBillingDetails objSaveBillingDetails;
        long BillID =0;
        LabNo = "";
        try
        {
            foreach (GridViewRow row in gvInvestigations.Rows)
            {
                if (((CheckBox)row.FindControl("chkTest")).Checked == true)
                {
                    decimal amount;
                    TextBox txtAmount = (TextBox)row.FindControl("txtAmount");
                    Label lblDescription = (Label)row.FindControl("lblDescription");
                    HiddenField hdnID = (HiddenField)row.FindControl("hdnID");
                    HiddenField hdnIsGrup = (HiddenField)row.FindControl("hdnisGroup");
                    HiddenField hdnSNo = (HiddenField)row.FindControl("hdnSno");
                    DropDownList ddlPerformingOrg = (DropDownList)row.FindControl("ddlPerformingOrg");
                    //if (ddlPerformingOrg.SelectedValue == ILocationID.ToString() + "~" + OrgID.ToString())
                    //{

                    HiddenField hdnFeeType = (HiddenField)row.FindControl("hdnFeeType");

                    if (hdnSNo.Value != "paid")
                    {
                        if (txtAmount.Text != "")
                        {
                            amount = Convert.ToDecimal(txtAmount.Text);
                            zeroAmount += amount;
                        }
                        else
                        {
                            amount = 0;
                            zeroAmount += amount;
                        }
                        objSaveBillingDetails = new SaveBillingDetails();
                        objSaveBillingDetails.ID = Convert.ToInt64(hdnID.Value);
                        objSaveBillingDetails.Amount = amount;
                        objSaveBillingDetails.Description = lblDescription.Text;
                        objSaveBillingDetails.IsGroup = hdnIsGrup.Value;

                        if (((CheckBox)row.FindControl("chkIsReImbursableItem")).Checked)
                        {
                            objSaveBillingDetails.IsReimbursable = "Y";
                        }
                        else
                        {
                            objSaveBillingDetails.IsReimbursable = "N";
                        }
                        objSaveBillingDetails.FeeType = hdnFeeType.Value;
                        lstBillingDetails.Add(objSaveBillingDetails);
                    }
                    //}
                    //else
                    //{

                    //}
                }
            }

            if (zeroAmount != 0)
            {

                //TextBox txtFooterDescription = (TextBox)gvInvestigations.FooterRow.FindControl("txtFooterDescription");
                //TextBox txtFooterAmount = (TextBox)gvInvestigations.FooterRow.FindControl("txtFooterAmount");
                //if (Convert.ToDouble(txtFooterAmount.Text == "" ? "0" : txtFooterAmount.Text) > 0)
                //{
                //    //set private variable indicating the list to be empty as false
                //    objSaveBillingDetails = new SaveBillingDetails();
                //    objSaveBillingDetails.ID = -1;
                //    objSaveBillingDetails.Description = txtFooterDescription.Text;
                //    objSaveBillingDetails.Amount = Convert.ToDecimal(txtFooterAmount.Text);
                //    lstBillingDetails.Add(objSaveBillingDetails);
                //}
                // Save Investigation billing information
                invbl.getOrgClientID(patientVisitID, out invClientID);
                billingBL.CreateInvestigationBillingEntry(OrgID, out BillID, patientVisitID, LID, invClientID, 
                    lstBillingDetails,ILocationID,out LabNo);
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
                    returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(Convert.ToInt64(Request.QueryString["ptid"]), TaskHelper.TaskStatus.Pending, UID);

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
                    lstBillingDetails.RemoveAll(p => p.Status == "Refered");
                    if (lstBillingDetails.Count > 0)
                    {
                        returnCode = new Tasks_BL(base.ContextInfo).CreateTaskAllowDuplicate(task, out createTaskID);
                    }
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
                            lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "CON", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber,lstPatientVisitDetails[0].TokenNumber,"");
                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverCaseSheet);
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.OrgID = OrgID;
                        task.PatientVisitID = patientVisitID;
                        task.PatientID = patientID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        returnCode = taskBL.CreateTask(task, out createTaskID);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Saving the Investigation Fee", ex);
        }
        return BillID;
    }

    public List<OrderedInvestigations> GetPaidPatientInvestigation(long patientVisitID)
    {
        List<OrderedInvestigations> GetPaidInvestigation = new List<OrderedInvestigations>();
        try
        {
            foreach (GridViewRow row in gvInvestigations.Rows)
            {
                TextBox txtAmount = (TextBox)row.FindControl("txtAmount");
                Label lblDescription = (Label)row.FindControl("lblDescription");
                HiddenField hdnID = (HiddenField)row.FindControl("hdnID");
                HiddenField hdnIsGrup = (HiddenField)row.FindControl("hdnisGroup");
                HiddenField hdnSNo = (HiddenField)row.FindControl("hdnSno");
                DropDownList ddlPerformingOrg = (DropDownList)row.FindControl("ddlPerformingOrg");
                if (ddlPerformingOrg.SelectedValue != "0~0")
                {
                    if (((CheckBox)row.FindControl("chkTest")).Checked)
                    {
                        if (ddlPerformingOrg.SelectedValue == ILocationID.ToString() + "~" + OrgID.ToString())
                        {
                            if (type == "Ref")
                            {
                                if (hdnSNo.Value.ToLower() == "paid")
                                {
                                    GetPaidInvestigation.Add(GetInvestigations(patientVisitID, lblDescription.Text, hdnID.Value, hdnIsGrup.Value, "Paid", 0, 0));
                                }
                                else
                                {
                                    GetPaidInvestigation.Add(GetInvestigations(patientVisitID, lblDescription.Text, hdnID.Value, hdnIsGrup.Value, "Ordered", 0, 0));
                                }

                            }
                            else if (type == "Referral")
                            {
                                if (hdnSNo.Value.ToLower() != "paid")
                                {
                                    GetPaidInvestigation.Add(GetInvestigations(patientVisitID, lblDescription.Text, hdnID.Value, hdnIsGrup.Value, "Paid", Int64.Parse(ddlPerformingOrg.SelectedValue.Split('~')[1]), Int64.Parse(ddlPerformingOrg.SelectedValue.Split('~')[0])));
                                }
                            }
                            else
                            {
                                GetPaidInvestigation.Add(GetInvestigations(patientVisitID, lblDescription.Text, hdnID.Value, hdnIsGrup.Value, "Paid", 0, 0));
                            }
                        }
                        else
                        {
                            GetPaidInvestigation.Add(GetInvestigations(patientVisitID, lblDescription.Text, hdnID.Value, hdnIsGrup.Value, "Paid", Int64.Parse(ddlPerformingOrg.SelectedValue.Split('~')[1]), Int64.Parse(ddlPerformingOrg.SelectedValue.Split('~')[0])));
                        }
                    }
                    else
                    {
                        if (ddlPerformingOrg.SelectedValue != ILocationID.ToString() + "~" + OrgID.ToString())
                        {
                            GetPaidInvestigation.Add(GetInvestigations(patientVisitID, lblDescription.Text, hdnID.Value, hdnIsGrup.Value, "Refered", Int64.Parse(ddlPerformingOrg.SelectedValue.Split('~')[1]), Int64.Parse(ddlPerformingOrg.SelectedValue.Split('~')[0])));
                        }

                    }
                }


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Saving the Investigation Fee", ex);
        }
        return GetPaidInvestigation;
    }

    private OrderedInvestigations GetInvestigations(long patientVisitID, string Description, string ID, string IsGrup, string Status,long ToOrgID,long ToLocation)
    {
        OrderedInvestigations patientInvestigation = new OrderedInvestigations();
        patientInvestigation.VisitID = patientVisitID;
        patientInvestigation.Name = Description;
        patientInvestigation.ID = Convert.ToInt32(ID);

        if (IsGrup == "G")
        {
            patientInvestigation.Type = "GRP";
        }
        else
        {
            patientInvestigation.Type = "INV";
        }
        patientInvestigation.CreatedBy = 0;
        patientInvestigation.Status = Status;
        patientInvestigation.OrgID = OrgID;
        patientInvestigation.CreatedBy = LID;
        patientInvestigation.ReferedToOrgID = ToOrgID;
        patientInvestigation.ReferedToLocation = ToLocation;
      
        return patientInvestigation;
    }
    public long ReferralsInvestigation(List<OrderedInvestigations> Investigations)
    {
        try
        {
            foreach (GridViewRow row in gvInvestigations.Rows)
            {
                HiddenField hdnID = (HiddenField)row.FindControl("hdnID");
                DropDownList ddlPerformingOrg = (DropDownList)row.FindControl("ddlPerformingOrg");
                List<OrderedInvestigations> obj = new List<OrderedInvestigations>();
                obj = Investigations.FindAll(p => p.ID == Convert.ToInt64(hdnID.Value) && p.ReferedToLocation.ToString() + "~" + p.ReferedToOrgID.ToString() == ddlPerformingOrg.SelectedValue);
                if (obj.Count > 0)
                {
                    if (obj[0].ID != 0)
                    {
                        row.BackColor = System.Drawing.Color.Tomato;
                    }
                }
            }

        }
        catch (Exception Ex)
        {
            throw;
        }
        return 1;
    }
}
