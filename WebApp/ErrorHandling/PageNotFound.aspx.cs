using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.PlatForm.Utility;

using Attune.Kernel.PlatForm.Base;
public partial class ErrorHandling_PageNotFound : Attune_BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        CLogger.LogWarning("Redirect Page to : " + Request.RawUrl);
    }
}
