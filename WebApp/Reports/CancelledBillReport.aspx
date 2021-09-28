<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CancelledBillReport.aspx.cs"
    Inherits="Reports_CancelledBillReport" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Cancelled Bill Report</title>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script language="javascript" type="text/javascript">

        function CheckEmpty() {
            var AlertType = SListForAppMsg.Get('Reports_CancelledBillReport_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reports_CancelledBillReport_aspx_02');
            var objcli = SListForAppMsg.Get('Reports_CancelledBillReport_aspx_01') == null ? "Select a client" : SListForAppMsg.Get('Reports_CancelledBillReport_aspx_01');
            var Check = document.getElementById("txtMailAddress").value;
            var ctrl = document.getElementById("txtMailAddress");
            if (Check == "") {
                ValidationWindow(objcli, AlertType);

                //alert("Enter Email Address");
                return false;
            }
            else 
            {

                if (validateMultipleEmailsCommaSeparated(ctrl, ','))
                { }
                else
                {return false;}
            
             }
            

        }

        function ItemClientSelected(source, eventArgs) {

            var ClientCorpID;
            var list = eventArgs.get_value().split('^');
            ClientCorpID = list[0];
            document.getElementById('hdnSelectedClientID').value = ClientCorpID;

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


        function CheckPatientSearch() {

            var AlertType = SListForAppMsg.Get('Reports_CancelledBillReport_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reports_CancelledBillReport_aspx_02');
            var objcli = SListForAppMsg.Get('Reports_CancelledBillReport_aspx_03') == null ? "Select From Date" : SListForAppMsg.Get('Reports_CancelledBillReport_aspx_03');
            var objfrom = SListForAppMsg.Get('Reports_CancelledBillReport_aspx_04') == null ? "Select To Date" : SListForAppMsg.Get('Reports_CancelledBillReport_aspx_04');

            if (document.getElementById('txtFrom').value == '') {
                ValidationWindow(objcli, AlertType);
            
                //alert('Select From Date');
                return false;
            }
            if (document.getElementById('txtTo').value == '') {
                ValidationWindow(objfrom, AlertType);
                //alert('Select To Date');
                return false;
            }

        }
        function validateToDate() {

            var AlertType = SListForAppMsg.Get('Reports_CancelledBillReport_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reports_CancelledBillReport_aspx_02');
            var objfrom = SListForAppMsg.Get('Reports_CancelledBillReport_aspx_05') == null ? "Provide / select value for From date" : SListForAppMsg.Get('Reports_CancelledBillReport_aspx_05');
            if (document.getElementById('txtFDate').value == '') {
                ValidationWindow(objfrom, AlertType);
                //alert('Provide / select value for From date');
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                ValidationWindow(objfrom, AlertType);
                //alert('Provide / select value for To date');
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
            // WinPrint.close();
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
        function validateEmail(field) {
            var regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,5}$/;
            return (regex.test(field)) ? true : false;
        }
        function validateMultipleEmailsCommaSeparated(emailcntl, seperator) {
            var AlertType = SListForAppMsg.Get('Reports_CancelledBillReport_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reports_CancelledBillReport_aspx_02');
            var vCheck = SListForAppMsg.Get('Reports_CancelledBillReport_aspx_07') == null ? "Please check," : SListForAppMsg.Get('Reports_CancelledBillReport_aspx_07');
            var vEmailAddress = SListForAppMsg.Get('Reports_CancelledBillReport_aspx_08') == null ? "email addresses not valid!" : SListForAppMsg.Get('Reports_CancelledBillReport_aspx_08');
            var value = emailcntl.value;
            if (value != '') {
                var result = value.split(seperator);
                for (var i = 0; i < result.length; i++) {
                    if (result[i] != '') {
                        if (!validateEmail(result[i])) {
                            // emailcntl.focus();
                            ValidationWindowEmail(vCheck + ' "' + result[i] + '" ' + vEmailAddress, AlertType);
         
                            return false;
                        }
                    }
                }
            }
            return true;
        }
        function ValidationWindowEmail(message, tt) {
            jQuery('<div>')
        .html("<p>" + message + "</p>")
        .dialog({
            autoOpen: false,
            modal: true,
            title: tt,
            dialogClass: 'validationwindow',
            close: function() {
                jQuery(this).dialog("destroy");
            },
            buttons: {
                "MyButton": {
                    id: "okbtnid",
                    "class": "btn",
                    click: function() {
                        jQuery(this).dialog("destroy");
                        document.getElementById('txtEmail').focus();
                    }
                }
            },
            create: function() {

                var canceltxt = jQuery('#Language').text();
                jQuery('#Cancelbtnid').text(canceltxt);
                //var oktxt = jQuery('[id$=hdnButtonText]').val();
                var oktxt = SListForAppDisplay.Get("Scripts_Common_js_Ok") == null ? "Ok" : SListForAppDisplay.Get("Scripts_Common_js_Ok");
                if (oktxt == '' || oktxt == null) {
                    try {
                        oktxt = jQuery('[id$=btnRoleOK]').val();
                    }
                    catch (Error) {
                        oktxt = "Ok";
                    }
                    oktxt = oktxt == "" || oktxt == undefined ? "Ok" : oktxt;
                }

                jQuery('#okbtnid').text(oktxt);
                jQuery('#okbtnid').css("width", "100px");
                jQuery('#okbtnid').css("height", "30px");
            }
        }).dialog("open");
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
                    class="w-100p searchPanel">
                    <tr>
                        <td>
                            <div class="dataheaderWider">
                                <table id="tblPatient" runat="server" class="w-100p" border="0" cellpadding="0" cellspacing="0">
                                    <tr id="Tr1" runat="server">
                                        <td id="Td1" align="left" runat="server">
                                            <div style="display: block">
                                                <table class="w-100p" border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblFrom" Text="From" runat="server" 
                                                                meta:resourcekey="lblFromResource1"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox Width="125px" ID="txtFrom" CssClass="Txtboxsmall" runat="server" 
                                                                meta:resourcekey="txtFromResource1"></asp:TextBox>
                                                            <a href="javascript:NewCssCal('<% =txtFrom.ClientID %>','ddmmyyyy','arrow',true,12,'Y','N','Y')">
                                                                <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblTo" Text="To" runat="server" 
                                                                meta:resourcekey="lblToResource1"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txtTo" Width="125px" CssClass="Txtboxsmall" runat="server" 
                                                                meta:resourcekey="txtToResource1"></asp:TextBox>
                                                            <a href="javascript:NewCssCal('<% =txtTo.ClientID %>','ddmmyyyy','arrow',true,12,'Y','N','Y')">
                                                                <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblCountry" Text="Select Country" runat="server" 
                                                                meta:resourcekey="lblCountryResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlCountry" runat="server" onchange="getCountryID();" AutoPostBack="true"
                                                                OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged" 
                                                                meta:resourcekey="ddlCountryResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="Rs_ClientName" runat="server" Text="Client Name" 
                                                                meta:resourcekey="Rs_ClientNameResource1"></asp:Label>
                                                        </td>
                                                        <td id="tdClientParttxt" runat="server">
                                                            <asp:TextBox ID="txtClient" runat="server" autocomplete="off" Width="200px" 
                                                                CssClass="AutoCompletesearchBox" meta:resourcekey="txtClientResource1"></asp:TextBox>
                                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" CompletionInterval="1"
                                                                CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                Enabled="True" FirstRowSelected="True" OnClientItemSelected="ItemClientSelected"
                                                                UseContextKey="true" ServiceMethod="GetCountryWiseClientNames" ServicePath="~/Webservice.asmx"
                                                                TargetControlID="txtClient">
                                                            </cc1:AutoCompleteExtender>
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="Button1" runat="server" CssClass="btn" OnClick="btnSearch_Click"
                                                                OnClientClick="return CheckPatientSearch();" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" Text="TestWise" 
                                                                meta:resourcekey="Button1Resource1" />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnClientWise" runat="server" OnClientClick="return CheckPatientSearch();"
                                                                CssClass="btn" onmouseover="this.className='btn btnhov'" Text="ClientWise" 
                                                                OnClick="btnClientWise_Click" meta:resourcekey="btnClientWiseResource1" />
                                                        </td>
                                                    </tr>
                                                    <br />
                                                    <tr>
                                                        <td align="right">
                                                            &nbsp; &nbsp; &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right" colspan="10">
                                                            <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" 
                                                                OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1">Back&nbsp;&nbsp;&nbsp;</asp:LinkButton>
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
                        <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" 
                            meta:resourcekey="imgProgressbarResource1" />
                        <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" 
                            meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <div id="divPrint1" style="display: none;" runat="server">
                    <table cellpadding="0" cellspacing="0" border="0" class="w-100p">
                        <tr align="right">
                            <td id="tdexcel" style="padding-right: 10px; color: #000000;" runat="server">
                                <asp:Label ID="lbExcel" Text="Excel Report" Font-Bold="True" ForeColor="#000333"
                                    runat="server" meta:resourcekey="lbExcelResource1"></asp:Label>
                                <asp:ImageButton ID="btnConverttoXL" OnClick="btnConverttoXL_Click" runat="server"
                                    ImageUrl="~/Images/ExcelImage.GIF" 
                                    meta:resourcekey="btnConverttoXLResource1"  />
                                &nbsp;&nbsp;
                                <asp:ImageButton ID="btnConverttoClientXL" runat="server" OnClick="btnConverttoClientXL_Click"
                                    ImageUrl="~/Images/ExcelImage.GIF" Visible="False" 
                                    meta:resourcekey="btnConverttoClientXLResource1" />
                                <b id="B2" runat="server">
                                    <asp:Label ID="Label1" Visible="False" Text="Print Report" runat="server" 
                                    meta:resourcekey="Label1Resource1" ></asp:Label>
                                </b>
                                <%-- </td>
                                            <td style="padding-right: 10px; color: #000000;">--%>
                                <b id="B1" runat="server">
                                    <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"
                                        ></asp:Label>
                                </b>
                                <asp:Button ID="btnPrintAll" runat="server" Text="Print" CssClass="btn" 
                                    OnClick="btnPrintAll_Click" meta:resourcekey="btnPrintAllResource1" />
                                <asp:Button ID="btnPrintAllClient" runat="server" Text="Print" CssClass="btn" Visible="false"
                                    OnClick="btnPrintAllClient_Click" 
                                    meta:resourcekey="btnPrintAllClientResource1" />
                                &nbsp;&nbsp;
                                <asp:Button ID="btnSendmail" runat="server" Text="Send Mail" CssClass="btn" 
                                    OnClick="btnSendmail_Click" meta:resourcekey="btnSendmailResource1" />
                            </td>
                        </tr>
                    </table>
                </div>
                <asp:Panel ID="pnl" runat="server" ScrollBars="Vertical" class="w-60p" Style="height: 500px;"
                    Visible="false">
                    <asp:GridView ID="grdResult" runat="server" CellPadding="4" AlternatingRowStyle-CssClass="trEven"
                        AutoGenerateColumns="False" DataKeyNames="FeeId" OnRowDataBound="grdResult_RowDataBound"
                        ForeColor="#333333" CssClass="mytable1" 
            EmptyDataText="Cancelled bills Not Available" 
            meta:resourcekey="grdResultResource1">
                        <HeaderStyle CssClass="gridView w-60p" />
                        <Columns>
                            <asp:TemplateField HeaderText="SI.No" HeaderStyle-Width="3%" 
                                meta:resourcekey="TemplateFieldResource1">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
<HeaderStyle Width="3%"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="FeeId" Visible="false" 
                                meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:Label ID="lnkFeeId" Style="color: Black; font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("FeeId") %>' runat="server" 
                                        meta:resourcekey="lnkFeeIdResource1"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="FeeType" HeaderText="FeeType" Visible="false" 
                                meta:resourcekey="BoundFieldResource1">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" Width="14%" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Test / Profile" 
                                meta:resourcekey="TemplateFieldResource3">
                                <ItemTemplate>
                                    <asp:Label ID="lnkFeeDescription" Style="font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("FeeDescription") %>' runat="server" 
                                        meta:resourcekey="lnkFeeDescriptionResource1"></asp:Label>
                                </ItemTemplate>
                                <FooterStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Country Name <br/> (Currency)" 
                                meta:resourcekey="TemplateFieldResource4">
                                <ItemTemplate>
                                    <asp:Label ID="lnkCountryName" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("CountryName") %>'
                                        runat="server" meta:resourcekey="lnkCountryNameResource1"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="left"></ItemStyle>
                                <FooterStyle HorizontalAlign="left" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="TotalCount" HeaderText="Total Count" 
                                meta:resourcekey="BoundFieldResource2">
                                <HeaderStyle HorizontalAlign="Right" />
                                <ItemStyle HorizontalAlign="Right" Width="5%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CancelledCount" HeaderText="Cancelled Count" 
                                meta:resourcekey="BoundFieldResource3">
                                <HeaderStyle HorizontalAlign="Right" />
                                <ItemStyle HorizontalAlign="Right" Width="5%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CancelledPercentage" HeaderText="% Cancelled" 
                                meta:resourcekey="BoundFieldResource4">
                                <HeaderStyle HorizontalAlign="Right" />
                                <ItemStyle HorizontalAlign="Right" Width="7%" />
                            </asp:BoundField>
                        </Columns>
<AlternatingRowStyle CssClass="trEven"></AlternatingRowStyle>
                    </asp:GridView>
                </asp:Panel>
                <asp:Panel ID="pnel" runat="server" ScrollBars="Vertical" Style="height: 500px;"
                    Visible="false">
                    <asp:GridView ID="grdResultFifty" runat="server" CellPadding="4" AlternatingRowStyle-CssClass="trEven"
                        AutoGenerateColumns="False" DataKeyNames="FeeId" 
            ForeColor="#333333" CssClass="gridView w-100p"
                        EmptyDataText="Cancelled bills Not Available" 
            OnRowDataBound="grdResultFifty_RowDataBound" 
            meta:resourcekey="grdResultFiftyResource1">
                        <Columns>
                            <asp:TemplateField HeaderText="SI.No" HeaderStyle-Width="3%" 
                                meta:resourcekey="TemplateFieldResource5">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
<HeaderStyle Width="3%"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="FeeId" Visible="false" 
                                meta:resourcekey="TemplateFieldResource6">
                                <ItemTemplate>
                                    <asp:Label ID="lnkFeeId" Style="color: Black; font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("FeeId") %>' runat="server" 
                                        meta:resourcekey="lnkFeeIdResource2"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="FeeType" HeaderText="FeeType" Visible="false" 
                                meta:resourcekey="BoundFieldResource5">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" Width="14%" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Test / Profile" 
                                meta:resourcekey="TemplateFieldResource7">
                                <ItemTemplate>
                                    <asp:Label ID="lnkFeeDescription" Style="font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("FeeDescription") %>' runat="server" 
                                        meta:resourcekey="lnkFeeDescriptionResource2"></asp:Label>
                                </ItemTemplate>
                                <FooterStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Country Name <br/> (Currency)" 
                                meta:resourcekey="TemplateFieldResource8">
                                <ItemTemplate>
                                    <asp:Label ID="lnkCountryName" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("CountryName") %>'
                                        runat="server" meta:resourcekey="lnkCountryNameResource2"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="left"></ItemStyle>
                                <FooterStyle HorizontalAlign="left" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="TotalCount" HeaderText="Total Count" 
                                meta:resourcekey="BoundFieldResource6">
                                <HeaderStyle HorizontalAlign="Right" />
                                <ItemStyle HorizontalAlign="Right" Width="5%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CancelledCount" HeaderText="Cancelled Count" 
                                meta:resourcekey="BoundFieldResource7">
                                <HeaderStyle HorizontalAlign="Right" />
                                <ItemStyle HorizontalAlign="Right" Width="5%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CancelledPercentage" HeaderText="% Cancelled" 
                                meta:resourcekey="BoundFieldResource8">
                                <HeaderStyle HorizontalAlign="Right" />
                                <ItemStyle HorizontalAlign="Right" Width="7%" />
                            </asp:BoundField>
                        </Columns>
<AlternatingRowStyle CssClass="trEven"></AlternatingRowStyle>
                    </asp:GridView>
                </asp:Panel>
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
                    runat="server" Style="display: none">
                   <asp:Panel ID="Panel5" runat="server" CssClass="dialogHeader">
                        <table class="w-100p">
                            <tr>
                                <td>
                                    <asp:Label ID="Label11" runat="server" Text="Email Report" 
                                        meta:resourcekey="Label11Resource1" ></asp:Label>
                                </td>
                                <td align="right">
                                    <img id="img1" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                        style="cursor: pointer;" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <table width="100%">
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="vertical-align: middle;">
                                <asp:Label ID="lblMailAddress" runat="server" Text="To: " 
                                    meta:resourcekey="lblMailAddressResource1"  />
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtMailAddress" TextMode="MultiLine" Width="300px" Height="40px"
                                    runat="server" meta:resourcekey="txtMailAddressResource1" />
                                <p style="margin: 2px 0 5px 0; font-size: 11px; color: #666;">
                                    <asp:Label ID="lblMailAddressHint" runat="server" 
                                        Text="example: abc@example.com, def@example.com" meta:resourcekey="lblMailAddressHintResource1"
                                        />
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                    <ProgressTemplate>
                                        <asp:Image ID="imgProgressbars" runat="server" ImageUrl="~/Images/working.gif" 
                                            meta:resourcekey="imgProgressbarsResource1"  />
                                        <asp:Label ID="Rs_Pleasewaits" Text="Please wait...." runat="server" 
                                            meta:resourcekey="Rs_PleasewaitsResource1"  />
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                                <asp:Button ID="Send" runat="server" Text="Send" OnClientClick="javascript:return CheckEmpty();"
                                    CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                    OnClick="btnSendMailReport_Click" meta:resourcekey="SendResource1" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HiddenField ID="hdnClientEmail" runat="server" />
                                <asp:HiddenField ID="hdnCountryID" runat="server" Value="0" />
                                <asp:HiddenField ID="hdnSelectedClientID" runat="server" Value="0" />
                                <asp:HiddenField ID="hdnMessages" runat="server" />
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
