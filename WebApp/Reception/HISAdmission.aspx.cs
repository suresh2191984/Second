using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;



public partial class Reception_HISAdmission : BasePage
{
    public Reception_HISAdmission()
        : base("Reception\\HISAdmission.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long returnCode = -1;
    long patientID = -1;
    long visitID = -1;
    long taskID = -1;
    string belong = String.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            try
            {
                Int64.TryParse(Request.QueryString["pid"], out patientID);
                Int64.TryParse(Request.QueryString["vid"], out visitID);

                List<OrgDietTypeMapping> lstOrgDietType = new List<OrgDietTypeMapping>();
                List<OrgDietPatternMapping> lstOrgDietPattern = new List<OrgDietPatternMapping>();
                List<OrgDietPlanMapping> lstOrgDietPlan = new List<OrgDietPlanMapping>();
                List<ModeofOxygenDelivery> lstModeofOxygenDelivery = new List<ModeofOxygenDelivery>();
                List<Patient> lstPatient = new List<Patient>();
                List<InPatientAdmissionDetails> lstInpatient = new List<InPatientAdmissionDetails>();

                List<PatientCondition> lstCondition = new List<PatientCondition>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetDieTarySpecification(OrgID, patientID, visitID, out lstOrgDietType, out lstOrgDietPattern,
                                                                            out lstOrgDietPlan, out lstModeofOxygenDelivery, out lstPatient, 
                                                                            out lstCondition, out lstInpatient);

                if (lstOrgDietType.Count > 0)
                {
                    ddlDietType.DataSource = lstOrgDietType;
                    ddlDietType.DataTextField = "DietTypeName";
                    ddlDietType.DataValueField = "OrgDietTypeMappingID";
                    ddlDietType.DataBind();
                    ddlDietType.Items.Insert(0, "-----Select-----");
                    ddlDietType.Items[0].Value = "0";
                }
                if (lstOrgDietPattern.Count > 0)
                {
                    ddlDietPattern.DataSource = lstOrgDietPattern;
                    ddlDietPattern.DataTextField = "DietPatternName";
                    ddlDietPattern.DataValueField = "OrgDietPatternMappingID";
                    ddlDietPattern.DataBind();
                    ddlDietPattern.Items.Insert(0, "-----Select-----");
                    ddlDietPattern.Items[0].Value = "0";
                }
                if (lstOrgDietPlan.Count > 0)
                {
                    ddlDietPlan.DataSource = lstOrgDietPlan;
                    ddlDietPlan.DataTextField = "DietPlanName";
                    ddlDietPlan.DataValueField = "OrgDietPlanMappingID";
                    ddlDietPlan.DataBind();
                    ddlDietPlan.Items.Insert(0, "-----Select-----");
                    ddlDietPlan.Items[0].Value = "0";
                }
                if (lstModeofOxygenDelivery.Count > 0)
                {
                    ddlModeofDelivery.DataSource = lstModeofOxygenDelivery;
                    ddlModeofDelivery.DataValueField = "ModeOfOxygDeliveryName";
                    ddlModeofDelivery.DataValueField = "ModeOfOxygDeliveryID";
                    ddlModeofDelivery.DataBind();
                    ddlModeofDelivery.Items.Insert(0, "-----Select-----");
                    ddlModeofDelivery.Items[0].Value = "0";
                }
                if (lstCondition.Count > 0)
                {
                    ddlConfirmPatientCondition.DataSource = lstCondition;
                    ddlConfirmPatientCondition.DataTextField = "Condition";
                    ddlConfirmPatientCondition.DataValueField = "ConditionID";
                    ddlConfirmPatientCondition.DataBind();
                }
                if (lstInpatient.Count > 0)
                {
                    ddlConfirmPatientCondition.Items[lstInpatient[0].ConditionOnAdmissionID].Selected = true;
                }

                if (lstPatient.Count > 0)
                {
                    string[] identification = lstPatient[0].PersonalIdentification.Split('~');
                    if (identification.Length > 0 && identification.Length == 1)
                    {
                        txtVerifyIdentificationMarks.Text = identification[0].ToString();
                    }
                    else if (identification.Length > 1)
                    {
                        txtVerifyIdentificationMarks.Text = identification[0].ToString();
                        txtVerifyIdentificationMarks1.Text = identification[1].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while loading Dietary Specification", ex);
            }
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            Int64.TryParse(Request.QueryString["vid"], out visitID);
            Int64.TryParse(Request.QueryString["tid"], out taskID);

            InPatientAdmissionDetails inPatient = new InPatientAdmissionDetails();
            PatientDietSpecification patientDietSpec = new PatientDietSpecification();

            patientDietSpec.OrgDietTypeMappingID = Convert.ToInt64(ddlDietType.SelectedValue);
            patientDietSpec.OrgDietPatternMappingID = Convert.ToInt64(ddlDietPattern.SelectedValue);
            patientDietSpec.OrgDietPlanMappingID = Convert.ToInt64(ddlDietPlan.SelectedValue);
            patientDietSpec.FluidRestriction = txtFluidRestriction.Text == "" ? "0" : txtFluidRestriction.Text;
            patientDietSpec.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            patientDietSpec.CreatedBy = LID;


            inPatient.PatientID = patientID;
            inPatient.VisitID = visitID;
            inPatient.OxygenRequired = rdoOxygenRequiredYes.Checked == true ? "Y" : "N";
            inPatient.OrientationProvided = rdoOrientationProvidedYes.Checked == true ? "Y" : "N";
            inPatient.VerifyIdentification = chkVerifyIdentification.Checked == true ? "Y" : "N";
            inPatient.ConditionOnAdmissionID = Convert.ToInt32(ddlConfirmPatientCondition.SelectedItem.Value);
            if (rdoOxygenRequiredYes.Checked == true)
            {
                inPatient.ModeOfOxygenDeliveryID = Convert.ToInt32(ddlModeofDelivery.SelectedValue);
                inPatient.RateOfDelivery = Convert.ToInt32(txtRateofDelivery.Text);
            }

            List<BelongingsHandoverDetails> lstBelong = new List<BelongingsHandoverDetails>();
            lstBelong = GetBelong(visitID);


            //Save HIS Details

            returnCode = new PatientVisit_BL(base.ContextInfo).SaveHISAdmissionDetail(visitID, patientDietSpec, inPatient, lstBelong);

            //Update Task

            returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);
            Response.Redirect("Home.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string val = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while savig HIS Admision", ex);
        }
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        string belongText = string.Empty;
        string dtoRemove = string.Empty;
        dtoRemove = did.Value;

        string newPrescription = string.Empty;
        int rowCount = 0;
        if (ViewState["rowCount"] != null)
        {
            Int32.TryParse(ViewState["rowCount"].ToString(), out rowCount);
        }
        rowCount++;

        if (ViewState["pre"] != null)
        {
            belong = ViewState["pre"].ToString();
        }
        if (txtBelongingHandover.Text != "")
        {
            if (dtoRemove.Trim().Length > 0)
            {
                foreach (string drow in belong.Split('|'))
                {
                    bool IsDeleted = false;
                    foreach (string s in dtoRemove.Split(','))
                    {
                        if (s != string.Empty && !IsDeleted)
                        {
                            if (drow.Contains("RID^" + s + "~"))
                            {
                                IsDeleted = true;
                            }
                        }
                    }
                    if (!IsDeleted && drow != string.Empty)
                        newPrescription += drow + "|";
                }
                belong = string.Empty;
                belong = newPrescription;
            }

            did.Value = "";
            belongText = txtBelongingHandover.Text.Trim();
            txtBelongingHandover.Text = "";

            if (!belong.Contains("BELONG^" + belong))
            {
                belong += "RID^" + rowCount.ToString() + "~BELONG^" + belongText + "|";
            }
            ViewState["rowCount"] = rowCount;
            ViewState["pre"] = belong;
        }
        if (belong.Trim().Length > 0)
            BuildTable();

        btnAdd.Attributes.Add("onclick", "pageLoadFocus('" + txtBelongingHandover.ClientID.ToString() + "');");
    }

