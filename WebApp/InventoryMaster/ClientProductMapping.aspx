<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClientProductMapping.aspx.cs"
    Inherits="InventoryMaster_ClientProductMapping" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Client Product Mapping</title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table class="searchPanel w-100p">
            <tr>
                <td>
                    <table class="w-100p">
                        <tr>
                            <td>
                                <span>
                                    <asp:Label ID="lblPrd" runat="server" Text="Product Name :" meta:resourcekey="lblPrdResource1" />
                                </span>
                                <asp:TextBox ID="txtProductName" CssClass="small" runat="server" onkeyup="ClearMainDatas(this);"
                                    meta:resourcekey="txtProductNameResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoGname1" runat="server" TargetControlID="txtProductName"
                                    ServiceMethod="GetAllProducts" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                    EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="30" OnClientItemSelected="IAmSelected"
                                    DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected" Enabled="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                            <td>
                                <span>
                                    <asp:Label ID="lblclie" runat="server" Text="Client Name :" meta:resourcekey="lblclieResource1" />
                                </span>
                                <asp:TextBox ID="txtClientName" CssClass="small" runat="server" onkeyup="ClearMainDatas(this);"
                                    meta:resourcekey="txtClientNameResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientName"
                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                    MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetHospAndRefPhy"
                                    ServicePath="~/PlatForm/CommonWebServices/CommonServices.asmx" DelimiterCharacters=""
                                    OnClientItemSelected="ClientSelected" Enabled="True" UseContextKey="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                            <td>
                                <span>
                                    <asp:Label ID="lblQt" runat="server" Text="Qty :" meta:resourcekey="lblQtResource1" />
                                </span>
                                <asp:TextBox ID="txtQty" CssClass="mini" runat="server" onkeydown="return validatenumber(event);"
                                    meta:resourcekey="txtQtyResource1"></asp:TextBox>
                            </td>
                            <td>
                                <span>
                                    <asp:Label ID="lblTy" runat="server" Text="Type :" meta:resourcekey="lblTyResource1" />
                                </span>
                                <asp:DropDownList ID="ddlType" CssClass="auto" runat="server" onblur="LoadNoofDays()">                                   
                                </asp:DropDownList>
                            </td>
                            <td>
                                <span>
                                    <asp:Label ID="Label2" runat="server" Text="Value :" meta:resourcekey="lblValue" />
                                </span>
                                <asp:TextBox ID="txtNoofDays" CssClass="mini" runat="server" onkeydown="javascript:return validatenumber(event);" MaxLength="3" />
                                   
                            </td>
                            <td>
                                <asp:CheckBox ID="chkISActive" Checked="True" runat="server" Text="Active" meta:resourcekey="chkISActiveResource1" />
                            </td>
                            <td>
                                <asp:Button ID="btnSave" CssClass="btn" Text=" Save " runat="server" OnClientClick="javascript:return Validate(this);"
                                    OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                <asp:Button ID="btnSearch" CssClass="btn" Text=" Search " runat="server" OnClick="btnSearch_Click"
                                    meta:resourcekey="btnSearchResource1" />
                                <asp:Button ID="btnClear" CssClass="btn" Text="Clear" runat="server" OnClientClick="javascript:return ClearFields(this);"
                                    meta:resourcekey="btnClearResource1" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table id="tableClientMapping" class="gridView w-100p">
                        <asp:Repeater ID="rpClientProductMapping" runat="server" OnItemDataBound="rpClientProductMapping_ItemDataBound">
                            <HeaderTemplate>
                                <tr class="gridHeader">
                                    <td>
                                        <asp:Label ID="lblPrd" runat="server" Text="S.No" meta:resourcekey="lblPrdResource2" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblSelect" runat="server" Text="Select" meta:resourcekey="lblSelectResource1" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblName" runat="server" Text="Product Name" meta:resourcekey="lblNameResource1" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblClient" runat="server" Text="Client Name" meta:resourcekey="lblClientResource1" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblQty" runat="server" Text="Qty" meta:resourcekey="lblQtyResource1" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblActive" runat="server" Text="Active" meta:resourcekey="lblActiveResource1" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblType" runat="server" Text="Restriction Type" meta:resourcekey="lblTypeResource1" />
                                    </td>
                                     <td>
                                        <asp:Label ID="Label3" runat="server" Text="Value" meta:resourcekey="lblValue"  />
                                    </td>
                                </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <asp:Literal ID="lisno" runat="server" meta:resourcekey="lisnoResource1"></asp:Literal>
                                    </td>
                                    <td>
                                        <span id="spanClientRow" runat="server" class="hide" />
                                        <input type="radio" id="temp" onclick="SetRowValue(this);" />
                                    </td>
                                    <td>
                                        <asp:Literal ID="liProductName" runat="server" meta:resourcekey="liProductNameResource1"></asp:Literal>
                                    </td>
                                    <td>
                                        <asp:Literal ID="liClientName" runat="server" meta:resourcekey="liClientNameResource1"></asp:Literal>
                                    </td>
                                    <td>
                                        <asp:Literal ID="liQty" runat="server" meta:resourcekey="liQtyResource1"></asp:Literal>
                                    </td>
                                    <td>
                                        <asp:Literal ID="liIsActive" runat="server" meta:resourcekey="liIsActiveResource1"></asp:Literal>
                                    </td>
                                    <td>
                                        <asp:Literal ID="liRestrictionType" runat="server" meta:resourcekey="liRestrictionTypeResource1"></asp:Literal>
                                    </td>
                                     <td>
                                        <asp:Literal ID="liNoofDrugs" runat="server"></asp:Literal>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                    <center id="cError" runat="server" class="hide">
                        <b>
                            <asp:Label ID="Label1" runat="server" Text="No Matches Found!!!" 
                            meta:resourcekey="Label1Resource1" />
                        </b>
                    </center>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnProductID" runat="server" />
        <asp:HiddenField ID="hdnProductName" runat="server" />
        <asp:HiddenField ID="hdnClientID" runat="server" />
        <asp:HiddenField ID="hdnClientName" runat="server" />
        <asp:HiddenField ID="hdnMappingID" runat="server" />
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>

