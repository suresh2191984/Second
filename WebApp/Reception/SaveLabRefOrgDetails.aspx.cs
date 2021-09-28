using System;
using System.Data;
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
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Linq;

public partial class Reception_SaveLabRefOrgDetails : BasePage
{
    eAddType iAddressType;
    long pLabRefOrgID = -1;
    int mode = 0;

    public Reception_SaveLabRefOrgDetails()
        : base("Reception_SaveLabRefOrgDetails_aspx")
    {

    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        string strltHead = Resources.Reception_ClientDisplay.Reception_SaveLabRefOrgDetails_aspx_04 == null ? "Enter the details of new Clinic" : Resources.Reception_ClientDisplay.Reception_SaveLabRefOrgDetails_aspx_04;
        txtName.Focus();
        if (ddCountry.Items.Count <= 0)
            LoadCountry();
        try
        {
            if (Request.QueryString["mode"] != null)
            {
                Int32.TryParse(Request.QueryString["mode"], out mode);
                if (mode == 1) Panel7.Visible = false;
                ltHead.Text = strltHead;
                //ltHead.Text = "Enter the details of new Clinic";
            }
            if (!IsPostBack)
            {
                LoadReferringType();
                LoadReferringOrgType();
                LoadHospital();
                GetAddressType();
            }
           
        }
        catch (Exception ex)
        {
          CLogger.LogError("Error in SaveLabRefOrgDetails.aspx:Page_Load", ex);
        }
    }
    public void GetAddressType()
    {
        long returnCode = -1;
        try
        {
            string strddlSelect = Resources.Reception_ClientDisplay.Reception_SaveLabRefOrgDetails_aspx_03 == null ? "-----Select-----" : Resources.Reception_ClientDisplay.Reception_SaveLabRefOrgDetails_aspx_03;
            Master_BL obj = new Master_BL(base.ContextInfo);
            List<EmployerDeptMaster> lstEmpDeptMaster = new List<EmployerDeptMaster>();
            returnCode = obj.GetEmployerDeptMaster(OrgID, out lstEmpDeptMaster);
            string AddNewDepartment = string.Empty;
            if (!String.IsNullOrEmpty(ViewState["AddDepartment"].ToString()))
            {
                AddNewDepartment = ViewState["AddDepartment"].ToString();
            }
            if (lstEmpDeptMaster.Count > 0 || (!String.IsNullOrEmpty(AddNewDepartment) && AddNewDepartment.Length > 0))
            {
                if (!String.IsNullOrEmpty(AddNewDepartment) && AddNewDepartment.Length > 0)
                {
                    string[] Department = AddNewDepartment.Split('^');
                    for (int i = 0; i < Department.Length; i++)
                    {
                        if (!String.IsNullOrEmpty(Department[i]) && Department[i].Length > 0)
                        {
                            EmployerDeptMaster objEDM = new EmployerDeptMaster();
                            objEDM.EmpDeptName = Department[i].Split('~')[0];
                            objEDM.Code = Department[i].Split('~')[1];
                            lstEmpDeptMaster.Add(objEDM);
                        }
                    }
                }
                drplstPerson.DataSource = lstEmpDeptMaster;
                drplstPerson.DataValueField = "Code";
                drplstPerson.DataTextField = "EmpDeptName";
                drplstPerson.DataBind();
                drplstPerson.Items.Insert(0, strddlSelect);
                drplstPerson.Items[0].Value = "0";
            }
            //---Code End---
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured to get Despatch Mode", ex);
        }
    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        string WinAlert = Resources.Reception_AppMsg.Reception_SaveLabRefOrgDetails_aspx_05 == null ? "Alert" : Resources.Reception_AppMsg.Reception_SaveLabRefOrgDetails_aspx_05;
        string UsrMsgWin = Resources.Reception_AppMsg.Reception_SaveLabRefOrgDetails_aspx_06 == null ? "New reference organization was added successfully!" : Resources.Reception_AppMsg.Reception_SaveLabRefOrgDetails_aspx_06;
        string UsrMsgWin1 = Resources.Reception_AppMsg.Reception_SaveLabRefOrgDetails_aspx_07 == null ? "Updated successfully" : Resources.Reception_AppMsg.Reception_SaveLabRefOrgDetails_aspx_07;
        string strbtnFinish = Resources.Reception_ClientDisplay.Reception_SaveLabRefOrgDetails_aspx_01 == null ? "Save" : Resources.Reception_ClientDisplay.Reception_SaveLabRefOrgDetails_aspx_01;
        string strltHead = Resources.Reception_ClientDisplay.Reception_SaveLabRefOrgDetails_aspx_05 == null ? "Select a Clinic to edit the details or click on Add New Clinic." : Resources.Reception_ClientDisplay.Reception_SaveLabRefOrgDetails_aspx_05;
        long returnCode = -1;
        try
        {

            if (ddlHospital.SelectedValue != "0")
            {
                pLabRefOrgID = Convert.ToInt64(ddlHospital.SelectedValue);
            }
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            LabReferenceOrg LabRefOrg = new LabReferenceOrg();
            LabRefOrgAddress LabRefOrgAddress = new LabRefOrgAddress();
            LabRefOrg.RefOrgName = txtName.Text;
            LabRefOrg.OrgID = OrgID;
            LabRefOrg.Code = txtHosCode.Text;
            LabRefOrg.ClientTypeID = Convert.ToInt16(drplstReferringType.SelectedValue);
            LabRefOrg.ReferringType = ddlRefType.SelectedValue;
            LabRefOrg.IsClient = chkIsClient.Checked ? "Y" : "N";
            LabRefOrgAddress = GetLabRefOrgAddress();
			 LabRefOrg.FolderName = PathName.Text;
            if (hdnEmpID.Value != null && hdnEmpID.Value != "" && Convert.ToInt64(hdnEmpID.Value) > 0)
            {
                LabRefOrg.ContactPersonID = Convert.ToInt64(hdnEmpID.Value);
                //LabRefOrg.ContactPersonID = hdnEmpID.Value;
            }
            if (pLabRefOrgID == -1)
            {
                LabRefOrgAddress.CreatedBy = LID;
                returnCode = patientBL.SaveLabRefOrgDetailandAddress(LabRefOrg, LabRefOrgAddress);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgWin + "','" + WinAlert + "');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('New reference organization was added successfully!');", true);
            }
            else
            {
                LabRefOrg.LabRefOrgID = pLabRefOrgID;
                LabRefOrgAddress.LabRefOrgID = pLabRefOrgID;
                LabRefOrgAddress.ModifiedBy = LID;

                returnCode = patientBL.UpdateLabRefOrgDetailandAddress(LabRefOrg, LabRefOrgAddress);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgWin1 + "','" + WinAlert + "');", true);
               // ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('Updated successfully!');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm2", "onUpdatehide();", true); 

            }
            if (returnCode != 0)
            {
                //ErrorDisplay1.ShowError = true;
               // ErrorDisplay1.Status = "Error while saving Lab Reference Organization Detail and Address. Please try after some time.";
            }
            if (returnCode == 0)
            {

                LoadHospital();
                ddlHospital.SelectedIndex = 0;
                ClearFields();
                btnFinish.Text = strbtnFinish;
                //btnFinish.Text = "Save";
                lblStatus.Visible = true;
                ltHead.Text = strltHead;
               // ltHead.Text = "Select a Clinic to edit the details or click on Add New Clinic.";
                if (mode == 1) Panel7.Visible = true;
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Lab Reference Organization Detail and Address.", ex);
           // ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    public LabRefOrgAddress GetLabRefOrgAddress()
    {
        LabRefOrgAddress objAddress = new LabRefOrgAddress();
        short CountryID;
        short StateID;
        if (txtAddressID.Text != "")
        {
            objAddress.AddressID = Convert.ToInt32(txtAddressID.Text);
        }
        objAddress.Add1 = txtAddress1.Text;
        objAddress.Add2 = txtAddress2.Text;
        objAddress.Add3 = txtAddress3.Text;
        objAddress.AddressType = Convert.ToString(eAddType.PERMANENT);
        objAddress.City = txtCity.Text;
        Int16.TryParse(ddCountry.SelectedValue, out CountryID);
        Int16.TryParse(ddState.SelectedValue, out StateID);
        objAddress.CountryID = CountryID;
        objAddress.StateID = StateID;
        objAddress.PostalCode = txtPostalCode.Text;
        objAddress.MobileNumber = txtMobile.Text;
        objAddress.LandLineNumber = txtLandLine.Text;
        objAddress.AltLandLineNumber = txtAltLandLine.Text;
        objAddress.Fax = txtFax.Text;
        return objAddress;

    }
    #region Properties

    public enum eAddType
    {
        CURRENT = 1, PERMANENT = 2, ALTERNATE = 3, OFFICE = 4
    }

    public eAddType AddressType
    {
        get
        {
            return iAddressType;
        }
        set
        {
            iAddressType = value;
        }
    }
    #endregion
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Reception/SaveLabRefOrgDetails.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
    public void GetLabRefOrgAddress(long LabRefOrgID)
    {
        string strbtnFinish1 = Resources.Reception_ClientDisplay.Reception_SaveLabRefOrgDetails_aspx_02 == null ? "Update" : Resources.Reception_ClientDisplay.Reception_SaveLabRefOrgDetails_aspx_02;
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<LabRefOrgAddress> getLabRefOrgAddress = new List<LabRefOrgAddress>();
            List<LabReferenceOrg> getLabRefOrg = new List<LabReferenceOrg>();
            retCode = patBL.GetLabRefOrgDetailandAddress(LabRefOrgID, out getLabRefOrg, out getLabRefOrgAddress);
            if (retCode == 0)
            {
                btnFinish.Text = strbtnFinish1;
                //btnFinish.Text = "Update";
                foreach (LabReferenceOrg labRefOrg in getLabRefOrg)
                {
                    txtName.Text = labRefOrg.RefOrgName;
                    txtHosCode.Text = labRefOrg.Code;
                    if (!String.IsNullOrEmpty(labRefOrg.ClientTypeID.ToString()))
                        drplstReferringType.SelectedValue = labRefOrg.ClientTypeID.ToString();
                    if (!String.IsNullOrEmpty(labRefOrg.ReferringType.ToString()))
                        ddlRefType.SelectedValue = labRefOrg.ReferringType.ToString();
                    if (!String.IsNullOrEmpty(labRefOrg.ClientTypeID.ToString()))
                        hdnRefOrgType.Value = labRefOrg.ClientTypeID.ToString();                         
                    chkIsClient.Checked = labRefOrg.IsClient == "Y" ? true : false;
 					 PathName.Text = labRefOrg.FolderName;
                    hdnEmpID.Value = Convert.ToString(labRefOrg.ContactPersonID);
                    txtPersonName.Text = labRefOrg.ContactPersonName;
                    if (labRefOrg.ContactPersonTypeID != null && labRefOrg.ContactPersonTypeID != "")
                    {
                        drplstPerson.SelectedValue = labRefOrg.ContactPersonTypeID;
                        AutoCompleteExtender3.ContextKey = labRefOrg.ContactPersonTypeID;
                    }
                }
                foreach (LabRefOrgAddress labOrgAddress in getLabRefOrgAddress)
                {
                    SetLabRefOrgAddress(labOrgAddress);
                }
                btnDelete.Visible = true;
                txtName.Enabled = false;
                txtHosCode.Enabled = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading LabRefOrgAddress Details.", ex);
           // ErrorDisplay1.ShowError = true;
          //  ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    public void SetLabRefOrgAddress(LabRefOrgAddress pAddress)
    {
        //LoadCountry();
        txtAddressID.Text = pAddress.AddressID.ToString();
        txtAddress1.Text = pAddress.Add1;
        txtAddress2.Text = pAddress.Add2;
        txtAddress3.Text = pAddress.Add3;
        txtCity.Text = pAddress.City;
        ListItem Country = ddCountry.Items.FindByValue(pAddress.CountryID.ToString());

        if (Country != null)
        {
            ddCountry.SelectedValue = pAddress.CountryID.ToString();
        }
        if (ddState.Items.FindByValue(pAddress.StateID.ToString()) != null)
        {
            ddState.SelectedValue = pAddress.StateID.ToString();
        }
        txtPostalCode.Text = pAddress.PostalCode;
        txtMobile.Text = pAddress.MobileNumber;
        txtLandLine.Text = pAddress.LandLineNumber;
        txtAltLandLine.Text = pAddress.AltLandLineNumber;
        txtFax.Text = pAddress.Fax;
    }
    public void LoadHospital()
    {
        string strddlHospital = Resources.Reception_ClientDisplay.Reception_SaveLabRefOrgDetails_aspx_03 == null ? "-----Select-----" : Resources.Reception_ClientDisplay.Reception_SaveLabRefOrgDetails_aspx_03;
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<LabReferenceOrg> getHospital = new List<LabReferenceOrg>();
            retCode = patBL.GetLabRefOrg(OrgID, 0,"D", out getHospital);
            if (retCode == 0)
            {
                ddlHospital.DataSource = getHospital;
                ddlHospital.DataTextField = "RefOrgName";
                ddlHospital.DataValueField = "LabRefOrgID";
                ddlHospital.DataBind();
                ddlHospital.Items.Insert(0, strddlHospital);
                //ddlHospital.Items.Insert(0, "-----Select-----");
                ddlHospital.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Hospital Details.", ex);
           // ErrorDisplay1.ShowError = true;
          //  ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void ddlHospital_SelectedIndexChanged(object sender, EventArgs e)
    {
        string strltHead = Resources.Reception_ClientDisplay.Reception_SaveLabRefOrgDetails_aspx_05 == null ? "Select a Clinic to edit the details or click on Add New Clinic." : Resources.Reception_ClientDisplay.Reception_SaveLabRefOrgDetails_aspx_05;
        string strbtnFinish = Resources.Reception_ClientDisplay.Reception_SaveLabRefOrgDetails_aspx_01 == null ? "Save" : Resources.Reception_ClientDisplay.Reception_SaveLabRefOrgDetails_aspx_01;
        lblStatus.Visible = false;
        ltHead.Text = strltHead;
        //ltHead.Text = "Select a Clinic to edit the details or click on Add New Clinic.";
        Panel7.Visible = true;
        pLabRefOrgID = Convert.ToInt64(ddlHospital.SelectedValue);
        ddlRefType.SelectedValue = "0";
        if (ddlHospital.SelectedValue == "0")
        {
            ClearFields();
            btnFinish.Text = strbtnFinish;
           // btnFinish.Text = "Save";
            btnDelete.Visible = false;           

        }
        else
        {
            GetLabRefOrgAddress(pLabRefOrgID);
        }
    }
    public void ClearFields()
    {
        txtName.Text = ""; txtHosCode.Text = ""; drplstReferringType.SelectedValue = "0"; txtAddress1.Text = ""; txtAddress2.Text = "";
        txtAddress3.Text = ""; txtCity.Text = "";txtPostalCode.Text="";txtLandLine.Text=""; txtMobile.Text="";
        txtAltLandLine.Text = ""; txtFax.Text = ""; chkIsClient.Checked = false; LoadCountry(); ddlRefType.SelectedValue = "0";
        txtPersonName.Text = ""; hdnEmpID.Value = "0"; drplstPerson.SelectedValue = "0";
		 PathName.Text = "";
    }
    protected void addNewHospital_Click(object sender, EventArgs e)
    {
        Response.Redirect("SaveLabRefOrgDetails.aspx?mode=1",true);
    }


    protected void btnDelete_Click(object sender, EventArgs e)
    {
        string strbtnFinish = Resources.Reception_ClientDisplay.Reception_SaveLabRefOrgDetails_aspx_01 == null ? "Save" : Resources.Reception_ClientDisplay.Reception_SaveLabRefOrgDetails_aspx_01;
        string strltHead = Resources.Reception_ClientDisplay.Reception_SaveLabRefOrgDetails_aspx_05 == null ? "Select a Clinic to edit the details or click on Add New Clinic." : Resources.Reception_ClientDisplay.Reception_SaveLabRefOrgDetails_aspx_05;
        long returnCode = -1;
        try
        {

            if (ddlHospital.SelectedValue != "0")
            {
                pLabRefOrgID = Convert.ToInt64(ddlHospital.SelectedValue);
            }
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            LabReferenceOrg LabRefOrg = new LabReferenceOrg();
            LabRefOrgAddress LabRefOrgAddress = new LabRefOrgAddress();
            LabRefOrg.RefOrgName = txtName.Text;

            LabRefOrg.OrgID = OrgID;
            LabRefOrg.ClientTypeID = Convert.ToInt16(hdnRefOrgType.Value);
            //LabRefOrgAddress = RefOrgAddressCtrl.GetLabRefOrgAddress();
            if (pLabRefOrgID == -1)
            {
                LabRefOrgAddress.CreatedBy = LID;
                returnCode = patientBL.SaveLabRefOrgDetailandAddress(LabRefOrg, LabRefOrgAddress);
            }
            else
            {
                LabRefOrg.LabRefOrgID = pLabRefOrgID;
                LabRefOrg.Status = "D";
                LabRefOrgAddress.LabRefOrgID = pLabRefOrgID;
                LabRefOrgAddress.ModifiedBy = LID;
                returnCode = patientBL.UpdateLabRefOrgDetailandAddress(LabRefOrg, LabRefOrgAddress);
            }

            if (returnCode != 0)
            {
              //  ErrorDisplay1.ShowError = true;
               // ErrorDisplay1.Status = "Error while Updating Lab Reference Organization Detail and Address. Please try after some time.";
            }
            if (returnCode == 0)
            {
                LoadHospital();
                ddlHospital.SelectedIndex = 0;
                txtName.Text = "";
                ClearFields();
                btnFinish.Text = strbtnFinish;
               //btnFinish.Text = "Save";
                //RefOrgAddressCtrl.clearAddress();
                lblStatus.Visible = true;
                ltHead.Text = strltHead;
                //ltHead.Text = "Select a Clinic to edit the details or click on Add New Clinic.";
                if (mode == 1) Panel7.Visible = true;
                lblStatus.Text = "Reference Organization Removed Successfully!";
                btnDelete.Visible = false;
                txtName.Enabled = true;
                txtHosCode.Enabled = true;
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Updating Lab Reference Organization Detail and Address.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void ddCountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        //if (ddCountry.SelectedIndex > 0)
        //{

        LoadState(Convert.ToInt32(ddCountry.SelectedValue));
        ViewState["Country"] = ddCountry.SelectedItem.Value.ToString();

        //}
    }
    protected void LoadState(int countryID)
    {
        List<State> states = new List<State>();
        State_BL stateBL = new State_BL(base.ContextInfo);
        State selectedState = new State();
        long returnCode = -1;
        ddState.Items.Clear();
        int stateID = 0;
        try
        {

            returnCode = stateBL.GetStateByCountry(countryID, out states);
            //Commanded By Shajahan:

            //ddState.DataSource = states;
            //ddState.DataTextField = "StateName";
            //ddState.DataValueField = "StateID";
            //ddState.DataBind();
            foreach (State st in states)
            {
                ddState.Items.Add(new ListItem(st.StateName.ToUpper(), st.StateID.ToString()));
            }

            selectedState = states.Find(FindState);
            ddState.SelectedValue = selectedState.StateID.ToString();
            Int32.TryParse(ddState.SelectedItem.Value, out stateID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Sate", ex);
        }
        finally
        {
        }
    }
    protected void LoadCountry()
    {
        long returnCode = -1;
        Country_BL countryBL = new Country_BL(base.ContextInfo);
        List<Country> countries = new List<Country>();
        Country selectedCountry = new Country();
        ddCountry.Items.Clear();
        int countryID = 0;
        try
        {
            returnCode = countryBL.GetCountryList(out countries);
            ddCountry.DataSource = countries;
            ddCountry.DataTextField = "CountryName";
            ddCountry.DataValueField = "CountryID";
            ddCountry.DataBind();
            selectedCountry = countries.Find(FindCountry);
            ddCountry.SelectedValue = selectedCountry.CountryID.ToString();
            Int32.TryParse(ddCountry.SelectedItem.Value, out countryID);
            LoadState(countryID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Country", ex);
        }
        finally
        {
        }
    }
    static bool FindCountry(Country c)
    {
        if (c.IsDefault != null && c.IsDefault == "Y")
        {
            return true;
        }
        return false;
    }

    static bool FindState(State s)
    {
        if (s.IsDefault != null && s.IsDefault == "Y")
        {
            return true;
        }
        return false;
    }

    public void LoadReferringType()
    {  
        try
        {
            long returncode = -1;
            string domains = "ReferringType,Department";
            string[] Tempdata = domains.Split(',');
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            MetaData objMeta;
            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping (lstmetadataInput,OrgID,LanguageCode , out lstmetadataOutput);
            if (returncode == 0)
            {
                if (lstmetadataOutput.Count > 0)
                {
                    var childItems = from child in lstmetadataOutput
                                     where child.Domain == "ReferringType"
                                     orderby child.MetaDataID ascending
                                     select child;
                    drplstReferringType.DataSource = childItems;
                    drplstReferringType.DataTextField = "DisplayText";
                    drplstReferringType.DataValueField = "Code";
                    drplstReferringType.SelectedValue = "0";
                    drplstReferringType.DataBind();

                    var childItems2 = from child in lstmetadataOutput
                                      where child.Domain == "Department"
                                      orderby child.MetaDataID ascending
                                      select child;
                    string temp = string.Empty;
                    foreach (var child in childItems2)
                    {
                        temp += child.DisplayText + "~" + child.Code + "^";
                    }
                    if (!String.IsNullOrEmpty(temp) && temp.Length > 0)
                    {
                        hdnAddDepart.Value = temp;
                        ViewState.Add("AddDepartment", temp);
                    }

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading ReferringType in RadioButtonList in InvoiceMaster.aspx.cs", ex);
        }
    }

    public void LoadReferringOrgType()
    {
        try
        {
            long returncode = -1;
            string domains = "ReferringOrgType,";
            string[] Tempdata = domains.Split(',');
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            MetaData objMeta;
            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping (lstmetadataInput,OrgID,LanguageCode , out lstmetadataOutput);
            if (returncode == 0)
            {
                if (lstmetadataOutput.Count > 0)
                {
                    var childItems = from child in lstmetadataOutput
                                     where child.Domain == "ReferringOrgType"
                                     orderby child.MetaDataID ascending
                                     select child;
                    ddlRefType.DataSource = childItems;
                    ddlRefType.DataTextField = "DisplayText";
                    ddlRefType.DataValueField = "Code";
                    ddlRefType.SelectedValue = "0";
                    ddlRefType.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading ReferringOrgType SaveLabRefOrgDetails.aspx.cs", ex);
        }
    }


}
