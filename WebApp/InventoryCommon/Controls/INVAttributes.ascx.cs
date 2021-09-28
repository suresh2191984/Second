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
using Attune.Kernel.BusinessEntities;
using System.Collections.Generic;
using System.Xml;
using System.Xml.Linq;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;

public partial class InventoryCommon_Controls_INVAttributes : Attune_BaseControl
{
    public InventoryCommon_Controls_INVAttributes()
    
        :base("InventoryCommon_Controls_INVAttributes_ascx")
    { }
    List<Attributes> lstAttributes = new List<Attributes>();
    List<ProductAttributes> lstProductAttributes = new List<ProductAttributes>();
    List<AttributeValues> lstAttributeValues = new List<AttributeValues>();
    DataTable objAttributes = new DataTable();
    DataTable dtAttributeValues = new DataTable();
    //Inventory_BL invBL;
    long QuantityCount = 0;
    long pId = 0;
    //string AttributeDetail = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }
    //public void BindProductAttributes(string XmlValues, string strProduct, string actionFlag)
    //{
    //    long retCode = -1;
    //    try
    //    {
    //        string[] strProd = strProduct.Split('~');
    //        DataTable attDT1 = new DataTable();
    //        DataSet dsAttVal = new DataSet();
    //        gvAttributeValues.Visible = false;
    //        pId = Int64.Parse(strProd[0]);
    //        if (strProd[1] != "Assign")
    //        {
    //            lblReceivedQty.Text = strProd[1];
    //            QuantityCount = Convert.ToInt64(Convert.ToDecimal(strProd[1]));
    //            ViewState["QtyCount"] = QuantityCount;
    //        }
    //        retCode = invBL.GetAttributes(OrgID, out lstAttributes);
    //        if (lstAttributes.Count > 0)
    //        {
    //            Utilities.ConvertFrom(lstAttributes, out attDT1);
    //        }
    //        Utilities.ConvertTo(attDT1, out lstProductAttributes);
    //        DataColumn Id = objAttributes.Columns.Add("UnitNo");
    //        DataColumn pid = objAttributes.Columns.Add("ProductId");
    //        Id.AutoIncrement = true;
    //        Id.AutoIncrementSeed = 1;
    //        pid.DefaultValue = pId;
    //        hdnMandatoryFields.Value = "";
    //        gvAttributes.DataSource = lstProductAttributes;
    //        gvAttributes.DataBind();
    //        gvAttributes.Visible = true;
    //        ViewState["Attributes"] = objAttributes;
    //        ModalPopupExtender1.Show();

    //        if (actionFlag == "Update" && strProd[2] != "N")
    //        {
    //            StringReader attStream = new StringReader(strProd[2]);
    //            dsAttVal.ReadXml(attStream);
    //            if (dsAttVal.Tables.Count > 0)
    //            {
    //                DataTable dtAttXml = dsAttVal.Tables[0];
    //                //objAttributes = dsAttVal.Tables[0];
    //                dtAttXml.Columns.Remove("IsIssued");
    //                dtAttXml.Columns.Remove("Description");
    //                dtAttXml.AcceptChanges();
    //                dtAttXml.Columns["UnitNo"].SetOrdinal(0);
    //                dtAttXml.Columns["ProductId"].SetOrdinal(1);
    //                // rowCount = objAttributes.Rows.Count;
    //                objAttributes.Merge(dtAttXml, true, MissingSchemaAction.Ignore);
    //                ViewState["Attributes"] = objAttributes;
    //                gvAttributeValues.DataSource = ViewState["Attributes"]; ;
    //                gvAttributeValues.DataBind();
    //                gvAttributeValues.Visible = true;
    //            }
    //        }
            
    //    }
    //catch (Exception ex)
    //    {
    //        CLogger.LogError("Error On Binding Product Attribute Values - INVAttributes.ascx", ex);
    //    }
    //}

