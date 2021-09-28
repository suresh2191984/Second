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
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.DataAccessEngine;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventorySales.BL;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.PlatForm.BL;
using System.Collections.Generic;


public partial class InventorySales_SalesOrderPrint : Attune_BasePage
{
    InventorySales_BL inventorySalesBL;
    long SID = 0;
    List<SalesItemBasket> lstsalesdetail = new List<SalesItemBasket>();
    List<Customers> lstcustomers = new List<Customers>();
    List<Customers> lstusers = new List<Customers>();
    protected void Page_Load(object sender, EventArgs e)
    {
        inventorySalesBL = new InventorySales_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            if (Request.QueryString["SID"] != null)
            {
                SID = long.Parse(Request.QueryString["SID"]);
            }

            GetsalesDetails(SID);

            if (Request.QueryString["can"] != null)
            {
                btnCancel.Visible = true;
            }
        }

    }

    public void GetsalesDetails(long SID)
    {
        
        string poNO = string.Empty;
        string approval = string.Empty;
       // sID = Convert.ToInt32(Request.QueryString["SOID"]);

        try
        {
            long returnCode = -1;
            returnCode = inventorySalesBL.GetSalesDetails(OrgID, ILocationID, SID, InventoryLocationID, out lstsalesdetail, out lstcustomers, out lstusers);
            if (lstcustomers.Count > 0)
            {
                lblOrgName.Text = lstcustomers[0].CustomerName;
                lbladdr1.Text = lstcustomers[0].Address1;
                lblStreetAddress.Text = lstcustomers[0].Address2;
                lblcontactperson.Text = lstcustomers[0].CustomerName;
                lblCity.Text = lstcustomers[0].City;
                lblFax.Text = lstcustomers[0].FaxNumber;
                lbltinno.Text = lstcustomers[0].TINNo;
                lblemails.Text = lstcustomers[0].EmailID;
                lblcstno.Text = lstcustomers[0].CSTNo;
               
                lblPhone.Text = lstcustomers[0].Phone;
                lblMobile.Text = lstcustomers[0].Mobile;
                lblSODate.Text = lstcustomers[0].CreatedAt.ToExternalDate();   
                

            }

            if (lstsalesdetail.Count > 0)
            {
                //lblSODate.Text = lstsalesdetail[0].ExpiryDate.ToString("dd/mm/yyyy");

                lblPOID.Text =lstsalesdetail[0].PrescriptionNO.ToString();

                lblStatus.Text = lstsalesdetail[0].RakNo.ToString();

            }

            if (lstusers.Count > 0)
            {
                lblBooked.Text = lstusers[0].CustomerName;//Who is booked

            }
            if (lstsalesdetail.Count > 0)
            {
                grdResult.DataSource = lstsalesdetail;
                grdResult.DataBind();
            }




        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get Sales Details list", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
         try
        {
            long returnCode = 0;
            long orderID = Convert.ToInt64(Request.QueryString["SID"]);
            string status = StockOutFlowStatus.Cancelled;
            returnCode = inventorySalesBL.UpdateInventorySales("SalesOrder", orderID, status, LID, OrgID, ILocationID);
            if (returnCode == 0)
            {
                GetsalesDetails(orderID);
            }
        }
       
        catch (Exception ex)
        {
            CLogger.LogError("Error while Updating Approval details in ViewPurchaseOrder.aspx", ex);
            
        }
    }
    
}
