using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using System.Collections;


public partial class InPatient_EditTPAPayment : BasePage 
{int orgid = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            long returnCode = -1;
            long visitID = -1;
            long patientID = -1;

            List<TPAPayments> lpaymentDetais = new List<TPAPayments>();
            Int64.TryParse(Request.QueryString["vid"].ToString(), out visitID);
            Int64.TryParse(Request.QueryString["PID"].ToString(), out patientID);
            Int32.TryParse(Request.QueryString["OrgID"].ToString(), out orgid);
            if (visitID != 0)
            {
                returnCode = new IP_BL(base.ContextInfo).GetPTPAPaymentDetails(visitID, patientID, orgid, out lpaymentDetais);
            }
            if (lpaymentDetais.Count > 0)
            {
                grdTPACollection.DataSource = lpaymentDetais;
                grdTPACollection.DataBind();
            }
        }

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        long finalBillID = -1;
        long VisitID = -1;
        long PatientID = -1;
        int TypeID = -1;
        decimal amount = 0, TDS = 0, RightOff = 0;
        long returncode = -1;
        string Status = string.Empty;

        List<PatientDueChart> pDueChrt = new List<PatientDueChart>();
        foreach (GridViewRow GR in grdTPACollection.Rows)
        {

            PatientDueChart PDChart = new PatientDueChart();
            PatientID = Convert.ToInt64(grdTPACollection.DataKeys[GR.RowIndex][0].ToString());
            VisitID = Convert.ToInt64(grdTPACollection.DataKeys[GR.RowIndex][1].ToString());
            finalBillID = Convert.ToInt64(grdTPACollection.DataKeys[GR.RowIndex][2].ToString());
            TextBox txtAmt = (TextBox)GR.FindControl("txtTPAAmount");
            if (txtAmt.Text != string.Empty)
            {
                amount = Convert.ToDecimal(txtAmt.Text);
            }

            if (txtTDS.Text != string.Empty)
            {
                TDS = Convert.ToDecimal(txtTDS.Text);
                //Status = "Completed";
            }

            if (txtWriteOff.Text != string.Empty)
            {
                RightOff = Convert.ToDecimal(txtWriteOff.Text);
                //Status = "Completed";
            }
            //TypeID = Convert.ToInt32(ddlStatus.SelectedItem.Value);
            decimal ChequeNo = 0;
            //string Bankname = ((TextBox)GR.FindControl("txtBankName")).Text;
            //TextBox txtChequeNo = (TextBox)GR.FindControl("txtChqNo");
            //if (txtChequeNo.Text != string.Empty)
            //{
            //    ChequeNo = Convert.ToDecimal(txtChequeNo.Text);
            //}

            Status = ddlStatus.SelectedItem.Value;
            PDChart.DetailsID = finalBillID;
            PDChart.PatientID = PatientID;
            PDChart.Amount = amount;
            PDChart.TDS = TDS;
            PDChart.RightOff = RightOff;
            PDChart.CreatedBy = 0;
            PDChart.TypeID = 0;
            PDChart.Description = "TPA";
            PDChart.VisitID = VisitID;
            PDChart.BankNameorCardType = "";
            PDChart.ChequeorCardNumber = "0";
            PDChart.Status = Status;
            pDueChrt.Add(PDChart);

        }
        if (pDueChrt.Count > 0)
        {
           // returncode = new IP_BL(base.ContextInfo).UpdatePaymentDetails(pDueChrt, orgid);
        }
    }
}
