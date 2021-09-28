using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class DateTimePicker : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }

    private string birth_day ;//= ViewState["birth_day"].ToString(); //= ViewState("birth_day"); //= string.Empty;
    private string birth_month;// = ViewState["birth_month"].ToString();//= string.Empty;
    private string birth_year;//=ViewState["birth_year"].ToString(); //= string.Empty;

    public string BirthDay
    {
        get
        {
            return ViewState["birth_day"].ToString();
        }
        set
        {
            ViewState["birth_day"] = value;
        }
    }

    public string BirthMonth
    {
        get
        {
            return ViewState["birth_month"].ToString();
        }
        set
        {
            ViewState["birth_month"] = value;
        }
    }
    public string BirthYear
    {
        get
        {
            return ViewState["birth_year"].ToString();
        }
        set
        {
            ViewState["birth_year"] = value;
        }
    }
   
   
  

    protected void C_ddlDay_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (C_ddlDay.SelectedIndex > 0)
        {
            ViewState["birth_day"] = C_ddlDay.SelectedValue;
        }
    }
    protected void C_ddlYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (C_ddlYear.SelectedIndex > 0)
        {
            ViewState["birth_year"] = C_ddlYear.SelectedValue;
        }
    }
    protected void C_ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (C_ddlMonth.SelectedIndex > 0)
        {
            ViewState["birth_month"] = C_ddlMonth.SelectedValue;
        }
    }
}
