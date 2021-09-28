<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StockReceive.aspx.cs" Inherits="CentralReceiving_StockReceive"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="~/InventoryCommon/Controls/INVAttributes.ascx" TagName="INVAttributes"
    TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Stock Receive</title>
</head>
<body>
    <form id="prFrm" runat="server" onkeydown="SuppressBrowserRefresh();SuppressBrowserBackspaceRefresh();">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table class="searchPanel w-100p">
            <tr>
                <td class="colorforcontent" colspan="5">
                    <div id="ACX2OPPmt1" class="hide" runat="server">
                        &nbsp;<img src="../PlatForm/Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                            style="cursor: pointer" onclick="showResponses('ACX2OPPmt1','ACX2minusOPPmt1','ACX2responsesOPPmt1',1);" />
                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2OPPmt1','ACX2minusOPPmt1','ACX2responsesOPPmt1',1);">
                            &nbsp;<%=Resources.CentralReceiving_ClientDisplay.CentralReceiving_StockReceive_aspx_01%></span>
                    </div>
                    <div id="ACX2minusOPPmt1" class="show" runat="server">
                        &nbsp;<img src="../PlatForm/Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                            style="cursor: pointer" onclick="showResponses('ACX2OPPmt1','ACX2minusOPPmt1','ACX2responsesOPPmt1',0);" />
                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2OPPmt1','ACX2minusOPPmt1','ACX2responsesOPPmt1',0);">
                            &nbsp;<%=Resources.CentralReceiving_ClientDisplay.CentralReceiving_StockReceive_aspx_01%></span>
                    </div>
                </td>
            </tr>
            <tr class="tablerow" id="ACX2responsesOPPmt1" runat="server">
                <td>
                    <div>
                        <table class="w-100p">
                            <tr>
                                <td class="defaultfontcolor">
                                    <asp:Label ID="lblFrom" Text="From Date" runat="server" meta:resourcekey="lblFromResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtFrom" runat="server" CssClass="small datePicker" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                        TabIndex="3" meta:resourcekey="txtFromResource1"></asp:TextBox>
                                </td>
                                <td class="defaultfontcolor">
                                    <asp:Label ID="lblTo" Text="To Date" runat="server" meta:resourcekey="lblToResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtTo" runat="server" CssClass="small datePicker" TabIndex="4" onKeyPress="return ValidateSpecialAndNumeric(this);"
                                        meta:resourcekey="txtToResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="defaultfontcolor">
                                    <asp:Label ID="Label1" Text="Supplier Name" runat="server" meta:resourcekey="Label1Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlSupplierList" runat="server" CssClass="small" TabIndex="5"
                                        meta:resourcekey="ddlSupplierListResource1">
                                    </asp:DropDownList>
                                </td>
                                <td class="defaultfontcolor">
                                    <asp:Label ID="Label2" Text="Purchase Order No" runat="server" meta:resourcekey="Label2Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtpurchaseordernos" runat="server" CssClass="small" onKeyPress="return ValidateMultiLangChar(this);"
                                        TabIndex="6" meta:resourcekey="txtpurchaseordernosResource1"></asp:TextBox>
                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                    <asp:Button runat="server" Text="Search" CssClass="btn" ID="btnSearch" OnClick="btnSearch_Click"
                                        TabIndex="7" meta:resourcekey="btnSearchResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <table class="w-100p">
                                        <tr>
                                            <td colspan="5">
                                                <div>
                                                    <asp:GridView ID="grdResult" runat="server" AllowPaging="True" CellPadding="3" AutoGenerateColumns="False"
                                                        DataKeyNames="OrderNo" EmptyDataText="Not Available Data" OnRowDataBound="grdResult_RowDataBound"
                                                        OnPageIndexChanging="grdResult_PageIndexChanging" PageSize="8" CssClass="gridView w-100p"
                                                        TabIndex="8" meta:resourcekey="grdResultResource1">
                                                        <HeaderStyle CssClass="gridHeader" />
                                                        <PagerStyle CssClass="gridPager" />
                                                        <Columns>
                                                            <asp:BoundField Visible="false" DataField="OrderId" HeaderText="Order No" meta:resourcekey="BoundFieldResource1" />
                                                            <asp:BoundField Visible="false" DataField="SupplierID" HeaderText="SupplierID" meta:resourcekey="BoundFieldResource2" />
                                                            <asp:TemplateField ItemStyle-Width="2%" HeaderText="Select" HeaderStyle-HorizontalAlign="Left"
                                                                meta:resourcekey="TemplateFieldResource1">
                                                                <ItemTemplate>
                                                                    <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="OrderSelect"
                                                                        meta:resourcekey="rdSelResource1" />
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                <ItemStyle Width="2%"></ItemStyle>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="OrderNo" HeaderText="Order No" HeaderStyle-HorizontalAlign="left"
                                                                ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource3">
                                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Left" Width="15%"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="SupplierName" Visible="true" HeaderText="Supplier" ItemStyle-Width="40%"
                                                                ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource4">
                                                                <ItemStyle HorizontalAlign="Left" Width="40%"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Comments" Visible="true" HeaderText="Comments" ItemStyle-Width="12%"
                                                                ItemStyle-HorizontalAlign="Center" meta:resourcekey="BoundFieldResource5">
                                                                <ItemStyle HorizontalAlign="Center" Width="12%"></ItemStyle>
                                                            </asp:BoundField>
                                                          
                                                            <asp:TemplateField HeaderText="Date">
                                                                <ItemTemplate>
                                                                    <span>
                                                                        <%#((DateTime)DataBinder.Eval(Container.DataItem, "OrderDate")).ToString(DateTimeFormat)%></span>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <br />
                                                </div>
                                                <div id="tdgo" class="a-center">
                                                    <asp:Button ID="btnGo" runat="server" Text="GO" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="return CheckPoNo();" OnClick="btnGo_Click"
                                                        Visible="False" TabIndex="9" meta:resourcekey="btnGoResource1" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <br />
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="poNoid" runat="server" />
    <asp:HiddenField ID="HdnPOno" runat="server" />
    <asp:HiddenField ID="hdnorderdate" runat="server" />
    <asp:HiddenField ID="SupID" runat="server" />
    <asp:HiddenField ID="hdnProductList" runat="server" />
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    </form>
</body>
</html>

