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
using System.Data;

public partial class Admin_AddOrChangeBarcodePatterns : BasePage
{
    public Admin_AddOrChangeBarcodePatterns()
        : base("Admin_AddOrChangeBarcodePatterns_aspx")
    {
    }
    long returncode = -1;
    List<BarcodeOrgMapping> lstorgmap = new List<BarcodeOrgMapping>();
    string stralert = Resources.Admin_AppMsg.Admin_AddOrChangeBarcodePatterns_aspx_Alert == null ? "Alert" : Resources.Admin_AppMsg.Admin_AddOrChangeBarcodePatterns_aspx_Alert;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            
            BarcodeCategories();
            BarcodeMainAttributes();
            BarcodePlaceHolders();         
            LstBarcodeMainAttributes.Attributes.Add("onclick", "Javascript:CheckCategory();");
            LstBarcodeCategories.Attributes.Add("onclick", "Javascript:Clearcat();");
          
            LoadTable(lstorgmap);
            hdnorgid.Value =OrgID.ToString();
        }

    }
    public void LoadTable(List<BarcodeOrgMapping> lstorgmap)
    {
        try
        {
            returncode = new Master_BL(base.ContextInfo).GetBarcodeOrgMap(OrgID, out lstorgmap);
            foreach (BarcodeOrgMapping objMap in lstorgmap)
            {
                hdnRecords.Value += objMap.CategoryName + "~" + objMap.MainAttributeName + "~" + objMap.DisplayText+ "~"+ objMap.BarcodeCategoryId + "~" + objMap.BarcodeMainAttributeId +"~"+ objMap.Id  +"~" + objMap.Value+ "^";
            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "IsDefault", "ChildGridList();", true);            

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadBarcodeOrgMapping", ex);
        }
    }


    public void BarcodePlaceHolders()
    {
        try
        {
            LstBarcodePlaceHolders.Items.Clear();
            List<BarcodePlaceHolders> listBarcodePlaceHolders = new List<BarcodePlaceHolders>();
            returncode = new Master_BL(base.ContextInfo).BarcodePlaceHolders(out listBarcodePlaceHolders);
            if (listBarcodePlaceHolders.Count > 0)
            {
                LstBarcodePlaceHolders.DataSource = listBarcodePlaceHolders;
                LstBarcodePlaceHolders.DataTextField = "Name";
                LstBarcodePlaceHolders.DataValueField = "Code";
                LstBarcodePlaceHolders.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadBarcodePlaceHolders", ex);
        }

    }



    public void BarcodeCategories()
    {
        LstBarcodeCategories.Items.Clear();

     List<BarcodeCategories> listBarcodeCategories = new List<BarcodeCategories>();
     try
     {
         returncode = new Master_BL(base.ContextInfo).BarcodeCategory(out listBarcodeCategories);
         if (listBarcodeCategories.Count > 0)
         {
             LstBarcodeCategories.DataSource = listBarcodeCategories;
             LstBarcodeCategories.DataTextField = "Name";
             LstBarcodeCategories.DataValueField = "Id";
             LstBarcodeCategories.DataBind();
         }

     }

     catch (Exception ex)
     {
         CLogger.LogError("Error in LoadBarcodeCategories", ex);
     }




    }

    public void BarcodeMainAttributes()
    {
        LstBarcodeMainAttributes.Items.Clear();

        List<BarcodeMainAttributes> listBarcodeMainAttributes = new List<BarcodeMainAttributes>();
        try
        {
            returncode = new Master_BL(base.ContextInfo).BarcodeMainAttributes(out listBarcodeMainAttributes);
            if (listBarcodeMainAttributes.Count > 0)
            {
                LstBarcodeMainAttributes.DataSource = listBarcodeMainAttributes;              
                LstBarcodeMainAttributes.DataTextField = "Name";
                LstBarcodeMainAttributes.DataValueField = "Id";
                LstBarcodeMainAttributes.DataBind();

            }

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadBarcodeMainAttributes", ex);
        }
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        List<BarcodeOrgMapping> lstMC = new List<BarcodeOrgMapping>();
        try
        
        {

            foreach (string str in hdnRecords.Value.Split('^'))
            {
                if (str != "")
                {
                    BarcodeOrgMapping objMC = new BarcodeOrgMapping();
                    string[] list = str.Split('~');
                    objMC.Id = Int64.Parse(list[5]);
                    objMC.BarcodeCategoryId = Int64.Parse(list[3]);
                    objMC.BarcodeMainAttributeId = Int64.Parse(list[4]);
                    objMC.OrgID = int.Parse(OrgID.ToString());
                    objMC.DisplayText = list[2].ToString();
                    objMC.Value = list[6].ToString();
                    lstMC.Add(objMC);
                }
            }
            returncode = new Master_BL(base.ContextInfo).BarcodeCheckAndInsertPattern(OrgID, lstMC);
            if (returncode >= 0)
            {
                             
                Response.Redirect("AddOrChangeBarcodePatterns.aspx");
            }
            else
            {
                string strerror = Resources.Admin_AppMsg.Admin_AddOrChangeBarcodePatterns_aspx_13 == null ? "Error while saving BarcodePatterns Details!" : Resources.Admin_AppMsg.Admin_AddOrChangeBarcodePatterns_aspx_13;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "all", "javascript:ValidationWindow('" + strerror + "','" + stralert + "');", true);
            }


           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving BarcodePatterns details", ex);
        }
    
    }
}
