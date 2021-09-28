using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using System.Web.UI.HtmlControls;

public partial class CommonControls_OrderedSamples : BaseControl
{
    string status = string.Empty;
   
    public HiddenField isHistoFlagActive
    {
        get
        {
            return this.HdnIsFlagActive;
        }
    } 

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["Status"] != null && Request.QueryString["Status"] != "")
        {
            status = Request.QueryString["Status"];
        }
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Specimen", "Specimenautocomplete();", true);
    }
   
    public void LoadSamples(List<PatientInvestigation> lstPatientInvestigation)
    {
        if (lstPatientInvestigation.Count() > 0)
        {
            dlInvName.DataSource = lstPatientInvestigation;
            dlInvName.DataBind();
            dlInvName.Visible = true;
            lblInvStatus.Visible = false;

        }
        else
        {
            dlInvName.Visible = false;
            lblInvStatus.Visible = true;
        }

    }
    protected void dlInvName_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        string strINV = Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_04 == null ? "INV" : Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_04;
        string strPaid = Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_05 == null ? "Paid" : Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_05;
        string strSampleCollect = Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_06 == null ? "SampleCollected" : Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_06;
        string strReTest = Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_07 == null ? "Retest" : Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_07;
        string strRecheck = Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_08 == null ? "Recheck" : Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_08;
        string strReflex = Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_09 == null ? "ReflexTest" : Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_09;
        string strOutSource = Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_10 == null ? "OutSource" : Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_10;

        string strRC = Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_11 == null ? "RC" : Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_11;
        string strRR = Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_12 == null ? "RR" : Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_12;
        string strRF = Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_13 == null ? "RF" : Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_13;


        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Label lblStatus = (Label)e.Item.FindControl("lblStatus");
            Label lblInvName1 = (Label)e.Item.FindControl("lblInvName1");
            HtmlInputButton btnInvName = (HtmlInputButton)e.Item.FindControl("btnInvName");
          
            Label Label1 = (Label)e.Item.FindControl("Label1");
            Label Label2 = (Label)e.Item.FindControl("Label2");
            Label lblPackageName = (Label)e.Item.FindControl("lblPackageName");
            HtmlInputHidden lblInvestigationID = (HtmlInputHidden)e.Item.FindControl("lblInvestigationID");
            HtmlInputHidden lblType = (HtmlInputHidden)e.Item.FindControl("lblType");
            HtmlInputHidden lbInvName = (HtmlInputHidden)e.Item.FindControl("lbInvName");

            HtmlInputHidden ISSpecialTest = (HtmlInputHidden)e.Item.FindControl("isSpecialTest");
         //   Button btngetSpecimen = (Button)e.Item.FindControl("BtnSpecimen");
            HtmlInputButton btngetSpecimen = (HtmlInputButton)e.Item.FindControl("BtnSpecimen");

            if (ISSpecialTest.Value == "1")
            {
                btngetSpecimen.Attributes.Add("style", "color:Red;display:block;  font-size:10pt; font-weight:bold; text-decoration:underline; background-color:Transparent;");
                HdnIsFlagActive.Value =HdnIsFlagActive.Value +"~"+ "Y" + "~";
            }
            else
            {
                HdnIsFlagActive.Value =HdnIsFlagActive.Value +"~"+ "N"+"~";
            }
             
            btngetSpecimen.Attributes.Add("onclick", "javascript:CallSpecimenValues('" + lblInvestigationID.Value + "','" + lblType.Value + "','" + lbInvName.Value + "')");
            Label lblPatientStatus = (Label)e.Item.FindControl("lblPatientStatus");
            Label lblTestStatus = (Label)e.Item.FindControl("lblStatusDisplayText");
            HtmlInputHidden lblPatStatus = (HtmlInputHidden)e.Item.FindControl("lblPatientStatus1");
			PatientInvestigation oPINV = (PatientInvestigation)e.Item.DataItem;
            lblPackageName.Text = String.IsNullOrEmpty(oPINV.PackageName) ? string.Empty : "<br/><span style='padding-left:25px;font-size:9px;'>(" + oPINV.PackageName + ")</span>";
            btnInvName.Visible = true;
            lblInvName1.Visible = false;
            if (lblType.Value == strINV.Trim())
            {
                btnInvName.Visible  = false;
                lblInvName1.Visible = true;
               
            }

            status = Request.QueryString["Status"];

if (lblStatus.Text.Trim() != strPaid.Trim() && lblStatus.Text.Trim() != strSampleCollect.Trim())
            {
                if (lblStatus.Text == strReTest.Trim())
                {
                    Label1.Visible = false;
                    Label2.Visible = false;
                    lblInvName1.Visible = false;
                    lblStatus.Visible = false;
                    lblTestStatus.Visible = false;
                }
                else if (lblStatus.Text == strRecheck.Trim())
                {
                    Label1.Visible = false;
                    Label2.Visible = false;
                    lblInvName1.Visible = false;
                    lblStatus.Visible = false;
                    lblTestStatus.Visible = false;
                }
                else if (lblStatus.Text == strReflex.Trim())
                {
                    Label1.Visible = false;
                    Label2.Visible = false;
                    lblInvName1.Visible = false;
                    lblStatus.Visible = false;
                    lblTestStatus.Visible = false;
                }
                else
                {
                    lblPatientStatus.Visible = false;
                }
            }

            if (lblPatStatus.Value.Trim() != "")
            {
                if (lblPatStatus.Value == strReTest.Trim())
                {
                    lblPatientStatus.Visible = true;
                    lblPatientStatus.Text = strRC.Trim();
                    lblPatientStatus.ForeColor = System.Drawing.Color.Black;
                    lblPatientStatus.BackColor = System.Drawing.Color.Yellow;
                }
                else if (lblPatStatus.Value == strRecheck.Trim())
                {
                    lblPatientStatus.Visible = true;
                    lblPatientStatus.Text = strRR.Trim();
                    lblPatientStatus.ForeColor = System.Drawing.Color.Black;
                    lblPatientStatus.BackColor = System.Drawing.Color.Yellow;
                }
                else if (lblPatStatus.Value == strReflex.Trim())
                {
                    lblPatientStatus.Visible = true;
                    lblPatientStatus.Text = strRF.Trim();
                    lblPatientStatus.ForeColor = System.Drawing.Color.Black;
                    lblPatientStatus.BackColor = System.Drawing.Color.Yellow;
                }
                else
                {
                    lblPatientStatus.Visible = false;
                }
            }
           

            btnInvName.Attributes.Add("onclick", "javascript:GetGroupName1('" + lblInvestigationID.Value + "','" + lblType.Value + "','" + lbInvName.Value + "')");

            if (lblStatus.Text == strOutSource.Trim())
            {
                //btnInvName.ForeColor = System.Drawing.Color.OrangeRed;
                lblStatus.ForeColor = System.Drawing.Color.OrangeRed;
                Label1.ForeColor = System.Drawing.Color.OrangeRed;
                Label2.ForeColor = System.Drawing.Color.OrangeRed;
            }
        
        }
    }
}
