using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class QMS_QCResult : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hdnOrgID.Value = OrgID.ToString();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {

    }
}
