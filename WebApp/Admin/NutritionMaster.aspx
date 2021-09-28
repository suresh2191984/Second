<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NutritionMaster.aspx.cs"
    Inherits="Admin_NutritionMaster" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/FoodMenuWardmapping.ascx" TagName="foodmenuwardmapping"
    TagPrefix="ucdiet3" %>
<%@ Register Src="../CommonControls/NutritionFoodCategory.ascx" TagName="ucNFC" TagPrefix="ucDiet" %>
<%@ Register Src="~/CommonControls/NutritionFoodList.ascx" TagName="ucNFL" TagPrefix="ucDiet1" %>
<%@ Register Src="~/CommonControls/NutritionIngredients.ascx" TagName="ucNFI" TagPrefix="ucDiet2" %>
<%@ Register Src="../CommonControls/FoodSession.ascx" TagName="FoodSession" TagPrefix="SessionMaster" %>
<%@ Register Src="../CommonControls/FoodMenu.ascx" TagName="FoodMenu" TagPrefix="MenuMaster" %>
<%@ Register Src="../CommonControls/NutritionFoodIngredientsMapping.ascx" TagName="FoodMenuIngrMapping"
    TagPrefix="IngredientsMapping" %>
<%@ Register Src="../CommonControls/NutritionMenuDeatails.ascx" TagName="MenuDeatails"
    TagPrefix="MenuDeatails" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/Common.js"></script>

    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script type="text/javascript" src="../Scripts/jquery-1.8.1.min.js"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script type="text/javascript">

        $(function() {
            $("input[type=text], input[type=password], textarea, select").each(function() {
                $(this).focus(function() {
                    $(this).css('border', 'solid 1px #00DDFF');
                });
                $(this).blur(function() {
                    $(this).css('border', 'solid 1px transparent');
                });
            });

        });

        function DisplayTab(tabName) {
            $('#TabsMenus li').removeClass('active');
            if (tabName == 'CAT') {
                document.getElementById('tabContentCategory').style.display = 'block';
                document.getElementById('tabContentFoodlist').style.display = 'none';
                document.getElementById('tabsession').style.display = 'none';
                document.getElementById('tblFoodMenumapping').style.display = 'none';
                document.getElementById('tabContentIntegredients').style.display = 'none';
                document.getElementById('tblIngreMapping').style.display = 'none';
                document.getElementById('tblfoodmenumaster').style.display = 'none';
                document.getElementById('tblMenuDetails').style.display = 'none';
                $('#tabcategory').addClass('active');
            }
            else if (tabName == 'LIST') {
                document.getElementById('tabContentCategory').style.display = 'none';
                document.getElementById('tabContentFoodlist').style.display = 'block';
                document.getElementById('tabsession').style.display = 'none';
                document.getElementById('tblFoodMenumapping').style.display = 'none';
                document.getElementById('tabContentIntegredients').style.display = 'none';
                document.getElementById('tblIngreMapping').style.display = 'none';
                document.getElementById('tblMenuDetails').style.display = 'none';
                document.getElementById('tblfoodmenumaster').style.display = 'none';
                $('#tablist').addClass('active');
            }

            else if (tabName == 'NFSM') {

                document.getElementById('tabContentCategory').style.display = 'none';
                document.getElementById('tabContentFoodlist').style.display = 'none';
                document.getElementById('tabsession').style.display = 'block';
                document.getElementById('tblFoodMenumapping').style.display = 'none';
                document.getElementById('tblfoodmenumaster').style.display = 'none';
                document.getElementById('tblMenuDetails').style.display = 'none';
                document.getElementById('tblIngreMapping').style.display = 'none';
                document.getElementById('tabContentIntegredients').style.display = 'none';
                $('#tabfoodsession').addClass('active');
            }
            else if (tabName == 'FMWM') {
                document.getElementById('tabContentCategory').style.display = 'none';
                document.getElementById('tabContentFoodlist').style.display = 'none';
                document.getElementById('tabsession').style.display = 'none';
                document.getElementById('tabContentIntegredients').style.display = 'none';
                document.getElementById('tblFoodMenumapping').style.display = 'block';
                document.getElementById('tblMenuDetails').style.display = 'none';
                document.getElementById('tblfoodmenumaster').style.display = 'none';
                document.getElementById('tblIngreMapping').style.display = 'none';
                $('#tabfoodmenuwardmapping').addClass('active');
            }
            else if (tabName == 'NFI') {
                document.getElementById('tabContentCategory').style.display = 'none';
                document.getElementById('tabContentFoodlist').style.display = 'none';
                document.getElementById('tabsession').style.display = 'none';
                document.getElementById('tblFoodMenumapping').style.display = 'none';
                document.getElementById('tblMenuDetails').style.display = 'none';
                document.getElementById('tblIngreMapping').style.display = 'none';
                document.getElementById('tblfoodmenumaster').style.display = 'none';
                document.getElementById('tabContentIntegredients').style.display = 'block';
                $('#tabfoodintegr').addClass('active');
            }
            else if (tabName == 'FMD') {
                document.getElementById('tabContentCategory').style.display = 'none';
                document.getElementById('tabContentFoodlist').style.display = 'none';
                document.getElementById('tabsession').style.display = 'none';
                document.getElementById('tabContentIntegredients').style.display = 'none';
                document.getElementById('tblFoodMenumapping').style.display = 'none';
                document.getElementById('tblIngreMapping').style.display = 'none';
                document.getElementById('tblfoodmenumaster').style.display = 'none';
                document.getElementById('tblMenuDetails').style.display = 'block';
                $('#tabmenudetails').addClass('active');
            }
            else if (tabName == 'FMIM') {
                document.getElementById('tabContentCategory').style.display = 'none';
                document.getElementById('tabContentFoodlist').style.display = 'none';
                document.getElementById('tabsession').style.display = 'none';
                document.getElementById('tabContentIntegredients').style.display = 'none';
                document.getElementById('tblFoodMenumapping').style.display = 'none';
                document.getElementById('tblfoodmenumaster').style.display = 'none';
                document.getElementById('tblMenuDetails').style.display = 'none';
                document.getElementById('tblIngreMapping').style.display = 'block';
                $('#tabfoodintgntsmap').addClass('active');
            }
            else {
                document.getElementById('tabContentCategory').style.display = 'none';
                document.getElementById('tabContentFoodlist').style.display = 'none';
                document.getElementById('tabsession').style.display = 'none';
                document.getElementById('tabContentIntegredients').style.display = 'none';
                document.getElementById('tblFoodMenumapping').style.display = 'none';
                document.getElementById('tblIngreMapping').style.display = 'none';
                document.getElementById('tblMenuDetails').style.display = 'none';
                document.getElementById('tblfoodmenumaster').style.display = 'block';
                $('#tabmenumaster').addClass('active');
            }

        }
            
       
   
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <uc6:UserHeader ID="UserHeader1" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer" />
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
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table width="100%">
                            <tr>
                                <td valign="top">
                                    <div id='TabsMenus' align="left">
                                        <ul>
                                            <li id="tabcategory" class="active" onclick="DisplayTab('CAT')"><a href='#'><span>
                                                <asp:Label ID="lblfoodcategory" runat="server" Text="Food Category" 
                                                    meta:resourcekey="lblfoodcategoryResource1" ></asp:Label></span></a></li>
                                            <li id="tablist" onclick="DisplayTab('LIST')"><a href='#'><span>
                                                <asp:Label ID="lblNutritionFoodList" runat="server" Text="Food List" 
                                                    meta:resourcekey="lblNutritionFoodListResource1" ></asp:Label></span></a></li>
                                            <li id="tabfoodsession" onclick="DisplayTab('NFSM')"><a href='#'><span>
                                                <asp:Label ID="lblNutritionFoodSessionMaster" runat="server" 
                                                    Text="Food Session Master" 
                                                    meta:resourcekey="lblNutritionFoodSessionMasterResource1"></asp:Label></span></a></li>
                                            <li id="tabmenumaster" onclick="DisplayTab('FMM')"><a href='#'><span>
                                                <asp:Label ID="lblFoodMenuMastertab" runat="server" Text="Food Menu Master" 
                                                    meta:resourcekey="lblFoodMenuMastertabResource1"></asp:Label></span></a></li>
                                            <li id="tabfoodintegr" onclick="DisplayTab('NFI')"><a href='#'><span>
                                                <asp:Label ID="lblFoodIntegredients" runat="server" Text="Food Integredients" 
                                                    meta:resourcekey="lblFoodIntegredientsResource1"></asp:Label></span></a></li>
                                            <li id="tabfoodmenuwardmapping" onclick="DisplayTab('FMWM')"><a href='#'><span>
                                                <asp:Label ID="lblFoodMenuWardMapping" runat="server" 
                                                    Text="Food Menu Ward Mapping" 
                                                    meta:resourcekey="lblFoodMenuWardMappingResource1"></asp:Label></span></a></li>
                                            <li id="tabmenudetails" onclick="DisplayTab('FMD')"><a href='#'><span>
                                                <asp:Label ID="Lblmenudetails" runat="server" Text="Food Menu Details" 
                                                    meta:resourcekey="LblmenudetailsResource1"></asp:Label></span></a></li>
                                            <li id="tabfoodintgntsmap" onclick="DisplayTab('FMIM')"><a href='#'><span>
                                                <asp:Label ID="lblFoodIntegredientsMapping" runat="server" 
                                                    Text="Food Integredients Mapping" 
                                                    meta:resourcekey="lblFoodIntegredientsMappingResource1"></asp:Label></span></a></li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <table width="100%">
                            <tr>
                                <td valign="top">
                                    <table border="0" cellpadding="0" cellspacing="0" id="tblFoodMenumapping" style="display: none;">
                                        <tr>
                                            <td id="tdFoodMenumapping" runat="server" valign="top">
                                                <ucdiet3:foodmenuwardmapping ID="FoodMenu" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                    <table border="0" cellpadding="0" width="100%" cellspacing="0" id="tabContentCategory">
                                        <tr>
                                            <td id="tdCategory" runat="server" valign="top">
                                                <ucDiet:ucNFC ID="NFC" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                    <table border="0" cellpadding="1" width="100%" cellspacing="0" id="tabContentFoodlist"
                                        style="display: none;">
                                        <tr>
                                            <td id="tdFoodlist" runat="server" valign="top">
                                                <ucDiet1:ucNFL ID="NFL" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" id="tabContentIntegredients"
                                        style="display: none;">
                                        <tr>
                                            <td id="tdIntegredients" runat="server" valign="top">
                                                <ucDiet2:ucNFI ID="NFI" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="tblfoodmenumaster"
                                        style="display: none;">
                                        <tr>
                                            <td id="tdfoodmenumaster" runat="server" valign="top">
                                                <MenuMaster:FoodMenu ID="FoodMenuMaster" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                    <table border="0" cellpadding="0" width="100%" cellspacing="0" id="tabsession" style="display: none;">
                                        <tr>
                                            <td id="tdsession" runat="server" valign="top">
                                                <SessionMaster:FoodSession ID="FoodSessionMaster" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                    <table border="0" cellpadding="0" width="100%" cellspacing="0" id="tblMenuDetails"
                                        style="display: none;">
                                        <tr>
                                            <td id="td1" runat="server" valign="top">
                                                <MenuDeatails:MenuDeatails ID="FoodMenuDetails" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                    <table border="0" cellpadding="0" width="100%" cellspacing="0" id="tblIngreMapping"
                                        style="display: none;">
                                        <tr>
                                            <td id="td2" runat="server" valign="top">
                                                <IngredientsMapping:FoodMenuIngrMapping ID="IngreMapping" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
