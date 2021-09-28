<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IPItemizedBill.aspx.cs" Inherits="InPatient_IPItemizedBill" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
 
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
 
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc8" %>
  
<%@ Register Src="../CommonControls/FinalBillHeader.ascx" TagName="FinalBillHeader"
    TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/DiagnoseWithICD.ascx" TagName="DiagnoseWithICD"
    TagPrefix="uc23" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>IPView Bill</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <style type="text/css">
        .dvPrintClass
        {
            font-family: Verdana;
        }
    </style>
</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">

    <script language="javascript" type="text/javascript">
        function CallPrintRecceipt() {
            var prtContent = document.getElementById('printArea1');
            var WinPrint =
                        window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();

        }
    </script>

    <input type="hidden" id="hdnRecievedAmount" runat="server" />
    <input type="hidden" id="hdnCurrentDue" runat="server" />
    <input type="hidden" id="hdnGrandTotal" runat="server" />
    <input type="hidden" id="hdnDeduction" runat="server" />
    <asp:ScriptManager ID="scrpt" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc8:PatientHeader ID="PatientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc121:LeftMenu ID="LeftMenu1" runat="server" />
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
                        <div align="center" id="printArea1" style="font-family: Verdana; font-size: 10px;">
                            <table width="100%" border="1" style="border-style: solid; border-width: 1px; border-color: Black;
                                font-size: 10px; font-family: Verdana;" cellspacing="0" cellpadding="0" align="center">
                                <tr>
                                    <td colspan="5" align="center">
                                        <asp:Label Style="font-family: Verdana; font-size: 10px;" Visible="False" ID="lblHospitalName"
                                            runat="server" meta:resourcekey="lblHospitalNameResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr class="dataheaderInvCtrl">
                                    <td colspan="7">
                                        <table width="98%" id="tblHeader" runat="server" border="0" cellspacing="0" cellpadding="0"
                                            style="font-family: Verdana; font-size: 10px;">
                                            <tr>
                                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                                    <asp:Label ID="Rs_BillNo" Text="Bill No" runat="server" 
                                                        meta:resourcekey="Rs_BillNoResource1"></asp:Label>
                                                </td>
                                                <td align="left" nowrap="nowrap" class="style1">
                                                    &nbsp;:&nbsp;
                                                </td>
                                                <td width="83%" align="left" nowrap="nowrap">
                                                    <asp:Label ID="lblInvoiceNo" runat="server" Style="font-weight: 700" 
                                                        meta:resourcekey="lblInvoiceNoResource1"></asp:Label>
                                                </td>
                                                <td width="83%" align="left" nowrap="nowrap">
                                                    <asp:Label ID="lblBillDate" Text="Bill Date" runat="server" 
                                                        meta:resourcekey="lblBillDateResource1"></asp:Label>
                                                </td>
                                                <td width="83%" align="left" nowrap="nowrap" class="style1">
                                                    &nbsp;:&nbsp;
                                                </td>
                                                <td width="83%" align="left" nowrap="nowrap">
                                                    <asp:Label ID="lblInvoiceDate" runat="server" Style="font-weight: 700" 
                                                        meta:resourcekey="lblInvoiceDateResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 23%" align="left" nowrap="nowrap">
                                                    <label>
                                                        <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server" 
                                                        meta:resourcekey="Rs_PatientNameResource1"></asp:Label></label>
                                                </td>
                                                <td align="left" nowrap="nowrap" class="style1">
                                                    &nbsp;:&nbsp;
                                                </td>
                                                <td width="83%" align="left" nowrap="nowrap">
                                                    <span style="width: 23%">
                                                        <asp:Label ID="lblName" runat="server" Style="font-weight: 700" 
                                                        meta:resourcekey="lblNameResource1"></asp:Label>
                                                    </span>
                                                </td>
                                                <td width="83%" align="left" nowrap="nowrap">
                                                    <asp:Label ID="Rs_PatientNo" Text="Patient No" runat="server" 
                                                        meta:resourcekey="Rs_PatientNoResource1"></asp:Label>
                                                </td>
                                                <td width="83%" align="left" nowrap="nowrap">
                                                    &nbsp;:&nbsp;
                                                </td>
                                                <td width="83%" align="left" nowrap="nowrap">
                                                    <span style="width: 23%">
                                                        <asp:Label ID="lblPatientNumber" runat="server" Style="font-weight: 700" 
                                                        meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 23%" align="left" nowrap="nowrap">
                                                    <asp:Label ID="Rs_PatientAge" Text="Patient Age" runat="server" 
                                                        meta:resourcekey="Rs_PatientAgeResource1"></asp:Label>
                                                </td>
                                                <td align="left" nowrap="nowrap" class="style1">
                                                    &nbsp;:&nbsp;
                                                </td>
                                                <td width="83%" align="left" nowrap="nowrap">
                                                    <asp:Label ID="lblAge" runat="server" Style="font-weight: 700" 
                                                        meta:resourcekey="lblAgeResource1"></asp:Label>
                                                </td>
                                                <td width="83%" align="left" nowrap="nowrap">
                                                    <asp:Label ID="Rs_Sex" Text="Sex" runat="server" 
                                                        meta:resourcekey="Rs_SexResource1"></asp:Label>
                                                </td>
                                                <td width="83%" align="left" nowrap="nowrap">
                                                    &nbsp;:&nbsp;
                                                </td>
                                                <td width="83%" align="left" nowrap="nowrap">
                                                    <asp:Label ID="lblSex" runat="server" Style="font-weight: 700" 
                                                        meta:resourcekey="lblSexResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" nowrap="nowrap">
                                                    <asp:Label runat="server" ID="lblPhy" Text="Primary Physician " 
                                                        meta:resourcekey="lblPhyResource1"></asp:Label>
                                                </td>
                                                <td align="left" nowrap="nowrap" class="style1">
                                                    &nbsp;:&nbsp;
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    <asp:Label ID="lblPhysician" runat="server" Style="font-weight: 700" 
                                                        meta:resourcekey="lblPhysicianResource1"></asp:Label>
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    <asp:Label ID="lbIPNo" Text="IP No" runat="server" 
                                                        meta:resourcekey="lbIPNoResource1"></asp:Label>
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    &nbsp;:&nbsp;
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    <asp:Label ID="lblIPNo" runat="server" Style="font-weight: 700" 
                                                        meta:resourcekey="lblIPNoResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" nowrap="nowrap">
                                                    &nbsp;
                                                </td>
                                                <td align="left" nowrap="nowrap" class="style1">
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" nowrap="nowrap">
                                                    <asp:Label runat="server" ID="Label1" Text="Date of Admission" 
                                                        meta:resourcekey="Label1Resource1"></asp:Label>
                                                </td>
                                                <td align="left" nowrap="nowrap" class="style1">
                                                    &nbsp;:&nbsp;
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    <asp:Label ID="lblDOA" runat="server" Style="font-weight: 700" 
                                                        meta:resourcekey="lblDOAResource1"></asp:Label>
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    <asp:Label ID="Label3" Text="Date of Discharge" runat="server" 
                                                        meta:resourcekey="Label3Resource1"></asp:Label>
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    &nbsp;:&nbsp;
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    <asp:Label ID="lblDOD" runat="server" Style="font-weight: 700" 
                                                        meta:resourcekey="lblDODResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6">
                                                    <uc3:FinalBillHeader ID="FinalBillHeader1" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr class="dataheaderInvCtrl">
                                    <td colspan="7" runat="server" id="tdDiagnose" align="left">
                                        <table border="0" cellspacing="0" cellpadding="0" width="100%" style="font-family: Verdana;
                                            font-size: 10px;">
                                            <tr>
                                                <td>
                                                    <uc23:DiagnoseWithICD ID="DiagnoseWithICD1" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="7">
                                        <table border="0" cellspacing="0" cellpadding="0" width="100%" style="font-family: Verdana;
                                            font-size: 10px;">
                                            <tr>
                                                <td colspan="3">
                                                    <br />
                                                    <div class="dataheaderInvCtrl" align="left" style="display: none; font-weight: bold"
                                                        id="trRoomCharges" runat="server">
                                                        <asp:Label ID="Rs_RoomCharges" Text="Room Charges" runat="server" 
                                                            meta:resourcekey="Rs_RoomChargesResource1"></asp:Label>
                                                    </div>
                                                    <div style="padding-left: 10px">
                                                        <asp:GridView ID="gvIndentRoomType" runat="server" GridLines="None" AutoGenerateColumns="False"
                                                            OnRowDataBound="gvIndentRoomType_RowDataBound" Width="100%" 
                                                            meta:resourcekey="gvIndentRoomTypeResource1">
                                                            <Columns>
                                                                <asp:TemplateField meta:resourcekey="TemplateFieldResource4">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                    <ItemTemplate>
                                                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                            <tr>
                                                                                <td align="left">
                                                                                    <span style="font-family: Verdana; font-size: 10px;"><b>
                                                                                        <asp:Label ID="lblFeeTypeDetails" runat="server" 
                                                                                        Text='<%# DataBinder.Eval(Container.DataItem, "RoomTypeName") %>' 
                                                                                        meta:resourcekey="lblFeeTypeDetailsResource1"></asp:Label>
                                                                                    </b></span>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:GridView ID="gvIndentRoomDetails" runat="server" AutoGenerateColumns="False"
                                                                                        OnRowDataBound="gvIndentRoomDetails_RowDataBound" Width="100%" 
                                                                                        GridLines="None" Font-Names="Verdana"
                                                                                        Font-Size="10px" meta:resourcekey="gvIndentRoomDetailsResource1">
                                                                                        <HeaderStyle CssClass="dataheader1" BorderColor="Black" BorderStyle="Solid" />
                                                                                        <PagerStyle CssClass="dataheader1" />
                                                                                        <RowStyle CssClass="dataheaderInvCtrl" />
                                                                                        <Columns>
                                                                                            <asp:BoundField HeaderText="ID" DataField="DetailsID" 
                                                                                                meta:resourcekey="BoundFieldResource1" />
                                                                                            <asp:BoundField HeaderText="FeeType" DataField="FeeType" 
                                                                                                meta:resourcekey="BoundFieldResource2" />
                                                                                            <asp:BoundField HeaderText="FeeID" DataField="FeeID" 
                                                                                                meta:resourcekey="BoundFieldResource3" />
                                                                                            <asp:BoundField HeaderText="Description" DataField="Description" 
                                                                                                meta:resourcekey="BoundFieldResource4">
                                                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField HeaderText="From" DataField="FromDate" 
                                                                                                DataFormatString="{0:dd/MM/yyyy}" meta:resourcekey="BoundFieldResource5">
                                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
                                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField HeaderText="To" DataField="ToDate" 
                                                                                                DataFormatString="{0:dd/MM/yyyy}" meta:resourcekey="BoundFieldResource6">
                                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
                                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                            </asp:BoundField>
                                                                                            <asp:TemplateField HeaderText="UnitPrice" 
                                                                                                meta:resourcekey="TemplateFieldResource1">
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="txtUnitPrice" Style="text-align: right;" runat="server" MaxLength="10"
                                                                                                        Text='<%# Eval("AMOUNT") %>'   onkeypress="return ValidateOnlyNumeric(this);"   
                                                                                                        Width="60px" meta:resourcekey="txtUnitPriceResource1"></asp:Label>
                                                                                                    <asp:HiddenField ID="hdnOldPrice" Value='<%# Eval("AMOUNT") %>' 
                                                                                                        runat="server" />
                                                                                                </ItemTemplate>
                                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Quantity" 
                                                                                                meta:resourcekey="TemplateFieldResource2">
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="txtQuantity" runat="server" Style="text-align: right;" MaxLength="10"
                                                                                                        Text='<%# Eval("unit") %>'   onkeypress="return ValidateOnlyNumeric(this);"   
                                                                                                        Width="60px" meta:resourcekey="txtQuantityResource1"></asp:Label>
                                                                                                    <asp:HiddenField ID="hdnOldQuantity" Value='<%# Eval("unit") %>' 
                                                                                                        runat="server" />
                                                                                                </ItemTemplate>
                                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Amount" 
                                                                                                meta:resourcekey="TemplateFieldResource3">
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="txtAmount" runat="server" Style="text-align: right; padding-right: 10px;"
                                                                                                        ReadOnly="true" Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>' 
                                                                                                        Width="60px" meta:resourcekey="txtAmountResource1"></asp:Label>
                                                                                                    <asp:HiddenField ID="hdnAmount" runat="server" />
                                                                                                </ItemTemplate>
                                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:BoundField DataField="Status" HeaderText="Status" 
                                                                                                meta:resourcekey="BoundFieldResource7" />
                                                                                        </Columns>
                                                                                    </asp:GridView>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr runat="server" id="trRoomLine">
                                                <td colspan="3" style="height: 1px; background-color: Black; width: 100%;">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" align="right">
                                                    <br />
                                                    <div id="dvTreatmentCharges" class="dataheaderInvCtrl" align="left" style="font-weight: bold"
                                                        runat="server">
                                                        <asp:Label ID="Rs_TreatmentCharges" Text="Treatment Charges" runat="server" 
                                                            meta:resourcekey="Rs_TreatmentChargesResource1"></asp:Label>
                                                        
                                                    </div>
                                                    <div style="padding-left: 10px">
                                                        <asp:GridView ID="gvTreatmentCharges" runat="server" GridLines="None" AutoGenerateColumns="False"
                                                            OnRowDataBound="gvTreatment_RowDataBound" Width="100%" 
                                                            meta:resourcekey="gvTreatmentChargesResource1">
                                                            <Columns>
                                                                <asp:TemplateField meta:resourcekey="TemplateFieldResource9">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                    <ItemTemplate>
                                                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                            <tr>
                                                                                <td align="left">
                                                                                    <span style="font-family: Verdana; font-size: 10px;"><b>
                                                                                        <asp:Label ID="lblFeeType" runat="server" Visible="False" 
                                                                                        Text='<%# DataBinder.Eval(Container.DataItem, "FeeType") %>' 
                                                                                        meta:resourcekey="lblFeeTypeResource1"></asp:Label>
                                                                                        <span style="text-decoration: underline;">
                                                                                            <asp:Label ID="lblFeeTypeDetails" runat="server" 
                                                                                        Text='<%# DataBinder.Eval(Container.DataItem, "FeeType") %>' 
                                                                                        meta:resourcekey="lblFeeTypeDetailsResource2"></asp:Label></span>
                                                                                    </span></b>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:GridView ID="gvIndents" CellPadding="3" runat="server" AutoGenerateColumns="False"
                                                                                        GridLines="None" Width="100%" OnRowDataBound="gvIndents_RowDataBound" Font-Names="Verdana"
                                                                                        Font-Size="10px" meta:resourcekey="gvIndentsResource1">
                                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                                        <PagerStyle CssClass="dataheader1" />
                                                                                        <Columns>
                                                                                            <asp:BoundField HeaderText="ID" DataField="DetailsID" 
                                                                                                meta:resourcekey="BoundFieldResource8" />
                                                                                            <asp:BoundField HeaderText="FeeType" DataField="FeeType" 
                                                                                                meta:resourcekey="BoundFieldResource9">
                                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField HeaderText="FeeID" DataField="FeeID" 
                                                                                                meta:resourcekey="BoundFieldResource10" />
                                                                                            <asp:TemplateField HeaderText="Description" 
                                                                                                meta:resourcekey="TemplateFieldResource5">
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="chkID" runat="server" Style="text-align: left;" 
                                                                                                        Text='<%# Eval("Description") %>' meta:resourcekey="chkIDResource1" />
                                                                                                    <asp:HiddenField ID="hdnServiceCode" runat="server" Value='<%# Eval("ServiceCode") %>' />
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle HorizontalAlign="Left" Width="35%" />
                                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:BoundField HeaderText="Date" DataField="FromDate" 
                                                                                                DataFormatString="{0:dd/MM/yyyy}" Visible="False" 
                                                                                                meta:resourcekey="BoundFieldResource11">
                                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
                                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                            </asp:BoundField>
                                                                                            <asp:TemplateField HeaderText="UnitPrice" 
                                                                                                meta:resourcekey="TemplateFieldResource6">
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="txtUnitPrice" Style="text-align: right;" runat="server" MaxLength="10"
                                                                                                        Text='<%# Eval("AMOUNT") %>'   onkeypress="return ValidateOnlyNumeric(this);"  
                                                                                                        Width="60px" meta:resourcekey="txtUnitPriceResource2"></asp:Label>
                                                                                                    <asp:HiddenField ID="hdnOldPrice" Value='<%# Eval("AMOUNT") %>' 
                                                                                                        runat="server" />
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle HorizontalAlign="Center" Width="100px" />
                                                                                                <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Quantity" 
                                                                                                meta:resourcekey="TemplateFieldResource7">
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="txtQuantity" runat="server" Style="text-align: right;" MaxLength="10"
                                                                                                        Text='<%# Eval("unit") %>'   onkeypress="return ValidateOnlyNumeric(this);"   
                                                                                                        Width="60px" meta:resourcekey="txtQuantityResource2"></asp:Label>
                                                                                                    <asp:HiddenField ID="hdnOldQuantity" Value='<%# Eval("unit") %>' 
                                                                                                        runat="server" />
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle HorizontalAlign="Center" Width="60px" />
                                                                                                <HeaderStyle HorizontalAlign="Center" Width="60px" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Amount" 
                                                                                                meta:resourcekey="TemplateFieldResource8">
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="txtAmount" runat="server" Style="text-align: right; padding-right: 10px;"
                                                                                                        ReadOnly="true" Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>' 
                                                                                                        Width="60px" meta:resourcekey="txtAmountResource2"></asp:Label>
                                                                                                    <asp:HiddenField ID="hdnAmount" runat="server" />
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle HorizontalAlign="Center" Width="100px" />
                                                                                                <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:BoundField DataField="Status" HeaderText="Status" 
                                                                                                meta:resourcekey="BoundFieldResource12" />
                                                                                        </Columns>
                                                                                    </asp:GridView>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr runat="server" id="trTreatmentLine">
                                                <td colspan="3" style="height: 1px; background-color: Black; width: 100%;">
                                                </td>
                                            </tr>
                                            <tr class="dataheaderInvCtrl">
                                                <td colspan="3" align="center">
                                                    <br />
                                                    <div id="dvpharmacy" runat="server">
                                                        <asp:Label ID="Rs_Pharmacy" Text="Pharmacy" runat="server" 
                                                            meta:resourcekey="Rs_PharmacyResource1"></asp:Label></div>
                                                    <br />
                                                     <asp:GridView ID="gvMedicalItems" CellPadding="3" runat="server" AutoGenerateColumns="False"
                                                        GridLines="None" Width="100%" OnRowDataBound="gvPharmacy_RowDataBound" Font-Names="Verdana"
                                                        Font-Size="10px" meta:resourcekey="gvMedicalItemsResource1">
                                                        <HeaderStyle CssClass="dataheader1" />
                                                        <PagerStyle CssClass="dataheader1" />
                                                        <RowStyle HorizontalAlign="Left" />
                                                        <Columns>
                                                            <asp:BoundField HeaderText="Description" DataField="Description" 
                                                                meta:resourcekey="BoundFieldResource13" />
                                                            <asp:TemplateField HeaderText="Batch No" 
                                                                meta:resourcekey="TemplateFieldResource10">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblBatchNo" Text='<%# Eval("BatchNo") %>' runat="server" 
                                                                        meta:resourcekey="lblBatchNoResource1"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Expiry Date" 
                                                                meta:resourcekey="TemplateFieldResource11">
                                                                <ItemTemplate>
                                                                    <asp:Label Text='<%# Eval("ExpiryDate") %>' ID="lblExpiryDate" runat="server" 
                                                                        meta:resourcekey="lblExpiryDateResource1"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField HeaderText="Date" Visible="false" DataField="FromDate" 
                                                                meta:resourcekey="BoundFieldResource14" />
                                                            <asp:BoundField HeaderText="Quantity" DataField="unit" 
                                                                meta:resourcekey="BoundFieldResource15" />
                                                            <asp:BoundField HeaderText="UnitPrice" DataField="AMOUNT" 
                                                                meta:resourcekey="BoundFieldResource16" />
                                                            <asp:TemplateField HeaderText="Amount" 
                                                                meta:resourcekey="TemplateFieldResource12">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="txtAmount" runat="server" Style="padding-right: 10px;" Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>'
                                                                        Width="60px" meta:resourcekey="txtAmountResource3"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                            <tr runat="server" id="trPharmacyLine">
                                                <td colspan="3" style="height: 1px; background-color: Black; width: 100%;">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" align="center">
                                                    <br />
                                                    <div id="divNonMedicalHead" class="dataheaderInvCtrl" align="left" style="font-weight: bold"
                                                        runat="server">
                                                       <asp:Label ID="Rs_NonMedicalItems"  Text="Non-MedicalItems" runat="server" 
                                                            meta:resourcekey="Rs_NonMedicalItemsResource1"></asp:Label>
                                                    </div>
                                                    <div id="divNonMedical" visible="false" runat="server" style="padding-left: 10px">
                                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                            <tr>
                                                                <td align="left">
                                                                    <span style="font-family: Verdana; font-size: 10px;"><b><span style="text-decoration: underline;
                                                                        text-align: left;">
                                                                        <asp:Label ID="lblNonMedicalDetails" runat="server" 
                                                                        Text="Sum of NonMedicalItems" meta:resourcekey="lblNonMedicalDetailsResource1"></asp:Label>
                                                                        <asp:HiddenField ID="hdnNonMedicalDetails" runat="server" Value="0.00" />
                                                                    </span></b></span>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:GridView ID="gvNonMedicalItems" CellPadding="3" runat="server" AutoGenerateColumns="False"
                                                                        GridLines="None" Width="100%" OnRowDataBound="gvNonMedicalItems_RowDataBound"
                                                                        Font-Names="Verdana" Font-Size="10px" 
                                                                        meta:resourcekey="gvNonMedicalItemsResource1">
                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                        <PagerStyle CssClass="dataheader1" />
                                                                        <Columns>
                                                                            <asp:BoundField HeaderText="ID" DataField="DetailsID" 
                                                                                meta:resourcekey="BoundFieldResource17" />
                                                                            <asp:BoundField HeaderText="FeeType" DataField="FeeType" 
                                                                                meta:resourcekey="BoundFieldResource18">
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField HeaderText="FeeID" DataField="FeeID" 
                                                                                meta:resourcekey="BoundFieldResource19" />
                                                                            <%--  <asp:BoundField HeaderText="Description" DataField="Description">
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </asp:BoundField>--%>
                                                                            <asp:TemplateField HeaderText="Description" HeaderStyle-Width="35%" 
                                                                                meta:resourcekey="TemplateFieldResource13">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="chkID" runat="server" Style="text-align: left;" 
                                                                                        Text='<%# Eval("Description") %>' meta:resourcekey="chkIDResource2" />
                                                                                    <asp:HiddenField ID="hdnServiceCode" runat="server" Value='<%# Eval("ServiceCode") %>' />
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField HeaderText="Date" DataField="FromDate" 
                                                                                DataFormatString="{0:dd/MM/yyyy}" meta:resourcekey="BoundFieldResource20">
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                            </asp:BoundField>
                                                                            <asp:TemplateField HeaderText="UnitPrice" HeaderStyle-Width="15%" 
                                                                                meta:resourcekey="TemplateFieldResource14">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="txtUnitPrice" Style="text-align: right;" runat="server" MaxLength="10"
                                                                                        Text='<%# Eval("AMOUNT") %>'   onkeypress="return ValidateOnlyNumeric(this);"  
                                                                                        Width="60px" meta:resourcekey="txtUnitPriceResource3"></asp:Label>
                                                                                    <asp:HiddenField ID="hdnOldPrice" Value='<%# Eval("AMOUNT") %>' 
                                                                                        runat="server" />
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Quantity" HeaderStyle-Width="15%" 
                                                                                meta:resourcekey="TemplateFieldResource15">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="txtQuantity" runat="server" Style="text-align: right;" MaxLength="10"
                                                                                        Text='<%# Eval("unit") %>'   onkeypress="return ValidateOnlyNumeric(this);"   
                                                                                        Width="60px" meta:resourcekey="txtQuantityResource3"></asp:Label>
                                                                                    <asp:HiddenField ID="hdnOldQuantity" Value='<%# Eval("unit") %>' 
                                                                                        runat="server" />
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Amount" 
                                                                                meta:resourcekey="TemplateFieldResource16">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="txtAmount" runat="server" Style="text-align: right; padding-right: 10px;"
                                                                                        ReadOnly="true" Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>' 
                                                                                        Width="60px" meta:resourcekey="txtAmountResource4"></asp:Label>
                                                                                    <asp:HiddenField ID="hdnAmount" runat="server" />
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField DataField="Status" HeaderText="Status" 
                                                                                meta:resourcekey="BoundFieldResource21" />
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr runat="server" id="trNonMedicalLine">
                                                <td colspan="3" style="height: 1px; background-color: Black; width: 100%;">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" style="padding-top: 10px; vertical-align: middle;">
                                                    <table cellpadding="4" class="dataheaderInvCtrl" style="vertical-align: middle; font-family: Verdana;
                                                        font-size: 10px;" cellspacing="0" border="0" width="100%">
                                                        <tr class="dataheaderInvCtrl">
                                                            <td width="22%">
                                                                &nbsp;
                                                            </td>
                                                            <td width="41%" align="right">
                                                                <asp:Label ID="Rs_GrossBillAmount" Text="Gross Bill Amount"  runat="server" 
                                                                    meta:resourcekey="Rs_GrossBillAmountResource1"></asp:Label>
                                                            </td>
                                                            <td width="10%" align="right" class="details_value">
                                                                <asp:HiddenField ID="hdnGross" runat="server" />
                                                                <asp:Label ID="txtGross" runat="server" Text="0.00" Font-Bold="True" 
                                                                    meta:resourcekey="txtGrossResource1"></asp:Label>
                                                                <input type="hidden" runat="server" id="hdnStdDedID" value="0" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_Discount" Text="Discount" runat="server" 
                                                                    meta:resourcekey="Rs_DiscountResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="txtDiscount" runat="server" Font-Bold="True" Text="0.00" 
                                                                    meta:resourcekey="txtDiscountResource1" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" colspan="2">
                                                                <asp:Label ID="Rs_Tax" Text="Tax" runat="server" 
                                                                    meta:resourcekey="Rs_TaxResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="txtTax" runat="server" Font-Bold="True" Text="0.00" 
                                                                    meta:resourcekey="txtTaxResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" align="right">
                                                                <div id="dvTaxDetails" runat="server">
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_PreviousDue" Text="Previous Due" runat="server" 
                                                                    meta:resourcekey="Rs_PreviousDueResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="txtPreviousDue" Font-Bold="True" runat="server" Text="0.00" 
                                                                    meta:resourcekey="txtPreviousDueResource1" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_CreditDebitCardCharge" Text="Credit/Debit Card Charge" 
                                                                    runat="server" meta:resourcekey="Rs_CreditDebitCardChargeResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="lblServiceCharge" Font-Bold="True" runat="server" Text="0.00" 
                                                                    meta:resourcekey="lblServiceChargeResource1" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_RoundOff" Text="Round Off" runat="server" 
                                                                    meta:resourcekey="Rs_RoundOffResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="lblRoundOff" Font-Bold="True" runat="server" Text="0.00" 
                                                                    meta:resourcekey="lblRoundOffResource1" />
                                                            </td>
                                                        </tr>
                                                        <tr class="dataheaderInvCtrl">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right" valign="middle">
                                                               <asp:Label ID="Rs_NetBillAmount" Text="Net Bill Amount" runat="server" 
                                                                    meta:resourcekey="Rs_NetBillAmountResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                -----------<br />
                                                                <asp:Label ID="lblTotal" Font-Bold="True" runat="server" Text="0.00" 
                                                                    meta:resourcekey="lblTotalResource1" />
                                                                <br />
                                                                -----------
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" visible="false">
                                                                <asp:Label ID="txtRecievedAdvance" Visible="False" Font-Bold="True" runat="server"
                                                                    Text="0.00" meta:resourcekey="txtRecievedAdvanceResource1" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_AmountReceivedfromPatient"  
                                                                    Text="Amount Received from Patient" runat="server" 
                                                                    meta:resourcekey="Rs_AmountReceivedfromPatientResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="txtPreviousAmountPaid" Font-Bold="True" runat="server" 
                                                                    Text="0.00" meta:resourcekey="txtPreviousAmountPaidResource1" />
                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="trPaidAmt" visible="false">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                               <asp:Label ID="Rs_PaidAgainstNonMedicalItems" 
                                                                    Text="Paid Against Non-MedicalItems" runat="server" 
                                                                    meta:resourcekey="Rs_PaidAgainstNonMedicalItemsResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="lblPaidAmt" runat="server" Font-Bold="True" Text="0.00" 
                                                                    meta:resourcekey="lblPaidAmtResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="trCoPay" visible="false">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_CoPayment" Text="Co-Payment" runat="server" 
                                                                    meta:resourcekey="Rs_CoPaymentResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="lblCoPayment" runat="server" Font-Bold="True" Text="0.00" 
                                                                    meta:resourcekey="lblCoPaymentResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="tpaDetails" runat="server" Text="Amount Received From TPA" 
                                                                    meta:resourcekey="tpaDetailsResource1"></asp:Label>
                                                                <td align="right">
                                                                    <asp:Label ID="txtThirdParty" runat="server" Text="0.00" Font-Bold="True" 
                                                                        meta:resourcekey="txtThirdPartyResource1" />
                                                                </td>
                                                        </tr>
                                                        <tr runat="server" id="trTPADue" visible="false">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                               <asp:Label ID="Rs_DueFromTPA" Text="Due From TPA" runat="server" 
                                                                    meta:resourcekey="Rs_DueFromTPAResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="lblTPADue" runat="server" Font-Bold="True" Text="0.00" 
                                                                    meta:resourcekey="lblTPADueResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr class="dataheaderInvCtrl">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_Due" Text="Due" runat="server" 
                                                                    meta:resourcekey="Rs_DueResource1"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="txtGrandTotal" Font-Bold="True" runat="server" Text="0.00" 
                                                                    meta:resourcekey="txtGrandTotalResource1" />
                                                            </td>
                                                        </tr>
                                                        <%--  <tr><td colspan="3" align="right">----------------------------------------------</td></tr>--%>
                                                        <tr>
                                                            <%--<td>
                                                            &nbsp;
                                                        </td>
                                                        <td align="right">
                                                            Previous Refund
                                                        </td>--%>
                                                            <td align="right" visible="false">
                                                                <asp:Label ID="txtPreviousRefund" Visible="False" Font-Bold="True" 
                                                                    runat="server" meta:resourcekey="txtPreviousRefundResource1" />
                                                            </td>
                                                        </tr>
                                                        <tr class="dataheaderInvCtrl">
                                                            <%--  <td>
                                                            &nbsp;
                                                        </td>
                                                        <td align="right">
                                                            Amount to Refund
                                                        </td>--%>
                                                            <td align="right" visible="false">
                                                                <asp:Label ID="txtRefundAmount" Visible="False" Font-Bold="True" runat="server" 
                                                                    meta:resourcekey="txtRefundAmountResource1" />
                                                            </td>
                                                        </tr>
                                                        <%-- <tr><td colspan="3" align="right">---------------------</td></tr>--%>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td colspan="6" align="left">
                                        <asp:Label ID="lblAmountinWords" runat="server" 
                                            Style="font-family: Verdana; font-size: 10px" 
                                            ><asp:Label ID="Rs_AmountinWords" Text="Amount in Words:" runat="server"></asp:Label>&nbsp;(<%= CurrencyName %>)&nbsp;</asp:Label>
                                        <asp:Label ID="lblAmount" runat="server" 
                                            Style="font-family: Verdana; font-size: 10px" 
                                            ></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td colspan="2" align="center">
                                        <asp:Label ID="lblSignature" runat="server" Text="Signature" 
                                            meta:resourcekey="lblSignatureResource1"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <center>
                            <br />
                            <input type="button" id="btnBillPrint" value="PrintBill" class="btn" onmouseover="this.className='btn btnhov'"
                                onmouseout="this.className='btn'" onclick="CallPrintRecceipt();return false;" />
                            <%--<asp:Button ID="btnReceipt" runat="server" OnClick="btnViewReceipt_Click" Text="Print Receipt" CssClass="btn" />--%>
                            &nbsp; &nbsp; &nbsp; &nbsp;
                            <asp:Button ID="btnViewSummary" runat="server" OnClick="btnViewSummary_Click" Text="View Summary Bill"
                                CssClass="btn" meta:resourcekey="btnViewSummaryResource1" />
                            <asp:Button ID="btnViewBill" runat="server" OnClick="btnViewBill_Click" Text="View Bill With Dates"
                                CssClass="btn" meta:resourcekey="btnViewBillResource1" />
                            <br />
                       </center>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
