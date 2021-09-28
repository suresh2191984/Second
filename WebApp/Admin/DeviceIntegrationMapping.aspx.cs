using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Globalization;
using System.Xml;
using System.Xml.Linq;
using System.Xml.XPath;
using System.Xml.Serialization;
using System.IO;
using Attune.Podium.BillingEngine;
using Attune.Podium.ExcelExportManager;
using System.Drawing;

public partial class Admin_DeviceIntegrationMapping : BasePage
{
    public Admin_DeviceIntegrationMapping()
        : base("Admin_DeviceIntegrationMapping_aspx")
    {
    }
    string InfoHeader = Resources.Admin_AppMsg.Admin_DeviceIntegrationMapping_aspx_07 == null ? "Alert" : Resources.Admin_AppMsg.Admin_DeviceIntegrationMapping_aspx_07;
               
    string strDispSave = Resources.Admin_AppMsg.Admin_Analyzer_aspx_Save == null ? "Save" : Resources.Admin_AppMsg.Admin_Analyzer_aspx_Save;
    string strDispUpdate = Resources.Admin_AppMsg.Admin_Analyzer_aspx_Update == null ? "Update" : Resources.Admin_AppMsg.Admin_Analyzer_aspx_Update;
    string strDispSel = Resources.Admin_AppMsg.Admin_drpSelect == null ? "---Select---" : Resources.Admin_AppMsg.Admin_drpSelect;
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    string IsActive = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        AutoCompleteExtenderTestName.ContextKey = OrgID.ToString();
        if (!Page.IsPostBack)
        {

            InstrumentName();
            LoadMeatData();

        }
    }


    public void LoadMeatData()
    {
        try
        {
            long returncode = -1;
            string domains = "DeviceFormula";
            string[] Tempdata = domains.Split(',');           
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            MetaData objMeta;
            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);
            }
            
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaData(lstmetadataInput, out lstmetadataOutput);
            string setID = string.Empty;
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "DeviceFormula"
                                 select child;
                if (childItems.Count() > 0)
                {
                    DrpFormula.DataSource = childItems;
                    DrpFormula.DataTextField = "DisplayText";
                    DrpFormula.DataValueField = "Code";
                    DrpFormula.DataBind();
                    DrpFormula.Items.Insert(0, new ListItem(strDispSel, ""));
                    DrpFormula.Items[0].Value = "";
                    DrpFormula.SelectedValue = setID;
                    
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() in Test Master", ex);
        }
    }

    public void InstrumentName()
    {
        long ReturnCode = -1;
        try
        {
            Master_BL MasterBL = new Master_BL(base.ContextInfo);
            List<InvInstrumentMaster> lstInst = new List<InvInstrumentMaster>();
            ReturnCode = MasterBL.GetInstrumentName(OrgID, out lstInst);
            if (lstInst.Count > 0)
            {
                DrpInstrumentName.DataSource = lstInst;
                DrpInstrumentName.DataTextField = "InstrumentName";
                DrpInstrumentName.DataValueField = "InstrumentName";
                DrpInstrumentName.DataBind();
                DrpInstrumentName.Items.Insert(0, strDispSel);//"Select");
                DrpInstrumentName.Focus();

            }

        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while GetInstrumentName", ex);
        }

    }



    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadGrid();
    }

    public void LoadGrid()
    {

        string InstrumentName = string.Empty;
        DrpInstrumentName.Enabled = true;
        InstrumentName = DrpInstrumentName.SelectedValue.ToString();
        long Returncode = -1;
        try
        {

            Master_BL MasterBL = new Master_BL(base.ContextInfo);
            List<DeviceIntegrationOrgMapping> lstDIM = new List<DeviceIntegrationOrgMapping>();
            List<DeviceIntegrationOrgMapping> lstDIM1 = new List<DeviceIntegrationOrgMapping>();
            string Nomatch = Resources.Admin_AppMsg.Admin_OrganisationLocation_aspx_20 == null ? "No Matching Records Found" : Resources.Admin_AppMsg.Admin_OrganisationLocation_aspx_20;
            Returncode = MasterBL.GetDeviceInstrumentDetails(OrgID, InstrumentName, out lstDIM, out lstDIM1);
            if (lstDIM.Count > 0)
            {
                divGrid.Style.Add("display", "block");
                grdDevice.DataSource = lstDIM;
                grdDevice.DataBind();


            }
            else
            {
                divGrid.Style.Add("display", "none");
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('No Matching Records Found');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "javascript:ValidationWindow('" + Nomatch + "','" + InfoHeader + "');", true);
            }

            if (lstDIM1.Count > 0)
            {
                if (!String.IsNullOrEmpty(lstDIM1[0].DeviceID) && lstDIM1[0].DeviceID!="0")
                {
                    TxtDeviceId.Text = lstDIM1[0].DeviceID;
                    TxtDeviceId.Enabled = false;
                }
                else
                {
                    TxtDeviceId.Text = "";
                    TxtDeviceId.Enabled = true;
                }
            }

            
            TxtInvName.Text = "";
            TxtTestCode.Text = "";
            hdnDeviceMappingID.Value = "0";
            hdnTestID.Value = "0";
            hdnValueID.Value = "0";
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while GetDeviceInstrumentDetails", ex);
        }


    }

    protected void grdDevice_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        btnSearch_Click(sender, e);
        grdDevice.PageIndex = e.NewPageIndex;
        grdDevice.DataBind();
    }
    protected void grdDevice_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DeviceEdit")
        {
            Int32 rowIndex = Convert.ToInt32(e.CommandArgument);
            string InstrumentName = Convert.ToString(grdDevice.DataKeys[rowIndex]["InstrumentName"]);
            string TestCode = Convert.ToString(grdDevice.DataKeys[rowIndex]["TestCode"]);
            string InvestigationName = Convert.ToString(grdDevice.DataKeys[rowIndex]["InvestigationName"]);
            string DeviceID = Convert.ToString(grdDevice.DataKeys[rowIndex]["DeviceID"]);
            long InvestigationID = Convert.ToInt64(grdDevice.DataKeys[rowIndex]["InvestigationID"]);
            long DeviceMappingID = Convert.ToInt64(grdDevice.DataKeys[rowIndex]["DeviceMappingID"]);
            string Formula = Convert.ToString(grdDevice.DataKeys[rowIndex]["Formula"]);
            BindDeviceValues(InstrumentName, DeviceID, TestCode, InvestigationName, InvestigationID,Formula);
            DrpInstrumentName.Enabled = true;
            TxtDeviceId.Enabled = false;
            txtFormula.Enabled = false;

        }

    }

    public void BindDeviceValues(string InstrumentName, string DeviceID, string TestCode, string InvestigationName, long InvestigationID,string Formula)
    {
        long Returncode = -1;
        btnAdd.Text = strDispUpdate;
        btnAdd.Text =  Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_23 == null ? "Update" : Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_23;
        hdnValueID.Value = "1";
        try
        {
            Master_BL MasterBL = new Master_BL(base.ContextInfo);
            List<DeviceIntegrationOrgMapping> lstDIM = new List<DeviceIntegrationOrgMapping>();
            Returncode = MasterBL.GetDeviceInstrumentDetailsEdit(OrgID, DeviceID, TestCode, InvestigationID, out lstDIM);

            if (lstDIM.Count > 0)
            {
                DrpInstrumentName.SelectedValue = lstDIM[0].InstrumentName.ToString();
                TxtDeviceId.Text = DeviceID;
                TxtTestCode.Text = lstDIM[0].TestCode.ToString();
                TxtInvName.Text = lstDIM[0].InvestigationName.ToString();
                hdnTestID.Value = lstDIM[0].InvestigationID.ToString();
                if (lstDIM[0].Formula.ToString() != "")
                {
                    txtFormula.Text = lstDIM[0].Formula.ToString();
                }
                if(txtFormula.Text=="")
                {
                     txtFormula.Text = Formula;
                }
                txtFormula.Enabled = false;
                hdnDeviceMappingID.Value = lstDIM[0].DeviceMappingID.ToString();
                if (lstDIM[0].IsActive == "Y")
                {
                    chkActive.Checked = true;

                }
                else
                {
                    chkActive.Checked = false;

                }

            }
        }

        catch (Exception ex)
        {

            CLogger.LogError("Error while GetDeviceInstrumentDetailsEdit", ex);
        }



    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        long RtCode = -1;
        int ValueID = Int32.Parse(hdnValueID.Value.ToString());
        long DeviceMappingID = Int64.Parse(hdnDeviceMappingID.Value.ToString());
        long InvestigationID = Int64.Parse(hdnTestID.Value.ToString());

        if (chkActive.Checked == true)
        {
            IsActive = "Y";
        }
        else
        {
            IsActive = "N";
        }
        try
        {
            Master_BL MasterBL = new Master_BL(base.ContextInfo);
            List<DeviceIntegrationOrgMapping> lstDIM = new List<DeviceIntegrationOrgMapping>();
            RtCode = MasterBL.SaveAndUpdateDeviceIntegration(OrgID, TxtDeviceId.Text, DeviceMappingID, TxtTestCode.Text, InvestigationID, DrpInstrumentName.SelectedValue.ToString(), ValueID, txtFormula.Text, IsActive);

            if (RtCode >= 0)
            {
                //string InfoHeader = Resources.Admin_AppMsg.Admin_DeviceIntegrationMapping_aspx_07 == null ? "Alert" : Resources.Admin_AppMsg.Admin_DeviceIntegrationMapping_aspx_07;
                string AlrtText = Resources.Admin_AppMsg.Admin_DeviceIntegrationMapping_aspx_06 == null ? "Successfully Saved" : Resources.Admin_AppMsg.Admin_DeviceIntegrationMapping_aspx_06;
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('Successfully Saved');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "javascript:ValidationWindow('" + AlrtText + "','" + InfoHeader + "');", true);

                TxtDeviceId.Text = "";
                TxtInvName.Text = "";
                TxtTestCode.Text = "";
                txtFormula.Text = "";
                hdnDeviceMappingID.Value = "0";
                hdnTestID.Value = "0";
                hdnValueID.Value = "0";
                chkActive.Checked = false;
                btnSearch_Click(sender, e);
            }
            DrpInstrumentName.Enabled = true;
            btnAdd.Text = strDispSave;
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while SaveAndUpdateDeviceIntegration", ex);
        }

    }
    protected void grdDevice_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            imgBtnXL.Visible = true;
            lnkExportXL.Visible = true;
            e.Row.BackColor = System.Drawing.Color.PapayaWhip;


        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        CancelButtonClick();
    }

    public void CancelButtonClick()
    {
        /*long Returncode = -1;
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            Returncode = new Navigation().GetLandingPage(lstUserRole, out path);
            //Response.Redirect(Helper.GetAppName() + path, true);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }*/

        DrpInstrumentName.SelectedIndex = 0;
        TxtDeviceId.Text = "";
        TxtTestCode.Text = "";
        TxtInvName.Text = "";
        txtFormula.Text = "";
        chkActive.Checked = false;
    }

    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        ExportToExcel();

    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }

    public void ExportToExcel()
    {
        try
        {
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "DeviceMapping.xls"));
            Response.ContentType = "application/ms-excel";
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            LoadGrid();
            grdDevice.AllowPaging = false;
            grdDevice.DataBind();

            //Applying stlye to gridview header cells
            for (int i = 0; i < grdDevice.HeaderRow.Cells.Count; i++)
            {
                grdDevice.HeaderRow.Cells[i].Style.Add("background-color", "#507CD1");
            }
            int j = 1;
            //This loop is used to apply stlye to cells based on particular row
            foreach (GridViewRow gvrow in grdDevice.Rows)
            {
                gvrow.BackColor = Color.White;
                if (j <= grdDevice.Rows.Count)
                {
                    if (j % 2 != 0)
                    {
                        for (int k = 0; k < gvrow.Cells.Count; k++)
                        {
                            gvrow.Cells[k].Style.Add("background-color", "#EFF3FB");
                        }
                    }
                }
                j++;
            }

            grdDevice.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in ExCel, ExporttoExcel", ex);
        }

    }



}
