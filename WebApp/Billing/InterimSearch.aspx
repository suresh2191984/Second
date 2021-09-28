<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InterimSearch.aspx.cs" Inherits="Billing_InterimSearch" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/HospitalBillSearch.ascx" TagName="BillSearch"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="PhyHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Bill Search</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
          <script src ="../scripts/MessageHandler.js" language ="javascript" type ="text/javascript" ></script>
    <script src="../Scripts/Common.js" type="text/javascript"></script>
 <script language="JavaScript" type ="text/javascript" >
 var userMsg;
    function PrintPopup() {
        var str = document.getElementById("hdnpopUp").value;
        if (str != "N") {

            var newwin = window.open(str, 'bbb', 'toolbar=0,location=0,directories=0,status=0,scrollbars=1,menubar=1,resizable=1');
            if (window.focus) { newwin.focus() }
        }
    }
    function doValidate() {
        var PatientName = document.getElementById("txtPatientName").value;
        var PatientNumber = document.getElementById("txtPatientNumber").value;
        var InterimBillNo = document.getElementById("txtInterimBillNo").value;
        //            //var date = document.getElementById("txtBillDate").value;
        //            if (patient.trim() == '' && bill.trim() == '' && date.trim() == '') {
        //                alert('Provide value for at least one of the fields');
        //                return false;
        //            }
        //            else {
        //            if (PatientName.trim().length < 3 && PatientName.trim() != '' && (PatientNumber.trim() == '' && date.trim() == '' && InterimBillNo.trim() == '')) {
        //                alert('Name must have atleast three characters');
        //                return false;
        //                //                }
        //            }
        return true;
    }
    //      

    function ShowRegDate() {
        document.getElementById('txtFromDate').value = "";
        document.getElementById('txtToDate').value = "";
        document.getElementById('txtFromPeriod').value = "";
        document.getElementById('txtToPeriod').value = "";
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
            document.getElementById('divRegDate').style.display = 'inline'; 0
            document.getElementById('divRegCustomDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';
        }
    }

    function CheckVisitID() {



    }
    </script>

    <style type="text/css">
        .style1
        {
            width: 136px;
        }
        .style2
        {
            width: 131px;
        }
    </style>
