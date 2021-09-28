using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Collections;
using System.Data.SqlClient;

public partial class Admin_CasualityMaster : BasePage
{
    public Admin_CasualityMaster()
        : base("Admin\\CasualityMaster.aspx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            
            if (!IsPostBack)
            {
                txtTstName.Text = string.Empty;
                txtCR.Text = string.Empty;
                txtCC.Text = string.Empty;
                //btnEdit.Visible = false;
                loadCasuality();
                //btnEdit.Style.Add("display", "none");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error during Page load", ex);
        }

    }

    private void loadCasuality()
    {
        long returnCode = -1;
        List<CasualtyCharges> lstCas = new List<CasualtyCharges>();
        Master_BL CasualityBL = new Master_BL(base.ContextInfo);
        returnCode = CasualityBL.GetCasuality(OrgID, out lstCas);
        grdResult.DataSource = lstCas;
        grdResult.DataBind();
    }



    protected void btnSave_Click(object sender, EventArgs e)
    {
        long returncode = -1;
        List<CasualtyCharges> lstCas = new List<CasualtyCharges>();
        CasualtyCharges Cas = new CasualtyCharges();
        Master_BL CasualityBL = new Master_BL(base.ContextInfo);
        
        Cas.TestName = txtTstName.Text;
        Cas.CasualtyCode = txtCC.Text;
        Cas.CasualtyRate =Convert.ToDecimal(txtCR.Text);
        Cas.CreatedBy = LID;
        Cas.ModifiedBy = LID;

        if (HdnID.Value != "")
            Cas.CasualtyID = Convert.ToInt32(HdnID.Value);
        else
            Cas.CasualtyID = 0;
        returncode = CasualityBL.InsertCasuality(OrgID,Cas);
        Response.Redirect("CasualityMaster.aspx");

    }

    //protected void btnEdit_Click(object sender, EventArgs e)
    //{
    //    long returncode = -1;
    //    List<CasualtyCharges> lstCas = new List<CasualtyCharges>();
    //    CasualtyCharges Cas = new CasualtyCharges();
    //    Master_BL CasualityBL = new Master_BL(base.ContextInfo);

    //    Cas.TestName = txtTstName.Text;
    //    Cas.CasualtyCode = txtCC.Text;
    //    Cas.CasualtyRate = Convert.ToDecimal(txtCR.Text);
    //    Cas.CasualtyID = Convert.ToInt32(HdnID.Value);
    //    returncode = CasualityBL.InsertCasuality(OrgID, Cas);
    //    Response.Redirect("CasualityMaster.aspx");

    //}

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
        }
        loadCasuality();
    }


   
        
}