    #region BindProductAttributes
    public void BindProductAttributes(string XmlValues, string strProduct, string actionFlag)
    {
        try
        {
            string sUnit = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVAttributes_ascx_03;
            if (sUnit == null)
            {
                sUnit = "UnitNo";
            }

            string sProductId = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVAttributes_ascx_05;
            if (sProductId == null)
            {
                sProductId = "ProductId";
            }

            string sAssign = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVAttributes_ascx_11;
            if (sAssign == null)
            {
                sAssign = "Assign";
            }


            string[] strProd = strProduct.Split('~');
            DataSet dsXml = new DataSet();
            DataSet dsAttVal = new DataSet();
            int rowCount = 0;
            gvAttributeValues.Visible = false;
            pId = Int64.Parse(strProd[0]);
            if (strProd[1] != sAssign)
            {
                lblReceivedQty.Text = strProd[1];
                QuantityCount = Convert.ToInt64(Convert.ToDecimal(strProd[1]));
                hdnTotalCount.Value = strProd[1];
                if (strProd.Length == 4)
                {
                    hdnUsageLimit.Value = strProd[3];
                }
            }


            if (XmlValues != "")
            {
                StringReader stream = new StringReader(XmlValues);
                dsXml.ReadXml(stream);
                if (dsXml.Tables.Count > 0)
                {
                    DataTable dtXml = dsXml.Tables[0];
                    Utilities.ConvertTo(dsXml.Tables[0], out lstProductAttributes);

                    

                    DataColumn Id = objAttributes.Columns.Add(sUnit);
                    DataColumn pid = objAttributes.Columns.Add(sProductId);
                    Id.AutoIncrement = true;
                    Id.AutoIncrementSeed = 1;
                    pid.DefaultValue = pId;
                    hdnMandatoryFields.Value = "";
                    gvAttributes.DataSource = lstProductAttributes;
                    gvAttributes.DataBind();
                    ViewState["Attributes"] = objAttributes;
                    ModalPopupExtender1.Show();
                }
            }
           
            if (actionFlag == "Update" && strProd[2] != "N")
            {
                StringReader attStream = new StringReader(strProd[2]);
                dsAttVal.ReadXml(attStream);
                if (dsAttVal.Tables.Count > 0)
                {
                    string sIsIssued = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVAttributes_ascx_06;
                    if (sIsIssued == null)
                    {
                        sIsIssued = "IsIssued";
                    }

                    string sUsedSoFor = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVAttributes_ascx_07;
                    if (sUsedSoFor == null)
                    {
                        sUsedSoFor = "UsedSoFor";
                    }

                    string sDescription = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVAttributes_ascx_08;
                    if (sDescription == null)
                    {
                        sDescription = "Description";
                    } 


                    DataTable dtAttXml = dsAttVal.Tables[0];
                    dtAttXml.Columns.Remove(sIsIssued);
                    dtAttXml.Columns.Remove(sUsedSoFor);
                    dtAttXml.Columns.Remove(sDescription);
                    dtAttXml.AcceptChanges();
                    dtAttXml.Columns[sUnit].SetOrdinal(0);
                    dtAttXml.Columns[sProductId].SetOrdinal(1);
                    rowCount = objAttributes.Rows.Count;
                    objAttributes.Merge(dtAttXml, true, MissingSchemaAction.Ignore);
                    ViewState["Attributes"] = objAttributes;
                    gvAttributeValues.DataSource = ViewState["Attributes"]; ;
                    gvAttributeValues.DataBind();
                    hdnGridCount.Value = gvAttributeValues.Rows.Count.ToString();
                    gvAttributeValues.Visible = true;
                }

            }
          

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error On Binding Product Attribute Values - INVAttributes.ascx", ex);
        }


    }
    #endregion

    private int getRowCount(string strXml)
    {
        int count = 0;
        StringReader attStream = new StringReader(strXml);
        DataSet dsVal=new DataSet();
        dsVal.ReadXml(attStream);
        if (dsVal.Tables.Count > 0)
        {
            count=dsVal.Tables[0].Rows.Count;
        }
        return count;
    }

