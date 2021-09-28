using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.TrustedOrg;
using System.Collections;
using System.Reflection;
using System.Globalization;

public partial class InPatient_PatientICDSearch : BasePage
{
    public InPatient_PatientICDSearch ()
        : base("InPatient\\PatientICDSearch.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long returnCode = -1;
    string pVisitType = string.Empty;
    long visitID = 0;
   

    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    protected void Page_Load(object sender, EventArgs e)
    {
        txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
        txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {

        if (ddlType.SelectedItem.Text == "OP")
        {
            pVisitType = "0";
            //grdResult.Columns[6].Visible = false;
            //grdResult.Columns[7].Visible = false;
        }

        if (ddlType.SelectedItem.Text == "IP")
        {
            pVisitType = "1";
            grdResult.Columns[6].Visible = true;
            grdResult.Columns[7].Visible = true;
        }
        if (ddlType.SelectedItem.Text == "Both")
        {

            //grdResult.Columns[6].Visible = true;
            //grdResult.Columns[7].Visible = true;
        }


       
        string strPatientName = null;

        string strStatus = null;
        string strVisitType = null;
        List<PatientVisit> patientVisit = new List<PatientVisit>();
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        strStatus = drpICDStatus.SelectedValue.ToString();

        strVisitType = pVisitType;
        strPatientName = txtPname.Text;
        if (strPatientName == "")
        {
            strPatientName = "";
        }

        string fromDate, ToDate;

        if (txtFrom.Text == "" || txtTo.Text == "")
        {

            fromDate = "";
            ToDate = "";
            //fromDate = Convert.ToDateTime(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString());
            //ToDate = Convert.ToDateTime(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString());
        }
        else
        {
            fromDate = txtFrom.Text;
            ToDate = txtTo.Text;
        }

        returnCode = patientBL.SearchICDStatusDetails(strStatus, fromDate, ToDate, strVisitType, strPatientName, OrgID, out patientVisit);
        if (returnCode == 0 && patientVisit.Count > 0)
        {
            grdResult.Visible = true;
            lblResult.Visible = false;
            lblResult.Text = "";
            grdResult.DataSource = patientVisit;
            grdResult.DataBind();
            foreach (GridViewRow grd in grdResult.Rows)
            {
                Label l1 = (Label)grd.FindControl("lblGrdDischargedDT");
                Label l2 = (Label)grd.FindControl("lblGrdAdmissionDT");
                Label l3 = (Label)grd.FindControl("lblGrdConsultant");
                Label l4 = (Label)grd.FindControl("LblGrdVisitType");
                if (l1.Text == "01 Jan 0001")
                {
                    l1.Text = "-";
                    grdResult.Columns[7].ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                }
                if (l2.Text == "01 Jan 0001")
                {
                    l2.Text = "-";
                    grdResult.Columns[6].ItemStyle.HorizontalAlign = HorizontalAlign.Center;

                }
                if (l3.Text == "")
                {
                    l3.Text = "-";
                    grdResult.Columns[5].ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                }

                if (l4.Text == "1")
                    l4.Text = "IP";
                if (l4.Text == "0")
                    l4.Text = "OP";

            }
            
        }
        else
        {
            

            grdResult.Visible = false;
            lblResult.Visible = true;
            lblResult.Text = "No Matching Records Found!";
        }




    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Admin/Home.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
   
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        if (e.NewPageIndex == grdResult.PageCount)
        {
            ImageButton ibtnNext = (ImageButton)(grdResult.BottomPagerRow.FindControl("lnkNext"));
            if (ibtnNext != null) ibtnNext.Visible = false;
        }
        if (e.NewPageIndex >= 0)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }

    }
 
    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {

      
        int rowIndex = -1;


        if (e.CommandName == "OEdit")
        {
            rowIndex = Convert.ToInt32(e.CommandArgument);
            visitID = Convert.ToInt64(grdResult.DataKeys[rowIndex][0]);
            string pagename = string.Empty;
            DropDownList ddlICDStatus = (DropDownList)grdResult.Rows[rowIndex].FindControl("ddlICDStatus");
            Response.Redirect("../InPatient/PendingICDDetails.aspx?&vid=" + visitID , true);

        }

        if (e.CommandName == "OUpdate")
        {
            rowIndex = Convert.ToInt32(e.CommandArgument);
            visitID = Convert.ToInt64(grdResult.DataKeys[rowIndex][0]);

            //Label lblPV = (Label)grdResult.Rows[rowIndex].FindControl("lblPV");

            //visitID = Convert.ToInt64(lblPV.Text);

            DropDownList ddlICDStatus = (DropDownList)grdResult.Rows[rowIndex].FindControl("ddlICDStatus");

            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            returnCode = patientBL.UpdateICDStatus(visitID, ddlICDStatus.Text.ToString());


            if (returnCode == 0)
            {
                //Response.Write("Success");
                lblResult.Text = "Success";
            }
            else
            {

                lblResult.Text = "Failed!";
            }


        }
    }
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
}
