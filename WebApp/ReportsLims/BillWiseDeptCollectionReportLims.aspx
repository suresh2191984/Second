<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillWiseDeptCollectionReportLims.aspx.cs"
    Inherits="ReportsLims_BillWiseDeptCollectionReportLims" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Patient-Wise Bill-Wise Collection Details</title>
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script language="javascript" type="text/javascript">
        function validateToDate() {

            if (document.getElementById('txtFDate').value == '') {
                alert('Provide / select value for From date');
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                alert('Provide / select value for To date');
                document.getElementById('txtTDate').focus();
                return false;
            }
        }
        function popupprint() {
            var prtContent = document.getElementById('prnReport');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }

        function clearContextText() {
            $('#divPrint').hide();

        }
    </script>

    <script runat="server">
        decimal TotalUnitPrice;
        decimal GetAmount(decimal Price)
        {
            if (Price != 0)
            {
                TotalUnitPrice += Price;
            }
            else
            {
                Price = 0;
            }
            return Price;
        }
        decimal GetTotal()
        {
            return TotalUnitPrice;
        }

        //this is for Amount Received 

        decimal totalRecAmt;
        decimal ReceivedAmount(decimal RecAmt)
        {
            if (RecAmt != 0)
            {
                totalRecAmt += RecAmt;
            }
            else
            {
                RecAmt = 0;
            }
            return RecAmt;
        }
        decimal Total()
        {
            return totalRecAmt;
        }

        //This is for Deposit Used 

        decimal totalDepAmt;
        decimal DepositAmount(decimal DepAmt)
        {
            if (DepAmt != 0)
            {
                totalDepAmt += DepAmt;
            }
            else
            {
                DepAmt = 0;
            }
            return DepAmt;
        }
        decimal Total1()
        {
            return totalDepAmt;
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
        <%--  <script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

                        <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>--%>

        <script type="text/javascript">
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
            function SelectedOver(source, eventArgs) {
                $find('AutoCompleteExtender1')._onMethodComplete = function(result, context) {
                    //var Perphysicianname = document.getElementById('txtperphy').value;
                    $find('AutoCompleteExtender1')._update(context, result, /* cacheResults */false);
                    if (result == "") {
                        alert('Please select from the list');
                        document.getElementById('txtClientName').value = '';

                    }
                };
            }
            function SetClientID(source, eventArgs) {
                var ClientID = 0;
                if (eventArgs != undefined) {
                    ClientID = eventArgs.get_value();
                    document.getElementById('<%=hdnClientID.ClientID %>').value = ClientID.split('|')[0];
                }
                else {
                    document.getElementById('<%=hdnClientID.ClientID %>').value = ClientID;
                }
            }
        </script>

        <asp:UpdatePanel ID="updatePanel1" runat="server">
            <Triggers>
                <asp:PostBackTrigger ControlID="lnkExportXL" />
                <asp:PostBackTrigger ControlID="imgBtnXL" />
            </Triggers>
            <ContentTemplate>
                <table id="tblCollectionOPIP" class="w-100p a-center">
                    <tr align="center">
                        <td align="left">
                            <div class="dataheaderWider">
                                <table id="tbl" class="w-100p">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization" 
                                                meta:resourcekey="lblOrgsResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlTrustedOrg" onchange="javascript:clearContextText();" runat="server"
                                                CssClass="ddl" meta:resourcekey="ddlTrustedOrgResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblLocation" runat="server" Text="Location :" 
                                                meta:resourcekey="lblLocationResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlLocation" Width="180px" runat="server" CssClass="ddl" 
                                                meta:resourcekey="ddlLocationResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="Rs_FromDate" Text="From Date" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                        </td>
                                        <td class="a-left">
                                            <asp:TextBox ID="txtFDate" runat="server" CssClass="Txtboxsmall" Width="70px" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="Rs_ToDate" Text="To Date" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                        </td>
                                        <td class="a-left">
                                            <asp:TextBox ID="txtTDate" runat="server" CssClass="Txtboxsmall" Width="70px" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                        </td>
                                        <td class="a-left">
                                           <asp:Panel ID="pnlVisitType" Width="100%" GroupingText="Visit Type" runat="server" meta:resourcekey="pnlVisitTypeResource1">
                                                <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" runat="server"
                                                    meta:resourcekey="rblVisitTypeResource1">
                                                    <asp:ListItem Text="OP" Selected="True" Value="0" 
                                                        meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                    <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                    <asp:ListItem Text="OP&IP" Value="-1" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td id="Td1" runat="server">
                                            <asp:Label ID="Rs_SelectCurrency" Text="Select Currency" runat="server" 
                                                meta:resourcekey="Rs_SelectCurrencyResource1"></asp:Label>
                                        </td>
                                        <td id="Td2" runat="server">
                                            <asp:DropDownList ID="ddlCurrency" ToolTip="Select Currency" runat="server" 
                                                Width="150px" meta:resourcekey="ddlCurrencyResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td class="w-10p">
                                            <asp:Label ID="lblClientname" runat="server" Text="Client Name" 
                                                meta:resourcekey="lblClientnameResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtClientName" runat="server" autocomplete="off" Width="130px" CssClass="AutoCompletesearchBox"
                                                TabIndex="3" onblur="javascript:return CearetxtDate();" 
                                                meta:resourcekey="txtClientNameResource1"></asp:TextBox>
                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientName"
                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetClientList"
                                                OnClientItemSelected="SetClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                OnClientItemOver="SelectedOver" Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                        <td align="left">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                        </td>
                                        <td align="left">
                                            <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server" CssClass="details_label_age"
                                                OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                        </td>
                                        <td colspan="2">
                                            <asp:ImageButton ID="imgBtnXL" OnClientClick="if(getElementById('hdnXLFlag').value!='1' || getElementById('grdResult')== undefined ) { alert('No Records to Export');return false;} return true;"
                                                runat="server" ImageUrl="../Images/ExcelImage.GIF" ToolTip="Save As Excel" Style="width: 16px"
                                                meta:resourcekey="imgBtnXLResource1" />
                                            <asp:LinkButton ID="lnkExportXL" Text="Export To XL" Font-Underline="True" OnClientClick="if(getElementById('hdnXLFlag').value!='1' || getElementById('grdResult')== undefined ) { alert('No Records to Export');return false;} return true;"
                                                runat="server" Font-Bold="True" Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel"
                                                meta:resourcekey="lnkExportXLResource1" OnClick="lnkExportXL_Click"></asp:LinkButton>
                                            <input type="hidden" runat="server" value="0" id="hdnXLFlag" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="updatePanel1" runat="server">
                                <ProgressTemplate>
                                    <div id="progressBackgroundFilter">
                                    </div>
                                    <div align="center" id="processMessage">
                                        Please wait...<br />
                                        <br />
                                        <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" 
                                            meta:resourcekey="imgProgressbarResource1" />
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                            <div id="divPrint" visible="false" runat="server">
                                <table cellpadding="0" cellspacing="0" border="0" width="95%">
                                    <tr>
                                        <td align="right" style="padding-right: 10px; color: #000000;">
                                            <b id="printText" runat="server">
                                                <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>
                                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table cellpadding="0" class="defaultfontcolor" width="100%" style="color: Black;
                                font-family: Verdana; text-align: left;" cellspacing="1" width="100%">
                                <tr>
                                    <td>
                                        <div id="divOPDWCR" runat="server" style="display: block;">
                                            <div id="prnReport" style="font-family: Arial; text-decoration: none; font-size: 10px;">
                                                <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" 
                                                    Width="100%" CellPadding="1" CssClass="mytable1" EmptyDataText="Collection Details Not Available"
                                                    Font-Names="verdana" OnRowDataBound="grdResult_RowDataBound" 
                                                    meta:resourcekey="grdResultResource1">
                                                    <HeaderStyle CssClass="dataheader1" />
                                                    <RowStyle HorizontalAlign="Left" Font-Size="10px" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                                            <ItemTemplate>
                                                                <%# Container.DataItemIndex + 1 %>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="BillNumber" HeaderText="Bill Number" 
                                                            meta:resourcekey="BoundFieldResource1" />
                                                        <asp:BoundField DataField="VisitNumber" HeaderText="Visit Number" 
                                                            meta:resourcekey="BoundFieldResource2" />
                                                        <asp:BoundField DataField="PatientName" HeaderText="Name" 
                                                            meta:resourcekey="BoundFieldResource3" />
                                                        <asp:BoundField DataField="Age" HeaderText="Age/Sex" 
                                                            meta:resourcekey="BoundFieldResource4" />
                                                        <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd/MM/yyyy}" 
                                                            HeaderText="Visit Date" meta:resourcekey="BoundFieldResource5" />
                                                        <asp:TemplateField HeaderText="Description" 
                                                            meta:resourcekey="TemplateFieldResource2">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblBilledFor" Text='<%# Eval("Description") %>' runat="server" 
                                                                    meta:resourcekey="lblBilledForResource1"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="BillAmount" DataFormatString="{0:0.00}" ItemStyle-HorizontalAlign="Right"
                                                            HeaderText="Billed Amt" meta:resourcekey="BoundFieldResource6" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="AmountReceived" DataFormatString="{0:0.00}" ItemStyle-HorizontalAlign="Right"
                                                            HeaderText="Received Amt" meta:resourcekey="BoundFieldResource7" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Due" DataFormatString="{0:0.00}" ItemStyle-HorizontalAlign="Right"
                                                            HeaderText="Due" meta:resourcekey="BoundFieldResource8" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="AmountRefund" DataFormatString="{0:0.00}" ItemStyle-HorizontalAlign="Right"
                                                            HeaderText="Cancel Amt" meta:resourcekey="BoundFieldResource9" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Discount" DataFormatString="{0:0.00}" ItemStyle-HorizontalAlign="Right"
                                                            HeaderText="Discount Amt" meta:resourcekey="BoundFieldResource10" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="DepositUsed" DataFormatString="{0:0.00}" ItemStyle-HorizontalAlign="Right"
                                                            HeaderText="Deposit Used" meta:resourcekey="BoundFieldResource11" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="CreditorDebitCard" HeaderText="Mode Of Payment" 
                                                           />
                                                        <asp:BoundField DataField="Location" HeaderText="Location" 
                                                            meta:resourcekey="BoundFieldResource12" />
                                                        <asp:BoundField DataField="ClientName" HeaderText="Client Name" 
                                                            meta:resourcekey="BoundFieldResource13" />
                                                        <asp:BoundField DataField="RefphysicianName" HeaderText="Refphysician Name" 
                                                            meta:resourcekey="BoundFieldResource14" />
                                                    </Columns>
                                                </asp:GridView>
                                                <%--<asp:GridView ID="gvIPReport" runat="server" AutoGenerateColumns="False" Visible="False"
                                                        Width="100%"   AllowPaging="True" OnPreRender="gridView_PreRender"
                                                        PageSize="20" OnPageIndexChanging="gvIPReport_PageIndexChanging" CellPadding="1"
                                                        EmptyDataText="Collection Details Not Available" OnRowDataBound="gvIPReport_RowDataBound"
                                                        Font-Names="verdana" 
                                                        meta:resourcekey="gvIPReportResource1">
                                                        <Columns>
                                                            <asp:BoundField HeaderText="Bill Number" DataField="BillNumber" 
                                                                meta:resourcekey="BoundFieldResource1" >
                                                                <ItemStyle VerticalAlign="Top" />
                                                            </asp:BoundField>
                                                            <asp:BoundField HeaderText="Patient Name" DataField="PatientName" 
                                                                meta:resourcekey="BoundFieldResource2" >
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                                                            </asp:BoundField>
                                                            <asp:BoundField HeaderText="Age" DataField="Age" 
                                                                meta:resourcekey="BoundFieldResource3" >
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" Width="5%" />
                                                            </asp:BoundField>
                                                              <asp:BoundField HeaderText="Visit Date" DataField="VisitDate"
                                                                DataFormatString="{0:dd/MMM/yy hh:mm tt}" 
                                                                meta:resourcekey="BoundFieldResource6" >
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle VerticalAlign="Top" Width="12%" />
                                                            </asp:BoundField>
                                                            <asp:TemplateField HeaderText="Description" 
                                                                meta:resourcekey="TemplateFieldResource2">
                                                                <ItemTemplate>
                                                                    <asp:GridView ID="gvDescription" Width="100%" GridLines="None" ShowHeader="False"
                                                                        AutoGenerateColumns="False" runat="server"  OnPreRender="childGrid_PreRender"  
                                                                        meta:resourcekey="gvDescriptionResource1">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Billed For" 
                                                                                meta:resourcekey="TemplateFieldResource1" >
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblBilledFor" Text='<%# Eval("ConsultantName") %>' 
                                                                                        runat="server" meta:resourcekey="lblBilledForResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField HeaderText="BilledAmt" DataField="ItemAmount" 
                                                                                meta:resourcekey="BoundFieldResource4" >
                                                                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" Width="20%" />
                                                                            </asp:BoundField>
                                                                           
                                                                            <asp:BoundField HeaderText="Fee Type" DataField="FeeType" HeaderStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle"
                                                                            meta:resourcekey="BoundFieldResource7">
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" Width="20%" />
                                                                            </asp:BoundField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle Width="43%" />
                                                            </asp:TemplateField>        
                                                            
                                                        <asp:BoundField HeaderText ="Total(BilledAMT)" DataField ="BilledAmount" />
                                                        <asp:BoundField HeaderText ="Amount Received" DataField ="AmountReceived" />   
                                                        <asp:BoundField HeaderText ="DueAmount" DataField ="Due" /> 
                                                        <asp:BoundField ItemStyle-HorizontalAlign="Right" HeaderText ="RefundAmt" DataField ="AmountRefund" /> 
                                                        <asp:BoundField HeaderText ="DiscountAmount" DataField ="Discount" />                                                        
                                                        <asp:BoundField HeaderText ="DepositUsed" DataField ="DepositUsed"  Visible="false"/>
                                                               
                                                           
                                                            <asp:BoundField Visible="False" DataField="PaidCurrencyAmount"
                                                                HeaderText="Paid Currency Amount" meta:resourcekey="BoundFieldResource8" >
                                                                <ItemStyle VerticalAlign="Top" />
                                                            </asp:BoundField>
                                                        </Columns>
                                                        <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                        <FooterStyle Font-Bold="True" Height="25px" />
                                                        <HeaderStyle CssClass="dataheader1" Height="25px" />
                                                    </asp:GridView>--%>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>
