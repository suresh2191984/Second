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

public partial class Masters_LabHome : BasePage
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Patient_BL objPatient_BL = new Patient_BL(base.ContextInfo);
            List<Patient> lstPatient = new List<Patient>();
            objPatient_BL.SearchPendingPhysio(OrgID, "", "", "", "","","","", out lstPatient);
            if (RoleName == "Physiotherapist")
            {
                if (lstPatient.Count > 0)
                {
                    lbtnPendingPhysio.Visible = true;
                }
                else
                {
                    lbtnPendingPhysio.Visible = false;
                }
            }

            else
            {
                lbtnPendingPhysio.Visible = false;
            }
            if (InventoryLocationID == -1)
            {
                Department1.LoadLocationUserMap();
            }

        }
    }
  
    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        try
        {
            Session["UserName"] = null;
            Response.Redirect("Home.aspx");
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
    protected void lbtnPendingPhysio_Click(object sender, EventArgs e)
    {
        
        Response.Redirect("../Dialysis/PendingPhysioSearch.aspx");
    }
}
