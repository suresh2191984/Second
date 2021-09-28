using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class InPatient_AttribWithDate : System.Web.UI.UserControl
{
    string name = string.Empty;
    public string Name
    {
        get { return name; }
        set
        {
            name = value;
            lblName.Text = value;
        }
    }
    string text = string.Empty;
    public string Text
    {
        get { return txtValue.Text; }
        set
        {
            text= value;
            txtValue.Text = value;
        }
    }

    string dataType = string.Empty;
    public string DataType
    {
        get { return dataType; }
        set
        {
            dataType = value;
            //txtValue.Text = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public void GetResult()
    {

    }
}
