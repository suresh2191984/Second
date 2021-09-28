<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientRecommendation.aspx.cs"
    Inherits="Patient_PatientRecommendation" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc8" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat='server'>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>PatientRecommendation</title>
    <%--<link href="~/StyleSheets/Style.css" rel="stylesheet" type="text/css" />
--%>
      <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="/Scripts/bid.js" type="text/javascript"></script>

    <script src="~/Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function expandBox(id) {
            document.getElementById(id).style.height = "400";


        }
        function collapseBox(id) {
            document.getElementById(id).style.height = "70";


        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
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
                <uc3:PatientHeader ID="patientHeader" runat="server" />
            </div>
            <div style="float: right; width: 1%;">
                <div class="Rightheader" />
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
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <table border="0" cellpadding="0" width="100%">
                            <tr>
                                <td align="right">
                                    <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnBack_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Filter Result Name :&nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:TextBox ID="txtName" runat="server"  CssClass ="Txtboxsmall" ></asp:TextBox>
                                    <asp:Button ID="btnGo" Text="Go" runat="server" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn'" OnClick="btnGo_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                        <table border="0" cellpadding="2" cellspacing="1" width="100%">
                            <tr>
                                <td align="center">
                                    <asp:Label ID="lblText" runat="server">
                                    </asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:GridView ID="GridView1" EmptyDataText="No matching records found " runat="server"
                                        AutoGenerateColumns="False" GridLines="Both" CssClass="mytable1" Width="70%"
                                        AllowPaging="True" OnRowDataBound="GridView1_RowDataBound" DataKeyNames="ResultID,ResultName,ResultValues"
                                        PageSize="10" OnPageIndexChanging="GridView1_PageIndexChanging">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="ChkResult" runat="server" Width="40" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblResultId" Text='<%#Eval("ResultID") %>' runat="server" Visible="false ">
                                                    </asp:Label>
                                                    <asp:Label ID="lblResultName" Text='<%#Eval("ResultName") %>' runat="server" Visible="false ">
                                                    </asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderText="ResultName" DataField="ResultName" />
                                            <%-- <asp:TemplateField HeaderText="ResultValues">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtResultValues" Text='<%#Eval("ResultValues") %>' runat="server"
                                                        TextMode="MultiLine" Width="300" Height="40">
                                                    </asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>--%>
                                            <asp:TemplateField HeaderText="ResultValues">
                                                <ItemTemplate>
                                                    <FCKeditorV2:FCKeditor ID="fckInvDetails" Value='<%#Eval("ResultValues") %>' BasePath=""
                                                        runat="server" Width="580px" Height="70">
                                                    </FCKeditorV2:FCKeditor>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%-- <asp:BoundField HeaderText="ResultValues" DataField="ResultValues" />--%>
                                        </Columns>
                                        <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                        <HeaderStyle CssClass="dataheader1" />
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Button ID="btnSave" Text="OK" runat="server" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn'" OnClick="btnSave_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:HiddenField ID="hdnValue" runat="server" Value="" />
                                </td>
                            </tr>
                        </table>
    </div>
    </td> </tr> </table>
    <uc2:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
