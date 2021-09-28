<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LabTestStatisticsReportLims.aspx.cs"
    Inherits="ReportsLims_LabTestStatisticsReportLims" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>
        <%=Resources.ReportsLims_AppMsg.ReportsLims_LabTestStaticsReportLims_aspx_hdr%>
    </title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script language="javascript" type="text/javascript">
        function validateToDate() {
            var AlrtWinHdr = SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_winhdr") != null ? SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_winhdr") : "Alert";
            var UsrMsgDisp = SListForAppMsg.Get("ReportsLims_LabTestStaticsReportLims_aspx_01") != null ? SListForAppMsg.Get("ReportsLims_LabTestStaticsReportLims_aspx_01") : "Provide / select value for From date";
            var UsrMsgDisp1 = SListForAppMsg.Get("ReportsLims_LabTestStaticsReportLims_aspx_02") != null ? SListForAppMsg.Get("ReportsLims_LabTestStaticsReportLims_aspx_02") : "Provide / select value for To date";
           
            if (document.getElementById('txtFDate').value == '') {
                //alert('Provide / select value for From date');
                ValidationWindow(UsrMsgDisp, AlrtWinHdr);
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                //alert('Provide / select value for To date');
                ValidationWindow(UsrMsgDisp1, AlrtWinHdr);
                document.getElementById('txtTDate').focus();
                return false;
            }
        }
        function popupprint(PrintContent) {
            var prtContent = document.getElementById(PrintContent);
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
        function clearContextText() {
            $('#contentArea').hide();

        }
    </script>

    <style type="text/css">
        .ui-datepicker
        {
            font-size: 8pt !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table id="tblCollectionOPIP" class="w-100p a-center">
            <tr>
                <td>
                    <div class="dataheaderWider">
                        <table id="tbl">
                            <tr>
                                <td>
                                    <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization" 
                                        meta:resourcekey="lblOrgsResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlTrustedOrg" onchange="javascript:clearContextText();" runat="server"
                                        CssClass="ddl">
                                    </asp:DropDownList>
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="Rs_Date" Text="Date :" runat="server" meta:resourcekey="Rs_DateResource1"></asp:Label>
                                </td>
                                <td class="a-left">
                                    <asp:TextBox ID="txtFDate" CssClass="Txtboxsmall" Width="70px" runat="server" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                </td>
                                <td class="a-left">
                                    <asp:TextBox ID="txtTDate" CssClass="Txtboxsmall" Width="70px" runat="server" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                </td>
                                <td class="a-left">
                                    <asp:Panel ID="pnlVisitType" Width="100%" GroupingText="Visit Type" 
                                        runat="server" meta:resourcekey="pnlVisitTypeResource1">
                                        <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" runat="server"
                                           >
                                            <%--<asp:ListItem Text="OP" Selected="True" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                            <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                            <asp:ListItem Text="OP&IP" Value="-1" meta:resourcekey="ListItemResource3"></asp:ListItem>--%>
                                        </asp:RadioButtonList>
                                    </asp:Panel>
                                </td>
                                <td class="a-left">
                                    <asp:Panel ID="pnReportType" runat="server" Width="100%" 
                                        GroupingText="Report Type" meta:resourcekey="pnReportTypeResource1">
                                        <asp:RadioButtonList ID="rblReportType" RepeatDirection="Horizontal" runat="server"
                                            >
                                            <%--<asp:ListItem Text="Summary" Selected="True" Value="0" 
                                                meta:resourcekey="ListItemResource4"></asp:ListItem>
                                            <asp:ListItem Text="Detail" Value="1" meta:resourcekey="ListItemResource5"></asp:ListItem>--%>
                                        </asp:RadioButtonList>
                                    </asp:Panel>
                                </td>
                                <td class="a-left">
                                    <asp:Panel ID="HeaderPanel" Width="100%" GroupingText="Header Type" 
                                        runat="server" meta:resourcekey="HeaderPanelResource1">
                                        <asp:RadioButtonList ID="rblHeader" RepeatDirection="Horizontal" runat="server" >
                                            <%--<asp:ListItem Text="IMAGING" Selected="True" Value="0" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                            <asp:ListItem Text="LAB" Value="1" meta:resourcekey="ListItemResource7"></asp:ListItem>--%>
                                        </asp:RadioButtonList>
                                    </asp:Panel>
                                </td>
                                <td class="a-left">
                                    <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                        OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                </td>
                                <td>
                                </td>
                                <td class="a-left">
                                    <%--<asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click"
                                                        meta:resourcekey="lnkBackResource1">
                                                        <asp:Label ID="Rs_Back" Text="Back" runat="server" meta:resourcekey="Rs_BackResource1"></asp:Label>
                                                        &nbsp;&nbsp;&nbsp;</asp:LinkButton>--%>
                                    <asp:LinkButton ID="lnkBack" runat="server" Text="Back &nbsp; " CssClass="details_label_age"
                                        OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <asp:UpdateProgress ID="Progressbar" runat="server">
                        <ProgressTemplate>
                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                            <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                    <div id="divPrint" visible="false" runat="server">
                        <table class="w-100p">
                            <tr>
                                <td class="a-right paddingR10">
                                    <b id="printText" runat="server">
                                        <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label>
                                    </b>&nbsp;&nbsp;
                                    <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint('prnReport');"
                                        ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                    <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                        ToolTip="Save As Excel" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="divSumm" visible="false" runat="server">
                        <table class="w-100p">
                            <tr>
                                <td class="a-right paddingR10">
                                    <b id="B1" runat="server">
                                        <asp:Label ID="Rs_PrintReport1" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReport1Resource1"></asp:Label>
                                    </b>&nbsp;&nbsp;
                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/printer.gif"
                                        OnClientClick="return popupprint('DivsumPrint');" ToolTip="Print" meta:resourcekey="ImageButton1Resource1" />
                                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                        ToolTip="Save As Excel" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                        <ContentTemplate>
                            <div id="divOPDWCR" runat="server" visible="False">
                                <div id="prnReport">
                                    <asp:GridView ID="gvIPReport" runat="server" AutoGenerateColumns="False" Visible="False"
                                        OnRowDataBound="gvIPReport_RowDataBound" CssClass="gridView w-100p" meta:resourcekey="gvIPReportResource1">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Room Vacancy Report" meta:resourcekey="TemplateFieldResource2">
                                                <ItemTemplate>
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="a-left h-25">
                                                                <b>
                                                                    <asp:Label ID="Rs_Date" Text="Date :" runat="server" meta:resourcekey="Rs_DateResource2"></asp:Label></b>
                                                                <asp:Label ID="lblDate" Font-Bold="True" Font-Size="12px" Text='<%# Eval("VisitDate", "{0:dd/MM/yyyy}") %>'
                                                                    runat="server" meta:resourcekey="lblDateResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="gvIPCreditMain" runat="server" AutoGenerateColumns="False"
                                                                    ForeColor="#333333" CssClass="mytable1 gridView w-100p" OnRowDataBound="gvIPCreditMain_RowDataBound"
                                                                    meta:resourcekey="gvIPCreditMainResource1">
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource">
                                                                            <ItemTemplate>
                                                                                <%# Container.DataItemIndex + 1 %>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Test Name" meta:resourcekey="TemplateFieldResource1">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblDept" Font-Size="12px" Text='<%# Eval("DeptName") %>' runat="server"
                                                                                    meta:resourcekey="lblDeptResource1"></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="TotalCounts" HeaderText="Total Nos" meta:resourcekey="BoundFieldResource1">
                                                                            <ItemStyle Width="50px" />
                                                                        </asp:BoundField>
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
                                </div>
                            </div>
                            <div id="DivsumPrint" runat="server">
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblTottest" Font-Bold="True" runat="server" meta:resourcekey="lblTottestResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:GridView ID="gvIPSummary" runat="server" AutoGenerateColumns="False"
                                                ForeColor="#333333" CssClass="mytable1 gridView" meta:resourcekey="gvIPSummaryResource1">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Test Name" meta:resourcekey="TemplateFieldResource3">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblDept" Font-Size="12px" Text='<%# Eval("DeptName") %>' runat="server"
                                                                meta:resourcekey="lblDeptResource2"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="TotalCounts" HeaderText="Total Nos" meta:resourcekey="BoundFieldResource2">
                                                        <ItemStyle Width="50px" />
                                                    </asp:BoundField>
                                                </Columns>
                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>

<%--    <script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>--%>

<%--    <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>--%>

    <script type="text/javascript">
//                            $(function() {
//                                $("#txtFDate").datepicker({
//                                    changeMonth: true,
//                                    changeYear: true,
//                                    maxDate: 0,
//                                    yearRange: '2008:2030'
//                                });
//                                $("#txtTDate").datepicker({
//                                    changeMonth: true,
//                                    changeYear: true,
//                                    maxDate: 0,
//                                    yearRange: '2008:2030'
//                                })
        //                            });
        $(function() {
        $("#txtFDate").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                $("#txtTDate").datepicker("option", "minDate", selectedDate);

                    var date = $("#txtFDate").datepicker('getDate');
                    //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                    // $("#txtTo").datepicker("option", "maxDate", d);

                }
            });
            $("#txtTDate").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                $("#txtFDate").datepicker("option", "maxDate", selectedDate);
                }
            })
        });

    </script>

</body>
</html>
