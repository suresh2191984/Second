using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;   
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using System.Collections;
using PdfSharp.Pdf.Security;
using System.Web.UI.HtmlControls;
using System.Web.Services;
using System.Web.Script;
using System.Data;
using System.Data.SqlClient;
using System.Xml;


public partial class Reception_ResourceConsumption : BasePage
{
    public Reception_ResourceConsumption()
        : base("Reception\\ResourceConsumption.aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    long patientVisitID = -1;
    long patientID = -1;
    long returnCode = -1;
    int OrgID = 0;
    long ServiceID = 0;
    List<Patient> lstPatient = new List<Patient>();
    Master_BL obj ;
    Patient_BL patientBL ;
    List<SurgeryOrderedServices> lstServices = new List<SurgeryOrderedServices>();
    List<BillOfMaterials> lstBillofMaterials = new List<BillOfMaterials>();
    List<ResourceConsumption> lstResourceConsumption = new List<ResourceConsumption>();
    List<ResourceConsumption> dtResourceConsumption = new List<ResourceConsumption>();
    List<BillOfMaterials> lstBillofMaterials1 = new List<BillOfMaterials>();
    DataTable dtConsumption;
    protected void Page_Load(object sender, EventArgs e)
    {
         obj = new Master_BL(base.ContextInfo);
         patientBL = new Patient_BL(base.ContextInfo);

        OrgID = OrgID;
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);

        if (!IsPostBack)
        {

            returnCode = patientBL.GetPatientDemoandAddress(patientID, out lstPatient);
            if (lstPatient.Count > 0)
            {
                lblNameValue.Text = lstPatient[0].Name;
                lblAgeOrSexValue.Text = lstPatient[0].Age + "/" + lstPatient[0].SEX;
                lblPnovalue.Text = lstPatient[0].PatientNumber;
                lbladdressvalue.Text = lstPatient[0].PatientAddress[0].Add1;
                lblcontactNovalue.Text = lstPatient[0].PatientAddress[0].MobileNumber;


            }
           LoadGrid();

        }

    }


    private void LoadGrid()
    {


        obj.GetServiceForConsumption(patientID, patientVisitID, ServiceID, out lstServices, out lstBillofMaterials);
        if (lstServices.Count > 0)
        {
            btnSaveID.Style.Add("display", "block");
            ddlServices.DataSource = lstServices;
            ddlServices.DataTextField = "Description";
            ddlServices.DataValueField = "FeeID";
            ddlServices.DataBind();
            ddlServices.Items.Insert(0, "--Select--");
            ddlServices.Items[0].Value = "0";
          
        }

    }



    [WebMethod]
    public static String LoadResources(long ID)
    {
        long returnCode = -1;
        long patientID = 0;
        long PatientvisitID = 0;
        string[] strResourceNames = null;

        List<SurgeryOrderedServices> lstServices = new List<SurgeryOrderedServices>();
        List<BillOfMaterials> lstBillofMaterials = new List<BillOfMaterials>();
        try
        {

            //Master_BL oMaster_BL = new Master_BL(base.ContextInfo);

            //List<string> lstResourceNames = new List<string>();

            //returnCode = oMaster_BL.GetServiceForConsumption(patientID, PatientvisitID, ID, out lstServices, out lstBillofMaterials);
            //if (lstBillofMaterials.Count() > 0)
            //{
            //    strResourceNames = new string[lstBillofMaterials.Count];
            //    for (int i = 0; i < lstBillofMaterials.Count; i++)
            //    {
            //        strResourceNames[i] = lstBillofMaterials[i].SeviceID + "/" + lstBillofMaterials[i].ResourceName;
            //    }
            //}
        }

        catch (Exception ex)
        {
            CLogger.LogError("There is a problem in loading Resource names   ", ex);
        }


        return strResourceNames.ToString();



    }


    protected void ddlServices_OnSelectedIndexChanged(object sender, EventArgs e)
    {


        ServiceID = Convert.ToInt64(ddlServices.SelectedItem.Value);
      //  LoadGrid();
        obj.GetServiceForConsumption(patientID, patientVisitID, ServiceID, out lstServices, out lstBillofMaterials);
     
        if (lstBillofMaterials.Count() > 0)
        {

            var list = (from list1 in lstBillofMaterials
                        select list1.ServiceName 
                         ).ToList().Distinct();

            foreach (var obj1 in list)
            {
                BillOfMaterials pdc = new BillOfMaterials();
                pdc.ServiceName   = obj1;
                lstBillofMaterials1.Add(pdc);
            }


            btnSaveID.Style.Add("display", "block");
            gvResources.DataSource = lstBillofMaterials1;
            gvResources.DataBind();
        }

        else
        {
            gvResources.DataSource = null;
            gvResources.DataBind();

            btnSaveID.Style.Add("display", "none");
        }

       


    }

