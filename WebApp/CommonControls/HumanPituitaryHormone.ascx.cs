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

public partial class CommonControls_HumanPituitaryHormone : BaseControl
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
    public void SetData(List<PatientHistoryAttribute> lsthisPHA, long ID)
    {
        var lstHuman = from s in lsthisPHA
                             where s.HistoryID == ID
                             select s;
        if (lstHuman.Count() > 0)
        {
            List<EMRAttributeClass> Meditype = (from d in lstHuman
                                                   where d.AttributeID == 124
                                                   select new EMRAttributeClass
                                                   {
                                                       AttributeName = d.AttributeName,
                                                       AttributevalueID = d.AttributevalueID,
                                                       AttributeValueName = d.AttributeValueName
                                                   }).ToList();

            DropDownList ddl = new DropDownList();
            ddl.ID = "ddlChkList";
            ListItem lstItem = new ListItem();
            ddl.Items.Insert(0, lstItem);
            ddl.Width = new Unit(155);
            ddl.Attributes.Add("onmousedown", "showdivonClick3()");
            CheckBoxList chkBxLst = new CheckBoxList();
            chkBxLst.ID = "chkLstItem";
            chkBxLst.Attributes.Add("onmouseover", "showdiv3()");
            DataTable dtListItem = GetListItem(Meditype);
            int rowNo = dtListItem.Rows.Count;
            string lstValue = string.Empty;
            string lstID = string.Empty;
            for (int i = 0; i < rowNo; i++)
            {
                lstValue = dtListItem.Rows[i]["Value"].ToString();
                lstID = dtListItem.Rows[i]["ID"].ToString();
                lstItem = new ListItem("<a href=\"javascript:void(0)\" id=\"alst\" style=\"text-decoration:none;color:Black; \" onclick=\"getSelectedItem(' " + lstValue + "','" + i + "','" + lstID + "','anchor');\">" + lstValue + "</a>", dtListItem.Rows[i]["ID"].ToString());
                lstItem.Attributes.Add("onclick", "getSelectedItem3('" + lstValue + "','" + i + "','" + lstID + "','listItem');");
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
            phDDLCHKMedication.Controls.Add(ddl);
            phDDLCHKMedication.Controls.Add(div);
        }
        rdoNo_1112.Checked = true;
    }
    public DataTable GetListItem(List<EMRAttributeClass> medication)
    {
        DataTable table = new DataTable();
        table.Columns.Add("ID", typeof(int));
        table.Columns.Add("Value", typeof(string));
        table.Columns.Add("AttributeValue", typeof(int));
        for (int i = 0; i < medication.Count; i++)
        {
            table.Rows.Add((i + 1), medication[i].AttributeValueName,medication[i].AttributevalueID);
        }
        return table;
    }

    public void EditData(List<PatientHistoryAttribute> lstPHA, long ID)
    {
        List<PatientHistoryAttribute> lstEditData = (from s in lstPHA
                                                       where s.HistoryID == ID
                                                       select s).ToList();
        CheckBoxList chklist = (CheckBoxList)phDDLCHKMedication.FindControl("chkLstItem");
        DropDownList ddllist = (DropDownList)phDDLCHKMedication.FindControl("ddlChkList");
        int cnt = 0;
        string text = "";
        for (int j = 0; j < lstEditData.Count(); j++)
        {
            if (lstEditData[j].HistoryID == ID)
            {
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
                lblCheckItemsMedication.Text = text;
                divrdoYes_1112.Style.Add("display", "block");
                rdoYes_1112.Checked = true;
                rdoNo_1112.Checked = false;
            }
        }
    }
    public long GetData(out List<PatientHistory> attribute, out List<PatientHistoryAttribute> attrValue)
    {
        int returnval = -1;
        attribute = new List<PatientHistory>();
        attrValue = new List<PatientHistoryAttribute>();
        List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
        List<PatientHistoryAttribute> lstPatientHistoryAttribute = new List<PatientHistoryAttribute>();

        if (rdoYes_1112.Checked == true)
        {
            PatientHistory objPatientHistory = new PatientHistory();
            objPatientHistory.HistoryID = Convert.ToInt32(1112);
            objPatientHistory.HistoryName = rdoYes_1112.Text;
            lstPatientHistory.Add(objPatientHistory);
            attribute.Add(objPatientHistory);
            CheckBoxList chklist = (CheckBoxList)phDDLCHKMedication.FindControl("chkLstItem");
            for (int i = 0; i < chklist.Items.Count; i++)
            {
                if (chklist.Items[i].Selected == true)
                {
                    PatientHistoryAttribute objPatientHistoryAttribute = new PatientHistoryAttribute();
                    objPatientHistoryAttribute.HistoryID = Convert.ToInt32(1112);
                    objPatientHistoryAttribute.AttributeID = Convert.ToInt64(124);
                    objPatientHistoryAttribute.AttributevalueID = Convert.ToInt32(chklist.Items[i].Value);
                    objPatientHistoryAttribute.AttributeValueName = chklist.Items[i].Text.ToString();
                    lstPatientHistoryAttribute.Add(objPatientHistoryAttribute);
                    attrValue.Add(objPatientHistoryAttribute);
                }
            }
        }
        return returnval;
    }
}
