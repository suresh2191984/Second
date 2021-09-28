using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;

public partial class CommonControls_MasterControl :  BaseControl
{
    FeeType.type _name;
    protected void Page_Load(object sender, EventArgs e)
    {
        lblStatus.Text = string.Empty;
    }
    public FeeType.type TableType 
    {
        get { return _name; }
        set { _name = value; }
    }
    public string Text
    {
        set { lblName.Text = value; }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        List<CasualtyCharges> lCasuality = new List<CasualtyCharges>();
        CasualtyCharges eCasuality = new CasualtyCharges();
        if (EnumUtils.stringValueOf(TableType) == FeeType.Casuality)
        {
            eCasuality.TestName = txtName.Text;
            eCasuality.FeeType = FeeType.Casuality;
            eCasuality.OrgID = OrgID;
            lCasuality.Add(eCasuality);
            returnCode = new Immunize_BL(base.ContextInfo).InsertMasterData(lCasuality);
            mdlMaster.Show();
            if (returnCode != -1)
            {
                mdlMaster.Show();
                lblStatus.Text = "Casuality  saved scucessfully...!";

                txtName.Text = string.Empty;
            }
            else
            {
                mdlMaster.Show();
                lblStatus.Text = "Error while saving Casuality..!";
            }
        }
        else if(EnumUtils.stringValueOf(TableType) == FeeType.MedicalIndents)
        {
            eCasuality.TestName = txtName.Text;
            eCasuality.FeeType = FeeType.MedicalIndents;
            eCasuality.OrgID = OrgID;
            lCasuality.Add(eCasuality);
            returnCode = new Immunize_BL(base.ContextInfo).InsertMasterData(lCasuality);
            mdlMaster.Show();
            if (returnCode != -1)
            {
                mdlMaster.Show();
                lblStatus.Text = "MedicalIndents  saved scucessfully...!";
                txtName.Text = string.Empty;
                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Indents", "javascript:CreateIndentTables()", true);
            }
            else
            {
                mdlMaster.Show();
                lblStatus.Text = "Error while saving MedicalIndents..!";
            }
        }
    }
}

