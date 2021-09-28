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
using Attune.Podium.BillingEngine;
using System.Collections;

public partial class Reception_RefedInvestigation : BasePage
{

    
    Investigation_BL invbl ;
    List<BillingFeeDetails> lstProcedureFeesDetails = new List<BillingFeeDetails>();
    List<Physician> lstPhysician = new List<Physician>();
    Physician_BL PhysicianBL;
    List<Organization> lstorgs = new List<Organization>();
    List<BillingFeeDetails> lstInvestigationFeesDetails = new List<BillingFeeDetails>();
    Referrals_BL objReferrals_BL ;
    long patientVisitID = 0;
    long patientID = 0;
    int iCount = 0;
    long invClientID = 0;
    decimal zeroAmount = 0;
    long returnCode = -1;
    long taskID = -1;
    long ptaskID = -1;
    long createTaskID = -1;
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    Tasks task = new Tasks();
    Tasks_BL taskBL;
    string LabNo = string.Empty;
    string gUID = string.Empty;
    BillingEngine billingBL;
    protected void Page_Load(object sender, EventArgs e)
    {
         billingBL = new BillingEngine(base.ContextInfo);
          taskBL = new Tasks_BL(base.ContextInfo);
          invbl = new Investigation_BL(base.ContextInfo);
          PhysicianBL = new Physician_BL(base.ContextInfo);
          objReferrals_BL = new Referrals_BL(base.ContextInfo);
        try
        {
            if (!IsPostBack)
            {

                LoadInvestigations();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading Investigation Fee ", ex);
        }
       
    }

    private void LoadInvestigations()
    {
        try
        {
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            invbl.getOrgClientID(patientVisitID, out invClientID);

            if (Request.QueryString["gUID"] != null)
            {
                gUID = Request.QueryString["gUID"].ToString();

            }

            billingBL.GetInvFeeDetails(patientVisitID, OrgID, invClientID,gUID, out lstInvestigationFeesDetails);

            var tempinv = from inv in lstInvestigationFeesDetails
                          orderby inv.ProcedureType
                          select inv;

            if (lstInvestigationFeesDetails.Count > 0)
            {
                gvInvestigations.DataSource = tempinv;
                gvInvestigations.DataBind();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading Investigation Fee ", ex);
        }
    }

    protected void gvInvestigations_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            BillingFeeDetails inv=new BillingFeeDetails();
            inv = (BillingFeeDetails)e.Row.DataItem;
            DropDownList ddlPerformingOrg = (DropDownList)e.Row.FindControl("ddlPerformingOrg");
            BindPerformingOrg(ddlPerformingOrg);
            if (inv.ProcedureType!="Refered")
            {
                ddlPerformingOrg.SelectedValue = OrgID.ToString();
            }
        }
    }
    
