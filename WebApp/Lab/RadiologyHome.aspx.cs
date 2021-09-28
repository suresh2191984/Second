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
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;

public partial class Masters_RadiologyHome : BasePage
{
    int currentPageNo = 1;

    int PageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        //uctlTaskList. onTaskSelectFailed += new EventHandler(uctlTaskList_onTaskSelectFailed);


        //DropDownList objDropDownList = (DropDownList)uctlTaskList.FindControl("ddCat");         // ((CommonControls_TasksNew)(uctlTaskList)).ddCat.
        //objDropDownList.Attributes.Add("onchange", "ddlValuesCheck(this)");
        loadGrid(currentPageNo, PageSize);



        //if (!IsPostBack)
        //{
        //   // uctlPendingVitals.OrgID = 1;
        //}
    }

    //protected void uctlTaskList_onTaskSelectFailed(object sender, EventArgs e)
    //{
    //    CommonControls_Tasks tsk = (CommonControls_Tasks)sender;
    //    long iPatientID = uctlTaskList.SelectedPatient;
    //    long iTaskID = uctlTaskList.SelectedTask;
    //    string redirectURL = uctlTaskList.RedirectURL;
    //    redirectURL = string.Format(redirectURL, iPatientID.ToString());

    //    Response.Redirect(redirectURL);
    //}

    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        Session["UserName"] = null;
        Response.Redirect("Home.aspx");
    }

    public void loadGrid(int currentPageNo, int PageSize)
    {
        Investigation_BL callBL = new Investigation_BL(base.ContextInfo);
        List<PatientVisitDetails> lstDetails = new List<PatientVisitDetails>();
        LoginDetail objLoginDetail = new LoginDetail();
        objLoginDetail.LoginID = LID;
        objLoginDetail.RoleID = RoleID;
        objLoginDetail.Orgid = OrgID;

        callBL.GetLabInvestigation(ILocationID, OrgID, RoleID, currentPageNo, PageSize, out lstDetails, out totalRows, -1, objLoginDetail);
        if (lstDetails.Count > 0)
        {
            totalpage = totalRows;
            lblTotal.Text = CalculateTotalPages(totalRows).ToString();


            if (hdnCurrent.Value == "")
            {
                lblCurrent.Text = currentPageNo.ToString();
            }
            else
            {
                lblCurrent.Text = hdnCurrent.Value;
                currentPageNo = Convert.ToInt32(hdnCurrent.Value);
            }

            if (currentPageNo == 1)
            {
                Btn_Previous.Enabled = false;

                if (Int32.Parse(lblTotal.Text) > 1)
                {
                    Btn_Next.Enabled = true;
                }
                else
                    Btn_Next.Enabled = false;

            }

            else
            {
                Btn_Previous.Enabled = true;

                if (currentPageNo == Int32.Parse(lblTotal.Text))
                    Btn_Next.Enabled = false;
                else Btn_Next.Enabled = true;
            }
            dCapture.Visible = true;
            dCaption.Visible = true;
            GridView1.DataSource = lstDetails;
            GridView1.DataBind();
        }
    }

    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);

        return totalPages;
    }
    protected void Btn_Previous_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            loadGrid(currentPageNo, PageSize);
        }

        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            loadGrid(currentPageNo, PageSize);
        }
    }
    protected void Btn_Next_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            loadGrid(currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            loadGrid(currentPageNo, PageSize);
        }

    }
    protected void btnGo_Click(object sender, EventArgs e)
    {


        hdnCurrent.Value = txtpageNo.Text;
        loadGrid(Convert.ToInt32(txtpageNo.Text), PageSize);



    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            PatientVisitDetails PVD = (PatientVisitDetails)e.Row.DataItem;
            if (PVD.Status == "Reject")
            {
                e.Row.ForeColor = System.Drawing.Color.Red;
                HtmlAnchor ctr = (HtmlAnchor)e.Row.FindControl("lnklist");
                ctr.Style.Add("color", "Red");
                //e.Row.Style["text-decoration"] = "none";
                //e.Row.Attributes.Add("onmouseover", "this.style.cursor='pointer';this.style.color='Red';");
                //e.Row.Attributes.Add("onmouseout", "this.style.color='Black';");


            }
        }
    }
}
