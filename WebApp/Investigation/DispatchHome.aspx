<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DispatchHome.aspx.cs" Inherits="Investigation_DispatchHome" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="AdminHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientAccessHeader.ascx" TagName="AdminHeader"
    TagPrefix="uc100" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Publish Investigation Report</title>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function checkvalidate() {
            var chkboxrowcount = $("#gvName input[id*='chkSelectNL']:checkbox:checked").size();
            if (chkboxrowcount == 0) {
                alert("please select at least one record");
                return false;
            }
            if ($('#ddlVisitActionName option:selected').val() == "0") {
                $('#ddlVisitActionName').focus();
                alert('select the Actions');
                return false;
            }


        }
        //        $(document).ready(function() {
        //            $('#btnGo').click(function() {
        //                var chkboxrowcount = $("#gvName input[id*='chkSelectNL']:checkbox:checked").size();
        //                if (chkboxrowcount == 0) {
        //                    alert("please select at least a record");
        //                    return false;
        //                }
        //                return true;
        //            });
        //        });
        function UnselectedDatas() {


        }
        function ShowRegDate() {
            document.getElementById('txtFromDate').value = "";
            document.getElementById('txtToDate').value = "";

            document.getElementById('hdnTempFrom').value = "";
            document.getElementById('hdnTempTo').value = "";

            document.getElementById('hdnTempFromPeriod').value = "0";
            document.getElementById('hdnTempToPeriod').value = "0";
            if (document.getElementById('ddlRegisterDate').value == "0") {

                document.getElementById('txtFromDate').value = document.getElementById('hdnFirstDayWeek').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastDayWeek').value;

                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayWeek').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayWeek').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddlRegisterDate').value == "1") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnFirstDayMonth').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastDayMonth').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayMonth').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayMonth').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddlRegisterDate').value == "2") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnFirstDayYear').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastDayYear').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayYear').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayYear').value

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';

            }
            if (document.getElementById('ddlRegisterDate').value == "3") {
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'block';
                document.getElementById('divRegCustomDate').style.display = 'block';
                document.getElementById('divRegCustomDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'inline';
                document.getElementById('hdnTempFromPeriod').value = "1";
                document.getElementById('hdnTempToPeriod').value = "1";

            }
            if (document.getElementById('ddlRegisterDate').value == "-1") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;

                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';


            }
            if (document.getElementById('ddlRegisterDate').value == "4") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;

                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';


            }

            if (document.getElementById('ddlRegisterDate').value == "5") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnLastWeekFirst').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastWeekLast').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastWeekFirst').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastWeekLast').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddlRegisterDate').value == "6") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnLastMonthFirst').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastMonthLast').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastMonthFirst').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastMonthLast').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddlRegisterDate').value == "7") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnLastYearFirst').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastYearLast').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastYearFirst').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastYearLast').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div>
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc2:Header ID="Header2" runat="server" />
                <uc7:AdminHeader ID="AdminHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc3:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc5:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                            <ContentTemplate>
                                <table id="Fulltable" runat="server" width="100%" border="0" cellpadding="2" cellspacing="2">
                                    <tr>
                                        <td>
                                            <div style="width: 100%">
                                                <table id="Headersearch" runat="server" border="0" class="dataheader2">
                                                    <tr>
                                                        <td width="15%">
                                                            <asp:Label runat="server" ID="lblPatientNo" Text="Patient No"></asp:Label>
                                                        </td>
                                                        <td width="15%">
                                                            <asp:TextBox ID="txtPatientNo" onKeyPress="onEnterKeyPress(event);" MaxLength="16"
                                                                runat="server" CssClass="Txtboxsmall"> </asp:TextBox>
                                                        </td>
                                                        <td width="15%">
                                                            <asp:Label ID="lblName" Text="Name" runat="server"></asp:Label>
                                                        </td>
                                                        <td width="15%">
                                                            <asp:TextBox ID="txtName" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                                            <cc1:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" TargetControlID="txtName"
                                                                FirstRowSelected="True" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                MinimumPrefixLength="1" ServiceMethod="GetPatientListWithDetails" ServicePath="~/InventoryWebService.asmx"
                                                                DelimiterCharacters="" Enabled="True">
                                                            </cc1:AutoCompleteExtender>
                                                        </td>
                                                        <td width="15%">
                                                            <asp:Label ID="lblVisitNo" Text="Visit ID / External Visit ID" runat="server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtVisitNo" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top">
                                                            <asp:Label ID="Rs_RegisteredDate" runat="server" Text="Registered Date"></asp:Label>
                                                            <asp:HiddenField ID="hdnFirstDayWeek" runat="server" />
                                                            <asp:HiddenField ID="hdnLastDayWeek" runat="server" />
                                                            <asp:HiddenField ID="hdnFirstDayMonth" runat="server" />
                                                            <asp:HiddenField ID="hdnLastDayMonth" runat="server" />
                                                            <asp:HiddenField ID="hdnFirstDayYear" runat="server" />
                                                            <asp:HiddenField ID="hdnLastDayYear" runat="server" />
                                                            <asp:HiddenField ID="hdnDateImage" runat="server" />
                                                            <asp:HiddenField ID="hdnTempFrom" runat="server" />
                                                            <asp:HiddenField ID="hdnTempTo" runat="server" />
                                                            <asp:HiddenField ID="hdnTempFromPeriod" runat="server" />
                                                            <asp:HiddenField ID="hdnTempToPeriod" runat="server" />
                                                            <asp:HiddenField ID="hdnLastMonthFirst" runat="server" />
                                                            <asp:HiddenField ID="hdnLastMonthLast" runat="server" />
                                                            <asp:HiddenField ID="hdnLastWeekFirst" runat="server" />
                                                            <asp:HiddenField ID="hdnLastWeekLast" runat="server" />
                                                            <asp:HiddenField runat="server" ID="hdnLastYearFirst" />
                                                            <asp:HiddenField ID="hdnLastYearLast" runat="server" />
                                                            <asp:HiddenField ID="hdnActionCount" runat="server" />
                                                        </td>
                                                        <td>
                                                            <span class="richcombobox" style="width: 155px;">
                                                                <asp:DropDownList ID="ddlRegisterDate" CssClass="ddl" Width="155px" onChange="javascript:return ShowRegDate();"
                                                                    runat="server">
                                                                    <asp:ListItem Value="-1" Selected="True" Text="--Select--"></asp:ListItem>
                                                                    <asp:ListItem Value="0" Text="This Week"></asp:ListItem>
                                                                    <asp:ListItem Value="1" Text="This Month"></asp:ListItem>
                                                                    <asp:ListItem Value="2" Text="This Year"></asp:ListItem>                                                                    
                                                               <%-- <asp:ListItem Value="3" Text="Custom Period"></asp:ListItem>--%>
                                                                    <asp:ListItem Value="4" Text="Today"></asp:ListItem>
                                                                    <asp:ListItem Value="5" Text="Last Week"></asp:ListItem>
                                                                    <asp:ListItem Value="6" Text="Last Month"></asp:ListItem>
                                                                    <asp:ListItem Value="7" Text="Last Year"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </span>
                                                            <div id="divRegDate" style="display: none" runat="server">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Rs_FromDate" runat="server" Text="From Date"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox Width="70px" ID="txtFromDate" runat="server"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Rs_ToDate" runat="server" Text="To Date"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox Width="70px" runat="server" ID="txtToDate"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="divRegCustomDate" runat="server" style="display: none;">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Rs_FromDate1" runat="server" Text="From Date"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox Width="70px" ID="txtFromPeriod" runat="server"></asp:TextBox>
                                                                            <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                                                            <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFromPeriod"
                                                                                Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                                CultureTimePlaceholder="" Enabled="True" />
                                                                            <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                                ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFromPeriod"
                                                                                Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Rs_ToDate1" runat="server" Text="To Date" meta:resourcekey="Rs_ToDate1Resource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox Width="70px" runat="server" ID="txtToPeriod" meta:resourcekey="txtToPeriodResource1"></asp:TextBox>
                                                                            <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" />
                                                                            <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtToPeriod"
                                                                                Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                                CultureTimePlaceholder="" Enabled="True" />
                                                                            <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                                                                ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                                            <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToPeriod"
                                                                                Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnsearch" runat="server" Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClick="btnsearch_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:GridView ID="gvName" AllowPaging="True" AutoGenerateColumns="False" CellPadding="0"
                                                CssClass="mytable1" ForeColor="#333333" Width="100%" runat="server" OnPageIndexChanging="gvName_PageIndexChanging"
                                                OnRowDataBound="gvName_RowDataBound" DataKeyNames="PatientID,MobileNumber" EmptyDataText="No Matching Records">
                                                <HeaderStyle CssClass="dataheader1" />
                                                <RowStyle Font-Bold="False" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Select">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkSelectNL" runat="server" />
                                                            <asp:HiddenField ID="hdnSelect" Value='<%# Bind("PatientID") %>' runat="server" />
                                                            <asp:HiddenField ID="hdnPatientvisitid" Value='<%# Bind("PatientVisitId") %>' runat="server" />
                                                            <asp:HiddenField ID="hdnreportstatus" Value='<%# Bind("Status") %>' runat="server" />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" Width="30px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="PatientNumber">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblpnumber" Text='<%# Bind("PatientNumber") %>' runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblName" Text='<%# Bind("PatientName") %>' runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Mobile">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblMobile" runat="server" Text='<%# Bind("MobileNumber") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="PatientAge">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblPatientAge" runat="server" Text='<%# Bind("PatientAge") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Email">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblemail" runat="server" Text='<%# Bind("EMail") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr id="trSelectVisit" runat="server" visible="false" align="center">
                                        <td class="defaultfontcolor">
                                            Select a patient visit
                                            <asp:DropDownList ID="ddlVisitActionName" CssClass="ddl" runat="server">
                                            </asp:DropDownList>
                                            <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClick="btnGo_Click" OnClientClick="return checkvalidate()" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
