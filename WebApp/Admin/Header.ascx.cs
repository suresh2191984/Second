using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Nurse_Header : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblName.Text = Name;
    }
    protected void lnkLogOut_Click(object sender, EventArgs e)
    {
        LogOut();
    }
    
}
