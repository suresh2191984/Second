<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PendingRecommendation.aspx.cs"
    Inherits="Patient_PendingRecommendation" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="~/CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/TaskEscalation.ascx" TagName="TaskEscalation"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

</head>
<body >
    <form id="form1" runat="server"><asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index:2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>"  class="logostyle" />
                </div>
            </div>
                <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc7:DocHeader ID="docHeader" runat="server" />
        </div>
                    <div style="float: right;"  class="Rightheader"></div>
        </div>
       <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
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
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                    
                        <table width="100%">
                            <tr align="center">
                                <td align="center">
                                    <asp:GridView ID="gvPatient" runat="server" AllowPaging="True" PageSize="100" AutoGenerateColumns="False"
                                        OnRowDataBound="gvPatient_RowDataBound" Width="100%" OnRowCommand="gvPatient_RowCommand"
                                        ForeColor="Black" Font-Size="Small" meta:resourcekey="gvPatientResource1">
                                        <HeaderStyle CssClass="dataheader1" />
                                        <PagerStyle CssClass="dataheader1" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Visit No" 
                                                meta:resourcekey="TemplateFieldResource1"></asp:TemplateField>
                                            <asp:TemplateField HeaderText="PatientID" 
                                                meta:resourcekey="TemplateFieldResource2">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbl_PatNo" runat="server" Text='<%# bind("PatientNumber") %>' 
                                                        meta:resourcekey="lbl_PatNoResource1"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Name" meta:resourcekey="TemplateFieldResource3">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbl_name" runat="server" Text='<%# bind("name") %>' 
                                                        meta:resourcekey="lbl_nameResource1"></asp:Label>
                                                    <asp:Label ID="lbl_visitid" runat="server" Text='<%# bind("PatientVisitId") %>' 
                                                        Visible="False" meta:resourcekey="lbl_visitidResource1"></asp:Label>
                                                    <asp:Label ID="lbl_pid" runat="server" Text='<%# bind("PatientID") %>' 
                                                        Visible="False" meta:resourcekey="lbl_pidResource1"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Date" meta:resourcekey="TemplateFieldResource4">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldate" runat="server" Text='<%# bind("visitdate") %>' 
                                                        meta:resourcekey="lbldateResource1"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Show" meta:resourcekey="TemplateFieldResource5">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkshow" runat="server" CommandArgument='<%# bind("PatientVisitId") %>'
                                                        ForeColor="Blue" Text="Enter Recommendation" CommandName="enter" 
                                                        meta:resourcekey="lnkshowResource1"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:HiddenField ID="Hdnvalue" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <div style="width: 385px; height: 100px" onload="loadImg()" id="divContent">
                            <div style="background-color: Transparent; text-align: left; padding-left: 50px;
                                padding-top: 20px; font-family: Verdana; font-size: small;">
                            </div>
                        </div>
                    </div>
                 </td>
            </tr>
        </table>
        <uc5:Footer ID="ucFooter" runat="server" />
    </div>
    </form>
</body>
</html>
