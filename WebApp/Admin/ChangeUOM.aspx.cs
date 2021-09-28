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
public partial class Admin_ChangeUOM : BasePage 
{
    protected void Page_Load(object sender, EventArgs e)
    {
        long returnCode = -1;
        List<UOM> lstUOM = new List<UOM>();
        if (!IsPostBack)
        {
            try
            {
                returnCode = new Investigation_BL(base.ContextInfo).GetUOMCode(out lstUOM);
                if (lstUOM.Count > 0)
                {
                    dlUOMCode.DataSource = lstUOM;
                    dlUOMCode.DataBind();
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in UOM Load ", ex);
            }
        }
    }
    protected void dlUOMCode_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        //if (e.Item.ItemType == ListItemType.Item)//(e.Item.ItemType == DataControlCellType.DataCell)
       // {
            UOM u = (UOM)e.Item.DataItem;
            string strScript = "SelectUOMCode('" + ((RadioButton)e.Item.FindControl("rbUOMCode")).ClientID + "','" + u.UOMID + "', '" + u.UOMCode + "');";
            ((RadioButton)e.Item.FindControl("rbUOMCode")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Item.FindControl("rbUOMCode")).Attributes.Add("onclick", strScript);

           


       // }
    }
}
