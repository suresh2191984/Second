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
using Attune.Solution.BusinessLogic_Ledger;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Linq;
using System.IO;
using System.Xml;
using System.Drawing;
using System.ComponentModel;
using Attune.Podium.ExcelExportManager;
using Attune.Podium.PerformingNextAction;
using Attune.Podium.BillingEngine;

public partial class Ledger_InvoiceLedgerOutStandingDetails : BasePage 
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
               
                hdnOrgID.Value = OrgID.ToString();
                if (CID > 0)
                {
                    hdnCID.Value = CID.ToString();
                    hdnclientType.Value = "CLP";
                }
                else
                {
                    hdnCID.Value = "0";
                    hdnclientType.Value = "CLI";
                }
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load while Outsatnding List :" + ex.ToString() + " Inner Exception-", ex.InnerException);

        }


    }
  

}
