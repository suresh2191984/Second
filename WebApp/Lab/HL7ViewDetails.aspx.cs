using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using System.IO;

public partial class Lab_HL7View : BasePage
{
    Investigation_BL InvestigationBL = new Investigation_BL();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                string txtInvastigation = string.Empty;
                string txtDateTime = string.Empty;
                string txtIdentifier = string.Empty;
                string Inbound = string.Empty;

                imgBtnXL.Visible = false;
                lnkExportXL.Visible = false;

                txtFrom.Text = System.DateTime.Now.ToShortDateString();

                txtInvastigation = txtInvestigationName.Text != "" ? txtInvestigationName.Text : null;
                txtDateTime = txtFrom.Text != "" ? txtFrom.Text : null;
                txtIdentifier = txtpIdentifier.Text != "" ? txtpIdentifier.Text : null;

                foreach (ListItem item in rdInbound.Items)
                {
                    if (item.Selected)
                    {
                        Inbound = item.Value.ToString();
                    }
                    else
                    {
                        Inbound = null;
                    }
                }

                DataSet dts = new DataSet();
                dts = hlmessagedetails(OrgID, txtInvastigation, Inbound, txtDateTime, txtIdentifier);
                if (dts.Tables.Count == 0)
                {
                    grdHLresult.DataSource = null;
                    grdHLresult.DataBind();
                }
                else
                {
                    grdHLresult.DataSource = dts.Tables[0].DefaultView;
                    grdHLresult.DataBind();
                }
                Clear();

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in investigation_BatchwiseEnterResilt on page_load", ex);
        }
    }
    public System.Data.DataSet hlmessagedetails(int orgid, string MessageControlId, string MessageType, string txtDateTime, string PatientIdentifier)
    {
        DataSet ds = new DataSet();
        try
        {
            ds = InvestigationBL.GetHLMessageDetails(orgid, MessageControlId, MessageType, txtDateTime, PatientIdentifier);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in BL GetInvestigationsDetail", ex);
        }
        return ds;
    }
    protected void btnBatchSearch_Click(object sender, EventArgs e)
    {
        try
        {
            string txtInvastigation = string.Empty;
            string txtDateTime = string.Empty;
            string txtIdentifier = string.Empty;
            string Inbound = string.Empty;


            txtInvastigation = txtInvestigationName.Text != "" ? txtInvestigationName.Text : null;
            txtDateTime = txtFrom.Text != "" ? txtFrom.Text : null;
            txtIdentifier = txtpIdentifier.Text != "" ? txtpIdentifier.Text : null;

            foreach (ListItem item in rdInbound.Items)
            {
                if (item.Selected)
                {
                    Inbound = item.Value.ToString();
                }
                else
                {
                    Inbound = null;
                }
            }

            DataSet dtset = new DataSet();
            dtset = hlmessagedetails(OrgID, txtInvastigation, Inbound, txtDateTime, txtIdentifier);
            if (dtset.Tables.Count == 0)
            {
                grdHLresult.DataSource = null;
                grdHLresult.DataBind();

            }
            else
            {
                grdHLresult.DataSource = dtset.Tables[0].DefaultView;
                grdHLresult.DataBind();
            }
            Clear();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in investigation_BatchwiseEnterResilt on page_load", ex);
        }
    }
    public void Clear()
    {
        txtInvestigationName.Text = "";
        txtpIdentifier.Text = "";
    }
    public void ExportToExcel()
    {
        try
        {
            if (grdHLresult.Rows.Count > 0)
            {
                Response.ClearContent();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "PendingList" + Convert.ToDateTime(OrgDateTimeZone).ToString("ddMMyyyyHHMMss") + ".xls"));
                Response.ContentType = "application/ms-excel";
                StringWriter sw = new StringWriter();
                HtmlTextWriter htw = new HtmlTextWriter(sw);

                /*Change the Header Row back to white color*/
                grdHLresult.HeaderRow.Style.Add("background-color", "#FFFFFF");
                /*Applying stlye to gridview header cells*/
                for (int i = 0; i < grdHLresult.HeaderRow.Cells.Count; i++)
                {
                    grdHLresult.HeaderRow.Cells[i].Style.Add("background-color", "#df5015");
                }
                grdHLresult.RenderControl(htw);
                Response.Write(sw.ToString());
                Response.End();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in BL GetInvestigationsDetail", ex);
        }
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            ExportToExcel();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in BL GetInvestigationsDetail", ex);
        }
    }
}
