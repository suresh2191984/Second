<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RadiologyHome.aspx.cs" Inherits="Masters_RadiologyHome" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/Tasks.ascx" TagName="Task" TagPrefix="uc8" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc9" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Technician Home Page</title>
    <%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>

    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        window.history.forward(1);

        function checkForValues() {

            if (document.getElementById('txtpageNo').value == "") {
                alert('Provide page number');
                return false;
            }

            if (Number(document.getElementById('txtpageNo').value) < Number(1)) {
                alert('Provide correct page number');
                return false;
            }

            if (Number(document.getElementById('txtpageNo').value) > Number(document.getElementById('lblTotal').innerText)) {
                alert('Provide correct page number');
                return false;
            }



        }    
       
    </script>

</head>
<body>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc9:UserHeader ID="UserHeader1" runat="server" />
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
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <top:topheader id="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table cellpadding="2" cellspacing="1" width="100%">
                            <tr>
                                <td align="left" class="defaultfontcolor">
                                    <asp:Label ID="Rs_PendingTaskList" Text="Pending Task List" runat="server" 
                                        meta:resourcekey="Rs_PendingTaskListResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td height="32" class="defaultfontcolor">
                                    <uc8:Task ID="uctlTaskList" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <br />
                        <br />
                        <div id="dCapture" runat="server" visible="false">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="evenforsurg" width="25%" height="23" align="left">
                                        <div id="dCaption" runat="server" visible="false">
                                            <span class="dataheader1txt">&nbsp;<asp:Label  ID="Rs_InvestigatonResultCapture" 
                                                Text="Investigaton Result Capture"  runat="server" 
                                                meta:resourcekey="Rs_InvestigatonResultCaptureResource1"></asp:Label></span>
                                        </div>
                                    </td>
                                    <td width="75%" height="23" align="left">
                                        &nbsp;
                                    </td>
                                    &nbsp;
                                                </tr>
                                                      <tr>
                                             <td colspan="2" class="defaultfontcolor">
                                        <asp:GridView ID="GridView1" runat="server" ForeColor="Black" Width="97%" CellPadding="4"
                                            AutoGenerateColumns="False" OnRowDataBound="GridView1_RowDataBound" 
                                            meta:resourcekey="GridView1Resource1">
                                            <HeaderStyle CssClass="Duecolor" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Radiology Tasks List" ControlStyle-Width="250px" 
                                                    meta:resourcekey="TemplateFieldResource1">
                                                    <ItemTemplate>
                                                        <a href='<%# "~/Investigation/InvestigationCapture.aspx?vid="+DataBinder.Eval(Container.DataItem,"PatientVisitID") + "&gUID=" + DataBinder.Eval(Container.DataItem,"UID") %>'
                                                            runat="server" id="lnklist" style="text-decoration: none; color: Black">
                                                            <%# "Enter Result for " +(string)DataBinder.Eval(Container.DataItem,"PatientName") + "(" +(string)DataBinder.Eval(Container.DataItem,"Age") +")" %>
                                                        </a>
                                                              </ItemTemplate>

                                                  <ControlStyle Width="250px"></ControlStyle>
                                                </asp:TemplateField>
                                                <asp:BoundField ControlStyle-Width="120px" DataField="VisitDate" HeaderText="Investigation Ordered Date"
                                                    DataFormatString="{0:dd MMM yyyy}" meta:resourcekey="BoundFieldResource1" >
<ControlStyle Width="120px"></ControlStyle>
                                                </asp:BoundField>
                                                <asp:BoundField ControlStyle-Width="80px" Visible="false" DataField="Status" 
                                                    HeaderText="Status" meta:resourcekey="BoundFieldResource2" >
<ControlStyle Width="80px"></ControlStyle>
                                                </asp:BoundField>
                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr class="dataheaderInvCtrl">
                                    <td align="center" colspan="2" class="defaultfontcolor">
                                        <asp:Label ID="Label1" runat="server" Text="Page" 
                                            meta:resourcekey="Label1Resource1"></asp:Label>
                                        <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" 
                                            meta:resourcekey="lblCurrentResource1"></asp:Label>
                                        <asp:Label ID="Label2" runat="server" Text="Of" 
                                            meta:resourcekey="Label2Resource1"></asp:Label>
                                        <asp:Label ID="lblTotal" runat="server" Font-Bold="True" 
                                            meta:resourcekey="lblTotalResource1"></asp:Label>
                                        <asp:Button ID="Btn_Previous" runat="server" Text="Previous" OnClick="Btn_Previous_Click"
                                            CssClass="btn" meta:resourcekey="Btn_PreviousResource1" Width="72px" />
                                        <asp:Button ID="Btn_Next" runat="server" Text="Next" OnClick="Btn_Next_Click" 
                                            CssClass="btn" meta:resourcekey="Btn_NextResource1" Width="54px" />
                                        <asp:HiddenField ID="hdnCurrent" runat="server" />
                                        <asp:Label ID="Label3" runat="server" Text="Enter The Page To Go:" 
                                            meta:resourcekey="Label3Resource1"></asp:Label>
                                        <asp:TextBox ID="txtpageNo" runat="server" Width="30px" 
                                              onkeypress="return ValidateOnlyNumeric(this);"  
                                            meta:resourcekey="txtpageNoResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                        <asp:Button ID="btnGo" runat="server" Text="Go" OnClientClick="javascript:return checkForValues();"
                                            OnClick="btnGo_Click" CssClass="btn" meta:resourcekey="btnGoResource1" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
