using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Drawing;
using System.Web.UI.HtmlControls;


public partial class InPatient_DeliveryNotes : BasePage
{
    public InPatient_DeliveryNotes()
        : base("InPatient\\DeliveryNotes.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    List<SurgeryType> lstSurgeryType = new List<SurgeryType>();
    List<AnesthesiaType> lstAnesthesiaType = new List<AnesthesiaType>();
    List<DeliveryTypeMaster> lstDeliveryTypeMaster = new List<DeliveryTypeMaster>();
    List<Physician> lstDeliveringObstretician = new List<Physician>();
    List<Physician> lstNeonatologist = new List<Physician>();
    List<FetalPresentations> lstFetalPresentations = new List<FetalPresentations>();

    List<LabourAndDeliveryNotes> lstLabourAndDeliveryNotes = new List<LabourAndDeliveryNotes>();
    List<PatientComplication> lstPatientComplication = new List<PatientComplication>();
    List<NewBornDetails> lstNewBornDetails = new List<NewBornDetails>();
    List<BirthInstructions> lstBirthInstructions = new List<BirthInstructions>();

    Neonatal_BL objNeonatal_BL ;
    long returnCode = -1;
    string pName = string.Empty;
    long patientVisitID = -1;
    long patientID = -1;
    string pType = string.Empty;
    int i = 1;
    int j = 0;

    int NewChildCount = 0;    

    protected void Page_Load(object sender, EventArgs e)
    {
        objNeonatal_BL = new Neonatal_BL(base.ContextInfo);
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);

        if (!IsPostBack)
        {
            ComplaintICDCode1.ComplaintHeader = "Complication";
            ComplaintICDCode1.SetWidth(500);
            GetFCKPath();

            pGetDeliveryNotesData();
            GetDeliveryNotesDataForUpdate();
        }

        if (Request.QueryString["page"] == "ICD")
        {
            btnCancel.Visible = false;
            btnFinish.Visible = false;
            btnIns.Visible = false;          
            MainHeader.Visible = false;
            ComplaintICDCode1.AddBtnVisible = "False";
            ComplaintICDCode1.SetComplaint();
        }
    }

