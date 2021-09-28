<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LabStatisticsReportLims.aspx.cs"
    Inherits="ReportsLims_LabStatisticsReportLims" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>
        <%=Resources.ReportsLims_AppMsg.ReportsLims_LabStatisticsReportLims_aspx_hdr%>
    </title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
<link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

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
                        <table id="tblCollectionOPIP" class="a-center w-100p">
                            <tr class="a-center">
                                <td class="a-left">
                                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                                   
                                        <ContentTemplate>
                                         <asp:UpdateProgress ID="Progressbar" runat="server">
                                <ProgressTemplate>
                                    <div id="progressBackgroundFilter" class="a-center">
                                    </div>
                                    <div id="processMessage" class="a-center w-20p">
                                        <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                            meta:resourcekey="img1Resource1" />
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
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
                                                        <td>
                                                            <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                            <asp:TextBox ID="txtFDate" onmousedown="fndate();" CssClass="Txtboxsmall" Width="70px" runat="server" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                            <asp:TextBox ID="txtTDate" onmousedown="fndate();" CssClass="Txtboxsmall" Width="70px" runat="server" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                        </td>
                                                        <td>
                                            <asp:Panel ID="pnReportType" runat="server" Width="80%" 
                                                GroupingText="Report Type" meta:resourcekey="pnReportTypeResource1">
                                                                <asp:DropDownList ID="ddlType" runat="server" CssClass="ddl" meta:resourcekey="ddlTypeResource1">
                                                                </asp:DropDownList>
                                                            </asp:Panel>
                                                        </td>
                                                        <td>
                                            <asp:Panel ID="pnPatientType" Width="100%" GroupingText="Patient Type" 
                                                runat="server" meta:resourcekey="pnPatientTypeResource1">
                                                <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" runat="server"
                                                    >
                                                    <%--<asp:ListItem Text="OP" Selected="True" Value="0" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                    <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                    <asp:ListItem Text="OP-IP" Value="-1" meta:resourcekey="ListItemResource5"></asp:ListItem>--%>
                                                                </asp:RadioButtonList>
                                                            </asp:Panel>
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                                OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                                        </td>
                                                        <td>
                                                            <asp:LinkButton ID="lnkBack" runat="server" Text="Back &nbsp; " CssClass="details_label_age"
                                                                OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            
                                            <div id="divPrint" visible="False" runat="server">
                                                <table class="w-95p">
                                                    <tr>
                                                        <td class="a-right paddingR10">
                                                            <b id="printText" runat="server">
                                                                <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label>
                                                            </b>&nbsp;&nbsp;
                                                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint('prnReport');"
                                                                ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                            
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divSummPrint" visible="False" runat="server">
                                                <table class="w-100p">
                                                    <tr>
                                                        <td class="a-right paddingR10">
                                                            <b id="B1" runat="server">
                                                                <asp:Label ID="Rs_PrintReport1" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReport1Resource1"></asp:Label></b>&nbsp;&nbsp;
                                                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/printer.gif"
                                                                OnClientClick="return popupprint('divSummary');" ToolTip="Print" meta:resourcekey="ImageButton1Resource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divOPDWCR" runat="server" style="display:none">
                                                <div id="prnReport" runat="server">
                                                    <table id="tblItem"class="w-100p">
                                                        <tr>
                                                            <td>
                                                                <asp:Label runat="server" Font-Bold="True" ID="lblHeader" meta:resourcekey="lblHeaderResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="w-100p" align="justify">
                                                                <asp:DataList ID="gvIPReport" runat="server" CellPadding="4" RepeatColumns="4" RepeatDirection="Horizontal"
                                                                    Visible="False" Width="100%" OnItemDataBound="gvIPReport_ItemDataBound" meta:resourcekey="gvIPReportResource1">
                                                                    <HeaderTemplate>
                                                                        <asp:Label runat="server" ID="lblHeader" meta:resourcekey="lblHeaderResource2"></asp:Label>
                                                                    </HeaderTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                                                                    <ItemTemplate>
                                                                        <table cellpadding="0" class="dataheaderInvCtrl w-100p">
                                                                            <tr>
                                                                                <td class="a-center h-25">
                                                                                    <b>
                                                                                        <asp:Label ID="Rs_Date" Text="Date :" runat="server" meta:resourcekey="Rs_DateResource1"></asp:Label></b>
                                                                                    <asp:LinkButton ID="lnkDate" ForeColor="Brown" Font-Bold="True" Font-Size="12px"
                                                                                        Text='<%# Eval("VisitDate", "{0:dd/MM/yyyy}") %>' runat="server" meta:resourcekey="lnkDateResource1"></asp:LinkButton>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="a-left h-15 w-10p">
                                                                                    <asp:GridView ID="gvIPCreditMain" runat="server" AutoGenerateColumns="False"
                                                                                        ForeColor="#333333" CssClass="mytable1 w-100p gridView" OnRowDataBound="gvIPCreditMain_RowDataBound"
                                                                                        meta:resourcekey="gvIPCreditMainResource1">
                                                                                        <Columns>
                                                                                            <asp:TemplateField HeaderText="S.No">
                                                                                                <ItemTemplate>
                                                                                                    <%# Container.DataItemIndex + 1 %>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Department Name" meta:resourcekey="TemplateFieldResource1">
                                                                                                <ItemTemplate>
                                                                                                    <asp:LinkButton ID="lnkDept" Font-Underline="True" ForeColor="Black" Font-Size="12px"
                                                                                                        Text='<%# Eval("DeptName") %>' runat="server" meta:resourcekey="lnkDeptResource1"></asp:LinkButton>
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle Width="50%" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:BoundField DataField="NoOfTests" HeaderText="No of Tests" meta:resourcekey="BoundFieldResource1">
                                                                                                <ItemStyle Width="50%" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField Visible="False" DataField="LengthofStay" HeaderText="No. of Visit"
                                                                                                meta:resourcekey="BoundFieldResource2">
                                                                                                <ItemStyle Width="5px" />
                                                                                            </asp:BoundField>
                                                                                        </Columns>
                                                                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                                        <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                                    </asp:GridView>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <b>
                                                                                        <asp:Label ID="Rs_Testsforthismonth" Text="Tests for this month:" runat="server"
                                                                                            meta:resourcekey="Rs_TestsforthismonthResource1"></asp:Label>
                                                                                        &nbsp;&nbsp;</b><asp:Label runat="server" ForeColor="Red" ID="lblTot" meta:resourcekey="lblTotResource1"></asp:Label><b>&nbsp;<asp:Label
                                                                                            ID="Rs_Nos" Text="Nos." runat="server" meta:resourcekey="Rs_NosResource1"></asp:Label>&nbsp;</b>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </asp:DataList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                            <div id="divSummary" runat="server" visible="False">
                                                <table class="w-100p">
                                                    <tr>
                                                        <td class="a-center">
                                                            <asp:GridView ID="gvIPSummary" runat="server" AutoGenerateColumns="False" 
                                                                ForeColor="#333333" CssClass="mytable1 w-100p" meta:resourcekey="gvIPSummaryResource1">
                                                                <Columns>
                                                                    <asp:BoundField DataField="DeptName" HeaderText="Department Name" meta:resourcekey="BoundFieldResource3">
                                                                        <ItemStyle HorizontalAlign="Left" Width="50%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="TotalCounts" HeaderText="No of Tests" meta:resourcekey="BoundFieldResource4">
                                                                        <ItemStyle Width="50%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField Visible="False" DataField="LengthofStay" HeaderText="No. of Visit"
                                                                        meta:resourcekey="BoundFieldResource5">
                                                                        <ItemStyle Width="5px" />
                                                                    </asp:BoundField>
                                                                </Columns>
                                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label Font-Bold="True" Font-Size="13px" runat="server" ID="totTest" meta:resourcekey="totTestResource1"></asp:Label>
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
        <asp:HiddenField ID="hdnMessages" runat="server" />
 
    </form>
         <script language="javascript" type="text/javascript">
             function ShowAlertMsg(key) {
                 var AlrtWinHdr = SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_winhdr") != null ? SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_winhdr") : "Alert";
                 var UsrMsgDisp = SListForAppMsg.Get("ReportsLims_LabStatisticsReportLims_aspx_01") != null ? SListForAppMsg.Get("ReportsLims_LabStatisticsReportLims_aspx_01") : "No Matching Records found for the selected dates";
                 var userMsg = SListForApplicationMessages.Get(key);
                 if (userMsg != null) {
                     // alert(userMsg);
                     ValidationWindow(userMsg, AlrtWinHdr);

                 }
                 else if (key == "CommonMessages_20") {
                     //alert(' No Matching Records found for the selected dates');
                     ValidationWindow(UsrMsgDisp, AlrtWinHdr);

                 }

                 return false;
             }
             function validateToDate() {
                 var AlrtWinHdr = SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_winhdr") != null ? SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_winhdr") : "Alert";
                 var UsrMsgDisp = SListForAppMsg.Get("ReportsLims_LabStatisticsReportLims_aspx_02") != null ? SListForAppMsg.Get("ReportsLims_LabStatisticsReportLims_aspx_02") : "Provide / select value for From date";
                 var UsrMsgDisp1 = SListForAppMsg.Get("ReportsLims_LabStatisticsReportLims_aspx_03") != null ? SListForAppMsg.Get("ReportsLims_LabStatisticsReportLims_aspx_03") : "Provide / select value for To date";
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
             function popupprint(prnReport) {
                 var prtContent = document.getElementById(prnReport);
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
<script type="text/javascript" src="../Scripts/datetimepicker.js"></script>

                       

                        <script type="text/javascript">

                            function fndate() {


                                $(function() {
                                    $("#txtFDate").datepicker({
                                        changeMonth: true,
                                        changeYear: true,
                                        maxDate: 0,
                                        dateFormat: 'dd/mm/yy',
                                        yearRange: '2008:2030'
                                    });
                                    $("#txtTDate").datepicker({
                                        changeMonth: true,
                                        changeYear: true,
                                        dateFormat: 'dd/mm/yy',
                                        maxDate: 0,
                                        yearRange: '2008:2030'
                                    })
                                });

                            }



                           
                                $(function() {
                                    $("#txtFDate").datepicker({
                                        changeMonth: true,
                                        changeYear: true,
                                        maxDate: 0,
                                        dateFormat: 'dd/mm/yy',
                                        yearRange: '2008:2030'
                                    });
                                    $("#txtTDate").datepicker({
                                        changeMonth: true,
                                        changeYear: true,
                                        dateFormat: 'dd/mm/yy',
                                        maxDate: 0,
                                        yearRange: '2008:2030'
                                    })
                                });
                           

                        </script>
</body>
</html>
