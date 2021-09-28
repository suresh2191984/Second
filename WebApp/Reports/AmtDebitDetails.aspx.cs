using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;

public partial class Reports_AmtDebitDetails : BasePage
{
    long returnCode = -1;
    List<AmountDebtClosureDetails> lstACD = new List<AmountDebtClosureDetails>();
    string pathname = "";


    protected void Page_Load(object sender, EventArgs e)
    {
        //txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        // txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {

            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            pathname = GetConfigValue("AmountDepositDetails_TRF", OrgID);
            returnCode = new Report_BL().AmtDeptDetailsReport(fDate, tDate, OrgID, out lstACD);

            if (lstACD.Count > 0)
            {

                gvIPDepositMain.Visible = true;
                gvIPDepositMain.DataSource = lstACD;
                gvIPDepositMain.DataBind();
            }
            else
            {

                //CalculationPanelNone();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, CreditCardStmt", ex);
        }

    }
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        try
        {
            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
            if (lstConfig.Count > 0)
                configValue = lstConfig[0].ConfigValue;

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetConfigValue - AmountclosureDebitDetails.aspx", ex);
        }
        return configValue;
    }
    protected void gvIPDepositMain_RowDataBound(Object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            AmountDebtClosureDetails AAD = (AmountDebtClosureDetails)e.Row.DataItem;
            PlaceHolder imgPlaceHolder = (PlaceHolder)e.Row.FindControl("imgPlaceHolder");
            if (AAD.FileURL != null && AAD.FileURL != "")
            {
                string[] str = AAD.FileURL.Split(',');
                int i = 0;
                foreach (string item in str)
                {
                    LinkButton obj = new LinkButton();
                    obj.ID = i.ToString() + item;
                    obj.Text = item;
                    obj.Attributes.Add("onmouseover", "return ShowPicture(this.id,'" + pathname + item + "'); ");
                    obj.Attributes.Add("onmouseout", "HidePicture();");
                    obj.Attributes.Add("onclick", "return false");
                    i++;
                    imgPlaceHolder.Controls.Add(obj);
                }
            }
        }
    }
}