    private void SetProductAttributes(List<ProductAttributes> lstAttributes)
    {
        string sAttributes = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVAttributes_ascx_01;
        if (sAttributes == null)
        {
            sAttributes = "Attributes";
        }

        string sValues = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVAttributes_ascx_02;
        if (sValues == null)
        {
            sValues = "Values";
        }

        string sUnitNO = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVAttributes_ascx_03;
        if (sUnitNO == null)
        {
            sUnitNO = "UnitNo";
        }

        string sName = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVAttributes_ascx_04;
        if (sName == null)
        {
            sName = "Name";
        }
        
        TableRow rowH = new TableRow();
        TableCell cellH1 = new TableCell();
        TableCell cellH2 = new TableCell();
        cellH1.Attributes.Add("class", "a-left");
        cellH1.Text = sAttributes;
        cellH1.Width = Unit.Percentage(10);
        cellH2.Attributes.Add("class", "a-left");
        cellH2.Text = sValues;
        cellH2.Width = Unit.Percentage(20);
        rowH.Cells.Add(cellH1);
        rowH.Cells.Add(cellH2);
        rowH.Font.Bold = true;
        rowH.Font.Underline = true;
        rowH.Attributes.Add("class", "greycolor");
        objAttributes.Columns.Add(sUnitNO);
        foreach (ProductAttributes item in lstAttributes)
        {
            
            TableRow rowC = new TableRow();
            TextBox txtBoxV = new TextBox();
            TableCell cell1 = new TableCell();
            TableCell cell2 = new TableCell();
            TableCell cell3 = new TableCell();

            cell1.Attributes.Add("class", "a-center");
            cell1.Text = sName + item.AttributeName;
            cell1.Width = Unit.Percentage(10);
            cell2.Attributes.Add("class", "a-left");
            cell2.Width = Unit.Percentage(20);

            txtBoxV.ID = "ID" + item.AttributeID;

            cell2.Controls.Add(txtBoxV);
            cell3.Attributes.Add("class", "a-left");
            if (item.IsMandatory == "Y")
            {
                cell3.Text = "<img src=\"../PlatForm/Images/starbutton.png\" class=\"v-middle\" />";
            }
            else
            {
                cell3.Text = "";
            }
            rowC.Cells.Add(cell1);
            rowC.Cells.Add(cell2);
            rowC.Cells.Add(cell3);
            rowC.Attributes.Add("class", "black");
        }
        ViewState["Attributes"] = objAttributes;

    }

