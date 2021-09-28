﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class DischargeSummary_PrimaryConsultant : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }




    public void BindPrimaryConsultant(string primaryConsultant, string HeaderName)
    {
        lblConsultantT.Text = HeaderName + " :";
        lblConsultant.Text = primaryConsultant;
    }
}
