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

public partial class CommonControls_FoodMenuWardmapping : BaseControl 
{
    Nutrition_BL nutritionbl = new Nutrition_BL();
    RoomBooking_BL roombl = new RoomBooking_BL();
    List<RoomDetails> lstBuildingDatas = new List<RoomDetails>();
    List<RoomDetails> lstFloorDatas = new List<RoomDetails>();
    List<RoomDetails> lstWardDatas = new List<RoomDetails>();
    List<RoomDetails> lstRoomTypeDatas = new List<RoomDetails>();
    List<BuildingMaster> lstbuildmaster = new List<BuildingMaster>();
    List<Diet_FoodMenuWardMapping> lstfoodmenu = new List<Diet_FoodMenuWardMapping>();
    string update_message = Resources.ClientSideDisplayTexts.CommonControl_Foodmenuwardmapping_update_message;
    string sucess_message = Resources.ClientSideDisplayTexts.CommonControl_Foodmenuwardmapping_successMessage;
    string update = Resources.ClientSideDisplayTexts.Common_Update;
    string UpdtFalid = Resources.ClientSideDisplayTexts.CommonControl_Foodmenuwardmapping_UptFald;
    string AlrdyExst = Resources.ClientSideDisplayTexts.CommonControl_Foodmenuwardmapping_AlrdyExst;
    Diet_FoodMenuWardMapping objDiet_FoodMenuWardMapping;


    protected void Page_Load(object sender, EventArgs e)
    {

       
        A4.ContextKey = OrgID.ToString();

          
            if (!IsPostBack)
            {
               
                loadwarddetails();
                loadfoodmenuwardmapping();

            }
       
      }
    public void loadfoodmenuwardmapping()
    {
        long returncode = -1;
        returncode = nutritionbl.pGetFoodMenuWardMapping(OrgID, out lstfoodmenu);
        if (lstfoodmenu.Count > 0)
        {
            grdResult.DataSource = lstfoodmenu;
            grdResult.DataBind();
            grdResult.Visible = true;
            

        }


    }
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            Diet_FoodMenuWardMapping FWMM = (Diet_FoodMenuWardMapping)e.Row.DataItem;
            string strScript = "FoodMenuWardextractRow('" + ((RadioButton)e.Row.FindControl("rdSel")).ClientID + "','" + FWMM.FoodMenuWardMapping + "','" + FWMM.BuildingID + "','" + FWMM.FoodMenuID + "','" + FWMM.FoodMenuName + "','" + FWMM.WardID + "','" + FWMM.WardName + "','" + FWMM.RoomTypeID + "','" + FWMM.RoomTypeName + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);

        }
    }


    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
        }
        loadfoodmenuwardmapping();
    }

    public void loadwarddetails()
    {
        long returncode = -1;
        
        returncode = roombl.GetRoomDetails(OrgID, ILocationID, out lstBuildingDatas, out lstFloorDatas, out lstWardDatas, out lstRoomTypeDatas);

        if (lstBuildingDatas.Count > 0)
        {
            ddbuilding.DataSource = lstBuildingDatas;
            ddbuilding.DataTextField = "Name";
            ddbuilding.DataValueField = "ID";
            ddbuilding.DataBind();
            ddbuilding.Items.Insert(0, "---Select---");
            ddbuilding.Items[0].Value = "0";
        }

        if (lstWardDatas.Count > 0)
        {
            foreach (var item in lstWardDatas)
            {

                hdnWardList.Value += item.BuildingID + "~" + item.ID  + "~" + item.Name  + "^";

            }

        }

        if (lstRoomTypeDatas.Count > 0)
        {
            ddroomtype.DataSource = lstRoomTypeDatas;
            ddroomtype.DataTextField ="Name";
            ddroomtype.DataValueField ="ID";
            ddroomtype.DataBind();
            ddroomtype.Items.Insert(0, "---Select---");
            ddroomtype.Items[0].Value = "0";
        }


    }
    private void clearFields()
    {
        txtfoodmenu.Text = "";
        ddbuilding.SelectedIndex = 0;
        ddroomtype.SelectedIndex = 0;
        ddward.SelectedIndex = -1;
        lblmsg.Text = "";
       }

    protected void btnADD_Click(object sender, EventArgs e)
    {
        try
        {


            long retCode = -1;

            string[] arr = commonval.Value.Split('^');

            hdnWardID.Value = arr[0];

            objDiet_FoodMenuWardMapping = new Diet_FoodMenuWardMapping();
            objDiet_FoodMenuWardMapping.FoodMenuWardMapping = Convert.ToInt64(hdnfoodmenuwardmapping.Value);
            objDiet_FoodMenuWardMapping.FoodMenuID = Convert.ToInt64(hdnfoodmenuID.Value);
            objDiet_FoodMenuWardMapping.WardID = Convert.ToInt32(hdnWardID.Value);
            objDiet_FoodMenuWardMapping.RoomTypeID = Convert.ToInt32(ddroomtype.SelectedValue);
            objDiet_FoodMenuWardMapping.OrgID = OrgID;
            objDiet_FoodMenuWardMapping.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            objDiet_FoodMenuWardMapping.CreatedBy = Int64.Parse(LID.ToString());
            objDiet_FoodMenuWardMapping.ModifiedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            objDiet_FoodMenuWardMapping.ModifiedBy = Int64.Parse(LID.ToString());
            retCode = nutritionbl.GetFoodMenuWardMapping(objDiet_FoodMenuWardMapping);

            if (retCode == 0)
            {
                loadfoodmenuwardmapping();
                clearFields();
                lblmsg.ForeColor = System.Drawing.Color.Black;

                if (hdnbtnADD.Value == update)
                {
                    lblmsg.Text = update_message;
                }
                else
                {
                    lblmsg.Text = sucess_message ;
                }
       

            }
            else
            {
                clearFields();
                lblmsg.ForeColor = System.Drawing.Color.Red;

                if (hdnbtnADD.Value == update)
                {
                    lblmsg.Text = UpdtFalid;
                }
                else
                {
                    lblmsg.Text = AlrdyExst;
                }
                
                

            }
           
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }


}
