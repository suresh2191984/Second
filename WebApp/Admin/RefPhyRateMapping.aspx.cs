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

public partial class RefPhyRateMapping : BasePage
{
    long Returncode = -1;

    AdminReports_BL objBl;
    RateMaster RTM = new RateMaster();
    List<RateTypeMaster> lstRateTypeMaster = new List<RateTypeMaster>();
    List<RateMaster> lstRateType = new List<RateMaster>();      
    protected void Page_Load(object sender, EventArgs e)
    {
        objBl = new AdminReports_BL(base.ContextInfo);
        try
        {
            if (!IsPostBack)
            {
                // LoadClientType();
                // LoadExistingCorporate();
                // loadExistingClient();
         lbl_Type.Text = "Selet Client name";
                hdnClient.Value = String.Empty;
                loadExistingClient();
                loadExistingTPA();
                loadRateType();
                loaddata();
                hdID.Value = "0";
                hdnTPA.Value = "";
                hdnAttributes.Value = String.Empty;
                rdoClient.Checked = true;
                ratetype.Attributes.Add("Style", "display:block");
                divClientType.Attributes.Add("Style", "display:block");
            }
            //if (IsPostBack)
            //{
            //    rdoClient.Visible = true;
            //}
        }
        catch (Exception ex)
        {
            CLogger.LogError("Problem on Page Load", ex);
        }
    }
    public void loaddata()
    {
        try
        {
            string OrgType = "COrg";
            Returncode = objBl.pGetRateTypeMaster(OrgID, OrgType, out lstRateType);
            if (lstRateType.Count > 0)
            {                
                foreach (RateMaster items in lstRateType)
                {
                    hdnClient.Value += items.RateId + "~" + items.RateName + "~" + '0' + "^";// items.RateTypeId + "^";
                    if (items.RateName == "GENERAL")
                    {
                        hdnddlTPARateID.Value =Convert.ToString(items.RateId);
                    }
                }
                ddlTPARate.DataSource = lstRateType;
                ddlTPARate.DataTextField = "RATENAME";
                ddlTPARate.DataValueField = "RATEID";
                ddlTPARate.DataBind();
                
                //thiyagu added--removed rate type for client selection
                ddlRateType.DataSource = lstRateType;
                ddlRateType.DataTextField = "RATENAME";
                ddlRateType.DataValueField = "RATEID";
                ddlRateType.DataBind();
                ratetype.Attributes.Add("Style", "display:block");
            }
            else
            {
                ddlRateType.DataSource = null;
                ddlRateType.DataBind();
                ddlTPARate.DataSource = null;
                ddlTPARate.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load data", ex);
        }
    }
    public void loadRateType()
    {
        try
        {
            Returncode = objBl.pGetRateMaster(OrgID, out lstRateTypeMaster);
            if (lstRateTypeMaster.Count > 0)
            {
                ddlRate.DataSource = lstRateTypeMaster;
                ddlRate.DataTextField = "RateTypeName";
                ddlRate.DataValueField = "RateId";
                ddlRate.DataBind();
                ddlRate.Items.Insert(0, "--Select-->");
            }
            else
            {
                ddlRate.DataSource = null;
                ddlRate.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load data", ex);
        } 
    }
    //private void LoadClientType()
    //{
    //    Patient_BL objPatient_BL = new Patient_BL(base.ContextInfo);
    //    List<InvClientType> lstInvClientType = new List<InvClientType>();
    //    objPatient_BL.GetInvClientType(out lstInvClientType);
    //    ddlClientType.DataSource = lstInvClientType;
    //    ddlClientType.DataTextField = "ClientTypeName";
    //    ddlClientType.DataValueField = "ClientTypeID";
    //    ddlClientType.DataBind();
    //    ddlClientType.Items.Add(new ListItem("Others", "0"));
    //}
    //private void LoadExistingCorporate()
    //{
    //    try
    //    {
    //        IP_BL objIP_BL = new IP_BL(base.ContextInfo);
    //        List<CorporateMaster> lstCorporateMaster = new List<CorporateMaster>();
    //        objIP_BL.GetCorporateMaster(OrgID, out lstCorporateMaster);
    //        gvCorporate.DataSource = lstCorporateMaster;
    //        gvCorporate.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while Load Corporate", ex);
    //    }
    //}
    private void loadExistingClient()
    {
        try
        {
            Investigation_BL objInvestigation_BL = new Investigation_BL(base.ContextInfo);
            List<InvClientMaster> lstInvClientMaster = new List<InvClientMaster>();
            InvClientMaster ICM = new InvClientMaster();            
            objInvestigation_BL.getOrgClientName(OrgID, out lstInvClientMaster);
            gvClient.DataSource = lstInvClientMaster;
            gvClient.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Load Client", ex);
        }
    }
    private void loadExistingTPA()
    {
        try
        {
            Investigation_BL objInvestigation_BL = new Investigation_BL(base.ContextInfo);
            List<TPAMaster> lstTPAMaster = new List<TPAMaster>();
            objInvestigation_BL.getOrgTPAName(OrgID, out lstTPAMaster);
            gvTRA.DataSource = lstTPAMaster;
            gvTRA.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save TPA", ex);
        }
    }

    protected void bsave_Click(object sender, EventArgs e)
    {
        IP_BL objIP_BL = new IP_BL(base.ContextInfo);
        Investigation_BL objInvestigation_BL = new Investigation_BL(base.ContextInfo);
        InvClientMaster objInvClientMaster = new InvClientMaster();
        CorporateMaster objCorporateMaster = new CorporateMaster();
        TPAMaster objTPAMaster = new TPAMaster();
        long lresult = -1;
        try
        {            
            if (rdoClient.Checked == true)
            {
                if (hdnClient.Value != "")
                {
                    objInvClientMaster.ClientName = txtName.Text;
                    //objInvClientMaster.ClientTypeID = int.Parse(ddlClientType.SelectedValue);
                    objInvClientMaster.OrgID = OrgID;
                    objInvClientMaster.ClientAttributes = CreateClientXML();
                    objInvClientMaster.ClientID = int.Parse(hdnClient.Value);
                    objInvClientMaster.RateId = Convert.ToInt16(ddlRateType.SelectedItem.Value);
                    objInvClientMaster.RateTypeId = Convert.ToInt16(ddlRate.SelectedItem.Value);
                    string sClientName = txtName.Text.Trim();
                    //string sClientvalue= txtValue.Text.Trim();
                    lresult = objInvestigation_BL.UpdateClientMaster(objInvClientMaster);

                }
                else
                {
                    objInvClientMaster.ClientName = txtName.Text;
                    //objInvClientMaster.ClientTypeID = int.Parse(ddlClientType.SelectedValue);
                    objInvClientMaster.OrgID = OrgID;
                    objInvClientMaster.ClientAttributes = CreateClientXML();
                    objInvClientMaster.ClientID = int.Parse(hdID.Value);
                    string sClientName = txtName.Text.Trim();
                    lresult = objInvestigation_BL.SaveClientMaster(objInvClientMaster, sClientName, Convert.ToInt16(-1), Convert.ToInt16(ddlRateType.SelectedValue));
                    if (lresult == -1)
                    {
                        ErrorDisplay1.ShowError = true;
                        ErrorDisplay1.Status = "Client Name is already Exist";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('Client Name is already Exist');", true);
                        txtName.Text = String.Empty;
                        txtClientAttributes.Text = String.Empty;
                        txtValue.Text = string.Empty;
                        hdnAttributes.Value = String.Empty;
                        return;
                    }
                }
            }
            if (rdoTPA.Checked == true)
            {
                if (hdnTPA.Value != "")
                {
                    objTPAMaster.TPAID = Convert.ToInt64(hdnTPA.Value);
                    objTPAMaster.TPAName = txtName.Text;
                    objTPAMaster.TPAAttributes = CreateXML();
                    objTPAMaster.OrgID = OrgID;
                    objTPAMaster.RateId = Convert.ToInt16(ddlTPARate.SelectedItem.Value);
                    lresult = objInvestigation_BL.UpdateTPAMaster(objTPAMaster);
                }
                else
                {
                    objTPAMaster.TPAName = txtName.Text;
                    objTPAMaster.OrgID = OrgID;
                    objTPAMaster.TPAAttributes = CreateXML();
                    objTPAMaster.RateId = Convert.ToInt16(ddlTPARate.SelectedItem.Value);
                    //objTPAMaster.TPAAttributes
                    lresult = objInvestigation_BL.SaveTPAMaster(objTPAMaster);
                    hdnAttributes.Value = String.Empty;
                }
                if (lresult == -1)
                {
                    ErrorDisplay1.ShowError = true;
                    ErrorDisplay1.Status = "Insurance or TPA Name is already Exist";
                    //this.Page.RegisterStartupScript("key1", "<script language='javascript'>alert('" + ErrorDisplay1.Status + "'); </script>");
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('Insurance or TPA Name already Exist');", true);
                    txtName.Text = String.Empty;
                    txtAttributes.Text = String.Empty;
                    txtTpaValue.Text = String.Empty;
                    hdnAttributes.Value = String.Empty;
                    return;
                }
            }
            //Response.Redirect("AddCorpClient.aspx");
            Helper.PageRedirect(this.Page, "AddCorpClient.aspx");
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Save Corporate And Client", Ex);
        }
    }    
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            string Uavailable = string.Empty;
            long ClientID = 0;
            string sClientTypeName = "";
            string sMessageType = "";
            long.TryParse(hdID.Value, out ClientID);
            if (rdoClient.Checked == true)
            {
                sClientTypeName = "CLIE";
                sMessageType = "Client";
                long.TryParse(hdnClient.Value, out ClientID);
            }
            //else if (rdoCorporate.Checked == true)
            //{
            //    sClientTypeName = "CORP";
            //    sMessageType = "Corporate";
            //}
            else if (rdoTPA.Checked == true)
            {
                sClientTypeName = "TPA";
                sMessageType = "TPA/Insurance";
                long.TryParse(hdnTPA.Value, out ClientID);
            }
            new Investigation_BL(base.ContextInfo).DeleteClientCorporate(OrgID, ClientID, sClientTypeName,out Uavailable);
            if (Uavailable == "YES")
            {
                ErrorDisplay1.Status = "Deleted Successfully";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('Deleted Successfully');", true);
                txtName.Text = String.Empty;
                txtAttributes.Text = String.Empty;
                hdnAttributes.Value = String.Empty;
                
            }
            else
            {
                ErrorDisplay1.Status = "This Client / TPA is already associated with a Patient. Hence this cannot be deleted";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('This Client / TPA is already associated with a Patient. Hence this cannot be deleted');", true);
                txtName.Text = String.Empty;
                txtAttributes.Text = String.Empty;
                hdnAttributes.Value = String.Empty;
               

            }
           // LoadClientType();
          //  LoadExistingCorporate();
            loadExistingClient();
            loadExistingTPA();
            hdID.Value = "0";
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Canceling Corporate And Client", ex);
        }

    }
    string CreateXML()
    {
        //11~as~AlphaNumeric^12~asas~AlphaNumeric^

        XmlDocument Doc = new XmlDocument();
        Doc.LoadXml("<TpaAttributes></TpaAttributes>");
        XmlNode xmlNode;

        foreach (string O in hdnAttributes.Value.Split('^'))
        {
            if (O != string.Empty)
            {
                string Id = string.Empty;
                string name = string.Empty;
                string type = string.Empty;
                string value = string.Empty;
                if (O.Split('~')[0] != string.Empty)
                {
                    Id = O.Split('~')[0];
                }
                if (O.Split('~')[1] != string.Empty)
                {
                    name = O.Split('~')[1];
                }
                if (O.Split('~')[2] != string.Empty)
                {
                    type = O.Split('~')[2];
                }
                if (O.Split('~')[3] != string.Empty)
                {
                    value = O.Split('~')[3];
                }
                XmlElement xmlElement = Doc.CreateElement("AttribDetails");
                xmlNode = Doc.CreateNode(XmlNodeType.Element, "ID", "");
                xmlNode.InnerText = Id;
                xmlElement.AppendChild(xmlNode);

                xmlNode = Doc.CreateNode(XmlNodeType.Element, "Name", "");
                xmlNode.InnerText = name;
                xmlElement.AppendChild(xmlNode);

                xmlNode = Doc.CreateNode(XmlNodeType.Element, "Type", "");
                xmlNode.InnerText = type;
                xmlElement.AppendChild(xmlNode);

                xmlNode = Doc.CreateNode(XmlNodeType.Element, "Value", "");
                xmlNode.InnerText = value;
                xmlElement.AppendChild(xmlNode);
                Doc.DocumentElement.AppendChild(xmlElement);

                    
            }
        }
        //Doc.Save(@"d:\a.xml");
        return Doc.InnerXml;

    }

