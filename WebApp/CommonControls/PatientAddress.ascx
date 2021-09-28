<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PatientAddress.ascx.cs"
    Inherits="CommonControls_PatientAddress"   %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<script src="../Scripts/PatientsRegistration.js" type="text/javascript"></script>
<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

<script type="text/javascript" src="../Scripts/JsonScript.js"></script>

<script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>

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

<style type="text/css">
    .style1
    {
        height: 48px;
    }
    .style2
    {
        width: 171px;
        height: 48px;
    }
    .style3
    {
        width: 300px;
        height: 48px;
    }
</style>

<table width="100%" cellpadding="2" cellspacing="0">
    <tr>
        <td colspan="6" align="left" id="us">
            <asp:Literal ID="litTitle" runat="server" meta:resourcekey="litTitleResource1"></asp:Literal>
            <asp:Literal ID="litCurrentTitle" runat="server" meta:resourcekey="litCurrentTitleResource1" 
                 ></asp:Literal>
        </td>
    </tr>
    <tr>
        <td height="35">
            <table width="100%" border="0" cellpadding="4" cellspacing="0">
                <tr>
                    <td style="display: none" class="style1">
                        <asp:TextBox runat="server" Visible="False" ID="txtAddressID" 
                            meta:resourcekey="txtAddressIDResource1"></asp:TextBox>
                    </td>
                    <td class="style2">
                        <asp:Label ID="Address1" runat="server" Text="Address 1" 
                            meta:resourcekey="Address1Resource1"></asp:Label>
                    </td>
                    <td class="style3">
                        <asp:TextBox ID="txtAddress2" TextMode="MultiLine" runat="server" onFocus="return expandTextBox(this.id)"
                            Width="150px" onBlur="return collapseTextBox(this.id);" MaxLength="150" 
                            TabIndex="9" meta:resourcekey="txtAddress2Resource1"></asp:TextBox>&nbsp;<img
                                src="../Images/starbutton.png" alt="" align="middle" />
                    </td>
                    <td class="style1">
                        <asp:Label ID="Address2" runat="server" Text="Address 2" 
                            meta:resourcekey="Address2Resource2"></asp:Label>
                    </td>
                    <td class="style1">
                        <asp:TextBox ID="txtAddress1" CssClass="Txtboxsmall" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                            MaxLength="250" TabIndex="10" meta:resourcekey="txtAddress1Resource1"></asp:TextBox>
                    </td>
                    
                </tr>
                <tr>
                    <td style="display: none">
                        &nbsp;
                    </td>
                    <td>
                        <asp:Label ID="Address3" runat="server" Text="Address 3" 
                            meta:resourcekey="Address3Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAddress3" CssClass="Txtboxsmall" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                            MaxLength="250" TabIndex="11" meta:resourcekey="txtAddress3Resource1"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="Country" runat="server" Text="Country" 
                            meta:resourcekey="CountryResource1"></asp:Label>
                    </td>
                    <td style="margin-left: 40px">
                        <asp:DropDownList ID="ddCountry" CssClass="ddlsmall" runat="server" TabIndex="12"  
                             onchange="javascript:loadState(this.id);" 
                            meta:resourcekey="ddCountryResource1">
                        </asp:DropDownList>
                    </td>
                    
                </tr>
                <tr>
                    <td style="display: none">
                        &nbsp;
                    </td>
                    <td>
                        <asp:Label ID="State" runat="server" Text="State" 
                            meta:resourcekey="StateResource1"></asp:Label>
                    </td>
                    <td>
                       
                                <asp:DropDownList ID="ddState" CssClass="ddlsmall" runat="server" 
                                    TabIndex="13"  onchange="javascript:loadCity(this.id);" 
                                    meta:resourcekey="ddStateResource1"></asp:DropDownList>
                              
                    </td>
                    <td>
                        <asp:Label ID="City" runat="server" Text="City" 
                            meta:resourcekey="CityResource1"></asp:Label>
                    </td>
                    <td>
                        <%--<asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>--%>
                                <asp:DropDownList ID="ddlCity" runat="server" CssClass="ddlsmall" 
                            onchange="javascript:loadDis(this.id);" TabIndex="14" 
                            meta:resourcekey="ddlCityResource1" Height="19px" Width="151px">
                                </asp:DropDownList>&nbsp;<img
                                src="../Images/starbutton.png" alt="" align="middle"/>
                                
                            
                                
                            <%--</ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddlCity" EventName="SelectedIndexChanged" />
                            </Triggers>
                        </asp:UpdatePanel>--%>
                    </td>
                    
                    
                </tr>
                <tr style="display:none" id="trOtherCountry" runat="server" >
                    <td style="display: none">
                    </td>
                    <td colspan="2">
                        <div style="display: none" runat="server" id="tbCountry">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <asp:Label ID="Label1" runat="server" Text="Other Country" 
                                            meta:resourcekey="Label1Resource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtOtherCountry" CssClass="Txtboxsmall" runat="server" 
                                            meta:resourcekey="txtOtherCountryResource1"></asp:TextBox>
                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                    <td colspan="2">
                        <div style="display: none" runat="server" id="tbState">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <asp:Label ID="Label2" runat="server" Text="Other State" 
                                            meta:resourcekey="Label2Resource1" ></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtOtherState" CssClass="Txtboxsmall" runat="server" 
                                            meta:resourcekey="txtOtherStateResource1"></asp:TextBox>
                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
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
                        <asp:Label ID="lblDistricts" runat="server" Text="Districts" 
                            meta:resourcekey="lblDistrictsResource1"></asp:Label>
                    </td>
                    <td>
                                <asp:DropDownList ID="ddlDistricts" runat="server" CssClass="ddlsmall" 
                                    onchange="javascript:loaLocality(this.id);" TabIndex="15"
                                    meta:resourcekey="ddlDistrictsResource1">
                                </asp:DropDownList>
                            
                    </td>
                    
                    
                    
                    <td>
                        <asp:Label ID="lblLocality" runat="server" Text="Locality" 
                            meta:resourcekey="lblLocalityResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddllocalities" runat="server" CssClass="ddlsmall" 
                            onchange="javascript:onchangeLocaliy(this.id);" TabIndex="16"
                            meta:resourcekey="ddllocalitiesResource1">
                        </asp:DropDownList>
                    </td>
                    
                </tr>
                <tr>
                    <td style="display: none">
                        &nbsp;
                    </td>
                    <td>
                        <asp:Label ID="PostalCode" runat="server" Text="Postal Code" 
                            meta:resourcekey="PostalCodeResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPostalCode" CssClass="Txtboxsmall" TabIndex="17" runat="server"
                            MaxLength="6" meta:resourcekey="txtPostalCodeResource1" ></asp:TextBox>
                        <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="FilteredTextBoxExtender2"
                            TargetControlID="txtPostalCode" Enabled="True">
                        </ajc:FilteredTextBoxExtender>
                    </td>
                    
                </tr>
                <tr>
                    <td style="display: none">
                        &nbsp;
                    </td>
                    <td>
                        <asp:Label ID="Mobile" runat="server" Text="Mobile" 
                            meta:resourcekey="MobileResource1"></asp:Label>
                    </td>
                    <td colspan="1">
                        <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                            <ContentTemplate>
                                <asp:TextBox ID="txtCountryCode" runat="server" Width="30px" CssClass="Txtboxsmall"
                                    Font-Bold="True" AutoPostBack="True" 
                                    meta:resourcekey="txtCountryCodeResource1"></asp:TextBox>
                                <asp:TextBox ID="txtMobile" CssClass="Txtboxsmall" TabIndex="18" runat="server"  
                                     meta:resourcekey="txtMobileResource1" onblur="checkLandLineNumber()"
                                    ></asp:TextBox>
                                <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="filtxtMobile"
                                    TargetControlID="txtMobile" Enabled="True">
                                </ajc:FilteredTextBoxExtender>
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" /><img src="../Images/starbutton.png"
                                    alt="" align="middle" />
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddCountry" EventName="SelectedIndexChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </td>
                    <td>
                        <asp:Label ID="LandLine" runat="server" Text="Landline" 
                            meta:resourcekey="LandLineResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtLandLine" CssClass="Txtboxsmall" 
                            TabIndex="19" runat="server" MaxLength="12" 
                            meta:resourcekey="txtLandLineResource1"></asp:TextBox>
                        <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="FilteredTextBoxExtender1"
                            TargetControlID="txtLandLine" Enabled="True">
                        </ajc:FilteredTextBoxExtender>
                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" /><img src="../Images/starbutton.png"
                            alt="" align="middle" />
                    </td>
                    
                </tr>
                <asp:HiddenField ID="hdnAddressCountry" runat="server" />
                <asp:HiddenField ID="hdnAddressState" runat="server" />
                <asp:HiddenField ID="hdnCityID" runat="server" />
                <asp:HiddenField ID="hdnDistricts" runat="server" />
                <asp:HiddenField ID="hdnLoclities" runat="server" />
                <asp:HiddenField ID="hdnPhLength" runat="server" />
            </table>
        </td>
    </tr>
</table>
