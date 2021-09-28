using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using System.Data;
using System.Collections;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;

public partial class CommonControls_ControlListDetails : BaseControl
{
    List<ControlMappingDetails> lstTempControlSavedValues;
    List<ControlMappingDetails> lstControlMappingDetails;
    List<ControlMappingDetails> lstControlMappingValues;
    ControlMappingDetails objControlMappingDetails;
    object objControls;
    Control pControls;
    protected void Page_Load(object sender, EventArgs e)
    {
        string a = UserName;

    }

    public long LoadCustomerControls(long ReferenceID, string ReferenceType, string pType, long SecondaryReferenceID, List<ControlMappingDetails> lstControlValues)
    {
        long RetValue = -1;
        try
        {
            
            new ClinicalTrail_BL(base.ContextInfo).GetControlListDetails(OrgID, ReferenceID, ReferenceType, pType,SecondaryReferenceID, out lstControlMappingDetails, out lstControlMappingValues);
            gdvCustomerControls.DataSource = lstControlMappingDetails;
            gdvCustomerControls.DataBind();
            if (lstControlMappingDetails.Count > 0)
            {
                RetValue = 0;
                //ModalPopupExtender1.Show();
            }
            else
            {
                RetValue = -1;
                //SaveAttributes();
            }
             
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - LoadCustomerControls", ex);
            
        }
        return RetValue;
    } 
    protected void gdvCustomerControls_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                objControlMappingDetails = (ControlMappingDetails)e.Row.DataItem;
                if (objControlMappingDetails.ControlCode == "DDL")
                {
                    objControls = (DropDownList)e.Row.FindControl("ddlControlValue");
                }
                if (objControlMappingDetails.ControlCode == "TEXT")
                {
                    objControls = (TextBox)e.Row.FindControl("txtControlValue");

                }
                if (objControlMappingDetails.ControlCode == "DATE")
                {
                    objControls = (TextBox)e.Row.FindControl("txtControldade");
                }
                if (objControlMappingDetails.ControlCode == "RDO")
                {
                    objControls = (RadioButtonList)e.Row.FindControl("rdoControlValue");
                }
                if (objControlMappingDetails.ControlCode == "CHBL")
                {
                    objControls = (CheckBoxList)e.Row.FindControl("chBLControlValue");
                }
                if (objControlMappingDetails.ControlCode == "CHB")
                {
                    objControls = (CheckBox)e.Row.FindControl("chkConfigValue");
                }
                if (objControlMappingDetails.ControlCode == "PAGE")
                {
                    objControls = (TextBox)e.Row.FindControl("txtControlValue");

                }

