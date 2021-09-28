using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Histopath_Specimen_Details_Entry : BasePage
{
    public Histopath_Specimen_Details_Entry()
        : base("Histopath_Specimen_Details_Entry_aspx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        DateTime OrgDateTimeZoneLst = Convert.ToDateTime(OrgDateTimeZone);
        hdnOrgDateTime.Value = String.Format("{0:dd/MM/yyyy hh:mm tt}", OrgDateTimeZoneLst);
        hdnOrgDate.Value = String.Format("{0:dd/MM/yyyy}", OrgDateTimeZoneLst);
    }
}
