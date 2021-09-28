using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BillingEngine;
using Attune.Podium.BusinessEntities;

public partial class CommonControls_DueDetails : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    public long loadDueDetail(long orgID, long patientID, 
        long patientVisitID, out long finalBillID, 
        out List<FinalBill> lstDueDetail,out string VisitType)
    {

        long returnCode = -1;
        lstDueDetail = new List<FinalBill>();
        VisitType = "";

        BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
        billingEngineBL.GetDueDetails(orgID, patientID, patientVisitID, out finalBillID, out lstDueDetail,out VisitType);

        gvDueDetail.DataSource = lstDueDetail;
        gvDueDetail.DataBind();

        //for (int i = 0; i < lstDueDetail.Count; i++)
        //{
        //    dueAmount += Convert.ToDouble(lstDueDetail[i].Due);
        //}

        return returnCode;
    }
    protected void gvDueDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
    }
}
