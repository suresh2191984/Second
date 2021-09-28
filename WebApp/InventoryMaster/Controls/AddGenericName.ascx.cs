using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Web.Script.Serialization;
using Attune.Kernel.PlatForm.Base;

public partial class CommonControls_AddGenericName : Attune_BaseControl
{
    public CommonControls_AddGenericName()
        : base("InventoryMaster_Controls_AddGenericName_ascx")
    { }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //InventoryWebService ws = new InventoryWebService();
            //GenericNameList lstDrugGeneric = new GenericNameList();
            //lstDrugGeneric = ws.GetSearchGenericListForUpdate(1, "");
            //if (lstDrugGeneric != null && lstDrugGeneric.lstDrugGeneric!=null && lstDrugGeneric.lstDrugGeneric.Count> 0)
            //{
            //    JavaScriptSerializer _jsonData = new JavaScriptSerializer();
            //    hdnTotalCount.Value = Convert.ToString(lstDrugGeneric.RecordCount);
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "GenerateTable(" + _jsonData.Serialize(lstDrugGeneric.lstDrugGeneric) + ");", true);
            //}
        }

    }
}
