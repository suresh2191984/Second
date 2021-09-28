using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class CommonControls_SmallSummary : BaseControl
{
    string title = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        litTitle.Text = Title;
        DataTable dt = new DataTable();
        dt.Columns.Add("URL");
        dt.Columns.Add("Text");
        DataRow dr = dt.NewRow();
        dr["URL"] = "Pt.aspx";
        dr["Text"] = "Daily (13-12)Echo Reports";
        dt.Rows.Add(dr);

        DataRow dr1 = dt.NewRow();
        dr1["URL"] = "Pt.aspx";
        dr1["Text"] = "Weekly(14-7)Echo Reports";
        dt.Rows.Add(dr1);



        rptItems.DataSource = dt;
        rptItems.DataBind();
    }
    public string Title
    {
        set
        {
            title = value;
        }
        get
        {
            return title;
        }
    }
}
