using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;


public partial class CommonControls_PaymentCollection : BaseControl
{
   
    long patientID = 0;
    long visitID = 0;
    bool consulting = false;
    bool procedure = false;
    bool investigation = false;

    
    public long PatientID
    {
        get { return patientID; }
        set { patientID = value; }
    }
    public long VisitID
    {
        get { return visitID; }
        set { visitID = value; }
    }
    public bool Consulting
    {
        get { return consulting; }
        set { consulting = value; }
    }
    public bool Procedure
    {
        get { return procedure; }
        set { procedure = value; }
    }
    public bool Investigation
    {
        get { return investigation; }
        set { investigation = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public void SaveAdvanceAmount()
    {
        long returnCode = -1;
        decimal amount=0;
        amount = Convert.ToDecimal(txtAmountRecieved.Text);
        if (Consulting)
        {
            returnCode = new BillingEngine(base.ContextInfo).InsertAdvanceAmount(OrgID, PatientID, VisitID, amount, "CON");
        }
        if (Procedure)
        {
            returnCode = new BillingEngine(base.ContextInfo).InsertAdvanceAmount(OrgID, PatientID, VisitID, amount, "PRO");
        }
        if (Investigation)
        {
            returnCode = new BillingEngine(base.ContextInfo).InsertAdvanceAmount(OrgID, PatientID, VisitID, amount, "INV");
        }

    }
}
