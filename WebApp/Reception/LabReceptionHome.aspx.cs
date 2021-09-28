using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;

public partial class Reception_LabReceptionHome : BasePage
{
    public Reception_LabReceptionHome()
        : base("Reception_LabReceptionHome_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        string strAlert = Resources.Reception_AppMsg.Reception_AddressBook_aspx_02 == null ? "Alert" : Resources.Reception_AppMsg.Reception_AddressBook_aspx_02;
        string strTaskCreat = Resources.Reception_AppMsg.Reception_LabReceptionHome_aspx_01 == null ? "Task Created Successfully" : Resources.Reception_AppMsg.Reception_LabReceptionHome_aspx_01;
        string strRatesApplied = Resources.Reception_AppMsg.Reception_LabReceptionHome_aspx_02 == null ? "Rates Applied Successfully" : Resources.Reception_AppMsg.Reception_LabReceptionHome_aspx_02;

        if (!IsPostBack)
        {
            rdoTask.Checked = true;

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt1", "javascript:SelectMaster();", true);

            if (Request.QueryString["showalert"] != null)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alrUpdateSucess", "ValidationWindow('" + strTaskCreat.Trim() + "," + strAlert.Trim() + "');", true);
            }
            if (Request.QueryString["Appalert"] != null)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alrUpdateSucess", "ValidationWindow('" + strRatesApplied.Trim() + "," + strAlert.Trim() + "');", true);
            }

           
        }
       
    }
}
