<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChequeDDStmt.aspx.cs" Inherits="Reports_ChequeDDStmt" %>

<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
       <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <style type="text/css">
        .grd
        {
            text-align: right;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function validateToDate() {

            if (document.getElementById('txtFDate').value == '') {
                alert('Provide / select value for From date');
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                alert('Provide / select value for To date');
                document.getElementById('txtTDate').focus();
                return false;
            }
        }
        function popupprint() {
            var prtContent = document.getElementById('prnReport');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="RHead" runat="server" />
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
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table id="tblCollectionOPIP" align="center" width="100%">
                            <tr align="center">
                                <td align="center">
                                    <div class="dataheaderWider">
                                        <table id="tbl">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Rs_FromDate" Text="From Date:" runat="server" 
                                                        meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                    <asp:TextBox ID="txtFDate"  CssClass ="Txtboxsmall" Width ="120px" runat="server"></asp:TextBox>
                                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                        PopupButtonID="ImgFDate" Enabled="True" />
                                                    <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" meta:resourcekey="ImgFDateResource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFDate"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                        ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                        CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                        ControlToValidate="txtFDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" 
                                                        meta:resourcekey="MaskedEditValidator5Resource1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server" 
                                                        meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                    <asp:TextBox ID="txtTDate" runat="server" CssClass ="Txtboxsmall" Width ="120px"></asp:TextBox>
                                                    <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                                        PopupButtonID="ImgTDate" Enabled="True" />
                                                    <asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" meta:resourcekey="ImgTDateResource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTDate"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                        ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                        CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                        ControlToValidate="txtTDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" 
                                                        meta:resourcekey="MaskedEditValidator1Resource1" />
                                                </td>
                                                <td>
                                                    <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" 
                                                        runat="server" meta:resourcekey="rblVisitTypeResource1">
                                                        <asp:ListItem Text="OP" Selected="True" Value="0" 
                                                            meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                        <asp:ListItem Text="IP" Value="1" ></asp:ListItem>
                                                        <asp:ListItem Text="OP&IP" Value="-1"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    <asp:RadioButtonList ID="rblReportType" RepeatDirection="Horizontal" 
                                                        runat="server" >
                                                        <asp:ListItem Text="Summary" Selected="True" Value="0" 
                                                           ></asp:ListItem>
                                                        <asp:ListItem Text="Detail" Value="1" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                        OnClick="btnSubmit_Click" />
                                                </td>
                                                <td>
                                                    <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" Style="width: 16px" OnClick="imgBtnXL_Click" 
                                                        />
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server" 
                                                        CssClass="details_label_age" OnClick="lnkBack_Click" 
                                                        ></asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <asp:UpdateProgress ID="Progressbar" runat="server">
                                        <ProgressTemplate>
                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" 
                                                 />
                                            <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" 
                                                ></asp:Label>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                    <div id="divPrint" style="display: none;" runat="server">
                                        <table cellpadding="0" cellspacing="0" border="0" width="95%">
                                            <tr>
                                                <td align="right" style="padding-right: 10px; color: #000000;">
                                                    <b id="printText" runat="server"><asp:Label ID="Rs_PrintReport" 
                                                        Text="Print Report" runat="server" ></asp:Label></b>
                                                    <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                        ToolTip="Print"  />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                                        <ContentTemplate>
                                            <div id="divOPDWCR" runat="server" style="display: none;">
                                                <div id="prnReport">
                                                    <asp:GridView ID="gvIPReport" runat="server" AutoGenerateColumns="False" Visible="False"
                                                        Width="100%" OnRowDataBound="gvIPReport_RowDataBound" 
                                                        >
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Collection Report" 
                                                                meta:resourcekey="TemplateFieldResource1">
                                                                <ItemTemplate>
                                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                        <tr>
                                                                            <td align="left" style="height: 25px;">
                                                                                <b><asp:Label ID="Rs_Date" Text="Date:" runat="server" 
                                                                                    meta:resourcekey="Rs_DateResource1"></asp:Label></b>
                                                                                <%# DataBinder.Eval(Container.DataItem, "VisitDate", "{0:dd/MM/yyyy}")%>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:GridView ID="gvIPCreditMain" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                                    ForeColor="#333333" CssClass="mytable1" 
                                                                                    OnRowDataBound="gvIPCreditMain_RowDataBound" 
                                                                                   >
                                                                                    <Columns>
                                                                                        <asp:BoundField DataField="PatientNumber" HeaderText="Patient No" 
                                                                                             >
                                                                                            <ItemStyle Width="25px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="PatientName" HeaderText="Name" 
                                                                                            >
                                                                                            <ItemStyle HorizontalAlign="Left" Wrap="False" Width="180px"></ItemStyle>
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="CreditorDebitCard" HeaderText="Bank/Card Name" 
                                                                                            >
                                                                                            <ItemStyle HorizontalAlign="Left" Wrap="False" Width="180px"></ItemStyle>
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="Age"
                                                                                            HeaderText="Age">
                                                                                            <ItemStyle HorizontalAlign="Left" Wrap="False" Width="80px"></ItemStyle>
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="FinalBillID" HeaderText="Bill No" 
                                                                                             >
                                                                                            <ItemStyle Width="25px" />
                                                                                        </asp:BoundField>
                                                                                        
                                                                                        <asp:BoundField DataField="ReceiptNO" HeaderText="Receipt No" />
                                                                                        
                                                                                        
                                                                                        <asp:BoundField DataField="VisitType" HeaderText="Visit" 
                                                                                             >
                                                                                            <ItemStyle Width="25px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="ReceivedAmount" HeaderText="Rcvd Amount" 
                                                                                             >
                                                                                            <HeaderStyle Width="60px" />
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="ServiceCharge" 
                                                                                            HeaderText="Credit/Debit Card Charge (%)" 
                                                                                             >
                                                                                            <HeaderStyle Width="30px" />
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                    </Columns>
                                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                                    <PagerStyle BackColor="White" ForeColor="#000066" />
                                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                                </asp:GridView>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <br />
                                                    <div id="breakup" runat="server">
                                                        <table border="0" id="tabGranTotal1" runat="server" visible="False" class="dataheaderWider"
                                                            cellpadding="0" style="color: #000000;" cellspacing="0" width="100%">
                                                            <tr id="Tr1" runat="server">
                                                                <td id="Td1" align="right" width="60%" runat="server">
                                                                    
                                                                   <asp:Label ID="Rs_TotalCardAmount" Text="Total Cheque and DD Amount" runat="server"></asp:Label>
                                                                    <label id="Label1" style="color: Green;" runat="server">
                                                                        (A)</label> :
                                                                </td>
                                                                <td id="Td2" align="right" width="20%" runat="server">
                                                                    <label id="lblCardTotal" runat="server">
                                                                    </label>
                                                                </td>
                                                                <td id="Td3" align="right" runat="server">
                                                                </td>
                                                            </tr>
                                                            <tr id="Tr2" runat="server">
                                                                <td id="Td4" align="right" width="60%" runat="server">
                                                                    <asp:Label ID="Rs_TotalServiceCharge" Text="Total Service Charge" runat="server"></asp:Label>
                                                                    <label id="Label5" style="color: Green;" runat="server">
                                                                        (B)</label> :
                                                                </td>
                                                                <td id="Td5" align="right" runat="server">
                                                                </td>
                                                                <td id="Td6" align="right" width="20%" runat="server">
                                                                    <label id="lblServiceCharge" runat="server">
                                                                    </label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>