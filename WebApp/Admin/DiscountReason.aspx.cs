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
using System.Xml;

public partial class Admin_DiscountReason : BasePage 
{
    public Admin_DiscountReason()
        : base(" Admin\\DiscountReason .aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (!IsPostBack)
            {

                txtDiscountCode.Text = string.Empty;
                txtDiscountReason.Text = string.Empty;
                LoadReasonMaster();
                

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error during Page load", ex);
        }
     
    }



    private void LoadReasonMaster()
    {
        long returnCode = -1;
        List<DiscountReasonMaster> lstReason = new List<DiscountReasonMaster>();
        Master_BL Reasonobj = new Master_BL(base.ContextInfo);
        returnCode = Reasonobj.GetReasonMaster(OrgID,  out lstReason);

        grdResult.DataSource = lstReason;
        grdResult.DataBind();

    }
   protected void btnSave_Click(object sender, EventArgs e)
    {
        long returncode = -1;
        List<DiscountReasonMaster> lstReason = new List<DiscountReasonMaster>();
        DiscountReasonMaster objreason = new DiscountReasonMaster();
        Master_BL BLobj = new Master_BL(base.ContextInfo);
        objreason.ReasonCode = txtDiscountCode.Text;
        objreason.ReasonDesc = txtDiscountReason.Text;

        if (HdnID.Value != "")
            objreason.ReasonId = Convert.ToInt16(HdnID.Value);
        else
            objreason.ReasonId = 0;
             returncode = BLobj.InsertReasonMaster(OrgID, objreason);
            Response.Redirect("DiscountReason.aspx");
            divInv.Attributes.Add("Style", "display:block");
    }

      protected void btnDelete_Click(object sender, EventArgs e)
      {
          
        long returncode = -1;
        List<DiscountReasonMaster> lstDiscount = new List<DiscountReasonMaster>();
        DiscountReasonMaster DisMaster = new DiscountReasonMaster();
        Master_BL DiscMaster = new Master_BL(base.ContextInfo);
        DisMaster.ReasonId  = Convert.ToInt32(HdnID.Value);

        returncode = DiscMaster.DeleteDiscountReasonMaster(OrgID,DisMaster.ReasonId);
        Response.Redirect("DiscountReason.aspx");
        divInv.Attributes.Add("Style", "display:block");
      
     }

   
   
}
