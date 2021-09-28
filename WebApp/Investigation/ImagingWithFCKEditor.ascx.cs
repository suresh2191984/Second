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
using Microsoft.VisualBasic;

public partial class Investigation_ImagingWithFCKEditor : BaseControl
{
    public Investigation_ImagingWithFCKEditor()
        : base("Investigation_ImagingWithFCKEditor_ascx")
    {
    }

    string strAll = Resources.Investigation_ClientDisplay.Investigation_ImagingWithFCKEditor_ascx_01 == null ? "--All--" : Resources.Investigation_ClientDisplay.Investigation_ImagingWithFCKEditor_ascx_01;
    string strSelect = Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_19 == null ? "-----Select-----" : Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_19;

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

    //Added by Perumal on 13 Jan 2012
    private string reason = string.Empty;
    public string Reason
    {
        get { return reason; }
        set
        {
            reason = value;
            txtAddNotes.Text = reason;
        }
    }
    //Added by Perumal on 13 Jan 2012

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
    string SelValue = "0";
    public string SelectedValue
    {
        get { return SelValue; }
        set
        {
            SelValue= value;
            
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Investigation_BL inv_BL = new Investigation_BL(base.ContextInfo);
            string sPath = Request.Url.AbsolutePath;
            int iIndex = sPath.LastIndexOf("/");

            sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
            sPath = Request.ApplicationPath ;
            sPath = sPath + "/fckeditor/";
            fckInvDetails.BasePath = sPath;
            fckInvDetails.ToolbarSet = "Attune";
            fckInvDetails.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
            fckInvDetails.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

            FCKImpression.BasePath = sPath;
            FCKImpression.ToolbarSet = "Attune";
            FCKImpression.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
            FCKImpression.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

            FCKinvFinidings.BasePath = sPath;
            FCKinvFinidings.ToolbarSet = "Attune";
            FCKinvFinidings.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
            FCKinvFinidings.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

            //Page.ClientScript.RegisterOnSubmitStatement(fckInvDetails.GetType(), fckInvDetails.ClientID + "fckInvDetails", "FCKeditorAPI.GetInstance('" + fckInvDetails.ClientID + "').UpdateLinkedField();");
            //Page.ClientScript.RegisterOnSubmitStatement(FCKinvFinidings.GetType(), FCKinvFinidings.ClientID + "FCKinvFinidings", "FCKeditorAPI.GetInstance('" + FCKinvFinidings.ClientID + "').UpdateLinkedField();");
            //Page.ClientScript.RegisterOnSubmitStatement(FCKImpression.GetType(), FCKImpression.ClientID + "FCKImpression", "FCKeditorAPI.GetInstance('" + FCKImpression.ClientID + "').UpdateLinkedField();");
            ////autosave();
            if (!IsPostBack)
            {
                List<InvDeptMaster> listOfdept = new List<InvDeptMaster>();
                new Investigation_BL(base.ContextInfo).GetInvforDept(Convert.ToInt32(POrgid), out listOfdept);
                listOfdept = listOfdept.FindAll(p => p.Display == "N");
                ddlDept.DataSource = listOfdept;
                ddlDept.DataTextField = "DeptName";
                ddlDept.DataValueField = "DeptID";
                ddlDept.DataBind();
                ddlDept.Items.Insert(0, new ListItem(strAll.Trim(), "0"));

                List<InvResultTemplate> lstInvResultTemplate = new List<InvResultTemplate>();
                inv_BL.GetInvestigationResultTemplateByID(Convert.ToInt32(POrgid), Convert.ToInt64(ControlID), string.Empty, "Imaging", out lstInvResultTemplate);
                fckInvDetails.Focus();
                if (lstInvResultTemplate.Count > 0)
                {
                    ddlInvResultTemplate.DataSource = lstInvResultTemplate;
                    ddlInvResultTemplate.DataTextField = "ResultName";
                    ddlInvResultTemplate.DataValueField = "ResultValues";
                    ddlInvResultTemplate.DataBind();
                    ddlInvResultTemplate.Items.Insert(0, strSelect.Trim());
                    ddlInvResultTemplate.Items[0].Value = "0";
                }
            }
            ViewState["isEdit"] = true;
            if (SelectedValue != string.Empty)
            {
                ddlDept.SelectedValue = SelectedValue;
                btnFilter_Click(sender, e);
            }
            //if (pnlShow.Enabled == false)
            //{

            //}
            //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), FCKImpression.ClientID, "javascript:fnenable('" + FCKImpression.ClientID + "');", true);
            ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Imaging pattern Page Load", ex);
        }

    }

