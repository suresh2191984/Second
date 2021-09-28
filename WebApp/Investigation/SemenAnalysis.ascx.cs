
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Web.Script.Serialization;

public partial class Investigation_SemenAnalysis : BaseControl
{
    public Investigation_SemenAnalysis()
        : base("Investigation_SemenAnalysis_ascx")
    {
    }

    private string id = string.Empty;
    private string name = string.Empty;
    private string uom = string.Empty;
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

    protected void Page_Load(object sender, EventArgs e)
    {
        AutoCompleteExtender1.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        AutoCompleteExtender2.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
        LoadMetaData();
    }

    public string ControlID
    {
        get { return id; }
        set
        {
            id = value;
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


    public void LoadData(List<InvestigationValues> lstData)
    {
        for (int i = 0; i < lstData.Count; i++)
        {
            if (lstData[i].Name == "SemenReaction")
            {
                ddlsReaction.Items.Add(lstData[i].Value);
            }

            if (lstData[i].Name == "SpermAgglutination")
            {
                //ddlShow.Items.Add(lstData[i].Value);
                ddlsAgglutination.Items.Add(lstData[i].Value);
            }


        }
        ddlsReaction.Items.Insert(0, new ListItem("Select"));
        ddlsAgglutination.Items.Insert(0, new ListItem("Select"));
    }

    public List<InvestigationValues> GetResult(long VID)
    {

        List<InvestigationValues> lstInvestigationVal = new List<InvestigationValues>();
        InvestigationValues obj = new InvestigationValues();
        String[] status;
        if (txtSpermCount.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 1;
            lstInvestigationVal.Add(obj);
        }
        if (txtSemenph.Text != string.Empty || ddlsReaction.SelectedItem.Text != "Select" || txtlignfacton.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = "Macroscopy";
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 2;
            lstInvestigationVal.Add(obj);
        }

        if (txtSemenph.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.Name = lblsemenpH.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.Value = txtSemenph.Text;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 3;
            lstInvestigationVal.Add(obj);
        }
        if (ddlsReaction.SelectedItem.Text != "Select")
        {
            obj = new InvestigationValues();
            obj.Name = lblSemenreaction.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.Value = ddlsReaction.SelectedItem.Text;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 4;
            lstInvestigationVal.Add(obj);
        }
        if (txtlignfacton.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.Name = lblsemenLignefaction.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.Value = txtlignfacton.Text;
            obj.UOMCode = lblLignefactonUOM.Text;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 5;
            lstInvestigationVal.Add(obj);
        }
        if (txtSpermCount.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = "Microscopy";
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 6;
            lstInvestigationVal.Add(obj);
        }
        if (txtSpermCount.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.Name = lblSpermCount.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.Value = txtSpermCount.Text;
            obj.UOMCode = spermCountUOM.Text;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 7;
            lstInvestigationVal.Add(obj);
        }
        if (txtactiveSperms.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = "Sperm Motility";
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 8;
            lstInvestigationVal.Add(obj);
        }
        if (ddlsMotality.SelectedItem.Text != "Select")
        {
            obj = new InvestigationValues();
            obj.Name = lblOverallMotility.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.Value = ddlsMotality.SelectedItem.Value;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 9;
            lstInvestigationVal.Add(obj);
        }

        if (txthypermotile.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.Name = lblHypermotile.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.Value = txthypermotile.Text;
            obj.UOMCode = lblhypermotileUOM.Text;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 10;
            lstInvestigationVal.Add(obj);
        }


        if (txtactiveSperms.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.Name = lblActiveSperms.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.Value = txtactiveSperms.Text;
            obj.UOMCode = lblactiveSuom.Text;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 11;
            lstInvestigationVal.Add(obj);
        }

        if (txtSluggishSperm.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.Name = lblSluggishSperm.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.Value = txtSluggishSperm.Text;
            obj.UOMCode = lblSluggishSpermUOM.Text;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 12;
            lstInvestigationVal.Add(obj);
        }

        if (txtvSluggish.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.Name = lblvSluggis.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.Value = txtvSluggish.Text;
            obj.UOMCode = lblvsugUOM.Text;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 13;
            lstInvestigationVal.Add(obj);
        }
        //obj = new InvestigationValues();
        //obj.Name = lblHypermotile.Text;
        //obj.InvestigationID = Convert.ToInt32(ControlID);
        //obj.PatientVisitID = VID;
        //obj.CreatedBy = LID;
        //obj.GroupName = GroupName;
        //obj.GroupID = groupID;
        //obj.Orgid = OrgID;
        //obj.Value = txthypermotile.Text;
        //obj.UOMCode = lblhypermotileUOM.Text;
        //obj.Status = ddlstatus.SelectedItem.Text;
        //lstInvestigationVal.Add(obj);

        if (txtImmotileSperm.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.Name = lblImmotileSperms.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.Value = txtImmotileSperm.Text;
            obj.UOMCode = lblImmotileSpermUOM.Text;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 14;
            lstInvestigationVal.Add(obj);
        }


        if (txtSpermMorphology.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.Name = lblSpermMorphology.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.Value = txtSpermMorphology.Text;
            obj.UOMCode = lblMorphologyUOM.Text;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 15;
            lstInvestigationVal.Add(obj);
        }

        if (hSemenResultvalues.Value != string.Empty)
        {
            obj = new InvestigationValues();
            obj.Name = "Sperm Morphology";
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.Value = "Quantification";
            obj.UOMCode = lblMorphologyUOM.Text;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 16;
            lstInvestigationVal.Add(obj);
        }
        int i = 17;
        foreach (string splitString in hSemenResultvalues.Value.Split('^'))
        {
            //obj = new InvestigationValues();
            //RID:1~Morphology:1~Qualifcation:1~UOM:%^
            //RID:1~Morphology:Abnormal~Qualifcation:15~UOM:%^
            obj = new InvestigationValues();
            if (splitString != "")
            {
                foreach (string strValues in splitString.Split('~'))
                {
                    string chkString = strValues.Split(':')[0];
                    string Strvalue = strValues.Split(':')[1];



                    switch (chkString)
                    {
                        case "Morphology":
                            if (Strvalue != "")
                            {
                                obj.Name = Strvalue;
                            }
                            break;

                        case "Quantification":
                            if (Strvalue != "")
                            {
                                obj.Value = Strvalue;

                            }

                            break;
                    };

                }
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = OrgID;
                obj.PatientVisitID = VID;
                obj.InvestigationID = Convert.ToInt32(ControlID);
                //obj.Status = ddlstatus.SelectedItem.Text;
                status = ddlstatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                obj.SequenceNo = i;
                lstInvestigationVal.Add(obj);
                i += 1;
            }

        }

        if (txtsVitality.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.Name = lblSpermVitality.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.Value = txtsVitality.Text;
            obj.UOMCode = lblsVitalityUOM.Text;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = i;
            lstInvestigationVal.Add(obj);
            i += 1;
        }

        if (ddlsAgglutination.SelectedItem.Text != "Select")
        {

            obj = new InvestigationValues();
            obj.Name = lblsAggulination.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.Value = ddlsAgglutination.SelectedItem.Text;
            obj.UOMCode = lblsVitalityUOM.Text;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = i;
            lstInvestigationVal.Add(obj);
            i += 1;
        }

        if (txtExAgglinaton.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.Name = lblEx.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.Value = txtExAgglinaton.Text;
            obj.UOMCode = lblsVitalityUOM.Text;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = i;
            lstInvestigationVal.Add(obj);
            i += 1;
        }


        if (txtLeucocytes.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.Name = lblSleukocytes.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.Value = txtLeucocytes.Text;
            obj.UOMCode = lblWBCsUOM.Text;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = i;
            lstInvestigationVal.Add(obj);
            i += 1;
        }

        if (txtRBCs.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.Name = lblRBCs.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.Value = txtRBCs.Text;
            obj.UOMCode = lblRBCsUOM.Text;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = i;
            lstInvestigationVal.Add(obj);
            i += 1;
        }
        if (txtPuscells.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.Name = lblPuscells.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.Value = txtPuscells.Text;
            obj.UOMCode = lblpuscellsUOM.Text;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = i;
            lstInvestigationVal.Add(obj);
            i += 1;
        }
        return lstInvestigationVal;
    }

    public void loadStatus(List<InvestigationStatus> lstStatus)
    {
        ddlstatus.DataSource = lstStatus;
        //ddlstatus.DataTextField = "Status";
        //ddlstatus.DataValueField = "InvestigationStatusID";
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
        string strSelect = Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_19;
        List<PatientInvestigation> lstPInv = new List<PatientInvestigation>();
        PatientInvestigation Pinv = null;
        string[] status;
        Pinv = new PatientInvestigation();
        Pinv.InvestigationID = Convert.ToInt64(ControlID);
        Pinv.PatientVisitID = Vid;
        //Pinv.Status = ddlstatus.SelectedItem.Text;
        status = ddlstatus.SelectedValue.Split('_');
        Pinv.Status = status[0].ToString();
        Pinv.Reason = txtReason.Text;
        Pinv.MedicalRemarks = txtMedRemarks.Text;
        Pinv.OrgID = OrgID;
        Pinv.ReferenceRange = txtRefRange.Text;
        Pinv.AccessionNumber = AccessionNumber;	
        if (Pinv.ReferenceRange.Trim() != "")
        {
            Pinv.ReferenceRange = Pinv.ReferenceRange.Trim().Replace("\n", "<br>");
        }
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
        //InvRemarks
        if (hdnRemarksID.Value != null && hdnRemarksID.Value != "")
        {
            Pinv.RemarksID = Convert.ToInt64(hdnRemarksID.Value);
        }
        //InvRemarks
        return Pinv;
    }

    public void setAttributes(string id)
    {
        txtReason.Attributes.Add("onfocus", "Clear('" + id + "');");
        txtReason.Attributes.Add("onblur", "setComments('" + id + "');");
    }

    public void loadData(List<InvestigationValues> lstLoadData)
    {

    }
    bool readOnly = false;
    public bool Readonly
    {
        set
        {
            //Modified by Perumal on 23 Jan 2012
            //txtReason.Enabled = value;
            txtReason.ReadOnly = value == false ? true : false;
            txtMedRemarks.ReadOnly = value == false ? true : false;
            pnlEnabled.Enabled = value;
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

    public void LoadDataForEdit(List<InvestigationValues> lstValues)
    {
        lblName.Text = lstValues[0].Name;
        string hidVal = string.Empty;
        int i = 0;
        foreach (var item in lstValues)
        {
            switch (item.Name)
            {
                case "Semen pH":
                    txtSemenph.Text = item.Value;
                    break;

                case "Semen Reaction":
                    ddlsReaction.ClearSelection();
                    if (ddlsReaction.Items.Contains(new ListItem(item.Value.Trim())))
                    {
                        ddlsReaction.Items.FindByValue(item.Value).Selected = true;
                    }
                    break;

                case "Sperm Count":
                    txtSpermCount.Text = item.Value;
                    break;

                case "Sperm Overall Motaility":
                    ddlsMotality.ClearSelection();
                    ddlsMotality.Items.FindByValue(item.Value).Selected = true;
                    break;

                case "Active Sperms":
                    txtactiveSperms.Text = item.Value;
                    break;

                case "SluggishSperm":
                    txtSluggishSperm.Text = item.Value;
                    break;

                case "VerysluggishSperm":
                    txtvSluggish.Text = item.Value;
                    break;

                case "ImmotileSperm":
                    txtImmotileSperm.Text = item.Value;
                    break;

                case "Hyper motile Sperms":
                    txthypermotile.Text = item.Value;
                    break;

                case "Sperms with Normal Morphology ":
                    txtSpermMorphology.Text = item.Value;
                    break;

                case "Sperm Vitality":
                    txtsVitality.Text = item.Value;
                    break;

                case "Sperm Agglutination":
                    ddlsAgglutination.Items.FindByText(item.Value).Selected = true;
                    break;

                case "Extent of agglination":
                    txtExAgglinaton.Text = item.Value;
                    break;

                case "Semen Liquefaction time":
                    txtlignfacton.Text = item.Value;
                    break;

                case "Semen Leukocytes(WBCs)":
                    txtLeucocytes.Text = item.Value;
                    break;

                case "Semen RBCs":
                    txtRBCs.Text = item.Value;
                    break;

                case "Semen PusCells":
                    txtPuscells.Text = item.Value;
                    break;

                default:
                    //"RID:" + rowNumber + "~Morphology:" + morphology + "~Qualifcation:" + Qualifcation + "%^";
                    if (item.Name != "Sperm Morphology" && item.Value != "Quantification")
                    {
                        i = i + 1;
                        hidVal += "RID:" + i + "~Morphology:" + item.Name + "~Quantification:" + item.Value + "^";
                    }
                    break;
            }
        }
        if (hidVal != string.Empty)
        {
            hSemenResultvalues.Value = hidVal;
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "ProcessMethods", "javascript:LoadExistingSemenItem('" + hSemenResultvalues.Value + "','" + this.ClientID + "');", true);
        }
        txtReason.Text = lstValues[0].Reason;
        txtMedRemarks.Text = lstValues[0].MedicalRemarks;
    }
    
    public bool IsEditPattern()
    {
        return Convert.ToBoolean(hdnReadonly.Value);
    }

    public void MakeReadOnly(string patterID)
    {
        ATag.Visible = true;
        hdnReadonly.Value = "true";
        pnlEnabled.Enabled = true;
        txtRefRange.Attributes.Add("readOnly", "true");
        txtReason.Attributes.Add("readOnly", "true");
        txtMedRemarks.Attributes.Add("readOnly", "true");
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

    public void LoadMetaData()
    {
        string strSelect = Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_19;
        try
        {
            long returncode1 = -1;
            string domains1 = "Motality";
            string[] Tempdata1 = domains1.Split(',');
            string LangCode1 = "en-GB";
            List<MetaData> lstmetadataInput1 = new List<MetaData>();
            List<MetaData> lstmetadataOutput1 = new List<MetaData>();

            MetaData objMeta1;

            for (int i = 0; i < Tempdata1.Length; i++)
            {
                objMeta1 = new MetaData();
                objMeta1.Domain = Tempdata1[i];
                lstmetadataInput1.Add(objMeta1);

            }
            returncode1 = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput1, OrgID, LangCode1, out lstmetadataOutput1);
            if (lstmetadataOutput1.Count > 0)
            {
                var childItems2 = from child in lstmetadataOutput1
                                  where child.Domain == "Motality"
                                  select child;
                ddlsMotality.DataSource = childItems2;
                ddlsMotality.DataTextField = "DisplayText";
                ddlsMotality.DataValueField = "Code";
                ddlsMotality.DataBind();
                ddlsMotality.Items.Insert(0, new ListItem(strSelect, ""));


            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Despatch Status ", ex);


        }

    }

}
