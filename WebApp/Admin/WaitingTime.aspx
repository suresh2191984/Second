<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WaitingTime.aspx.cs" Inherits="Admin_WaitingTime" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Admin Waiting Time</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />
     <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../Scripts/Common.js" language="javascript"></script>

    <script type="text/javascript" src="../Scripts/AutoComplete.js" language="javascript"></script>

    <script type="text/javascript" src="../Scripts/bid.js"></script>

    <script type="text/javascript" src="../Scripts/DHEBAdder.js"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <style type="text/css">
        .stylenone
        {
            display: none;
        }
    </style>
</head>
<body>
    <form id="frmPatientVitals" runat="server">

    <script language="javascript" type="text/javascript">
        function popupprint() {
            document.getElementById('<%= btnViewDetails.ClientID %>').style.display = 'None';
            document.getElementById('<%= ImgToDate.ClientID %>').style.display = 'None';
            document.getElementById('<%= ImgBntCalc.ClientID %>').style.display = 'None';

            var prtContent = document.getElementById('printCashClosure');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();

            document.getElementById('<%= btnViewDetails.ClientID %>').style.display = 'block';
            document.getElementById('<%= ImgToDate.ClientID %>').style.display = 'block';
            document.getElementById('<%= ImgBntCalc.ClientID %>').style.display = 'block';
        }
        function validateToDate() {

            if (document.getElementById('txtFromDate').value == '') {
                alert('Provide / select value for From date');
                document.getElementById('txtFromDate').focus();
                return false;
            }
            if (document.getElementById('txtToDate').value == '') {
                alert('Provide / select value for To date');
                document.getElementById('txtToDate').focus();
                return false;
            }
        }
    </script>

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
                <td width="15%" valign="top" id="menu" style="display: block;">
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
                        <ul>
                            <li>
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <div align="center" id="printCashClosure">
                            <table cellpadding="2" cellspacing="1" width="100%">
                                <tr>
                                    <td style="text-align: center; vertical-align: middle;">
                                        <table border="0" cellpadding="4" cellspacing="0">
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Rs_From" Text="From" runat="server" 
                                                        meta:resourcekey="Rs_FromResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    :
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox runat="server" ID="txtFromDate" MaxLength="10"  CssClass ="Txtboxsmall"
                                                        size="25" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                                    &nbsp;<asp:Image runat="server" ID="ImgBntCalc" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                        Width="16px" Height="16px" border="0" alt="Pick from date" 
                                                        meta:resourcekey="ImgBntCalcResource1" />
                                                    <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc"
                                                        TargetControlID="txtFromDate" Enabled="True" />
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="Rs_To" Text="To" runat="server" 
                                                        meta:resourcekey="Rs_ToResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    :
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox runat="server" ID="txtToDate" MaxLength="10"  CssClass ="Txtboxsmall"
                                                        meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                                    &nbsp;<asp:Image runat="server" ID="ImgToDate" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                        Width="16px" Height="16px" AlternateText="Pick to date" 
                                                        meta:resourcekey="ImgToDateResource1" />
                                                        
                                                    <asp:Button ID="btnViewDetails" runat="server" CssClass="btn" TabIndex="2" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                        Text="View Details" OnClick="btnViewDetails_Click" 
                                                        meta:resourcekey="btnViewDetailsResource1" />
                                                        &nbsp;
                                                         <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" 
                                                                    runat="server" CssClass="details_label_age"
                                                                    OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource2"></asp:LinkButton>
                                                    <ajc:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgToDate"
                                                        TargetControlID="txtToDate" Enabled="True" />
                                                </td>
                                                <td>
                                                    <asp:ImageButton runat="server" ID="btnExportToExcel" ImageUrl="~/Images/ExcelImage.GIF"
                                                        OnClick="btnExportToExcel_Click" ToolTip="Save As Excel" Visible="False" 
                                                        meta:resourcekey="btnExportToExcelResource1" />
                                                </td>
                                                <td>
                                                 
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="text-align: center;">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Panel ID="pnlExam" runat="server" CssClass="defaultfontcolor" 
                                            meta:resourcekey="pnlExamResource1">
                                            <div class="dataheader2">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 50%" valign="top">
                                                            <asp:Panel ID="pnlMax" runat="server" GroupingText="Top(5)Maximum Waiting Time" 
                                                                meta:resourcekey="pnlMaxResource1">
                                                                <asp:GridView ID="gvMaxWaitTime" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                    Visible="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                                                    CellPadding="3" Font-Bold="False" Font-Names="Verdana" Font-Overline="False"
                                                                    Font-Size="9pt" Font-Strikeout="False" Font-Underline="False" 
                                                                    meta:resourcekey="gvMaxWaitTimeResource1">
                                                                    <RowStyle ForeColor="#000066" />
                                                                    <Columns>
                                                                        <asp:BoundField DataField="PatientName" HeaderText="Patient Name" 
                                                                            meta:resourceKey="BoundFieldResource1">
                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="StartTime" 
                                                                            DataFormatString="{0:dd/MM/yyyy hh:mm tt}" HeaderText="Start Time" 
                                                                            meta:resourceKey="BoundFieldResource2" />
                                                                        <asp:BoundField DataField="EndTime" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" 
                                                                            HeaderText="End Time" meta:resourceKey="BoundFieldResource3" />
                                                                        <asp:BoundField DataField="ElapsedTime" HeaderText="Waiting Time(Mins)" 
                                                                            meta:resourceKey="BoundFieldResource4" />
                                                                    </Columns>
                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                </asp:GridView>
                                                            </asp:Panel>
                                                        </td>
                                                        <td style="width: 50%" valign="top">
                                                            <asp:Panel ID="pnlMinWaitTime" runat="server" 
                                                                GroupingText="Top(5)Minimum Waiting Time" 
                                                                meta:resourcekey="pnlMinWaitTimeResource1">
                                                                <asp:GridView ID="gvMinWaitTime" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                    Visible="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                                                    CellPadding="3" Font-Names="Verdana" Font-Size="9pt" 
                                                                    meta:resourcekey="gvMinWaitTimeResource1">
                                                                    <RowStyle ForeColor="#000066" />
                                                                    <Columns>
                                                                        <asp:BoundField DataField="PatientName" HeaderText="Patient Name" 
                                                                            meta:resourceKey="BoundFieldResource5">
                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="StartTime" 
                                                                            DataFormatString="{0:dd/MM/yyyy hh:mm tt}" HeaderText="Start Time" 
                                                                            meta:resourceKey="BoundFieldResource6" />
                                                                        <asp:BoundField DataField="EndTime" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" 
                                                                            HeaderText="End Time" meta:resourceKey="BoundFieldResource7" />
                                                                        <asp:BoundField DataField="ElapsedTime" HeaderText="Waiting Time(Mins)" 
                                                                            meta:resourceKey="BoundFieldResource8" />
                                                                    </Columns>
                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                </asp:GridView>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">
                                                            <asp:Label ID="Rs_AverageMaxWaitingTime" Text="Average Max Waiting Time :" 
                                                                runat="server" meta:resourcekey="Rs_AverageMaxWaitingTimeResource1"></asp:Label>
                                                            <asp:Label ID="lblMaxWaitTime" runat="server" 
                                                                meta:resourcekey="lblMaxWaitTimeResource1"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:Label ID="Rs_AverageMinWaitingTime" Text="Average Min Waiting Time :" 
                                                                runat="server" meta:resourcekey="Rs_AverageMinWaitingTimeResource1"></asp:Label>
                                                            <asp:Label ID="lblMinWaitTime" runat="server" 
                                                                meta:resourcekey="lblMinWaitTimeResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <asp:Panel ID="pnlWaitingDetails" runat="server" 
                                                                GroupingText="Patient Waiting Details" 
                                                                meta:resourcekey="pnlWaitingDetailsResource1">
                                                                <asp:GridView ID="gvWaitingDetails" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                    Visible="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                                                    CellPadding="3" Font-Names="Verdana" Font-Size="9pt" 
                                                                    meta:resourcekey="gvWaitingDetailsResource1">
                                                                    <RowStyle ForeColor="#000066" />
                                                                    <Columns>
                                                                        <asp:BoundField DataField="PatientName" HeaderText="Patient Name" 
                                                                            meta:resourceKey="BoundFieldResource9">
                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="StartTime" 
                                                                            DataFormatString="{0:dd/MM/yyyy hh:mm tt}" HeaderText="Start Time" 
                                                                            meta:resourceKey="BoundFieldResource10" />
                                                                        <asp:BoundField DataField="EndTime" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" 
                                                                            HeaderText="End Time" meta:resourceKey="BoundFieldResource11" />
                                                                        <asp:BoundField DataField="ElapsedTime" HeaderText="Waiting Time(Mins)" 
                                                                            meta:resourceKey="BoundFieldResource12" />
                                                                    </Columns>
                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                </asp:GridView>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top">
                                                        </td>
                                                        <td align="left" style="text-align: left;">
                                                            <asp:Label ID="Rs_AverageWaitingTime" Text="Average Waiting Time :" 
                                                                runat="server" meta:resourcekey="Rs_AverageWaitingTimeResource1"></asp:Label>
                                                            <asp:Label ID="lblAllWaitTime" runat="server" 
                                                                meta:resourcekey="lblAllWaitTimeResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="dataheader2" align="center">
                            <br />
                            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btn"
                                onmouseover="this.className='btn btnhov'" 
                                onmouseout="this.className='btn'" OnClientClick="return popupprint();" 
                                meta:resourcekey="btnPrintResource1" />
                            <br />
                            <br />
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <%--</script>--%>
    <asp:HiddenField ID="hdnAmtReceivedID" runat="server" />
    </form>
</body>
</html>
