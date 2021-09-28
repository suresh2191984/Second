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

public partial class Admin_AddOrChangeNumberPatterns : BasePage
{
    public Admin_AddOrChangeNumberPatterns()
        : base("Admin_AddOrChangeNumberPatterns_aspx")
    {
    }

    long returncode = -1;
    List<MasterCategories> lstCategories = new List<MasterCategories>();
    List<MasterCategories> lstCategoryNPattern = new List<MasterCategories>();
    List<MasterPatterns> lstPatterns = new List<MasterPatterns>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lbPatterns.Attributes.Add("onclick", "Javascript:CheckCategory();");
            lbCategories.Attributes.Add("onclick", "Javascript:InsertNumber();");
            LoadMeatData();
            
        }
        LoadCategoriesAndProducts();
    }
    public void LoadCategoriesAndProducts()
    {
        List<Organization> lstOrganization = new List<Organization>();
        returncode = new Master_BL(base.ContextInfo).GetCategoriesAndPatterns(OrgID, out lstCategories, out lstPatterns, out lstCategoryNPattern);
        if (lstCategories.Count() > 0)
        {
            lbCategories.DataSource = lstCategories;
            lbCategories.DataTextField = "CategoryName";
            lbCategories.DataValueField = "CategoryId";
            lbCategories.DataBind();
        }
        if (lstPatterns.Count() > 0)
        {
            
            lbPatterns.DataSource = lstPatterns;
            lbPatterns.DataTextField = "PatternName";
            lbPatterns.DataValueField = "PatternValue";
            lbPatterns.DataBind();
        }
        if (lstCategoryNPattern.Count() > 0)
        {
            grdPatterns.DataSource = lstCategoryNPattern;
            grdPatterns.DataBind();
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            List<MasterCategories> lstMC = new List<MasterCategories>();
            foreach (string str in hdnRecords.Value.Split('^'))
            {
                if (str != "")
                {
                    MasterCategories objMC = new MasterCategories();
                    string[] list = str.Split('~');
                    objMC.CategoryId = Int64.Parse(list[0]);
                    objMC.CategoryName = list[1].ToString();
                    objMC.PatternValue = list[2].ToString();
                    objMC.IsReset = list[3].ToString();
                    objMC.CreatedDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    if (list[3].ToString() == "Y")
                    {
                        objMC.ResetOption = list[4].ToString();
                        objMC.ResetBy = list[5].ToString();
                        objMC.ResetNumber = Convert.ToInt32(list[6].ToString());
                    }
                    else
                    {
                        objMC.ResetOption = "";
                        objMC.ResetBy = "";
                        objMC.ResetNumber = 0;
                    }
                    objMC.Pattern = list[7].ToString();
                    lstMC.Add(objMC);
                }
            }
            returncode = new Master_BL(base.ContextInfo).CheckAndAssignPattern(OrgID, ILocationID, lstMC);
            if (returncode > 0)
            {
                string sPath = "Admin\\\\AddOrChangeNumberPatterns.aspx.cs_1";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "NumberPatterns", "ShowAlertMsg('" + sPath + "')", true);
            }

            LoadCategoriesAndProducts();
           
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg('" + sPath + "')", true);
            //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "NumberPatterns", "javascript:alert('Data saved Succesfully');", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InsertAuditTransaction", ex);
        }

    }
    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "MonthFormat,YearFormat,months";
            string[] Tempdata = domains.Split(',');
            //string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }


            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "MonthFormat"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlMonth.DataSource = childItems;
                    ddlMonth.DataTextField = "DisplayText";
                    ddlMonth.DataValueField = "Code";
                    ddlMonth.DataBind();


                }

                var childItems1 = from child in lstmetadataOutput
                                  where child.Domain == "YearFormat"
                                 select child;
                if (childItems1.Count() > 0)
                {
                    ddlYear.DataSource = childItems1;
                    ddlYear.DataTextField = "DisplayText";
                    ddlYear.DataValueField = "Code";
                    ddlYear.DataBind();


                }


                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "months"
                                  select child;
                if (childItems2.Count() > 0)
                {
                    ddlYear.DataSource = childItems2;
                    ddlYear.DataTextField = "DisplayText";
                    ddlYear.DataValueField = "Code";
                    ddlYear.DataBind();


                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }
}
