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
using System.Data;
using System.Security.Cryptography;
using System.Web.UI.HtmlControls;
using Attune.Podium.SmartAccessor;
using Attune.Podium.EMR;

public partial class BloodBank_BloodRequestForm : BasePage
{
    long visitID = 0;
    long returnCode = -1;
    long taskID = -1;
    long patientID = 0;
    string Vtype = string.Empty;
    List<BloodGroup> lstBloodGrp = new List<BloodGroup>();
    List<BloodComponent> lstBloodComponent = new List<BloodComponent>();
    List<Patient> lstPatient = new List<Patient>();
    List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
    List<DonorStatus> lstDonorStatus = new List<DonorStatus>();
    List<BloodCollectionDetails> lstBloodCollect = new List<BloodCollectionDetails>();
    List<BloodCapturedDetials> lstBloodCapture = new List<BloodCapturedDetials>();
    List<BloodRequistionDetails> lstBloodRequest = new List<BloodRequistionDetails>();
    Dialysis_BL objdia = new Dialysis_BL();
    protected void Page_Load(object sender, EventArgs e)
    {
        //ddlBloodComponent.Attributes.Add("onChange", "return ddlBloodComponentChange();");
        //AutoCompleteExtenderBloodComponent.ContextKey = hdnBloodComponentID.Value + '~' + txtBloodComponentName.Text + '~' + OrgID;
        txtNoOfUnits.Attributes.Add("onKeyDown", "return validatenumber(event);");
        Vtype = Request.QueryString["vType"].ToString();
        if (Request.QueryString["PID"] != null && Request.QueryString["VID"] != null)
        {
            patientID = Convert.ToInt32(Request.QueryString["PID"].ToString());
            visitID = Convert.ToInt32(Request.QueryString["VID"].ToString());
            trHospital.Visible = false;
            txtName.Enabled = false;
            txtAge.Enabled = false;
            ddlAge.Enabled = false;
       
            ddlSex.Enabled = false;
            txtContact.Enabled = false;
        }
        else
        {
            trHospital.Visible = true;
            txtName.Enabled = true;
            txtAge.Enabled = true;
            ddlAge.Enabled = true;
            ddlSex.Enabled = true;
            txtContact.Enabled = true;
          
        }
       
        if (!Page.IsPostBack)
        {
            LoadMetaData();
            if (patientID != 0)
            {
                returnCode = new Patient_BL(base.ContextInfo).GetPatientDemoandAddress(patientID, out lstPatient);
                txtName.Text = lstPatient[0].Name;
                txtAge.Text = lstPatient[0].Age.Split(' ')[0];
                if (lstPatient[0].SEX == "M")
                {
                    ddlSex.SelectedIndex = 1;
                    chkPregnant.Enabled = false;
                    txtPregnant.Enabled = false;
                }
                else
                {
                    ddlSex.SelectedIndex = 2;
                    chkPregnant.Enabled = true;
                    txtPregnant.Enabled = true;
                }
                ddlBloodGrp.SelectedValue = lstPatient[0].BloodGroup;
                txtContact.Text = lstPatient[0].PatientAddress[0].MobileNumber;
              //  ddlBloodComponent.Attributes.Add("onChange", "return ddlBloodComponentChange();");
               // AutoCompleteExtender3.ContextKey = OrgID.ToString() + '~' + hdnBloodComponentID.Value;
              
            }
          //  returnCode = new BloodBank_BL(base.ContextInfo).GetBloodGroupsAndComponents(out lstBloodGrp, out lstBloodComponent);
            //if (returnCode == 0)
            //{
            //    if (lstBloodGrp.Count > 0)
            //    {
            //        ddlBloodGrp.DataSource = lstBloodGrp;
            //        ddlBloodGrp.DataValueField = "BloodGroupID";
            //        ddlBloodGrp.DataTextField = "BloodGroupName";
            //        ddlBloodGrp.DataBind();
            //        ddlBloodGrp.Items.Insert(0, "--Select--");
            //        ddlBloodGrp.Items[0].Value = "-1";
            //    }
            //    if (lstBloodComponent.Count > 0)
            //    {
            //        ddlBloodComponent.DataSource = lstBloodComponent;
            //        ddlBloodComponent.DataValueField = "BloodComponentID";
            //        ddlBloodComponent.DataTextField = "BloodComponentName";
            //        ddlBloodComponent.DataBind();
            //    }
            //}
        }
    }
    public void LoadMetaData()
    {
        try
        {

            long returncode = -1;
            string domains = "DateAttributes,Gender,BloodGroup,BloodComponent,CrossMatchingMethod";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";

            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }


            returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "DateAttributes"
                                 select child;

                ddlAge.DataSource = childItems;
                ddlAge.DataTextField = "DisplayText";
                ddlAge.DataValueField = "DisplayText";
                ddlAge.DataBind();
                ddlAge.SelectedValue = "Year(s)";


                var childItems1 = from child in lstmetadataOutput
                                  where child.Domain == "Gender"
                                  select child;


                ddlSex.DataSource = childItems1;
                ddlSex.DataTextField = "DisplayText";
                ddlSex.DataValueField = "Code";
                ddlSex.DataBind();
                ddlSex.Items.Insert(0, "--Select--");
                ddlSex.Items[0].Value = "0";
                //ddlSex.SelectedValue = "M";

                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "BloodGroup"
                                  select child;


                ddlBloodGrp.DataSource = childItems2;
                ddlBloodGrp.DataTextField = "DisplayText";
                ddlBloodGrp.DataValueField = "Code";
                ddlBloodGrp.DataBind();
                ddlBloodGrp.Items.Insert(0, "--Select--");
                ddlBloodGrp.Items[0].Value = "0";

                var childItems3 = from child in lstmetadataOutput
                                  where child.Domain == "BloodComponent"
                                  select child;


                ddlBloodComponent.DataSource = childItems3;
                ddlBloodComponent.DataTextField = "DisplayText";
                ddlBloodComponent.DataValueField = "Code";
                ddlBloodComponent.DataBind();
                ddlBloodComponent.Items.Insert(0, "--Select--");
                ddlBloodComponent.Items[0].Value = "0";

                ddlTransfusionComponent.DataSource = childItems3;
                ddlTransfusionComponent.DataTextField = "DisplayText";
                ddlTransfusionComponent.DataValueField = "Code";
                ddlTransfusionComponent.DataBind();
                ddlTransfusionComponent.Items.Insert(0, "--Select--");
                ddlTransfusionComponent.Items[0].Value = "0";

                List<MetaData> Meta = (from d in lstmetadataOutput
                                       where d.Domain == "CrossMatchingMethod"
                                       select new MetaData
                                       {
                                           DisplayText = d.DisplayText,
                                           Code = d.Code,
                                       }).ToList();

                DropDownList ddl = new DropDownList();
                ddl.ID = "ddlChkList";
                ListItem lstItem = new ListItem();
                ddl.Items.Insert(0, lstItem);
                ddl.Width = new Unit(155);
                ddl.Attributes.Add("onmousedown", "showdivonClick1()");
                CheckBoxList chkBxLst = new CheckBoxList();
                chkBxLst.ID = "chkLstItem";
                chkBxLst.Attributes.Add("onmouseover", "showdiv1()");
                DataTable dtListItem = GetListItem(Meta);
                int rowNo = dtListItem.Rows.Count;
                string lstValue = string.Empty;
                string lstID = string.Empty;
                for (int i = 0; i < rowNo; i++)
                {
                    lstValue = dtListItem.Rows[i]["Value"].ToString();
                    lstID = dtListItem.Rows[i]["ID"].ToString();
                    lstItem = new ListItem("<a href=\"javascript:void(0)\" id=\"alst\" style=\"text-decoration:none;color:Black; \" onclick=\"getSelectedItem(' " + lstValue + "','" + i + "','" + lstID + "','anchor');\">" + lstValue + "</a>", dtListItem.Rows[i]["ID"].ToString());
                    lstItem.Attributes.Add("onclick", "getSelectedItem1('" + lstValue + "','" + i + "','" + lstID + "','listItem');");
                    lstItem.Value = dtListItem.Rows[i]["AttributeValue"].ToString();
                    lstItem.Text = dtListItem.Rows[i]["Value"].ToString();
                    chkBxLst.Items.Add(lstItem);
                }
                System.Web.UI.HtmlControls.HtmlGenericControl div = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
                div.ID = "divChkList";
                div.Controls.Add(chkBxLst);
                div.Style.Add("border", "black 1px solid");
                div.Style.Add("width", "160px");
                div.Style.Add("height", "180px");
                div.Style.Add("overflow", "AUTO");
                div.Style.Add("display", "none");
                phCrossMatchingMethod.Controls.Add(ddl);
                phCrossMatchingMethod.Controls.Add(div);
             
            }
        }




        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
    }
    public DataTable GetListItem(List<MetaData> Meta)
    {
        DataTable table = new DataTable();
        table.Columns.Add("ID", typeof(int));
        table.Columns.Add("Value", typeof(string));
        table.Columns.Add("AttributeValue", typeof(int));
        for (int i = 0; i < Meta.Count; i++)
        {
            table.Rows.Add((i + 1), Meta[i].DisplayText, Meta[i].Code);
        }
        return table;
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Home.aspx");
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Request.QueryString["PID"] != null && Request.QueryString["VID"] != null)
        {
            patientID = Convert.ToInt32(Request.QueryString["PID"].ToString());
            visitID = Convert.ToInt32(Request.QueryString["VID"].ToString());
        }
        DateTime RequestDate = Convert.ToDateTime(txtRequestDate.Text);
        DateTime TransfusionScheduledDate = Convert.ToDateTime(txtTransfusionDate.Text);
        string Status = "Requested";
        string ClinicalIndication = txtIndication.Text.ToString();
        long CrossMatchingMethod = 2;
        string hasPreviousTransfuion = string.Empty;
        string IsPregnant = string.Empty;
        string PregnancyDetails = string.Empty;
        long PreviousTransfusionComponent = -1;
        DateTime PrevoiusTransfusionDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        string PrevoiusTransfusionReaction = string.Empty;
        Tasks task = new Tasks();
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        long pSpecialityID = 0;
        long createTaskID = -1;
        long taskIDReffered = -1;
        long TaskID=0;
        long BloodGroup = Convert.ToInt32(ddlBloodGrp.SelectedValue);
        List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
        List<PatientPrescription> lstpatientprescription = new List<PatientPrescription>();
        Dialysis_BL objDialysis = new Dialysis_BL();
        pSpecialityID = Convert.ToInt32(TaskHelper.speciality.BloodBank);
        if (chkHOTransfusion.Checked)
        {
            hasPreviousTransfuion = "Y";
            PreviousTransfusionComponent = Convert.ToInt32(ddlTransfusionComponent.SelectedValue);
            PrevoiusTransfusionDate = Convert.ToDateTime(txtPrevTransfusionDate.Text.ToString());
            PrevoiusTransfusionReaction = txtTransfusionReaction.Text.ToString();
        }
        else hasPreviousTransfuion = "N";
        if (chkPregnant.Checked)
        {
            IsPregnant = "Y";
            PregnancyDetails = txtPregnant.Text.ToString();
        }
        else IsPregnant = "N";

        foreach (string str in hdnComponents.Value.Split('^'))
        {
            BloodRequistionDetails objBloodRequest = new BloodRequistionDetails();
            if (str != "")
            {
                string[] list = str.Split('~');
                objBloodRequest.BloodComponent = Convert.ToInt32(list[1].ToString());
                objBloodRequest.NoOfUnits = Convert.ToInt32(list[2].ToString());
                objBloodRequest.ProductID = Convert.ToInt32(list[3].ToString());
                objBloodRequest.ProductName = list[4].ToString();
                lstBloodRequest.Add(objBloodRequest);
               
            }
            
        }
        returnCode = new BloodBank_BL(base.ContextInfo).InsertBloodRequest(patientID, visitID, OrgID, RequestDate, TransfusionScheduledDate, Status,
                                                           ClinicalIndication, CrossMatchingMethod, hasPreviousTransfuion, PreviousTransfusionComponent,
                                                           PrevoiusTransfusionDate, PrevoiusTransfusionReaction, IsPregnant, PregnancyDetails, lstBloodRequest);

     

        ////objdia.SavePrescription(lstBloodRequest);
        //   //Task for OP PATIENT BLOOD Billing
        //if(Vtype !="IP")
        //{
            if (returnCode > 0)
            {
                long returnCodeINV = -1;
                returnCodeINV = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
                Hashtable dText = new Hashtable();
                Hashtable urlVal = new Hashtable();

                returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.BloodRequest), visitID, 0,
                         lstPatientVisitDetails[0].PatientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", pSpecialityID, "", 0, "", 0, "", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.BloodRequest);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.SpecialityID = Convert.ToInt32(pSpecialityID);
                //task.BillID = FinalBillID;
                task.PatientVisitID = visitID;
                task.PatientID = patientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;
                //task.RefernceID = labno.ToString();
                //Create task               
                returnCode = taskBL.CreateTask(task, out taskIDReffered);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Registration", "alert('Blood Request is sent');", true);
                Navigation navigation = new Navigation();
                Role role = new Role();
                role.RoleID = RoleID;
                List<Role> userRoles = new List<Role>();
                userRoles.Add(role);
                string relPagePath = string.Empty;
                returnCode = navigation.GetLandingPage(userRoles, out relPagePath);
                if (returnCode == 0)
                {
                    Response.Redirect(Request.ApplicationPath + relPagePath, true);
                }
            }
        //}
            //Task for INPATIENT BLOOD Billing
            //else
            //{
            //    if (returnCode > 0)
            //    {
            //        long returnCodeINV = -1;
            //        returnCodeINV = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
            //        Hashtable dText = new Hashtable();
            //        Hashtable urlVal = new Hashtable();
                  
            //        returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.IPBillingforBlood), visitID, 0,
            //                 lstPatientVisitDetails[0].PatientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", pSpecialityID, "", 0, "", 0, "", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
            //        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.IPBillingforBlood);
            //        task.DispTextFiller = dText;
            //        task.URLFiller = urlVal;
            //        task.RoleID = RoleID;
            //        task.OrgID = OrgID;
            //        task.SpecialityID = Convert.ToInt32(pSpecialityID);
            //        //task.BillID = FinalBillID;
            //        task.PatientVisitID = visitID;
            //        task.PatientID = patientID;
            //        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            //        task.CreatedBy = LID;
            //        //task.RefernceID = labno.ToString();
            //        //Create task               
            //        returnCode = taskBL.CreateTask(task, out taskIDReffered);

            //    }
            //}
            // TaskID = taskIDReffered;

            //foreach (string str in hdnComponents.Value.Split('^'))
            //{
            //    PatientPrescription objpres = new PatientPrescription();
            //    if (str != "")
            //    {
            //        string[] list = str.Split('~');

            //        objpres.DrugID = Convert.ToInt32(list[3].ToString());
            //        objpres.Dose = list[2].ToString();
            //        objpres.BrandName = list[4].ToString();
            //        objpres.PatientVisitID = visitID;
            //        objpres.TotalQty = Convert.ToDecimal(list[2].ToString());
            //        objpres.TaskID = TaskID;
                   
                    
            //    }
              
            //    lstpatientprescription.Add(objpres);

            //}
            //objDialysis.SavePrescription(lstpatientprescription);


           
              
            
        }
    }