<script type="text/javascript">
    function IAmSelected(source, eventArgs) {
        var varGetVal = eventArgs.get_value();
        var ProductID;
        var Productname;
        var list = eventArgs.get_value().split('~');
        if (list.length > 0) {
            ProductID = list[1];
            $('#hdnProductID').val(ProductID)
            $('#hdnProductName').val($('#txtProductName').val());
        }
    }

    function ClientSelected(source, eventArgs) {
        var varGetVal = eventArgs.get_value();
        var ClientID = 0;
        ClientID = eventArgs.get_value();
        $('#hdnClientID').val(ClientID)
    }

    function SetRowValue(ele) {
        $("[id$='tableClientMapping'] tbody  tr td input:radio").each(function() {
            $(this).prop('checked', false)
        });
        $(ele).prop('checked', true)
        $('#btnSave').val('Update');
        $('#hdnProductName').val($(ele).prev('span').attr('PName'));
        $('#txtProductName').val($(ele).prev('span').attr('PName'));
        $('#hdnProductID').val($(ele).prev('span').attr('PID'));

        $('#hdnClientName').val($(ele).prev('span').attr('CName'));
        $('#txtClientName').val($(ele).prev('span').attr('CName'));
        $('#hdnClientID').val($(ele).prev('span').attr('CID'));

        $('#txtQty').val($(ele).prev('span').attr('QTY'));
        $('#ddlType').val($(ele).prev('span').attr('Type'));

        if ($(ele).prev('span').attr('IS') == 'Y') {
            $('#chkISActive').prop('checked', true)
        }
        $('#hdnMappingID').val($(ele).prev('span').attr('MID'));
        $('#txtProductName').attr('disabled', 'disabled');
        $('#txtNoofDays').val($(ele).prev('span').attr('NoofDays'));
        LoadNoofDays();
    }

    function ClearFields(ele) {
        $("[id$='tableClientMapping'] tbody  tr td input:radio").each(function() {
            $(this).attr('checked', false);
        });
        $('#btnSave').val('Save');
        $('#hdnProductName').val('');
        $('#txtProductName').val('');
        $('#hdnProductID').val('');
        $('#hdnClientName').val('');
        $('#txtClientName').val('');
        $('#hdnClientID').val('');
        $('#txtQty').val('');
        $('#ddlType').val(0);
        $('#chkISActive').attr('checked', false);
        $('#hdnMappingID').val('');
        $('#txtProductName').attr('disabled', false);
        $('#txtNoofDays').val('');
        return false;
    }

    function Validate(ele) {
        var errorMsg = SListForAppMsg.Get('InventoryMaster_Error');

        if ($('#hdnProductID').val() == '') {
            var userMsg = SListForAppMsg.Get('InventoryMaster_ClientProductMapping_aspx_Product');

            if (userMsg != null && errorMsg != null) {
                ValidationWindow(userMsg, errorMsg);
            }
            else {
                ValidationWindow("Please Enter Product Name", "Alert");
            }
            return false;
        }

        if ($('#hdnClientID').val() == '') {
            var userMsg = SListForAppMsg.Get('InventoryMaster_ClientProductMapping_aspx_ClientName');

            if (userMsg != null && errorMsg != null) {
                ValidationWindow(userMsg, errorMsg);
            }
            else {
                ValidationWindow("Please Enter ClientName Name", "Alert");
            }

            return false;
        }

        if ($('#txtQty').val() == '') {
            var userMsg = SListForAppMsg.Get('InventoryMaster_ClientProductMapping_aspx_Qty');

            if (userMsg != null && errorMsg != null) {
                ValidationWindow(userMsg, errorMsg);
            }
            else {
                ValidationWindow("Please Enter Qty", "Alert");
            }

            return false;
        }

        if ($('#ddlType').val() == 0) {
            var userMsg = SListForAppMsg.Get('InventoryMaster_ClientProductMapping_aspx_Type');

            if (userMsg != null && errorMsg != null) {
                ValidationWindow(userMsg, errorMsg);
            }
            else {
                ValidationWindow("Please Select Type", "Alert");
            }

            return false;
        }
        if ($('#txtNoofDays').val() == '' && $('#ddlType').val()!='V') {
            var userMsg = SListForAppMsg.Get('InventoryMaster_ClientProductMapping_aspx_NoofDays');

            if (userMsg != null && errorMsg != null) {
                ValidationWindow(userMsg, errorMsg);
            }
            else {
                ValidationWindow("Please Enter No of Days", "Alert");
            }

            return false;
        }
        $('#txtNoofDays').val() = $('#txtNoofDays').val() == "" ? 1 : $('#txtNoofDays').val();
    }

    function ClearMainDatas(ele) {
        if ($.trim($(ele).val()) == '') {
            ClearFields(ele);
            LoadNoofDays();
        }
    }
    function LoadNoofDays() {
        switch ($('#ddlType').val()) {
            case "Y":
                $('#txtNoofDays').prop('readonly', true);
                $('#txtNoofDays').attr('onkeypress', 'return false');
                $('#txtNoofDays').val(365);
                break;
            case "M":
                $('#txtNoofDays').prop('readonly', true);
                $('#txtNoofDays').attr('onkeypress', 'return false');
                $('#txtNoofDays').val(30);
                break;
            case "W":
                $('#txtNoofDays').prop('readonly', true);
                $('#txtNoofDays').attr('onkeypress', 'return false');
                $('#txtNoofDays').val(7);
                break;
            case "D":
                $('#txtNoofDays').prop('readonly', false);
                $('#txtNoofDays').removeAttr('onkeypress');
                $('#txtNoofDays').val(1);
                break;
            case "V":
                $('#txtNoofDays').prop('readonly', true);
                $('#txtNoofDays').attr('onkeypress', 'return false');              
                $('#txtNoofDays').val(1);
                break;
            case "H":
                $('#txtNoofDays').prop('readonly', false);
                $('#txtNoofDays').removeAttr('onkeypress');
                $('#txtNoofDays').val(1);
                break;
            default:
                $('#txtNoofDays').prop('readonly', false);
                $('#txtNoofDays').removeAttr('onkeypress');
                $('#txtNoofDays').val(1);
                break;
        }    
    }
    
</script>

