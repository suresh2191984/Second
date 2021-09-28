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


public partial class CommonControls_SurgeryBilling : BaseControl
{
    

    long _lVisitID = 0;
    long _lPatientID = 0;
    int iClientID = 0;
    public long lVisitID
    {
        get
        {
            return _lVisitID;
        }
        set
        {
            _lVisitID = value;
        }
    }
    public long lPatientID
    {
        get
        {
            return _lPatientID;
        }
        set
        {
            _lPatientID = value;
        }
    }
    
    long returnCode = -1;
    List<Physician> lstChiefPhysician= new List<Physician>();
    List<Physician> lstAnesthisa = new List<Physician>();
    List<IPTreatmentPlanMaster> lstIPTreatmentType = new List<IPTreatmentPlanMaster>();
    List<InstrumentationMaster> lstInstrumentationMaster = new List<InstrumentationMaster>();
    List<PatientInvestigation> lstInv = new List<PatientInvestigation>();
    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    List<Nurse> lstNurse = new List<Nurse>();
    List<PatientVisit> lstInPatientVisit = new List<PatientVisit>();
    string RdoValue = string.Empty;
    long SurgeryBillingID = -1;
    int pTreatmentMasterID = -1;
    string SurgeyFeeDefined = string.Empty;

    IP_BL ipBL ;
    Investigation_BL invBL ;
    SharedInventory_BL invenBL ;
    PatientVisit_BL PVBL;

