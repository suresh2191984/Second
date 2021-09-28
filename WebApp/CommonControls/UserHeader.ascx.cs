using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;

public partial class CommonControls_UserHeader : BaseControl
{
	public CommonControls_UserHeader()
        : base("CommonControls_UserHeader_ascx")
    {
    }
	
    protected void Page_Load(object sender, EventArgs e)
    {
        lblName.Text = UserName;
        if (RoleName != RoleHelper.Patient)
        {
            string usrMsg = Resources.CommonControls_ClientDisplay.CommonControls_PhysicianHeader_ascx_02;
            lblRolename.Text = usrMsg + RoleDescription;
        }
        else
        {
            lblRolename.Text = string.Empty;
        }
    }
}
