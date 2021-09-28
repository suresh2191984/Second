using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

public partial class Admin_PageContext : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int orgID = 0;
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        hdnOrgId.Value = orgID.ToString();
    }
}