                //View Saved Items
                if (objControlMappingDetails.ReferenceType == "VIEW")
                {
                    BindControlValuesWithData(objControls, objControlMappingDetails);
                } 
                else
                {
                    BindControlValues(objControls, objControlMappingDetails);
                }
              
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - gdvCustomerControls", ex);

        }
    }

    private void BindControlValues(object objControls, ControlMappingDetails objControlMappingDetails)
    {

        switch (objControlMappingDetails.ControlCode)
        {

            case "DDL":

                DropDownList ddl = (DropDownList)objControls;
                ddl.DataSource = lstControlMappingValues.FindAll(p => p.ControlMappingID == objControlMappingDetails.ControlMappingID).ToList();
                ddl.DataValueField = "ControlValue";
                ddl.DataTextField = "ControlValue";
                ddl.DataBind();
                ddl.Visible = true;
                break;

            case "CHBL":

                CheckBoxList chb = (CheckBoxList)objControls;
                chb.DataSource = lstControlMappingValues.FindAll(p => p.ControlMappingID == objControlMappingDetails.ControlMappingID).ToList();
                chb.DataValueField = "ControlValue";
                chb.DataTextField = "ControlValue";
                chb.DataBind();
                chb.Visible = true;
                break;

            case "TEXT":
                TextBox txt = (TextBox)objControls;
                txt.Visible = true;
                break;

            case "DATE":
                TextBox txtdate = (TextBox)objControls;
                //objAnchor.HRef = "javascript:NewCssCal('" + txtdate.ClientID + "','ddmmyyyy','arrow',true,12)";
                //objAnchor.Visible = true;
                //txtdate.Attributes.Add("onfocus", "openViewBill('" + pagename + "','" + sFeetype + "')");
                txtdate.Visible = true;
                break;

            case "RDO":

                RadioButtonList rdo = (RadioButtonList)objControls;
                rdo.DataSource = lstControlMappingValues.FindAll(p => p.ControlMappingID == objControlMappingDetails.ControlMappingID).ToList();
                rdo.DataValueField = "ControlValue";
                rdo.DataTextField = "ControlValue";
                rdo.DataBind();
                rdo.Visible = true;
                break;
            case "CHB":
                CheckBox ckk = (CheckBox)objControls;
                ckk.Visible = true;
                break;
            case "PAGE":
                TextBox Pagetxt = (TextBox)objControls;
                Pagetxt.Text = UserName;
                Pagetxt.ReadOnly = true;
                Pagetxt.Visible = true;
                break;
                

            default:
                break;
        }
    }


    public void getControlsValues(out List<ControlMappingDetails> lstControlSavedValues)
    {
        lstControlSavedValues = new List<ControlMappingDetails>();

        foreach (GridViewRow item in gdvCustomerControls.Rows)
        {

            objControlMappingDetails = new ControlMappingDetails();
            DropDownList ddl = (DropDownList)item.FindControl("ddlControlValue");
            TextBox txt = (TextBox)item.FindControl("txtControlValue");
            TextBox txtdate = (TextBox)item.FindControl("txtControldade");

            RadioButtonList rdo = (RadioButtonList)item.FindControl("rdoControlValue");
            CheckBoxList chbl = (CheckBoxList)item.FindControl("chBLControlValue");
            CheckBox chb = (CheckBox)item.FindControl("chkConfigValue");
            HiddenField hdnControlMappingID = (HiddenField)item.FindControl("hdnControlMappingID");
            HiddenField hdnControlTypeID = (HiddenField)item.FindControl("hdnControlTypeID");
            HiddenField hdnControlCode = (HiddenField)item.FindControl("hdnControlCode");
            Label LblDisplayText = (Label)item.FindControl("LblDisplayTextGrid");
            HiddenField hdnID = (HiddenField)item.FindControl("hdnID");
            
            objControlMappingDetails.ControlMappingID = Convert.ToInt64(hdnControlMappingID.Value);
            objControlMappingDetails.ControlName = LblDisplayText.Text;
            if (hdnControlCode.Value == "DDL")
            {
                objControlMappingDetails.ControlValue = ddl.SelectedValue;
            }
            if (hdnControlCode.Value == "TEXT" || hdnControlCode.Value == "PAGE")
            {
                objControlMappingDetails.ControlValue = txt.Text;
            }
            if (hdnControlCode.Value == "RDO")
            {
                objControlMappingDetails.ControlValue = rdo.SelectedValue;
            }

            if (hdnControlCode.Value == "CHB")
            {
                objControlMappingDetails.ControlValue = chb.Checked.ToString();
            }
             
            if (hdnControlCode.Value == "CHBL")
            {
                foreach (ListItem val in chbl.Items)
                {
                    if (val.Selected)
                    {
                        objControlMappingDetails = new ControlMappingDetails();
                        objControlMappingDetails.ControlMappingID = Convert.ToInt64(hdnControlMappingID.Value);
                        objControlMappingDetails.ControlName = LblDisplayText.Text;
                        objControlMappingDetails.ControlValue = val.Value;
                        lstControlSavedValues.Add(objControlMappingDetails);
                    }
                }

            }
            if (hdnControlCode.Value == "DATE")
            {
                objControlMappingDetails.ControlValue = txtdate.Text;
            }
           // else
            //{
                lstControlSavedValues.Add(objControlMappingDetails);
           // }
        }
    }

    private void BindControlValuesWithData(object objControls, ControlMappingDetails objControlMappingDetails)
    {

        switch (objControlMappingDetails.ControlCode)
        {

            case "DDL":

                DropDownList ddl = (DropDownList)objControls;
                ddl.DataSource = lstControlMappingValues.FindAll(p => p.ControlMappingID == objControlMappingDetails.ControlMappingID).ToList();
                ddl.DataValueField = "ControlValue";
                ddl.DataTextField = "ControlValue";
                ddl.DataBind();
                ddl.Visible = true;
                ddl.SelectedValue = objControlMappingDetails.Description;
                break;

            case "CHBL":

                CheckBoxList chb = (CheckBoxList)objControls;
                chb.DataSource = lstControlMappingValues.FindAll(p => p.ControlMappingID == objControlMappingDetails.ControlMappingID).ToList();
                chb.DataValueField = "ControlValue";
                chb.DataTextField = "ControlValue";
                chb.DataBind();
                chb.Visible = true;
                for (int i = 0; i < chb.Items.Count; i++)
                {
                    if (chb.Items[i].Value == objControlMappingDetails.Description)
                    {
                        chb.Items[i].Selected = true;
                    }
                }
                break;

            case "TEXT":
                TextBox txt = (TextBox)objControls;
                txt.Visible = true;
                txt.Text = objControlMappingDetails.Description;
                break;

            case "DATE":
                TextBox txtdate = (TextBox)objControls;
                //objAnchor.HRef = "javascript:NewCssCal('" + txtdate.ClientID + "','ddmmyyyy','arrow',true,12)";
                //objAnchor.Visible = true;
                txtdate.Visible = true;
                txtdate.Text = objControlMappingDetails.Description;
                break;

            case "RDO":

                RadioButtonList rdo = (RadioButtonList)objControls;
                rdo.DataSource = lstControlMappingValues.FindAll(p => p.ControlMappingID == objControlMappingDetails.ControlMappingID).ToList();
                rdo.DataValueField = "ControlValue";
                rdo.DataTextField = "ControlValue";
                rdo.DataBind();
                rdo.Visible = true;
                for (int i = 0; i < rdo.Items.Count; i++)
                {
                    if (rdo.Items[i].Value == objControlMappingDetails.Description)
                    {
                        rdo.Items[i].Selected = true;
                    }
                }
                break;
            case "CHB":
                CheckBox ckk = (CheckBox)objControls;
                ckk.Visible = true;

                break;
            case "PAGE":
                TextBox Pagetxt = (TextBox)objControls;
                Pagetxt.Visible = true;
                Pagetxt.ReadOnly = true;
                Pagetxt.Text = objControlMappingDetails.Description;
                break;

            default:
                break;
        }
    }
}
