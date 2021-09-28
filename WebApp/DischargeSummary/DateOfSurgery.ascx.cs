using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DischargeSummary_DateOfSurgery : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public void BindDateOfSurgery(string DateOfSurgery,string HeaderName)
    {
        lblDOSH.Text = HeaderName+" :";
        lblDOS.Text = DateOfSurgery;
    }
}
