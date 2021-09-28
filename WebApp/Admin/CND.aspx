<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CND.aspx.cs" Inherits="CND" meta:resourcekey="PageResource1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PhyBookedSchedule.ascx" TagName="PhysicainSchedule" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Central Nutrition Department</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>
    <script type="text/javascript" src="../Scripts/jquery-1.8.1.min.js"></script>
    <style type="text/css">
        #testTable
        {
            width: 300px;
            margin-left: auto;
            margin-right: auto;
        }
        #tablePagination
        {
            background-color: Transparent;
            font-size: 0.8em;
            padding: 0px 5px;
            height: 20px;
        }
        #tablePagination_paginater
        {
            margin-left: auto;
            margin-right: auto;
        }
        #tablePagination img
        {
            padding: 0px 2px;
        }
        #tablePagination_perPage
        {
            float: left;
        }
        #tablePagination_paginater
        {
            float: right;
        }
        .LOP_Btm_PageNat
        {
            color: #40657F;
            margin-left: -4px;
            float: left;
            margin-top: 10px;
            width: 1300px;
        }
        .Selected
        {
            color: red;
            cursor: default;
        }
        .paging a
        {
            color: Black;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function() {
            if ($('#hdnTotalCount').val() != '') {
                createPager($('#hdnTotalCount').val(), $('#divPager'));
            }
            else {
                $('#divPager').hide();
            }

            $('#gvFoodDeliveredDetails tr').each(function(i) {
                if (i == 0) {
                    $(this).children('th:first').remove();
                    $(this).children('/th/:last').remove();
                }
                else {
                    $(this).children('td:first').remove();
                    $(this).children('/td/:last').remove();
                }
                //console.log(i);
            });

            ShowFilter('');

        });
    </script>
    
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="ReceptionHeader" runat="server" />
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
                        <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                    <table>
                        <tr>
                            <td>
                               <asp:Label ID="lblHeaderTxt" runat="server" 
                                    Text="<h3>Central Nutrition Department</h3>" 
                                    meta:resourcekey="lblHeaderTxtResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td width="10%">Filter&nbsp;By</td>
                                        <td width="5%">
                                            <asp:DropDownList ID="ddlFilter" runat="server" onchange="ShowFilter(this);" 
                                                meta:resourcekey="ddlFilterResource1"></asp:DropDownList>                                              
                                        </td>
                                        <td>&nbsp;</td>
                                        <td id="tdSessionName" style="display:none">
                                            <asp:Label ID="lblSession" runat="server" Text="Session" 
                                                meta:resourcekey="lblSessionResource1"></asp:Label>            
                                        </td>
                                        <td id="tdSessionDDL" style="display:none"><asp:DropDownList ID="ddlSession" 
                                                runat="server" meta:resourcekey="ddlSessionResource1"></asp:DropDownList></td>
                                        <td id="tdWardName" style="display:none">
                                             <asp:Label ID="lblWardName" runat="server" Text="Ward Name" 
                                                 meta:resourcekey="lblWardNameResource1"></asp:Label>
                                        </td>
                                        <td id="tdWardDDL" style="display:none"><asp:DropDownList ID="ddlWardName" 
                                                runat="server" meta:resourcekey="ddlWardNameResource1"></asp:DropDownList></td>
                                        <td></td>
                                        <td id="tdLoadBtn" style="display:none">
                                            <asp:Button ID="btnLoadOrders" runat="server" CssClass="btn" 
                                                Text=" Load Orders >> " onclick="btnLoadOrders_Click" 
                                                meta:resourcekey="btnLoadOrdersResource1" />
                                           <%-- <input id="btnLoadOrders" type="button" class="btn" value=" Load Orders >> " onclick="LoadDatas();" />--%>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                        <tr>
                        <td>
                            <asp:GridView ID="gvFoodDeliveredDetails" runat="server" 
                                AutoGenerateColumns="False" CssClass="mytable1"
                                        CellSpacing="4" HorizontalAlign="Center" CellPadding="4" 
                                Width="100%" OnRowDataBound="gvFoodDeliveredDetails_OnRowDataBound" 
                                meta:resourcekey="gvFoodDeliveredDetailsResource1">
                                        <Columns>
                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                <HeaderTemplate>
                                                    <td class="dataheader1">
                                                          <asp:Label ID="lblSelect" runat="server" Text="Select" 
                                                              meta:resourcekey="lblSelectResource1"></asp:Label>
                                                    </td>
                                                    <td class="dataheader1">
                                                       <asp:Label ID="Label1" runat="server" Text="Ward Name" 
                                                            meta:resourcekey="Label1Resource1"></asp:Label>
                                                    </td>
                                                    <td class="dataheader1">
                                                         <asp:Label ID="Label2" runat="server" Text="Food Ordered Date" 
                                                             meta:resourcekey="Label2Resource1"></asp:Label>
                                                    </td>
                                                    <td class="dataheader1">
                                                        <asp:Label ID="Label3" runat="server" Text="Food Name" 
                                                            meta:resourcekey="Label3Resource1"></asp:Label>
                                                    </td>
                                                    <td class="dataheader1">
                                                        <asp:Label ID="Label4" runat="server" Text="Status" 
                                                            meta:resourcekey="Label4Resource1"></asp:Label>
                                                    </td>
                                                    <td class="dataheader1">
                                                        <asp:Label ID="Label5" runat="server" Text="UOM" 
                                                            meta:resourcekey="Label5Resource1"></asp:Label>
                                                    </td>
                                                    <td class="dataheader1">
                                                        <asp:Label ID="Label6" runat="server" Text="Quantity" 
                                                            meta:resourcekey="Label6Resource1"></asp:Label>
                                                    </td>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <td>
                                                        <input type="checkbox" id="chkFoodOrder" runat="server" onclick="GetDeliveringDetails(this);" />
                                                    </td>
                                                    <td id="lblWardName" runat="server">
                                                    </td>
                                                    <td id="lblFoodOrderedDate" runat="server">
                                                    </td>
                                                    <td id="lblFoodName" runat="server">
                                                    </td>
                                                    <td id="lblStatus" runat="server">
                                                    </td>
                                                    <td id="lblUOM" runat="server">
                                                    </td>
                                                    <td id="lblQuantity" runat="server">
                                                    </td>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                     <div id="divLoadingGif" style="position:absolute;z-index:1;top:370px;left:450px;display:none">
                                       <img alt="loding" src="../Themes/GG/Images/loading_new.gif" width="20px" height="20px"/>
                                    </div>
                         </td>
                        </tr>
                          <tr>
                                <td colspan="2">
                                    <div id="divPager" style="float: right; padding-top: 10px;">
                                    </div>
                                    
                                    <asp:Label ID="lblMsg" runat="server" Visible="False" Text="<b>No Food Orders TO See !!!</b>"
                                        meta:resourcekey="lblMsgResource1"></asp:Label>
                                </td>
                            </tr>
                        <tr>
                            <td>
                             <asp:HiddenField ID="hdnDeliveringDetails" runat="server" />
                             <asp:Button ID="btnFoodDeliver" runat="server" Text="Click To Deliver" 
                                    OnClientClick="UpdateFoodDeliveringDetails();" onclick="btnFoodDeliver_Click" 
                                    style="display:none" meta:resourcekey="btnFoodDeliverResource1" />
                            </td>
                        </tr>
                     </table>
                     
                     </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
         <asp:HiddenField ID="hdnTotalCount" runat="server" />
         <asp:HiddenField ID="hdnOrgID" runat="server" />
    </div>
    </form>
