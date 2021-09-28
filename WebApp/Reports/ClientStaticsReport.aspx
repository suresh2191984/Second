<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClientStaticsReport.aspx.cs"
    Inherits="Reports_ClientStaticsReport" Culture="auto" meta:resourcekey="PageResource1" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Client Statics Report</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .dataheader3
        {
            margin-right: 2px;
        }
    </style>
</head>
    <script type="text/javascript" language="javascript">
        function checkDate1(obj) {
            var obj = document.getElementById('<%=txtFromDate.ClientID %>');
            if (obj.value != '') {
                var DOB = obj.value.split('/');
                var calday = DOB[0];
                var calmon = DOB[1];
                var calyear = DOB[2];

                var dateObj = new Date();
                var curday = dateObj.getDate();
                var curmon = dateObj.getMonth() + 1;
                var curyear = dateObj.getFullYear();

                if (parseFloat(calyear) == parseFloat(curyear) && parseFloat(calmon) == parseFloat(curmon) && parseFloat(calday) > parseFloat(curday)) {
                    $("#" + obj.id).val("");
                    alert("Enter date should not be greater than current Date");
                    return false;
                }
                else {
                    return true;
                }
            } 
        }
        function checkDate2(obj) {
            var obj = document.getElementById('<%=txtToDate.ClientID %>');
            if (obj.value != '') {
                var DOB = obj.value.split('/');
                var calday = DOB[0];
                var calmon = DOB[1];
                var calyear = DOB[2];

                var dateObj = new Date();
                var curday = dateObj.getDate();
                var curmon = dateObj.getMonth() + 1;
                var curyear = dateObj.getFullYear();

                if (parseFloat(calyear) == parseFloat(curyear) && parseFloat(calmon) == parseFloat(curmon) && parseFloat(calday) > parseFloat(curday)) {
                    $("#" + obj.id).val("");
                    alert("Enter date should not be greater than current Date");
                    return false;
                }
                else {
                    return true;
                }
            }
        }

        function Validate() {

          
            var fdate = document.getElementById('<%=txtFromDate.ClientID %>');
            var tdate = document.getElementById('<%=txtToDate.ClientID %>');


            var DOB = fdate.value.split('/');
                var calday = DOB[0];
                var calmon = DOB[1];
                var calyear = DOB[2];

                var dateObj = tdate.value.split('/'); ;
                var curday = dateObj[0];
                var curmon = dateObj[1];
                var curyear = dateObj[2];

                if (parseFloat(calyear) > parseFloat(curyear)) {
                    alert("FromDate year should not be greater than ToDate year");
                    return false;
                }
                else {
                    if (parseFloat(calmon) > parseFloat(curmon)) {
                        alert("FromDate month should not be greater than ToDate month");
                        return false;
                    }
                    else {

                        if (parseFloat(calyear) == parseFloat(curyear) && parseFloat(calmon) == parseFloat(curmon) && parseFloat(calday) > parseFloat(curday)) {
                            alert("FromDate date should not be greater than ToDate Date");
                            return false;
                        }

                    }
                }
           
        }
        function ChkSelectType1() {

            var RB1 = document.getElementsByName("rblReportType");

            if (RB1[1].checked == true) {
                //              
            }
            if (RB1[2].checked == true) {
                //               
            }
        }
        function ShowAlertMsg(key) {
            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else {
                alert('No Datas Found');
                return false;
            }

            return true;
        }
        function ClientSelected(source, eventArgs) {

            document.getElementById('hdnClientID').value = eventArgs.get_value();
        }
    </script>

