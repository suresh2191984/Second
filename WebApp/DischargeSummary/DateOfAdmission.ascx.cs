using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DischargeSummary_DateOfAdmission : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public void BindDateOfAdmission(string BindDateOfAdmission,string HeaderName)
    {
        lblDOAH.Text = HeaderName + " :";
        lblDOA.Text = BindDateOfAdmission;
    }
}
