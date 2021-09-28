<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NewDateTimePicker.ascx.cs"
    Inherits="CommonControls_NewDateTimePicker" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<%--<script src="../Scripts/CollectSample.js" language="javascript" type="text/javascript"></script>--%>

<script type="text/javascript" language="javascript">

    function ValidateTime(Obj) {
        //        if (Obj.id == '<%= txtSampleTime1.ClientID %>') {
        //            if (Obj.value == "") {
        //                document.getElementById('<%= txtSampleTime1.ClientID %>').value = "12";
        //            }
        //            else if (Obj.value > 12 || Obj.value <= 0) {
        //                document.getElementById('<%= txtSampleTime1.ClientID %>').value = "";
        //                document.getElementById('<%= txtSampleTime1.ClientID %>').focus();
        //                alert('Provide valid pick up time(hour) between 0 to 12');
        //            }
        //        }
        //        if (Obj.id == '<%= txtSampleTime2.ClientID %>') {
        //            if (Obj.value == "") {
        //                document.getElementById('<%= txtSampleTime2.ClientID %>').value = "00";
        //            }
        //            else if (Obj.value > 59 || Obj.value < 0) {
        //                document.getElementById('<%= txtSampleTime2.ClientID %>').value = "";
        //                document.getElementById('<%= txtSampleTime2.ClientID %>').focus();
        //                alert('Provide valid pick up time(minutes) between 0 to 59');
        //            }
        //        }
        //        if (Obj.id == 'DateTimePicker1_txtSampleTime1') {
        //            if (Obj.value == "") {
        //                document.getElementById('DateTimePicker1_txtSampleTime1').value = "12";
        //            }
        //            else if (Obj.value > 12 || Obj.value <= 0) {
        //                document.getElementById('DateTimePicker1_txtSampleTime1').value = "";
        //                document.getElementById('DateTimePicker1_txtSampleTime1').focus();
        //                alert('Provide valid pick up time(hour) between 0 to 12');
        //            }
        //        }
        //        if (Obj.id == 'DateTimePicker1_txtSampleTime2') {
        //            if (Obj.value == "") {
        //                document.getElementById('DateTimePicker1_txtSampleTime2').value = "00";
        //            }
        //            else if (Obj.value > 59 || Obj.value <= 0) {
        //                document.getElementById('DateTimePicker1_txtSampleTime2').value = "";
        //                document.getElementById('DateTimePicker1_txtSampleTime2').focus();
        //                alert('Provide valid pick up time(minutes) between 0 to 59');
        //            }
        //        }
        //        if (Obj.id == 'ctlCollectSample_DatePicker1_txtSampleTime1') {
        //            if (Obj.value == "") {
        //                document.getElementById('ctlCollectSample_DatePicker1_txtSampleTime1').value = "12";
        //            }
        //            else if (Obj.value > 12 || Obj.value <= 0) {
        //                document.getElementById('ctlCollectSample_DatePicker1_txtSampleTime1').value = "";
        //                document.getElementById('ctlCollectSample_DatePicker1_txtSampleTime1').focus();
        //                alert('Provide valid pick up time(hour) between 0 to 12');
        //            }
        //        }
        //        if (Obj.id == 'ctlCollectSample_DatePicker1_txtSampleTime2') {
        //            if (Obj.value == "") {
        //                document.getElementById('ctlCollectSample_DatePicker1_txtSampleTime2').value = "00";
        //            }
        //            else if (Obj.value > 59 || Obj.value <= 0) {
        //                document.getElementById('ctlCollectSample_DatePicker1_txtSampleTime2').value = "";
        //                document.getElementById('ctlCollectSample_DatePicker1_txtSampleTime2').focus();
        //                alert('Provide valid pick up time(minutes) between 0 to 59');
        //            }
        //        }
    }
</script>

<div class="w-15p">
    <table class="w-20p" cellpadding="1" cellspacing="1">
        <tr class="v-top">
            <td>
                <asp:TextBox ID="txtSampleDateCollect" runat="server" CssClass="Txtboxsmall" Height="16px"
                    meta:resourceKey="txtSampleDateCollectResource2" Width="80px" ToolTip="dd/mm/yyyy"></asp:TextBox>
                <ajc:MaskedEditExtender ID="MaskedEditExtender14" runat="server" TargetControlID="txtSampleDateCollect"
                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                    CultureTimePlaceholder="" Enabled="True" />
                <ajc:CalendarExtender ID="CalendarExtender12" Format="dd/MM/yyyy" runat="server"
                    TargetControlID="txtSampleDateCollect" PopupButtonID="ImgBntCalc" Enabled="True" />
            </td>
            <td>
                <asp:TextBox ID="txtSampleTime1" runat="server" Height="16px" Width="25px" CssClass="Txtboxsmall"
                    ToolTip="hr" onblur="ValidateTime(this);" MaxLength="2" 
                    meta:resourcekey="txtSampleTime1Resource1"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="txtSampleTime2" runat="server" Height="16px" Width="25px" CssClass="Txtboxsmall"
                    MaxLength="2" ToolTip="mn" onblur="ValidateTime(this);" 
                    meta:resourcekey="txtSampleTime2Resource1"></asp:TextBox>
            </td>
            <td>
                <asp:DropDownList ID="ddlSampleTimeType" Width="45px" CssClass="ddl" runat="server"
                    Height="19px">
                   <%-- <asp:ListItem Text="AM" Value="AM"></asp:ListItem>
                    <asp:ListItem Text="PM" Value="PM"></asp:ListItem>
                    <asp:ListItem Text=" " Value="0"></asp:ListItem>--%>
                </asp:DropDownList>
                <%--<img align="middle" alt="" src="../Images/starbutton.png" />--%>
            </td>
        </tr>
    </table>
    <input id="hdnDateTime" runat="server" type="hidden" />
</div>
