<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClientManagement.aspx.cs" Inherits="Lab_InvocieMaster"
    EnableEventValidation="false" meta:resourcekey="PageResource1" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrderedSamples.ascx" TagName="OrderedSamples"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Client Master</title>
    <style type="text/css">
        table.gridView td, table.gridView th
        {
            padding: 3px 2px !important;
        }
        #pnlNotify table
        {
            width: 100%;
        }
        #pnlNotify table td
        {
            width: 17%;
        }
        .ChkAlign
        {
            margin: 0 5px 0 0;
        }    
        .dynamicgrid
        {
            min-height: 50px;
            max-height: 110px;
            overflow: auto;
        }
        .ui-autocomplete.ui-front
        {
            width: 260px !important;
            min-height: 20px;
            max-height: 200px;
            overflow: auto;
        }
        .ui-datepicker
        {
            font-size: 12pt !important;
        }
        .listMain
        {
            z-index: 999999;
        }
        .h-350
        {
            height: 350px;
        }
        .h-250
        {
            height: 250px;
        }
        .h-100
        {
            height: 100px !important;
        }
        .h-150
        {
            height: 150px !important;
        }
        .h-200
        {
            height: 200px !important;
        }
        .w-250
        {
            width: 250px;
        }
        .w-350
        {
            width: 350px;
        }
        .w-420
        {
            width: 420px;
        }
        .w-400
        {
            width: 400px;
        }
        .w-500
        {
            width: 500px;
        }
        .marginauto
        {
            margin: auto;
        }
        .o-auto
        {
            overflow: auto;
        }
        .contentdata img
        {
            cursor: pointer;
        }
        .bg-searchimage
        {
            background: url("../Images/magnifying-glass.png") #FFF no-repeat scroll right top;
        }
        #updatePanel21 table
        {
            border-top: 1px solid #24618E;
        }
        .popAssociatedClient
        {
            display: none;
            position: fixed;
            _position: absolute;
            min-height: 100px;
            width: 650px;
            left: 350px;
            top: 10px;
            z-index: 100;
        }
        .popAssociatedClient
        {
            -moz-box-shadow: 0 0 5px #a5a5a3;
            -webkit-box-shadow: 0 0 5px #a5a5a3;
            box-shadow: 0 0 5px #a5a5a3;
            border: 1px solid #008080 !important;
            background: #a5a5a3;
        }
        element.style
        {
            margin-top: 20px;
            width: 650px;
            left: 350px;
            top: 80px;
            display: block;
            background-color: white;
        }
        .finalcopylist
        {
            overflow: auto;
            border: 2px;
            border-color: #fff;
            height: 105px;
            width: 150px;
            margin: 30px 0;
        }
        .marginR20 {margin:0 20px 0 0;}
        .marginRL2023 {margin:0 20px 0 23px;}
        .updatePanelall {min-height:350px;}
        .dataTables_wrapper .dataTables_length, .dataTables_wrapper .dataTables_filter, .dataTables_wrapper .dataTables_info, .dataTables_wrapper .dataTables_processing, .dataTables_wrapper .dataTables_paginate 
        {
                color: #fff!important;
        }
        .ui-icon {
            display: inline-block!important;
        }
        #popAssociatedClient .sorting_1 
        {
            text-align:left!important;
        }
        .red
        {
            color:Red;
        }
        
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata" id="divFull">
        <div class="w-100p a-center h-25 marginT5">
            <asp:Label ID="Label6" runat="server" Text="Client Name" />
            <asp:TextBox ID="txtClientName" runat="server" Placeholder="Enter Client name or code"
                Width="227px" CssClass="medium bg-searchimage paddingR10" ToolTip="Enter Client name or code"></asp:TextBox>
            <asp:TextBox ID="txtClientName1" runat="server" Placeholder="Enter Client name" Width="227px"
                CssClass="medium hide" ToolTip="Enter Client name or code"></asp:TextBox>
            <img src="../Images/starbutton.png" id="imgComplaint">
            <img src="../Images/Add.png" alt="ADD Button" id="btnAddNewClient" title="Add new client"
                class="v-middle" />
            <img src="../Images/ExcelImage.GIF" id="ImageBtnExport" alt="ADD Button" title="Click to Dowlaod XL file"
                class="v-middle pull-right" />
            <iframe id="iframeExcel" runat="server" style="display: none;"></iframe>
        </div>
        <div class="w-100p">
            <table id="DatatableBasicClientDetails" style="width: 1200px">
                <thead>
                    <tr>
                        <th>
                            Client Code
                        </th>
                        <th>
                            Payment Category
                        </th>
                        <th>
                            Type
                        </th>
                        <th>
                            Has Parent
                        </th>
                        <th>
                            Discount Mapped
                        </th>
                        <th>
                            Notification
                        </th>
                        <th>
                            Print Location
                        </th>
                        <th>
                            Account Holder
                        </th>
                        <th>
                            Staus
                        </th>
                    </tr>
                </thead>
            </table>
        </div>
        <asp:UpdatePanel ID="UpdatePanel" runat="server">
            <ContentTemplate>
                <div id="TabsMenu" class="TabsMenu">
                    <div id="Fullhtmlpage">
                        <ul id="ulTabsMenu" runat="server">
                        </ul>
                    </div>
                </div>
                <br />
                <asp:UpdatePanel ID="updatePanel21" runat="server">
                    <ContentTemplate>
                    <div class="updatePanelall">
                        <table id="DivtabCMBasic" class="w-100p">
                            <tr class="lh30 hide" id="trCopyDetails">
                                <td>
                                    <asp:Label ID="lblCopyFrom" runat="server" Text="Copy details from" />
                                </td>
                                <td>
                                    <asp:TextBox ID="txtCopyFrom" runat="server" CssClass="medium bg-searchimage paddingR10"></asp:TextBox>
                                </td>
                                <td>
                                    <%--<button id="btnCopy" runat="server" text="Copy" class="btn ">
                                        Copy</button>--%>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="lh30">
                                <td class="a-left w-12p">
                                    <asp:Label ID="lblClientCode" runat="server" Text="Client Code" />
                                </td>
                                <td class="w-21p">
                                    <asp:TextBox ID="txtClientCode" runat="server" CssClass="medium"></asp:TextBox>
                                    <img src="../Images/starbutton.png" id="img4">
                                </td>
                                <td class="w-12p">
                                    <asp:Label ID="lblClientType" runat="server" Text="Client Type" />
                                </td>
                                <td class="w-22p">
                                    <asp:DropDownList ID="ddlClientType" runat="server" class="medium">
                                    </asp:DropDownList>
                                    <img src="../Images/starbutton.png" id="img5">
                                </td>
                                <td class="w-12p">
                                    <asp:Label ID="lblRegistrationType" runat="server" Text="Registration Type" />
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlRegistrationType" runat="server" class="medium">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr class="lh30">
                                <td>
                                    <asp:CheckBox ID="chkHasparent" runat="server" />
                                    <asp:Label ID="lblHasparent" runat="server" Text="Has Parent?"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtHasparent" runat="server" Placeholder="Enter Client name or code"
                                        CssClass="medium bg-searchimage paddingR10" ToolTip="Enter Client name or code"></asp:TextBox>
                                </td>
                                <td colspan="2">
                                    <asp:CheckBox ID="chkCCLabReport" runat="server" />
                                    <asp:Label ID="lblCCLabReport" runat="server" Text="CC Lab Report to Parent Client?"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblSplPrivileges" runat="server" Text="Spl. Privileges" />
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlSplPrivileges" runat="server" class="medium">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr class="lh30">
                                <td>
                                    <button id="btnAssociateClient" text="View Associate Clients">
                                        View Associate Clients</button>
                                </td>
                                <td colspan="5">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="lh30">
                                <td>
                                    <asp:Label ID="lblOrderableLocation" runat="server" Text="Orderable Location" />
                                </td>
                                <td>
                                    <%--<asp:DropDownList ID="ddlOrderableLocation" runat="server" class="medium">
                                    </asp:DropDownList>--%>
                                    <asp:TextBox ID="txtOrderableLocation" CssClass="medium" Placeholder="OrderableLocation" runat="server" /> 
                                    <div runat="server" class="hide" style="min-height: 40px; max-height: 155px; width: 205px; background-color:White; overflow-y: auto; position:absolute;" id="divOrderableLocation"> 
                                        <asp:CheckBoxList ID="chklstOrderableLocation" style="min-height: 40px; max-height: 155px; width: 205px;" runat="server" multiple="true">
                                        </asp:CheckBoxList>
                                    </div>
                                </td>
                                <td>
                                    <asp:Label ID="lblPrintLocation" runat="server" Text="Print Location" />
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlPrintLocation" runat="server" class="medium">
                                    </asp:DropDownList>
                                    <img src="../Images/Add.png" alt="ADD Button" title="Add New" id="btnNewPrinter"
                                        class="v-middle" />
                                </td>
                                <td>
                                    <asp:Label ID="lblNoofPrintCopies" runat="server" Text="No of Print Copies" />
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlNoofPrintCopies" runat="server" class="medium">
                                        <asp:ListItem Text="0">0</asp:ListItem>
                                        <asp:ListItem Text="1">1</asp:ListItem>
                                        <asp:ListItem Text="2">2</asp:ListItem>
                                        <asp:ListItem Text="3">3</asp:ListItem>
                                        <asp:ListItem Text="4">4</asp:ListItem>
                                        <asp:ListItem Text="5">5</asp:ListItem>
                                        <asp:ListItem Text="6">6</asp:ListItem>
                                        <asp:ListItem Text="7">7</asp:ListItem>
                                        <asp:ListItem Text="8">8</asp:ListItem>
                                        <asp:ListItem Text="9">9</asp:ListItem>
                                        <asp:ListItem Text="10">10</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr class="lh30">
                                <td colspan="2">
                                    <asp:CheckBox ID="chkExcludeAutoAuthorization" runat="server" />
                                    <asp:Label ID="lblExcludeAutoAuthorization" runat="server" Text="Exclude Auto Authorization"></asp:Label>
                                </td>
                                <%-- <td>
                                    <asp:Label ID="lblAccountHolder" runat="server" Text="Account Holder" />
                                </td>
                                <td>
                                 
                                    <asp:TextBox ID="txtAccountHolder" runat="server" Placeholder="Enter AccountHolder Name"
                                        CssClass="medium bg-searchimage paddingR10" ToolTip="Enter AccountHolder Name"></asp:TextBox>
                                </td>
                                <td colspan="2">
                                    <asp:CheckBox ID="chkAllowWalkinClients" runat="server" />
                                    <asp:Label ID="lblAllowWalkinClients" runat="server" Text="Allow Walk in Clients"></asp:Label>
                                </td>--%>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <table class="w-100p">
                                        <tr class="lh30">
                                            <td colspan="6">
                                                <asp:Label ID="lblContactDetails" runat="server" class="font12 bold" Text="Contact Details" />
                                            </td>
                                        </tr>
                                        <tr class="lh30">
                                            <td class="a-left w-12p">
                                                <asp:Label ID="lblContactType" runat="server" Text="Contact Type" />
                                            </td>
                                            <td class="a-left w-21p">
                                                <asp:DropDownList ID="ddlContactType" runat="server" class="medium">
                                                </asp:DropDownList>
                                            </td>
                                            <td class="a-left w-12p">
                                                <asp:Label ID="lblSPOCName" runat="server" Text="SPOC Name" />
                                            </td>
                                            <td class="a-left w-22p">
                                                <asp:TextBox ID="txtSPOCName" runat="server" class="medium bg-searchimage paddingR10 ui-autocomplete-input"></asp:TextBox>
                                            </td>
                                            <td class="a-left w-12p">
                                                <asp:Label ID="lblMobileNo" runat="server" Text="Mobile No" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtMobileNo" runat="server" MaxLength="10" CssClass="medium"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr class="lh30">
                                            <td>
                                                <asp:Label ID="lblLandlineNo" runat="server" Text="Landline No" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtLandlineNo" runat="server" MaxLength="10" CssClass="medium"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblEmailId" runat="server" Text="Email ID" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtEmailId" runat="server" CssClass="medium"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblFaxNo" runat="server" Text="Fax No" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtFaxNo" runat="server" CssClass="medium"></asp:TextBox>
                                                <%--<asp:CheckBox ID="ChkIsPrimary" runat="server" />
                                                <asp:Label ID="lblPrimary" runat="server" Text="Primary"></asp:Label>--%>
                                                <img src="../Images/Add.png" alt="ADD Button" title="Add new client" id="btnAddContactDetails"
                                                    class="v-middle" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6">
                                                <div class="dynamicgrid a-auto">
                                                    <table id="tblContactDetails" class="w-100p gridView">
                                                        <thead id="tblContactDetailsthead">
                                                            <tr class="gridHeader">
                                                                <th>
                                                                    <asp:Label ID="lblCType" runat="server" Text="Type" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblCName" runat="server" Text="Name" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblCMobileNumber" runat="server" Text="MobileNumber" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblCLandlineNo" runat="server" Text="Landline No" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblCEmailID" runat="server" Text="Email ID" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblCFaxNo" runat="server" Text="Fax No" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblAddressID" runat="server" Text="Address ID" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="Label1" runat="server" Text="ContactTypeId" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="Label217" runat="server" Text="Action" />
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table class="w-100p hide" id="DivtabCMCommunication">
                            <tr class="lh30">
                                <td class="w-10p">
                                    <asp:Label ID="lblLocation" runat="server" Text="Location" />
                                </td>
                                <td>
                                    <asp:TextBox ID="txtLocation" runat="server" CssClass="small bg-searchimage paddingR10"></asp:TextBox>
                                </td>
                                <td class="w-8p">
                                    <asp:Label ID="lblHub" runat="server" Text="Hub" />
                                </td>
                                <td>
                                    <asp:TextBox ID="txtHub" runat="server" CssClass="small bg-searchimage paddingR10"></asp:TextBox>
                                </td>
                                <td class="w-8p">
                                    <asp:Label ID="lblZone" runat="server" Text="Zone" />
                                </td>
                                <td>
                                    <asp:TextBox ID="txtZone" runat="server" CssClass="small bg-searchimage paddingR10"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblRoute" runat="server" Text="Route" />
                                </td>
                                <td class="w-8p">
                                    <asp:TextBox ID="txtRoute" runat="server" CssClass="small bg-searchimage paddingR10"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblTransitTime" runat="server" Text="Transit Time" />
                                </td>
                                <td>
                                    <asp:TextBox ID="txtTransitTime" runat="server" MaxLength="2" CssClass="w-46 v-top"></asp:TextBox>
                                     <asp:DropDownList runat="server" ID="ddlTransitTime" class="w-100 h-21">
                                        <asp:ListItem Text="value">Value</asp:ListItem>
                                        <asp:ListItem Text="value1">Value1</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                              
                                <td colspan="6">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="8">
                                    <table class="w-100p">
                                        <tr class="lh30">
                                            <td colspan="6">
                                                <asp:Label ID="lblShippingDetails" runat="server" class="font12 bold" Text="Shipping Details" />
                                            </td>
                                        </tr>
                                        <tr class="lh30">
                                            <td class="a-left">
                                                <asp:Label ID="lblAddressType" runat="server" Text="Address Type" />
                                            </td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlAddressType" class="medium">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblZipCode" runat="server" Text="Zip Code" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtZipCode" runat="server" CssClass="medium"></asp:TextBox>
                                                <%--bg-searchimage paddingR10--%>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblArea" runat="server" Text="Area" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtArea" runat="server" CssClass="medium"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr class="lh30">
                                            <td>
                                                <asp:Label ID="lblCountry" runat="server" Text="Country" />
                                            </td>
                                            <td>
                                                <%--<asp:TextBox ID="txtCountry" runat="server" CssClass="medium "></asp:TextBox>--%>
                                                <asp:DropDownList ID="ddlCountry" runat="server" class="medium">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblState" runat="server" Text="State" />
                                            </td>
                                            <td>
                                                <%--<asp:TextBox ID="txtState" runat="server" CssClass="medium "></asp:TextBox>--%>
                                                <asp:DropDownList ID="ddlState" runat="server" class="medium">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblCity" runat="server" Text="City" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtCity" runat="server" CssClass="medium "></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr class="lh30">
                                            <td>
                                                <asp:Label ID="lblAddressline1" runat="server" Text="Address Line 1" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAddressLine1" runat="server" CssClass="medium "></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblAddressline2" runat="server" Text="Address Line 2" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAddressLine2" runat="server" CssClass="medium "></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label2" runat="server" Text="Contact No" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtContactNo" runat="server" MaxLength="10" CssClass="medium "></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr class="lh30">
                                            <td>
                                                <asp:Label ID="Label3" runat="server" Text="Land Line Number" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtLandlineNo1" runat="server" MaxLength="11" CssClass="medium "></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label4" runat="server" Text="Email Id" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtEmailId1" runat="server" CssClass="medium "></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="chkPrimary1" CssClass="margin0" runat="server" />
                                                <asp:Label ID="lblPrimary1" runat="server" Text="Active"></asp:Label>
                                            </td>
                                            <td>
                                                <img src="../Images/Add.png" alt="ADD Button" title="Add new Shipping" id="btnAddShippingDetails"
                                                    class="v-middle">
                                                <%--<img src="../Images/Add.png" alt="ADD Button" title="Add New Item" class="v-middle" />--%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6">
                                                <div class="dynamicgrid a-auto">
                                                    <table id="tblShippingDetails" class="w-100p gridView">
                                                        <thead>
                                                            <tr class="gridHeader">
                                                                <th>
                                                                    <asp:Label ID="Label168" runat="server" Text="Address Type" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="Label169" runat="server" Text="Zip Code" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="Label170" runat="server" Text="Area" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="Label171" runat="server" Text="City" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="Label172" runat="server" Text="State" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="Label173" runat="server" Text="Country" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="Label174" runat="server" Text="Address Line 1" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="Label175" runat="server" Text="Address Line 2" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="Label7" runat="server" Text="Contact No" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="Label12" runat="server" Text="Land Line Number" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="Label13" runat="server" Text="Email Id" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="Label176" runat="server" Text="Active" />
                                                                </th>
                                                                
                                                                <th>
                                                                    <asp:Label ID="lblAction2" runat="server" Text="Action" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="Label14" runat="server" Text="AddressID" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="Label23" runat="server" Text="Address TypeID" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="Label25" runat="server" Text="CountryID" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="Label26" runat="server" Text="StateID" />
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table class="w-100p hide" id="DivtabCMNotification">
                            <tr class="lh30">
                                <td colspan="8">
                                    <asp:Panel ID="pnlNotify" CssClass="borderGrey w-96p" Style="margin: 8px auto;" runat="server">
                                        
                                        <asp:CheckBoxList ID="chkNotification" RepeatColumns="6" runat="server" RepeatDirection="Horizontal" />
                                        <div id="divReportPrintDate" class="hide" runat="server">
                                        <asp:Label ID="lblrptdt" Text="  Report Print From" runat="server" />
                                        <asp:TextBox ID="txtReportPrintDate" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtFromResource1"></asp:TextBox>
                                        <img src="../Images/starbutton.png" id="imgReportPrintDt">
                                        </div>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr class="lh30">
                                <td>
                                    <asp:Label ID="lblNotifications" runat="server" Text="Notifications" />
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlNotifications" class="small">
                                    </asp:DropDownList>
                                </td>
                                <td class="w-12p">
                                    <asp:Label ID="lblcommunicationmode" runat="server" Text="Communication Mode" />
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlCommunicationMode" class="small">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="lblDetails" runat="server" Text="Communication Details" />
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlmobile" CssClass="hide">
                                        <asp:ListItem Text="91">91</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtmobilenumber" runat="server" CssClass="small  paddingR10"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:CheckBox ID="chkactive" Checked="false" runat="server" />
                                    <asp:Label ID="lblBlocked" Text="IsBlocked" Style="width: 94px;" runat="server" />
                                    <img src="../Images/Add.png" alt="ADD Button" title="Add new client" id="btnAddNotification"
                                        class="v-middle" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="8">
                                    <div class="dynamicgrid">
                                        <table id="tblNotificationDetails" class="w-100p gridView">
                                            <thead>
                                                <tr class="gridHeader">
                                                    <th>
                                                        <asp:Label ID="Label15" runat="server" Text="Notifications" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblComMode" runat="server" Text="CommunicationMode" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label16" runat="server" Text="Details" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label17" runat="server" Text="IsBlocked" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label18" runat="server" Text="Action" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label27" runat="server" Text="NotiText" />
                                                    </th>
                                                </tr>
                                            </thead>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <table id="DivtabCMReport" class="w-100p " style="display: none;">
                            <tr class="lh30">
                                <td colspan="6">
                                    <asp:Label ID="lblReportAttributes" runat="server" class="font12 bold" Text="Report Attributes" />
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right w-16p paddingR10">
                                    <asp:Label ID="lblDescription" runat="server" Text="Invoice Report Format" />
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlDescription" class="medium">
                                    </asp:DropDownList>
                                </td>
                                <td class="a-right w-16p paddingR10">
                                    <asp:Label ID="lblCategory" runat="server" Text="Stationery Type" />
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlStationery" class="medium">
                                    </asp:DropDownList>
                                </td>
                        </table>
                        <table id="DivtabCMCommercial" class="w-100p " style="display: none;">
                            <tr>
                                <td colspan="7">
                                    <table class="w-100p">
                                        <tr class="lh30">
                                            <td colspan="6">
                                                <asp:Label ID="lblTaxDetail" runat="server" class="font12 bold" Text="Tax Details" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="w-5p">
                                                <asp:Label ID="lblTaxDetails" runat="server" Text="TaxDetails" />
                                            </td>
                                            <td class="w-5p">
                                                <asp:DropDownList ID="ddlTaxDetails" runat="server" class="medium">
                                                </asp:DropDownList>
                                            </td>
                                            <td class="w-5p">
                                                <asp:Label ID="lblSequence" runat="server" Text="Sequence" />
                                            </td>
                                            <td colspan="2" class="w-23p">
                                                <asp:TextBox ID="txtSequence" runat="server" CssClass="medium"></asp:TextBox>
                                            </td>
                                            <td class="w-5p">
                                                <asp:CheckBox ID="chkIsActive" CssClass="w-100" Checked="false" runat="server" Text="Active" />
                                                <img id="btnAddTaxDetails" alt="ADD Button" class="v-middle" src="../Images/Add.png"
                                                    title="Add this Tax" />
                                            </td>
                                        </tr>
                                        <tr id="trTax">
                                            <td colspan="6">
                                                <div class="dynamicgrid o-auto">
                                                    <table id="tblTaxDetails" class="w-100p gridView display">
                                                        <thead>
                                                            <tr class="gridHeader">
                                                                <th>
                                                                    <asp:Label ID="Label19" runat="server" Text="TaxID" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblTaxDe" runat="server" Text="Tax Details" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="Label21" runat="server" Text="Sequence" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblact" runat="server" Text="Active" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="Label22" runat="server" Text="Action" />
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                                <tr class="lh30">
                                
                                    <td colspan="7">
                                        <asp:Label ID="lblDiscountAndTax" runat="server" class="font12 bold" Text="Discount Details" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="w-5p">
                                        <asp:Label ID="lblType1" runat="server" Text="Type" />
                                    </td>
                                    <td class="w-5p">
                                        <asp:DropDownList ID="ddlType" runat="server" class="medium" TabIndex="69">
                                        </asp:DropDownList>
                                    </td>
                                    <td class="w-5p">
                                        <asp:Label ID="lblPolicy" runat="server" Text="Policy" />
                                    </td>
                                    <td class="w-10p">
                                        <asp:TextBox ID="txtPolicy" runat="server" CssClass="medium bg-searchimage paddingR10"
                                            Placeholder="Enter Policy name or code" ToolTip="Enter Policy name or code"></asp:TextBox>
                                    </td>
                                    <td class="w-10p" colspan="2">
                                        <asp:Label ID="lblFrom" runat="server" Text="From" />
                                        <asp:TextBox ID="txtFrom" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtFromResource1"></asp:TextBox>
                                        <asp:Label ID="lblTo" runat="server" Text="To" />
                                        <asp:TextBox ID="txtTo" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtToResource1"></asp:TextBox>
                                    </td>
                                    <td class="w-5p">
                                        <asp:CheckBox ID="chkPolicyIsActive" runat="server" Text="IsActive" CssClass="w-100"/>
                                        <%--<asp:Label Text="IsActive" CssClass="w-100" runat="server" ID="lblPActive" />--%>
                                        <img id="btnAddPolicy" alt="ADD Button" class="v-middle" src="../Images/Add.png"
                                            title="Add this Discount" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="7">
                                        <div class="dynamicgrid o-auto">
                                            <table id="tblCommercialDetails" class="w-100p gridView display" cellspacing="0"
                                                width="100%">
                                                <thead>
                                                    <tr class="gridHeader">
                                                        <th>
                                                            <asp:Label ID="Label83" runat="server" Text="Category" />
                                                        </th>
                                                        <th>
                                                            <asp:Label ID="Label84" runat="server" Text="Policy" />
                                                        </th>
                                                        <th>
                                                            <asp:Label ID="lblpolicyId" runat="server" Text="PolicyID" />
                                                        </th>
                                                        <th>
                                                            <asp:Label ID="Label85" runat="server" Text="FromDate" />
                                                        </th>
                                                        <th>
                                                            <asp:Label ID="Label86" runat="server" Text="ToDate" />
                                                        </th>
                                                        <th>
                                                            <asp:Label ID="Label20" runat="server" Text="IsActive" />
                                                        </th>
                                                        <th>
                                                            <asp:Label ID="Label24" runat="server" Text="CategoryID" />
                                                        </th>
                                                        <th>
                                                            <asp:Label ID="Label87" runat="server" Text="Action" />
                                                        </th>
                                                    </tr>
                                                </thead>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            
                        </table>
                        <table id="DivtabCMCredit" class="w-100p " style="display: none;">
                            <tr>
                                <td>
                                    <table class="w-100p">
                                        <tr class="lh30">
                                            <td colspan="6">
                                                <asp:Label ID="lblCommericalAttributes" runat="server" class="font12 bold" Text="Commerical Attributes" />
                                            </td>
                                        </tr>
                                        <tr class="lh25">
                                            <td>
                                                <asp:Label ID="lblBusinessType" runat="server" Text="Business Type" />
                                            </td>
                                            <td>
                                                <%--  <asp:TextBox ID="txtBusinessType" runat="server"  CssClass="medium"></asp:TextBox>--%>
                                                <asp:DropDownList runat="server" ID="ddlBusinessType" TabIndex="69" class="medium">
                                                </asp:DropDownList>
                                                <img src="../Images/starbutton.png" id="img6">
                                            </td>
                                            <td>
                                                <asp:Label ID="lblCSTNo" runat="server" Text="CST No" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtCSTNo" runat="server" CssClass="medium"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblServiceTaxNo" runat="server" Text="Service Tax No" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtServiceTaxNo" runat="server" CssClass="medium"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr class="lh25">
                                            <td>
                                                <asp:Label ID="lblPanNo" runat="server" Text="PAN No" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPanNo" runat="server" CssClass="medium"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblSAPCode" runat="server" Text="SAP Code" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSAPCode" runat="server" CssClass="medium"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblCurrencyType" runat="server" Text="Currency Type" />
                                            </td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlCurrencyType" TabIndex="69" class="medium">
                                                </asp:DropDownList>
                                                <img src="../Images/starbutton.png" id="img7">
                                            </td>
                                        </tr>
                                        <tr class="lh25">
                                            <td>
                                                <asp:Label ID="lblPaymentCategory" runat="server" Text="Payment Category" />
                                            </td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlPaymentCategory" TabIndex="69" class="medium">
                                                </asp:DropDownList>
                                                <img src="../Images/starbutton.png" id="img8">
                                            </td>
                                            <td colspan="2">
                                                <asp:CheckBox ID="chkAllowServiceMapping" CssClass="ChkAlign" runat="server" />
                                                <asp:Label ID="lblAllowServiceMapping" runat="server" Text="Allow Service Mapping"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblInvoiceCycle" runat="server" Text="Invoice Cycle" />
                                            </td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlInvoiceCycle" TabIndex="69" class="medium">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr class="lh35">
                                            <td colspan="2">
                                                <asp:CheckBox ID="chkCouponSystem" CssClass="ChkAlign" runat="server" />
                                                <asp:Label ID="lblCouponSystem" runat="server" Text="Coupon System"></asp:Label>
                                            </td>
                                            <td colspan="2">
                                                <asp:CheckBox ID="chkInvoiceApprovalRequired" CssClass="ChkAlign" runat="server" />
                                                <asp:Label ID="lblInvoiceApprovalRequired" runat="server" Text="Invoice Approval Required"></asp:Label>
                                            </td>
                                            <td colspan="2">
                                                <asp:CheckBox ID="chkAllowBillingDiscount" CssClass="ChkAlign" runat="server" />
                                                <asp:Label ID="lblAllowBillingDiscount" runat="server" Text="Allow Billing Discount"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="w-100p">
                                        <tr class="lh30">
                                            <td colspan="6">
                                                <asp:Label ID="lblClientStatus1" runat="server" class="font12 bold" Text="Client Status" />
                                            </td>
                                        </tr>
                                        <tr class="lh30">
                                            <td>
                                                <asp:Label ID="lblClientStatus" runat="server" Text="Client Status" />
                                            </td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlClientStatus" TabIndex="69" class="small">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblReason" runat="server" Text="Reason" />
                                            </td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlReason" TabIndex="69" class="small">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblAction" runat="server" Text="Action" />
                                            </td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlAction" TabIndex="69" class="small">
                                                </asp:DropDownList>
                                            </td>
                                            <td colspan="2" id="tdHideDate">
                                                <asp:Label ID="lblFromDate" CssClass="marginR20" runat="server" Text="From" />
                                                <asp:TextBox ID="txtFromDate" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                                <asp:Label ID="lblToDate" CssClass="marginRL2023" runat="server" Text="To" />
                                                <asp:TextBox ID="txtToDate" CssClass="Txtboxsmall"  runat="server" meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr class="lh30">
                                            <td>
                                                <asp:Label ID="lblCreditLimit" runat="server" Text="Credit Limit" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtCreditLimit" runat="server" CssClass="small"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblCreditDays" runat="server" Text="Credit Days" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtCreditDays" runat="server" CssClass="small"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblGraceLimit" runat="server" Text="Grace Limit" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtGraceLimit" runat="server" CssClass="small"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblGraceDays" runat="server" Text="Grace Days" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtGraceDays" runat="server" CssClass="small"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="trClientDeposit">
                                <td>
                                    <table class="w-100p">
                                        <tr class="lh30">
                                            <td colspan="6">
                                                <asp:Label ID="lblClientDeposit" runat="server" class="font12 bold" Text="Client Deposit" />
                                            </td>
                                        </tr>
                                        <tr class="lh30">
                                            <td>
                                                <asp:Label ID="lblAdvanceThreshold" runat="server" Text="Advance Threshold" />
                                            </td>
                                            <td>
                                                <%--<asp:TextBox ID="txtAdvanceThreshold" runat="server" CssClass="medium"></asp:TextBox>--%>
                                                <asp:DropDownList runat="server" ID="ddlAdvanceThreshold" TabIndex="69" class="small">
                                                <asp:ListItem Value='0' Text='--Select--' />
                                                <asp:ListItem Value='Value' Text='Value' />
                                                <asp:ListItem Value='Percentage' Text='Percentage' />                                                
                                                </asp:DropDownList>
                                                <img src="../Images/starbutton.png" id="img9">
                                            </td>
                                            <td>
                                                <asp:Label ID="lblValue" runat="server" Text="Value" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtValue" runat="server" CssClass="medium"></asp:TextBox>
                                                <img src="../Images/starbutton.png" id="img10">
                                            </td>
                                            <td>
                                                <asp:Label ID="lblMinimumDeposite" runat="server" Text="Minimum Deposit" />
                                                <img src="../Images/starbutton.png" id="img11">
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtMinimumDeposite" runat="server" CssClass="medium"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table id="DivtabCMAttributes" class="w-100p " style="display: none;">
                            <tr class="lh30">
                                <td colspan="6">
                                    <asp:Label ID="lblClientAttributes" runat="server" class="font12 bold" Text="Client Attributes" />
                                </td>
                            </tr>
                            <tr class="lh25">
                                <td class="w-8p">
                                    <asp:Label ID="lblAttributes" runat="server" Text="Attributes" />
                                </td>
                                <td>
                                    <asp:TextBox ID="txtAttributes" runat="server" Placeholder="Attributes Type" CssClass="medium"></asp:TextBox>
                                    <img src="../Images/starbutton.png" id="img2">
                                </td>
                                <td>
                                    <asp:Label ID="lblAttributesValue" runat="server" Text="Enter Attribute Value" />
                                </td>
                                <td>
                                    <asp:TextBox ID="txtAttributesValue" runat="server" Placeholder="Search" MaxLength="10" CssClass="medium"></asp:TextBox>
                                    <img src="../Images/starbutton.png" id="img1">
                                </td>
                                <td>
                                    <asp:Label ID="lblAttributesType" runat="server" Text="Select Attribute Type" />
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlAttributesType" TabIndex="69" class="medium">
                                        <asp:ListItem Text="value">Value</asp:ListItem>
                                        <asp:ListItem Text="value1">Value1</asp:ListItem>
                                    </asp:DropDownList>
                                    <img src="../Images/starbutton.png" id="img3">
                                    &nbsp;
                                    <img src="../Images/Add.png" alt="ADD Button" title="Add new client" id="AddAttribute" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <div class="dynamicgrid a-auto">
                                        <table id="tblAttributesDetails" class="w-100p gridView display">
                                            <thead>
                                                <tr class="gridHeader">
                                                    <th>
                                                        <asp:Label ID="Label71" runat="server" Text="Attribute" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label72" runat="server" Text="Value" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label208" runat="server" Text="Type" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label73" runat="server" Text="Action" />
                                                    </th>
                                                </tr>
                                            </thead>
                                        </table>
                                    </div>
                                </td>
                                <input type="hidden" id="hdnClientAttributes" runat="server" />
                            </tr>
                        </table>
                        <table id="DivtabCMDocuments" class="w-100p " style="display: none;">
                            <tr class="lh30">
                                <td colspan="8">
                                    <asp:Label ID="lblAttachDocuments" runat="server" class="font12 bold" Text="Attach Documents" />
                                </td>
                            </tr>
                            <tr class="lh30">
                                <td class="w-9p">
                                    <asp:Label ID="lblFileName" runat="server" Text="File Name" />
                                </td>
                                <td class="w-14p">
                                    <asp:TextBox ID="txtFileName" runat="server" CssClass="small"></asp:TextBox>
                                </td>
                                <td class="w-7p">
                                    <asp:Label ID="lblDate" runat="server" Text="Date" />
                                </td>
                                <td class="w-14p">
                                    <asp:TextBox ID="txtDate" CssClass="small" runat="server" meta:resourcekey="txtDateResource1"></asp:TextBox>
                                </td>
                                <td class="w-7p">
                                    <asp:Label ID="lblType" runat="server" Text="Type" />
                                </td>
                                <td class="w-12p">
                                    <asp:TextBox ID="txtType" runat="server" CssClass="smaller"></asp:TextBox>
                                </td>
                                <td width="285px;">
                                    <asp:FileUpload ID="FileUpload" runat="server" CssClass="btn" ToolTip="Browse" />
                                </td><td>    
                                    <img src="../Images/Add.png" alt="ADD Button" class="ClsAdd" title="Add new client" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblTermAndConditions" runat="server" Text="Terms & Conditions" />
                                </td>
                                <td colspan="4">
                                    <asp:TextBox ID="txtTermAndConditions" runat="server" Placeholder="Search" CssClass="w-500 h-100 o-auto"
                                        TextMode="MultiLine"></asp:TextBox>
                                </td>
                                <td colspan="3" class="a-left v-top">
                                    <asp:ListBox ID="ListFiles" runat="server" CssClass="w-50p h-100" Style="display: none;" />
                                    <asp:ListBox ID="ListDoc" runat="server" CssClass="w-50p h-100" Style="display: none;" />
                                    <div id="divFiles" class="finalcopylist borderGrey bg-white marginL5 w-70p">
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <iframe id="iframe" style="display: none;"></iframe>
                        <%-- <table id="DivtabCMAudit" class="w-100p " style="display: none;">
                            <tr class="lh30">
                                <td>
                                    <asp:Label ID="Label26" runat="server" class="font12 bold" Text="Audit Histroy" />
                                </td>
                                <td class="a-right">
                                    <asp:TextBox ID="TextBox1" runat="server" Placeholder="Search" Width="227px" CssClass="small bg-searchimage paddingR10"
                                        ToolTip="Search"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div class="w-100p h-350 o-auto">
                                        <table class="w-100p gridView">
                                            <tr class="gridHeader">
                                                <th>
                                                    <asp:Label ID="Label27" runat="server" Text="Client Name" />
                                                </th>
                                                <th>
                                                    <asp:Label ID="Label28" runat="server" Text="Client Name" />
                                                </th>
                                                <th>
                                                    <asp:Label ID="Label29" runat="server" Text="Client Name" />
                                                </th>
                                                <th>
                                                    <asp:Label ID="Label30" runat="server" Text="Client Name" />
                                                </th>
                                                <th>
                                                    <asp:Label ID="Label31" runat="server" Text="Client Name" />
                                                </th>
                                                <th>
                                                    <asp:Label ID="Label32" runat="server" Text="Client Name" />
                                                </th>
                                                <th>
                                                    <asp:Label ID="Label33" runat="server" Text="Client Name" />
                                                </th>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label36" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label37" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label38" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label39" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label40" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label41" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label42" runat="server" Text="value1" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label34" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label35" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label43" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label44" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label45" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label46" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label47" runat="server" Text="value1" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label48" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label49" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label50" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label51" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label52" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label53" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label54" runat="server" Text="value1" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label55" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label56" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label57" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label58" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label59" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label60" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label61" runat="server" Text="value1" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label62" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label63" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label64" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label65" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label66" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label67" runat="server" Text="value1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label68" runat="server" Text="value1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>--%>
                      </div>
                        <table class="w-100p">
                            
                            <tr class="lh35">
                                
                                <td class="w-15p a-center">
                                     <button id="btnCancel" runat="server" onclick="return Cancel();" text="Cancel" class="btn">
                                        Cancel</button>
                                </td>
                                 <td class="w-20p">
                                    <asp:Label ID="lblReasonforAmend" runat="server" Text="Reason for Amendment" />
                                </td>
                                <td class="w-20p">
                                     <asp:DropDownList runat="server" ID="ddlReasonForSave" TabIndex="69" class="small">
                                    </asp:DropDownList>
                                </td>
                                <td class="w-15p">
                                    <asp:Label ID="Label207" runat="server" Text="Next Action" />
                                </td>
                                <td class="w-20p">
                                    <asp:DropDownList runat="server" ID="ddlNextAction" TabIndex="69" class="small">
                                        <asp:ListItem Value="0" Text="--Select--" />
                                        <asp:ListItem Value="1" Text="Save And Map Rate Card" />
                                        <asp:ListItem Value="2" Text="Save And Service Client Mapping" />
                                    </asp:DropDownList>
                                </td>
                                <td class="a-left">
                                    <asp:Button ID="btnFinalSave" runat="server" class="btn" Text="Save" />
                                    
                                </td>
                            </tr>
                           
                        </table>
                        <div id="Div2" class="hide" style="top: 0px; left: 0px; position: fixed; height: 1000px;
                            width: 100%; z-index: 99; opacity: 0.8; background: rgb(193, 193, 193);">
                        </div>
                        <div id="Backgrd_hide" class="hide" style="top: 0px; left: 0px; position: fixed;
                            height: 1000px; width: 100%; z-index: 99; opacity: 0.8; background: rgb(193, 193, 193);">
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="w-60p borderGrey a-center  popup_box popAssociatedClient" style="margin-top: 20px;
            width: 650px; left: 350px; top: 80px; background-color: white;" id="popAssociatedClient">
             <a class="pull-right btn" href="#" id="Closeclick">X</a>
            <table id="AssociateClientdatatable">
                <thead>
                    <tr>
                        <th>
                            Client Code
                        </th>
                        <th>
                            Client Name
                        </th>
                    </tr>
                </thead>
            </table>
           
        </div>
        <div class="w-60p borderGrey a-center  popup_box popAssociatedClient" style="margin-top: 20px;
            width: 650px; left: 350px; top: 80px; background-color: white;" id="popNewPrinter"
            runat="server">
            <a class="pull-right btn" href="#" id="Closeclick1">X</a>
            <asp:Panel ID="pnlAddLocation" runat="server" Style="height: 350px; width: 600px;"
                CssClass="modalPopup dataheaderPopup">
                <table align="center" style="padding: 5px; padding-top: 10px;">
                    <tr style="display: none">
                        <td>
                            <asp:Label ID="lblCode" runat="server" Text="Code"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCode" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblPrinterName" runat="server" Text="PrinterName"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPrinterName" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <button id="btnAddLocation" class="btn" runat="server">
                                Save</button>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <br />
                            <div id="divLocationPrinter" runat="server" style="height: 250px; width: 595px; overflow: auto">
                                <table id="tblLocationPrinter" class="w-100p gridView">
                                    <thead>
                                        <tr class="gridHeader">
                                            <th>
                                                <asp:Label ID="Label5" runat="server" Text="SNO" />
                                            </th>
                                            <th>
                                                <asp:Label ID="Label8" runat="server" Text="PrinterName" />
                                            </th>
                                            <th style="display: none">
                                                <asp:Label ID="Label9" runat="server" Text="Code" />
                                            </th>
                                            <th style="display: none">
                                                <asp:Label ID="Label10" runat="server" Text="OrgAddressID" />
                                            </th>
                                            <th>
                                                <asp:Label ID="Label11" runat="server" Text="Action" />
                                            </th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            
        </div>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <input type="hidden" id="hdnIsCtParentOrg" runat="server" />
    <input type="hidden" id="hdnClientTypeID" runat="server" />
    <input type="hidden" id="hdnGetParentID" runat="server" />
    <input type="hidden" id="hdnAddDepart" runat="server" value="" />
    <input type="hidden" id="hdnLocation" runat="server" value="0" />
    <input type="hidden" id="hdnRouteID" runat="server" value="0" />
    <input type="hidden" id="hdnZoneID" runat="server" value="0" />
    <input type="hidden" id="hdnHubID" runat="server" value="0" />
    <input type="hidden" id="hdnOrgAddressID" runat="server" value="" />
    <input type="hidden" id="hdnContactDetails" runat="server" />
    <input type="hidden" id="hdnNotificationDetails" runat="server" />
    <input type="hidden" id="hdnlstStationery" runat="server" value="" />
    <input type="hidden" id="hdnShippingDetails" runat="server" value="" />
    <input type="hidden" id="hdnShippingAddID" runat="server" value="0" />
    <input type="hidden" id="hdnBasicTab" runat="server" value="" />
    <input type="hidden" id="hdnReadOnlyTab" runat="server" value="" />
    <input type="hidden" id="hdnTaxDetails" runat="server" value="" />
    <input type="hidden" id="hdnDiscountDetails" runat="server" value="" />
    <input type="hidden" id="hdnClientCode" runat="server" value="0" />
    <input type="hidden" id="hdnClientName" runat="server" value="0" />
    <input type="hidden" id="hdnClientID" runat="server" value="0" />
    <input type="hidden" id="hdnLocationID" runat="server" value="0" />
    <input type="hidden" id="hdnParentClientID" runat="server" value="0" />
    <input type="hidden" id="hdnPolicyID" runat="server" value="" />
    <input type="hidden" id="hdnTabAccessdetails" runat="server" value="" />
    <input type="hidden" id="hdnDiscountTypeID" runat="server" value="0" />
    <input type="hidden" id="hdnDiscountconfigVal" runat="server" value="" />
    <input type="hidden" id="hdnStateID" runat="server" value="0" />
    <input type="hidden" id="hdnbaseCurrencyID" runat="server" value="0" />
    </form>
