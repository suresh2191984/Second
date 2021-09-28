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


public partial class Admin_ServiceResourceUtilizationMaster : BasePage
{

  
    long returnCode = -1;
    List<FeeTypeMaster> lstService = new List<FeeTypeMaster>();
    List<FeeTypeMaster> lstResource = new List<FeeTypeMaster>();
    List<MetaData> lstEstimatedTime = new List<MetaData>();
    List<IPTreatmentPlanMaster> lstSurgery = new List<IPTreatmentPlanMaster>();
    List<IPTreatmentPlanMaster> lstInterventional = new List<IPTreatmentPlanMaster>();
    List<SurgeryPackageMaster> lstSurgeryPKG = new List<SurgeryPackageMaster>();
    List<IPTreatmentPlanMaster> lstSOI = new List<IPTreatmentPlanMaster>();
    List<FloorMaster> lstFloor = new List<FloorMaster>();
    List<BedMaster> lstBed = new List<BedMaster>();
    List <RoomBookingDetails> lstRooms = new List<RoomBookingDetails>();
    List<BillofMaterialDetails> lstBillOfMaterialDetails = new List<BillofMaterialDetails>();
    List<BillofMaterialDetails> dtBillDetails = new List<BillofMaterialDetails>();
    List<BillOfMaterials> dtBillOfMaterials = new List<BillOfMaterials>();
    List<BillingFeeDetails> lstDetails = new List<BillingFeeDetails>();
    Master_BL objMasterBL;

    protected void Page_Load(object sender, EventArgs e)
    {
        objMasterBL = new Master_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            pLoadServiceandResource();
            LoadUnit();
            LoadGrid();
            string iValue = string.Empty;
            LoadMetaData();
            AutoServiceName.ContextKey = OrgID.ToString() + '~' + iValue;

          //  btnSave_Click(sender,e);
        }
     
     
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {

        string RecurrentUsage = string.Empty;
        //if (chkRecurrentUsage.Checked == true)
        //{
        //    RecurrentUsage = "Y";
        //}
        //else
        //{
        //    RecurrentUsage = "N";
        //}
        try
        {
            var splits = hdnServiceMapping.Value.Split('^');

            BillofMaterialDetails Servicemapping;
            BillOfMaterials objBillOfMaterials;
            //Procedures~SWD~Pharmacy~KALFLUK 150 MG TAB~3~Pcs~3~Day(s)~~PRO~PRM
            for (int i = 0; i < splits.Length; i++)
            {
                if (splits[i] != "")
                {

                    //"Procedures~WAX BATH~General Bill Items~30% to 50% Burns 1st Dressing ~2~Bottle~9~Day(s)~662~PRO~GEN"
                    Servicemapping = new BillofMaterialDetails();
                    objBillOfMaterials = new BillOfMaterials();
                    // Surgery~Anterior Resection of Rectum~Drugs~Dolo 650~2~Kg~2~Kg~8"
                    var Services = splits[i].Split('~');
                    objBillOfMaterials.SeviceID = Convert.ToInt64(Services[8].ToString());
                    objBillOfMaterials.ServiceType  = Services[0].ToString();//Service type
                    objBillOfMaterials.ServiceName = Services[1].ToString();
                    objBillOfMaterials.OrgID = Convert.ToInt64(OrgID);
                    objBillOfMaterials.ResourceType = Services[2].ToString();
                    objBillOfMaterials.ResourceName = Services[3];
                    objBillOfMaterials.FeeType = Services[9].ToString();//Service fee type 
                    //Servicemapping = Convert.ToInt64(Services[9].ToString());//DeviceID
                    Servicemapping.ServiceName = Services[1].ToString();//investigation name

                    var temp = Convert.ToDecimal(Services[4]);
                    if (temp != 0)
                    {
                        Servicemapping.EstimatedQty = Convert.ToDecimal(Services[4]);
                        Servicemapping.EstimatedUnit = Services[5];
                    }
                    else
                    {
                        Servicemapping.EstimatedQty = 0;
                        Servicemapping.EstimatedUnit = "Null";
                    }
                  
                 //   Servicemapping.EstimatedUnit = Services[5];
                    Servicemapping.EstimatedDuration = Services[6]+" "+Services[7];
                    Servicemapping.OrgID = OrgID;
                    Servicemapping.BufferUnit  = Services[10].ToString();//Resource fee type 
                    Servicemapping .RecurrentUsage =Services[11].ToString();
                    Servicemapping.ProductID = Convert.ToInt64(Services[12].ToString());
                  
                    dtBillDetails.Add(Servicemapping);
                    dtBillOfMaterials.Add(objBillOfMaterials);
                }
            }
           // string EstimatedDuration = txtestimatedDuration.Text + '~' + ddlduration.SelectedItem.Text;
            //returnCode = new Master_BL(base.ContextInfo).InsertBillOfMaterials(dtBillOfMaterials, dtBillDetails,out lstBillOfMaterialDetails);
            returnCode = objMasterBL.InsertBillOfMaterials(dtBillOfMaterials, dtBillDetails, out lstBillOfMaterialDetails);
            ClientScript.RegisterStartupScript(this.GetType(), "key", "alert('Services has been  saved successfully.');");
       
            ItemsClear();
            hdnServiceMapping.Value = "";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Ther is some problem in Saving BillOf Materials Details", ex);
        }
    }


