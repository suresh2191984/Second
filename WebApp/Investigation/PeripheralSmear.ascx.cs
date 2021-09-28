using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using System.Web.Script.Serialization;
public partial class Investigation_PeripheralSmear : BaseControl
{
    int groupID = 0;
    string groupName = string.Empty;
    string name = string.Empty;
    string id = string.Empty;
    string uom = string.Empty;
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
    public string UOM
    {
        get { return uom; }
        set
        {
            uom = value;
            lblUom1.Text = uom;
            lblUom2.Text = uom;
            lblUom3.Text = uom;
            lblUom4.Text = uom;
            lblUom5.Text = uom;
            lblUom6.Text = uom;
            lblUom7.Text = uom;
            lblUom8.Text = uom;
            lblUom9.Text = uom;
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
        //ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id);ShowStatusReason(this.id);");
        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
    }
    //protected void ddlShow_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (ddlShow.SelectedIndex == 1)
    //    {
    //        ddlPlasma.Visible = true;
    //    }
    //    else
    //    {
    //        ddlPlasma.Visible = false;
    //    }
    //}

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

    /// <summary>
    /// Assign the ControlID to hidden field
    /// </summary>
    public string ControlID
    {
        get { return id; }
        set
        {
            id = value;
            //hidVal.Value = id;
        }
    }

    /// <summary>
    /// Method to populate dropdown list
    /// </summary>
    /// <param name="lstData"></param>
    public void LoadData(List<InvestigationValues> lstData)
     {
        int i;
        for (i = 0; i < lstData.Count; i++)
        {
            if (lstData[i].Name == "Result")
            {
                ddlredcells.Items.Add(lstData[i].Value);
            }

            if (lstData[i].Name == "Result1")
            {
                //ddlShow.Items.Add(lstData[i].Value);
                ddldistribution.Items.Add(lstData[i].Value);
            }
            if (lstData[i].Name == "Parasites")
            {
                //ddlShow.Items.Add(lstData[i].Value);
                ddlParasites.Items.Add(lstData[i].Value);
            }
            if (lstData[i].Name == "WbcCount")
            {
                //ddlShow.Items.Add(lstData[i].Value);
                ddlWbcCount.Items.Add(lstData[i].Value);
            }
            if (lstData[i].Name == "Normal")
            {
                //ddlShow.Items.Add(lstData[i].Value);
                ddlNormalRedcells.Items.Add(lstData[i].Value);
            }
            
            
        }
        ddlParasites.Items.Insert(0, new ListItem("Select"));
        ddlredcells.Items.Insert(0, new ListItem("Select"));
        ddlredcells.Items.Add("Others");
        ddldistribution.Items.Insert(0, new ListItem("Select"));
        ddlWbcCount.Items.Insert(0, new ListItem("Select"));
        ddlNormalRedcells.Items.Insert(0, new ListItem("Select"));
        //        ddlPlasma.Items.Insert(0, new ListItem("Select"));
        txtReason.Text = lstData[0].Reason;
        txtMedRemarks.Text = lstData[0].MedicalRemarks;
    }


    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> lstInvestigationVal = new List<InvestigationValues>();
        InvestigationValues obj;
        String[] status;
        obj = new InvestigationValues();
        obj.InvestigationID = Convert.ToInt32(ControlID);
        obj.Name = lblName.Text;
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
        lstInvestigationVal.Add(obj);

        obj = new InvestigationValues();
        obj.InvestigationID = Convert.ToInt32(ControlID);
        obj.Name = lblRedcells.Text;
        //obj.Value = ddlredcells.SelectedItem.Text != "Select" ? rdlMorphology.SelectedItem.Text
        //            + " " + ddlredcells.SelectedItem.Text : rdlMorphology.SelectedItem.Text;
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
        lstInvestigationVal.Add(obj);


        obj = new InvestigationValues();
        obj.InvestigationID = Convert.ToInt32(ControlID);
        obj.Name = lblmorphology.Text;

        //obj.Value = ddlredcells.SelectedItem.Text != "Select" ?
        //            ddlredcells.SelectedItem.Text == "Others" ?
        //            txtOthers.Text != string.Empty ? rdlMorphology.SelectedItem.Text
        //            + " " + txtOthers.Text : rdlMorphology.SelectedItem.Text
        //            : rdlMorphology.SelectedItem.Text : rdlMorphology.SelectedItem.Text
        //            + " " + ddlredcells.SelectedItem.Text;
        //string sfdsf = rdlrbcMorphology.SelectedItem.Text;
        if (rdlrbcMorphology.SelectedItem.Text == "AbNormal")
        {
            if (ddlredcells.SelectedItem.Text != "Select")
            {
                //obj.Value = ddlredcells.SelectedItem.Text == "Others" ?
                //           txtOthers.Text != string.Empty ? rdlrbcMorphology.SelectedItem.Text
                //           + " " + txtOthers.Text : rdlrbcMorphology.SelectedItem.Text : rdlrbcMorphology.SelectedItem.Text +
                //           " " + ddlredcells.SelectedItem.Text;

                obj.Value = ddlredcells.SelectedItem.Text == "Others" ?
                           txtOthers.Text != string.Empty ? rdlrbcMorphology.SelectedItem.Text
                           + " " + txtOthers.Text : rdlrbcMorphology.SelectedItem.Text : ddlredcells.SelectedItem.Text;
            }
            else
            {
                obj.Value = rdlrbcMorphology.SelectedItem.Text;
            }
        }
        else if (rdlrbcMorphology.SelectedItem.Text == "Normal")
        {
            if (ddlNormalRedcells.SelectedItem.Text != "Select")
            {
                //obj.Value = rdlrbcMorphology.SelectedItem.Text + " " + ddlNormalRedcells.SelectedItem.Text;
                obj.Value = ddlNormalRedcells.SelectedItem.Text;
            }
            else
            {
                obj.Value = rdlrbcMorphology.SelectedItem.Text;
            }
        }
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
        lstInvestigationVal.Add(obj);


        obj = new InvestigationValues();
        obj.InvestigationID = Convert.ToInt32(ControlID);
        obj.Name = lblRbcDistribution.Text;
        obj.Value = ddldistribution.SelectedItem.Text != "Select" ? rdlRbcDistribution.SelectedItem.Text
                    + " " + ddldistribution.SelectedItem.Text : rdlRbcDistribution.SelectedItem.Text;
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
        lstInvestigationVal.Add(obj);


        if (chkAsinocytesis.Checked && txtAsino.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = chkAsinocytesis.Text;
            obj.Value = txtAsino.Text;
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
            lstInvestigationVal.Add(obj);
        }

        if (chkpoikilocytesis.Checked && txtpoikilocytesis.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = chkpoikilocytesis.Text;
            obj.Value = txtpoikilocytesis.Text;
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
            lstInvestigationVal.Add(obj);
        }

        if (chkPolychromasia.Checked && txtPolychromasia.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = chkPolychromasia.Text;
            obj.Value = txtPolychromasia.Text;
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
            lstInvestigationVal.Add(obj);
        }

        obj = new InvestigationValues();
        obj.InvestigationID = Convert.ToInt32(ControlID);
        obj.Name = lblWBC.Text;
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
        lstInvestigationVal.Add(obj);

        //wbc Count
        if (ddlWbcCount.SelectedItem.Text != "Select")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblWbcCount.Text;
            obj.Value = ddlWbcCount.SelectedItem.Text;
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
            lstInvestigationVal.Add(obj);
        }