</body>
</html>
<script src="../Scripts/paging/CND_Paging.js" type="text/javascript"></script>

<script type="text/javascript">

    var getFoodDeliveringDetails = '';
    var forChkboxSelect = '';

    function GetDeliveringDetails(ele) {
        if ($(ele).attr('checked')) {
            
            var FoodOrderID = $(ele).attr('FI');
            getFoodDeliveringDetails += FoodOrderID + ',';
            
            var FoodRowID = $(ele).attr('RI');
            forChkboxSelect += FoodRowID + '@';
        }
        else {
            
            var FoodOrderID = $(ele).attr('FI');
            var removeFoodOrder = FoodOrderID + ',';
            getFoodDeliveringDetails = getFoodDeliveringDetails.replace(removeFoodOrder, '');
           
            var FoodRowID = $(ele).attr('RI');
            var removeRowID = FoodRowID + '@';
            forChkboxSelect = forChkboxSelect.replace(removeRowID, '');
        }
        if (getFoodDeliveringDetails != '') {
            $('#btnFoodDeliver').show();
        }
        else {
            $('#btnFoodDeliver').hide();
        }
    }

    function UpdateFoodDeliveringDetails() {
        if (getFoodDeliveringDetails != '') {
            $('#hdnDeliveringDetails').val(getFoodDeliveringDetails.substring(0, (getFoodDeliveringDetails.length - 1)));
        }
    }

    function MakeChkBoxSelect() {
        var v = forChkboxSelect.substring(0, (forChkboxSelect.length - 1));
        var v1 = v.split('@');
        for (var i = 0; i < v1.length; i++) {
            var foodID = v1[i];
            $('#gvFoodDeliveredDetails tr td input').each(function() {
                if ($(this).attr('RI') == foodID) {
                    $(this).attr('checked', true);
                }
            });
        }
    }


    function ShowFilter(ele) {

        if ($('#ddlFilter option:selected').val() == 1) {
            ShowFilterDDL(1);
        }
        else if ($('#ddlFilter option:selected').val() == 2) {
            ShowFilterDDL(2);
        }
        else {
            ShowFilterDDL(0);
        }
    }

    function ShowFilterDDL(txt) {
       
        if (txt == 1) {
            $('#tdSessionName').hide();
            $('#tdSessionDDL').hide();
            $('#tdWardName').show();
            $('#tdWardDDL').show();
            $('#tdLoadBtn').show();
            $('#ddlSession option:selected').val(0);
        }
        else if (txt == 2) {
            $('#tdWardName').hide();
            $('#tdWardDDL').hide();
            $('#tdSessionName').show();
            $('#tdSessionDDL').show();
            $('#tdLoadBtn').show();
            $('#ddlWardName option:selected').val(0);
        }
        else {
           
            $('#tdSessionName').hide();
            $('#tdSessionDDL').hide();
            $('#tdWardName').hide();
            $('#tdWardDDL').hide();
            $('#tdLoadBtn').show();
            $('#ddlSession option:selected').val(0);
            $('#ddlWardName option:selected').val(0);
        }

    }
       
        
    </script>