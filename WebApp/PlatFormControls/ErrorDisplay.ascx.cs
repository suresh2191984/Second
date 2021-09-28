using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Attune.Kernel.PlatForm.Base;
public partial class PlatFormControls_ErrorDisplay : Attune_BaseControl
{
    public PlatFormControls_ErrorDisplay()
        : base("PlatFormControls_ErrorDisplay_ascx")
    {
    }
    string status = string.Empty;    
    bool showerror = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        //lblStatus.Attributes.Add("onMouseOver", "ExpandErrorLabel('lblStatus');");        
        //lblStatus.Text = Status;
    }
    public string Status
    {
        get { return status; }
        set
        {
            status = value;
            lblStatus.Text = status;
        }
    }
    public bool ShowError
    {
        set
        {
            showerror = value;
            ShowHideError();
        }
    }

    private void ShowHideError()
    {
        lblStatus.Visible = showerror;
        //if (!showerror)
        //{
        //    lblStatus.Visible = false;
        //}
    }
}
