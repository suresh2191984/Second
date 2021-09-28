using System;
using System.Data;
using System.Collections.Generic;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
//using System.Web.UI.WebControls;
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

public partial class Investigation_RichTextPattern : BaseControl
{
    public Investigation_RichTextPattern()
        : base("Investigation_RichTextPattern_ascx")
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
    protected void Page_Load(object sender, EventArgs e)
    {
        if (isDeltaCheckWant)
        {
            //tdDeltaCheck.Style.Add("display", "block");
            tdBetaCheck.Style.Add("display", "table-cell");
            lblPVisitID.Text = Convert.ToString(PatientVisitID);
            lblPatternID.Text = Convert.ToString(PatternID);
            lblInvID.Text = ControlID;
            lblOrgID.Text = Convert.ToString(POrgid);
            lblPatternClassName.Text = "Investigation_checkInvest";


        }
        tdFish.Visible = true;

        string sPath = Request.Url.AbsolutePath;
        int iIndex = sPath.LastIndexOf("/");

        sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
        sPath = Request.ApplicationPath;
        //sPath = sPath + "/fckeditor/";
        sPath = sPath + "/ckeditor/";
        fckVal.BasePath = sPath;
        //fckVal.ToolbarSet = "Attune";
        //fckVal.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        //fckVal.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";
     //   fckVal.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
    //    fckVal.Attributes.Add("onclick", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmptyForCKEditor(this.id,'fckVal');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
        ddlStatusReason.Attributes.Add("onchange", "javascript:checkreasonifempty(this.id,'" + hdnstatusreason.ClientID + "');");
        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");


        //AutoCompleteExtender1.ContextKey = ControlID.ToString() + "~" + GroupID.ToString() + "~" + OrgID.ToString() + "~" +string.Empty;
        //txtValue.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        //txtValue.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        ///fckVal.Controls.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        ABetaTag.Attributes.Add("onmouseover", "this.style.cursor='pointer';this.style.color='Green';");
        ABetaTag.Attributes.Add("onmouseout", "this.style.color='Red';");

        lnkPDFReportPreviewer.Attributes.Add("onclick", "ShowReportPreview('" + PatientVisitID + "','" + RoleID + "','all');return false;");
    }
    public void loadMethod(List<InvestigationValues> lstBulkData)
    {
        //   int count = 0;
        for (int i = 0; i < lstBulkData.Count; i++)
        {
        //fckVal.Value = lstBulkData[i].Value;
            fckVal.Text = lstBulkData[i].Value;
            break;
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
        if (lstStatus.Count > 0)
        {
            ddlstatus.DataSource = lstStatus;
            ddlstatus.DataTextField = "DisplayText";
            ddlstatus.DataValueField = "StatuswithID";
            ddlstatus.DataBind();
            string SelString = lstStatus.Find(O => O.StatuswithID.Contains("_1")).StatuswithID;
            if (ddlstatus.Items.FindByValue(SelString) != null)
            {
                ddlstatus.SelectedValue = SelString;
            }
            //else if (ddlstatus.Items.FindByValue("Validate_1") != null)
            //{
            //    ddlstatus.SelectedValue  = "Validate_1";
            //} 
        }
        else
        {
            ddlstatus.DataSource = null;
            ddlstatus.DataBind();
        }
    }
    public InvestigationValues GetResult(long VID)
    {

        InvestigationValues InVestVal = new InvestigationValues();
        //List<InvestigationValues> lstVal = new List<InvestigationValues>();
        String[] status;
        //if (fckVal.Value != "")
        if (fckVal.Text != "")
        {
            InVestVal = new InvestigationValues();
            InVestVal.Name = lblName.Text;
            status = ddlstatus.SelectedValue.Split('_');
            InVestVal.Status = status[0].ToString();
            //InVestVal.Status = ddlstatus.SelectedItem.Text;
            InVestVal.InvestigationID = Convert.ToInt32(ControlID);
            //InVestVal.Value = fckVal.Value.ToString();
            InVestVal.Value = fckVal.Text.ToString();
            InVestVal.PatientVisitID = VID;
            InVestVal.GroupID = GroupID;
            InVestVal.GroupName = GroupName;
            InVestVal.Orgid = OrgID;
            InVestVal.CreatedBy = LID;
            InVestVal.UID = UID;
            //lstVal.Add(InVestVal);
        }
        else
        {
            InVestVal = new InvestigationValues();
            InVestVal.Name = lblName.Text;
            status = ddlstatus.SelectedValue.Split('_');
            InVestVal.Status = status[0].ToString();
            //InVestVal.Status = ddlstatus.SelectedItem.Text;
            InVestVal.InvestigationID = Convert.ToInt32(ControlID);
            InVestVal.Value = string.Empty;
            InVestVal.PatientVisitID = VID;
            InVestVal.GroupID = GroupID;
            InVestVal.GroupName = GroupName;
            InVestVal.Orgid = OrgID;
            InVestVal.CreatedBy = LID;
            InVestVal.UID = UID;
            //lstVal.Add(InVestVal);
        }

        return InVestVal;

    }
    public PatientInvestigation GetInvestigations(long Vid)
    {
        List<PatientInvestigation> lstPInv = new List<PatientInvestigation>();
        PatientInvestigation Pinv = null;
        Pinv = new PatientInvestigation();
        Pinv.InvestigationID = Convert.ToInt64(ControlID);
        Pinv.PatientVisitID = Vid;
        string[] status = ddlstatus.SelectedValue.Split('_');
        Pinv.Status = status[0].ToString();
        //Pinv.Status = ddlstatus.SelectedItem.Text;
        Pinv.OrgID = Convert.ToInt32(OrgID);//OrgID;  
        if (!String.IsNullOrEmpty(hdnstatusreason.Value))
        {
            Pinv.InvStatusReasonID = Convert.ToInt32(hdnstatusreason.Value.Split('~')[0].ToString());
            Pinv.Reason = hdnstatusreason.Value.Split('~')[1].ToString();
        }
        long LoginID = 0;
        if (!String.IsNullOrEmpty(hdnOpinionUser.Value))
        {
            Int64.TryParse(hdnOpinionUser.Value, out LoginID);
        }
        Pinv.LoginID = LoginID;
        Pinv.GroupID = groupID;
        Pinv.UID = UID;
        Pinv.LabNo = LabNo;
        hdnstatusreason.Value = "";
        hdnOpinionUser.Value = "";
        return Pinv;
    }
    public void LoadDataForComments(List<InvestigationValues> lEditInvestigation)
    {
        lblName.Text = lEditInvestigation[0].Name;
        //  txtMedRemarks.Text = lEditInvestigation[0].MedicalRemarks;
    }
    public void LoadDataForEdit(List<InvestigationValues> lEditInvestigation)
    {
        //fckVal.Value = lEditInvestigation[0].Value;
        fckVal.Text = lEditInvestigation[0].Value;
        lblName.Text = lEditInvestigation[0].Name;
        lblInvID.Text = ControlID;
        lblOrgID.Text = Convert.ToString(OrgID);

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
    //public bool Readonly
    //{
    //    set
    //    {
    //        txtMedRemarks.ReadOnly = value == false ? true : false;
    //    }
    //}
    private string medicalremarks = string.Empty;
    //public string MedicalRemarks
    //{
    //    get { return medicalremarks; }
    //    set
    //    {
    //        medicalremarks = value;
    //        txtMedRemarks.Text = medicalremarks;
    //    }
    //}
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
            // EnableMedicalRemarksForLabTech();
        }
    }