        obj = new InvestigationValues();
        obj.InvestigationID = Convert.ToInt32(ControlID);
        obj.Name = lblwbcDistribution.Text;
        obj.Value = txtwbcDistribution.Text != string.Empty ? rdlwbcDistribution.SelectedItem.Text
                    + " " + txtwbcDistribution.Text : rdlwbcDistribution.SelectedItem.Text;
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
        lstInvestigationVal.Add(obj);



        obj = new InvestigationValues();
        obj.InvestigationID = Convert.ToInt32(ControlID);
        obj.Name = lblImmCells.Text;
        obj.Value = txtImmatureCells.Text != string.Empty ? rdlImmatureCells.SelectedItem.Text
                    + " " + txtImmatureCells.Text : rdlImmatureCells.SelectedItem.Text;
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
        lstInvestigationVal.Add(obj);

        obj = new InvestigationValues();
        obj.InvestigationID = Convert.ToInt32(ControlID);
        obj.Name = lblMalignantscell.Text;
        obj.Value = txtMalignantcells.Text != string.Empty ? rdlMalignantscell.SelectedItem.Text
                    + " " + txtMalignantcells.Text : rdlMalignantscell.SelectedItem.Text;
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
        lstInvestigationVal.Add(obj);

        if (txtspepcificpatterns.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblSpecificpatterns.Text;
            obj.Value = txtspepcificpatterns.Text;
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
            lstInvestigationVal.Add(obj);
        }

        obj = new InvestigationValues();
        obj.InvestigationID = Convert.ToInt32(ControlID);
        obj.Name = lblPlatelets.Text;
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
        lstInvestigationVal.Add(obj);

        obj = new InvestigationValues();
        obj.InvestigationID = Convert.ToInt32(ControlID);
        obj.Name = lblpltDistribution.Text;
        obj.Value = txtpltDistribution.Text != string.Empty ? rdlpltDistribution.SelectedItem.Text
                    + " " + txtpltDistribution.Text : rdlpltDistribution.SelectedItem.Text;
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
        lstInvestigationVal.Add(obj);

        obj = new InvestigationValues();
        obj.InvestigationID = Convert.ToInt32(ControlID);
        obj.Name = lblpltMorphology.Text;
        obj.Value = txtpltmorphology.Text != string.Empty ? rdlpltmorphology.SelectedItem.Text
                    + " " + txtpltmorphology.Text : rdlpltmorphology.SelectedItem.Text;
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
        lstInvestigationVal.Add(obj);

