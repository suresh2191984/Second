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
using Attune.Kernel.InventoryCommon.BL;

public partial class PORequest_RequestPrint : Attune_BasePage
{
    public PORequest_RequestPrint()
        : base("PORequest_RequestPrint_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
   // Inventory_BL inventoryBL;
    List<PurchaseRequest> LstPurchaseRequest = new List<PurchaseRequest>();
    List<PurchaseRequestDetails> LstpurchaseRequestDetails = new List<PurchaseRequestDetails>();

    //int ReceivedOrgID = -1;
    //int ReceivedOrgAddID = -1;
    string PRequestID = string.Empty;
    string Status = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        List<PurchaseRequest> lstPurchaseRequest = new List<PurchaseRequest>();
        List<PurchaseRequestDetails> lstpurchaseRequestdetails = new List<PurchaseRequestDetails>();
      //  inventoryBL = new Inventory_BL(base.ContextInfo);
     

        if (!IsPostBack)
        {
            if (Request.QueryString["PORID"] != null)
            {
                PRequestID = Request.QueryString["PORID"];
            }
            //RequestPrints.LoadPurchaseRequest(PRequestID);
            var temp= PRequestID.Split('^');
                for (int i = 0; i < temp.Length; i++)
                {
                    if (temp[i] != "")
                    {
                        PurchaseRequest ids = new PurchaseRequest();
                        ids.PurchaseRequestID = Convert.ToInt64(temp[i].ToString());
                        lstPurchaseRequest.Add(ids);
                    }
                } 
            RptrReports.DataSource = lstPurchaseRequest;
            RptrReports.DataBind();

        }


    }
     

    protected void RptrReports_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        HiddenField prid = (HiddenField)e.Item.FindControl("hdnprid");
        PORequest_Controls_PurchaseRequestPrint PReqPrint = (PORequest_Controls_PurchaseRequestPrint)e.Item.FindControl("RequestPrints");
        PReqPrint.LoadPurchaseRequest(Convert.ToInt64(prid.Value)); 

    }

}