<script src="Scripts/StockRecieve.js" type="text/javascript"></script>

<script src="../PlatForm/Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

<script type="text/javascript" language="javascript">

    function CalRounfOff() {
        // //debugger;
        var GrandwithRoundof = document.getElementById('txtGrandwithRoundof').value;
        var NetTotal = document.getElementById('txtNetTotal').value;
        var RoundOfValue = 0;
        UPresult = Math.ceil(Number(NetTotal));
        LOresult = Math.floor(Number(NetTotal));
        if (UPresult >= GrandwithRoundof && LOresult <= GrandwithRoundof) {
            if (GrandwithRoundof > NetTotal) {
                RoundOfValue = Number(GrandwithRoundof) - Number(NetTotal);
                document.getElementById('hdnRoundofType').value = 'UL';
            }
            if (GrandwithRoundof < NetTotal) {
                RoundOfValue = Number(NetTotal) - Number(GrandwithRoundof);
                document.getElementById('hdnRoundofType').value = 'LL';
            }
            document.getElementById('txtRoundOffValue').value = parseFloat(RoundOfValue).toFixed(2);
            return true;
        }
        else {
            document.getElementById('txtGrandwithRoundof').value = NetTotal;
            document.getElementById('txtRoundOffValue').value = 0.00;
            return true
        }


    }

    //        function CalRounfOff() {
    //            // //debugger;
    //            var GrandwithRoundof = document.getElementById('txtGrandwithRoundof').value;
    //            var NetTotal = document.getElementById('txtNetTotal').value;
    //            var RoundOfValue;
    //            UPresult = Math.ceil(Number(NetTotal));
    //            LOresult = Math.floor(Number(NetTotal));
    //            if (UPresult >= GrandwithRoundof && LOresult <= GrandwithRoundof) {

    //                if (GrandwithRoundof > NetTotal) {
    //                    RoundOfValue = Number(GrandwithRoundof) - Number(NetTotal);
    //                    document.getElementById('hdnRoundofType').value = 'UL';
    //                }
    //                if (GrandwithRoundof < NetTotal) {
    //                    RoundOfValue = Number(NetTotal) - Number(GrandwithRoundof);
    //                    document.getElementById('hdnRoundofType').value = 'LL';
    //                }
    //                document.getElementById('txtRoundOffValue').value = parseFloat(RoundOfValue).toFixed(2);
    //                return true;
    //            }
    //            else {
    //                alert('Provide Correct Rounded-Off Net Total');
    //                document.getElementById('txtGrandwithRoundof').value = 0.00;
    //                document.getElementById('txtGrandwithRoundof').focus();
    //                return false;
    //            }
    //        }

