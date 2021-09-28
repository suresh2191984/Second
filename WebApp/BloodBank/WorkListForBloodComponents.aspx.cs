using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using System.Collections;
using System.Text;
using System.Data;

public partial class BloodBank_WorkListForBloodComponents : BasePage 
{
    List<BloodSeparationDetails> lstBloodBags = new List<BloodSeparationDetails>();
    List<BloodSeparationDetails> lstBagsInStock = new List<BloodSeparationDetails>();
    long ReturnCode = -1;
    long ProductID = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        BillingEngine billingBL = new BillingEngine(base.ContextInfo);
        billingBL.GetBloodBags(ProductID,out lstBloodBags);
        if (lstBloodBags.Count() > 0)
        {
            gvSummary.DataSource = lstBloodBags;
            gvSummary.DataBind();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "There is no Data ", true);
        }

    }
}
