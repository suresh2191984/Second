using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class QMS_PNC : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hdnOrgID.Value = OrgID.ToString();
    }
}
