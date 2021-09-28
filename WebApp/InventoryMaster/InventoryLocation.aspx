<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InventoryLocation.aspx.cs"
    Inherits="Inventory_InventoryLocation" meta:resourcekey="PageResource1" %>


<%@ Register Src="~/InventoryCommon/Controls/ProductSearch.ascx" TagName="ProductSearch" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Inventory Location</title>
 </head>
 
<body oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/InventoryMaster/Webservice/InventoryMaster.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <div class="w-97p marginauto card-md card-md-default padding10">
                          <asp:Label ID="lblmsg" runat="server" Font-Bold ="True" Font-Size="Larger" meta:resourcekey="lblmsgResource1" ></asp:Label>
                           <table class="w-100p">
                            <tr class="lh35">
                                <td>
                                    <asp:HiddenField ID="hdnLocationID" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdnStatus" runat="server" />
                                    <asp:HiddenField ID="hdnSelLocationID" runat="server" Value="0" />
                                    <asp:Label ID="lblOrganisation" runat="server" Text="Organisation Address : " CssClass="bold" meta:resourcekey="lblOrganisationResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="drpOrgAddress" CssClass="small" runat="server" meta:resourcekey="drpOrgAddressResource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="lblLocation" runat="server" Text="Location Name : "  CssClass="bold"
                                        meta:resourcekey="lblLocationResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this)" ID="txtLocation" runat="server" CssClass="small" 
                                    meta:resourcekey="txtLocationResource1" ></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblLocation2" runat="server" Text="Location Type : " CssClass="bold"
                                        meta:resourcekey="lblLocation2Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlLocationType" runat="server" onchange="fnChange();" CssClass="medium" meta:resourcekey="ddlLocationTypeResource1">
                                    </asp:DropDownList>
                                </td>
                                <td class="w-134">
                                    <asp:Label ID="lblTinNO" runat="server" Text="Tin No : " CssClass="bold"
                                        meta:resourcekey="lblTinNOResource1"></asp:Label>
                                </td>
                                <td>
                                   <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtTinNo" CssClass="small" MaxLength="48" runat="server" 
                                        meta:resourcekey="txtTinNoResource1"></asp:TextBox>
                                </td>
                                
                            </tr>
                            <tr class="lh25">
                                <td>
                                    <asp:Label ID="lblDLNO" runat="server" Text="DL No : " CssClass="bold"
                                        meta:resourcekey="lblDLNOResource1"></asp:Label>
                                </td>
                                <td>
                                     <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtDLNO" CssClass="small" MaxLength="48" runat="server" 
                                         meta:resourcekey="txtDLNOResource1"></asp:TextBox>
                                </td>
                            
                                <td id="tdActive" runat="server" class="hide">
                                   <asp:Label ID="lblActive" runat="server" Text="Active : " CssClass="bold"
                                        meta:resourcekey="lblActiveResource1"></asp:Label>
                                </td>
                                <td id="tdChkActive" runat="server" class="hide">
                                   <asp:CheckBox runat="server" ID="chkStatus" meta:resourcekey="chkStatusResource1" />
                                </td>
                                <td id="tdParent" runat="server">
                                    <asp:Label ID="lblParent" runat="server" CssClass="bold" Text="Is Parent" meta:resourcekey="lblParentResource1"></asp:Label>
                                </td>
                                <td id="tdChkParent" runat="server">
                                    <asp:CheckBox runat="server" ID="chkParent" OnClick="fnCheck(this.id)" meta:resourcekey="chkParentResource1" />
                                </td>
                                <td id="tdTxtParent" runat="server" class="hide" colspan="2">
                                <asp:Label ID="lblParentLoc"  Text="Parent Location" runat="server" CssClass="bold w-134" meta:resourcekey="lblParentLocResource1"></asp:Label>
                                    <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtParentLocation" runat="server" CssClass="small" meta:resourcekey="txtParentLocationResource1"></asp:TextBox>
                                    <ajc:AutoCompleteExtender ID="AutoCompleteParentLoc" runat="server" TargetControlID="txtParentLocation"
                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                        OnClientItemSelected="SelectParent" MinimumPrefixLength="1" CompletionInterval="1"
                                        FirstRowSelected="True" ServiceMethod="GetParentLocation" ServicePath="~/InventoryMaster/Webservice/InventoryMaster.asmx"
                                        DelimiterCharacters="" Enabled="True">
                                    </ajc:AutoCompleteExtender>
                                </td>
                            </tr>
                               <tr>
                                   <td colspan="8" class="a-center">
                                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="btn marginR30"
                                            OnClientClick="javascript:return ValidateFields();"  meta:resourcekey="btnSaveResource1" />
                                        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="cancel-btn" OnClientClick="javascript:return ClearFields();"
                                            meta:resourcekey="btnClearResource1" />
                                    </td>
                               </tr>
                        </table>
                        </div>
                        <ul class="marginT10">
                            <li class="w-100p">
                                
                                <asp:Button ID="btngetValues" OnClick="btnGetItems" CssClass="btn hide" runat="server" 
                                    meta:resourcekey="btngetValuesResource1" />
                                <div class=" w-99p marginauto">
                                    <asp:GridView ID="gvLocation" runat="server" OnRowDataBound="gvLocation_RowDataBound"
                                    AutoGenerateColumns="False" CssClass="responstable w-100p fixResponsTable"
                                    meta:resourcekey="gvLocationResource1">
                                    <Columns>
                                    <asp:TemplateField HeaderText="SL No." meta:resourcekey="TemplateFieldResource1">
                                         <ItemTemplate>
                                          <%#Container.DataItemIndex+1 %>
                                          </ItemTemplate> 
                                          </asp:TemplateField> 
                                        <asp:BoundField DataField="OrgAddressName" HeaderText="Location Name" 
                                            meta:resourcekey="BoundFieldResource1" />
                                        <asp:BoundField DataField="LocationTypeCode" HeaderText="Type Code" 
                                            meta:resourcekey="BoundFieldResource2" />
                                        <asp:BoundField DataField="TINNO" HeaderText="Tin No" 
                                            meta:resourcekey="BoundFieldResource3" />
                                        <asp:BoundField DataField="DLNO" HeaderText="DL No" 
                                            ItemStyle-HorizontalAlign="Center" meta:resourcekey="BoundFieldResource4">
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Active Status" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Left"
                                            HeaderStyle-HorizontalAlign="Left" 
                                            meta:resourcekey="TemplateFieldResource2">
                                            <ItemTemplate>
                                                <asp:Label ID="lblIsActive" Text='<%# Bind("IsActive") %>' runat="server" meta:resourcekey="lblIsActiveResource1"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Left" Width="10%"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Left"
                                            HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource3">
                                            <ItemTemplate>
                                                <a name="lnkEdit" class="cursor" onclick='AssignValues(&#039;<%# Eval("LocationInfo") %>&#039;)'>
                                                    <asp:Label ID="lblEdit" runat="server" ToolTip="Click to Edit" class="pull-left marginR10 ui-icon ui-icon-pencil cursor"></asp:Label>&nbsp;&nbsp;</a>
                                                <a id="lnk" name="lnkDelete" runat="server" class="pointer bluecolor">
                                                    <asp:Label ID="lblDelete" runat="server" ToolTip="Click to Delete" class="pull-left marginL10 ui-icon ui-icon-trash cursor"></asp:Label></a>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="gridHeader"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Left" Width="10%"></ItemStyle>
                                        </asp:TemplateField>
                                    </Columns>
                                    <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="responstableHeader fixTableHeader" />
                                </asp:GridView>
                                </div>
                            </li>
                        </ul>
                        <div>
                            <table id="tblGrid">
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <br />
                     
                    </div>
                         <asp:HiddenField ID ="hdnMessages" runat ="server" />
                         <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
