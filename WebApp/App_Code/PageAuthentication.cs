using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Xml;
using System.Web.Services;
using Attune.Podium.BusinessEntities;

/// <summary>
/// Summary description for PageAuthentication
/// </summary>
public class PageAuthentication
{
    ContextDetails globalContextDetails;
    public PageAuthentication()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public PageAuthentication(ContextDetails localContextDetails)
    {
        globalContextDetails = localContextDetails;
    }

    [WebMethod(EnableSession = true)]
    public string GetCurrentAuthentication(string CurrentPage, string OrgID, string RoleName)
    {

        string getCurrentAuthentication = string.Empty;
        XmlDocument doc = new XmlDocument();
        doc.Load(HttpContext.Current.Request.MapPath("../App_Data/XML/PageAccessLevel.xml"));

        XmlNode node = doc.SelectSingleNode("/PageRoleAccessMapping/PageName/" + CurrentPage);

        if (!node.Equals(null) && node.ChildNodes.Count > 0)
        {
            for (int c = 0; c < node.ChildNodes.Count; c++)
            {
                XmlNode nodeOrg = node.ChildNodes[c];

                if (!nodeOrg.Equals(null) && nodeOrg.Name.Equals("Orgid"))
                {

                    if (nodeOrg.Attributes[0].Value == OrgID)
                    {
                        for (int j = 0; j < nodeOrg.ChildNodes.Count; j++)
                        {
                            XmlNode nodeRole = nodeOrg.ChildNodes[j];
                            if (nodeRole.Attributes[0].Value == RoleName)
                            {
                                for (int k = 0; k < nodeRole.ChildNodes.Count; k++)
                                {
                                    XmlNode nodeSection = nodeRole.ChildNodes[k];
                                    if (nodeSection.LocalName == "section")
                                    {
                                        getCurrentAuthentication += nodeSection.Attributes[0].Value + "-";

                                        XmlNode nodeActivity = nodeSection.ChildNodes[0];

                                        if (nodeActivity.LocalName == "Activity")
                                        {
                                            for (int i = 0; i < nodeActivity.ChildNodes.Count; i++)
                                            {
                                                getCurrentAuthentication += nodeActivity.ChildNodes[i].InnerText;
                                            }
                                            getCurrentAuthentication += "@";
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        if (getCurrentAuthentication.Length > 0)
        {
            getCurrentAuthentication = getCurrentAuthentication.Substring(0, (getCurrentAuthentication.Length - 1));
        }
        else
        {
            getCurrentAuthentication = string.Empty;
        }

        return getCurrentAuthentication;
    }


    public string GetDefaultAuthentication(string CurrentPage, string OrgID, string RoleName)
    {
        string[] pageName;
        string getDefaultAuthentication = string.Empty;
        XmlDocument doc = new XmlDocument();
        doc.Load(HttpContext.Current.Request.MapPath("../App_Data/XML/PageRoleMapping.xml"));
        string getOrgID = string.Empty;
        string path = HttpContext.Current.Request.Url.AbsolutePath;
        pageName = path.Split('/');
        XmlNode node = doc.SelectSingleNode("/PageRoleAccessMapping/Pages/" + CurrentPage);
        if (node.Attributes[0].Value == OrgID)
        {
            XmlNode nodeSections = doc.SelectSingleNode("/PageRoleAccessMapping/Pages/" + CurrentPage + "/Sections");
            for (int i = 0; i < nodeSections.ChildNodes.Count; i++)
            {
                if (nodeSections.ChildNodes[i].Name.Equals("Activity"))
                {
                    getDefaultAuthentication += nodeSections.ChildNodes[i].ChildNodes[0].InnerText + "-" + nodeSections.ChildNodes[i].Attributes[0].Value + "@";
                }
            }
        }

        if (getDefaultAuthentication.Length > 0)
        {
            getDefaultAuthentication = getDefaultAuthentication.Substring(0, (getDefaultAuthentication.Length - 1));
        }
        else
        {
            getDefaultAuthentication = string.Empty;
        }

        return getDefaultAuthentication;
    }




    public string ToDoControl(string ControlType)
    {
        string type = string.Empty;

        switch (ControlType)
        {
            case "11":
                type = "Show";
                break;

            case "10":
                type = "ShowNDisable";
                break;

            case "01":
                type = "Hide";
                break;

            case "00":
                type = "Hide";
                break;

            default:
                type = "Show";
                break;
        }

        return type;
    }
}
