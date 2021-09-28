using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Collections;
using System.Text;
using System.Data;
using System.Data.SqlClient;
public partial class CommonControls_SurgeryforProcedurePlanning :BaseControl 
{

    long patientVisitID = -1;
    long patientID = -1;
    long returnCode = -1;
    long OperationID = -1;
    string RdoValue = string.Empty;
    int OrgID = 0;
    int BaseCurrencyID = 0;
    int PaidCurrencyID = 0;
    Patient_BL patientBL;
    List<IPTreatmentPlanMaster> lstIPTreatmentPlanMaster = new List<IPTreatmentPlanMaster>();
    List<IPTreatmentPlan> lstIPTreatmentPlan = new List<IPTreatmentPlan>();
    List<IPTreatmentPlanDetails> lstTreatmentplanDetails = new List<IPTreatmentPlanDetails>();
    List<IPTreatmentPlanDetails> lstReportIPTreatmentPlanDetails = new List<IPTreatmentPlanDetails>();
    List<Patient> lstPatient = new List<Patient>();

    List<PatientVitals> lstPatientVitals = new List<PatientVitals>();
    List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
    List<SurgeryType> lstSurgeryType = new List<SurgeryType>();
    List<OperationType> lstOperationType = new List<OperationType>();
    List<AnesthesiaType> lstAnesthesiaType = new List<AnesthesiaType>();
    List<Physician> lstSurgeonName = new List<Physician>();
    //List<AHPStaff> lstAnesthisa = new List<AHPStaff>();
    List<Physician> lstAnesthesiast = new List<Physician>();
    List<AHPStaff> lstTechnicianName = new List<AHPStaff>();
    List<Nurse> lstNurseName = new List<Nurse>();

    List<OperationNotes> lstOperationNotes = new List<OperationNotes>();
    List<OperationFinding> lstOperationFinding = new List<OperationFinding>();
    List<OperationComplication> lstOperationComplication = new List<OperationComplication>();
    List<OperationStaff> lstOperationStaff = new List<OperationStaff>();

    List<Physician> lstChiefPhysicianOperationStaff = new List<Physician>();
    List<Physician> lstAssistantPhysicianOperationStaff = new List<Physician>();
    //List<AHPStaff> lstAnesthisiaOperationStaff = new List<AHPStaff>();
    List<Physician> lstAnesthisiaOperationStaff = new List<Physician>();
    List<AHPStaff> lstTechnicianOperationStaff = new List<AHPStaff>();
    List<Nurse> lstNurseOperationStaff = new List<Nurse>();
    List<IPTreatmentPlan> lstIPTreatmentPlanByOperationID = new List<IPTreatmentPlan>();
    List<IPTreatmentPlan> lstIPTreatmentPlanFromCaserecord = new List<IPTreatmentPlan>();
    List<IPTreatmentPlan> lstIPTreatmentPlanAndPerformed = new List<IPTreatmentPlan>();
    List<IPTreatmentPlan> lst = new List<IPTreatmentPlan>();
    List<IPTreatmentPlanDetails> lstIPTreatmentPlanDetails = new List<IPTreatmentPlanDetails>();
   

    List<VitalsUOMJoin> lstVitalsUOMJoin = new List<VitalsUOMJoin>();

    IP_BL ipBL;
    protected void Page_Load(object sender, EventArgs e)
    {
        patientBL = new Patient_BL(base.ContextInfo);
        ipBL = new IP_BL(base.ContextInfo);
        OrgID=OrgID;
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["oid"], out OperationID);
        //GetIPPlannedAndPerformedTreatment();

      
        AutoSurgeryName.ContextKey = OrgID.ToString();
        Autosurgeonname.ContextKey = OrgID.ToString();
       // AutoSurubTeam.ContextKey = OrgID.ToString();
        AutoCompleteExtender3.ContextKey = OrgID.ToString();
        AutoAnesthesiastName.ContextKey = OrgID.ToString();
        
