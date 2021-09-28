<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ConfigureVisitPurpose.aspx.cs" Inherits="Admin_Configure_VisitPurpose" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" language="javascript">
        function CheckAllUnmap(obj1) {           
            var checkboxCollection = document.getElementById('chklstUnMap').getElementsByTagName('input');
            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    checkboxCollection[i].checked = obj1.checked;
                }
            }
        }

        function CheckAllMap(obj1) {
            var checkboxCollection = document.getElementById('chklstMap').getElementsByTagName('input');
            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    checkboxCollection[i].checked = obj1.checked;
                }
            }
        }

        function chkGrponchange() {            
            var tableBody = document.getElementById('chklstMap').childNodes[0];
            var j = 0;
            for (var i = 0; i < tableBody.childNodes.length; i++) {
                var currentTd = tableBody.childNodes[i].childNodes[0];
                var listControl = currentTd.childNodes[0];
                if (listControl.checked == true) {
                    j = j + 1;
                }
            }
            if (j == 0) {
                alert('Select the items in Mapped Visit Purpose');
                return false;
            }
        }

        function chkUnGrponchange() {            
            var tableBody = document.getElementById('chklstUnMap').childNodes[0];
            var j = 0;
            for (var i = 0; i < tableBody.childNodes.length; i++) {
                var currentTd = tableBody.childNodes[i].childNodes[0];
                var listControl = currentTd.childNodes[0];
                if (listControl.checked == true) {
                    j = j + 1;
                }
            }
            if (j == 0) {
                alert('Select the items in UnMapped Visit Purpose');
                return false;
            }
        }
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
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc2:Header ID="Header" runat="server" />
                <uc1:UserHeader ID="UserHeader1" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc3:LeftMenu ID="LeftMenu1" runat="server" />
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
                    <div class="contentdata1" id="tab">
                        <ul>
                            <li>
                                <uc5:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table align="left" cellpadding="0" cellspacing="0" border="0" width="100%" class="dataheadergroup">
                            <tr>
                                <td>                                    
                                    <asp:UpdatePanel ID="pnl" runat="server">
                                        <ContentTemplate>
                                          <asp:Panel ID="pnlSearch" runat="server" BorderWidth="1px" 
                                                            CssClass="dataheader2">
                                                            <ajc:RoundedCornersExtender runat="server" ID="rce" Corners="All" Radius="6" TargetControlID="pnlSearch"></ajc:RoundedCornersExtender>
                                            <table border="0">                                                
                                                <tr>
                                                    <td class="ancCSbg">
                                                        UnMapped Visit Purpose</td>
                                                    <td>
                                                    </td>
                                                    <td class="ancCSbg">
                                                        Mapped Visit Purpose</td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 51px; width: 50%">
                                                        <div style="overflow: scroll; border: 2px; border-color: #fff; height: 180px;" class="ancCSviolet">
                                                            <asp:CheckBox ID="ChkboxUnMap" Text="ALL" runat="server" CssClass="smallfon" onclick="CheckAllUnmap(this)"
                                                                    Checked="false" />
                                                            <asp:CheckBoxList ID="chklstUnMap" runat="server" Height="51px" Width="320px">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <table>
                                                            <tr>                                                                                                                                                          
                                                                <td>
                                                                    <asp:Button ID="btnSelectAdd" runat="server" class="btn" Height="26px" Text=">" ToolTip="Add To Mapped Visit Purpose" 
                                                                        Width="62px" onclick="btnSelectAdd_Click" OnClientClick="javascript:return chkUnGrponchange();" />
                                                                </td>
                                                                <td>                                                                    
                                                                    <asp:Button ID="btnSelectRemove" runat="server" class="btn" Height="25px" ToolTip="Add To UnMapped Visit Purpose"
                                                                        Text="<" Width="61px" onclick="btnSelectRemove_Click" OnClientClick="javascript:return chkGrponchange();" />                                                                        
                                                                </td>                                                                                                                                                               
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td  style="height: 51px; width: 50%">
                                                        <div style="overflow: scroll; border: 2px; border-color: #fff; height: 180px;" class="ancCSviolet">
                                                            <asp:CheckBox ID="ChkboxMap" Text="ALL" runat="server" CssClass="smallfon" onclick="CheckAllMap(this)"
                                                                    Checked="false" />
                                                            <asp:CheckBoxList ID="chklstMap" runat="server" Height="51px" Width="320px">
                                                            </asp:CheckBoxList>                                                           
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                           </asp:Panel>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
