using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Configuration;
using System.Collections;

public partial class Admin_AnalyzerType : BasePage
{
    public Admin_AnalyzerType()
        : base("Admin\\AnalyzerType.aspx")
    {
    }
    long Returncode = -1;

    Master_BL objBl = new Master_BL();
    List<AnalyzerType> lsttype = new List<AnalyzerType>();
    string IsActive = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!this.IsPostBack)
        {
            BindAnalyzerType();
        }

        //string productname = txtproductname.Text;
        //string productdescription = txtproductdes.Text;

        //if (!this.IsPostBack)
        //{
        //    this.BindGrid();
        //}

    }


    //private void BindGrid()
    //{


    //                using (DataTable dt = new DataTable())
    //                {
    //                    sda.Fill(dt);
    //                    GridView1.DataSource = dt;
    //                    GridView1.DataBind();
    //                }
    //            }
    //    }


    protected void btnSaveproduct_Click(object sender, EventArgs e)
    {

        try
        {

            AnalyzerType ObjAnalyzerType = new AnalyzerType();
            Master_BL masterbl = new Master_BL(base.ContextInfo);
            List<AnalyzerType> lstAnalyzerType = new List<AnalyzerType>();
            long returnCode = -1;
            ObjAnalyzerType.Productname = txtproductname.Text;
            ObjAnalyzerType.Productdescription = txtproductdes.Text;
            ObjAnalyzerType.OrgID = OrgID;
            if (btnSaveproduct.Text == "Save")
                ObjAnalyzerType.Productid = 0;
            else
                ObjAnalyzerType.Productid = Convert.ToInt32(ViewState["Productid"]);
            if (chkActive1.Checked == true)
            {
                IsActive = "Y";
            }
            else
            {
                IsActive = "N";
            }
            ObjAnalyzerType.IsActive = IsActive;
            //if (btnSaveproduct.Text == "Save")
            //{
            returnCode = masterbl.InsertAnalyzerType(ObjAnalyzerType, out returnCode);
            if (returnCode == 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Analyzer Details are Added/Updated Successfully!');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Analyzer Name Already Existed!');", true);
            }
            //}

            //else
            //{
            //    masterbl.UpdateAnalyzerType(ObjAnalyzerType);

            //}
            BindAnalyzerType();

            Clear();
            //btnSaveproduct.Text = "Save";

        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in Analyzertype Home page: ", ex);


        }

    }
    private void Clear()
    {

        txtproductname.Text = string.Empty;
        txtproductdes.Text = string.Empty;
        chkActive1.Checked = true;
        btnSaveproduct.Text = "Save";
    }


    protected void btneditproduct_Click(object sender, EventArgs e)
    {

        Button btneditproduct = (Button)sender;
        GridViewRow gvRow = (GridViewRow)btneditproduct.NamingContainer;
        AnalyzerType ObjAnalyzerType = new AnalyzerType();
        ObjAnalyzerType.Productname = gvRow.Cells[1].Text;
        ObjAnalyzerType.Productdescription = gvRow.Cells[2].Text;
        ObjAnalyzerType.IsActive = gvRow.Cells[3].Text;
        txtproductname.Text = ObjAnalyzerType.Productname;
        if (ObjAnalyzerType.Productdescription == "&nbsp;")
        {
            txtproductdes.Text = "";
        }
        else
        {
            txtproductdes.Text = ObjAnalyzerType.Productdescription;
        }
        ObjAnalyzerType.Productid = Convert.ToInt32(gvRow.Cells[0].Text);
        ViewState["Productid"] = ObjAnalyzerType.Productid;
        if (ObjAnalyzerType.IsActive == "Y")
        {
            chkActive1.Checked = true;
        }
        else
        {
            chkActive1.Checked = false;
        }

        btnSaveproduct.Text = "Update";


    }

    public void BindAnalyzerType()
    {


        try
        {
            //Clear();
            long returnCode = 0;
            List<AnalyzerType> lstAnalyzerType = new List<AnalyzerType>();
            Master_BL masterbl = new Master_BL(base.ContextInfo);
            returnCode = masterbl.GetAnalyzerType(out lstAnalyzerType);

            if (lstAnalyzerType.Count > 0)
            {
                gvAnalyzerType.DataSource = lstAnalyzerType;
                gvAnalyzerType.DataBind();
            }
            else
            {
                gvAnalyzerType.DataSource = null;
                gvAnalyzerType.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);

        }

    }

    protected void gvAnalyzerType_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        gvAnalyzerType.PageIndex = e.NewPageIndex;
        BindAnalyzerType();

    }





}






