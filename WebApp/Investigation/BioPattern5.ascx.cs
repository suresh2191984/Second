using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;

public partial class Investigation_BioPattern5 : BaseControl
{
    public Investigation_BioPattern5()
        : base("Investigation_BioPattern5_ascx")
    {
    }
    private string id = string.Empty;
   


    /// <summary>
    /// Assign the ControlID to hidden field
    /// </summary>
    public string ControlID
    {
        get { return id; }
        set
        {
            id = value;
            hidVal.Value = id;
        }
    }  
    bool readOnly = false;
    public bool Readonly
    {
        set
        {
            //txtReason.Enabled = value;
            //txtRefRange.Enabled = value;
            //txtValue.Enabled = value;
            //lnkEdit.Visible = true;

        }
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

    #region "Common Resource Property"

    string strTime = Resources.Investigation_ClientDisplay.Investigation_BioPattern5_ascx_01 == null ? "Time <br /> (in hrs)" : Resources.Investigation_ClientDisplay.Investigation_BioPattern5_ascx_01;
    string strBlood = Resources.Investigation_ClientDisplay.Investigation_BioPattern5_ascx_02 == null ? "Blood Sugar <br /> (in mg/dl)" : Resources.Investigation_ClientDisplay.Investigation_BioPattern5_ascx_02;
    string strUrine = Resources.Investigation_ClientDisplay.Investigation_BioPattern5_ascx_03 == null ? "Urine Sugar <br /> (in mg/dl)" : Resources.Investigation_ClientDisplay.Investigation_BioPattern5_ascx_03;

    #endregion
    #region "Initial"
    protected void Page_Load(object sender, EventArgs e)
    {
        if (pnGTT.Visible)
        {
            loadGTT();
        }
        LoadMetaData();
    }

    #endregion

    #region "Events"
    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        if (ViewState["test"] == null)
        {
            ViewState["isEdit"] = true;
        }
        Readonly = true;
    }
    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        Table tbl = new Table();
        TableCell cell;
        TableRow tr;
        hidVal.Value = t13015.Text;
        ViewState["Count"] = hidVal.Value;
        int testCount = Convert.ToInt32(hidVal.Value);
        tr = new TableRow();
        DateTime time = Convert.ToDateTime(ddlStartTime.SelectedItem.Text + " " + ddlampm.SelectedItem.Text);
        pn3016.Controls.Clear();

        // Create table Header Name 
        cell = new TableCell();
        Label lblTime = new Label();
        lblTime.Text = strTime.Trim();
        lblTime.CssClass = "defaultfontcolor";
        cell.Width = 100;
        cell.Style["style"] = "align:center";
        cell.Controls.Add(lblTime);
        tr.Controls.Add(cell);

        cell = new TableCell();
        cell.Width = 100;
        Label lblBloodSugar = new Label();
        lblBloodSugar.Text = strBlood.Trim();
        lblBloodSugar.CssClass = "defaultfontcolor";
        cell.Controls.Add(lblBloodSugar);
        tr.Controls.Add(cell);

        cell = new TableCell();
        cell.Width = 100;
        Label lblUrineSugar = new Label();
        lblUrineSugar.Text = strUrine.Trim();
        lblUrineSugar.CssClass = "defaultfontcolor";
        cell.Controls.Add(lblUrineSugar);
        tr.Controls.Add(cell);

        tbl.Controls.Add(tr);

        tbl.GridLines = GridLines.Both;
        tbl.Style.Add("align", "center");

        // Create Dynamic Text control
        for (int i = 0, j = 1; i < testCount; i++, j++)
        {
            DateTime addTime = time.AddMinutes(Convert.ToDouble(ddlTimeInterval.SelectedItem.Text) * j);
            tr = new TableRow();
            cell = new TableCell();
            cell.Width = 100;
            TextBox txt = new TextBox();
            txt.Text = addTime.ToShortTimeString();
            txt.ID = "t" + j.ToString() + "13015";
            txt.CssClass = "textbox_hemat";
            txt.ReadOnly = true;
            cell.Controls.Add(txt);
            tr.Controls.Add(cell);

            cell = new TableCell();
            cell.Width = 100;
            TextBox txt1 = new TextBox();
            txt1.ID = "t" + j.ToString() + "23015";
            txt1.CssClass = "textbox_hemat";
            cell.Controls.Add(txt1);
            tr.Controls.Add(cell);

            cell = new TableCell();
            cell.Width = 100;
            TextBox txt2 = new TextBox();
            txt2.ID = "t" + j.ToString() + "33015";
            txt2.CssClass = "textbox_hemat";
            cell.Controls.Add(txt2);
            tr.Controls.Add(cell);

            tbl.Controls.Add(tr);
        }