    ////private void EnableMedicalRemarksForLabTech()
    ////{
    ////    if (labTechEditMedRem == "N" && currentRoleName == RoleHelper.LabTech)
    ////    {
    ////        txtMedRemarks.ReadOnly = true;
    ////    }
    ////    else
    ////    {
    ////        txtMedRemarks.ReadOnly = false;
    ////    }
    ////}


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
            hdnUID.Value = value;
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
                //txtValue.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
            }

        }
    }
    private string age = string.Empty;
    private string sex = string.Empty;
    private string patientName = string.Empty;
    public string Age
    {
        get { return age; }
        set
        {
            lblAge.Text = age = value;
        }
    }
    public string Sex
    {
        get { return sex; }
        set
        {
            lblSex.Text = sex = value;
        }
    }
    public string PatientName
    {
        get { return patientName; }
        set
        {
            lblPatientName.Text = value;
        }
    }
    private string visitNumber = string.Empty;
    public string VisitNumber
    {
        get { return visitNumber; }
        set
        {
            lnkPDFReportPreviewer.Text = value;
        }
    }
    private string labno = string.Empty;
    public string LabNo
    {
        get
        {
            return labno;
        }
        set
        {
            labno = value;
            hdnLabNo.Value = value;
        }
    }
    private bool isDeltaCheckWant = false;
    public bool IsDeltaCheckWant
    {
        get { return isDeltaCheckWant; }
        set { isDeltaCheckWant = value; }
    }
    private long patientVisitID = -1;

    public long PatientVisitID
    {
        get { return patientVisitID; }
        set
        {
            patientVisitID = value;
        }
    }
    private long patternID = -1;
    public long PatternID
    {
        get { return patternID; }
        set
        {
            patternID = value;
        }
    }
    private long pOrgid = -1;
    public long POrgid
    {
        get { return pOrgid; }
        set
        {
            pOrgid = value;
        }
    }
    public string TestStatus
    {
        set
        {
            if (!string.IsNullOrEmpty(value))
            {
                lblTestStatus.Text = value;
            }
        }
    }
    public void BatchWise(bool IsBatchWise)
    {
        if (IsBatchWise)
        {
            tdPatientDetails.Style.Add("display", "table-cell");
            tdInvName.Style.Add("display", "table-cell");
        }
        else
        {
            tdPatientDetails.Style.Add("display", "none");
            tdInvName.Style.Add("display", "table-cell");
        }
    }
    public long ClientID
	 {
        set
        {  
		          hdnClientID.Value = Convert.ToString(value); 
		}
     }
}
