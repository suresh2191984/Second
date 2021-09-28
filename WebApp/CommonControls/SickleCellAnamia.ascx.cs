using System;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Text;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Collections.Generic;
using Attune.Podium.SmartAccessor;
using System.Linq;
using Attune.Podium.EMR;
using Attune.Podium.Common;
using System.Data;

public partial class CommonControls_SickleCellAnamia : BaseControl
{
    private string id;
    private string attriName;
    public string AttriName
    {
        get { return attriName; }
        set
        {
            attriName = value;
        }
    }
    public string ControlID
    {
        get { return id; }
        set
        {
            id = value;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public void SetData(List<PatientComplaintAttribute> lsthisPCA, long ID)
    {
        var lstAnaemia = from s in lsthisPCA
                     where s.ComplaintID == ID
                     select s;
        if (lstAnaemia.Count() > 0)
        {
            List<EMRAttributeClass> Anaemiatype = (from d in lstAnaemia
                                                  where d.AttributeID == 29
                                                  select new EMRAttributeClass
                                                  {
                                                      AttributeName = d.AttributeName,
                                                      AttributevalueID = d.AttributevalueID,
                                                      AttributeValueName = d.AttributeValueName
                                                  }).ToList();


            //lstEMRvalue.Name = "Complaint";
            //lstEMRvalue.Attributename = "Cancer";
            //lstEMRvalue.Attributeid = 13;
            //lstEMRvalue.Attributevaluename = cancertype[0].AttributeName;
            ////EMR9.Bind(lstEMRvalue, cancertype);


            ddlType_465.DataSource = Anaemiatype.ToList();
            ddlType_465.DataTextField = "AttributeValueName";
            ddlType_465.DataValueField = "AttributevalueID";
            ddlType_465.DataBind();
            List<EMRAttributeClass> Anaemia = (from d in lstAnaemia
                                                   where d.AttributeID == 30
                                                   select new EMRAttributeClass
                                                   {
                                                       AttributeName = d.AttributeName,
                                                       AttributevalueID = d.AttributevalueID,
                                                       AttributeValueName = d.AttributeValueName
                                                   }).ToList();
            //ddlAnaemia.DataSource = Anaemia.ToList();
            //ddlAnaemia.DataTextField = "AttributeValueName";
            //ddlAnaemia.DataValueField = "AttributevalueID";
            //ddlAnaemia.DataBind();
            {
                DropDownList ddl = new DropDownList();
                ddl.ID = "ddlChkList";
                ListItem lstItem = new ListItem();
                ddl.Items.Insert(0, lstItem);
                ddl.Width = new Unit(155);
                ddl.Attributes.Add("onmousedown", "showdivonClick1()");
                CheckBoxList chkBxLst = new CheckBoxList();
                chkBxLst.ID = "chkLstItem";
                chkBxLst.Attributes.Add("onmouseover", "showdiv1()");
                DataTable dtListItem = GetListItem(Anaemia);
                int rowNo = dtListItem.Rows.Count;
                string lstValue = string.Empty;
                string lstID = string.Empty;
                for (int i = 0; i < rowNo; i++)
                {
                    lstValue = dtListItem.Rows[i]["Value"].ToString();
                    lstID = dtListItem.Rows[i]["ID"].ToString();
                    lstItem = new ListItem("<a href=\"javascript:void(0)\" id=\"alst\" style=\"text-decoration:none;color:Black; \" onclick=\"getSelectedItem(' " + lstValue + "','" + i + "','" + lstID + "','anchor');\">" + lstValue + "</a>", dtListItem.Rows[i]["ID"].ToString());
                    lstItem.Attributes.Add("onclick", "getSelectedItem1('" + lstValue + "','" + i + "','" + lstID + "','listItem');");
                    lstItem.Value = dtListItem.Rows[i]["AttributeValue"].ToString();
                    lstItem.Text = dtListItem.Rows[i]["Value"].ToString();
                    chkBxLst.Items.Add(lstItem);
                }
                System.Web.UI.HtmlControls.HtmlGenericControl div = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
                div.ID = "divChkList";
                div.Controls.Add(chkBxLst);
                div.Style.Add("border", "black 1px solid");
                div.Style.Add("width", "160px");
                div.Style.Add("height", "180px");
                div.Style.Add("overflow", "AUTO");
                div.Style.Add("display", "none");
                phDDLCHKAnaemia.Controls.Add(ddl);
                phDDLCHKAnaemia.Controls.Add(div);
            }
        }
        rdoNo_465.Checked = true;
        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:showContentHis('"+rdoNo_465.ID+"');", true);
    }

    public void EditData(List<PatientComplaintAttribute> lstPCA, long ID)
    {
        List<PatientComplaintAttribute> lstEditData = (from s in lstPCA
                                                     where s.ComplaintID == ID
                                                     select s).ToList();
        CheckBoxList chklist = (CheckBoxList)phDDLCHKAnaemia.FindControl("chkLstItem");
        DropDownList ddllist = (DropDownList)phDDLCHKAnaemia.FindControl("ddlChkList");
        int cnt = 0;
        string text = "";
        for (int j = 0; j < lstEditData.Count(); j++)
        {
            if (lstEditData[j].ComplaintID == ID)
            {
                divrdoYes_465.Style.Add("display", "block");
                rdoYes_465.Checked = true;
                rdoNo_465.Checked = false;
                for (int i = 0; i < chklist.Items.Count; i++)
                {
                    if (chklist.Items[i].Value == lstEditData[j].AttributevalueID.ToString())
                    {
                        chklist.Items[i].Selected = true;
                        cnt = cnt + 1;
                        if (text == "")
                        {
                            text = lstEditData[j].AttributeValueName;
                        }
                        else
                            text = text + "," + lstEditData[j].AttributeValueName;
                    }
                }

                ddllist.SelectedItem.Text = cnt + " items";
                lblCheckItemsAnaemia.Text = text;
                if (lstEditData[j].AttributeID == 29)
                {
                    ddlType_465.SelectedItem.Value = lstEditData[j].AttributevalueID.ToString();
                }
               
            }
        }
    }
    public long GetData(out List<PatientComplaint> attribute, out List<PatientComplaintAttribute> attrValue)
    {
        int returnval = -1;
        attribute = new List<PatientComplaint>();
        attrValue = new List<PatientComplaintAttribute>();
        List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
        List<PatientComplaintAttribute> lstPatientComplaintAttribute = new List<PatientComplaintAttribute>();
        if (rdoYes_465.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = 465;
            lstPatientComplaint.Add(objPatientComplaint);
            attribute.Add(objPatientComplaint);

            CheckBoxList chklist = (CheckBoxList)phDDLCHKAnaemia.FindControl("chkLstItem");
            
            for (int i = 0; i < chklist.Items.Count; i++)
            {
                if (chklist.Items[i].Selected == true)
                {
                    PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                    objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(465);
                    objPatientComplaintAttribute.AttributeID = Convert.ToInt64(29);
                    objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(chklist.Items[i].Value);
                    objPatientComplaintAttribute.AttributeValueName = chklist.Items[i].Text.ToString();
                    lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                    attrValue.Add(objPatientComplaintAttribute);
                }
            }
            PatientComplaintAttribute objPatientComplaintAttribute1 = new PatientComplaintAttribute();
            objPatientComplaintAttribute1.ComplaintID = Convert.ToInt32(465);
            objPatientComplaintAttribute1.AttributeID = Convert.ToInt64(29);
            objPatientComplaintAttribute1.AttributevalueID = Convert.ToInt32(ddlType_465.SelectedValue);
            if (ddlType_465.SelectedItem.Text == "Others")
            {
                objPatientComplaintAttribute1.AttributeValueName = txtothers_465.Text;
            }
            else objPatientComplaintAttribute1.AttributeValueName = ddlType_465.SelectedItem.Text;
            lstPatientComplaintAttribute.Add(objPatientComplaintAttribute1);
            attrValue.Add(objPatientComplaintAttribute1);
        }
        return returnval;
    }
    public DataTable GetListItem(List<EMRAttributeClass> drugs)
    {
        DataTable table = new DataTable();
        table.Columns.Add("ID", typeof(int));
        table.Columns.Add("Value", typeof(string));
        table.Columns.Add("AttributeValue", typeof(int));
        for (int i = 0; i < drugs.Count; i++)
        {
            table.Rows.Add((i + 1), drugs[i].AttributeValueName, drugs[i].AttributevalueID);
        }
        return table;
    }
}
