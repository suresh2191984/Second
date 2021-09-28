using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Reception_printpopup : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["IP"] == "Y")
        {
            ucIP.Visible = true;
            ucPatReg.Visible = false;
        }
        else if (Request.QueryString["OP"] == "Y")
        {
            ucIP.Visible = false;
            ucPatReg.Visible = true;
        }
    }
}
