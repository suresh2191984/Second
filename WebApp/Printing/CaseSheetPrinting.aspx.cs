using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class Printing_CaseSheetPrinting : BasePage
{
    long patientVisitID = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["vid"] != null)
            {
                Int64.TryParse(Request.QueryString["vid"].ToString(), out patientVisitID);
                OPCaseSheet1.LoadPatientDetails(patientVisitID, 0);
            }
        }
    }
    protected void btnHome_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Reception/Home.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
}
