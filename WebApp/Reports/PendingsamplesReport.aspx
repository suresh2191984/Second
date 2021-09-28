<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PendingsamplesReport.aspx.cs"
    Inherits="Reports_PendingsamplesReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Pending Sample Report</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

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
        function CheckPatientSearch() {

            if (document.getElementById('txtFrom').value == '') {
                alert('Select From Date');
                return false;
            }
            if (document.getElementById('txtTo').value == '') {
                alert('Select To Date');
                return false;
            }

        }
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
    </script>

</head>
<body>
    <form id="form1" runat="server">

    <script language="javascript" type="text/javascript">
        function openViewBill(obj, ftype) {
            var skey = "../Reception/ViewPrintPage.aspx"
                           + obj
                           + "&IsPopup=" + "Y"
                           + "&CCPage=Y"
                           + "";

            window.open(skey, 'ViewBill', 'letf=0,top=0,height=640,width=800,toolbar=0,scrollbars=1,status=0');
        }
       
    </script>

    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="updatePanel1" runat="server">
            <ContentTemplate>
                <table id="tblCollectionOPIP" align="center" cellpadding="0" cellspacing="0" border="0"
                    class="w-100p">
                    <tr>
                        <td>
                            <div>
                                <table id="tblPatient" runat="server" class="w-100p searchPanel" border="0" cellpadding="0"
                                    cellspacing="0">
                                    <tr id="Tr1" runat="server">
                                        <td id="Td1" align="left" runat="server">
                                            <div style="display: block">
                                                <table class="w-50p" border="0" cellpadding="0" cellspacing="0">
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
                                                            <asp:Button ID="Button1" runat="server" CssClass="btn" OnClick="btnSearch_Click"
                                                                OnClientClick="return CheckPatientSearch();" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" Text="Search" />
                                                            &nbsp;
                                                        </td>
                                                        <td>
                                                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="details_label_age" Text="Back"
                                                                OnClick="lnkBack_Click"></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
                <asp:UpdateProgress ID="Progressbar" runat="server">
                    <ProgressTemplate>
                        <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                        <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <div id="divPrint1" style="display: none;" runat="server">
                    <table cellpadding="0" cellspacing="0" border="0" class="w-90p">
                        <tr align="right">
                            <td id="tdexcel" style="padding-right: 10px; color: #000000;" runat="server">
                                <asp:Label ID="lbExcel" Text="Excel Report" Font-Bold="True" ForeColor="#000333"
                                    runat="server" meta:resourcekey="lbExcelResource1"></asp:Label>
                                <asp:ImageButton ID="btnConverttoXL" OnClick="btnConverttoXL_Click" runat="server"
                                    ImageUrl="~/Images/ExcelImage.GIF" meta:resourcekey="btnConverttoXLResource1" />
                                &nbsp;&nbsp;
                                <%-- </td>
                                            <td style="padding-right: 10px; color: #000000;">--%>
                                <b id="B1" runat="server">
                                    <asp:Label ID="Rs_PrintReport" Visible="true" Text="Print Report" runat="server"></asp:Label>
                                </b>
                                <asp:Button ID="btnPrintAll" runat="server" Text="Print" CssClass="btn" OnClick="btnPrintAll_Click" />
                                &nbsp;&nbsp;
                                <asp:Button ID="btnSendmail" runat="server" Text="Send Mail" CssClass="btn" OnClick="btnSendmail_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
                <br />
                <asp:Panel ID="pnl" runat="server" ScrollBars="Vertical" Style="width: 75%; height: 500px;"
                    Visible="false">
                    <asp:GridView ID="grdResult" runat="server" AlternatingRowStyle-CssClass="trEven"
                        CellPadding="4" AutoGenerateColumns="False" OnRowDataBound="grdResult_RowDataBound"
                        ForeColor="#333333" CssClass="gridView w-100p" EmptyDataText="Pending Samples Not Available >4 hrs">
                        <HeaderStyle CssClass="dataheader1" />
                        <Columns>
                            <asp:TemplateField HeaderText="SI.No" HeaderStyle-Width="3%">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Labcode">
                                <ItemTemplate>
                                    <asp:Label ID="lnkClientName" Style="color: Black; font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("ClientName") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="left" Width="20%" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="BarcodeNumber" HeaderText="Barcode">
                                <HeaderStyle HorizontalAlign="center" />
                                <ItemStyle HorizontalAlign="Left" Width="17%" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Tests">
                                <ItemTemplate>
                                    <asp:Label ID="lnkTestName" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("TestName") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="left" Width="20%" />
                                <FooterStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="SampleCollectedAt" HeaderText="Sample Collected Time" />
                            <asp:TemplateField HeaderText="Sample Received Time">
                                <ItemTemplate>
                                    <asp:Label ID="lnkSamplereceivedAt" Style="font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("SamplereceivedAt") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="left" Width="20%" />
                                <FooterStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="Hours" HeaderText="Pending Hrs">
                                <HeaderStyle HorizontalAlign="Right" />
                                <ItemStyle HorizontalAlign="Right" Width="5%" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
                <asp:Panel ID="pnel" runat="server" AlternatingRowStyle-CssClass="trEven" ScrollBars="Vertical"
                    Style="width: 75%; height: 500px;" Visible="false">
                    <asp:GridView ID="grdResultFifty" runat="server" CellPadding="4" AutoGenerateColumns="False"
                        ForeColor="#333333" CssClass="gridView w-100p" EmptyDataText="Pending Samples Not Available >4 hrs"
                        OnRowDataBound="grdResultFifty_RowDataBound">
                        <HeaderStyle CssClass="dataheader1" />
                        <Columns>
                            <asp:TemplateField HeaderText="SI.No" HeaderStyle-Width="3%">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Labcode">
                                <ItemTemplate>
                                    <asp:Label ID="lnkClientName" Style="color: Black; font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("ClientName") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="left" Width="20%" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="BarcodeNumber" HeaderText="Barcode">
                                <HeaderStyle HorizontalAlign="center" />
                                <ItemStyle HorizontalAlign="Left" Width="17%" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Tests">
                                <ItemTemplate>
                                    <asp:Label ID="lnkTestName" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("TestName") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="left" Width="20%" />
                                <FooterStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="SampleCollectedAt" HeaderText="Sample Collected Time" />
                            <asp:TemplateField HeaderText="Sample Received Time">
                                <ItemTemplate>
                                    <asp:Label ID="lnkFiftySamplereceivedAt" Style="font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("SamplereceivedAt") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="left" Width="20%" />
                                <FooterStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="Hours" HeaderText="Pending Hrs">
                                <HeaderStyle HorizontalAlign="Right" />
                                <ItemStyle HorizontalAlign="Right" Width="5%" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnConverttoXL" />
                <asp:PostBackTrigger ControlID="btnPrintAll" />
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
                        <table class="w-100p">
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