    protected void pLoadServiceandResource()
    {

      
        returnCode = new Master_BL(base.ContextInfo).GetServieandServicetMaster(OrgID, out lstService, out lstResource,out lstEstimatedTime);
        if (lstService.Count() > 0)
        {
            ddlServiceType.DataSource = lstService.ToList();
            ddlServiceType.DataValueField = "FeeType";
            ddlServiceType.DataTextField = "FeeTypeDesc";
            ddlServiceType.DataBind();
            ddlServiceType.Items.Insert(0, "--Select--");
         

        }
        if (lstResource.Count() > 0)
        {
            ddlResourceType.DataSource = lstResource;
            ddlResourceType.DataValueField = "FeeType";
            ddlResourceType.DataTextField = "FeeTypeDesc";
            ddlResourceType.DataBind();
            ddlResourceType.Items.Insert(0, "--Select--");
        }
      



    }

    public void LoadUnit()
    {
        try
        {
            long returnCode = -1;
            SharedInventory_BL InventoryBL = new SharedInventory_BL(base.ContextInfo);
            List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
           // returnCode = InventoryBL.GetUnitType(OrgID, InventoryLocationID, out lstInventoryUOM);
            ddlUOM.DataSource = lstInventoryUOM;
            ddlUOM.DataTextField = "UOMCode";
            ddlUOM.DataValueField = "UOMCode";
            ddlUOM.DataBind();
            ddlUOM.Items.Insert(0, new ListItem("--Select--", "0"));
            ddlUOM.Items[0].Selected = true;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while GetUnitType", ex);
        }
    }

    private string ServiceType()
    {
        string  iValue = string.Empty;
        if (ddlServiceType.SelectedItem.Text == "Consultation")
        {
            iValue = "CON";
        }
        else if (ddlResourceType.SelectedItem.Text == "General Bill Items")
        {
            iValue = "GEN";
        }
        else if (ddlServiceType.SelectedItem.Text == "Investigation")
        {
            iValue = "INV";
        }
        else if (ddlServiceType.SelectedItem.Text == "Procedures")
        {
            iValue = "PRO";
        }

        else if (ddlResourceType.SelectedItem.Text == "Pharmacy")
        {
            iValue = "PRM";
        }

        //Casuality

        else if (ddlServiceType.SelectedItem.Text == "Casuality")
        {
            iValue = "CAS";
        }
        return iValue;
    }



