using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class QMS_AnalyteMaster : BasePage
{
    
    protected void Page_Load(object sender, EventArgs e)
        {
        hdnOrgID.Value = Session["OrgID"].ToString();
    }
}
