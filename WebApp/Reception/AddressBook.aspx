<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddressBook.aspx.cs" Inherits="Reception_AddressBook"
    EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Address Book</title>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <%-- <script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <link href="../Images/favicon.ico" rel="shortcut icon" />

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>--%>
    <%--
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />--%>
    <%--    <link href="~/StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />
    <%--    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />--%>
    <style type="text/css">
        .AutoCompletesearchBox1
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
            padding-left: 20px !important;
        }
        .Txtboxsmall1
        {
            font-family: Arial, Helvetica, sans-serif;
            text-align: left;
            height: 15px;
            width: 170px;
            border: 1px solid #999999;
            font-size: 11px;
            margin-left: 0px;
        }
    </style>

    <script type="text/javascript">

        var AlertType;
//        $(document).ready(function() {
//            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
//        });
        function GetType(pName) {
            // debugger;
            if (pName != "") {

                document.getElementById('<%=txtName.ClientID %>').value = pName;

            }
        }
        function SetContextKey() {
            // debugger;
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
            document.getElementById('<%=txtName.ClientID %>').value = '';
            var SearchTypeID = document.getElementById('ddlType').options[document.getElementById('ddlType').selectedIndex].value;
            var SearchTypeName = document.getElementById('ddlType').options[document.getElementById('ddlType').selectedIndex].innerText;

            document.getElementById('<%=hdnSearchType.ClientID %>').value = SearchTypeID;
            if (SearchTypeName == 'Client') {

                if (SearchTypeID != null && ($find('AutoCompleteExtender1') != null || $find('AutoCompleteExtender1') != undefined)) {
                    $find('AutoCompleteExtender1').set_contextKey(SearchTypeID);
                }
                document.getElementById('txtName').className = 'AutoCompletesearchBox1';

            }
            else if (SearchTypeName == 'Refering Physician') {
                if (SearchTypeID != null && ($find('AutoCompleteExtender1') != null || $find('AutoCompleteExtender1') != undefined)) {
                    $find('AutoCompleteExtender1').set_contextKey(SearchTypeID);
                }
                document.getElementById('txtName').className = 'AutoCompletesearchBox1';

            }
            else if (SearchTypeName == 'Collection Centers / OrgLocations') {
                if (SearchTypeID != null && ($find('AutoCompleteExtender1') != null || $find('AutoCompleteExtender1') != undefined)) {
                    $find('AutoCompleteExtender1').set_contextKey(SearchTypeID);
                }
                document.getElementById('txtName').className = 'AutoCompletesearchBox1';

            }
            else if (SearchTypeName == '-Select-') {
                if (SearchTypeID != null && ($find('AutoCompleteExtender1') != null || $find('AutoCompleteExtender1') != undefined)) {
                    $find('AutoCompleteExtender1').set_contextKey('0');
                }
                document.getElementById('txtName').className = 'AutoCompletesearchBox1';

            }
            else {
                if ($find('AutoCompleteExtender1') != null || $find('AutoCompleteExtender1') != undefined)
                    $find('AutoCompleteExtender1').set_contextKey('');
                document.getElementById('txtName').className = 'Txtboxsmall1';


            }

            document.getElementById('<%=lblResult.ClientID %>').innerText = '';
        }

        function SelectedItem(source, eventArgs) {
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
            var searchName = "";
            var details = "";
            var searchId = "";
            var searchtype = "";
            pName = eventArgs.get_text();
            details = eventArgs.get_value();
            if (details != '') {
                searchName = details.split(':')[0];
                searchId = details.split(':')[1];
                searchtype = details.split(':')[2];

                if (searchName != '') {
                    document.getElementById('<%= txtName.ClientID %>').value = searchName;
                    document.getElementById('<%= hdnSearchTypeID.ClientID %>').value = searchId;
                    document.getElementById('<%= hdnSearchTypeName.ClientID %>').value = searchtype;
                }
                else {
                    document.getElementById('<%= txtName.ClientID %>').value = '';
                    document.getElementById('<%= hdnSearchTypeID.ClientID %>').value = '';
                    document.getElementById('<%= hdnSearchTypeName.ClientID %>').value = '';

                }
            }
            else {
                document.getElementById('<%= txtName.ClientID %>').value = '';
                document.getElementById('<%= hdnSearchTypeID.ClientID %>').value = '';

            }


        }
        function isSpclChar(e) {
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
            var key;
            var isCtrl = false;

            if (window.event) // IE8 and earlier
            {
                key = e.keyCode;
            }
            else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
            {
                key = e.which;
            }

            if ((key >= 48 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32) || (key == 46) || (key == 44) || (key == 45)) {
                isCtrl = true;
            }

            return isCtrl;
        }

        function Validation() {
            /* Added By Venkatesh S */
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
            var vSelectType = SListForAppMsg.Get('Reception_AddressBook_aspx_01') == null ? "Please select a Type" : SListForAppMsg.Get('Reception_AddressBook_aspx_01');

            if (document.getElementById('ddlType').value == "0") {
                ValidationWindow(vSelectType, AlertType);
                document.getElementById('ddlType').focus();
                return false;
            }
        }
        function ChangeTxtBoxWidthDynamic() {
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');

            var completionList = $find("AutoCompleteExtender1").get_completionList().childNodes;
            for (var i = 0; i < completionList.length; i++) {
                var temp = completionList[i].innerHTML;
                if ($('#AutoCompleteExtender1_completionListElem').length > 0 && temp.length != '') {
                    if (temp.length > 0 && temp.length < 10) {
                        $('#AutoCompleteExtender1_completionListElem').css('width', '150px');
                        $("#AutoCompleteExtender1_completionListElem li").each(function(n) {
                            $(this).css('width', '200px');
                        });
                    }
                    else if (temp.length > 10 && temp.length < 25) {
                        $('#AutoCompleteExtender1_completionListElem').css('width', '200px');
                        $("#AutoCompleteExtender1_completionListElem li").each(function(n) {
                            $(this).css('width', '200px');
                        });
                    }
                    else if (temp.length > 25 && temp.length < 30) {
                        $('#AutoCompleteExtender1_completionListElem').css('width', '250px');
                        $("#AutoCompleteExtender1_completionListElem li").each(function(n) {
                            $(this).css('width', '250px');
                        });
                    }
                    else if (temp.length > 30 && temp.length < 35) {
                        $('#AutoCompleteExtender1_completionListElem').css('width', '300px');
                        $("#AutoCompleteExtender1_completionListElem li").each(function(n) {
                            $(this).css('width', '300px');
                        });
                    }
                    else if (temp.length > 35 && temp.length < 40) {
                        $('#AutoCompleteExtender1_completionListElem').css('width', '320px');
                        $("#AutoCompleteExtender1_completionListElem li").each(function(n) {
                            $(this).css('width', '320px');
                        });
                    }
                    else if (temp.length > 40 && temp.length < 45) {
                        $('#AutoCompleteExtender1_completionListElem').css('width', '340px');
                        $("#AutoCompleteExtender1_completionListElem li").each(function(n) {
                            $(this).css('width', '340px');
                        });
                    }
                    else if (temp.length > 45 && temp.length < 50) {
                        $('#AutoCompleteExtender1_completionListElem').css('width', '370px');
                        $("#AutoCompleteExtender1_completionListElem li").each(function(n) {
                            $(this).css('width', '370px');
                        });
                    }
                    else if (temp.length > 50 && temp.length < 55) {
                        $('#AutoCompleteExtender1_completionListElem').css('width', '400px');
                        $("#AutoCompleteExtender1_completionListElem li").each(function(n) {
                            $(this).css('width', '400px');
                        });
                    }
                    else if (temp.length > 55 && temp.length < 60) {
                        $('#AutoCompleteExtender1_completionListElem').css('width', '450px');
                        $("#AutoCompleteExtender1_completionListElem li").each(function(n) {
                            $(this).css('width', '450px');
                        });
                    }
                    else if (temp.length > 60 && temp.length < 65) {
                        $('#AutoCompleteExtender1_completionListElem').css('width', '500px');
                        $("#AutoCompleteExtender1_completionListElem li").each(function(n) {
                            $(this).css('width', '500px');
                        });
                    }
                }
            }
        }

        function SetContext() {
            //   debugger;
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
            var SearchTypeID = document.getElementById('<%=hdnSearchType.ClientID %>').value;

            if (SearchTypeID != null && ($find('AutoCompleteExtender1') != null || $find('AutoCompleteExtender1') != undefined)) {
                $find('AutoCompleteExtender1').set_contextKey(SearchTypeID);
            }
            document.getElementById('txtName').className = 'AutoCompletesearchBox1';

        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <table id="tbltable" class="a-center w-100p">
                    <tr class="a-center">
                        <td class="a-left">
                            <div class="dataheaderWider">
                                <table id="Table1" class="w-100p searchPanel">
                                    <tr>
                                        <td class="w-55p a-left">
                                            <table id="tbl" class="w-100p">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs_PatientNumber" Text="Type" runat="server" meta:resourcekey="Rs_PatientNumberResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlType" runat="server" CssClass="ddlsmall" onChange="SetContextKey()"
                                                           >
                                                    <%--        <asp:ListItem Text="-Select-" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                            <asp:ListItem Text="Client" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                            <asp:ListItem Text="Refering Physician" Value="2" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                            <asp:ListItem Text="Collection Centers / OrgLocations" Value="3" meta:resourcekey="ListItemResource4"></asp:ListItem>--%>
                                                        </asp:DropDownList>
                                                        <%--&nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblName" Text="Name" runat="server" meta:resourcekey="Rs_PatientNumberResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtName" runat="server" CssClass="small"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" 
                                                            onkeydown="javascript:SetContext();" OnChange="javascript:GetType(document.getElementById('txtName').value);"
                                                            MaxLength="255" meta:resourcekey="txtNameResource1"></asp:TextBox>
                                                        <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtName"
                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                            OnClientItemSelected="SelectedItem" CompletionInterval="1" FirstRowSelected="True"
                                                            ServiceMethod="GetClientAndRefPhyAndLocation" ServicePath="~/WebService.asmx"
                                                            MinimumPrefixLength="2" OnClientPopulated="ChangeTxtBoxWidthDynamic" DelimiterCharacters=""
                                                            Enabled="True">
                                                        </cc1:AutoCompleteExtender>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td colspan="4" class="paddingB5 w-20p a-left">
                                            <asp:Button ID="btnSearch" CssClass="btn" Text="Search" OnClick="Search_Click" runat="server"
                                                meta:resourcekey="btnSearchResource1" />
                                        </td>
                                        <td class="w-25p">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="contentArea">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <div id="prnReport">
                                            <div id="tblGrd" runat="server">
                                                <asp:GridView ID="grdAddressBook" runat="server" CssClass="gridView w-100p m-auto" AutoGenerateColumns="False" DataKeyNames="AddressId"
                                                    meta:resourceKey="grdResultResource1">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Name" meta:resourcekey="TemplateFieldResource1" HeaderStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblName" runat="server" Text='<%# Bind("Location") %>' meta:resourcekey="lblNameResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle CssClass="w-25p"/>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Address" meta:resourcekey="TemplateFieldResource2" HeaderStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblAddress" runat="server" Text='<%# Bind("Add1") %>' meta:resourcekey="lblAddressResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle CssClass="w-40p"/>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Contact Number" ItemStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource3">
                                                            <ItemTemplate>
                                                                <asp:Literal ID="litMobile" runat="server" Text='<%#Bind("MobileNumber")%>'></asp:Literal>
                                                            </ItemTemplate>
                                                            <ItemStyle CssClass="w-15p"/>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Email" meta:resourcekey="TemplateFieldResource4" ItemStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblEmail" runat="server" Text='<%# Bind("Comments") %>' meta:resourcekey="lblEmailResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle CssClass="w-20p"/>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Type" meta:resourcekey="TemplateFieldResource5" HeaderStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblType" runat="server" Text='<%# Bind("ReferType") %>' meta:resourcekey="lblTypeResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle CssClass="w-20p" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <HeaderStyle CssClass="dataheader1" />
                                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                                                        PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                                                    <PagerStyle HorizontalAlign="Center" />
                                                </asp:GridView>
                                                <br />
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center h-15">
                            <asp:Label ID="lblResult" runat="server" meta:resourcekey="lblResultResource1"></asp:Label>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnSearchTypeID" runat="server" />
    <asp:HiddenField ID="hdnSearchTypeName" runat="server" />
    <asp:HiddenField ID="hdnSearchType" runat="server" Value="0" />
   
    </form>
</body>
</html>
