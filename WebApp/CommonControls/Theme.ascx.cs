using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;

public partial class CommonControls_Theme : BaseControl
{
    //string styleClass = string.Empty;
    //string styleMidClass = string.Empty;
    
    List<Theme> dtItems = new List<Theme>();
    //public string AppName = string.Empty;
    //public int roleID = 0;
    //public int orgID = 0;
    //public int parentIDOP;
    //public int parentIDIP;
    // Theme_BL objTheme_BL = new Theme_BL(base.ContextInfo);
    protected void Page_Load(object sender, EventArgs e)
    {

        
       
        long retCode = -1;
        Theme_BL ThmBL = new Theme_BL(base.ContextInfo);
       List<Theme> lstThemeName = new List<Theme>();
       Hashtable ht = new Hashtable();
       retCode = ThmBL.GetTheme(out lstThemeName);
        if (retCode == 0)
            dtItems = lstThemeName;
        ht.Clear();
        foreach (Theme item in dtItems)
        {
            item.ThemeName = item.ThemeName;
            ht.Add(item.ThemeID, item.ThemeURL);
        }
        rptMenu.DataSource = dtItems;
        rptMenu.DataBind();
        ViewState["themes"] = ht;
         
            foreach (RepeaterItem item in rptMenu.Items)
            {

                HiddenField hdn = (HiddenField)item.FindControl("HdnThemeID");

                LinkButton lnk = (LinkButton)item.FindControl("BtnThemeChange");
                lnk.Attributes.Add("onclick", "javascript:setThemeID('" + hdn.Value + "');");
                

            }
         
       
  
            if (!Page.IsPostBack)
                SetTheme();
            ChangeTheme();
            

    }

    private void SetTheme()
    {
        
      

        Hashtable ht =(Hashtable) ViewState["themes"];

        foreach (DictionaryEntry dt in ht)
        {


            if (Convert.ToString(dt.Key) == Session["ThemeID"].ToString())
            {

                link.Text = "<link href=\".." + dt.Value.ToString() + "\" rel=\"stylesheet\" type=\"text/css\" />";

            }


        }


        
        
    }



    protected void BtnthemeChange_Click(object sender, EventArgs e)
    {

        ChangeTheme();
        SetTheme();

    }

    protected void ChangeTheme()
    {
        string[] valcheck = hdnSelectedID.Value.Split(',');

        if (hdnSelectedID.Value != "" && valcheck[0] != "")
        {

            if (hdnSelectedID.Value.Length == 2)
            {
                if (hdnSelectedID.Value.Contains(','))
                {
                    hdnSelectedID.Value = hdnSelectedID.Value.Replace(",", "");
                }
            }
            else
            {
                if (hdnSelectedID.Value.Contains(',') && hdnSelectedID.Value.Length > 1)
                {
                    string[] val = hdnSelectedID.Value.Split(',');
                    hdnSelectedID.Value = val[0];
                }
            }
            Theme_BL objTheme_BL = new Theme_BL(base.ContextInfo);
            objTheme_BL.UpdateThemeByLID(LID, Convert.ToInt64(hdnSelectedID.Value));
            Session.Add("ThemeID", "");
            Session.Add("ThemeID", Convert.ToInt64(hdnSelectedID.Value));
        }
    }
}