    protected void ddlServiceType_OnSelectedIndexChanged(object sender, EventArgs e)
    {

        string  iValue = string.Empty;
     
        iValue = ServiceType();
        AutoServiceName.ContextKey = OrgID.ToString() + '~' + iValue;

        returnCode = new Master_BL(base.ContextInfo).GetServiceNames(OrgID, iValue,Convert.ToString(txtServiceName.Text),out lstDetails);
      
        
    }

    protected void ddlResourceType_OnSelectedIndexChanged(object sender, EventArgs e)
    {

        string iValue = string.Empty;
        iValue = ServiceType();
      
        AutoResourceName.ContextKey = OrgID.ToString() + '~' + iValue;
        returnCode = new Master_BL(base.ContextInfo).GetServiceNames(OrgID, iValue, "", out lstDetails);
        LoadMetaData();

    }

    private int ResourceTypeID()
    {
        int iValue = 0;
        if (ddlResourceType.SelectedItem.Text == "Drugs")
        {
            iValue = 1;
        }
        else if (ddlResourceType.SelectedItem.Text == "Asset")
        {
            iValue = 2;
        }
      
        else if (ddlResourceType.SelectedItem.Text == "Medical Indents")
        {
            iValue = 3;
        }
        else if (ddlResourceType.SelectedItem.Text == "Rooms")
        {
            iValue = 4;

        }

        return iValue;
    }




    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string SearchItem = string.Empty;

