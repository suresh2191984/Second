using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.PlatForm.Base;

public partial class PlatForm_CommonControls_Captureimage : BaseControl
{
    public PlatForm_CommonControls_Captureimage()
        : base("PlatForm_CommonControls_Captureimage_ascx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(Convert.ToInt32(base.OrgID).ToString()))
        {
            WebcamhdnOrgID.Value = Convert.ToInt32(base.OrgID).ToString();
        }
        if (!String.IsNullOrEmpty(Convert.ToInt32(base.OrgID).ToString()))
        {
            hdnLoginID.Value = Convert.ToInt32(base.LID).ToString();
        } 
    }
}