    private void BindPerformingOrg(DropDownList ddlPerformingOrg)
    {
        try
        {
            if (lstorgs.Count==0)
            {
                new Schedule_BL(base.ContextInfo).getOrganizations( out lstorgs);
            }
             ddlPerformingOrg.DataSource = lstorgs;
             ddlPerformingOrg.DataTextField = "Name";
             ddlPerformingOrg.DataValueField = "OrgID";
             ddlPerformingOrg.DataBind();
             ddlPerformingOrg.Items.Insert(0, "--Select One--");
             ddlPerformingOrg.Items[0].Value = "0";
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
            TextBox txtFooterDescription = (TextBox)gvInvestigations.FooterRow.FindControl("txtFooterDescription");
            TextBox txtFooterAmount = (TextBox)gvInvestigations.FooterRow.FindControl("txtFooterAmount");

            List<BillingFeeDetails> lstPhysicianFees = new List<BillingFeeDetails>();

            BillingFeeDetails bill1 = new BillingFeeDetails();
            iCount = 0;

            foreach (GridViewRow row in gvInvestigations.Rows)
            {
                BillingFeeDetails bill = new BillingFeeDetails();
                Label lblSNo = (Label)row.FindControl("lblSno");
                Label lblDesc = (Label)row.FindControl("lblDescription");
                TextBox txtAmount = (TextBox)row.FindControl("txtAmount");
                Label lblIsVariable = (Label)row.FindControl("lblisVariable");
                Label lblID = (Label)row.FindControl("lblID");
                Label lblIsGroup = (Label)row.FindControl("lblisGroup");

                long ID = Convert.ToInt64(lblID.Text);
                string description = lblDesc.Text;
                bill.ProcedureType = lblSNo.Text;
                bill.Descrip = description;
                bill.Amount = Convert.ToDecimal(txtAmount.Text == "" ? "0" : txtAmount.Text);
                bill.IsVariable = lblIsVariable.Text;
                bill.ID = ID;
                bill.IsGroup = lblIsGroup.Text;
                lstPhysicianFees.Insert(iCount, bill);
                iCount++;
            }
            bill1.ID = -1;
            bill1.Amount = Convert.ToDecimal(txtFooterAmount.Text == "" ? "0" : txtFooterAmount.Text);
            bill1.Descrip = txtFooterDescription.Text.Trim(); ;
            iCount = lstPhysicianFees.Count;
            lstPhysicianFees.Insert(iCount, bill1);
            gvInvestigations.DataSource = lstPhysicianFees;
            gvInvestigations.DataBind();
            hdnAmount.Value = "";

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Adding Other Investigation ", ex);
        }
       
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        btnSave.Enabled = false;
        try
        {
            long returnCode = -1;
            long createTaskID = -1;
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            Int64.TryParse(Request.QueryString["tid"], out taskID);
            long FinalBillID = 0;
            FinalBillID = SaveFeesDetails();
            if (FinalBillID!=0)
            {
                // Update patient investigation status
                List<SaveBillingDetails> lstSaveBillingDetail = new List<SaveBillingDetails>();
                List<PatientInvestigation> lstUpdatePatientInvStatus = new List<PatientInvestigation>();
                List<Referral> lstReferrals = new List<Referral>();
                PatientInvestigation patientInvestigation;

                lstSaveBillingDetail = GetSaveFeeDetail();

                lstReferrals = GetReferralsInvestigation();

               //returnCode= objReferrals_BL.SaveUpdateReferrals(lstReferrals,LID);

                for (int i = 0; i < lstSaveBillingDetail.Count; i++)
                {
                    patientInvestigation = new PatientInvestigation();
                    patientInvestigation.PatientVisitID = patientVisitID;
                    if (lstSaveBillingDetail[i].IsGroup == "I")
                    {
                        patientInvestigation.InvestigationID = Convert.ToInt32(lstSaveBillingDetail[i].ID);
                    }
                    else
                    {
                        patientInvestigation.GroupID = Convert.ToInt32(lstSaveBillingDetail[i].ID);
                    }
                    patientInvestigation.CreatedBy = 0;
                    patientInvestigation.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    patientInvestigation.Status = "Paid";
                    lstUpdatePatientInvStatus.Add(patientInvestigation);
                }
                int count = -1;
                returnCode = new Investigation_BL(base.ContextInfo).UpdateSampleCollected(lstUpdatePatientInvStatus, 0, out count);

                //Update InvestigationPayment tasks
                returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);

                //Create task for Collect investigation payment
                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
                returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), patientVisitID, 0,
                            patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectPayment);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.BillID = FinalBillID;
                task.PatientVisitID = patientVisitID;
                task.PatientID = patientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                //Create task               
                returnCode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);

                string redirectURL = @"..\Billing\Billing.aspx?vid=" + patientVisitID + "&tid=" + createTaskID + "&pid=" + patientID + "&ptid=0&ftype=INV&bid=" + FinalBillID + "";
                Response.Redirect(redirectURL, true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Saving the Investigation Fee", ex);
        }


    }

    private List<Referral> GetReferralsInvestigation()
    {
        List<Referral> lstReferrals = new List<Referral>();
         Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Referral objReferrals;
        try
        {
            foreach (GridViewRow row in gvInvestigations.Rows)
            {
                objReferrals = new Referral();
                if (((CheckBox)row.FindControl("chkTest")).Checked == true)
                {
                    TextBox txtAmount = (TextBox)row.FindControl("txtAmount");
                    Label lblDesc = (Label)row.FindControl("lblDescription");
                    Label lblID = (Label)row.FindControl("lblID");
                    Label lblIsGrup = (Label)row.FindControl("lblisGroup");
                    Label lblSNo = (Label)row.FindControl("lblSno");
                    DropDownList ddlPerformingOrg = (DropDownList)row.FindControl("ddlPerformingOrg");
                    if (ddlPerformingOrg.SelectedValue == OrgID.ToString())
                    {
                        //objReferrals.ReferedOrgID = Int64.Parse(ddlPerformingOrg.SelectedValue);
                        //objReferrals.ReferingOrgID = OrgID;
                        //objReferrals.ReferingVisitID = patientVisitID;
                        //objReferrals.ReferralStatus = "Open";
                        lstReferrals.Add(objReferrals);
                    }

                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Saving the Investigation Fee", ex);
        }
        return lstReferrals;
    }

    private long SaveFeesDetails()
    {
        BillingEngine billingBL = new BillingEngine(base.ContextInfo);
        List<SaveBillingDetails> lstBillingDetails = new List<SaveBillingDetails>();
        SaveBillingDetails objSaveBillingDetails;
        long BillID = 0;
        try
        {
            foreach (GridViewRow row in gvInvestigations.Rows)
            {
                if (((CheckBox)row.FindControl("chkTest")).Checked == true)
                {
                    decimal amount;
                    TextBox txtAmount = (TextBox)row.FindControl("txtAmount");
                    Label lblDesc = (Label)row.FindControl("lblDescription");
                    Label lblID = (Label)row.FindControl("lblID");
                    Label lblIsGrup = (Label)row.FindControl("lblisGroup");
                    Label lblSNo = (Label)row.FindControl("lblSno");
                    DropDownList ddlPerformingOrg = (DropDownList)row.FindControl("ddlPerformingOrg");

                    if (ddlPerformingOrg.SelectedValue == OrgID.ToString())
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
                        objSaveBillingDetails.ID = Convert.ToInt64(lblID.Text);
                        objSaveBillingDetails.Amount = amount;
                        objSaveBillingDetails.Description = lblDesc.Text;
                        objSaveBillingDetails.IsGroup = lblIsGrup.Text;
                        lstBillingDetails.Add(objSaveBillingDetails);
                    }
                }
            }

            if (zeroAmount != 0)
            {

                TextBox txtFooterDescription = (TextBox)gvInvestigations.FooterRow.FindControl("txtFooterDescription");
                TextBox txtFooterAmount = (TextBox)gvInvestigations.FooterRow.FindControl("txtFooterAmount");
                if (Convert.ToDouble(txtFooterAmount.Text == "" ? "0" : txtFooterAmount.Text) > 0)
                {
                    //set private variable indicating the list to be empty as false
                    objSaveBillingDetails = new SaveBillingDetails();
                    objSaveBillingDetails.ID = -1;
                    objSaveBillingDetails.Description = txtFooterDescription.Text;
                    objSaveBillingDetails.Amount = Convert.ToDecimal(txtFooterAmount.Text);
                    lstBillingDetails.Add(objSaveBillingDetails);
                }
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

                    List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                    returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
                    returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample), patientVisitID, 0,
                        patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
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
                            lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "CON", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
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

    private List<SaveBillingDetails> GetSaveFeeDetail()
    {
        List<SaveBillingDetails> lstSaveInvestigationDet = new List<SaveBillingDetails>();
        SaveBillingDetails objSaveBillingDetails;
        try
        {
            foreach (GridViewRow row in gvInvestigations.Rows)
            {
                if (((CheckBox)row.FindControl("chkTest")).Checked == true)
                {
                    decimal amount;
                    TextBox txtAmount = (TextBox)row.FindControl("txtAmount");
                    Label lblDesc = (Label)row.FindControl("lblDescription");
                    Label lblID = (Label)row.FindControl("lblID");
                    Label lblIsGrup = (Label)row.FindControl("lblisGroup");
                    Label lblSNo = (Label)row.FindControl("lblSno");
                    DropDownList ddlPerformingOrg = (DropDownList)row.FindControl("ddlPerformingOrg");

                    if (ddlPerformingOrg.SelectedValue == OrgID.ToString())
                    {
                        if (txtAmount.Text != "")
                        {
                            amount = Convert.ToDecimal(txtAmount.Text);
                        }
                        else
                        {
                            amount = 0;
                        }
                        objSaveBillingDetails = new SaveBillingDetails();
                        objSaveBillingDetails.ID = Convert.ToInt64(lblID.Text);
                        objSaveBillingDetails.Amount = amount;
                        objSaveBillingDetails.Description = lblDesc.Text;
                        objSaveBillingDetails.IsGroup = lblIsGrup.Text;
                        lstSaveInvestigationDet.Add(objSaveBillingDetails);
                    }
                    
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Saving the Investigation Fee", ex);
        }
        return lstSaveInvestigationDet;
    }

}