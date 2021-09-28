using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Web.Script.Serialization;
using Attune.Podium.Common;

public partial class CommonControls_ViewCommunication : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ViewCommunicationlist();
        }
    }
    protected void grdViewCommunication_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName.Equals("View"))
        {
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            long CommID = Convert.ToInt64(this.grdViewCommunication.DataKeys[rowIndex]["CommID"]);
            int CommType = Convert.ToInt16(this.grdViewCommunication.DataKeys[rowIndex]["CommType"]);
            string CommCode = (string)this.grdViewCommunication.DataKeys[rowIndex]["CommCode"];
            string ACKRequired = (string)this.grdViewCommunication.DataKeys[rowIndex]["ACKRequired"];
            Session["VCommID"] = CommID;
            Session["CommType"] = CommType;
            Session["CommCode"] = CommCode;
            Session["ACKRequired"] = ACKRequired;
            Response.Redirect("~/Broadcast/ViewDetailCommunication.aspx");
            Session["NBMessage"] = "";
            Session["NCMessage"] = "";
        }
    }

    protected void grdViewCommunication_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //e.Row.Attributes["onmouseover"] = "javascript:SetMouseOver(this)";
            //e.Row.Attributes["onmouseout"] = "javascript:SetMouseOut(this)";
            int CommCategoryID = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "CommCategoryID"));
            int Commtype = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "CommType"));
            Label lbl = (Label)e.Row.FindControl("lblTypeIndicator");
            if (Commtype == 2)
            {
                lbl.Text = "&nbsp; NB &nbsp;";
                lbl.BackColor = System.Drawing.Color.Orange;
            }
            else
            {
                lbl.Text = " &nbsp; C &nbsp; ";
                lbl.BackColor = System.Drawing.Color.CadetBlue;

            }
            if (CommCategoryID > 0)
            {
                //e.Row.Cells[1].BackColor = System.Drawing.Color.Yellow;
                e.Row.BackColor = System.Drawing.Color.White;
            }
        }
    }

    protected void lnkCommContent_Click(object sender, EventArgs e)
    {
        //Response.Redirect("~/Broadcast/ViewDetailCommunication.aspx");
    }

    public void ViewCommunicationlist()
    {
        string initiator = String.Empty;

        initiator = "Y";


        List<NBCommunicationMaster> lstViewComm = new List<NBCommunicationMaster>();
        Communication_BL InvBL = new Communication_BL(base.ContextInfo);
        lstViewComm = InvBL.ViewMasterCommunication(RoleID, initiator, LID);
        if (lstViewComm.Count > 0)
        {
            grdViewCommunication.DataSource = lstViewComm;
            grdViewCommunication.DataBind();
        }
        else
        {
            //NBCommunication.Visible = false;
        }
        if (lstViewComm.Count > 0)
        {
            grdViewCommunication.DataSource = lstViewComm;
            grdViewCommunication.DataBind();
        }
        else
        {
            //NewCommunication.Visible = false;
        }

    }

}
