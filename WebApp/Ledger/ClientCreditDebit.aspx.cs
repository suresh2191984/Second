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
using Attune.Solution.BusinessLogic_Ledger;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Linq;
using System.IO;
using System.Xml;
using System.Drawing;
using System.ComponentModel;
using Attune.Podium.ExcelExportManager;
using Attune.Podium.PerformingNextAction;
using Attune.Solution.BusinessComponent;

public partial class Ledger_ClientCreditDebit : BasePage
{
    
    ClientCredit ClientCreditdet = new ClientCredit();
    ClientDebit ClientDebitdet = new ClientDebit();
    string type = string.Empty;
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();
        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;
        return configValue;
    }
    protected void Page_Load(object sender, EventArgs e)
    {


        if (!IsPostBack)
        {

            AutoCompleteExtender1.ContextKey = OrgID.ToString() + "~" + "CLIENTZONE" + "~" + -1;
            AutoCompleteExtender2.ContextKey = OrgID.ToString() + "~" + "CLIENTZONE" + "~" + -1;
            hdnClientLoginID.Value = LID.ToString();
            hdnDate.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
            hdnOrgID.Value = OrgID.ToString();
            hdnDrivePath.Value = GetConfigValue("ReceiptEntryProofPath", OrgID);


            //handlerpath.Value = ConfigurationManager.AppSettings["DriveName"].ToString();
        }
    }
    List<ClientCredit> CreditValue = new List<ClientCredit>();
    List<ClientDebit> DebitValue = new List<ClientDebit>();
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    private long CreditDetails(ClientCredit clientcredit,out long  successcode)
    {
        long returncode = -1;
        successcode = -1;
        ClientLedger_BL objcredit_BL = new ClientLedger_BL(ContextInfo);
        clientcredit.OrgID = OrgID;
        clientcredit.Category = ddlCategory.SelectedItem.Text.Trim().ToString();
        clientcredit.Narration = ddlNarration.SelectedItem.Text.Trim().ToString();
        clientcredit.BarCode = txtEnterBarCode.Text.Trim().ToString();
        clientcredit.Amount = Convert.ToDecimal(txtEnterAmount.Text);
        clientcredit.Remarks = txtRemarks.Text.ToString();
        clientcredit.CreatedBy = LID;
        clientcredit.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        string idval = "";
        idval = hdnClientID.Value.ToString();
        clientcredit.SourceCode = idval;
        objcredit_BL.SaveClientCredit(clientcredit,out successcode);
        return returncode;
    }

    private void DebitDetails(ClientDebit clientdebit, out long successcode)
    {
        ClientLedger_BL objDebit_BL = new ClientLedger_BL(ContextInfo);
        successcode = -1;
        clientdebit.OrgID = OrgID;
        clientdebit.Amount = Convert.ToDecimal(txtEnterAmount.Text.ToString());
        clientdebit.Category = ddlCategory.SelectedItem.Text.Trim().ToString();
        clientdebit.Narration = ddlNarration.SelectedItem.Text.Trim().ToString();
        clientdebit.BarCode = txtEnterBarCode.Text.Trim().ToString();
        clientdebit.Remarks =txtRemarks.Text.ToString();
        clientdebit.CreatedBy = LID;
        clientdebit.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        string idval = "";
        idval = hdnClientID.Value.ToString();
        clientdebit.SourceCode = idval;
        objDebit_BL.SaveClientDebit(clientdebit,out successcode);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            ClientLedger_BL objClientLedger_BL = new ClientLedger_BL(ContextInfo);
            long successcode = -1;
            if (ddlType.SelectedValue == "C")
            {
                
                ClientCredit c = new ClientCredit();
                CreditDetails(c,out successcode);
                if (successcode > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alrsubmitSucess", "alert('Credit Sumitted Successfully!');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alrsubmitSucess", "alert('Same Narration for the Client Already Exist!');", true);

                }
            }
            else if (ddlType.SelectedValue == "D")
            {
                ClientDebit d = new ClientDebit();
                DebitDetails(d,out successcode);
                if (successcode >0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alrsubmitSucess", "alert('Debit Sumitted Successfully!');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alrsubmitSucess", "alert('Same Narration for the Client Already Exist!');", true);

                }
            }
            cleardata();
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Save Page :"+ ex.ToString() +" Inner Exception-", ex.InnerException);
        }
       
    }
    private void cleardata()
    {

        txtClientName.Text = "";
        ddlNarration.ClearSelection();
        txtEnterBarCode.Text = "";
        txtReEnterBarCode.Text = "";
        txtEnterAmount.Text = "";
        txtReEnterAmount.Text = "";
        txtRemarks.Text = "";
        hdnClientID.Value = string.Empty;
    }
    public void lstNarrationList()
    {
        try
        {
            ClientLedger_BL ObjClientNar = new ClientLedger_BL(base.ContextInfo);
            List<CreditDebitNarration> lstClientNarattion = new List<CreditDebitNarration>();
            string typeval = "";
            typeval = ddlType.SelectedValue.ToString();
            ObjClientNar.GetNarrationList(typeval, out lstClientNarattion);
            ddlNarration.DataSource = lstClientNarattion;
            ddlNarration.DataTextField = "Narration";
            ddlNarration.DataValueField = "Id";
            ddlNarration.DataBind();
            ddlNarration.Items.Insert(0, "Select");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading Client Narrration List ", ex);
        }
    }
    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
      
        if (ddlType.SelectedValue != "")
        {
           // cleardata();
         //   lstNarrationList();
        }
    }
    protected void cleardata(object sender, EventArgs e)
    {
        txtClientName.Text = string.Empty;
        txtEnterAmount.Text = string.Empty;
        txtReEnterAmount.Text = string.Empty;
        txtReEnterBarCode.Text = string.Empty;
        txtRemarks.Text = string.Empty;
        txtEnterBarCode.Text = string.Empty;
        ddlCategory.SelectedIndex = -1;
        ddlNarration.SelectedIndex = -1;
        ddlType.SelectedIndex = -1;
        hdnClientID.Value = "";
    }
    protected void btnReset_click(object sender, EventArgs e)
    {
        cleardata();
    }
    
   
    //protected void btnChequeSubmit_Click(object sender, EventArgs e)
    //{
    //    if (fpProofCopy.HasFile)
    //    {
    //        string filename = Path.GetFileName(fpProofCopy.PostedFile.FileName);
    //        //Save images into Images folder
    //        fpProofCopy.SaveAs(Server.MapPath("ReceiptEntryImages/" + filename));
            //try
            //{
            //    string filename = Path.GetFileName(fpProofCopy.FileName);
            //    string newfile = (Server.MapPath("~/ReceiptEntryImages/") + filename);//+ filename
            //    fpProofCopy.SaveAs(newfile);
            //    //StatusLabel.Text = "Upload status: File uploaded!";
            //    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Inserted Successfullys')", true);
            //}
            //catch (Exception ex)
            //{
            //    //StatusLabel.Text = "Upload status: The file could not be uploaded. The following error occured: " + 
            //    CLogger.LogError("Error while uploading file :" + ex.ToString() + " uploading file-", ex);
            //}
        //}
        //FileUpload1.SaveAs(Server.MapPath("images//" + FileUpload1.FileName));
        /////
        //string fileName = Path.Combine(Server.MapPath("~/images"), FileUpload2.FileName);
        //FileUpload2.SaveAs(fileName);
        /////
        //string fileName = Path.GetFileName(FileUpload3.PostedFile.FileName);
        //FileUpload3.PostedFile.SaveAs(Server.MapPath("~/images/") + fileName);
        ////
        //if (fpProofCopy.HasFile)
        //{
        //    //create the path to save the file to
        //    string fileName = Path.Combine(Server.MapPath("~/ReceiptEntryImages"), fpProofCopy.FileName);
        //    //save the file to our local path
        //    fpProofCopy.SaveAs(fileName);
        //}
    //}
    protected void ddlEntrytype_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
