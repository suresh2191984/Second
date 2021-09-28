using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Histopathology_EnterTissueType : BasePage
{
    public Histopathology_EnterTissueType()
        : base("Histopathology_EnterTissueType_aspx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        DateTime OrgDateTimeZoneLst = Convert.ToDateTime(OrgDateTimeZone);

        hdnOrgDate.Value = String.Format("{0:dd/MM/yyyy}", OrgDateTimeZoneLst);

    }
}