    private void GetDeliveryNotesDataForUpdate()
    {

        returnCode = objNeonatal_BL.GetDeliveryNotesDataForUpdate(patientVisitID, out lstLabourAndDeliveryNotes, out lstPatientComplication, out lstBirthInstructions, out lstNewBornDetails);
        
        if (returnCode == 0)
        {
            if (lstLabourAndDeliveryNotes.Count > 0)
            {
                hdnEdit.Value = "Y";
                ddlNewbornDetails.Enabled = true;
                btnFinish.Text = "Update";
                ddlGenerationType.Enabled = false;
                ddlNewbornDetails.SelectedValue = "Edit Labour And Delivery Notes";

                hdnBirthRegID.Value = lstLabourAndDeliveryNotes[0].BirthRegID.ToString();
                txtHusbandName.Text = lstLabourAndDeliveryNotes[0].HusbandName;
                ddlTOL.SelectedValue = lstLabourAndDeliveryNotes[0].TypeOfLabour.ToString();
                ddlMOD.SelectedValue = lstLabourAndDeliveryNotes[0].ModeOfDelivery.ToString();
                ddlDS.SelectedValue = lstLabourAndDeliveryNotes[0].DeliveryAssistance.ToString();
                ddlProcedureType.SelectedValue = lstLabourAndDeliveryNotes[0].ProcedureTypeID.ToString();
                ddlGenerationType.SelectedValue = lstLabourAndDeliveryNotes[0].GenerationType.ToString();
                ddlAnesthesiaType.SelectedValue = lstLabourAndDeliveryNotes[0].AnesthesiaTypeID.ToString();               
                ddlDelObstretician.SelectedValue = lstLabourAndDeliveryNotes[0].DeliveringObstreticianID.ToString();
                ddlNeonatologist.SelectedValue = lstLabourAndDeliveryNotes[0].NeonatologistID.ToString();
                fckdeliveryNotes.Value = lstLabourAndDeliveryNotes[0].DeliveryNotes;
               // txtDob.Text = lstLabourAndDeliveryNotes[0].ChildDOB.ToString();

                if (lstLabourAndDeliveryNotes[0].LabourTmax != "")
                {
                    string[] LabourTmax = lstLabourAndDeliveryNotes[0].LabourTmax.Split(' ');
                    txtLhours.Text = LabourTmax[0];
                    txtLmin.Text = LabourTmax[2];
                }

                if (lstLabourAndDeliveryNotes[0].ROMLength != "")
                {
                    string[] ROMLength = lstLabourAndDeliveryNotes[0].ROMLength.Split(' ');
                    txtRomhours.Text = ROMLength[0];
                    txtRommin.Text = ROMLength[2];
                }

                if (lstLabourAndDeliveryNotes[0].DeliveryTerm != "")
                {
                    string[] DeliveryTerm = lstLabourAndDeliveryNotes[0].DeliveryTerm.Split(' ');
                    ddlDeliveryTerm.SelectedValue = DeliveryTerm[0];
                    txtWeeks.Text = DeliveryTerm[1];
                }
               
               
               
                //objLabourAndDeliveryNotes.LabourTmax = txtLhours.Text + " " + "hours" + " " + txtLmin.Text + " " + "min";
                //objLabourAndDeliveryNotes.ROMLength = txtRomhours.Text + " " + "hours" + " " + txtRommin.Text + " " + "min";
                //objLabourAndDeliveryNotes.DeliveryTerm = ddlDeliveryTerm.SelectedValue + " " + txtWeeks.Text + " " + "Weeks";                
            }
            if (lstPatientComplication.Count > 0)
            {
                ComplaintICDCode1.SetPatientComplication(lstPatientComplication);

                    //int i = 220;
                    //hdnComplicationItems.Value = "";
                    //foreach (PatientComplication objCM in lstPatientComplication)
                    //{


                    //    hdnComplicationItems.Value += i + "~" + objCM.ComplicationName + "^";
                    //    i += 1;
                    //}

            }

            if (lstBirthInstructions.Count > 0)
            { 
                    int i = 320;
                    hdnInsItems.Value = "";
                    foreach (BirthInstructions objBI in lstBirthInstructions)
                    {
                        hdnInsItems.Value += i + "~" + objBI.Instructions + "^";
                        i += 1;
                    }
            }

            if (lstNewBornDetails.Count > 0)
            {
                hdnChildCount.Value = lstNewBornDetails.Count.ToString();             
                gvNewBornDetails.DataSource = lstNewBornDetails;
                gvNewBornDetails.DataBind();
            }
            else
            {
                hdnChildCount.Value = lstNewBornDetails.Count.ToString();
              
            }
        }
    }

    public void pGetDeliveryNotesData()
    {
       
        returnCode = objNeonatal_BL.GetDeliveryNotesData(OrgID, out lstSurgeryType, out lstAnesthesiaType, out lstDeliveryTypeMaster, out lstDeliveringObstretician, out lstNeonatologist, out lstFetalPresentations);

        if (returnCode == 0)
        {
            if (lstSurgeryType.Count > 0)
            {
                ddlProcedureType.DataSource = lstSurgeryType;
                ddlProcedureType.DataTextField = "TypeName";
                ddlProcedureType.DataValueField = "SurgeryTypeID";
                ddlProcedureType.DataBind();
                //ddlProcedureType.Items.Insert(0, "-----Select-----");
                //ddlProcedureType.Items[0].Value = "0";
            }

            if (lstAnesthesiaType.Count > 0)
            {
                ddlAnesthesiaType.DataSource = lstAnesthesiaType;
                ddlAnesthesiaType.DataTextField = "TypeName";
                ddlAnesthesiaType.DataValueField = "AnesthesiaTypeID";
                ddlAnesthesiaType.DataBind();
                //ddlAnesthesiaType.Items.Insert(0, "-----Select-----");
                //ddlAnesthesiaType.Items[0].Value = "0";
            }

            if (lstDeliveryTypeMaster.Count > 0)
            {
                var lstTOL=from TOL in lstDeliveryTypeMaster
                           where TOL.DeliveryType=="TOL"
                           select TOL;

                ddlTOL.DataSource = lstTOL;
                ddlTOL.DataTextField = "DeliveryTypeName";
                ddlTOL.DataValueField = "DeliveryTypeID";
                ddlTOL.DataBind();
                ddlTOL.Items.Insert(0, "-----Select-----");
                ddlTOL.Items[0].Value = "0";

                var lstMOD = from MOD in lstDeliveryTypeMaster
                             where MOD.DeliveryType == "MOD"
                             select MOD;

                ddlMOD.DataSource = lstMOD;
                ddlMOD.DataTextField = "DeliveryTypeName";
                ddlMOD.DataValueField = "DeliveryTypeID";
                ddlMOD.DataBind();
                ddlMOD.Items.Insert(0, "-----Select-----");
                ddlMOD.Items[0].Value = "0";


                var lstDS = from DS in lstDeliveryTypeMaster
                             where DS.DeliveryType == "DS"
                             select DS;

                ddlDS.DataSource = lstDS;
                ddlDS.DataTextField = "DeliveryTypeName";
                ddlDS.DataValueField = "DeliveryTypeID";
                ddlDS.DataBind();
                ddlDS.Items.Insert(0, "-----Select-----");
                ddlDS.Items[0].Value = "0";
            }

            if (lstDeliveringObstretician.Count > 0)
            {
                ddlDelObstretician.DataSource = lstDeliveringObstretician;
                ddlDelObstretician.DataTextField = "PhysicianName";
                ddlDelObstretician.DataValueField = "PhysicianID";
                ddlDelObstretician.DataBind();
                //ddlDelObstretician.Items.Insert(0, "-----Select-----");
                //ddlDelObstretician.Items[0].Value = "0";
            }

            if (lstNeonatologist.Count > 0)
            {
                ddlNeonatologist.DataSource = lstNeonatologist;
                ddlNeonatologist.DataTextField = "PhysicianName";
                ddlNeonatologist.DataValueField = "PhysicianID";
                ddlNeonatologist.DataBind();
                //ddlNeonatologist.Items.Insert(0, "-----Select-----");
                //ddlNeonatologist.Items[0].Value = "0";
            }

         

           
           
        }

    }

