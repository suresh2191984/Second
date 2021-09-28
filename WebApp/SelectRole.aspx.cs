using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.TrustedOrg;
using System.Configuration;
using System.IO;
using System.Threading;

using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Common;
using System.Xml.Linq;
using Attune.Kernel.BusinessEntities;
 
public partial class SelectRole : Attune_BasePage
{
    public SelectRole()
        : base("SelectRole_ascx")
    {}
    long loginID = -1;
    long returnCode = -1;
    public String strBrowser = string.Empty;
    public string strBrowserVersion = string.Empty;
    string OS = string.Empty;
    // GateWay gateWay = new GateWay(base.ContextInfo);
    GateWay gateWay;

    #region TOOL GENERATED CODE: Resource file reading and Client side script injection
    //public SelectRole()
    //    : base("SelectRole.aspx")
    //{
    //}

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        gateWay = new GateWay(base.ContextInfo);
        try
        {
            string _LandingPageLogo = string.Empty;
            string _LogoPath = string.Empty;

            try
            {             
                HttpCookie cookie = Request.Cookies["LoginLogo"];
                if (cookie != null && !string.IsNullOrEmpty(cookie.Value))
                {
        
                    _LandingPageLogo = cookie.Value;
                    Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetDecryptor();
                    obj.Crypt(_LandingPageLogo, out _LogoPath);
                    if (!string.IsNullOrEmpty(_LogoPath))
                    {
                        LoginPageLogo.ImageUrl = "~/Images/" + _LogoPath + ".png";
                        //CLogger.LogWarning(_LandingPageLogo);
                    }
                    else
                    {
                        LoginPageLogo.ImageUrl = "Images/logo.png";
                    }
                }
                else
                {
                    LoginPageLogo.ImageUrl = "Images/logo.png";
                }

            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in convertiong logo path" + _LandingPageLogo, ex.InnerException);
                LoginPageLogo.ImageUrl = "Images/logo.png";
            }

            ListItem ddlselect = GetMetaData("Select", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            //Getting Browsing Browser to stored in Logged in profile.
            String userAgent = Request.UserAgent;           
            if (userAgent.IndexOf("Windows NT 6.3") > 0)
            {
                OS = "Windows 8.1";
            }
            else if (userAgent.IndexOf("Windows NT 6.2") > 0)
            {
                OS = "Windows 8";
            }
            else if (userAgent.IndexOf("Windows NT 6.1") > 0)
            {
                OS = "Windows 7";
            }
            else if (userAgent.IndexOf("Windows NT 6.0") > 0)
            {
                OS = "Windows Vista";
            }
            else if (userAgent.IndexOf("Windows NT 5.2") > 0)
            {
                OS = "Windows Server 2003";
            }
            else if (userAgent.IndexOf("Windows NT 5.1") > 0)
            {
                OS = "Windows XP";
            }
            else if (userAgent.IndexOf("Windows NT 5.01") > 0)
            {
                OS = "Windows 2000, Service Pack 1 (SP1)";
            }
            else if (userAgent.IndexOf("Windows NT 5.0") > 0)
            {
                OS = "Windows 2000";
            }
            else if (userAgent.IndexOf("Windows NT 4.0") > 0)
            {
                OS = "Microsoft Windows NT 4.0";
            }
            else if (userAgent.IndexOf("Win 9x 4.90") > 0)
            {
                OS = "Windows Millennium Edition (Windows Me)";
            }
            else if (userAgent.IndexOf("Windows 98") > 0)
            {
                OS = "Windows 98";
            }
            else if (userAgent.IndexOf("Windows 95") > 0)
            {
                OS = "Windows 95";
            }
            else if (userAgent.IndexOf("Windows CE") > 0)
            {
                OS = "Windows CE";
            }
            else
            {
                OS = Convert.ToString(userAgent);
            }


            System.Web.HttpBrowserCapabilities browserDetection = Request.Browser;
            if (browserDetection.Id == "safari1plus")
            {
                strBrowser = "Chrome";
            }
            else
            {
                strBrowser = browserDetection.Browser;
            }
            strBrowserVersion = browserDetection.Version;
            if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["LoginBackgroundImage"]))
            {
                string imagePath = ConfigurationManager.AppSettings["LoginBackgroundImage"];
                if (File.Exists(HttpContext.Current.Request.PhysicalApplicationPath + imagePath))
                {
                    System.Drawing.Image image = System.Drawing.Image.FromFile(HttpContext.Current.Request.PhysicalApplicationPath + imagePath);
                    if (image != null)
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "BackgroundImage", "javascript:SetBodyBackground('" + imagePath + "');", true);
                        divLoginImg.Style.Add("background-image", "");
                        if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["LoginLabelTextColor"]))
                        {
                            string color = ConfigurationManager.AppSettings["LoginLabelTextColor"];
                            lbl.Style.Add("color", color);
                            lblOrg.Style.Add("color", color);
                            lblLocation.Style.Add("color", color);
                            lblRole.Style.Add("color", color);
                        }
                        //divLoginImg.Style.Add("width", image.Width + "px");
                        //if (image.Width > 520)
                        //{
                        //    divLoginImg.Style.Add("margin-left", "20%");
                        //    tblInputBox.Style.Add("width", "160px");
                        //}
                    }
                }
            }
            List<Config> lstConfig = new List<Config>();
            Configuration_BL configBL = new Configuration_BL(base.ContextInfo);
            returnCode = configBL.GetConfigDetails("IsChangeOrgganizationLabelNameinSelectRole", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                if (lstConfig[0].ConfigValue != "" && lstConfig[0].ConfigValue != null)
                {
                    lblOrg.Text = lstConfig[0].ConfigValue;
                }
            }
            returnCode = configBL.GetConfigDetails("IsChangeLocationLabelNameinSelectRole", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                if (lstConfig[0].ConfigValue != "" && lstConfig[0].ConfigValue != null)
                {
                    lblLocation.Text = lstConfig[0].ConfigValue;
                }
            }
            if (!IsPostBack)
            {
                returnCode = configBL.GetConfigDetails("Need_Department", OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                {
                    if (lstConfig[0].ConfigValue == "Y")
                    {
                      //  hnnNeedDepartment.Value = "Y";
                       //   LoadDepartment();

                       // trddlDeptText.Attributes.Add("class", "displaytr");
                     //   trddlDept.Attributes.Add("class", "displaytr");
                    }
                    else
                    {
                       // ddlDepartment.Items.Insert(0, ddlselect);
                      //  ddlDepartment.Items[0].Value = "0";

                       //  trddlDeptText.Attributes.Add("class", "hide");
                      //   trddlDept.Attributes.Add("class", "hide");
                    }
                }
                else
                {
                   // ddlDepartment.Items.Insert(0, ddlselect);
                   // ddlDepartment.Items[0].Value = "0";
                  //  trddlDeptText.Attributes.Add("class", "hide");
                   // trddlDept.Attributes.Add("class", "hide");
                }                
				//Set Style Sheet property
                string sLangCode = "en-GB";
                string strFileName = "LTL";
                sLangCode = Session["LanguageCode"].ToString();
                XDocument xDocument1 = XDocument.Load(Server.MapPath("~\\App_Data\\ApplicationSettings.xml"));
                var query1 = (from xEle in xDocument1.Descendants("LanguageCode")
                              where xEle.Element("Code").Value == sLangCode
                              select new ListItem(xEle.Element("Code").Value, xEle.Element("Alignment").Value)).ToList();
                linkCommonCSS.Attributes.Add("href", strFileName + ".css");
              //  strFileName = "PlatForm/StyleSheets/Common";
                strFileName = "StyleSheets/Style";
                if (query1[0].Value.ToString() == "RTL")
                {
                    strFileName = strFileName + query1[0].Value.ToString();
                }
                linkCommonCSS.Attributes.Add("href", strFileName + ".css");
                //End
            }

            if (Session["DepartmentID"] != null && !string.IsNullOrEmpty(Session["DepartmentID"].ToString()))
            {
              //  ddlDepartment.SelectedValue = Session["DepartmentID"].ToString();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load " + ex.Message, ex);
        }
    }

    protected void imgGo_Click(object sender, EventArgs e)
    {
        try
        {
            long returncode = 0;
            string orgName = string.Empty;
            Int64.TryParse(Session["LID"].ToString(), out loginID);
            Attune.Podium.BusinessEntities.Role loginrole = new Attune.Podium.BusinessEntities.Role();

            loginrole.OrgID = Convert.ToInt32(ddlOrg.SelectedValue);
            loginrole.OrgName = ddlOrg.SelectedItem.Text;
            loginrole.OrgDisplayName = ddlOrg.SelectedItem.Text;
            loginrole.RoleID = Convert.ToInt32(ddlRole.SelectedValue.Split('~')[0]);
            loginrole.Description = ddlRole.SelectedItem.Text;
            loginrole.RoleName = ddlRole.SelectedValue.Split('~')[1];
            loginrole.OrgDisplayName = ddlOrg.SelectedItem.Text;

            List<Attune.Podium.BusinessEntities.Role> lstLoginRole = new List<Attune.Podium.BusinessEntities.Role>();
            string path = string.Empty;
            List<OrganizationAddress> lstLocationdet = new List<OrganizationAddress>();

            #region Set the Location's Country and State defaultly

            if (Session["AddressID"] == null)
            {
                // returnCode = patientBL.GetLocation(Convert.ToInt64(OrgID), loginID, Convert.ToInt64(RoleID), out lstLocationdet);
                returnCode = new Organization_BL().GetLocation(Convert.ToInt32(loginrole.OrgID), loginID, Convert.ToInt64(RoleID), out lstLocationdet);
                if (lstLocationdet.Count > 0)
                {
                    foreach (OrganizationAddress objOrg in lstLocationdet)
                    {
                        if (objOrg.AddressID.ToString() == ddlLocation.SelectedValue)
                        {
                            Session.Add("CountryID", objOrg.CountryID.ToString());
                            Session.Add("StateID", objOrg.StateID.ToString());
                        }
                    }
                }
            }
            else
            {
                string strAdd = Session["AddressID"].ToString();
                string[] strAddID = strAdd.Split('^');
                string[] strAdds = null;
                string[] strCountry = null;
                for (int i = 0; i < strAddID.Length - 1; i++)
                {
                    int intLocID = Convert.ToInt32(strAddID[i].Split('*').ElementAt(0));
                    if (intLocID.ToString() == ddlLocation.SelectedValue)
                    {
                        strAdds = strAddID[i].Split('*');
                        strCountry = strAdds[1].Split('~');
                        Session.Add("CountryID", strCountry[0]);
                        Session.Add("StateID", strCountry[1]);
                        break;
                    }
                }
            }
            #endregion

            Navigation Attune_Navigation = new Navigation();
            lstLoginRole.Add(loginrole);
            returncode = Attune_Navigation.GetLandingPage(lstLoginRole, out path);
            if (returncode == 0)
            {
                List<Config> lstConfig = new List<Config>();

                Session.Add("RoleId", lstLoginRole[0].RoleID.ToString());
                Session.Add("OrgID", lstLoginRole[0].OrgID.ToString());
                Session.Add("OrgName", lstLoginRole[0].OrgName);
                Session.Add("OrgDisplayName", lstLoginRole[0].OrgDisplayName);
                Session.Add("RoleName", lstLoginRole[0].RoleName.ToString());
                Session.Add("LocationID", ddlLocation.SelectedValue.ToString());
                //Session.Add("LocationName", ddlLocation.SelectedItem.Text);
                Session["LocationName"] = ddlLocation.SelectedItem.Text;
                Session.Add("RoleDescription", ddlRole.SelectedItem.Text);
                if (lstLoginRole[0].OrgDisplayName != null)
                {
                    Session.Add("OrgDisplayName", lstLoginRole[0].OrgDisplayName.ToString());
                }
                else
                {
                    Session.Add("OrgDisplayName", "");
                }
                new Attune.Solution.BusinessComponent.GateWay().GetOrganizationDBMapping(lstLoginRole[0].OrgID);
                //LocationID
                LoggedInProfile objLoggedInProfile = new LoggedInProfile();
                objLoggedInProfile.IPAddress = Request.UserHostAddress;
                objLoggedInProfile.LoginID = loginID;
                objLoggedInProfile.OrgAddressID = int.Parse(ddlLocation.SelectedValue);
                objLoggedInProfile.OrgID = lstLoginRole[0].OrgID;
                objLoggedInProfile.BrowserName = strBrowser;
                objLoggedInProfile.Browserversion = strBrowserVersion;
                objLoggedInProfile.OS = OS;
                returnCode = gateWay.InsertLoggedInProfile(objLoggedInProfile);
                long DeptID = -1;

                HttpCookie CSGuid = new HttpCookie("CSGuid");
                CSGuid.Value = lstLoginRole[0].OrgID.ToString();
                Response.Cookies.Add(CSGuid);

                returnCode = gateWay.UpdateLoggedInUser(Session.SessionID, LID, lstLoginRole[0].RoleID, DeptID, Convert.ToInt64(ddlLocation.SelectedValue), lstLoginRole[0].OrgID);
                Session.Add("InventoryLocationID", "-1");
                List<LocationUserMap> lstLocationUserMap = new List<LocationUserMap>();

                returnCode = new GateWay(ContextInfo).GetLocationUserMap(LID, lstLoginRole[0].OrgID, Int32.Parse(ddlLocation.SelectedValue), out lstLocationUserMap);
				
								
                if (lstLocationUserMap != null && lstLocationUserMap.Count > 0)
                {
                    if (lstLocationUserMap.Exists(P => P.IsDefault == "Y"))
                    {
                        Session.Add("InventoryLocationID", lstLocationUserMap.Find(P => P.IsDefault == "Y").LocationID);
                        Session.Add("DepartmentName", lstLocationUserMap.Find(P => P.IsDefault == "Y").LocationName);
                        Session.Add("InventoryLocationType", lstLocationUserMap.Find(p => p.IsDefault == "Y").LocationTypeID);
                    }
                    else
                    {
                        Session.Add("InventoryLocationID", lstLocationUserMap.FirstOrDefault().LocationID);
                        Session.Add("DepartmentName", lstLocationUserMap.FirstOrDefault().LocationName);
                        Session.Add("InventoryLocationType", lstLocationUserMap.FirstOrDefault().LocationTypeID);
                    }
                }
                else
                {
                    if (RoleHelper.Inventory != RoleName)
                    {
                        Configuration_BL configBL = new Configuration_BL(base.ContextInfo);
                        List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                        returnCode = configBL.GetInventoryConfigDetails("InventoryLocation", lstLoginRole[0].OrgID, Convert.ToInt32(lstLoginRole[0].OrgAddressID), out lstInventoryConfig);
                        if (lstInventoryConfig.Count > 0)
                        {
                            Session.Add("InventoryLocationID", lstInventoryConfig[0].ConfigValue);
                        }
                    }
                }
                try
                {
                    string LogoPathRole = string.Empty;
                    List<Role> userRoles = new List<Role>();
                    Attune.Kernel.BusinessEntities.Login loggedIn = new Attune.Kernel.BusinessEntities.Login();
                    loggedIn.LoginID = loginID;
                    returnCode = gateWay.GetRoles(loggedIn, out userRoles);
                    if (returnCode >= 0 && userRoles.Count > 0)
                    {
                        LogoPathRole = userRoles.Find(P => P.OrgID == lstLoginRole[0].OrgID).LogoPath;
                    }
                    if (!String.IsNullOrEmpty(LogoPath))
                    {
                        Session.Add("LogoPath", LogoPathRole);
                    }
                }
                catch (Exception ex)
                {
                    CLogger.LogError("Logo error in page", ex);
                }
                List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
                List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
                returnCode = new TrustedOrg(base.ContextInfo).GetTrustedOrgList(int.Parse(ddlLocation.SelectedValue), lstLoginRole[0].RoleID, "", out lstTOD);
                if (lstTOD!=null && lstTOD.Count > 0)
                {
                    Session.Add("IsTrustedOrg", "Y");
                }
                else
                {
                    Session.Add("IsTrustedOrg", "N");
                }

                //Added By Ramki
                returnCode = new Configuration_BL().GetConfigDetails("UseOrgBasedDrugData", lstLoginRole[0].OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                {
                    if (lstConfig[0].ConfigValue == "Y")
                        Session.Add("DrugOrgID", lstLoginRole[0].OrgID);
                    else
                        Session.Add("DrugOrgID", 0);
                }
                else
                {
                    Session.Add("DrugOrgID", 0);
                }
                returnCode = new Configuration_BL().GetConfigDetails("IsAmountEditable", lstLoginRole[0].OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                    Session.Add("IsAmountEditable", lstConfig[0].ConfigValue);
                else
                    Session.Add("IsAmountEditable", "Y");

            // if (ddlDepartment.SelectedValue != "0")
              //  {
                 //   Session.Add("DepartmentID", ddlDepartment.SelectedValue);
                  //  Session.Add("EMPDepartmentName", ddlDepartment.SelectedItem.Text);
              // }
                Response.Redirect(Request.ApplicationPath + path, true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while moving between available roles", ex);
        }
    }

    protected void imgLogout_Click(object sender, EventArgs e)
    {
        LogOut();
    }
    void LoadDepartment()
    {
        ListItem ddlselect = GetMetaData("Select", "0");
        if (ddlselect == null)
        {
            ddlselect = new ListItem() { Text = "Select", Value = "0" };
        }
        long returnCode = -1;
        List<EmployerDeptMaster> lstEmpDeptMaster = new List<EmployerDeptMaster>();
        GateWay obj = new GateWay();
        returnCode = obj.GetEmployerDeptMaster(OrgID, out lstEmpDeptMaster);
        if (lstEmpDeptMaster.Count > 0)
        {
            if (Session["DepartmentID"] != null)
            {
              //  ddlDepartment.DataSource = lstEmpDeptMaster.FindAll(p => p.Code == Session["DepartmentID"].ToString()); ;
            }
            else
            {
            //    ddlDepartment.DataSource = lstEmpDeptMaster;
            }
          //  ddlDepartment.DataValueField = "Code";
          //  ddlDepartment.DataTextField = "EmpDeptName";
          //  ddlDepartment.DataBind();
           // ddlDepartment.Items.Insert(0, ddlselect);
           // ddlDepartment.Items[0].Value = "0";
        }
        else
        {
          //  ddlDepartment.Items.Insert(0, ddlselect);
           // ddlDepartment.Items[0].Value = "0";
        }
    }
}

