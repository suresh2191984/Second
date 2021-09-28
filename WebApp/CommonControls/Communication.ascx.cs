using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;


public partial class CommonControls_Communication : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            GetCommunicationCount();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Page_Load() method In CommonControls_Communication", ex);
        }
    }


    public void GetCommunicationCount()
    {
        Communication_BL Cmbl = new Communication_BL(base.ContextInfo);
        List<NBCommunicationMaster> lstNBCommunication = new List<NBCommunicationMaster>();
        List<NBCommunicationMaster> lstNewCommunication = new List<NBCommunicationMaster>();
        Cmbl.RetrieveNBCommunication(OrgID, RoleID, LID, out lstNBCommunication, out lstNewCommunication);
        int lstCount = 0;
        lstCount = lstNBCommunication.Count();
        lstCount += lstNewCommunication.Count();

        if (lstNBCommunication.Count == 0 && lstNewCommunication.Count == 0)
        {
            lblCount.Text = "0";
            tblMsgCount.Visible = false;
        }
        else
        {
            lblCount.Text = "Message Inbox:[ " + lstCount.ToString() + " ]";
            tblMsgCount.Visible = true;
        }
        lblCount.Enabled = lblCount.Text == "0" ? false : true;
    }


    protected void lblCount_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Broadcast/ViewCommunication.aspx");
    }
}
