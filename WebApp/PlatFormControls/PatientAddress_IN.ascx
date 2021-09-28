<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PatientAddress_IN.ascx.cs"
    Inherits="PlatFormControls_PatientAddress_IN" %>
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
         <td id="Td31" runat="server">
        </td>
        <td id="Td41" runat="server">
        </td>
    </tr>
    <tr>
        <td class="v-top w-11p" runat="server" id="Col1">
            <asp:Label ID="Address1" runat="server" Text="<u>A</u>ddress" meta:resourcekey="Address1Resource1"></asp:Label>
        </td>
        <td class="v-middle w-25p" runat="server" id="Col2">
            <asp:TextBox ID="txtAddress1" TextMode="MultiLine" AccessKey="A" runat="server" onFocus="return expandTextBox(this.id)" CssClass="medium v-middle"
                onBlur="return collapseTextBox(this.id);" onkeypress="return ValidateMultiLangChar(this);"
                MaxLength="150" TabIndex="9" meta:resourcekey="txtAddress1Resource1"></asp:TextBox><img
                    src="../PlatForm/Images/starbutton.png" alt="" class="marginL5 marginR2 v-middle" id="ImgtxtAddress1" />
        </td>
        <td id="Col3" class="v-top w-10p Col3" runat="server">
            <asp:Label ID="Country" runat="server" Text="<u>C</u>ountry" meta:resourcekey="CountryResource1"></asp:Label>
        </td>
        <td id="Col4" class="v-top w-22p Col4" runat="server">
            <asp:DropDownList ID="ddCountry" CssClass="medium" AccessKey="C" runat="server" TabIndex="12"
                onchange="javascript:loadState(this.id);" meta:resourcekey="ddCountryResource1">
            </asp:DropDownList>
			<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" id="ImgtxtAddress1" />
        </td>
        <td class="v-top w-9p Col5">
            <asp:Label ID="State" runat="server" Text="<u>S</u>tate" meta:resourcekey="StateResource1"></asp:Label>
        </td>
        <td class="v-top">
            <asp:DropDownList ID="ddState" CssClass="medium" AccessKey="S" runat="server" TabIndex="13"
                onchange="javascript:loadDis1(this.id);" meta:resourcekey="ddStateResource1">
            </asp:DropDownList>
            <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" id="Img_ddState"/>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblDistricts" runat="server" Text="District" meta:resourcekey="lblDistrictsResource1"></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="ddlDistricts" runat="server" CssClass="medium" onchange="javascript:loadCity1(this.id);"
                TabIndex="15" meta:resourcekey="ddlDistrictsResource1">
            </asp:DropDownList>
            <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center marginL3" id="imgDistrict" style="display:none" runat="server" />
        </td>
         <td>
            <asp:Label ID="City" runat="server" Text="Cit<u>y</u>" meta:resourcekey="CityResource1"></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="ddlCity" runat="server" AccessKey="Y" CssClass="medium" onchange="javascript:loaLocality1(this.id);"
                TabIndex="14" meta:resourcekey="ddlCityResource1">
            </asp:DropDownList>
            <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" runat="server" id="imgCity" style="display:none"/>
        </td>
        <td>
            <asp:Label ID="lblLocality" runat="server" Text="Locality" meta:resourcekey="lblLocalityResource1"></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="ddllocalities" runat="server" CssClass="medium" onchange="javascript:onchangeLocaliy(this.id);"
                TabIndex="16" meta:resourcekey="ddllocalitiesResource1">
            </asp:DropDownList>
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
                            <asp:TextBox ID="txtOtherCountry" CssClass="medium" runat="server" onkeypress="return ValidateMultiLangChar(this);" meta:resourcekey="txtOtherCountryResource1"></asp:TextBox>
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
                            <asp:TextBox ID="txtOtherState" CssClass="medium" runat="server" onkeypress="return ValidateMultiLangChar(this);"
                                meta:resourcekey="txtOtherStateResource1"></asp:TextBox>
                            <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="PostalCode" runat="server" Text="<u>P</u>ostal Code" meta:resourcekey="PostalCodeResource1"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtPostalCode" CssClass="medium" AccessKey="P" TabIndex="17" runat="server" onkeypress="return AlphaNumericOnly(event);"
                MaxLength="6" meta:resourcekey="txtPostalCodeResource1"></asp:TextBox>
            <%--<ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="FilteredTextBoxExtender2"
                TargetControlID="txtPostalCode" Enabled="True">
            </ajc:FilteredTextBoxExtender>--%>
           
                <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center marginL2"  runat="server" id="imgPostalCode" style="display:none"/>
        
        </td>
        <td>
            <asp:Label ID="Mobile" runat="server" Text="<u>M</u>obile" meta:resourcekey="MobileResource1"></asp:Label>
        </td>
        <td colspan="1">
            <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                <ContentTemplate>
                    <asp:TextBox ID="txtCountryCode" runat="server"  CssClass="mini" Font-Bold="True" onkeypress="return ValidateMultiLangChar(this);" Enabled=false
                        meta:resourcekey="txtCountryCodeResource1"></asp:TextBox>
                    <asp:TextBox ID="txtMobile" CssClass="w-140" AccessKey="M" TabIndex="18" runat="server" 
                        onkeypress="return ValidateOnlyNumeric(this);"
                        meta:resourcekey="txtMobileResource1" onblur="checkMobileNumber()" ></asp:TextBox>
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
        <td class="v-bottom">
            <asp:TextBox ID="txtLandLine" CssClass="small" AccessKey="L" TabIndex="19" runat="server" 
                    onkeypress="return ValidateOnlyNumeric(this);"
                MaxLength="12" onblur="checkLandLineNumber()" meta:resourcekey="txtLandLineResource1"></asp:TextBox>
            <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="FilteredTextBoxExtender1"
                TargetControlID="txtLandLine" Enabled="True">
            </ajc:FilteredTextBoxExtender>
            <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" /><img src="../PlatForm/Images/starbutton.png"
                alt="" class="a-center" />
        </td>
    </tr>
    <asp:HiddenField ID="hdnAddressCountry" runat="server" />
    <asp:HiddenField ID="hdnAddressState" runat="server" />
    <asp:HiddenField ID="hdnOrgState" runat="server" />
    <asp:HiddenField ID="hdnCityID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnDistricts" runat="server" Value="0"/>
    <asp:HiddenField ID="hdnLoclities" runat="server" Value="0"/>
    <asp:HiddenField ID="hdnPhLength" runat="server" />
    <asp:HiddenField ID="hdnsme" runat="server" />
    <asp:HiddenField ID="hdnConfigvalue" runat="server" Value="0" />
     <asp:HiddenField ID="hdnIsPostalCodeNeed" runat="server"/>
    <asp:HiddenField ID="hdnOrgID" runat="server" />
    <asp:HiddenField ID="hdnLangCode" runat="server" />
	  <asp:HiddenField ID="hdnAllowLesserDigitMobileYN" runat="server" Value="N" />
	<asp:HiddenField ID="hdnDistrictYN" runat="server"  />
	<asp:HiddenField ID="hdnPostalCodeYN" runat="server"  />
	<asp:HiddenField ID="hdnStateid" runat="server"  Value="0"/>
    <asp:TextBox runat="server" Visible="False" ID="txtAddressID"
         onkeypress="return ValidateMultiLangChar(this);" meta:resourcekey="txtAddressIDResource1"></asp:TextBox>
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
    var ErrorMsg = SListForAppMsg.Get('Platform_CommonControls_PatientAddress_IN_ascx_01') != null ? SListForAppMsg.Get('Platform_CommonControls_PatientAddress_IN_ascx_01') : "Error";
    var ConfirmMsg = SListForAppMsg.Get('Platform_CommonControls_PatientAddress_IN_ascx_02') != null ? SListForAppMsg.Get('Platform_CommonControls_PatientAddress_IN_ascx_02') : "Confirm"
    var okMsg = SListForAppMsg.Get('Platform_CommonControls_PatientAddress_IN_ascx_03') != null ? SListForAppMsg.Get('Platform_CommonControls_PatientAddress_IN_ascx_03') : "Ok";
    var CancelMsg = SListForAppMsg.Get('Platform_CommonControls_PatientAddress_IN_ascx_04') != null ? SListForAppMsg.Get('Platform_CommonControls_PatientAddress_IN_ascx_04') : "Cancel";
    var stateselected;
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

        if ($("[id$=" + ctrlName + "hdnAddressState]").length > 0 && $("[id$=" + ctrlName + "hdnAddressState]").val()!="") {
            stateselected = $("[id$=" + ctrlName + "hdnOrgState]").val();
            $("[id$=" + ctrlName + "hdnAddressState]")[0].value = "";
        }

