<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddressControl.ascx.cs"
    Inherits="UserControl_AddressControl" %>
 <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<%--<script src="../Scripts/Common.js" type="text/javascript"></script>

<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />--%>

<script language="javascript" type="text/javascript">

    function inputOnlyNumbers(evt) {
        //debugger;
        var e = window.event || evt;
        var charCode = e.which || e.keyCode;
        if ((charCode > 47 && charCode < 58) || charCode == 8 || charCode == 9 || charCode == 46 || charCode == 37 || charCode == 39 || (charCode > 95 && charCode < 106)) {
            return true;
        }
        return false;
    }
    function expandTextBox(id) {
        document.getElementById(id).rows = "5";
        document.getElementById(id).cols = "20";
        ConverttoUpperCase(id);
    }
    function collapseTextBox(id) {
        document.getElementById(id).rows = "1";
        document.getElementById(id).cols = "20";
        ConverttoUpperCase(id);

    }
    //    function showUsercontrolothercouuntry() {
    //        var e = document.getElementById("ucPAdd_ddCountry");
    //        var strCountry = e.options[e.selectedIndex].text;
    //        if (strCountry == 'Others') {
    //            document.getElementById('ucPAdd_trusother').style.display = 'block'
    //        }
    //        else {
    //            document.getElementById('ucPAdd_trusother').style.display = 'none'
    //        }
    //    }
    //    function showUsercontrolotherState() {
    //        var e = document.getElementById("ucPAdd_ddState");
    //        var strCountry = e.options[e.selectedIndex].text;
    //        if (strCountry == 'Others') {
    //            document.getElementById('ucPAdd_trusother').style.display = 'block'
    //        }
    //        else {
    //            document.getElementById('ucPAdd_trusother').style.display = 'none'
    //        }
    //    }
    function showotherUCcouuntry(objCountry) {
        var parID = objCountry.split("_")[0];
        var e = document.getElementById(objCountry);
        var strCountry = e.options[e.selectedIndex].text;
        var strCountryValue = e.options[e.selectedIndex].value;
        document.getElementById(parID + "_tbCountry").style.display = 'none';
        document.getElementById(parID + "_tbState").style.display = 'none';
        document.getElementById(parID + "_txtOtherCountry").value = '';
        document.getElementById(parID + "_txtOtherState").value = '';
        if (strCountry.toUpperCase() == 'OTHERS') {
            document.getElementById(parID + "_tbCountry").style.display = 'block';
            document.getElementById(parID + "_tbState").style.display = 'block';
            document.getElementById(parID + "_txtOtherCountry").value = '';
            document.getElementById(parID + "_txtOtherState").value = '';
        }
        else if (strCountry.toUpperCase() != 'OTHERS') {
            document.getElementById(parID + "_tbState").style.display = 'block';
            document.getElementById(parID + "_txtOtherState").value = '';
        }
        mobilenovalidation(strCountryValue);
    }

    function showotherState(objState) {
        var parID = objState.split("_")[0];

        var e = document.getElementById(objState);
        var strState = e.options[e.selectedIndex].text;

        document.getElementById(parID + "_tbState").style.display = 'none';
        document.getElementById(parID + "_txtOtherCountry").value = '';
        document.getElementById(parID + "_txtOtherState").value = '';
        if (strState.toUpperCase() == 'OTHERS') {
            document.getElementById(parID + "_tbState").style.display = 'block';
            document.getElementById(parID + "_txtOtherCountry").value = '';
            document.getElementById(parID + "_txtOtherState").value = '';
        }
    }
    function copylocation() {
        var city = document.getElementById('ucPAdd_txtCity').value;
        var location = document.getElementById('txtLocation').value;
        if (city != "" && location == "") {
            document.getElementById('txtLocation').value = city;
        }
    }
    function mobilenovalidation(objCountryCode) {
        $('#ucPAdd_txtMobile').val('');
        objCountryCode = document.getElementById('ucPAdd_ddCountry').value;
        if (objCountryCode == '75') {
            document.getElementById('ucPAdd_txtMobile').maxLength = "10";
        }
        else {
            document.getElementById('ucPAdd_txtMobile').maxLength = "11";
        }
    }
</script>