<body>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
  <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata1">
                        <div>
                            <table cellpadding="2" class="dataheader2 defaultfontcolor" cellspacing="1" width="100%">
                                <tr>
                                    <td>
                                        <table width="100%">
                                            <tr>
                                                <td style="width: 11%">
                                                    <asp:Label ID="lblOrg" Text="Organization : " runat="server"></asp:Label>
                                                    <asp:DropDownList ID="ddlOrganization" Width="150px" runat="server" CssClass="ddl"
                                                        AutoPostBack="True">
                                                    </asp:DropDownList>
                                                </td>
                                                <td id="Td1" runat="server" style="width: 15%">
                                                    <asp:Label ID="lblClientName" Text="Client Name" runat="server"></asp:Label>
                                                    <asp:TextBox ID="txtClient" Width="170px" runat="server" CssClass="Txtboxsmall" ToolTip="Enter Client Name"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" TargetControlID="txtClient"
                                                        EnableCaching="False" FirstRowSelected="True" CompletionInterval="1" MinimumPrefixLength="1"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetClientListforSchedule"
                                                        ServicePath="~/WebService.asmx" OnClientItemSelected="ClientSelected" DelimiterCharacters=""
                                                        Enabled="True">
                                                    </ajc:AutoCompleteExtender>
                                                    &nbsp;
                                                    <%--<img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                                </td>
                                                <td style="width: 7%">
                                                    <asp:Panel ID="pnReportType" runat="server" Width="75%" GroupingText="Client Type">
                                                        <asp:DropDownList ID="ddlType" runat="server" CssClass="ddl">
                                                            <asp:ListItem>--Select--</asp:ListItem>
                                                            <asp:ListItem>Credit</asp:ListItem>
                                                            <asp:ListItem>Cash</asp:ListItem>                                                            
                                                        </asp:DropDownList>
                                                    </asp:Panel>
                                                </td>
                                                <td style="width: 17%">
                                                    <asp:Label ID="lbfrom" runat="server" Text="From :" meta:resourcekey="lbfromResource1"></asp:Label>
                                                    <asp:TextBox runat="server" ID="txtFromDate" MaxLength="10" Width="150px" size="25"
                                                        CssClass="Txtboxsmall" onblur="javascript:return checkDate1(this);" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                                    &nbsp;<asp:Image runat="server" ID="ImgBntCalc" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                        Width="16px" Style="vertical-align: bottom;" Height="16px" border="0" alt="Pick from date"
                                                        meta:resourcekey="ImgBntCalcResource1" />
                                                    <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc"
                                                        TargetControlID="txtFromDate" Enabled="True" OnClientDateSelectionChanged="checkDate1" />
                                                </td>
                                                <td style="width: 15%">
                                                    <asp:Label ID="lbto" runat="server" Text="To :" meta:resourcekey="lbtoResource1"></asp:Label>
                                                    <asp:TextBox runat="server" ID="txtToDate" MaxLength="10" Width="150px" CssClass="Txtboxsmall"
                                                       onblur="javascript:return checkDate2(this);" meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                                    &nbsp;<asp:Image runat="server" ID="ImgToDate" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                        Width="16px" Height="16px" Style="vertical-align: bottom;" AlternateText="Pick to date"
                                                        meta:resourcekey="ImgToDateResource1" />
                                                    <ajc:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgToDate"
                                                        TargetControlID="txtToDate" Enabled="True" OnClientDateSelectionChanged="checkDate2"/>
                                                </td>
                                                 <td width="13%">
                                                    <asp:Panel ID="Panel1" Width="100%" GroupingText="Report Type" runat="server">
                                                        <asp:RadioButtonList ID="rblReportType" RepeatDirection="Horizontal" runat="server"
                                                            meta:resourcekey="rblReportTypeResource1" onclick="javascript:ChkSelectType1();">
                                                            <asp:ListItem Text="Summary" Selected="True" Value="0" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                            <asp:ListItem Text="Detail" Value="1" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </asp:Panel>
                                                </td>
                                                <td style="width: 3%">
                                                    <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                                </td>
                                                <td style="width: 3%">
                                                    <asp:Button runat="server" ID="btnGo" Text=" Go " CssClass="btn" TabIndex="6" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClick="btnGo_Click" OnClientClick="javascript:return Validate()"/>
                                                </td>
                                                <td style="width: 3%">
                                                    &nbsp;
                                                    <asp:Button ID="btnCancel" runat="server" Text="Reset" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                                                        onmouseout="this.className='btn1'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1"
                                                        Visible="false" />
                                                </td>
                                                <td style="width: 3%">
                                                    <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click"
                                                        meta:resourcekey="lnkBackResource1">Back&nbsp;&nbsp;&nbsp;
                                                    </asp:LinkButton>
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
                                                    <td>
                                                        <asp:Button ID="btnPrintAll" runat="server" Text="Print Report" OnClick="PrintAllPages" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td valign="top" class="dataheader2" nowrap="nowrap">
                                                        <asp:GridView ID="grdResult" runat="server" AllowPaging="true" PageSize="20" OnPageIndexChanging="grdResult_PageIndexChanging"
                                                            ShowFooter="True" OnRowDataBound="grdResult_RowDataBound" EmptyDataText="No Results Found."
                                                            AutoGenerateColumns="False" CellPadding="4" CssClass="mytable1" Width="100%">
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <RowStyle HorizontalAlign="Left" Font-Size="10px" />
                                                            <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                                PageButtonCount="5" PreviousPageText="" />
                                                            <Columns>
                                                                <%--  <asp:BoundField DataField="CreatedBy" HeaderText="User ID" FooterStyle-CssClass="dataheader1"></asp:BoundField> --%>
                                                                <asp:TemplateField HeaderText="Sl No." FooterStyle-Font-Bold="true" FooterStyle-CssClass="dataheader1"
                                                                    meta:resourcekey="TemplateFieldResource15">
                                                                    <ItemTemplate>
                                                                        <%#Container.DataItemIndex+1 %>
                                                                    </ItemTemplate>
                                                                    <FooterStyle CssClass="dataheader1" Font-Bold="True"></FooterStyle>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="Client Name" HeaderText="Client Name" FooterStyle-CssClass="dataheader1">
                                                                    <FooterStyle CssClass="dataheader1"></FooterStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Bill Date" HeaderText="Bill Date" FooterText="Grand Total"
                                                                    FooterStyle-CssClass="dataheader1">
                                                                    <FooterStyle CssClass="dataheader1"></FooterStyle>
                                                                </asp:BoundField>
                                                                <asp:TemplateField HeaderText="Gross BillValue" FooterStyle-Font-Bold="true" FooterStyle-CssClass="dataheader1">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblUserGross" Text='<%# Eval("GrossBillValue") %>' runat="server"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <FooterTemplate>
                                                                        <asp:Label ID="lblCrossValue" Text="0.00" runat="server"></asp:Label>
                                                                    </FooterTemplate>
                                                                    <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Left"></FooterStyle>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Net Value" FooterStyle-Font-Bold="true" FooterStyle-CssClass="dataheader1">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblUserNet" Text='<%# Eval("Net Value") %>' runat="server"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <FooterTemplate>
                                                                        <asp:Label ID="lblNetValue" Text="0.00" runat="server"></asp:Label>
                                                                    </FooterTemplate>
                                                                    <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Left"></FooterStyle>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Discount Value" FooterStyle-Font-Bold="true" FooterStyle-CssClass="dataheader1">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblUserDiscount" Text='<%# Eval("Discount Amount") %>' runat="server"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <FooterTemplate>
                                                                        <asp:Label ID="lblDiscount" Text="0.00" runat="server"></asp:Label>
                                                                    </FooterTemplate>
                                                                    <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Left"></FooterStyle>
                                                                </asp:TemplateField>
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
                        <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
                    </div>

 <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </div>
    </form>
</body>
</html>