    protected void ddlGenerationType_SelectedIndexChanged(object sender, EventArgs e)
    {
        List<NewBornDetails> lstNewBornDetails = new List<NewBornDetails>();

      
        if (Request.QueryString["PNAME"] != null)
        {
            pName = Request.QueryString["PNAME"];
        }

        if (ddlGenerationType.SelectedValue != "--Select--")
        {

            for (int i = 0; i < Convert.ToInt32(ddlGenerationType.SelectedValue); i++)
            {
                NewBornDetails objNewBornDetails = new NewBornDetails();
                lstNewBornDetails.Add(objNewBornDetails);
            }
        }

        gvNewBornDetails.DataSource = lstNewBornDetails;
        gvNewBornDetails.DataBind();
    }

    protected void gvNewBornDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
      
        if (e.Row.RowType == DataControlRowType.DataRow)

        {           
            returnCode = objNeonatal_BL.GetDeliveryNotesData(OrgID, out lstSurgeryType, out lstAnesthesiaType, out lstDeliveryTypeMaster, out lstDeliveringObstretician, out lstNeonatologist, out lstFetalPresentations);


            DropDownList ddlPresentation = (DropDownList)e.Row.FindControl("ddlPresentation");
            DropDownList ddlGender = (DropDownList)e.Row.FindControl("ddlGender");
            DropDownList ddlStatus = (DropDownList)e.Row.FindControl("ddlStatus");
            
            TextBox txtName = (TextBox)e.Row.FindControl("txtName");

            TextBox txtBirthWeight = (TextBox)e.Row.FindControl("txtBirthWeight");
            TextBox txtHeadCIRC = (TextBox)e.Row.FindControl("txtHeadCIRC");
            TextBox txtCHL = (TextBox)e.Row.FindControl("txtCHL");
            TextBox txtPresentationID = (TextBox)e.Row.FindControl("txtPresentationID");
            TextBox txtSex = (TextBox)e.Row.FindControl("txtSex");
            TextBox txtStatus = (TextBox)e.Row.FindControl("txtStatus");
            TextBox txtOnemin = (TextBox)e.Row.FindControl("txtOnemin");
            TextBox txtfiveMin = (TextBox)e.Row.FindControl("txtfiveMin");
            TextBox txtAPGARScore = (TextBox)e.Row.FindControl("txtAPGARScore");
            TextBox txtDob = (TextBox)e.Row.FindControl("txtDob");
            LinkButton lbtnDOB = (LinkButton)e.Row.FindControl("lbtnDOB");
            lbtnDOB.Attributes.Add("onclick", "NewCal('"+txtDob.ClientID+"','ddmmyyyy',true,12)");

            txtDob.Attributes.Add("onchange", "ExcedDateone('" + txtDob.ClientID.ToString() + "','',0,0);");

            hdnChkValues.Value += txtName.ClientID + "~" + txtDob.ClientID + "^";

          

            if (hdnEdit.Value != "Y")
            {
                string[] s = pName.Split('.');

                txtName.Text = "Baby"+i.ToString()+" of  " + s[1].ToString();

               // txtDob.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
               txtDob.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy hh:mm:ss");
            }

            if (hdnEdit.Value == "Y" && ddlNewbornDetails.SelectedValue=="Add More Child")
            {
                txtDob.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy hh:mm:ss");
                if (hdnNewChildCount.Value == "")
                {
                    string[] s = pName.Split('.');
                    i = i + Convert.ToInt32(hdnChildCount.Value);
                    txtName.Text = "Baby" + i.ToString() + " of  " + s[1].ToString();
                    hdnNewChildCount.Value = i.ToString();
                    Session["NewChildCount"] = i.ToString();
                }
                else
                {
                    string[] s = pName.Split('.');
                    j = Convert.ToInt32(hdnNewChildCount.Value) + 1;
                    txtName.Text = "Baby" + j.ToString() + " of  " + s[1].ToString();
                    hdnNewChildCount.Value = j.ToString();
                    Session["NewChildCount"] = hdnNewChildCount.Value;
                  
                }
            }
            if (lstFetalPresentations.Count > 0)
            {

                ddlPresentation.DataSource = lstFetalPresentations;
                ddlPresentation.DataTextField = "FetalPresentationDesc";
                ddlPresentation.DataValueField = "FetalPresentationID";
                ddlPresentation.DataBind();
                //ddlPresentation.Items.Insert(0, "-----Select-----");
                //ddlPresentation.Items[0].Value = "0";               
            }
            if (hdnEdit.Value == "Y" && ddlNewbornDetails.SelectedValue != "Add More Child")
            {
                string[] BirthWeight = txtBirthWeight.Text.Split(' ');
                txtBirthWeight.Text = BirthWeight[0];

                string[] HeadCIRC = txtHeadCIRC.Text.Split(' ');
                txtHeadCIRC.Text = HeadCIRC[0];

                string[] CHL = txtCHL.Text.Split(' ');
                txtCHL.Text = CHL[0];

                string[] APGARScore = txtAPGARScore.Text.Split(' ');
                txtOnemin.Text = APGARScore[0];
                txtfiveMin.Text = APGARScore[1];

                ddlPresentation.SelectedValue = txtPresentationID.Text;
                ddlStatus.SelectedValue = txtStatus.Text;

                if (txtStatus.Text == "2")
                {
                    txtOnemin.ReadOnly = true;
                    txtfiveMin.ReadOnly = true;
                }

                if (txtSex.Text == "M")
                {
                    ddlGender.SelectedValue = "Male";
                }
                else
                {
                    ddlGender.SelectedValue = "Female";
                }
                //txtDob.Text = Convert.ToDateTime(txtDob.Text).ToString("dd-mm-yyyy hh:mm:ss");
                txtDob.Text = Convert.ToDateTime(txtDob.Text).ToString("dd-MM-yyyy hh:mm:ss");

            }
         

            i++;
        }
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {


        if (btnFinish.Text != "Update")
        {
            try
            {
                Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
                Int64.TryParse(Request.QueryString["pid"], out patientID);

                #region Get The LabourAndDeliveryNotes

                LabourAndDeliveryNotes objLabourAndDeliveryNotes = new LabourAndDeliveryNotes();
                objLabourAndDeliveryNotes.HusbandName = txtHusbandName.Text;
                objLabourAndDeliveryNotes.HusbandName = txtHusbandName.Text;
                objLabourAndDeliveryNotes.TypeOfLabour = Convert.ToInt32(ddlTOL.SelectedValue);
                objLabourAndDeliveryNotes.ModeOfDelivery = Convert.ToInt32(ddlMOD.SelectedValue);
                objLabourAndDeliveryNotes.DeliveryAssistance = Convert.ToInt32(ddlDS.SelectedValue);
                objLabourAndDeliveryNotes.ProcedureTypeID = Convert.ToInt32(ddlProcedureType.SelectedValue);
                if ((objLabourAndDeliveryNotes.ModeOfDelivery == 4) || (objLabourAndDeliveryNotes.ModeOfDelivery == 6))
                {
                    objLabourAndDeliveryNotes.Typeid = 1;
                }
                else if (objLabourAndDeliveryNotes.ModeOfDelivery == 7)
                {
                    objLabourAndDeliveryNotes.Typeid = 2;
                }
                else if ((objLabourAndDeliveryNotes.ModeOfDelivery == 5) && (objLabourAndDeliveryNotes.DeliveryAssistance == 8) || (objLabourAndDeliveryNotes.DeliveryAssistance == 9))
                {
                    objLabourAndDeliveryNotes.Typeid = 3;
                }
                else if (objLabourAndDeliveryNotes.DeliveryAssistance == 12)
                {
                    objLabourAndDeliveryNotes.Typeid = 4;
                }
                else if ((objLabourAndDeliveryNotes.DeliveryAssistance == 10) && (objLabourAndDeliveryNotes.DeliveryAssistance == 11))
                {
                    objLabourAndDeliveryNotes.Typeid = 5;
                }             
                if (ddlGenerationType.SelectedValue != "--Select--")
                {
                    objLabourAndDeliveryNotes.GenerationType = Convert.ToInt32(ddlGenerationType.SelectedValue);
                }
                objLabourAndDeliveryNotes.LabourTmax = txtLhours.Text + " " + "hours" + " " + txtLmin.Text + " " + "min";
                objLabourAndDeliveryNotes.ROMLength = txtRomhours.Text + " " + "hours" + " " + txtRommin.Text + " " + "min";
                objLabourAndDeliveryNotes.DeliveryTerm = ddlDeliveryTerm.SelectedValue + " " + txtWeeks.Text + " " + "Weeks";
                objLabourAndDeliveryNotes.DeliveringObstreticianID = Convert.ToInt32(ddlDelObstretician.SelectedValue);
                objLabourAndDeliveryNotes.NeonatologistID = Convert.ToInt32(ddlNeonatologist.SelectedValue);
                objLabourAndDeliveryNotes.DeliveryNotes = fckdeliveryNotes.Value;
                // objLabourAndDeliveryNotes.ChildDOB = Convert.ToDateTime(txtDob.Text);
                objLabourAndDeliveryNotes.AnesthesiaTypeID = Convert.ToInt32(ddlAnesthesiaType.SelectedValue);
                lstLabourAndDeliveryNotes.Add(objLabourAndDeliveryNotes);
                #endregion

                #region Get The PatientComplication Details
              //  lstPatientComplication = GetPatientComplication();
               
                lstPatientComplication = ComplaintICDCode1.GetPatientComplication("Birth");

                #endregion

                #region Get The BirthInstruction Details
                lstBirthInstructions = GetBirthInstructions();
                #endregion

                #region Get The NewbornDetails Details
                lstNewBornDetails = GetlstNewBornDetails();
                #endregion

                pType = "Add";

                string needIPNo = string.Empty;
                List<Config> lstCon = new List<Config>();
                new GateWay(base.ContextInfo).GetConfigDetails("NeedIPNumber", OrgID, out lstCon);
                if (lstCon.Count > 0)
                    needIPNo = lstCon[0].ConfigValue.Trim();

                objNeonatal_BL.SaveLabourAndDeliveryNotes(OrgID, patientVisitID, patientID, LID, pType, NewChildCount, lstLabourAndDeliveryNotes, lstPatientComplication, lstBirthInstructions, lstNewBornDetails, needIPNo);

                if (lstPatientComplication.Count > 0)
                {
                    Patient_BL objPatient_BL = new Patient_BL(base.ContextInfo);
                    objPatient_BL.UpdatePatientICDStatus(patientVisitID);
                }
                Navigation navigation = new Navigation();
                Role role = new Role();
                role.RoleID = RoleID;
                List<Role> userRoles = new List<Role>();
                userRoles.Add(role);
                string relPagePath = string.Empty;
                long returnCode = -1;
                returnCode = navigation.GetLandingPage(userRoles, out relPagePath);
                if (returnCode == 0)
                {
                    Response.Redirect(Request.ApplicationPath  + relPagePath, true);
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
        else if (btnFinish.Text == "Update" && ddlNewbornDetails.SelectedValue == "Edit Labour And Delivery Notes")
        {
            try
            {
                Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
                Int64.TryParse(Request.QueryString["pid"], out patientID);
                #region Get The LabourAndDeliveryNotes

                LabourAndDeliveryNotes objLabourAndDeliveryNotes = new LabourAndDeliveryNotes();
                objLabourAndDeliveryNotes.BirthRegID = Convert.ToInt64(hdnBirthRegID.Value);
                objLabourAndDeliveryNotes.HusbandName = txtHusbandName.Text;
                objLabourAndDeliveryNotes.HusbandName = txtHusbandName.Text;
                objLabourAndDeliveryNotes.TypeOfLabour = Convert.ToInt32(ddlTOL.SelectedValue);
                objLabourAndDeliveryNotes.ModeOfDelivery = Convert.ToInt32(ddlMOD.SelectedValue);
                objLabourAndDeliveryNotes.DeliveryAssistance = Convert.ToInt32(ddlDS.SelectedValue);
                objLabourAndDeliveryNotes.ProcedureTypeID = Convert.ToInt32(ddlProcedureType.SelectedValue);


                if ((objLabourAndDeliveryNotes.ModeOfDelivery == 4) || (objLabourAndDeliveryNotes.ModeOfDelivery == 6))
                {
                    objLabourAndDeliveryNotes.Typeid = 1;
                }
                else if (objLabourAndDeliveryNotes.ModeOfDelivery == 7)
                {
                    objLabourAndDeliveryNotes.Typeid = 2;
                }
                else if ((objLabourAndDeliveryNotes.ModeOfDelivery == 5) && (objLabourAndDeliveryNotes.DeliveryAssistance == 8) || (objLabourAndDeliveryNotes.DeliveryAssistance == 9))
                {
                    objLabourAndDeliveryNotes.Typeid = 3;
                }
                else if (objLabourAndDeliveryNotes.DeliveryAssistance == 12)
                {
                    objLabourAndDeliveryNotes.Typeid = 4;
                }
                else if ((objLabourAndDeliveryNotes.DeliveryAssistance == 10) && (objLabourAndDeliveryNotes.DeliveryAssistance == 11))
                {
                    objLabourAndDeliveryNotes.Typeid = 5;
                }        
                if (ddlGenerationType.SelectedValue != "--Select--")
                {
                    objLabourAndDeliveryNotes.GenerationType = Convert.ToInt32(ddlGenerationType.SelectedValue);
                }
                objLabourAndDeliveryNotes.LabourTmax = txtLhours.Text + " " + "hours" + " " + txtLmin.Text + " " + "min";
                objLabourAndDeliveryNotes.ROMLength = txtRomhours.Text + " " + "hours" + " " + txtRommin.Text + " " + "min";
                objLabourAndDeliveryNotes.DeliveryTerm = ddlDeliveryTerm.SelectedValue + " " + txtWeeks.Text + " " + "Weeks";
                objLabourAndDeliveryNotes.DeliveringObstreticianID = Convert.ToInt32(ddlDelObstretician.SelectedValue);
                objLabourAndDeliveryNotes.NeonatologistID = Convert.ToInt32(ddlNeonatologist.SelectedValue);
                objLabourAndDeliveryNotes.DeliveryNotes = fckdeliveryNotes.Value;
                // objLabourAndDeliveryNotes.ChildDOB = Convert.ToDateTime(txtDob.Text);
                objLabourAndDeliveryNotes.AnesthesiaTypeID = Convert.ToInt32(ddlAnesthesiaType.SelectedValue);
                lstLabourAndDeliveryNotes.Add(objLabourAndDeliveryNotes);
                #endregion

                #region Get The PatientComplication Details
               // lstPatientComplication = GetPatientComplication();
                lstPatientComplication = ComplaintICDCode1.GetPatientComplication("Birth");
                #endregion

                #region Get The BirthInstruction Details
                lstBirthInstructions = GetBirthInstructions();
                #endregion

                #region Get The NewbornDetails Details
                lstNewBornDetails = GetlstNewBornDetails();
                #endregion

                pType = "Update";
                string needIPNo = string.Empty;
                List<Config> lstCon = new List<Config>();
                new GateWay(base.ContextInfo).GetConfigDetails("NeedIPNumber", OrgID, out lstCon);
                if (lstCon.Count > 0)
                    needIPNo = lstCon[0].ConfigValue.Trim();
                objNeonatal_BL.SaveLabourAndDeliveryNotes(OrgID, patientVisitID, patientID, LID, pType, NewChildCount, lstLabourAndDeliveryNotes, lstPatientComplication, lstBirthInstructions, lstNewBornDetails, needIPNo);
                Navigation navigation = new Navigation();
                Role role = new Role();
                role.RoleID = RoleID;
                List<Role> userRoles = new List<Role>();
                userRoles.Add(role);
                string relPagePath = string.Empty;
                long returnCode = -1;
                returnCode = navigation.GetLandingPage(userRoles, out relPagePath);
                if (returnCode == 0)
                {
                    Response.Redirect(Request.ApplicationPath  + relPagePath, true);
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
        else if (btnFinish.Text == "Update" && ddlNewbornDetails.SelectedValue=="Add More Child")
        {
            try
            {
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);          
            #region Get The NewbornDetails Details
            lstNewBornDetails = GetlstNewBornDetails();
            #endregion
            pType = "AddNew";
            NewChildCount =Convert.ToInt32(Session["NewChildCount"]);
            string needIPNo = string.Empty;
            List<Config> lstCon = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails("NeedIPNumber", OrgID, out lstCon);
            if (lstCon.Count > 0)
                needIPNo = lstCon[0].ConfigValue.Trim();
                objNeonatal_BL.SaveLabourAndDeliveryNotes(OrgID, patientVisitID, patientID, LID, pType, NewChildCount, lstLabourAndDeliveryNotes, lstPatientComplication, lstBirthInstructions, lstNewBornDetails, needIPNo);
                Session.Remove("NewChildCount");               
                Navigation navigation = new Navigation();
                Role role = new Role();
                role.RoleID = RoleID;
                List<Role> userRoles = new List<Role>();
                userRoles.Add(role);
                string relPagePath = string.Empty;
                long returnCode = -1;
                returnCode = navigation.GetLandingPage(userRoles, out relPagePath);
                if (returnCode == 0)
                {
                    Response.Redirect(Request.ApplicationPath  + relPagePath, true);
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
    }
    private List<BirthInstructions> GetBirthInstructions()
    {
        List<BirthInstructions> lstBirthInstructionsTemp = new List<BirthInstructions>();
        foreach (string listInsItems in hdnInsItems.Value.Split('^'))
        {
            if (listInsItems != "")
            {
                BirthInstructions objBirthInstructions = new BirthInstructions();
                string[] listChildlistInsItems = listInsItems.Split('~');
                objBirthInstructions.InstructionID = 0;
                objBirthInstructions.Instructions = listChildlistInsItems[1];
                lstBirthInstructionsTemp.Add(objBirthInstructions);
            }
        }
        return lstBirthInstructionsTemp;
    }

    //private List<PatientComplication> GetPatientComplication()
    //{
    //    List<PatientComplication> lstPatientComplicationTemp = new List<PatientComplication>();
    //    foreach (string listComplication in hdnComplicationItems.Value.Split('^'))
    //    {
    //        if (listComplication != "")
    //        {
    //            PatientComplication objPatientComplication = new PatientComplication();
    //            string[] listChildComplication = listComplication.Split('~');
    //            objPatientComplication.ComplicationID = 0;
    //            objPatientComplication.ComplicationName = listChildComplication[1];
    //            objPatientComplication.ComplicationType = "Birth";
    //            lstPatientComplicationTemp.Add(objPatientComplication);
    //        }
    //    }
    //    return lstPatientComplicationTemp;
    //}


    private List<NewBornDetails> GetlstNewBornDetails()
    {
        List<NewBornDetails> lstNewBornDetailsTemp = new List<NewBornDetails>();

        foreach (GridViewRow gr in gvNewBornDetails.Rows)
        {
            NewBornDetails objNewBornDetails = new NewBornDetails();
            TextBox txtName = (TextBox)gr.FindControl("txtName");
            TextBox txtBirthWeight = (TextBox)gr.FindControl("txtBirthWeight");
            TextBox txtHeadCIRC = (TextBox)gr.FindControl("txtHeadCIRC");
            TextBox txtCHL = (TextBox)gr.FindControl("txtCHL");
            TextBox txtOnemin = (TextBox)gr.FindControl("txtOnemin");
            TextBox txtfiveMin = (TextBox)gr.FindControl("txtfiveMin");
            TextBox txtIdentiFicationMarks1 = (TextBox)gr.FindControl("txtIdentiFicationMarks1");
            TextBox txtIdentiFicationMarks2 = (TextBox)gr.FindControl("txtIdentiFicationMarks2");
            TextBox txtNewBornDetailID = (TextBox)gr.FindControl("txtNewBornDetailID");
            TextBox txtPatientID = (TextBox)gr.FindControl("txtPatientID");
            TextBox txtDob = (TextBox)gr.FindControl("txtDob");
            DropDownList ddlGender = (DropDownList)gr.FindControl("ddlGender");
            DropDownList ddlPresentation = (DropDownList)gr.FindControl("ddlPresentation");
            DropDownList ddlStatus = (DropDownList)gr.FindControl("ddlStatus");
            objNewBornDetails.Name = txtName.Text;
            if (ddlGender.SelectedValue == "Male")
            {
                objNewBornDetails.Sex = "M";
            }
            else
            {
                objNewBornDetails.Sex = "F";
            }
            objNewBornDetails.IdentiFicationMarks1 = txtIdentiFicationMarks1.Text;
            objNewBornDetails.IdentiFicationMarks2 = txtIdentiFicationMarks2.Text;
            if (txtDob.Text != "")
            {
                objNewBornDetails.DOB = Convert.ToDateTime(txtDob.Text);
            }
            objNewBornDetails.PresentationID=Convert.ToInt32(ddlPresentation.SelectedValue);
            if (txtHeadCIRC.Text != "")
            {
                objNewBornDetails.HeadCIRC = txtHeadCIRC.Text + " " + "cm";
            }
            if (txtCHL.Text != "")
            {
                objNewBornDetails.CHL = txtCHL.Text + " " + "cm";
            }
            objNewBornDetails.Status = ddlStatus.SelectedValue;
            objNewBornDetails.APGARScore = txtOnemin.Text + " " + txtfiveMin.Text;
            if (txtCHL.Text != "")
            {
                objNewBornDetails.BirthWeight = txtBirthWeight.Text + " " + "kg";
            }
            objNewBornDetails.ParentVisitID = patientVisitID;


            if (btnFinish.Text == "Update")
            {
                objNewBornDetails.NewBornDetailID = Convert.ToInt64(txtNewBornDetailID.Text);
                objNewBornDetails.PatientID = Convert.ToInt64(txtPatientID.Text);

            }
            lstNewBornDetailsTemp.Add(objNewBornDetails);
            
        }

        return lstNewBornDetailsTemp;
    }


    protected void ddlNewbornDetails_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (ddlNewbornDetails.SelectedValue == "Edit Labour And Delivery Notes")
        {
            tbl1.Style.Add("display", "block");
            tbl3.Style.Add("display", "block");
            tbl4.Style.Add("display", "block");
            tbl5.Style.Add("display", "block");
            GetDeliveryNotesDataForUpdate();
            ComplaintICDCode1.ComplaintHeader = "Complication";
            ComplaintICDCode1.SetHeader();
        }
        else if (ddlNewbornDetails.SelectedValue == "Add More Child")
        {
            ddlGenerationType.Enabled = true;
            gvNewBornDetails.DataSource = null;
            gvNewBornDetails.DataBind();
            ddlGenerationType.SelectedValue = "--Select--";
            tbl1.Style.Add("display", "none");
            tbl3.Style.Add("display", "none");
            tbl4.Style.Add("display", "none");
            tbl5.Style.Add("display", "none");            
        }
        else
        {
        }
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
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);
            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath  + relPagePath, true);
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

    private void GetFCKPath()
    {
        try
        {
            string sPath = Request.Url.AbsolutePath;
            int iIndex = sPath.LastIndexOf("/");
            sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
            sPath = Request.ApplicationPath ;
            sPath = sPath + "/fckeditor/";
            fckdeliveryNotes.ToolbarSet = "Attune";
            fckdeliveryNotes.BasePath = sPath;
            fckdeliveryNotes.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
            fckdeliveryNotes.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in FCk Editor In DischargeSummary.aspx", ex);
        }
    }

    protected void lnkHome_Click(object sender, EventArgs e)
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
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);
            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath  + relPagePath, true);
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
}