//        if ($("[id$=" + ctrlName + "hdnAddressState]").length > 0) {
//            $("[id$=" + ctrlName + "hdnAddressState]")[0].value = "";
//        } //previous coding
        

        if ($("[id$=" + ctrlName + "hdnCityID]").length > 0) {
            $("[id$=" + ctrlName + "hdnCityID]")[0].value = "";
        }


        if ($("[id$=" + ctrlName + "hdnDistricts]").length > 0) {
            $("[id$=" + ctrlName + "hdnDistricts]")[0].value = "";
        }

        if (stateselected != undefined) {
            $("[id$=" + ctrlName + "ddState]").val(stateselected);
        }
        //$("[id$=" + ctrlName + "ddState]").val('0'); //previous coding
        $("[id$=" + ctrlName + "ddlCity]").val('0');
        $("[id$=" + ctrlName + "ddllocalities]").val('0');
       
        

        if ($("[id$=hdnLoclities]").length > 0) {
            $("[id$=hdnLoclities]")[0].value = "";
        }
		if(Config=='Y'){
//        loadState(ctrlName + "ddCountry");
          var flag=0;
          }
//		  else{
//		  loadState(ctrlName + "ddCountry");
//		  }

    }
    function fnValidatePatAddress(ctrlName) {

        if (ctrlName == null || ctrlName == undefined) {
            ctrlName = "";
        }
        else {
            ctrlName = ctrlName + "_";
        }

        if ($("[id$=" + ctrlName + "hdnLoclities]").length > 0) {
            $("[id$=" + ctrlName + "hdnLoclities]")[0].value = $("[id$=" + ctrlName + "ddllocalities]")[0].value;
        }
        if ($("[id$=" + ctrlName + "hdnDistricts]").length > 0) {
            $("[id$=" + ctrlName + "hdnDistricts]")[0].value = $("[id$=" + ctrlName + "ddlDistricts]")[0].value;
        }
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
            var userMsg = SListForAppMsg.Get('PlatFormControls_PatientAddress_IN_ascx_01');
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
		if ($("[id$=" + ctrlName + "ddCountry]").length > 0 && $("[id$=" + ctrlName + "ddCountry]").val() == '0') {
            var userMsg = SListForAppMsg.Get('PlatFormControls_PatientAddress_IN_ascx_07');
            var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
            if (ErrorMsg == null) {
                ErrorMsg = "Alert";
            }
            if (userMsg != null) {
                ValidationWindow(userMsg, ErrorMsg);
            }
            else {
                ValidationWindow('Select Country', 'Error');
            }
            $("[id$=" + ctrlName + "ddCountry]").focus();
            return false;
        }
        if ($("[id$=" + ctrlName + "ddState]").length > 0 && $("[id$=" + ctrlName + "ddState]").val() == '0') {
            var userMsg = SListForAppMsg.Get('PlatFormControls_PatientAddress_IN_ascx_02');
            var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
            if (ErrorMsg == null) {
                ErrorMsg = "Alert";
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

        if ($("[id$=hdnDistrictYN]")[0].value == 'Y') {
            if ($("[id$=" + ctrlName + "ddlDistricts]").length > 0 && ($("[id$=" + ctrlName + "ddlDistricts]").val() == '0' || $("[id$=" + ctrlName + "ddlDistricts]").val() == undefined || $("[id$=" + ctrlName + "ddlDistricts]").val() == "") && Config != "Y") {
                var userMsg = SListForAppMsg.Get('PlatFormControls_PatientAddress_IN_ascx_03');
                var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
                if (ErrorMsg == null) {
                    ErrorMsg = "Error";
                }
                if (userMsg != null) {
                    ValidationWindow(userMsg, ErrorMsg);
                }
                else {
                    ValidationWindow('Select Districts', 'Error');
                }
                $("[id$=" + ctrlName + "ddlDistricts]").focus();
                return false;
            }

        if ($("[id$=" + ctrlName + "ddlCity]").length > 0 && $("[id$=" + ctrlName + "ddlCity]").val() == '0') {
            var userMsg = SListForAppMsg.Get('PlatFormControls_PatientAddress_IN_ascx_05');
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
        }

        if ($("#mobilen").css('display') != 'none')
        {
        if ($("[id$=" + ctrlName + "txtMobile]").length > 0 && ($("[id$=" + ctrlName + "txtMobile]")[0].value == '') && ($("[id$=" + ctrlName + "txtLandLine]")[0].value == '')) {
            var userMsg = SListForAppMsg.Get('PlatFormControls_PatientAddress_IN_ascx_04');
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
         }   
    var ConfigPost = document.getElementById("<%=hdnIsPostalCodeNeed.ClientID %>").value;

    if ( $("[id$=" + ctrlName + "txtPostalCode]")[0].value == '' && ConfigPost == "Y") {
        var userMsg = SListForAppMsg.Get('PlatFormControls_PatientAddress_IN_ascx_08');
        var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
        if (ErrorMsg == null) {
            ErrorMsg = "Error";
        }
        if (userMsg != null) {
            ValidationWindow(userMsg, ErrorMsg);
        }
        else {
            ValidationWindow('Provide Postal Code', 'Error');
        }
        $("[id$=" + ctrlName + "txtPostalCode]")[0].focus();
        return false;
    }
            if ($("[id$=hdnPostalCodeYN]")[0].value == 'Y') {
                if ($("[id$=" + ctrlName + "txtPostalCode]").length > 0 && ($("[id$=" + ctrlName + "txtPostalCode]")[0].value == '')) {
                    var userMsg = SListForAppMsg.Get("CommonControls_PatientAddress_IN_ascx_05") == null ? "Provide Postal Code" : SListForAppMsg.Get("CommonControls_PatientAddress_IN_ascx_05");
                    ValidationWindow(userMsg, errorMsg);
                    $("[id$=" + ctrlName + "txtPostalCode]")[0].focus();
                    return false;
        }
        }

        return true;
    }

    function SetAddress() {
        document.getElementById('<%=ddCountry.ClientID %>').selectedIndex = 0;
        document.getElementById('<%=ddlDistricts.ClientID %>').selectedIndex = 0;
        document.getElementById('<%=ddlCity.ClientID %>').selectedIndex = 0;
        
    }


    function loadState(objState, objID) {

        var parID = objState.substring(0, objState.lastIndexOf('_')); //objState.split("_")[0];
        var Length;
        var select = ClientSelect.Select;
        var orgID = document.getElementById("<%=hdnOrgID.ClientID %>").value;
        var Langcode = document.getElementById("<%=hdnLangCode.ClientID %>").value;
        var selectMsg = SListForAppDisplay.Get("PlatFormControls_PatientAddress_IN_ascx_01") != null ? SListForAppDisplay.Get("PlatFormControls_PatientAddress_IN_ascx_01") : "Select";
        document.getElementById(parID + "_hdnAddressCountry").value = document.getElementById(objState).value;
        $("select[id$=" + parID + "_ddState] > option").remove();
      //  $("select[id$=" + parID + "_ddState] > option").empty();
        $("select[id$=" + parID + "_ddlCity] > option").remove();
        $("select[id$=" + parID + "_ddlDistricts] > option").remove();
        $("select[id$=" + parID + "_ddllocalities] > option").remove();
        $.ajax({
            type: "POST",
            url: "../PlatformWebServices/PlatFormServices.asmx/Localities",

            data: "{ 'CodeID': '" + (document.getElementById(parID + "_ddCountry").value) + "','OrgID':" +orgID+",'LangCode':'" + Langcode +"'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var Items = data.d;
                //$("#" + parID + "_ddState").attr("disabled", false);
                $("#" + parID + "_ddState").append('<option value="0">'+selectMsg+' </option>');
                $("#" + parID + "_ddlCity").append('<option value="0">' + selectMsg + '</option>');
                $("#" + parID + "_ddlDistricts").append('<option value="0">' + selectMsg + '</option>');
                $("#" + parID + "_ddllocalities").append('<option value="0">' + selectMsg + '</option>');
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
                        if (document.getElementById(parID + "_hdnAddressCountry").value != document.getElementById("<%=hdnAddressCountry.ClientID %>").value) {
                            //document.getElementById(parID + "_ddState").value = $("[id$=" + parID + "_hdnAddressState]")[0].value;
                        }
                        else {
                            document.getElementById(parID + "_ddState").value = $("[id$=" + parID + "_hdnAddressState]")[0].value;
                        }
                        if (Config != "Y") {
                            loadDis1(parID + "_ddState");
                        }
                        else {
                            loadCity1(parID + "_ddState");
                        }
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
        var orgID = document.getElementById("<%=hdnOrgID.ClientID %>").value;
        var Langcode = document.getElementById("<%=hdnLangCode.ClientID %>").value;
        var selectMsg = SListForAppDisplay.Get("PlatFormControls_PatientAddress_IN_ascx_01") != null ? SListForAppDisplay.Get("PlatFormControls_PatientAddress_IN_ascx_01") : "Select";
        // document.getElementById(parID + "_hdnAddressState").value = document.getElementById(objCity).value;
        // document.getElementById(parID + "_hdnCityID").value = document.getElementById(objCity).value;
        $("select[id$=" + parID + "_ddlCity] > option").remove();
        $("select[id$=" + parID + "_ddllocalities] > option").remove();
        var value = document.getElementById(parID + "_ddlDistricts").value;
        if (value == "") {
            value = StateCode;
        }
        $("select[id$=" + parID + "_ddlCity] > option").remove();
        if(value>0)
        {
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
                $("#" + parID + "_ddlCity").append('<option value="0">'+selectMsg+'</option>');
                $("#" + parID + "_ddlDistricts").append('<option value="0">'+selectMsg+'</option>');
                $("#" + parID + "_ddllocalities").append('<option value="0">'+selectMsg+'</option>');
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
    }

    function HideDistrict(objCity) {
       

        Config = document.getElementById("<%=hdnConfigvalue.ClientID %>").value;
        if (Config == 'Y') {
            if (($('#<%= lblDistricts.ClientID %>').selector == '#ucPAdd_lblDistricts' || $('#<%= lblDistricts.ClientID %>').selector == '#QPR_ucPAdd_lblDistricts') || ($('#<%= lblDistricts.ClientID %>').selector == '#ucCAdd_lblDistricts') || $('#<%= lblDistricts.ClientID %>').selector == '#QPR_ucCAdd_lblDistricts') {
                var CountryValue = document.getElementById("<%=ddCountry.ClientID %>").value;
                var Country = document.getElementById("<%=ddCountry.ClientID %>").options[document.getElementById("<%=ddCountry.ClientID %>").selectedIndex].text;

                var StateValue = document.getElementById("<%=ddState.ClientID %>").value;
                var State = document.getElementById("<%=ddState.ClientID %>").options[document.getElementById("<%=ddState.ClientID %>").selectedIndex].text;
                if (flag = 1) {
                    if ($('#<%= lblDistricts.ClientID %>').selector == '#ucCAdd_lblDistricts' || $('#<%= lblDistricts.ClientID %>').selector == '#ucPAdd_lblDistricts') {
                        var parID = "ucPAdd";
                    }
                    if ($('#<%= lblDistricts.ClientID %>').selector == '#QPR_ucPAdd_lblDistricts') {
                        var parID = "QPR_ucPAdd";
                    }
                }

                if (Country == 'United Arab Emirates' || Config == 'Y') {
                    $("<%=lblDistricts.ClientID %>").closest("td").hide();
                    $("<%=ddlDistricts.ClientID %>").closest("td").hide();

                    $("#<%=lblDistricts.ClientID %>").hide();
                    $("#<%=ddlDistricts.ClientID %>").hide();
                    $("#<%=ddlDistricts.ClientID %>").next().hide();
                    
                    document.getElementById("<%=ddlDistricts.ClientID %>")[0].value = StateValue;
                    document.getElementById("<%=ddlDistricts.ClientID %>")[0].text = State;
                    document.getElementById("<%=hdnDistricts.ClientID %>").value = StateValue;
                    
                    
                }
                else {
                    $("<%=lblDistricts.ClientID %>").closest("td").show();
                    $("<%=ddlDistricts.ClientID %>").closest("td").show();

                    $("#<%=lblDistricts.ClientID %>").show();
                    $("#<%=ddlDistricts.ClientID %>").show();
                    $("#<%=ddlDistricts.ClientID %>").next().show();
                }
            }

            else {
                $("<%=lblDistricts.ClientID %>").closest("td").show();
                $("<%=ddlDistricts.ClientID %>").closest("td").show();

                $("#<%=lblDistricts.ClientID %>").show();
                $("#<%=ddlDistricts.ClientID %>").show();
                $("#<%=ddlDistricts.ClientID %>").next().show();
            }
        }
    }
    window.onload = HideDistrict();

    function loadCity1(objCity) {

        var parID = objCity.substring(0, objCity.lastIndexOf('_')); // objCity.split("_")[0];
        var orgID = document.getElementById("<%=hdnOrgID.ClientID %>").value;
        var Langcode = document.getElementById("<%=hdnLangCode.ClientID %>").value;
        var selectMsg = SListForAppDisplay.Get("PlatFormControls_PatientAddress_IN_ascx_01") != null ? SListForAppDisplay.Get("PlatFormControls_PatientAddress_IN_ascx_01") : "Select";
      //  var select = ClientSelect.Select;
        $("select[id$=" + parID + "_ddlCity] > option").remove();
        $("select[id$=" + parID + "_ddllocalities] > option").remove();
		if(Config != 'Y'){
        var value = document.getElementById(parID + "_ddlDistricts").value;
//        if (value == "") {
//            value = StateCode;
//        }      
		}
		else{
		var value = document.getElementById(parID + "_ddState").value;
                if (value == "") {
                    value = StateCode;
                }  
		}
            document.getElementById(parID + "_hdnDistricts").value = value;
		$("#" + parID + "_ddlCity").append('<option value="0">'+selectMsg+'</option>');
		$("#" + parID + "_ddllocalities").append('<option value="0">'+selectMsg+'</option>');
		if(value>0)
		{
        $.ajax({
            type: "POST",
            url: "../PlatformWebServices/PlatFormServices.asmx/Localities",
            data: "{ 'CodeID': '" + value + "','OrgID':" + orgID + ",'LangCode':'" + Langcode + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var Items = data.d;
                $.each(Items, function(index, Item) {
                    $("#" + parID + "_ddlCity").append('<option value="' + Item.Locality_ID + '">' + Item.Locality_Value + '</option>');
                });

                if ($("[id$=" + parID + "_hdnCityID]").length > 0) {
                    if ($("[id$=" + parID + "_hdnCityID]")[0].value != undefined && $("[id$=" + parID + "_hdnCityID]")[0].value != "") {
                        document.getElementById(parID + "_ddlCity").value = $("[id$=" + parID + "_hdnCityID]")[0].value;
                        loaLocality(parID + "_ddlCity");
		                if (document.getElementById(parID + "_ddlCity").value == "")
		                    document.getElementById(parID + "_ddlCity").value = 0;
                    }
                }
            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }
        });
    }
    }

    function loadDis(objCity, DistrictID, CityCode) 
    
    {

        var parID = objCity.substring(0, objCity.lastIndexOf('_')); // objCity.split("_")[0];
        var select = SListForAppDisplay.Get("PlatFormControls_PatientAddress_IN_ascx_01") != null ? SListForAppDisplay.Get("PlatFormControls_PatientAddress_IN_ascx_01") : "Select";
        var orgID = document.getElementById("<%=hdnOrgID.ClientID %>").value;
        var Langcode = document.getElementById("<%=hdnLangCode.ClientID %>").value;
        //  document.getElementById(parID + "_hdnCityID").value = document.getElementById(objCity).value;
        //document.getElementById(parID + "_hdnAddressState").value = document.getElementById(objCity).value;
        $("select[id$=" + parID + "_ddlDistricts] > option").remove();
        $("select[id$=" + parID + "_ddlCity] > option").remove();
        $("select[id$=" + parID + "_ddllocalities] > option").remove();
        // var parID = objCity.split("_")[0];
        var value = document.getElementById(parID + "_ddState").value;
        if (value == "") {
            value = CityCode;
        }
        if(value>0)
        {
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
                $("#" + parID + "_ddlDistricts").append('<option value="0">' + select + '</option>');
                $("#" + parID + "_ddllocalities").append('<option value="0">' + select + '</option>');
                $("#" + parID + "_ddlCity").append('<option value="0">' + selectMsg + '</option>');
                
                $.each(Items, function(index, Item) {
                    $("#" + parID + "_ddlDistricts").append('<option value="' + Item.Locality_ID + '">' + Item.Locality_Value + '</option>');

                });
                if (DistrictID > 0) {
                    document.getElementById(parID + "_ddlDistricts").value = DistrictID;
                    document.getElementById(parID + "_hdnDistricts").value = DistrictID;
                }
                if ($("[id$=" + parID + "_hdnDistricts]").length > 0) {
                    if ($("[id$=" + parID + "_hdnDistricts]")[0].value != undefined && $("[id$=" + parID + "_hdnDistricts]")[0].value != "") {
                        document.getElementById(parID + "_ddlDistricts").value = $("[id$=" + parID + "_hdnDistricts]")[0].value;
                        loadCity1(parID + "_ddlDistricts");
                    }
                }
            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }
        });
        }
    }

    function loadDis1(objCity) {
        var setstateid = $("#<%=ddState.ClientID %>").val(); // document.getElementById("<%=ddState.ClientID %>").selectedIndex;
        //document.getElementById("<%=ddState.ClientID %>").Value;
        $("#<%=hdnStateid.ClientID %>").val(setstateid);
        Config = document.getElementById('<%=hdnConfigvalue.ClientID %>').value;
        if (Config == 'Y') {
            if ($('#<%= lblDistricts.ClientID %>').selector == '#ucCAdd_lblDistricts' || $('#<%= lblDistricts.ClientID %>').selector == '#ucPAdd_lblDistricts') {
                var parID = "ucPAdd";
            }
            if ($('#<%= lblDistricts.ClientID %>').selector == '#QPR_ucPAdd_lblDistricts') {
                var parID = "QPR_ucPAdd";
            }
            if (($('#<%= lblDistricts.ClientID %>').selector == '#ucCAdd_lblDistricts' || $('#<%= lblDistricts.ClientID %>').selector == '#QPR_ucPAdd_lblDistricts') || (($('#<%= lblDistricts.ClientID %>').selector == '#ucPAdd_lblDistricts' || $('#<%= lblDistricts.ClientID %>').selector == '#QPR_ucCAdd_lblDistricts'))) {
                var flag = 1;
                loadCity1(parID + "_ddState");
            }
        }
        else {
            $("#ucPAdd_lblDistricts").closest("td").show();
            $("#ucPAdd_ddlDistricts").closest("td").show();

            var parID = objCity.substring(0, objCity.lastIndexOf('_')); // objCity.split("_")[0];
            var select = SListForAppDisplay.Get("PlatFormControls_PatientAddress_IN_ascx_01") != null ? SListForAppDisplay.Get("PlatFormControls_PatientAddress_IN_ascx_01") : "Select";
            var orgID = document.getElementById("<%=hdnOrgID.ClientID %>").value;
            var Langcode = document.getElementById("<%=hdnLangCode.ClientID %>").value;
            $("select[id$=" + parID + "_ddlDistricts] > option").remove();
            $("select[id$=" + parID + "_ddlCity] > option").remove();
            $("select[id$=" + parID + "_ddllocalities] > option").remove();
            var value = document.getElementById(parID + "_ddState").value;
            if (value == "") {
                value = CityCode;
            }
            $("#" + parID + "_ddlDistricts").append('<option value="0">' + select + '</option>');
            $("#" + parID + "_ddlCity").append('<option value="0">' + select + '</option>');
            $("#" + parID + "_ddllocalities").append('<option value="0">' + select + '</option>');
            if (value != "" && value != "0") {
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
                            $("#" + parID + "_ddlDistricts").append('<option value="' + Item.Locality_ID + '">' + Item.Locality_Value + '</option>');

                        });
                        if ($("[id$=" + parID + "_hdnDistricts]").length > 0) {
                            if ($("[id$=" + parID + "_hdnDistricts]")[0].value != undefined && $("[id$=" + parID + "_hdnDistricts]")[0].value != "") {
                                document.getElementById(parID + "_ddlDistricts").value = $("[id$=" + parID + "_hdnDistricts]")[0].value;
                                loadCity(parID + "_ddlDistricts");
                            }
                        }
                    },
                    failure: function(msg) {
                        ShowErrorMessage(msg);
                    }
                });
            }
        }
    }
    function loaLocality(objLocality, LocalityID, DistrictID) {

        var parID = objLocality.substring(0, objLocality.lastIndexOf('_'));  //objLocality.split("_")[0];
        var select = SListForAppDisplay.Get("PlatFormControls_PatientAddress_IN_ascx_01") != null ? SListForAppDisplay.Get("PlatFormControls_PatientAddress_IN_ascx_01") : "Select";
        var orgID = document.getElementById("<%=hdnOrgID.ClientID %>").value;
        var Langcode = document.getElementById("<%=hdnLangCode.ClientID %>").value;
        $("select[id$=" + parID + "_ddllocalities] > option").remove();
        // document.getElementById(parID + "_hdnLoclities").value = document.getElementById(objLocality).value;
        // var parID = objLocality.split("_")[0];
        var value = document.getElementById(parID + "_hdnDistricts").value;
        if (value == "") {
            value = DistrictID;
        }
        if(value>0)
        {
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
                $("#" + parID + "_ddllocalities").append('<option value="0">' + select + '</option>');
                $.each(Items, function(index, Item) {
                    $("#" + parID + "_ddllocalities").append('<option value="' + Item.Locality_ID + '">' + Item.Locality_Value + '</option>');

                });
                if (LocalityID > 0) {
                    document.getElementById(parID + "_ddllocalities").value = LocalityID;
                }
                if ($("[id$=" + parID + "_hdnLoclities]").length > 0) {
                    if ($("[id$=" + parID + "_hdnLoclities]")[0].value != undefined && $("[id$=" + parID + "_hdnLoclities]")[0].value != "") {
                        document.getElementById(parID + "_ddllocalities").value = $("[id$=" + parID + "_hdnLoclities]")[0].value;
                        //loaLocality(parID + "_ddllocalities");
                    }
                }
            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }
        });
        }
    }


    function loaLocality1(objLocality) {

        var parID = objLocality.substring(0, objLocality.lastIndexOf('_'));  //objLocality.split("_")[0];
        var select = SListForAppDisplay.Get("PlatFormControls_PatientAddress_IN_ascx_01") != null ? SListForAppDisplay.Get("PlatFormControls_PatientAddress_IN_ascx_01") : "Select";
        var orgID = document.getElementById("<%=hdnOrgID.ClientID %>").value;
        var Langcode = document.getElementById("<%=hdnLangCode.ClientID %>").value;
        $("select[id$=" + parID + "_ddllocalities] > option").remove();
        // document.getElementById(parID + "_hdnLoclities").value = document.getElementById(objLocality).value;
        // var parID = objLocality.split("_")[0];
        var value = document.getElementById(parID + "_ddlCity").value;
        document.getElementById(parID + "_hdnCityID").value = value;
        if (value == "") {
            value = DistrictID;
        }
        $("#" + parID + "_ddllocalities").append('<option value="0">' + select + '</option>');
        if (value > 0) {
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

                });
            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }
        });
        }
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
        if ($("[id$=ddlDistricts]").length > 0) {
            $("[id$=ddlDistricts]")[0].disabled = true;
        }
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
        if ($("[id$=ddlDistricts]").length > 0) {
            $("[id$=ddlDistricts]")[0].disabled = false;
        }
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
        if (StateCode != undefined && StateCode != "") {
            loadState(CtrlName + "_ddCountry", StateCode);
        }
        else {
        loadState(CtrlName + "_ddCountry");
    }
    }
    function ValidateSplChar(txt) {
        txt.value = txt.value.replace(/[^a-zA-Z 0-9,._\-\ \n\r]+/g, '');
        var maxlength = 250;
        var object = document.getElementById(txt.id)
        if (object.value.length > maxlength) {
            object.focus();
            object.value = txt.value.substring(0, maxlength);
            object.scrollTop = object.scrollHeight;
            alert('Please enter a maximum of 250 characters');
            return false;
        }
        return true;
    }
    
</script>

