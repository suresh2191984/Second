using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessLogic_Ledger;
using System.Collections.Generic;
using Attune.Podium.Common;
using Attune.Podium.ExcelExportManager;

public partial class Ledger_AdvancePaymentRecommend : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                //AutoCompleteExtender1.ContextKey = OrgID.ToString() + "~" + "CLIENTZONE" + "~" + -1;
                hdnOrgID.Value = OrgID.ToString();
                hdnCID.Value = CID.ToString();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load while RecommendList :" + ex.ToString() + " Inner Exception-", ex.InnerException);
        }
    }
}