    protected void gvAttributes_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ProductAttributes obj = (ProductAttributes)e.Row.DataItem;
            objAttributes.Columns.Add(obj.AttributeName);
            Image img = (Image)e.Row.FindControl("imgIsMandatory");
            if (obj.IsMandatory == "Y")
            {
                TextBox txtAttributeValues = (TextBox)e.Row.FindControl("txtAttributeValues");
                img.Visible = true;
                hdnMandatoryFields.Value += txtAttributeValues.ClientID + "~";
            }
            if (obj.IsSelected == "N")
            {
                e.Row.Visible = false;
            }
        }
    }

    protected void BtnAdd_Click(object sender, EventArgs e)
    {
        bool flag;
        gvAttributeValues.Visible = true;
        flag = true;
        BindAttributeValues(flag);

        #region
        //TableRow rowH = new TableRow();
        //foreach (DataColumn col in objAttributes.Rows[0].Table.Columns)
        //{
        //    TableCell cellH = new TableCell();
        //    cellH.Attributes.Add("align", "center");
        //    cellH.Text = col.ColumnName;
        //    rowH.Cells.Add(cellH);
        //    rowH.Font.Bold = true;
        //    rowH.Font.Underline = true;
        //    rowH.Style.Add("color", "#333");
        //    tabAttributes.Rows.Add(rowH);
        //}

        //foreach (DataRow row in objAttributes.Rows)
        //{
        //    TableRow rowC = new TableRow();
        //    TableRow rowE = new TableRow();
        //    foreach (DataColumn col in row.Table.Columns)
        //    {
        //        TableCell cellC = new TableCell();
        //        cellC.Attributes.Add("align", "center");
        //        cellC.Text = row[col.ColumnName].ToString();
        //        rowC.Cells.Add(cellC);
        //        rowC.Style.Add("color", "#000000");
        //        tabAttributes.Rows.Add(rowC);
        //    }

        //    TableCell cellE = new TableCell();
        //    LinkButton lbtnEdit = new LinkButton();
        //    lbtnEdit.ID = "E" + row["UnitNo"].ToString();
        //    HiddenField rId = new HiddenField();
        //    rId.ID = row["UnitNo"].ToString();
        //    rId.Value = row["UnitNo"].ToString();
        //    cellE.Controls.Add(rId);
        //    rowE.Cells.Add(cellE);
        //    tabAttributes.Rows.Add(rowE);
        //}
        #endregion
        gvAttributeValues.DataSource = (DataTable)ViewState["Attributes"];
        gvAttributeValues.DataBind();
        ModalPopupExtender1.Show();
        hdnGridCount.Value = gvAttributeValues.Rows.Count.ToString();
        clearIt();
        
    }
    
    protected void BindAttributeValues(bool pFlag)
    {
        try
        {
            List<AttributeValue> lstTmpAttributeValue = new List<AttributeValue>();
            List<AttributeValue> lstAttributeValue = new List<AttributeValue>();
            if (ViewState["Attributes"] != null)
            {
                objAttributes = (DataTable)ViewState["Attributes"];
                dtAttributeValues = objAttributes.Copy();
                dtAttributeValues.Clear();
            }
            DataRow dr;
            dr = dtAttributeValues.NewRow();
            foreach (GridViewRow item in gvAttributes.Rows)
            {
                Label AttributeName = (Label)item.FindControl("lblAttributes");
                TextBox txtAttributeValues = (TextBox)item.FindControl("txtAttributeValues");
                HiddenField hdnIsMandatory = (HiddenField)item.FindControl("hdnIsMandatory");
                HiddenField hdnValues = (HiddenField)item.FindControl("hdnValues");
                if (txtAttributeValues.Text == "")
                {
                    dr[AttributeName.Text] = "N/A";
                    divNote.Attributes.Add("class", "show");
                }
                else
                {
                    dr[AttributeName.Text] = txtAttributeValues.Text;
                }
            }
            dtAttributeValues.Rows.Add(dr);
            Utilities.ConvertTo(objAttributes, out lstAttributeValue);
            Utilities.ConvertTo(dtAttributeValues, out lstTmpAttributeValue);

            if (lstAttributeValue.Count > 0)
            {
                if (lstAttributeValue.Exists(P => P.ProductNo == lstTmpAttributeValue[0].ProductNo && P.SerialNo == lstTmpAttributeValue[0].SerialNo && P.OtherValue == lstTmpAttributeValue[0].OtherValue))
                {
                    string Message = Resources.InventoryCommon_AppMsg.InventoryCommon_Controls_INVAttributes_ascx_04;
                    if (Message == null)
                    {
                        Message = "Cannot be added multiple times";
                    }
                    string Error = Resources.InventoryCommon_AppMsg.InventoryCommon_Error;
                    if (Error == null)
                    {
                        Error = "Error";
                    }
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "MultipleAdd", "javascript:ValidationWindow('" + Message + "','" + Error + "')", true);
                    return;

                }
            }
             
            if (pFlag == true)
            {
                objAttributes.Merge(dtAttributeValues, true, MissingSchemaAction.Ignore);
            }
            ViewState["Attributes"] = objAttributes;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error On Binding Product Attribute Values - INVAttributes.ascx", ex);
        }

    }

    protected void gvAttributeValues_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ///summa
        }
    }

    protected void gvAttributeValues_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (ViewState["Attributes"] != null)
        {
            objAttributes = (DataTable)ViewState["Attributes"];
        }
        if (e.CommandName == "rEdit")
        {
            foreach (DataRow item in objAttributes.Rows)
            {
                if (item["UnitNo"].ToString() == e.CommandArgument.ToString())
                {
                    break;
                }
            }
        }
        if (e.CommandName == "rDelete")
        {
           
            foreach (DataRow item in objAttributes.Rows)
            {
                if (item["UnitNo"].ToString() == e.CommandArgument.ToString())
                {
                    objAttributes.Rows.Remove(item);
                    QuantityCount++;
                    break;
                }
            }
            objAttributes.AcceptChanges();
        }
        ViewState["Attributes"] = objAttributes;
        gvAttributeValues.DataSource = objAttributes;
        gvAttributeValues.DataBind();
        ModalPopupExtender1.Show();
        hdnGridCount.Value = gvAttributeValues.Rows.Count.ToString();
    }

    protected void btnOK_Click(object sender, EventArgs e)
    {
        string result = string.Empty;

        if (QuantityCount == 0)
        {
            if (ViewState["Attributes"] != null)
            {
                objAttributes = (DataTable)ViewState["Attributes"];
                result = getProductAttributeValues(objAttributes);
                hdnAttValue.Value=result;
                ScriptManager.RegisterStartupScript(this,this.GetType(),"getAttrib","SetAttrib()",true);
            }
        }
    }


    public string getProductAttributeValues(DataTable dt)
    {
        string strXml = string.Empty;
        bool pFlag;
        try
        {
            string sAttributeValues = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVAttributes_ascx_09;
            if (sAttributeValues == null)
            {
                sAttributeValues = "AttributeValues";
            }

            string sUnits = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVAttributes_ascx_10;
            if (sUnits == null)
            {
                sUnits = "Units";
            }

            string sIssued = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVAttributes_ascx_06;
            if (sIssued == null)
            {
                sIssued = "IsIssued";
            }

            string sUsedFor = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVAttributes_ascx_07;
            if (sUsedFor == null)
            {
                sUsedFor = "UsedSoFor";
            }

            string Description1 = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVAttributes_ascx_08;
            if (Description1 == null)
            {
                Description1 = "Description";
            }

            XmlDocument xmlDoc = new XmlDocument();
            XmlNode declaration = xmlDoc.CreateNode(XmlNodeType.XmlDeclaration, null, null);
            xmlDoc.AppendChild(declaration);
            XmlElement root;
            root = xmlDoc.CreateElement(sAttributeValues);
            xmlDoc.AppendChild(root);
            int i = 1;

            foreach (DataRow item in dt.Rows)
            {

                pFlag = true;
                XmlElement rootElt = xmlDoc.CreateElement(sUnits);
                root.AppendChild(rootElt);
                foreach (DataColumn col in item.Table.Columns)
                {
                    if (pFlag == true)
                    {
                        XmlAttribute unitAttrib = xmlDoc.CreateAttribute(col.ColumnName);
                        unitAttrib.Value = i.ToString();
                        rootElt.Attributes.Append(unitAttrib);
                        pFlag = false;
                    }
                    else
                    {
                        XmlAttribute prodAttribute = xmlDoc.CreateAttribute(col.ColumnName);
                        prodAttribute.Value = item[col.ColumnName].ToString();
                        rootElt.Attributes.Append(prodAttribute);
                    }
                }
                i++;
                XmlAttribute IsIssued = xmlDoc.CreateAttribute(sIssued);
                IsIssued.Value = "N";
                rootElt.Attributes.Append(IsIssued);

                XmlAttribute UsedSoFor = xmlDoc.CreateAttribute(sUsedFor);
                UsedSoFor.Value = "0";
                if (int.Parse(hdnUsageLimit.Value) > 0)
                {
                   // UsedSoFor.Value = "0";
                }
                rootElt.Attributes.Append(UsedSoFor);

                XmlAttribute Description = xmlDoc.CreateAttribute(Description1);
                Description.Value = "";
                rootElt.Attributes.Append(Description);

                root.AppendChild(rootElt);
            }
            strXml = xmlDoc.InnerXml;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error On getProductAttributeValues - INVAttributes.ascx", ex);
            return "";
        }
        return strXml;
    }
    
    protected void clearIt()
    {
        for (int i = 0; i < gvAttributes.Rows.Count; i++)
        {
            TextBox txtAttributeValues = (TextBox)gvAttributes.Rows[i].FindControl("txtAttributeValues");
            txtAttributeValues.Text = "";
        }
    }
   
}
