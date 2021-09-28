using System;
using System.Collections.Generic;
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
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class Patient_selectdiagnosis : BasePage
{
    long patientVisitID = -1;
    long previousVisitID = -1;
    long returnCode = -1;
    long patientID = -1;
    long taskID = -1;
    int complaintID = -1;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
}