        if (!IsPostBack)
        {
            GetOperationNotes();
            LoadChiefOperator();
            LoadAnesthisia();
            LoadIPTreatmentPlanMaster();
            LoadAllIPTreatmentPlanChild();
            LoadPriority();
            returnCode = patientBL.GetPatientDemoandAddress(patientID, out lstPatient);
            if (lstPatient.Count > 0)
            {
                lblNameValue.Text = lstPatient[0].Name;
                lblAgeOrSexValue.Text = lstPatient[0].Age + "/" + lstPatient[0].SEX;
                lblPnovalue.Text = lstPatient[0].PatientNumber;
                lbladdressvalue.Text = lstPatient[0].PatientAddress[0].Add1;
                lblcontactNovalue.Text = lstPatient[0].PatientAddress[0].MobileNumber;
             

            }
        
        }
    }

    private void LoadChiefOperator()
    {
        ddlChiefOperator.DataSource = lstSurgeonName;
        ddlChiefOperator.DataTextField = "PhysicianName";
        ddlChiefOperator.DataValueField = "PhysicianID";
        ddlChiefOperator.DataBind();
        //ddlChiefOperator.Items.Insert(0, "-----Select-----");
        //ddlChiefOperator.Items[0].Value = "0";
    }

    private void LoadAnesthisia()
    {
        DrpAnasthesiast.DataSource = lstAnesthesiast;
        DrpAnasthesiast.DataTextField = "PhysicianName";
        DrpAnasthesiast.DataValueField = "PhysicianID";
        DrpAnasthesiast.DataBind();
    }




    public void GetOperationNotes()
    {
        ipBL = new IP_BL(base.ContextInfo);
        try
        {

            returnCode = ipBL.GetOperationNotes(patientVisitID, OrgID, out lstSurgeryType, out lstOperationType, out lstAnesthesiaType, out lstSurgeonName, out lstAnesthesiast, out lstTechnicianName, out lstNurseName, out lstIPTreatmentPlan, out lstPatient, out lstIPTreatmentPlanFromCaserecord,out lstIPTreatmentPlanDetails);
            if (returnCode == 0)
            {
                
                if (lstSurgeonName.Count > 0)
                {
                    LoadChiefOperator();
                   
                }

                if (lstAnesthesiast.Count > 0)
                {
                    LoadAnesthisia();
                }

                if (lstIPTreatmentPlanDetails.Count > 0)
                {
                    grdCRCplan.DataSource = lstIPTreatmentPlanDetails;
                    grdCRCplan.DataBind();
                }

                               

            }
        }
        catch (Exception ex)
        {


          
        }


    }
    protected void grdCRCplan_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
         
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
                e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
                e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdCRCplan, "Select$" + e.Row.RowIndex));

                IPTreatmentPlanDetails IPD = (IPTreatmentPlanDetails)e.Row.DataItem;
               
            }
        }
        catch (Exception ex)
        {
          
        }
    }

    protected void grdCRCplan_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        ipBL = new IP_BL(base.ContextInfo);
        try
        {
           // List<IPTreatmentPlanDetails> lstIPTreatmentPlanDetails = new List<IPTreatmentPlanDetails>();
          //  lstTreatmentDetails.Clear();
            long returncode = -1;

            int SurgeryPlanID = 0;

            if (e.CommandName == "Select")
            {
                int rowIndex = -1;
                rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow grow = grdCRCplan.Rows[rowIndex];
                SurgeryPlanID = Convert.ToInt32(grdCRCplan.DataKeys[rowIndex][0].ToString());
            }
            returnCode = ipBL.GetIPTreatmentPlanDetails(patientID, out lstTreatmentplanDetails, out lstReportIPTreatmentPlanDetails);
         //   returnCode = ipBL.GetOperationNotes(patientVisitID, OrgID, out lstSurgeryType, out lstOperationType, out lstAnesthesiaType, out lstSurgeonName, out lstAnesthesiast, out lstTechnicianName, out lstNurseName, out lstIPTreatmentPlan, out lstPatient, out lstIPTreatmentPlanFromCaserecord, out lstIPTreatmentPlanDetails);
            var s = lstIPTreatmentPlanDetails.Find(p => p.SurgeryPlanID == SurgeryPlanID);
            if (lstIPTreatmentPlanDetails.Count > 0)
            {
             
                ddlIPTreatmentPlanMaster.SelectedItem.Text = s.ParentName.ToString();
                ddlIPTreatmentPlanChild.Text = s.IPTreatmentPlanName;
                var PhysicianID= Convert.ToInt64(s.SurgeonID);
                var AnesthesiastID = Convert.ToInt64(s.AnesthesiastID);



                //var lstphyAnd = (from lstsp in lstSurgeonName
                //                 select new { lstsp.PhysicianID, lstsp.PhysicianName }).Distinct();
                //var tempSpec = (from lst in lstphyAnd
                //                where lst.PhysicianID == PhysicianID
                //                select lst.PhysicianName).Distinct();
             
                txtNew.Text = lstSurgeonName.Find(P=>P.PhysicianID==PhysicianID).PhysicianName;
                ddlChiefOperator.SelectedItem.Text = lstSurgeonName.Find(P => P.PhysicianID == PhysicianID).PhysicianName;
                txtIPTreatmentPlanProsthesis.Text = s.Prosthesis;
                
                txtAnesthesiast.Text = lstAnesthesiast.Find(P => P.PhysicianID == AnesthesiastID).PhysicianName;
                DrpAnasthesiast.SelectedItem.Text = lstAnesthesiast.Find(P => P.PhysicianID == AnesthesiastID).PhysicianName;
               // txtFromTime.Text  = s.TreatmentPlanDate.ToString();
                if (s.IsProvisional == "Y")
                {
                    chkprovisional.Checked = true;
                }
                else
                {
                    chkprovisional.Checked = false;
                }

               


            }
         //   btnFinish.Text = "Update";

           
        }

        catch (Exception ex)
        {

        }
    }

    protected void LoadIPTreatmentPlanMaster()
    {
        ipBL = new IP_BL(base.ContextInfo);
        try
        {
            ipBL.GetIPTreatmentPlanMaster(OrgID, out lstIPTreatmentPlanMaster);
            var list = from IPTreatment in lstIPTreatmentPlanMaster
                       where IPTreatment.IPTreatmentPlanParentID == 0
                       select IPTreatment;
            if (list.Count() > 0)
            {
                ddlIPTreatmentPlanMaster.DataSource = lstIPTreatmentPlanMaster;
                ddlIPTreatmentPlanMaster.DataTextField = "IPTreatmentPlanName";
                ddlIPTreatmentPlanMaster.DataValueField = "IPTreatmentPlanID";
                ddlIPTreatmentPlanMaster.DataBind();
                ddlIPTreatmentPlanMaster.Items.Insert(lstIPTreatmentPlanMaster.Count, "Medical");
                ddlIPTreatmentPlanMaster.Items[lstIPTreatmentPlanMaster.Count].Value = "0";
            }
        }
        catch (Exception ex)
        {
          
        }
    }

    public void LoadAllIPTreatmentPlanChild()
    {
        ipBL = new IP_BL(base.ContextInfo);
        try
        {
            List<IPTreatmentPlanMaster> lstAllIPTreatmentPlanChild = new List<IPTreatmentPlanMaster>();

            ipBL.GetAllIPTreatmentPlanChild(OrgID, out lstAllIPTreatmentPlanChild);

            string Surgery = 0 + "~" + "Others" + "~" + 1 + "^";
            string Interventional = 0 + "~" + "Others" + "~" + 2 + "^";

            if (lstAllIPTreatmentPlanChild.Count > 0)
            {
                foreach (IPTreatmentPlanMaster objIPTreatmentPlanMaster in lstAllIPTreatmentPlanChild)
                {
                    hdnIPTreatmentPlanChild.Value += objIPTreatmentPlanMaster.TreatmentPlanID + "~" + objIPTreatmentPlanMaster.IPTreatmentPlanName + "~" + objIPTreatmentPlanMaster.IPTreatmentPlanParentID + "^";

                }
                hdnIPTreatmentPlanChild.Value += Surgery + Interventional;
            }

        }
        catch (Exception ex)
        {
           
        }
    }


    protected void btnFinish_Click(object sender, EventArgs e)
    {
        ipBL = new IP_BL(base.ContextInfo);
        AdvancePaid_BL objAdBL = new AdvancePaid_BL(base.ContextInfo);
        List<IPTreatmentPlanDetails> lstTreatmentPlanDetails= new List<IPTreatmentPlanDetails>();
        int SurgeonID = Convert.ToInt16(ddlChiefOperator.SelectedValue);
        int anesthesiaID = Convert.ToInt16(DrpAnasthesiast.SelectedValue);
        string ScrubTeam = string.Empty;
      //  int IPTreatmentPlanID = Convert.ToInt16(ddlIPTreatmentPlanMaster.SelectedValue);
        //DateTime operationTime = Convert.ToDateTime(txtFromTime.Text);
       
        string provisional = string.Empty;

        if (txtFromTime.Text ==Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString())
        {
            chkprovisional.Checked = false;
        }
        else
        {
            chkprovisional.Checked = true;
        }
        if (chkprovisional.Checked)
        {
            provisional = "Y";
        }
        else 
        {
            provisional = "N";
        }


      
     
        lstTreatmentPlanDetails = GetIPTreatmentPlanDetails();
        ipBL.InsertIPTreatmentPlanDetails(patientVisitID, patientID, OrgID, lstTreatmentPlanDetails);
        GetOperationNotes();
        CollecetAdvance();
       
       
       
    }
    public List<IPTreatmentPlanDetails> GetIPTreatmentPlanDetails()
    {

        List<IPTreatmentPlanDetails> lstIPTreatmentPlanTemp = new List<IPTreatmentPlanDetails>();
        hdnIPTreatmentPlanItems.Value += hdnPerformed.Value;
        foreach (string listParentTreatmentPlan in hdnIPTreatmentPlanItems.Value.Split('^'))
        {

           //1~21~0~21/AVR (Aortic valve replacement)~21/AVR (Aortic valve replacement)~aaa~Dr.BALAMURUGAN B~Dr.SEETHARAMAN ~N~
            //31/8/2012 11:37:14 AM~Right Eye ~Dr.BALAMURUGAN B~Dr.SEETHARAMAN ^
            if (listParentTreatmentPlan != "")
            {
              
                IPTreatmentPlanDetails objIPTreatmentPlan = new IPTreatmentPlanDetails();
                string[] listChildTreatmentPlan = listParentTreatmentPlan.Split('~');
                objIPTreatmentPlan.PatientID = patientID;
                objIPTreatmentPlan.PatientVisitID = patientVisitID;
                objIPTreatmentPlan.IPTreatmentPlanID = Convert.ToInt32(listChildTreatmentPlan[1]);
                objIPTreatmentPlan.IPTreatmentPlanName = listChildTreatmentPlan[4];
                objIPTreatmentPlan.TreatmentPlanDate = Convert.ToDateTime(listChildTreatmentPlan[9]);
             
                // objIPTreatmentPlan.SurgeonID = Convert.ToInt64(listChildTreatmentPlan[6]);
              //  objIPTreatmentPlan.AnesthesiastID = Convert.ToInt64(listChildTreatmentPlan[7]);
                objIPTreatmentPlan.IsProvisional = listChildTreatmentPlan[8];
                //objIPTreatmentPlan.ParentID = Convert.ToInt32(listChildTreatmentPlan[1]);
                objIPTreatmentPlan.ParentName = listChildTreatmentPlan[3];
                objIPTreatmentPlan.CreatedBy = Convert.ToInt64(LID);
               

                string[] prosthesis = listChildTreatmentPlan[5].Split(',');
                var pcount = prosthesis.Length;
                string pros=string.Empty;
                if (pcount > 1)
                {
                    for (int j = 0; j < prosthesis.Length; j++)
                    {
                        pros += prosthesis[j].ToString() + ",";
                        objIPTreatmentPlan.Prosthesis = pros;
                    }
                }
                else
                {
                    objIPTreatmentPlan.Prosthesis = listChildTreatmentPlan[5];
                }



                string[] surgeon = listChildTreatmentPlan[11].Split(',');
                var count =surgeon.Length ;
                string names=string .Empty;
                if (count > 1)
                {
                    for (int i = 0; i <surgeon.Length; i++)
                    {
                        names += surgeon[i].ToString() + ",";
                        objIPTreatmentPlan.SurgeonName  = names;
                    }
                
                }

                else
                {

                    objIPTreatmentPlan.SurgeonName = listChildTreatmentPlan[11];
                }


                string[] anesthesiast = listChildTreatmentPlan[12].Split(',');
                var acount = anesthesiast.Length;
                string anesthesiastnames = string.Empty;
                if (count > 1)
                {
                    for (int i = 0; i < anesthesiast.Length; i++)
                    {
                        anesthesiastnames += anesthesiast[i].ToString() + ",";
                        objIPTreatmentPlan.AnesthesiastName = anesthesiastnames;
                    }

                }

                else
                {

                    objIPTreatmentPlan.AnesthesiastName = listChildTreatmentPlan[12];
                }
                //objIPTreatmentPlan.PatientName = listChildTreatmentPlan[13];
                objIPTreatmentPlan.SiteOfOperation  = listChildTreatmentPlan[10];

          
                objIPTreatmentPlan.StagePlanned = "OPR";

                lstIPTreatmentPlanTemp.Add(objIPTreatmentPlan);


            }
        }
        return lstIPTreatmentPlanTemp;
    }
   
  

    public List<IPTreatmentPlanDetails> GetIPTreatmentPlan()
    {

        List<IPTreatmentPlanDetails> lstIPTreatmentPlanTemp = new List<IPTreatmentPlanDetails>();
        hdnIPTreatmentPlanItems.Value += hdnPerformed.Value;
        //"1~2~376~Interventional~AICD Implantation~Prosthesis 1 ,Prosthesis~937~1108~Y~18/8/2012 02:43:59 PM~JAYAMURTHYNaN3669~Dr.ARUN RAMANAN^"
        foreach (string listParentTreatmentPlan in hdnIPTreatmentPlanItems.Value.Split('^'))
        {
            if (listParentTreatmentPlan != "")
            {
                IPTreatmentPlanDetails objIPTreatmentPlan = new IPTreatmentPlanDetails();
                string[] listChildTreatmentPlan = listParentTreatmentPlan.Split('~');


                objIPTreatmentPlan.PatientID = patientID;
                objIPTreatmentPlan.PatientVisitID = patientVisitID;
              
                objIPTreatmentPlan.IPTreatmentPlanID = Convert.ToInt32(listChildTreatmentPlan[2]);
                objIPTreatmentPlan.IPTreatmentPlanName = listChildTreatmentPlan[4];
                objIPTreatmentPlan.Prosthesis = listChildTreatmentPlan[5] ;
                objIPTreatmentPlan.SurgeonID = Convert.ToInt64(listChildTreatmentPlan[6]);
                objIPTreatmentPlan.AnesthesiastID = Convert.ToInt64(listChildTreatmentPlan[7]);
                objIPTreatmentPlan.IsProvisional = listChildTreatmentPlan[8];
                
                objIPTreatmentPlan.TreatmentPlanDate = Convert.ToDateTime(txtFromTime.Text);
                objIPTreatmentPlan.StagePlanned = "OPR";
                
                lstIPTreatmentPlanTemp.Add(objIPTreatmentPlan);


            }
        }
        return lstIPTreatmentPlanTemp;
    }
    public void LoadPriority()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<PriorityMaster> getPriorityMaster = new List<PriorityMaster>();
            retCode = patBL.GetPriorityMaster(out getPriorityMaster);
            if (retCode == 0)
            {
                ddlPriority.DataSource = getPriorityMaster;
                ddlPriority.DataTextField = "PriorityName";
                ddlPriority.DataValueField = "PriorityID";
                ddlPriority.DataBind();
            }
        }
        catch (Exception ex)
        {
          
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("../Reception/Home.aspx");
    
    }
    //protected void btnCollectAdvance_Click(object sender, EventArgs e)
    //{
    //    mpe.Show();
    //}
    //protected void OKButton_Click(object sender, EventArgs e)
    //{

    //   // PaymentType.GetAmountReceivedDetails();
    //    mpe.Hide();
    //}

    public void CollecetAdvance()
    {
        decimal dAmount = 0;
        AdvancePaid_BL objAdBL = new AdvancePaid_BL(base.ContextInfo);

        List<AdvancePaidDetails > lstAdvancePaidDetails = new List<AdvancePaidDetails>();
       
        decimal dServiceCharge = 0;
     
        hdnAdvanceAmount.Value = hdnAdvanceAmount.Value == "" ? "0" : hdnAdvanceAmount.Value;

        dAmount = Convert.ToDecimal(hdnAdvanceAmount.Value);

       
     
        long returnCode = -1;
       
        

        System.Data.DataTable dtAdvancePaidDetails = new System.Data.DataTable();
        PaymentType.GetOtherCurrReceivedDetails(out BaseCurrencyID, out PaidCurrencyID);
        PaidCurrencyID = BaseCurrencyID;

       //dtAdvancePaidDetails = PaymentType.GetAmountReceivedDetails();
       dtAdvancePaidDetails = PaymentType.GetSOIAmountReceivedDetails();
    
       ((HiddenField)PaymentType.FindControl("hdfPaymentType")).Value = Convert.ToString(dtAdvancePaidDetails);




       var  TotalAmtReceived = dtAdvancePaidDetails.Rows[0]["AdvanceAmount"].ToString();
       if (Convert.ToDecimal(TotalAmtReceived) < dAmount || Convert.ToDecimal(TotalAmtReceived) > dAmount)
       {

       
           ScriptManager.RegisterStartupScript(this, this.GetType(), "Alert", "alert('Collect Minimum Advance amount for this Procedure.');", true);
       }


       else
       {
           string sreceiptNo = "";
           long IpIntermediateID = 0;
           string sType = "";
           if (dtAdvancePaidDetails.Rows.Count > 0)
           {
               returnCode = objAdBL.SaveSOIAdvancePaidDetails(patientVisitID, patientID, LID, dAmount, OrgID,
                                                               out lstAdvancePaidDetails,
                                                               dtAdvancePaidDetails, dServiceCharge,
                                                               out sreceiptNo, out sType);

               string strName = "";

               string sPage = "../InPatient/PrintReceiptPage.aspx?Amount="
                               + dAmount + "&dDate="
                               + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt")
                               + "&rcptno=" + sreceiptNo.ToString()
                               + "&PID=" + patientID.ToString()
                               + "&VID=" + patientVisitID.ToString()
                               + "&OrgID=" + OrgID
                               + "&pdid=" + IpIntermediateID.ToString() + "&pDet=" + sType + "&PNAME=" + strName
                               ;

               dtAdvancePaidDetails = new DataTable();
               ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:openPOPupQuick('" + sPage + "');", true);
           }
       }

    }
}
