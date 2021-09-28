<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UCDate.ascx.cs" Inherits="UCDate" %>
&nbsp; &nbsp;
<div style="z-index: 101; left: 4px; width: 341px; position: absolute; top: 6px;
    height: 1px">
<asp:TextBox ID="C_txtDate" runat="server"  CssClass="Txtboxsmall" Width="91px"></asp:TextBox>
<asp:Button ID="C_btnDate" runat="server" OnClick="C_btnDate_Click" Text="...." />
    <asp:Calendar ID="C_Calender" runat="server" DayNameFormat="FirstLetter" OnSelectionChanged="C_Calender_SelectionChanged"
        Style="left: 136px; position: relative; top: -21px" Visible="False">
        <DayHeaderStyle BackColor="Cornsilk" ForeColor="#804040" />
    </asp:Calendar>
</div>