    protected void gvResources_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)


             
        {



            BillOfMaterials BMaster = (BillOfMaterials)e.Row.DataItem;
            //string strScript = "SelectResource('" + ((CheckBox)e.Row.Cells[1].FindControl("chkBox")).ClientID + "','" + BMaster.OrgID+ "');";
            //((CheckBox)e.Row.Cells[0].FindControl("chkBox")).Attributes.Add("onclick", strScript);
           
            
            IEnumerable<BillOfMaterials> childItems = (from child in lstBillofMaterials
                                                       where

                                                            child.ResourceName == BMaster.ResourceName


                                                       group child by new
                                                       {
                                                           //child.ResourceServiceTypeName,
                                                           child.FeeType,


                                                       } into g
                                                       select new BillOfMaterials
                                                       {
                                                           FeeType = g.Key.FeeType,

                                                       }).Distinct().ToList();

         

            //var ddl = (DropDownList)e.Row.FindControl("ddlUOM");
            //long returnCode = -1;
            //Inventory_BL InventoryBL = new Inventory_BL(base.ContextInfo);
            //List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
            //returnCode = InventoryBL.GetUnitType(OrgID, InventoryLocationID, out lstInventoryUOM);
            //ddl.DataSource = lstInventoryUOM;
            //ddl.DataTextField = "UOMCode";
            //ddl.DataValueField = "UOMCode";
            //ddl.DataBind();
            //ddl.Items.Insert(0, new ListItem("--Select--", "0"));
            //ddl.Items[0].Selected = true;
            //ddl.DataSource = childItems;
            //ddl.DataTextField = "ServiceType";
            //ddl.DataValueField = "ServiceType";
            //ddl.DataBind();
        }

    }

    protected void gvResources_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Select")
            {
                int RowIndex = Convert.ToInt32(e.CommandArgument);
                long ResourceID = 0;
          ResourceID =Convert.ToInt64(hdnResourceID.Value);
              hdnResourceID.Value = ResourceID.ToString();
               //hdnPatientNumber.Value = Convert.ToString(GvSMSReport.DataKeys[RowIndex][1]);

                //  Communication.SendSMS("Dear " + lstPatient.Name + ",\nYour test request has been registered successfully with\n" + OrgName + " at " + String.Format("{0:dd-MM-yyyy hh:mm:ss tt}", Convert.ToDateTime(new BasePage().OrgDateTimeZone)) + ". Thank you.", lstPatient.PatientAddress[0].MobileNumber.Trim());     
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("There is some problem in Rowcommand event in SMSReport page", ex);
        }
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {

        try
        {

      
            CheckBox chkSelect = new CheckBox();
            TextBox txtConsumptionValue = new TextBox();
            TextBox ConsumptionUnit = new TextBox();
            TextBox txtConsumptionDate = new TextBox();
            TextBox txtComments = new TextBox();
            Label lblResourceName=new Label();
            HiddenField hdnResourceID = new HiddenField();
         
           
                foreach (GridViewRow row1 in gvResources.Rows)
                { 
                  
                    chkSelect = (CheckBox)row1.FindControl("chkBox");
                    txtConsumptionValue = (TextBox)row1.FindControl("txtValue");
                    ConsumptionUnit = (TextBox)row1.FindControl("TxtUnit");
                    txtConsumptionDate = (TextBox)row1.FindControl("txtDate");
                    txtComments = (TextBox)row1.FindControl("txtComments");
                    lblResourceName =(Label)row1.FindControl("lblDescriptionName");
                    hdnResourceID = (HiddenField)row1.FindControl("hdnvalue");

                    if (chkSelect.Checked == true)
                    {
                        ResourceConsumption ResourceConsumptions = new ResourceConsumption();
                        ResourceConsumptions.ResourceName =Convert.ToString(lblResourceName.Text);
                        ResourceConsumptions.Comments = txtComments.Text;
                        ResourceConsumptions.ConsumptionValue = txtConsumptionValue.Text + " " + ConsumptionUnit.Text;
                        ResourceConsumptions.ConsumptionDate = Convert.ToDateTime(txtConsumptionDate.Text);
                        ResourceConsumptions.PatientID = patientID;
                        ResourceConsumptions.PatientVisitID = patientVisitID;
                        ResourceConsumptions.ServiceID = Convert.ToInt64(ddlServices.SelectedItem.Value);
                        ResourceConsumptions.ServiceName = ddlServices.SelectedItem.Text;
                        ResourceConsumptions.ResourceID = Convert.ToInt64(hdnResourceID.Value);
                        dtResourceConsumption.Add(ResourceConsumptions); 
                       
                      
                       // dtConsumption.Rows.Add(dtResourceConsumptions);
                    }
                 
                     

                 
                 
                }

                    
                  returnCode = obj.InsertResourceConsumption(dtResourceConsumption, out lstResourceConsumption);
         
            
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "alert('Data has been saved sucessfully!!');", true);
            

              
     
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("The is a problem in Saving Resource Consumption", ex);
        }



    }

  
}