<script type="text/javascript" src="../PlatForm/Scripts/tableFixedHeader.js"></script>
<script type="text/javascript" language="javascript">
    var userMsg;



    function isSpclChar(e) {
        var key;
        var isCtrl = false;

        if (window.event) // IE8 and earlier
        {
            key = e.keyCode;
        }
        else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
        {
            key = e.which;
        }

        if ((key >= 48 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32)) {
            isCtrl = true;
        }

        return isCtrl;
    }


    function ClearFields() {
        document.getElementById('txtLocation').value = '';
        document.getElementById('ddlLocationType').value = 0;
        document.getElementById('drpOrgAddress').value = 0;
        document.getElementById('hdnLocationID').value = '';
        document.getElementById('lblmsg').innerHTML = '';
        //document.getElementById('btnSave').value = 'Save';
        var chkbox = document.getElementById("chklistProductType");
        //document.getElementById('tdActive').style.display = 'hide';
        //document.getElementById('tdChkActive').style.display = 'hide';
        $('#tdActive').removeClass().addClass('hide');
        $('#tdChkActive').removeClass().addClass('hide');
        var chkst = document.getElementById("chkStatus");
        chkst.checked = false;
        $('#txtTinNo').val('');
        $('#txtDLNO').val('');
        return false;

    }

    function ValidateFields() {
        var flag = 0;

        if (document.getElementById('drpOrgAddress').value == 0) {
            var userMsg = SListForAppMsg.Get('InventoryMaster_InventoryLocation_aspx_SelectOrgAddress');
            var errorMsg = SListForAppMsg.Get('InventoryMaster_Error');
            if (userMsg != null && errorMsg != null) {
                ValidationWindow(userMsg, errorMsg);
            }
            else {
                ValidationWindow("Select the OrgAddress name", "Alert");
            }
            document.getElementById('drpOrgAddress').focus();
            flag = 1;
            return false;
        }
        if ((document.getElementById('txtLocation').value).trim() == '') {
            var userMsg = SListForAppMsg.Get('InventoryMaster_InventoryLocation_aspx_ProvideLocation');
            var errorMsg = SListForAppMsg.Get('InventoryMaster_Error');
            if (userMsg != null && errorMsg != null) {
                ValidationWindow(userMsg, errorMsg);
            }
            else {
                ValidationWindow("Provide the location name", "Alert");
            }
            document.getElementById('txtLocation').value = '';
            document.getElementById('txtLocation').focus();
            flag = 1;
            return false;
        }
        if (document.getElementById('ddlLocationType').value == 0) {
            var userMsg = SListForAppMsg.Get('InventoryMaster_InventoryLocation_aspx_SelectLocation');
            var errorMsg = SListForAppMsg.Get('InventoryMaster_Error');
            if (userMsg != null && errorMsg != null) {
                ValidationWindow(userMsg, errorMsg);
            }
            else {
                ValidationWindow("Select the location type", "Alert");
            }
            document.getElementById('ddlLocationType').focus();
            if (flag == 1) {
                document.getElementById('txtLocation').focus();
            }
            return false;
        }
        //Commented by Annapoorani

        //            if ($.trim($('#txtTinNo').val()) == '') {
        //                var userMsg = SListForAppMsg.Get('InventoryMaster_InventoryLocation_aspx_EnterTin');
        //                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error');
        //                if (userMsg != null && errorMsg != null) {
        //                    ValidationWindow(userMsg, errorMsg);
        //                }
        //                else {
        //                    ValidationWindow("Enter Tin NO", "Error");
        //                }
        //                $('#txtTinNo').focus();
        //                return false;
        //            }
        //            
        //            if ($.trim($('#txtDLNO').val()) == '') {
        //                var userMsg = SListForAppMsg.Get('InventoryMaster_InventoryLocation_aspx_EnterDrug');
        //                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error');
        //                if (userMsg != null && errorMsg != null) {
        //                    ValidationWindow(userMsg, errorMsg);
        //                }
        //                else {
        //                    ValidationWindow("Enter Drug Licence NO", "Error");
        //                }

        //                $('#txtDLNO').focus();
        //                return false;
        //            }

        if (document.getElementById('chkParent').checked == true) {
            if ($("#hdnSelLocationID").val() == "" || $("#hdnSelLocationID").val() == 0) {
                $("#txtParentLocation").val('');
                $("#txtParentLocation").focus();
                var userMsg = SListForAppMsg.Get('InventoryMaster_InventoryLocation_aspx_02');
                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error');
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                }
                else {
                    ValidationWindow("Selected Parent Location is not Available.!", "Error");
                }
//                ValidationWindow('', 'Alert');
                return false;
            }
        }
        var userMsg = SListForAppDisplay.Get('InventoryMaster_InventoryLocation_aspx_Save') == null ? "Save" : SListForAppDisplay.Get('InventoryMaster_InventoryLocation_aspx_Save');
        if (document.getElementById('btnSave').value == userMsg)
            document.getElementById('hdnLocationID').value = 0;
    }

    function AssignValues(info) {
        ClearFields();
        var x = info.split('~');
        document.getElementById('lblmsg').innerHTML = '';
        document.getElementById('hdnLocationID').value = x[0];
        document.getElementById('txtLocation').value = x[1];
        document.getElementById('ddlLocationType').value = x[2];
        document.getElementById('drpOrgAddress').value = x[6];
        if (x[11] != '' && x[11] != '0') {
            chkParent.checked = true;
            //$("#txtParentLocation").val(x[11])
            document.getElementById('txtParentLocation').value = x[11];
            $('#hdnSelLocationID').val(x[12]);
            $('#tdTxtParent').removeClass('hide').addClass('displaytd');
        }
        var status = (document.getElementById('hdnStatus').value = x[5]);
        if (x[9] != '' && x[9] != '0') {
            $('#txtTinNo').val(x[9]);
        }
        if (x[10] != '' && x[10] != '0') {
            $('#txtDLNO').val(x[10]);
        }
        var y1 = x[3].split(',');
        var y = x[4].split(',');
        var l = y.length;

        //document.getElementById('tdActive').style.display = 'table-cell';
        //document.getElementById('tdChkActive').style.display = 'table-cell';
        $('#tdActive').removeClass('hide').addClass('displaytd');
        $('#tdChkActive').removeClass('hide').addClass('displaytd');
        var chkst = document.getElementById("chkStatus");
        if (status == 'Y') {
            chkst.checked = true;
            document.getElementById('chkStatus').visible = false;
        }
        else {
            chkst.checked = false;
            document.getElementById('chkStatus').visible = true;
        }
        var userMsg = SListForAppDisplay.Get('InventoryMaster_InventoryLocation_aspx_Update');
        document.getElementById('btnSave').value = userMsg == null ? 'Update' : userMsg;
        return false;
    }

    function DeleteValues(info) {
        ClearFields();
        var x = info.split('~');
        //            if (x[8] == 1) {
        //                var userMsg = SListForAppMsg.Get('InventoryMaster_InventoryLocation_aspx_LocationCannotMap') == null ? "This location cannot be deleted as there are one or more products that are mapped & used with this location" : SListForAppMsg.Get('InventoryMaster_InventoryLocation_aspx_LocationCannotMap');
        //                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Error" : errorMsg;
        //                ValidationWindow(userMsg, errorMsg);
        //                return false;
        //            }
        document.getElementById('lblmsg').innerHTML = '';
        var hdnID = document.getElementById('hdnLocationID').value = x[0];
        var cnfm = null;
        if (x[8] != 0) {
            var userMsg = SListForAppMsg.Get('InventoryMaster_InventoryLocation_aspx_ConfirmMessage') == null ? "Are you sure you want to delete this?" : SListForAppMsg.Get('InventoryMaster_InventoryLocation_aspx_ConfirmMessage');
            var informMsg = SListForAppMsg.Get('InventoryMaster_Information') == null ? "Information" : SListForAppMsg.Get('InventoryMaster_Information');
            var okMsg = SListForAppMsg.Get('InventoryMaster_Ok') == null ? "Ok" : SListForAppMsg.Get('InventoryMaster_Ok');
            var cancelMsg = SListForAppMsg.Get('InventoryMaster_Cancel') == null ? "Cancel" : SListForAppMsg.Get('InventoryMaster_Cancel');
            cnfm = ConfirmWindow(userMsg, informMsg, okMsg, cancelMsg);
        }

        // var cnfm = confirm("Are you sure you want to delete this?");
        if (cnfm == true || x[8] == 0) {
            Attune.Kernel.InventoryMaster.InventoryMaster.DeleteLocation(hdnID);
            //                document.getElementById('lnkDelete').disable = true;
            document.getElementById('btngetValues').click();
        }

    }

    function Visible(info) {

        var x = info.split('~');
        document.getElementById('lblmsg').innerHTML = '';
        var status = (document.getElementById('hdnStatus').value = x[5]);
        if (status == 'Y') {
            document.getElementById('lnkDelete').disable = false;

        }
        else {
            document.getElementById('lnkDelete').disable = true;

        }
    }
    function validorgaddress() {
        if (document.getElementById('drpOrgAddress').value == 0) {
            var userMsg = SListForAppMsg.Get('InventoryMaster_InventoryLocation_aspx_SelectOrg') == null ? "Select the Org Address" : SListForAppMsg.Get('InventoryMaster_InventoryLocation_aspx_SelectOrg');
            var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Alert" : SListForAppMsg.Get('InventoryMaster_Error');

            ValidationWindow(userMsg, errorMsg);
            return false;


        }

    }
    function SelectParent(source, eventArgs) {
        var PColval = eventArgs.get_value().split('~');
        document.getElementById('hdnSelLocationID').value = PColval[0];
        document.getElementById('txtParentLocation').value = PColval[1];
    }
    function fnCheck(objId) {
        if (document.getElementById(objId).checked == true) {
            $('#tdTxtParent').removeClass().addClass('displaytd');
        }
        else if (document.getElementById(objId).checked == false) {
            $('#tdTxtParent').removeClass().addClass('hide');
            $('#txtParentLocation').val('');
            $('#hdnSelLocationID').val('0');
        }
    }
    function fnChange() {
        if ($('#ddlLocationType').val() == '2' || $('#ddlLocationType').val() == '3') {
            document.getElementById('chkParent').checked = true;
            $('#tdTxtParent').removeClass('hide').addClass('displaytd');
        }
        else {
            $('#chkParent').removeAttr("checked");
            $('#tdTxtParent').removeClass('displaytd').addClass('hide');
        }
    }
    window.onload = ValidateAutoComplete;
    function ValidateAutoComplete() {

        $find('<%=AutoCompleteParentLoc.ClientID %>')._onMethodComplete = function(result, context) {

            $find('<%=AutoCompleteParentLoc.ClientID %>')._update(context, result, /* cacheResults */false);

            PackageAutoComplete(result, context);
        };
    }
    function PackageAutoComplete(result, context) {
        if (result == "") {
            var userMsg = SListForAppMsg.Get('InventoryMaster_InventoryLocation_aspx_01') != null ? SListForAppMsg.Get('InventoryMaster_InventoryLocation_aspx_01') : "Free Text not allowed";
            $('#txtParentLocation').val("");
            ValidationWindow(userMsg, errorMsg);
        }
    } 
    $(document).ready(function() {
        recallscroll();
        $("#gvLocation").tableHeadFixer({ height: 400, tableHead: false });
    });
    </script>
</html>
