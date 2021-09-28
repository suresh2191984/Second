<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OutsourceWorksheet.aspx.cs"
    Inherits="Invoice_OutsourceWorksheet" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>OutSource Worksheet</title>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <style type="text/css">
        .ui-datepicker
        {
            font-size: 8pt !important;
        }
        .wraptext
        {
            width: 200px;
            word-break: break-all;
        }
        #tblPrint td, #tblPrint td span
        {
            font-size: 12px !important;
            line-height: 17px;
        }
        .m-auto
        {
            margin: 0 auto;
        }
        .paddingL255
        {
            padding-left: 255px;
        }
        .paddingR20
        {
            padding-right: 20px;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function CheckSearch() {

            if (document.getElementById('txtFDate').value == '') {
                alert('Select From Date');
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                alert('Select To Date');
                document.getElementById('txtTDate').focus();
                return false;
            }

        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="updatePanel1" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter">
                        </div>
                        <div align="center" id="processMessage" width="60%">
                            <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" />
                            <br />
                            <br />
                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
               
                            <div>
                                <table id="tbl" border="0" align="Center" cellpadding="0" cellspacing="0" class="searchPanel w-100p">
                                    <tr id="trTrustedOrg" runat="server" style="display: table-row;">
                                        <td>
                                            <asp:Label ID="Rs_FromDate" Text="From Date " runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox Width="125px" ID="txtFDate" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                            <a href="javascript:NewCssCall('<% =txtFDate.ClientID %>','ddmmyyyy','arrow',false,12,'Y','N','Y')">
                                                <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                        </td>
                                        <td>
                                            <asp:Label ID="Rs_ToDate" Text="To Date " runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtTDate" Width="125px" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                            <a href="javascript:NewCssCall('<% =txtTDate.ClientID %>','ddmmyyyy','arrow',false,12,'Y','N','Y')">
                                                <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblOrgs" runat="server" Text="Outsource Location"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlOrganisation" runat="server" CssClass="ddl" Width="155px">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnSearch" runat="server" CssClass="btn" Text="Search" OnClick="btnSearch_Click"
                                                OnClientClick="return CheckSearch();" />
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <asp:Label ID="lblResult" runat="server" ForeColor="#333" Style="display: none;">No Matching Records Found!</asp:Label>
                                <%--<asp:UpdateProgress ID="Progressbar" runat="server">
                                        <ProgressTemplate>
                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                                            <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server"></asp:Label>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>--%>
                                <%--<div id="divPrint" style="display: none;" runat="server">--%>
                                <table id="tabPrintButton" class="w-100p a-center" style="display: none;" runat="server">
                                    <tr class="a-right">
                                        <td class="a-right paddingR20" style="color: #000000;">
                                            <b id="printText" runat="server">
                                                <asp:ImageButton ID="imgpdf" ImageUrl="../Images/pdf.ico" runat="server" Style="cursor: pointer;"
                                                    Height="25px" Width="25px" OnClick="imgpdf_Click" />
                                                <%--<img src="../Images/printer.gif" style="cursor: pointer;" id="imgPrint" runat="server" OnClientClick="return popupprint();" />--%>
                                                <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                    ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                <asp:LinkButton ID="lnkPrint" Text="Print" Font-Underline="True" OnClientClick="return popupprint(); return false"
                                                    runat="server" Font-Bold="True" Font-Size="12px" ForeColor="Black" meta:resourcekey="lnkExportXLResource2"></asp:LinkButton></b>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="prnReport" runat="server" style="font-size: 8pt; text-align: left; color: black;
                                font-family: calibri; width: 100%;">
                                <table id="tblPrint" class="marginB10 w-100p" runat="server" style="display: none;
                                    margin: 0 auto;">
                                    <tr>
                                        <td>
                                            <table width="100%" class="a-left paddingL255">
                                                <tr class="h-35">
                                                    <td colspan="1">
                                                        <asp:Label ID="lblto" runat="server" Text="To:" CssClass="large bold"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="1">
                                                        <asp:Label ID="lblClientAddress" runat="server" CssClass="large"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                            <table width="100%" class="a-left paddingL255">
                                                <tr>
                                                    <td colspan="1">
                                                        Total Samples :
                                                    </td>
                                                    <td colspan="1">
                                                        <asp:Label ID="lbltotsample" runat="server" CssClass="large bold"></asp:Label>
                                                    </td>
                                                    <td colspan="1">
                                                        Total Patients :
                                                    </td>
                                                    <td colspan="1">
                                                        <asp:Label ID="lbltotpattients" runat="server" CssClass="large bold"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="1">
                                                        Total Amount :
                                                    </td>
                                                    <td colspan="1">
                                                        <asp:Label ID="lbltotamount" runat="server" CssClass="large bold"></asp:Label>
                                                    </td>
                                                    <td colspan="1">
                                                        Consignment Handling Charges :
                                                    </td>
                                                    <td colspan="1">
                                                        <asp:Label ID="lblcharges" runat="server" CssClass="large bold"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="1">
                                                        Amount Payable :
                                                    </td>
                                                    <td colspan="1">
                                                        <asp:Label ID="lblamtpayable" runat="server" CssClass="large bold"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <table class="w-100p marginT10 v-top">
                                    <tr>
                                        <td align="center">
                                            <asp:Panel ID="pnlgrid" runat="server" class="ContentPanel">
                                                <div style="display: block" runat="server">
                                                    <asp:GridView ID="grdInvoice" runat="server" AlternatingRowStyle-CssClass="trEven"
                                                        AutoGenerateColumns="False" GridLines="Both" ForeColor="#333333" CssClass="gridView w-100p"
                                                        OnRowDataBound="grdInvoice_RowDataBound">
                                                        <HeaderStyle Font-Bold="True" CssClass="dataheader1" />
                                                        <RowStyle HorizontalAlign="Left" />
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="S.No" ItemStyle-Width="2%">
                                                                <ItemStyle />
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <%--<asp:BoundField DataField="ExternalVisitID" HeaderText="Lab No" meta:resourcekey="BoundFieldResource2">
                                                                            <ItemStyle HorizontalAlign="Left" Wrap="true" Width="100px"></ItemStyle>
                                                                        </asp:BoundField>--%>
                                                            <asp:BoundField DataField="PatientName" HeaderText="PatientName">
                                                                <ItemStyle HorizontalAlign="Left" Wrap="true"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="InvestigationName" HeaderText="TestName">
                                                                <ItemStyle HorizontalAlign="Left" Wrap="true" />
                                                            </asp:BoundField>
                                                            <asp:TemplateField HeaderText="BarcodeNumber" HeaderStyle-Width="12%">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="BarcodeNumber" runat="server" Text='<%# Bind("BarcodeNumber") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="Rate" HeaderText="Rate">
                                                                <ItemStyle HorizontalAlign="left" Wrap="true"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="VisitNumber" HeaderText="Visit Number" HeaderStyle-Width="10%">
                                                                <ItemStyle HorizontalAlign="Left" Wrap="true" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="SampleDesc" HeaderText="Sample" HeaderStyle-Width="12%">
                                                                <ItemStyle HorizontalAlign="left" Wrap="true"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:TemplateField HeaderText="Vacutainer/Additive" HeaderStyle-Width="12%">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="SampleContainerName" runat="server" Text='<%# Bind("SampleContainerName") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <%--<asp:BoundField DataField="SampleContainerName" HeaderText="Vacutainer/Additive"
                                                        meta:resourcekey="BoundFieldResource2">
                                                        <ItemStyle HorizontalAlign="left" Wrap="true"></ItemStyle>
                                                    </asp:BoundField>--%>
                                                            <asp:BoundField DataField="OutsourcedDate" HeaderText="OutSourcingDate" HeaderStyle-Width="10%">
                                                                <ItemStyle HorizontalAlign="left" Wrap="true"></ItemStyle>
                                                            </asp:BoundField>
                                                        </Columns>
                                                        <EmptyDataRowStyle CssClass="dataheader1"></EmptyDataRowStyle>
                                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                    </asp:GridView>
                                                </div>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        
            </ContentTemplate>
               <Triggers>
                                <asp:PostBackTrigger ControlID="imgpdf" />
                                
                            </Triggers>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>

<script language="javascript" type="text/javascript">

    function popupprint() {

        var prtContent = document.getElementById('prnReport');
        var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0,height: 99999px;');
        //alert(WinPrint);
        WinPrint.document.write(prtContent.innerHTML);
        WinPrint.document.close();
        WinPrint.focus();
        WinPrint.print();
        document.body.innerHTML = originalContents;
        //WinPrint.close();
        return false;
    }




    //        var prtContent = document.getElementById('prnReport');
    //        var WinPrint =
    //                        window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
    //        WinPrint.document.write(
    //           '<html>' +
    //             '<head>' +
    //                    '<link href="../Themes_New/IB/style.css" rel="stylesheet" type="text/css" media="print" />' +
    //                    '<link href="../Themes_New/IB/style.css" rel="stylesheet" type="text/css" media="screen" />' +
    //             '</head>' +
    //             '<body>' + prtContent.innerHTML + '</body>' +
    //           '</html>'
    //            );
    //        WinPrint.document.close();
    //        WinPrint.focus();
    //        WinPrint.print();
    //        // WinPrint.close();
    //        return false;
     
</script>

</html>
