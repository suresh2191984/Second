using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;
using Attune.Kernel.BusinessEntities;
using System.Xml;
using System.Xml.Linq;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PORequest.BL;

public partial class PORequest_Controls_PurchaseRequestPrint : Attune_BaseControl
{
    public PORequest_Controls_PurchaseRequestPrint()
        : base("PORequest_Controls_PurchaseRequestPrint_ascx")
   {
   }
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    //Inventory_BL inventoryBL;
    List<PurchaseRequest> LstPurchaseRequest = new List<PurchaseRequest>();
    List<PurchaseRequestDetails> LstpurchaseRequestDetails = new List<PurchaseRequestDetails>();
    int ReceivedOrgID = -1;
    int ReceivedOrgAddID = -1;
    //long PRequestID = -1;
    string Status = string.Empty;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    public  void LoadPurchaseRequest(long PRID)
    {

        PORequest_BL inventoryBL = new PORequest_BL(base.ContextInfo);
        inventoryBL.GetPORequestDetail(OrgID, ILocationID, ReceivedOrgID, ReceivedOrgAddID, PRID, Status, out LstPurchaseRequest, out  LstpurchaseRequestDetails);

        if (LstPurchaseRequest.Count > 0)
        {
            lblDate.Text = LstPurchaseRequest[0].RequestDate.ToString();
            lblPORNo.Text = LstPurchaseRequest[0].PurchaseRequestNo.ToString();
            lblPORequestedBy.Text = LstPurchaseRequest[0].Comments.ToString();
            lblStatus.Text = LstPurchaseRequest[0].Status.ToString();
            lblPORToLocation.Text = LstPurchaseRequest[0].LocationName.ToString();
            lblPORFromLocation.Text = LstPurchaseRequest[0].ToLocationName.ToString(); 

        }

        if (LstpurchaseRequestDetails.Count > 0)
        {
            GridViewDetails.DataSource = LstpurchaseRequestDetails;
            GridViewDetails.DataBind();

        }




    }

}
