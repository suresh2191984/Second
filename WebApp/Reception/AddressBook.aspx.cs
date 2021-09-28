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
using System.IO;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Linq;
using System.Xml;
using Attune.Podium.BillingEngine;
using Attune.Podium.NewInstanceCreation;
using Attune.Podium.PerformingNextAction;

public partial class Reception_AddressBook : BasePage
{
    Master_BL master;
    List<OrganizationAddress> lstOragnizationAddress;
    long returnCode = 0;
     
    public Reception_AddressBook()
        : base("Reception_AddressBook_aspx")
    {
    
    }
     protected void page_Init(object sender, EventArgs e)
     {
         base.page_Init(sender, e);
     }
    protected void Page_Load(object sender, EventArgs e)
    {
            
        master = new Master_BL(base.ContextInfo);
                   
        if (!IsPostBack)
        {
            AutoCompleteExtender1.ContextKey = "RPH"; 
            LoadMetaData();
        }
    }
       
    public void LoadMetaData()
    {
        try
        {
            string select = Resources.Reception_ClientDisplay.Reception_Collections_aspx_03 == null ? "---Select---" : Resources.Reception_ClientDisplay.Reception_Collections_aspx_03;

            long returncode = -1;
            string domains = "ddlAddressbook";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInputs = new List<MetaData>();
            List<MetaData> lstmetadataOutputs = new List<MetaData>();
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInputs.Add(objMeta);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInputs, OrgID, LangCode, out lstmetadataOutputs);
            if (lstmetadataOutputs.Count > 0)
            {
                var childItems = from child in lstmetadataOutputs
                                 where child.Domain == "ddlAddressbook"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlType.DataSource = childItems;
                    ddlType.DataTextField = "DisplayText";
                    ddlType.DataValueField = "Code";
                    ddlType.DataBind();

                }
                //ddlType.Items
                ddlType.Items.Insert(0, select);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }
    public List<OrganizationAddress> GetAddressBookDetails()
    {
        try
        {
            lstOragnizationAddress = new List<OrganizationAddress>();
            string searchText = txtName.Text;
            int searchTypeId=0;
            int searchType = Convert.ToInt32(ddlType.SelectedItem.Value);
            if (hdnSearchTypeName.Value == "Client")
            {
                searchType = 1;
            }
            else if (hdnSearchTypeName.Value == "Physician")
            {
                searchType = 2;
            }
            else if (hdnSearchTypeName.Value == "Location")
            {
                searchType = 3;
            }
            if (!string.IsNullOrEmpty(txtName.Text))
                searchTypeId = Convert.ToInt32(hdnSearchTypeID.Value);

            long returncode = master.GetAddresBookDetails(searchType,searchTypeId, base.OrgID, out lstOragnizationAddress);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetFailedMessages method", ex);
        }
        return lstOragnizationAddress;

    }
    protected void Search_Click(object sender, EventArgs e)
    {
    
        lblResult.Text = "";
        LoadGrid();

    }
	string strNoRecord = Resources.Reception_ClientDisplay.Reception_AddressBook_aspx_01 == null ? "No matching records found" : Resources.Reception_ClientDisplay.Reception_AddressBook_aspx_01;
    public void LoadGrid()
    {
        try
        {
            List<OrganizationAddress> organizationAddress = GetAddressBookDetails();
            if (organizationAddress.Count > 0)
            {
            
            
                tblGrd.Style.Add("display", "block");

                grdAddressBook.DataSource = organizationAddress;
                grdAddressBook.DataBind();
            }
            else
            {
            
                tblGrd.Style.Add("display", "none");

                lblResult.Text = strNoRecord.Trim();
            }
            txtName.Text = "";
          
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadGrid Method", ex);
        }
    }


   
}
