using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class CommonControls_PatientPrescription : BaseControl
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

        }
    }

    public void loadData(IList<PatientPrescription> lstPatientPrescription)
    {
        if (lstPatientPrescription.Count > 0)
        {
            
            gvTreatment.DataSource = lstPatientPrescription;
            gvTreatment.DataBind();
            gvTreatment.SelectedIndex = 0;
            lblTreatment.Text = "";
            gvTreatment.HeaderRow.Height = Unit.Pixel(15);
          

        }
        else
        {
            gvTreatment.DataSource = lstPatientPrescription;
            gvTreatment.DataBind();
           // lblTreatment.Text = "No Treatment";
        }
    }

    protected void gvTreatment_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        

    }
    protected void gvTreatment_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex >= 0)
        {
            gvTreatment.PageIndex = e.NewPageIndex;
            gvTreatment.PageSize = 3;
            
        }
    }
    protected void LoadTable()
    {
       

    }
}

