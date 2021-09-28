using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Podium.NewInstanceCreation;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Configuration;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;
using System.Xml.Linq;
using System.Drawing.Design;

public partial class NewInstanceCreation_NewInstanceCreation : BasePage
{
    string strddlOrgName = Resources.NewInstanceCreation_ClientDisplay.NewInstanceCreation_NewInstanceCreation_aspx_01 == null ? "--Select--" : Resources.NewInstanceCreation_ClientDisplay.NewInstanceCreation_NewInstanceCreation_aspx_01;
    public NewInstanceCreation_NewInstanceCreation()
        : base("NewInstanceCreation_NewInstanceCreation_aspx")
    {
    }
    long returnCode = -1;
    int pDefaultOrgID = -1;
    long pDefaultOrgAddID = -1;
    long pCurrencyID = -1;
    int BaseCurrencyID = -1;
    string BaseCurrencyCode = string.Empty;
    long returncode1 = -1;

    List<Role> lstRole = new List<Role>();
    List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
    List<Organization> lstOrganization = new List<Organization>();
    List<NewInstanceCreationTracker> lstNICT = new List<NewInstanceCreationTracker>();
    List<OrganizationAddress> lstOrgLocation = new List<OrganizationAddress>();
    List<CurrencyOrgMapping> lstCurrOrgMap = new List<CurrencyOrgMapping>();
    List<Department> lstDep = new List<Department>();
    string jqueryTask = string.Empty;
    string finish = Resources.NewInstanceCreation_AppMsg.NewInstanceCreation_NewInstanceCreation_aspx_finish == null ? "Finish" : Resources.NewInstanceCreation_AppMsg.NewInstanceCreation_NewInstanceCreation_aspx_finish;
    string strpage = Resources.NewInstanceCreation_AppMsg.NewInstanceCreation_NewInstancecreation_aspx_19 == null ? "Page" : Resources.NewInstanceCreation_AppMsg.NewInstanceCreation_NewInstancecreation_aspx_19;
    string strof = Resources.NewInstanceCreation_AppMsg.NewInstanceCreation_NewInstancecreation_aspx_20 == null ? "Of" : Resources.NewInstanceCreation_AppMsg.NewInstanceCreation_NewInstancecreation_aspx_20;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            divCreateNewInstance.Attributes.Add("style", "block");
            btnFinish.Enabled = true;
            btnupdate.Visible=false;

