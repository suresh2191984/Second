<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReceivedInWard.aspx.cs" Inherits="ReceivedInWard" meta:resourcekey="PageResource1" %>
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
    <title>Received In Ward</title>
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

            $('#gvCompletedFoodDetails tr').each(function(i) {
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
                            <table style="margin-top:10px;">
                                    <tr><td><asp:Label ID="lblHeaderTxt" runat="server" 
                                            Text="<h3>Completed Food Orders In Ward</h3>" 
                                            meta:resourcekey="lblHeaderTxtResource1"></asp:Label></td></tr>
                                    <tr>
                                        <td>
                                          <asp:GridView ID="gvCompletedFoodDetails" runat="server" 
                                                AutoGenerateColumns="False" CssClass="mytable1" CellSpacing="4" HorizontalAlign="Center"
                                            CellPadding="4"  Width="100%" 
                                                OnRowDataBound="gvCompletedFoodDetails_OnRowDataBound" 
                                                meta:resourcekey="gvCompletedFoodDetailsResource1">
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
                                                        <asp:Label ID="Label2" runat="server" Text="Patient Name" 
                                                            meta:resourcekey="Label2Resource1"></asp:Label>  
                                                    </td>
                                                    <td class="dataheader1">
                                                        <asp:Label ID="Label3" runat="server" Text="Food Name" 
                                                            meta:resourcekey="Label3Resource1"></asp:Label>  
                                                    </td>
                                                    <td class="dataheader1">
                                                        <asp:Label ID="Label4" runat="server" Text="Food Ordered Date" 
                                                            meta:resourcekey="Label4Resource1"></asp:Label>
                                                    </td>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <td>
                                                        <input type="checkbox" id="chkFoodOrder" runat="server" onclick="GetDeliveringDetails(this);" />
                                                    </td>
                                                    <td id="lblWardName" runat="server">
                                                    </td>
                                                    <td id="lblPatientName" runat="server">
                                                    </td>
                                                    <td id="lblFoodName" runat="server">
                                                    </td>
                                                    <td id="lblOrderedDate" runat="server">
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
                                             <asp:Label ID="lblMsg" runat="server" meta:resourcekey="lblMsgResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-top:30px">
                                            <asp:Button ID="btnReceivedInWard" runat="server" Text="Issue To Patient" 
                                                OnClientClick="UpdateFoodDeliveringDetails();" 
                                                onclick="btnReceivedInWard_Click" style="display:none" 
                                                meta:resourcekey="btnReceivedInWardResource1" />
                                        </td>
                                    </tr>
                                 </table>
                            <asp:HiddenField ID="hdnReceivedDetails" runat="server" />
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
<script src="../Scripts/paging/ReceivedInWard_paging.js" type="text/javascript"></script>
 
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
             $('#btnReceivedInWard').show();
         }
         else {
             $('#btnReceivedInWard').hide();
         }
     }

     function UpdateFoodDeliveringDetails() {
         if (getFoodDeliveringDetails != '') {
             $('#hdnReceivedDetails').val(getFoodDeliveringDetails.substring(0, (getFoodDeliveringDetails.length - 1)));
         }
     }

     function MakeChkBoxSelect() {
         var v = forChkboxSelect.substring(0, (forChkboxSelect.length - 1));
         var v1 = v.split('@');
         for (var i = 0; i < v1.length; i++) {
             var foodID = v1[i];
             $('#gvCompletedFoodDetails tr td input').each(function() {
                 if ($(this).attr('RI') == foodID) {
                     $(this).attr('checked', true);
                 }
             });
         }
     }
        
       
        
    </script>