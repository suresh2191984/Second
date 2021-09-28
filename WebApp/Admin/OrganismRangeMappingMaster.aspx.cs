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
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;

public partial class Admin_OrganismRangeMappingMaster : BasePage
{
    public Admin_OrganismRangeMappingMaster(): base("Admin_OrganismRangeMappingMaster_aspx")
    {
    }
    long returnCode = -1;  
    protected void Page_Load(object sender, EventArgs e)
    { 
        hdnOrgID.Value = Convert.ToInt32(OrgID).ToString();
    }
 
}
