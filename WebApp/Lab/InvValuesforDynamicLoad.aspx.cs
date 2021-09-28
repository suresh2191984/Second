
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Podium.ExcelExportManager;
using System.IO;

public partial class Lab_InvValuesforDynamicLoad : BasePage
{


    public Lab_InvValuesforDynamicLoad()
        : base("Lab_InvValuesforDynamicLoad_aspx")
    {
    }

  
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
           

          
           
            if (!IsPostBack)
            {
                ACETestCodeScheme.ContextKey = OrgID + "~" + CodeSchemeType.Groups;
                
                
            }
           
        }
        catch (Exception ex)
        {
            
            CLogger.LogError("Error in Page Load: ", ex);
        }
    }

 




   
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
   
     
   protected void txtTDate_TextChanged(object sender, EventArgs e)
    {

    }
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("..//Reports//ViewReportList.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Home Page", ex);
        }
    }
}
