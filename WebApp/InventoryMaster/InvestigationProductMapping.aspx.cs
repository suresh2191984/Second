using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.Data;
using System.Xml;
using Attune.Kernel.DataAccessEngine;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryMaster.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.InventoryCommon.BL;


public partial class Admin_InvestigationProductMapping : Attune_BasePage
{
    public Admin_InvestigationProductMapping()
        : base("InventoryMaster_InvestigationProductMapping_aspx")
    { }
    InventoryMaster_BL inventoryBL;

    List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
    List<InventoryItemsBasket> lstdevices = new List<InventoryItemsBasket>();
    List<InvInstrumentMaster> lstInst = new List<InvInstrumentMaster>();
    long productid = 0;
    long InvestigationID = 0;
    long DeviceMappingID = 0;
    long DeviceID = 0;
    string DeviceName = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryMaster_BL( base.ContextInfo);
        if (!IsPostBack)
        {
            LoadUnit();
            loadtbl();


        }
        AutoInvName.ContextKey = drpDevices.SelectedValue;

    }
    public void LoadUnit()
    {
        new InventoryCommon_BL(base.ContextInfo).GetInventoryUOM(out lstInventoryUOM);
        eunits.DataSource = lstInventoryUOM;
        eunits.DataTextField = "UOMCode";
        eunits.DataValueField = "UOMCode";
        eunits.DataBind();
        eunits.Items.Insert(0, GetMetaData("Select", "0"));
        eunits.Items[0].Value = "0";

        bUnits.DataSource = lstInventoryUOM;
        bUnits.DataTextField = "UOMCode";
        bUnits.DataValueField = "UOMCode";
        bUnits.DataBind();
        bUnits.Items.Insert(0, GetMetaData("Select", "0"));
        bUnits.Items[0].Value = "0";

        inventoryBL.GetInstrumentName(OrgID,out lstInst);
        if (lstInst.Count > 0)
        {
            drpDevices.DataSource = lstInst;
            drpDevices.DataTextField = "InstrumentName";
            drpDevices.DataValueField = "InstrumentID";
            drpDevices.DataBind();
            drpDevices.Items.Insert(0, GetMetaData("Select", "0"));
            drpDevices.Items[0].Value = "0";
        }
       

    }
    //protected void btnSave_Click(object sender, EventArgs e)
    //{
    //    long returncode = -1;
    //    InventoryItemsBasket maping = new InventoryItemsBasket();
    //    List<InventoryItemsBasket> devicemapping = new List<InventoryItemsBasket>();
    //    try
    //    {
    //        var splits = hdnProductMapping.Value.Split('^');
    //        for (int i = 0; i < splits.Length; i++)
    //        {
    //            if (splits[i] != "")
    //            {
    //                var devics = splits[i].Split('~');
    //                maping.CategoryName = devics[0].ToString();//DeviceID
    //                maping.ID = Convert.ToInt64(devics[8]);//Investigationid
    //                maping.AttributeDetail = CreateXMLinfo(maping.CategoryName, maping.ID);
    //                maping.Manufacture = DateTimeUtility.GetServerDate();
    //                maping.ExpiryDate = DateTimeUtility.GetServerDate();
    //                devicemapping.Add(maping);
    //            }
    //        }
    //       returncode=inventoryBL.updatetestinformation(OrgID, devicemapping);



    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Update Test information in Analyzer", ex);
    //    }


    //}

    protected void btnSave_Click(object sender, EventArgs e)
    {
        long returncode = -1;
        long InvestigationID = 0;
        long DeviceMappingID = 0;
        InventoryItemsBasket maping;
        List<InventoryItemsBasket> devicemapping = new List<InventoryItemsBasket>();
        try
        {
            var splits = hdnProductMapping.Value.Split('^');
            for (int i = 0; i < splits.Length; i++)
            {
                if (splits[i] != "")
                {
                    maping = new InventoryItemsBasket();
                    // device + "~" + InvName + "~" + ProductName + "~" + Equantity + "~" + eunits + "~" + Bquantity + "~" + bunits + "~" + Productid + "~" + Invid + "~" + ParentProductid + "~" + DeviceID + "~" + DeviceMappingID  + "^"

                    var devics = splits[i].Split('~');
                    maping.CategoryName = devics[0].ToString();//DeviceID
                    maping.Description = devics[1].ToString();//investigation name
                    maping.ProductName = devics[2].ToString();
                    maping.Manufacture =DateTimeNow;
                    maping.ExpiryDate = DateTimeNow;
                    maping.Quantity = Convert.ToDecimal(devics[3]);
                    maping.SellingUnit = devics[4];
                    maping.RcvdLSUQty = Convert.ToDecimal(devics[5]);
                    maping.LSUnit = devics[6];
                    maping.ProductID = Convert.ToInt64(devics[7]);
                    maping.Providedby = Convert.ToInt64(devics[8]);//Investigationid
                    maping.ParentProductID = Convert.ToInt64(devics[9]);
                    maping.ID = Convert.ToInt64(devics[11]);//DeviceMappingID

                    devicemapping.Add(maping);
                }
            }

            InvestigationID = Convert.ToInt64(hdnInvID.Value);
            //DeviceID = Convert.ToInt64(devics[10]);
            DeviceName = drpDevices.SelectedValue;

            if (devicemapping.Count > 0)
            {
                returncode = inventoryBL.updatetestinformation(OrgID, devicemapping, LID, ILocationID, InvestigationID, DeviceMappingID, DeviceName);
            }
            loadtbl();


        }
        catch (Exception ex)
        {
            CLogger.LogError("Update Test information in Analyzer", ex);
        }


    }



    string CreateXMLinfo(string deviceid, long investigationid)
    {
        XmlDocument deviceattributes = new XmlDocument();
        deviceattributes.LoadXml("<TestInfo></TestInfo>");
        XmlNode xmlNode;
        foreach (string s in hdnProductMapping.Value.Split('^'))
        {
            if (deviceid == s.Split('~')[0] && investigationid == Convert.ToInt64(s.Split('~')[8]))
            {
                XmlElement xmlElement = deviceattributes.CreateElement("Investigation");
                xmlNode = deviceattributes.CreateNode(XmlNodeType.Element, "Deviceid", "");
                xmlNode.InnerText = s.Split('~')[0].ToString();
                xmlElement.AppendChild(xmlNode);

                xmlNode = deviceattributes.CreateNode(XmlNodeType.Element, "Invname", "");
                xmlNode.InnerText = s.Split('~')[1].ToString();
                xmlElement.AppendChild(xmlNode);

                xmlNode = deviceattributes.CreateNode(XmlNodeType.Element, "Pname", "");
                xmlNode.InnerText = s.Split('~')[2].ToString();
                xmlElement.AppendChild(xmlNode);

                xmlNode = deviceattributes.CreateNode(XmlNodeType.Element, "Estimated", "");
                xmlNode.InnerText = s.Split('~')[3].ToString();
                xmlElement.AppendChild(xmlNode);

                xmlNode = deviceattributes.CreateNode(XmlNodeType.Element, "eunits", "");
                xmlNode.InnerText = s.Split('~')[4].ToString();
                xmlElement.AppendChild(xmlNode);

                xmlNode = deviceattributes.CreateNode(XmlNodeType.Element, "Buffer", "");
                xmlNode.InnerText = s.Split('~')[5].ToString();
                xmlElement.AppendChild(xmlNode);

                xmlNode = deviceattributes.CreateNode(XmlNodeType.Element, "bunits", "");
                xmlNode.InnerText = s.Split('~')[6].ToString();
                xmlElement.AppendChild(xmlNode);

                xmlNode = deviceattributes.CreateNode(XmlNodeType.Element, "ProductID", "");
                xmlNode.InnerText = s.Split('~')[7].ToString();
                xmlElement.AppendChild(xmlNode);

                xmlNode = deviceattributes.CreateNode(XmlNodeType.Element, "InvestigationID", "");
                xmlNode.InnerText = s.Split('~')[8].ToString();
                xmlElement.AppendChild(xmlNode);
                deviceattributes.DocumentElement.AppendChild(xmlElement);
            }
        }
        return deviceattributes.InnerXml;
    }
    public void loadtbl()
    {
        List<InventoryItemsBasket> deviceattributes = new List<InventoryItemsBasket>();
        try
        {
            hdnProductMapping.Value = "";
            hdnUnProducts.Value = "";

            InvestigationID = hdnInvID.Value == "" ? 0 : Convert.ToInt64(hdnInvID.Value);
            DeviceName = drpDevices.SelectedItem.ToString();
            if (DeviceName != "")
            {
                inventoryBL.GetDeviceAttributes(OrgID, DeviceID, InvestigationID, DeviceName, out deviceattributes);
            }
            if (deviceattributes.Count > 0)
            {
                for (int i = 0; i < deviceattributes.Count; i++)
                {
                    // hdnProductMapping.Value += getattributes(deviceattributes[i].AttributeDetail);
                    hdnProductMapping.Value += deviceattributes[i].Description + "^";

                }

                ScriptManager.RegisterStartupScript(Page, this.GetType(), "loa1attributes", "  Tblist();", true);
            }
        }
        catch (Exception EX)
        {
            CLogger.LogError("Load Device Attribures Investigation mappin", EX);
        }


    }
    public string getattributes(string attributes)
    {
        string HdnText = string.Empty;
        XmlDocument Doc = new XmlDocument();
        Doc.LoadXml(attributes);
        int Count = Doc.GetElementsByTagName("Investigation").Count;
        foreach (XmlNode node in Doc.GetElementsByTagName("Investigation"))
        {
            HdnText += node["Deviceid"].InnerText + "~" + node["Invname"].InnerText + "~" + node["Pname"].InnerText + "~" +
                       node["Estimated"].InnerText + "~" + node["eunits"].InnerText + "~" + node["Buffer"].InnerText + "~" +
                       node["bunits"].InnerText + "~" + node["ProductID"].InnerText + "~" + node["InvestigationID"].InnerText + "^";
        }
        return HdnText;
    }


    protected void drpDevices_SelectedIndexChanged(object sender, EventArgs e)
    {

        loadtbl();
        AutoInvName.ContextKey = drpDevices.SelectedValue;
    }


}
