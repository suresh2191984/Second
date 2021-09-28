<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PatientAddress_AR.ascx.cs"
    Inherits="PlatFormControls_PatientAddress_AR" %>
<table id="tblAddressCntrl" class="w-100p">
    <tr id="TitleRow" runat="server">
        <td colspan="2" class="a-left" id="us" runat="server">
            <asp:Literal ID="litTitle" runat="server" meta:resourcekey="litTitleResource1"></asp:Literal>
            <asp:Literal ID="litCurrentTitle" runat="server" meta:resourcekey="litCurrentTitleResource1"></asp:Literal>
        </td>
        <td id="Td1" runat="server">
        </td>
        <td id="Td2" runat="server">
        </td>
    </tr>
    <tr>
        <td class="v-top w-11p" runat="server" id="Col1">
            <asp:Label ID="Address1" runat="server" Text="<u>A</u>ddress" meta:resourcekey="Address1Resource1"></asp:Label>
        </td>
        <td class="v-top w-25p" runat="server" id="Col2">
            <asp:TextBox ID="txtAddress1" TextMode="MultiLine" AccessKey="A" runat="server" onFocus="return expandTextBox(this.id)"
                onBlur="return collapseTextBox(this.id);"  MaxLength="150" TabIndex="9" onkeypress="return ValidateMultiLangChar(this);"
                meta:resourcekey="txtAddress1Resource1"></asp:TextBox><img
                    src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
        </td>
        <td id="Col3" class="v-top w-15p" runat="server">
            <asp:Label ID="Country" runat="server" Text="<u>C</u>ountry" meta:resourcekey="CountryResource1"></asp:Label>
        </td>
        <td id="Col4" class="v-top w-22p" runat="server">
            <asp:DropDownList ID="ddCountry" CssClass="small" AccessKey="C" runat="server" TabIndex="12"
                onchange="javascript:loadState(this.id);" meta:resourcekey="ddCountryResource1">
            </asp:DropDownList>
			<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" id="ImgtxtAddress1" />
        </td>
    
        <td class="v-top w-11p" runat="server">
            <asp:Label ID="State" runat="server" Text="<u>S</u>tate" meta:resourcekey="StateResource1"></asp:Label>
        </td>
        <td class="v-top" runat="server">
            <asp:DropDownList ID="ddState" CssClass="small" AccessKey="S" runat="server" TabIndex="13"
                onchange="javascript:loadCity1(this.id);" meta:resourcekey="ddStateResource1">
            </asp:DropDownList>
            
            <img src="../PlatForm/Images/starbutton.png" alt="" runat="server" id="imgddState" class="a-center" />
        </td>
        </tr>
    <tr>
        <td>
            <asp:Label ID="City" runat="server" Text="Cit<u>y</u>" meta:resourcekey="CityResource1"></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="ddlCity" runat="server" AccessKey="Y" CssClass="small" onchange="javascript:loaLocality1(this.id);"
                TabIndex="14" meta:resourcekey="ddlCityResource1">
            </asp:DropDownList>
            <img src="../PlatForm/Images/starbutton.png" alt="" runat="server" id="imgCity" class="a-center" />
        </td>
    
        <td>
            <asp:Label ID="lblLocality" runat="server" Text="Locality" meta:resourcekey="lblLocalityResource1"></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="ddllocalities" runat="server" CssClass="small" onchange="javascript:onchangeLocaliy(this.id);"
                TabIndex="16" meta:resourcekey="ddllocalitiesResource1">
            </asp:DropDownList>
        </td>
        <td>
            <asp:Label ID="PostalCode" runat="server" Text="<u>P</u>ostal Code" meta:resourcekey="PostalCodeResource1"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtPostalCode" CssClass="small" AccessKey="P" TabIndex="17" runat="server" onkeypress="return AlphaNumericOnly(event);"
                MaxLength="6" meta:resourcekey="txtPostalCodeResource1"></asp:TextBox>
            <%--<ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="FilteredTextBoxExtender2"
                TargetControlID="txtPostalCode" Enabled="True">
            </ajc:FilteredTextBoxExtender>--%>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="Mobile" runat="server" Text="<u>M</u>obile" meta:resourcekey="MobileResource1"></asp:Label>
        </td>
        <td colspan="1">
            <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                <ContentTemplate>
                    <asp:TextBox ID="txtCountryCode" runat="server" Enabled="false" Width="30px" CssClass="small" Font-Bold="True"
                        onkeypress="return ValidateMultiLangChar(this);" meta:resourcekey="txtCountryCodeResource1"></asp:TextBox>
                    <asp:TextBox ID="txtMobile" CssClass="small" AccessKey="M" TabIndex="18" runat="server"
                        meta:resourcekey="txtMobileResource1" onblur="checkMobileNumber()" Style="width: 109px;" onkeypress="return ValidateSpecialAndNumeric(this);"></asp:TextBox>
                    <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="filtxtMobile"
                        TargetControlID="txtMobile" Enabled="True">
                    </ajc:FilteredTextBoxExtender>
                    <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" /><img src="../PlatForm/Images/starbutton.png"
                        alt="" class="a-center" />
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddCountry" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
        <td>
            <asp:Label ID="LandLine" runat="server" Text="<u>L</u>andline" meta:resourcekey="LandLineResource1"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtLandLine" CssClass="small" AccessKey="L" TabIndex="19" runat="server" onkeypress="return ValidateSpecialAndNumeric(this);"
                MaxLength="12" onblur="checkLandLineNumber()" meta:resourcekey="txtLandLineResource1"></asp:TextBox>
            <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="FilteredTextBoxExtender1"
                TargetControlID="txtLandLine" Enabled="True">
            </ajc:FilteredTextBoxExtender>
            <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" /><img src="../PlatForm/Images/starbutton.png"
                alt="" class="a-center" />
        </td>
    </tr>
    <tr class="hide" id="trOtherCountry" runat="server">
        <td colspan="2">
            <div class="hide" runat="server" id="tbCountry">
                <table class="w-100p">
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="Other Country" meta:resourcekey="Label1Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtOtherCountry" CssClass="small" runat="server" onkeypress="return ValidateMultiLangChar(this);" meta:resourcekey="txtOtherCountryResource1"></asp:TextBox>
                            <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                        </td>
                    </tr>
                </table>
            </div>
        </td>
        <td colspan="2">
            <div class="hide" runat="server" id="tbState">
                <table class="w-100p">
                    <tr>
                        <td>
                            <asp:Label ID="Label2" runat="server" Text="Other State" meta:resourcekey="Label2Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtOtherState" CssClass="small" runat="server" onkeypress="return ValidateMultiLangChar(this);"
                                meta:resourcekey="txtOtherStateResource1"></asp:TextBox>
                            <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <asp:HiddenField ID="hdnAddressCountry" runat="server" />
    <asp:HiddenField ID="hdnIsMandtReq" runat="server" />
    <asp:HiddenField ID="hdnAddressState" runat="server" />
    <asp:HiddenField ID="hdnCityID" runat="server" />
    <asp:HiddenField ID="hdnDistricts" runat="server" />
    <asp:HiddenField ID="hdnLoclities" runat="server" />
    <asp:HiddenField ID="hdnPhLength" runat="server" />
    <asp:HiddenField ID="hdnsme" runat="server" />
    <asp:HiddenField ID="hdnConfigvalue" runat="server" Value="0" />
    <asp:HiddenField ID="hdnOrgID" runat="server" />
    <asp:HiddenField ID="hdnLangCode" runat="server" />
    <asp:TextBox runat="server" Visible="False" ID="txtAddressID" onkeypress="return ValidateMultiLangChar(this);"
          meta:resourcekey="txtAddressIDResource1"></asp:TextBox>
