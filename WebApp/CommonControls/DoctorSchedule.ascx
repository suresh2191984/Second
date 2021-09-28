<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DoctorSchedule.ascx.cs"
    Inherits="CommonControls_DoctorSchedule" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<style type="text/css">
    </style>

<script type="text/javascript" language="javascript">

    function compareStartDateAndEndDate() {
        var sStartDate = document.getElementById('<%= txtFrom.ClientID %>').value;
        var sStartTime = document.getElementById('<%= ddlfromtime.ClientID %>').value;
        var sEndDate = document.getElementById('<%= txtTo.ClientID %>').value;
        var sEndTime = document.getElementById('<%= ddltotime.ClientID %>').value;

        var days = 0;
        var difference = 0;
        ar1 = new Array();
        ar1 = sStartDate.split("/");
        sStartDate = ar1[1] + "/" + ar1[0] + "/" + ar1[2] + " " + sStartTime;
        ar2 = new Array();
        ar2 = sEndDate.split("/");
        sEndDate = ar2[1] + "/" + ar2[0] + "/" + ar2[2] + " " + sEndTime;

        date1 = new Date(sStartDate);
        date2 = new Date(sEndDate);
        difference = date2 - date1;
        minutes = Math.round(difference / (1000 * 60)); // compute minutes
        if (minutes < 0) {
            document.getElementById('<%= txtFrom.ClientID %>').focus();
            var userMsg = SListForApplicationMessages.Get('CommonControls\\DoctorSchedule.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            }
            else { alert("Start date and time cannot be less than end date and time."); }
            return false;
        }
        else
            return true;
    }
</script>

<div align="center">
    <table cellpadding="2" cellspacing="2">
        <tr>
            <div id="divallPhysicians" runat="server">
                <td>
                    <asp:Label ID="Rs_Physician" runat="server" Text="Physician" meta:resourcekey="Rs_PhysicianResource1"></asp:Label>
                </td>
                <td colspan="2" align="left">
                    <asp:DropDownList ID="ddlPhysician" runat="server" meta:resourcekey="ddlPhysicianResource1">
                    </asp:DropDownList>
                </td>
                <td>
                    &nbsp;
                </td>
            </div>
        </tr>
        <tr>
            <td style="color: #000000;">
                <asp:Label ID="Rs_From" runat="server" Text="From" meta:resourcekey="Rs_FromResource1"></asp:Label>
            </td>
            <td>
                <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" ErrorTooltipEnabled="True"
                    Mask="99/99/9999" MaskType="Date" TargetControlID="txtFrom" CultureAMPMPlaceholder=""
                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                    Enabled="True" />
                <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc"
                    TargetControlID="txtFrom" Enabled="True" />
                <asp:TextBox ID="txtFrom" runat="server" MaxLength="1" Style="text-align: justify"
                    TabIndex="3" ValidationGroup="MKE" Width="130px" meta:resourcekey="txtFromResource1" />
                <asp:ImageButton ID="ImgBntCalc" runat="server" CausesValidation="False" Height="16px"
                    ImageUrl="~/images/Calendar_scheduleHS.png" Width="17px" meta:resourcekey="ImgBntCalcResource1" />
            </td>
            <td>
                <asp:DropDownList ID="ddlfromtime" runat="server" meta:resourcekey="ddlfromtimeResource1">
                </asp:DropDownList>
                &nbsp;<ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                    ControlToValidate="txtFrom" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                    InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(dd-mm-yyyy)"
                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td style="color: #000000;">
                <asp:Label ID="Rs_To" runat="server" Text="To" meta:resourcekey="Rs_ToResource1"></asp:Label>
            </td>
            <td>
                <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" ErrorTooltipEnabled="True"
                    Mask="99/99/9999" MaskType="Date" TargetControlID="txtTo" CultureAMPMPlaceholder=""
                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                    Enabled="True" />
                <ajc:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc1"
                    TargetControlID="txtTo" Enabled="True" />
                <asp:TextBox ID="txtTo" runat="server" MaxLength="1" Style="text-align: justify"
                    TabIndex="4" ValidationGroup="MKE" Width="130px" meta:resourcekey="txtToResource1" />
                <asp:ImageButton ID="ImgBntCalc1" runat="server" CausesValidation="False" Height="16px"
                    ImageUrl="~/images/Calendar_scheduleHS.png" Width="17px" meta:resourcekey="ImgBntCalc1Resource1" />
            </td>
            <td>
                <asp:DropDownList ID="ddltotime" runat="server" meta:resourcekey="ddltotimeResource1">
                </asp:DropDownList>
                &nbsp;<ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                    ControlToValidate="txtTo" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                    InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(dd-mm-yyyy)"
                    ValidationGroup="MKE1" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
            </td>
            <td>
                <asp:Button ID="btnSearch" runat="server" CssClass="btn" onfocus="compareStartDateAndEndDate();"
                    onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Search"
                    OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" />
            </td>
        </tr>
    </table>
    <table style="border: solid 1px white; width: 90%;">
        <tr>
            <td style="overflow: auto">
                <asp:Label ID="lblNoData" runat="server" Font-Names="Verdana" Font-Bold="False" Font-Size="10pt"
                    ForeColor="Red" meta:resourcekey="lblNoDataResource1"></asp:Label>
                <asp:DataList ID="dlFloorMaster" runat="server" RepeatColumns="5" RepeatDirection="Horizontal"
                    OnLoad="Page_Load" meta:resourcekey="dlFloorMasterResource1">
                    <HeaderTemplate>
                        <table style="font-family: Arial; font-size: 11px; padding-left: 2px; text-align: center;
                            height: 50px;">
                            <tr>
                                <td>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <table style="font-family: Arial; font-size: 11px; padding-left: 2px; text-align: center;
                            width: 140px;" class="tokenbooked">
                            <td id="tdCover" style="height: 75px;">
                                <asp:Label ID="lblDoctorName" runat="server" Text='<%# Eval("PhysicianName") %>'></asp:Label><%--meta:resourcekey="lblDoctorNameResource1"--%><br />
                                <asp:Label ID="lblSTARTTIME" runat="server" Text='<%# Eval("StartTime") %>'></asp:Label><%--meta:resourcekey="lblSTARTTIMEResource1"--%>
                                <br />
                                <asp:Label ID="lblENDTIME" runat="server" Text='<%# Eval("EndTime") %>'></asp:Label><%--meta:resourcekey="lblENDTIMEResource1" --%><br />
                                <asp:Label ID="lblBOOKINGDESCRIPTION" runat="server" CssClass="borderstyle22" Text='<%# Eval("BookingDescription") %>'
                                    meta:resourcekey="lblBOOKINGDESCRIPTIONResource1"><%--meta:resourcekey="lblBOOKINGDESCRIPTIONResource1"--%> </asp:Label>
                                <asp:Label ID="lblTOKEN" runat="server" Text='<%# Eval("TokenNumber") %>' Visible="False"></asp:Label><%--meta:resourcekey="lblTOKENResource1"--%>
                            </td>
                        </table>
                    </ItemTemplate>
                    <FooterTemplate>
                        </td> </tr> </table>
                    </FooterTemplate>
                </asp:DataList>
            </td>
        </tr>
    </table>
</div>
<p>
    &nbsp;</p>
