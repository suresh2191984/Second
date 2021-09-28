using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using ReportingService;
using System.Configuration;

public partial class CommonControls_InvReportTemplateMaster : System.Web.UI.UserControl
{

    #region Constants
    const string reportImage = "../Images/report.gif";
    const string folderImage = "../Images/folder.gif";
    #endregion
    
    private ReportingService2005 rs;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        rs = new ReportingService2005();
        //rs.Credentials = System.Net.CredentialCache.DefaultCredentials;
        rs.Credentials = new System.Net.NetworkCredential(ConfigurationManager.AppSettings["ReportUserName"], ConfigurationManager.AppSettings["ReportPassword"]);
        tvCatalog.BackColor = System.Drawing.Color.DimGray; //.Gainsboro;
        tvCatalog.ForeColor = System.Drawing.Color.Black;
        if (!IsPostBack)
        {
            BuildTreeView();
            tvCatalog.Attributes.Add("onclick", "return OnTreeClick(event)");
        }
    }
    private void BuildTreeView()
    {
        try
        {
            TreeNode RootNode = new TreeNode();
            RootNode.Text = ""; //"Report Server";
            RootNode.Expanded = true;
            tvCatalog.Nodes.AddAt(0, RootNode);
            GetCatalogItems(string.Empty, RootNode);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error BuildTreeView", ex);
        }
    }
    private void GetCatalogItems(string catalogPath, TreeNode parentNode)
    {
        CatalogItem[] items;
        try
        {
            if (catalogPath.Length == 0)
            {
                items = rs.ListChildren("/", false);
            }
            else
            {
                items = rs.ListChildren(catalogPath, false);
            }
            foreach (CatalogItem item in items)
            {
                if (item.Hidden != true)
                {
                    if ((item.Type.Equals(ItemTypeEnum.Folder) || item.Type.Equals(ItemTypeEnum.Report)) &
                        (item.Type != ItemTypeEnum.DataSource
                        & item.Name != "Data Sources"))
                    {
                        TreeNode folderNode = new TreeNode(item.Name, null);
                        folderNode.ImageUrl = GetNodeImage(item.Type);
                        folderNode.Text = item.Name;
                        folderNode.Value = item.Path;
                        folderNode.ToolTip = item.Name;
                        parentNode.ChildNodes.Add(folderNode);
                        if (item.Type.Equals(ItemTypeEnum.Folder))
                        {
                            GetCatalogItems(item.Path, folderNode);
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error GetCatalogItems", ex);
        }
        finally
        {
            rs.Dispose();
        }
    }
    private string GetNodeImage(ItemTypeEnum type)
    {
        string imagePath = string.Empty;

        switch (type)
        {
            case ItemTypeEnum.Folder:
                imagePath = folderImage;
                break;
            case ItemTypeEnum.Report:
                imagePath = reportImage;
                break;
            case ItemTypeEnum.LinkedReport:
                imagePath = reportImage;
                break;
        }

        return imagePath;
    }

    //private string m_strPathControl;
    //private string m_strSelectedValue;

    //public string strPathControl
    //{
    //    get { return m_strPathControl; }
    //    set { m_strPathControl = value; }
    //}

    //public string strSelectedValue
    //{
    //    get { return m_strSelectedValue; }
    //    set { m_strSelectedValue = value; }
    //}
}
