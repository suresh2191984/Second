using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class CommonControls_ReferralTemplate : BaseControl
{
    long returnCode = -1;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

   public void LoadReferralTemplate(string ResultName,long VisitID)
    {
        List<Referral> lstReferral = new List<Referral>();
        new Referrals_BL(base.ContextInfo).GetReferralTemplate(ResultName, VisitID, out lstReferral);

        if (lstReferral.Count > 0)
        {
            lblReferredByDrName.Text = lstReferral[0].ReferedByPhysicianName;
            lblreferredByOrg.Text = OrgName;
            lblReferredToDrName.Text = lstReferral[0].ReferedToPhysicianName;
            lblreferredTOOrg.Text = lstReferral[0].ReferedToOrgName;
            lblReferrealTemplate.Text = lstReferral[0].ReferralNotes;

        }
    }
}
