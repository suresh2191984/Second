<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sendToNutrition.aspx.cs"
    Inherits="sendToNutrition" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PhyBookedSchedule.ascx" TagName="PhysicainSchedule"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Send TO CND</title>
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

            $('#gvFoodOrdered tr').each(function(i) {
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
                        <table style="padding-bottom: 20px;">
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="lblText" runat="server" Text="<h3>Nutrition Department</h3>" 
                                        meta:resourcekey="lblTextResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblFoodSession" runat="server" Text="FOOD SESSION" 
                                                    meta:resourcekey="lblFoodSessionResource1"></asp:Label>&nbsp;&nbsp;
                                                <asp:DropDownList ID="ddlFoodSession" runat="server" 
                                                    meta:resourcekey="ddlFoodSessionResource1">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblWardName" runat="server" Text="WARD NAME" 
                                                    meta:resourcekey="lblWardNameResource1"></asp:Label>&nbsp;&nbsp;
                                                <asp:DropDownList ID="ddlWardName" runat="server" 
                                                    meta:resourcekey="ddlWardNameResource1">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:Button ID="btnLoadFoodOrders" runat="server" CssClass="btn" Text=" Load Orders >> "
                                                    OnClick="btnLoadFoodOrders_Click" 
                                                    meta:resourcekey="btnLoadFoodOrdersResource1"></asp:Button>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:GridView ID="gvFoodOrdered" runat="server" AutoGenerateColumns="False" CssClass="mytable1"
                                        CellSpacing="4" HorizontalAlign="Center" CellPadding="4" Width="100%" 
                                        OnRowDataBound="gvFoodOrdered_OnRowDataBound" 
                                        meta:resourcekey="gvFoodOrderedResource1">
                                        <Columns>
                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                <HeaderTemplate>
                                                    <td class="dataheader1">
                                                        <input type="checkbox" id="chkALL" runat="server" onclick="GetPatientDietPlanID(this);"/>
                                                    </td>
                                                    <td class="dataheader1">
                                                       <asp:Label ID="lblTDWardName" runat="server" Text="Ward Name" 
                                                            meta:resourcekey="lblTDWardNameResource1"></asp:Label>
                                                    </td>
                                                    <td class="dataheader1">
                                                       <asp:Label ID="Label1" runat="server" Text="Food Menu Name" 
                                                            meta:resourcekey="Label1Resource1"></asp:Label>
                                                    </td>
                                                    <td class="dataheader1">
                                                         <asp:Label ID="Label2" runat="server" Text="Food Name" 
                                                             meta:resourcekey="Label2Resource1"></asp:Label>
                                                    </td>
                                                    <td class="dataheader1">
                                                        <asp:Label ID="Label3" runat="server" Text="Status" 
                                                            meta:resourcekey="Label3Resource1"></asp:Label>
                                                    </td>
                                                    <td class="dataheader1">
                                                        <asp:Label ID="Label4" runat="server" Text="UOM" 
                                                            meta:resourcekey="Label4Resource1"></asp:Label>
                                                    </td>
                                                    <td class="dataheader1">
                                                        <asp:Label ID="Label5" runat="server" Text="Quantity" 
                                                            meta:resourcekey="Label5Resource1"></asp:Label>
                                                    </td>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <td>
                                                        <input type="checkbox" id="chkFoodOrder" runat="server" onclick="GetPatientDietPlanID(this);" />
                                                    </td>
                                                    <td id="lblWardName" runat="server">
                                                    </td>
                                                    <td id="lblFoodMenuName" runat="server">
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
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div id="divPager" style="float: right; padding-top: 10px;">
                                    </div>
                                    <asp:Label ID="lblMsg" runat="server" Visible="False" Text="<b>No Food List TO See !!!</b>"
                                        meta:resourcekey="lblMsgResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Button ID="btnSendTOCND" runat="server" OnClick="btnSendTOCND_Click" Text="Send TO CND"
                                        Style="display: none" meta:resourcekey="btnSendTOCNDResource1" />
                                </td>
                            </tr>
                        </table>
                      
                        <asp:HiddenField ID="hdnFoodOrderedDate" runat="server" />
                        <asp:HiddenField ID="hdnOrderBY" runat="server" />
                        <asp:HiddenField ID="hdnFoodDetails" runat="server" />
                        <asp:HiddenField ID="hdnTotalCount" runat="server" />
                        <asp:HiddenField ID="hdnOrgID" runat="server" />
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>

<script src="../Scripts/paging/sendToNutrition_Paging.js" type="text/javascript"></script>

<script type="text/javascript">

    var GetFoodOrder = '';
    var _flag = 0;
    function GetPatientDietPlanID(ele) {
        if ($(ele).attr('id') != 'gvFoodOrdered_ctl01_chkALL') {

            _flag = 0;
            var PDPI = '';
            PDPI += $(ele).attr('PDPI') + '@';

            if ($(ele).attr('checked') == true) {
                $(ele).parent('td').parent('tr').children('td').each(function(i) {
                    if (i != 0) {
                        PDPI += $(this).attr('PDPI') + '@';
                    }
                });
                GetFoodOrder += PDPI.substring(0, (PDPI.length - 1)) + '|';
            }
            else {
                $(ele).parent('td').parent('tr').children('td').each(function(i) {
                    if (i != 0) {
                        PDPI += $(this).attr('PDPI') + '@';
                    }
                });
                var removeRow = PDPI.substring(0, (PDPI.length - 1)) + '|';
                GetFoodOrder = GetFoodOrder.replace(removeRow, '');
            }


            if (GetFoodOrder != '') {
                $('#btnSendTOCND').show();
                var foodOrdersList = GetFoodOrder.substring(0, (GetFoodOrder.length - 1));
                $('#hdnFoodDetails').val(foodOrdersList);
            }
            else {
                $('#btnSendTOCND').hide();
            }

        }


        else {

            _flag = 1;
            if ($(ele).attr('checked') == true) {
                $('#gvFoodOrdered tr td input').each(function(i) {
                    $(this).attr('checked', true);
                    if (i != 0) {
                        $(this).attr('disabled', true);
                    }
                });
                $('#hdnFoodDetails').val('full');
                $('#btnSendTOCND').show();
            }
            else {
                $('#gvFoodOrdered tr td input').each(function(i) {
                    $(this).attr('checked', false);
                    if (i != 0) {
                        $(this).removeAttr('disabled');
                    }
                });
                $('#btnSendTOCND').hide();
            }
        }
        
        
    }


    function MakeChkBoxSelect() {
        if (_flag == 0) {
            var v = GetFoodOrder.substring(0, (GetFoodOrder.length - 1));
            var v1 = v.split('|');
            for (var i = 0; i < v1.length; i++) {
                var v2 = v1[i].split('@');
                var pdpiID = v2[0];
                $('#gvFoodOrdered tr td input').each(function() {
                    if ($(this).attr('PDPI') == pdpiID) {
                        $(this).attr('checked', true);
                    }
                });
            }
        }
        else {
            $('#gvFoodOrdered tr td input').each(function(i) {
                $(this).attr('checked', true);
                if (i != 0) {
                    $(this).attr('disabled', true);
                }
            });
        }
    }
    
</script>

