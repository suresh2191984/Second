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
using System.IO;
using System.Linq;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using AjaxControlToolkit;

public partial class Admin_ManageSequenceINV : BasePage
{
    string Update_msg = Resources.AppMessages.Update_Message;

    public Admin_ManageSequenceINV()
        : base("Admin\\ManageSequenceINV.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }


    long returnCode = -1;
    DischargeSummarySeq Inv = new DischargeSummarySeq();
    List<DischargeSummarySeq> lstInvOrg = new List<DischargeSummarySeq>();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                fill();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Sequence Investigation", ex);
        }
    }
    public void fill()
    {
        try
        {
            long returnCode = -1;
            IP_BL ip = new IP_BL(base.ContextInfo);
            returnCode = ip.GetAllDischargeSummarySeq(OrgID, out lstInvOrg);
            gvReckon.DataSource = lstInvOrg;
            gvReckon.DataBind();
            GetDataTable(lstInvOrg);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in the fill function", ex);
        }
    }
    public void GetDataTable(List<DischargeSummarySeq> lstmap)
    {
        System.Data.DataTable dt = new DataTable();
        try
        {
            if (lstmap.Count > 0)
            {
                DataColumn dbCol1 = new DataColumn("DischargeSummarySeqID", typeof(Int64));
                DataColumn dbCol2 = new DataColumn("PlaceHolderID", typeof(String));
                DataColumn dbCol3 = new DataColumn("ControlName", typeof(String));
                DataColumn dbCol4 = new DataColumn("HeaderName", typeof(String));
                DataColumn dbCol5 = new DataColumn("OrgID", typeof(Int32));
                DataColumn dbCol6 = new DataColumn("IsActive", typeof(String));
                DataColumn dbCol7 = new DataColumn("SequenceNo", typeof(Int32));

                dt.Columns.Add(dbCol1);
                dt.Columns.Add(dbCol2);
                dt.Columns.Add(dbCol3);
                dt.Columns.Add(dbCol4);
                dt.Columns.Add(dbCol5);
                dt.Columns.Add(dbCol6);
                dt.Columns.Add(dbCol7);

                foreach (DischargeSummarySeq org in lstmap)
                {
                    DataRow dr = dt.NewRow();
                    dr["DischargeSummarySeqID"] = org.DischargeSummarySeqID;
                    dr["PlaceHolderID"] = org.PlaceHolderID;
                    dr["ControlName"] = org.ControlName;
                    dr["HeaderName"] = org.HeaderName;
                    dr["OrgID"] = OrgID;
                    dr["IsActive"] = org.IsActive;
                    dr["SequenceNo"] = org.SequenceNo;
                    dt.Rows.Add(dr);
                }
            }
            ViewState["Reckon"] = dt;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Sequence Investigation", ex);
        }
    }
    protected void Gvbound(object se, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ImageButton imgclose = (ImageButton)e.Row.FindControl("imgclose");
            ImageButton imgright = (ImageButton)e.Row.FindControl("imgright");
            HiddenField hdn = (HiddenField)e.Row.FindControl("hdnremove");
            //HiddenField hdnFlag = (HiddenField)e.Row.FindControl("hdnFlag");
            //if(hdnFlag.Value=="0")
            //{
            //    imgclose.Visible = true;
            //   imgright.Visible = false;
            //}else{
            //    imgclose.Visible = true;
            //    imgright.Visible = false;
            //}


            hdndata.Value += imgclose.ClientID + "~" + imgright.ClientID + "~" + hdn.ClientID + "^";
            string strScript = "SelectInvSeqRowCommon('" + ((RadioButton)e.Row.FindControl("rdbcheck")).ClientID + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdbcheck")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdbcheck")).Attributes.Add("onclick", strScript);
            if (e.Row.DataItem != null)
            {
                DischargeSummarySeq dis = (DischargeSummarySeq)e.Row.DataItem;
                //((System.Data.DataRowView)(e.Row.DataItem)).Row.ItemArray[5]
                ImageButton img = (ImageButton)e.Row.FindControl("imgright");
                ImageButton close = (ImageButton)e.Row.FindControl("imgclose");
                if (dis.IsActive.Trim() == "Y")
                {
                    img.Visible = true;
                    close.Visible = false;
                }
                else
                {
                    img.Visible = false;
                    close.Visible = true;

                }

            }
        }
    }
    protected void gvReckon_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            DataTable dt = (DataTable)ViewState["Reckon"];
            int selRow = Convert.ToInt32(e.CommandArgument);
            int swapRow = 0;
            int MoveRow = 0;
            int rowindex = 0;
            int count = gvReckon.Rows.Count;
            GridViewRow grd = (GridViewRow)gvReckon.Rows[Convert.ToInt16(e.CommandArgument)];
            if (dt != null && dt.Rows.Count > 0)
            {
                //if (e.CommandName == "UP")
                //{
                //    if (selRow > 0)
                //    {
                //        swapRow = selRow - 1;
                //        string strTempDtlID = dt.Rows[selRow]["InvestigationID"].ToString();
                //        string strTempValue = dt.Rows[selRow]["InvestigationName"].ToString();
                //        dt.Rows[selRow]["InvestigationID"] = dt.Rows[swapRow]["InvestigationID"];
                //        dt.Rows[selRow]["InvestigationName"] = dt.Rows[swapRow]["InvestigationName"];
                //        dt.Rows[swapRow]["InvestigationName"] = strTempValue;
                //        dt.Rows[swapRow]["InvestigationID"] = strTempDtlID;
                //        gvReckon.DataSource = dt;
                //        gvReckon.DataBind();
                //    }
                //}
                //else if (e.CommandName == "DOWN")
                //{
                //    if (selRow < dt.Rows.Count - 1)
                //    {
                //        swapRow = selRow + 1;
                //        string strTempDtlID = dt.Rows[selRow]["InvestigationID"].ToString();
                //        string strTempValue = dt.Rows[selRow]["InvestigationName"].ToString();
                //        dt.Rows[selRow]["InvestigationID"] = dt.Rows[swapRow]["InvestigationID"];
                //        dt.Rows[selRow]["InvestigationName"] = dt.Rows[swapRow]["InvestigationName"];
                //        dt.Rows[swapRow]["InvestigationName"] = strTempValue;
                //        dt.Rows[swapRow]["InvestigationID"] = strTempDtlID;
                //        gvReckon.DataSource = dt;
                //        gvReckon.DataBind();
                //    }
                //}
                if ((e.CommandName == "Move"))
                {
                    foreach (GridViewRow GR in gvReckon.Rows)
                    {
                        RadioButton rdb = (RadioButton)GR.FindControl("rdbcheck");
                        ImageButton img = (ImageButton)GR.FindControl("imgright");
                        if ((rdb.Checked))
                        {
                            rowindex = GR.RowIndex;
                            if (rowindex > selRow)
                            {
                                for (int i = rowindex; i > selRow; i--)
                                {
                                    string strTempDtlID = dt.Rows[i]["DischargeSummarySeqID"].ToString();
                                    string strTempValue = dt.Rows[i]["HeaderName"].ToString();
                                    string stractive = dt.Rows[i]["IsActive"].ToString();
                                    //string strcontrol = dt.Rows[i]["PlaceHolderID"].ToString();
                                    dt.Rows[i]["DischargeSummarySeqID"] = dt.Rows[i - 1]["DischargeSummarySeqID"];
                                    dt.Rows[i]["HeaderName"] = dt.Rows[i - 1]["HeaderName"];
                                    dt.Rows[i]["IsActive"] = dt.Rows[i - 1]["IsActive"];
                                    //dt.Rows[i]["PlaceHolderID"] = dt.Rows[i - 1]["PlaceHolderID"];
                                    dt.Rows[i - 1]["DischargeSummarySeqID"] = Int64.Parse(strTempDtlID);
                                    dt.Rows[i - 1]["HeaderName"] = strTempValue;
                                    dt.Rows[i - 1]["IsActive"] = stractive;
                                    ////dt.Rows[i - 1]["PlaceHolderID"] = strcontrol;
                                }
                            }
                            else if (rowindex < selRow)
                            {
                                for (int i = rowindex; i < selRow; i++)
                                {
                                    string strTempDtlID = dt.Rows[i]["DischargeSummarySeqID"].ToString();
                                    string strTempValue = dt.Rows[i]["HeaderName"].ToString();
                                    string stractive = dt.Rows[i]["IsActive"].ToString();
                                    //string strcontrol = dt.Rows[i]["PlaceHolderID"].ToString();
                                    dt.Rows[i]["DischargeSummarySeqID"] = dt.Rows[i + 1]["DischargeSummarySeqID"];
                                    dt.Rows[i]["HeaderName"] = dt.Rows[i + 1]["HeaderName"];
                                    dt.Rows[i]["IsActive"] = dt.Rows[i + 1]["IsActive"];
                                    //dt.Rows[i]["PlaceHolderID"] = dt.Rows[i + 1]["PlaceHolderID"];
                                    dt.Rows[i + 1]["DischargeSummarySeqID"] = Int64.Parse(strTempDtlID);
                                    dt.Rows[i + 1]["HeaderName"] = strTempValue;
                                    dt.Rows[i + 1]["IsActive"] = stractive;
                                    //dt.Rows[i + 1]["PlaceHolderID"] = strcontrol;
                                }
                            }
                            List<DischargeSummarySeq> seq = new List<DischargeSummarySeq>();
                            Utilities.ConvertTo(dt, out seq);
                            gvReckon.DataSource = seq;
                            gvReckon.DataBind();
                        }
                    }
                }
                //else
                //{
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('The selected Location is INActive.');", true);                  
                //}
            }
            if (e.CommandName.Equals("right"))
            {
                GridViewRow gr = (GridViewRow)gvReckon.Rows[Convert.ToInt16(e.CommandArgument)];
                if (gr.FindControl("imgright") != null && gr.FindControl("imgclose") != null)
                {
                    gr.FindControl("imgright").Visible = false;
                    gr.FindControl("imgclose").Visible = true;
                }
            }
            else if (e.CommandName.Equals("close"))
            {
                GridViewRow gr = (GridViewRow)gvReckon.Rows[Convert.ToInt16(e.CommandArgument)];
                if (gr.FindControl("imgright") != null && gr.FindControl("imgclose") != null)
                {
                    gr.FindControl("imgright").Visible = true;
                    gr.FindControl("imgclose").Visible = false;
                }
            }
            ViewState["Reckon"] = dt;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Sequence Investigation", ex);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            IP_BL objInv = new IP_BL(base.ContextInfo);
            GetDataTable(filldata());
            DataTable dt = (DataTable)ViewState["Reckon"];
            returnCode = objInv.SaveDischargeseqDetails(OrgID, dt);
            fill();
            //filldata();
            if (returnCode == 0 || returnCode > 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('"+Update_msg+"');", true);
               // ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('Changes saved successfully.');", true);
                // this.Page.RegisterStartupScript("key1", "<script language='javascript' >alert('Changes saved successfully.'); </script>");
                //ClientScript.RegisterStartupScript(this.GetType(), "m", "alert('Changes saved successfully.');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Saving Sequence Investigation", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);
            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Saving Sequence Investigation", ex);
        }
    }

    public List<DischargeSummarySeq> filldata()
    {
        List<DischargeSummarySeq> lst = new List<DischargeSummarySeq>();
        try
        {
            foreach (GridViewRow gr in gvReckon.Rows)
            {
                if (gr.RowType == DataControlRowType.DataRow)
                {
                    DischargeSummarySeq discharge = new DischargeSummarySeq();
                    TextBox txtheader = (TextBox)gr.FindControl("txtheadername");
                    Label lbldischargeID = (Label)gr.FindControl("dischargeid");
                    Label lblPlaceHolderID = (Label)gr.FindControl("PlaceHolderID");
                    Label lblseq = (Label)gr.FindControl("sequence");
                    CheckBox chkselect = (CheckBox)gr.FindControl("chk");
                    ImageButton img = (ImageButton)gr.FindControl("imgright");
                    discharge.HeaderName = txtheader.Text.ToString();
                    discharge.DischargeSummarySeqID = int.Parse(lbldischargeID.Text);
                    discharge.IsActive = img.Visible == true ? "Y" : "N";
                    discharge.PlaceHolderID = lblPlaceHolderID.Text.ToString();
                    discharge.SequenceNo = int.Parse(lblseq.Text);
                    lst.Add(discharge);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in filldata", ex);
        }
        return lst;
    }
}

   
    
