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
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Linq;

public partial class Investigation_PrintWorkListFromVisitToVisit : BasePage
{
    long vid = 0;
    long returnCode = -1;
    string fromVisit = string.Empty;
    string toVisit = string.Empty;
    string IsIncludevalues = "Y";
    int intVisitType = -1;
    List<WorkOrder> lstWorkList = new List<WorkOrder>();
    Investigation_BL investigationBL;
    protected void Page_Load(object sender, EventArgs e)
    {
        investigationBL = new Investigation_BL(base.ContextInfo);
        try
        {
            int deptID = 0;
            deptID = Convert.ToInt32(Request.QueryString["deptID"]);
            fromVisit = Request.QueryString["fvid"];
            toVisit = Request.QueryString["tvid"];
            intVisitType = Convert.ToInt16(Request.QueryString["vtyp"]);
            int Client = Convert.ToInt32(Request.QueryString["clientID"]);
            long LocationID = Convert.ToInt64(Request.QueryString["LocationID"]);
            string sWardName = Request.QueryString["WardName"];
            int PriorityID = Convert.ToInt16(Request.QueryString["PriorityID"]);
            string InvName = Request.QueryString["InvName"];

            string fromDate = Request.QueryString["fDate"];
            string toDate = Request.QueryString["tDate"];

            int intHistoryMode = Convert.ToInt32(Request.QueryString["hMode"]);
            string strPageMode = Request.QueryString["PageMode"];
            IsIncludevalues = Request.QueryString["IsIncludevalues"];

            //////////////returnCode = investigationBL.GetWorkListFromVisitToVisit(fromVisit.ToString(), toVisit.ToString(), OrgID, deptID,
            //////////////    ILocationID, Client, LocationID, sWardName, InvName, PriorityID, out lstWorkList, intVisitType, fromDate, toDate,
            //////////////    intHistoryMode, strPageMode, LID, IsIncludevalues, "All");
            returnCode = investigationBL.GetWorkListFromVisitToVisit(fromVisit.ToString(), toVisit.ToString(), OrgID, deptID, ILocationID
                   , Client, LocationID, sWardName, InvName, PriorityID, out lstWorkList, intVisitType,
                   fromDate, toDate, Convert.ToInt32(intHistoryMode), strPageMode, LID, IsIncludevalues, "All");
            if (lstWorkList.Count > 0)
            {

                TableRow bodyRow = null;

                int Rcount = 0;
                int PCount = 0;
                int FinalbillID = 0;
                Image img = null;
                int rowcount = 0;
                long visitid = 0;
                string Deptname = string.Empty;
                List<WorkOrder> lstparent = new List<WorkOrder>();
                lstparent = lstWorkList.FindAll(p => p.StrVisitID != "" && p.StrVisitID != null && p.StrBillNumber != null);
                foreach (WorkOrder objWL in lstparent)
                {
                    if (objWL.StrVisitID != "" && objWL.StrVisitID != null && objWL.Description != null)
                    {
                        visitid = objWL.VisitID;
                        Deptname = objWL.Description;
                        rowcount = 0;
                        ////sample print
                        long returncode = -1;
                        string IsBillWithBarcode = string.Empty;
                        IsBillWithBarcode = GetConfigValue("PrintBillBarcode", OrgID);
                        if (IsBillWithBarcode == "Y")
                        {
                            List<String> lstQueryString = new List<String>();
                            BarcodeHelper objBarcodeHelper = new BarcodeHelper();
                            returncode = objBarcodeHelper.GetBarcodeQueryString(OrgID, Convert.ToString(objWL.VisitID), string.Empty, FinalbillID, BarcodeCategory.Bill, out lstQueryString);
                            if (lstQueryString.Count > 0)
                            {
                                foreach (String queryString in lstQueryString)
                                {
                                    img = new Image();
                                    img.ImageUrl = "../admin/BarcodeHandler.ashx?" + queryString;
                                }



                            }

                        }

                        PCount += 1;
                        TableRow headerRow1 = new TableRow();
                        if (PCount > 1)
                        {
                            TableRow FooterRow1 = new TableRow();
                            TableCell Fcell11 = new TableCell();
                            TableCell Fcell22 = new TableCell();
                            Fcell11.ColumnSpan = 3;
                            Fcell11.Attributes.Add("align", "center");
                            Fcell22.ColumnSpan = 3;
                            Fcell22.Attributes.Add("align", "center");
                            Fcell11.Text = "Done By";
                            Fcell22.Text = "Supervised By";
                            FooterRow1.Cells.Add(Fcell11);
                            FooterRow1.Cells.Add(Fcell22);
                            //listTab.Rows.Add(FooterRow1);
                            headerRow1.Style.Add("page-break-before", "always");
                        }
                        TableRow headerRow2 = new TableRow();
                        TableRow headerRow3 = new TableRow();

                        headerRow1.Style.Add("font-size", "20px");
                        headerRow2.Style.Add("font-size", "20px");
                        headerRow3.Style.Add("font-size", "20px");

                        TableCell cell1 = new TableCell();
                        TableCell cell11 = new TableCell();
                        TableCell cell2 = new TableCell();
                        TableCell cell22 = new TableCell();
                        TableCell cell3 = new TableCell();
                        TableCell cell33 = new TableCell();
                        TableCell cell4 = new TableCell();
                        TableCell cell44 = new TableCell();
                        TableCell cell5 = new TableCell();
                        TableCell cell55 = new TableCell();
                        TableCell cell6 = new TableCell();
                        TableCell cell66 = new TableCell();
                        TableCell cellRM1 = new TableCell();
                        TableCell cellRM2 = new TableCell();
                        TableCell cellRM3 = new TableCell();
                        TableCell cellRM4 = new TableCell();
                        TableCell cellRM5 = new TableCell();
                        TableCell cellRM6 = new TableCell();
                       

                        cell1.Attributes.Add("align", "left");
                        cell1.Text = "<B>VisitNo</B>";
                        cell1.BorderWidth = 1;
                        cell1.Style.Add("white-space", "nowrap");
                        cell1.Style.Add("width", "8%");

                        cell11.Attributes.Add("align", "left");
                        cell11.Text = objWL.StrVisitID;
                        cell11.BorderWidth = 1;
                        cell11.Style.Add("white-space", "nowrap");
                        cell11.Style.Add("width", "10%");

                        cell2.Attributes.Add("align", "left");
                        cell2.Text = "<B>Name</B>";
                        cell2.BorderWidth = 1;

                        cell2.Style.Add("white-space", "nowrap");
                        cell2.Style.Add("width", "8%");

                        cell22.Attributes.Add("align", "left");
                        cell22.Text = objWL.PatientName + " / " + objWL.Age;
                        cell22.BorderWidth = 1;

                        cell22.Style.Add("white-space", "nowrap");
                        cell22.Style.Add("width", "20%");

                        cell3.Attributes.Add("align", "left");
                        cell3.Text = "<B>Rec.Date</B>";
                        cell3.BorderWidth = 1;

                        cell3.Style.Add("white-space", "nowrap");
                        cell3.Style.Add("width", "10%");


                        cell33.Attributes.Add("align", "left");
                        cell33.Text = objWL.ReceivedOn;
                        cell33.BorderWidth = 1;

                        cell33.Style.Add("white-space", "nowrap");
                        cell33.Style.Add("width", "18%");


                        cell4.Attributes.Add("align", "left");
                        cell4.Text = "<B>Client</B>";
                        cell4.BorderWidth = 1;

                        cell4.Style.Add("white-space", "nowrap");
                        cell4.Style.Add("width", "8%");

                        cell44.Attributes.Add("align", "left");
                        cell44.Text = objWL.Source;
                        cell44.BorderWidth = 1;

                        cell44.Style.Add("white-space", "nowrap");
                        cell44.Style.Add("width", "10%");

                        cell5.Attributes.Add("align", "left");
                        cell5.Text = "<B>Ref.By</B>";
                        cell5.BorderWidth = 1;

                        cell5.Style.Add("white-space", "nowrap");
                        cell5.Style.Add("width", "8%");

                        cell55.Attributes.Add("align", "left");
                        cell55.Text = objWL.ReferingPhysicianName;
                        cell55.BorderWidth = 1;

                        cell55.Style.Add("white-space", "nowrap");
                        cell55.Style.Add("width", "18%");

                        cell6.Attributes.Add("align", "left");
                        cell6.Text = "<B>Reg.Loc</B>";
                        cell6.BorderWidth = 1;

                        cell6.Style.Add("white-space", "nowrap");
                        cell6.Style.Add("width", "10%");

                        cell66.Attributes.Add("align", "left");
                        cell66.Text = objWL.Destination;
                        cell66.BorderWidth = 1;

                        cell66.Style.Add("white-space", "nowrap");
                        cell66.Style.Add("width", "18%");

                        cellRM1.Attributes.Add("align", "left");
                        cellRM1.Text = "<B>SampleID</B>";
                        cellRM1.BorderWidth = 1;

                        cellRM2.Attributes.Add("align", "left");
                        cellRM2.Text = objWL.StrBillNumber;
                        cellRM2.BorderWidth = 1;

                        cellRM3.Attributes.Add("align", "left");
                        cellRM3.Text = "<B>Protocol Name</B>";
                        cellRM3.BorderWidth = 1;
                        cellRM3.Style.Add("white-space", "nowrap");
                        cellRM3.Style.Add("width", "18%");
                       

                        cellRM4.Attributes.Add("align", "left");
                        cellRM4.Text = objWL.Protocolname;
                        cellRM4.BorderWidth = 1;
                        cellRM4.Style.Add("font-size", "10pt");

                        cellRM5.Attributes.Add("align", "left");
                        cellRM5.Text = "<B>Generated By</B>";
                        cellRM5.BorderWidth = 1;
                        cellRM5.Style.Add("white-space", "nowrap");
                        cellRM5.Style.Add("width", "18%");

                        cellRM6.Attributes.Add("align", "left");
                        cellRM6.Text = objWL.Loginname;
                        cellRM6.BorderWidth = 1;
                        headerRow1.Cells.Add(cell1);
                        headerRow1.Cells.Add(cell11);
                        headerRow1.Cells.Add(cell2);
                        headerRow1.Cells.Add(cell22);
                        headerRow1.Cells.Add(cell3);
                        headerRow1.Cells.Add(cell33);
                        headerRow2.Cells.Add(cell4);
                        headerRow2.Cells.Add(cell44);
                        headerRow2.Cells.Add(cell5);
                        headerRow2.Cells.Add(cell55);
                        headerRow2.Cells.Add(cell6);
                        headerRow2.Cells.Add(cell66);

                        headerRow3.Cells.Add(cellRM1);
                        headerRow3.Cells.Add(cellRM2);
                        headerRow3.Cells.Add(cellRM3);
                        headerRow3.Cells.Add(cellRM4);
                        headerRow3.Cells.Add(cellRM5);
                        headerRow3.Cells.Add(cellRM6);

                        listTab.Rows.Add(headerRow1);
                        listTab.Rows.Add(headerRow2);
                        listTab.Rows.Add(headerRow3);

                    }
                    List<WorkOrder> lstcontent = new List<WorkOrder>();
                    lstcontent = lstWorkList.FindAll(p => p.VisitID == visitid && p.Description == Deptname);
                    lstWorkList.RemoveAll(p => p.VisitID == visitid && p.Description == Deptname);
                    TableCell Bcell1 = new TableCell();
                    TableCell Bcell2 = new TableCell();
                    TableCell Bcell3 = new TableCell();
                    int counts = 0;
                   
                    foreach (WorkOrder content in lstcontent)
                    {
                        if (counts < 16)
                        {
                        bodyRow = new TableRow();
                        Rcount += 1;

                        

                        Bcell1.Attributes.Add("align", "left");
                            Bcell1.ColumnSpan = 4;
                        Bcell1.Style.Add("width", "100%");

                        if (rowcount == 0)
                        {
                            Table table = new Table();
                            table.Style.Add("width", "100%");
                            TableRow row = new TableRow();
                            TableCell barCell1 = new TableCell();
                            TableCell barCell2 = new TableCell();
                                TableCell barCell3 = new TableCell();
                            Label lblInvText = new Label();
                            if (objWL.Status == "Cancel")
                            {
                                    lblInvText.Text = "**" + content.InvestigationName;
                                lbltxt.Visible = true;
                            }
                            else if (objWL.Status == "NewlyAdded")
                            {
                                    lblInvText.Text = "*" + content.InvestigationName;
                                lbltxt.Visible = true;
                            }
                            else
                            {                                
                                    lblInvText.Text = content.InvestigationName;
                            }
						 
                                barCell1.Controls.Add(lblInvText);
                                barCell3.RowSpan = 2;
                                barCell3.Attributes.Add("align", "right");
                                
                                row.Cells.Add(barCell1);
                                table.Attributes.Add("cellpadding", "5px");
                                table.Attributes.Add("cellspacing", "5");
                              
                                table.Rows.Add(row);

                                Bcell1.Controls.Add(table);
                            }
                            else
                            {
                                if (objWL.Status == "Cancel")
                                {
                                    Bcell1.Text = "**" + content.InvestigationName;
                                    lbltxt.Visible = true;
                                }
                                else if (objWL.Status == "NewlyAdded")
                                {
                                    Bcell1.Text = "*" + content.InvestigationName;
                                    lbltxt.Visible = true;
                                }
                                else
                                {
                                    Bcell1.Text = content.InvestigationName;
                                }
                            }
                        }

                        else
                        {
                            bodyRow = new TableRow();
                            Rcount += 1;

                            Bcell2.Attributes.Add("align", "left");
                            Bcell2.ColumnSpan = 3;
                            Bcell2.Style.Add("width", "100%");

                            if (rowcount == 0)
                            {
                                Table table = new Table();
                                table.Style.Add("width", "100%");
                                TableRow row = new TableRow();
                                TableCell barCell1 = new TableCell();
                                TableCell barCell2 = new TableCell();
                                TableCell barCell3 = new TableCell();
                                Label lblInvText = new Label();
                                if (objWL.Status == "Cancel")
                                {
                                    lblInvText.Text = "**" + content.InvestigationName;
                                    lbltxt.Visible = true;
                                }
                                else if (objWL.Status == "NewlyAdded")
                                {
                                    lblInvText.Text = "*" + content.InvestigationName;
                                    lbltxt.Visible = true;
                                }
                                else
                                {
                                    lblInvText.Text = content.InvestigationName;
                                }

                                barCell1.Controls.Add(lblInvText);
                                barCell2.RowSpan = 2;
                                barCell2.Attributes.Add("align", "right");
                             
                                table.Attributes.Add("cellpadding", "5px");
                                table.Attributes.Add("cellspacing", "5");
                                row.Cells.Add(barCell1);
                             
                                table.Rows.Add(row);

                                Bcell2.Controls.Add(table);
                            }
                            else
                            {
                                if (objWL.Status == "Cancel")
                                {
                                    Bcell2.Text = "**" + content.InvestigationName;
                                    lbltxt.Visible = true;
                                }
                                else if (objWL.Status == "NewlyAdded")
                                {
                                    Bcell2.Text = "*" + content.InvestigationName;
                                    lbltxt.Visible = true;
                                }
                                else
                                {
                                    Bcell2.Text = content.InvestigationName;
                                }
                            }
                        }
                        bodyRow.Cells.Add(Bcell1);

                        counts++;

                    }



                    bodyRow.Cells.Add(Bcell2);
                   
                    bodyRow.Font.Bold = false;

                    TableCell Fcell1 = new TableCell();
                    TableCell Fcell2 = new TableCell();
                    if (Rcount == 45)
                    {
                        Rcount = 0;
                        TableRow FooterRow = new TableRow();
                        Fcell1.ColumnSpan = 3;
                        Fcell1.Attributes.Add("align", "center");
                        Fcell2.ColumnSpan = 3;
                        Fcell2.Attributes.Add("align", "center");
                        Fcell1.Text = "Done By";
                        Fcell2.Text = "Supervised By";
                        FooterRow.Cells.Add(Fcell1);
                        FooterRow.Cells.Add(Fcell2);
                       
                    }

                    listTab.Rows.Add(bodyRow);
                  
                }

            }
        }
        catch (Exception ex)
        {
        }
    }
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
}
