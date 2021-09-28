using System;
using System.Data;
using System.Collections.Generic;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Linq;
using Attune.Solution.DAL;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;

public partial class Investigation_MultiAddControl : BaseControl
{
    public Investigation_MultiAddControl()
        : base("Investigation_MultiAddControl_ascx")
    {
    }

    private string name = string.Empty;
    private string uom = string.Empty;
    private string result = string.Empty;
    private string isAbnormal = string.Empty;
    private string id = string.Empty;
    private int maxlength = 0;
    private long accessionNumber = 0;
    private long visitID = 0;
    private long patientID = 0;
    private string uID = string.Empty;
    List<InvResultTemplate> lstInvResultTemplate;
    private int packageID = 0;
    private string packageName = string.Empty;

    public int PackageID
    {
        get { return packageID; }
        set
        {
            packageID = value;
        }
    }


    public string PackageName
    {
        get { return packageName; }
        set
        {
            packageName = value;
        }
    }
    public string Name
    {
        get { return name; }
        set
        {
            name = value;
            lblName.Text = name;
        }
    }
    bool readOnly = false;
    public bool Readonly
    {
        set
        {
            txtMedRemarks.ReadOnly = value == false ? true : false;
        }
    }
    private string medicalremarks = string.Empty;
    public string MedicalRemarks
    {
        get { return medicalremarks; }
        set
        {
            medicalremarks = value;
            txtMedRemarks.Text = medicalremarks;
        }
    }
    private string currentRoleName = string.Empty;
    public string CurrentRoleName
    {
        get { return currentRoleName; }
        set
        {
            currentRoleName = value;
        }
    }
    private string labTechEditMedRem = string.Empty;

    public string LabTechEditMedRem
    {
        get { return labTechEditMedRem; }
        set
        {
            labTechEditMedRem = value;
            EnableMedicalRemarksForLabTech();
        }
    }




    public long AccessionNumber
    {
        get { return accessionNumber; }
        set
        {
            accessionNumber = value;
        }
    }
    public long VisitID
    {
        get { return visitID; }
        set
        {
            visitID = value;
        }
    }
    public long PatientID
    {
        get { return patientID; }
        set
        {
            patientID = value;
        }
    }
    public string UID
    {
        get { return uID; }
        set
        {
            uID = value;
        }
    }

    public string ControlID
    {
        get { return id; }
        set
        {
            id = value;
            hidVal.Value = id;
        }
    }





    private int groupID = 0;
    private string groupName = string.Empty;

    public int GroupID
    {
        get { return groupID; }
        set
        {
            groupID = value;
        }
    }


