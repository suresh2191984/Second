<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClinicalHistoryMaster.aspx.cs"
    Inherits="Admin_ClinicalHistoryMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>

    <script type="text/javascript">

        function winClose() {

            window.close();
        }

        function DisableEnterKey(e) {
            debugger;
            var key;
            if (window.event)
                key = window.event.keyCode; //IE
            else
                key = e.which; //firefox     

            return (key != 13);
        }       
    </script>

    <style>
        .even
        {
            text-align: center;
        }
        .odd
        {
            text-align: center;
        }        
       
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <%-- <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>--%>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table class="w-100p searchPanel">
            <tr>
                <td>
                    <asp:Label ID="lbl_HistoryName" runat="server" Text="History Name :"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txt_HistoryName" runat="server" TabIndex="0" meta:resourcekey="txt_Err_CodeResource1"
                        onkeydown="return DisableEnterKey()"></asp:TextBox>
                    <img src="../Images/starbutton.png" alt="" align="middle" />
                </td>
                <td>
                    <asp:Label ID="lbl_HistoryCode" runat="server" Text="History Code :"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txt_HistoryCode" runat="server" TabIndex="1" meta:resourcekey="txt_Err_CodeResource1"
                        onkeydown="return DisableEnterKey()"></asp:TextBox>
                    <img src="../Images/starbutton.png" alt="" align="middle" />
                </td>
                <td>
                    <asp:Label ID="lbl_ControlType" runat="server" Text="Control Type :"></asp:Label>
                </td>
                <td class="v-middle">
                    <asp:DropDownList ID="ddlControlType" ForeColor="Black" runat="server" meta:resourcekey="ddlDataResource1"
                        CssClass="ddlsmall expandDdl" Font-Bold="true" TabIndex="2">
                        <asp:ListItem Text="Select" value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                        <asp:ListItem Text="TextBox" value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                        <asp:ListItem Text="CheckBox" value="2" meta:resourcekey="ListItemResource2"></asp:ListItem>
                        <asp:ListItem Text="Date" value="3" meta:resourcekey="ListItemResource2"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:Button ID="btn_Save" runat="server" Text="Add" TabIndex="3" OnClientClick="return Save();" />
                    <asp:Button ID="btn_Update" runat="server" Text="Update"  />
                    <asp:Button ID="btn_Reset" runat="server" Text="Reset" TabIndex="4" OnClientClick="Reset(); return false"/>
                </td>
            </tr>
            <tr>
                <div id="div_HistoryMaster_Grid" align="left" style="display: none">
                    <div id="ClinicalHistory" class="w-100p o-auto max-h-400">
                        <%--<table id="tblHistoryMaster" style="display: none">--%>
                        <table id="tblHistoryMaster" width="100%">
                            <thead>
                                <th class="a-center">
                                    S.NO
                                </th>
                                <th class="a-center">
                                    History Name
                                </th>
                                <th class="a-center">
                                    History Code
                                </th>
                                <th class="a-center">
                                    Control Type
                                </th>
                                <th class="a-center">
                                    Action
                                </th>
                            </thead>
                        </table>
                    </div>
                </div>
            </tr>
            <tr>
                <div id="div1" align="left">
                    <table id="Table1" style="display: none">
                        <tr>
                            <td>
                                <%--<asp:Button ID="btnClose" runat="server" Text="Close" TabIndex="5" OnClientClick="Close(); return false" />--%>
                            </td>
                        </tr>
                    </table>
                </div>
            </tr>
        </table>
    </div>

    <script language="javascript" type="text/javascript">
        $(document).ready(function() {
            orgID = '<%=base.OrgID %>';
            //locId = '<%=base.ILocationID %>';

            //alert("hai")
        });
    </script>

    <asp:HiddenField ID="hdn_EditHistoryId" runat="server" Value="" />
    
    
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" Value="0" />
    </form>

    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

    <script src="../Scripts/ClinicalHistory.js" type="text/javascript"></script>

    <script src="../PlatForm/Scripts/linq.min.js" type="text/javascript"></script>

    <%--  <script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>

    <script src="../Scripts/AdobeReaderDetection.js" type="text/javascript" language="javascript" />--%>
</body>
</html>
