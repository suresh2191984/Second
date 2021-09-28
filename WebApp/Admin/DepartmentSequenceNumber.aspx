<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DepartmentSequenceNumber.aspx.cs"
    Inherits="Admin_DepartmentSequenceNumber" EnableEventValidation="false" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="../QMS/plugins/multiselect/css/bootstrap-multiselect.css"
        type="text/css" />
    <title></title>
    <style type="text/css">
        .show
        {
            display: block !important;
        }
        .w-75p
        {
            width: 75% !important;
        }
        .w-50p
        {
            width: 50% !important;
        }
        .paddingT100
        {
            padding-top: 100px;
        }
        .paddingT50
        {
            padding-top: 50px;
        }
        /*******************Common.Css Modal PopUP Jquery****************************/.modalDiag
        {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
        .closeModalDiag
        {
            color: white;
            float: right;
            font-size: 12px;
            font-weight: bold;
            padding: 3px;
            border: 1px solid #fff;
            border-radius: 5px;
            width: 15px;
            height: 15px;
            text-align: center;
        }
        .closeModalDiag:hover, .closeModalDiag:focus
        {
            color: #ccc;
            text-decoration: none;
            cursor: pointer;
            padding: 3px;
            border: 1px solid #fff;
            border-radius: 5px;
            width: 25px;
            height: 25px;
            text-align: center;
        }
        /* modaldiag1 Body */.modalDiag-body
        {
            padding: 16px 16px !important;
            overflow: auto;
        }
        /*******************End of Common.Css ****************************//*******************Green Theme Modal PopUP Jquery****************************//* modaldiag1 Header */.modalDiag-header
        {
            padding: 12px 16px !important;
            background-color: #008080;
            color: white;
        }
        /* modaldiag1 Footer */.modalDiag-footer
        {
            padding: 12px 16px !important;
            background-color: #008080;
            color: white;
        }
        /* modaldiag1 Content */.modalDiag-content
        {
            position: relative;
            background-color: #fefefe;
            margin: auto;
            padding: 0;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
            -webkit-animation-name: animatetop;
            -webkit-animation-duration: 0.7s;
            animation-name: animatetop;
            animation-duration: 0.7s;
            border-radius: 10px;
        }
        .modalDiag-content1
        {
            position: relative;
            background-color: #fefefe;
            margin: auto;
            padding: 0;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
            -webkit-animation-name: animaterevtop;
            -webkit-animation-duration: 0.7s;
            animation-name: animaterevtop;
            animation-duration: 0.7s;
            border-radius: 10px;
        }
        /* Add Animation */@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframesanimatetop{from{top:-300px;opacity:0}
        to
        {
            top: 0;
            opacity: 1;
        }
        }@keyframesanimatetop{from{top:-300px;opacity:0}
        to
        {
            top: 0;
            opacity: 1;
        }
        }@-webkit-keyframesanimaterevtop{from{top:0;opacity:1}
        to
        {
            top: -300px;
            opacity: 0;
        }
        }@keyframesanimaterevtop{from{top:0;opacity:1}
        to
        {
            top: -300px;
            opacity: 0;
        }
        }/*******************End of Green Theme Modal PopUP Jquery****************************//*******************Blue Theme Modal PopUP Jquery****************************//* modaldiag1 Header */
        .modalDiag-header
        {
            padding: 12px 16px !important;
            background-color: ##4e7b9c;
            color: white;
        }
        /* modaldiag1 Footer */.modalDiag-footer
        {
            padding: 12px 16px !important;
            background-color: #3e6f8a;
            color: white;
        }
        /* modaldiag1 Content */.modalDiag-content
        {
            position: relative;
            background-color: #fefefe;
            margin: auto;
            padding: 0;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
            -webkit-animation-name: animatetop;
            -webkit-animation-duration: 0.7s;
            animation-name: animatetop;
            animation-duration: 0.7s;
            border-radius: 10px;
        }
        .modalDiag-content1
        {
            position: relative;
            background-color: #fefefe;
            margin: auto;
            padding: 0;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
            -webkit-animation-name: animaterevtop;
            -webkit-animation-duration: 0.7s;
            animation-name: animaterevtop;
            animation-duration: 0.7s;
            border-radius: 10px;
        }
        /* Add Animation */@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframesanimatetop{from{top:-300px;opacity:0}
        to
        {
            top: 0;
            opacity: 1;
        }
        }@keyframesanimatetop{from{top:-300px;opacity:0}
        to
        {
            top: 0;
            opacity: 1;
        }
        }@-webkit-keyframesanimaterevtop{from{top:0;opacity:1}
        to
        {
            top: -300px;
            opacity: 0;
        }
        }@keyframesanimaterevtop{from{top:0;opacity:1}
        to
        {
            top: -300px;
            opacity: 0;
        }
        }/*******************End of Blue Theme Modal PopUP Jquery****************************//*******************Black Theme Modal PopUP Jquery****************************//* modaldiag1 Header */
        .modalDiag-header
        {
            padding: 12px 16px !important;
            background-color: #4e7b9c;
            color: white;
        }
        /* modaldiag1 Footer */.modalDiag-footer
        {
            padding: 12px 16px !important;
            background-color: #777777;
            color: white;
        }
        /* modaldiag1 Content */.modalDiag-content
        {
            position: relative;
            background-color: #fefefe;
            margin: auto;
            padding: 0;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
            -webkit-animation-name: animatetop;
            -webkit-animation-duration: 0.7s;
            animation-name: animatetop;
            animation-duration: 0.7s;
            border-radius: 10px;
        }
        .modalDiag-content1
        {
            position: relative;
            background-color: #fefefe;
            margin: auto;
            padding: 0;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
            -webkit-animation-name: animaterevtop;
            -webkit-animation-duration: 0.7s;
            animation-name: animaterevtop;
            animation-duration: 0.7s;
            border-radius: 10px;
        }
        /* Add Animation */@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframes@-webkit-keyframesanimatetop{from{top:-300px;opacity:0}
        to
        {
            top: 0;
            opacity: 1;
        }
        }@keyframesanimatetop{from{top:-300px;opacity:0}
        to
        {
            top: 0;
            opacity: 1;
        }
        }@-webkit-keyframesanimaterevtop{from{top:0;opacity:1}
        to
        {
            top: -300px;
            opacity: 0;
        }
        }@keyframesanimaterevtop{from{top:0;opacity:1}
        to
        {
            top: -300px;
            opacity: 0;
        }
        }/*******************End of Black Theme Modal PopUP Jquery****************************/
        #tableArea
        {
            height: 250px;
            overflow-y: auto;
        }
        .divArea
        {
            width: 70%;
            height: 70px;
            border: 2px solid black;
            margin: auto;
            background: white;
            z-index: 1;
            border-radius: 10px 10px 10px 10px;
        }
        .txtDisabled
        {
            font-weight: 700;
        }
        .trrow
        {
            background-color: White;
        }
         .Margin50
        {
            margin-bottom:10px;
            margin-left:10px;
            margin-right:10px;
            margin-top:10px;
        }
        .toodle
        {
            font-size: x-large;
            font-weight: bold;
        }
        .mytable1 td, .mytable1 th
        {
            border: 1px solid #686868;
            border-bottom: 1px solid #686868;
        }
        .searchBox
        {
            font-family: Arial, Helvetica, sans-serif;
            text-align: left;
            height: 15px;
            width: 150px;
            border: 1px solid #999999;
            font-size: 11px;
            margin-left: 0px;
            background-image: url('../Images/magnifying-glass.png');
            background-repeat: no-repeat;
            padding-left: 20px;
            background-color: #F3E2A9;
        }
        .mediumList
        {
            min-width: 330px;
        }
        .bigList
        {
            min-width: 800px;
        }
        .listMain
        {
            min-height: 0px;
        }
        h1, h2, h3, h4, h5, h6
        {
            margin: 10px 0;
            font-family: inherit;
            font-weight: bold;
            line-height: 1;
            color: inherit;
            text-rendering: optimizelegibility;
        }
        h1 small, h2 small, h3 small, h4 small, h5 small, h6 small
        {
            font-weight: normal;
            line-height: 1;
            color: #999999;
        }
        h1
        {
            font-size: 36px;
            line-height: 40px;
        }
        h2
        {
            font-size: 30px;
            line-height: 40px;
        }
        h3
        {
            font-size: 24px;
            line-height: 40px;
        }
        h4
        {
            font-size: 18px;
            line-height: 20px;
        }
        h5
        {
            font-size: 14px;
            line-height: 20px;
        }
        h6
        {
            font-size: 12px;
            line-height: 20px;
        }
        h1 small
        {
            font-size: 24px;
        }
        h2 small
        {
            font-size: 18px;
        }
        h3 small
        {
            font-size: 14px;
        }
        h4 small
        {
            font-size: 14px;
        }
        .close
        {
            float: right;
            font-size: 20px;
            font-weight: bold;
            line-height: 20px;
            color: #000000;
            text-shadow: 0 1px 0 #ffffff;
            opacity: 0.2;
            filter: alpha(opacity=20);
        }
        .close:hover
        {
            color: #000000;
            text-decoration: none;
            cursor: pointer;
            opacity: 0.4;
            filter: alpha(opacity=40);
        }
        button.close
        {
            padding: 0;
            cursor: pointer;
            background: transparent;
            border: 0;
            -webkit-appearance: none;
        }
        .modal-backdrop
        {
            position: fixed;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            z-index: 100;
            background-color: #000000;
        }
        .modal-backdrop.fade
        {
            opacity: 0;
        }
        .modal-backdrop, .modal-backdrop.fade.in
        {
            opacity: 0.8;
            filter: alpha(opacity=80);
        }
        .modal
        {
            font-family: "Helvetica Neue" , Helvetica, Arial, sans-serif;
            font-size: 14px;
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            z-index: 1050;
            margin: -250px 0 0 -280px;
            overflow: auto;
            color: #333333;
            padding: 3px;
            background-color: #e0ebf5;
            border: 1px solid #999;
            border: 1px solid rgba(0, 0, 0, 0.3); *border:1pxsolid#999;-webkit-border-radius:6px;-moz-border-radius:6px;border-radius:6px;-webkit-box-shadow:03px7pxrgba(0, 0, 0, 0.3);-moz-box-shadow:03px7pxrgba(0, 0, 0, 0.3);box-shadow:03px7pxrgba(0, 0, 0, 0.3);-webkit-background-clip:padding-box;-moz-background-clip:padding-box;background-clip:padding-box;}
        .modal-header
        {
            padding: 9px 15px;
            border-bottom: 1px solid #eee;
        }
        .modal-header .close
        {
            margin-top: 2px;
        }
        .modal-header h3
        {
            margin: 0;
            line-height: 30px;
        }
        .modal-body
        {
            max-height: 400px;
            padding: 15px;
            overflow-y: auto;
        }
        .modal-form
        {
            margin-bottom: 0;
        }
        .modal-footer
        {
            padding: 14px 15px 15px;
            margin-bottom: 0;
            text-align: right;
            background-color: #e0ebf5;
            color: #333333;
            border-top: 1px solid #ddd;
            -webkit-border-radius: 0 0 6px 6px;
            -moz-border-radius: 0 0 6px 6px;
            border-radius: 0 0 6px 6px; *zoom:1;-webkit-box-shadow:inset01px0#ffffff;-moz-box-shadow:inset01px0#ffffff;box-shadow:inset01px0#ffffff;}
        .modal-footer:before, .modal-footer:after
        {
            display: table;
            line-height: 0;
            content: "";
        }
        .modal-footer:after
        {
            clear: both;
        }
        .modal-footer .btn + .btn
        {
            margin-bottom: 0;
            margin-left: 5px;
        }
        .modal-footer .btn-group .btn + .btn
        {
            margin-left: -1px;
        }
        fieldset
        {
            border: 1px solid green;
            padding: 5px;
            text-align: left;
        }
        legend
        {
            margin-bottom: 0px;
            margin-left: 5px;
            padding: 1px;
            font-size: 12px;
            font-weight: bold;
            color: White;
            text-align: right;
            background-color: #2C88B1;
        }
        .auto-style1
        {
            color: #E81144;
        }
        .auto-style2
        {
            color: #E81144;
        }
        pre
        {
            margin: 10px 0px 10px 0px;
        }
        strong
        {
            font-weight: bold;
            color: #5F5F5F;
        }
        .auto-style3
        {
            color: #DD1144;
        }
        .auto-style4
        {
            color: #6666FF;
        }
        .auto-style5
        {
            width: 100%;
        }
        .auto-style6
        {
            width: 344px;
        }
        .SumoSelect
        {
            font-size: 12px;
        }
        .optWrapper.multiple ul li
        {
            float: none;
        }
        .outer
        {
            width: 100%;
            text-align: center;
        }
        .inner
        {
        }
        .btn-group, .btn-group-vertical
        {
            position: relative;
            vertical-align: middle;
        }
        .btn-group > .btn:first-child
        {
            margin-left: 0;
        }
        .btn-group > .btn, .btn-group-vertical > .btn
        {
            position: relative;
            float: left;
        }
        .btn.btn-default.multiselect
        {
            padding: 6px 12px;
            margin-bottom: 0;
            font-size: 12px;
            width:250px;
            font-weight: normal;
            line-height: 0.428571;
            text-align: left;
            height:23px;
            text-align:left;
            white-space: nowrap;
            vertical-align: middle;
            cursor: pointer;
            background-image: none;
            border: 1px solid transparent;
            border-radius: 4px;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            -o-user-select: none;
            user-select: none;
            color: #333;
            background-color: #fff;
            border-color: #ccc;
        }
        .btn-default:hover, .btn-default:focus, .btn-default:active, .btn-default.active, .open .dropdown-toggle.btn-default
        {
            color: #333;
            background-color: #ebebeb;
            border-color: #adadad;
        }
        .multiselect-container.dropdown-menu
        {
            position: absolute;
            top: 100%;
            left: 0;
            z-index: 1000;
            display: none;
            float: left;
            min-width: 160px;
            padding: 5px 0;
            margin: 2px 0 0;
            font-size: 14px;
            list-style: none;
            background-color: #fff;
            border: 1px solid #ccc;
            border: 1px solid rgba(0,0,0,0.15);
            border-radius: 4px;
            -webkit-box-shadow: 0 6px 12px rgba(0,0,0,0.175);
            box-shadow: 0 6px 12px rgba(0,0,0,0.175);
            background-clip: padding-box;
        }
        .multiselect-container.dropdown-menu li
        {
            float: none;
        }
        .open > .dropdown-menu
        {
            display: block;
        }
        .btn-group.open .dropdown-toggle
        {
            -webkit-box-shadow: inset 0 3px 5px rgba(0,0,0,.125);
            
            box-shadow: inset 0 3px 5px rgba(0,0,0,.125);
        }
        .multiselect-container > li > a > label.checkbox
        {
            margin: 0;
            padding: 3px 20px 3px 10px !important;
        }
        .up
        {
            color: Red;
        }
        .down
        {
            color: Blue;
        }
        .tableHeading
        {
            background-color: #999994;
            font-weight: bold;
            font-size: 12pt;
        }
        <%--#TabContainer1_tabDepsigMap_GrdSigMapLoc tr td:first-child,#TabContainer1_tabDepsigMap_GrdSigMapLoc tr th:first-child
        {
            display: block;
        }--%>
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" ScriptMode="Release" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table cellpadding="0" cellspacing="0" border="0" class="searchPanel w-100p">
            <tr>
                <td>
                    <asp:UpdatePanel ID="upd" runat="server">
                        <ContentTemplate>
                            <ajc:TabContainer ID="TabContainer1" runat="server" Width="929px" ActiveTabIndex="0">
                                <ajc:TabPanel ID="TabPanel2" runat="server"  CssClass="dataheadergroup" HeaderText="Manage Department"
                                    meta:resourcekey="TabPanel2Resource1">
                                    
                                    <HeaderTemplate>
                                        Manage Department
                                    </HeaderTemplate>
                                    <ContentTemplate>
                                    <table class=Margin50"><tr><td></td></tr></table>
                                        <table class="w-100p">
                                            <tr id="tr2" runat="server">
                                                <td id="Td3" align="left" runat="server" colspan="2">
                                                    <asp:Label ID="Label11" Width="160px" Text="Dept Name" runat="server" Font-Size="Small"
                                                        meta:resourcekey="lblNewDeptResource1"></asp:Label>
                                                    <asp:TextBox ID="txtdeptName" runat="server" CssClass="Txtboxmedium" Font-Bold="True"
                                                        Font-Size="Small" meta:resourcekey="txtDeptaddResource1"></asp:TextBox>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                    &nbsp;
                                                    <asp:Label ID="Label12" Text="Code " runat="server" Font-Size="Small" meta:resourcekey="lblCodeResource1"></asp:Label>
                                                    <asp:TextBox ID="txtcodeDep" Width="50px" MaxLength="5" CssClass="Txtboxmedium" runat="server"
                                                        Font-Bold="True" Font-Size="Small" meta:resourcekey="txtCodeResource1"></asp:TextBox>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label5" Width="160px" Text="Display" runat="server" Font-Size="Small"></asp:Label>
                                                    <asp:CheckBox ID="chkDisplay" runat="server" Width="62px" Font-Bold="True" Checked="True" />
                                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;
                                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                    <asp:Label ID="Label6" Text="Dept Code" runat="server" Font-Size="Small"></asp:Label>
                                                    <asp:TextBox ID="txtDeptCode" Width="50px" MaxLength="7" onkeypress="return ValidateOnlyNumeric(this);" runat="server" CssClass="Txtboxmedium" Font-Bold="True"
                                                        Font-Size="Small"></asp:TextBox>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label7" Width="160px" Text="Print Seperately" runat="server" Font-Size="Small"></asp:Label>
                                                    <asp:CheckBox ID="ChkPriSe" runat="server" Font-Bold="True" Checked="True" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label3" Width="160px" Text="Scan In Required?" runat="server" Font-Size="Small"></asp:Label>
                                                    <asp:CheckBox ID="ChkSacn" runat="server" Font-Bold="True" Checked="True" />
                                                </td>
                                            </tr>    
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label2" Width="160px" Text="Shareable" runat="server" Font-Size="Small"></asp:Label>
                                                    <asp:CheckBox ID="Chkshareable" runat="server" Font-Bold="True" />
                                                </td>
                                            </tr>
                                             <tr id="trclientSMS" runat="server" style="display:none;">
                                                <td>
                                                    <asp:Label ID="lblClientpatientSMS" Width="160px" Text="Dept Level Patient SMS?" runat="server" Font-Size="Small"></asp:Label>
                                                    <asp:CheckBox ID="chkClientPatientSMS" runat="server" Font-Bold="True" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 10px">
                                                </td>
                                            </tr>
                                            <tr style="height: 10px">
                                                <td>
                                                    <asp:Label ID="Label8" Width="160px" Text="Location list" Font-Bold="True" runat="server"
                                                        Font-Size="Small"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 10px">
                                                    <asp:Label ID="Label1" Width="160px" GroupingText="Select Location" BorderColor="#547D97"
                                                        Font-Bold="True" Text="Select Location" runat="server" Font-Size="Small"></asp:Label>
                                                    <asp:CheckBox ID="chkAllLocations" runat="server" Text="Select All" OnClick="ChkAllLocations(this);"
                                                        meta:resourcekey="chkAllLocationsResource1" />
                                                    <br />
                                                    <br />
                                                    <asp:CheckBoxList ID="chkLocations" runat="server" RepeatColumns="3" Font-Bold="False"
                                                        OnClick="checkedfunc();" meta:resourcekey="chkLocationsResource1">
                                                    </asp:CheckBoxList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="Td4" runat="server" class="w-70p" style="display: none;">
                                                    <asp:Label ID="Label9" Width="160px" Text="Add new department" runat="server" Font-Bold="True"
                                                        Font-Size="Small" meta:resourcekey="lblNewDeptResource1"></asp:Label>
                                                    <asp:TextBox ID="TextBox2" runat="server" CssClass="Txtboxmedium" Font-Bold="True"
                                                        Font-Size="Small" meta:resourcekey="txtDeptaddResource1"></asp:TextBox>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                    &nbsp;
                                                    <asp:Label ID="Label10" Text="Code " runat="server" Font-Bold="True" Font-Size="Small"
                                                        meta:resourcekey="lblCodeResource1"></asp:Label>
                                                    <asp:TextBox ID="TextBox3" Width="50px" MaxLength="5" CssClass="Txtboxmedium" runat="server"
                                                        Font-Bold="True" Font-Size="Small" meta:resourcekey="txtCodeResource1"></asp:TextBox>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td class="a-center">
                                                    <asp:Button ID="btnSaveLoc" runat="server" Text="Save" Width="60px" OnClick="btnSaveLocations_Click"
                                                        OnClientClick="return fncsave();" CssClass="btn" meta:resourcekey="btnDeptsaveResource1" />
                                                    <asp:Button ID="btnCancelDep" runat="server" Text="Cancel" Width="60px" OnClick="btnCancelDep_Click"
                                                        CssClass="btn" meta:resourcekey="btnCancelResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                        <table class="w-100p" cellpadding="3" cellspacing="3">
                                            <tr>
                                                <td>
                                                    <div id="divGrid" runat="server" style="display: block">
                                                        <asp:GridView ID="grdDeptLoc" AllowPaging="True" runat="server" CssClass="gridView w-100p"
                                                            ForeColor="Black" Width="929px" CellPadding="4" AutoGenerateColumns="False" OnPageIndexChanging="grdDeptLoc_PageIndexChanging"
                                                            PageSize="8" OnRowCommand="grdDeptLoc_RowCommand" DataKeyNames="DeptName,DeptID,Code,DeptCode,Display,PrintSeparately,LocationDetails,IsScanInRequired,IsShareAble,IsClientSMS"
                                                            OnRowDataBound="grdDeptLoc_RowDataBound" meta:resourcekey="grdDeviceResource1">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Dept Name" SortExpression="DepartmetName" meta:resourcekey="TemplateFieldResource1">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtDeptNameLoc" runat="server" Text='<%# Bind("DeptName") %>' meta:resourcekey="txtDeviceNameResource1"></asp:TextBox>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblDeptNameLoc" runat="server" Text='<%# Bind("DeptName") %>' meta:resourcekey="lblDeviceNameResource1"></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="DeptID" SortExpression="DeptID" Visible="False" meta:resourcekey="TemplateFieldResource2">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtDeptLocID" runat="server" Text='<%# Bind("DeptID") %>' meta:resourcekey="txtInstrumentIDResource1"></asp:TextBox>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblDeptLocID" runat="server" Text='<%# Bind("DeptID") %>' meta:resourcekey="lblInstrumentIDResource1"></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Code" SortExpression="Code" meta:resourcekey="TemplateFieldResource4">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtCodeLoc" runat="server" Text='<%# Bind("Code") %>' meta:resourcekey="txtDeviceIDResource2"></asp:TextBox>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblCodeLoc" runat="server" Text='<%# Bind("Code") %>' meta:resourcekey="lblDeviceIDResource1"></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Dept Code" SortExpression="Dept Code" meta:resourcekey="TemplateFieldResource5">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtDeptCodeLoc" runat="server" Text='<%# Bind("DeptCode") %>' meta:resourcekey="txtTestCodeResource2"></asp:TextBox>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblDeptCodeLoc" runat="server" Text='<%# Bind("DeptCode") %>' meta:resourcekey="lblTestCodeResource2"></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Display" SortExpression="InvestigationName" meta:resourcekey="TemplateFieldResource6">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtDisplayLoc" runat="server" Text='<%# Bind("Display") %>' meta:resourcekey="txtInvestigationNameResource1"></asp:TextBox>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblDisplayLoc" runat="server" Text='<%# Bind("Display") %>' meta:resourcekey="lblInvestigationNameResource1"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Print Separately" SortExpression="PrintSeparately">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtPrtsp" runat="server" Text='<%# Bind("PrintSeparately") %>' meta:resourcekey="lblInvestigationIDResource1"></asp:TextBox>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblPrtsp" runat="server" Text='<%# Bind("PrintSeparately") %>' meta:resourcekey="lblInvestigationIDResource2"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                 <asp:TemplateField HeaderText="IsShareable" SortExpression="IsShareable">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtIsShare" runat="server" Text='<%# Bind("IsShareAble") %>' ></asp:TextBox>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblShare" runat="server" 
                                                                        
                                                                          Text='<%# Eval("IsShareAble").ToString() == "True"? "Yes" : "No" %>'
                                                                        ></asp:Label>
                                                                        <%--Text='<%# Bind("IsShareAble") %>' --%>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Locations" SortExpression="Locations">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtLocationID" runat="server" Text='<%# Bind("location") %>' meta:resourcekey="lblInvestigationIDResource1"></asp:TextBox>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblLocation" runat="server" Text='<%# Bind("location") %>' meta:resourcekey="lblInvestigationIDResource2"></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="LocationID" SortExpression="Locations" Visible="False">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="lblLocationID1" runat="server" Text='<%# Bind("LocationDetails") %>'
                                                                            meta:resourcekey="lblInvestigationIDResource1"></asp:TextBox>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblLocationID" runat="server" Text='<%# Bind("LocationDetails") %>'
                                                                            meta:resourcekey="lblInvestigationIDResource2"></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Scan In Required">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblAutoScanIn" runat="server" 
                                                                        Text='<%# Eval("IsScanInRequired").ToString() == "True"? "Yes" : "No" %>'
                                                                        
                                                                           ></asp:Label>
                                                                           
                                                                           <%--Text='<%# Bind("IsScanInRequired") %>'--%>
                                                                    </ItemTemplate>
                                                                      <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="ISPatientSMS" Visible=false>
                                                                <ItemTemplate >
                                                                 <asp:Label ID="LblclientSMS" runat="server" 
                                                                        Text='<%# Eval("IsClientSMS").ToString() == "True"? "Yes" : "No" %>'
                                                                        
                                                                           ></asp:Label>
                                                                           
                                                                           
                                                                    </ItemTemplate>
                                                                      <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource9">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="btnEdit" CommandName="EditRow" CommandArgument="<%# ((GridViewRow)Container).RowIndex %>"
                                                                            runat="server" Text="Edit" ForeColor="Blue" Font-Underline="True" Font-Size="12px"
                                                                            Font-Bold="True" meta:resourcekey="btnEditResource1" />
                                                                    </ItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Left" />
                                                                    <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <EmptyDataRowStyle BackColor="LightBlue" ForeColor="Black" />
                                                            <HeaderStyle CssClass="colorforcontent" ForeColor="White" />
                                                            <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        </asp:GridView>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                        <div>
                                        </div>
                                    </ContentTemplate>
                                </ajc:TabPanel>
                                <ajc:TabPanel ID="TabPanel3" runat="server" CssClass="dataheadergroup" HeaderText="Department Sequence Number"
                                    meta:resourcekey="TabPanel2Resource1">
                                    <HeaderTemplate>
                                        <%--Department Sequence Number--%>
                                        <%=Resources.CommonControls_ClientDisplay.CommonControls_SequenceArrangement_ascx_002%>
                                    </HeaderTemplate>
                                    <ContentTemplate>
                                        <table class="w-100p" style="display: none;">
                                            <tr id="trSelectDept" runat="server">
                                                <td id="Td1" align="left" runat="server" colspan="2">
                                                    <%=Resources.CommonControls_ClientDisplay.CommonControls_SequenceArrangement_ascx_003%>
                                                    <asp:DropDownList ID="ddlDeptName" runat="server" CssClass="ddllarge">
                                                    </asp:DropDownList>
                                                    &nbsp;&nbsp;
                                                    <input type="button" id="btnAddNew" value="Add new" onclick="ShowHideDept('Add');"
                                                        style="width: 85px;" class="btn" runat="server" meta:resourcekey="btnAddNewResource1" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="trAddNewDept" runat="server" class="w-70p" style="display: none;">
                                                    <asp:Label ID="lblNewDept" Width="160px" Text="Dept Name" runat="server" Font-Bold="True"
                                                        Font-Size="Small" meta:resourcekey="lblNewDeptResource1"></asp:Label>
                                                    <asp:TextBox ID="txtDeptadd" Height="20px" runat="server" CssClass="Txtboxmedium"
                                                        Font-Bold="True" Font-Size="Small" meta:resourcekey="txtDeptaddResource1"></asp:TextBox>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                    &nbsp;
                                                    <asp:Label ID="lblCode" Text="Code " runat="server" Font-Bold="True" Font-Size="Small"
                                                        meta:resourcekey="lblCodeResource1"></asp:Label>
                                                    <asp:TextBox ID="txtCode" Height="20px" Width="50px" MaxLength="5" CssClass="Txtboxmedium"
                                                        runat="server" Font-Bold="True" Font-Size="Small" meta:resourcekey="txtCodeResource1"></asp:TextBox>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td class="a-center">
                                                    <asp:Button ID="btnDeptsave" runat="server" Text="Save" Width="60px" OnClick="btnDeptsave_Click"
                                                        OnClientClick="return valid();" CssClass="btn" meta:resourcekey="btnDeptsaveResource1" />
                                                    <input type="button" id="btnCancel" value="Cancel" onclick="ShowHideDept('Cancel');"
                                                        class="btn" runat="server" meta:resourcekey="btnCancelResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                        <div id="Div1" runat="server" style="overflow: scroll; max-height: 500px; display: block">
                                            <asp:UpdatePanel ID="UpdatePanel" runat="server">
                                                <ContentTemplate>
                                                    <asp:GridView ID="GrdDept" EmptyDataText="No matching records found " runat="server"
                                                        AutoGenerateColumns="False" Width="929px" ForeColor="#333333" CellPadding="3" OnRowDataBound="Divbound"
                                                        OnPageIndexChanging="GrdDept_PageIndexChanging" 
                                                        OnRowCommand="GrdDept_RowCommand" AutoGenerateEditButton="True" OnRowEditing="GrdDept_RowEditing"
                                                        OnRowUpdating="GrdDept_RowUpdating" ShowFooter="True" OnRowCancelingEdit="GrdDept_RowCancelingEdit"
                                                        CssClass="gridView w-90p" meta:resourcekey="GrdDeptResource1">
                                                        <HeaderStyle CssClass="dataheader1" />
                                                        <Columns>
                                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource9">
                                                                <ItemTemplate>
                                                                    <asp:RadioButton ID="rdbcheck" runat="server" meta:resourcekey="rdbcheckResource3" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField HeaderText="SequenceNo" Visible="false" DataField="SequenceNo" meta:resourcekey="BoundFieldResource9" />
                                                            <asp:TemplateField HeaderText="DeptID" meta:resourcekey="TemplateFieldResource10">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="DeptID" runat="server" Text='<%# Bind("DeptID") %>' meta:resourcekey="DeptIDResource1"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Department Code" meta:resourcekey="TemplateFieldResource11">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="DeptCode" runat="server" Text='<%# Bind("Code") %>' meta:resourcekey="DeptCodeResource1"></asp:Label>
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="TxtCode" MaxLength="5" runat="server" Text='<%# Bind("Code") %>'
                                                                        meta:resourcekey="TxtCodeResource2"></asp:TextBox>
                                                                </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="DeptName" meta:resourcekey="TemplateFieldResource12">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbldept" runat="server" Text='<%# Bind("DeptName") %>' meta:resourcekey="lbldeptResource1"></asp:Label>
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="Txtdept" runat="server" Text='<%# Bind("DeptName") %>' meta:resourcekey="TxtdeptResource1"></asp:TextBox>
                                                                </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource13">
                                                                <ItemTemplate>
                                                                    <asp:ImageButton ID="btnUp" ImageUrl="~/Images/UpArrow.png" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                        CommandName="UP" meta:resourcekey="btnUpResource3" />
                                                                    <asp:ImageButton ID="btnDown" ImageUrl="~/Images/DownArrow.png" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                        CommandName="DOWN" meta:resourcekey="btnDownResource3" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Move" meta:resourcekey="TemplateFieldResource14">
                                                                <ItemTemplate>
                                                                    <asp:Button ID="btnmove" runat="server" CssClass="btn" Text="Move Here" CommandName="Move"
                                                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                        meta:resourcekey="btnmoveResource3" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    </asp:GridView>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                            <table width="100%" cellpadding="5" id="Table1" runat="server" cellspacing="0" border="0">
                                                <tr id="Tr1" runat="server">
                                                    <td id="Td2" align="center" runat="server">
                                                        <asp:Button ID="saveDept" runat="server" Text="Save DeptSequence" CssClass="btn"
                                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="saveDept_Click"
                                                            meta:resourcekey="btnsaveDeptResource3" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <asp:HiddenField ID="DeptIDLoc" runat="server" Value="0" />
                                            <asp:HiddenField ID="ChcUpfl" runat="server" Value="0" />
                                        </div>
                                    </ContentTemplate>
                                </ajc:TabPanel>
                                <ajc:TabPanel ID="TabPanel1" runat="server" HeaderText="Role Department Mapping"
                                    meta:resourcekey="TabPanel1Resource1">
                                    <HeaderTemplate>
                                        <%--Role Department Mapping--%>
                                        <%=Resources.CommonControls_ClientDisplay.CommonControls_SequenceArrangement_ascx_06%>
                                    </HeaderTemplate>
                                    <ContentTemplate>
                                        <div>
                                            <table class="w-100p" style="overflow: scroll; max-height: 100px;">
                                                <tr>
                                                    <td class="style1">
                                                        <asp:Label ID="lblRoleName" runat="server" Text="Select role" meta:resourcekey="lblRoleNameResource1"></asp:Label>
                                                        <asp:DropDownList ID="ddlRole" CssClass="ddl" runat="server" AutoPostBack="True"
                                                            OnSelectedIndexChanged="ddlRole_SelectedIndexChanged" meta:resourcekey="ddlRoleResource1">
                                                        </asp:DropDownList>
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td />
                                                </tr>
                                                <tr>
                                                    <td class="style1">
                                                        <asp:Label ID="Label4" runat="server" Text="Select department " meta:resourcekey="Label1Resource1"></asp:Label>
                                                        <asp:CheckBox ID="chkCheckAll" runat="server" onclick="checkAllItem(this);" Text="Select all"
                                                            meta:resourcekey="chkCheckAllResource1" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td />
                                                </tr>
                                                <tr>
                                                    <td class="style1">
                                                        <asp:CheckBoxList ID="checkLst" runat="server" Font-Size="Smaller" RepeatColumns="5"
                                                            meta:resourcekey="checkLstResource1">
                                                        </asp:CheckBoxList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="style1">
                                                        <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save" CssClass="btn"
                                                            Width="115px" OnClientClick="return validateSequenceArrangement();" meta:resourcekey="btnSaveResource1" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 20px">
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </ContentTemplate>
                                </ajc:TabPanel>
                                <ajc:TabPanel ID="TabManageHeader" runat="server" HeaderText="Manage Header" meta:resourcekey="TabManageHeaderResource1">
                                    <HeaderTemplate>
                                        <%--Manage Header--%>
                                        <%=Resources.CommonControls_ClientDisplay.CommonControls_SequenceArrangement_ascx_07%>
                                    </HeaderTemplate>
                                    <ContentTemplate>
                                        <table class="w-100p">
                                            <tr class="lh30">
                                                <td>
                                                    <asp:Label ID="lblHeaderName" Text="Header Name" CssClass="medium" runat="server"
                                                        meta:resourcekey="lblHeaderNameResource1" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtHeaderName" CssClass="medium" runat="server" meta:resourcekey="txtHeaderNameResource1" />
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkIsActive" runat="server" Text="IsActive" meta:resourcekey="chkIsActiveResource1" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnAdd" Text="SAVE" OnClientClick="return ValidationHeader();" OnClick="btnAdd_Click"
                                                        CssClass="btn" runat="server" meta:resourcekey="btnAddResource1" />
                                                </td>
                                            </tr>
                                            <tr class="lh30">
                                                <td colspan="4">
                                                    <div id="divManageHeader" runat="server" style="overflow: scroll; max-height: 450px;
                                                        display: block">
                                                        <asp:GridView ID="gvManageHeader" EmptyDataText="No matching records found " runat="server"
                                                            AutoGenerateColumns="False" Width="900px" ForeColor="#333333" CellPadding="3" OnRowDataBound="Divbound"
                                                            AllowPaging="true" PageSize="8" OnPageIndexChanging="gvManageHeader_PageIndexChanging"
                                                            OnRowCommand="gvManageHeader_RowCommand" AutoGenerateEditButton="True" OnRowEditing="gvManageHeader_RowEditing"
                                                            OnRowUpdating="gvManageHeader_RowUpdating" ShowFooter="True" OnRowCancelingEdit="gvManageHeader_RowCancelingEdit"
                                                            CssClass="gridView w-90p" meta:resourcekey="gvManageHeaderResource1">
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <Columns>
                                                                <asp:BoundField HeaderText="SequenceNo" Visible="False" DataField="SequenceNo" meta:resourcekey="BoundFieldResource10" />
                                                                <asp:TemplateField HeaderText="DeptID" meta:resourcekey="TemplateFieldResource15">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblDeptID" runat="server" Text='<%# Bind("HeaderID") %>' meta:resourcekey="lblDeptIDResource1"></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="DeptName" meta:resourcekey="TemplateFieldResource16">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbldeptName" runat="server" Text='<%# Bind("HeaderName") %>' meta:resourcekey="lbldeptNameResource1"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtdeptName" runat="server" Text='<%# Bind("HeaderName") %>' meta:resourcekey="txtdeptNameResource1"></asp:TextBox>
                                                                    </EditItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="IsActive" meta:resourcekey="TemplateFieldResource17">
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkIsActive" runat="server" Checked='<%# Eval("IsActive") %>' meta:resourcekey="chkIsActiveResource2" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        </asp:GridView>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </ajc:TabPanel>
                                <ajc:TabPanel ID="tabDepsigMap" runat="server" CssClass="dataheadergroup" HeaderText="Department Signature Mapping"
                                    meta:resourcekey="TabPanel2Resource1">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblHeader" Text="Department Signature Mapping" runat="server" Font-Size="Small"></asp:Label>
                                    </HeaderTemplate>
                                    <ContentTemplate>
                                        <div>
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Lblloca" Text="Select Location" runat="server" Font-Size="Small"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlLocationSig" AutoPostBack="true" OnSelectedIndexChanged="ddlLocationsig_SelectedIndexChanged"
                                                            runat="server" CssClass="ddllarge">
                                                        </asp:DropDownList>
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                </tr>
                                                  <tr>
                                                    <td align="left" colspan="1">
                                                        <asp:Label ID="lblDepartName" Text="Select Department" runat="server" Font-Size="Small"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlDeptSigMap" AutoPostBack="true" OnSelectedIndexChanged="ddlDeptSigMap_SelectedIndexChanged"
                                                            runat="server" CssClass="ddllarge">
                                                        </asp:DropDownList>
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblLoginName" Text="Select User Name" runat="server" Font-Size="Small"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlLoginName"  multiple="multiple" 
                                                            runat="server" meta:resourcekey="ddlSpeciesResource1">
                                                        </asp:DropDownList>
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" colspan="4">
                                                        <asp:Button ID="btnsaveSig" OnClick="btnsaveSig_Click" OnClientClick="return ValidationSig();"
                                                            CssClass="btn" Width="60px" Text="Save" runat="server"
                                                             />
                                                        <asp:Button ID="btnCanSig" OnClick="ClearFiled_Click" CssClass="btn" Width="60px"
                                                            meta:resourcekey="btnCancelResource1" runat="server" Text="Cancel" />
                                                    </td>
                                                </tr>
                                            </table>
                                                <asp:GridView Visible="false" ID="GrdSigMap" Width="800px" EmptyDataText="No matching records found "
                                                    ShowFooter="True" CssClass="gridView w-90p" AutoGenerateColumns="False" ForeColor="#333333"
                                                    PageSize="10" CellPadding="3" runat="server" OnRowDataBound="Sigbound" OnRowCommand="GrdSigMap_RowCommand"
                                                    DataKeyNames="ID,DeptID,DeptName,AddressID,Location,UserID,UserName,SeqNo,Defaultsig"
                                                    meta:resourcekey="GrdDeptResource1">
                                                    <HeaderStyle CssClass="dataheader1" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Edit">
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnEditSeq" runat="server" CssClass="btn" Text="Edit" CommandName="Editrow"
                                                                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField meta:resourcekey="TemplateFieldResource9">
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chckDis" runat="server" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="DeptID" Visible="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="ID" runat="server" Visible="true" Text='<%# Bind("ID") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Department ID" Visible="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDeptId" runat="server" Text='<%# Bind("DeptID") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Dept Name">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDeptName" runat="server" Text='<%# Bind("DeptName") %>' meta:resourcekey="lbldeptResource1"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Address ID" Visible="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblAddressID" runat="server" Text='<%# Bind("AddressID") %>' meta:resourcekey="lbldeptResource1"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Location">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblLocation" runat="server" Text='<%# Bind("Location") %>' meta:resourcekey="lbldeptResource1"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                </asp:GridView>
                                                <asp:GridView ID="GrdSigMapLoc" Height="50px" ShowFooter="false" CssClass="gridView w-90p"
                                                    AutoGenerateColumns="False" Width="916px" ForeColor="#333333" CellPadding="3" 
                                                    AllowPaging="true" PageSize="10" OnPageIndexChanging="GrdSigMapLoc_PageIndexChanging"
                                                    EmptyDataText="No matching records found " runat="server" DataKeyNames="DeptID"
                                                    OnRowDataBound="GrdSigMapLoc_OnRowDataBound" HeaderStyle-BackColor="#A52A2A"
                                                    HeaderStyle-ForeColor="White" OnRowCommand="GrdSigMapLoc_RowCommand">
                                                    <Columns>
                                                        <asp:TemplateField ItemStyle-Width="20px">
                                                            <ItemTemplate>
                                                                <div id="div<%# Eval("RowNo") %>" style="display: none;">
                                                                    <asp:GridView ID="gvSubgrid" ShowFooter="false" CssClass="gridView w-90p" OnRowDataBound="DepSeqBound"
                                                                        EmptyDataText="No matching records found " runat="server" AutoGenerateColumns="false"
                                                                        DataKeyNames="DeptID" HeaderStyle-BackColor="#FFA500" HeaderStyle-ForeColor="White"
                                                                        OnRowCommand="gvSubgrid_RowCommand">
                                                                        <Columns>
                                                                            <asp:TemplateField Visible="false" meta:resourcekey="TemplateFieldResource9">
                                                                                <ItemTemplate>
                                                                                    <asp:CheckBox ID="chckDisSubgrid" runat="server" />
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Center" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField Visible="false" HeaderText="Id">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblIDMain" runat="server" Text='<%# Bind("Id") %>' meta:resourcekey="lbldeptResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField Visible="false" HeaderText="Seq">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblSeqNo" runat="server" Text='<%# Bind("SeqNo") %>' meta:resourcekey="lbldeptResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField Visible="false" HeaderText="UserID">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblLoginID" runat="server" Text='<%# Bind("UserID") %>' meta:resourcekey="lbldeptResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="User Name">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblLoginName" runat="server" Text='<%# Bind("UserName") %>' meta:resourcekey="lbldeptResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Center" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="LoginName" Visible="false">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblDefaultsigSubgrid" runat="server" Text='<%# Bind("Defaultsig") %>'
                                                                                        meta:resourcekey="lbldeptResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Center" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="S.no" ItemStyle-Width="100">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Center" />
                                                        </asp:TemplateField>
                                                          <asp:TemplateField Visible="false" HeaderText="AddressID">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblAddressID" runat="server" Text='<%# Bind("AddressID") %>' meta:resourcekey="lbldeptResource1"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Location">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblLoctionname" runat="server" Text='<%# Bind("Location") %>' meta:resourcekey="lbldeptResource1"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                         <asp:TemplateField Visible="false" HeaderText="DeptID">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDepID" runat="server" Text='<%# Bind("DeptID") %>' meta:resourcekey="lbldeptResource1"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Department">
                                                            <ItemTemplate>
                                                                <a href="JavaScript:shrinkandgrow('div<%# Eval("RowNo") %>');">
                                                                    <img alt="+" id="imgdiv<%# Eval("RowNo") %>" src="../Images/plus.png" />
                                                                    <asp:Label ID="lblDepName" runat="server" Text='<%# Bind("DeptName") %>' meta:resourcekey="lbldeptResource1"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        
                                                        <asp:TemplateField Visible="true" HeaderText="Change Seq">
                                                        
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnPobup" OnClientClick="openModalJQ('mymodaldiag2', 'myModalclass2');"
                                                                    runat="server" CssClass="btn" Text="Change Seq" CommandName="ChangeSeq" onmouseover="this.className='btn btnhov'"
                                                                    onmouseout="this.className='btn'" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' />
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Center" />
                                                        </asp:TemplateField>
                                                       
                                                      
                                                        <asp:TemplateField HeaderText="Edit">
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnEditSeqPobup" runat="server" CssClass="btn" Text="Edit" CommandName="Editrow"
                                                                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' />
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Center" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                </asp:GridView>
                                                <asp:HiddenField ID="LogIdCheck" runat="server" Value="0" />
                                                <asp:HiddenField ID="hdMove" runat="server" />
                                                <asp:HiddenField ID="InsUpdflag" runat="server" Value="0" />
                                            <asp:HiddenField ID="HdLoginName" runat="server" Value="0" />
                                        </div>
                                        <div id="mymodaldiag1" class="modalDiag paddingT50">
                                            <!-- modaldiag1 content -->
                                            <div id="myModalclass1" class="w-50p">
                                                <div class="modalDiag-header">
                                                    <span class="bold w-100p"><span class="marginT5">User Name</span>
                                                    <input type="button" class="pull-right" style="font-size:10px" CssClass="btn"
                                                    onclick="closeModdalDialog('mymodaldiag1', 'myModalclass1');" value="X" />
                                                    <%--<span onclick="closeModdalDialog('mymodaldiag1', 'myModalclass1');"
                                                      onmousemove="cursor"  class="pull-right"  style="font-size:20px">X</span></span>--%>
                                                            
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="gvPopupgrid"  Width="650px" CssClass="gridView w-90p"
                                                                    OnRowDataBound="DepSeqBound" EmptyDataText="No matching records found " runat="server"
                                                                    AutoGenerateColumns="false" DataKeyNames="SeqNo" HeaderStyle-BackColor="#FFA500"
                                                                    HeaderStyle-ForeColor="White" OnRowCommand="gvSubgrid_RowCommand">
                                                                    <Columns>
                                                                        <asp:TemplateField Visible="false" HeaderText="DefaultSig">
                                                                            <ItemTemplate>
                                                                                <asp:CheckBox ID="chckDisPopupgrid" runat="server" />
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField Visible="false" HeaderText="ID">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblID" runat="server" Text='<%# Bind("Id") %>' meta:resourcekey="lbldeptResource1"></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField Visible="false" HeaderText="Seq">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblSeqNoPopup" runat="server" Text='<%# Bind("SeqNo") %>' meta:resourcekey="lbldeptResource1"></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField Visible="false" HeaderText="UserID">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblLoginIDPopup" runat="server" Text='<%# Bind("UserID") %>' meta:resourcekey="lbldeptResource1"></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="User Name">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblLoginNamePopup" runat="server" Text='<%# Bind("UserName") %>'
                                                                                    meta:resourcekey="lbldeptResource1"></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Center" />  
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="LoginName" Visible="false">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblDefaultsigPopup" runat="server" Text='<%# Bind("Defaultsig") %>'
                                                                                    meta:resourcekey="lbldeptResource1"></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Select">
                                                                            <ItemTemplate>
                                                                                <asp:ImageButton ID="btnUp" ImageUrl="~/Images/UpArrow.png" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                                                                    CommandName="UP" meta:resourcekey="btnUpResource3" />
                                                                                <asp:ImageButton ID="btnDown" ImageUrl="~/Images/DownArrow.png" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                                    CommandName="DOWN" meta:resourcekey="btnDownResource3" />
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                </asp:GridView>
                                                                <asp:GridView ID="gvCustomers" runat="server" AutoGenerateColumns="false" RowStyle-BackColor="#A1DCF2"
                                                                    HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White">
                                                                    <Columns>
                                                                        <asp:BoundField ItemStyle-Width="150px" DataField="CustomerID" HeaderText="CustomerID" />
                                                                        <asp:BoundField ItemStyle-Width="150px" DataField="ContactName" HeaderText="Contact Name" />
                                                                        <asp:BoundField ItemStyle-Width="150px" DataField="City" HeaderText="City" />
                                                                    </Columns>
                                                                </asp:GridView>
                                                                <div style="height: 10px;">
                                                                </div>
                                                                <div class="outer">
                                                                    <asp:Button ID="btnSaveDeptSequence" runat="server" Text="Save" CssClass="btn"
                                                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="saveSequance_Click"
                                                                      style="width:60px;"  meta:resourcekey="btnsaveDeptResource3" />  
                                                                        <input type="button" value="Cancel" style="width:60px;" Class="btn" onclick="closeModdalDialog('mymodaldiag1', 'myModalclass1');">
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </ajc:TabPanel>
                                <ajc:TabPanel ID="TabDeptSharing"  runat="server" HeaderText="Department Sharing"
                                   >
                                    <HeaderTemplate>
                                        Department Sharing
                                    </HeaderTemplate>
                                    <ContentTemplate>
                                        <div>
                                            <table class="w-100p" style="overflow: scroll; max-height: 100px;">
                                                <tr>
                                                    <td class="style1">
                                                        <asp:Label ID="lblDeptshare" runat="server" Text="Select Dept" ></asp:Label>
                                                        <asp:DropDownList ID="ddlDeptshare" CssClass="ddl" runat="server" AutoPostBack="True"
                                                            OnSelectedIndexChanged="ddlDeptshare_SelectedIndexChanged" >
                                                        </asp:DropDownList>
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td />
                                                </tr>
                                                <tr>
                                                    <td class="style1">
                                                        <asp:Label ID="Label14" runat="server" Text="Select Shared department " ></asp:Label>
                                                        <asp:CheckBox ID="ChckDeptShar" runat="server" onclick="checkAllItemDept(this);" Text="Select all"
                                                            />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td />
                                                </tr>
                                                <tr>
                                                    <td class="style1">
                                                        <asp:CheckBoxList ID="ChckDeptShared" runat="server" Font-Size="Smaller" RepeatColumns="5"
                                                           >
                                                        </asp:CheckBoxList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="style1">
                                                        <asp:Button ID="btnSharedDept" runat="server" OnClick="btnSaveSharDept_Click" Text="Save" CssClass="btn"
                                                            Width="115px"   />
                                                            
                                                            <%--OnClientClick="return validateSequenceArrangement();"--%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 20px">
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </ContentTemplate>
                                </ajc:TabPanel>
                            </ajc:TabContainer>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script src="../Scripts/bootstrap.min.js" type="text/javascript"></script>

    <script src="../QMS/Script/bootstrap-multiselect.js" type="text/javascript"></script>

    <script type="text/javascript">
        var arrModalDiag = ["mymodaldiag1", "mymodaldiag2"];
        var arrModalDiagClass = ["myModalclass1", "myModalclass2"];
        function openModalJQ(modalId, modalClassID) {
            var modaldiag = modalId;
            var modalClassdiag = modalClassID;
            $('#' + modalClassdiag).removeClass("modalDiag-content1");
            $('#' + modalClassdiag).addClass("modalDiag-content");
            $('#' + modaldiag).removeClass("hide").addClass("modalDiag show");
            Resetdrplogin();
            var DeptID = document.getElementById('TabContainer1_tabDepsigMap_ddlDeptSigMap').value;
            var LocID = document.getElementById('TabContainer1_tabDepsigMap_ddlLocationSig').value;
            BindLogin(DeptID, LocID);
        }
        function closeModdalDialog(modalId, modalClassID) {
            var modaldiag = modalId;
            var modalClassdiag = modalClassID;
            $('#' + modalClassdiag).addClass("modalDiag-content1");
            setTimeout(function() {
                $('#' + modaldiag).removeClass("show").addClass("hide");
            }, 700);
        }
        document.addEventListener('click', function(e) {
            for (i = 0; i < arrModalDiag.length; i++) {
                if (e.target.id == arrModalDiag[i]) {
                    modalPopupHide(i);
                }
            }
        });
        $('body').keydown(function(evt) {
            if (evt.keyCode === 27) {
                for (i = 0; i < arrModalDiagClass.length; i++) {
                    if ($('#' + arrModalDiagClass[i]).hasClass("modalDiag-content")) {
                        modalPopupHide(i);
                    }
                }
            }
        });
        function modalPopupHide(i) {
            var temp = i;
            $('#' + arrModalDiagClass[i]).removeClass("modalDiag-content").addClass("modalDiag-content1");
            setTimeout(function() {
                $('#' + arrModalDiag[i]).removeClass("show").addClass("hide");
            }, 700);
            sleep(1000);
        }

        function shrinkandgrow(input) {
            var displayIcon = "img" + input;
            if ($("#" + displayIcon).attr("src") == "../Images/plus.png") {
                $("#" + displayIcon).closest("tr")
			    .after("<tr><td></td><td colspan = '100%'>" + $("#" + input)
			    .html() + "</td></tr>");
                $("#" + displayIcon).attr("src", "../Images/minus.png");
            } else {
                $("#" + displayIcon).closest("tr").next().remove();
                $("#" + displayIcon).attr("src", "../Images/plus.png");
            }
        }

        function divexpandcollapse(divname) {
            var div = document.getElementById(divname);
            var img = document.getElementById('img' + divname);
            if (div.style.display == "none") {
                div.style.display = "inline";
                img.src = "minus.gif";
            } else {
                div.style.display = "none";
                img.src = "plus.gif";
            }
        }

        var resdata1 = [];
        $(document).ready(function() {
        Resetdrplogin();
    });
   
        function Resetdrplogin() {
            $('#TabContainer1_tabDepsigMap_ddlLoginName').multiselect('dataprovider', resdata1);
        }

        function BindLogin(DeptID, LocID) {

            var OrgID = '<%= Session["OrgID"] %>';
            var dd;
            var resdata = [];
            var obj = {};
            var flag = 0;
            obj.status = 'principle'
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/pGetLoginNames",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ Deptid: DeptID, Locid: LocID, Orgid: OrgID }),
                async: false,
                success: function(data) {
                    dd = data.d;
                    if (dd.length > 0) {
                    

//                        $('#TabContainer1_tabDepsigMap_ddlLoginName').append($('<option></option>').val(0).html('-- Select --'));
                        $.each(dd, function(index, Item) {
                            var obj = new Object();
                            var label = Item.Name;
                            var value = Item.UserID;
                            obj = { label: label, value: value };
                            resdata.push(obj);
                        });
                        $('#TabContainer1_tabDepsigMap_ddlLoginName').multiselect('dataprovider', resdata);
                        $('#TabContainer1_tabDepsigMap_ddlLoginName').multiselect('rebuild');
                    }
                    else {
                        for (var i = 0; i < $("#TabContainer1_tabDepsigMap_ddlLoginName option").length; i++) {
                            if ($("#TabContainer1_tabDepsigMap_ddlLoginName option")[i].value == 0) {
                                flag = 1;
                            }
                        }
                        if (flag == 0) {
                            $('#TabContainer1_tabDepsigMap_ddlLoginName').append($('<option></option>').val(0).html('-- Select --'));
                            Resetdrplogin();
                        }
                    }
                },
                error: function(result) {
                    alert("Error");
                }
            });
        }
        function SelectLogin(OrgID, DeptID, AddressID) {

            var dd;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetDeptSigSeqMapLog",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ Orgid: OrgID, Deptid: DeptID, Addressid: AddressID }),
                async: false,
                success: function(data) {
                    dd = data.d;
                    if (dd.length > 0) {
//                        $('#TabContainer1_tabDepsigMap_ddlLoginName').append($('<option></option>').val(0).html('-- Select --'));
                        $.each(dd, function(index, Item) {
                        var label = Item.UserName;
                        var value = Item.UserID;
                            for (var i = 0; i < $("#TabContainer1_tabDepsigMap_ddlLoginName option").length; i++) {
                                if ($("#TabContainer1_tabDepsigMap_ddlLoginName option")[i].value == value) {
                                    $("#TabContainer1_tabDepsigMap_ddlLoginName option")[i].selected = true;
                                    var lsts = $("#TabContainer1_tabDepsigMap_ddlLoginName option").closest('td').find('li');
                                    $(lsts[i + 1]).addClass('active');
                                    $(lsts[i + 1]).find('input[type="checkbox"]').prop('checked', true);
                                    break;
                                }
                            }
                        });
                        $('#TabContainer1_tabDepsigMap_ddlLoginName').multiselect();
                        $('#TabContainer1_tabDepsigMap_ddlLoginName').multiselect('rebuild');
                    }
                },
                error: function(result) {
                    alert("Error");
                }
            });

        }
        function ValidationSig() {

            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_DepartmentSequenceNumber_aspx_03") != null ? SListForAppMsg.Get("Admin_DepartmentSequenceNumber_aspx_03") : "Enter the Department Name ";
            var userMsg1 = SListForAppMsg.Get("Admin_DepartmentSequenceNumber_aspx_10") != null ? SListForAppMsg.Get("Admin_DepartmentSequenceNumber_aspx_10") : "Select the Location  ";
            var userMsg2 = SListForAppMsg.Get("Admin_DepartmentSequenceNumber_aspx_11") != null ? SListForAppMsg.Get("Admin_DepartmentSequenceNumber_aspx_11") : "Select the User Name ";
            var dept = document.getElementById('TabContainer1_tabDepsigMap_ddlDeptSigMap').value;
            var Loc = document.getElementById('TabContainer1_tabDepsigMap_ddlLocationSig').value;
            var val = $("#TabContainer1_tabDepsigMap_ddlLoginName").val();
            if (dept == 0) {
                ValidationWindow(userMsg, AlrtWinHdr);
                document.getElementById('TabContainer1_tabDepsigMap_ddlDeptSigMap').focus();
                return false;
            } if (Loc == 0) {
                ValidationWindow(userMsg1, AlrtWinHdr);
                document.getElementById('TabContainer1_tabDepsigMap_ddlLocationSig').focus();
                return false;
            }
            if (val == null || val == '' || val == 0 || val == undefined) {
                ValidationWindow(userMsg2, AlrtWinHdr);
                document.getElementById('TabContainer1_tabDepsigMap_ddlLoginName').focus();
                return false;
            } else
                document.getElementById("TabContainer1_tabDepsigMap_HdLoginName").value = $("#TabContainer1_tabDepsigMap_ddlLoginName").val();
            return true;
        }
        function GetSelectedCountries() {
            var selectedCountries = "";
            $("#ddlCountry option:selected").each(function() {
                selectedCountries += "Country: " + $(this).text() + ", CountryId: " + $(this).val() + "\n";
            });
            if (selectedCountries) {
                alert(selectedCountries);
            }
            else {
                alert("Please select at least one country");
            };
        }

        function ShowMultiSelectSpecies() {

            window.asd = $('.SlectBox').SumoSelect({ csvDispCount: 3, selectAll: true, captionFormatAllSelected: "Yeah, OK, so everything." });

            var SelectedSpecies;

            $('.SlectBox').on('sumo:opened', function(o) {

                SelectedSpecies = $('.SlectBox').val();


                console.log("dropdown opened", o)
            });

        }
        function checkedfunc() {

            var btnvalue = document.getElementById('TabContainer1_TabPanel2_btnSaveLoc').value;
            if (btnvalue == "Save")
                document.getElementById('TabContainer1_TabPanel3_ChcUpfl').value = 0
            if (btnvalue == "Update")
                document.getElementById('TabContainer1_TabPanel3_ChcUpfl').value = 1
            var flag = document.getElementById('TabContainer1_TabPanel3_ChcUpfl').value;
        }

        function fncsave() {

            if (validationDept() == true) {
                var chcupfl = document.getElementById('TabContainer1_TabPanel3_ChcUpfl').value;
                if (chcupfl == "1") {
                    var answer = confirm("if you Change then Sequence order will be change?")
                    if (answer) {
                        return true;
                    }
                    else {
                        return false;
                    }
                }
                else {
                    return true;
                }
            }
            else
                return false;
        }


        function ValidationHeader() {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_DepartmentSequenceNumber_aspx_07") != null ? SListForAppMsg.Get("Admin_DepartmentSequenceNumber_aspx_07") : "Please Enter the Header Name ";
            if (document.getElementById('TabContainer1_TabManageHeader_txtHeaderName').value == '') {
                if (userMsg != null) {
                    ValidationWindow(userMsg, AlrtWinHdr);
                }
                document.getElementById('TabContainer1_TabManageHeader_txtHeaderName').focus();
                return false;
            }
            return true;
        }

        function validationDept() {
            var checked = '0';
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_DepartmentSequenceNumber_aspx_03") != null ? SListForAppMsg.Get("Admin_DepartmentSequenceNumber_aspx_03") : "Enter the Department Name";
            var userMsg1 = SListForAppMsg.Get("Admin_DepartmentSequenceNumber_aspx_04") != null ? SListForAppMsg.Get("Admin_DepartmentSequenceNumber_aspx_04") : "Enter the Department Code";
            var userMsg2 = SListForAppMsg.Get("Admin_DepartmentSequenceNumber_aspx_05") != null ? SListForAppMsg.Get("Admin_DepartmentSequenceNumber_aspx_05") : "Select the anyone of location";

            if (document.getElementById('TabContainer1_TabPanel2_txtdeptName').value == '') {
                if (userMsg != null) {
                    ValidationWindow(userMsg, AlrtWinHdr);
                }
                document.getElementById('TabContainer1_TabPanel2_txtdeptName').focus();
                return false;
            }
            if (document.getElementById('TabContainer1_TabPanel2_txtcodeDep').value == '') {
                if (userMsg != null) {
                    ValidationWindow(userMsg1, AlrtWinHdr);
                }
                document.getElementById('TabContainer1_TabPanel2_txtcodeDep').focus();
                return false;
            }
            return true;
        }
        function checkAllItem(obj1) {
            var checkboxCollection = document.getElementById('<%=checkLst.ClientID %>').getElementsByTagName('input');
            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    checkboxCollection[i].checked = obj1.checked;
                }
            }
        }
        function checkAllItemDept(obj1) {
            var checkboxCollection = document.getElementById('<%=ChckDeptShared.ClientID %>').getElementsByTagName('input');
            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    checkboxCollection[i].checked = obj1.checked;
                }
            }
        }
        function ShowHideDept(obj) {
            if (obj == "Add") {
                document.getElementById('<%= ddlDeptName.ClientID %>').value = "0";
                document.getElementById('<%= trAddNewDept.ClientID %>').style.display = 'table-cell';
                document.getElementById('<%= trSelectDept.ClientID %>').style.display = 'none';
                document.getElementById('btnCancel').value = "Cancel";
                return false;
            }
            else {
                document.getElementById('<%= ddlDeptName.ClientID %>').value = "0";
                document.getElementById('<%= trSelectDept.ClientID %>').style.display = 'block';
                document.getElementById('<%= trAddNewDept.ClientID %>').style.display = 'none';
                document.getElementById('btnCancel').value = "Cancel";
                return false;
            }
        }
        function validateSequenceArrangement() {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_DepartmentSequenceNumber_aspx_08") != null ? SListForAppMsg.Get("Admin_DepartmentSequenceNumber_aspx_08") : "Select the Role ";
            var userMsg1 = SListForAppMsg.Get("Admin_DepartmentSequenceNumber_aspx_09") != null ? SListForAppMsg.Get("Admin_DepartmentSequenceNumber_aspx_09") : "Select any one of Department  ";
            if (document.getElementById('TabContainer1_TabPanel1_ddlRole').value == "0") {
                if (userMsg != null) {
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }
            }
            var check = '1';
            var checkboxlist = document.getElementById('TabContainer1_TabPanel1_checkLst');
            var checkOptions = checkboxlist.getElementsByTagName('input');
            var listSelected = checkboxlist.getElementsByTagName('label');
            var last_val = '';
            for (i = 0; i < checkOptions.length; i++) {
                if (checkOptions[i].checked) {
                    check = '0';
                }
            }
            if (check == '1') {
                if (userMsg1 != null) {
                    ValidationWindow(userMsg1, AlrtWinHdr);
                    return false;
                }
            }
            return true;
        }

        function ChkAllLocations(obj) {

            if ($("#" + obj.id).prop("checked")) {
                $("#TabContainer1_TabPanel2_chkLocations").find("input[type='checkbox']").prop("checked", true);
            } else {
                $("#TabContainer1_TabPanel2_chkLocations").find("input[type='checkbox']").prop("checked", false);
            }
        }
        
        function SelectInvSeqRowCommon(rid) {
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(rid).checked = true;
        }
        
    </script>

</body>
</html>
