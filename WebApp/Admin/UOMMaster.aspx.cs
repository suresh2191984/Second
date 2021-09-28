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
using System.Text;

public partial class Admin_UOMMaster : BasePage
{
    List<InvestigationMaster> INVMaster = new List<InvestigationMaster>();
    Investigation_BL investigationBL;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        try
        {
            investigationBL = new Investigation_BL(base.ContextInfo);
            if (!IsPostBack)
            {
                LoadSymbols();
            }
            UOMList();
            Textarea1.Focus();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Load InvestigationSymbols", ex);
        }
    }

    protected void LoadSymbols()
    {
        INVMaster.Clear();
        long returnCode = -1;
        try
        {
            returnCode = investigationBL.GetInvestigationSymbols(OrgID, out INVMaster);
            if (INVMaster.Count > 0)
            {
                foreach (InvestigationMaster items in INVMaster)
                {
                    hdnINVList.Value += items.TestCode + "^";
                    Button b = new Button();
                    string txtHTML = items.TestCode;
                    b.Text =Server.HtmlDecode(items.TestCode);
                    b.ID = items.InvestigationID.ToString();
                    b.Width = 30;
                    b.ToolTip = items.InvestigationName.ToString();
                    string str = " return ButtonClick('" + b.Text.Replace("'", "") + "^" + txtHTML + "')";
                    b.OnClientClick = str;
                    pSymbols.Controls.Add(b);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get InvestigationSymbols", ex);
        }
    }

    protected void UOMList()
    {
        long returnCode = -1;
        List<UOM> lstUOM = new List<UOM>();
        try
        {
            returnCode = new Investigation_BL(base.ContextInfo).GetUOMCode(out lstUOM);
            if (lstUOM.Count > 0)
            {
                foreach (UOM item in lstUOM)
                {
                    hdnUOMList.Value += item.UOMCode + "^";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in UOM Load ", ex);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        int tempvar=0;
        long returnCode = -1;
        string UOMSymbol = "";
        string UOMDesc = "";
        try
        {
            UOMSymbol = hdnUOM.Value;
            UOMDesc = txtDescription.Text.Trim();
            string[] List = hdnUOMList.Value.Split('^');
            if (List.Length > 0)
            {
                for (int i = 0; i < List.Length; i++)
                {
                    if (List[i] == UOMSymbol)
                    {
                        tempvar = 1;
                        break;
                    }
                }
            }
            if (tempvar == 1)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:alert('Units Already Exists !');", true);
            }
            else
            {
                returnCode = investigationBL.SaveUOMSymbols(OrgID, UOMSymbol, UOMDesc);
                if (returnCode > 0)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:alert('Units Inserted Successfully');", true);                   
                }
            }
            hdnUOM.Value = "";
            Textarea1.Text = "";
            txtDescription.Text = "";
            txtUpload.Text = "";
            txtUploadDesc.Text = "";
            LoadSymbols();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing SaveUOMSymbols", ex);
        }
    }
    
    protected void btnUploadSymbols_Click(object sender, EventArgs e)
    {
        string Symbol = "";
        string Description = "";
        long returnCode = -1;
        try
        {
            Symbol = txtUpload.Text.Trim();
            Description = txtUploadDesc.Text.Trim();
            returnCode = new Investigation_BL(base.ContextInfo).UploadUOMCode(OrgID,Symbol,Description);
            if (returnCode > 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "symb", "javascript:alert('Symbols Inserted Successfully');", true);
                Textarea1.Text = "";
                hdnUOM.Value = "";
                txtDescription.Text = "";
                txtUpload.Text = "";
                txtUploadDesc.Text = "";                               
            }
            LoadSymbols();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing UploadUOMSymbols", ex);
        }
    }
    
    public string EncodeStringToBase64(string stringToEncode)
    {
        return Convert.ToBase64String(Encoding.UTF8.GetBytes(stringToEncode));
    }

    public string DecodeStringFromBase64(string stringToDecode)
    {
        return Encoding.UTF8.GetString(Convert.FromBase64String(stringToDecode));
    }
}