        //string SearchItem =  txtsearch.Text.ToUpper();
        new Master_BL(base.ContextInfo).GetServiceMaster(OrgID, SearchItem, out lstBillOfMaterialDetails);
        if(lstBillOfMaterialDetails.Count()>0)
        {
         grdResult.DataSource = lstBillOfMaterialDetails.GroupBy(item => new { item.ServiceName },
                                     (key, group) => new  BillofMaterialDetails
                                     {
                                        
                                         ServiceName  = key.ServiceName
                                            
                                      
                                       
                                     }).ToList<BillofMaterialDetails>();
            grdResult.DataBind();
          //  txtsearch.Text = "";
           
        }
    }

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                BillofMaterialDetails BMaster = (BillofMaterialDetails)e.Row.DataItem;
                IEnumerable<BillofMaterialDetails> childItems = (from child in lstBillOfMaterialDetails 
                                                                 where
                                                                  
                                                                      child.ServiceName == BMaster.ServiceName
                                                                      
                                                                  group child by new
                                                                 {
                                                                    //child.ResourceServiceTypeName,
                                                               
                                                                     child.ServiceName,
                                                                     child.ResourceType ,
                                                                   
                                                                     child.EstimatedQty ,
                                                                     child.EstimatedUnit ,
                                                                     child.EstimatedDuration ,
                                                                     child.ProductID ,
                                                                  
                                                                     child.ResourceName ,
                                                                     child.RecurrentUsage 

                                                                 } into g
                                                                  select new BillofMaterialDetails
                                                                 {
                                                                  
                                                              
                                                                     ResourceType = g.Key.ResourceType,
                                                                     ResourceName = g.Key.ResourceName,
                                                                     EstimatedQty = g.Key.EstimatedQty,
                                                                     EstimatedUnit = g.Key.EstimatedUnit,
                                                                     EstimatedDuration = g.Key.EstimatedDuration,
                                                                     RecurrentUsage = g.Key.RecurrentUsage,
                                                                   
                                                                 }).Distinct().ToList();          
            
                GridView childGrid = (GridView)e.Row.FindControl("grdChildResult");
                childGrid.DataSource = childItems;

                childGrid.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("there was a problem in lodind data", ex);
        }
    }

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
    }

    protected void grdChildResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                BillofMaterialDetails BOM = (BillofMaterialDetails)e.Row.DataItem;
                BillofMaterialDetails BMaster = (BillofMaterialDetails)e.Row.DataItem;
                IEnumerable<BillofMaterialDetails> childItems = (from child in lstBillOfMaterialDetails
                                                                 where

                                                                      child.ServiceName == BMaster.ServiceName

                                                                 group child by new
                                                                 {
                                                                     //child.ResourceServiceTypeName,
                                                                     child.ServiceName,
                                                                     child.ResourceType,

                                                                     child.EstimatedQty,
                                                                     child.EstimatedUnit,
                                                                     child.EstimatedDuration,
                                                                     child.ProductID,

                                                                     child.ResourceName,
                                                                     child.RecurrentUsage

                                                                 } into g
                                                                 select new BillofMaterialDetails
                                                                 {

                                                                     ResourceType = g.Key.ResourceType,
                                                                     ResourceName = g.Key.ResourceName,
                                                                     EstimatedQty = g.Key.EstimatedQty,                                                                    
                                                                     EstimatedUnit = g.Key.EstimatedUnit,                                                                                                                           
                                                                     EstimatedDuration = g.Key.EstimatedDuration,
                                                                     RecurrentUsage = g.Key.RecurrentUsage,

                                                                 }) .Distinct().ToList();
              
              
                GridView childGrid = (GridView)e.Row.FindControl("grdChildResult");
                if (BOM.EstimatedUnit =="Null")
                {
                    e.Row.Cells[3].Text = "-";

                }
                childGrid.DataSource = childItems;

                childGrid.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("there was a problem in lodind data", ex);
        }
    }



  
     private  void ItemsClear()
     {
         ddlResourceType.SelectedIndex =0;
         ddlServiceType.SelectedIndex = 0;
         txtestimatedDuration.Text = "";
         txtQty.Text = "";
         txtServiceName.Text = "";
         txtResourceName.Text = "";
         chkRecurrentUsage.Checked = false;
     }




     protected void LoadGrid()
     {
       
         
         new Master_BL(base.ContextInfo).GetServiceMaster(OrgID,"", out lstBillOfMaterialDetails);
       //  hdnServiceMapping.Value =Convert.ToString(lstBillOfMaterialDetails);
        // CreateXMLinfo(lstBillOfMaterialDetails[0].ServiceName, lstBillOfMaterialDetails[0].InvestigationID);

       

         if (lstBillOfMaterialDetails.Count() > 0)
         {
         grdResult.DataSource = lstBillOfMaterialDetails.GroupBy(item => new { item.ServiceName ,item.BufferUnit,item.ResourceServiceTypeName },
                                     (key, group) => new  BillofMaterialDetails
                                     {
                                         ResourceServiceTypeName=key.ResourceServiceTypeName ,
                                         ServiceName  = key.ServiceName,
                                         BufferUnit =key.BufferUnit 
                                                                       
                                     }).ToList<BillofMaterialDetails>();
     
            // grdResult.DataSource = lstBillOfMaterialDetails;
             grdResult.DataBind();
         }



     }

     public void LoadMetaData()
     {
         try
         {
             long returncode = -1;
             string domains = "HistoryDuration";
             string[] Tempdata = domains.Split(',');
             string LangCode = "en-GB";
             // string LangCode = string.Empty;
             List<MetaData> lstmetadataInput = new List<MetaData>();
             List<MetaData> lstmetadataOutput = new List<MetaData>();

             MetaData objMeta;

             for (int i = 0; i < Tempdata.Length; i++)
             {
                 objMeta = new MetaData();
                 objMeta.Domain = Tempdata[i];
                 lstmetadataInput.Add(objMeta);

             }

             //returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
			 returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

             if (lstmetadataOutput.Count > 0)
             {
                 var childItems = from child in lstmetadataOutput
                                  where child.Domain == "HistoryDuration" //orderby child .MetaDataID
                                  select child;
                 ddlduration.DataSource = childItems;
                 ddlduration.DataTextField = "DisplayText";
                 ddlduration.DataValueField = "Code";
                 ddlduration.DataBind();
                 ddlduration.Items.Insert(0, "-----Select-----");
                 ddlduration.Items[0].Value = "0";


             }



         }
         catch (Exception ex)
         {
             CLogger.LogError("Error while  loading Search Type  Meta Data ", ex);

         }
     }



  


}