<table class="w-100p">
    <tr>
        <td class="a-left" colspan="6" id="us">
            <asp:Literal ID="litTitle" runat="server" meta:resourcekey="litTitleResource1"></asp:Literal>
        </td>
    </tr>
    <tr>
        <td class="h-35">
            <table class="tabledata w-100p">
                <tr>
                    <td style="display: none">
                        <asp:TextBox runat="server" Visible="False" ID="txtAddressID" CssClass="small" meta:resourcekey="txtAddressIDResource1"></asp:TextBox>
                    </td>
                    <td style="width: 171px;">
                        <asp:Label ID="Rs_Address1" runat="server" Text="Address 1" meta:resourcekey="Rs_Address1Resource1"></asp:Label>
                    </td>
                    <td style="width: 300px;">
                        <asp:TextBox ID="txtAddress2" TextMode="MultiLine" runat="server" onFocus="return expandTextBox(this.id)"
                            CssClass="small" onBlur="return collapseTextBox(this.id);" MaxLength="150"
                            meta:resourcekey="txtAddress2Resource1"></asp:TextBox>&nbsp;<img src="../Images/starbutton.png"
                                alt="" />
                    </td>
                    <td>
                        <asp:Label ID="Rs_Address2" runat="server" Text="Address 2" meta:resourcekey="Rs_Address2Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAddress1" CssClass="small" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                            MaxLength="250" meta:resourcekey="txtAddress1Resource1"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="display: none">
                        &nbsp;
                    </td>
                    <td>
                        <asp:Label ID="Rs_Address3" runat="server" Text="Address 3" meta:resourcekey="Rs_Address3Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAddress3" CssClass="small" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                            MaxLength="250" meta:resourcekey="txtAddress3Resource1"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="Rs_City" runat="server" Text="City" meta:resourcekey="Rs_CityResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtCity" CssClass="small" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                            MaxLength="25"  meta:resourcekey="txtCityResource1"></asp:TextBox>
                        &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                    </td>
                </tr>
                <tr>
                    <td style="display: none">
                        &nbsp;
                    </td>
                    <td>
                        <asp:Label ID="Rs_Country" runat="server" Text="Country" meta:resourcekey="Rs_CountryResource1"></asp:Label>
                    </td>
                    <td style="margin-left: 40px">
                        <asp:DropDownList ID="ddCountry" CssClass="ddlsmall" runat="server"
                            AutoPostBack="True" OnSelectedIndexChanged="ddCountry_SelectedIndexChanged" onchange="showotherUCcouuntry(this.id);"
                            meta:resourcekey="ddCountryResource1">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Label ID="Rs_State" runat="server" Text="State" meta:resourcekey="Rs_StateResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="ddState" CssClass="ddlsmall" runat="server" onchange="showotherState(this.id);"
                                    meta:resourcekey="ddStateResource1">
                                </asp:DropDownList>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddCountry" EventName="SelectedIndexChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td style="display: none">
                    </td>
                    <td colspan="2">
                        <div style="display: none" runat="server" id="tbCountry">
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <asp:Label ID="Label1" runat="server" Text="Other Country" meta:resourcekey="Label1Resource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtOtherCountry" CssClass="small" runat="server" meta:resourcekey="txtOtherCountryResource1"></asp:TextBox>
                                        &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                    <td colspan="2">
                        <div style="display: none" runat="server" id="tbState">
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <asp:Label ID="Label2" runat="server" Text="Other State" meta:resourcekey="Label2Resource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtOtherState" CssClass="small" runat="server" meta:resourcekey="txtOtherStateResource1"></asp:TextBox>
                                        &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="display: none">
                        &nbsp;
                    </td>
                    <td>
                        <asp:Label ID="Rs_PostalCode" runat="server" Text="Postal Code" meta:resourcekey="Rs_PostalCodeResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPostalCode" CssClass="small" runat="server" MaxLength="6"
                            meta:resourcekey="txtPostalCodeResource1"></asp:TextBox>
                        <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="FilteredTextBoxExtender2"
                            TargetControlID="txtPostalCode" Enabled="True">
                        </ajc:FilteredTextBoxExtender>
                    </td>
                    <td>
                        <asp:Label ID="lblCutOffTime" Text=" Transit Time" runat="server" meta:resourcekey="lblCutOffTimeResource1"
                            Style="display: none;"></asp:Label>
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td class="style1">
                                    <asp:TextBox ID="txtCOTValue" runat="server" MaxLength="3" CssClass="small" meta:resourcekey="txtCOTValueResource1"
                                             onkeypress="return ValidateOnlyNumeric(this);"   Style="display: none;"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlCOTType" CssClass="ddlsmall" 
                                        Style="display: none;">
                                     <%--   <asp:ListItem meta:resourcekey="ListItemResource1">Hour(s)</asp:ListItem>
                                        <asp:ListItem meta:resourcekey="ListItemResource2">Day(s)</asp:ListItem>--%>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="display: none">
                        &nbsp;
                    </td>
                    <td>
                        <asp:Label ID="Rs_Mobile" runat="server" Text="Mobile" meta:resourcekey="Rs_MobileResource1"></asp:Label>
                         <asp:label ID="lblcountrycode" runat="server" Visible="False" 
                            meta:resourcekey="lblcountrycodeResource1"></asp:label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtMobile" CssClass="small"  runat="server" MaxLength="11"
                            meta:resourcekey="txtMobileResource1"></asp:TextBox>
                        <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="filtxtMobile"
                            TargetControlID="txtMobile" Enabled="True">
                        </ajc:FilteredTextBoxExtender>
                        &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" /><%--<img src="../Images/starbutton.png"
                            alt="" class="v-middle" />--%>
                    </td>
                    <td>
                        <asp:Label ID="Rs_LandLine" runat="server" Text="Landline" meta:resourcekey="Rs_LandLineResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtLandLine" CssClass="small" onblur="checkLandLineNumber()"
                            runat="server" MaxLength="12" meta:resourcekey="txtLandLineResource1"></asp:TextBox>
                        <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="FilteredTextBoxExtender1"
                            TargetControlID="txtLandLine" Enabled="True">
                        </ajc:FilteredTextBoxExtender>
                        &nbsp;<%--<img src="../Images/starbutton.png" alt="" class="v-middle" /><img src="../Images/starbutton.png"
                            alt="" class="v-middle" />--%>
                    </td>
                </tr>
                <asp:HiddenField ID="hdnCurrentAddressState" runat="server" />
                <asp:HiddenField ID="hdnPermanentAddressState" runat="server" />
                <asp:HiddenField ID="hdnCurrentAddressCountry" runat="server" />
                <asp:HiddenField ID="hdnPermanentAddressCountry" runat="server" />
            </table>
        </td>
    </tr>
</table>