    public void loadDrName(List<PerformingPhysician> lPerformingPhyiscian)
    {
        ddlperfPhysician.DataSource = lPerformingPhyiscian;
        ddlperfPhysician.DataTextField = "physicianName";
        ddlperfPhysician.DataBind();
        ddlperfPhysician.Items.Insert(0, "Select");
        ddlperfPhysician.Items.FindByText("Select").Selected = true;
        
    }
    
    public List<InvestigationValues> GetResult(long VID,out bool Flag)
    {
       
        List<InvestigationValues> lstValues = new List<InvestigationValues>();
        InvestigationValues obj = new InvestigationValues();
       
        if( (ddlperfPhysician.SelectedItem.Text != "Select" ) || (ddlstatus.SelectedItem.Text == "Pending"))
        {
            if (fckInvDetails.Value.Trim() != string.Empty)
            {
                obj = new InvestigationValues();
                obj.Name = lblInvDetails.Text;
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.PatientVisitID = VID;
                obj.Value = fckInvDetails.Value;
                obj.Status = ddlstatus.SelectedItem.Text;
                obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.CreatedBy = LID;
                obj.ModifiedBy = LID;
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                lstValues.Add(obj);
            }
            else
            {
                obj = new InvestigationValues();
                obj.Name = lblInvDetails.Text;
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.PatientVisitID = VID;
                obj.Value = "&nbsp;";
                obj.Status = ddlstatus.SelectedItem.Text;
                obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.CreatedBy = LID;
                obj.ModifiedBy = LID;
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                lstValues.Add(obj);
            }

            if (FCKinvFinidings.Value.Trim() != string.Empty)
            {
                obj = new InvestigationValues();
                obj.Name = lblFindings.Text;
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.PatientVisitID = VID;
                obj.Value = FCKinvFinidings.Value;
                obj.Status = ddlstatus.SelectedItem.Text;// ddlstatus.SelectedItem.Text;
                obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.CreatedBy = LID;
                obj.ModifiedBy = LID;
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                lstValues.Add(obj);
            }
            else
            {
                obj = new InvestigationValues();
                obj.Name = lblFindings.Text;
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.PatientVisitID = VID;
                obj.Value = "&nbsp;";
                obj.Status = ddlstatus.SelectedItem.Text;// ddlstatus.SelectedItem.Text;
                obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.CreatedBy = LID;
                obj.ModifiedBy = LID;
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                lstValues.Add(obj);
            }



            if (FCKImpression.Value.Trim() != string.Empty)
            {
                obj = new InvestigationValues();
                obj.Name = lblImpression.Text;
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.PatientVisitID = VID;
                obj.Value = FCKImpression.Value;
                obj.Status = ddlstatus.SelectedItem.Text;
                obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.CreatedBy = LID;
                obj.ModifiedBy = LID;
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                lstValues.Add(obj);
            }
            else
            {

                obj = new InvestigationValues();
                obj.Name = lblImpression.Text;
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.PatientVisitID = VID;
                obj.Value = "&nbsp;";
                obj.Status = ddlstatus.SelectedItem.Text;
                obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.CreatedBy = LID;
                obj.ModifiedBy = LID;
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                lstValues.Add(obj);
            }
            if (txtAddNotes.Text.Trim() != string.Empty)
            {
                obj = new InvestigationValues();
                obj.Name = lblAddNotes.Text;
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.PatientVisitID = VID;
                obj.Value = txtAddNotes.Text;
                obj.Status = ddlstatus.SelectedItem.Text;
                obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.CreatedBy = LID;
                obj.ModifiedBy = LID;
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                lstValues.Add(obj);

            }
            Flag = true;
            
        }
        else
        {
            string strValidate = Resources.Investigation_AppMsg.Investigation_ImagingWithFCKEditor_ascx_01 == null ? "Please Select performing Physicain Name" : Resources.Investigation_AppMsg.Investigation_ImagingWithFCKEditor_ascx_01;
            string strAlert=Resources.Investigation_AppMsg.Investigation_Header_Alert==null?"Alert":Resources.Investigation_AppMsg.Investigation_Header_Alert;
            if (ddlstatus.SelectedItem.Text == "Cancel")
            {
                Flag = true;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), this.ClientID, "javascript:ValidationWindow(" + strValidate.Trim() + "," + strAlert.Trim() + ");", true);
                Flag = false;
            }
            
        }
        return lstValues;
    }

    public PatientInvestigation GetInvestigations(long Vid)
    {
        List<PatientInvestigation> lstPInv = new List<PatientInvestigation>();
        PatientInvestigation Pinv = null;
        //if (ddlperfPhysician.SelectedItem.Text != "Select")
        //{
            Pinv = new PatientInvestigation();
            Pinv.InvestigationID = Convert.ToInt64(ControlID);
            Pinv.PatientVisitID = Vid;
            Pinv.Status = ddlstatus.SelectedItem.Text;
            Pinv.PerformingPhysicainName = ddlperfPhysician.SelectedItem.Text == "Select" ? "" : ddlperfPhysician.SelectedItem.Text;
            Pinv.OrgID = Convert.ToInt32(POrgid);// OrgID;
            if (ddlStatusReason.Items.Count > 0)
            {
            Pinv.InvStatusReasonID = (ddlStatusReason.SelectedValue == strSelect.Trim() ? 0 : Convert.ToInt32(ddlStatusReason.SelectedValue));
            }
            long LoginID = 0;
            if (!String.IsNullOrEmpty(hdnOpinionUser.Value))
            {
                Int64.TryParse(hdnOpinionUser.Value, out LoginID);
            }
            Pinv.LoginID = LoginID;
            Pinv.AccessionNumber = AccessionNumber;	
        //}
        
        return Pinv;
    }
    protected void btnShowModalPopup_Click(object sender, EventArgs e)
    {
       // ModalPopupExtender1.Show();
    }
    public void autosave()
    {
        bool Flag;
        string status;
        PatientInvestigation pinv = GetInvestigations(PatientVisitID);
        List<PatientInvestigation> lstPatientInv = new List<PatientInvestigation>();
        List<PatientInvSampleResults> lstPatientInvSampleResults = new List<PatientInvSampleResults>();
        int returnStatus = 0;
        lstPatientInv.Add(pinv);
        List<InvestigationValues> lst = GetResult(PatientVisitID,out Flag);
        List<List<InvestigationValues>>LstOfBio=new List<List<InvestigationValues>>();
        LstOfBio.Add(lst);
        Investigation_BL saveResults = new Investigation_BL(base.ContextInfo);
        //saveResults.SaveInvestigationResults(LstOfBio, lstPatientInv, lstPatientInvSampleResults, out returnStatus);
    }
    //protected void tmrPostback_Tick(object sender, EventArgs e)
    //{
    //    autosave();
    //    string str = tmrPostback.ClientID;
    //}
  
    protected void lnkAutoSave_Click(object sender, EventArgs e)
    {
        autosave();
        //string str = tmrPostback.ClientID;
    }

    public void SetInvestigationValueForEdit(List<InvestigationValues> InvestigationEditData)
    {
        this.ddlperfPhysician.ClearSelection();
        if(InvestigationEditData[0].PerformingPhysicainName != string.Empty)
            ddlperfPhysician.Items.FindByText(InvestigationEditData[0].PerformingPhysicainName).Selected = true;
        if (InvestigationEditData.Count > 0)
        {
            foreach (var item in InvestigationEditData)
            {
                switch (item.Name)
                {
                    case "Technique":  
                        fckInvDetails.Value = item.Value;
                        break;
                    case "Findings":
                        FCKinvFinidings.Value = item.Value;
                        break;
                    case "Conclusion":
                        FCKImpression.Value = item.Value;
                        break;
                    
                }
            }
        }
    }
    protected void ddlInvResultTemplate_SelectedIndexChanged(object sender, EventArgs e)
    {
        
       
    }

    protected void btnGo_Click(object sender, EventArgs e)
    {
        try
        {

            fckInvDetails.Value = string.Empty;
            FCKinvFinidings.Value = string.Empty;
            FCKImpression.Value = string.Empty;

            if (ddlInvResultTemplate.SelectedValue != "0")
            {
                //int ResultID = -1;
                //string ResultName = string.Empty;
                //Investigation_BL inv_BL = new Investigation_BL(base.ContextInfo);
                //List<InvResultTemplate> lResultTemplate = new List<InvResultTemplate>();
                //ResultID = Convert.ToInt32(ddlInvResultTemplate.SelectedValue);
                //inv_BL.GetInvestigationResultTemplateByID(Convert.ToInt32(POrgid), ResultID, ResultName, "Imaging", out lResultTemplate);
                XmlDocument xmlDocEdit = new XmlDocument();
                string str = ddlInvResultTemplate.SelectedValue;
                //ViewState["TemplateID"] = ddlInvResultTemplate.SelectedValue;
                int invDetailsStartIndex = str.IndexOf("<InvestigationDetails>");
                if (invDetailsStartIndex != -1)
                {
                    string invDetails = "<InvestigationDetails>";
                    int invDetailsEndIndex = str.IndexOf("</InvestigationDetails>");
                    fckInvDetails.Value = str.Substring(invDetailsStartIndex + invDetails.Length, invDetailsEndIndex - invDetailsStartIndex - invDetails.Length);
                }
                //fckInvDetails.Value = "hai";

                int invFindingsStartIndex = str.IndexOf("<InvestigationFindings>");
                if (invFindingsStartIndex != -1)
                {
                    string invFindings = "<InvestigationFindings>";
                    int invFindingsEndIndex = str.IndexOf("</InvestigationFindings>");
                    FCKinvFinidings.Value = str.Substring(invFindingsStartIndex + invFindings.Length, invFindingsEndIndex - invFindingsStartIndex - invFindings.Length);
                }


                int invImpressionStartIndex = str.IndexOf("<Impression>");
                if (invImpressionStartIndex != -1)
                {
                    string invImpression = "<Impression>";
                    int invImpressionEndIndex = str.IndexOf("</Impression>");
                    FCKImpression.Value = str.Substring(invImpressionStartIndex + invImpression.Length, invImpressionEndIndex - invImpressionStartIndex - invImpression.Length);
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While load Template in Imaging pattern", ex);
        }
    }
    bool readOnly = true;
    public bool Readonly
    {
        set
        {
            pnlShow.Enabled = true;
            lnkEdit.Visible = true;
            pnlV.Visible = false;
            string Function = string.Empty;
            if (value != true)
            {
                 Function = "function FCKeditor_OnComplete(editorInstance) {editorInstance.EditorDocument.body.contentEditable = 'false';editorInstance.EditorDocument.designMode = 'off';}";
                 ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), FCKImpression.ClientID + "EDit", Function, true);

            }
            else
            {
                Function = "function FCKeditor_OnComplete(editorInstance) {editorInstance.EditorDocument.body.contentEditable = 'true';editorInstance.EditorDocument.designMode = 'on';}";
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), FCKImpression.ClientID + "nonEDit", Function, true);

            }

        }
    }
    bool isreporteditable = false;
    public bool isReportEditable
    {
        set
        {
            if (value != true)
            {
                string Function = "function FCKeditor_OnComplete(editorInstance) {editorInstance.EditorDocument.body.contentEditable = 'false';editorInstance.EditorDocument.designMode = 'off';}";
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), FCKImpression.ClientID, Function, true);
            }
            lblAddNotes.Visible = true;
            txtAddNotes.Visible = true;
        }
        get { return isreporteditable; }
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
    //protected void ddlDept_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    long returncode = -1;
    //    long DeptID = Convert.ToInt64(ddlDept.SelectedItem.Value);
    //    List<InvResultTemplate> lstInvResultTemplate = new List<InvResultTemplate>();
    //    returncode = new Investigation_BL(base.ContextInfo).GetInvestigationResultTemplate(Convert.ToInt32(POrgid), "Imaging", DeptID, out lstInvResultTemplate);
    //    fckInvDetails.Focus();
    //    if (lstInvResultTemplate.Count > 0)
    //    {
    //        ddlInvResultTemplate.DataSource = lstInvResultTemplate;
    //        ddlInvResultTemplate.DataTextField = "ResultName";
    //        ddlInvResultTemplate.DataValueField = "ResultValues";
    //        ddlInvResultTemplate.DataBind();
    //        ddlInvResultTemplate.Items.Insert(0, "-----Select-----");
    //        ddlInvResultTemplate.Items[0].Value = "0";
    //    }
    //}
    protected void btnFilter_Click(object sender, EventArgs e)
    {
        long returncode = -1;
        long DeptID = Convert.ToInt64(ddlDept.SelectedItem.Value);
        List<InvResultTemplate> lstInvResultTemplate = new List<InvResultTemplate>();
        ddlInvResultTemplate.DataSource = null;
        ddlInvResultTemplate.DataBind();
        returncode = new Investigation_BL(base.ContextInfo).GetInvestigationResultTemplateByID(Convert.ToInt32(POrgid), Convert.ToInt64(ControlID), string.Empty, "Imaging", out lstInvResultTemplate);
        fckInvDetails.Focus();
        if (lstInvResultTemplate.Count > 0)
        {
            ddlInvResultTemplate.DataSource = lstInvResultTemplate;
            ddlInvResultTemplate.DataTextField = "ResultName";
            ddlInvResultTemplate.DataValueField = "ResultValues";
            ddlInvResultTemplate.DataBind();
            ddlInvResultTemplate.Items.Insert(0, strSelect.Trim());
            ddlInvResultTemplate.Items[0].Value = "0";
        }
    }
    public void LoadInvStatusReason(List<InvReasonMasters> lstInvReasonMaster)
    {
        ddlStatusReason.DataSource = lstInvReasonMaster;
        ddlStatusReason.DataTextField = "ReasonDesc";
        ddlStatusReason.DataValueField = "ReasonID";
        ddlStatusReason.DataBind();
        ddlStatusReason.Items.Insert(0, strSelect.Trim());
        ddlStatusReason.SelectedIndex = 0;
    }
    public bool IsEditPattern()
    {
        return Convert.ToBoolean(hdnReadonly.Value);
    }

    public void MakeReadOnly(string patterID)
    {
        ATag.Visible = true;
        hdnReadonly.Value = "true";

        pnlShow.Enabled = true;
       // lnkEdit.Visible = true;
        pnlV.Visible = false;
        string Function = string.Empty;
        if (false != true)  //false-Assigned as Dummy Varible
        {
            Function = "function FCKeditor_OnComplete(editorInstance) {editorInstance.EditorDocument.body.contentEditable = 'false';editorInstance.EditorDocument.designMode = 'off';}";
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), FCKImpression.ClientID + "EDit", Function, true);

        }
        else
        {
            Function = "function FCKeditor_OnComplete(editorInstance) {editorInstance.EditorDocument.body.contentEditable = 'true';editorInstance.EditorDocument.designMode = 'on';}";
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), FCKImpression.ClientID + "nonEDit", Function, true);

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