</script>

<script type="text/javascript" language="javascript">

    function Validate() {

        var userMsg = SListForAppMsg.Get('CentralReceiving_StockReceive_aspx_01');
        var cancelMsg = SListForAppMsg.Get('CentralReceiving_Cancel');
        var okMsg = SListForAppMsg.Get('CentralReceiving_OK');
        var informationMsg = SListForAppMsg.Get('CentralReceiving_Information');
        if (userMsg != null && cancelMsg != null && okMsg != null && informationMsg != null) {
            if (ConfirmWindow(userMsg, informationMsg, okMsg, cancelMsg) == false) {
                return false;
            }
            else {
                if (ConfirmWindow(" Do you want to continue !Click 'OK'", "Information", "Ok", "Cancel") == false) {
                    return false;
                }
            }


        } else {
            document.getElementById('btnCancel').focus();
            return true


        }
    }


    function KeyPress1(e) {
        var ddlaction = document.getElementById('ddlSupplier');
        if (ddlaction.visibility == "visible") {
            var Select = SListForAppDisplay.Get('CentralReceiving_StockReceive_aspx_02');
            if (Select == null) {
                Select = "--Select--";
            }
            if (ddlaction.options[ddlaction.selectedIndex].text == Select) {
                var userMsg = SListForAppMsg.Get('CentralReceiving_StockReceive_aspx_02') != null ? SListForAppMsg.Get('CentralReceiving_StockReceive_aspx_02') : "Select a Supplier";
                var errorMsg = SListForAppMsg.Get('CentralReceiving_Error') != null ? SListForAppMsg.Get('CentralReceiving_Error') : "Alert";
                ValidationWindow(userMsg, errorMsg);
                return false;
            }


            var Type = "DC";


            var s1val = ddlaction.options[ddlaction.selectedIndex].value + '~' + Type;
        }
        else {

            var Type = "DC";

            var s1val = document.getElementById('hdnSupplierID').value + '~' + Type;
        }
        $find('AutoCompleteDcNumber').set_contextKey(s1val);
    }

    function KeyPress2(e) {
        var ddlaction = document.getElementById('ddlSupplier');
        if (ddlaction.visibility == "visible") {
            var Select = SListForAppDisplay.Get('CentralReceiving_StockReceive_aspx_02');
            if (Select == null) {
                Select = "--Select--";
            }
            if (ddlaction.options[ddlaction.selectedIndex].text == Select) {
                var userMsg = SListForAppMsg.Get('CentralReceiving_StockReceive_aspx_02') != null ? SListForAppMsg.Get('CentralReceiving_StockReceive_aspx_02') : "Select a Supplier";
                var errorMsg = SListForAppMsg.Get('CentralReceiving_Error') != null ? SListForAppMsg.Get('CentralReceiving_Error') : "Alert";
                ValidationWindow(userMsg, errorMsg);
                return false;
            }

            var Type = "INVOICE";

            var s1val = ddlaction.options[ddlaction.selectedIndex].value + '~' + Type;
        }
        else {

            var Type = "INVOICE";

            var s1val = document.getElementById('hdnSupplierID').value + '~' + Type;
        }
        $find('AutoCompleteInvoiceNumber').set_contextKey(s1val);
    }

    function ChkDcSupplierCombination(source, eventArgs) {
        var supplierid = eventArgs.get_value();
        var ddl = document.getElementById('ddlSupplier');
        if (ddl.visibility == "visible") {
            if (supplierid == ddl.options[ddl.selectedIndex].value) {
                DCAlert();
            }
        }
        else {
            if (supplierid == document.getElementById('hdnSupplierID').value) {
                DCAlert();
            }
        }
    }

    function ChkInvoiceSupplierCombination(source, eventArgs) {
        var supplierid = eventArgs.get_value();
        var ddl = document.getElementById('ddlSupplier');
        if (ddl.visibility == "visible") {
            if (supplierid == ddl.options[ddl.selectedIndex].value) {
                InvoiceAlert();
            }
        }
        else {
            if (supplierid == document.getElementById('hdnSupplierID').value) {
                InvoiceAlert();
            }
        }
    }
    function DCAlert() {
        var userMsg = SListForAppMsg.Get('CentralReceiving_StockReceive_aspx_03');
        if (userMsg == null) {
            userMsg = "This combination of Supplier name & DC No Already exists. Do you want to continue!Click 'OK'";
        }
        var Information = SListForAppMsg.Get('CentralReceiving_Information');
        if (Information == null) {
            Information = 'Information';
        }
        var OkMsg = SListForAppMsg.Get('CentralReceiving_OK');
        if (OkMsg == null) {
            OkMsg = 'Ok';
        }
        var CancelMsg = SListForAppMsg.Get('CentralReceiving_Cancel');
        if (CancelMsg == null) {
            CancelMsg = 'Cancel';
        }


        if (userMsg != null && Information != null && OkMsg != null && CancelMsg != null) {
            var DC = ConfirmWindow(userMsg, Information, OkMsg, CancelMsg);
        }
        else {
            DC = ConfirmWindow("This combination of Supplier name & DC No Already exists. Do you want to continue!Click 'OK'", "Information", "Ok", "Cancel");
        }
        if (DC == true) {
            document.getElementById('txtInvoiceNo').focus();
        }
        else {
            document.getElementById('txtDCNumber').value = "";
            //document.getElementById('txtInvoiceNo').value = "";
        }
    }
    function InvoiceAlert() {
        var userMsg = SListForAppMsg.Get('CentralReceiving_StockReceive_aspx_04');
        if (userMsg == null) {
            userMsg = "This combination of Supplier name & Invoice No Already exists. Do you want to continue!Click 'OK'";
        }
        var Information = SListForAppMsg.Get('CentralReceiving_Information');
        if (Information == null) {
            Information = 'Information';
        }
        var OkMsg = SListForAppMsg.Get('CentralReceiving_OK');
        if (OkMsg == null) {
            OkMsg = 'Ok';
        }
        var CancelMsg = SListForAppMsg.Get('CentralReceiving_Cancel');
        if (CancelMsg == null) {
            CancelMsg = 'Cancel';
        }
        if (userMsg != null && Information != null && OkMsg != null && CancelMsg != null) {
            var Invoice = ConfirmWindow(userMsg, Information, OkMsg, CancelMsg);
        }
        else {
            Invoice = ConfirmWindow("This combination of Supplier name & Invoice No Already exists. Do you want to continue!Click 'OK'", "Information", "Ok", "Cancel");
        }
        if (Invoice == true) {
            document.getElementById('txtBatchNo').focus();
        }
        else {
            //document.getElementById('txtDCNumber').value = "";
            document.getElementById('txtInvoiceNo').value = "";
        }
    }



    //Only numbers and only one dot value allowed for diecimal
    function isNumerics(e, Id) {

        var key; var isCtrl; var flag = 0;
        var txtVal = document.getElementById(Id).value.trim();
        var len = txtVal.split('.');
        if (len.length > 1) {
            flag = 1;
        }
        if (window.event) {
            key = window.event.keyCode;
            if (window.event.shiftKey) {
                isCtrl = false;
            }
            else {
                if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
                    isCtrl = true;
                }
                else {
                    isCtrl = false;
                }
            }
        } return isCtrl;
    }

</script>

