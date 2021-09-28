using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Collections;
using System.Text;
using System.Data;

public partial class CommonControls_OrganTransplant : BaseControl
{
    public string ComplaintHeader { get; set; }
    public string DefaultComplaintID { get; set; }
    public int ComplaintID { get; set; }
    public string ComplaintName { get; set; }
    public string AddBtnVisible { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {

        //lblComplaint.Text = ComplaintHeader;

    }

    public void SetData(List<PatientComplaintAttribute> lsthisPCA, long ID)
    {
        List<PatientComplaintAttribute> lstOrganTransplant = (from s in lsthisPCA
                                 where s.ComplaintID == ID
                                 select s).Distinct().ToList();
        if (lstOrganTransplant.Count() > 0)
        {
           
            DropDownList ddl = new DropDownList();
            ddl.ID = "ddlChkList";
            ListItem lstItem = new ListItem();
            ddl.Items.Insert(0, lstItem);
            ddl.Width = new Unit(155);
            ddl.Attributes.Add("onmousedown", "showdivonClick()");
            CheckBoxList chkBxLst = new CheckBoxList();
            chkBxLst.ID = "chkLstItem";
            chkBxLst.Attributes.Add("onmouseover", "showdiv()");
            DataTable dtListItem = GetListItem(lstOrganTransplant);
            int rowNo = dtListItem.Rows.Count;
            string lstValue = string.Empty;
            string lstID = string.Empty;
            for (int i = 0; i < rowNo; i++)
            {

                lstValue = dtListItem.Rows[i]["Value"].ToString();
                lstID = dtListItem.Rows[i]["ID"].ToString();
                lstItem = new ListItem("<a href=\"javascript:void(0)\" text=\"'" + lstValue + "'\" value=\"'" + lstID + "'\" id=\"alst\" style=\"text-decoration:none;color:Black; \" onclick=\"getSelectedItem(' " + lstValue + "','" + i + "','" + lstID + "','anchor');\">" + lstValue + "</a>", dtListItem.Rows[i]["ID"].ToString());
                lstItem.Value = dtListItem.Rows[i]["AttributeValue"].ToString();
                lstItem.Text = dtListItem.Rows[i]["Value"].ToString();
                lstItem.Attributes.Add("onclick", "getSelectedItem('" + lstValue + "','" + i + "','" + lstID + "','listItem');");
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
            phDDLCHK.Controls.Add(ddl);
            phDDLCHK.Controls.Add(div);

            List<EMRAttributeClass> OrganType = (from s in lstOrganTransplant
                                                 where s.AttributeID == 32
                                                 select new EMRAttributeClass
                                                 {

                                                     AttributeName = s.AttributeName,
                                                     AttributevalueID = s.AttributevalueID,
                                                     AttributeValueName = s.AttributeValueName
                                                 }).ToList();
            ddlOrganTransplant.DataSource = OrganType.ToList();
            ddlOrganTransplant.DataTextField = "AttributeValueName";
            ddlOrganTransplant.DataValueField = "AttributevalueID";
            ddlOrganTransplant.DataBind();
        }
        rdoNo_966.Checked = true;   
    }

    public DataTable GetListItem(List<PatientComplaintAttribute> drugs)
    {
        DataTable table = new DataTable();
        table.Columns.Add("ID", typeof(int));
        table.Columns.Add("Value", typeof(string));
        table.Columns.Add("AttributeValue", typeof(int));
        for (int i = 0; i < drugs.Count; i++)
        {
            table.Rows.Add((i + 1), drugs[i].AttributeName, drugs[i].AttributeID);
        }
        return table;
    }

    public void EditData(List<PatientComplaintAttribute> lstPCA, long ID)
    {
        List<PatientComplaintAttribute> lstEditData = (from s in lstPCA
                                                       where s.ComplaintID == ID
                                                       select s).ToList();
        CheckBoxList chklist = (CheckBoxList)phDDLCHK.FindControl("chkLstItem");
        DropDownList ddllist = (DropDownList)phDDLCHK.FindControl("ddlChkList");
        int cnt = 0;
        string text = "";
        for (int j = 0; j < lstEditData.Count(); j++)
        {
            if (lstEditData[j].ComplaintID == ID)
            {
                for (int i = 0; i < chklist.Items.Count; i++)
                {
                    if (chklist.Items[i].Value == lstEditData[j].AttributeID.ToString())
                    {
                        chklist.Items[i].Selected = true;
                        cnt = cnt + 1;
                        if (text == "")
                        {
                            text = lstEditData[j].AttributeName;
                        }
                        else
                            text = text + "," + lstEditData[j].AttributeName;
                    }
                }

                ddllist.SelectedItem.Text = cnt + " items";
                lblCheckItems.Text = text;
                divrdoYes_966.Style.Add("display", "Green");
                rdoYes_966.Checked = true;
                //if (lstEditData[j].AttributeID == 32)
                //{
                //    ddlOrganTransplant.SelectedValue = lstEditData[j].AttributevalueID.ToString();
                //}
                //if (lstEditData[j].AttributeID == 37 && lstEditData[j].AttributeValueName!="")
                //{
                    
                //}
                //if (lstEditData[j].AttributeID == 38 && lstEditData[j].AttributeValueName != "")
                //{
                //}
                //if (lstEditData[j].AttributeID == 39 && lstEditData[j].AttributeValueName != "")
                //{
                //}
            }
        }
    }

    public long getdata(out List<PatientComplaint> attribute, out List<PatientComplaintAttribute> attrValue)
    {
        int returnval = -1;
        attribute = new List<PatientComplaint>();
        attrValue = new List<PatientComplaintAttribute>();
        List<PatientComplaint> lstPatientcomplaint = new List<PatientComplaint>();
        List<PatientComplaintAttribute> lstPatientComplaintAttribute = new List<PatientComplaintAttribute>();
        CheckBoxList chklist = (CheckBoxList)phDDLCHK.FindControl("chkLstItem");
        if (rdoYes_966.Checked == true)
        {
            PatientComplaint objPatientcomplaint = new PatientComplaint();
            objPatientcomplaint.ComplaintID = Convert.ToInt32(966);
            objPatientcomplaint.ComplaintName = rdoYes_966.Text;
            lstPatientcomplaint.Add(objPatientcomplaint);

            attribute.Add(objPatientcomplaint);
            for (int i = 0; i < chklist.Items.Count; i++)
            {
                if (chklist.Items[i].Selected == true)
                {
                    PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                    objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(78);
                    objPatientComplaintAttribute.AttributeID = Convert.ToInt64(28);
                    objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(chklist.Items[i].Value);
                    objPatientComplaintAttribute.AttributeValueName = chklist.Items[i].Text.ToString();
                    lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                    attrValue.Add(objPatientComplaintAttribute);
                }
            }
            if (ddlOrganTransplant.SelectedValue != "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute1 = new PatientComplaintAttribute();
                objPatientComplaintAttribute1.ComplaintID = Convert.ToInt32(966);
                objPatientComplaintAttribute1.AttributeID = Convert.ToInt64(32);
                objPatientComplaintAttribute1.AttributevalueID = Convert.ToInt32(ddlOrganTransplant.SelectedValue);
                objPatientComplaintAttribute1.AttributeValueName = ddlOrganTransplant.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute1);
                attrValue.Add(objPatientComplaintAttribute1);
            }
        }
        return returnval;
    }

}



    
