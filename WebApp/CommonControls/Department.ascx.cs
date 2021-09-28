using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.DataAccessEngine;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.TrustedOrg;
using System.Collections;
using System.Globalization;

public partial class CommonControls_Department : BaseControl
{
    public CommonControls_Department()
        : base("CommonControls_Department_ascx")
    {
    }
    private int _OrgID = 0;
    private long _RoleID = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           
        }
        if (OrgID == 0)
        {
            OrgID = OrgID;
        }
        if (URoleID == 0)
        {
            URoleID = RoleID;
        }
    }

    public void LoadLocationUserMap()
    {
        long iOrgID = Int64.Parse(OrgID.ToString());
        long returnCode = -1;
        List<LocationUserMap> lstLocationUserMap = new List<LocationUserMap>();
        returnCode = new GateWay(base.ContextInfo).GetLocationUserMap(LID, OrgID, ILocationID, out lstLocationUserMap);
        if (lstLocationUserMap.Count > 0)
        {
            ddlLocation.DataSource = lstLocationUserMap;
            ddlLocation.DataTextField = "LocationName";
            ddlLocation.DataValueField = "LocationID";
            ddlLocation.DataBind();
            ddlLocation.Items.Insert(0, "--Select Department--");
            ddlLocation.Items[0].Value = "-1";
            ddlLocation.SelectedValue = InventoryLocationID.ToString();
            mpeAttributeLocation.Show();
        }
    }

    protected void btnOk_Click(object sender, EventArgs e)
    {
        Navigation navigation = new Navigation();
        Role role = new Role();
        try
        {
           
            try
            {
                Session.Add("InventoryLocationID", ddlLocation.SelectedValue);
                Session.Add("DepartmentName", ddlLocation.SelectedItem.Text);
                
                role.RoleID = RoleID;
                List<Role> userRoles = new List<Role>();
                userRoles.Add(role);
                string relPagePath = string.Empty;
                long returnCode = -1;
                returnCode = new SharedInventory_BL(base.ContextInfo).SetDefaultInventoryLocation(LID, int.Parse(ddlLocation.SelectedValue),OrgID,ILocationID);

                returnCode = navigation.GetLandingPage(userRoles, out relPagePath);


                if (returnCode == 0)
                {
                    Response.Redirect(Request.ApplicationPath + relPagePath, true);
                }
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
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
     public int OrgID
    {
        set { _OrgID = value; }
        get { return _OrgID; }
    }
    //venkat
    public long URoleID
    {
        set { _RoleID = value; }
        get { return _RoleID; }
    }


}

