using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;

public partial class CommonControls_PatientOrgHeader : BaseControl
{
    long returnCode = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        //lblOrgName.Text = "Attune";
        if (!IsPostBack)
        {
            try
            {
                
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in OrgHeader Page Load", ex);
            }
        }
    }
    protected void lnkLogOut_Click(object sender, EventArgs e)
    {
        LogOut();
    }
}

