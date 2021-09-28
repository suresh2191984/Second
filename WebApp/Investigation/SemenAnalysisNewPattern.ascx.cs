using System;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Text;
using Attune.Podium.Common;
using System.Collections.Generic;
using System.Web.Script.Serialization;
public partial class Investigation_SemenAnalysisNewPattern :BaseControl 
{
    public Investigation_SemenAnalysisNewPattern()
        : base("2")
    {
    }

    private string name = string.Empty;
    private string uom = string.Empty;
    private string result = string.Empty;
    private string id = string.Empty;
    private string refRange = string.Empty;

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
   

    public string RefRange
    {
        get { return refRange; }
        set
        {
            refRange = value;
            txtRefRange.Text = refRange;
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
    /// <summary>
    /// Get and Set the Investigation Name
    /// </summary>
    public string Name
    {
        get { return name; }
        set
        {
            name = value;
            lblName.Text = name;
        }
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

    public string ControlID
    {
        get { return id; }
        set
        {
            id = value;
            hidValChp.Value = id;
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
            txtReason.Text = reason;
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
    //Added by Perumal on 13 Jan 2012

    protected void Page_Load(object sender, EventArgs e)
    {
        AutoCompleteExtender1.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        AutoCompleteExtender2.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();

        ddlStatusReason.Attributes.Add("onchange", "javascript:checkreasonifempty(this.id,'" + hdnstatusreason.ClientID + "');");
       // ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id);ShowStatusReason(this.id);");
        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
    }
    public void loadStatus(List<InvestigationStatus> lstStatus)
    {
        ddlStatus.DataSource = lstStatus;
        //ddlStatus.DataTextField = "Status";
        //ddlStatus.DataValueField = "InvestigationStatusID";
        ddlStatus.DataTextField = "DisplayText";
        ddlStatus.DataValueField = "StatuswithID";
        ddlStatus.DataBind();
        string SelString = lstStatus.Find(O => O.StatuswithID.Contains("_1")).StatuswithID;
        if (ddlStatus.Items.FindByValue(SelString) != null)
        {
            ddlStatus.SelectedValue = SelString;
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
    public void LoadData(List<InvestigationValues> lstValues)
    {
        for (int i = 0; i < lstValues.Count; i++)
        {
            lblName.Text = lstValues[i].Value;
        }
    }

    public PatientInvestigation GetInvestigations(long Vid)
    {
        List<PatientInvestigation> lstPInv = new List<PatientInvestigation>();
        PatientInvestigation Pinv = null;
        string[] status;
        Pinv = new PatientInvestigation();
        Pinv.InvestigationID = Convert.ToInt64(ControlID);
        Pinv.PatientVisitID = Vid;
        //Pinv.Status = ddlStatus.SelectedItem.Text;
        status = ddlStatus.SelectedValue.Split('_');
        Pinv.Status = status[0].ToString();
        Pinv.ReferenceRange = txtRefRange.Text;
        if (Pinv.ReferenceRange.Trim() != "")
        {
            Pinv.ReferenceRange = Pinv.ReferenceRange.Trim().Replace("\n", "<br>");
        }
        Pinv.Reason = txtReason.Text;
        Pinv.MedicalRemarks = txtMedRemarks.Text;
        Pinv.OrgID = Convert.ToInt32(POrgid);// OrgID;
        Pinv.AccessionNumber = AccessionNumber;	
        if (hdnstatusreason.Value != "")
        {
            Pinv.InvStatusReasonID = Convert.ToInt32(hdnstatusreason.Value.Split('~')[0].ToString());
            Pinv.Reason = hdnstatusreason.Value.Split('~')[1].ToString();
        }
        //if (ddlStatusReason.Items.Count > 0)
        //{
        //    Pinv.InvStatusReasonID = (ddlStatusReason.SelectedValue == "-----Select-----" ? 0 : Convert.ToInt32(ddlStatusReason.SelectedValue));


        //}

        long LoginID = 0;
        if (!String.IsNullOrEmpty(hdnOpinionUser.Value))
        {
            Int64.TryParse(hdnOpinionUser.Value, out LoginID);
        }
        Pinv.LoginID = LoginID;
        //InvRemarks
        if (hdnRemarksID.Value != null && hdnRemarksID.Value != "")
        {
            Pinv.RemarksID = Convert.ToInt64(hdnRemarksID.Value);
        }
        //InvRemarks
        return Pinv;
    }
    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> lstInvestigationVal = new List<InvestigationValues>();
        InvestigationValues obj;
        String[] status;



        if ((txtVolume.Text != string.Empty) || (txtLiquification.Text != string.Empty) || (txtViscosity.Text != string.Empty) || (txtPH.Text != string.Empty) || (txtSpermCount.Text != string.Empty) || (txtRapid.Text != string.Empty) || (txtSluggish.Text != string.Empty) || (txtnon.Text != string.Empty) || (txtNoMotility.Text != string.Empty) || (txtnon.Text != string.Empty) || (txtPinGiant.Text != string.Empty))
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            obj.PackageID = PackageID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageName = PackageName;
            obj.SequenceNo = 1;
            lstInvestigationVal.Add(obj);
        }

        if (txtVolume.Text != string.Empty || txtPH.Text != string.Empty || txtViscosity.Text != string.Empty || txtLiquification.Text != string.Empty)
        {

            if (lblPhysicalExamination.Text != string.Empty)
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblPhysicalExamination.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                obj.PackageID = PackageID;
                //obj.Status = ddlStatus.SelectedItem.Text;
                status = ddlStatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageName = PackageName;
                obj.SequenceNo = 2;
                lstInvestigationVal.Add(obj);

            }

            if (txtVolume.Text != string.Empty)
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblVolume.Text;
                obj.Value = txtVolume.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
                obj.UOMCode = lblUVolume.Text;
                //obj.Status = ddlStatus.SelectedItem.Text;
                status = ddlStatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                obj.SequenceNo = 3;
                lstInvestigationVal.Add(obj);
            }
            if (txtLiquification.Text != string.Empty)
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblLiquification.Text;
                obj.Value = txtLiquification.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
                obj.UOMCode = lbluLiquification.Text;
                //obj.Status = ddlStatus.SelectedItem.Text;
                status = ddlStatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                obj.SequenceNo = 4;
                lstInvestigationVal.Add(obj);
            }
            if (txtViscosity.Text != string.Empty)
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblViscosity.Text;
                obj.Value = txtViscosity.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                //obj.Status = ddlStatus.SelectedItem.Text;
                status = ddlStatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                obj.SequenceNo = 5;
                lstInvestigationVal.Add(obj);
            }
            if (txtPH.Text != string.Empty)
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblPH.Text;
                obj.Value = txtPH.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
                //obj.Status = ddlStatus.SelectedItem.Text;
                status = ddlStatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                obj.SequenceNo = 6;
                lstInvestigationVal.Add(obj);
            }
        }

        if (txtReaction.Text != string.Empty)
        {


            if (lblChemicalExamination.Text != string.Empty)
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblChemicalExamination.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
                //obj.Status = ddlStatus.SelectedItem.Text;
                status = ddlStatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                obj.SequenceNo = 7;
                lstInvestigationVal.Add(obj);

            }

            if (txtReaction.Text != string.Empty)
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblReaction.Text;
                obj.Value = txtReaction.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
                //obj.Status = ddlStatus.SelectedItem.Text;
                status = ddlStatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                obj.SequenceNo = 8;
                lstInvestigationVal.Add(obj);
            }
        }

        if (txtSpermCount.Text != string.Empty)
        {
            //if (lblSpermCount1.Text != string.Empty)
            //{
            //    obj = new InvestigationValues();
            //    obj.InvestigationID = Convert.ToInt32(ControlID);
            //    obj.Name = lblSpermCount1.Text;
            //    obj.PatientVisitID = VID;
            //    obj.CreatedBy = LID;
            //    obj.GroupName = GroupName;
            //    obj.GroupID = groupID;
            //    obj.Orgid =Convert.ToInt32(POrgid);// OrgID;
            //    obj.Status = ddlStatus.SelectedItem.Text;
            //    obj.PackageID = PackageID;
            //    obj.PackageName = PackageName;
            //    obj.SequenceNo = 9;
            //    lstInvestigationVal.Add(obj);

            //}
            if (txtSpermCount.Text != string.Empty)
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = "<b>" + lblSpermCount.Text + "</b>";
                obj.Value = txtSpermCount.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                obj.UOMCode = lblUSpermCount.Text;
                //obj.Status = ddlStatus.SelectedItem.Text;
                status = ddlStatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                obj.SequenceNo = 10;
                lstInvestigationVal.Add(obj);
            }
        }
        if (txtRapid.Text != string.Empty || txtNoMotility.Text != string.Empty || txtnon.Text != string.Empty || txtSluggish.Text != string.Empty)
        {

            if (lblMotility.Text != string.Empty)
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblMotility.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
                //obj.Status = ddlStatus.SelectedItem.Text;
                status = ddlStatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                obj.SequenceNo = 11;
                lstInvestigationVal.Add(obj);

            }
            if (txtRapid.Text != string.Empty)
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblRapid.Text;
                obj.Value = txtRapid.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
                obj.UOMCode = lblURapid.Text;
                //obj.Status = ddlStatus.SelectedItem.Text;
                status = ddlStatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                obj.SequenceNo = 12;
                lstInvestigationVal.Add(obj);
            }
            if (txtSluggish.Text != string.Empty)
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblSluggish.Text;
                obj.Value = txtSluggish.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                obj.UOMCode = lblUSluggish.Text;
                //obj.Status = ddlStatus.SelectedItem.Text;
                status = ddlStatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                obj.SequenceNo = 13;
                lstInvestigationVal.Add(obj);
            }
            if (txtnon.Text != string.Empty)
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblNon.Text;
                obj.Value = txtnon.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
                obj.UOMCode = lblUNon.Text;
                //obj.Status = ddlStatus.SelectedItem.Text;
                status = ddlStatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                obj.SequenceNo = 14;
                lstInvestigationVal.Add(obj);
            }
            if (txtNoMotility.Text != string.Empty)
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblNoMotility.Text;
                obj.Value = txtNoMotility.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
                obj.UOMCode = lblUNoMotility.Text;
                //obj.Status = ddlStatus.SelectedItem.Text;
                status = ddlStatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                obj.SequenceNo = 15;
                lstInvestigationVal.Add(obj);
            }
        }

        if (txtNormal.Text != string.Empty || txtPinGiant.Text != string.Empty)
        {
            if (lblMorphology.Text != string.Empty)
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblMorphology.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
                //obj.Status = ddlStatus.SelectedItem.Text;
                status = ddlStatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                obj.SequenceNo = 16;
                lstInvestigationVal.Add(obj);

            }
            if (txtNormal.Text != string.Empty)
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblNormal.Text;
                obj.Value = txtNormal.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
                obj.UOMCode = lblUNormal.Text;
                //obj.Status = ddlStatus.SelectedItem.Text;
                status = ddlStatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                obj.SequenceNo = 17;
                lstInvestigationVal.Add(obj);
            }
            if (txtPinGiant.Text != string.Empty)
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblPinGiant.Text;
                obj.Value = txtPinGiant.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                obj.UOMCode = lblUPinGiant.Text;
                //obj.Status = ddlStatus.SelectedItem.Text;
                status = ddlStatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                obj.SequenceNo = 18;
                lstInvestigationVal.Add(obj);
            }
        }
        if (txtWbcs.Text != string.Empty || txtRbcs.Text != string.Empty || txtEpithelial.Text != string.Empty || txtSpermagglutinates.Text != string.Empty)
            {
                if (lblMicroscopicfindings.Text != string.Empty)
                {
                    obj = new InvestigationValues();
                    obj.InvestigationID = Convert.ToInt32(ControlID);
                    obj.Name = lblMicroscopicfindings.Text;
                    obj.PatientVisitID = VID;
                    obj.CreatedBy = LID;
                    obj.GroupName = GroupName;
                    obj.GroupID = groupID;
                    obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
                    //obj.Status = ddlStatus.SelectedItem.Text;
                    status = ddlStatus.SelectedValue.Split('_');
                    obj.Status = status[0].ToString();
                    obj.PackageID = PackageID;
                    obj.PackageName = PackageName;
                    obj.SequenceNo = 19;
                    lstInvestigationVal.Add(obj);

                }
                if (txtWbcs.Text != string.Empty)
                {
                    obj = new InvestigationValues();
                    obj.InvestigationID = Convert.ToInt32(ControlID);
                    obj.Name = lblWbc.Text;
                    obj.Value = txtWbcs.Text;
                    obj.PatientVisitID = VID;
                    obj.CreatedBy = LID;
                    obj.GroupName = GroupName;
                    obj.GroupID = groupID;
                    obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                    obj.UOMCode = lblUwbcss.Text;
                    //obj.Status = ddlStatus.SelectedItem.Text;
                    status = ddlStatus.SelectedValue.Split('_');
                    obj.Status = status[0].ToString();
                    obj.PackageID = PackageID;
                    obj.PackageName = PackageName;
                    obj.SequenceNo = 20;
                    lstInvestigationVal.Add(obj);
                }
                if (txtRbcs.Text != string.Empty)
                {
                    obj = new InvestigationValues();
                    obj.InvestigationID = Convert.ToInt32(ControlID);
                    obj.Name = lblRBC.Text;
                    obj.Value = txtRbcs.Text;
                    obj.PatientVisitID = VID;
                    obj.CreatedBy = LID;
                    obj.GroupName = GroupName;
                    obj.GroupID = groupID;
                    obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                    obj.UOMCode = lblUrbcs.Text;
                    //obj.Status = ddlStatus.SelectedItem.Text;
                    status = ddlStatus.SelectedValue.Split('_');
                    obj.Status = status[0].ToString();
                    obj.PackageID = PackageID;
                    obj.PackageName = PackageName;
                    obj.SequenceNo = 21;
                    lstInvestigationVal.Add(obj);
                }
                if (lblEpithelialcells.Text != string.Empty)
                {
                    obj = new InvestigationValues();
                    obj.InvestigationID = Convert.ToInt32(ControlID);
                    obj.Name = lblEpithelialcells.Text;
                    obj.Value = txtEpithelial.Text;
                    obj.PatientVisitID = VID;
                    obj.CreatedBy = LID;
                    obj.GroupName = GroupName;
                    obj.GroupID = groupID;
                    obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                    obj.UOMCode = lblUEpithelial.Text;
                    //obj.Status = ddlStatus.SelectedItem.Text;
                    status = ddlStatus.SelectedValue.Split('_');
                    obj.Status = status[0].ToString();
                    obj.PackageID = PackageID;
                    obj.PackageName = PackageName;
                    obj.SequenceNo = 22;
                    lstInvestigationVal.Add(obj);
                }
                if (lblEpithelialcells.Text != string.Empty)
                {
                    obj = new InvestigationValues();
                    obj.InvestigationID = Convert.ToInt32(ControlID);
                    obj.Name = lblSpermagglutinate.Text;
                    obj.Value = txtSpermagglutinates.Text;
                    obj.PatientVisitID = VID;
                    obj.CreatedBy = LID;
                    obj.GroupName = GroupName;
                    obj.GroupID = groupID;
                    obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
                    obj.UOMCode = lblUSpermagglutinates.Text;
                    //obj.Status = ddlStatus.SelectedItem.Text;
                    status = ddlStatus.SelectedValue.Split('_');
                    obj.Status = status[0].ToString();
                    obj.PackageID = PackageID;
                    obj.PackageName = PackageName;
                    obj.SequenceNo = 23;
                    lstInvestigationVal.Add(obj);
                }
            }
        
        return lstInvestigationVal;
    }

    public void setAttributes(string id)
    {
        txtReason.Attributes.Add("onfocus", "Clear('" + id + "');");
        txtReason.Attributes.Add("onblur", "setComments('" + id + "');");
        txtRefRange.Attributes.Add("onfocus", "Clear('" + id + "_txtRefRange');");
        txtRefRange.Attributes.Add("onblur", "setComments('" + id + "_txtRefRange');");
    }

    bool readOnly = false;
    public bool Readonly
    {
        set
        {
            //Modified by Perumal on 23 Jan 2012
            //txtReason.Enabled = value;
            //txtRefRange.Enabled = value;
            txtReason.ReadOnly = value == false ? true : false;
            txtMedRemarks.ReadOnly = value == false ? true : false;
            txtRefRange.Enabled = value == false ? true : false;

            pnlenabled.Enabled = value;
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
    public void LoadDataForEdit(List<InvestigationValues> lEditValues)
    {
        //lblName.Text = lEditValues[0].Name;
        foreach (var item in lEditValues)
        {
            switch (item.Name)
            {
                case "Volume":
                    txtVolume.Text = item.Value;
                    break;

                case "Liquification":
                    txtLiquification.Text = item.Value;
                    break;

                case "Viscosity":
                    txtViscosity.Text = item.Value;
                    break;

                case "PH":
                    txtPH.Text = item.Value;
                    break;

                case "Reaction":
                    txtReaction.Text = item.Value;
                    break;

                case "<b>Sperm Count</b>":
                    txtSpermCount.Text = item.Value;
                    break;

                case "A-Rapid Progressive Motility":
                    txtRapid.Text = item.Value;
                    break;

                case "B-Sluggish Progressive Motility":
                    txtSluggish.Text = item.Value;
                    break;

                case "C-Non Progressive Motility":
                    txtnon.Text = item.Value;
                    break;

                case "D-No Motility":
                    txtNoMotility.Text = item.Value;
                    break;

                case "Normal":
                    txtNormal.Text = item.Value;
                    break;

                case "Pin,Giant&Amorphous Heads":
                    txtPinGiant.Text = item.Value;
                    break;

                case "WBCs":
                    txtWbcs.Text = item.Value;
                    break;
                case "RBCs":
                    txtRbcs.Text = item.Value;
                    break;
                case "Epithelial Cells":
                    txtEpithelial.Text = item.Value;
                    break;
                case "Sperm agglutinates":
                    txtSpermagglutinates.Text = item.Value;
                    break;





            }

        }
        txtReason.Text = lEditValues[0].Reason;
        txtMedRemarks.Text = lEditValues[0].MedicalRemarks;
    }
   
    public bool IsEditPattern()
    {
        return Convert.ToBoolean(hdnReadonly.Value);
    }

    public void MakeReadOnly(string patterID)
    {
        ATag.Visible = true;
        hdnReadonly.Value = "true";
        pnlenabled.Enabled = true;
        txtRefRange.Attributes.Add("readOnly", "true");
        txtReason.Attributes.Add("readOnly", "true");
        txtMedRemarks.Attributes.Add("readOnly", "true");
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
        if (labTechEditMedRem == "N" && currentRoleName == "Lab Technician")
        {
            txtMedRemarks.ReadOnly = true;
        }
        else
        {
            txtMedRemarks.ReadOnly = false;
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

}