    protected void gvTRA_RowDataBound(object sender, GridViewRowEventArgs e)
    {        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TPAMaster p = (TPAMaster)e.Row.DataItem;
            //string strScript = "SelectRowCommon('" + ((RadioButton)e..Row.Cells[1].FindControl("rdSel")).ClientID + "','" + p.PatientID + "','" + p.OrgID + "');";
            //((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            //((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
            string HIDstr = "";
            if ((p.TPAAttributes != null) && (p.TPAAttributes != string.Empty))
            {
                HIDstr = CustomiseString(p.TPAAttributes);
            }
            else
            {
                HIDstr = "";
            }
            string strScript = "SetTPAId('" + ((RadioButton)e.Row.FindControl("rdSel")).ClientID + "','" + p.TPAName + "','" + p.TPAID + "','" + HIDstr + "','" + p.RateId  + "');";
            // ((CheckBox)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.FindControl("rdSel")).Attributes.Add("onclick", strScript);
        }
    }
    string CustomiseString(string XMLString)
    {
        string HdnText = string.Empty;        
            XmlDocument Doc = new XmlDocument();
            Doc.LoadXml(XMLString);
            string str = Doc.InnerXml;          
 
            int count = Doc.GetElementsByTagName("AttribDetails").Count;
            //11~as~AlphaNumeric^12~asas~AlphaNumeric^
            foreach (XmlNode xmNode in Doc.GetElementsByTagName("AttribDetails"))
            {
                HdnText += xmNode["ID"].InnerText + "~" + xmNode["Name"].InnerText + "~" + xmNode["Type"].InnerText + "~" + xmNode["Value"].InnerText + "^";
            }        
        return HdnText;
    }

    string CreateClientXML()
    {
        //11~as~AlphaNumeric^12~asas~AlphaNumeric^

        XmlDocument Doc = new XmlDocument();
        Doc.LoadXml("<ClientAttributes></ClientAttributes>");
        XmlNode xmlNode;

        foreach (string O in hdnClientAttributes.Value.Split('^'))
        {
            if (O != string.Empty)
            {
                string Id = string.Empty;
                string name = string.Empty;
                string type = string.Empty;
                string value = string.Empty;
                if (O.Split('~')[0] != string.Empty)
                {
                    Id = O.Split('~')[0];
                }
                if (O.Split('~')[1] != string.Empty)
                {
                    name = O.Split('~')[1];
                }
                if (O.Split('~')[2] != string.Empty)
                {
                    type = O.Split('~')[2];
                }
                if (O.Split('~')[3] != string.Empty)
                {
                    value = O.Split('~')[3];
                }
                XmlElement xmlElement = Doc.CreateElement("AttribDetails");
                xmlNode = Doc.CreateNode(XmlNodeType.Element, "ID", "");
                xmlNode.InnerText = Id;
                xmlElement.AppendChild(xmlNode);

                xmlNode = Doc.CreateNode(XmlNodeType.Element, "Name", "");
                xmlNode.InnerText = name;
                xmlElement.AppendChild(xmlNode);

                xmlNode = Doc.CreateNode(XmlNodeType.Element, "Type", "");
                xmlNode.InnerText = type;
                xmlElement.AppendChild(xmlNode);

                xmlNode = Doc.CreateNode(XmlNodeType.Element, "Value", "");
                xmlNode.InnerText = value;
                xmlElement.AppendChild(xmlNode);
                Doc.DocumentElement.AppendChild(xmlElement);
            }
        }
        //Doc.Save(@"d:\a.xml");
        return Doc.InnerXml;

    }
    protected void gvClient_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            InvClientMaster p = (InvClientMaster)e.Row.DataItem;
            string HIDstr = "";
            if ((p.ClientAttributes != null) && (p.ClientAttributes != string.Empty))
            {
                HIDstr = CustomiseString(p.ClientAttributes);
            }
            else
            {
                HIDstr = "";
            }
            string strScript = "SetClientId('" + ((RadioButton)e.Row.FindControl("rdoSel")).ClientID + "','" + p.ClientName + "','" + p.ClientID + "','" + HIDstr + "','" + p.RateId + "','" + p.RateTypeName + "');";
            // ((CheckBox)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.FindControl("rdoSel")).Attributes.Add("onclick", strScript);
        }
    }
 
}


