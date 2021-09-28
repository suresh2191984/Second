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

public partial class Investigation_ImageUploadpattern : BaseControl
{
    public Investigation_ImageUploadpattern()
        : base("Investigation_ImageUploadpattern_ascx")
    {
    }
    string pathname = string.Empty;
    long Patientid = 0;
    long visitid = 0;
    private string id = string.Empty;
    private string name = string.Empty;
    public event MultipleFileUploadClick Click;
    List<PatientInvestigationFiles> lstpatientImages;

    private int _Rows = 6;
    public int Rows
    {
        get { return _Rows; }
        set { _Rows = value < 6 ? 6 : value; }
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

    /// <summary>
    /// The no of maximukm files to upload.
    /// </summary>
    private int _UpperLimit = 0;
    public int UpperLimit
    {
        get { return _UpperLimit; }
        set { _UpperLimit = value; }
    }
     int POrgID = -1;
    long patientvid = -1;

    protected void Page_Load(object sender, EventArgs e)
    {
        lblPVisitID.Text = Convert.ToString(PatientVisitID);
        lblPatternID.Text = Convert.ToString(PatternID);
        lblInvID.Text = ControlID;
        lblOrgID.Text = Convert.ToString(POrgid);
        ShowImagePattern();
        // lblCaption.Text = _UpperLimit == 0 ? "Maximum Files: No Limit" : string.Format("Maximum Files: {0}", _UpperLimit);
        //lblCaption.Text = " ";
        pnlListBox.Attributes["style"] = "overflow:auto;";
        //pnlListBox.Height = Unit.Pixel(20 * _Rows - 1);

        if (Request.QueryString["POrgID"] != null)
        {
            Int32.TryParse(Request.QueryString["POrgID"], out POrgID);

        }
        else
        {
            POrgID = OrgID;
        }
        if (Request.QueryString["vid"] != null)
        {
            Int64.TryParse(Request.QueryString["vid"], out patientvid);

        }
        else
        {
            patientvid = VisitID;
        }
        if (!string.IsNullOrEmpty(ControlID))
        {
            BindImages(patientvid, POrgID, ControlID);
        }

        
        Patientid = Convert.ToInt64(Request.QueryString["pid"]);
        AutoCompleteExtender2.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        txtMedRemarks.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtMedRemarks.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtMedRemarks.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id,'" + IsAutoValidate + "');");

        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
        ddlStatusReason.Attributes.Add("onchange", "javascript:checkreasonifempty(this.id,'" + hdnstatusreason.ClientID + "');");
        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");

        btnAdd.Attributes.Add("onclick", "javascript:Add('" + pnlFiles.ClientID + "','" + pnlListBox.ClientID + "','" + btnAdd.ClientID + "','" + ControlID + "','" + AccessionNumber + "','" + GroupName + "',this.id,'" + IsAutoValidate + "');");
        btnUpload.Attributes.Add("onclick", "javascript:return DisableTop('" + pnlFiles.ClientID + "','" + pnlListBox.ClientID + "','" + btnAdd.ClientID + "','" + ControlID + "','" + AccessionNumber + "');");
        btnClear.Attributes.Add("onclick", "javascript:Clear('" + pnlFiles.ClientID + "','" + pnlListBox.ClientID + "','" + btnAdd.ClientID + "','" + ControlID + "','" + AccessionNumber + "');");
    }
    public void loadStatus(List<InvestigationStatus> lstStatus)
    {
        try
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
                
            }
            else
            {
                ddlstatus.DataSource = null;
                ddlstatus.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading ImageUpload status dropdown", ex);
        }
    }
    protected void BindImages(long visitid, int POrgID, string invid)
    {
        long returncode = -1;
        long investigationid = Convert.ToInt64(invid);
        Investigation_BL InvestigationBL = new Investigation_BL(base.ContextInfo);
        lstpatientImages = new List<PatientInvestigationFiles>();
        if (visitid != null && investigationid != null && POrgID !=null)
        {
            returncode = InvestigationBL.ProbeImagesForPatientVisits(visitid, investigationid, POrgID, out lstpatientImages);
        }
        if (lstpatientImages.Count > 0)
        {
            tdrptimages.Visible = true;
            rptimages.DataSource = lstpatientImages;
            rptimages.DataBind();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), ControlID, "AddNoGraphVisit();", true);
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
    private int groupID = 0;
    private string groupName = string.Empty;

    public int GroupID
    {
        get { return groupID; }
        set
        {
            hdnGroupID.Value = Convert.ToString(value);
            groupID = value;
        }
    }


    public string GroupName
    {
        get { return groupName; }
        set
        {
            hdnGroupName.Value = value;
            groupName = value;
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
    private string isAutoValidate = "N";
    public string IsAutoValidate
    {
        get { return isAutoValidate; }
        set
        {
            hdnIsAutoValidate.Value = value;
            isAutoValidate = value;
        }
    }
    public void ShowImagePattern()
    {
        pnlParent.Visible = true;
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
    public bool IsEditPattern()
    {
        return Convert.ToBoolean(hdnReadonly.Value);
    }
    public void MakeReadOnly(string patterID)
    {
        hdnReadonly.Value = "true";        
    }
    public List<InvestigationValues> GetResult(long VID)
    {
        
            InvestigationValues InVestVal = null;
            String[] status;
            List<InvestigationValues> lstVal = new List<InvestigationValues>();

            
            InVestVal = new InvestigationValues();
            InVestVal.Name = lblName.Text;
            status = ddlstatus.SelectedValue.Split('_');
            InVestVal.Status = status[0].ToString();
            InVestVal.InvestigationID = Convert.ToInt32(ControlID);
            //InVestVal.Name = "Image Uploader";        
            InVestVal.PatientVisitID = VID;
            InVestVal.GroupID = GroupID;
            InVestVal.Orgid = OrgID;
            InVestVal.CreatedBy = LID;
            InVestVal.GroupName = GroupName;
            InVestVal.UID = UID;
            lstVal.Add(InVestVal);

            return lstVal;
        
    }
    public PatientInvestigation GetInvestigations(long Vid)
    {
        List<PatientInvestigation> lstPInv = new List<PatientInvestigation>();
        PatientInvestigation Pinv = null;
        Pinv = new PatientInvestigation();
        Pinv.InvestigationID = Convert.ToInt64(ControlID);
        Pinv.PatientVisitID = Vid;
        Pinv.MedicalRemarks = txtMedRemarks.Text;
        string[] status = ddlstatus.SelectedValue.Split('_');
        Pinv.Status = status[0].ToString();       
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
        Pinv.AccessionNumber = AccessionNumber;
        hdnstatusreason.Value = "";
        hdnOpinionUser.Value = "";
        return Pinv;
    }
    public void LoadDataForEdit(List<InvestigationValues> lEditInvestigation)
    {
        lblName.Text = lEditInvestigation[0].Name;     
        txtMedRemarks.Text = lEditInvestigation[0].MedicalRemarks;
    }
    public HttpFileCollection TRFFiles()
    {
        HttpFileCollection hfc = Request.Files;
        return hfc;
    }
    public List<PatientInvestigationFiles> GetInvestigationFiles(long PatientVisitID, out bool Flag)
    {

        Flag = true;
        string fileCtrlID;
        string[] lstFileCtrlID1;
        string[] lstFileCtrlID;
        bool addToList = false;
        byte[] fileByte = new byte[byte.MinValue];
        HttpFileCollection hfc = TRFFiles();
        HttpPostedFile hpf = null;
        List<PatientInvestigationFiles> PtFiles1 = new List<PatientInvestigationFiles>();
        PatientInvestigationFiles pFiles1 = null;
        for (int i = 0; i < hfc.Count; i++)
        {
            addToList = false;
            hpf = hfc[i];
            if (hpf.ContentLength <= 0)
                continue;
            else
            {
                if (hpf.ContentLength > 0)
                {
                    //if (isBatchWise)
                    //{
                        fileCtrlID = hfc.Keys[i];
                        if (fileCtrlID.Contains('$'))
                        {
                            lstFileCtrlID1 = fileCtrlID.Split('$');
                            if (lstFileCtrlID1 != null && lstFileCtrlID1.Length > 0)
                            {
                                lstFileCtrlID = lstFileCtrlID1[0].Split('~');
                                if (lstFileCtrlID != null && lstFileCtrlID.Length > 4)
                                {
                                    long accNo = 0;
                                    Int64.TryParse(lstFileCtrlID[5], out accNo);
                                    if (lstFileCtrlID[0] == ControlID && accNo == AccessionNumber)
                                    {
                                        addToList = true;
                                    }
                                }
                            }
                        }
                        else
                        {
                            lstFileCtrlID = fileCtrlID.Split('_');
                            if (lstFileCtrlID != null && lstFileCtrlID.Length >= 3)
                            {
                                long accNo = 0;
                                Int64.TryParse(lstFileCtrlID[3], out accNo);
                                if (lstFileCtrlID[2] == ControlID && accNo == AccessionNumber)
                                {
                                    addToList = true;
                                }
                            }
                        }
                    //}
                    //else
                    //{
                    //    addToList = true;
                    //}
                    if (addToList)
                    {
                        using (var binaryReader = new BinaryReader(hpf.InputStream))
                        {
                            fileByte = binaryReader.ReadBytes(hpf.ContentLength);
                        }
                        pFiles1 = new PatientInvestigationFiles();
                        pFiles1.PatientVisitID = PatientVisitID;
                        pFiles1.ImageSource = fileByte;
                        pFiles1.FilePath = hpf.FileName;
                        pFiles1.CreatedBy = LID;
                        pFiles1.OrgID = OrgID;
                        pFiles1.InvestigationID = Convert.ToInt32(ControlID);
                        PtFiles1.Add(pFiles1);
                    }
                }
            }
           
        }

        return PtFiles1;
    }



    protected void btnUpload_Click(object sender, EventArgs e)
    {
        // Fire the event.
        Click(this, new FileCollectionEventArgs(this.Request));
    }
    protected void rptimages_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            System.Web.UI.WebControls.Image imgchrome = (System.Web.UI.WebControls.Image)e.Item.FindControl("imgchrome");
            HiddenField HiddenProbeImageID = (HiddenField)e.Item.FindControl("HiddenProbeImageID");
            HiddenField hdnInvestigationId = (HiddenField)e.Item.FindControl("hdnInvestigationId");
            HiddenField hdnPvisitid = (HiddenField)e.Item.FindControl("hdnPvisitid");
            HiddenField hdnOrgID = (HiddenField)e.Item.FindControl("hdnOrgID");
            Label imagpath = (Label)e.Item.FindControl("imagpath");
            imgchrome.ImageUrl = "ProbeImagehandler.ashx?InvID=" + hdnInvestigationId.Value + "&VisitId=" + hdnPvisitid.Value + "&POrgID=" + hdnOrgID.Value + "&ImageID=" + HiddenProbeImageID.Value;
        }
    }
    private bool isBatchWise = false;
    public void BatchWise(bool IsBatchWise)
    {
        isBatchWise = IsBatchWise;
        if (IsBatchWise)
        {
            tdInvName.Style.Add("display", "table-cell");
        }
        else
        {
            tdPatientDetails.Style.Add("display", "none");
            tdInvName.Style.Add("display", "table-cell");
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
            lnkPDFReportPreviewer.Attributes.Add("onclick", "ShowReportPreview('" + PatientVisitID + "','" + RoleID + "','all');return false;");
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
    private long accessionNumber = 0;
    private string uID = string.Empty;
    public string UID
    {
        get { return uID; }
        set
        {
            uID = value;
            hdnUID.Value = value;
        }
    }
    public long AccessionNumber
    {
        get { return accessionNumber; }
        set
        {
            hdnAccessionNumber.Value = Convert.ToString(value);
            accessionNumber = value;
        }
    }
    private long visitID = 0;
    private long patientID = 0;
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
    private long pOrgid = -1;
    public long POrgid
    {
        get { return pOrgid; }
        set
        {
            pOrgid = value;
        }
    }
}
/// <summary>
/// EventArgs class that has some readonly properties regarding posted files corresponding to MultipleFileUpload control. 
/// </summary>
public class FileCollectionEventArgs : EventArgs
{
    private HttpRequest _HttpRequest;

    public HttpFileCollection PostedFiles
    {
        get
        {
            return _HttpRequest.Files;
        }
    }

    public int Count
    {
        get { return _HttpRequest.Files.Count; }
    }

    public bool HasFiles
    {
        get { return _HttpRequest.Files.Count > 0 ? true : false; }
    }

    public double TotalSize
    {
        get
        {
            double Size = 0D;
            for (int n = 0; n < _HttpRequest.Files.Count; ++n)
            {
                if (_HttpRequest.Files[n].ContentLength < 0)
                    continue;
                else
                    Size += _HttpRequest.Files[n].ContentLength;
            }

            return Math.Round(Size / 1024D, 2);
        }
    }

    public FileCollectionEventArgs(HttpRequest oHttpRequest)
    {
        _HttpRequest = oHttpRequest;
    }
}

//Delegate that represents the Click event signature for MultipleFileUpload control.
public delegate void MultipleFileUploadClick(object sender, FileCollectionEventArgs e);

