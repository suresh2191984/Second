using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Podium.TrustedOrg;


public partial class CommonControls_ChangeLocation : BaseControl
{
    public CommonControls_ChangeLocation()
        : base("CommonControls_ChangeLocation_ascx")
    {
    }
	
    long returnCode = -1;
    string styleClass = string.Empty;
    string styleMidClass = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            leftDiv.Attributes.Add("Class", CSSStyle);
            PatientVisit_BL objPatientVisit_BL = new PatientVisit_BL(base.ContextInfo);
            List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
            returnCode = objPatientVisit_BL.GetLocation(OrgID, LID, RoleID, out lstLocation);

            if (lstLocation.Count > 0)
            {
                OrganizationAddress oAddress = lstLocation.Find(P => P.AddressID == ILocationID);
                if (oAddress != null)
                {
                    Session["HasHealthCard"] = oAddress.IsRemote;
                    Session["CountryID"] = oAddress.CountryID.ToString();
                    Session["StateID"] = oAddress.StateID.ToString();
                }
            }
            if (lstLocation.Count > 1)
            {
                leftDiv.Visible = true;
                lstLocation.RemoveAll(P => P.AddressID == ILocationID);
                rptChangeLocation.DataSource = lstLocation;
                rptChangeLocation.DataBind();
            }

            else
            {
                leftDiv.Visible = false;
            }
        }
    }


    protected void rptChangeLocation_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {

            if (e.CommandName == "go")
            {
                Role loginrole = new Role();

                Label lblAddressID = ((Label)e.Item.FindControl("lblAddressID"));
                LinkButton linkLocation = ((LinkButton)e.Item.FindControl("linkLocation"));
                Session.Add("LocationID", lblAddressID.Text);
                Session.Add("LocationName", linkLocation.Text);

                GateWay gateWay = new GateWay(base.ContextInfo);
                List<LocationUserMap> lstLocationUserMap = new List<LocationUserMap>();
                returnCode = gateWay.GetLocationUserMap(LID, OrgID, Int32.Parse(lblAddressID.Text), out lstLocationUserMap);
                if (lstLocationUserMap.Count > 0)
                {
                    if (lstLocationUserMap.Exists(P => P.IsDefault == "Y"))
                    {
                        Session.Add("InventoryLocationID", lstLocationUserMap.Find(P => P.IsDefault == "Y").LocationID);
                        Session.Add("DepartmentName", lstLocationUserMap.Find(P => P.IsDefault == "Y").LocationName);
                    }
                    else
                    {
                        Session.Add("InventoryLocationID", "-1");
                    }

                }
                else
                {
                    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                    returnCode = gateWay.GetInventoryConfigDetails("InventoryLocationID", OrgID,ILocationID, out lstInventoryConfig);
                    if (lstInventoryConfig.Count > 0)
                    {
                        Session.Add("InventoryLocationID", lstInventoryConfig[0].ConfigValue);
                    }
                    else
                    {
                        Session.Add("InventoryLocationID", "-1");
                    }
                }

                // List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
                List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
                List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
                returnCode = new TrustedOrg(base.ContextInfo).GetTrustedOrgList(Int32.Parse(lblAddressID.Text), RoleID, "", out lstTOD);
                if (lstTOD.Count > 0)
                {
                    Session.Add("IsTrustedOrg", "Y");
                }
                else
                {
                    Session.Add("IsTrustedOrg", "N");
                }

                Navigation navigation = new Navigation();
                Role role = new Role();
                role.RoleID = RoleID;
                List<Role> userRoles = new List<Role>();
                userRoles.Add(role);
                string relPagePath = string.Empty;
                Session["PageNo"] = null;
                returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

                if (returnCode == 0)
                {
                    Response.Redirect(Request.ApplicationPath + relPagePath, true);
                }
            }
            
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error at ChangeLocation Control itemcommand", ex);
        }
    }


    public string CSSStyle
    {
        set
        {
            styleClass = value;
        }
        get
        {
            return styleClass;
        }
    }
    public string CSSMidStyle
    {
        set
        {
            styleMidClass = value;
        }
        get
        {
            return styleMidClass;
        }
    }
}
