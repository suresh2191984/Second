using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections;
using System.Data;
using Attune.Podium.Common;
using System.Web.Services;
using System.Web.Script.Services;
using System.Text;
using System.ServiceModel.Web;
using System.Web.Script.Serialization;

public partial class Admin_ChangeUOM : BasePage 
{
    protected void Page_Load(object sender, EventArgs e)
    {

        long returnCode = -1;
        List<UOM> lstUOM = new List<UOM>();

        Investigation_BL ObjInv_BL = new Investigation_BL(new BaseClass().ContextInfo);
        returnCode = ObjInv_BL.GetUOMCode(out lstUOM);
        if (lstUOM.Count > 0)
        {
            dlUOMCode.DataSource = lstUOM;
            dlUOMCode.DataBind();
        }
    }
    
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string IsUOMCodeExists(String UOMCode, String UOMDescription)
    {
        long returnCode = -1;
        int Count;
        Investigation_BL ObjInv_BL = new Investigation_BL(new BaseClass().ContextInfo);
        returnCode = ObjInv_BL.IsUOMCodeExists(UOMCode, UOMDescription, out Count);

        JavaScriptSerializer js = new JavaScriptSerializer();
        return js.Serialize(Count);
    }

    [WebMethod]
    public static string AddUOM(String UOMCode, String UOMDescription)
    {
        long returnCode = -1;
        int UOMID;
        Investigation_BL ObjInv_BL = new Investigation_BL(new BaseClass().ContextInfo);
        returnCode = ObjInv_BL.AddUOMCode(UOMCode, UOMDescription, out UOMID);
        
        JavaScriptSerializer js = new JavaScriptSerializer();
        return js.Serialize(UOMID);
    }

    protected void dlUOMCode_ItemDataBound(object sender, DataListItemEventArgs e)
    {

        UOM u = (UOM)e.Item.DataItem;
        string strScript = "SelectUOMCode('" + u.UOMID + "', '" + u.UOMCode + "');";
        ((RadioButton)e.Item.FindControl("rbUOMCode")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
        ((RadioButton)e.Item.FindControl("rbUOMCode")).Attributes.Add("onclick", strScript);
    }
}
