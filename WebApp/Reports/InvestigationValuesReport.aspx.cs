using System;
using System.Collections.Generic;
using System.Web.UI;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Data;
using System.Globalization;
using System.Linq;
using ReportBusinessLogic;

public partial class Lab_InvestigationValuesReport : BasePage
{

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            AutoCompleteExtender1.ContextKey = "0" + '^' + OrgID.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in page load", ex);
        }
    }
   
}
