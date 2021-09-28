using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Podium.TrustedOrg;

public partial class UserControl_OrgHeader : BaseControl
{
    long returnCode = -1;

    protected void Page_Load(object sender, EventArgs e)
    {



        //hdnTheme.Value = link.ClientID;

        //lblOrgName.Text = OrgName;
        //if (RoleName == RoleHelper.Patient)
        //{
        //    lblOrgName.Text = "Suburban Diagnostics Pvt Ltd";
        //    lnkRoleChange.Visible = false;
        //}
        //else
        //{
            if (OrgDisplayName != null)
            {
                lblOrgName.Text = OrgDisplayName;
            }
        //}

        string Location = LocationName == null ? "" : LocationName;

        if (Location != "")
        {
            lblLocationName.Text = "Location : " + Location;
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
    protected void btnLogOut_Click(object sender, EventArgs e)
    {

        LogOut();
    }
    protected void RoleChange_Click(object sender, EventArgs e)
    {
       // Department2.LoadLocationsAndRoles();
    }
    protected void btnRoleOK_Click(object sender, EventArgs e)
    {
        try
        {
            GateWay gateway = new GateWay(base.ContextInfo);
            long returncode = 0;
            long loginID = -1;
            string orgName = string.Empty;
            Int64.TryParse(Session["LID"].ToString(), out loginID);
            Role loginrole = new Role();
            loginrole.OrgID = Convert.ToInt32(hdnOrg.Value);
            loginrole.OrgName = hdnDisplayName.Value;
            loginrole.RoleID = Convert.ToInt64(hdnRole.Value.Split('~')[0]);
            loginrole.RoleName = hdnRole.Value.Split('~')[1];
            loginrole.OrgDisplayName = hdnDisplayName.Value;
            List<Role> lstLoginRole = new List<Role>();
            string path = string.Empty;
            Navigation Navigation = new Navigation();
            lstLoginRole.Add(loginrole);
            returncode = Navigation.GetLandingPage(lstLoginRole, out path);
            if (returncode == 0)
            {
                List<Config> lstConfig = new List<Config>();
                Session.Add("RoleId", lstLoginRole[0].RoleID.ToString());
                Session.Add("OrgID", lstLoginRole[0].OrgID.ToString());
                Session.Add("OrgName", lstLoginRole[0].OrgName);
                Session.Add("OrgDisplayName", lstLoginRole[0].OrgDisplayName);
                Session.Add("RoleName", lstLoginRole[0].RoleName.ToString());
                Session.Add("LocationID", hdnLocationID.Value.ToString());
                Session.Add("LocationName", hdnLocationName.Value);
                Session.Add("RoleDescription", hdnRoleName.Value);

                LoggedInProfile objLoggedInProfile = new LoggedInProfile();
                objLoggedInProfile.IPAddress = Request.UserHostAddress;
                objLoggedInProfile.LoginID = loginID;
                objLoggedInProfile.OrgAddressID = int.Parse(hdnLocationID.Value);
                objLoggedInProfile.OrgID = lstLoginRole[0].OrgID;
                returncode = gateway.InsertLoggedInProfile(objLoggedInProfile);
                Session.Add("InventoryLocationID", "-1");
                List<LocationUserMap> lstLocationUserMap = new List<LocationUserMap>();
                returncode = gateway.GetLocationUserMap(LID, lstLoginRole[0].OrgID, Int32.Parse(hdnLocationID.Value), out lstLocationUserMap);
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
                        returncode = gateway.GetInventoryConfigDetails("InventoryLocation", lstLoginRole[0].OrgID, Int32.Parse(hdnLocationID.Value), out lstInventoryConfig);
                        if (lstInventoryConfig.Count > 0)
                        {
                            Session.Add("InventoryLocationID", lstInventoryConfig[0].ConfigValue);
                        }
                    }
                }

                List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
                List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
                returncode = new TrustedOrg(base.ContextInfo).GetTrustedOrgList(int.Parse(hdnLocationID.Value), lstLoginRole[0].RoleID, "", out lstTOD);
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
}