        int checkCount = 0;
        string resultString = string.Empty;
        foreach (ListItem li in chkList.Items)
        {
            if (li.Selected)
            {
                if (resultString != string.Empty)
                {
                    resultString += ddlParasites.SelectedItem.Text != "Select" ? "," + li.Text
                                    + " Parasites " + rdlparasites.SelectedItem.Text : li.Text
                                    + " Parasites " + rdlparasites.SelectedItem.Text
                                    + "(" + ddlParasites.SelectedItem.Text + ")";
                }
                else
                {
                    resultString = ddlParasites.SelectedItem.Text != "Select" ? li.Text
                                                    + " Parasites " + rdlparasites.SelectedItem.Text
                                                    + "(" + ddlParasites.SelectedItem.Text + ")" : li.Text
                                                    + " Parasites " + rdlparasites.SelectedItem.Text;
                }
                checkCount = 1;
            }

        }
        if (checkCount == 0)
        {
            resultString = rdlparasites.SelectedItem.Text;
        }

        if (resultString != string.Empty)
        {

            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblparasites.Text;
            obj.Value = resultString;
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
            lstInvestigationVal.Add(obj);
        }

        if (txtValue.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblTotalCount.Text;
            obj.Value = txtValue.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUnit.Text;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }

        if (txt1.Text != "" || txt2.Text != "" || txt3.Text != "" || txt4.Text != "" || txt5.Text != "" || txt6.Text != "" || txt7.Text != "" || txt8.Text != "" || txt9.Text != "")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblCaption.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }
        if (txt1.Text != "")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName1.Text;
            obj.Value = txt1.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUom1.Text;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }
        if (txt2.Text != "")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName2.Text;
            obj.PatientVisitID = VID;
            obj.Value = txt2.Text;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUom2.Text;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }
        if (txt3.Text != "")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName3.Text;
            obj.Value = txt3.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUom3.Text;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }
        if (txt4.Text != "")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName4.Text;
            obj.Value = txt4.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUom4.Text;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }
        if (txt5.Text != "")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName5.Text;
            obj.Value = txt5.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUom5.Text;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }
        if (txt6.Text != "")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName6.Text;
            obj.Value = txt6.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUom6.Text;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }
        if (txt7.Text != "")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName7.Text;
            obj.Value = txt7.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUom7.Text;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }
        if (txt8.Text != "")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName8.Text;
            obj.Value = txt8.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUom8.Text;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }
        if (txt9.Text != "")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName9.Text;
            obj.Value = txt9.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUom9.Text;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }

        

        return lstInvestigationVal;

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
    public PatientInvestigation GetInvestigations(long Vid)
    {
        List<PatientInvestigation> lstPInv = new List<PatientInvestigation>();
        PatientInvestigation Pinv = null;
        string[] status;
        Pinv = new PatientInvestigation();
        Pinv.InvestigationID = Convert.ToInt64(ControlID);
        Pinv.PatientVisitID = Vid;
        Pinv.Reason = txtReason.Text;
        Pinv.MedicalRemarks = txtMedRemarks.Text;
        //Pinv.Status = ddlStatus.SelectedItem.Text;
        status = ddlStatus.SelectedValue.Split('_');
        Pinv.Status = status[0].ToString();
        Pinv.OrgID = Convert.ToInt32(POrgid);// OrgID;
        Pinv.AccessionNumber = AccessionNumber;	
        if (ddlStatusReason.Items.Count > 0)
        {
            Pinv.InvStatusReasonID = (ddlStatusReason.SelectedValue == "-----Select-----" ? 0 : Convert.ToInt32(ddlStatusReason.SelectedValue));
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
        txtReason.Attributes.Add("onfocus", "Clear('" + id + "_txtReason');");
        txtReason.Attributes.Add("onblur", "setComments('" + id + "_txtReason');");
        //txtRefRange.Attributes.Add("onfocus", "Clear('" + id + "_txtRefRange');");
        //txtRefRange.Attributes.Add("onblur", "setComments('" + id + "_txtRefRange');");
    }
    bool readOnly = false;
    public bool Readonly
    {
        set
        {
            //Modified by Perumal on 23 Jan 2012
            //txtReason.Enabled = value;
            //txtRefRange.Enabled = value;
            //txtValue.Enabled = value;
            txtReason.ReadOnly = value == false ? true : false;
            txtMedRemarks.ReadOnly = value == false ? true : false;
            txtRefRange.ReadOnly = value == false ? true : false;
            txtValue.ReadOnly = value == false ? true : false;

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
    
    public bool IsEditPattern()
    {
        return Convert.ToBoolean(hdnReadonly.Value);
    }

    public void MakeReadOnly(string patterID)
    {
        ATag.Visible = true;
        hdnReadonly.Value = "true";
        txtValue.Attributes.Add("readOnly", "true");
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




