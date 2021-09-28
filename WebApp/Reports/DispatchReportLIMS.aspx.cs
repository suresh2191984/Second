using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using System.Collections;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.IO;
using Attune.Podium.ExcelExportManager;



public partial class Reports_DispatchReportLIMS : BasePage
{
    public Reports_DispatchReportLIMS()
        : base("Reports_DispatchReportLIMS_aspx")
    {
    }
    List<DayWiseCollectionReport> lstDispatchReport;
    List<OrderedInvestigations> lstorderedinvestigations;
    int currentPageNo = 1;
    int PageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    string strselect = Resources.Reports_ClientDisplay.Reports_DispatchReportLIMS_aspx_01 == null ? "--Select--" : Resources.Reports_ClientDisplay.Reports_DispatchReportLIMS_aspx_01;
    string WinAlert = Resources.Reports_AppMsg.Reports_Reports_DispatchReportLIMS_aspx_Alert == null ? "Alert" : Resources.Reports_AppMsg.Reports_Reports_DispatchReportLIMS_aspx_Alert;
    string UsrMsgWin = Resources.Reports_AppMsg.Reports_Reports_DispatchReportLIMS_aspx_01 == null ? "No Matching Record Found" : Resources.Reports_AppMsg.Reports_Reports_DispatchReportLIMS_aspx_01;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
            txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
            txtFDate.Text = OrgTimeZone;
            txtTDate.Text = OrgTimeZone;
            LoadOrgan();
            GetClientType();
            loadlocations(RoleID, OrgID);
            LoadEmpType();
            LoadMetaData();
            LoadDespatchMode();
        }

    }




    public void LoadEmpType()
    {
        long returnCode = -1;
         try
         {
             Master_BL obj = new Master_BL(base.ContextInfo);
        List<EmployerDeptMaster> lstEmpDeptMaster = new List<EmployerDeptMaster>();
       
        returnCode = obj.GetEmployerDeptMaster(OrgID, out lstEmpDeptMaster);
        drplstPerson.DataSource = lstEmpDeptMaster.FindAll(p => p.EmpDeptName == "COURIER"); ;
        drplstPerson.DataValueField = "Code";
        drplstPerson.DataTextField = "EmpDeptName";
        drplstPerson.DataBind();
        drplstPerson.Items.Insert(0, strselect);
        drplstPerson.Items[0].Value = "0";
        }
         catch (Exception ex)
         {
             CLogger.LogError("Error Occured to get Despatch Mode", ex);
         }

    }

    public void GetClientType()
    {
        long returnCode = -1;
        try
        {
            Patient_BL Patient_BL = new Patient_BL(base.ContextInfo);
            List<InvClientType> lstInvClientType = new List<InvClientType>();
            returnCode = Patient_BL.GetInvClientType(out lstInvClientType);
            if (lstInvClientType.Count > 0)
            {
                ddlClientType.DataSource = lstInvClientType.FindAll(p => p.IsInternal == "N");
                ddlClientType.DataValueField = "ClientTypeID";
                ddlClientType.DataTextField = "ClientTypeName";
                ddlClientType.DataBind();
                ddlClientType.Items.Insert(0, new ListItem(strselect, "0"));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Get InvClientType", ex);
        }
    }
    private void LoadOrgan()
    {
        try
        {
            List<Organization> lstOrgList = new List<Organization>();
            AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
            objBl.GetSharingOrganizations(OrgID, out lstOrgList);
            if (lstOrgList.Count > 0)
            {
                trTrustedOrg.Style.Add("display", "table-row");
                ddlTrustedOrg.DataSource = lstOrgList;
                ddlTrustedOrg.DataTextField = "Name";
                ddlTrustedOrg.DataValueField = "OrgID";
                ddlTrustedOrg.DataBind();              
                ddlTrustedOrg.SelectedValue = lstOrgList.Find(p => p.OrgID == OrgID).ToString();
                ddlTrustedOrg.Focus();
            }
            else
            {
                trTrustedOrg.Style.Add("display", "none");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load TrustedOrg details", ex);

        }
    }


    protected void loadlocations(long uroleID, int intOrgID)
    {
        long returnCode = -1;
        try
        {
            PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
            List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
            returnCode = patientBL.GetLocation(intOrgID, LID, uroleID, out lstLocation);
            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "Location";
            ddlLocation.DataValueField = "AddressID";
            ddlLocation.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured during GetLocation", ex);
        }
    }

    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("ViewReportList.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Home Page", ex);
        }
    }

    protected void gvOrgwiseDispatch_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvOrgwiseDispatch.PageIndex = e.NewPageIndex;
            //btnSubmit_Click(sender, e);
            BTNSearch();
        }

    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        BTNSearch();

    }

    public void BTNSearch()
    {
        currentPageNo = 1;
        try
        {
            lblHeader.Text="";
            lblorg.Text="";
            lbldate.Text = "";
            lblRefDoc.Text = "";

            lstDispatchReport = new List<DayWiseCollectionReport>();
            lstorderedinvestigations = new List<OrderedInvestigations>();
            long ReturnCode = -1;
            Report_BL BAL = new Report_BL(base.ContextInfo);
                        string Status= "Dispatch";

            long pOrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            int OrgAddressID = Convert.ToInt32(ddlLocation.SelectedValue);
            string fdate = txtFDate.Text;
            string tdate = txtTDate.Text;
            DateTime fDate = Convert.ToDateTime(Convert.ToDateTime(fdate).ToString("dd/MM/yyyy"));
            DateTime tDate = Convert.ToDateTime(Convert.ToDateTime(tdate).ToString("dd/MM/yyyy"));
            //DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            //DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            int RefHospitalID = Convert.ToInt32(hdnReferringHospitalID.Value);
            int RefPhysicianID = Convert.ToInt32(hdnPhysicianID.Value);
            int ClientTypeID = Convert.ToInt32(ddlClientType.SelectedValue);
            long ClientID = 0;
            if (hdnSelectedClientID.Value != "0" && hdnSelectedClientID.Value != "")
            {
                string[] clientid = hdnSelectedClientID.Value.Split('|');
                 ClientID = Convert.ToInt32(clientid[0]);
            }
            int CourierBoyID = 0;
           
         
            if (txtPersonName.Text != "")
            {
                 CourierBoyID = Convert.ToInt32(hdnEmpID.Value);
            }
            
             string DispatchTypeID = string.Empty;
             long DispatchModeid = 0;
             if (!String.IsNullOrEmpty(ddldespatch.SelectedValue) && ddldespatch.SelectedValue.ToString().Length > 0)
             {
                 DispatchTypeID = ddldespatch.SelectedValue.ToString();
             }


             if (!String.IsNullOrEmpty(ddlDespatchMode.SelectedValue) && ddlDespatchMode.SelectedValue.ToString().Length > 0)
             {
                 DispatchModeid = Convert.ToInt64(ddlDespatchMode.SelectedValue);
             }

             BAL.GetCourierDetailsReport(pOrgID, OrgAddressID, Status, RefHospitalID, RefPhysicianID, fDate, tDate, ClientID, ClientTypeID, CourierBoyID, DispatchTypeID, DispatchModeid, out lstDispatchReport, out lstorderedinvestigations, PageSize, currentPageNo, out totalRows);

           
                if (lstDispatchReport.Count > 0)
                {
                 
                    gvOrgwiseDispatch.DataSource = lstDispatchReport;
                    gvOrgwiseDispatch.DataBind();
                    hdnEmpID.Value = "";
                    lblHeader.Text = "SUBURBAN DIAGNOSTICS PVT LTD";
                    lblorg.Text = ddlTrustedOrg.SelectedItem.Text +" - "+ ddlLocation.SelectedItem.Text;
                    if (ddldespatch.SelectedItem.Text == strselect)
                    {
                    lbldate.Text = fdate + " - " + tdate+"  "+"Doctor and Home Delivery"; 
                    }
                     if (txtReferringPhysician.Text!="")
                    {
                        lblRefDoc.Text = txtReferringPhysician.Text;
                    }
                     if (ddldespatch.SelectedItem.Text == "HomeDelivery")
                    {
                        lbldate.Text = fdate + " - " + tdate + "  " + "Home Delivery";
                    }
                     if (ddldespatch.SelectedItem.Text == "Doctor/Clinic Delivery")
                    {
                        lbldate.Text = fdate + " - " + tdate + "  " + "Doctor Delivery";
                    }

                     
                 //   GroupGridView(gvOrgwiseDispatch.Rows, 0, 16);
                   

                }


           

            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgWin + "','" + WinAlert + "');", true);
                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Alt", "alert('No Matching Record Found');", true);
                gvOrgwiseDispatch.DataSource = "";
                gvOrgwiseDispatch.DataBind();
            }
                if (lstDispatchReport.Count > 0)
                {
                    GrdFooter.Style.Add("display", "block");
                    totalpage = totalRows;
                    lblTotal.Text = CalculateTotalPages(totalRows).ToString();

                    hdnCurrent.Value = currentPageNo.ToString();
                    lblCurrent.Text = currentPageNo.ToString();

                    if (currentPageNo == 1)
                    {
                        btnPrevious.Enabled = false;
                        if (Int32.Parse(lblTotal.Text) > 1)
                        {
                            btnNext.Enabled = true;
                        }
                        else
                            btnNext.Enabled = false;
                    }
                    else
                    {
                        btnPrevious.Enabled = true;
                        if (currentPageNo == Int32.Parse(lblTotal.Text))
                            btnNext.Enabled = false;
                        else btnNext.Enabled = true;
                    }
                }
                else
                    GrdFooter.Style.Add("display", "none");


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, OPCollectionReport", ex);
        }
    }

  public  void GroupGridView(GridViewRowCollection gvrc, int startIndex, int total)
    {
        if (total == 0) return;
        int i, count = 1;
        ArrayList lst = new ArrayList();
        lst.Add(gvrc[0]);
        var ctrl = gvrc[0].Cells[startIndex];
        for (i = 1; i < gvrc.Count; i++)
        {
            TableCell nextCell = gvrc[i].Cells[startIndex];
            if (ctrl.Text == nextCell.Text)
            {
                count++;
                nextCell.Visible = false;
                lst.Add(gvrc[i]);
            }
            else
            {
                if (count > 1)
                {
                    ctrl.RowSpan = count;
                    GroupGridView(new GridViewRowCollection(lst), startIndex + 1, total - 1);
                }
                count = 1;
                lst.Clear();
                ctrl = gvrc[i].Cells[startIndex];
                lst.Add(gvrc[i]);
            }
        }
        if (count > 1)
        {
            ctrl.RowSpan = count;
            GroupGridView(new GridViewRowCollection(lst), startIndex + 1, total - 1);
        }
        count = 1;
        lst.Clear();
    }

    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        ExportToExcel();
      
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }

    public  void ExportToExcel()
    {
        try
        {
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "Dispatch Report.xls"));
            Response.ContentType = "application/ms-excel";
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            BTNSearch();
            gvOrgwiseDispatch.AllowPaging = false;
            gvOrgwiseDispatch.DataBind();
            //Change the Header Row back to white color
            gvOrgwiseDispatch.HeaderRow.Style.Add("background-color", "#FFFFFF");
            prnReport.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in ExCel, ExporttoExcel", ex);
        }

        }

  
    protected void gvOrgwiseDispatch_RowDataBound(object sender, GridViewRowEventArgs e)
    {
       
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
           
            imgBtnXL.Visible = true;
            lnkExportXL.Visible = true;
            imgprint.Visible = true;
            lnkPrint.Visible = true;
            //Label lblRegistrationDate = (Label)e.Row.FindControl("lblRegistrationDate");
            //Label lblSampleCollectedDate = (Label)e.Row.FindControl("lblSampleCollectedDate");
            //Label lblApprovedAt = (Label)e.Row.FindControl("lblApprovedAt");
            //Label lblDespatchDate = (Label)e.Row.FindControl("lblDespatchDate");

            //if (DateTime.Parse(lblRegistrationDate.Text).ToString("dd-MMM-yyyy") == "01-Jan-1900")
            //{
            //    e.Row.Cells[12].Text = "**";

            //}

            //if (DateTime.Parse(lblSampleCollectedDate.Text).ToString("dd-MMM-yyyy") == "01-Jan-1900")
            //{
            //    e.Row.Cells[13].Text = "**";

            //}

            //if (DateTime.Parse(lblApprovedAt.Text).ToString("dd-MMM-yyyy") == "01-Jan-1900")
            //{
            //    e.Row.Cells[14].Text = "**";
              
            //}

            //if (DateTime.Parse(lblDespatchDate.Text).ToString("dd-MMM-yyyy") == "01-Jan-1900")
            //{
            //    e.Row.Cells[15].Text = "**";

            //}
            
                 List<OrderedInvestigations> tempList = new List<OrderedInvestigations>();
                DayWiseCollectionReport IOM = (DayWiseCollectionReport)e.Row.DataItem;
                tempList = lstorderedinvestigations.FindAll(p => p.VisitID == IOM.PatientVisitId);
                string strtemp = GetToolTip(tempList);
                //e.Row.Cells[2].Attributes.Add("onmouseover", "this.className='colornw';showTooltip(event,'" + strtemp + "');return false;");
                //e.Row.Cells[2].Attributes.Add("onmouseout", "this.style.color='Black';hideTooltip();");
                //e.Row.Cells[2].Style.Add("color", "Blue");
          

        }

    }
    private string GetToolTip(List<OrderedInvestigations> tempList)
    {
        string TableHead = "";
        string TableData = "";
        TableHead = "<table border=\"1\" cellpadding=\"2\"cellspacing=\"2\" style=\"font-size:medium;\"  ><tr style=\"font-weight: bold;width:50%;\" ><td>Investigation Name</td><td>Status</td><td>Type</td></tr>";
        foreach (OrderedInvestigations item in tempList)
        {
            TableData += "<tr style=\"width:50%;\">  <td>" + item.Name + "</td><td>" + item.Status.ToString() + "</td><td>" + item.Type + "</td></tr>";
        }
        return TableHead + TableData + "</table> ";
    }

    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "DespatchType";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }


           
            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
			returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "DespatchType"
                                 orderby child.DisplayText descending
                                 select child;
                ddldespatch.DataSource = childItems;
                ddldespatch.DataTextField = "DisplayText";
                ddldespatch.DataValueField = "Code";
                ddldespatch.DataBind();
                ListItem lstItem = new ListItem();
                lstItem.Text = strselect;
                lstItem.Value = "0";
                ddldespatch.Items.Insert(0, lstItem);

            }
            
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Despatch Status ", ex);
           

        }
    }


    void LoadDespatchMode()
    {
        long returnCode = -1;
        Master_BL obj = new Master_BL(base.ContextInfo);
        List<ClientAttributes> lstclientattrib = new List<ClientAttributes>();
        List<MetaValue_Common> lstmetavalue = new List<MetaValue_Common>();
        List<ActionManagerType> lstactiontype = new List<ActionManagerType>();
        //List<ActionManagerType> lstactionCourieronly = new List<ActionManagerType>();
        List<InvReportMaster> lstrptmaster = new List<InvReportMaster>();
        returnCode = obj.GetGroupValues(OrgID, out lstmetavalue, out lstactiontype, out lstclientattrib, out lstrptmaster);
        if (lstactiontype.Count > 0)
        {
    

            lstactiontype = (from p in lstactiontype
                             where p.ActionTypeID  == 4 
                                  select p).ToList();
            
            
            ddlDespatchMode.DataSource = lstactiontype;
            ddlDespatchMode.DataTextField = "ActionType";
            ddlDespatchMode.DataValueField = "ActionTypeID";
            ddlDespatchMode.DataBind();
            ListItem lstItem = new ListItem();
            lstItem.Text = strselect;
            lstItem.Value = "4";
            ddlDespatchMode.Items.Insert(0, lstItem);
            


        }
    }


    protected void lnkExportXL_Click(object sender, EventArgs e)
    {
        try
        {
            ExportToExcel();
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in ExCel, ExporttoExcel", ex);
        }
    }
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            BTNSearch(currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            BTNSearch(currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            BTNSearch(currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            BTNSearch(currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);
        return totalPages;
    }
    protected void btnGo1_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = txtpageNo.Text;
        BTNSearch(Convert.ToInt32(txtpageNo.Text), PageSize);
    }

    public void BTNSearch(int currentPageNo,int PageSize)
    {
        try
        {
            lstDispatchReport = new List<DayWiseCollectionReport>();
            lstorderedinvestigations = new List<OrderedInvestigations>();
            long ReturnCode = -1;
            Report_BL BAL = new Report_BL(base.ContextInfo);
            string Status = "Dispatch";

            long pOrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            int OrgAddressID = Convert.ToInt32(ddlLocation.SelectedValue);
            string fdate = txtFDate.Text;
            string tdate = txtTDate.Text;
            DateTime fDate = Convert.ToDateTime(Convert.ToDateTime(fdate).ToString("dd/MM/yyyy"));
            DateTime tDate = Convert.ToDateTime(Convert.ToDateTime(tdate).ToString("dd/MM/yyyy"));
            //DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            //DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            int RefHospitalID = Convert.ToInt32(hdnReferringHospitalID.Value);
            int RefPhysicianID = Convert.ToInt32(hdnPhysicianID.Value);
            int ClientTypeID = Convert.ToInt32(ddlClientType.SelectedValue);
            long ClientID = 0;
            if (hdnSelectedClientID.Value != "0" && hdnSelectedClientID.Value != "")
            {
                string[] clientid = hdnSelectedClientID.Value.Split('|');
                ClientID = Convert.ToInt32(clientid[0]);
            }
            int CourierBoyID = 0;


            if (txtPersonName.Text != "")
            {
                CourierBoyID = Convert.ToInt32(hdnEmpID.Value);
            }

            string DispatchTypeID = string.Empty;
            long DispatchModeid = 0;
            if (!String.IsNullOrEmpty(ddldespatch.SelectedValue) && ddldespatch.SelectedValue.ToString().Length > 0)
            {
                DispatchTypeID = ddldespatch.SelectedValue.ToString();
            }


            if (!String.IsNullOrEmpty(ddlDespatchMode.SelectedValue) && ddlDespatchMode.SelectedValue.ToString().Length > 0)
            {
                DispatchModeid = Convert.ToInt64(ddlDespatchMode.SelectedValue);
            }

            BAL.GetCourierDetailsReport(pOrgID, OrgAddressID, Status, RefHospitalID, RefPhysicianID, fDate, tDate, ClientID, ClientTypeID, CourierBoyID, DispatchTypeID, DispatchModeid, out lstDispatchReport, out lstorderedinvestigations, PageSize, currentPageNo, out totalRows);


            if (lstDispatchReport.Count > 0)
            {

                gvOrgwiseDispatch.DataSource = lstDispatchReport;
                gvOrgwiseDispatch.DataBind();
                hdnEmpID.Value = "";
                //   GroupGridView(gvOrgwiseDispatch.Rows, 0, 16);


            }




            else
            {
                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Alt", "alert('No Matching Record Found');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgWin + "','" + WinAlert + "');", true);
                gvOrgwiseDispatch.DataSource = "";
                gvOrgwiseDispatch.DataBind();
            }
            if (lstDispatchReport.Count > 0)
            {
                GrdFooter.Style.Add("display", "block");
                totalpage = totalRows;
                lblTotal.Text = CalculateTotalPages(totalRows).ToString();
                if (hdnCurrent.Value == "")
                {
                    lblCurrent.Text = currentPageNo.ToString();
                }
                else
                {
                    lblCurrent.Text = hdnCurrent.Value;
                    currentPageNo = Convert.ToInt32(hdnCurrent.Value);
                }
                if (currentPageNo == 1)
                {
                    btnPrevious.Enabled = false;
                    if (Int32.Parse(lblTotal.Text) > 1)
                    {
                        btnNext.Enabled = true;
                    }
                    else
                        btnNext.Enabled = false;
                }
                else
                {
                    btnPrevious.Enabled = true;
                    if (currentPageNo == Int32.Parse(lblTotal.Text))
                        btnNext.Enabled = false;
                    else btnNext.Enabled = true;
                }
            }
            else
                GrdFooter.Style.Add("display", "none");


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, OPCollectionReport", ex);
        }
    }
}

