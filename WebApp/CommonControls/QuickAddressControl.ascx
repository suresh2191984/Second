<%@ Control Language="C#" AutoEventWireup="true" CodeFile="QuickAddressControl.ascx.cs"
    Inherits="UserControl_QuickAddressControl" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<script src="../Scripts/Common.js" type="text/javascript"></script>

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
</script>

<table width="100%" cellpadding="1" cellspacing="0">
    <tr>
        <td colspan="6" align="left" id="us">
            <asp:Literal ID="litTitle" runat="server" meta:resourcekey="litTitleResource1"></asp:Literal>
        </td>
    </tr>
    <tr>
        <td height="35">
            <table width="100%" border="1" cellpadding="1" cellspacing="1" class="tabledata">
                <tr>
                    <td style="width: 5%" align="left">
                        <asp:Label ID="Rs_Address1" runat="server" Text="Address 1 :" meta:resourcekey="Rs_Address1Resource1" CssClass="biltextb" ></asp:Label>
                    </td>
                    <td style="width: 10%">
                        <asp:TextBox ID="txtAddress2" TextMode="MultiLine" runat="server" onFocus="return expandTextBox(this.id)"
                            onBlur="return collapseTextBox(this.id);" MaxLength="250" TabIndex="9" meta:resourcekey="txtAddress2Resource1" CssClass="biltextb" ></asp:TextBox>&nbsp;<img
                                src="../Images/starbutton.png" alt="" align="middle" />
                    </td>
                    <td style="width: 5%" align="left">
                        <asp:Label ID="Rs_Address2" runat="server" Text="Address 2 :" meta:resourcekey="Rs_Address2Resource1" CssClass="biltextb" ></asp:Label>
                    </td>
                    <td style="width: 10%">
                        <asp:TextBox ID="txtAddress1" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                            MaxLength="250" TabIndex="10" meta:resourcekey="txtAddress1Resource1" CssClass="biltextb" ></asp:TextBox>
                    </td>
                    <td align="left" style="width: 5%">
                        <asp:Label ID="Rs_Address3" runat="server" Text="Address 3 :" meta:resourcekey="Rs_Address3Resource1" CssClass="biltextb" ></asp:Label>
                    </td>
                    <td style="width: 10%">
                        <asp:TextBox ID="txtAddress3" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                            MaxLength="250" TabIndex="11" meta:resourcekey="txtAddress3Resource1" CssClass="biltextb" ></asp:TextBox>
                    </td>
                    <td align="left" style="width: 5%">
                        <asp:Label ID="Rs_City" runat="server" Text="City :" meta:resourcekey="Rs_CityResource1" CssClass="biltextb" ></asp:Label>
                    </td>
                    <td style="width: 10%">
                        <asp:TextBox ID="txtCity" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                            MaxLength="25" TabIndex="12" meta:resourcekey="txtCityResource1" CssClass="biltextb" ></asp:TextBox>
                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                    </td>
                    <td align="left" style="width: 5%">
                        <asp:Label ID="Rs_Country" runat="server" Text="Country :" meta:resourcekey="Rs_CountryResource1" CssClass="biltextb" ></asp:Label>
                    </td>
                    <td style="width: 10%">
                        <asp:DropDownList ID="ddCountry" runat="server" TabIndex="13" AutoPostBack="True"
                            OnSelectedIndexChanged="ddCountry_SelectedIndexChanged" onchange="showotherUCcouuntry(this.id);" CssClass="bilddltb" >
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                     <td align="left" style="width: 5%">
                        <asp:Label ID="Rs_State" runat="server" Text="State :" CssClass="biltextb" ></asp:Label>
                    </td>
                    <td style="width: 10%">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="ddState" runat="server" TabIndex="14" onchange="showotherState(this.id);" CssClass="bilddltb" >
                                </asp:DropDownList>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddCountry" EventName="SelectedIndexChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </td>
                    <td align="left">
                        <asp:Label ID="Rs_PostalCode" runat="server" Text="PostalCode :" meta:resourcekey="Rs_PostalCodeResource1" CssClass="biltextb" ></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPostalCode" TabIndex="15" runat="server" MaxLength="6" meta:resourcekey="txtPostalCodeResource1" CssClass="biltextb" ></asp:TextBox>
                        <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="FilteredTextBoxExtender2"
                            TargetControlID="txtPostalCode" Enabled="True">
                        </ajc:FilteredTextBoxExtender>
                    </td>
                    <td align="left">
                        <asp:Label ID="Rs_Mobile" runat="server" Text="Mobile :" meta:resourcekey="Rs_MobileResource1" CssClass="biltextb" ></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtMobile" TabIndex="16" runat="server" MaxLength="11" meta:resourcekey="txtMobileResource1" CssClass="biltextb" ></asp:TextBox>
                        <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="filtxtMobile"
                            TargetControlID="txtMobile" Enabled="True">
                        </ajc:FilteredTextBoxExtender>
                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" /><img src="../Images/starbutton.png"
                            alt="" align="middle" />
                    </td>
                    <td align="left">
                        <asp:Label ID="Rs_LandLine" runat="server" Text="LandLine :" meta:resourcekey="Rs_LandLineResource1" CssClass="biltextb" ></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtLandLine" onblur="checkLandLineNumber()" TabIndex="17" runat="server"
                            MaxLength="12" meta:resourcekey="txtLandLineResource1" CssClass="biltextb" ></asp:TextBox>
                        <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="FilteredTextBoxExtender1"
                            TargetControlID="txtLandLine" Enabled="True">
                        </ajc:FilteredTextBoxExtender>
                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" /><img src="../Images/starbutton.png"
                            alt="" align="middle" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="right" style="display: none" runat="server" id="tbCountry">
                        <div  CssClass="biltextb" >
                            <table width="100%">
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="Label1" runat="server" Text="Other Country" CssClass="biltextb" ></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtOtherCountry" runat="server" CssClass="biltextb"></asp:TextBox>
                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                    <td colspan="2" style="display: none" runat="server" id="tbState">
                        <div  >
                            <table width="100%">
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="Label2" runat="server" Text="Other State" CssClass="biltextb" ></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtOtherState" runat="server" CssClass="biltextb" ></asp:TextBox>
                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                     <td style="width: 3%; display:none;">
                        <asp:TextBox runat="server" Visible="false" ID="txtAddressID" meta:resourcekey="txtAddressIDResource1" CssClass="biltextb" ></asp:TextBox>
                    </td>
                </tr>
               
            </table>
             <asp:HiddenField ID="hdnCurrentAddressState" runat="server" />
                <asp:HiddenField ID="hdnPermanentAddressState" runat="server" />
                <asp:HiddenField ID="hdnCurrentAddressCountry" runat="server" />
                <asp:HiddenField ID="hdnPermanentAddressCountry" runat="server" />
        </td>
    </tr>
</table>