            bind();
            ddlOrgName.Enabled = true;
        }
        jqueryTask = GetConfigValue("IsNeedJqueryTask", OrgID);
        BindCreatedOrg();
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {
        string WinAlert = Resources.NewInstanceCreation_AppMsg.NewInstanceCreation_NewInstanceCreation_aspx_14 == null ? "Alert" : Resources.NewInstanceCreation_AppMsg.NewInstanceCreation_NewInstanceCreation_aspx_14;
        string UsrMsgWin = Resources.NewInstanceCreation_AppMsg.NewInstanceCreation_NewInstanceCreation_aspx_15 == null ? "Organization Name already Exists." : Resources.NewInstanceCreation_AppMsg.NewInstanceCreation_NewInstanceCreation_aspx_15;
        pDefaultOrgID = Convert.ToInt32(ddlOrgName.SelectedValue);
        pCurrencyID = Convert.ToInt64(ddlBaseCurrency.SelectedValue);
        pDefaultOrgAddID = ILocationID;
        btnFinish.Enabled = false;
        btnFinish.Visible = false;

        int retStatus = -1;
        string pathname = "../Images/Logo/";

        try
        {


            string PictureName = Path.GetFileNameWithoutExtension(FileUpload1.FileName);
            string fileExtension = Path.GetExtension(FileUpload1.FileName);

            string fileName = Path.GetFileName(FileUpload1.FileName);

            if (FileUpload1.HasFile)
            {
                FileUpload1.SaveAs(Server.MapPath("../Images/Logo/") + fileName);
                   
            }

            string filePath = pathname + PictureName + fileExtension;

            if (!String.IsNullOrEmpty(PictureName) && PictureName.Length > 0)
            {
                hdnLogoPath.Value = filePath;

            }


            if (btnFinish.Text == finish)
            {
                long lngCheckName = new NewInstance(base.ContextInfo).pCheckOrganizationName(txtOrgName.Text, out retStatus);
                if (retStatus == 1)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgWin + "','" + WinAlert + "');", true);
                   // ScriptManager.RegisterStartupScript(Page, this.GetType(), "Duplicate Org. Name", "alert('Organization Name already Exists.');", true);
                    btnFinish.Enabled = true;
                    btnFinish.Visible = true;
                    return;
                }
            }
            #region OrgDetails

            Organization org = new Organization();
            org.OrgID = pDefaultOrgID;
            //org.AddressID = pDefaultOrgAddID;
            org.Name = txtOrgName.Text;
            org.OrgDisplayName = txtdisplayname.Text;
            org.Location = txtLocation.Text;
            org.OrganizationTypeID = 1;
            org.LogoPath = hdnLogoPath.Value;
            TextBox txtAdd1 = (TextBox)ucPAdd.FindControl("txtAddress1");
            TextBox txtAdd2 = (TextBox)ucPAdd.FindControl("txtAddress2");
            TextBox txtAdd3 = (TextBox)ucPAdd.FindControl("txtAddress3");
            TextBox txtCity = (TextBox)ucPAdd.FindControl("txtCity");
            DropDownList ddlCountry = (DropDownList)ucPAdd.FindControl("ddCountry");
            DropDownList ddlState = (DropDownList)ucPAdd.FindControl("ddState");
            TextBox txtPostalCode = (TextBox)ucPAdd.FindControl("txtPostalCode");
            TextBox txtmno = (TextBox)ucPAdd.FindControl("txtMobile");
            TextBox txtllno = (TextBox)ucPAdd.FindControl("txtLandLine");
            TextBox txtOtherCountry = (TextBox)ucPAdd.FindControl("txtOtherCountry");
            TextBox txtOtherState = (TextBox)ucPAdd.FindControl("txtOtherState");
            org.Add1 = txtAdd1.Text;
            org.Add2 = txtAdd2.Text;
            org.Add3 = txtAdd3.Text;
            org.PostalCode = txtPostalCode.Text;
            org.City = txtCity.Text;
            org.PhoneNumber = txtmno.Text;
            org.LandLineNumber = txtllno.Text;
            org.CountryID = Convert.ToInt32(ddlCountry.SelectedValue);
            org.StateID = Convert.ToInt32(ddlState.SelectedValue);
            org.StartDTTM = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            org.EndDTTM = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            org.OtherCountryName = txtdisplayname.Text;
            org.OtherStateName = txtOtherState.Text; 
            //for is default org check
            if (chkbaseorgselect.Checked == true)
            {
                org.Isdefaultorg = "Y";
            }
            else
            {
                org.Isdefaultorg = "N";                
            } 
            if (ddlreplang.SelectedValue != "0")
                org.ReportLanguage = ddlreplang.SelectedItem.Value;
            else
                org.ReportLanguage = "en-GB"; 

            org.DefaultOrgID = Convert.ToInt32(ddlOrgName.SelectedValue);
            lstOrganization.Add(org);
            #endregion

            foreach (ListItem lst in chkRoles.Items)
            {
                if (lst.Text.ToLower() != "administrator")
                {
                    if (lst.Selected)
                    {
                        Role r = new Role();
                        r.RoleID = Convert.ToInt32(lst.Value);
                        r.RoleName = lst.Text;
                        r.Description = lst.Text;
                        r.OrgID = pDefaultOrgID;
                        r.OrgAddressID = pDefaultOrgAddID;
                        lstRole.Add(r);
                    }
                }
                else
                {
                    Role r = new Role();
                    r.RoleID = Convert.ToInt32(lst.Value);
                    r.RoleName = lst.Text;
                    r.Description = lst.Text;
                    r.OrgID = pDefaultOrgID;
                    r.OrgAddressID = pDefaultOrgAddID;
                    lstRole.Add(r);
                }
            }

            foreach (ListItem lst in chkVisitPurpose.Items)
            {
                if (lst.Selected)
                {
                    VisitPurpose r = new VisitPurpose();
                    r.VisitPurposeID = Convert.ToInt32(lst.Value);
                    r.VisitPurposeName = lst.Text;
                    r.OrgID = pDefaultOrgID;
                    r.OrgAddressID = pDefaultOrgAddID;
                    lstVisitPurpose.Add(r);
                }
            }
            foreach(ListItem lstdept in chkDeptlist.Items)
            {
                if(lstdept.Selected)
                {
                    Department depart = new Department();
                    depart.DeptID = Convert.ToInt32(lstdept.Value);
                    depart.DeptName = lstdept.Text;
                    depart.OrgID = pDefaultOrgID;
                    depart.OrgAddressID = pDefaultOrgAddID;
                    lstDep.Add(depart);
                }

            }
            string EncryptedString = string.Empty;
            Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetEncryptor();
            obj.Crypt("abc123", out EncryptedString);
            int pOldInsID = 0;
            if (hdnInstanceID.Value != "")
            {
                pOldInsID = Convert.ToInt32(hdnInstanceID.Value);
            }

            string AliceType = String.Empty;


            
            returnCode = new NewInstance(base.ContextInfo).CreateOrgInstanceQueue(txtOrgName.Text, lstOrganization, lstRole, lstVisitPurpose,lstDep,out retStatus, EncryptedString, pCurrencyID, AliceType, pOldInsID);
            
        }
        catch (Exception ex)
        {
            btnFinish.Enabled = true;
            btnFinish.Visible = true;

            CLogger.LogError("Error in Creating New Instance", ex);
        }
        if (retStatus == 0)
        {
            try
            {
                #region Reset Entered Data

                //txtOrgName.Text = string.Empty;
                txtLocation.Text = string.Empty;
                TextBox txtAdd1 = (TextBox)ucPAdd.FindControl("txtAddress2");
                TextBox txtAdd2 = (TextBox)ucPAdd.FindControl("txtAddress1");
                TextBox txtAdd3 = (TextBox)ucPAdd.FindControl("txtAddress3");
                TextBox txtCity = (TextBox)ucPAdd.FindControl("txtCity");
                DropDownList ddlCountry = (DropDownList)ucPAdd.FindControl("ddCountry");
                DropDownList ddlState = (DropDownList)ucPAdd.FindControl("ddState");
                TextBox txtPostalCode = (TextBox)ucPAdd.FindControl("txtPostalCode");
                TextBox txtmno = (TextBox)ucPAdd.FindControl("txtMobile");
                TextBox txtllno = (TextBox)ucPAdd.FindControl("txtLandLine");
                TextBox txtOtherCountry = (TextBox)ucPAdd.FindControl("txtOtherCountry");
                TextBox txtOtherState = (TextBox)ucPAdd.FindControl("txtOtherState");
                txtAdd1.Text = string.Empty;
                txtAdd2.Text = string.Empty;
                txtAdd3.Text = string.Empty;
                txtPostalCode.Text = string.Empty;
                txtCity.Text = string.Empty;
                txtmno.Text = string.Empty;
                txtllno.Text = string.Empty;
                txtOtherCountry.Text  = txtOtherCountry.Text;
                txtOtherState.Text  = txtOtherState.Text;
                txtdisplayname.Text = string.Empty;
                hdnInstanceID.Value = "";
                btnFinish.Enabled = true;
                btnFinish.Visible = true;
                ddlBaseCurrency.SelectedValue = "0";
                ddlCountry.SelectedIndex = -1;
                ddlState.SelectedIndex = -1;
                ddlOrgName.SelectedValue = "0";
                imglogo.Visible = false;
                //btnFinish.Text = "Finish";
                btnFinish.Text = finish;
                s1role.Visible = false;
                s2Purpose.Visible = false;
                lbldept.Visible = false;
                chkRolesAll.Visible = false;
                chkVisitAll.Visible = false;
                chkDeptAll.Visible = false;
                chkRoles.Visible = false;
                chkVisitPurpose.Visible = false;
                chkDeptlist.Visible = false;
                chkbaseorgselect.Checked = false;

                #endregion

                string pUserName = string.Empty;
                string pPassword = string.Empty;
                string pOrgName = string.Empty;
                long pReturnStatus = -1;
                returnCode = new NewInstance(base.ContextInfo).CreateatedOrgInstanceDetail(out lstNICT, out pReturnStatus);
                if (jqueryTask == "Y")
                {
                    if (lstNICT.Count  > 0)
                    {
                        hdnlogname.Value = Convert.ToString(lstNICT[0].DefaultLoginName);
                        hdnlogpwd.Value = "abc123";
                    }
                    grdCreatedOrgs.Visible = false;
                    GrdFooter.Visible = false;
                }
                else
                {
                if (lstNICT.Count > 0)
                {
                    divCreatedOrg.Attributes.Add("style", "block");
                    grdCreatedOrgs.Visible = true;

                    grdCreatedOrgs.DataSource = lstNICT;
                    grdCreatedOrgs.DataBind();
                    hdnlogname.Value = Convert.ToString(lstNICT[0].DefaultLoginName);
                    hdnlogpwd.Value = "abc123";
                }
                else
                {
                    divCreatedOrg.Attributes.Add("style", "none");
                    grdCreatedOrgs.Visible = false;
                }

                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Retrieving Created Org", ex);
            }
            if (returnCode >= 0)
            {
                HttpContext.Current.Cache.Remove("ConfigData");
                HttpContext.Current.Cache.Remove("BillConfigData");
                HttpContext.Current.Cache.Remove("CachePageDetails");
                HttpContext.Current.Cache.Remove("MetaDataCacheLIS");
                HttpContext.Current.Cache.Remove("LandingPageCatch");
                HttpContext.Current.Cache.Remove("ActionCacheFile");
                HttpContext.Current.Cache.Remove("MenuCacheNewFile");
                HttpContext.Current.Cache.Remove("ResourceCache");
                HttpContext.Current.Cache.Remove("ThemeCache");
                HttpContext.Current.Cache.Remove("CacheFile");
                HttpContext.Current.Cache.Remove("InventoryConfigData");
                HttpContext.Current.Cache.Remove("MetaDataCacheFile");
                

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "javascript:ShowAlertMsg();", true);
                // bind();
                ddlOrgName.Items[0].Value = "0";
                ddlBaseCurrency.Items[0].Value = "0";
                hidecontrol();
            }
        }
    }

    protected void grdCreatedOrgs_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        Label lblStatus = (Label)e.Row.FindControl("lblStatus");
        LinkButton btEdit = (LinkButton)e.Row.FindControl("btEdit");
        Label lblPwd = (Label)e.Row.FindControl("lblPassword");
        Label lblcurrency = (Label)e.Row.FindControl("CurrencyID");
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            lblPageStart.Text = strpage;
            lblGrdvwtotpage.Text = (grdCreatedOrgs.PageIndex + 1).ToString();
            lblendPage.Text = strof;
            lblGrdToOF.Text = grdCreatedOrgs.PageCount.ToString();
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if ((((NewInstanceCreationTracker)e.Row.DataItem).DefaultPassword).ToString() != null)
            {
                if ((((NewInstanceCreationTracker)e.Row.DataItem).DefaultLoginName) == null || (((NewInstanceCreationTracker)e.Row.DataItem).DefaultLoginName) == "")
                {
                    lblPwd.Text = "";
                }
                else
                {
                    lblPwd.Text = "abc123";//DecryptedString((((NewInstanceCreationTracker)e.Row.DataItem).DefaultPassword).ToString());
                }
            }
            else
            {
                lblPwd.Text = "abc123";
            }

            if ((((NewInstanceCreationTracker)e.Row.DataItem).CompletedAt).ToString() == "01/01/0001 00:00:00")
            {
                e.Row.Cells[5].Text = "";

                e.Row.Style.Add("font-weight", "bold");
                e.Row.Style.Add("color", "Black");

            }
            if (btEdit != null)
            {
                if (lblStatus.Text == "COMPLETED")
                {
                    btEdit.Visible = true;

                }
                else
                {
                    btEdit.Visible = false;

                }
            }
        }
       
    }

    public void BindCreatedOrg()
    {
        long pReturnStatus = -1;
        if (jqueryTask == "Y")
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CreateatedOrgInstanceDetail", "CreateatedOrgInstanceDetail('" + OrgID + "');", true);
            grdCreatedOrgs.Visible = false;
            GrdFooter.Visible = false;
        }
        else
        {
        returnCode = new NewInstance(base.ContextInfo).CreateatedOrgInstanceDetail(out lstNICT, out pReturnStatus);
        if (lstNICT.Count > 0)
        {
            divCreatedOrg.Attributes.Add("style", "block");
            grdCreatedOrgs.Visible = true;

            //lblNewOrg.Text = "The Organization named <b>" + pOrgName.ToString() + "</b> has been created. <br /> Following are the Default User Details";

            grdCreatedOrgs.DataSource = lstNICT;
            grdCreatedOrgs.DataBind();
            GrdFooter.Style.Add("Display","table-row");
        }
        else
        {
            divCreatedOrg.Attributes.Add("style", "none");
            grdCreatedOrgs.Visible = false;

            }
        }
    }


    private string DecryptedString(string strDecript)
    {
        string strDecryptedString = "abc123";
        try
        {
            Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetDecryptor();
            obj.Crypt(strDecript, out strDecryptedString);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in NewInstanceCreation.aspx.cs_DecryptedString() Method", ex);
            strDecryptedString = strDecript;
        }
        return strDecryptedString;
    }
    public void bind()
    {

        long returnvalue = -1;
        Master_BL BL = new Master_BL();
        AdminReports_BL adminbl = new AdminReports_BL();
        List<Organization> lstOrganization = new List<Organization>();
	List<Organization> lstOrganization1 = new List<Organization>();
        returnvalue = adminbl.pGetOrgLoction(out lstOrganization);
	lstOrganization1 = (from s in lstOrganization
                           where s.OrgID == OrgID
                           select s).ToList();
        if (lstOrganization.Count > 0)
        {
            ddlOrgName.DataSource = lstOrganization1;
            ddlOrgName.DataTextField = "Name";
            ddlOrgName.DataValueField = "OrgID";
            ddlOrgName.DataBind();
           ddlOrgName.Items.Insert(0, strddlOrgName);
           // ddlOrgName.Items.Insert(0, "--Select--");
            ddlOrgName.Items[0].Value = "0";

        }
        List<CurrencyMaster> lstCurrencyMaster = new List<CurrencyMaster>();

        returnvalue = BL.GetCurrencyForOrg(OrgID, out BaseCurrencyID, out BaseCurrencyCode, out lstCurrencyMaster);
        if (lstCurrencyMaster.Count > 0)
        {
            ddlBaseCurrency.DataSource = lstCurrencyMaster;
            ddlBaseCurrency.DataTextField = "CurrencyName";
            ddlBaseCurrency.DataValueField = "CurrencyID";
            ddlBaseCurrency.DataBind();
            //ddlOrgName.Items.Insert(0, strddlOrgName);
            //ddlBaseCurrency.Items.Insert(0, "--Select--");
            //ddlBaseCurrency.Items[0].Value = "0";
            ListItem li = new ListItem();
            li.Text = strddlOrgName;
            li.Value = "0";
            ddlBaseCurrency.Items.Add(li);
            ddlBaseCurrency.SelectedValue = "0";
        }
        ddlreplang.Items.Insert(0, "Select");
        ddlreplang.Items[0].Value = "0";

    }

    protected void ddlOrgName_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlOrgName.SelectedValue.ToString() != "0")
        {
            pDefaultOrgID = Convert.ToInt32(ddlOrgName.SelectedValue);

        if (pDefaultOrgID > 0)
        {
            returnCode = new Role_BL(base.ContextInfo).GetRoleName(pDefaultOrgID, out lstRole);

            if (lstRole.Count > 0)
            {
                chkRoles.DataSource = lstRole;
                chkRoles.DataTextField = "RoleName";
                chkRoles.DataValueField = "RoleID";
                chkRoles.DataBind();
                chkRoles.Visible = true;
                chkRolesAll.Visible = true;
                s1role.Visible = true;
                lblroleall.Visible = true;
            }
            else
            {
                chkRoles.Visible = false;
                chkRolesAll.Visible = false;
                s1role.Visible = false;
                lblroleall.Visible = false;
            }

            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitPurposes(pDefaultOrgID, out lstVisitPurpose);


            if (lstVisitPurpose.Count > 0)
            {
                chkVisitPurpose.DataSource = lstVisitPurpose;
                chkVisitPurpose.DataTextField = "VisitPurposeName";
                chkVisitPurpose.DataValueField = "VisitPurposeID";
                chkVisitPurpose.DataBind();
                chkVisitPurpose.Visible = true;
                chkVisitAll.Visible = true;
                s2Purpose.Visible = true;
                lblvisitall.Visible = true;
            }
            else
            {
                chkVisitPurpose.Visible = false;
                chkVisitAll.Visible = false;
                s2Purpose.Visible = false;
                lblvisitall.Visible = false;
            }

            returncode1 = new Role_BL(base.ContextInfo).GetDepartment(pDefaultOrgID, out lstDep);
            if (lstDep.Count > 0)
            {
                chkDeptlist.DataSource = lstDep;
                chkDeptlist.DataTextField = "DeptName";
                chkDeptlist.DataValueField = "DeptID";
                chkDeptlist.DataBind();
                chkDeptlist.Visible = true;
                chkDeptAll.Visible = true;
                lbldept.Visible = true;
                lbldeptall.Visible = true;
            }
            else 
            {
                chkDeptlist.Visible = false;
                chkDeptAll.Visible = false;
                lbldept.Visible = false;
                lbldeptall.Visible = false;
            }
           long returncode = -1;
           string domains = "ReportLanguage";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            // string LangCode = string.Empty;
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, pDefaultOrgID, LangCode, out lstmetadataOutput);
           if (lstmetadataOutput.Count > 0)
            {

                ddlreplang.DataSource = lstmetadataOutput;
                ddlreplang.DataTextField = "DisplayText";
                ddlreplang.DataValueField = "Code";
                ddlreplang.DataBind();
                ddlreplang.Items.Insert(0, "Select");
                ddlreplang.Items[0].Value = "0";
            }
        }
        else
        {
            chkRoles.Visible = false;
            chkVisitPurpose.Visible = false;
            chkDeptlist.Visible = false;
            chkRolesAll.Visible = false;
            chkDeptAll.Visible = false;
            chkVisitAll.Visible = false;
            s1role.Visible = false;
            s2Purpose.Visible = false;
            lbldept.Visible = false;
            lblroleall.Visible = false;
            lblvisitall.Visible = false;
            lbldeptall.Visible = false;            
        }
        }
        else
        {
           // string WinAlert = Resources.NewInstanceCreation_AppMsg.NewInstanceCreation_NewInstanceCreation_aspx_14 == null ? "Alert" : Resources.NewInstanceCreation_AppMsg.NewInstanceCreation_NewInstanceCreation_aspx_14;
           // ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + "Select Any One Default Organization.." + "','" + WinAlert + "');", true);
            chkRoles.Visible = false;
            chkRoles.Visible = false;
            chkRolesAll.Visible = false;
            s1role.Visible = false;
            lblroleall.Visible = false;
            chkVisitPurpose.Visible = false;
            chkVisitAll.Visible = false;
            s2Purpose.Visible = false;
            lblvisitall.Visible = false;
            chkDeptlist.Visible = false;
            chkDeptAll.Visible = false;
            lbldept.Visible = false;
            lbldeptall.Visible = false;
            chkVisitPurpose.Visible = false;
            chkDeptlist.Visible = false;
            chkRolesAll.Visible = false;
            chkDeptAll.Visible = false;
            chkVisitAll.Visible = false;
            s1role.Visible = false;
            s2Purpose.Visible = false;
            lbldept.Visible = false;
            lblroleall.Visible = false;
            lblvisitall.Visible = false;
            lbldeptall.Visible = false;
        }
    }

    protected void grdCreatedOrgs_RowCommand(object sender, GridViewCommandEventArgs e)
    {
      //  string finish = Resources.NewInstanceCreation_AppMsg.Newinstancecreation_Newinstancecreation_aspx_finish == null ? "Edit" : Resources.NewInstanceCreation_AppMsg.Newinstancecreation_Newinstancecreation_aspx_finish;
        string Edit = Resources.NewInstanceCreation_AppMsg.NewInstanceCreation_NewInstanceCreation_aspx_edit == null ? "Edit" : Resources.NewInstanceCreation_AppMsg.NewInstanceCreation_NewInstanceCreation_aspx_edit;
        string WinAlert = Resources.NewInstanceCreation_AppMsg.NewInstanceCreation_NewInstanceCreation_aspx_14 == null ? "Alert" : Resources.NewInstanceCreation_AppMsg.NewInstanceCreation_NewInstanceCreation_aspx_14;
        //string Editcmd = e.CommandName.ToString();
        List<OrgUsers> lstOrgUsers = new List<OrgUsers>();
        List<NewInstanceWaitingCustomers> lstloc = new List<NewInstanceWaitingCustomers>();
        List<CurrencyMaster> lstCurrencyMaster = new List<CurrencyMaster>();
        List<NewInstanceCreationTracker> lstNICT  = new List<NewInstanceCreationTracker>();
        Master_BL BLC = new Master_BL();
        try
        {
            Int32 rowIndex = Convert.ToInt32(e.CommandArgument);
            string Name = grdCreatedOrgs.DataKeys[rowIndex]["Name"].ToString();
            string Location = grdCreatedOrgs.DataKeys[rowIndex]["Location"].ToString();
            string Isdefaultorg =grdCreatedOrgs.DataKeys[rowIndex]["Isdefaultorg"]   == null ? "" : grdCreatedOrgs.DataKeys[rowIndex]["Isdefaultorg"].ToString();
            Int32 DefaultOrgID = Convert.ToInt32(grdCreatedOrgs.DataKeys[rowIndex]["DefaultOrgID"]);
            Int32 InstanceID = Convert.ToInt32(grdCreatedOrgs.DataKeys[rowIndex]["InstanceID"]);
            string Logo = grdCreatedOrgs.DataKeys[rowIndex]["LogoPath"].ToString();
            string DisplayName = grdCreatedOrgs.DataKeys[rowIndex]["DisplayName"].ToString();
            Int32 CurrencyID = Convert.ToInt32(grdCreatedOrgs.DataKeys[rowIndex]["CurrencyID"]);


            if (e.CommandName == "Edit")
            {
                //hdnOrgName.Value = "";
                long returnCode = -1;
                AdminReports_BL adminbl = new AdminReports_BL();
                long pReturnStatus = -1;
                txtOrgName.Text = Name;
                txtLocation.Text = Location;
                if(Isdefaultorg=="Y")
                {
                    chkbaseorgselect.Checked = true;
                }
                else
                {
                    chkbaseorgselect.Checked = false;
                    
                }
                txtdisplayname.Text = DisplayName;
                hdnInstanceID.Value = InstanceID.ToString();
                //hdnOrgName.Value = Name;
                //btnFinish.Text = "update";
                //btnupdate.Visible = true;
                btnupdate.Attributes.Add("style","display:");
                btnFinish.Visible = false;
                //pOldOrgName = hdnOrgName.Value;
                ddlOrgName.Enabled = false;
                txtOrgName.Enabled = false;
                txtdisplayname.Enabled = false;
                ddlBaseCurrency.Enabled = false;
                chkbaseorgselect.Enabled = false;
                returnCode = adminbl.pgetmyloc(InstanceID, out lstloc);
                //if (lstloc.Count > 0)
                //{
                //    var orgidpage = ddlOrgName.Items.FindByValue(Convert.ToString(lstloc[0].OrgID));
                //    if (orgidpage!=null)
                //    {
                //        ddlOrgName.SelectedValue = Convert.ToString(lstloc[0].OrgID);
                //    }
                //    else
                //    {
                //        ddlOrgName.SelectedValue = Convert.ToString(0);
                //    }

                //}
                if (DefaultOrgID>0)
                {
                    ddlOrgName.SelectedValue = Convert.ToString(DefaultOrgID);
                }
                else
                {
                    ddlOrgName.SelectedValue = Convert.ToString(0);
                }

               // lstNICT = new List<NewInstanceCreationTracker>();
                returnCode = new NewInstance(base.ContextInfo).CreateatedOrgInstanceDetail(out lstNICT, out pReturnStatus);
               
                if (lstNICT.Count > 0)
                {
                    //foreach (var a in lstNICT)

                    ddlBaseCurrency.SelectedValue = Convert.ToString(CurrencyID);
                            
                }


                imglogo.Visible = true;
                // imglogo.Src = "../Reception/PatientImageHandler.ashx?Logo=" + Logo;
                //imglogo.Src = Logo;
                if (Logo == "")
                {
                    //imglogo.Style.Add("width", "60px");
                    imglogo.Style.Add("Display","none");
                }
                else
                {
                    imglogo.Src = Logo;
                    imglogo.Style.Add("Display", "block");
                }
                FileUpload1.Attributes.Add("onmouseover", "showTooltip(event,'" + Logo + "');return false;");
                FileUpload1.Attributes.Add("onmouseout", "hideTooltip();");
                //this.Controls.Add(fileupload1);
                ucPAdd.SetAddresstoLocEdit(lstloc);

                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt1", "javascript:hdnInstanceID('" + InstanceID.ToString() + "','" + Logo + "');", true);
                hidechklist();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("error while updating", ex);
        }
    }
    protected void grdCreatedOrgs_RowEditing(object sender, GridViewEditEventArgs e)
    {
        btnupdate.Visible = true;
        btnupdate.Enabled = true;
    }

    protected void grdCreatedOrgs_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdCreatedOrgs.PageIndex = e.NewPageIndex;
        grdCreatedOrgs.DataBind();
    }
    protected void btnupdate_Click(object sender, EventArgs e)
    {
        pDefaultOrgID = Convert.ToInt32(ddlOrgName.SelectedValue);
        pCurrencyID = Convert.ToInt64(ddlBaseCurrency.SelectedValue);
        pDefaultOrgAddID = ILocationID;
        btnFinish.Enabled = false;
        btnFinish.Visible = false;

        int retStatus = -1;
        string pathname = "../Images/Logo/";

        try
        {


            string PictureName = Path.GetFileNameWithoutExtension(FileUpload1.FileName);
            string fileExtension = Path.GetExtension(FileUpload1.FileName);

            string fileName = Path.GetFileName(FileUpload1.FileName);

            if (FileUpload1.HasFile)
            {
                FileUpload1.SaveAs(Server.MapPath("../Images/Logo/") + fileName);

            }

            string filePath = pathname + PictureName + fileExtension;

            if (!String.IsNullOrEmpty(PictureName) && PictureName.Length > 0)
            {
                hdnLogoPath.Value = filePath;

            }

            #region OrgDetails
            Organization org = new Organization();
            org.OrgID = pDefaultOrgID;
            //org.AddressID = pDefaultOrgAddID;
            org.Name = txtOrgName.Text;
            org.OrgDisplayName = txtdisplayname.Text;
            org.Location = txtLocation.Text;
            org.OrganizationTypeID = 1;
            org.LogoPath = hdnLogoPath.Value;
            TextBox txtAdd1 = (TextBox)ucPAdd.FindControl("txtAddress1");
            TextBox txtAdd2 = (TextBox)ucPAdd.FindControl("txtAddress2");
            TextBox txtAdd3 = (TextBox)ucPAdd.FindControl("txtAddress3");
            TextBox txtCity = (TextBox)ucPAdd.FindControl("txtCity");
            DropDownList ddlCountry = (DropDownList)ucPAdd.FindControl("ddCountry");
            DropDownList ddlState = (DropDownList)ucPAdd.FindControl("ddState");
            TextBox txtPostalCode = (TextBox)ucPAdd.FindControl("txtPostalCode");
            TextBox txtmno = (TextBox)ucPAdd.FindControl("txtMobile");
            TextBox txtllno = (TextBox)ucPAdd.FindControl("txtLandLine");
            TextBox txtOtherCountry = (TextBox)ucPAdd.FindControl("txtOtherCountry");
            TextBox txtOtherState = (TextBox)ucPAdd.FindControl("txtOtherState");
            org.Add1 = txtAdd1.Text;
            org.Add2 = txtAdd2.Text;
            org.Add3 = txtAdd3.Text;
            org.PostalCode = txtPostalCode.Text;
            org.City = txtCity.Text;
            org.PhoneNumber = txtmno.Text;
            org.LandLineNumber = txtllno.Text;
            org.CountryID = Convert.ToInt32(ddlCountry.SelectedValue);
            org.StateID = Convert.ToInt32(ddlState.SelectedValue);
            org.StartDTTM = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            org.EndDTTM = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            org.OtherCountryName = txtdisplayname.Text;
            org.OtherStateName = txtOtherState.Text;
            //for is default org check
            if (chkbaseorgselect.Checked == true)
            {
                org.Isdefaultorg = "Y";
            }
            else
            {
                org.Isdefaultorg = "N";
            }
            lstOrganization.Add(org);
            #endregion

            foreach (ListItem lst in chkRoles.Items)
            {
                if (lst.Selected)
                {
                    Role r = new Role();
                    r.RoleID = Convert.ToInt32(lst.Value);
                    r.RoleName = lst.Text;
                    r.Description = lst.Text;
                    r.OrgID = pDefaultOrgID;
                    r.OrgAddressID = pDefaultOrgAddID;
                    lstRole.Add(r);
                }
            }

            foreach (ListItem lst in chkVisitPurpose.Items)
            {
                if (lst.Selected)
                {
                    VisitPurpose r = new VisitPurpose();
                    r.VisitPurposeID = Convert.ToInt32(lst.Value);
                    r.VisitPurposeName = lst.Text;
                    r.OrgID = pDefaultOrgID;
                    r.OrgAddressID = pDefaultOrgAddID;
                    lstVisitPurpose.Add(r);
                }
            }
            foreach (ListItem lstdept in chkDeptlist.Items)
            {
                if (lstdept.Selected)
                {
                    Department depart = new Department();
                    depart.DeptID = Convert.ToInt32(lstdept.Value);
                    depart.DeptName = lstdept.Text;
                    depart.OrgID = pDefaultOrgID;
                    depart.OrgAddressID = pDefaultOrgAddID;
                    lstDep.Add(depart);
                }

            }
            string EncryptedString = string.Empty;
            Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetEncryptor();
            obj.Crypt("abc123", out EncryptedString);
            int pOldInsID = 0;
            if (hdnInstanceID.Value != "")
            {
                pOldInsID = Convert.ToInt32(hdnInstanceID.Value);
            }

            string AliceType = String.Empty;
            returnCode = new NewInstance(base.ContextInfo).CreateOrgInstanceQueue(txtOrgName.Text, lstOrganization, lstRole, lstVisitPurpose, lstDep, out retStatus, EncryptedString, pCurrencyID, AliceType, pOldInsID);

        }
        catch (Exception ex)
        {
            btnFinish.Enabled = true;
            btnFinish.Visible = true;

            CLogger.LogError("Error in Creating New Instance", ex);
        }
        if (retStatus == 0)
        {
            try
            {
                #region Reset Entered Data

                //txtOrgName.Text = string.Empty;
                txtLocation.Text = string.Empty;
                TextBox txtAdd1 = (TextBox)ucPAdd.FindControl("txtAddress1");
                TextBox txtAdd2 = (TextBox)ucPAdd.FindControl("txtAddress2");
                TextBox txtAdd3 = (TextBox)ucPAdd.FindControl("txtAddress3");
                TextBox txtCity = (TextBox)ucPAdd.FindControl("txtCity");
                DropDownList ddlCountry = (DropDownList)ucPAdd.FindControl("ddCountry");
                DropDownList ddlState = (DropDownList)ucPAdd.FindControl("ddState");
                TextBox txtPostalCode = (TextBox)ucPAdd.FindControl("txtPostalCode");
                TextBox txtmno = (TextBox)ucPAdd.FindControl("txtMobile");
                TextBox txtllno = (TextBox)ucPAdd.FindControl("txtLandLine");
                TextBox txtOtherCountry = (TextBox)ucPAdd.FindControl("txtOtherCountry");
                TextBox txtOtherState = (TextBox)ucPAdd.FindControl("txtOtherState");
                txtAdd1.Text = string.Empty;
                txtAdd2.Text = string.Empty;
                txtAdd3.Text = string.Empty;
                txtPostalCode.Text = string.Empty;
                txtCity.Text = string.Empty;
                txtmno.Text = string.Empty;
                txtllno.Text = string.Empty;
                txtOtherCountry.Text = txtOtherCountry.Text;
                txtOtherState.Text = txtOtherState.Text;
                txtdisplayname.Text = string.Empty;
                hdnInstanceID.Value = "";
                btnFinish.Enabled = true;
                btnFinish.Visible = true;
                ddlBaseCurrency.SelectedValue = "0";
                ddlCountry.SelectedIndex = -1;
                ddlState.SelectedIndex = -1;
                ddlOrgName.SelectedValue = "0";
                imglogo.Visible = false;
            // btnFinish.Text = "Finish";
                btnFinish.Text =finish;
                s1role.Visible = false;
                s2Purpose.Visible = false;
                lbldept.Visible = false;
                chkRolesAll.Visible = false;
                chkVisitAll.Visible = false;
                chkDeptAll.Visible = false;
                chkRoles.Visible = false;
                chkVisitPurpose.Visible = false;
                chkDeptlist.Visible = false;
                chkbaseorgselect.Checked = false;

                #endregion

                string pUserName = string.Empty;
                string pPassword = string.Empty;
                string pOrgName = string.Empty;
                long pReturnStatus = -1;
                if (jqueryTask == "Y")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "CreateatedOrgInstanceDetail", "CreateatedOrgInstanceDetail('" + OrgID + "');", true);
                    grdCreatedOrgs.Visible = false;
                    GrdFooter.Visible = false;
                }
                else
                {
                returnCode = new NewInstance(base.ContextInfo).CreateatedOrgInstanceDetail(out lstNICT, out pReturnStatus);
                if (lstNICT.Count > 0)
                {
                    divCreatedOrg.Attributes.Add("style", "block");
                    grdCreatedOrgs.Visible = true;

                    grdCreatedOrgs.DataSource = lstNICT;
                    grdCreatedOrgs.DataBind();
                }
                else
                {
                    divCreatedOrg.Attributes.Add("style", "none");
                    grdCreatedOrgs.Visible = false;
                }
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Retrieving Created Org", ex);
            }
            if (returnCode >= 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "javascript:ShowAlertMsgUpdate();", true);
                //  bind();
                ddlOrgName.Items[0].Value = "0";
                ddlBaseCurrency.Items[0].Value = "0";
                hidecontrol();
                btnupdate.Visible = false;
                btnupdate.Attributes.Add("style", "display:none;");
            }
        }
        btnupdate.Enabled = false;
    }
    public void hidecontrol()
    {
        lblroleall.Visible = false;
        lblvisitall.Visible = false;
        lbldeptall.Visible = false;
        ddlOrgName.Enabled = true;
        txtOrgName.Text = "";
        ddlBaseCurrency.Enabled = true;
        txtOrgName.Enabled = true;
        txtdisplayname.Enabled = true;
    }
    public void hidechklist()
    {
        s1role.Visible = false;
        s2Purpose.Visible = false;
        lbldept.Visible = false;
        chkRolesAll.Visible = false;
        chkVisitAll.Visible = false;
        chkDeptAll.Visible = false;
        chkRoles.Visible = false;
        chkVisitPurpose.Visible = false;
        chkDeptlist.Visible = false;
        lblroleall.Visible = false;
        lblvisitall.Visible = false;
        lbldeptall.Visible = false;
    }
    protected void btnGoes_Click(object sender, EventArgs e)
    {
        int pageno = Convert.ToInt32(txtpageNo.Text);
        int totalpagecount = grdCreatedOrgs.PageCount;
        if (pageno > 0 && pageno <= totalpagecount)
        {
            grdCreatedOrgs.PageIndex = pageno - 1;
            grdCreatedOrgs.DataBind();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "javascript:showvalidatemsg();", true);
            txtpageNo.Text = "";
        }
    }
    protected void Btn_Next_Click(object sender, EventArgs e)
    {
        int i = Convert.ToInt32(lblGrdvwtotpage.Text);
        grdCreatedOrgs.PageIndex = grdCreatedOrgs.PageIndex + 1;
        grdCreatedOrgs.DataBind();
        if (i == grdCreatedOrgs.PageCount)
        {
            Btn_Next.Enabled = false;
            Btn_Previous.Enabled = false;
        }
        else
        {
            Btn_Next.Enabled = true;
            Btn_Previous.Enabled = true;
        }
    }

    protected void Btn_Previous_Click(object sender, EventArgs e)
    {
        int i = 1;
        if (grdCreatedOrgs.PageIndex > 0)
        {
            grdCreatedOrgs.PageIndex = grdCreatedOrgs.PageIndex - 1;
            grdCreatedOrgs.DataBind();
        }
        else
        {
            if (i != grdCreatedOrgs.PageCount)
            {
                Btn_Previous.Enabled = false;
            }
            else
            {
                Btn_Previous.Enabled = true;
            }
        }

    }
}
