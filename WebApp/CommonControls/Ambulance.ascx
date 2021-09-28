<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Ambulance.ascx.cs" Inherits="CommonControls_Ambulance" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<style type="text/css">
    .style1
    {
        height: 67px;
    }
</style>
<table width="80%" style="border-color: Red;">
    <tr>
        <td nowrap="nowrap">
            <asp:Label ID="lblAmbulanceNo" runat="server" Text="AmbulanceNo" meta:resourcekey="lblAmbulanceNoResource1"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtAmbulanceNo" runat="server" MaxLength="20" CssClass="biltextb"
                meta:resourcekey="txtAmbulanceNoResource1"></asp:TextBox>
            <ajc:AutoCompleteExtender ID="AutoCompleteExtenderAmbulanceNo" runat="server" TargetControlID="txtAmbulanceNo"
                EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                OnClientItemSelected="funAmbulanceNo" CompletionListCssClass="wordWheel listMain .box"
                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                ServiceMethod="GetAmbulanceNo" ServicePath="~/OPIPBilling.asmx" UseContextKey="True"
                DelimiterCharacters="" Enabled="True">
            </ajc:AutoCompleteExtender>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblDriverName" runat="server" Text="Driver Name" meta:resourcekey="lblDriverNameResource1"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtDriverName" runat="server" MaxLength="100" CssClass="biltextb"
                meta:resourcekey="txtDriverNameResource1"></asp:TextBox>
            <ajc:AutoCompleteExtender ID="AutoCompleteExtenderDriverName" runat="server" TargetControlID="txtDriverName"
                EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                OnClientItemSelected="funDriverName" CompletionListCssClass="wordWheel listMain .box"
                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                ServiceMethod="GetPerformingDriverName" ServicePath="~/OPIPBilling.asmx" UseContextKey="True"
                DelimiterCharacters="" Enabled="True">
            </ajc:AutoCompleteExtender>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblLocation" runat="server" Text="Location" meta:resourcekey="lblLocationResource1"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtLocation" runat="server" MaxLength="100" CssClass="biltextb"
                meta:resourcekey="txtLocationResource1"></asp:TextBox>
            <ajc:AutoCompleteExtender ID="AutoCompleteExtenderLocationID" runat="server" TargetControlID="txtLocation"
                EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                OnClientItemSelected="funLocation" CompletionListCssClass="wordWheel listMain .box"
                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                ServiceMethod="GetLocation" ServicePath="~/OPIPBilling.asmx" UseContextKey="True"
                DelimiterCharacters="" Enabled="True">
            </ajc:AutoCompleteExtender>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblDistance" runat="server" Text="Distance" meta:resourcekey="lblDistanceResource1"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:TextBox ID="txtDistanceKgm" runat="server" MaxLength="5" CssClass="biltextb"
                Style="width: 40px;" meta:resourcekey="txtDistanceKgmResource1"></asp:TextBox>
            <asp:Label ID="lblKgm" runat="server" Text="(IN KM) " Style="color: Red; font-size: 12px;"
                meta:resourcekey="lblKgmResource1"></asp:Label>
            <ajc:FilteredTextBoxExtender ID="fteDistance" runat="server" FilterType="Custom, Numbers"
                ValidChars="." TargetControlID="txtDistanceKgm" Enabled="True">
            </ajc:FilteredTextBoxExtender>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblDuration" runat="server" Text="Duration" meta:resourcekey="lblDurationResource1"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:TextBox ID="txtDuration" runat="server" MaxLength="5" CssClass="biltextb" Style="width: 40px;"
                meta:resourcekey="txtDurationResource1"></asp:TextBox>
            <asp:Label ID="lblHours" runat="server" Text="(IN HOURS) " Style="color: Red; font-size: 12px;"
                meta:resourcekey="lblHoursResource1"></asp:Label>
            <ajc:FilteredTextBoxExtender ID="ftdDuration" runat="server" FilterType="Custom, Numbers"
                ValidChars="." TargetControlID="txtDuration" Enabled="True">
            </ajc:FilteredTextBoxExtender>
        </td>
        <tr>
        </tr>
        <td nowrap="nowrap">
            <asp:Label ID="lblDate" runat="server" Text="Start Date" meta:resourcekey="lblDateResource1"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:TextBox CssClass="biltextb" ID="txtArrivalFromDate" Width="105px" Style="text-align: right;"
                runat="server" ReadOnly="True" meta:resourcekey="txtArrivalFromDateResource1"></asp:TextBox>
            <a id="ahrImgBtn" href="javascript:NewCal('ucAmb_txtArrivalFromDate','ddmmyyyy',true,12);">
                <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date" /></a>
            <asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                CausesValidation="False" Style="display: none;" meta:resourcekey="ImgBntCalcResource1" />
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblToDate" runat="server" Text="To Date" meta:resourcekey="lblToDateResource1"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:TextBox CssClass="biltextb" ID="txtArrivalToDate" Width="105px" Style="text-align: right;"
                runat="server" ReadOnly="True" meta:resourcekey="txtArrivalToDateResource1"></asp:TextBox>
            <a id="a1" href="javascript:NewCal('ucAmb_txtArrivalToDate','ddmmyyyy',true,12);">
                <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date" /></a>
            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                CausesValidation="False" Style="display: none;" meta:resourcekey="ImageButton1Resource1" />
        </td>
    </tr>
</table>
<asp:HiddenField ID="hdnDriverID" runat="server" Value="0" />
<asp:HiddenField ID="hdnAMBID" runat="server" Value="0" />
<asp:HiddenField ID="hdnLocationID" runat="server" Value="0" />

<script type="text/javascript">

  function funDriverName(source, eventArgs) {
         var txtDrivername = eventArgs.get_text();
         var txtDriverID = eventArgs.get_value();
         document.getElementById('<%= txtDriverName.ClientID %>').value = txtDrivername;
         document.getElementById('<%= hdnDriverID.ClientID %>').value = txtDriverID;
       
     }
     
     function funAmbulanceNo(source, eventArgs) {
         var txtAMBName = eventArgs.get_text();
         var txtAMBID= eventArgs.get_value();
         document.getElementById('<%= txtAmbulanceNo.ClientID %>').value = txtAMBName;
         document.getElementById('<%= hdnAMBID.ClientID %>').value = txtAMBID;
       
     }
     
      function funLocation(source, eventArgs) {
         var txtLocation = eventArgs.get_text();
         var txtLcoationID= eventArgs.get_value();
         document.getElementById('<%= txtLocation.ClientID %>').value = txtLocation;
         document.getElementById('<%= hdnLocationID.ClientID %>').value = txtLcoationID;
       
     }
     
     function DateCompare() {
     
            var objFromDate = document.getElementById('<%= txtArrivalFromDate.ClientID %>').value.substring(0,10);
            var objToDate = document.getElementById('<%= txtArrivalToDate.ClientID %>').value.substring(0,10);

            var FromDate = new Date(objFromDate);
            var ToDate = new Date(objToDate);
         
            if (FromDate > ToDate) {
            alert(objFromDate + ' should be less than ' + objToDate);
             return false;
            }
            else
            {
            return true; 
            }
}
     
</script>

