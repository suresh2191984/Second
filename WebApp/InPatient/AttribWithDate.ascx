<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AttribWithDate.ascx.cs"
    Inherits="InPatient_AttribWithDate" %>
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="defaultfontcolor">
    <tr>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
        
        <td style="font-weight: normal; font-size: 10px; height: 20px; color: #000; width: 19%;">
            <asp:Label ID="lblName" runat="server" Text="Name" 
                meta:resourcekey="lblNameResource1"></asp:Label>
        </td>
        <td>
     
                 <asp:TextBox ID="txtValue" runat="server" CssClass="Txtboxsmall" Width="130px" TabIndex="4" MaxLength="1"
                Style="text-align: justify" ValidationGroup="MKE" 
                     meta:resourcekey="txtValueResource1" />
                
           <%--   <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                CausesValidation="False" />
            <ajc:maskededitextender id="MaskedEditExtender1" runat="server" targetcontrolid="txtValue"
                mask="99/99/9999" messagevalidatortip="true" onfocuscssclass="MaskedEditFocus"
                oninvalidcssclass="MaskedEditError" masktype="Date" displaymoney="Left" acceptnegative="Left"
                errortooltipenabled="True" />
            <ajc:maskededitvalidator id="MaskedEditValidator1" runat="server" controlextender="MaskedEditExtender1"
                controltovalidate="txtValue" emptyvaluemessage="Date is required" invalidvaluemessage="Date is invalid"
                display="Dynamic" tooltipmessage="(dd-mm-yyyy)" emptyvalueblurredtext="*" invalidvalueblurredmessage="*"
                validationgroup="MKE" />
            <ajc:calendarextender id="CalendarExtender2" runat="server" targetcontrolid="txtValue"
                popupbuttonid="ImageButton1" format="dd/MM/yyyy" />
            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />--%>
            <a href="javascript:NewCal('<%=txtValue.ClientID %>','ddmmyyyy',true,12)">
              <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
        </td>
    </tr>
</table>
