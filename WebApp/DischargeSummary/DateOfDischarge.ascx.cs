using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class DischargeSummary_DateOfDischarge :BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public void BindDateOfDischarge(string DateOfDischarge,string HeaderName)
    {
        lblDODH.Text = HeaderName+" :";
        lblDOD.Text = DateOfDischarge;
    }
}
