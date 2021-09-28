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

public partial class UCDate : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //2C_Calender.Visible = false;
        //C_txtDate.Text = "";
        if (!IsPostBack)
        {
            ViewState["strDate"] = "";
        }

    }

    protected void C_btnDate_Click(object sender, EventArgs e)
    {
        if (C_Calender.Visible == false)
        {
            C_Calender.Visible = true;
        }
        else
        {
            C_Calender.Visible = false;
        }
    }


    protected void C_Calender_SelectionChanged(object sender, EventArgs e)
    {
        C_txtDate.Text = C_Calender.SelectedDate.ToShortDateString().ToString();
        ViewState["strDate"] = C_Calender.SelectedDate.ToString();
        C_Calender.Visible = false;
    }
   
    
    public string Get_Date
    {
        get
        {
            //if (ViewState["strDate"].ToString() != "")
            //{
                return ViewState["strDate"].ToString();
            //}
            //else
            //{
            //    string temp = "";
            //    return temp;
            //}
        }
        set
        {
            ViewState["strDate"] = value !=null ? value:"";
        }
    }
    //string temp = "";
    public void Clear()
    {
        //C_txtDate.Text = temp;
    }
}
