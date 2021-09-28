<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TimingSpecimen.ascx.cs"
    Inherits="CommonControls_TimingSpecimen" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<style type="text/css">
    .style1
    {
        width: 283px;
    }
</style>

<script language="javascript" type="text/javascript">

    function ValidateDate() {
        if (document.getElementById("<%=txtFrom.ClientID%>").value == "") {
            alert("Enter From Date");
        }
        if (document.getElementById("<%=txtTo.ClientID%>").value == "") {
            alert("Enter To Date");
        }
    }
    function validatePageNumber() {
        if (document.getElementById('txtpageNo').value == "") {
            return false;
        }
    }
</script>

<script runat="server">
    string _date;
    string GetDate(string Date)
    {
        if (Date != "01/01/1900")
        {
            _date = Date;
        }
        else
        {
            _date = "--";
        }
        return _date;
    }
</script>

<%--<table width="100%">
    <tr>
        <td>--%>
<asp:UpdateProgress ID="prog1" runat="server">
    <ProgressTemplate>
        <div id="progressBackgroundFilter" class="a-center">
        </div>
        <div id="processMessage" class="a-center w-20p">
            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                meta:resourcekey="img1Resource1" />
        </div>
    </ProgressTemplate>
</asp:UpdateProgress>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:Panel ID="pnlPSearch" CssClass="w-100p" runat="server" meta:resourcekey="pnlPSearchResource1">
            <table class="dataheader3 w-100p defaultfontcolor" style="height: auto">
                <tr>
                    <td>
                        <table class="w-100p">
                            <tr class="a-center">
                                <td class="w-25p">
                                    <asp:Label ID="Label1" Text="From" runat="server" meta:resourcekey="Label1Resource1"></asp:Label>
                                    <asp:TextBox ID="txtFrom" TabIndex="6" CssClass="small" runat="server" meta:resourcekey="txtFromResource1"></asp:TextBox>
                                    <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                        CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" /><br />
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFrom"
                                        Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                        Enabled="True" />
                                    <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                        ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                    <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFrom"
                                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                </td>
                                <td class="w-25p">
                                    <asp:Label ID="lblTo" Text="To" runat="server" meta:resourcekey="lblToResource1"></asp:Label>
                                    &nbsp;<asp:TextBox ID="txtTo" TabIndex="7" CssClass="small" runat="server" meta:resourcekey="txtToResource1"></asp:TextBox>
                                    <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                        CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" /><br />
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTo"
                                        Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                        Enabled="True" />
                                    <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                        ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                    <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtTo"
                                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                                </td>
                                <td class="w-50p a-left">
                                    <asp:Button ID="btnSearch" runat="server" CssClass="btn" TabIndex="8" OnClientClick="javascript:return ValidateDate();"
                                        OnClick="btnSearch_Click" Text="Search" meta:resourcekey="btnSearchResource1" />
                                </td>
                            </tr>
                        </table>
                        <asp:UpdatePanel ID="updatePanel2" runat="server">
                            <ContentTemplate>
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <asp:GridView ID="GridView1" runat="server" ForeColor="Black" CssClass="mytable1 gridView w-96p m-auto"
                                                AutoGenerateColumns="False" AllowPaging="True" DataKeyNames="PatientVisitID,BarcodeNumber,InvSampleStatusID,PatientID,InvestigationID"
                                                OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="10" OnRowDataBound="GridView1_RowDataBound"
                                        OnRowCommand="GridView1_RowCommand" meta:resourcekey="GridView1Resource1">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="VisitID" meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                    <asp:Label ID="lblVisitID" runat="server" Text='<%# Bind("PatientVisitID") %>' meta:resourcekey="lblVisitIDResource1"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Name" meta:resourcekey="TemplateFieldResource2">
                                                        <ItemTemplate>
                                                    <asp:Label ID="lblName" runat="server" Text='<%# Bind("PatientName") %>' meta:resourcekey="lblNameResource1"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Age" meta:resourcekey="TemplateFieldResource3">
                                                        <ItemTemplate>
                                                    <asp:Label ID="lblAge" runat="server" Text='<%# Bind("Age") %>' meta:resourcekey="lblAgeResource1"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Sample Name" meta:resourcekey="TemplateFieldResource4">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSampleName" runat="server" Text='<%# Bind("SampleDesc") %>' meta:resourcekey="lblSampleNameResource1"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Test Name" meta:resourcekey="TemplateFieldResource5">
                                                        <ItemTemplate>
                                                    <asp:Label ID="lblTextName" runat="server" Text='<%# Bind("InvestigtionName") %>'
                                                        meta:resourcekey="lblTextNameResource1"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Mean Time" meta:resourcekey="TemplateFieldResource6">
                                                        <ItemTemplate>
                                                    <asp:Label ID="lblMeanTime" runat="server" Text='<%# Bind("Remarks") %>' meta:resourcekey="lblMeanTimeResource1"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Last Visited Time" meta:resourcekey="TemplateFieldResource7">
                                                        <ItemTemplate>
                                                    <asp:Label ID="lblLstVisitedTime" runat="server" Text='<%# GetDate(DataBinder.Eval(Container.DataItem, "CreatedAt", "{0:dd/MM/yyyy hh:mm tt}").ToString()) %>'
                                                        meta:resourcekey="lblLstVisitedTimeResource1"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Update History" meta:resourcekey="TemplateFieldResource8">
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="imgQuickDiagnosis" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                        CommandName="UpdateHistory" ImageUrl="~/Images/QuickDiagnosis.gif" meta:resourcekey="imgQuickDiagnosisResource1" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <HeaderStyle CssClass="colorforcontent" ForeColor="White" />
                                                <EmptyDataRowStyle BackColor="LightBlue" ForeColor="Black" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr id="GrdFooter" runat="server" style="display: none;" class="dataheaderInvCtrl">
                                        <td colspan="6" class="defaultfontcolor a-center w-100p">
                                            <asp:Label ID="Label19" runat="server" Text="Page"></asp:Label>
                                            <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                            <asp:Label ID="Label20" runat="server" Text="Of"></asp:Label>
                                            <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label>
                                            <asp:Button ID="btnPrevious" runat="server" Text="Previous" CssClass="btn" OnClick="btnPrevious_Click" />
                                            <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn" OnClick="btnNext_Click" />
                                            <asp:HiddenField ID="hdnCurrent" runat="server" />
                                            <asp:Label ID="Label21" runat="server" Text="Enter The Page To Go:"></asp:Label>
                                            <asp:TextBox ID="txtpageNo" runat="server" CssClass="w-30" AutoComplete="off"    onkeypress="return ValidateOnlyNumeric(this);"  ></asp:TextBox>
                                            <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" OnClick="btnGo_Click"
                                                OnClientClick="javascript:return validatePageNumber();" />
                                            <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:Label ID="lblerror" runat="server" meta:resourcekey="lblerrorResource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </ContentTemplate>
</asp:UpdatePanel>
<%--  </td>
    </tr>
</table>
--%>