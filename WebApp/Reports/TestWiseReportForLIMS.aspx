<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TestWiseReportForLIMS.aspx.cs"
    Inherits="Reports_TestWiseReportForLIMS" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Test Stat Report</title>
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script type="text/javascript" language="javascript">
        function clearContextText() {
            $('#contentArea').hide();
        }
        function setContextClientValue() {
            var sval = document.getElementById('<%= ddlClientType.ClientID %>').value + "^" + document.getElementById('<%= ddlTrustedOrg.ClientID %>').value;
            $find('<%= AutoCompleteExtenderClient.ClientID %>').set_contextKey(sval);
            return false;
        }
        function SetContextValue() {
            var sval = document.getElementById('<%= ddlTrustedOrg.ClientID %>').value;
            $find('<%= AutoCompleteExtenderReferringHospital.ClientID %>').set_contextKey(sval);
            $find('<%= AutoCompleteExtenderReferringPhysician.ClientID %>').set_contextKey("RPH^" + sval);
            return false;
        }
        function GetReferingPhysicianID(source, eventArgs) {
            document.getElementById('<%= txtReferringPhysician.ClientID %>').value = eventArgs.get_text();
            document.getElementById('<%= hdnPhysicianID.ClientID %>').value = eventArgs.get_value().split('^')[0];
        }
        function GetReferingOrgID(source, eventArgs) {
            document.getElementById('<%= txtReferringHospital.ClientID %>').value = eventArgs.get_text();
            document.getElementById('<%= hdnReferringHospitalID.ClientID %>').value = eventArgs.get_value();
        }
        function alpha(e) {
            var k;
            document.all ? k = e.keyCode : k = e.which;
            return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || k == 46 || (k >= 48 && k <= 57));
        }
        function SelectedClientID(source, eventArgs) {
            document.getElementById('<%= hdnSelectedClientID.ClientID %>').value = eventArgs.get_value();
        }
        function ClearValue(obj) {
            if (document.getElementById(obj).value == "") {
                document.getElementById('<%= hdnSelectedClientID.ClientID %>').value = "0";
            }
        }
        function ClearFields() {
            if (document.getElementById('<%= txtReferringHospital.ClientID %>').value.trim() == "") {
                document.getElementById('<%= hdnReferringHospitalID.ClientID %>').value = "0";
            }
            if (document.getElementById('<%= txtReferringPhysician.ClientID %>').value.trim() == "") {
                document.getElementById('<%= hdnPhysicianID.ClientID %>').value = "0";
            }
        }
    </script>

    <style type="text/css">
        .style2
        {
            width: 12%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <table class="searchPanel w-100p">
                    <tr>
                        <td class="a-left w-12p">
                            <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization" meta:resourcekey="lblOrgsResource1"></asp:Label>
                        </td>
                        <td class="a-left w-15p">
                            <asp:DropDownList ID="ddlTrustedOrg" AutoPostBack="true" onchange="javascript:clearContextText();"
                                runat="server" CssClass="ddl" TabIndex="1" OnSelectedIndexChanged="ddlTrustedOrg_SelectedIndexChanged"
                                Width="150px" meta:resourcekey="ddlTrustedOrgResource1">
                            </asp:DropDownList>
                        </td>
                        <td class="a-left w-10p">
                            <asp:Label ID="lblLoc" Text="Location" runat="server" meta:resourcekey="lblLocResource1"></asp:Label>
                        </td>
                        <td class="a-left w-10p">
                            <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddl" Width="150px" TabIndex="2"
                                meta:resourcekey="ddlLocationResource1">
                            </asp:DropDownList>
                        </td>
                        <td colspan="3" class="w-40p">
                            <table class="w-100p">
                                <tr>
                                    <td class="a-left w-4p">
                                        <asp:Label runat="server" ID="fromDate" Text="From" CssClass="label_title" meta:resourcekey="fromDateResource1"></asp:Label>
                                    </td>
                                    <td class="a-left w-8p">
                                        <asp:TextBox ID="txtFrom" runat="server" CssClass="Txtboxsmall" Width="70px" TabIndex="3"
                                            meta:resourcekey="txtFromResource1" />
                                    </td>
                                    <td class="a-left w-4p">
                                        <asp:Label runat="server" ID="toDate" Text="To" CssClass="label_title" meta:resourcekey="toDateResource1"></asp:Label>
                                    </td>
                                    <td class="a-left w-10p">
                                        <asp:TextBox ID="txtTo" runat="server" CssClass="Txtboxsmall" Width="70px" TabIndex="4"
                                            meta:resourcekey="txtToResource1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-left w-12p">
                            <asp:Label ID="lblReferingOrg" Text="Reference Hospital" runat="server" meta:resourcekey="lblReferingOrgResource1"></asp:Label>
                        </td>
                        <td class="a-left w-15p">
                            <asp:TextBox ID="txtReferringHospital" runat="server" CssClass="Txtboxsmall" onfocus="return SetContextValue();"
                                onBlur="return ClearFields();" Width="150px" TabIndex="5" meta:resourcekey="txtReferringHospitalResource1"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoCompleteExtenderReferringHospital" runat="server"
                                TargetControlID="txtReferringHospital" EnableCaching="False" FirstRowSelected="True"
                                CompletionInterval="1" MinimumPrefixLength="1" CompletionListCssClass="wordWheel listMain .box"
                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                ServiceMethod="GetQuickBillRefOrg" ServicePath="~/WebService.asmx" OnClientItemSelected="GetReferingOrgID"
                                DelimiterCharacters="" Enabled="True">
                            </ajc:AutoCompleteExtender>
                        </td>
                        <td class="a-left w-10p">
                            <asp:Label ID="lblReferringPhysician" Text="Referring Physician" runat="server" meta:resourcekey="lblReferringPhysicianResource1"></asp:Label>
                        </td>
                        <td class="a-left w-10p">
                            <asp:TextBox ID="txtReferringPhysician" runat="server" onfocus="return SetContextValue();"
                                CssClass="Txtboxsmall" onBlur="return ClearFields();" Width="150px" TabIndex="6"
                                meta:resourcekey="txtReferringPhysicianResource1"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoCompleteExtenderReferringPhysician" runat="server"
                                TargetControlID="txtReferringPhysician" EnableCaching="False" FirstRowSelected="True"
                                CompletionInterval="1" MinimumPrefixLength="1" CompletionListCssClass="wordWheel listMain .box"
                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                ServiceMethod="GetRateCardForBilling" ServicePath="~/OPIPBilling.asmx" OnClientItemSelected="GetReferingPhysicianID"
                                DelimiterCharacters="" Enabled="True">
                            </ajc:AutoCompleteExtender>
                        </td>
                        <td class="a-left w-10p">
                            <asp:Label runat="server" ID="lblDepartment" Text="Select Department" CssClass="label_title"
                                meta:resourcekey="lblDepartmentResource1"></asp:Label>
                        </td>
                        <td class="a-left w-15p" colspan="4">
                            <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="ddl" Width="200px"
                                TabIndex="7" meta:resourcekey="ddlDepartmentResource1">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-left w-12p">
                            <asp:Label ID="lblClientType" runat="server" Text="Client type" meta:resourcekey="lblClientTypeResource1"></asp:Label>
                        </td>
                        <td class="a-left w-15p">
                            <asp:DropDownList ID="ddlClientType" Width="150px" runat="server" CssClass="ddl"
                                TabIndex="8" meta:resourcekey="ddlClientTypeResource1">
                            </asp:DropDownList>
                        </td>
                        <td class="a-left w-10p">
                            <asp:Label ID="Label1" Text="Client Name" runat="server" meta:resourcekey="Label1Resource1"></asp:Label>
                        </td>
                        <td class="a-left w-10p">
                            <asp:TextBox ID="txtClient" onfocus="setContextClientValue();" OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"
                                onblur="javascript:ClearValue(this.id);ConverttoUpperCase(this.id);" autocomplete="off"
                                CssClass="Txtboxsmall" runat="server" Width="150px" TabIndex="9" meta:resourcekey="txtClientResource1"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClient" runat="server" TargetControlID="txtClient"
                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetClientList"
                                OnClientItemSelected="SelectedClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                Enabled="True">
                            </ajc:AutoCompleteExtender>
                        </td>
                        <td class="a-left w-10p">
                            <asp:Label ID="lblFeetype" runat="server" Text="Fee type" meta:resourcekey="lblFeetypeResource1"></asp:Label>
                        </td>
                        <td class="a-left w-15p">
                            <asp:DropDownList ID="ddlFeeType" runat="server" CssClass="ddl" Width="200px" TabIndex="10"
                                meta:resourcekey="ddlFeeTypeResource1">
                            </asp:DropDownList>
                        </td>
                        <td class="a-center w-4p">
                            <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
                                OnClick="btnSearch_Click" TabIndex="11" meta:resourcekey="btnSearchResource1" />
                        </td>
                        <td class="a-left">
                            <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="False" runat="server" CssClass="details_label_age"
                                Width="40px" OnClick="lnkBack_Click" TabIndex="12" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                        </td>
                        <td runat="server" id="tdXL">
                            <asp:ImageButton ID="imgBtnXL" Visible="False" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                ToolTip="Save As Excel" OnClick="imgBtnXL_Click" TabIndex="13" meta:resourcekey="imgBtnXLResource1" />
                            <asp:LinkButton ID="lnkExportXL" Visible="False" Text="Export To XL" Font-Underline="True"
                                runat="server" Font-Bold="True" Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel"
                                OnClick="lnkExportXL_Click" TabIndex="14" meta:resourcekey="lnkExportXLResource1"></asp:LinkButton>
                            <input type="hidden" runat="server" value="0" id="hdnXLFlag" />
                        </td>
                    </tr>
                    <tr>
                        <td style="display: none;" class="a-left w-12p">
                            <asp:Label runat="server" ID="lblSample" Text="Select Sample" CssClass="label_title"
                                meta:resourcekey="lblSampleResource1"></asp:Label>
                        </td>
                        <td style="display: none;" class="a-left" colspan="5">
                            <asp:DropDownList ID="ddlSample" runat="server" CssClass="ddl" TabIndex="15" meta:resourcekey="ddlSampleResource1">
                            </asp:DropDownList>
                            <asp:HiddenField ID="hdnReferringHospitalID" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnPhysicianID" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnSelectedClientID" runat="server" Value="0" />
                        </td>
                    </tr>
                </table>
                <div>
                    <table class="w-100p">
                        <tr class="dataheaderInvCtrl" id="contentArea" runat="server">
                            <td>
                                <asp:GridView ID="grdTestReport" runat="server" AutoGenerateColumns="False" Width="100%"
                                    HorizontalAlign="Right" Font-Names="Verdana" Font-Size="10px" RowStyle-HorizontalAlign="Right"
                                    OnRowDataBound="grdTestReport_RowDataBound" meta:resourcekey="grdTestReportResource1">
                                    <RowStyle HorizontalAlign="Right"></RowStyle>
                                    <Columns>
                                        <asp:TemplateField HeaderText="Test Wise Stat Report" meta:resourcekey="TemplateFieldResource2">
                                            <ItemTemplate>
                                                <table class="w-100p">
                                                    <tr>
                                                        <td class="a-left h-25">
                                                            <asp:Label ID="lblReceiptInterim" Style="font-weight: bold; font-size: 10px;" runat="server"
                                                                meta:resourcekey="lblReceiptInterimResource1"></asp:Label>
                                                            <b>
                                                                <%# DataBinder.Eval(Container.DataItem, "DeptName")%></b>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:GridView ID="grdChildGridTestReport" runat="server" AutoGenerateColumns="False"
                                                                ForeColor="#333333" OnRowDataBound="grdChildGridTestReport_RowDataBound" Font-Size="10px"
                                                                CssClass="mytable1 w-100p gridView" meta:resourcekey="grdChildGridTestReportResource1">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="S.No" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                                                        <ItemTemplate>
                                                                            <%# Container.DataItemIndex + 1 %>
                                                                        </ItemTemplate>                                                                       
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="InvestigationName" ItemStyle-HorizontalAlign="left"
                                                                        Visible="true" meta:resourcekey="TemplateFieldResource1">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblInvestigationName" runat="server" Text='<%# Bind("InvestigationName") %>'
                                                                                meta:resourcekey="lblInvestigationNameResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="150px" />
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField ItemStyle-Width="40px" DataField="ProcessingOrgName" HeaderText="Processing Organization"
                                                                        ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource1">
                                                                        <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                                                                    </asp:BoundField>
                                                                    <asp:BoundField ItemStyle-Width="40px" DataField="Location" HeaderText="Location"
                                                                        meta:resourcekey="BoundFieldResource2" ItemStyle-HorizontalAlign="Left">
                                                                        <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                                                                    </asp:BoundField>
                                                                    <asp:BoundField ItemStyle-Width="40px" DataField="DeptName" HeaderText="Department"
                                                                        meta:resourcekey="BoundFieldResource3" ItemStyle-HorizontalAlign="Left">
                                                                        <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                                                                    </asp:BoundField>
                                                                    <asp:BoundField ItemStyle-Width="40px" DataField="ProcessingOrgName" HeaderText="Referring Hospital"
                                                                        meta:resourcekey="BoundFieldResource4" ItemStyle-HorizontalAlign="Left">
                                                                        <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                                                                    </asp:BoundField>
                                                                    <asp:BoundField ItemStyle-Width="40px" DataField="SampleName" HeaderText="Sample name"
                                                                        meta:resourcekey="BoundFieldResource5" ItemStyle-HorizontalAlign="Left" Visible="false">
                                                                        <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                                                                    </asp:BoundField>
                                                                    <asp:BoundField ItemStyle-Width="40px" DataField="ClientName" HeaderText="Client name"
                                                                        meta:resourcekey="BoundFieldResource6" ItemStyle-HorizontalAlign="Left">
                                                                        <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                                                                    </asp:BoundField>
                                                                    <asp:BoundField ItemStyle-Width="30px" DataFormatString="{0:0.00}" DataField="Rate"
                                                                        HeaderText="Rate" meta:resourcekey="BoundFieldResource7">
                                                                        <ItemStyle HorizontalAlign="Right" Wrap="false"></ItemStyle>
                                                                    </asp:BoundField>
                                                                    <asp:BoundField ItemStyle-Width="10px" ItemStyle-HorizontalAlign="Right" DataField="NumberOfOccurance"
                                                                        HeaderText="Number of occurance" meta:resourcekey="BoundFieldResource8" />
                                                                    <asp:BoundField ItemStyle-Width="15px" DataFormatString="{0:0.00}" DataField="BilledAmount"
                                                                        HeaderText="Billed amount" ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource9" />
                                                                    <asp:BoundField ItemStyle-Width="15px" DataField="MyCost" HeaderText="Cost per test"
                                                                        ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource10" />
                                                                    <asp:BoundField ItemStyle-Width="15px" ItemStyle-HorizontalAlign="Right" DataField="NetAmount"
                                                                        HeaderText="Net amount" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource11" />
                                                                </Columns>
                                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddlTrustedOrg" EventName="SelectedIndexChanged" />
                <asp:PostBackTrigger ControlID="imgBtnXL" />
                <asp:PostBackTrigger ControlID="lnkExportXL" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
    <%-- <script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

                    <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>--%>

    <script language="javascript" type="text/javascript">

        function pageLoad() {
            $("#txtFrom").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                    $("#txtTo").datepicker("option", "minDate", selectedDate);

                    var date = $("#txtFrom").datepicker('getDate');
                    //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                    // $("#txtTo").datepicker("option", "maxDate", d);

                }
            });
            $("#txtTo").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                    $("#txtFrom").datepicker("option", "maxDate", selectedDate);
                }
            })

        }
        $(function() {
            $("#txtFrom").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                    $("#txtTo").datepicker("option", "minDate", selectedDate);

                    var date = $("#txtFrom").datepicker('getDate');
                    //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                    // $("#txtTo").datepicker("option", "maxDate", d);

                }
            });
            $("#txtTo").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                    $("#txtFrom").datepicker("option", "maxDate", selectedDate);
                }
            })
        });

    </script>

</body>
</html>
