<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CreditLimitReport.aspx.cs"
    Inherits="Reports_CreditLimitReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Credit Limit Report</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
      <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../Scripts/Common.js" language="javascript"></script>

    <script runat="server">
        string _date;
        string GetDate(string Date)
        {
            if (Date != "01/01/0001")
            {
                _date = Date;
            }
            else
            {
                _date = "--";
            }
            return _date;
        }
        
    </script>

</head>
<body>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="AdminHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: none;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata1">
                        <ul style="display: none;">
                            <li>
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <div>
                            <table cellpadding="2" class="dataheader2 defaultfontcolor" style="text-align: left;"
                                cellspacing="1">
                                <tr>
                                    <td align="left">
                                        <table>
                                            <tr>
                                                <td align="left">
                                                    From :
                                                    <asp:TextBox runat="server" ID="txtFromDate" MaxLength="10" CssClass ="Txtboxsmall" Width="100px" size="25"></asp:TextBox>
                                                    &nbsp;<asp:Image runat="server" ID="ImgBntCalc" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                        Width="16px" Height="16px" border="0" alt="Pick from date" />
                                                    <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc"
                                                        TargetControlID="txtFromDate" Enabled="True" />
                                                    To :
                                                    <asp:TextBox runat="server" ID="txtToDate" MaxLength="10" CssClass ="Txtboxsmall" Width="100px"></asp:TextBox>
                                                    &nbsp;<asp:Image runat="server" ID="ImgToDate" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                        Width="16px" Height="16px" AlternateText="Pick to date" />
                                                    <ajc:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgToDate"
                                                        TargetControlID="txtToDate" Enabled="True" />
                                                </td>
                                                <td align="right">
                                                    <asp:Button runat="server" ID="btnGo" Text=" Go " CssClass="btn" TabIndex="6" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClick="btnGo_Click" />
                                                    &nbsp;
                                                    <asp:Button ID="btnCancel" runat="server" Text="Reset" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                                        onmouseout="this.className='btn1'" OnClick="btnCancel_Click" />
                                                    <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click">
                                                Back
                                                    </asp:LinkButton>
                                                    &nbsp;
                                                    <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" OnClick="imgBtnXL_Click" />
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div align="center" id="printCashClosure">
                            <table cellpadding="2" class="defaultfontcolor" style="text-align: left;" cellspacing="1"
                                width="100%">
                                <tr id="tralldetails" runat="server">
                                    <td valign="top">
                                        <div id="divAllUsers" runat="server">
                                            <table cellpadding="2" class="defaultfontcolor" style="color: Black; font-family: Verdana;
                                                text-align: left;" cellspacing="1" width="100%">
                                                <tr>
                                                    <td valign="top" class="dataheader2" nowrap="nowrap">
                                                        <asp:GridView ID="grdResult" runat="server" EmptyDataText="No Results Found." AutoGenerateColumns="False"
                                                            CellPadding="4" CssClass="mytable1" Width="100%">
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <RowStyle HorizontalAlign="Left" Font-Size="10px" />
                                                            <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                                PageButtonCount="5" PreviousPageText="" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="S.No">
                                                                    <ItemTemplate>
                                                                        <%# Container.DataItemIndex + 1 %>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="DOA" ItemStyle-HorizontalAlign="Right" Visible="true">
                                                                    <ItemTemplate>
                                                                        <%# GetDate(DataBinder.Eval(Container.DataItem, "AdmissionDate", "{0:dd/MM/yyyy}").ToString())%>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="25px" />
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="BedDetail" HeaderText="Room #" />
                                                                <asp:BoundField DataField="PatientNumber" HeaderText="Patient #" />
                                                                <asp:BoundField DataField="Name" HeaderText="Name" />
                                                                <asp:BoundField DataField="BillNumber" HeaderText="Bill No" />
                                                                <asp:BoundField DataField="IsCreditBill" HeaderText="Credit/Cash" />
                                                                <asp:BoundField DataField="TPAName" HeaderText="Insurance/Corp Name" />
                                                                <asp:BoundField DataField="AdvanceAmount" HeaderText="Advance Amt" />
                                                                <asp:BoundField DataField="PreAuthAmount" HeaderText="PreAuth Amt" />
                                                                <asp:BoundField DataField="CreditLimit" HeaderText="CreditLimit" />
                                                                <asp:TemplateField HeaderText="Upper Billable Limit" ItemStyle-HorizontalAlign="Right">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblUpperBillable" Text='<%# UpperBillableCalc(Eval("AdvanceAmount"),Eval("PreAuthAmount"),Eval("CreditLimit")) %>'
                                                                            runat="server"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="BillAmount" HeaderText="Billed Amt" />
                                                                <asp:TemplateField HeaderText="Burnt %" ItemStyle-HorizontalAlign="Right">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblBurnt" Text='<%# Burnt(Eval("BillAmount"),Eval("AdvanceAmount"),Eval("PreAuthAmount"),Eval("CreditLimit")) %>'
                                                                            runat="server"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="DueDetails" HeaderText="Amount Due" />
                                                                <asp:BoundField DataField="CreditLimitRemarks" HeaderText="Credit Limit Remarks" />
                                                            </Columns>
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
