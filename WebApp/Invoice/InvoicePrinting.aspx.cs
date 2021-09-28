using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using System.Collections;

public partial class Invoice_InvoicePrinting : BasePage
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        long InvoiceID = -1;
        if (!IsPostBack)
        {
            long ClientID;
            Int64.TryParse(Request.QueryString["ID"].ToString(), out InvoiceID);
            if (Request.QueryString["CID"] != null)
            {
                ClientID = Convert.ToInt64(Request.QueryString["CID"]);
            }
            BillPrint.LoadDetails(InvoiceID);
            BillPrint.LoadBillConfigMetadata(OrgID, ILocationID);


        }
    }
    
}
