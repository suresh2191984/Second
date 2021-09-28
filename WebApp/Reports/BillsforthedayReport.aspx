<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillsforthedayReport.aspx.cs"
    Inherits="Reports_BillsforthedayReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Bills for the day Report</title>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script language="javascript" type="text/javascript">

        function CheckEmpty() {
            var Check = document.getElementById("txtMailAddress").value;
            if (Check == "") {
                alert("Enter Email Address");
                return false;
            }
            return true;

        }
        function getCountryID() {
            document.getElementById("txtClient").value = "";
            var e = document.getElementById("ddlCountry");
            var ddlCountry = e.options[e.selectedIndex].value;
            if (ddlCountry == "--Select--") {
                document.getElementById("hdnCountryID").value = 0;
            }
            else {
                document.getElementById("hdnCountryID").value = ddlCountry;
            }
        }

        function CheckSearch() {
            if (document.getElementById('txtFrom').value == '') {
                alert('Select From Date');
                document.getElementById('txtFrom').focus();
                return false;
            }
            if (document.getElementById('txtTo').value == '') {
                alert('Select To Date');
                document.getElementById('txtTo').focus();
                return false;
            }

        }

        function ShowColumns(obj) {
            $("#pnlColumns").slideToggle("slow");
            $("#lnkBtnSaveTemplate").slideToggle("slow");
            if (obj.value != "Hide") {
                obj.value = "Hide";
            }
            else {
                obj.value = "Show";
            }
        }

        function ItemClientSelected(source, eventArgs) {

            var ClientCorpID;
            var list = eventArgs.get_value().split('^');
            ClientCorpID = list[0];
            document.getElementById('hdnSelectedClientID').value = ClientCorpID;

        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="updatePanel1" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter">
                        </div>
                        <div align="center" id="processMessage" width="60%">
                            <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" />
                            <br />
                            <br />
                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <div class="dataheaderWider">
                    <table class="w-100p searchPanel" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <asp:Label ID="lblFrom" Text="From" runat="server"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox Width="125px" ID="txtFrom" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                <a href="javascript:NewCssCal('<% =txtFrom.ClientID %>','ddmmyyyy','arrow',true,12,'Y','N','Y')">
                                    <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                            </td>
                            <td>
                                <asp:Label ID="lblTo" Text="To" runat="server"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtTo" Width="125px" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                <a href="javascript:NewCssCal('<% =txtTo.ClientID %>','ddmmyyyy','arrow',true,12,'Y','N','Y')">
                                    <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                            </td>
                            <td>
                                <asp:Label ID="lblCountry" Text="Select Country" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlCountry" runat="server" onchange="getCountryID();" OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged"
                                    AutoPostBack="true">
                                </asp:DropDownList>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_ClientName" runat="server" Text="Client Name"></asp:Label>
                            </td>
                            <td id="tdClientParttxt" runat="server">
                                <asp:TextBox ID="txtClient" runat="server" autocomplete="off" Width="200px" CssClass="AutoCompletesearchBox"></asp:TextBox>
                                <cc1:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" CompletionInterval="1"
                                    CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                    Enabled="True" FirstRowSelected="True" MinimumPrefixLength="3" OnClientItemSelected="ItemClientSelected"
                                    UseContextKey="true" ServiceMethod="GetCountryWiseClientNames" ServicePath="~/Webservice.asmx"
                                    TargetControlID="txtClient">
                                </cc1:AutoCompleteExtender>
                            </td>
                            <td>
                                <asp:Button ID="btnSearch" runat="server" CssClass="btn" OnClick="btnSearch_Click"
                                    OnClientClick="return CheckSearch();" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                    Text="Test Wise" />
                                &nbsp;
                            </td>
                            <td>
                                <asp:Button ID="btnClientSearch" runat="server" CssClass="btn" OnClientClick="return CheckSearch();"
                                    onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Client Wise"
                                    OnClick="btnClientSearch_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;&nbsp;&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="right" colspan="10">
                                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="details_label_age" Text="Back"
                                    OnClick="lnkBack_Click"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="divPrint1" style="display: none;" runat="server">
                    <table cellpadding="0" cellspacing="0" border="0" class="w-100p">
                        <tr align="right">
                            <td id="tdexcel" style="padding-right: 10px; color: #000000;" runat="server">
                                <asp:Label ID="lbExcel" Text="Excel Report" Font-Bold="True" ForeColor="#000333"
                                    runat="server" meta:resourcekey="lbExcelResource1"></asp:Label>
                                <asp:ImageButton ID="btnConverttoXL" OnClick="btnConverttoXL_Click" runat="server"
                                    ImageUrl="~/Images/ExcelImage.GIF" Visible="false" />
                                &nbsp;&nbsp;
                                <asp:ImageButton ID="btnConverttoClientXL" OnClick="btnConverttoClientXL_Click" runat="server"
                                    ImageUrl="~/Images/ExcelImage.GIF" Visible="false" />
                                <b id="B1" runat="server">
                                    <asp:Label ID="Rs_PrintReport" Visible="false" Text="Print Report" runat="server"
                                        meta:resourcekey="Rs_PrintReportResource1"></asp:Label>
                                </b>
                                <asp:Button ID="btnPrintAll" runat="server" Text="Print" CssClass="btn" Visible="false"
                                    OnClick="btnPrintAll_Click" />
                                <asp:Button ID="btnPrintAllClient" runat="server" Text="Print" CssClass="btn" Visible="false"
                                    OnClick="btnPrintAllClient_Click" />
                                &nbsp;&nbsp;
                                <asp:Button ID="btnSendmail" runat="server" Text="Send Mail" CssClass="btn" OnClick="btnSendmail_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
                <asp:Panel ID="pnl" runat="server" ScrollBars="Vertical" Style="width: 60%; height: 500px;"
                    Visible="false">
                    <asp:GridView ID="grdResult" AlternatingRowStyle-CssClass="trEven" runat="server"
                        CellPadding="4" AutoGenerateColumns="False" DataKeyNames="FeeId" OnRowDataBound="grdResult_RowDataBound"
                        ForeColor="#333333" CssClass="gridView w-75p" EmptyDataText="Bills for the Day Not Available"
                        meta:resourcekey="grdResultResource1">
                        <HeaderStyle CssClass="dataheader1" />
                        <FooterStyle CssClass="dataheader1" />
                        <Columns>
                            <asp:TemplateField HeaderText="SI.No" HeaderStyle-Width="3%">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="FeeId" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lnkFeeId" Style="color: Black; font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("FeeId") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="FeeType" HeaderText="FeeType" Visible="false">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="">
                                <ItemTemplate>
                                    <asp:Label ID="lnkFeeDescription" Style="font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("FeeDescription") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="left"></ItemStyle>
                                <FooterStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Country Name <br/> (Currency)">
                                <ItemTemplate>
                                    <asp:Label ID="lnkCountryName" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("CountryName") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="left"></ItemStyle>
                                <FooterStyle HorizontalAlign="left" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Test count" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <%# Eval("TotalCount") %>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="B2B Billed Amount" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <%# Eval("BilledAmount")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="B2C Billed Amount" ItemStyle-HorizontalAlign="Right"
                                Visible="false">
                                <ItemTemplate>
                                    <%# Eval("GrossAmount")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Center" />
                    </asp:GridView>
                </asp:Panel>
                <asp:Panel ID="pnel" runat="server" ScrollBars="Vertical" Style="width: 60%; height: 500px;"
                    Visible="false">
                    <asp:GridView ID="grdResultFifty" runat="server" AlternatingRowStyle-CssClass="trEven"
                        CellPadding="4" AutoGenerateColumns="False" DataKeyNames="FeeId" ForeColor="#333333"
                        CssClass="gridView w-75p" EmptyDataText="Bills for the Day Not Available" OnRowDataBound="grdResultFifty_RowDataBound">
                        <HeaderStyle CssClass="dataheader1" />
                        <FooterStyle CssClass="dataheader1" />
                        <Columns>
                            <asp:TemplateField HeaderText="SI.No" HeaderStyle-Width="3%">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="FeeId" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lnkFeeId" Style="color: Black; font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("FeeId") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="FeeType" HeaderText="FeeType" Visible="false">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="">
                                <ItemTemplate>
                                    <asp:Label ID="lnkFeeDescription" Style="font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("FeeDescription") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="left"></ItemStyle>
                                <FooterStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Country Name">
                                <ItemTemplate>
                                    <asp:Label ID="lnkCountryName" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("CountryName") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="left"></ItemStyle>
                                <FooterStyle HorizontalAlign="left" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Test count" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <%# Eval("TotalCount") %>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="B2B Billed Amount" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <%# Eval("BilledAmount")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="B2C Billed Amount" ItemStyle-HorizontalAlign="Right"
                                Visible="false">
                                <ItemTemplate>
                                    <%# Eval("GrossAmount")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Center" />
                    </asp:GridView>
                </asp:Panel>
                <asp:HiddenField ID="hdnSelectedClientID" runat="server" Value="0" />
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnConverttoXL" />
                <asp:PostBackTrigger ControlID="btnConverttoClientXL" />
                <asp:PostBackTrigger ControlID="btnPrintAll" />
                <asp:PostBackTrigger ControlID="btnPrintAllClient" />
            </Triggers>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <asp:HiddenField ID="hdnTargetCtlMailReport" runat="server" />
                <cc1:ModalPopupExtender ID="modalpopupsendemail" runat="server" PopupControlID="pnlMailReports"
                    TargetControlID="hdnTargetCtlMailReport" BackgroundCssClass="modalBackground"
                    CancelControlID="img1" DynamicServicePath="" Enabled="True">
                </cc1:ModalPopupExtender>
                <asp:Panel ID="pnlMailReports" BorderWidth="1px" Height="40%" Width="30%" CssClass="modalPopup dataheaderPopup"
                    runat="server" meta:resourcekey="pnlMailReportResource1" Style="display: none">
                    <asp:Panel ID="Panel5" runat="server" CssClass="dialogHeader" meta:resourcekey="Panel1Resource1">
                        <table width="100%">
                            <tr>
                                <td>
                                    <asp:Label ID="Label11" runat="server" Text="Email Report" meta:resourcekey="Label11Resource2"></asp:Label>
                                </td>
                                <td align="right">
                                    <img id="img1" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                        style="cursor: pointer;" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <table class="w-100p">
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="vertical-align: middle;">
                                <asp:Label ID="lblMailAddress" runat="server" Text="To: " meta:resourcekey="lblMailAddressResource1" />
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtMailAddress" TextMode="MultiLine" Width="300px" Height="40px"
                                    runat="server" meta:resourcekey="txtMailAddressResource1" />
                                <p style="margin: 2px 0 5px 0; font-size: 11px; color: #666;">
                                    <asp:Label ID="lblMailAddressHint" runat="server" Text="example: abc@example.com, def@example.com"
                                        meta:resourcekey="lblMailAddressHintResource1" />
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                    <ProgressTemplate>
                                        <asp:Image ID="imgProgressbars" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                        <asp:Label ID="Rs_Pleasewaits" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                                <asp:Button ID="Send" runat="server" Text="Send" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" OnClientClick="javascript:return CheckEmpty();"
                                    OnClick="btnSendMailReport_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HiddenField ID="hdnClientEmail" runat="server" />
                                <asp:HiddenField ID="hdnCountryID" runat="server" Value="0" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>
