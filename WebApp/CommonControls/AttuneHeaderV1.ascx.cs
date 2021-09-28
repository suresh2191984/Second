using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using System.Globalization;
using Attune.Podium.TrustedOrg;
using System.Web.Services;
public partial class CommonControls_AttuneHeaderV1 : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

        lblLoginName.Text = UserName;
        lblRoleName.Text = RoleDescription;
        if (OrgDisplayName != null)
        {
            lblOrgName.Text = OrgDisplayName;
        }
        //}

        string Location = LocationName == null ? "" : LocationName;

        if (Location != "")
        {
            hdnLocationName.Value = Location;
          //  lblLocationName.Text = "Location : " + Location;
            lblLocationName.Text =   Location;
        }
        //displaySessionTimeLeft
        if (!IsPostBack)
        {
            if (Request.QueryString["ILF"] == null)
            {
                if (IsFirstLogin == "N")
                {
                    Response.Redirect(Request.ApplicationPath + "/ChangePassword/ChangePassword.aspx?ILF=Y");
                }
            }
            try
            {
                long returnCode = -1;
                List<Banners> lstBanners = new List<Banners>();
                returnCode = new Banners_BL(base.ContextInfo).GetBannersText(RoleID, LID, OrgID, out lstBanners);
                if (lstBanners.Count > 0)
                {
                    string bannerText = string.Empty;

                    divBanner.Style.Add("display", "block");
                    foreach (Banners b in lstBanners)
                    {
                        bannerText += "***" + b.BannerText + "*** ";
                    }

                    lblBannerText.Text = bannerText;
                }
                else
                {
                    divBanner.Style.Add("display", "none");
                }


            }
            catch (System.Threading.ThreadAbortException tae)
            {
                string thread = tae.ToString();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in OrgHeader Page Load", ex);
            }
        }
    }
    protected void lnkLogOut_Click(object sender, EventArgs e)
    {
        LogOut();
    }

    protected void btnRoleOK_Click(object sender, EventArgs e)
    {
        try
        {
            //SetLanguage();
            GateWay gateway = new GateWay(base.ContextInfo);
            long returncode = 0;
            long loginID = -1;
            string orgName = string.Empty;
            Int64.TryParse(Session["LID"].ToString(), out loginID);
            Role loginrole = new Role();
            loginrole.OrgID = Convert.ToInt32(OrgID);
            loginrole.OrgName = OrgDisplayName;

            string[] strRole = null;
            if (!string.IsNullOrEmpty(hdnRole.Value.Trim()))
            {
                strRole = hdnRole.Value.Split('~');
            }

            string[] strLoaction = null;
            string strLocationID = "0";
            string strLocationName = "0";
            if (!string.IsNullOrEmpty(hdnLocation.Value.Trim()))
            {
                strLoaction = hdnLocation.Value.Split('~');
                strLocationID = strLoaction[0];
                strLocationName = strLoaction[1];
            }


            loginrole.RoleID = Convert.ToInt64(strRole[0]);
            loginrole.RoleName = strRole[1];
            loginrole.Description = strRole[2];
            List<Role> lstLoginRole = new List<Role>();
            string path = string.Empty;
            Navigation Navigation = new Navigation();
            lstLoginRole.Add(loginrole);
            returncode = Navigation.GetLandingPage(lstLoginRole, out path);
            if (returncode == 0)
            {
                if (Request.Cookies["LeftMenu"] != null)
                {
                    Response.Cookies["LeftMenu"].Expires = DateTime.Now.AddDays(-1);
                }
                //--------------------TaskNotification----------------------------------------//
                // string chkTaskNotificationtext = "";
                //if (chkTaskNotification.Checked == true)
                //    TaskNotification = "Y";
                //else
                //    TaskNotification = "N";
                //ContextInfo.AdditionalInfo = TaskNotification;
                //Session.Add("TaskNotification", TaskNotification);
                Theme_BL objTheme_BL = new Theme_BL(base.ContextInfo);
                long ThemeId = 0;
                if (Session["ThemeID"].ToString() != "")
                    ThemeId = Convert.ToInt64(Session["ThemeID"].ToString());
                objTheme_BL.UpdateThemeByLID(LID, ThemeId);
                //----------------------End--------------------------------------------------//

                List<Config> lstConfig = new List<Config>();
                Session.Add("RoleID", lstLoginRole[0].RoleID.ToString());
                Session.Add("OrgID", lstLoginRole[0].OrgID.ToString());
                Session.Add("OrgName", lstLoginRole[0].OrgName);
                Session.Add("OrgDisplayName", lstLoginRole[0].OrgName);
                Session.Add("RoleName", lstLoginRole[0].RoleName.ToString());
                Session.Add("LocationID", strLocationID);
                Session.Add("LocationName", strLocationName);
                Session.Add("RoleDescription", loginrole.Description);
                //Session.Add("DepartmentID", ddlDepartment.SelectedValue);
                LoggedInProfile objLoggedInProfile = new LoggedInProfile();
                objLoggedInProfile.IPAddress = Request.UserHostAddress;
                objLoggedInProfile.LoginID = loginID;
                objLoggedInProfile.OrgAddressID = int.Parse(strLocationID);
                objLoggedInProfile.OrgID = lstLoginRole[0].OrgID;
                returncode = gateway.InsertLoggedInProfile(objLoggedInProfile);
                Session.Add("InventoryLocationID", "-1");
                List<LocationUserMap> lstLocationUserMap = new List<LocationUserMap>();
                returncode = gateway.GetLocationUserMap(LID, lstLoginRole[0].OrgID, Int32.Parse(strLocationID), out lstLocationUserMap);
                if (lstLocationUserMap.Count > 0)
                {
                    if (lstLocationUserMap.Exists(P => P.IsDefault == "Y"))
                    {
                        Session.Add("InventoryLocationID", lstLocationUserMap.Find(P => P.IsDefault == "Y").LocationID);
                        Session.Add("DepartmentName", lstLocationUserMap.Find(P => P.IsDefault == "Y").LocationName);
                    }
                }
                else
                {
                    if (RoleHelper.Inventory != RoleName)
                    {
                        List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                        returncode = gateway.GetInventoryConfigDetails("InventoryLocation", lstLoginRole[0].OrgID, Int32.Parse(strLocationID), out lstInventoryConfig);
                        if (lstInventoryConfig.Count > 0)
                        {
                            Session.Add("InventoryLocationID", lstInventoryConfig[0].ConfigValue);
                        }
                    }
                }

                if (!string.IsNullOrEmpty(ddlOrg.SelectedValue) && Convert.ToInt16(ddlOrg.SelectedValue) > 0)
                {
                    Session.Add("InventoryLocationID", ddlOrg.SelectedValue);
                }

                List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
                List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
                returncode = new TrustedOrg(base.ContextInfo).GetTrustedOrgList(int.Parse(strLocationID), lstLoginRole[0].RoleID, "", out lstTOD);
                if (lstTOD.Count > 0)
                {
                    Session.Add("IsTrustedOrg", "Y");
                }
                else
                {
                    Session.Add("IsTrustedOrg", "N");
                }

                returncode = gateway.GetConfigDetails("UseOrgBasedDrugData", lstLoginRole[0].OrgID, out lstConfig);
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
                returncode = gateway.GetConfigDetails("IsAmountEditable", lstLoginRole[0].OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                    Session.Add("IsAmountEditable", lstConfig[0].ConfigValue);
                else
                    Session.Add("IsAmountEditable", "Y");

                Response.Redirect(Request.ApplicationPath + path, true);
                Helper.PageRedirect(Page, Request.ApplicationPath + path);
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



    
    //protected void SetLanguage()
    //{
    //    //Sets the cookie that is to be used by Global.asax
    //    HttpCookie cookie = new HttpCookie("CultureInfo");
    //    cookie.Value = ddlLanguage.SelectedValue;
    //    Response.Cookies.Add(cookie);
    //    //Set the culture and reload the page for immediate effect. 
    //    //Future effects are handled by Global.asax
    //    Thread.CurrentThread.CurrentUICulture = new CultureInfo(ddlLanguage.SelectedValue);
    //    Thread.CurrentThread.CurrentCulture = new CultureInfo(ddlLanguage.SelectedValue);
    //    base.ContextInfo.LanguageCode = ddlLanguage.SelectedValue;
    //    Session["LanguageCode"] = ddlLanguage.SelectedValue;
    //}
}
