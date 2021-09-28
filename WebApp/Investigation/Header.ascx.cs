using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Physician_Header : BaseControl
{
    string name = string.Empty;
    string age = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        lblName.Text = Name;
        lblAge.Text = Age;
    }
    protected void lnkLogOut_Click(object sender, EventArgs e)
    {
        LogOut();
    }
    public string Name
    {
        get { return name; }
        set { name = value; }
    }
    public string Age
    {
        get { return age; }
        set { age = value; }
    }
   
}
