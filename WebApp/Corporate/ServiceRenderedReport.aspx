<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ServiceRenderedReport.aspx.cs" Inherits="Corporate_CorporateSearchReport" meta:resourcekey="PageResource1" %>


<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Patient-Wise Bill-Wise Collection Details</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

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
        
       
    </script>
    <script  runat ="server"  >
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

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="RHead" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: None;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/Show.png" id="showmenu"
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
                            <li class="dataheader">Date Between Collection Details</li>
                        </ul>
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                            <Triggers>
                                <asp:PostBackTrigger ControlID="lnkExportXL" />
                                <asp:PostBackTrigger ControlID="imgBtnXL" />
                            </Triggers>
                            <ContentTemplate>
                                <table id="tblCollectionOPIP" align="center" width="100%">
                                    <tr align="center">
                                        <td align="left">
                                            <div class="dataheaderWider">
                                                <table id="tbl">
                                                    <tr>
                                                        <td align="right">
                                                            <asp:Label ID="Rs_FromDate" Text="From Date:" runat="server" 
                                                                meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txtFDate" runat="server" meta:resourcekey="txtFDateResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                                            <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                                PopupButtonID="ImgFDate" Enabled="True" />
                                                            <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgFDateResource1" />
                                                            <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFDate"
                                                                Mask="99/99/9999" MaskType="Date"
                                                                ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                                CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                            <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                ControlToValidate="txtFDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" 
                                                                meta:resourcekey="MaskedEditValidator5Resource1" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server" 
                                                                meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txtTDate" runat="server" meta:resourcekey="txtTDateResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                                            <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                                                PopupButtonID="ImgTDate" Enabled="True" />
                                                            <asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgTDateResource1" />
                                                            <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTDate"
                                                                Mask="99/99/9999" MaskType="Date"
                                                                ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                                CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                            <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                                ControlToValidate="txtTDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" 
                                                                meta:resourcekey="MaskedEditValidator1Resource1" />
                                                        </td>
                                                        <td align="left">
                                                            <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" 
                                                                runat="server" meta:resourcekey="rblVisitTypeResource1">
                                                                <asp:ListItem Text="OP" Selected="True" Value="0" 
                                                                    meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                        <td>
                                                            <asp:ImageButton ID="imgBtnXL" OnClientClick="if(getElementById('hdnXLFlag').value!='1' || getElementById('gvIPReport')== undefined ) { alert('No Records to Export');return false;} return true;"
                                                                runat="server" ImageUrl="../Images/ExcelImage.GIF" ToolTip="Save As Excel" OnClick="lnkExportXL_Click"
                                                                Style="width: 16px" meta:resourcekey="imgBtnXLResource1" />
                                                            <asp:LinkButton ID="lnkExportXL" Text="Export To XL" Font-Underline="True" OnClientClick="if(getElementById('hdnXLFlag').value!='1' || getElementById('gvIPReport')== undefined ) { alert('No Records to Export');return false;} return true;"
                                                                runat="server" Font-Bold="True" Font-Size="12px" ForeColor="Black"
                                                                ToolTip="Save As Excel" OnClick="lnkExportXL_Click" 
                                                                meta:resourcekey="lnkExportXLResource1"></asp:LinkButton>
                                                            <input type="hidden" runat="server" value="0" id="hdnXLFlag" />
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
                                                    </tr>
                                                    <tr>
                                                        <td colspan="8" align="left">
                                                            <table id="tabCurrency" runat="server">
                                                                <tr id="Tr1" runat="server">
                                                                    <td id="Td1" runat="server">
                                                                        <asp:Label ID="Rs_SelectCurrency" Text="Select Currency"  runat="server"></asp:Label>
                                                                    </td>
                                                                    <td id="Td2" runat="server">
                                                                        <asp:DropDownList ID="ddlCurrency" ToolTip="Select Currency" CssClass="ddlmedium" runat="server" Width="250px">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                                <ProgressTemplate>
                                                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" 
                                                        meta:resourcekey="imgProgressbarResource1" />
                                                    <asp:Label ID ="Rs_Pleasewait" Text="Please wait...." runat="server" 
                                                        meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                            <div id="divPrint" visible="false" runat="server">
                                                <table cellpadding="0" cellspacing="0" border="0" width="95%">
                                                    <tr>
                                                        <td align="right" style="padding-right: 10px; color: #000000;">
                                                            <b id="printText" runat="server"><asp:Label ID="Rs_PrintReport" 
                                                                Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>
                                                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                                ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                            <td>
                                            <div id="divOPDWCR" runat="server" style="display: block;">
                                                <div id="prnReport" style="font-family: Arial; text-decoration: none; font-size: 10px;">
                                                    <asp:GridView ID="gvIPReport" runat="server" AutoGenerateColumns="False" Visible="False"
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
                                                                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" Width="25%" />
                                                                            </asp:BoundField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle Width="43%" />
                                                            </asp:TemplateField>        
                                                            
                                                        <asp:BoundField HeaderText ="Billed Amt." DataField ="BilledAmount" />
                                                        <asp:BoundField HeaderText ="Amount Received" Visible="False" DataField ="AmountReceived" />   
                                                        <asp:BoundField HeaderText ="DueAmount" Visible="False" DataField ="Due" /> 
                                                        <asp:BoundField ItemStyle-HorizontalAlign="Right"  HeaderText ="Cancelled Amt." DataField ="AmountRefund" /> 
                                                        <asp:BoundField HeaderText ="DiscountAmount" Visible="False" DataField ="Discount" />                                                        
                                                        <asp:BoundField HeaderText ="DepositUsed"  DataField ="DepositUsed"  Visible="false"/>
                                                               
                                                           
                                                            <asp:BoundField Visible="False" DataField="PaidCurrencyAmount"
                                                                HeaderText="Paid Currency Amount" meta:resourcekey="BoundFieldResource8" >
                                                                <ItemStyle VerticalAlign="Top" />
                                                            </asp:BoundField>
                                                        </Columns>
                                                        
                                                        <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                        <FooterStyle Font-Bold="True" Height="25px" />
                                                        <HeaderStyle CssClass="dataheader1" Height="25px" />
                                                    </asp:GridView>
                                                 
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
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
