<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CenterAndSpecialitywiseReport.aspx.cs"
    Inherits="Reports_CenterAndSpecialitywiseReport" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <style type="text/css">
        .style3
        {
            width: 131px;
        }
        .style4
        {
            width: 63px;
        }
    </style>

    <script language="javascript" type="text/javascript">
    
 function ShowAlertMsg(key) {
       var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
                return false ;
            }
            else
            {
            alert('Please Click the check box');
            return false ;
            }
         
           return true;
        }

        //           function CheckRow() {
        //                
        //            var flag = 0;
        //            var cboxObj = document.getElementById('ddlDoctorName');
        //            var cboxList = cboxObj.getElementsByTagName('input');
        //            for (var i = 0; i < cboxList.length; i++) {
        //                if (cboxList[0].checked) {
        //                    flag = 1;
        //                    cboxList[i].checked = true;
        //                    

        //                }

        //            }

        //        }
        function popupprint() {
            var prtContent = document.getElementById('grdResult');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            return false;
        }
        function checkAll(obj1) {
            var checkboxCollection = document.getElementById('ddlDoctorName').getElementsByTagName('input');

            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    checkboxCollection[i].checked = obj1.checked;
                }
            }
        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <div id="wrapper">
                <div id="header">
                    <div class="logoleft" style="z-index: 2;">
                        <div class="logowrapper">
                            <img alt="" src="" class="logostyle" />
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
                        <td width="15%" valign="top" id="menu" style="display: none;">
                            <div id="navigation">
                                <uc1:LeftMenu ID="LeftMenu1" runat="server" />
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
                            <div class="contentdata1">
                                <ul>
                                    <li>
                                        <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                    </li>
                                </ul>
                                <table id="tblCollectionOPIP" align="center" width="100%">
                                    <tr align="center">
                                        <td align="center">
                                            <div class="dataheaderWider">
                                                <table id="tbl">
                                                    <tr>
                                                        <td align="right">
                                                            <asp:Label ID="Label1" runat="server" Text=" From Date :" Width="100px" meta:resourcekey="Label1Resource1"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txtFDate" runat="server"  meta:resourcekey="txtFDateResource1" CssClass ="Txtboxsmall" ></asp:TextBox>
                                                            <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                                PopupButtonID="ImgFDate" Enabled="True" />
                                                            <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgFDateResource1" />
                                                            <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFDate"
                                                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                Enabled="True" />
                                                            <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                ControlToValidate="txtFDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txtTDate" runat="server" meta:resourcekey="txtTDateResource1" CssClass="Txtboxsmall" ></asp:TextBox>
                                                            <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                                                PopupButtonID="ImgTDate" Enabled="True" />
                                                            <asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgTDateResource1" />
                                                            <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTDate"
                                                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                Enabled="True" />
                                                            <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                                ControlToValidate="txtTDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="Button1" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClick="btnSubmit_Click" meta:resourcekey="Button1Resource1" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right" valign="top">
                                                            <asp:Label ID="doctorsname" runat="server" Text="Doctor's Name:" Font-Bold="True"
                                                                meta:resourcekey="doctorsnameResource1" />
                                                        </td>
                                                        <td align="left" colspan="4" style="height: 250px;" valign="top">
                                                            <asp:CheckBox ID="CheckBox1" runat="server" Text="Select All" onclick="checkAll(this);"
                                                                meta:resourcekey="CheckBox1Resource1" />
                                                            <asp:CheckBoxList ID="ddlDoctorName" runat="server" RepeatColumns="5" meta:resourcekey="ddlDoctorNameResource1">
                                                            </asp:CheckBoxList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divPrint" style="display: none;" runat="server">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td align="left" style="padding-right: 10px; color: #000000; display: none;">
                                                            <asp:Label ID="lbExcel" Text="Excel Report" Font-Bold="True" ForeColor="#000333"
                                                                runat="server" meta:resourcekey="lbExcelResource1"></asp:Label>
                                                            <asp:ImageButton ID="btnConverttoXL" runat="server" ImageUrl="~/Images/ExcelImage.GIF"
                                                                OnClick="btnConverttoXL_Click" meta:resourcekey="btnConverttoXLResource1" />
                                                        </td>
                                                        <td align="right" style="padding-right: 10px; color: #000000;">
                                                            <b id="printText" runat="server">
                                                                <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>
                                                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                                ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:UpdatePanel ID="updatePanel3" runat="server">
                                                <ContentTemplate>
                                                    <asp:UpdateProgress ID="Progressbar" runat="server">
                                                        <ProgressTemplate>
                                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" Height="16px"
                                                                Width="16px" meta:resourcekey="imgProgressbarResource1" />
                                                            <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                                                        </ProgressTemplate>
                                                    </asp:UpdateProgress>
                                                    <asp:GridView ID="MainGrandTotal" runat="server" AutoGenerateColumns="False" Width="100%"
                                                        Visible="False" ForeColor="#333333" CssClass="mytable1" meta:resourcekey="MainGrandTotalResource1">
                                                        <Columns>
                                                            <asp:BoundField DataField="patientID" HeaderText="Patient ID" meta:resourcekey="BoundFieldResource1"
                                                                Visible="False">
                                                                <ItemStyle HorizontalAlign="Left" Width="25px" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="PatientName" HeaderText="Name" meta:resourcekey="BoundFieldResource2">
                                                                <ItemStyle HorizontalAlign="Left" Wrap="False" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Age" HeaderText="Age" meta:resourcekey="BoundFieldResource3"
                                                                Visible="False">
                                                                <ItemStyle HorizontalAlign="Right" Wrap="False" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="BillNumber" HeaderText="Bill No" meta:resourcekey="BoundFieldResource4"
                                                                Visible="False">
                                                                <ItemStyle HorizontalAlign="Left" Width="25px" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="ConsultantName" HeaderText="Consultant" meta:resourcekey="BoundFieldResource5"
                                                                Visible="False">
                                                                <ItemStyle HorizontalAlign="Left" Width="25px" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="BillAmount" DataFormatString="{0:0.00}" HeaderText="Bill Amt"
                                                                meta:resourcekey="BoundFieldResource6">
                                                                <ItemStyle HorizontalAlign="Right" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="CreditDue" DataFormatString="{0:0.00}" HeaderText="Credit Due"
                                                                meta:resourcekey="BoundFieldResource7" Visible="False">
                                                                <ItemStyle HorizontalAlign="Right" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="NetValue" DataFormatString="{0:0.00}" HeaderText="Net Amt"
                                                                meta:resourcekey="BoundFieldResource8">
                                                                <ItemStyle HorizontalAlign="Right" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="ReceivedAmount" DataFormatString="{0:0.00}" HeaderText="Rcvd Amt"
                                                                meta:resourcekey="BoundFieldResource9">
                                                                <ItemStyle HorizontalAlign="Right" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Discount" DataFormatString="{0:0.00}" HeaderText="Total Discount"
                                                                meta:resourcekey="BoundFieldResource10">
                                                                <ItemStyle HorizontalAlign="Right" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Cash" DataFormatString="{0:0.00}" HeaderText="Cash" meta:resourcekey="BoundFieldResource11">
                                                                <ItemStyle HorizontalAlign="Right" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Cards" DataFormatString="{0:0.00}" HeaderText="Cards"
                                                                meta:resourcekey="BoundFieldResource12">
                                                                <ItemStyle HorizontalAlign="Right" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Cheque" DataFormatString="{0:0.00}" HeaderText="Cheque"
                                                                meta:resourcekey="BoundFieldResource13">
                                                                <ItemStyle HorizontalAlign="Right" />
                                                            </asp:BoundField>
                                                        </Columns>
                                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                        <RowStyle Font-Bold="True" />
                                                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                        <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                    </asp:GridView>
                                                    <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                        CellPadding="0" DataKeyNames="PhysicianID" ForeColor="#333333" GridLines="None"
                                                        OnRowDataBound="grdResult_RowDataBound" Width="100%" PageSize="5" OnPageIndexChanging="grdResult_PageIndexChanging"
                                                        meta:resourcekey="grdResultResource1">
                                                        <HeaderStyle BorderWidth="0px" />
                                                        <PagerStyle CssClass="dataheader1" />
                                                        <Columns>
                                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                                <ItemTemplate>
                                                                    <table cellpadding="2" class="dataheaderInvCtrl" style="border-collapse: collapse;"
                                                                        cellspacing="3" border="1" width="100%">
                                                                        <tr>
                                                                            <td>
                                                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                                    <tr>
                                                                                        <td>
                                                                                            <table cellpadding="5" cellspacing="0" border="0" width="100%">
                                                                                                <tr class="Duecolor">
                                                                                                    <td align="left" style="font-weight: bold; width: 175px;">
                                                                                                        <asp:Label ID="lblPhy" Text='<%# DataBinder.Eval(Container.DataItem,"PhysicianName") %>'
                                                                                                            runat="server" meta:resourcekey="lblPhyResource1"></asp:Label>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td align="right">
                                                                                            <asp:GridView ID="grdChildResult" runat="server" AutoGenerateColumns="False" CellPadding="3"
                                                                                                PageSize="100" ForeColor="Black" GridLines="None" OnRowDataBound="grdChildResult_RowDataBound"
                                                                                                Width="100%" meta:resourcekey="grdChildResultResource1">
                                                                                                <RowStyle Font-Bold="False" />
                                                                                                <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                                                                <Columns>
                                                                                                    <asp:BoundField DataField="Category" HeaderText="Category" meta:resourcekey="BoundFieldResource14">
                                                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                                        <ItemStyle HorizontalAlign="Center" Width="20%"></ItemStyle>
                                                                                                    </asp:BoundField>
                                                                                                    <asp:BoundField DataField="SubCategory" HeaderText="SubCategory" meta:resourcekey="BoundFieldResource15">
                                                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                                        <ItemStyle HorizontalAlign="Center" Width="20%"></ItemStyle>
                                                                                                    </asp:BoundField>
                                                                                                    <asp:BoundField DataField="NoOfTests" HeaderText="NoOfTests" meta:resourcekey="BoundFieldResource16">
                                                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                                        <ItemStyle HorizontalAlign="Center" Width="15%"></ItemStyle>
                                                                                                    </asp:BoundField>
                                                                                                    <asp:BoundField DataField="NoOfCases" HeaderText="NoOfCases" meta:resourcekey="BoundFieldResource17">
                                                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                                        <ItemStyle HorizontalAlign="Center" Width="15%"></ItemStyle>
                                                                                                    </asp:BoundField>
                                                                                                    <asp:BoundField DataField="ActualBilled" HeaderText="ActualBilled" meta:resourcekey="BoundFieldResource18">
                                                                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                                                        <ItemStyle HorizontalAlign="Right" Width="15%"></ItemStyle>
                                                                                                    </asp:BoundField>
                                                                                                    <asp:BoundField DataField="StdBillAmount" HeaderText="StdBillAmount" meta:resourcekey="BoundFieldResource19">
                                                                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                                                        <ItemStyle HorizontalAlign="Right" Width="15%"></ItemStyle>
                                                                                                    </asp:BoundField>
                                                                                                </Columns>
                                                                                            </asp:GridView>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <table border="0" width="100%">
                                                                                                <tr style="font-weight: bold; color: Blue;">
                                                                                                    <td style="width: 22%;" align="center">
                                                                                                    </td>
                                                                                                    <td style="width: 23%;" align="center">
                                                                                                        <asp:Label ID="Label2" runat="server" Text="SubTotal" meta:resourcekey="Label2Resource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td style="width: 10%;" align="center">
                                                                                                        <asp:Label ID="lblTest" runat="server" meta:resourcekey="lblTestResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td style="width: 15%;" align="center">
                                                                                                        <asp:Label ID="lblSubTotal" runat="server" meta:resourcekey="lblSubTotalResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td style="width: 15%;" align="right">
                                                                                                        <asp:Label ID="ActualBill" runat="server" meta:resourcekey="ActualBillResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td style="width: 15%;" align="right">
                                                                                                        <asp:Label ID="StdBill" runat="server" meta:resourcekey="StdBillResource1"></asp:Label>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
                <uc5:Footer ID="Footer1" runat="server" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    </form>
</body>
</html>
