<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DoctorPaySummary.aspx.cs"
    Inherits="Admin_DoctorPaySummary" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Doctor Payment Summary</title>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <style>
        .w-94
        {
            width: 94px;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function ValidateDate() {

            if (document.getElementById('txtFrom').value == '') {

                alert('Select from date and to date');
                return false;
            }
            else if (document.getElementById('txtTo').value == '') {
                alert('Select from date and to date');
                return false;

            }
            else if (document.getElementById('txtPhysician').value == '') {
                    alert('Enter Doctor Name');
                    return false;
            }
            else {
                return checkFromDateToDate('txtFrom', 'txtTo');
            }
        }
        function SelectedOverPhy(source, eventArgs) {
            $find('AutoCompleteExtenderRefPhy')._onMethodComplete = function(result, context) {
                $find('AutoCompleteExtenderRefPhy')._update(context, result, /* cacheResults */false);
                if (result == "") {

                    alert('Please select from the list');
                    document.getElementById('txtPhysician').value = '';
                    document.getElementById('<%=hdnPhysicianID.ClientID %>').value = '0';
                }
            };
        }
        function javRefphyDetails() {
            document.getElementById('hdnPhysicianID').value = "";

            $find('AutoCompleteExtenderRefPhy')._onMethodComplete = function(result, context) {

                $find('AutoCompleteExtenderRefPhy')._update(context, result, false);
                if (result == "") {
                    alert('Please select Physician Name from the list');
                    $('#txtPhysician').val("");
                    document.getElementById('txtPhysician').focus();
                    return false;
                }
            };
        }
        function SetPhysicianID(source, eventArgs) {
            if (eventArgs != undefined) {
                document.getElementById('<%=hdnPhysicianID.ClientID %>').value = eventArgs.get_value();
            }
            if (document.getElementById('txtPhysician').value == '') {
                document.getElementById('<%=hdnPhysicianID.ClientID %>').value = '0'
            }
            else if (document.getElementById('hdnPhysicianID') != null) {
                if (document.getElementById('<%=hdnPhysicianID.ClientID %>').value == '') {
                    alert('Please select from the list');
                    document.getElementById('<%=hdnPhysicianID.ClientID %>').value = '0';
                    document.getElementById('txtPhysician').value = '';
                }
            }
        }
        function isNumerc(e, Id) {
            var key; var isCtrl;
            //debugger;
            if (window.event) {
                key = window.event.keyCode;
                if (window.event.shiftKey) {
                    isCtrl = false;
                }
                else {
                    if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190)) {
                        isCtrl = true;
                    }
                    else {
                        //if ((key >= 185 && key <= 192) || (key >= 218 && key <= 222))
                        isCtrl = false;
                    }
                }
            } return isCtrl;
        }
        function isValidKey(e) {

           
                return false;

        }  
        function fnvalidate(gvname, rowIdx) {
            var i = "";
            i = parseInt(rowIdx) + 1

            if (i < 10) {
                row = "_ctl0" + i;
            }
            else {
                row = "_ctl" + i;
            }
            var Payable = 0;
            var Net = 0;
            var Outstand = 0;
            var Total = 0;
            Payable = document.getElementById(gvname + row + '_txtPaidAmount').value;
            Net = document.getElementById(gvname + row + '_lblPayableamount').innerText;
            Outstand = document.getElementById(gvname + row + '_lblOutstanding').innerText;
            Total = parseFloat(Net) + Outstand;
            if (Total <= Payable) {
                alert('Please enter correct amount');
                document.getElementById(gvname + row + '_txtPaidAmount').value = parseFloat(Total).toFixed(2);
            }

        }
        function checkItems() {

            try {
                var flag = 0;

                var Payable = 0;
                var Net = 0;
                var Outstand = 0;
                var Total = 0;
                var isError = false;

                $('table[id$="grdResult"]').each(function() {

                    flag = 1;
                    var $row = $(this).closest("tr");
                    var Net = $row.find($('input[id$="txtPayableamount"]'));
                    var Outstand = $row.find($('span[id$="lblOutstanding"]')).html();
                    var paid = $row.find($('input[id$="txtPaidAmount"]'));
                    var statusID = $row.find($('select[id$="drpStatus"] option:selected'));
                    var statusddl = $row.find($('select[id$="drpStatus"]'));
                    if (Number($(paid).val()) > Number((Number($(Net).val()) + Number(Outstand)))) {
                        alert('Paid Amount Should not be Greater than Sum of Payable and outstanding amounts');
                        $(paid).focus();
                        isError = true;
                        return false;
                    }

                    if (Number($(paid).val()) == (Number($(Net).val()) + Number(Outstand)) && $(statusID).val() == "2") {
                        alert('Status cannot be Partially Paid.');
                        $(statusddl).focus();
                        isError = true;
                        return false;

                    }
                    if (Number($(paid).val()) < (Number($(Net).val()) + Number(Outstand)) && $(statusID).val() == "0") {
                        alert('Status cannot be Paid.');
                        $(statusddl).focus();
                        isError = true;
                        return false;

                    }
                });
                if (isError)
                    return false;
            }
            catch (e) {
                alert("There was a problem");
                return false;
            }
        }
        function CalNetAmount(e, Id) {
            //var i = "";
            //filename = filename.replace(".pdf", exten);
            //            i = parseInt(rowIdx) + 2

            //            if (i < 10) {
            //                row = "_ctl0" + i;
            //            }
            //            else {
            //                row = "_ctl" + i;
            //            }
            var Net = 0;
            var Total = 0;
            var lblid = Id.replace("_chkblock", "_lbldNetAmount");

            TNetAmount = document.getElementById("lblTotNetAmount").innerText
            Net = document.getElementById(lblid).innerText;
            if (document.getElementById(Id).checked == true) {
                Total = Number(TNetAmount) - Number(Net);
                document.getElementById(Id.replace("_chkblock", "_txtRemarks")).disabled = false;
            }
            else {
                Total = Number(TNetAmount) + Number(Net);
                document.getElementById(Id.replace("_chkblock", "_txtRemarks")).disabled = true;
            }
            document.getElementById("lblTotNetAmount").innerText = Total.toFixed(2);
            //            if (Total <= Payable) {
            //                alert('Please enter correct amount');
            //                document.getElementById(gvname + row + '_txtPaidAmount').value = parseFloat(Total).toFixed(2);
            //            }

        }
        function Updategrid(rowID, BCount, BAmount, Dis, NetAmt, OutStand, PayableAmt, Paidamt, fBId) {
            //debugger;
            var i = rowID;
            var gvname = document.getElementById('grdResult').id;
            i = parseInt(rowID) + 2

            if (i < 10) {
                row = "_ctl0" + i;
            }
            else {
                row = "_ctl" + i;
            }
            document.getElementById(gvname + row + '_txtPaidAmount').value = Paidamt.toFixed(2);
            document.getElementById(gvname + row + '_txtvisits').innerText = BCount;
            document.getElementById(gvname + row + '_txtBillamount').innerText = BAmount.toFixed(2);
            document.getElementById(gvname + row + '_txtDiscount').innerText = Dis.toFixed(2);
            document.getElementById(gvname + row + '_txtNetamount').innerText = NetAmt.toFixed(2);
            document.getElementById(gvname + row + '_txtPayableamount').innerText = PayableAmt.toFixed(2);
            //            document.getElementById(gvname + row + '_lblOutstanding').innerText = OutStand;
            document.getElementById(gvname + row + '_hdnFinalbillID').value = document.getElementById('hdnfinallist').value;
            //document.getElementById('MPEDrpayoutdtls').style.display = 'none';
        }
        
    </script>

    <script runat="server">
        string _date;
        string GetDate(string Date)
        {
            if (Date != "01/01/1900")
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

    <style type="text/css">
        .style1
        {
            width: 135px;
        }
        .style2
        {
            width: 123px;
        }
        .style3
        {
            width: 112px;
        }
        .style4
        {
            width: 175px;
        }
        .style5
        {
            width: 133px;
        }
        .minHeight
        {
            min-height: 378px;
        }
        .contentdata
        {
            overflow-y: auto !important;
        }
        .griviewStyle table.gridView td
        {
            color: #323232;
            padding: 4px 2px;
            border: 1px solid #e8e8e8;
        }
        .docDetails
        {
            margin-bottom: 36px;
        }
        #pnlResult
        {
            overflow-y: auto;
            height: 240px;
            display: block;
        }
        #gvFianalDtls .grdHeader
        {
            display: none;
        }
        .griviewStyle #MPEDrpayoutdtls_foregroundElement
        {
            width: 100%;
            left: 0.5px !important;
        }
        .griviewStyle .txtRRemarks
        {
            width: 140px;
        }
        .ie .griviewStyle .txtRRemarks
        {
            width: 150px;
        }
        .txtpayment { width:94px; text-align:right;}
        .txtpayment1 { width:94px; text-align:right; float:left}
        .txtpayment2 { float:right;}
        .txtpayment3 { width:94px; text-align:left;}
    </style>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnGo" defaultfocus="ddlClient">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="searchPanel minHeight griviewStyle">
                    <table class="w-100p searchPanel v-top">
                        <tr>
                            <td>
                                <table class="docDetails">
                                    <tr>
                                        <td class="h-32 colorforcontent padding5">
                                            <table border="0" id="mytable1 w-100p">
                                                <tr>
                                                    <td id="us">
                                                        <asp:Label ID="Rs_DoctorpayoutResource" Text="Doctor Payout Details" runat="server"
                                                            meta:resourcekey="Rs_DoctorpayoutResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div>
                                                <asp:Panel runat="server" CssClass="dataheader2 w-99p" ID="pnlDate" meta:resourcekey="pnlDateResource1">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="h-5">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <table class="w-75p">
                                                                    <tr>
                                                                        <td class="defaultfontcolor">
                                                                            <asp:Label ID="lblFrom" Text="From" runat="server" meta:resourcekey="lblFromResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox runat="server" ID="txtFrom" CssClass="Txtboxsmall" MaxLength="25" size="20"></asp:TextBox>&nbsp;
                                                                        </td>
                                                                        <td class="defaultfontcolor">
                                                                            <asp:Label ID="lblTo" Text="To" runat="server" meta:resourcekey="lblToResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox runat="server" ID="txtTo" MaxLength="25" CssClass="Txtboxsmall" size="20"></asp:TextBox>&nbsp;
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label runat="server" ID="lbl" Text="Doctor Name"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtPhysician" runat="server" CssClass="AutoCompletesearchBox" onchange="SetPhysicianID()"
                                                                                Width="230px"></asp:TextBox>
                                                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" CompletionInterval="1"
                                                                                CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                CompletionListItemCssClass="wordWheel itemsMain" CompletionSetCount="10" EnableCaching="false"
                                                                                FirstRowSelected="true" MinimumPrefixLength="1" ServiceMethod="GetPhysician"
                                                                                OnClientItemSelected="SetPhysicianID" OnClientItemOver="SelectedOverPhy" ServicePath="~/Webservice.asmx"
                                                                                TargetControlID="txtPhysician">
                                                                            </ajc:AutoCompleteExtender>
                                                                             &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />      
                                                                        </td>
                                                                        <td>
                                                                            <asp:Button runat="server" ID="btnGo" Text=" Search " CssClass="btn" TabIndex="6"
                                                                                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="javascript:return ValidateDate();"
                                                                                OnClick="btnGo_Click" meta:resourcekey="btnGoResource1" Width="50px" />
                                                                            &nbsp;
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td class="colorforcontent padding5 bold">
                                            <asp:Label ID="lblGvSummary" Text="Summary Details" runat="server" meta:resourcekey="lblResultResource1"
                                                Style="font-family: Arial, sans-serif"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Panel ID="pnlResult" runat="server" ScrollBars="Auto">
                                                <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                    Visible="false" CellPadding="4" Font-Size="10px" HeaderStyle-CssClass="headGrid"
                                                    CssClass="mytable1 gridView w-97p" ForeColor="#333333" OnRowCommand="grdResult_RowCommand1"
                                                    meta:resourcekey="grdResultResource1">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="S.No">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblsno" runat="server" Text='<%# Container.DataItemIndex+1 %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Center" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Doctor Code" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="13%"
                                                            meta:resourcekey="TemplateFieldResource1">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDoctorcode" runat="server" Text='<%# Bind("PhysicianCode") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Left" Width="13%"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Doctor Name" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="18%"
                                                            meta:resourcekey="TemplateFieldResource2">
                                                            <ItemTemplate>
                                                                <asp:HiddenField ID="hdnRefId" runat="server" Value='<%# Eval("ReferingPhysicianID") %>' />
                                                                <asp:Label ID="lblDoctorName" runat="server" Text='<%# Bind("PhysicianName") %>'></asp:Label>
                                                                <asp:HiddenField ID="hdnFinalbillID" runat="server" Value="" />
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Left" Width="18%"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Visits" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="13%"
                                                            meta:resourcekey="TemplateFieldResource3">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtvisits" class="txtpayment3" runat="server" onkeydown="return isValidKey(event)" Text='<%# Bind("BillCount") %>'></asp:TextBox>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Left" Width="13%"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Bill Amount" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="13%"
                                                            meta:resourcekey="TemplateFieldResource4">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtBillamount" class="txtpayment" runat="server" onkeydown="return isValidKey(event)" Text='<%# Bind("BillAmount") %>'></asp:TextBox>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Right" Width="13%"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Discount" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="13%"
                                                            meta:resourcekey="TemplateFieldResource5">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtDiscount" class="txtpayment" runat="server" onkeydown="return isValidKey(event)" Text='<%# Bind("DisCount") %>'></asp:TextBox>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Right" Width="13%"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Net Amount" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="13%"
                                                            meta:resourcekey="TemplateFieldResource6">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtNetamount" class="txtpayment" runat="server" onkeydown="return isValidKey(event)" Text='<%# Bind("NetAmount") %>'></asp:TextBox>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Right" Width="13%"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Payable Amount" ItemStyle-HorizontalAlign="Right"
                                                            ItemStyle-Width="18%" meta:resourcekey="TemplateFieldResource7">
                                                            <ItemTemplate>
                                                            
                                                                <asp:TextBox ID="txtPayableamount" class="txtpayment1" runat="server" onkeydown="return isValidKey(event)" Text='<%# Bind("PayableAmount") %>'></asp:TextBox>
                                                                &nbsp; <asp:ImageButton ID="imgPayableAmt" class="txtpayment2" runat="server" ImageUrl="~/Images/BillIcon.jpg" Style="border-width: 0px;"
                                                        ToolTip="View Details" CommandName="ShowFinalbill" CommandArgument='<%# Container.DataItemIndex%>'  />
                                                                <%--<asp:LinkButton ID="lnkPayableAmt" runat="server" Text='<%# Bind("PayableAmount") %>'
                                                                    CommandName="ShowFinalbill" CommandArgument='<%# Container.DataItemIndex%>'></asp:LinkButton>--%>
                                                                <%--<asp:Image ImageUrl="~/Images/History.jpg" runat="server" Text="H" Height="30px"
                                                                    ID="imgchanges" meta:resourcekey="imgchangesResource1" />--%>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Right" Width="13%"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Out Standing" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="13%"
                                                            meta:resourcekey="TemplateFieldResource8">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblOutstanding" runat="server" Text='<%# Bind("OutStanding") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Right" Width="13%"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Paid Amount" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%"
                                                            meta:resourcekey="TemplateFieldResource9">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtPaidAmount" CssClass="a-right w-94" runat="server" Text='<%# Bind("Paidamount") %>'
                                                                    onkeydown="return isNumerc(event,this.id);"></asp:TextBox>
                                                                <%--onblur="return fnvalidate('grdResult',parentNode.parentNode.rowIndex);"--%>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Payment Status" ItemStyle-HorizontalAlign="Center"
                                                            ItemStyle-Width="13%" meta:resourcekey="TemplateFieldResource9">
                                                            <ItemTemplate>
                                                                <asp:DropDownList runat="server" ID="drpStatus">
                                                                    <asp:ListItem Value="0">Paid</asp:ListItem>
                                                                    <asp:ListItem Value="1">Hold</asp:ListItem>
                                                                    <asp:ListItem Value="2">Partially Paid</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Center" Width="13%"></ItemStyle>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                                <table class="w-100p">
                                                    <tr>
                                                        <td class="a-center">
                                                            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" Visible="false"
                                                                OnClientClick="javascript:return checkItems();" CssClass="btn" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                                <asp:Button ID="hiddenTargetControlForModalPopup" runat="server" Style="display: none"
                                    meta:resourcekey="hiddenTargetControlForModalPopupResource1" />
                                <ajc:ModalPopupExtender ID="MPEDrpayoutdtls" runat="server" TargetControlID="hiddenTargetControlForModalPopup"
                                    PopupControlID="Panel1" BackgroundCssClass="modalBackground" Enabled="True" DropShadow="True"
                                    DynamicServicePath="" CancelControlID="btnCancel" />
                                <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup dataheaderPopup" Style="width: 99%;
                                    height: 475px; overflow: auto;" meta:resourcekey="Panel1Resource1">
                                    <div style="text-align: center;">
                                        Detail Report
                                    </div>
                                    <table border="1" id="GrdHeader" class="w-100p" runat="server" style="display: table">
                                        <tr class="dataheader1">
                                            <td runat="server" id="tdActionse" class="a-center w-8p">
                                                <asp:Label ID="lblpayblock" runat="server" Text="Payment Block"></asp:Label>
                                            </td>
                                            <td class="a-center w-5p">
                                                <asp:Label ID="lblUHID" runat="server" Text="UHID"></asp:Label>
                                            </td>
                                            <td class="a-center w-17p">
                                                <asp:Label ID="lblPatientName" runat="server" Text="Patient Name"></asp:Label>
                                            </td>
                                            <td class="a-center w-9p">
                                                <asp:Label ID="lblVisitNo" runat="server" Text="Visit Number"></asp:Label>
                                            </td>
                                            <td class="a-center w-23p">
                                                <asp:Label ID="lblServiceName" runat="server" Text="Service Name"></asp:Label>
                                            </td>
                                            <td id="Td1" runat="server" class="a-center w-8p">
                                                <asp:Label ID="lblBillAmount" runat="server" Text="Bill Amount"></asp:Label>
                                            </td>
                                            <td id="Td2" runat="server" class="a-center w-7p">
                                                <asp:Label ID="lblDiscount" runat="server" Text="Discount" meta:resourcekey="LabelclResource1"></asp:Label>
                                            </td>
                                            <td id="Td3" runat="server" class="a-center w-11p">
                                                <asp:Label ID="lblNetAmount" runat="server" Text="Net Amount" meta:resourcekey="LabelclResource1"></asp:Label>
                                            </td>
                                            <td id="Td4" runat="server" class="a-center w-35p">
                                                <asp:Label ID="lblRemarks" runat="server" Text="Remarks" meta:resourcekey="Rs_TrackIdResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="w-100p">
                                        <tr class="w-100p">
                                            <td>
                                                <div id="divgv">
                                                    <asp:GridView ID="gvFianalDtls" runat="server" CellPadding="1" AutoGenerateColumns="False"
                                                        CssClass="w-100p" ItemStyle-VerticalAlign="Top" HeaderStyle-CssClass="grdHeader"
                                                        DataKeyNames="Finalbillid,Finalbillblock" RepeatDirection="Horizontal" meta:resourcekey="grdResultResource1"
                                                        OnRowDataBound="gvFianalDtls_RowDataBound" ShowFooter="true">
                                                        <Columns>
                                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                                <ItemTemplate>
                                                                    <table id="parentgrid" runat="server" class="w-100p a-left">
                                                                        <tr id="Tr1" runat="server">
                                                                            <td class="a-center w-9p">
                                                                                <asp:CheckBox ID="chkblock" runat="server" onclick="CalNetAmount(event,this.id);" />
                                                                            </td>
                                                                            <td class="a-left w-5p">
                                                                                <asp:Label ID="lbldPatientNumber" runat="server" Text='<%# Bind("PatientNumber") %>'></asp:Label>
                                                                            </td>
                                                                            <td id="PatientName" class="a-left w-18p" runat="server">
                                                                                <%# DataBinder.Eval(Container.DataItem, "PatientName")%>
                                                                            </td>
                                                                            <td id="Td16" class="a-left w-10p" nowrap="nowrap" runat="server">
                                                                                <asp:Label ID="lbldVisitNo" runat="server" Text='<%# Bind("VisitNumber") %>'></asp:Label>
                                                                                <asp:Label ID="lblfbid" runat="server" Visible="false" Text='<%# Bind("Finalbillid") %>'></asp:Label>
                                                                            </td>
                                                                            <td class="w-22p">
                                                                                <asp:Label ID="lbldServiceName" runat="server" Text='<%# Bind("Servicename") %>'></asp:Label>
                                                                            </td>
                                                                            <td class="a-right w-7p">
                                                                                <asp:Label ID="lbldBillAmount" runat="server" Text='<%# Bind("BillAmount") %>'></asp:Label>
                                                                            </td>
                                                                            <td class="a-right w-7p">
                                                                                <asp:Label ID="lbldDiscount" runat="server" Text='<%# Bind("BillDiscount") %>'></asp:Label>
                                                                            </td>
                                                                            <td class="a-right w-11p">
                                                                                <asp:Label ID="lbldNetAmount" runat="server" Text='<%# Bind("NetAmount") %>'></asp:Label>
                                                                            </td>
                                                                            <td class="a-left w-40p">
                                                                                <asp:TextBox ID="txtRemarks" CssClass="txtRRemarks" Text='<%# Bind("Remarks") %>' Enabled="false" runat="server"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <table>
                                        <tr>
                                            <td class="a-center w-8p">
                                            </td>
                                            <td class="a-left w-5p">
                                            </td>
                                            <td class="a-left w-17p">
                                            </td>
                                            <td class="a-left w-9p">
                                            </td>
                                            <td class="a-right w-23p">
                                            </td>
                                            <td class="a-right w-8p">
                                            </td>
                                            <td class="a-right w-7p">
                                                <asp:Label ID="Label6" runat="server" Text="Total" meta:resourcekey="LabelclResource1"></asp:Label>
                                            </td>
                                            <td class="a-right w-11p">
                                                <asp:Label ID="lblTotNetAmount" runat="server" meta:resourcekey="LabelclResource1"></asp:Label>
                                            </td>
                                            <td class="a-right w-35p">
                                            </td>
                                        </tr>
                                    </table>
                                    <div style="text-align: center;">
                                        <asp:Button ID="btnAddDisc" Text="Save" runat="server" class="btn" OnClick="btnAdd_click" />
                                        <input type="button" id="btnCancel" value="Cancel" runat="server" class="btn" />
                                    </div>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <input type="hidden" id="hdnPhysicianID" runat="server" value="0" />
                    <input type="hidden" id="hdnRowIndex" runat="server" />
                    <input type="hidden" id="hdnfinallist" runat="server" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>

<script type="text/javascript">
    function DatePickUP() {
        $(function() {
            $("#txtFrom").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                    $("#txtTo").datepicker("option", "minDate", selectedDate);
                    var date = $("#txtFrom").datepicker('getDate');
                }
            });
            $("#txtTo").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                    $("#txtFrom").datepicker("option", "maxDate", selectedDate);
                }
            })
        });
    }

</script>

<script type="text/javascript">
    if (typeof DatePickUP == 'function')
        Sys.Application.add_load(DatePickUP);  </script>

