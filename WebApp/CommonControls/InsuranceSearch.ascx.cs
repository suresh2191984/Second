using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using System.Collections;

public partial class CommonControls_InsuranceSearch : BaseControl
{
    public event EventHandler onSearchComplete;
    long returnCode = -1;
    ArrayList al = new ArrayList();
    List<TPADetails> lstTPADetails;
    
    protected void Page_Load(object sender, EventArgs e)
    {

        if (ViewState["SelectedProds"] != null)
        {
            al = (ArrayList)ViewState["SelectedProds"];
        }

        if (!IsPostBack)
        {
            txtPatientNo.Attributes.Add("onKeyDown", "return validatenumber(event);");
            txtPatientName.Attributes.Add("onkeypress", "return onKeyPressBlockNumbers(event);");
            txtPatientName.Attributes.Add("onkeypress", "return onKeyPressBlockNumbers(event);");
         
            txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            BindTPA();
            BindClient();
            LoadMetaData();

            string  rval = string.Empty;
                rval = GetConfigValue("TPAFORLAB", OrgID);
           hdnTPALAB.Value = rval;
           btnSearch_Click(this, e);
        }
        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Showddl", "javascript:ShowDDl();", true);
    }

    private void BindClient()
    {
        try
        {
            List<InvClientMaster> Clientmaster = new List<InvClientMaster>();
            new Investigation_BL(base.ContextInfo).getOrgClientName(OrgID, out Clientmaster);
            if (Clientmaster.Count > 0)
            {
                ddlCorporate.DataSource = Clientmaster;
                ddlCorporate.DataTextField = "ClientName";
                ddlCorporate.DataValueField = "ClientID";
                ddlCorporate.DataBind();
                ddlCorporate.Items.Insert(0, "All");
                ddlCorporate.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Binding BindClient() Method", ex);
        }
    }

    private void BindTPA()
    {
        try
        {
            List<TPAMaster> lTpaMaster = new List<TPAMaster>();
            new IP_BL(base.ContextInfo).GetTPAName(OrgID, out lTpaMaster);
            ddlTpaName.DataSource = lTpaMaster;

            ddlTpaName.DataTextField = "TPAName";
            ddlTpaName.DataValueField = "TPAID";
            ddlTpaName.DataBind();
            ddlTpaName.Items.Insert(0, new ListItem("All", "-1"));
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Binding BindTPA() Method", ex);
        }
    }
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        string prodID = string.Empty;
        string prodFName = string.Empty;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TPADetails tpa = (TPADetails)e.Row.DataItem;
            

            string strScript = "onChaangeChk('" + ((CheckBox)e.Row.Cells[1].FindControl("rdSel")).ClientID + "');";
            ((CheckBox)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);

            Label lblDischaredDT = (Label)e.Row.FindControl("lblDischaredDT");
            Label lblAdmissionDate = (Label)e.Row.FindControl("lblAdmissionDate");
            TextBox txtClaimForwardDate = (TextBox)e.Row.FindControl("txtClaimForwardDate");
            HiddenField hdnDischargedDT = new HiddenField();
            hdnDischargedDT = (HiddenField)e.Row.FindControl("hdnDischargedDT");
            HiddenField hdnAdmissionDate = new HiddenField();
            hdnAdmissionDate = (HiddenField)e.Row.FindControl("hdnAdmissionDate");
            ImageButton ImageButton1 = (ImageButton)e.Row.FindControl("ImageButton1");   
            
            if (tpa.DischargedDT != DateTime.MinValue)
            {
                lblDischaredDT.Text = tpa.DischargedDT.ToShortDateString();
            }

            if (tpa.AdmissionDate != DateTime.MinValue)
            {
                lblAdmissionDate.Text = tpa.AdmissionDate.ToShortDateString();
                hdnAdmissionDate.Value = lblAdmissionDate.Text;
            }
            if (lblDischaredDT.Text != "")
                hdnDischargedDT.Value = lblDischaredDT.Text;
            if (tpa.CliamForwardDate != DateTime.MinValue)
            {
                txtClaimForwardDate.Text = tpa.CliamForwardDate.ToShortDateString();
                if (OrgID == 78 && RoleName == "Accounts")
                {
                    txtClaimForwardDate.Enabled = false;
                    ImageButton1.Visible = false;
                }
                    
            }
            else
            {
               // txtClaimForwardDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString();
                 txtClaimForwardDate.Text = "__/__/____";
                 if (OrgID == 78 && RoleName == "Accounts")
                 {
                     txtClaimForwardDate.Enabled = false;
                     ImageButton1.Visible = false;
                      
                 }

            }
            //txtClaimForwardDate.Attributes.Add("onchange", "ExcedDate('" + txtClaimForwardDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtClaimForwardDate.ClientID.ToString() + "','hdnDischargedDT',1,1);");
            string sFunProcedures = "CompareDate('" + hdnDischargedDT.ClientID + "','" + txtClaimForwardDate.ClientID + "','" + hdnAdmissionDate.ClientID + "');";
            txtClaimForwardDate.Attributes.Add("onchange", sFunProcedures);
            txtClaimForwardDate.Attributes.Add("onblur", sFunProcedures);
            

            for (int i = 0; i < al.Count; i++)
            {
                prodFName = al[i].ToString();

                prodID = prodFName.Split('~')[0].ToString();

                if (tpa.PatientID == Convert.ToInt64(prodID))
                {
                    ((CheckBox)e.Row.FindControl("rdSel")).Checked = true;
                }
            }
        }

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        lblResult.Visible = false;
        try
        {
            LoadSearch();
            onSearchComplete(this, e);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnSearch_Click in Insurance Search Control", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            //Response.Redirect("../Reception/Home.aspx", true);
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
 
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            AddToViewState();

            if (e.NewPageIndex != -1)
            {
                grdResult.PageIndex = e.NewPageIndex;
                LoadSearch();
            }
        }
        catch (Exception ex)
        {
        }
    }
   
    private bool hasResult = false;
    public bool HasResult
    {
        get
        {
            return hasResult;
        }
        set
        {
            hasResult = value;
        }
    }
    void AddToViewState()
    {
        long prodID = -1;
        string prodName = string.Empty;
        string strProduct = string.Empty;

        bool blnExists = false;
        string ProductDetails = string.Empty;
        string[] hiddenIDs = new string[] { };
        ArrayList alTemp = al;

        foreach (GridViewRow row in grdResult.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkBox = (CheckBox)row.FindControl("rdSel");
                if (chkBox.Checked)
                {
                    prodID = Convert.ToInt64(grdResult.DataKeys[row.RowIndex][0].ToString());
                    prodName = grdResult.DataKeys[row.RowIndex][1].ToString();
                    strProduct = prodID.ToString() + "~" + prodName;

                    if (al.Count > 0)
                    {
                        for (int i = 0; i < al.Count; i++)
                        {
                            if (al[i].ToString() == strProduct)
                            {
                                blnExists = true;
                                break;
                            }
                        }
                        if (!blnExists)
                        {
                            alTemp.Add(strProduct);
                        }
                    }
                    else
                    {
                        alTemp.Add(strProduct);
                    }
                }
                else
                {
                    prodID = Convert.ToInt64(grdResult.DataKeys[row.RowIndex][0].ToString());
                    prodName = grdResult.DataKeys[row.RowIndex][1].ToString();
                    strProduct = prodID.ToString() + "~" + prodName;

                    if (al.Count > 0)
                    {
                        for (int i = 0; i < al.Count; i++)
                        {

                            if (al[i].ToString() == strProduct)
                            {
                                blnExists = true;
                                break;
                            }
                        }
                        if (blnExists)
                        {
                            alTemp.Remove(strProduct);
                        }
                    }
                }
            }
        }
        ViewState["SelectedProds"] = alTemp;
       
    }
    private void LoadSearch()
    {
        
        lstTPADetails = new List<TPADetails>();
        long patientID = txtPatientNo.Text == string.Empty ? 0 : Convert.ToInt64(txtPatientNo.Text);
        string PaymentStatus = ddlPaymentype.SelectedItem.Text;
        string TPAName = ddlType.SelectedItem.Text;
        long tpaID = Convert.ToInt64(ddlTpaName.SelectedItem.Value);

        DateTime fromDate = Convert.ToDateTime(txtFrom.Text);
        DateTime ToDate = Convert.ToDateTime(txtTo.Text);
        string PatienName = txtPatientName.Text;
      //  int ClientID =Convert.ToInt32(ddlClient.SelectedItem.Value);
       // int CorporateID = Convert.ToInt32(ddlCorporate.SelectedItem.Value);
        int ClientID = Convert.ToInt32(ddlCorporate.SelectedItem.Value);

        new IP_BL(base.ContextInfo).GetTPAPatient(patientID, PatienName, PaymentStatus, TPAName, tpaID, fromDate, ToDate, OrgID, ClientID, out lstTPADetails);
        if (lstTPADetails.Count > 0)
        {

            grdResult.DataSource = lstTPADetails;
            grdResult.DataBind();

            HasResult = true;
            grdResult.Columns[4].Visible = true;
            lblStatus.Visible = false;
            if (hdnTPALAB.Value == "1")
            {
                grdResult.Columns[4].Visible = false;
                grdResult.Columns[5].Visible = false;
                grdResult.Columns[7].Visible = false;
            }
        }
        else
        {
            lblStatus.Visible = true;
            grdResult.DataSource = lstTPADetails;
      
            grdResult.DataBind();
            grdResult.Columns[4].Visible = false;
        }

    }
    public string GetValue()
    {
        string str = string.Empty;
        AddToViewState();
        ArrayList alTemp = (ArrayList)ViewState["SelectedProds"];

        for (int i = 0; i < alTemp.Count; i++)
        {
            str += alTemp[i].ToString() + "^";
        }
        return str;
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

    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "PatientSearchType,PaymentType,";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

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
                                     where child.Domain == "PatientSearchType"
                                     orderby child.DisplayText ascending
                                     select child;
                    ddlType.DataSource = childItems;
                    ddlType.DataTextField = "DisplayText";
                    ddlType.DataValueField = "Code";
                    ddlType.DataBind();

                    var childItems1 = from child in lstmetadataOutput
                                      where child.Domain == "PaymentType"
                                      orderby child.DisplayText descending
                                      select child;
                    ddlPaymentype.DataSource = childItems1;
                    ddlPaymentype.DataTextField = "DisplayText";
                    ddlPaymentype.DataValueField = "Code";
                    ddlPaymentype.DataBind();
                }
            //}
        }
        catch (Exception ex)
        {
            CLogger.LogError("There was a Problem in Loading Meta Data", ex);
        }
    }
 
}