    public string GroupName
    {
        get { return groupName; }
        set
        {
            groupName = value;
        }
    }
    private string decimalPlaces;
    public string DecimalPlaces
    {
        get { return decimalPlaces; }
        set
        {
            decimalPlaces = value;
            if (!string.IsNullOrEmpty(value))
            {
                txtDescription.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
            }

        }
    }
    #region "Initial"
    protected void Page_Load(object sender, EventArgs e)
    {
        tdFish.Visible = true;
        if (!string.IsNullOrEmpty(ControlID))
        {
            hdnControlID.Value = this.ClientID;
            //LoadDeafultLegend(Convert.ToInt32(ControlID));
            //if (lstInvResultTemplate.Count > 0)
            //{
            //    txtDescription.Text = lstInvResultTemplate[0].ResultValues;
            //}

            txtDescription.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        }
        AutoCompleteExtender2.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        txtMedRemarks.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtMedRemarks.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtMedRemarks.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");

        AutoCompleteExtender1.ContextKey = ControlID.ToString() + "~" + GroupID.ToString() + "~" + OrgID.ToString() + "~" + string.Empty;
        txtDescription.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtDescription.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtDescription.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
    }
    #endregion
    #region "Methods"
    public void loadMethod(List<InvestigationValues> lstBulkData)
    {
        //   int count = 0;
        //for (int i = 0; i < lstBulkData.Count; i++)
        //{
        //    txtDescription.Text = lstBulkData[i].Value;
        //    break;
        //}

    }
    private void EnableMedicalRemarksForLabTech()
    {
        if (labTechEditMedRem == "N" && currentRoleName == RoleHelper.LabTech)
        {
            txtMedRemarks.ReadOnly = true;
        }
        else
        {
            txtMedRemarks.ReadOnly = false;
        }
    }
    public void LoadDeafultLegend(long invid)
    {
        try
        {
            long returncode = -1;
            Investigation_BL InvestigationBL = new Investigation_BL(base.ContextInfo);
            lstInvResultTemplate = new List<InvResultTemplate>();
            returncode = InvestigationBL.GetSignalPatterns(invid, OrgID, out lstInvResultTemplate);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while LoadDeafultLegend ", ex);
        }
    }
    public void loadStatus(List<InvestigationStatus> lstStatus)
    {
        ddlstatus.DataSource = lstStatus;
        ddlstatus.DataTextField = "DisplayText";
        ddlstatus.DataValueField = "StatuswithID";
        ddlstatus.DataBind();
        if (ddlstatus.Items.FindByValue("Pending_1") != null)
        {
            ddlstatus.SelectedValue = "Pending_1";
        }
        else if (ddlstatus.Items.FindByValue("Validate_1") != null)
        {
            ddlstatus.SelectedValue = "Validate_1";
        }
    }
    public InvestigationValues GetResult(long VID)
    {
        InvestigationValues InVestVal = new InvestigationValues();
        //if (txtDescription.Text != "")   
        //{

        string chkString1 = lblName.Text;
        string FinalVal = string.Empty;
        int flag = 0;
        foreach (string splitString in hdnClinicalNotes.Value.Split(','))
        {
            if (splitString != "")
            {
                if (FinalVal == string.Empty)
                {
                    FinalVal = splitString;
                }
                else
                {
                    FinalVal = FinalVal + "," + splitString;
                }
                flag = flag + 1;
            }
        }
        if (flag > 0)
        {
            InVestVal = new InvestigationValues();
            InVestVal.Name = chkString1;
            InVestVal.Value = FinalVal;

            InVestVal.InvestigationID = Convert.ToInt32(ControlID);
            InVestVal.PatientVisitID = VID;
            InVestVal.CreatedBy = LID;
            InVestVal.GroupName = GroupName;
            InVestVal.GroupID = groupID;
            InVestVal.Orgid = OrgID;//OrgID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            InVestVal.Status = ddlstatus.SelectedItem.Text;
            InVestVal.CreatedBy = LID;
            InVestVal.PackageID = PackageID;
            InVestVal.PackageName = PackageName;
        }
        // }  

        return InVestVal;

    }
    public PatientInvestigation GetInvestigations(long Vid)
    {
        List<PatientInvestigation> lstPInv = new List<PatientInvestigation>();
        PatientInvestigation Pinv = null;
        Pinv = new PatientInvestigation();
        Pinv.InvestigationID = Convert.ToInt64(ControlID);
        Pinv.PatientVisitID = Vid;
        Pinv.MedicalRemarks = txtMedRemarks.Text;
        Pinv.Status = ddlstatus.SelectedItem.Text;
        Pinv.OrgID = Convert.ToInt32(OrgID);//OrgID;        
        long LoginID = 0;
        Pinv.LoginID = LoginID;
        Pinv.GroupID = groupID;
        Pinv.AccessionNumber = AccessionNumber;
        return Pinv;
    }
    public void LoadDataForComments(List<InvestigationValues> lEditInvestigation)
    {
        lblName.Text = lEditInvestigation[0].Name;
        txtMedRemarks.Text = lEditInvestigation[0].MedicalRemarks;
    }
    public void LoadDataForEdit(List<InvestigationValues> lEditInvestigation)
    {
        string ClinicalNotes = string.Empty;
        if (lEditInvestigation.Count > 0)
        {
            for (int Index = 0; Index < lEditInvestigation.Count; Index++)
            {
                if (lEditInvestigation[Index].Name != "" || lEditInvestigation[Index].Name != null)
                {
                    if (ClinicalNotes == string.Empty)
                    {
                        ClinicalNotes = lEditInvestigation[Index].Value;
                    }
                    else
                    {
                        ClinicalNotes = ClinicalNotes + "," + lEditInvestigation[Index].Value;
                    }
                }
            }

        }

        hdnClinicalNotes.Value = ClinicalNotes;
        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "ProcessMethods", "javascript:LoadExistingItems('" + this.ClientID + "','" + hdnClinicalNotes.Value + "');", true);
        hdnControlID.Value = this.ClientID;
        //txtDescription.Text = lEditInvestigation[0].Value;
        //lblName.Text = lEditInvestigation[0].Name;
        //lblInvID.Text = ControlID;
        //lblOrgID.Text = Convert.ToString(OrgID);

    }
    #endregion

    


    
    
    
    
    
    
   


}
