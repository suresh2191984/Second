using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;

using System.Collections;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Base;

public partial class PlatFormControls_Theme : Attune_BaseControl
{
    public PlatFormControls_Theme()
        : base("PlatFormControls_Theme_ascx")
    {}

    List<Theme> dtItems = new List<Theme>();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            long retCode = -1;
            Theme_BL ThmBL = new Theme_BL(base.ContextInfo);
            List<Theme> lstThemeName = new List<Theme>();
            Hashtable ht = new Hashtable();
            retCode = ThmBL.GetTheme(out lstThemeName);
            ht.Clear();
            foreach (Theme item in lstThemeName)
            {
                item.ThemeName = item.ThemeName;
                ht.Add(item.ThemeID, item.ThemeURL);
            }
            rptMenu.DataSource = lstThemeName;
            rptMenu.DataBind();
            ViewState["themes"] = ht;
            HiddenField hdn;
            LinkButton lnk;
            foreach (RepeaterItem item in rptMenu.Items)
            {
                hdn = (HiddenField)item.FindControl("HdnThemeID");
                lnk = (LinkButton)item.FindControl("BtnThemeChange");
                lnk.Attributes.Add("onclick", "javascript:setThemeID('" + hdn.Value + "');");
            }
            //ChangeTheme();
            string strHeader = Resources.PlatFormControls_ClientDisplay.PlatFormControls_Theme_ascx_01;
            HeaderDiv.InnerText = strHeader;
            HeaderDiv.Attributes.Add("title", strHeader);
        }
        SetTheme();
    }

    private void SetTheme()
    {
        try
        {
            hdnThemesetValue.Value = "1";
            Hashtable ht = (Hashtable)ViewState["themes"];
            foreach (DictionaryEntry dt in ht)
            {
                if (Convert.ToString(dt.Key) == Session["ThemeID"].ToString())
                {
                    link.Text = "<link media=\"all\" href=\"../PlatForm" + dt.Value.ToString() + "\" rel=\"stylesheet\" type=\"text/css\"  />";
                    if (Page.Header != null)
                    {
                        Page.Header.Controls.Add(link);
                        hdnThemesetValue.Value = "0";
                    }
                    else
                    {
                        hdnThemesetValue.Value = "1";
                    }
                }              
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }



    protected void BtnthemeChange_Click(object sender, EventArgs e)
    {
        ChangeTheme();
        SetTheme();
    }

    protected void ChangeTheme()
    {
        if (!string.IsNullOrEmpty(hdnSelectedID.Value))
        {
            long themesID = -1;
            if (hdnSelectedID.Value.Contains(","))
            {
                Int64.TryParse(hdnSelectedID.Value.Split(',')[0], out themesID);
            }
            else
            {
                Int64.TryParse(hdnSelectedID.Value,out themesID);
            }
            Theme_BL objTheme_BL = new Theme_BL(base.ContextInfo);
            objTheme_BL.UpdateThemeByLID(LID, themesID);
            Session.Add("ThemeID", "");
            Session.Add("ThemeID", themesID);
        }
    }
}