    public void BuildTable()
    {
        List<TableCell> cells = new List<TableCell>();
        string rid = string.Empty;
        foreach (string drow in belong.Split('|'))
        {
            TableRow row = new TableRow();
            if (drow != string.Empty)
            {
                foreach (string column in drow.Split('~'))
                {
                    cells.Add(AddCell(column, out rid));
                    if (rid != string.Empty)
                        row.Attributes.Add("id", rid);
                }
                foreach (TableCell cell in cells)
                {
                    row.Cells.Add(cell);
                }
                cells.Clear();

                gridTab.Rows.Add(row);
            }
        }
        gridTab.Visible = true;
  

    }



    private TableCell AddCell(string column, out string rid)
    {
        string colName = column.Split('^')[0];
        string colValue = column.Split('^')[1];
        TableCell cell = new TableCell();
        cell.Attributes.Add("align", "center");

        rid = string.Empty;
        switch (colName)
        {

            case "RID":
                HyperLink hLnk = new HyperLink();
                hLnk.ImageUrl = "~/Images/delete.jpg";
                hLnk.NavigateUrl = "javascript:OrganDonationDeleteRow('" + colValue + "','" + did.ClientID + "');";
                //cell.Width = Unit.Pixel(20);
                cell.Width = Unit.Percentage(20);
                rid = colValue;
                cell.Controls.Add(hLnk);
                break;
            case "BELONG":
                cell.Text = colValue;
                cell.Width = Unit.Percentage(50);
                break;
            

        };
        return cell;

    }


    public List<BelongingsHandoverDetails> GetBelong(long patientVisitID)
    {
         belong = string.Empty;
        string newBelong = string.Empty;
        string dtoRemove = string.Empty;
        dtoRemove = did.Value;
        List<BelongingsHandoverDetails> lstBelong = new List<BelongingsHandoverDetails>();
        if (ViewState["pre"] != null)
            belong = ViewState["pre"].ToString();

        if (dtoRemove.Trim().Length > 0)
        {
            foreach (string drow in belong.Split('|'))
            {
                bool IsDeleted = false;
                foreach (string s in dtoRemove.Split(','))
                {
                    if (s != string.Empty && !IsDeleted)
                    {
                        if (drow.Contains("RID^" + s + "~"))
                        {
                            IsDeleted = true;
                        }
                    }
                }
                if (!IsDeleted && drow != string.Empty)
                    newBelong += drow + "|";
            }
            belong = string.Empty;
            belong = newBelong;
        }

       did.Value = "";

        foreach (string row in belong.Split('|'))
        {

            if (row.Trim().Length != 0)
            {
                BelongingsHandoverDetails belongHDet = new BelongingsHandoverDetails();

                foreach (string column in row.Split('~'))
                {
                    string[] colNameValue;
                    string colName = string.Empty;
                    string colValue = string.Empty;
                    colNameValue = column.Split('^');
                    colName = colNameValue[0];
                    if (colNameValue.Length > 1)
                        colValue = colNameValue[1];

                    switch (colName)
                    {
                        case "BELONG":
                            belongHDet.BelongingDescription = colValue;
                            break;
                        
                    };
                }
                belongHDet.PatientVisitID = patientVisitID;
                belongHDet.CreatedBy = LID;
                belongHDet.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                belongHDet.ModifiedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                lstBelong.Add(belongHDet);
            }
        }

        return lstBelong;
    }

}
