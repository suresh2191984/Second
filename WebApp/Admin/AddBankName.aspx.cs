using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Text;
using System.Security.Cryptography;

public partial class Admin_AddBankName : BasePage
{
    
    public Admin_AddBankName()
        : base("Admin\\AddBankName.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<PaymentBanks> lstBanks;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindBankList();

        }
        
    }
    private void BindBankList()
    {
        
        lstBanks = new List<PaymentBanks>();

        long returnCode = -1;
        returnCode = new Payment_BL(base.ContextInfo).GetBankName(0, out lstBanks);

        lstboxBankName.DataSource = lstBanks;
        lstboxBankName.DataTextField = "BankName";
        lstboxBankName.DataValueField = "BankID";
        lstboxBankName.DataBind();


        lstboxBankName.Attributes.Add("onclick", "showItemName()");
        txtBankName.Attributes.Add("onfocus", "hideItemName()");
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        string[] BankRaw = hdnBankName.Value.Split('^');
        List<PaymentBanks> lstBanks = new List<PaymentBanks>();
        PaymentBanks objPaymentBanks;
        
        foreach (string str in BankRaw)
        {
            if (str != "")
            {
                string[] Bank = str.Split('~');
                objPaymentBanks = new PaymentBanks();
                objPaymentBanks.BankName = Bank[1].ToString().Trim().ToUpper();

                lstBanks.Add(objPaymentBanks);
            }
        }

        hdnBankName.Value = "";

        try
        {
            returnCode = new Payment_BL(base.ContextInfo).InsertBanks(lstBanks,LID);
            if (returnCode >= 0)
            {
                trResult.Attributes.Add("display", "block");
                lblResult.Text = "Saved Successfully";
            }
            else
            {
                trResult.Attributes.Add("display", "block");
                lblResult.Text = "Records not Saved";
            }
            BindBankList();
            Response.Redirect("AddBankName.aspx");

        }
        catch (Exception er)
        {
            CLogger.LogError("There was a Erroer while Saving Bank Master in Addbankname.aspx", er);
        }


    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        long Returncode = -1;
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            Returncode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        long BankID=0;
        BankID = Convert.ToInt64(hdnBankID.Value);
        try
        {
            
            returnCode = new Payment_BL(base.ContextInfo).pUpdateBank(BankID, txtBankName.Text.Trim().ToString().ToUpper(),LID,OrgID);
            if (returnCode >= 0)
            {
                string sPath = "Admin\\\\AddBankName.aspx.cs_6";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "ShowAlertMsg('" + sPath + "')", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('Updated');", true);
                BindBankList();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("There was a Erroer while Updating Bank Master in Addbankname.aspx", ex);
        }
    }
}
