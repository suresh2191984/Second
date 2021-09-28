using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class SampleCollectionPerson_Controls_SPBookingslot : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            hdnUserID.Value = Convert.ToString(LID);
            hdnOrgID.Value = Convert.ToString(OrgID);
        }
    }
}
