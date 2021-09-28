using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class DischargeSummary_ConditionOnDischarge : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void BindConditionOnDischarge(string ConditionOnDischarge,string HeaderName)
    {
        lblCOD.Text = HeaderName;
        lblCODV.Text = ConditionOnDischarge;

    }
}
