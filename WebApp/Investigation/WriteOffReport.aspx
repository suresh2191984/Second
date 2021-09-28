<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WriteOffReport.aspx.cs" Inherits="Investigation_WriteOffReport" %>

<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/TaskEscalation.ascx" TagName="TaskEscalation"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Write-Off Report</title>

<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script type="text/javascript">
        function SelectedPatientID(source, eventArgs) {
            document.getElementById('hdnSelectedPatientID').value = eventArgs.get_value().split('~')[2];
        }
        function SelectedClientID(source, eventArgs) {
            document.getElementById('hdnSelectedClientID').value = eventArgs.get_value();
        }
        function alpha(e) {
            var k;
            document.all ? k = e.keyCode : k = e.which;
            return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || k == 46 || (k >= 48 && k <= 57));
        }
        function popupprint() {
            var prtContent = "";
            if (document.getElementById('ddlWriteOffType').value == "Billing") {
                prtContent = document.getElementById('pnlWriteOffBillingReport');
            }
            else {
                prtContent = document.getElementById('pnlWriteoffInvoiceReport');
            }
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            // WinPrint.close();
        }
        function ShowDetails(obj) {
            if (document.getElementById(obj).value == "Billing") {
                document.getElementById('txtClient').value = "";
                document.getElementById('hdnSelectedPatientID').value = "0";
                document.getElementById('tblPatient').style.display = "block";
                document.getElementById('tblPatientName').style.display = "block";
                document.getElementById('tblClientTypeName').style.display = "none";
                document.getElementById('tblClientType').style.display = "none";
                document.getElementById('tblClient').style.display = "none";
                document.getElementById('tblClientName').style.display = "none";
            }
            else {
                document.getElementById('txtName').value = "";
                document.getElementById('hdnSelectedPatientID').value = "0";
                document.getElementById('tblPatient').style.display = "none";
                document.getElementById('tblPatientName').style.display = "none";
                document.getElementById('tblClientTypeName').style.display = "block";
                document.getElementById('tblClientType').style.display = "block";
                document.getElementById('tblClient').style.display = "block";
                document.getElementById('tblClientName').style.display = "block";
            }
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
                <div style="float: left; width: 4%;">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div style="float: left; width: 87.8%;">
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
                <td width="100%" valign="top" class="tdspace">
                    <span>&nbsp;</span>
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
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <table id="Table1" cellpadding="0" cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td>
                                            <div class="dataheaderWider">
                                                <asp:Panel ID="pnlWriteOffDetail" runat="server" GroupingText="">
                                                    <table id="tblWriteOffReport" runat="server" width="85%" cellpadding="2" cellspacing="2"
                                                        border="0">
                                                        <tr id="Tr1" runat="server">
                                                            <td id="Td10" runat="server">
                                                                <asp:Label ID="lblOrganisation" Text="Organisation : " Font-Bold="false" runat="server"></asp:Label>
                                                            </td>
                                                            <td id="Td11" runat="server">
                                                                <asp:DropDownList ID="ddlOrganization" Width="120px" runat="server" CssClass="ddl"
                                                                    OnSelectedIndexChanged="ddlOrganization_SelectedIndexChanged" AutoPostBack="True">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td id="Td5" runat="server" align="right">
                                                                <asp:Label ID="lblLocation" Text="Location : " Font-Bold="false" runat="server"></asp:Label>
                                                            </td>
                                                            <td id="Td6" runat="server">
                                                                <asp:DropDownList ID="drpLocation" Width="120px" runat="server" CssClass="ddl">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td id="Td1" runat="server" align="right">
                                                                <asp:Label ID="lblFromDate" runat="server" Font-Bold="false" Font-Size="Small" Text="From date : "></asp:Label>
                                                            </td>
                                                            <td id="Td2" runat="server">
                                                                <asp:TextBox runat="server" Width="70px" size="25" CssClass="Txtboxsmall" ID="txtFromDate"
                                                                    MaxLength="10"></asp:TextBox>
                                                                <cc1:MaskedEditExtender ID="MaskedEditExtender" runat="server" TargetControlID="txtFromDate"
                                                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                    CultureTimePlaceholder="" Enabled="True" />
                                                                <cc1:CalendarExtender ID="CalendarExtender" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFromDate"
                                                                    PopupButtonID="ImgBntCalc" Enabled="True" />
                                                            </td>
                                                            <td id="Td3" runat="server" align="right">
                                                                <asp:Label ID="lblToDate" runat="server" Font-Bold="false" Font-Size="Small" Text="To date : "></asp:Label>
                                                            </td>
                                                            <td id="Td4" runat="server">
                                                                <asp:TextBox ID="txtToDate" Width="70px" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                                                <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtToDate"
                                                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                    CultureTimePlaceholder="" Enabled="True" />
                                                                <cc1:CalendarExtender ID="CalendarExtender3" Format="dd/MM/yyyy" runat="server" TargetControlID="txtToDate"
                                                                    PopupButtonID="ImgBntCalc" Enabled="True" />
                                                            </td>
                                                            <td id="Td8" runat="server" align="right">
                                                                <asp:Label ID="lblWriteOff" Text="WriteOff Type : " Font-Bold="false" runat="server"></asp:Label>
                                                            </td>
                                                            <td id="Td7" runat="server">
                                                                <asp:DropDownList ID="ddlWriteOffType" onchange="ShowDetails(this.id);" Width="120px"
                                                                    runat="server" CssClass="ddl">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr style="width: 100%;">
                                                            <td id="tblPatient">
                                                                <asp:Label ID="lblName" Text="Patient Name : " Font-Bold="false" runat="server"></asp:Label>
                                                            </td>
                                                            <td align="left" id="tblPatientName">
                                                                <asp:TextBox ID="txtName"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" onblur="javascript:ClearValue(this.id);ConverttoUpperCase(this.id);"
                                                                    autocomplete="off" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtenderPatient" MinimumPrefixLength="2"
                                                                    runat="server" TargetControlID="txtName" ServiceMethod="GetLabQuickBillPatientList"
                                                                    ServicePath="~/OPIPBilling.asmx" EnableCaching="False" BehaviorID="AutoCompleteExLstGrp1"
                                                                    CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                                                    OnClientItemSelected="SelectedPatientID" Enabled="True">
                                                                </cc1:AutoCompleteExtender>
                                                            </td>
                                                            <td id="tblClientTypeName" style="display: none;">
                                                                <asp:Label ID="lblClientType" Font-Bold="false" runat="server" Text="Client type : "></asp:Label>
                                                            </td>
                                                            <td id="tblClientType" style="display: none;">
                                                                <asp:DropDownList ID="ddlClientType" Width="120px" runat="server" CssClass="ddl">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td align="center" id="tblClient" style="display: none;">
                                                                <asp:Label ID="lblClient" Style="display: block;" Text="Client Name : " Font-Bold="false"
                                                                    runat="server"></asp:Label>
                                                            </td>
                                                            <td id="tblClientName" style="display: none;">
                                                                <asp:TextBox ID="txtClient" onfocus="setContextValue();" Style="display: block;"
                                                                      OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" onblur="javascript:ClearValue(this.id);ConverttoUpperCase(this.id);"
                                                                    autocomplete="off" CssClass="Txtboxsmall" runat="server" Width="120px"></asp:TextBox>
                                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtenderClient" runat="server" TargetControlID="txtClient"
                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                    MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetClientList"
                                                                    OnClientItemSelected="SelectedClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                                    Enabled="True">
                                                                </cc1:AutoCompleteExtender>
                                                            </td>
                                                            <td colspan="0">
                                                                &nbsp;&nbsp;
                                                                <asp:Button ID="btnSearch" runat="server" CssClass="btn" OnClick="btnSearch_Click"
                                                                    onmouseout="this.className='btn'" onmouseover="this.className='btn1 btnhov'"
                                                                    Text="Search" />
                                                            </td>
                                                            <td colspan="3" style="width: 10%;" align="left" valign="top">
                                                                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click">Back&nbsp;&nbsp;&nbsp;</asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <table width="100%" runat="server">
                                    <tr>
                                        <td align="center">
                                            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                                <ProgressTemplate>
                                                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                                                    Please wait....
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td width="100%" runat="server">
                                            <div id="divWriteOffReport" runat="server">
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tr runat="server">
                                                        <td runat="server">
                                                            <div id="divPrintReport" style="display: none;" runat="server">
                                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                    <tr align="right">
                                                                        <td id="td19" style="padding-right: 10px; width: 85%; color: #000000;" runat="server"
                                                                            visible="true" align="right">
                                                                            <asp:Label ID="lblExcelReport" Text="Excel Report" Font-Bold="True" ForeColor="#000333"
                                                                                runat="server"></asp:Label>
                                                                            <asp:ImageButton ID="imgbtnExportToExcel" runat="server" ImageUrl="~/Images/ExcelImage.GIF"
                                                                                OnClick="imgbtnExportToExcel_Click" />
                                                                        </td>
                                                                        <td align="right" style="padding-right: 10px; width: 15%; color: #000000;">
                                                                            <b id="B2" runat="server">Print Report</b> &nbsp;&nbsp;
                                                                            <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/Images/printer.gif"
                                                                                OnClientClick="return popupprint();" ToolTip="Print" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr runat="server">
                                                        <td runat="server">
                                                            <asp:Panel ID="pnlWriteOffBillingReport" Style="display: block;" runat="server">
                                                                <table width="100%">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:GridView ID="grdWriteOffBillingReport" runat="server" AutoGenerateColumns="False"
                                                                                AllowPaging="True" PageSize="20" CellPadding="1" EmptyDataText="Details Not Available"
                                                                                Font-Names="verdana" Font-Size="11px" ShowFooter="True" Width="100%">
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="S.No" ItemStyle-Width="3%">
                                                                                        <ItemTemplate>
                                                                                            <%# Container.DataItemIndex + 1 %>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="3%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Patient name" ItemStyle-Width="15%">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblPatientName" Width="220px" runat="server" Text='<%# Eval("PatientName") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="15%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Patient number" ItemStyle-Width="5%">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblPatientNumber" Width="120px" runat="server" Text='<%# Eval("PatientNumber") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Visit ID" ItemStyle-Width="5%">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblVisitID" Width="100px" runat="server" Text='<%# Eval("VisitID") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Bill number" ItemStyle-Width="13%">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblBillNumber" Width="150px" runat="server" Text='<%# Eval("BillNo") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="15%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Due date" ItemStyle-Width="15%">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblDueBillDate" Width="170px" runat="server" Text='<%# Bind("DueBillDate","{0:D}")%>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="15%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Net Value" ItemStyle-Width="8%">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblNetValue" runat="server" Text='<%# Eval("NetValue") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="8%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Paid amount" ItemStyle-Width="8%">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblPaidAmount" runat="server" Text='<%# Eval("DuePaidAmt") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="8%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="WriteOff amt" ItemStyle-Width="10%">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblWriteOffAmt" runat="server" Text='<%# Eval("WriteOffAmt") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="8%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="User name" ItemStyle-Width="18%">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblUserName" runat="server" Text='<%# Eval("UserName") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="20%" />
                                                                                    </asp:TemplateField>
                                                                                </Columns>
                                                                                <FooterStyle CssClass="dataheader1" HorizontalAlign="Right" Height="15px" />
                                                                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                                                <HeaderStyle CssClass="dataheader1" Height="15px" />
                                                                            </asp:GridView>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                    <tr runat="server">
                                                        <td runat="server">
                                                            <asp:Panel ID="pnlWriteoffInvoiceReport" Style="display: block;" runat="server">
                                                                <table width="100%">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:GridView ID="grdWriteoffInvoiceReport" runat="server" AutoGenerateColumns="False"
                                                                                AllowPaging="True" PageSize="20" CellPadding="1" EmptyDataText="Details Not Available"
                                                                                Font-Names="verdana" Font-Size="11px" ShowFooter="True" Width="100%">
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="S.No">
                                                                                        <ItemTemplate>
                                                                                            <%# Container.DataItemIndex + 1 %>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="2%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Invoice number">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblInvoiceNo" runat="server" Text='<%# Eval("InvoiceNo") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="2%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Client name">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblClientName" Width="250px" runat="server" Text='<%# Eval("ClientName") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="3%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Receipt date">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblReceiptDate" runat="server" Text='<%# Bind("ReceiptDate","{0:D}") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="4%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Invoice amount">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblInvoiceAmount" runat="server" Text='<%# Eval("InvoiceAmount") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="3%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Received amount">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblReceivedAmount" runat="server" Text='<%# Eval("ReceivedAmount") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="3%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="WriteOff amt">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblWriteOffAmt" runat="server" Text='<%# Eval("WriteOffAmt") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="3%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Reason">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblWriteOffReason" Width="250px" runat="server" Text='<%# Eval("WriteOffReason") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="3%" />
                                                                                    </asp:TemplateField>
                                                                                </Columns>
                                                                                <FooterStyle CssClass="dataheader1" HorizontalAlign="Right" Height="25px" />
                                                                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                                                <HeaderStyle CssClass="dataheader1" Height="25px" />
                                                                            </asp:GridView>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <asp:HiddenField ID="hdnSelectedPatientID" runat="server" Value="0" />
                                <asp:HiddenField ID="hdnSelectedClientID" runat="server" Value="0" />
                            </ContentTemplate>
                            <Triggers>
                                <asp:PostBackTrigger ControlID="imgbtnExportToExcel" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>

<script type="text/javascript">
    function setContextValue() {
        var sval = document.getElementById('ddlClientType').value + "^" + document.getElementById('ddlOrganization').value;
        $find('AutoCompleteExtenderClient').set_contextKey(sval);
        return false;
    }
    function ClearValue(obj) {
        if (document.getElementById(obj).value == "") {
            document.getElementById('hdnSelectedClientID').value = "0";
            document.getElementById('hdnSelectedPatientID').value = "0";
        }
    }
</script>

</html>
