using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Physician_PhysicianHeader : BaseControl
{
    public Physician_PhysicianHeader()
        : base("Physician_PhysicianHeader_ascx")
    {
    }
	
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            lblName.Text = UserName;
        string UsrMsg = Resources.CommonControls_ClientDisplay.CommonControls_PhysicianHeader_ascx_02;
        lblRolename.Text = UsrMsg + RoleDescription;

    }
    protected void lnkLogOut_Click(object sender, EventArgs e)
    {
        LogOut();
    }
    
}
