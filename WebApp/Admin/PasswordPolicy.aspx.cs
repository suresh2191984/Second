using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.DAL;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Script.Serialization;

public partial class Admin_PasswordPolicy : BasePage
{
    public Admin_PasswordPolicy() : base("Admin_PasswordPolicy_aspx") { }
    Master_BL oMaster_BL;
   public  PatientVisit_BL patientBL;
    List<PasswordPolicy> pwdplcy = new List<PasswordPolicy>();
    string TransPass = string.Empty;

    Users_BL UserBL;
    protected void Page_Load(object sender, EventArgs e)
    {
        oMaster_BL = new Master_BL(base.ContextInfo);
        patientBL = new PatientVisit_BL(base.ContextInfo);
        UserBL = new Users_BL(base.ContextInfo);
        try
        {
            if (!IsPostBack)
            {
                LoadPasswordPolicy();
                LoadPrintPolicy();

            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "SetVisibleDiv", "SetVisibleContent()", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in page load ", ex);
        }
    }

    private void LoadPasswordPolicy()
    {
        try
        {
            TransPass = GetConfigValue("PasswordAuthentication", OrgID);

            hdnConfigid.Value = TransPass;
            txtpasswordlength.Focus();
            LoadTable(pwdplcy);

            if (!String.IsNullOrEmpty(TransPass) && TransPass.Length > 0)
            {
                if (TransPass == "Y")
                {

                    DivTpwd.Style.Add("display", "block");
                    DivLpwd.Style.Add("display", "block");
                    tdbtnadd.Style.Add("display", "none");
                    tdsaveall.Style.Add("display", "table-cell");

                }
                else
                {

                    DivTpwd.Style.Add("display", "none");
                    DivLpwd.Style.Add("display", "block");
                    tdbtnadd.Style.Add("display", "table-cell");
                    tdsaveall.Style.Add("display", "none");
                }
            }
            else
            {

                DivTpwd.Style.Add("display", "none");
                DivLpwd.Style.Add("display", "block");
                tdbtnadd.Style.Add("display", "table-cell");
                tdsaveall.Style.Add("display", "none");

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading password policy ", ex);
            throw ex;
        }
    }

    private void LoadPrintPolicy()
    {
        string strselect = Resources.Admin_ClientDisplay.Admin_PasswordPolicy_aspx_21 == null ? "--Select--" : Resources.Admin_ClientDisplay.Admin_PasswordPolicy_aspx_21;
        long returnCode = -1;
        try
        {
            hdnOrgID.Value = Convert.ToString(OrgID);
            hdnLoginID.Value = Convert.ToString(LID);

            MetaData oMetaData ;
            string MetaDomain = "PrintPolicy,ValidationType";

            string[] MetaName = MetaDomain.Split(',');
            List<MetaData> lstDomain = new List<MetaData>();
    

            foreach (string domainname in MetaName)
            {
                oMetaData = new MetaData();
                oMetaData.Domain = domainname;

                lstDomain.Add(oMetaData);
            }                                             
           
      
        
            List<MetaData> lstMetaData = new List<MetaData>();
            // returnCode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstDomain, LangCode, out lstMetaData);
            returnCode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstDomain, OrgID, LanguageCode , out lstMetaData);
            
            if (lstMetaData.Count > 0)
            {
                List<MetaData> lstCategory = ((from child in lstMetaData
                                 where child.Domain == "PrintPolicy"
                                 select child).Distinct()).ToList();
                if (lstCategory != null && lstCategory.Count > 0)
                {
                    ddlCategory.DataSource = lstCategory;
                    ddlCategory.DataTextField = "DisplayText";
                    ddlCategory.DataValueField = "Code";
                    ddlCategory.DataBind();

                    GateWay gateway = new GateWay(base.ContextInfo);
                    List<Role> userRoles = new List<Role>();
                    List<Role> lstRoles = new List<Role>();
                    Attune.Podium.BusinessEntities.Login loggedIn = new Attune.Podium.BusinessEntities.Login();
                    loggedIn.LoginID = LID;
                    returnCode = gateway.GetRoles(loggedIn, out userRoles);
                    lstRoles = ((from child in userRoles
                                 where child.OrgID == OrgID
                                 orderby child.RoleName
                                 select new Role { RoleID = child.RoleID, RoleName = child.RoleName,Description =child.Description}).Distinct()).ToList();
                    if (lstRoles != null && lstRoles.Count > 0)
                    {
                        ddlRole1.DataSource = lstRoles;
                        ddlRole1.DataTextField = "Description";
                        ddlRole1.DataValueField = "RoleID";
                        ddlRole1.DataBind();
                    }
                }
            }
            ListItem item = new ListItem(strselect, "0");
            ddlCategory.Items.Insert(0, item);
            ddlRole1.Items.Insert(0, item);
            ddlLocation.Items.Insert(0, item);
            var ValidationType = from child in lstMetaData
                                 where child.Domain == "ValidationType"
                             select child;
            if (ValidationType.Count() > 0)
            {
                drptransvltypd.DataSource = ValidationType;
                drptransvltypd.DataTextField = "DisplayText";
                drptransvltypd.DataValueField = "Code";
                drptransvltypd.DataBind();
                //drptransvltypd.SelectedValue = "Lab_Investigation";
                //drptransvltypd.Items.Insert(0, "--Select--");
                drptransvltypd.Items.Insert(0, strselect);
                drptransvltypd.Items[0].Value = "0";
                  ddlvlty.DataSource = ValidationType;
                ddlvlty.DataTextField = "DisplayText";
                ddlvlty.DataValueField = "Code";
                ddlvlty.DataBind();
                //drptransvltypd.SelectedValue = "Lab_Investigation";
                ddlvlty.Items.Insert(0, strselect);
                //ddlvlty.Items.Insert(0, "--Select--");
                ddlvlty.Items[0].Value = "0";
            }



            List<PrintPolicy> lstPrintPolicyMaster = new List<PrintPolicy>();
            Master_BL oMaster_BL = new Master_BL(base.ContextInfo);
            returnCode = oMaster_BL.GetPrintPolicy(OrgID, -1, -1, out lstPrintPolicyMaster);
            if (lstPrintPolicyMaster.Count > 0)
            {
                rptPrintPolicy.DataSource = lstPrintPolicyMaster;
                rptPrintPolicy.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading print policy ", ex);
        }
    }

    public void LoadTable(List<PasswordPolicy> lstpwdplcy)
    {
        try
        {
            long returncode = -1;
            returncode = new Users_BL(base.ContextInfo).GetPasswordpolicy(OrgID, out lstpwdplcy);
            foreach (PasswordPolicy objPP in lstpwdplcy)
            {
                hdnRecords.Value += objPP.Type + "~" + objPP.PasswordLength + "~" + objPP.Splcharlen + "~" + objPP.Numcharlen + "~" + objPP.ValidityPeriodType + "~" + objPP.ValidityPeriod + "~" + objPP.PreviousPwdcount+"~"+objPP.Id+ "^";
            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "IsDefault", "ChildGridList();", true);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadBarcodeOrgMapping", ex);
        }
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

 

    protected void btnsaveall_Click(object sender, EventArgs e)
    {

           List<PasswordPolicy> pwdplcy = new List<PasswordPolicy>();
       
        long Returncode = -1;
        foreach (string str in hdnRecords.Value.Split('^'))
        {
            if (str != "")
            {
              
                 PasswordPolicy obj = new PasswordPolicy();
                string[] list = str.Split('~');
                obj.Id = Int64.Parse(list[7]);
                obj.Type = list[0].ToString();
                obj.PasswordLength = Int32.Parse(list[1]);
                if (list[2] == "")
                {
                    list[2] = "0";
                }
                if (list[3] == "")
                {
                    list[3] = "0";
                }
                if (list[5] == "")
                {
                    list[5] = "0";
                }
                if (list[6] == "")
                {
                    list[6] = "0";
                }
                obj.Splcharlen = Int32.Parse(list[2].ToString());
                obj.Numcharlen = Int32.Parse(list[3].ToString());
                obj.ValidityPeriodType = list[4].ToString();
                obj.ValidityPeriod = Int32.Parse(list[5].ToString());
                obj.PreviousPwdcount = Int32.Parse(list[6].ToString());
                obj.OrgID = OrgID;
                obj.CreatedBy = LID;
                pwdplcy.Add(obj);
            }
        }
       

        Returncode = new Users_BL(base.ContextInfo).InsertPasswordPolicy(OrgID,pwdplcy);
        if (Returncode >= 0)
        {

            Response.Redirect("PasswordPolicy.aspx");

        }
      

        
  

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath  + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    protected void btnclose_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath  + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }

    [WebMethod(EnableSession=true)]
    public static List<OrganizationAddress> GetLocation(Int32 OrgID, Int64 LoginID, Int64 RoleID)
    {
        long returnCode = -1;
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        try
        {
            PatientVisit_BL patientBL = new PatientVisit_BL(new BaseClass().ContextInfo);
            returnCode = patientBL.GetLocation(OrgID, LoginID, RoleID, out lstLocation);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting location ", ex);
        }
        return lstLocation;
    }
    [WebMethod(EnableSession=true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static NameValuePair SavePrintPolicy(String PrintPolicy)
    {
        string strSave = Resources.Admin_ClientDisplay.Admin_PasswordPolicy_aspx_19 == null ? "Record saved successfully" : Resources.Admin_ClientDisplay.Admin_PasswordPolicy_aspx_19;
        string strUnsave = Resources.Admin_ClientDisplay.Admin_PasswordPolicy_aspx_20 == null ? "Unable to save" : Resources.Admin_ClientDisplay.Admin_PasswordPolicy_aspx_20;

        long returnCode = -1;
        NameValuePair oNameValuePair = new NameValuePair();
        Int64 pID = 0;
        try
        {
            JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
            PrintPolicyMaster oPrintPolicyMaster = oJavaScriptSerializer.Deserialize<PrintPolicyMaster>(PrintPolicy);
            if (oPrintPolicyMaster != null)
            {
                Master_BL oMaster_BL = new Master_BL(new BaseClass().ContextInfo);
                returnCode = oMaster_BL.SavePrintPolicy(oPrintPolicyMaster.OrgID, oPrintPolicyMaster.CreatedBy, oPrintPolicyMaster, out pID);
                if (returnCode == 0)
                {
                    oNameValuePair.ParentID = Convert.ToString(pID);
                    //oNameValuePair.Value = "Record saved successfully";
                    oNameValuePair.Value = strSave;
                }
                else
                {
                    oNameValuePair.ParentID = Convert.ToString(pID);
                    //oNameValuePair.Value = "Unable to save";
                    oNameValuePair.Value = strUnsave;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting location ", ex);
            oNameValuePair.ParentID = Convert.ToString(pID);
            //oNameValuePair.Value = "Unable to save";
            oNameValuePair.Value = strUnsave;
        }
        return oNameValuePair;
    }
    [WebMethod(EnableSession=true)]
    public static String DeletePrintPolicy(Int64 ID)
    {
        string strRec = Resources.Admin_ClientDisplay.Admin_PasswordPolicy_aspx_17 == null ? "Record deleted successfully" : Resources.Admin_ClientDisplay.Admin_PasswordPolicy_aspx_17;
        string strDel = Resources.Admin_ClientDisplay.Admin_PasswordPolicy_aspx_18 == null ? "Unable to delete" : Resources.Admin_ClientDisplay.Admin_PasswordPolicy_aspx_18;

        long returnCode = -1;
        String message = string.Empty;
        try
        {
                Master_BL oMaster_BL = new Master_BL(new BaseClass().ContextInfo);
                returnCode = oMaster_BL.DeletePrintPolicy(ID);
                if (returnCode == 0)
                {
                   // message = "Record deleted successfully";
                    message = strRec;
                }
                else
                {
                    //message = "Unable to delete";
                    message = strDel;
                }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while deleting print policy ", ex);
            //message = "Unable to delete";
            message = strDel;
        }
        return message;
    }
}