    protected void Page_Load(object sender, EventArgs e)
    {

        SurgeyFeeDefined = GetConfigValue("SurgeryfeeDefined", OrgID);
        hdnIsSurgeryDefined.Value = SurgeyFeeDefined;
        if (SurgeyFeeDefined == "N")
        {
            divSurgeryNonDefined.Style.Add("display", "block");

        }
        else
        {
            divSurgeryFeeDefined.Style.Add("display", "block");
        }


        invBL = new Investigation_BL(base.ContextInfo);
        ipBL = new IP_BL(base.ContextInfo);
        invenBL = new SharedInventory_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            try
            {

                GetSurgeonNameAndSurgeryType();
                LoadAllIPTreatmentPlanChild();
                txtBillDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy hh:mm:ss");

            }
            catch (Exception ex)
            {

                CLogger.LogError("Error in SurgeryBilling.ascx:Page_Load", ex);
            }

        }
    }


    public void GetSurgeonNameAndSurgeryType()
    {
        ipBL = new IP_BL(base.ContextInfo);
        try
        {
            returnCode = ipBL.GetSurgeonNameAndSurgeryType(OrgID, out lstIPTreatmentType, out lstChiefPhysician, out lstAnesthisa, out lstInstrumentationMaster,out lstNurse);

            if (returnCode == 0)
            {
                if (lstChiefPhysician.Count > 0)
                {
                    LoadChiefOperator();
                    LoadAssistentOperator();
                }

                if (lstAnesthisa.Count > 0)
                {
                    LoadAnesthisia();
                }

                if (lstIPTreatmentType.Count > 0)
                {
                    LoadTreatmentType();
                }

                if (lstInstrumentationMaster.Count > 0)
                {
                    LoadInstrumentationMaster();
                }
                if (lstNurse.Count > 0)
                {
                    LoadnurseName();
                }



            }
        }

        catch (Exception ex)
        {

            CLogger.LogError("Error in SurgeryBilling.ascx GetSurgeonNameAndSurgeryType()", ex);
        }


    }

    private void LoadnurseName()
    {
        try
        {
            drpNurse.DataSource = lstNurse;
            drpNurse.DataTextField = "NurseName";
            drpNurse.DataValueField = "NurseID";
            drpNurse.DataBind();

        }

        catch (Exception ex)
        {

            CLogger.LogError("Error in SurgeryBilling.ascx Load Nurse Name()", ex);
        }
    }


    private void LoadInstrumentationMaster()
    {
        try
        {
            ddlInsChg.DataSource = lstInstrumentationMaster;
            ddlInsChg.DataTextField = "Name";
            ddlInsChg.DataValueField = "InstrumentationID";
            ddlInsChg.DataBind();
            //drpinstrumentnames.DataSource = lstInstrumentationMaster;
            //drpinstrumentnames.DataTextField = "Name";
            //drpinstrumentnames.DataValueField = "InstrumentationID";
            //drpinstrumentnames.DataBind();


        }

        catch (Exception ex)
        {

            CLogger.LogError("Error in SurgeryBilling.ascx LoadInstrumentationMaster()", ex);
        }
    }

   
    public void BindSurgeryDetailByVisitID()
    {
        ipBL = new IP_BL(base.ContextInfo);
        try
        {
            List<SurgeryBillingMaster> lstSurgeryBillingMasterByVisitid = new List<SurgeryBillingMaster>();
            ipBL.BindSurgeryBillingDetailByVisitID(lVisitID, out lstSurgeryBillingMasterByVisitid);
            if (lstSurgeryBillingMasterByVisitid.Count > 0)
            {
                tbSurgery.Style.Add("display", "block");
                gvTreatment.DataSource = lstSurgeryBillingMasterByVisitid;
                gvTreatment.DataBind();
            }



        }

        catch (Exception ex)
        {

            CLogger.LogError("Error in SurgeryBilling.ascx BindSurgeryDetailByVisitID()", ex);
        }

    }

    public void LoadAllIPTreatmentPlanChild()
    {
        invBL = new Investigation_BL(base.ContextInfo);
        ipBL = new IP_BL(base.ContextInfo);
        PVBL = new PatientVisit_BL(base.ContextInfo);



        try
        {
            List<IPTreatmentPlanMaster> lstAllIPTreatmentPlanChild = new List<IPTreatmentPlanMaster>();
           // invenBL.GetVisitDetails(lVisitID,out lstPatientVisit);
            PVBL.GetInPatientVisitDetails(lPatientID, out lstInPatientVisit);
            if (lstInPatientVisit.Count > 0)
            {
                //here mapping clinetID entity is used instead of ClientID
                iClientID = Convert.ToInt32(lstInPatientVisit[0].MappingClientID);
                
            }

         
            ipBL.GetAllIPTreatmentPlanChild(OrgID, out lstAllIPTreatmentPlanChild);
            //invBL.GetInvestigationByClientID(lVisitID,OrgID, iClientID, "SOI", out lstInv);
            invBL.GetSurgeryByClientID(lVisitID, OrgID, iClientID, "SOI", out lstInv);
            if (lstInv.Count > 0)
            {
                //InvStatusReasonID --nothing but RateID (used this entity for getRateID)
                hdnRateID.Value = Convert.ToString(lstInv[0].InvStatusReasonID);
            
            }
             
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
            if (lstInv.Count > 0)
            {
                foreach (PatientInvestigation objIPTreatmentRate in lstInv)
                {
                    hdnIPTreatmentRate.Value += objIPTreatmentRate.GroupNameRate;
                }
            }

          
            

        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in SurgeryBilling.ascx LoadAllIPTreatmentPlanChild()", ex);
        }
    }

    private void LoadTreatmentType()
    {
        try
        {
            ddlIPTreatmentPlanMaster.DataSource = lstIPTreatmentType;
            ddlIPTreatmentPlanMaster.DataTextField = "IPTreatmentPlanName";
            ddlIPTreatmentPlanMaster.DataValueField = "TreatmentPlanID";
            ddlIPTreatmentPlanMaster.DataBind();
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in SurgeryBilling.ascx LoadTreatmentType()", ex);
        }
       
    }

    private void LoadChiefOperator()
    {
        try
        {
            ddlChief.DataSource = lstChiefPhysician;
            ddlChief.DataTextField = "PhysicianName";
            ddlChief.DataValueField = "PhysicianID";
            ddlChief.DataBind();
            DrpCheifSurgeon.DataSource = lstChiefPhysician;
            DrpCheifSurgeon.DataTextField = "PhysicianName";
            DrpCheifSurgeon.DataValueField = "PhysicianID";
            DrpCheifSurgeon.DataBind();
        }

        catch (Exception ex)
        {

            CLogger.LogError("Error in SurgeryBilling.ascx LoadChiefOperator()", ex);
        }
       
    }

    private void LoadAssistentOperator()
    {
        try
        {
            ddlAssistent.DataSource = lstChiefPhysician;
            ddlAssistent.DataTextField = "PhysicianName";
            ddlAssistent.DataValueField = "PhysicianID";
            ddlAssistent.DataBind();
            DrpAssistantSurgeon.DataSource = lstChiefPhysician;
            DrpAssistantSurgeon.DataTextField = "PhysicianName";
            DrpAssistantSurgeon.DataValueField = "PhysicianID";
            DrpAssistantSurgeon.DataBind();
            
           
        }

        catch (Exception ex)
        {

            CLogger.LogError("Error in SurgeryBilling.ascx LoadChiefOperator()", ex);
        }
      
    }

    private void LoadAnesthisia()
    {
        try
        {
            ddlAnesthetist.DataSource = lstAnesthisa;
            ddlAnesthetist.DataTextField = "PhysicianName";
            ddlAnesthetist.DataValueField = "PhysicianID";
            ddlAnesthetist.DataBind();
            DrpAnesthesiast.DataSource = lstAnesthisa;
            DrpAnesthesiast.DataTextField = "PhysicianName";
            DrpAnesthesiast.DataValueField = "PhysicianID";
            DrpAnesthesiast.DataBind();
            
        }

        catch (Exception ex)
        {

            CLogger.LogError("Error in SurgeryBilling.ascx LoadAnesthisia()", ex);
        }
    }

   

    protected void gvTreatment_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                SurgeryBillingMaster o = (SurgeryBillingMaster)e.Row.DataItem;
                string strScript = "SelectSurgeryRowCommon('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + o.SurgeryBillingID + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);

            }

        }

        catch (Exception ex)
        {

            CLogger.LogError("Error in SurgeryBilling.ascx gvTreatment_RowDataBound()", ex);
        }
    }

    public void ClearData()
    {
        try
        {
            txtSurgigalFee.Text = string.Empty;
            txtChiefSurgenFee.Text = string.Empty;
            txtOTCharges.Text = string.Empty;
            txtlabourCharges.Text = string.Empty;
            txtConsumablesCharges.Text = string.Empty;
            txtProsthesis.Text = string.Empty;
            hdntreatmentID.Value = "";
            hdntreatmentName.Value = "";
            iconHidAssistant.Value = "";
            iconHidAnesthetist.Value = "";
            iconHidOthers.Value = "";
            hdnSurgeryBillingID.Value = "";
            txtOthers.Text = "";
            hdnInsChg.Value = "";
            divOthers.Style.Add("display", "none");
        }

        catch (Exception ex)
        {

            CLogger.LogError("Error in SurgeryBilling.ascx ClearData()", ex);
        }

    }

    public List<SurgeryBillingDetails> LoadSurgeryBillingDetails()
    {
        List<SurgeryBillingDetails> lstSurgeryBillingDetailsTemp = new List<SurgeryBillingDetails>();

        try
        {


            foreach (string strAssistant in iconHidAssistant.Value.Split('^'))
            {
                if (strAssistant != "")
                {
                    SurgeryBillingDetails oSurgeryBillingDetails = new SurgeryBillingDetails();
                    string[] AssistantfeeDetails = strAssistant.Split('~');
                    oSurgeryBillingDetails.PhysicianID = Convert.ToInt64(AssistantfeeDetails[2]);
                    oSurgeryBillingDetails.Description = "Assistant Surgeon's Fee";
                    oSurgeryBillingDetails.Type = "ASS";
                    oSurgeryBillingDetails.Value = Convert.ToDecimal(AssistantfeeDetails[3]);
                    oSurgeryBillingDetails.CreatedBy = LID;
                    lstSurgeryBillingDetailsTemp.Add(oSurgeryBillingDetails);
                }
            }

            foreach (string strAnesthetist in iconHidAnesthetist.Value.Split('^'))
            {
                if (strAnesthetist != "")
                {
                    SurgeryBillingDetails oSurgeryBillingDetails = new SurgeryBillingDetails();
                    string[] AnesthetistfeeDetails = strAnesthetist.Split('~');
                    oSurgeryBillingDetails.PhysicianID = Convert.ToInt64(AnesthetistfeeDetails[2]);
                    oSurgeryBillingDetails.Description = "Anesthetist";
                    oSurgeryBillingDetails.Type = "ANST";
                    oSurgeryBillingDetails.Value = Convert.ToDecimal(AnesthetistfeeDetails[3]);
                    oSurgeryBillingDetails.CreatedBy = LID;
                    lstSurgeryBillingDetailsTemp.Add(oSurgeryBillingDetails);

                }
            }

            foreach (string strOthers in iconHidOthers.Value.Split('^'))
            {
                if (strOthers != "")
                {
                    SurgeryBillingDetails oSurgeryBillingDetails = new SurgeryBillingDetails();
                    string[] OthersfeeDetails = strOthers.Split('~');
                    oSurgeryBillingDetails.Description = OthersfeeDetails[1];
                    oSurgeryBillingDetails.Type = "OTH";
                    oSurgeryBillingDetails.Value = Convert.ToDecimal(OthersfeeDetails[2]);
                    oSurgeryBillingDetails.CreatedBy = LID;
                    lstSurgeryBillingDetailsTemp.Add(oSurgeryBillingDetails);
                }
            }

            foreach (string strIns in hdnInsChg.Value.Split('^'))
            {
                if (strIns != "")
                {


                    SurgeryBillingDetails oSurgeryBillingDetails = new SurgeryBillingDetails();
                    string[] InsDetails = strIns.Split('~');
                    oSurgeryBillingDetails.PhysicianID = Convert.ToInt64(InsDetails[2]);
                    oSurgeryBillingDetails.Description = "Instrumentation charges";
                    oSurgeryBillingDetails.Type = "INST";
                    oSurgeryBillingDetails.Value = Convert.ToDecimal(InsDetails[3]);
                    oSurgeryBillingDetails.CreatedBy = LID;
                    lstSurgeryBillingDetailsTemp.Add(oSurgeryBillingDetails);
                }
            }


            foreach (string strAssistant in iconHidAssistantdefined.Value.Split('^'))
            {
                if (strAssistant != "")
                {
                    SurgeryBillingDetails oSurgeryBillingDetails = new SurgeryBillingDetails();
                    string[] AssistantfeeDetails = strAssistant.Split('~');
                    oSurgeryBillingDetails.PhysicianID = Convert.ToInt64(AssistantfeeDetails[2]);
                    oSurgeryBillingDetails.Description = "Assistant Surgeon";
                    oSurgeryBillingDetails.Type = "ASS";
                //    oSurgeryBillingDetails.Value = Convert.ToDecimal(AssistantfeeDetails[3]);
                    oSurgeryBillingDetails.CreatedBy = LID;
                    lstSurgeryBillingDetailsTemp.Add(oSurgeryBillingDetails);
                }
            }

            foreach (string strAnesthetist in iconHidAnesthetistDefined.Value.Split('^'))
            {
                if (strAnesthetist != "")
                {
                    SurgeryBillingDetails oSurgeryBillingDetails = new SurgeryBillingDetails();
                    string[] AnesthetistfeeDetails = strAnesthetist.Split('~');
                    oSurgeryBillingDetails.PhysicianID = Convert.ToInt64(AnesthetistfeeDetails[2]);
                    oSurgeryBillingDetails.Description = "Anesthetist";
                    oSurgeryBillingDetails.Type = "ANST";
                  //  oSurgeryBillingDetails.Value = Convert.ToDecimal(AnesthetistfeeDetails[3]);
                    oSurgeryBillingDetails.CreatedBy = LID;
                    lstSurgeryBillingDetailsTemp.Add(oSurgeryBillingDetails);

                }
            }
            foreach (string strnurse in iconHidNurseDefined.Value.Split('^'))
            {
                if (strnurse != "")
                {
                    SurgeryBillingDetails oSurgeryBillingDetails = new SurgeryBillingDetails();
                    string[] AnesthetistfeeDetails = strnurse.Split('~');
                    oSurgeryBillingDetails.PhysicianID = Convert.ToInt64(AnesthetistfeeDetails[2]);
                    oSurgeryBillingDetails.Description = "Nusre";
                    oSurgeryBillingDetails.Type = "NUR";
                  //  oSurgeryBillingDetails.Value = Convert.ToDecimal(AnesthetistfeeDetails[3]);
                    oSurgeryBillingDetails.CreatedBy = LID;
                    lstSurgeryBillingDetailsTemp.Add(oSurgeryBillingDetails);

                }
            }

           
           


        }

        catch (Exception ex)
        {

            CLogger.LogError("Error in SurgeryBilling.ascx LoadSurgeryBillingDetails()", ex);
        }
        
        return lstSurgeryBillingDetailsTemp;
    }


    public List<SurgeryBillingMaster> LoadSurgeryBillingMasterData(long visitID, long patientID)
    {
        List<SurgeryBillingMaster> lstSurgeryBillingMasterTemp = new List<SurgeryBillingMaster>();
        try
        {
            SurgeryBillingMaster oSurgeryBillingMaster = new SurgeryBillingMaster();
            oSurgeryBillingMaster.PatientVisitID = visitID;
            oSurgeryBillingMaster.PatientID = patientID;

            if (hdntreatmentName.Value == "Others")
            {
                oSurgeryBillingMaster.SurgeryID = Convert.ToInt64(hdntreatmentID.Value);
                oSurgeryBillingMaster.TreatmentName = txtOthers.Text;
            }
            else
            {
                oSurgeryBillingMaster.SurgeryID = Convert.ToInt64(hdntreatmentID.Value);
                oSurgeryBillingMaster.TreatmentName = hdntreatmentName.Value;
            }

            if (txtSurgigalFee.Text != "")
            {
                oSurgeryBillingMaster.SurgicalFee = Convert.ToDecimal(txtSurgigalFee.Text);
            }
            oSurgeryBillingMaster.ChiefSurgeonID = Convert.ToInt64(ddlChief.SelectedValue);
            oSurgeryBillingMaster.ChiefSurgeonName = ddlChief.SelectedItem.Text;
            if (hdnSurgeryBillingID.Value != "")
            {
                oSurgeryBillingMaster.SurgeryBillingID = Convert.ToInt64(hdnSurgeryBillingID.Value);
            }
            if (SurgeyFeeDefined == "N")
            {

                if (txtChiefSurgenFee.Text != "")
                {
                    oSurgeryBillingMaster.ChiefSurgeonFee = Convert.ToDecimal(txtChiefSurgenFee.Text);
                }
                if (txtOTCharges.Text != "")
                {
                    oSurgeryBillingMaster.OTCharges = Convert.ToDecimal(txtOTCharges.Text);
                }
                if (txtConsumablesCharges.Text != "")
                {
                    oSurgeryBillingMaster.Consumables = Convert.ToDecimal(txtConsumablesCharges.Text);
                }
                if (txtlabourCharges.Text != "")
                {
                    oSurgeryBillingMaster.RoomCharges = Convert.ToDecimal(txtlabourCharges.Text);
                }
                if (txtProsthesis.Text != "")
                {
                    oSurgeryBillingMaster.ProsthesisFee = Convert.ToDecimal(txtProsthesis.Text);
                }
            }
            else
            {
                if (txtOTChargesdefined.Text != "")
                {
                    oSurgeryBillingMaster.OTCharges = Convert.ToDecimal(txtOTChargesdefined.Text);
                }
                if (txtDefinedConsumablesCharges.Text != "")
                {
                    oSurgeryBillingMaster.Consumables = Convert.ToDecimal(txtDefinedConsumablesCharges.Text);
                }
                if (txtRoomChargesdefined.Text != "")
                {
                    oSurgeryBillingMaster.RoomCharges = Convert.ToDecimal(txtRoomChargesdefined.Text);
                }
                if (txtDefinedProsthesis.Text != "")
                {
                    oSurgeryBillingMaster.ProsthesisFee = Convert.ToDecimal(txtDefinedProsthesis.Text);
                }
            }
            oSurgeryBillingMaster.CreatedAt = Convert.ToDateTime(txtBillDate.Text);
            oSurgeryBillingMaster.CreatedBy = LID;
            if (hdnDiscEnhc.Value != "")
            {
                oSurgeryBillingMaster.DiscountPercent = Convert.ToDecimal(hdnDiscEnhc.Value);
            }
            oSurgeryBillingMaster.DiscOrEnhanceType = hdnDiscEnhctype.Value;
            oSurgeryBillingMaster.Remarks = hdnRemark.Value;
            lstSurgeryBillingMasterTemp.Add(oSurgeryBillingMaster);

        }

        catch (Exception ex)
        {

            CLogger.LogError("Error in SurgeryBilling.ascx LoadSurgeryBillingMasterData()", ex);
        }
        return lstSurgeryBillingMasterTemp;
    }
    protected void btnEditOperationNotes_Click(object sender, EventArgs e)
    {
        try
        {
            if (Request.Form["pid"] != null && Request.Form["pid"].ToString() != "")
            {
                RdoValue = Request.Form["pid"];
            }
            Session["SurgeryBillingID"] = RdoValue;
            GetSurgeryBillingBySurgeryBillingID();

        }

        catch (Exception ex)
        {

            CLogger.LogError("Error in SurgeryBilling.ascx btnEditOperationNotes_Click()", ex);
        }
    }
    public void GetEditSurgeryAmount(out decimal SurgeryAmount)
    {
        SurgeryAmount = Convert.ToDecimal(hdnSurgeryAmount.Value);
    }

    public void GetSurgeryBillingBySurgeryBillingID()
    {
        ipBL = new IP_BL(base.ContextInfo);
        decimal totalBilled = 0;
        try
        {
            string tempOperationID = Session["SurgeryBillingID"].ToString();

            Int64.TryParse(tempOperationID, out SurgeryBillingID);
            List<SurgeryBillingMaster> lstSurgeryBillingMaster = new List<SurgeryBillingMaster>();
            List<SurgeryBillingDetails> lstSurgeryBillingDetails = new List<SurgeryBillingDetails>();
            List<SurgeryBillingDetails> lstAssistantPhysicianOperationStaff = new List<SurgeryBillingDetails>();
            List<SurgeryBillingDetails> lstAnesthisiaOperationStaff = new List<SurgeryBillingDetails>();
            ipBL.GetSurgeryBillingBySurgeryBillingID(SurgeryBillingID, out lstSurgeryBillingMaster, out lstSurgeryBillingDetails, out lstAssistantPhysicianOperationStaff, out lstAnesthisiaOperationStaff, out pTreatmentMasterID);

            

            if (lstAssistantPhysicianOperationStaff.Count > 0)
            {
                iconHidAssistant.Value = "";
                int i = 1;
                foreach (SurgeryBillingDetails objAssistant in lstAssistantPhysicianOperationStaff)
                {
                    iconHidAssistant.Value += i + "~" + objAssistant.PhysicianName + "~" + objAssistant.PhysicianID + "~" + objAssistant.Value + "^";
                    i += 1;
                    totalBilled = totalBilled + Convert.ToDecimal(objAssistant.Value);
                }

            }

            if (lstAnesthisiaOperationStaff.Count > 0)
            {

                var Anesthisialst = from objAnst in lstAnesthisiaOperationStaff
                                    where objAnst.Type == "ANST"
                                    select objAnst;

                var Instrumenrationlst = from objInst in lstAnesthisiaOperationStaff
                                         where objInst.Type == "INST"
                                         select objInst;

                if (Anesthisialst.Count() > 0)
                {


                    iconHidAnesthetist.Value = "";
                    int i = 200;
                    foreach (var objAnesthisia in Anesthisialst)
                    {
                        iconHidAnesthetist.Value += i + "~" + objAnesthisia.PhysicianName + "~" + objAnesthisia.PhysicianID + "~" + objAnesthisia.Value + "^";
                        i += 1;
                        totalBilled = totalBilled + Convert.ToDecimal(objAnesthisia.Value);
                    }
                }


                if (Instrumenrationlst.Count() > 0)
                {


                    hdnInsChg.Value = "";
                    int i = 200;
                    foreach (var objIns in Instrumenrationlst)
                    {
                        hdnInsChg.Value += i + "~" + objIns.PhysicianName + "~" + objIns.PhysicianID + "~" + objIns.Value + "^";
                        i += 1;
                        totalBilled = totalBilled + Convert.ToDecimal(objIns.Value);
                    }
                }
            }

            if (lstSurgeryBillingDetails.Count > 0)
            {
                iconHidOthers.Value = "";
                int i = 300;
                foreach (SurgeryBillingDetails objSBD in lstSurgeryBillingDetails)
                {
                    iconHidOthers.Value += i + "~" + objSBD.Description + "~" + objSBD.Value + "^";
                    i += 1;
                    totalBilled = totalBilled + Convert.ToDecimal(objSBD.Value);
                }
            }

            if (lstSurgeryBillingMaster.Count > 0)
            {
                hdnTID.Value = "";
                if (lstSurgeryBillingMaster[0].SurgeryID == 2 || lstSurgeryBillingMaster[0].SurgeryID == 1)
                {
                    divOthers.Style.Add("display", "Block");
                    ddlIPTreatmentPlanMaster.SelectedValue = lstSurgeryBillingMaster[0].SurgeryID.ToString();
                    hdnTID.Value = "0";
                    ddlIPTreatmentPlanChild.SelectedValue = "0";
                    txtOthers.Text = lstSurgeryBillingMaster[0].TreatmentName;

                }
                else
                {
                    divOthers.Style.Add("display", "none");
                    ddlIPTreatmentPlanMaster.SelectedValue = pTreatmentMasterID.ToString();
                    hdnTID.Value = lstSurgeryBillingMaster[0].SurgeryID.ToString();
                    ddlIPTreatmentPlanChild.SelectedValue = lstSurgeryBillingMaster[0].SurgeryID.ToString();

                }
                totalBilled = totalBilled + lstSurgeryBillingMaster[0].SurgicalFee +
                                            lstSurgeryBillingMaster[0].ChiefSurgeonFee +
                                            lstSurgeryBillingMaster[0].OTCharges +
                                            lstSurgeryBillingMaster[0].Consumables +
                                            lstSurgeryBillingMaster[0].RoomCharges +
                                            lstSurgeryBillingMaster[0].ProsthesisFee;

                ddlChief.SelectedValue = lstSurgeryBillingMaster[0].ChiefSurgeonID.ToString();
                txtChiefSurgenFee.Text = lstSurgeryBillingMaster[0].ChiefSurgeonFee.ToString();
                txtSurgigalFee.Text = lstSurgeryBillingMaster[0].SurgicalFee.ToString();
                txtOTCharges.Text = lstSurgeryBillingMaster[0].OTCharges.ToString();
                txtlabourCharges.Text = lstSurgeryBillingMaster[0].RoomCharges.ToString();
                txtConsumablesCharges.Text = lstSurgeryBillingMaster[0].Consumables.ToString();
                txtProsthesis.Text = lstSurgeryBillingMaster[0].ProsthesisFee.ToString();
                txtBillDate.Text = Convert.ToDateTime(lstSurgeryBillingMaster[0].CreatedAt).ToString("dd-MM-yyyy hh:mm:ss");
                hdnSurgeryBillingID.Value = SurgeryBillingID.ToString();
            }
            hdnSurgeryAmount.Value = totalBilled.ToString("0.00");

            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Showddl", "javascript:SurgicalFeeGetSplitUps('" + lstSurgeryBillingMaster[0].SurgeryID.ToString() + "');", true);
      
        }

        catch (Exception ex)
        {

            CLogger.LogError("Error in SurgeryBilling.ascx GetSurgeryBillingBySurgeryBillingID()", ex);
        }
    }

    public string GetConfigValue(string configKey, int orgID)
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
}
