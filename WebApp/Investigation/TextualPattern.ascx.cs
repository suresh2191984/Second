using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Xml;
using Attune.Podium.Common;
using System.Web.Script.Serialization;


public partial class Investigation_TextualPattern : BaseControl
{
    private string name = string.Empty;
    private string uom = string.Empty;
    private string result = string.Empty;
    private string id = string.Empty;
    private int maxlength = 0;
    private string controlName = string.Empty;
    private int groupID = 0;
    private string groupName = string.Empty;
    private long accessionNumber = 0;


    public long AccessionNumber
    {
        get { return accessionNumber; }
        set
        {
            hdnAccessionNumber.Value = Convert.ToString(value);
            accessionNumber = value;
        }
    }


    public int GroupID
    {
        get { return groupID; }
        set
        {
            groupID = value;
        }
    }
    string tid;
    public string TID
    {
        get { return tid; }
        set
        {
            tid = value;
            //sAutoRname.TargetControlID = tid + "_txtSensitive";

        }
    }
    public string ControlName
    {
        get { return controlName; }
        set
        {
            controlName = value;

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
    public string Name
    {
        get { return name; }
        set
        {
            name = value;
            lblName.Text = name;
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

    public string Value
    {
        get { return result; }
        set { result = value; }
    }
    long patientvisitID;
    public long PatientVisitID
    {
        get { return patientvisitID; }
        set { patientvisitID = value; }
    }

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

    string strSelect = Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_19 == null ? "-----Select-----" : Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_19;
    public void LoadddlInvResultTemplate()
    {
        Investigation_BL inv_BL = new Investigation_BL(base.ContextInfo);
        List<InvResultTemplate> lstInvResultTemplates = new List<InvResultTemplate>();
        Int64 ResultID = 0;
        Int64.TryParse(ControlID, out ResultID);
        string ResultName = String.Empty;
        ContextInfo.AdditionalInfo = "ResultIDType";
        inv_BL.GetInvestigationResultTemplateByID(Convert.ToInt32(POrgid), ResultID, ResultName, "TextReport", out lstInvResultTemplates);

        if (lstInvResultTemplates.Count > 0)
        {
            ddlInvResultTemplate.DataSource = lstInvResultTemplates;
            ddlInvResultTemplate.DataTextField = "ResultName";
            ddlInvResultTemplate.DataValueField = "DeptID";
            ddlInvResultTemplate.DataBind();
            ddlInvResultTemplate.Items.Insert(0, strSelect.Trim());
            ddlInvResultTemplate.Items[0].Value = "0";
        }
        else
        {
            inv_BL.GetInvestigationResultTemplate(Convert.ToInt32(POrgid), "TextReport", 0, out lstInvResultTemplates);
            if (lstInvResultTemplates.Count > 0)
            {
                ddlInvResultTemplate.DataSource = lstInvResultTemplates;
                ddlInvResultTemplate.DataTextField = "ResultName";
                ddlInvResultTemplate.DataValueField = "DeptID";
                ddlInvResultTemplate.DataBind();
                ddlInvResultTemplate.Items.Insert(0, strSelect.Trim());
                ddlInvResultTemplate.Items[0].Value = "0";
            }
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Investigation_BL inv_BL = new Investigation_BL(base.ContextInfo);
        string sPath = Request.Url.AbsolutePath;
        int iIndex = sPath.LastIndexOf("/");

        //List<InvResultTemplate> lstInvResultTemplates = new List<InvResultTemplate>();
        //inv_BL.GetInvestigationResultTemplate(Convert.ToInt32(POrgid), "TextReport", 0, out lstInvResultTemplates);

        //if (lstInvResultTemplates.Count > 0)
        //{
        //    ddlInvResultTemplate.DataSource = lstInvResultTemplates;
        //    ddlInvResultTemplate.DataTextField = "ResultName";
        //    ddlInvResultTemplate.DataValueField = "ResultID";
        //    ddlInvResultTemplate.DataBind();
        //    ddlInvResultTemplate.Items.Insert(0, "-----Select-----");
        //    ddlInvResultTemplate.Items[0].Value = "0";
        //}
        hdnGroupName.Value = GroupName;
        hdnDDLStatus.Value = ddlstatus.ClientID;

        sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
        sPath = Request.ApplicationPath;
        sPath = sPath + "/ckeditor/";
        fckInvDetails.BasePath = sPath;
       // fckInvDetails.ToolbarSet = "Default";
       // fckInvDetails.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
       // fckInvDetails.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "lblfckID", String.Format("var lblfckID=\"{0}\";", fckInvDetails.ClientID), true);

        Page.ClientScript.RegisterOnSubmitStatement(fckInvDetails.GetType(), fckInvDetails.ClientID + "editor", "if (typeof FCKeditorAPI != 'undefined' && FCKeditorAPI != null){ if(FCKeditorAPI.GetInstance('" + fckInvDetails.ClientID + "') !=null){FCKeditorAPI.GetInstance('" + fckInvDetails.ClientID + "').UpdateLinkedField();}}");

        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");

        //autosave();
        if (!IsPostBack)
        {
            List<InvResultTemplate> lstInvResultTemplate = new List<InvResultTemplate>();
            //inv_BL.GetInvestigationResultTemplate(Convert.ToInt32(POrgid), "TextReport", out lstInvResultTemplate);
            inv_BL.GetInvestigationResultTemplateByID(Convert.ToInt32(POrgid), Convert.ToInt64(ControlID), "Smear", "TextReport", out lstInvResultTemplate);
            inv_BL.GetInvestigationResultTemplateByID(Convert.ToInt32(POrgid), Convert.ToInt64(ControlID), "Cross Matching", "TextReport", out lstInvResultTemplate);

            fckInvDetails.Focus();
            if (lstInvResultTemplate.Count > 0)
            {
                if (fckInvDetails.Text == string.Empty)
                {
                    fckInvDetails.Text = lstInvResultTemplate[0].ResultValues;
                }
            }
            LoadddlInvResultTemplate();
            // fckInvDetails.Value = "Normocytic Normochromic RBCs.<br>Normal WBC count and morphology.<br>Normal platelet morphology and distribution.<br>No parasites seen.";
        }
    }
    public void SetInvestigationValueForEdit(List<InvestigationValues> lInvestigationValues)
    {
        lblName.Text = lInvestigationValues[0].Name;
        if (lInvestigationValues.Count > 0)
        {
            fckInvDetails.Text = lInvestigationValues[0].Value;
        }
    }
    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> lstValues = new List<InvestigationValues>();
        InvestigationValues obj = new InvestigationValues();
        String[] status;
            if (fckInvDetails.Text != string.Empty)
            {
                obj = new InvestigationValues();
                obj.Name = lblName.Text;
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.PatientVisitID = VID;
                obj.Value = fckInvDetails.Text;
                //obj.Status =  ddlstatus.SelectedItem.Text;
                status = ddlstatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.CreatedBy = LID;
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                lstValues.Add(obj);
            }
        return lstValues;
    }
    public void loadStatus(List<InvestigationStatus> lstStatus)
    {
        ddlstatus.DataSource = lstStatus;
        //ddlstatus.DataTextField = "Status";
        //ddlstatus.DataValueField = "InvestigationStatusID";
        ddlstatus.DataTextField = "DisplayText";
        ddlstatus.DataValueField = "StatuswithID";
        ddlstatus.DataBind();
        string SelString = lstStatus.Find(O => O.StatuswithID.Contains("_1")).StatuswithID;
        if (ddlstatus.Items.FindByValue(SelString) != null)
        {
            ddlstatus.SelectedValue = SelString;
        }  
    }
    //public void loadOpinionUser(List<Users> lstOpinionUser)
    //{
    //    ddlOpinionUser.DataSource = lstOpinionUser;
    //    ddlOpinionUser.DataTextField = "Name";
    //    ddlOpinionUser.DataValueField = "LoginID";
    //    ddlOpinionUser.DataBind();
    //    ListItem item = new ListItem();
    //    item.Text = "---Select---";
    //    item.Value = "0";
    //    ddlOpinionUser.Items.Insert(0, item);
    //    ddlOpinionUser.SelectedIndex = 0;
    //}
    public PatientInvestigation GetInvestigations(long Vid)
    {
        List<PatientInvestigation> lstPInv = new List<PatientInvestigation>();
        PatientInvestigation Pinv = null;
        string[] status;
        Pinv = new PatientInvestigation();
        Pinv.InvestigationID = Convert.ToInt64(ControlID);
        Pinv.PatientVisitID = Vid;
        //Pinv.Status = ddlstatus.SelectedItem.Text;
        status = ddlstatus.SelectedValue.Split('_');
        Pinv.Status = status[0].ToString();
        //Pinv.ReferenceRange = txtRefRange.Text;
        //Pinv.Reason = txtReason.Text;
        Pinv.OrgID = Convert.ToInt32(POrgid);// OrgID;
        if (ddlStatusReason.Items.Count > 0)
        {
            Pinv.InvStatusReasonID = (ddlStatusReason.SelectedValue == strSelect.Trim() ? 0 : Convert.ToInt32(ddlStatusReason.SelectedValue));
        }
        long LoginID = 0;
        Pinv.GroupID = groupID;
        if (!String.IsNullOrEmpty(hdnOpinionUser.Value))
        {
            Int64.TryParse(hdnOpinionUser.Value, out LoginID);
        }
        Pinv.LoginID = LoginID;
        Pinv.AccessionNumber = AccessionNumber;
        return Pinv;
    }
    bool readOnly = false;
    public bool Readonly
    {
        set
        {
            //pnlenb.Enabled = value;
            lnkEdit.Visible = true;
         
        }
    }
    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        if (ViewState["test"] == null)
        {
            ViewState["isEdit"] = true;
        }
        Readonly = true;
    }
    string isEdit = "false";
    public string IsEdit
    {
        get
        {
            if (ViewState["isEdit"] != null)
            {
                isEdit = ViewState["isEdit"].ToString();
            }
            else
            {
                isEdit = "false";
            }
            return isEdit;
        }

    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        try
        {
             
            
            if (ddlInvResultTemplate.SelectedValue != "0")
            {
                int ResultID = -1;
                string ResultName = string.Empty;
                Investigation_BL inv_BL = new Investigation_BL(base.ContextInfo);
                ResultID = Convert.ToInt32(ddlInvResultTemplate.SelectedValue);
                List<InvResultTemplate> lResultTemplate = new List<InvResultTemplate>();
                ResultID = Convert.ToInt32(ddlInvResultTemplate.SelectedValue);
                //ResultName = "RowIDSearch";
                //ResultName = ddlInvResultTemplate.SelectedItem.Text;
                ContextInfo.AdditionalInfo = "RowIDType";
                inv_BL.GetInvestigationResultTemplateByID(Convert.ToInt32(POrgid), ResultID, ResultName, "TextReport", out lResultTemplate);
                
                
                //ViewState["TemplateID"] = ddlInvResultTemplate.SelectedValue;
                
                fckInvDetails.Focus();
                if (lResultTemplate.Count > 0)
                {
                //    if (fckInvDetails.Value == string.Empty)
                  //  {
                        fckInvDetails.Text = lResultTemplate[0].ResultValues;
                    //}
                       //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Change Status", "setCompletedStatus('" + GroupName + "','" + ddlstatus.ClientID + "');", true);
                }
                
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While load Template in Imaging pattern", ex);
        }
    }
 
    public bool IsEditPattern()
    {
        return Convert.ToBoolean(hdnReadonly.Value);
    }

    public void MakeReadOnly(string patterID)
    {
        ATag.Visible = true;
        hdnReadonly.Value = "true";
         
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
    public List<PatientInvestigationFiles> GetInvestigationFiles(long PatientVisitID, out bool Flag)
    {

        Flag = true;
        HttpPostedFile httpPSFiles;
        PatientInvestigationFiles pFiles;
        List<PatientInvestigationFiles> lstPfiles = new List<PatientInvestigationFiles>();

        if (flUpload.HasFile)
        {
            if ((flUpload.PostedFile.ContentType.ToLower() == "jpeg") || (flUpload.PostedFile.ContentType == "jpg")
                || (flUpload.PostedFile.ContentType == "image/pjpeg") || (flUpload.PostedFile.ContentType == "image/jpeg"))
            {
                pFiles = new PatientInvestigationFiles();
                //flUpload.SaveAs(@"C:\temp\" + flUpload.FileName);
                //CLogger.LogError("Upload path:" + System.IO.Path.GetFullPath(flUpload.PostedFile.FileName),new Exception());
                //CLogger.LogError("Upload path:" + System.IO.Path.GetFullPath(flUpload.FileName), new Exception());
                pFiles.PatientVisitID = PatientVisitID;
                pFiles.ImageSource = flUpload.FileBytes;
                pFiles.FilePath = flUpload.FileName;
                pFiles.CreatedBy = LID;
                pFiles.OrgID = Convert.ToInt32(POrgid);// OrgID;
                pFiles.InvestigationID = Convert.ToInt32(ControlID);
                lstPfiles.Add(pFiles);
            }
            else
            {
                Flag = false;
            }
        }
        if (flUpload2.HasFile)
        {
            if ((flUpload2.PostedFile.ContentType.ToLower() == "jpeg") || (flUpload2.PostedFile.ContentType == "jpg")
                || (flUpload2.PostedFile.ContentType == "image/pjpeg") || (flUpload2.PostedFile.ContentType == "image/jpeg"))
            {
                pFiles = new PatientInvestigationFiles();
                //httpPSFiles = flUpload2.PostedFile;
                //btImage = new byte[flUpload2.PostedFile.ContentLength];
                //httpPSFiles.InputStream.Read(btImage, 0, flUpload2.PostedFile.ContentLength);
                pFiles.PatientVisitID = PatientVisitID;
                pFiles.ImageSource = flUpload2.FileBytes;
                pFiles.CreatedBy = LID;
                pFiles.FilePath = flUpload2.FileName;
                pFiles.OrgID = Convert.ToInt32(POrgid);// OrgID;
                pFiles.InvestigationID = Convert.ToInt32(ControlID);
                lstPfiles.Add(pFiles);
            }
            else
            {
                Flag = false;
            }
        }
        if (flUpload3.HasFile)
        {
            if ((flUpload3.PostedFile.ContentType.ToLower() == "jpeg") || (flUpload3.PostedFile.ContentType == "jpg")
                || (flUpload3.PostedFile.ContentType == "image/pjpeg") || (flUpload3.PostedFile.ContentType == "image/jpeg"))
            {
                pFiles = new PatientInvestigationFiles();
                //httpPSFiles = flUpload.PostedFile;
                //btImage = new byte[flUpload3.PostedFile.ContentLength];
                //httpPSFiles.InputStream.Read(btImage, 0, flUpload3.PostedFile.ContentLength);
                pFiles.PatientVisitID = PatientVisitID;
                pFiles.ImageSource = flUpload3.FileBytes;
                pFiles.FilePath = flUpload3.FileName;
                pFiles.CreatedBy = LID;
                pFiles.OrgID = Convert.ToInt32(POrgid);// OrgID;
                pFiles.InvestigationID = Convert.ToInt32(ControlID);
                lstPfiles.Add(pFiles);
            }
            else
            {
                Flag = false;
            }
        }
        if (flUpload1.HasFile)
        {

            if ((flUpload1.PostedFile.ContentType.ToLower() == "jpeg") || (flUpload1.PostedFile.ContentType == "jpg")
                || (flUpload1.PostedFile.ContentType == "image/pjpeg") || (flUpload1.PostedFile.ContentType == "image/jpeg"))
            {
                pFiles = new PatientInvestigationFiles();
                //httpPSFiles = flUpload4.PostedFile;
                //btImage = new byte[flUpload4.PostedFile.ContentLength];
                //httpPSFiles.InputStream.Read(btImage, 0, flUpload4.PostedFile.ContentLength);
                pFiles.PatientVisitID = PatientVisitID;
                pFiles.ImageSource = flUpload1.FileBytes;
                pFiles.FilePath = flUpload1.FileName;
                pFiles.CreatedBy = LID;
                pFiles.OrgID = Convert.ToInt32(POrgid);// OrgID;
                pFiles.InvestigationID = Convert.ToInt32(ControlID);
                lstPfiles.Add(pFiles);
            }
            else
            {
                Flag = false;
            }
        }
        return lstPfiles;
    }
}
