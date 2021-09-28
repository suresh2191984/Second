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

public partial class CommonControls_ParasiticInfections : BaseControl
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
        var lstPara = from s in lsthisPCA
                        where s.ComplaintID == ID
                        select s;
        if (lstPara.Count() > 0)
        {
            List<EMRAttributeClass> ParaType = (from d in lstPara
                                                       where d.AttributeID == 33
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
            ddl.Attributes.Add("onmousedown", "showdivonClick2()");
            CheckBoxList chkBxLst = new CheckBoxList();
            chkBxLst.ID = "chkLstItem";
            chkBxLst.Attributes.Add("onmouseover", "showdiv2()");
            DataTable dtListItem = GetListItem(ParaType);
            int rowNo = dtListItem.Rows.Count;
            string lstValue = string.Empty;
            string lstID = string.Empty;
            for (int i = 0; i < rowNo; i++)
            {
                lstValue = dtListItem.Rows[i]["Value"].ToString();
                lstID = dtListItem.Rows[i]["ID"].ToString();
                lstItem = new ListItem("<a href=\"javascript:void(0)\" id=\"alst\" style=\"text-decoration:none;color:Black; \" onclick=\"getSelectedItem(' " + lstValue + "','" + i + "','" + lstID + "','anchor');\">" + lstValue + "</a>", dtListItem.Rows[i]["ID"].ToString());
                lstItem.Attributes.Add("onclick", "getSelectedItem2('" + lstValue + "','" + i + "','" + lstID + "','listItem');");
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
            phDDLCHKPara.Controls.Add(ddl);
            phDDLCHKPara.Controls.Add(div);
        }
        rdoNo_972.Checked = true;
    }
     public DataTable GetListItem(List<EMRAttributeClass> ParaType)
     {
         DataTable table = new DataTable();
         table.Columns.Add("ID", typeof(int));
         table.Columns.Add("Value", typeof(string));
         table.Columns.Add("AttributeValue", typeof(int));
         for (int i = 0; i < ParaType.Count; i++)
         {
             table.Rows.Add((i + 1), ParaType[i].AttributeValueName, ParaType[i].AttributevalueID);
         }
         return table;
     }
    public void EditData(List<PatientComplaintAttribute> lstPCA, long ID)
    {
        List<PatientComplaintAttribute> lstEditData = (from s in lstPCA
                                                       where s.ComplaintID == ID
                                                       select s).ToList();
        CheckBoxList chklist = (CheckBoxList)phDDLCHKPara.FindControl("chkLstItem");
        DropDownList ddllist = (DropDownList)phDDLCHKPara.FindControl("ddlChkList");
        int cnt = 0;
        string text = "";
        for (int j = 0; j < lstEditData.Count(); j++)
        {
            if (lstEditData[j].ComplaintID == ID)
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
                lblCheckItemsPara.Text = text;
                //if (lstEditData[j].AttributeID == 34)
                //{
                //    if (lstEditData[j].AttributeValueName != "")
                //    {
                //        chkJaundice.Checked = true;
                //    }
                //    else chkJaundice.Checked = false;
                //}
                divrdoYes_972.Style.Add("display", "block");
                rdoYes_972.Checked = true;
                rdoNo_972.Checked = false;
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
        CheckBoxList chklist = (CheckBoxList)phDDLCHKPara.FindControl("chkLstItem");
        if (rdoYes_972.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(972);
            objPatientComplaint.ComplaintName = rdoYes_972.Text;
            lstPatientComplaint.Add(objPatientComplaint);
            attribute.Add(objPatientComplaint);
            for (int i = 0; i < chklist.Items.Count; i++)
            {
                if (chklist.Items[i].Selected == true)
                {
                    PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                    objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(972);
                    objPatientComplaintAttribute.AttributeID = Convert.ToInt64(33);
                    objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(chklist.Items[i].Value);
                    objPatientComplaintAttribute.AttributeValueName = chklist.Items[i].Text.ToString();
                    lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                    attrValue.Add(objPatientComplaintAttribute);
                }
            }

        }
        return returnval;
    }
}
