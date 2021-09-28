using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Web.Script.Serialization;
using Attune.Kernel.PlatForm.Base;

public partial class CommonControls_AddManufacturer :Attune_BaseControl
{
    public CommonControls_AddManufacturer()
        : base("InventoryMaster_Controls_AddManufacturer_ascx")
    { }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //InventoryWebService ws = new InventoryWebService();
            //GenericMfgList lstDrugGeneric = new GenericMfgList();
            //lstDrugGeneric = ws.GetManufacturerForUpdate(1, "");
            //if (lstDrugGeneric != null && lstDrugGeneric.lstManufacturer != null && lstDrugGeneric.lstManufacturer.Count > 0)
            //{
            //    JavaScriptSerializer _jsonData = new JavaScriptSerializer();
            //    hdnTotalMfgCount.Value = Convert.ToString(lstDrugGeneric.RecordCount);
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "GenerateMfgTable(" + _jsonData.Serialize(lstDrugGeneric.lstManufacturer) + ");", true);
            //}
            //else
            //{
            //    btnSaveMfgList.Attributes.Add("style", "display:none");
            //}
        }

    }
}
