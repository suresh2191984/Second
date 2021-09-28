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
using System.Xml;

public partial class CommonControls_FinalBillHeader : System.Web.UI.UserControl
{
    public string attribValue
    {
        get;
        set;
    }
    public string tpaName
    {
        get;
        set;
    }

    
    

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public void SetAttribute(string AttributeString,string TPAName)
    {
        trTpaname.Style.Add("display", "block");
        AttributeString = AttributeString == null ? "" : AttributeString;
        //AttributeString = "<TpaAttributes>" +
        //    "<AttribDetails>" +
        //        "<ID>2</ID>" +
        //        "<Name>urn:no</Name>" +
        //        "<Type>Numeric</Type>" +
        //        "<Value>13325</Value>" +
        //    "</AttribDetails>" +
        //    "<AttribDetails>" +
        //        "<ID>3</ID>" +
        //        "<Name>Autho Date</Name>" +
        //        "<Type>DateTime</Type>" +
        //        "<Value>16-4-2010 02:18:31 PM</Value>" +
        //    "</AttribDetails>" +
        //"</TpaAttributes>";
       
        string FormatText = string.Empty;
        XmlDocument Doc = new XmlDocument();
        if (AttributeString != "")
        {
            Doc.LoadXml(AttributeString);
            string str = Doc.InnerXml;
            int count = Doc.GetElementsByTagName("AttribDetails").Count;
            //11~as~AlphaNumeric^12~asas~AlphaNumeric^
      
            foreach (XmlNode xmNode in Doc.GetElementsByTagName("AttribDetails"))
            {
                TableRow row1 = new TableRow();
                TableCell cell1 = new TableCell();
                TableCell cell2 = new TableCell();
                cell1.Attributes.Add("align", "left");
                cell1.Text = xmNode["Name"].InnerText;
                cell1.Style.Add("font-size", "11px");
                cell2.Attributes.Add("align", "left");
                cell2.Text = xmNode["Value"].InnerText;
                cell2.Style.Add("font-size", "11px");
                row1.Cells.Add(cell1);
                row1.Cells.Add(cell2);
                row1.Style.Add("color", "#000");
                tblCRCPresc.Rows.Add(row1);
                FormatText += xmNode["Name"].InnerText + ":" + xmNode["Value"].InnerText + "<br>";
            }
            //lblAttrib.Text = FormatText;
            attribValue = FormatText;
            //lblAttrib.Style.Add("font-size", "11px");
            //lblAttrib.Style.Add("font-weight", "700");
           
        }

        if (TPAName != "")
        {
            lblTpaName.Text = TPAName;
            tpaName = TPAName;
            lblTpaText.Style.Add("font-size","11px");
            lblTpaText.Style.Add("font-weight","700");
            lblTpaText.Style.Add("font-weight","Bold");
            lblTpaName.Style.Add("font-size","11px");
            lblTpaName.Style.Add("font-weight","700");

        }
        

    }
}