</table>

<script language="javascript" type="text/javascript">



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

    
</script>
<script type="text/javascript" language="javascript">
    var ErrorMsg = SListForAppMsg.Get('Platform_CommonControls_PatientAddress_AR_ascx_01') != null ? SListForAppMsg.Get('Platform_CommonControls_PatientAddress_AR_ascx_01') : "Error";
    var ConfirmMsg = SListForAppMsg.Get('Platform_CommonControls_PatientAddress_AR_ascx_02') != null ? SListForAppMsg.Get('Platform_CommonControls_PatientAddress_AR_ascx_02') : "Confirm"
    var okMsg = SListForAppMsg.Get('Platform_CommonControls_PatientAddress_AR_ascx_03') != null ? SListForAppMsg.Get('Platform_CommonControls_PatientAddress_AR_ascx_03') : "Ok";
    var CancelMsg = SListForAppMsg.Get('Platform_CommonControls_PatientAddress_AR_ascx_04') != null ? SListForAppMsg.Get('Platform_CommonControls_PatientAddress_AR_ascx_04') : "Cancel";
</script>
<script type="text/javascript" language="javascript">
    function fnClearPatientAddress(ctrlName) {
        if (ctrlName == null || ctrlName == undefined) {
            ctrlName = "";
        }
        else {
            ctrlName = ctrlName + "_";
        }
        if ($("[id$=" + ctrlName + "txtAddress1]").length > 0) {
            $("[id$=" + ctrlName + "txtAddress1]")[0].value = "";
        }
        if ($("[id$=" + ctrlName + "txtAddress2]").length > 0) {
            $("[id$=" + ctrlName + "txtAddress2]")[0].value = "";
        }
        if ($("[id$=" + ctrlName + "txtAddress3]").length > 0) {
            $("[id$=" + ctrlName + "txtAddress3]")[0].value = "";
        }
        if ($("[id$=" + ctrlName + "txtAddress3]").length > 0) {
            $("[id$=" + ctrlName + "txtAddress3]")[0].value = "";
        }
        if ($("[id$=" + ctrlName + "txtMobile]").length > 0) {
            $("[id$=" + ctrlName + "txtMobile]")[0].value = "";
        }
        if ($("[id$=" + ctrlName + "txtLandLine]").length > 0) {
            $("[id$=" + ctrlName + "txtLandLine]")[0].value = "";
        }
        if ($("[id$=" + ctrlName + "txtPostalCode]").length > 0) {
            $("[id$=" + ctrlName + "txtPostalCode]")[0].value = "";
        }

        if ($("[id$=" + ctrlName + "hdnAddressCountry]").length > 0) {
            $("[id$=" + ctrlName + "hdnAddressCountry]")[0].value = "";
        }

        if ($("[id$=" + ctrlName + "hdnAddressState]").length > 0) {
            $("[id$=" + ctrlName + "hdnAddressState]")[0].value = "";
        }

        if ($("[id$=" + ctrlName + "hdnCityID]").length > 0) {
            $("[id$=" + ctrlName + "hdnCityID]")[0].value = "";
        }


        if ($("[id$=" + ctrlName + "hdnDistricts]").length > 0) {
            $("[id$=" + ctrlName + "hdnDistricts]")[0].value = "";
        }


        $("[id$=" + ctrlName + "ddState]").val('-1');
        $("[id$=" + ctrlName + "ddlCity]").val('-1');
        $("[id$=" + ctrlName + "ddllocalities]").val('-1');
       
        

        if ($("[id$=hdnLoclities]").length > 0) {
            $("[id$=hdnLoclities]")[0].value = "";
        }


    }
    /*Sathish--SupplierScreensAddressValidation*/
    function fnValidateSupplierAddress(ctrlName) {
        var mobileNoLength = $("[id$=hdnPhLength]").val();
        if (mobileNoLength == "" || mobileNoLength == null || mobileNoLength == undefined) {
            if ($('#hdnConfigvalue').val() == "Y") {
                mobileNoLength = 9;
            }
            else {
                mobileNoLength = 10;
            }
        }
        if (ctrlName == null || ctrlName == undefined) {
            ctrlName = "";
        }
        else {
            ctrlName = ctrlName + "_";
        }

        if ($("[id$=" + ctrlName + "hdnLoclities]").length > 0) {
            $("[id$=" + ctrlName + "hdnLoclities]")[0].value = $("[id$=" + ctrlName + "ddllocalities]")[0].value;
        }
        //        if ($("[id$=" + ctrlName + "hdnDistricts]").length > 0) {
        //            $("[id$=" + ctrlName + "hdnDistricts]")[0].value = $("[id$=" + ctrlName + "ddlDistricts]")[0].value;
        //        }
        if ($("[id$=" + ctrlName + "hdnCityID]").length > 0) {
            $("[id$=" + ctrlName + "hdnCityID]")[0].value = $("[id$=" + ctrlName + "ddlCity]")[0].value;
        }
        if ($("[id$=" + ctrlName + "hdnAddressState]").length > 0) {
            $("[id$=" + ctrlName + "hdnAddressState]")[0].value = $("[id$=" + ctrlName + "ddState]")[0].value;
        }
        if ($("[id$=" + ctrlName + "hdnAddressCountry]").length > 0) {
            $("[id$=" + ctrlName + "hdnAddressCountry]")[0].value = $("[id$=" + ctrlName + "ddCountry]")[0].value;
        }

        if ($('#hdnIsMandtReq').val() == "Y") {
            if ($("[id$=" + ctrlName + "txtAddress1]").length > 0 && $("[id$=" + ctrlName + "txtAddress1]")[0].value == '') {
                var userMsg = SListForAppMsg.Get('PlatFormControls_PatientAddress_AR_ascx_01');
                var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
                if (ErrorMsg == null) {
                    ErrorMsg = "Error";
                }
                if (userMsg != null) {
                    ValidationWindow(userMsg, ErrorMsg);
                }
                else {
                    ValidationWindow('Provide address', 'Error');
                }
                $("[id$=" + ctrlName + "txtAddress1]")[0].focus();
                return false;
            }

            if ($("[id$=" + ctrlName + "ddState]").length > 0 && $("[id$=" + ctrlName + "ddState]")[0].selectedIndex == '0') {
                var userMsg = SListForAppMsg.Get('PlatFormControls_PatientAddress_AR_ascx_02');
                var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
                if (ErrorMsg == null) {
                    ErrorMsg = "Error";
                }
                if (userMsg != null) {
                    ValidationWindow(userMsg, ErrorMsg);
                }
                else {
                    ValidationWindow('Select state', 'Error');
                }
                $("[id$=" + ctrlName + "ddState]").focus();
                return false;
            }

            //        if ($("[id$=" + ctrlName + "ddlDistricts]").length > 0 && $("[id$=" + ctrlName + "ddlDistricts]")[0].selectedIndex == '0' && Config != "Y") {
            //            alert('Select Districts');
            //            $("[id$=" + ctrlName + "ddlDistricts]").focus();
            //            return false;
            //        }

            if ($("[id$=" + ctrlName + "ddlCity]").length > 0 && $("[id$=" + ctrlName + "ddlCity]")[0].selectedIndex == '0') {
                var userMsg = SListForAppMsg.Get('PlatFormControls_PatientAddress_AR_ascx_03');
                var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
                if (ErrorMsg == null) {
                    ErrorMsg = "Error";
                }
                if (userMsg != null) {
                    ValidationWindow(userMsg, ErrorMsg);
                }
                else {
                    ValidationWindow('Select City', 'Error');
                }
                $("[id$=" + ctrlName + "ddlCity]")[0].focus();
                return false;
            }

            if ($("[id$=" + ctrlName + "txtMobile]").length > 0 && ($("[id$=" + ctrlName + "txtMobile]")[0].value == '') && ($("[id$=" + ctrlName + "txtLandLine]")[0].value == '')) {
                var userMsg = SListForAppMsg.Get('PlatFormControls_PatientAddress_AR_ascx_04');
                var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
                if (ErrorMsg == null) {
                    ErrorMsg = "Error";
                }
                if (userMsg != null) {
                    ValidationWindow(userMsg, ErrorMsg);
                }
                else {
                    ValidationWindow('Provide any one contact number', 'Error');
                }
                $("[id$=" + ctrlName + "txtMobile]")[0].focus();
                return false;
            }
            if ($("[id$=" + ctrlName + "txtMobile]").val().length > 0 && $("[id$=" + ctrlName + "txtMobile]").val().length < $("[id$=hdnPhLength]").val()) {
                userMsg = SListForAppMsg.Get('Platform_CommonControls_PatientAddress_AR_ascx_09') != null ? SListForAppMsg.Get('Platform_CommonControls_PatientAddress_AR_ascx_09') : "Provide valid mobile number";
                ValidationWindow(userMsg, ErrorMsg);
                return false;
            }
        }
        return true;
    }
    function fnValidatePatAddress(ctrlName) {
        var mobileNoLength = $("[id$=hdnPhLength]").val();
        if (mobileNoLength == "" || mobileNoLength == null || mobileNoLength == undefined) {
            if ($('#hdnConfigvalue').val() == "Y") {
                mobileNoLength = 9;
            }
            else {
                mobileNoLength = 10;
            }
        }
        if (ctrlName == null || ctrlName == undefined) {
            ctrlName = "";
        }
        else {
            ctrlName = ctrlName + "_";
        }

        if ($("[id$=" + ctrlName + "hdnLoclities]").length > 0) {
            $("[id$=" + ctrlName + "hdnLoclities]")[0].value = $("[id$=" + ctrlName + "ddllocalities]")[0].value;
        }
//        if ($("[id$=" + ctrlName + "hdnDistricts]").length > 0) {
//            $("[id$=" + ctrlName + "hdnDistricts]")[0].value = $("[id$=" + ctrlName + "ddlDistricts]")[0].value;
//        }
        if ($("[id$=" + ctrlName + "hdnCityID]").length > 0) {
            $("[id$=" + ctrlName + "hdnCityID]")[0].value = $("[id$=" + ctrlName + "ddlCity]")[0].value;
        }
        if ($("[id$=" + ctrlName + "hdnAddressState]").length > 0) {
            $("[id$=" + ctrlName + "hdnAddressState]")[0].value = $("[id$=" + ctrlName + "ddState]")[0].value;
        }
        if ($("[id$=" + ctrlName + "hdnAddressCountry]").length > 0) {
            $("[id$=" + ctrlName + "hdnAddressCountry]")[0].value = $("[id$=" + ctrlName + "ddCountry]")[0].value;
        }


        if ($("[id$=" + ctrlName + "txtAddress1]").length > 0 && $("[id$=" + ctrlName + "txtAddress1]")[0].value == '') {
            var userMsg = SListForAppMsg.Get('PlatFormControls_PatientAddress_AR_ascx_01');
            var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
            if (ErrorMsg == null) {
                ErrorMsg = "Error";
            }
            if (userMsg != null) {
                ValidationWindow(userMsg, ErrorMsg);
            }
            else {
                ValidationWindow('Provide address','Error');
            }
            $("[id$=" + ctrlName + "txtAddress1]")[0].focus();
            return false;
        }

        if ($("[id$=" + ctrlName + "ddState]").length > 0 && $("[id$=" + ctrlName + "ddState]")[0].selectedIndex == '0') {
            var userMsg = SListForAppMsg.Get('PlatFormControls_PatientAddress_AR_ascx_02');
            var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
            if (ErrorMsg == null) {
                ErrorMsg = "Error";
            }
            if (userMsg != null) {
                ValidationWindow(userMsg, ErrorMsg);
            }
            else {
                ValidationWindow('Select state', 'Error');
            }
            $("[id$=" + ctrlName + "ddState]").focus();
            return false;
        }

//        if ($("[id$=" + ctrlName + "ddlDistricts]").length > 0 && $("[id$=" + ctrlName + "ddlDistricts]")[0].selectedIndex == '0' && Config != "Y") {
//            alert('Select Districts');
//            $("[id$=" + ctrlName + "ddlDistricts]").focus();
//            return false;
//        }

        if ($("[id$=" + ctrlName + "ddlCity]").length > 0 && $("[id$=" + ctrlName + "ddlCity]")[0].selectedIndex == '0') {
            var userMsg = SListForAppMsg.Get('PlatFormControls_PatientAddress_AR_ascx_03');
            var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
            if (ErrorMsg == null) {
                ErrorMsg = "Error";
            }
            if (userMsg != null) {
                ValidationWindow(userMsg, ErrorMsg);
            }
            else {
                ValidationWindow('Select City', 'Error');
            }
            $("[id$=" + ctrlName + "ddlCity]")[0].focus();
            return false;
        }

        if ($("[id$=" + ctrlName + "txtMobile]").length > 0 && ($("[id$=" + ctrlName + "txtMobile]")[0].value == '') && ($("[id$=" + ctrlName + "txtLandLine]")[0].value == '')) {
            var userMsg = SListForAppMsg.Get('PlatFormControls_PatientAddress_AR_ascx_04');
            var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
            if (ErrorMsg == null) {
                ErrorMsg = "Error";
            }
            if (userMsg != null) {
                ValidationWindow(userMsg,ErrorMsg);
            }
            else {
                ValidationWindow('Provide any one contact number','Error');
            }
            $("[id$=" + ctrlName + "txtMobile]")[0].focus();
            return false;
        }
        if ($("[id$=" + ctrlName + "txtMobile]").val().length > 0 && $("[id$=" + ctrlName + "txtMobile]").val().length < $("[id$=hdnPhLength]").val()) {
            userMsg = SListForAppMsg.Get('Platform_CommonControls_PatientAddress_AR_ascx_09') != null ? SListForAppMsg.Get('Platform_CommonControls_PatientAddress_AR_ascx_09') : "Provide valid mobile number";
            ValidationWindow(userMsg, ErrorMsg);
            return false;
        }

        return true;
    }



    function loadState(objState, objID) {

        var parID = objState.substring(0, objState.lastIndexOf('_')); //objState.split("_")[0];
        var Length;
        var select = ClientSelect.Select;
        var orgID = document.getElementById("<%=hdnOrgID.ClientID %>").value;
        var Langcode = document.getElementById("<%=hdnLangCode.ClientID %>").value;
        document.getElementById(parID + "_hdnAddressCountry").value = document.getElementById(objState).value;
        $("select[id$=" + parID + "_ddState] > option").remove();
      //  $("select[id$=" + parID + "_ddState] > option").empty();
        $("select[id$=" + parID + "_ddlCity] > option").remove();
//        $("select[id$=" + parID + "_ddlDistricts] > option").remove();
        $("select[id$=" + parID + "_ddllocalities] > option").remove();
        $.ajax({
            type: "POST",
            url: "../PlatformWebServices/PlatFormServices.asmx/Localities",

            //data: "{ 'CodeID': '" + (document.getElementById(parID + "_ddCountry").value) + "'}",
            data: "{ 'CodeID': '" + document.getElementById(parID+"_ddCountry").value + "','OrgID':" + orgID + ",'LangCode':'" + Langcode + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var Items = data.d;
                //$("#" + parID + "_ddState").attr("disabled", false);
                $("#" + parID + "_ddState").append('<option value="-1">-Select- </option>');
                $("#" + parID + "_ddlCity").append('<option value="-1">-Select-</option>');
//                $("#" + parID + "_ddlDistricts").append('<option value="-1">-Select-</option>');
                $("#" + parID + "_ddllocalities").append('<option value="-1">-Select-</option>');
                $.each(Items, function(index, Item) {
                    $("#" + parID + "_ddState").append('<option value="' + Item.Locality_ID + '">' + Item.Locality_Value + '</option>');
                    document.getElementById(parID + "_txtCountryCode").value = "+" + Item.ISDCode;

                    Length = Item.PhoneNo_Length;
                    $("[id$=" + parID + "_hdnPhLength]").val(Length);

                    $("[id$=" + parID + "_txtMobile]").attr('maxLength', Length);
                    if (objID > 0) {
                        document.getElementById(parID + "_ddState").value = objID;
                        document.getElementById(parID + "_hdnAddressState").value = objID;
                    }
                });
                if ($("[id$=" + parID + "_hdnAddressState]").length > 0) {
                    if ($("[id$=" + parID + "_hdnAddressState]")[0].value != undefined && $("[id$=" + parID + "_hdnAddressState]")[0].value != "") {
                        document.getElementById(parID + "_ddState").value = $("[id$=" + parID + "_hdnAddressState]")[0].value;
						
                        
						loadCity1(parID + "_ddState");
						
                    }
                }

            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }
        });
    }

    function loadCity(objCity, objID, StateCode) {

        var parID = objCity.substring(0, objCity.lastIndexOf('_')); // objCity.split("_")[0];
        var select = ClientSelect.Select;
        var orgID = document.getElementById("<%=hdnOrgID.ClientID %>").value;
        var Langcode = document.getElementById("<%=hdnLangCode.ClientID %>").value;
        // document.getElementById(parID + "_hdnAddressState").value = document.getElementById(objCity).value;
        // document.getElementById(parID + "_hdnCityID").value = document.getElementById(objCity).value;
        $("select[id$=" + parID + "_ddlCity] > option").remove();
        $("select[id$=" + parID + "_ddllocalities] > option").remove();
//        var value = document.getElementById(parID + "_ddlDistricts").value;
//        if (value == "") {
//            value = StateCode;
//        }
        $("select[id$=" + parID + "_ddlCity] > option").remove();
        $.ajax({
            type: "POST",
            url: "../PlatformWebServices/PlatFormServices.asmx/Localities",
            //data: "{ 'CodeID': '" + value + "'}",
            data: "{ 'CodeID': '" + value + "','OrgID':" + orgID + ",'LangCode':'" + Langcode + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var Items = data.d;
                $("#" + parID + "_ddlCity").append('<option value="-1">-Select-</option>');
//                $("#" + parID + "_ddlDistricts").append('<option value="-1">-Select-</option>');
                $("#" + parID + "_ddllocalities").append('<option value="-1">-Select-</option>');
                $.each(Items, function(index, Item) {
                    $("#" + parID + "_ddlCity").append('<option value="' + Item.Locality_ID + '">' + Item.Locality_Value + '</option>');
                    if (objID > 0) {
                        document.getElementById(parID + "_ddlCity").value = objID;
                        document.getElementById(parID + "_hdnCityID").value = objID;
                    }
                });
                if ($("[id$=" + parID + "_hdnCityID]").length > 0) {
                    if ($("[id$=" + parID + "_hdnCityID]")[0].value != undefined && $("[id$=" + parID + "_hdnCityID]")[0].value != "") {
                        document.getElementById(parID + "_ddlCity").value = $("[id$=" + parID + "_hdnCityID]")[0].value;
                        loaLocality(parID + "_ddlCity");
                    }
                }
            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }
        });
    }


    function loadCity1(objCity) {

        var parID = objCity.substring(0, objCity.lastIndexOf('_')); // objCity.split("_")[0];
        var orgID = document.getElementById("<%=hdnOrgID.ClientID %>").value;
        var Langcode = document.getElementById("<%=hdnLangCode.ClientID %>").value;
        $("select[id$=" + parID + "_ddlCity] > option").remove();
        $("select[id$=" + parID + "_ddllocalities] > option").remove();
        $("[id$=" + parID + "_hdnLoclities]")[0].value = "-1";
		var value = document.getElementById(parID + "_ddState").value;
                if (value == "") {
                    value = StateCode;
                }  
		$("#" + parID + "_ddlCity").append('<option value="-1">-Select-</option>');
		$("#" + parID + "_ddllocalities").append('<option value="-1">-Select-</option>');
        $.ajax({
            type: "POST",
            url: "../PlatformWebServices/PlatFormServices.asmx/Localities",
            //data: "{ 'CodeID': '" + value + "'}",
            data: "{ 'CodeID': '" + value + "','OrgID':" + orgID + ",'LangCode':'" + Langcode + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var Items = data.d;
                $.each(Items, function(index, Item) {
                $("#" + parID + "_ddlCity").append('<option value="' + Item.Locality_ID + '">' + Item.Locality_Value + '</option>');
                document.getElementById(parID + "_ddlCity").value = ($("[id$=" + parID + "_hdnCityID]")[0].value.replace(/ /g, "") == "" ? "-1" : $("[id$=" + parID + "_hdnCityID]")[0].value);
                loaLocality1(parID + "_ddlCity");
                });
            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }
        });
    }

    function loadDis(objCity, DistrictID, CityCode) 
    
    {

        var parID = objCity.substring(0, objCity.lastIndexOf('_')); // objCity.split("_")[0];
        var select = ClientSelect.Select;
        var orgID = document.getElementById("<%=hdnOrgID.ClientID %>").value;
        var Langcode = document.getElementById("<%=hdnLangCode.ClientID %>").value;
        //  document.getElementById(parID + "_hdnCityID").value = document.getElementById(objCity).value;
        //document.getElementById(parID + "_hdnAddressState").value = document.getElementById(objCity).value;
//        $("select[id$=" + parID + "_ddlDistricts] > option").remove();
        $("select[id$=" + parID + "_ddlCity] > option").remove();
        $("select[id$=" + parID + "_ddllocalities] > option").remove();
        // var parID = objCity.split("_")[0];
        var value = document.getElementById(parID + "_ddState").value;
        if (value == "") {
            value = CityCode;
        }
        $.ajax({
            type: "POST",
            url: "../PlatformWebServices/PlatFormServices.asmx/Localities",
            //data: "{ 'CodeID': '" + value + "'}",
            data: "{ 'CodeID': '" + value + "','OrgID':" + orgID + ",'LangCode':'" + Langcode + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var Items = data.d;
//                $("#" + parID + "_ddlDistricts").append('<option value="-1">' + select + '</option>');
                $("#" + parID + "_ddllocalities").append('<option value="-1">' + select + '</option>');
//                $.each(Items, function(index, Item) {
//                    $("#" + parID + "_ddlDistricts").append('<option value="' + Item.Locality_ID + '">' + Item.Locality_Value + '</option>');

//                });
//                if (DistrictID > 0) {
//                    document.getElementById(parID + "_ddlDistricts").value = DistrictID;
//                    document.getElementById(parID + "_hdnDistricts").value = DistrictID;
//                }
//                if ($("[id$=" + parID + "_hdnDistricts]").length > 0) {
//                    if ($("[id$=" + parID + "_hdnDistricts]")[0].value != undefined && $("[id$=" + parID + "_hdnDistricts]")[0].value != "") {
//                        document.getElementById(parID + "_ddlDistricts").value = $("[id$=" + parID + "_hdnDistricts]")[0].value;
//                        loadCity(parID + "_ddlDistricts");
//                    }
//                }
            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }
        });

    }

    
    function loaLocality(objLocality, LocalityID, DistrictID) {

        var parID = objLocality.substring(0, objLocality.lastIndexOf('_'));  //objLocality.split("_")[0];
        var select = ClientSelect.Select;
        var orgID = document.getElementById("<%=hdnOrgID.ClientID %>").value;
        var Langcode = document.getElementById("<%=hdnLangCode.ClientID %>").value;
        $("select[id$=" + parID + "_ddllocalities] > option").remove();
        var value = document.getElementById(parID + "_hdnDistricts").value;

        $.ajax({
            type: "POST",
            url: "../PlatformWebServices/PlatFormServices.asmx/Localities",
            //data: "{ 'CodeID': '" + value + "'}",
            data: "{ 'CodeID': '" + value + "','OrgID':" + orgID + ",'LangCode':'" + Langcode + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var Items = data.d;
                $("#" + parID + "_ddllocalities").append('<option value="-1">' + select + '</option>');
                $.each(Items, function(index, Item) {
                    $("#" + parID + "_ddllocalities").append('<option value="' + Item.Locality_ID + '">' + Item.Locality_Value + '</option>');

                });
                if (LocalityID > 0) {
                    document.getElementById(parID + "_ddllocalities").value = LocalityID;
                }
                if ($("[id$=" + parID + "_hdnLoclities]").length > 0) {
                    if ($("[id$=" + parID + "_hdnLoclities]")[0].value != undefined && $("[id$=" + parID + "_hdnLoclities]")[0].value != "") {
                        document.getElementById(parID + "_ddllocalities").value = ($("[id$=" + parID + "_hdnLoclities]")[0].value.replace(/ /g, "") == "" ? "-1" : $("[id$=" + parID + "_hdnLoclities]")[0].value);
                        loaLocality(parID + "_ddllocalities");
                    }
                }
            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }
        });

    }


    function loaLocality1(objLocality) {

        var parID = objLocality.substring(0, objLocality.lastIndexOf('_'));  //objLocality.split("_")[0];
        var select = ClientSelect.Select;
        var orgID = document.getElementById("<%=hdnOrgID.ClientID %>").value;
        var Langcode = document.getElementById("<%=hdnLangCode.ClientID %>").value;
        $("select[id$=" + parID + "_ddllocalities] > option").remove();
        var value = document.getElementById(parID + "_ddlCity").value;
        document.getElementById(parID + "_hdnCityID").value = value;
        $("#" + parID + "_ddllocalities").append('<option value="-1">' + select + '</option>');
        $.ajax({
            type: "POST",
            url: "../PlatformWebServices/PlatFormServices.asmx/Localities",
            //data: "{ 'CodeID': '" + value + "'}",
            data: "{ 'CodeID': '" + value + "','OrgID':" + orgID + ",'LangCode':'" + Langcode + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var Items = data.d;

                $.each(Items, function(index, Item) {
                    $("#" + parID + "_ddllocalities").append('<option value="' + Item.Locality_ID + '">' + Item.Locality_Value + '</option>');
 if (($("[id$=" + parID + "_hdnLoclities]")[0].value > 0)) {
                    //document.getElementById(parID + "_ddllocalities").value = ($("[id$=" + parID + "_hdnLoclities]")[0].value.replace(/ /g, "") == "" ? "-1" : $("[id$=" + parID + "_hdnLoclities]")[0].value);
                    document.getElementById(parID + "_ddllocalities").value = $("[id$=" + parID + "_hdnLoclities]")[0].value;
}
                });
            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }
        });

    }

    function onchangeLocaliy(id) {
        var parID = id.split("_")[0];
        document.getElementById(parID + "_hdnLoclities").value = document.getElementById(id).value;
    }
    function fnDisableAddress() {

        if ($("[id$=txtAddress1]").length > 0) {
            $("[id$=txtAddress1]")[0].disabled = true;
        }
        if ($("[id$=txtAddress2]").length > 0) {
            $("[id$=txtAddress2]")[0].disabled = true;
        }
        if ($("[id$=txtAddress3]").length > 0) {
            $("[id$=txtAddress3]")[0].disabled = true;
        }
        if ($("[id$=txtPostalCode]").length > 0) {
            $("[id$=txtPostalCode]")[0].disabled = true;
        }
        if ($("[id$=txtMobile]").length > 0) {
            $("[id$=txtMobile]")[0].disabled = true;
        }
        if ($("[id$=txtLandLine]").length > 0) {
            $("[id$=txtLandLine]")[0].disabled = true;
        }
        if ($("[id$=ddCountry]").length > 0) {
            $("[id$=ddCountry]")[0].disabled = true;
        }
        if ($("[id$=ddState]").length > 0) {
            $("[id$=ddState]")[0].disabled = true;
        }
        if ($("[id$=ddlCity]").length > 0) {
            $("[id$=ddlCity]")[0].disabled = true;
        }
//        if ($("[id$=ddlDistricts]").length > 0) {
//            $("[id$=ddlDistricts]")[0].disabled = true;
//        }
        if ($("[id$=ddllocalities]").length > 0) {
            $("[id$=ddllocalities]")[0].disabled = true;
        }
    }
    function fnEnableAddress() {

        if ($("[id$=txtAddress1]").length > 0) {
            $("[id$=txtAddress1]")[0].disabled = false;
        }
        if ($("[id$=txtAddress2]").length > 0) {
            $("[id$=txtAddress2]")[0].disabled = false;
        }
        if ($("[id$=txtAddress3]").length > 0) {
            $("[id$=txtAddress3]")[0].disabled = false;
        }
        if ($("[id$=txtPostalCode]").length > 0) {
            $("[id$=txtPostalCode]")[0].disabled = false;
        }
        if ($("[id$=txtMobile]").length > 0) {
            $("[id$=txtMobile]")[0].disabled = false;
        }
        if ($("[id$=txtLandLine]").length > 0) {
            $("[id$=txtLandLine]")[0].disabled = false;
        }
        if ($("[id$=ddCountry]").length > 0) {
            $("[id$=ddCountry]")[0].disabled = false;
        }
        if ($("[id$=ddState]").length > 0) {
            $("[id$=ddState]")[0].disabled = false;
        }
        if ($("[id$=ddlCity]").length > 0) {
            $("[id$=ddlCity]")[0].disabled = false;
        }
//        if ($("[id$=ddlDistricts]").length > 0) {
//            $("[id$=ddlDistricts]")[0].disabled = false;
//        }
        if ($("[id$=ddllocalities]").length > 0) {
            $("[id$=ddllocalities]")[0].disabled = false;
        }
    }
    function fnSetAddress(Address1, Address2, Address3, CountryCode, StateCode, CityCode, AddLevel1, Addlevel2, PostalCode, Mobile, Landline, CtrlName) {
        if (CtrlName == undefined) {
            CtrlName = '';
        }
        if (Address1 != undefined && Address1 != "") {
            if ($("[id$=" + CtrlName + "_txtAddress1]").length > 0) {
                $("[id$=" + CtrlName + "_txtAddress1]")[0].value = Address1;
            }
        }
        if (Address2 != undefined && Address2 != "") {
            if ($("[id$=" + CtrlName + "_txtAddress2]").length > 0) {
                $("[id$=" + CtrlName + "_txtAddress2]")[0].value = Address2;
            }
        }
        if (Address3 != undefined && Address3 != "") {
            if ($("[id$=" + CtrlName + "_txtAddress3]").length > 0) {
                $("[id$=" + CtrlName + "_txtAddress3]")[0].value = Address3;
            }
        }
        if (PostalCode != undefined && PostalCode != "") {
            if ($("[id$=" + CtrlName + "_txtPostalCode]").length > 0) {
                $("[id$=" + CtrlName + "_txtPostalCode]")[0].value = PostalCode;
            }
        }
        if (Mobile != undefined && Mobile != "") {
            if ($("[id$=" + CtrlName + "_txtMobile]").length > 0) {
                $("[id$=" + CtrlName + "_txtMobile]")[0].value = Mobile;
            }
        }
        if (Landline != undefined && Landline != "") {
            if ($("[id$=" + CtrlName + "_txtLandLine]").length > 0) {
                $("[id$=" + CtrlName + "_txtLandLine]")[0].value = Landline;
            }
        }
        if (CountryCode != undefined && CountryCode != "") {
            if ($("[id$=" + CtrlName + "_hdnAddressCountry]").length > 0) {
                $("[id$=" + CtrlName + "_hdnAddressCountry]")[0].value = CountryCode;
                //  $("[id$=" + CtrlName + "_ddCountry")[0].value = CountryCode;
                $("#" + CtrlName + "_ddCountry").val(CountryCode);
            }
        }
        if (StateCode != undefined && StateCode != "") {
            if ($("[id$=" + CtrlName + "_hdnAddressState]").length > 0) {
                $("[id$=" + CtrlName + "_hdnAddressState]")[0].value = StateCode;
            }
        }
        if (CityCode != undefined && CityCode != "") {
            if ($("[id$=" + CtrlName + "_hdnCityID]").length > 0) {
                $("[id$=" + CtrlName + "_hdnCityID]")[0].value = CityCode;
            }
        }
        if (AddLevel1 != undefined && AddLevel1 != "") {
            if ($("[id$=" + CtrlName + "_hdnDistricts]").length > 0) {
                $("[id$=" + CtrlName + "_hdnDistricts]")[0].value = AddLevel1;
            }
        }
        if (Addlevel2 != undefined && Addlevel2 != "") {
            if ($("[id$=" + CtrlName + "_hdnLoclities]").length > 0) {
                $("[id$=" + CtrlName + "_hdnLoclities]")[0].value = Addlevel2;
            }
        }
        loadState(CtrlName + "_ddCountry");
    }
    function ValidateSplChar(txt) {
        txt.value = txt.value.replace(/[^a-zA-Z 0-9\n\r]+/g, '');
    }
    
</script>

