<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReminderPage.aspx.cs" Inherits="Reminder_ReminderPage"
   Culture="auto" UICulture="auto" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/DateTimePicker.ascx" TagName="DateTimePicker"
    TagPrefix="uc5" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Reminder</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script type="text/javascript">

        function CheckReminder() {

            if (document.getElementById('txtStartDt').value == '') {

                alert('Provide Start date');
                document.getElementById('txtStartDt').focus();
                return false;
            }

            if (document.getElementById('txtEndDt').value == '') {

                alert('Provide End date ');
                document.getElementById('txtEndDt').focus();
                return false;
            }

            if (document.getElementById('txtNotes').value == '') {

                alert('Provide Notes');
                document.getElementById('txtNotes').focus();
                return false;
            }

            if (document.getElementById('ddlFrequency').value == '----Select----') {

                alert('Select Frequency');
                document.getElementById('ddlFrequency').focus();
                return false;
            }

            return true;
        }
    
    </script>

</head>
<body oncontextmenu="return false;" onload="pageLoadFocus('txtStartDt');">
    <form id="form1" runat="server" defaultbutton="btnSave">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        
                        <table class="tabletxt w-100p searchPanel">
                           
                            <tr class="ReminderRow">
                                <td class="w-8p">
                                    <asp:Label ID="lblStartDt" runat="server" Text="Start Date" class="label_title"></asp:Label>
                                </td>
                                <td class="w-75p">
                                    <asp:TextBox ID="txtStartDt" runat="server"  CssClass ="Txtboxsmall" TabIndex="1" MaxLength="1"
                                        Style="text-align: justify" ValidationGroup="MKE" />
                                    <asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                        CausesValidation="False" />
                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtStartDt"
                                        Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                        OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                        ErrorTooltipEnabled="True" />
                                    <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                        ControlToValidate="txtStartDt" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                        ValidationGroup="MKE" />
                                    <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtStartDt"
                                        PopupButtonID="ImgBntCalc" Format="dd/MM/yyyy" />
                                </td>
                                <td class="w-5p">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="ReminderRow">
                                <td>
                                    <asp:Label ID="lblEndDt" runat="server" Text="End Date" class="label_title"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtEndDt" runat="server" TabIndex="2" MaxLength="1" CssClass="Txtboxsmall"
                                        Style="text-align: justify" ValidationGroup="MKE" />
                                    <asp:ImageButton ID="ImgBntCalc1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                        CausesValidation="False" />
                                    <ajc:MaskedEditExtender ID="MaskedEditExtender6" runat="server" TargetControlID="txtEndDt"
                                        Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                        OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                        ErrorTooltipEnabled="True" />
                                    <ajc:MaskedEditValidator ID="MaskedEditValidator6" runat="server" ControlExtender="MaskedEditExtender6"
                                        ControlToValidate="txtEndDt" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                        ValidationGroup="MKE" />
                                    <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtEndDt"
                                        PopupButtonID="ImgBntCalc1" Format="dd/MM/yyyy" />
                                </td>
                                <td>
                                    <input type="hidden" runat="server" id="hdnReminderTemplateID" />
                                </td>
                            </tr>
                            <tr class="ReminderRow">
                                <td>
                                    <asp:Label ID="lblNote" runat="server" Text="Notes" class="label_title"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" TabIndex="3"></asp:TextBox>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="ReminderRow">
                                <td>
                                    <asp:Label ID="lblFequency" runat="server" Text="Frequency" class="label_title"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlFrequency" runat="server" CssClass="ddl" TabIndex="4">
                                        <asp:ListItem>----Select----</asp:ListItem>
                                        <asp:ListItem>Daily</asp:ListItem>
                                        <asp:ListItem>Weekly</asp:ListItem>
                                        <asp:ListItem>Monthly</asp:ListItem>
                                        <asp:ListItem>Quarterly</asp:ListItem>
                                        <asp:ListItem>HalfYearly</asp:ListItem>
                                        <asp:ListItem>Yearly</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="ReminderRow">
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:Button ID="btnSave" runat="server" Text="Save" TabIndex="5" CssClass="btn"
                                        onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                                        OnClick="btnSave_Click" OnClientClick="return CheckReminder()" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" TabIndex="6" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnCancel_Click" />
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" class="defaultfontcolor">
                                    <asp:GridView runat="server" ID="gvReminderTemplate" AutoGenerateColumns="False"
                                        OnRowCommand="gvReminderTemplate_RowCommand" OnRowDeleting="gvReminderTemplate_RowDeleting"
                                        OnRowEditing="gvReminderTemplate_RowEditing" CssClass="defaultfontcolor gridView w-100p" OnRowDataBound="gvReminderTemplate_RowDataBound">
                                        <HeaderStyle CssClass="dataheader1" />
                                        <Columns>
                                            <asp:TemplateField ControlStyle-Width="0" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblReminderTemplateID" Text='<%#Bind("ReminderTemplateID") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ControlStyle Width="0px"></ControlStyle>
                                            </asp:TemplateField>
                                            <asp:TemplateField ControlStyle-Width="0" HeaderText="Start Date" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblStartDate" Text='<%#Bind("StartDate") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ControlStyle Width="0px"></ControlStyle>
                                            </asp:TemplateField>
                                            <asp:TemplateField ControlStyle-Width="0" HeaderText="End Date" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblEndDate" Text='<%#Bind("EndDate") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ControlStyle Width="0px"></ControlStyle>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="StartDate" DataFormatString="{0:dd/MM/yyy}" HeaderText="Start date" />
                                            <asp:BoundField DataField="EndDate" DataFormatString="{0:dd/MM/yyy}" HeaderText="End date" />
                                            <asp:TemplateField ControlStyle-Width="0" HeaderText="Notes">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblNotes" Text='<%#Bind("Notes") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ControlStyle Width="0px"></ControlStyle>
                                            </asp:TemplateField>
                                            <asp:TemplateField ControlStyle-Width="50" HeaderText="Frequency">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblFrequency" Text='<%#Bind("Frequency") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ControlStyle Width="50px"></ControlStyle>
                                            </asp:TemplateField>
                                            <asp:ButtonField CommandName="Edit" ItemStyle-ForeColor="black" ButtonType="Link"
                                                Text="Edit" />
                                            <asp:ButtonField CommandName="Delete" ItemStyle-ForeColor="black" ButtonType="Link"
                                                Text="Delete" />
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </div>
     <Attune:Attunefooter ID="Attunefooter" runat="server" />        
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