</body>
<link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

<script type="text/javascript">
    $(function() {

        $("#txtReportPrintDate").datepicker({
            changeMonth: true,
            changeYear: true,
            minDate: 0,
            yearRange: '2015:2030',
            dateFormat: 'dd/mm/yy'
        });
        $("#txtDate").datepicker({
            changeMonth: true,
            changeYear: true,
            minDate: 0,
            yearRange: '2015:2030',
            dateFormat: 'dd/mm/yy'
        });
        $("#txtFromDate").datepicker({
            changeMonth: true,
            changeYear: true,
            minDate: 0,
            yearRange: '2015:2030',
            dateFormat: 'dd/mm/yy'
        });
        $("#txtToDate").datepicker({
            changeMonth: true,
            changeYear: true,
            minDate: 0,
            yearRange: '2015:2030',
            dateFormat: 'dd/mm/yy'
        });
        $("#txtFrom").datepicker({
            changeMonth: true,
            changeYear: true,
            minDate: 0,
            yearRange: '2015:2030',
            dateFormat: 'dd/mm/yy'
        });
        $("#txtTo").datepicker({
            changeMonth: true,
            changeYear: true,
            minDate: 0,
            yearRange: '2015:2030',
            dateFormat: 'dd/mm/yy'
        });
    });
    $(function() {
        var DefaultTabID = $('#hdnBasicTab').val();
        $('[id^="DivtabCM"]').hide();
        $('#' + DefaultTabID).addClass('active');
        $('#Div' + DefaultTabID).show();

        var ReadOnly = $('#hdnReadOnlyTab').val();
        var sReadOnly = ReadOnly.split('~');
        for (var i = 0; i < sReadOnly.length - 1; i++) {
            var PnlName = 'Div' + sReadOnly[i];
            $('#' + PnlName).find("input,button,textarea,select").attr("disabled", "disabled");
        }
    });
    function ShowTabContent(tabId) {
        $('#TabsMenu li').removeClass('active');
        $('#' + tabId).addClass('active');
        $('[id^="DivtabCM"]').hide();
        $('#Div' + tabId).show();
        if ($('#tabCMDocuments').hasClass('active')) {
            $("#FileUpload").show();
        }
        else {
            $("#FileUpload").hide();
        }
    }
    // DateTime Method
    function JSONDateWithTime(dateStr) {
        jsonDate = dateStr;
        var d = new Date(parseInt(jsonDate.substr(6)));
        var m, day;
        m = d.getMonth() + 1;
        if (m < 10)
            m = '0' + m
        if (d.getDate() < 10)
            day = '0' + d.getDate()
        else
            day = d.getDate();
        var formattedDate = day + "/" + m + "/" + d.getFullYear();
        var hours = (d.getHours() < 10) ? "0" + d.getHours() : d.getHours();
        var minutes = (d.getMinutes() < 10) ? "0" + d.getMinutes() : d.getMinutes();
        var formattedTime = hours + ":" + minutes + ":" + d.getSeconds();
        formattedDate = formattedDate;  //+ " " + formattedTime;
        return formattedDate;
    }
    function ReportPrintChanged(ID) {
        $('#txtReportPrintDate').val('');
        if ($('#' + ID).is(':checked'))
            $('#divReportPrintDate').show();
        else
            $('#divReportPrintDate').hide();
    }
    
