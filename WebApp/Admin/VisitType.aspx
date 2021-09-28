<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VisitType.aspx.cs" Inherits="Admin_VisitType" meta:resourcekey="PageResource1" %>
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
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style1
        {
            height: 28px;                                             
        }
    </style>    
    <script type="text/javascript" language="javascript">
        function chklist() {
            if (document.getElementById('<%=ddlratetype.ClientID %>').value == 0) {
                alert('Provide RateType');
                document.getElementById('ddlratetype').focus();
                return false;
            }
                        
            var found = false;
            var validated = false;
            var id = document.getElementById("<%=chklstVisitType.ClientID %>").id;
            var elements = document.forms[0].elements;
            for (i = 0; i < elements.length; i++) {
                if (elements[i].type == "checkbox" && elements[i].id.indexOf(id) > -1) {
                    found = true;
                    if (elements[i].checked) {
                        validated = true;
                        break;
                    }
                }
            }
            if (found && validated)
                return true;
            else {
                alert('Please Select atleast one item check box list');
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
                                <td width="50%" height="50%">                                    
                                    <asp:UpdatePanel ID="pnl" runat="server">                                        
                                        <ContentTemplate>                                            
                                          <asp:Panel ID="pnlSearch" runat="server" BorderWidth="1px" Width="60%" Height="30%"
                                                            CssClass="dataheader2" meta:resourcekey="pnlSearchResource1">                                                 
                                            <table border="0" width="100%">                                                
                                                <tr>
                                                    <td class="style1" align="right">
                                                        <asp:Label runat="server" ID="lblratetype" Text="Select RateType" 
                                                            Font-Size="Small" meta:resourcekey="lblratetypeResource1"></asp:Label>
                                                    </td>
                                                    <td class="style1">
                                                        <asp:DropDownList ID="ddlratetype" runat="server"  CssClass ="ddlsmall"
                                                            onselectedindexchanged="ddlratetype_SelectedIndexChanged" 
                                                            AutoPostBack="True" meta:resourcekey="ddlratetypeResource1"></asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr> 
                                                    <td>
                                                    </td>                                                 
                                                    <td align="left"> 
                                                        <asp:Panel ID="pnlvisittype" runat="server" GroupingText="Visit Type" Width="70%" Font-Size="Small">                                                            
                                                            <asp:CheckBoxList runat="server" ID="chklstVisitType" RepeatDirection="Horizontal" 
                                                                                        RepeatColumns="3" Font-Size="Small" 
                                                                                meta:resourcekey="chklstVisitTypeResource1"></asp:CheckBoxList>
                                                        </asp:Panel>
                                                    </td>                                                    
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td align="left">
                                                        <asp:Button runat="server" ID="btnSave" Text="Save" onclick="btnSave_Click" OnClientClick="javascript:return chklist();"
                                                            onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'"
                                                            CssClass="btn" Width="75px" meta:resourcekey="btnSaveResource1" />
                                                                                                       
                                                        <asp:Button runat="server" ID="btnCancel" Text="Cancel"
                                                            onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'"
                                                            CssClass="btn"  Width="75px" onclick="btnCancel_Click" 
                                                            meta:resourcekey="btnCancelResource1" />
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
        <input type="hidden" id="hdnVisitSubType" value="" runat="server" />
        <uc4:footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
