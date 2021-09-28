<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DiscountReportLims.aspx.cs" Inherits="ReportsLims_DiscountReportLims"
    meta:resourcekey="PageResource1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>
        <%=Resources.ReportsLims_AppMsg.ReportsLims_DiscountReportLims_aspx_hdr %>
    </title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />

    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script language="javascript" type="text/javascript">
        function ChkSelectType() {
            // var selectedvalue;
            //            if (document.getElementById('rblReportType').checked) {
            //                var radbtnList = document.getElementById('rblReportType');
            //                selectedvalue = radbtnList.value;
            //                document.getElementById('AuthoUser').style.display = 'none';
            var RB1 = document.getElementsByName("rblReportType");
            var Grid = document.getElementById('gvIPCreditMain');
            if (RB1[1].checked == true) {
                document.getElementById('AuthoUser').style.display = 'none';
                for (i = 1; i <= Grid.rows.length; i++) {
                    document.getElementById('gvIPCreditMain').style.display = 'none';
                }
                document.getElementById('breakup').style.display = 'none';
                document.getElementById("UserwiseDropDown").selectedIndex = 0;
                document.getElementById("AuthoDropDown").selectedIndex = 0;
            }
            if (RB1[2].checked == true) {
                document.getElementById('AuthoUser').style.display = 'table-row';
                document.getElementById('divSum').style.display = 'none';
                document.getElementById('breakup').style.display = 'none';
                document.getElementById("UserwiseDropDown").selectedIndex = 0;
                document.getElementById("AuthoDropDown").selectedIndex = 0;
            }
        }
        function validateToDate() {
            var AlrtWinHdr = SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_winhdr") != null ? SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_winhdr") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_01") != null ? SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_01") : "Provide / select value for From date";
            var UsrAlrtMsg1 = SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_02") != null ? SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_02") : "Provide / select value for To date";
            if (document.getElementById('txtFDate').value == '') {
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                //alert('Provide / select value for From date');
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                //alert('Provide / select value for To date');
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
                       
                        <script type="text/javascript">
                          /*  $(function() {
                                $("#txtFDate").datepicker({
                                    changeMonth: true,
                                    changeYear: true,
                                    maxDate: 0,
                                    yearRange: '2008:2030'
                                });
                                $("#txtTDate").datepicker({
                                    changeMonth: true,
                                    changeYear: true,
                                    maxDate: 0,
                                    yearRange: '2008:2030'
                                })
                            });*/
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
                            function clearContextText() {
                                $('#contentArea').hide();

                            }
                        </script>

                        <table id="tblCollectionOPIP" class="dataheader2 defaultfontcolor a-center w-100p">
                            <tr>
                                <td class="a-left">
                                    <div class="dataheaderWider">
                                        <table id="tbl" class="w-100p">
                                            <tr>
                                                <td>
                                    <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization" meta:resourcekey="lblOrgsResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlTrustedOrg" onchange="javascript:clearContextText();" runat="server"
                                                        CssClass="ddl">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Rs_Location" runat="server" Text="Location" meta:resourcekey="Rs_LocationResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList  CssClass="ddlsmall" runat="server" ID="ddlLocation" style="width:180px;"                                                       
                                                        meta:resourcekey="ddLOResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Rs_FromDate" Text="From Date:" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                    <asp:TextBox ID="txtFDate" CssClass="Txtboxsmall" Width="70px" runat="server" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                    <%-- <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                        PopupButtonID="ImgFDate" Enabled="True" />
                                                    <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" meta:resourcekey="ImgFDateResource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFDate"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                        CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                        ControlToValidate="txtFDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />--%>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                    <asp:TextBox ID="txtTDate" CssClass="Txtboxsmall" Width="70px" runat="server" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                    <%-- <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                                        PopupButtonID="ImgTDate" Enabled="True" />
                                                    <asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" meta:resourcekey="ImgTDateResource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTDate"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                        CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                        ControlToValidate="txtTDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />--%>
                                                </td>
                                               <%-- <td>
                                                    <asp:Panel ID="pnlVisitType" Width="100%" GroupingText="Visit Type" runat="server">
                                                        <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" runat="server"
                                                            meta:resourcekey="rblVisitTypeResource1">
                                                            <asp:ListItem Text="OP" Selected="True" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                            <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                            <asp:ListItem Text="OP&IP" Value="-1" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </asp:Panel>
                                                </td>--%>
                                                <td>
                                    <asp:Panel ID="pnReportType" CssClass="w-100p" GroupingText="Report Type" runat="server"
                                        meta:resourcekey="pnReportTypeResource1">
                                                        <asp:RadioButtonList ID="rblReportType" ValidationGroup="vgr" RepeatDirection="Horizontal" runat="server"
                                                            meta:resourcekey="rblReportTypeResource1" onclick="javascript:ChkSelectType();">
                                           <%-- <asp:ListItem Text="Summary" Selected="True" Value="0" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                            <asp:ListItem Text="Detail" Value="1" meta:resourcekey="ListItemResource5"></asp:ListItem>--%>
                                                        </asp:RadioButtonList>
                                                    </asp:Panel>
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                        OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server" CssClass="details_label_age"
                                                        OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                </td>
                                            </tr>
                                            <tr id="AuthoUser" runat="server">
                                           
                                                <td>
                                                    <asp:Label ID="Authorized" runat="server" Text="Authorized By" meta:resourcekey="Rs_LocationResource11"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList  CssClass="ddlsmall" runat="server" ID="AuthoDropDown"                                                       
                                                        meta:resourcekey="ddABResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                <asp:Label ID="Userwise" runat="server" Text="Userwise" meta:resourcekey="Rs_LocationResource10"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList  CssClass="ddlsmall" runat="server" ID="UserwiseDropDown"  STYLE="width:180px;"                                                     
                                                        meta:resourcekey="ddUWResource1">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
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
                                    <div id="contentArea">
                                        <div id="divPrint" style="display: none;" runat="server">
                                            <table class="w-100p">
                                                <tr>
                                                    <td class="a-right paddingR10" style="color: #000000;">
                                                        <b id="printText" runat="server">
                                                            <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label>
                                                        </b>
                                                         <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                            ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                        <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                            ToolTip="Save As Excel" Style="width: 16px" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                                        &nbsp;
                                                       
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                                            <ContentTemplate>
                                                <div id="divOPDWCR" runat="server" style="display: none;">
                                                    <div id="prnReport">
                                                        
                                                                        <table class="w-100p">                                                                           
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:GridView ID="gvIPCreditMain" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                                        ForeColor="#333333" CssClass="mytable1 gridView" OnRowDataBound="gvIPCreditMain_RowDataBound"
                                                                                        meta:resourcekey="gvIPCreditMainResource1">
                                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                                        <RowStyle HorizontalAlign="Left" />
                                                                                        <Columns>
                                                            <asp:BoundField DataField="VisitDate" DataFormatString="{0:d}" HeaderText="Visited Date"
                                                                meta:resourcekey="BoundFieldResource1">
                                                                                                <ItemStyle Width="35px" />
                                                                                            </asp:BoundField>
                                                                                           <%-- <asp:BoundField DataField="PatientNumber" HeaderText="Patient No" meta:resourcekey="BoundFieldResource2">
                                                                                                <ItemStyle Width="25px" />
                                                                                            </asp:BoundField>--%>
                                                                                            <asp:BoundField DataField="PatientName"  HeaderText="Name" meta:resourcekey="BoundFieldResource2">
                                                                                                <ItemStyle HorizontalAlign="Left"   Wrap="False" Width="40px"></ItemStyle>
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="VisitNumber" HeaderText="Visit Number" meta:resourcekey="BoundFieldResource3">
                                                                                                <ItemStyle Width="25px" HorizontalAlign="Center" />
                                                                                            </asp:BoundField>
                                                                                           
                                                                                            <%--<asp:BoundField DataField="Address" HeaderText="Reason for Discount" meta:resourcekey="BoundFieldResource4">
                                                                                                <ItemStyle HorizontalAlign="Left" Wrap="True" Width="150px"></ItemStyle>
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="Age" HeaderText="Age" meta:resourcekey="BoundFieldResource5">
                                                                                                <ItemStyle HorizontalAlign="Left" Wrap="False" Width="90px"></ItemStyle>
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="BillNumber" HeaderText="Bill No" meta:resourcekey="BoundFieldResource6">
                                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="VisitType" HeaderText="Visit" meta:resourcekey="BoundFieldResource7">
                                                                                                <ItemStyle Width="25px" />
                                                                                            </asp:BoundField>--%>
                                                                                              <asp:BoundField DataField="TotalAmount" HeaderText="Gross Amount">
                                                                                                <ItemStyle Width="25px"  HorizontalAlign="Center"/>
											    </asp:BoundField>
                                                                                            <asp:BoundField DataField="NetValue" HeaderText="Net Amount">
                                                                                                <ItemStyle Width="25px"  HorizontalAlign="Center"/>
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="Discount" HeaderText="Discount Amount" meta:resourcekey="BoundFieldResource6">
                                                                                                <ItemStyle HorizontalAlign="Right" Width="30px" />
                                                                                            </asp:BoundField>
                                                                                             <asp:BoundField DataField="Userwise" HeaderText="Userwise" meta:resourcekey="BoundFieldResource7">
                                                                                                <ItemStyle HorizontalAlign="Right" Width="30px" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="DiscountReason" HeaderText="Reason for Discount" meta:resourcekey="AddressResource4">
                                                                                                <ItemStyle HorizontalAlign="Left" Wrap="True" Width="150px"></ItemStyle>
                                                                                            </asp:BoundField>
                                                                                             <asp:BoundField DataField="UserName" HeaderText="Authorized By" meta:resourcekey="BoundFieldResource4">
                                                                                                <ItemStyle Width="40px" HorizontalAlign="Left"  />
                                                                                            </asp:BoundField>
											    <asp:BoundField DataField="ReferredBy" HeaderText="Referring PhysicianName">
                                                                                                <ItemStyle Width="40px" HorizontalAlign="Left"  />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="Category" HeaderText="History">
                                                                                                <ItemStyle Width="40px" HorizontalAlign="Left"  />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="WardName" HeaderText="Remarks">
                                                                                                <ItemStyle Width="40px" HorizontalAlign="Left"  />
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
                                                                                <td class="a-right">
                                                                                    <b>
                                                        <asp:Label ID="lblDiscountAmount" runat="server" Font-Bold="True" ForeColor="Red"
                                                            meta:resourcekey="lblDiscountAmountResource1"></asp:Label></b>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    
                                                        <br />
                                                        
                                                    </div>
                                                </div>
                                                 <div id="divSum" runat="server" style="display: none;">
                                                    <div id="Div2">
                                                        
                                                                        <table class="w-100p">                                                                           
                                                                            <tr>
                                                                            <td class="w-20p"></td>
                                                                                <td class="a-center" >
                                                                                    <asp:GridView ID="GvSum" runat="server" AutoGenerateColumns="False" Width="60%"
                                                                                        ForeColor="#333333" CssClass="mytable1 gridView" 
                                                                                        meta:resourcekey="gvIPCreditMainResource1">
                                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                                        <RowStyle HorizontalAlign="Center" />
                                                                                        <Columns>
                                                                                        <asp:BoundField DataField="PatientCount" HeaderText="Patient Count" meta:resourcekey="BoundFieldResource9">
                                                                                                <ItemStyle Width="20%" HorizontalAlign="Center"/>
                                                                                            </asp:BoundField>
                                                                                         <asp:BoundField DataField="VisitDate" DataFormatString="{0:d}" HeaderText="VisitedDate" meta:resourcekey="BoundFieldResource1">
                                                                                                <ItemStyle Width="20%" HorizontalAlign="Center"/>
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="Discount" HeaderText="Discount Amount" meta:resourcekey="BoundFieldResource8">
                                                                                                <ItemStyle Width="20%" HorizontalAlign="Right"/>
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
                                                                                <td class="a-right" colspan="2">
                                                                                    <b>
                                                                                        <asp:Label ID="Label2" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label></b>
                                                                                </td>
                                                                                <td class="w-20p"></td>
                                                                            </tr>
                                                                        </table>
                                                                    
                                                        <br />
                                                      
                                                    </div>
                                                </div>
                                                <div id="breakup">
                                                            <table border="0" id="tabGranTotal1" runat="server" visible="False" class="dataheaderWider"
                                                                cellpadding="5" style="color: #000000;" cellspacing="0" width="100%">
                                                                <tr id="Tr2" runat="server">
                                                                    <td id="Td3" class="a-right w-80p" runat="server">
                                                <asp:Label ID="Rs_TotalDiscountAmount" Text="Total Discount Amount" runat="server"
                                                    meta:resourcekey="Rs_TotalDiscountAmountResource1"></asp:Label>
                                                                        <label id="Label1" style="color: Green;" runat="server">
                                                                            (A)</label>
                                                                        :
                                                                    </td>
                                                                    <td id="Td4" class="a-right" runat="server">
                                                                        <label id="lblDiscountTotal" runat="server" >
                                                                        
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
         <Attune:Attunefooter ID="Attunefooter" runat="server" />      
    </form>
</body>
</html>
