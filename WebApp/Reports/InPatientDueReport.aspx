<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InPatientDueReport.aspx.cs"
    Inherits="Reports_InPatientDueReport" %>

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
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table id="tblCollectionOPIP" align="center" width="100%">
                            <tr align="center">
                                <td align="left">
                                    <div class="dataheaderWider">
                                        <table id="tbl">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Rs_FromDate" Text="From Date:" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                    <asp:TextBox ID="txtFDate" runat="server" CssClass ="Txtboxsmall" Width ="120px" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                        PopupButtonID="ImgFDate" Enabled="True" />
                                                    <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" meta:resourcekey="ImgFDateResource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFDate"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                        CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                        ControlToValidate="txtFDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                    <asp:TextBox ID="txtTDate" runat="server" CssClass ="Txtboxsmall" Width ="120px" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                    <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                                        PopupButtonID="ImgTDate" Enabled="True" />
                                                    <asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" meta:resourcekey="ImgTDateResource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTDate"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                        CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                        ControlToValidate="txtTDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                </td>
                                                <td align="left">
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table border="1">
                                                        <tr>
                                                            <td>
                                                                <asp:RadioButtonList ID="Rbltypeofpatient" RepeatDirection="Horizontal" runat="server"
                                                                    meta:resourcekey="rblReportTypeResource1">
                                                                    <asp:ListItem Text="Cash" Value="N" Selected="True"></asp:ListItem>
                                                                    <asp:ListItem Text="Credit" Value="Y"></asp:ListItem>
                                                                    <asp:ListItem Text="Cash & Credit" Value="B"></asp:ListItem>
                                                                    <%-- <asp:ListItem Text="Credit&Cash" Value="Creditandcash"></asp:ListItem>--%>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                        OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                                </td>
                                                <td>
                                                    <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" Style="width: 16px" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server" CssClass="details_label_age"
                                                        OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <asp:UpdateProgress ID="Progressbar" runat="server">
                                        <ProgressTemplate>
                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                            <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                    <div id="divPrint" style="display: none;" runat="server">
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td align="right" style="padding-right: 10px; color: #000000;">
                                                    <b id="printText" runat="server">
                                                        <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>
                                                    <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                        ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                                        <ContentTemplate>
                                            <div id="divOPDWCR" runat="server">
                                                <div id="prnReport">
                                                    <table cellpadding="2" class="defaultfontcolor" style="color: Black; font-family: Verdana;
                                                        text-align: left;" cellspacing="1" width="100%">
                                                        <tr>
                                                            <td valign="top" class="dataheader2" nowrap="nowrap">
                                                                <asp:GridView ID="gvIPCreditMain" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                    ForeColor="#333333" ShowFooter="True" CssClass="mytable1" GridLines="Both" OnRowDataBound="gvIPCreditMain_RowDataBound">
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                    <RowStyle HorizontalAlign="Left" Font-Size="10px" />
                                                                    <Columns>
                                                                        <asp:TemplateField Visible="false" ItemStyle-Width="8%" HeaderText="S.No">
                                                                            <ItemTemplate>
                                                                                <%# Container.DataItemIndex + 1 %>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="PatientName" HeaderText="Name" />
                                                                        <asp:BoundField DataField="PatientNumber" HeaderText="Patient No" />
                                                                         <asp:TemplateField HeaderText="IP No">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblIPNummber" runat="server" Text='<%#Bind("IPNumber")%>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="Age" HeaderText="Age/Sex" />
                                                                        <asp:BoundField DataField="BillNumber" HeaderText="Bill No" />
                                                                        <asp:TemplateField HeaderText="DOA">
                                                                            <ItemTemplate>
                                                                                <%# GetDate(DataBinder.Eval(Container.DataItem, "DateofAdmission", "{0:dd/MM/yyyy}").ToString())%>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="BedName" HeaderText="Room/Bed No" />
                                                                        <asp:BoundField DataField="PhysicianName" HeaderText="Primary Physician" />
                                                                        <asp:BoundField DataField="IsCreditBill" HeaderText="Credit Bill" />
                                                                        <asp:BoundField DataField="ActualBilled" HeaderText="Gross Amt">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Pharmacy" HeaderText="Pharmacy Bill Amt">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="BillAmount" HeaderText="Hospital Bill Amt">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="PRMReceived" HeaderText="Pharmacy Collected Amt">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="HOSReceived" HeaderText="Hospital Collected Amt">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="PRMRefund" HeaderText="Pharmacy Refund Amt">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="HOSRefund" HeaderText="Hospital Refund Amt">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="AmountReceived" HeaderText="Total Collected Amt">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Due" HeaderText="Due">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                    </Columns>
                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                    <FooterStyle Font-Bold="true" Font-Size="small" HorizontalAlign="Right" />
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                        <tr id="GrdFooter" runat="server" style="display: none" class="dataheaderInvCtrl">
                                                            <td align="center" colspan="10" class="defaultfontcolor">
                                                                <asp:Label ID="Label1" runat="server" Text="Page"></asp:Label>
                                                                <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                                                <asp:Label ID="Label2" runat="server" Text="Of"></asp:Label>
                                                                <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label>
                                                                <asp:Button ID="btnPrevious" runat="server" Text="Previous" CssClass="btn" OnClick="btnPrevious_Click" />
                                                                <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn" OnClick="btnNext_Click" />
                                                                <asp:HiddenField ID="hdnCurrent" runat="server" />
                                                                <asp:Label ID="Label3" runat="server" Text="Enter The Page To Go:"></asp:Label>
                                                                <asp:TextBox ID="txtpageNo" runat="server" CssClass="Txtboxverysmall"  Width ="30px" Height ="20px"   onkeypress="return ValidateOnlyNumeric(this);"  ></asp:TextBox>
                                                                <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" OnClick="btnGo_Click" />
                                                                <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                                                            </td>
                                                        </tr>
                                                    </table>
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