</script>

<script src="../Scripts/test/XMLWriter.js" type="text/javascript"></script>

<link href="../Scripts/test/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />

<script src="../Scripts/test/jquery.dataTables.min.js" type="text/javascript"></script>

<link href="../Scripts/CustomAlerts/jquery.alerts.css" rel="stylesheet" type="text/css" />

<script src="../Scripts/CustomAlerts/jquery.alerts.js" type="text/javascript"></script>

<script src="../Scripts/test/grid.locale-en.js" type="text/javascript"></script>

<script src="../Scripts/test/jquery.jqGrid.min.js" type="text/javascript"></script>

<link href="../Scripts/test/ui.jqgrid.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">

    var OrgId = '<%=OrgID%>';
    var ILocationID = '<%=ILocationID%>';
    var IstxtCopyFrom = 'N';
    var IsNewClient = 'N';

    var btnUpdateConatctDetails = false;
    var UpdateConatctDetailsID = '';

    var btnUpdateReportDetails = false;
    var UpdateReportDetailsID = '';

    var btnUpdateAttributesDetails = false;
    var UpdateAttributesDetailsID = '';

    var btnUpdateCommercialDetails = false;
    var UpdateCommercialDetailsID = '';

    var btnUpdateShippingDetails = false;
    var UpdateShippingDetailsID = '';

    var btnUpdateCommercialTaxDetails = false;
    var UpdateCommercialTaxDetailsID = '';

    var btnUpdateNotificationDetails = false;
    var UpdateNotificationDetailsID = '';

    var IsExists = 'N';

    $(document).ready(function() {
        var CltID = '<%= Request.QueryString["ClientID"] %>';
        var CltCode = '<%= Request.QueryString["ClientCode"] %>';
        var CltName = '<%= Request.QueryString["ClientName"] %>';
        if (CltID != "" && CltCode != "" && CltName != "") {
            var str = CltCode + ' : ' + CltName;
            $("#txtClientName").val(str);
            GetClientMasterDetails(CltID, CltName, CltCode);
        }
        LoadState();
        $('#trTax').hide();
        $('#trClientDeposit').hide();
        $('#tdHideDate').hide();
        $('#txtHasparent').prop('disabled', 'disabled');

        $('#chkHasparent').change(function() {
            $('#txtHasparent').prop('disabled', !this.checked);
            if (!(this.checked))
                $('#txtHasparent').val('');

        });
        ///OrderableLocation Changes Start
        $(document).on("click", function(event) {
            var container = $('#txtOrderableLocation');
            var groupSelectorArea = $(event.target).closest("#divOrderableLocation").length == 1;
            if (groupSelectorArea == false && !container.is(event.target))
                $('#divOrderableLocation').hide();
        });
        $('#txtOrderableLocation').click(function() {
            $('#divOrderableLocation').show();
        });
        $('#divFull').scroll(function() {
            $('#divOrderableLocation').hide();

        });
        ///OrderableLocation Changes End

        $('input[id^="chklstOrderableLocation_"]').click(function() {

            var checked_checkboxesOL = $("[id*=chklstOrderableLocation] input:checked");
            var AllLbl = '';
            checked_checkboxesOL.each(function() {
                AllLbl += $(this).next()[0].innerHTML + ', ';
            });
            $('#txtOrderableLocation').val(AllLbl);
        });

        $('#txtCopyFrom').blur(function() {
            $('#hdnClientID').val(0);
            $('#txtClientCode').val('');
            $('#hdnClientCode').val(0);
            $('#hdnClientName').val(0);
        });
        function LoadState() {
            var DefaultStateID = 0;
            if ($('#ddlCountry :selected').val() == '0')
                var CountryID = 75;
            else
                var CountryID = $('#ddlCountry :selected').val();
            var InputParam = {};
            InputParam.countryID = CountryID;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ClientManagement.aspx/LoadState",
                data: JSON.stringify(InputParam),
                dataType: "json",
                success: function(data) {
                    var jsdata = JSON.parse(data.d);
                    $('#ddlState').empty();
                    $('#ddlState').append("<option value='0'>--Select--</option>");
                    $.each(jsdata, function(key, value) {
                        $('#ddlState').append($("<option></option>").val(value["StateID"]).html(value["StateName"]));
                        if (value["IsDefault"] == 'Y')
                            DefaultStateID = value["StateID"];
                    });
                    if ($('#hdnStateID').val() == 0)
                        $('#ddlState').val(DefaultStateID);
                    else
                        $('#ddlState').val($('#hdnStateID').val());
                    return false;
                },
                error: function(result) {
                    jAlert("No Match", 'Alert Box');
                }
            });

        }
        $('#ddlCountry').change(function(event) {
            LoadState();
        });

        //Export excel Client Details

        $('#ImageBtnExport').click(function() {

            if ($('#hdnClientCode').val() == 0) $('#hdnClientCode').val($('#txtClientCode').val());
            if ($('#hdnClientName').val() == 0) $('#hdnClientName').val($('#txtClientName1').val());

            $('#iframeExcel').attr('src', 'ClientExportToExcelHandler.ashx?ClientName=' + $('#hdnClientName').val() + '&ClientCode=' + $('#hdnClientCode').val() + '&OrgID=' + OrgId + '&ILocationID=' + ILocationID);
            $('#iframeExcel').load();
        });
        $('#DatatableBasicClientDetails').hide();

        //txtClientName AutoComplete
        $("#txtClientName").autocomplete({
            source: function(request, response) {
                var vdatas = {};
                vdatas.prefixText = $('#txtClientName').val();
                vdatas.contextKey = 0;
                vdatas.orgID = OrgId;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "ClientManagement.aspx/GetClientNameAutocomplete",
                    data: JSON.stringify(vdatas),
                    dataType: "json",
                    success: function(data) {
                        var returnedData = JSON.parse(data.d);
                        response($.map(returnedData, function(item) {
                            return {
                                label: item.ClientName,
                                val: item.ClientID,
                                description: item.Status

                            }
                        }))
                    },
                    error: function(result) {
                        jAlert("No Match", 'Alert Box');
                    }
                });
            },
            select: function(e, i) {
                bindDataToGridWithBasicDetails(i.item.val, $.trim(i.item.label.split(':')[0]));
                GetClientMasterDetails(i.item.val, $.trim(i.item.label.split(':')[1]), $.trim(i.item.label.split(':')[0]));
            },
            minLength: 1
        }).data("ui-autocomplete")._renderItem = function(ul, item) {
            if (item.description == 'A') {
                return $("<li>")
            .attr("value", item.value)
            //.addClass(/\A/.test(item.description) ? 'red' : '')
            .append("<a class='red'>" + item.label + "</a>")
            .appendTo(ul);
            }
            else {
                return $("<li>")
            .attr("value", item.value)
            //.addClass(/\A/.test(item.description) ? 'red' : '')
            .append("<a>" + item.label + "</a>")
            .appendTo(ul);
            }
        };


        //txtHasparent AutoComplete 

        $("#txtHasparent").autocomplete({
            source: function(request, response) {
                var vdatas1 = {};
                vdatas1.prefixText = $('#txtHasparent').val();
                vdatas1.contextKey = 0;
                vdatas1.orgID = OrgId;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "ClientManagement.aspx/GetClientNameAutocomplete",
                    data: JSON.stringify(vdatas1),
                    dataType: "json",
                    success: function(data) {
                        var returnedData = JSON.parse(data.d);
                        response($.map(returnedData, function(item) {
                            return {
                                label: item.ClientName,
                                val: item.ClientID
                            }
                        }))

                    },
                    error: function(result) {
                        jAlert("No Match", 'Alert Box');
                    }
                });
            },
            select: function(e, i) {
                $('#hdnParentClientID').val(i.item.val);
                GetAssociateClient(i.item.val, $.trim(i.item.label.split(':')[1]));
            },
            minLength: 1
        });


        //txtCopyFrom AutoComplete
        $("#txtCopyFrom").autocomplete({
            source: function(request, response) {
                var vdatas2 = {};
                vdatas2.prefixText = $('#txtCopyFrom').val();
                vdatas2.contextKey = 0;
                vdatas2.orgID = OrgId;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "ClientManagement.aspx/GetClientNameAutocomplete",
                    data: JSON.stringify(vdatas2),
                    dataType: "json",
                    success: function(data) {
                        IstxtCopyFrom = 'Y';
                        var returnedData = JSON.parse(data.d);
                        response($.map(returnedData, function(item) {
                            return {
                                label: item.ClientName,
                                val: item.ClientID
                            }
                        }))
                    },
                    error: function(result) {
                        jAlert("No Match", 'Alert Box');
                    }
                });
            },
            select: function(e, i) {
                GetClientMasterDetails(i.item.val, $.trim(i.item.label.split(':')[1]), $.trim(i.item.label.split(':')[0]));
            },
            minLength: 1
        });


        //txtLocation AutoComplete txtHub  
        $("#txtLocation").autocomplete({
            source: function(request, response) {
                var vdatas3 = {};
                vdatas3.prefixText = $('#txtLocation').val();
                vdatas3.contextKey = $('#ddlClientType').val();
                vdatas3.orgID = OrgId;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "ClientManagement.aspx/GetLocationDetails",
                    data: JSON.stringify(vdatas3),
                    dataType: "json",
                    success: function(data) {
                        var returnedData = JSON.parse(data.d);
                        response($.map(returnedData, function(item) {
                            return {
                                label: item.Location,
                                val: item.AddressID
                            }
                        }))
                    },
                    error: function(result) {
                        jAlert("No Match", 'Alert Box');
                    }
                });
            },
            select: function(e, i) {
                $('#hdnLocationID').val(i.item.val)
            },
            minLength: 1
        });

        //txtHub AutoComplete  
        $("#txtHub").autocomplete({
            source: function(request, response) {
                var vdatas3 = {};
                vdatas3.prefixText = $('#txtHub').val();
                vdatas3.contextKey = $('#ddlClientType').val();
                vdatas3.orgID = OrgId;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "ClientManagement.aspx/GetHubDetails",
                    data: JSON.stringify(vdatas3),
                    dataType: "json",
                    success: function(data) {
                        var returnedData = JSON.parse(data.d);
                        response($.map(returnedData, function(item) {
                            return {
                                label: item.Locality_Value,
                                val: item.Locality_ID
                            }
                        }))
                    },
                    error: function(result) {
                        jAlert("No Match", 'Alert Box');
                    }
                });
            },
            select: function(e, i) {
                $('#hdnHubID').val(i.item.val)
            },
            minLength: 1
        });

        //txtZone AutoComplete   
        $("#txtZone").autocomplete({
            source: function(request, response) {
                var vdatas3 = {};
                vdatas3.prefixText = $('#txtZone').val();
                vdatas3.contextKey = $('#ddlClientType').val();
                vdatas3.HubID = $('#hdnHubID').val();
                vdatas3.orgID = OrgId;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "ClientManagement.aspx/GetZoneDetails",
                    data: JSON.stringify(vdatas3),
                    dataType: "json",
                    success: function(data) {
                        var returnedData = JSON.parse(data.d);
                        response($.map(returnedData, function(item) {
                            return {
                                label: item.Locality_Value,
                                val: item.Locality_ID
                            }
                        }))
                    },
                    error: function(result) {
                        jAlert("No Match", 'Alert Box');
                    }
                });
            },
            select: function(e, i) {
                $('#hdnZoneID').val(i.item.val);
            },
            minLength: 1
        });


        //txtRoute AutoComplete   
        $("#txtRoute").autocomplete({
            source: function(request, response) {
                var vdatas3 = {};
                vdatas3.prefixText = $('#txtRoute').val();
                vdatas3.contextKey = $('#ddlClientType').val();
                vdatas3.ZoneID = $('#hdnZoneID').val();
                vdatas3.orgID = OrgId;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "ClientManagement.aspx/GetRouteNames",
                    data: JSON.stringify(vdatas3),
                    dataType: "json",
                    success: function(data) {
                        var returnedData = JSON.parse(data.d);
                        response($.map(returnedData, function(item) {
                            return {
                                label: item.Locality_Value,
                                val: item.Locality_ID
                            }
                        }))
                    },
                    error: function(result) {
                        jAlert("No Match", 'Alert Box');
                    }
                });
            },

            select: function(e, i) {
                $('#hdnRouteID').val(i.item.val);
            },
            minLength: 1
        });


        //txtZipCode AutoComplete   
        //        $("#txtZipCode").autocomplete({
        //            source: function(request, response) {
        //                var vdatas3 = {};
        //                vdatas3.PostalCode = $('#txtZipCode').val();
        //                vdatas3.OrgID = OrgId;
        //                $.ajax({
        //                    type: "POST",
        //                    contentType: "application/json; charset=utf-8",
        //                    url: "ClientManagement.aspx/GetAddressDetails",
        //                    data: JSON.stringify(vdatas3),
        //                    dataType: "json",
        //                    success: function(data) {
        //                        var returnedData = JSON.parse(data.d);
        //                        response($.map(returnedData, function(item) {
        //                            return {
        //                                label: item.PostalCode,
        //                                val: item.Address1
        //                            }
        //                        }))
        //                    },
        //                    error: function(result) {
        //                        jAlert("No Match", 'Alert Box');
        //                    }
        //                });
        //            },
        //            select: function(e, i) {
        //                $('#txtCity').val($.trim(i.item.val.split('~')[0]));
        //                $('#txtAddressLine1').val($.trim(i.item.val.split('~')[1]));
        //            },
        //            minLength: 1
        //        });

        //txtPolicy AutoComplete   
        $("#txtPolicy").autocomplete({
            source: function(request, response) {
                var TODVal;
                var vdatas3 = {};

                vdatas3.prefixText = $('#txtPolicy').val();
                vdatas3.contextKey = $('#ddlType').val();
                vdatas3.orgID = OrgId;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "ClientManagement.aspx/GetTODCodeAndID",
                    data: JSON.stringify(vdatas3),
                    dataType: "json",
                    success: function(data) {
                        var returnedData = JSON.parse(data.d);
                        response($.map(returnedData, function(item) {
                            return {
                                label: item.Code,
                                val: item.TODID
                            }
                        }))
                    },
                    error: function(result) {
                        jAlert("No Match", 'Alert Box');
                    }
                });
            },
            select: function(e, i) {
                $('#hdnPolicyID').val(i.item.val);
            },
            minLength: 1
        });
        //txtSPOCName AutoComplete
        $("#txtSPOCName").autocomplete({
            source: function(request, response) {
                var TODVal;
                var vdatas3 = {};
                vdatas3.prefixText = $('#txtSPOCName').val();
                vdatas3.contextKey = $('#ddlContactType').val();
                vdatas3.orgID = OrgId;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "ClientManagement.aspx/GetSPOCName",
                    data: JSON.stringify(vdatas3),
                    dataType: "json",
                    success: function(data) {
                        var returnedData = JSON.parse(data.d);
                        response($.map(returnedData, function(item) {
                            return {
                                label: item.Name,
                                val: item.EmpID
                            }
                        }))
                    },
                    error: function(result) {
                        jAlert("No Match", 'Alert Box');
                    }
                });
            },
            select: function(e, i) {
                $('#hdnDiscountTypeID').val(i.item.val)
            },
            minLength: 1
        });
        function GetClientMasterDetails(ClientID, ClientName, ClientCode) {
            var vparams = {};
            vparams.ClientID = ClientID;
            vparams.ClientName = ClientName;
            vparams.ILocationID = ILocationID;
            vparams.ClientCode = ClientCode;
            vparams.OrgID = OrgId;

            $.ajax({
                type: "POST",
                url: 'ClientManagement.aspx/GetInvoiceClientDetails',
                data: JSON.stringify(vparams),
                contentType: "application/json; charset=utf-8",
                dataType: 'json',
                success: function(data) {
                    var objdata = $.parseJSON(data.d);
                    $.each(objdata, function(index, value) {
                        ////Basic Details Tab Start
                        $('#hdnClientID').val(value.ClientID);
                        $('#hdnClientCode').val(value.ClientCode);
                        $('#hdnClientName').val(value.ClientName);
                        $('#txtClientCode').val(value.ClientCode);
                        $('#ddlClientType').val(value.ClientTypeID);
                        if (value.RegistrationType != '' && value.RegistrationType != null) {
                            $('#ddlRegistrationType').val(value.RegistrationType);
                        }
                        else {
                            $('#ddlRegistrationType').val("All");
                        }
                        if (value.ParentClientID > 0) {
                            $('#chkHasparent').prop('checked', true);
                            $('#txtHasparent').prop('disabled', false);
                        }
                        else {
                            $('#chkHasparent').prop('checked', false);
                        }
                        $('#txtHasparent').val(value.ParentClientName);
                        bindDataToGrid(value.ParentClientID);

                        $('#hdnParentClientID').val(value.ParentClientID);
                        if (value.IsMailToParentClient == 'Y') {
                            $('#chkCCLabReport').prop('checked', true);
                        }
                        else {
                            $('#chkCCLabReport').prop('checked', false);
                        }
                        if (value.ReferID != '' && value.ReferID != null) {
                            $('#ddlSplPrivileges').val(value.ReferID);
                        }
                        else {
                            $('#ddlSplPrivileges').val("0");
                        }
                        var StrOrderableLocation = '';
                        if (value.OrderableLocation != null) {
                            StrOrderableLocation = value.OrderableLocation.split("~");

                            var listOL = $('#<%= chklstOrderableLocation.ClientID%> input');
                            for (i = 0; i < StrOrderableLocation.length; i++) {
                                listOL.each(function(index) {
                                    var value = $(this).parent("span").attr('OrgID')
                                    var ID = $(this).attr('id')
                                    if (value == StrOrderableLocation[i]) {
                                        $('#' + ID + '').prop('checked', true);
                                    }

                                });
                            }
                        }

                        if (value.PrintOrgAddressID != '' && value.PrintOrgAddressID != null) {
                            $('#ddlPrintLocation').val(value.PrintOrgAddressID);
                        }
                        else {
                            $('#ddlPrintLocation').val("0");
                        }
                        if (value.PrintOutCopies != '' && value.PrintOutCopies != null) {
                            $('#ddlNoofPrintCopies').val(value.PrintOutCopies);
                        }
                        else {
                            $('#ddlNoofPrintCopies').val("0");
                        }
                        if (value.ExAutoAuthorization == 'Y') {
                            $('#chkExcludeAutoAuthorization').prop('checked', true);
                        }
                        else {
                            $('#chkExcludeAutoAuthorization').prop('checked', false);
                        }
                        $('#hdnContactDetails').val(value.OtherContacts);
                        LoadContactDetails();
                        ////Basic Details Tab End


                        ////Communication Details Tab Start
                        $('#txtLocation').val(value.CollectionCenter);
                        $('#txtHub').val(value.HubName);
                        $('#txtZone').val(value.ZoneName);
                        $('#txtRoute').val(value.RouteName);
                        $('#hdnLocationID').val(value.CollectionCenterID);
                        $('#hdnHubID').val(value.HubID);
                        $('#hdnZoneID').val(value.ZonalID);
                        $('#hdnRouteID').val(value.RouteID);
                        $('#txtTransitTime').val(value.TransitTimeValue);
                        if (value.TransitTimeType != '' && value.TransitTimeType != null)
                            $('#ddlTransitTime').val(value.TransitTimeType);
                        else
                            $('#ddlTransitTime').val("0");
                        $('#hdnShippingDetails').val(value.AddressDetails);
                        LoadShippingDetails();
                        ////Communication Details Tab End


                        ////Notifications Details Tab Start
                        var StrClientAttributes = '';
                        if (value.ClientAttributes != null) {
                            StrClientAttributes = value.ClientAttributes.split("^");

                            var listNoti = $('#<%= chkNotification.ClientID%> input');
                            for (i = 0; i < StrClientAttributes.length; i++) {
                                listNoti.each(function(index) {
                                    var value = $(this).parent("span").attr('attributeid')
                                    var ID = $(this).attr('id')
                                    if (value == StrClientAttributes[i]) {
                                        $('#' + ID + '').prop('checked', true);
                                    }
                                    if ($(this).next().html() == 'Report Print') {
                                        if ($('#' + ID).is(':checked'))
                                            $('#divReportPrintDate').show();
                                        else
                                            $('#divReportPrintDate').hide();
                                    }
                                });
                            }
                        }
                        $('#txtReportPrintDate').val(JSONDateWithTime(value.ReportPrintdate));

                        $('#hdnNotificationDetails').val(value.NotificationContacts);
                        LoadNotificationDetails();
                        ////Notifications Details Tab End



                        ////Report Details Tab Start
                        if (value.ReportTemplateID != '' && value.ReportTemplateID != null)
                            $('#ddlDescription').val(value.ReportTemplateID);
                        else
                            $('#ddlDescription').val("0");

                        var exists = false;

                        for (i = 0; i < StrClientAttributes.length; i++) {
                            $('#ddlStationery option').each(function() {
                                if (this.value == StrClientAttributes[i]) {
                                    $('#ddlStationery').val(StrClientAttributes[i]);
                                    exists = true;

                                }
                            });
                        }
                        if (exists = false) $('#ddlStationery').val(0);

                        ////Report Details Tab End




                        ////Commercial Details Tab Start
                        if (IstxtCopyFrom == 'N') {
                            $('#hdnTaxDetails').val(value.ClientTaxDetails);
                            LoadTaxdetails();

                            $('#hdnDiscountDetails').val(value.DiscountDeatils);
                            LoadDiscountdetails();
                        }
                        ////Commercial Details Tab End


                        ////CreditControl Details Tab Start
                        if (value.CustomerType != '' && value.CustomerType != null)
                            $('#ddlBusinessType').val(value.CustomerType);
                        else
                            $('#ddlBusinessType').val("0");
                        $('#txtCSTNo').val(value.CstNo)
                        $('#txtServiceTaxNo').val(value.ServiceTaxNo)
                        $('#txtPanNo').val(value.PanNo)
                        $('#txtSAPCode').val(value.SapCode);
                        if (value.CurrencyID != '' && value.CurrencyID != null)
                            $('#ddlCurrencyType').val(value.CurrencyID);
                        else
                            $('#ddlCurrencyType').val($('#hdnbaseCurrencyID').val());
                        if (value.PaymentCategory == 'CASHADV') {
                            $('#trClientDeposit').show();
                        }
                        if (value.PaymentCategory != '' && value.PaymentCategory != null)
                            $('#ddlPaymentCategory').val(value.PaymentCategory);
                        else
                            $('#ddlPaymentCategory').val("0");
                        if (value.IsMappedItem == 'Y') {
                            $('#chkAllowServiceMapping').prop('checked', true);
                        }
                        else {
                            $('#chkAllowServiceMapping').prop('checked', false);
                        }
                        if (value.InvoiceCycle != '' && value.InvoiceCycle != null)
                            $('#ddlInvoiceCycle').val(value.InvoiceCycle);
                        else
                            $('#ddlInvoiceCycle').val("0");
                        if (value.Hashealthcoupon == 'Y') {
                            $('#chkCouponSystem').prop('checked', true);
                        }
                        else {
                            $('#chkCouponSystem').prop('checked', false);
                        }
                        if (value.ApprovalRequired.trim() == 'Y') {
                            $('#chkInvoiceApprovalRequired').prop('checked', true);
                        }
                        else {
                            $('#chkInvoiceApprovalRequired').prop('checked', false);
                        }
                        if (value.IsDiscount == 'Y') {
                            $('#chkAllowBillingDiscount').prop('checked', true);
                        }
                        else {
                            $('#chkAllowBillingDiscount').prop('checked', false);
                        }
                        if (value.Status != '' && value.Status != null)
                            $('#ddlClientStatus').val(value.Status.trim());
                        else
                            $('#ddlClientStatus').val("0");
                        if (value.Reason != '' && value.Reason != null)
                            $('#ddlReason').val(value.Reason);
                        else
                            $('#ddlReason').val("0");
                        if (value.HoldAction != '' && value.HoldAction != null)
                            $('#ddlAction').val(value.HoldAction);
                        else
                            $('#ddlAction').val("0");
                        if (value.Status.trim() != 'A') {
                            $('#tdHideDate').show();
                            $('#txtFromDate').val(JSONDateWithTime(value.BlockFrom));
                            $('#txtToDate').val(JSONDateWithTime(value.BlockTo));
                        }
                        else {
                            $('#tdHideDate').hide();
                            $('#txtFromDate').val('');
                            $('#txtToDate').val('');
                        }

                        $('#txtCreditDays').val(value.CreditDays);
                        $('#txtGraceLimit').val(value.GraceLimit);
                        $('#txtGraceDays').val(value.GraceDays);
                        $('#txtCreditLimit').val(value.CreditLimit);
                        if (value.ThresholdType != '' && value.ThresholdType != null)
                            $('#ddlAdvanceThreshold').val(value.ThresholdType);
                        else
                            $('#ddlAdvanceThreshold').val("0");
                        $('#txtValue').val(value.ThresholdValue);
                        $('#txtMinimumDeposite').val(value.MinimumAdvanceAmt);
                        ////CreditControl Details Tab End


                        ////Attributes Details Tab Start
                        ReadAttributeXML(value.Attributes);
                        ////Attributes Details Tab End


                        ////Documents Details Tab Start
                        if (IstxtCopyFrom == 'N') {
                            loadDocDetail();
                        }
                        $('#txtTermAndConditions').val(value.Termsconditions);
                        ////Documents Details Tab End

                    });
                }
            });
        }

        function GetAssociateClient(ClientID, ClientName) {
            bindDataToGrid(ClientID);
        }
        // For Creating New Client /// btnAddNewClient
        $('#btnAddNewClient').click(function() {
            $('#txtClientName').hide();
            $('#txtClientName1').show();
            $('#trCopyDetails').show();
            Clear();
            IsNewClient = 'Y';
            $('#btnAddNewClient').hide();
            $('#lblReasonforAmend').hide();
            $('#ddlReasonForSave').hide();
        });

        $('#btnAssociateClient').click(function() {
            if ($('#txtHasparent').val() != '' && !($('#AssociateClientdatatable tbody tr td').hasClass("dataTables_empty"))) {// $('#AssociateClientdatatable >tbody >tr').length > 1
                $('#popAssociatedClient').show();
                $('#Backgrd_hide').show();
                $("#AssociateClientdatatable").show();
            }
            return false;
        });

        ///Document Upload Tab
        var FilePath = '<%=sFilePath%>';
        var FileUploadPath = FilePath.replace(/-/g, "\\\\");
        $(document).on('click', '.ClsAdd', function() {
            if ($('#txtClientCode').val() == '') {
                jAlert('Enter the Client Code')
                return false;
            }
            var UploadFileName1 = $("#FileUpload").val().split('\\').pop().replace(/\s+/g, '');
            var UploadFileName; var UploadFileNameExt;
            if ($("#txtFileName").val() != "") {
                var ext = UploadFileName1.split('.').pop();
                UploadFileName = $("#txtFileName").val() + '_' + $("#txtClientCode").val() + '.' + ext;
                UploadFileNameExt = $("#txtFileName").val() + '_' + $("#txtClientCode").val();
            }
            else {
                //UploadFileName = $("#FileUpload").val().split('\\').pop().replace(/\s+/g, '');
                //UploadFileName = UploadFileName + '_' + $("#txtClientCode").val();
                //UploadFileNameExt = UploadFileName.substr(0, UploadFileName.lastIndexOf('.')) || UploadFileName;
                var UploadFileName1 = $("#FileUpload").val().split('\\').pop().replace(/\s+/g, '');
                var UploadFileName2 = UploadFileName1.substr(0, UploadFileName1.lastIndexOf('.')) || UploadFileName1;
                UploadFileName = UploadFileName2 + '_' + $("#txtClientCode").val() + '.' + UploadFileName1.split('.').pop();
                UploadFileNameExt = UploadFileName2 + '_' + $("#txtClientCode").val();
            }
            if (UploadFileName != "") {

                if ($("#ListFiles option[value='" + UploadFileNameExt + "']").length > 0) {
                    jAlert("The " + UploadFileNameExt + " already added", 'Alert Box');
                }
                else {
                    var lstText = UploadFileName + '~' + $("#txtType").val() + '~' + $("#txtDate").val();
                    $('#ListDoc').append(' <option value="' + UploadFileNameExt + '">' + lstText + '</option> ');
                    $('#ListFiles').append(' <option value="' + UploadFileNameExt + '">' + UploadFileName + '</option> ');
                    var FilesList = "<div id='" + UploadFileNameExt + "'><table class='w-100p'><tr><td class='w-40p'><label class='lh25'>" + UploadFileName + "</label></td><td class='w-20p'><label>" + $("#txtType").val() + "</label></td><td class='w-25p'><label>" + $("#txtDate").val() + "</label></td><td class='w-15p'><img title='Click to Download' alt='Click to Download' class='btnDownloadRate pull-right' src='../Images/download1.png' /><img title='Click to Delete' alt='Click to Delete' class='btndeleteRate pull-right' src='../Images/delete11.png' /></td></tr></table></div>"
                    $(FilesList).appendTo('#divFiles');
                    if (!isAjaxUploadSupported()) { //IE fallfack
                        var iframe = document.createElement("<iframe name='upload_iframe' id='upload_iframe'>");
                        iframe.setAttribute("width", "0");
                        iframe.setAttribute("height", "0");
                        iframe.setAttribute("border", "0");
                        iframe.setAttribute("src", "javascript:false;");
                        iframe.style.display = "none";

                        var form = document.createElement("form");
                        //form.setAttribute("class", "iefileupload");
                        form.setAttribute("target", "upload_iframe");
                        form.setAttribute("action", "../FileUpload.ashx?Filepath=" + FileUploadPath + "&Filename=" + UploadFileName);
                        form.setAttribute("method", "post");
                        form.setAttribute("enctype", "multipart/form-data");
                        form.setAttribute("encoding", "multipart/form-data");
                        form.style.display = "inline-block";
                        form.style.left = "64%";
                        form.style.top = "35%";
                        form.style.position = "absolute";
                        var files = document.getElementById("FileUpload");
                        form.appendChild(files);
                        document.body.appendChild(form);
                        document.body.appendChild(iframe);
                        iframeIdmyFile = document.getElementById("upload_iframe");
                        form.submit();
                        var uplctrl = document.getElementById("FileUpload");
                        uplctrl.select();
                        //clrctrl = uplctrl.createTextRange();
                        //clrctrl.execCommand('delete');
                        uplctrl.focus();
                        $('#FileUpload').replaceWith($('#FileUpload').clone());
                        $("#txtFileName").val('');
                        $("#txtDate").val('');
                        $("#txtType").val('');
                        return false;

                    }
                    else {
                        AddtoFolder(UploadFileName);
                        $('#FileUpload').val("");
                    }
                    $("#txtFileName").val('');
                    $("#txtDate").val('');
                    $("#txtType").val('');
                }
            }
            else
                jAlert("Please Add File", 'Alert Box');
            return false
        });

        function isAjaxUploadSupported() {
            var input = document.createElement("input");
            input.type = "file";
            return (
		        "multiple" in input &&
		            typeof File != "undefined" &&
		            typeof FormData != "undefined" &&
		            typeof (new XMLHttpRequest()).upload != "undefined");
        }

        function AddtoFolder(UploadFileName) {
            var fileUpload = $("#FileUpload").get(0);
            var files = fileUpload.files;
            var FileDetails = new FormData();
            for (var i = 0; i < files.length; i++) {
                FileDetails.append(files[i].name, files[i]);
            }
            var FileDetails;
            $.ajax({
                url: "../FileUpload.ashx?OrgID=" + OrgId + "&Filepath=" + FileUploadPath + "&Filename=" + UploadFileName,
                type: "POST",
                contentType: false,
                processData: false,
                data: FileDetails,
                success: function(result) {
                },
                error: function(err) {
                    jAlert(err.statusText, 'Alert Box');
                }
            });
        };

        function DownloadFile(DownloadFileName) {
            $.ajax({
                url: '../DownloadFile.ashx?OrgID=' + OrgId + '&Filename=' + DownloadFileName + '&Filepath=' + FileUploadPath,
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function(response) {
                    if (isNaN(response.d) == true) {
                        $('#iframe').attr('src', '../DownloadFile.ashx?OrgID=' + OrgId + '&Filename=' + DownloadFileName + '&Filepath=' + FileUploadPath);
                        $('#iframe').load();
                    }
                    else {
                        jAlert(response.d, 'Alert Box');
                    }
                },
                error: function(err) {
                    jAlert(err.statusText, 'Alert Box');
                }
            });
        };

        //==== Method to delete a record
        function deleteRecord(RemoveItems) {
            var type = 'Delete';
            var searchtext = RemoveItems;
            jConfirm('Are you sure to delete a record?', 'Confirmation Dialog', function(ReturnResponse) {
                if (ReturnResponse == true) {
                    $.ajax({
                        type: "POST",
                        url: "ClientManagement.aspx/RemoveDocDetails",
                        data: "{'searchtext':'" + searchtext + "','type': '" + type + "' }",
                        contentType: "application/json; charset=utf-8",
                        datatype: "json",
                        success: function(response) {
                            $('#' + RemoveItems + '').remove();
                            $("#ListFiles option[value='" + RemoveItems + "']").remove();
                            $("#ListDoc option[value='" + RemoveItems + "']").remove();
                        },
                        error: function(response) {
                            jAlert(response.status + ' ' + response.statusText, 'Alert Box');
                        }
                    });
                }
                else {
                    return false;
                }
            });

        }


        //Download  button Click in Second tab
        $(document).on('click', '.btnDownloadRate', function() {

            var DownloadFileName;
            //var DownFile = $(this).parent().attr('id')
            var DownFile = $(this).parent().parent().parent().parent().parent().attr('id');
            $('#ListFiles option').each(function() {
                if (DownFile == $(this).val())
                    DownloadFileName = $(this).text();
            });
            DownloadFile(DownloadFileName);
        });

        //Delete button Click in Second tab
        $(document).on('click', '.btndeleteRate', function() {
            var RemoveItems = $(this).parent().parent().parent().parent().parent().attr('id');
            //var RemoveItems = $(this).parent().attr('id');
            deleteRecord(RemoveItems);

        });

        //binds to onchange event of your input field
        $('#FileUpload').bind('change', function() {
            var f = this;
            if (f.size > 1048576 || f.fileSize > 1048576) {
                jAlert("Allowed file size exceeded. (Max.1 MB)", 'Alert Box');
                this.value = null;
            }
        });

        function loadDocDetail() {
            var StrRateId = $('#hdnClientID').val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ClientManagement.aspx/GetUploadDocDetails",
                data: "{'FileDetails':'" + StrRateId + "'}",
                dataType: "json",
                success: function(data) {
                    if (data.d.length > 0) {
                        $('#ListFiles').text("");
                        $('#ListFiles').val("");
                        $('#ListDoc').text("");
                        $('#ListDoc').val("");
                        $('#divFiles').empty();
                        var returnedData = JSON.parse(data.d);
                        $.each(returnedData, function(index, returnedData) {
                            var url = returnedData.DocFileUrl;

                            var filename = returnedData.DocFileName.substr(0, returnedData.DocFileName.lastIndexOf('.')) || returnedData.DocFileName;
                            $('#ListDoc').append(' <option value="' + filename + '">' + returnedData.DocFileName + '~' + returnedData.Type + '~' + JSONDateWithTime(returnedData.DocDate) + '</option> ');
                            $('#ListFiles').append(' <option value="' + filename + '">' + returnedData.DocFileName + '</option> ');
                            //var FilesList = "<div id='" + filename + "'><label class='lh25'>" + returnedData.DocFileName + "</label><img title='Click to Download' alt='Click to Download' class='btnDownloadRate pull-right' src='../Images/download1.png' /><img title='Click to Delete' alt='Click to Delete' class='btndeleteRate pull-right' src='../Images/delete11.png' /></div>"
                            var FilesList = "<div id='" + filename + "'><table class='w-100p'><tr><td class='w-40p'><label class='lh25'>" + returnedData.DocFileName + "</label></td><td class='w-20p'><label>" + returnedData.Type + "</label></td><td class='w-25p'><label>" + JSONDateWithTime(returnedData.DocDate) + "</label></td><td class='w-15p'><img title='Click to Download' alt='Click to Download' class='btnDownloadRate pull-right' src='../Images/download1.png' /><img title='Click to Delete' alt='Click to Delete' class='btndeleteRate pull-right' src='../Images/delete11.png' /></td></tr></table></div>"
                            $(FilesList).appendTo('#divFiles');
                        });
                        //  return false;

                    }
                    else {
                        jAlert("No matching records found", 'Alert Box');
                    }
                },
                error: function(result) {
                    jAlert("No Match", 'Alert Box');
                }
            });
        }
        ////Document upload End

        //Attribute Detail Tab
        function ReadAttributeXML(inputXMl) {
            var oTable = $('#tblAttributesDetails').dataTable();
            oTable.fnClearTable();
            var xmlDoc = $.parseXML(inputXMl);
            $(xmlDoc).find('AttribDetails').each(function() {
                var sID = $(this).find('ID').text();
                var sName = $(this).find('Name').text();
                var sType = $(this).find('Type').text();
                var sValue = $(this).find('Value').text();
                GetAttributes(sName, sType, sValue);
            });
        }

        function GetAttributes(sName, sType, sValue) {
            $("#tblAttributesDetails").show();
            $('#tblAttributesDetails_filter').removeClass('hide');
            var Action = '<a class="ui-icon ui-icon-pencil marginL5 pull-left ADedit" title="Click to Edit" /><a class="ui-icon ui-icon-trash marginL5 pull-left ADremove" title="Click to Delete" />';
            $('#tblAttributesDetails').dataTable().fnAddData([sName, sValue, sType, Action]);

        }

        function AddAttributeDetailsRow() {
            $("#tblAttributesDetails").show();
            $('#tblAttributesDetails_filter').removeClass('hide');
            if (validateAttributesDetails() == true) {
                var Action = '<a class="ui-icon ui-icon-pencil marginL5 pull-left ADedit" title="Click to Edit" /><a class="ui-icon ui-icon-trash marginL5 pull-left ADremove" title="Click to Delete" />';
                if (btnUpdateAttributesDetails == true) {
                    $('#tblAttributesDetails').dataTable().fnUpdate([
            $('#txtAttributes').val(),
            $('#txtAttributesValue').val(),
            $('#ddlAttributesType option:selected').text(),
              Action
                ], UpdateAttributesDetailsID);
                    btnUpdateAttributesDetails = false;
                    UpdateAttributesDetailsID = '';
                }
                else {
                    var Msg = 'N';
                    var oTable = $('#tblAttributesDetails').dataTable();
                    var aData = oTable.fnGetData();
                    for (var i = 0; i < aData.length; i++) {
                        var Data = aData[i];
                        if ($('#txtAttributes').val() == Data[0] && $('#txtAttributesValue').val() == Data[1] && $('#ddlAttributesType option:selected').text() == Data[2]) {
                            Msg = 'Y'
                            break;
                        }
                    }
                    if (Msg != 'Y') {

                        $('#tblAttributesDetails').dataTable().fnAddData([
                $('#txtAttributes').val(),
                $('#txtAttributesValue').val(),
                $('#ddlAttributesType option:selected').text(),
                Action
                ]);
                    }
                    else {
                        jAlert("Duplicate Entry", 'Alert Box');
                    }
                }
            }
            $('#txtAttributes').val('');
            $('#txtAttributesValue').val('');
            $('#ddlAttributesType').val('0');

        }
        $(document).on('click', '.ADedit', function() {
            var row = $(this).closest('tr').index();
            btnUpdateAttributesDetails = true;
            UpdateAttributesDetailsID = row;

            var oTable = $('#tblAttributesDetails').dataTable();
            var aData = oTable.fnGetData();
            var Data = aData[row];
            $('#txtAttributes').val(Data[0]);
            $('#txtAttributesValue').val(Data[1]);
            $("#ddlAttributesType option:contains(" + Data[2] + ")").attr('selected', 'selected');

        });
        $(document).on('click', '.ADremove', function() {
            var row = $(this).closest('tr');
            var nRow = row[0];
            jConfirm('Are you sure to delete a record?', 'Confirmation Dialog', function(ReturnResponse) {
                if (ReturnResponse == true) $('#tblAttributesDetails').dataTable().fnDeleteRow(nRow);

            });
        });


        $('#AddAttribute').click(function() {
            AddAttributeDetailsRow();
        });

        ///Attribute tab end


        ///Jquery dataTable Intialization Start
        $('#tblContactDetails').dataTable({
            "bFilter": true,
            "bInfo": false,
            "bPaginate": false,
            "aaSorting": [],
            "aoColumns": [null, null, null, null, null, null, { "bVisible": false }, { "bVisible": false }, null]

        });
        $("#tblContactDetails").hide();
        $('#tblContactDetails_filter').addClass('hide');

        $('#tblLocationPrinter').dataTable({
            "bFilter": true,
            "bInfo": false,
            "bPaginate": false,
            "aaSorting": [],
            "aoColumns": [null, null, { "bVisible": false }, { "bVisible": false }, null]
        });
        $('#tblLocationPrinter_filter').addClass('hide');
        $("#tblLocationPrinter").hide();


        $('#tblAttributesDetails').dataTable({
            "bFilter": true,
            "bInfo": false,
            "bPaginate": false,
            "aaSorting": []

        });
        $('#tblAttributesDetails_filter').addClass('hide');
        $("#tblAttributesDetails").hide();


        $('#tblNotificationDetails').dataTable({
            "bFilter": true,
            "bInfo": false,
            "bPaginate": false,
            "aaSorting": [],
            "aoColumns": [null, null, null, null, null, { "bVisible": false}]

        });
        $("#tblNotificationDetails").hide();
        $('#tblNotificationDetails_filter').addClass('hide');

        $('#tblTaxDetails').dataTable({
            "bFilter": true,
            "bInfo": false,
            "bPaginate": false,
            "aaSorting": [],
            "aoColumns": [{ "bVisible": false }, null, null, null, null]
        });
        $("#tblTaxDetails").hide();
        $('#tblTaxDetails_filter').addClass('hide');


        $('#tblShippingDetails').dataTable({
            "bFilter": true,
            "bInfo": false,
            "bPaginate": false,
            "aaSorting": [],
            "aoColumns": [null, null, null, null, null, null, null, null, null, null, null, null, null, { "bVisible": false }, { "bVisible": false }, { "bVisible": false }, { "bVisible": false}]
        });
        $("#tblShippingDetails").hide();
        $('#tblShippingDetails_filter').addClass('hide');

        /*$("#tblShippingDetails").jqGrid({
        datatype: 'local',
        colNames: ['Address Type', 'Zipcode', 'Area', 'City', 'State', 'Country', 'Address 1', 'Address 2', 'Contact No', 'Land', 'Email Id', 'Active', 'Action', 'AddressTypeID', 'AddressID', 'CountryID', 'StateID'],
        colModel: [
        { name: 'ADDRESSTYPE', width: 90, align: 'center' },
        { name: 'ZIPCODE', width: 90, align: 'center' },
        { name: 'AREA', width: 90, align: 'center' },
        { name: 'CITY', width: 90, align: 'center' },
        { name: 'STATE', width: 90, align: 'center' },
        { name: 'COUNTRY', width: 90, align: 'center' },
        { name: 'ADD1', width: 150, align: 'center' },
        { name: 'ADD2', width: 150, align: 'center' },
        { name: 'CONTACTNO', width: 100, align: 'center' },
        { name: 'LAND', width: 100, align: 'center' },
        { name: 'EMAILID', width: 90, align: 'center' },
        { name: 'ACTIVE', width: 60, align: 'center' },
        { name: 'ACTION', width: 90, align: 'center' },
        { name: 'AddressTypeID', width: 90, align: 'center' },
        { name: 'AddressID', width: 90, align: 'center' },
        { name: 'CountryID', width: 90, align: 'center' },
        { name: 'StateID', width: 90, align: 'center' }
        ],
        cmTemplate: { sortable: false },
        rowNum: 100,
        gridview: true,
        hoverrows: false,
        autoencode: false,
        ignoreCase: true,
        viewrecords: true,
        height: '90%',
        beforeSelectRow: function() {
        return false;
        }
        });
        */
        //        $("#tblShippingDetails").jqGrid('hideCol', ["AddressTypeID", "AddressID", "CountryID", "StateID"]);
        //        $("#gbox_tblShippingDetails").hide();


        $('#tblCommercialDetails').dataTable({
            "bFilter": true,
            "bInfo": false,
            "bPaginate": false,
            "aaSorting": [],
            "aoColumns": [null, null, { "bVisible": false }, null, null, null, { "bVisible": false }, null]

        });
        $("#tblCommercialDetails").hide();
        $('#tblCommercialDetails_filter').addClass('hide');
        ///Jquery dataTable Intialization End

        ///Basic Details tab Start
        $('#btnAddLocation').click(function() {
            var InputParam = {};
            InputParam.txtCode = $('#txtCode').val();
            InputParam.hdnOrgAddressID = $('#hdnOrgAddressID').val();
            InputParam.txtPrinterName = $('#txtPrinterName').val();
            InputParam.OrgID = OrgId;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ClientManagement.aspx/AddNewPrinter",
                data: JSON.stringify(InputParam),
                dataType: "json",
                success: function(data) {
                    $('#txtPrinterName').val('');
                    $('#txtCode').val('');
                    $('#hdnOrgAddressID').val('');
                    $('#btnAddLocation').text('Save');
                    GetPrinterDetails();
                    return false;
                },
                error: function(result) {

                    jAlert("No Match", 'Alert Box');
                }
            });
            return false;
        });

        function LoadPrinterDdl() {
            var InputParam = {};
            InputParam.OrgID = OrgId;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ClientManagement.aspx/GetPrinterLocation",
                data: JSON.stringify(InputParam),
                dataType: "json",
                success: function(data) {
                    $('#txtPrinterName').val('');
                    $('#txtCode').val('');
                    $('#hdnOrgAddressID').val('');
                    var jsdata = JSON.parse(data.d);
                    $('#ddlPrintLocation').empty();
                    $('#ddlPrintLocation').append("<option value='0'>--Select--</option>");
                    $.each(jsdata, function(key, value) {
                        $('#ddlPrintLocation').append($("<option></option>").val(value["OrgAddressID"]).html(value["PrinterName"]));
                    });

                    return false;
                },
                error: function(result) {
                    jAlert("No Match", 'Alert Box');
                }
            });
        }

        $('#Closeclick').click(function() {
            $('#popAssociatedClient').hide();
            $('#popNewPrinter').hide();
            $('#Backgrd_hide').hide();
        });

        $('#Closeclick1').click(function() {
            LoadPrinterDdl();
            $('#popAssociatedClient').hide();
            $('#popNewPrinter').hide();
            $('#Backgrd_hide').hide();
        });

        //For Printer Details Start
        $('#btnNewPrinter').click(function() {
            GetPrinterDetails();
            $('#popNewPrinter').show();
            $('#Backgrd_hide').show();
            return false;
        });

        function GetPrinterDetails() {
            var oTable = $('#tblLocationPrinter').dataTable();
            oTable.fnClearTable();
            var OrgID = OrgId;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ClientManagement.aspx/GetPrinterLocation",
                data: "{'OrgID':'" + OrgID + "'}",
                dataType: "json",
                success: function(data) {
                    if (data.d.length > 0) {
                        var SNO = 1;
                        var Action = '<a class="ui-icon ui-icon-pencil marginL5 pull-left marginR10 PRedit" title="Click to Edit" /><a class="ui-icon ui-icon-trash marginL5 pull-left PRremove" title="Click to Delete" />';
                        var returnedData = JSON.parse(data.d);
                        $.map(returnedData, function(item) {
                            $('#tblLocationPrinter').dataTable().fnAddData([
                            SNO,
                            item.PrinterName,
                            item.Code,
                            item.OrgAddressID,
                            Action
                            ]);
                            SNO = SNO + 1;
                        })
                        $("#tblLocationPrinter").show();
                        $('#tblLocationPrinter_filter').removeClass('hide');
                    }
                    else {
                        jAlert("No matching records found", 'Alert Box');
                    }
                },
                error: function(result) {
                    jAlert("No match", 'Alert Box');
                }
            });
        }


        $(document).on('click', '.PRedit', function() {
            var row = $(this).closest('tr').index();
            var oTable = $('#tblLocationPrinter').dataTable();
            var aData = oTable.fnGetData();
            var Data = aData[row];
            $('#txtPrinterName').val(Data[1]);
            $('#txtCode').val(Data[2]);
            $('#hdnOrgAddressID').val(Data[3]);
            $('#btnAddLocation').text('Update');

        });
        $(document).on('click', '.PRremove', function() {
            var row = $(this).closest('tr').index();
            var oTable = $('#tblLocationPrinter').dataTable();
            var aData = oTable.fnGetData();
            var Data = aData[row];
            $('#hdnOrgAddressID').val(Data[3]);
            var OrgAddressID = $('#hdnOrgAddressID').val();
            jConfirm('Are you sure to delete a record?', 'Confirmation Dialog', function(ReturnResponse) {
                if (ReturnResponse == true) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "ClientManagement.aspx/RemovePrinterLocation",
                        data: "{'OrgID':'" + OrgId + "','OrgAddressID':'" + OrgAddressID + "'}",
                        dataType: "json",
                        success: function(data) {
                            GetPrinterDetails();
                            jAlert("Printer Removed Successfully..", 'Alert Box');
                        },
                        error: function(result) {
                            jAlert("Not Removed", 'Alert Box');
                        }
                    });
                }
            });
        });
        //Printer Details End

        function AddContactDetailsRow() {
            $("#tblContactDetails").show();
            $('#tblContactDetails_filter').removeClass('hide');

            var Action = '<a class="ui-icon ui-icon-pencil marginL5 pull-left marginR10 CDedit" title="Click to Edit" /><a class="ui-icon ui-icon-trash marginL5 pull-left CDremove" title="Click to Delete" />';
            if (btnUpdateConatctDetails == true) {
                $('#tblContactDetails').dataTable().fnUpdate([
                $('#ddlContactType :selected').text(),
                $('#txtSPOCName').val(),
                $('#txtMobileNo').val(),
                $('#txtLandlineNo').val(),
                $('#txtEmailId').val(),
                $('#txtFaxNo').val(),
                0,
                $('#ddlContactType').val(),
                Action
                ], UpdateConatctDetailsID);
                btnUpdateConatctDetails = false;
                UpdateConatctDetailsID = '';
            }
            else {
                if ($('#ddlContactType').val != 0) {
                    var Msg = 'N';
                    var oTable = $('#tblContactDetails').dataTable();
                    var aData = oTable.fnGetData();
                    for (var i = 0; i < aData.length; i++) {
                        var Data = aData[i];
                        if ($('#ddlContactType :selected').text() == Data[0] && $('#txtSPOCName').val() == Data[1] && $('#txtMobileNo').val() == Data[2] && $('#txtLandlineNo').val() == Data[3] && $('#txtEmailId').val() == Data[4] && $('#txtFaxNo').val() == Data[5]) {
                            Msg = 'Y'
                            break;
                        }
                    }
                    if (Msg != 'Y') {
                        $('#tblContactDetails').dataTable().fnAddData([
                $('#ddlContactType :selected').text(),
                $('#txtSPOCName').val(),
                $('#txtMobileNo').val(),
                $('#txtLandlineNo').val(),
                $('#txtEmailId').val(),
                $('#txtFaxNo').val(),
                0,
                $('#ddlContactType').val(),
                Action
                ]);
                    }
                    else {
                        jAlert("Duplicate..", 'Alert Box');
                    }
                }
                else {
                    jAlert("Select Contact Type", 'Alert Box');
                }
            }

            $('#ddlContactType').val(0);
            $('#txtSPOCName').val('');
            $('#txtMobileNo').val('');
            $('#txtLandlineNo').val('');
            $('#txtEmailId').val('');
            $('#txtFaxNo').val('');
            //$('#ChkIsPrimary').prop('checked', false);

        }
        $(document).on('click', '.CDedit', function() {
            var row = $(this).closest('tr').index();
            btnUpdateConatctDetails = true;
            UpdateConatctDetailsID = row;
            var oTable = $('#tblContactDetails').dataTable();
            var aData = oTable.fnGetData();
            var Data = aData[row];
            $("#ddlContactType option:contains(" + Data[0] + ")").attr('selected', 'selected');
            $('#txtSPOCName').val(Data[1]);
            $('#txtMobileNo').val(Data[2]);
            $('#txtLandlineNo').val(Data[3]);
            $('#txtEmailId').val(Data[4]);
            $('#txtFaxNo').val(Data[5]);
            //            if(Data[6] == 'Y'){
            //                $('#ChkIsPrimary').prop('checked', true);
            //            }
            //            else{
            //                $('#ChkIsPrimary').prop('checked', false);
            //            }            
        });
        $(document).on('click', '.CDremove', function() {
            var row = $(this).closest('tr');
            var nRow = row[0];
            jConfirm('Are you sure to delete a record?', 'Confirmation Dialog', function(ReturnResponse) {
                if (ReturnResponse == true) $('#tblContactDetails').dataTable().fnDeleteRow(nRow);
            });
        });
        function LoadContactDetails() {
            $("#tblContactDetails").show();
            $('#tblContactDetails_filter').removeClass('hide');

            var oTable = $('#tblContactDetails').dataTable();
            oTable.fnClearTable();
            var Action = '<a class="ui-icon ui-icon-pencil marginL5 pull-left marginR10 CDedit" title="Click to Edit" /><a class="ui-icon ui-icon-trash marginL5 pull-left CDremove" title="Click to Delete" />';
            var Values;
            var Data = $('#hdnContactDetails').val();
            var sData = Data.split('^');
            if (IstxtCopyFrom == 'Y') {
                for (var i = 0; i < sData.length - 1; i++) {
                    var Value = sData[i].split('~');
                    Values = [Value[1], Value[2], Value[6], Value[8], Value[5], Value[7], 0, Value[4], Action];
                    $('#tblContactDetails').dataTable().fnAddData(Values);
                }
            }
            else {
                for (var i = 0; i < sData.length - 1; i++) {
                    var Value = sData[i].split('~');
                    Values = [Value[1], Value[2], Value[6], Value[8], Value[5], Value[7], Value[3], Value[4], Action];
                    $('#tblContactDetails').dataTable().fnAddData(Values);
                }
            }
        }
        $('#btnAddContactDetails').click(function() {
            if (validateContactDetails() == true)
                AddContactDetailsRow();
        });
        ///Basic Details tab End

        ///Notification Tab Start
        $('#ddlCommunicationMode').change(function(event) {
            $("#txtmobilenumber").val('');
            if ($('#ddlCommunicationMode :selected').val() != 'Mail' && $('#ddlCommunicationMode :selected').val() != '0') {
                if ($('#ddlCommunicationMode :selected').val() == 'Fax')
                    $('#ddlmobile').hide();
                else
                    $('#ddlmobile').show();
                $("#txtmobilenumber").ValidationForNumeric();
                $("#txtmobilenumber").attr('maxlength', '10');
            }
            else {
                $('#ddlmobile').hide();
                $("#txtmobilenumber").unbind();
                $("#txtmobilenumber").attr('maxlength', '');
            }

        });

        $('#btnAddNotification').click(function() {

            if ($('#ddlCommunicationMode :selected').val() == 'Mail') {
                if (!IsEmail($('#txtmobilenumber').val())) {
                    jAlert("This Email Id is not valid", 'Alert Box')
                    return false;
                }
            }
            if (validateNotificationsDetails() == true) {
                AddNotificationDetails()
            }
        });
        function AddNotificationDetails() {

            $("#tblNotificationDetails").show();
            $('#tblNotificationDetails_filter').removeClass('hide');

            var NotifCombination = $('#ddlNotifications :selected').text() + ' ' + $('#ddlCommunicationMode :selected').text();
            var Action = '<a class="ui-icon ui-icon-pencil marginL5 pull-left marginR10 NTedit" title="Click to Edit" /><a class="ui-icon ui-icon-trash marginL5 pull-left NTremove" title="Click to Delete" />';
            var chk = $('#chkactive').is(":checked") ? "Y" : "N";
            if (btnUpdateNotificationDetails == true) {
                $('#tblNotificationDetails').dataTable().fnUpdate([
                $('#ddlNotifications :selected').text(),
                $('#ddlCommunicationMode :selected').text(),
                $('#txtmobilenumber').val(),
                chk,
                Action,
                NotifCombination
                ], UpdateNotificationDetailsID);
                btnUpdateNotificationDetails = false;
                UpdateNotificationDetailsID = '';
            }
            else {
                if ($('#ddlNotifications :selected').val() == '0' || $('#ddlCommunicationMode :selected').val() == '0') {
                    jAlert('Select the Notification Type');
                }
                else {
                    var Msg = 'N';
                    var oTable = $('#tblNotificationDetails').dataTable();
                    var aData = oTable.fnGetData();
                    for (var i = 0; i < aData.length; i++) {
                        var Data = aData[i];
                        if ($('#ddlNotifications :selected').text() == Data[0] && $('#ddlCommunicationMode :selected').text() == Data[1] && $('#txtmobilenumber').val() == Data[2] && chk == Data[3]) {
                            Msg = 'Y'
                            break;
                        }
                    }
                    if (Msg != 'Y') {
                        $('#tblNotificationDetails').dataTable().fnAddData([
                $('#ddlNotifications :selected').text(),
                $('#ddlCommunicationMode :selected').text(),
                $('#txtmobilenumber').val(),
                chk,
                Action,
                NotifCombination
                ]);
                    }
                    else {

                        jAlert("Duplicate..", 'Alert Box');
                    }
                }
            }

            $('#ddlNotifications').val(0);
            $('#ddlCommunicationMode').val(0);
            $('#txtmobilenumber').val('');
            $('#chkactive').prop('checked', false);



        }
        $(document).on('click', '.NTedit', function() {
            var row = $(this).closest('tr').index();
            btnUpdateNotificationDetails = true;
            UpdateNotificationDetailsID = row;
            var oTable = $('#tblNotificationDetails').dataTable();
            var aData = oTable.fnGetData();
            var Data = aData[row];
            $("#ddlNotifications option:contains(" + Data[0] + ")").attr('selected', 'selected');
            $("#ddlCommunicationMode option:contains(" + Data[1] + ")").attr('selected', 'selected');
            $('#txtmobilenumber').val(Data[2]);
            if (Data[3] == 'Y')
                $('#chkactive').prop('checked', true);
            else
                $('#chkactive').prop('checked', false);

        });
        $(document).on('click', '.NTremove', function() {
            var row = $(this).closest('tr');
            var nRow = row[0];
            jConfirm('Are you sure to delete a record?', 'Confirmation Dialog', function(ReturnResponse) {
                if (ReturnResponse == true) {
                    $('#tblNotificationDetails').dataTable().fnDeleteRow(nRow);
                }
            });
        });
        function LoadNotificationDetails() {
            $("#tblNotificationDetails").show();
            var oTable = $('#tblNotificationDetails').dataTable();
            oTable.fnClearTable();
            var Action = '<a class="ui-icon ui-icon-pencil marginL5 pull-left marginR10 NTedit" title="Click to Edit" /><a class="ui-icon ui-icon-trash marginL5 pull-left NTremove" title="Click to Delete" />';
            var Values;
            var Data = $('#hdnNotificationDetails').val();
            var sData = Data.split('^');
            for (var i = 0; i < sData.length - 1; i++) {
                var Value = sData[i].split('~');
                var Active = (Value[4] == 1) ? 'Y' : 'N';
                var Notiftxt = Value[2] + ' ' + Value[1];
                Values = [Value[2], Value[1], Value[3], Active, Action, Notiftxt];
                $('#tblNotificationDetails').dataTable().fnAddData(Values);
            }
        }
        ///Notification Tab End


        ///Communication Tab Start

        /*   function AddShippingDetailsRow() {
        $("#gbox_tblShippingDetails").show();
        //   $('#tblShippingDetails_filter').removeClass('hide');
        var ddlAddressType = $('#ddlAddressType :selected').text();
        var ddlAddressTypeID = $('#ddlAddressType :selected').val();
        var txtZipCode = $('#txtZipCode').val();
        var txtArea = $('#txtArea').val();
        var txtCity = $('#txtCity').val();
        var txtState = $('#ddlState :selected').text();
        var txtCountry = $('#ddlCountry :selected').text();
        var txtAddressLine1 = $('#txtAddressLine1').val();
        var txtAddressLine2 = $('#txtAddressLine2').val();
        var txtContactNo = $('#txtContactNo').val();
        var txtLandlineNo1 = $('#txtLandlineNo1').val();
        var txtEmailId1 = $('#txtEmailId1').val();
        var ddlCountryID = $('#ddlCountry :selected').val();
        var ddlStateID = $('#ddlState :selected').val();
        var chk = $('#chkPrimary1').is(":checked") ? "Y" : "N";

            var Action = '<a class="ui-icon ui-icon-pencil marginL5 pull-left marginR10 SDedit" title="Click to Edit" /><a class="ui-icon ui-icon-trash marginL5 pull-left SDremove" title="Click to Delete" />';

            // if (validateShippingDetails() == true) {

            if (btnUpdateShippingDetails == true) {
        //                $('#tblShippingDetails').dataTable().fnUpdate([
        //         ddlAddressType, txtZipCode, txtArea, txtCity, txtState, txtCountry, txtAddressLine1, txtAddressLine2, txtContactNo, txtLandlineNo1, txtEmailId1, chk, 0, Action], UpdateShippingDetailsID);
        $('#tblShippingDetails').jqGrid('setRowData', UpdateShippingDetailsID, { ADDRESSTYPE: ddlAddressType, ZIPCODE: txtZipCode, AREA: txtArea, CITY: txtCity, STATE: txtState, COUNTRY: txtCountry, ADD1: txtAddressLine1, ADD2: txtAddressLine2, CONTACTNO: txtContactNo, LAND: txtLandlineNo1, EMAILID: txtEmailId1, ACTIVE: chk, ACTION: Action, AddressTypeID: ddlAddressTypeID, CountryID: ddlCountryID, StateID: ddlStateID });
        MergeRemoveStyle();
        MergeGrid();
        btnUpdateShippingDetails = false;
        UpdateShippingDetailsID = '';
        clearShipping();
        }
        else {

                var Msg = 'N';
        var Data = $("#tblShippingDetails").jqGrid('getGridParam', 'data');
        for (var i = 0; i < Data.length; i++) {
        if (ddlAddressType == Data[i].ADDRESSTYPE && txtZipCode == Data[i].ZIPCODE && txtArea == Data[i].AREA && txtCity == Data[i].CITY && txtState == Data[i].STATE && txtCountry == Data[i].COUNTRY && txtAddressLine1 == Data[i].ADD1 && txtAddressLine2 == Data[i].ADD2 && txtContactNo == Data[i].CONTACTNO && txtLandlineNo1 == Data[i].LAND && txtEmailId1 == Data[i].EMAILID && chk == Data[i].ACTIVE) {
        Msg = 'Y';
        break;
        }
        }

                if (Msg != 'Y') {
        var gridID = parseInt($('#tblShippingDetails').getDataIDs().length) + 1;
        $("#tblShippingDetails").addRowData(gridID, { ADDRESSTYPE: ddlAddressType, ZIPCODE: txtZipCode, AREA: txtArea, CITY: txtCity, STATE: txtState, COUNTRY: txtCountry, ADD1: txtAddressLine1, ADD2: txtAddressLine2, CONTACTNO: txtContactNo, LAND: txtLandlineNo1, EMAILID: txtEmailId1, ACTIVE: chk, ACTION: Action, AddressTypeID: ddlAddressTypeID, AddressID: 0, CountryID: ddlCountryID, StateID: ddlStateID });
        Merge();
        clearShipping();
        }
        else {
        jAlert('Duplicate Record..');
        }

            }
        }*/

        function AddShippingDetailsRow() {
            $("#tblShippingDetails").show();
            $('#tblShippingDetails_filter').removeClass('hide');
            var ddlAddressType = $('#ddlAddressType :selected').text();
            var ddlAddressTypeID = $('#ddlAddressType :selected').val();
            var txtZipCode = $('#txtZipCode').val();
            var txtArea = $('#txtArea').val();
            var txtCity = $('#txtCity').val();
            var txtState = $('#ddlState :selected').text();
            var txtCountry = $('#ddlCountry :selected').text();
            var txtAddressLine1 = $('#txtAddressLine1').val();
            var txtAddressLine2 = $('#txtAddressLine2').val();
            var txtContactNo = $('#txtContactNo').val();
            var txtLandlineNo1 = $('#txtLandlineNo1').val();
            var txtEmailId1 = $('#txtEmailId1').val();
            var ddlCountryID = $('#ddlCountry :selected').val();
            var ddlStateID = $('#ddlState :selected').val();
            var chk = $('#chkPrimary1').is(":checked") ? "Y" : "N";
            var Action = '<a class="ui-icon ui-icon-pencil marginL5 pull-left marginR10 SDedit" title="Click to Edit" /><a class="ui-icon ui-icon-trash marginL5 pull-left SDremove" title="Click to Delete" />';
            var AddressID = $('#hdnShippingAddID').val();
            if (btnUpdateShippingDetails == true) {
                $('#tblShippingDetails').dataTable().fnUpdate([ddlAddressType, txtZipCode, txtArea, txtCity, txtState, txtCountry, txtAddressLine1, txtAddressLine2, txtContactNo, txtLandlineNo1, txtEmailId1, chk, Action, ddlAddressTypeID, AddressID, ddlCountryID, ddlStateID], UpdateShippingDetailsID);

                btnUpdateShippingDetails = false;
                UpdateShippingDetailsID = '';
                clearShipping();
            }
            else {

                var Msg = 'N';
                var oTable = $('#tblShippingDetails').dataTable();
                var aData = oTable.fnGetData();
                for (var i = 0; i < aData.length; i++) {
                    var Data = aData[i];
                    if (ddlAddressType == Data[0] && txtZipCode == Data[1] && txtArea == Data[2] && txtCity == Data[3] && txtState == Data[4] && txtCountry == Data[5] && txtAddressLine1 == Data[6] && txtAddressLine2 == Data[7] && txtContactNo == Data[8] && txtLandlineNo1 == Data[9] && txtEmailId1 == Data[10] && chk == Data[11]) {
                        Msg = 'Y'
                        break;
                    }
                }
                if (Msg != 'Y') {
                    $('#tblShippingDetails').dataTable().fnAddData([ddlAddressType, txtZipCode, txtArea, txtCity, txtState, txtCountry, txtAddressLine1, txtAddressLine2, txtContactNo, txtLandlineNo1, txtEmailId1, chk, Action, ddlAddressTypeID, 0, ddlCountryID, ddlStateID]);
                    clearShipping();
                }
                else {
                    jAlert("Duplicate..", 'Alert Box');
                }

            }
        }
        function clearShipping() {
            $('#ddlAddressType').val(0);
            $('#txtZipCode').val(''),
            $('#txtArea').val(''),
            $('#txtCity').val(''),
            $('#ddlState').val(0),
            $('#ddlCountry').val(0),
            $('#txtAddressLine1').val(''),
            $('#txtAddressLine2').val(''),
            $('#txtContactNo').val(''),
            $('#txtLandlineNo1').val(''),
            $('#txtEmailId1').val(''),
            $('#chkPrimary1').prop('checked', false);
        }

        //        function Merge() {

        //            var IsCheck = false;
        //            var cellcnt = 0;
        //            var table = document.getElementById("tblShippingDetails");
        //            var temple2 = table.rows[table.rows.length - 1];
        //            for (var i = 1; i < table.rows.length - 1; i++) {
        //                var temple = table.rows[i];
        //                if (temple.cells[0].innerHTML == temple2.cells[0].innerHTML && temple.cells[1].innerHTML == temple2.cells[1].innerHTML && temple.cells[2].innerHTML == temple2.cells[2].innerHTML && temple.cells[3].innerHTML == temple2.cells[3].innerHTML && temple.cells[4].innerHTML == temple2.cells[4].innerHTML && temple.cells[5].innerHTML == temple2.cells[5].innerHTML && temple.cells[6].innerHTML == temple2.cells[6].innerHTML && temple.cells[7].innerHTML == temple2.cells[7].innerHTML) {
        //                    while (cellcnt < 8) {
        //                        temple.cells[cellcnt].rowSpan = 1 + parseInt(temple.cells[cellcnt].rowSpan);
        //                        temple2.cells[cellcnt].style.display = "none";
        //                        cellcnt = cellcnt + 1;
        //                    }
        //                    IsCheck = true;

        //                }


        //                if (IsCheck == true) {
        //                    break;
        //                }
        //            }

        //            return false;
        //        }

        //        function MergeRemoveStyle() {
        //            var IsCheck = false;

        //            var table = document.getElementById("tblShippingDetails");
        //            for (var i = 1; i <= table.rows.length - 1; i++) {
        //                var cellcnt = 0;
        //                var temple = table.rows[i];
        //                while (cellcnt < 8) {
        //                    temple.cells[cellcnt].rowSpan = 0;
        //                    temple.cells[cellcnt].style.display = "table-cell";
        //                    cellcnt = cellcnt + 1;
        //                }
        //            }
        //            return false;
        //        }


        //        function MergeEdit(Id1, Id2) {
        //            var $row = $('#' + Id1).detach();
        //            $row.insertAfter('#' + Id2);
        //        }
        //        function MergeGrid() {


        //            var table = document.getElementById("tblShippingDetails");
        //            MergeRemoveStyle();
        //            for (var i = 1; i < table.rows.length - 1; i++) {
        //                var temple = table.rows[i];
        //                var IsCheck = false;
        //                var W = 2;
        //                if (i > 1) W = i;
        //                for (var j = i + 1; j <= table.rows.length - 1; j++) {
        //                    var temple2 = table.rows[j];
        //                    var cellcnt = 0;
        //                    if (temple.cells[0].innerHTML == temple2.cells[0].innerHTML && temple.cells[1].innerHTML == temple2.cells[1].innerHTML && temple.cells[2].innerHTML == temple2.cells[2].innerHTML && temple.cells[3].innerHTML == temple2.cells[3].innerHTML && temple.cells[4].innerHTML == temple2.cells[4].innerHTML && temple.cells[5].innerHTML == temple2.cells[5].innerHTML && temple.cells[6].innerHTML == temple2.cells[6].innerHTML && temple.cells[7].innerHTML == temple2.cells[7].innerHTML) {

        //                        if (j === i + 1 || j === W || j === W + 1) {
        //                            while (cellcnt < 8) {
        //                                temple.cells[cellcnt].rowSpan = 1 + parseInt(temple.cells[cellcnt].rowSpan);
        //                                temple2.cells[cellcnt].style.display = "none";
        //                                cellcnt = cellcnt + 1;
        //                            }
        //                            W += 1;

        //                        }
        //                        else {
        //                            MergeRemoveStyle();
        //                            MergeEdit(j, i);
        //                            IsCheck = true;
        //                            MergeEditStatus = true;
        //                            //break;
        //                        }
        //                    }

        //                }
        //                if (W > 2) {
        //                    for (k = i + 1; k < W; k++)
        //                        i += 1;
        //                }

        //                if (IsCheck == true) {
        //                    break;
        //                }
        //            }
        //            return false;
        //        }

        /*  $(document).on('click', '.SDedit', function() {
        //            var row = $(this).closest('tr').index();
        var row = $(this).closest('tr').attr('id');
        btnUpdateShippingDetails = true;
        UpdateShippingDetailsID = row;
        //            var oTable = $('#tblShippingDetails').dataTable();
        //            var aData = oTable.fnGetData();
        var Data = $("#tblShippingDetails").getRowData(row);
        //  var Data = aData[row];
        $("#ddlAddressType option:contains(" + Data["ADDRESSTYPE"] + ")").attr('selected', 'selected');
        $('#txtZipCode').val(Data["ZIPCODE"]);
        $('#txtArea').val(Data["AREA"]);
        $('#txtCity').val(Data["CITY"]);
        $("#ddlCountry option:contains(" + Data["COUNTRY"] + ")").attr('selected', 'selected');
        $('#hdnStateID').val(Data["StateID"]);
        LoadState();
        //$("#ddlState option:contains(" + Data["STATE"] + ")").attr('selected', 'selected');
        $('#txtAddressLine1').val(Data["ADD1"]);
        $('#txtAddressLine2').val(Data["ADD2"]);
        $('#txtContactNo').val(Data["CONTACTNO"]);
        $('#txtLandlineNo1').val(Data["LAND"]);
        $('#txtEmailId1').val(Data["EMAILID"]);
        if (Data["ACTIVE"] == 'Y') {
        $('#chkPrimary1').prop('checked', true);
        }
        else {
        $('#chkPrimary1').prop('checked', false);
        }
        });
        */
        $(document).on('click', '.SDedit', function() {
            var row = $(this).closest('tr').index();

            btnUpdateShippingDetails = true;
            UpdateShippingDetailsID = row;
            var oTable = $('#tblShippingDetails').dataTable();
            var aData = oTable.fnGetData();
            var Data = aData[row];
            $("#ddlAddressType option:contains(" + Data[0] + ")").attr('selected', 'selected');
            $('#txtZipCode').val(Data[1]);
            $('#txtArea').val(Data[2]);
            $('#txtCity').val(Data[3]);
            $("#ddlCountry option:contains(" + Data[5] + ")").attr('selected', 'selected');
            $('#hdnStateID').val(Data[16]);
            LoadState();
            $('#txtAddressLine1').val(Data[6]);
            $('#txtAddressLine2').val(Data[7]);
            $('#txtContactNo').val(Data[8]);
            $('#txtLandlineNo1').val(Data[9]);
            $('#txtEmailId1').val(Data[10]);
            if (Data[11] == 'Y') {
                $('#chkPrimary1').prop('checked', true);
            }
            else {
                $('#chkPrimary1').prop('checked', false);
            }
            $('#hdnShippingAddID').val(Data[14]);
        });
        //        $(document).on('click', '.SDremove', function() {
        //            //            var row = $(this).closest('tr');
        //            //            var nRow = row[0];
        //            //nRowId = $(this).closest('tr').index();
        //            nRowId = $(this).closest('tr').attr('id');
        //            jConfirm('Are you sure to delete a record?', 'Confirmation Dialog', function(ReturnResponse) {
        //                if (ReturnResponse == true) {
        //                    $('#tblShippingDetails').jqGrid('delRowData', nRowId);
        //                    MergeRemoveStyle();
        //                    MergeGrid();
        //                }

        //            });
        //        });


        $(document).on('click', '.SDremove', function() {
            var row = $(this).closest('tr');
            var nRow = row[0];
            jConfirm('Are you sure to delete a record?', 'Confirmation Dialog', function(ReturnResponse) {
                if (ReturnResponse == true) $('#tblShippingDetails').dataTable().fnDeleteRow(nRow);
            });
        });
        //        function LoadShippingDetails() {
        //            $("#gbox_tblShippingDetails").show();
        //            //            $('#tblShippingDetails_filter').removeClass('hide');
        //            //            var oTable = $('#tblShippingDetails').dataTable();
        //            //            oTable.fnClearTable();
        //            $("#tblShippingDetails").jqGrid("clearGridData");
        //            var Action = '<a class="ui-icon ui-icon-pencil marginL5 pull-left marginR10 SDedit" title="Click to Edit" /><a class="ui-icon ui-icon-trash marginL5 pull-left SDremove" title="Click to Delete" />';
        //            var Values;
        //            var Data = $('#hdnShippingDetails').val();
        //            var sData = Data.split('^');
        //            if (IstxtCopyFrom == 'Y') {
        //                for (var i = 0; i < sData.length - 1; i++) {
        //                    var Value = sData[i].split('~');
        //                    //Values = [Value[11], 'zip', Value[2], Value[1], 'state', 'Country', Value[0], 'Add 2', Value[12], Value[4], Value[3], Value[7], Value[8], Action];
        //                    //$('#tblShippingDetails').dataTable().fnAddData(Values);
        //                    var gridID = parseInt($('#tblShippingDetails').getDataIDs().length) + 1;
        //                    $("#tblShippingDetails").addRowData(gridID, { ADDRESSTYPE: Value[1], ZIPCODE: Value[14], AREA: Value[17], CITY: Value[2], STATE: Value[15], COUNTRY: Value[16], ADD1: Value[5], ADD2: Value[6], CONTACTNO: Value[11], LAND: Value[7], EMAILID: Value[12], ACTIVE: Value[13], ACTION: Action, AddressTypeID: Value[9], AddressID: 0, CountryID: Value[4], StateID: Value[3] });
        //                }
        //            }
        //            else {
        //                for (var i = 0; i < sData.length - 1; i++) {
        //                    var Value = sData[i].split('~');
        //                    //Values = [Value[11], 'zip', Value[2], Value[1], 'state', 'Country', Value[0], 'Add 2', Value[12], Value[4], Value[3], Value[7], Value[8], Action];
        //                    //$('#tblShippingDetails').dataTable().fnAddData(Values);
        //                    var gridID = parseInt($('#tblShippingDetails').getDataIDs().length) + 1;
        //                    $("#tblShippingDetails").addRowData(gridID, { ADDRESSTYPE: Value[1], ZIPCODE: Value[14], AREA: Value[17], CITY: Value[2], STATE: Value[15], COUNTRY: Value[16], ADD1: Value[5], ADD2: Value[6], CONTACTNO: Value[11], LAND: Value[7], EMAILID: Value[12], ACTIVE: Value[13], ACTION: Action, AddressTypeID: Value[9], AddressID: Value[10], CountryID: Value[4], StateID: Value[3] });
        //                }
        //            }
        //            MergeGrid();
        //        }
        function LoadShippingDetails() {
            $("#tblShippingDetails").show();
            $('#tblShippingDetails_filter').removeClass('hide');

            var oTable = $('#tblShippingDetails').dataTable();
            oTable.fnClearTable();
            var Action = '<a class="ui-icon ui-icon-pencil marginL5 pull-left marginR10 SDedit" title="Click to Edit" /><a class="ui-icon ui-icon-trash marginL5 pull-left SDremove" title="Click to Delete" />';
            var Values;
            var Data = $('#hdnShippingDetails').val();
            var sData = Data.split('^');
            if (IstxtCopyFrom == 'Y') {
                for (var i = 0; i < sData.length - 1; i++) {
                    var Value = sData[i].split('~');
                    Values = [Value[1], Value[14], Value[17], Value[2], Value[15], Value[16], Value[5], Value[6], Value[11], Value[7], Value[12], Value[13], Action, Value[9], 0, Value[4], Value[3]];
                    $('#tblShippingDetails').dataTable().fnAddData(Values);
                }
            }
            else {
                for (var i = 0; i < sData.length - 1; i++) {
                    var Value = sData[i].split('~');
                    Values = [Value[1], Value[14], Value[17], Value[2], Value[15], Value[16], Value[5], Value[6], Value[11], Value[7], Value[12], Value[13], Action, Value[9], Value[10], Value[4], Value[3]];
                    $('#tblShippingDetails').dataTable().fnAddData(Values);
                }
            }
        }




        $('#btnAddShippingDetails').click(function() {
            if (validateShippingDetails() == true) {
                AddShippingDetailsRow();
            }
        });

        //Communication Tab END


        //Commercial Details Tab Start
        //Tax Details
        $('#btnAddTaxDetails').click(function() {
            AddTaxDetailsRow();
        });


        function AddTaxDetailsRow() {
            if (validateTaxDetails() == true) {
                $("#tblTaxDetails").show();
                $("#trTax").show();
                $('#tblTaxDetails_filter').removeClass('hide');
                var chk = $('#chkIsActive').is(":checked") ? "Y" : "N";
                var Action = '<a class="ui-icon ui-icon-pencil marginL5 pull-left marginR10 TaxDedit" title="Click to Edit" /><a class="ui-icon ui-icon-trash marginL5 pull-left TaxDremove" title="Click to Delete" />';
                if (btnUpdateCommercialTaxDetails == true) {
                    $('#tblTaxDetails').dataTable().fnUpdate([
                $('#ddlTaxDetails').val(),
                $('#ddlTaxDetails :selected').text(),
                $('#txtSequence').val(),
                chk,
                Action
                ], UpdateCommercialTaxDetailsID);
                    btnUpdateCommercialTaxDetails = false;
                    UpdateCommercialTaxDetailsID = '';
                }
                else {
                    var Msg = 'N';
                    var oTable = $('#tblTaxDetails').dataTable();
                    var aData = oTable.fnGetData();
                    for (var i = 0; i < aData.length; i++) {
                        var Data = aData[i];
                        if ($('#ddlTaxDetails :selected').text() == Data[0]) {
                            Msg = 'Y'
                            errorMsg = Data[0];
                            break;
                        }
                        else if ($('#txtSequence').val() == Data[1]) {
                            Msg = 'Y'
                            errorMsg = Data[1];
                            break;
                        }
                    }
                    if (Msg != 'Y') {
                        $('#tblTaxDetails').dataTable().fnAddData([
                             $('#ddlTaxDetails').val(),
                $('#ddlTaxDetails :selected').text(),
                $('#txtSequence').val(),
                chk,
                Action
                ]);
                    }
                    else {
                        jAlert(errorMsg + ' already added.');
                    }
                }
                $('#ddlTaxDetails').val(0);
                $('#txtSequence').val('');
                $('#chkIsActive').prop('checked', false);
            }
        }
        $(document).on('click', '.TaxDedit', function() {
            var row = $(this).closest('tr').index();
            btnUpdateCommercialTaxDetails = true;
            UpdateCommercialTaxDetailsID = row;
            var oTable = $('#tblTaxDetails').dataTable();
            var aData = oTable.fnGetData();
            var Data = aData[row];
            $("#ddlTaxDetails option:contains(" + Data[1] + ")").attr('selected', 'selected');
            $('#txtSequence').val(Data[2]);
            if (Data[3] == 'Y') {
                $('#chkIsActive').prop('checked', true);
            }
            else {
                $('#chkIsActive').prop('checked', false);
            }
        });
        $(document).on('click', '.TaxDremove', function() {
            var row = $(this).closest('tr');
            var nRow = row[0];
            jConfirm('Are you sure to delete a record?', 'Confirmation Dialog', function(ReturnResponse) {
                if (ReturnResponse == true) $('#tblTaxDetails').dataTable().fnDeleteRow(nRow);

            });
        });

        function LoadTaxdetails() {
            $("#tblTaxDetails").show();
            $("#trTax").show();
            var oTable = $('#tblTaxDetails').dataTable();
            oTable.fnClearTable();
            var Action = '<a class="ui-icon ui-icon-pencil marginL5 pull-left marginR10 TaxDedit" title="Click to Edit" /><a class="ui-icon ui-icon-trash marginL5 pull-left TaxDremove" title="Click to Delete" />';
            var Values;
            var Data = $('#hdnTaxDetails').val();
            var sData = Data.split('^');
            for (var i = 0; i < sData.length - 1; i++) {
                var Value = sData[i].split('|');
                Values = [Value[3], Value[0], Value[1], Value[2], Action];
                $('#tblTaxDetails').dataTable().fnAddData(Values);
            }
            $('#chkIsActive').prop('checked', false);
        }

        //Discount Details
        function LoadDiscountdetails() {
            $("#tblCommercialDetails").show();
            $('#tblCommercialDetails_filter').removeClass('hide');

            var oTable = $('#tblCommercialDetails').dataTable();
            oTable.fnClearTable();
            var Action = '<a class="ui-icon ui-icon-pencil marginL5 pull-left CommDedit" title="Click to Edit" /><a class="ui-icon ui-icon-trash marginL5 pull-left CommDremove" title="Click to Delete" />';
            var Values;
            var Data = $('#hdnDiscountDetails').val();
            var sData = Data.split('^');
            for (var i = 0; i < sData.length - 1; i++) {
                var Value = sData[i].split('|');
                if (Value[5] == 1)
                    Value[5] = 'Y';
                else
                    Value[5] = 'N';
                Values = [Value[6], Value[7], Value[2], Value[3], Value[4], Value[5], Value[1], Action];
                $('#tblCommercialDetails').dataTable().fnAddData(Values);
            }
        }
        $('#btnAddPolicy').click(function() {
            var FromDate = $('#txtFrom').val().split('/');
            var Fdate = FromDate[2] + '/' + FromDate[1] + '/' + (parseInt(FromDate[0], 10) % 100);
            var startDate = new Date(Fdate);

            var FromTo = $('#txtTo').val().split('/');
            var FTo = FromTo[2] + '/' + FromTo[1] + '/' + (parseInt(FromTo[0], 10) % 100);
            var EndDate = new Date(FTo);
            if (startDate < EndDate) AddCommercialDetailsRow();
            else jAlert('To Date Should be grater than the From Date', 'Alert Box');
        });

        function AddCommercialDetailsRow() {
            $('#tblCommercialDetails_filter').removeClass('hide');
            $("#tblCommercialDetails").show();
            if (validateCommercialDetails() == true) {
                var chk = $('#chkPolicyIsActive').is(":checked") ? "Y" : "N";
                var Action = '<a class="ui-icon ui-icon-pencil marginL5 pull-left CommDedit" title="Click to Edit" /><a class="ui-icon ui-icon-trash marginL5 pull-left CommDremove" title="Click to Delete" />';
                if (btnUpdateCommercialDetails == true) {
                    $('#tblCommercialDetails').dataTable().fnUpdate([
                        $('#ddlType option:selected').text(),
                        $('#txtPolicy').val(),
                        $('#hdnPolicyID').val(),
                        $('#txtFrom').val(),
                        $('#txtTo').val(),
                        chk,
                        $('#ddlType').val(),
                        Action], UpdateCommercialDetailsID);
                    btnUpdateCommercialDetails = false;
                    UpdateCommercialDetailsID = '';
                }
                else {
                    var Msg = 'N';
                    var oTable = $('#tblCommercialDetails').dataTable();
                    var aData = oTable.fnGetData();
                    for (var i = 0; i < aData.length; i++) {
                        var Data = aData[i];
                        var FromDate = $('#txtFrom').val().split('/');
                        var Fdate = FromDate[2] + '/' + FromDate[1] + '/' + (parseInt(FromDate[0], 10) % 100);
                        var startDate = new Date(Fdate);

                        var FromTo = Data[3].split('/');
                        var FTo = FromTo[2] + '/' + FromTo[1] + '/' + (parseInt(FromTo[0], 10) % 100);
                        var EndDate = new Date(FTo);
                        if ($('#ddlType option:selected').text() == Data[0] && $('#txtPolicy').val().trim() == Data[1].trim() && $('#txtFrom').val() == Data[3] && $('#txtTo').val() == Data[4]) {
                            Msg = 'Y';
                            break;
                        }

                        else if ($('#hdnDiscountconfigVal').val() === "N") {

                            if ($('#ddlType option:selected').text() === Data[0]) {

                                Msg = 'SSS';
                                break;
                            }


                        }
                        else {
                            if ($('#ddlType option:selected').text() == Data[0] && $('#txtPolicy').val().trim() == Data[1].trim() && EndDate > startDate) {
                                Msg = 'S';
                                break;
                            }

                        }
                    }
                    if (Msg != 'Y' && Msg != 'S' && Msg != 'SSS') {
                        $('#tblCommercialDetails').dataTable().fnAddData([
                    $('#ddlType option:selected').text(),
                    $('#txtPolicy').val(),
                    $('#hdnPolicyID').val(),
                    $('#txtFrom').val(),
                    $('#txtTo').val(),
                    chk,
                    $('#ddlType').val(),
                    Action
                ]);
                    }
                    else {
                        if (Msg == 'Y') jAlert("Same Entry", "Alert Box")
                        else if (Msg == 'S') jAlert("Please Validity dates", "Alert Box")
                        else if (Msg === 'SSS') jAlert("Only Single Entry is Allowed", "Alert Box");
                    }
                }
            }
            $('#ddlType').val(0);
            $('#txtPolicy').val('');
            $('#hdnPolicyID').val('');
            $('#txtFrom').val('');
            $('#txtTo').val('');
            $('#chkPolicyIsActive').prop('checked', false);

        }

        $(document).on('click', '.CommDedit', function() {
            var row = $(this).closest('tr').index();
            btnUpdateCommercialDetails = true;
            UpdateCommercialDetailsID = row;
            var oTable = $('#tblCommercialDetails').dataTable();
            var aData = oTable.fnGetData();
            var Data = aData[row];
            $("#ddlType option:contains(" + Data[0] + ")").attr('selected', 'selected');
            $('#txtPolicy').val(Data[1]);
            $('#hdnPolicyID').val(Data[2]);
            $('#txtFrom').val(Data[3]);
            $('#txtTo').val(Data[4]);
            if (Data[5] == 'Y')
                $('#chkPolicyIsActive').prop('checked', true);
            else
                $('#chkPolicyIsActive').prop('checked', false);


        });
        $(document).on('click', '.CommDremove', function() {
            var row = $(this).closest('tr');
            var nRow = row[0];
            jConfirm('Are you sure to delete a record?', 'Confirmation Dialog', function(ReturnResponse) {
                if (ReturnResponse == true) $('#tblCommercialDetails').dataTable().fnDeleteRow(nRow);
            });
        });
        //Commercial Details Tab End

        //CreditControl Details Tab Start
        $('#ddlPaymentCategory').bind('change', function() {
            $('#ddlAdvanceThreshold').val('0');
            $('#txtValue').val('');
            $('#txtMinimumDeposite').val('');
            if ($('#ddlPaymentCategory').val() == 'CASHADV') $('#trClientDeposit').show();
            else $('#trClientDeposit').hide();
        });


        $('#ddlClientStatus').bind('change', function() {
            $('#txtFromDate').val('');
            $('#txtToDate').val('');
            if ($('#ddlClientStatus').val() == 'T' || $('#ddlClientStatus').val() == 'S') {
                $('#tdHideDate').show();
                if (IsNewClient != 'Y') jAlert('Status is Changed from Active to Inactive');
            }
            else { $('#tdHideDate').hide(); }
        });

        //CreditControl Details Tab End


        /// Final Save Option with Reason
        var jsonStringBasicDetails = [], ContactAddressDetails = [], jsonStringCredit = [], XmlAttributes = [], StrDocjson = [], jsonStringContactAndShippingTblDetails = [], jsonStringNotification = [], jsonStringDiscount = [], jsonStringTax = [], Reportobj = [];
        $('#btnFinalSave').click(function() {
            if (FinalSaveValidation()) {
                jsonStringBasicDetails.length = 0;
                ContactAddressDetails.length = 0;
                //ContactShippingDetails.length = 0;
                XmlAttributes.length = 0;
                jsonStringCredit.length = 0;
                StrDocjson.length = 0;
                jsonStringContactAndShippingTblDetails.length = 0;
                jsonStringNotification.length = 0;
                jsonStringDiscount.length = 0;
                jsonStringTax.length = 0;
                Reportobj.length = 0;
                //Report Tab
                var ddlDescription = $('#ddlDescription').val();
                var ddlStationery = $('#ddlStationery').val();
                GenerateAllUTD();

                if ($('#hdnClientCode').val() == 0) $('#hdnClientCode').val($('#txtClientCode').val());
                if ($('#hdnClientName').val() == 0) $('#hdnClientName').val($('#txtClientName1').val());
                var ReportFrom = $('#txtReportPrintDate').val().split('/');
                var RFdate = ReportFrom[2] + '-' + ReportFrom[1] + '-' + ReportFrom[0];

                var parameters = {
                    Details: [
            {
                AttributeDetails: XmlAttributes,
                ClientID: $('#hdnClientID').val(),
                ClientCode: $('#hdnClientCode').val(),
                ClientName: $('#hdnClientName').val(),
                ReportTemplateID: ddlDescription,
                ReportPrintdate: RFdate === 'undefined-undefined-' ? GetCurrentDate() : RFdate,
                Termsconditions: $('#txtTermAndConditions').val(),
                ReasonForUpdate: $('#ddlReasonForSave option:selected').text(),
                TabDesiable: 'tabCMBasic(True)~tabCMCommunication(True)~tabCMNotification(True)~tabCMReport(True)~tabCMCommercial(True)~tabCMCredit(True)~tabCMAttributes(True)~tabCMDocuments(True)'
            }
                  ],
                    lstBasicDetails: jsonStringBasicDetails,
                    lstContactcAndShipping: jsonStringContactAndShippingTblDetails,
                    lstCreditDetails: jsonStringCredit,
                    lstClientCommunication: jsonStringNotification,
                    lstTaxDetails: jsonStringTax,
                    lstDiscountPolicy: jsonStringDiscount,
                    lstClientAttributes: Reportobj,
                    lstDocUpload: StrDocjson
                };


                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "ClientManagement.aspx/btnFinalSaveContents",
                    data: JSON.stringify(parameters),
                    dataType: "json",
                    success: function(data) {
                        var RedirectDetails = data.d;
                        var Values = RedirectDetails.split('~');
                        var cltID = $('#hdnClientID').val() != 0 ? $('#hdnClientID').val() : Values[2];
                        var returnCode = Values[3];
                        var cltCode = Values[1];
                        var cltName = Values[0];
                        var OrgID = OrgId;
                        var OrgAddID = ILocationID;
                        if (returnCode != 1001) {
                            //if ($('#hdnClientID').val() != 0 && $('#hdnClientID').val() != undefined)
                            var IsNextAction = $('#ddlNextAction').val();
                            jAlert("Records Saved Successfully...", 'Alert Box');
                            if (IsNextAction != 0 && IsNextAction != undefined) {
                                if (IsNextAction == 1) {
                                    var link = document.createElement('a');
                                    link.href = '../Admin/ClientRateMapping.aspx?ClientID=' + cltID + '&ClientCode=' + cltCode + '&ClientName=' + cltName + '&OrgID=' + OrgID + '&OrgAddressID=' + OrgAddID;
                                    document.body.appendChild(link);
                                    link.click();
                                }
                                else if (IsNextAction == 2) {
                                    var link = document.createElement('a');
                                    link.href = '../Admin/SpecialRateCard.aspx?ClientID=' + cltID + '&ClientCode=' + cltCode + '&ClientName=' + cltName + '&OrgID=' + OrgID + '&OrgAddressID=' + OrgAddID;
                                    document.body.appendChild(link);
                                    link.click();
                                }
                                //window.location.href = '../Admin/RatesUpdation.aspx?ClientID=' + cltID + '&ClientCode=' + cltCode + '&ClientName=' + cltName + '&OrgID=' + OrgID + '&OrgAddressID=' + OrgAddID;

                            }
                            Clear();
                            if (IsNewClient == 'Y') {
                                $('#lblReasonforAmend').show();
                                $('#ddlReasonForSave').show();
                            }
                            IsNewClient = 'N';
                            $('#txtClientName').show();
                            $('#txtClientName1').hide();
                            $('#trCopyDetails').hide();
                            $('#btnAddNewClient').show();
                        }
                        else {
                            jAlert("Details was not saved.\n Some thing went Wrong.", 'Alert Box');
                        }
                    },
                    error: function(result) {
                        jAlert("Error", 'Alert Box');
                    }
                });
            }
            return false;
        });

        //Push UTD JSON for All Jquery DataTable

        function GenerateAllUTD() {
            //Basic Contact Details Grid
            var obj = [];
            var HasParaent, ccLabReport;
            var data = new Array(2);
            var Contactdatatable = $('#tblContactDetails').DataTable();

            // basic  basic and communication

            //Basic And Communication UDT Start
            var datatable = $('#tblContactDetails').DataTable();
            datatable.rows().every(function(rowIdx, tableLoop, rowLoop) {
                data = this.data();
                var tmpContactAddress = new Object();
                //return false;
                tmpContactAddress['AddressID'] = data[6];
                tmpContactAddress[' AddressTypeID'] = 0;
                tmpContactAddress['ReferenceID'] = $('#hdnClientID').val();
                tmpContactAddress['ReferenceType'] = "";
                tmpContactAddress['Address1'] = "";
                tmpContactAddress['City'] = "";
                tmpContactAddress['CountryID'] = 75;
                tmpContactAddress['StateID'] = 262;
                tmpContactAddress['EmailID'] = data[4];
                tmpContactAddress['Phone'] = data[3];
                tmpContactAddress['Mobile'] = data[2];
                tmpContactAddress['FaxNumber'] = data[5];
                tmpContactAddress['IsCommunication'] = "";
                tmpContactAddress['ISDCode'] = 0;
                tmpContactAddress['Name'] = data[1];
                tmpContactAddress['ContactType'] = data[7];
                tmpContactAddress['EmpID'] = 0;
                tmpContactAddress['SubUrban'] = "";
                tmpContactAddress['Address2'] = "";
                jsonStringContactAndShippingTblDetails.push(tmpContactAddress);
            });
            //            var RowLength = $('#tblShippingDetails tbody').find('tr').length;
            //                for (var i = 1; i < RowLength; i++) {
            //                var tmpShippingDeatils = {};
            //                // ContactShippingDetails += $('#tblShippingDetails tbody').find('tr')[i].cells[j].innerText + '|';
            //                tmpShippingDeatils['AddressID'] = $('#tblShippingDetails tbody').find('tr')[i].cells[14].innerText,
            //                          tmpShippingDeatils['AddressTypeID'] = $('#tblShippingDetails tbody').find('tr')[i].cells[13].innerText,
            //                          tmpShippingDeatils['ReferenceID'] = $('#hdnClientID').val(),
            //                          tmpShippingDeatils['ReferenceType'] = "",
            //                          tmpShippingDeatils['Address1'] = $('#tblShippingDetails tbody').find('tr')[i].cells[6].innerText,
            //                          tmpShippingDeatils['City'] = $('#tblShippingDetails tbody').find('tr')[i].cells[3].innerText,
            //                          tmpShippingDeatils['CountryID'] = $('#tblShippingDetails tbody').find('tr')[i].cells[15].innerText,
            //                          tmpShippingDeatils['StateID'] = $('#tblShippingDetails tbody').find('tr')[i].cells[16].innerText,
            //                          tmpShippingDeatils['EmailID'] = $('#tblShippingDetails tbody').find('tr')[i].cells[10].innerText,
            //                          tmpShippingDeatils['Phone'] = $('#tblShippingDetails tbody').find('tr')[i].cells[9].innerText,
            //                          tmpShippingDeatils['Mobile'] = $('#tblShippingDetails tbody').find('tr')[i].cells[8].innerText,
            //                          tmpShippingDeatils['FaxNumber'] = "",
            //                          tmpShippingDeatils['IsCommunication'] = $('#tblShippingDetails tbody').find('tr')[i].cells[11].innerText,
            //                          tmpShippingDeatils['ISDCode'] = 0,
            //                          tmpShippingDeatils['Name'] = "",
            //                          tmpShippingDeatils['ContactType'] = "",
            //                          tmpShippingDeatils['EmpID'] = 0,
            //                          tmpShippingDeatils['SubUrban'] = $('#tblShippingDetails tbody').find('tr')[i].cells[2].innerText,
            //                          tmpShippingDeatils['Address2'] = $('#tblShippingDetails tbody').find('tr')[i].cells[7].innerText,
            //                          tmpShippingDeatils['postalCode'] = $('#tblShippingDetails tbody').find('tr')[i].cells[1].innerText
            //                jsonStringContactAndShippingTblDetails.push(tmpShippingDeatils);
            //                //ContactShippingDetails += '^';
            //            }
            var datatable = $('#tblShippingDetails').DataTable();
            datatable.rows().every(function(rowIdx, tableLoop, rowLoop) {
                data = this.data();
                var tmpShippingDeatils = new Object();
                //return false;
                tmpShippingDeatils['AddressID'] = data[14];
                tmpShippingDeatils['AddressTypeID'] = data[13];
                tmpShippingDeatils['ReferenceID'] = $('#hdnClientID').val(),
                tmpShippingDeatils['ReferenceType'] = "",
                tmpShippingDeatils['Address1'] = data[6];
                tmpShippingDeatils['City'] = data[3];
                tmpShippingDeatils['CountryID'] = data[15];
                tmpShippingDeatils['StateID'] = data[16];
                tmpShippingDeatils['EmailID'] = data[10];
                tmpShippingDeatils['Phone'] = data[9];
                tmpShippingDeatils['Mobile'] = data[8];
                tmpShippingDeatils['FaxNumber'] = "",
                tmpShippingDeatils['IsCommunication'] = data[11];
                tmpShippingDeatils['ISDCode'] = 0,
                tmpShippingDeatils['Name'] = "",
                tmpShippingDeatils['ContactType'] = "",
                tmpShippingDeatils['EmpID'] = 0,
                tmpShippingDeatils['SubUrban'] = data[2];
                tmpShippingDeatils['Address2'] = data[7];
                tmpShippingDeatils['postalCode'] = data[1];
                jsonStringContactAndShippingTblDetails.push(tmpShippingDeatils);
            });


            //Basic And Communication UDT End

            var checked_checkboxesOL = $("[id*=chklstOrderableLocation] input:checked");
            var OrderableLocation = '';
            checked_checkboxesOL.each(function() {
                var value = $(this).parent("span").attr('OrgID')
                OrderableLocation += value + '~';
            });

            if ($('#chkHasparent').is(':checked')) HasParaent = true;
            else HasParaent = false;

            if ($('#chkCCLabReport').is(':checked')) ccLabReport = 'Y';
            else ccLabReport = 'N';
            var AutoAuthorization;
            if ($('#chkExcludeAutoAuthorization').is(':checked')) AutoAuthorization = 'Y';
            else AutoAuthorization = 'N';

            var tmpBasicDetails = new Object();
            tmpBasicDetails['ClientCode'] = $('#txtClientCode').val() === null ? '' : $('#txtClientCode').val();
            tmpBasicDetails['ClientType'] = $('#ddlClientType').val() === '' || $('#ddlClientType').val() === null ? 0 : $('#ddlClientType').val();
            tmpBasicDetails['RegistrationType'] = $('#ddlRegistrationType').val() === null ? '' : $('#ddlRegistrationType').val();
            tmpBasicDetails['HasParent'] = HasParaent;
            tmpBasicDetails['txtHasparent'] = $('#hdnParentClientID').val();
            tmpBasicDetails['CCLabReport'] = ccLabReport;
            tmpBasicDetails['SplPrivileges'] = $('#ddlSplPrivileges').val() === '' || $('#ddlSplPrivileges').val() === null ? 0 : $('#ddlSplPrivileges').val();
            tmpBasicDetails['OrderableLocation'] = OrderableLocation;
            tmpBasicDetails['PrintLocation'] = $('#ddlPrintLocation').val() === '' || $('#ddlPrintLocation').val() === null ? 0 : $('#ddlPrintLocation').val();
            tmpBasicDetails['NoofPrintCopies'] = $('#ddlNoofPrintCopies').val() === '' || $('#ddlNoofPrintCopies').val() === null ? 0 : $('#ddlNoofPrintCopies').val();
            // Communications tab Fields
            tmpBasicDetails['Location'] = $('#hdnLocationID').val(),
            tmpBasicDetails['Hub'] = $('#hdnHubID').val(),
            tmpBasicDetails['Zone'] = $('#hdnZoneID').val(),
            tmpBasicDetails['Route'] = $('#hdnRouteID').val(),
            tmpBasicDetails['TransitTime'] = $('#txtTransitTime').val() === '' || $('#txtTransitTime').val() === null ? 0 : $('#txtTransitTime').val(),
            tmpBasicDetails['ddlTransitTime'] = $('#ddlTransitTime').val() === null ? '' : $('#ddlTransitTime').val();
            tmpBasicDetails['ExAutoAuthorization'] = AutoAuthorization

            jsonStringBasicDetails.push(tmpBasicDetails);

            //Notification UDT Start
            var Notificationtable = $('#tblNotificationDetails').DataTable();
            Notificationtable.rows().every(function(rowIdx, tableLoop, rowLoop) {
                data = this.data();
                var BlockNotify = data[3] == 'Y' ? true : false;
                var tmpNotificationDetails = new Object();
                tmpNotificationDetails['ClientId'] = 0,
                tmpNotificationDetails['ComMode'] = data[1],
                tmpNotificationDetails['NotifyType'] = data[0],
                tmpNotificationDetails['ComDetails'] = data[2],
                tmpNotificationDetails['BlockNotify'] = BlockNotify
                jsonStringNotification.push(tmpNotificationDetails);
            });


            var checked_checkboxes = $("[id*=chkNotification] input:checked");
            checked_checkboxes.each(function() {
                var tmpNotify = new Object();
                var value = $(this).parent("span").attr('attributeid')
                var text = $(this).closest("td").find("label").html();
                tmpNotify['ClientID'] = 0;
                tmpNotify['AttributesID'] = value;
                tmpNotify['AttributeName'] = text;
                Reportobj.push(tmpNotify);
            });


            //Notification UDT End

            //Report UDT Start
            var ddlStationery = $('#ddlStationery').val() === '' || $('#ddlStationery').val() === null ? 0 : $('#ddlStationery').val();
            var tmpReortDetails = new Object();
            tmpReortDetails['ClientID'] = 0;
            tmpReortDetails['AttributesID'] = ddlStationery;
            Reportobj.push(tmpReortDetails);
            //Report UDT End

            //Commercial UDT Start
            var Discounttable = $('#tblCommercialDetails').DataTable();
            Discounttable.rows().every(function(rowIdx, tableLoop, rowLoop) {
                data = this.data();
                var Isactive = data[5] == 'Y' ? true : false;
                var ValidFrom = data[3].split('/');
                var VFdate = ValidFrom[2] + '-' + ValidFrom[1] + '-' + ValidFrom[0];
                var ValidTo = data[4].split('/');
                var VTdate = ValidTo[2] + '-' + ValidTo[1] + '-' + ValidTo[0];
                var tmpDiscountDetails = new Object();
                tmpDiscountDetails['ClientID'] = 0;
                tmpDiscountDetails['PolicyType'] = data[6];
                tmpDiscountDetails['PolicyID'] = data[2];
                tmpDiscountDetails['ValidFrom'] = VFdate;
                tmpDiscountDetails['ValidTo'] = VTdate;
                tmpDiscountDetails['IsActive'] = Isactive;
                jsonStringDiscount.push(tmpDiscountDetails);
            });

            var Taxdatatable = $('#tblTaxDetails').DataTable();
            Taxdatatable.rows().every(function(rowIdx, tableLoop, rowLoop) {
                data = this.data();
                var TempTaxDetails = new Object();
                TempTaxDetails['ID'] = 0,
                    TempTaxDetails['ClientID'] = 0;
                TempTaxDetails['TaxID'] = data[0];
                TempTaxDetails['OrgID'] = 0;
                TempTaxDetails['CreatedBy'] = 0;
                TempTaxDetails['CreatedAt'] = "2000-11-11 00:00:00";
                TempTaxDetails['ModifiedBy'] = 0;
                TempTaxDetails['ModifiedAt'] = "2000-11-11 00:00:00";
                TempTaxDetails['IsActive'] = data[3];
                TempTaxDetails['SequenceNo'] = data[2];
                jsonStringTax.push(TempTaxDetails)
            });
            //Commercial UDT End

            // Credit Control tab
            var AllowService, CouponSystem, InvoiceApprovalRequired, AllowBillingDiscount;
            if ($('#chkAllowServiceMapping').is(':checked')) AllowService = 'Y';
            else AllowService = 'N';
            if ($('#chkCouponSystem').is(':checked')) CouponSystem = 'Y';
            else CouponSystem = 'N';
            if ($('#chkInvoiceApprovalRequired').is(':checked')) InvoiceApprovalRequired = 'Y';
            else InvoiceApprovalRequired = 'N';
            if ($('#chkAllowBillingDiscount').is(':checked')) AllowBillingDiscount = 'Y';
            else AllowBillingDiscount = 'N';

            var ValidFrom = $('#txtFromDate').val().split('/');
            var VFdate = ValidFrom[2] + '-' + ValidFrom[1] + '-' + ValidFrom[0];

            var ValidTo = $('#txtToDate').val().split('/');
            var VTo = ValidTo[2] + '-' + ValidTo[1] + '-' + ValidTo[0];

            var cltStatus = 'A';
            if ($('#ddlClientStatus').val() != null && $('#ddlClientStatus').val() != 0) {
                cltStatus = $('#ddlClientStatus').val();
            }

            var TempCreditControl = new Object();
            // var TempCreditControl = {
            TempCreditControl['BusinessType'] = $('#ddlBusinessType').val() === '' || $('#ddlBusinessType').val() === null ? 0 : $('#ddlBusinessType').val();
            TempCreditControl['CSTNo'] = $('#txtCSTNo').val();
            TempCreditControl['ServiceTaxNo'] = $('#txtServiceTaxNo').val();
            TempCreditControl['PANNo'] = $('#txtPanNo').val();
            //'SAPCode': $('#txtPanNo').val();
            TempCreditControl['SAPCode'] = $('#txtSAPCode').val();
            TempCreditControl['CurrencyType'] = $('#ddlCurrencyType').val() === '' || $('#ddlCurrencyType').val() === null ? 0 : $('#ddlCurrencyType').val();
            TempCreditControl['PaymentCategory'] = $('#ddlPaymentCategory').val() === null ? '' : $('#ddlPaymentCategory').val();
            TempCreditControl['AllowServiceMapping'] = AllowService;
            TempCreditControl['InvoiceCycle'] = $('#ddlInvoiceCycle').val() === null ? '' : $('#ddlInvoiceCycle').val();
            TempCreditControl['CouponSystem'] = CouponSystem;
            TempCreditControl['InvoiceApprovalRequired'] = InvoiceApprovalRequired;

            TempCreditControl['AllowBillingDiscount'] = AllowBillingDiscount,

            TempCreditControl['ClientStatus'] = cltStatus;
            TempCreditControl['Reason'] = $('#ddlReason').val() === null ? '' : $('#ddlReason').val();
            TempCreditControl['Action'] = $('#ddlAction').val() === null ? '' : $('#ddlAction').val();
            TempCreditControl['FromDate'] = VFdate === 'undefined-undefined-' ? "1753-01-01 00:00:00" : VFdate;
            TempCreditControl['ToDate'] = VTo === 'undefined-undefined-' ? "1753-01-01 00:00:00" : VTo;
            TempCreditControl['CreditLimit'] = $('#txtCreditLimit').val() === '' ? 0 : $('#txtCreditLimit').val();
            TempCreditControl['CreditDays'] = $('#txtCreditDays').val() === '' ? 0 : $('#txtCreditDays').val();
            TempCreditControl['GraceLimit'] = $('#txtGraceLimit').val() === '' ? 0 : $('#txtGraceLimit').val();
            TempCreditControl['GraceDays'] = $('#txtGraceDays').val() === '' ? 0 : $('#txtGraceDays').val();

            TempCreditControl['AdvanceThreshold'] = $('#ddlAdvanceThreshold').val() === null ? '' : $('#ddlAdvanceThreshold').val();
            TempCreditControl['Value'] = $('#txtValue').val() === '' ? 0 : $('#txtValue').val();
            TempCreditControl['MinimumDeposite'] = $('#txtMinimumDeposite').val() === '' ? 0 : $('#txtMinimumDeposite').val()
            jsonStringCredit.push(TempCreditControl);
            // Credit Control tab end 

            //Generate Xml for Attributes
            var RowId = 1;
            var XML = new XMLWriter();
            XML.BeginNode("ClientAttributes");
            var datatable1 = $('#tblAttributesDetails').DataTable();

            datatable1.rows().every(function(rowIdx, tableLoop, rowLoop) {
                data = this.data();
                XML.BeginNode("AttribDetails");
                XML.Node("ID", RowId.toString());
                XML.Node("Name", data[0]);
                XML.Node("Type", data[2]);
                XML.Node("Value", data[1]);
                XML.EndNode();
                RowId = +1;
            });
            XML.Close(); // Takes care of unended tags.
            // The replace in the following line are only for making the XML look prettier in the textarea.
            //XmlAttributes = XML.ToString().replace(/</g, "\n<");
            XmlAttributes = XML.ToString();


            //Document Upload Tab

            if ($('#hdnClientCode').val() == 0) $('#hdnClientCode').val($('#txtClientCode').val());
            if ($('#hdnClientName').val() == 0) $('#hdnClientName').val($('#txtClientName1').val());

            var DocUrl = FileUploadPath + '\\\\' + $(this).text();
            //$('#ListFiles option').each(function() {
            $('#ListDoc option').each(function() {
                var DocDate = $(this).text().split('~')[2].split('/');
                var DocDt = DocDate[2] + '-' + DocDate[1] + '-' + DocDate[0];
                tmptestDoc = new Object();
                tmptestDoc['DocFileIds'] = 0;
                tmptestDoc['DocFileName'] = $(this).text().split('~')[0];
                tmptestDoc['DocFileUrl'] = DocUrl;
                tmptestDoc['IdentifyingType'] = $('#hdnClientName').val();
                tmptestDoc['IdentifyingId'] = $('#hdnClientID').val();
                tmptestDoc['Type'] = $(this).text().split('~')[1];
                tmptestDoc['DocDate'] = DocDt;
                StrDocjson.push(tmptestDoc)
            });

            //Document upload tab End
            //return false;
        }

        $('#ddlType').change(function(event) {
            $('#txtPolicy').val('');
            var parameters = {
                Drop: $('#ddlType').val(),
                OrgID: OrgId
            }

            $.ajax({
                type: "POST",
                url: "ClientManagement.aspx/GetDiscountConfig",
                data: JSON.stringify(parameters),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) {
                    $('#hdnDiscountconfigVal').val(response.d)
                },
                error: function(response) {
                    jAlert(err.statusText, 'Alert Box');
                }
            });
        });
    });


    function bindDataToGrid(ClientId) {
        var Parameter = {};
        Parameter.OrgId = OrgId;
        Parameter.ClientId = ClientId;
        $.ajax({
            type: "POST",
            url: "ClientManagement.aspx/GetAssociateClient",
            data: JSON.stringify(Parameter),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function Success(data) {
                var oTable1 = $('#AssociateClientdatatable').dataTable();
                oTable1.fnClearTable();
                var lstTPADetails = data.d;
                if (lstTPADetails.length > 0) {
                    fun_RptDetail(lstTPADetails);
                    $('#AssociateClientdatatable').hide();
                }
                else {
                    //jAlert("No matching records found",'Alert Box');
                    $('#AssociateClientdatatable').hide();
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
            }
        });
    }

    function fun_RptDetail(JST) {

        RDL = [];
        if (JST) {
            $.each(JST, function() {
                var ClientCode = this.ClientCode;
                var ClientName = this.ClientName;
                RDL.push(
                     [
                        ClientCode = ClientCode,
                        ClientName = ClientName
                     ]);
            });

            $("#AssociateClientdatatable").dataTable().fnDestroy();
            $('#AssociateClientdatatable').dataTable({
                "bDestroy": true,
                "bProcessing": true,
                "bPaginate": true,
                "bDeferRender": true,
                "bSortable": false,
                "bJQueryUI": true,
                "aaData": RDL,
                'bSort': true,
                'bLengthChange': false,
                'bFilter': true,
                'sPaginationType': 'full_numbers'

            });
        }
    }

    function bindDataToGridWithBasicDetails(ClientId, ClientCode) {
        var Parameter = {};
        Parameter.OrgId = OrgId;
        Parameter.ClientId = ClientId;
        Parameter.ClientCode = ClientCode;
        $.ajax({
            type: "POST",
            url: "ClientManagement.aspx/GetClientMasterDetails",
            data: JSON.stringify(Parameter),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function Success(data) {

                var oTableBasicDet = $('#DatatableBasicClientDetails').dataTable();
                oTableBasicDet.fnClearTable();
                var lstTPADetails = data.d;
                if (lstTPADetails.length > 0) {
                    fun_RptDetailWithClientMaster(lstTPADetails);
                    $('#DatatableBasicClientDetails').show();
                }
                else {
                    jAlert("No matching records found", 'Alert Box');
                    $('#DatatableBasicClientDetails').hide();
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
            }
        });
    }

    function fun_RptDetailWithClientMaster(JST) {
        RDL = [];
        if (JST) {
            $.each(JST, function() {
                var ClientCode = this.ClientCode;
                var PaymentCategory = this.PaymentCategory;
                var ClientTypeName = this.ClientTypeName;
                var ParentClientName = this.ParentClientName;
                var DiscountMapped = this.DiscountMapped;
                var ClientNotify = this.ClientNotify;
                var PrintLocation = this.PrintLocation;
                var AccountHolder = this.AccountHolder;
                var Status = this.Status;
                if (ClientNotify == null)
                    var Notify = ClientNotify;
                else
                    var Notify = ClientNotify.substring(0, ClientNotify.length - 1);
                RDL.push(
                     [
                        ClientCode = ClientCode,
                        PaymentCategory = PaymentCategory,
                        ClientTypeName = ClientTypeName,
                        ParentClientName = ParentClientName,
                        DiscountMapped = DiscountMapped,
                        ClientNotify = Notify,
                        PrintLocation = PrintLocation,
                        AccountHolder = AccountHolder,
                        Status = Status
                     ]);
            });


            $("#DatatableBasicClientDetails").dataTable().fnDestroy();
            $('#DatatableBasicClientDetails').dataTable({
                "bDestroy": false,
                "bProcessing": false,
                "bPaginate": false,
                "bDeferRender": false,
                "bSortable": false,
                "bJQueryUI": false,
                "aaData": RDL,
                'bSort': false,
                'bLengthChange': false,
                'bFilter': false,
                "bInfo": false,
                'sPaginationType': 'full_numbers'
            });
        }
    }
    // Validation Part:
    //Attribute Tab
    function validateAttributesDetails() {
        if ($('#txtAttributes').val() == "") {
            jAlert("This Attributes is required", 'Alert Box');
            $('#txtAttributes').focus();
            return false;
        }
        else if ($('#txtAttributesValue').val() == "") {
            jAlert("This Attributes Value is required", 'Alert Box');
            $('#txtAttributesValue').focus();
            return false;
        } var mydropdown = $('#ddlAttributesType');
        if (mydropdown.length == 0 || $(mydropdown).val() == "") {
            jAlert("This Attributes Type is required", 'Alert Box');
            $('#mydropdown').focus();
            return false;
        }
        return true;
    }

    // Commercial Details Tab
    function validateCommercialDetails() {
        var mydropdown = $('#ddlType');
        if (mydropdown.length == 0 || $(mydropdown).val() == "") {
            jAlert("Please select Type", 'Alert Box'); //bindDataToGrid
            mydropdown.focus();
            return false;
        }
        else if ($('#txtPolicy').val() == "") {
            jAlert("Please select Policy", 'Alert Box')
            $('#txtPolicy').focus();
            return false;
        }
        else if ($('#txtFrom').val() == "") {
            jAlert("Please select From Date", 'Alert Box')
            $('#txtFrom').focus()
            return false;
        }
        else if ($('#txtTo').val() == "") {
            jAlert("Please select To Date", 'Alert Box')
            $('#txtTo').focus();
            return false;
        }
        return true;

    }

    function validateTaxDetails() {
        var ddlTaxDetails = $('#ddlTaxDetails');
        var txtSequence = $('#txtSequence');

        if (ddlTaxDetails.val() == 0 || ddlTaxDetails.val() == "") {
            jAlert('Tax Details is required', 'Alert Box');
            ddlTaxDetails.focus();
            return false;
        }

        else if (txtSequence.val() == null || txtSequence.val() == "") {
            jAlert('Sequence is required', 'Alert Box');
            txtSequence.focus();
            return false;
        }
        return true;
    }


    /// Basic Details Tab

    $.fn.ValidationForNumeric =
function() {
    return this.each(function() {
        $(this).keydown(function(e) {
-1 !== $.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) || /65|67|86|88/.test(e.keyCode) && (!0 === e.ctrlKey || !0 === e.metaKey) || 35 <= e.keyCode && 40 >= e.keyCode || (e.shiftKey || 48 > e.keyCode || 57 < e.keyCode) && (96 > e.keyCode || 105 < e.keyCode) && e.preventDefault()
        });
    });
};

    function IsEmail(email) {
        var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        return regex.test(email);
    }
    function validateContactDetails() {
        var mydropdown = $('#ddlContactType');
        if (mydropdown.val() == 0 || mydropdown.val() == "") {
            jAlert("Contact Type is required", 'Alert Box')
            mydropdown.focus();
            return false;
        } else if ($('#txtSPOCName').val() == "") {
            jAlert("This SPOC Name is required", 'Alert Box')
            $('#txtSPOCName').focus();
            return false;
        }
        else if ($('#txtMobileNo').val() == "") {
            jAlert("This Mobile No is required", 'Alert Box')
            $('#txtMobileNo').focus();
            return false;
        } else if ($('#txtLandlineNo').val() == "") {
            jAlert("This Landline No is required", 'Alert Box')
            $('#txtLandlineNo').focus();
            return false;
        } else if ($('#txtEmailId').val() == "") {
            jAlert("This Email Id is required", 'Alert Box')
            $('#txtEmailId').focus();
            return false;
        }
        else if (!IsEmail($('#txtEmailId').val())) {
            jAlert("This Email Id is not valid", 'Alert Box')

            $('#txtEmailId').focus();
            return false;
        }
        else if ($('#txtFaxNo').val() == "") {
            jAlert("This Fax No is required", 'Alert Box')
            $('#txtFaxNo').focus();
            return false;
        }
        return true;
    }

    //validation of contact Details 
    $("#txtMobileNo").ValidationForNumeric();
    $("#txtLandlineNo").ValidationForNumeric();
    $("#txtFaxNo").ValidationForNumeric();


    function validateShippingDetails() {
        var countrydropdown = $('#ddlCountry');
        var statedropdown = $('#ddlState');
        var mydropdown = $('#ddlAddressType');
        if (mydropdown.val() == 0 || mydropdown.val() == "") {
            jAlert("Address Type is required", 'Alert Box');
            mydropdown.focus();
            return false;
        } else if ($('#txtZipCode').val() == "") {
            jAlert("This Zip Code is required", 'Alert Box');
            $('#txtZipCode').focus();
            return false;
        }
        else if ($('#txtArea').val() == "") {
            jAlert("This Area is required", 'Alert Box');
            $('#txtArea').focus();
            return false;
        }
        else if ($('#txtCity').val() == "") {
            jAlert("This City is required", 'Alert Box');
            $('#txtCity').focus();
            return false;
        }

        else if (statedropdown.val() == 0 || statedropdown.val() == "") {
            jAlert("This State is required", 'Alert Box');
            statedropdown.focus();
            return false;
        }

        else if (countrydropdown.val() == 0 || countrydropdown.val() == "") {
            jAlert("This Country is required", 'Alert Box');
            countrydropdown.focus();
            return false;
        }

        else if ($('#txtAddressLine1').val() == "") {
            jAlert("This Address Line 1 is required", 'Alert Box');
            $('#txtAddressLine1').focus();
            return false;
        }
        //        else if ($('#txtAddressLine2').val() == "") {
        //            jAlert("This Address Line 2 is required", 'Alert Box');
        //            $('#txtAddressLine2').focus();
        //            return false;
        //        }
        //        else if ($('#txtContactNo').val() == "") {
        //            jAlert("This Contact No is required", 'Alert Box');
        //            $('#txtContactNo').focus();
        //            return false;
        //        }
        //        else if ($('#txtLandlineNo1').val() == "") {
        //            jAlert("This Land Line No is required", 'Alert Box');
        //            $('#txtLandlineNo1').focus();
        //            return false;
        //        }
        if ($('#txtEmailId1').val() != '') {
            if (!IsEmail($('#txtEmailId1').val())) {
                jAlert("This Email Id is not valid", 'Alert Box');
                $('#txtEmailId1').focus();
                return false;
            }
        }
        return true;

    }


    function validateNotificationsDetails() {
        var mydropdown = $('#ddlNotifications');
        var mydropdownCom = $('#ddlCommunicationMode');

        if (mydropdown.val() == 0 || mydropdown.val() == "") {
            jAlert("Notifications is required", 'Alert Box');
            mydropdown.focus();
            return false;
        } else if (mydropdownCom.val() == 0 || mydropdownCom.val() == "") {
            jAlert("Communication is required", 'Alert Box');
            mydropdownCom.focus();
            return false;
        }
        else if ($('#txtmobilenumber').val() == "") {
            jAlert("This mobile number is required", 'Alert Box');
            $('#txtmobilenumber').focus();
            return false;
        }

        return true;


    }
    function ValidationById(Id) {
        var ids = $('#' + Id).closest('table').attr('id');
        if (ids == undefined)
           ids= $('#' + Id).parent().parent().parent().parent().parent().parent().parent().parent().attr('id');
        $('#TabsMenu li').removeClass('active');
        $('#' + ids).addClass('active');
        $('[id^="DivtabCM"]').hide();
        $('#' + ids).show();
       
    }
    $('#txtClientCode').blur(function() {
        IsExists = 'N'
        var InputParam = {};
        InputParam.CodeType = 'CLI';
        InputParam.Code = $('#txtClientCode').val();
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "ClientManagement.aspx/GetCheckClientCode",
            data: JSON.stringify(InputParam),
            dataType: "json",
            success: function(data) {
                if (data.d > 0) {
                    IsExists = 'Y';
                }
            },
            error: function(result) {
                jAlert("No Match", 'Alert Box');
            }
        });
    });
    
    function FinalSaveValidation() {
        
        if (IsExists == 'Y') {
            jAlert("The Client Code Already Exists.", 'Alert Box');
            return false;
        }
        if ($('#txtClientCode').val() == '') {
            jAlert('Enter the Client Code')
            ValidationById('txtClientCode');
            $('#txtClientCode').focus();           
            return false;
        }
        if ($('#ddlClientType').val() == 0) {
            jAlert('Select the Client Type')
            ValidationById('ddlClientType');
            return false;
        }
        if ($('#txtClientName').val() == '' && $('#txtClientName1').val() == '') {
            jAlert('Enter the Client Name')
            $('#txtClientName').focus();   
            return false;
        }
        if (IsNewClient == 'N') {
            if ($('#ddlReasonForSave').val() == 0) {
                jAlert('Enter the Reason for  Amendment')
                $('#ddlReasonForSave').focus();   
                return false;
            }
        }
        if ($('#ddlBusinessType').val() == 0) {
            jAlert('Select the Business Type')
            ValidationById('ddlBusinessType');
            $('#ddlBusinessType').focus();                       
            return false;
        }
        if ($('#ddlCurrencyType').val() == 0) {
            jAlert('Select the Currency Type')
            ValidationById('ddlCurrencyType');
            $('#ddlCurrencyType').focus();                       
            return false;
        }
        if ($('#ddlPaymentCategory').val() == 0) {
            jAlert('Select the Payment Category')
            ValidationById('ddlPaymentCategory');
            $('#ddlPaymentCategory').focus(); return false;
        }
        if ($('#ddlPaymentCategory').val() == 'CASHADV') {

            if ($('#ddlAdvanceThreshold').val() == '0' || $('#txtValue').val() == '' || $('#txtMinimumDeposite').val() == '') {
                jAlert('Select the Threshold Value')
                ValidationById('ddlAdvanceThreshold');
                $('#ddlAdvanceThreshold').focus(); return false;
            }
        }
        var NotifTxt = '';
        var Notificationtable = $('#tblNotificationDetails').DataTable();
        Notificationtable.rows().every(function(rowIdx, tableLoop, rowLoop) {
            data = this.data();
            NotifTxt += data[5] + '~';
        });
        var IsTrue = 1;
        var listNoti = $('#<%= chkNotification.ClientID%> input');
        listNoti.each(function(index) {
            var ID = $(this).attr('id')
            if ($('#' + ID).is(':checked')) {
                var checkedlst = $(this).next().html();
                if (checkedlst.toLowerCase().indexOf('sms') != -1 || checkedlst.toLowerCase().indexOf('email') != -1) {
                    if (NotifTxt.toLowerCase().indexOf(checkedlst.toLowerCase()) == -1) {
                        jAlert('Enter the Details for ' + checkedlst + '');
                        IsTrue = 0;
                    }
                }
            }
            if ($(this).next().html() == 'Report Print') {
                if ($('#' + ID).is(':checked')) {
                    if ($('#txtReportPrintDate').val() == '') {
                        jAlert('Enter the Report Print From Date')
                        IsTrue = 0;
                    }
                }
            }
        });
        if (IsTrue == 0)
            return false;


        return true;
    }


    //validation of Shipping Details
    $("#txtLandlineNo1").ValidationForNumeric();
    $("#txtContactNo").ValidationForNumeric();
    $("#txtZipCode").ValidationForNumeric();
    //Commercial Sequence number
    $("#txtSequence").ValidationForNumeric();
    $("#txtTransitTime").ValidationForNumeric();

    //Credit Control
    $("#txtCreditLimit").ValidationForNumeric();
    $("#txtCreditDays").ValidationForNumeric();
    $("#txtGraceLimit").ValidationForNumeric();
    $("#txtGraceDays").ValidationForNumeric();

    //Client Deposit
    $("#txtValue").ValidationForNumeric();
    $("#txtMinimumDeposite").ValidationForNumeric();
    function Cancel() {
        jConfirm('Are you sure to Cancel a Event?', 'Confirmation Dialog', function(ReturnResponse) {
            if (ReturnResponse == true) {
                $('#txtClientName').show();
                $('#txtClientName1').hide();
                $('#trCopyDetails').hide();
                Clear();
                IsNewClient = 'N';
                $('#btnAddNewClient').show();
                $('#lblReasonforAmend').show();
                $('#ddlReasonForSave').show();
            }
        });
        return false;
    }

    function Clear() {
        $('#tblCommercialDetails').dataTable().fnClearTable();
        //$('#tblShippingDetails').jqGrid("clearGridData");
        $('#tblShippingDetails').dataTable().fnClearTable();
        $('#tblTaxDetails').dataTable().fnClearTable();
        $('#tblNotificationDetails').dataTable().fnClearTable();
        $('#tblAttributesDetails').dataTable().fnClearTable();
        $('#tblLocationPrinter').dataTable().fnClearTable();
        $('#tblContactDetails').dataTable().fnClearTable();
        $('#DatatableBasicClientDetails').dataTable().fnClearTable();
        $('#DatatableBasicClientDetails').hide();
        $('#DatatableBasicClientDetails').dataTable().fnDestroy();

        $('#tblCommercialDetails_filter').addClass('hide');
        $('#tblTaxDetails_filter').addClass('hide');
        $('#tblNotificationDetails_filter').addClass('hide');
        $('#tblAttributesDetails_filter').addClass('hide');
        $('#tblLocationPrinter_filter').addClass('hide');
        $('#tblContactDetails_filter').addClass('hide');
        $('#tblShippingDetails_filter').addClass('hide');

        $('#hdnClientCode').val('0');
        $('#hdnClientName').val('0');
        $('#hdnClientID').val('0');

        $('#txtCopyFrom').val('');
        $('#txtClientName1').val('');
        $('#txtClientName').val('');
        $('#ddlReasonForSave').val(0);
        //Basic Details
        $('#txtClientCode').val('');
        $('#ddlClientType').val(0);
        $('#ddlRegistrationType').val('All');
        $('#chkHasparent').prop('checked', false);
        $('#txtHasparent').val('');
        $('#chkCCLabReport').prop('checked', false);
        $('#ddlSplPrivileges').val(0);
        $('[id*=chklstOrderableLocation] input').prop('checked', false);
        $('#ddlPrintLocation').val(0);
        $('#ddlNoofPrintCopies').val(0);
        $('#chkExcludeAutoAuthorization').prop('checked', false);
        $('#txtOrderableLocation').val('');

        $('#hdnParentClientID').val('0');

        //Communiction Details
        $('#txtLocation').val('');
        $('#txtHub').val('');
        $('#txtZone').val('');
        $('#txtRoute').val('');
        $('#txtTransitTime').val('');
        $('#ddlTransitTime').val(0);

        $('#hdnLocationID').val('0');
        $('#hdnHubID').val('0');
        $('#hdnZoneID').val('0');
        $('#hdnRouteID').val('0');

        //Notification Details
        $('#txtReportPrintDate').val('');
        $('#divReportPrintDate').hide();
        $('[id*=chkNotification] input').prop('checked', false);


        //Report Details
        $('#ddlDescription').val(0);
        $('#ddlStationery').val(0);


        //CreditControl Details
        $('#ddlBusinessType').val(0);
        $('#txtCSTNo').val('');
        $('#txtServiceTaxNo').val('');
        $('#txtPanNo').val('');
        $('#txtSAPCode').val('');
        $('#ddlCurrencyType').val($('#hdnbaseCurrencyID').val());
        $('#ddlPaymentCategory').val(0);
        $('#ddlInvoiceCycle').val(0);
        $('#chkAllowServiceMapping').prop('checked', false);
        $('#chkCouponSystem').prop('checked', false);
        $('#chkInvoiceApprovalRequired').prop('checked', false);
        $('#chkAllowBillingDiscount').prop('checked', false);

        $('#ddlClientStatus').val(0);
        $('#ddlReason').val(0);
        $('#ddlAction').val(0);
        $('#txtFromDate').val('');
        $('#txtToDate').val('');
        $('#txtCreditLimit').val('');
        $('#txtCreditDays').val('');
        $('#txtGraceLimit').val('');
        $('#txtGraceDays').val('');

        $('#ddlAdvanceThreshold').val('0');
        $('#txtValue').val('');
        $('#txtMinimumDeposite').val('');


        //Document Details
        $('#txtTermAndConditions').val('');
        $('#ListFiles').text("");
        $('#ListFiles').val("");
        $('#ListDoc').text("");
        $('#ListDoc').val("");
        $('#divFiles').empty();

        return false;
    }
    function GetCurrentDate() {
        var d = new Date();
        var curr_date = d.getDate();
        var curr_month = d.getMonth() + 1;
        var curr_year = d.getFullYear();
        return curr_year + "-" + curr_month + "-" + curr_date;

    }
</script>

</html>