        pn3016.Controls.Add(tbl);
    }
    #endregion

    #region "Methods"
    public void loadGTT()
    {
        pnGTT.Visible = true;
        Table tbl = new Table();
        TableCell cell;
        TableRow tr;
        if (Convert.ToString(ViewState["Count"]) != "")
        {
            int testCount = Convert.ToInt32(ViewState["Count"]);
            tr = new TableRow();
            DateTime time = Convert.ToDateTime(ddlStartTime.SelectedItem.Text + " " + ddlampm.SelectedItem.Text);
            pn3016.Controls.Clear();

            // Create table Header Name 
            cell = new TableCell();
            Label lblTime = new Label();
            lblTime.Text = strTime.Trim();
            lblTime.CssClass = "defaultfontcolor";
            cell.Width = 100;
            cell.Style["style"] = "align:center";
            cell.Controls.Add(lblTime);
            tr.Controls.Add(cell);

            cell = new TableCell();
            cell.Width = 100;
            Label lblBloodSugar = new Label();
            lblBloodSugar.Text = strBlood.Trim();
            lblBloodSugar.CssClass = "defaultfontcolor";
            cell.Controls.Add(lblBloodSugar);
            tr.Controls.Add(cell);

            cell = new TableCell();
            cell.Width = 100;
            Label lblUrineSugar = new Label();
            lblUrineSugar.Text = strUrine.Trim();
            lblUrineSugar.CssClass = "defaultfontcolor";
            cell.Controls.Add(lblUrineSugar);
            tr.Controls.Add(cell);

            tbl.Controls.Add(tr);

            tbl.GridLines = GridLines.Both;
            tbl.Style.Add("align", "center");

            for (int i = 0, j = 1; i < testCount; i++, j++)
            {
                DateTime addTime = time.AddMinutes(Convert.ToDouble(ddlTimeInterval.SelectedItem.Text) * j);
                tr = new TableRow();
                cell = new TableCell();
                cell.Width = 100;
                TextBox txt = new TextBox();
                txt.Text = addTime.ToShortTimeString();
                txt.ID = "t" + j.ToString() + "13015";
                txt.CssClass = "textbox_hemat";
                txt.ReadOnly = true;
                cell.Controls.Add(txt);
                tr.Controls.Add(cell);

                cell = new TableCell();
                cell.Width = 100;
                TextBox txt1 = new TextBox();
                txt1.ID = "t" + j.ToString() + "23015";
                txt1.CssClass = "textbox_hemat";
                cell.Controls.Add(txt1);
                tr.Controls.Add(cell);

                cell = new TableCell();
                cell.Width = 100;
                TextBox txt2 = new TextBox();
                txt2.ID = "t" + j.ToString() + "33015";
                txt2.CssClass = "textbox_hemat";
                cell.Controls.Add(txt2);
                tr.Controls.Add(cell);

                tbl.Controls.Add(tr);
            }
            pn3016.Controls.Add(tbl);
        }
    }
    public List<InvestigationValues> GetResult(long VID)
    {

        InvestigationValues InVestVal = null;
        List<InvestigationValues> lstVal = new List<InvestigationValues>();

        InVestVal = new InvestigationValues();
        InVestVal.InvestigationID = Convert.ToInt32(ControlID);
        InVestVal.Name = "Sugar Grams";
        InVestVal.Value = txtSugar.Text;
        InVestVal.PatientVisitID = VID;
        InVestVal.GroupID = 0;
        lstVal.Add(InVestVal);

        if (t13015.Text != "")
        {
            for (int i = 1; i <= Convert.ToInt16(t13015.Text); i++)
            {
                TextBox txtTime = (TextBox)this.FindControl("t" + i + "13015");
                TextBox txtBloodSugar = (TextBox)this.FindControl("t" + i + "23015");
                TextBox txtUrineSugar = (TextBox)this.FindControl("t" + i + "33015");
                if (txtTime != null)
                {
                    InVestVal = new InvestigationValues();
                    InVestVal.InvestigationID = Convert.ToInt32(ControlID);
                    InVestVal.Name = "Time";
                    InVestVal.Value = txtTime.Text;
                    InVestVal.PatientVisitID = VID;
                    InVestVal.GroupID = i;
                    InVestVal.PackageID = i;
                    lstVal.Add(InVestVal);

                    InVestVal = new InvestigationValues();
                    InVestVal.InvestigationID = Convert.ToInt32(ControlID);
                    InVestVal.Name = "Blood Sugar";
                    InVestVal.Value = txtBloodSugar.Text;
                    InVestVal.PatientVisitID = VID;
                    InVestVal.GroupID = i;
                    InVestVal.PackageID = i;
                    lstVal.Add(InVestVal);

                    InVestVal = new InvestigationValues();
                    InVestVal.InvestigationID = Convert.ToInt32(ControlID);
                    InVestVal.Name = "Urine Sugar";
                    InVestVal.Value = txtUrineSugar.Text;
                    InVestVal.PatientVisitID = VID;
                    InVestVal.GroupID = i;
                    InVestVal.PackageID = i;
                    lstVal.Add(InVestVal);
                }
            }
        }
        return lstVal;
    }
    public void ShowGTT()
    {
        pnGTT.Visible = true;
    }

    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "Pattern_StartTime,Pattern_ampm,Pattern_TimeInterval";
            string[] Tempdata = domains.Split(',');

            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            string LangCode = "en-GB";
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "Pattern_StartTime"
                                 orderby child.MetaDataID 
                                 select child;
                ddlStartTime.DataSource = childItems;
                ddlStartTime.DataTextField = "DisplayText";
                ddlStartTime.DataValueField = "Code";
                ddlStartTime.DataBind();
                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "Pattern_ampm"
                                  select child;

                ddlampm.DataSource = childItems2;
                ddlampm.DataTextField = "DisplayText";
                ddlampm.DataValueField = "Code";
                ddlampm.DataBind();
                var childItems3 = from child in lstmetadataOutput
                                  where child.Domain == "Pattern_TimeInterval"
                                  select child;
                ddlTimeInterval.DataSource = childItems3;
                ddlTimeInterval.DataTextField = "DisplayText";
                ddlTimeInterval.DataValueField = "Code";
                ddlTimeInterval.DataBind();
                ddlTimeInterval.SelectedValue = "-1";
            }



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);
            //edisp.Visible = true;
            // ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    #endregion
}
