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
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Xml;
using System.Xml.Linq;
using Attune.Podium.EMR;
public partial class EMR_EditEMR : BaseControl 
{
    List<EMRAttributeClass> lstAttribute = new List<EMRAttributeClass>();
    EMRAttributeClass attribute = new EMRAttributeClass();
    EMR clsEMR = new EMR();
    #region property
    private bool showpopup=false;
    private Control ddl = new Control();    
    private ListControl LC;

    private HiddenField hdn;

    private ArrayList arr = new ArrayList();

    
    //public class AttributeList : EventArgs
    //{
    //    public List<EMRAttributeClass> LstEMRAttribute { get; set; }
    //    public AttributeList()
    //    {
    //        this.LstEMRAttribute = new List<EMRAttributeClass>();
    //    }
    //}
    #endregion   

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }    
    public void Bind(EMR lstEMR,List<EMRAttributeClass> lstAttribute)
    {
        try
        {           
            hdnAttributeID.Value = String.Empty;
            lblexamination.Text = lstEMR.Name;
            hdnAttributeID.Value = lstEMR.Attributeid.ToString();          
            gvAttributes.DataSource = lstAttribute;
            gvAttributes.DataBind();
            gvAttributes.HeaderRow.Cells[0].Text = lstEMR.Attributename+"---"+lstEMR.Attributevaluename;           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in Bind Function",ex);
        }
    }

    protected void btnClose_Click(object sender, EventArgs e)
    {
        //try
        //{
        //    ModalPopupExtender1.Hide();
        //}
        //catch (Exception ex)
        //{
        //    CLogger.LogError("Error Occured in Close btn in Modal Popup", ex);
        //}
        //finally
        //{
        //    ModalPopupExtender1.Dispose();

        //}
    }

    protected void gvAttributes_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            EMRAttributeClass Attribcls = new EMRAttributeClass();
            int returncode;
            //AttributeList attrib = new AttributeList();
            List<EMRAttributeClass> lstattribEMR = new List<EMRAttributeClass>();
            List<EMRAttributeClass> lstResultEMR = new List<EMRAttributeClass>();
            string flag=String.Empty;
            if (e.CommandName.Equals("ADD"))
            {
                TextBox txtname = (TextBox)gvAttributes.FooterRow.FindControl("txtattribute");
                HiddenField hdnattributeid = (HiddenField)gvAttributes.FooterRow.FindControl("hdnattribute");
                returncode = 0;
                    Attribcls.AttributeID = Int64.Parse(hdnAttributeID.Value);
                    Attribcls.AttributeValueName = txtname.Text.ToString();
                    Attribcls.AttributevalueID = Int64.Parse(hdnattributeid.Value == String.Empty ? "0" : hdnattributeid.Value);
                    lstattribEMR.Add(Attribcls);
                    flag = hdnattributeid.Value == String.Empty ? "I" : "U";
                    clsEMR.EMRsave(lblexamination.Text, lstattribEMR, flag, out lstResultEMR,out returncode);
                    gvAttributes.DataSource = lstResultEMR;
                    gvAttributes.DataBind();
                    if (returncode == -1)
                    {
                        show.Attributes.Add("style","display:block");
                    }
                    else
                    {
                        show.Attributes.Add("style", "display:none");
                    }
                    LC = ((ListControl)DDL);
                    LC.DataSource = lstResultEMR;
                    LC.DataTextField = "AttributeValueName";
                    LC.DataValueField = "AttributevalueID";
                    LC.DataBind();
                    ModalPopupExtender1.Show();               
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in gridRowview command", ex);
        }
    }
    public Control  DDL
    {
        get { return ddl; }

        set { ddl = value; }
        
    }
}