</head>
<body  oncontextmenu="return true;">
    <form id="prFrm" runat="server" defaultbutton="btnBillSearch">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
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
                <uc3:Header ID="userHeader" runat="server" />
                <uc7:PhyHeader ID="physicianHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
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
                                  <input type="hidden" id="hdnReceivedID" runat="server" />
                                <input type="hidden" id="hdnProductId" runat="server" />
                                <input type="hidden" id="tempTable" runat="server" />
                                <input type="hidden" id="hdnProductList" runat="server" />
                                <input type="hidden" id="hdnProductName" runat="server" />
                                <input type="hidden" id="hdnTotalqty" runat="server" />
                                <input type="hidden" id="hdnRowEdit" runat="server" />
                            </li>
                        </ul>
                        
                        <table width="100%" class="defaultfontcolor" border="0" cellpadding="2" cellspacing="2">
                            <tr>
                                <td>
                                    <div id="DivCustomer" runat="server" class="defaultfontcolor">
                                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                            <ContentTemplate>
                                                <table width="100%" class="dataheader2 defaultfontcolor" border="0" cellpadding="2"
                                                    cellspacing="2">
                                                    <tr>
                                                        <td align="center" class="style2">
                                                          <asp:Label ID="Rs_PatientNumber" Text="Patient Number" runat="server" 
                                                                meta:resourcekey="Rs_PatientNumberResource1"></asp:Label>
                                                        </td>
                                                        <td class="style1">
                                                            <asp:TextBox ID="txtPatientNumber" runat="server"  CssClass="Txtboxsmall"
                                                             meta:resourcekey="txtPatientNumberResource1"></asp:TextBox>
                                                        </td>
                                                        <td align="center">
                                                           <asp:Label ID="Rs_BillDate" Text="Bill Date" runat="server" 
                                                                meta:resourcekey="Rs_BillDateResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlRegisterDate" onChange="javascript:return ShowRegDate();"
                                                      CssClass ="ddlsmall" runat="server" 
                                                                meta:resourcekey="ddlRegisterDateResource1">
                                                                <asp:ListItem Value="-1" Selected="True" meta:resourcekey="ListItemResource1">--Select--</asp:ListItem>
                                                                <asp:ListItem Value="0" meta:resourcekey="ListItemResource2">This Week</asp:ListItem>
                                                                <asp:ListItem Value="1" meta:resourcekey="ListItemResource3">This Month</asp:ListItem>
                                                                <asp:ListItem Value="2" meta:resourcekey="ListItemResource4">This Year</asp:ListItem>
                                                                <asp:ListItem Value="3" meta:resourcekey="ListItemResource5">Custom Period</asp:ListItem>
                                                                <asp:ListItem Value="4" meta:resourcekey="ListItemResource6">Today</asp:ListItem>
                                                                <asp:ListItem Value="5" meta:resourcekey="ListItemResource7">Last Week</asp:ListItem>
                                                                <asp:ListItem Value="6" meta:resourcekey="ListItemResource8">Last Month</asp:ListItem>
                                                                <asp:ListItem Value="7" meta:resourcekey="ListItemResource9">Last Year</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <div id="divRegDate" style="display: none" runat="server">
                                                              <asp:Label ID="Rs_FromDate" Text="From Date" runat="server" 
                                                                    meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                                <asp:TextBox Width="70px" ID="txtFromDate" runat="server" 
                                                                    meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                                               <asp:Label ID="Rs_ToDate"  Text="To Date" runat="server" 
                                                                    meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                                <asp:TextBox Width="70px" runat="server" ID="txtToDate" 
                                                                    meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                                            </div>
                                                            <div id="divRegCustomDate" runat="server" style="display: none;">
                                                              <asp:Label ID="Rs_FromDate1" Text="From Date" runat="server" 
                                                                    meta:resourcekey="Rs_FromDate1Resource1"></asp:Label>
                                                                <asp:TextBox Width="70px" ID="txtFromPeriod" runat="server" 
                                                                    meta:resourcekey="txtFromPeriodResource1"></asp:TextBox>
                                                                <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                    CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                                                <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFromPeriod"
                                                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                                    ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                                    CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                                <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                                    ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" 
                                                                    meta:resourcekey="MaskedEditValidator1Resource1" />
                                                                <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFromPeriod"
                                                                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                                                <asp:Label ID="Rs_ToDate1" Text="To Date" runat="server" 
                                                                    meta:resourcekey="Rs_ToDate1Resource1"></asp:Label>
                                                                <asp:TextBox Width="70px" runat="server" ID="txtToPeriod" 
                                                                    meta:resourcekey="txtToPeriodResource1"></asp:TextBox>
                                                                <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                    CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" />
                                                                <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtToPeriod"
                                                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                                    ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                                    CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                                <cc1:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                                                    ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" 
                                                                    meta:resourcekey="MaskedEditValidator2Resource1" />
                                                                <cc1:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtToPeriod"
                                                                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                                                            </div>
                                                        </td>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center" class="style2">
                                                            <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server" 
                                                                meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                                        </td>
                                                        <td class="style1">
                                                            <asp:TextBox ID="txtPatientName" runat="server"  CssClass ="Txtboxsmall"
                                                                meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
                                                        </td>
                                                        <td style="height: 5px;" align="center">
                                                         <asp:Label ID="Rs_InterimReferenceNo" Text="Interim Reference No" runat="server" 
                                                                meta:resourcekey="Rs_InterimReferenceNoResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtInterimBillNo" runat="server"  CssClass="Txtboxsmall"
                                                                meta:resourcekey="txtInterimBillNoResource1"></asp:TextBox>
                                                        </td>
                                                        
                                                    </tr>
                                                    <tr>
                                                        <td colspan="4" align="center">
                                                            <asp:Button ID="btnBillSearch" runat="server" Text="Search" CssClass="btn" 
                                                                onmouseout="this.className='btn'" OnClick="btnBillSearch_Click" 
                                                                OnClientClick="return doValidate();" 
                                                                meta:resourcekey="btnBillSearchResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                            <ContentTemplate>
                                                <table width="100%" id="tablebilID" visible="False" runat="server" class="defaultfontcolor"
                                                    border="0" cellpadding="2" cellspacing="2">
                                                    <tr runat="server">
                                                        <td runat="server">
                                                        <div class="defaultfontcolor">
                                                            <asp:Panel ID="pnlSerch" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                                                <table border="0" id="searchTab" runat="server" cellpadding="4" cellspacing="0" width="100%">
                                                                    <tr runat="server">
                                                                        <td runat="server">
                                                                            <asp:GridView ID="grdResult" EmptyDataText="No Matching Records Found!" Width="100%"
                                                                                runat="server" AllowPaging="True" CellPadding="2" AutoGenerateColumns="False"
                                                                                OnRowDataBound="grdResult_RowDataBound" ForeColor="#333333" 
                                                                                OnPageIndexChanging="grdResult_PageIndexChanging" CssClass="mytable1">
                                                                                <HeaderStyle CssClass="dataheader1" />
                                                                                <PagerStyle CssClass="dataheader1" />
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="Select">
                                                                                        <ItemTemplate>
                                                                                            <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="OrderSelect" />
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                                        <ItemStyle Width="2%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:BoundField DataField="InterimBillNo" HeaderText="InterimBillNo" />
                                                                                      <asp:BoundField DataField="PatientName" HeaderText=" PatientName" />
                                                                                    <asp:TemplateField HeaderText="Patient Number">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblBillID" Text='<%# Eval("PatientNumber")%>' runat="server"></asp:Label>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                     
                                                                                  
                                                                                   
                                                                                    <asp:BoundField DataField="CreatedAt" HeaderText="Bill Date" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" />
                       
                                                                                    <asp:BoundField DataField="FinalBillID" HeaderText="FinalBillID" 
                                                                                        Visible="False"  />
                                                                                     <asp:BoundField DataField="Status" HeaderText="Status"  Visible="False" />
                                                                                     <asp:BoundField DataField="Amount" HeaderText="Amount" 
                                                                                        DataFormatString="{0:0.00}"  >
                                                                             
                                                                                         <ItemStyle HorizontalAlign="Right" />
                                                                                    </asp:BoundField>
                                                                             
                                                                                </Columns>
                                                                            </asp:GridView>
                                                                        </td>
                                                                    </tr>
                                                                    <tr runat="server">
                                                                        <td runat="server">
                                                                            <input type="hidden" id="hdnpopUp" value="N" runat="server" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="tdgo" runat="server" style="display: none;">
                                                                        <td align="center" runat="server">
                                                                            <asp:Label ID="Rs_SelectaRecordandperformoneofthefollowing" Text="Select a Record and perform one of the following" runat="server" meta:resourcekey="Rs_SelectaRecordandperformoneofthefollowingResource1"></asp:Label>
                                                                            <asp:DropDownList ID="ddlAction" runat="server" Width="120px" CssClass="ddlsmall">
                                                                            </asp:DropDownList>
                                                                            
                                                                                <asp:Button ID="btnGo" runat="server" Width="50px" Text="GO" CssClass="btn" 
                                                                                onmouseout="this.className='btn'" OnClientClick="return CheckBillID();" OnClick="btnGo_Click" meta:resourcekey="btnGoResource1"/>
                                                                               
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                            </div> 
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
                </td>
            </tr>
        </table>
      <input type="hidden" id="hdnFID" runat="server" />
                    <input type="hidden" id="hdnpid" runat="server" />
                    <input type="hidden" id="hdnvid" runat="server" />
                    <input type="hidden" id="hdndate" runat="server" />
                    <input type="hidden" id="hdnFinalBillID" runat="server" />
                    <input type ="hidden" id ="hdnVisitDetail" runat ="server" />
                     <input type="hidden" id="hdnStatus" runat="server" />
                       <input type="hidden" id="hdnBillType" runat="server" />
        
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
        <asp:HiddenField ID="hidselection"  runat="server" />
            
     
        <uc5:Footer ID="Footer1" runat="server" />
           <asp:HiddenField ID ="hdnMessages" runat ="server" />

    </div>
    </form>
     <script type="text/javascript" language="javascript">

         function ShowAlertMsg(key) {

             var userMsg = SListForApplicationMessages.Get(key);
             if (userMsg != null) {
                 alert(userMsg);
                 return false;
             }
             else
              {
             alert('URL Not Found');
             return false;
             }
            
             return true;
         }
     
     
     
     
     
         function InterRowCommon(rid, PID, VID, iBillNo, billdate, BID, Status, BillType) {
             var len = document.forms[0].elements.length;
             for (var i = 0; i < len; i++) {
                 if (document.forms[0].elements[i].type == "radio") {
                     document.forms[0].elements[i].checked = false;
                 }
             }
             document.getElementById(rid).checked = true;
             document.getElementById("hdnFID").value = iBillNo;
             document.getElementById("hdnpid").value = PID;
             document.getElementById("hdnvid").value = VID;
             document.getElementById("hdndate").value = billdate;
             document.getElementById("hdnFinalBillID").value = BID;
             document.getElementById("hdnStatus").value = Status;
             document.getElementById("tdgo").style.display = 'block';
             
             if (BillType == "PDC") {
                 document.getElementById("hdnBillType").value = "N";
             }
             if (BillType == "SOS") {
                 document.getElementById("hdnBillType").value = "Y";
             }

         }
         //OnClientClick = "return CheckBillID();"
         function CheckBillID() {
             if (document.getElementById('hdnFID').value == 0) {
             userMsg = SListForApplicationMessages.Get('Billing\\InterimSearch.aspx_3');
                    if(userMsg !=null)
                {
                    alert(userMsg);
                    return false;
                }
            else{
                 alert('Select a bill number');
                 return false;
                 }
             }
//             else if ((document.getElementById('hidselection').value == "EDIT DUECHART") && (document.getElementById('hdnStatus').value == "Paid")) {
//            
//             alert('There is No Pending List so select Other Bill No');
//             return false;
//             }
         }
    </script>

    <script type="text/javascript" language="javascript">
        if (document.getElementById('hdnTempFromPeriod').value == "1" && document.getElementById('hdnTempToPeriod').value == "1") {
            document.getElementById('divRegDate').style.display = 'none';
            document.getElementById('divRegDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'block';
            document.getElementById('divRegCustomDate').style.display = 'block';
            document.getElementById('divRegCustomDate').style.display = 'inline';
            document.getElementById('divRegCustomDate').style.display = 'inline';
        }
        if (document.getElementById('hdnTempFrom').value != "" && document.getElementById('hdnTempTo').value != "") {
            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegCustomDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegDate').style.display = 'inline';
        }
    </script>
</body>
</html>