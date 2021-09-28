<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageCustomPrice.aspx.cs"
    Inherits="Admin_ManageCustomPrice" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc8" %>
    <%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Manage Custom Price</title>
    <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
      <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function convertNumber(id) {
            document.getElementById(id).value = parseFloat(document.getElementById(id).value).toFixed(2);
        }
        function validateSearch() {
            if (document.getElementById("ddlReferingPhysician").value == "0") {
                alert('Select referring physician');
                return false;
            }
            if (document.getElementById("ddlReferingHospital").value == "0") {
                alert('Select referring hospital');
                return false;
            }
        }

        function collectPriceList() {
            document.getElementById("hdnInvPriceList").value = "";
            var list = document.getElementById("hdnInvList").value.split('~');
            if (document.getElementById("hdnInvList").value != "") {
                for (var count = 0; count < list.length - 1; count++) {
                    var x = list[count];
                    document.getElementById("hdnInvPriceList").value += x + "~" + document.getElementById("txtDT" + x).value + "^";
                }
            }


        }
        function expandDropDownList(elementRef) {
            elementRef.style.width = '380px';
        }

        function collapseDropDownList(elementRef) {
            elementRef.style.width = elementRef.normalWidth;
        }
    </script>

</head>
<body  oncontextmenu="return false;" defaultbutton="btnFinish">
    <form id="prFrm" runat="server">
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
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td height="32">
                                            <table border="0" id="mytable1" cellpadding="4" cellspacing="0" width="100%">
                                                <tr>
                                                    <td colspan="5" id="us">
                                                        Look up for Custom Pricing Details.
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div>
                                                <input type="hidden" id="hdnInvList" runat="server" />
                                                <input type="hidden" id="hdnInvList1" runat="server" />
                                                <input type="hidden" id="hdnInvPriceList" runat="server" />
                                                <asp:Panel runat="server" CssClass="dataheader2" ID="pnlDate" Width="99%" Visible="true">
                                                    <table cellpadding="4" cellspacing="0" border="0" width="100%">
                                                        <%--<tr>
                                        <td style="width:20%;">
                                        Enter Investigation Name
                                        </td>
                                       <td>
                                        <asp:TextBox ID="txtInvestigationName" ToolTip="Investigation Name" Width="300px" runat="server"></asp:TextBox>
                                       </td>
                                        </tr>--%>
                                                        <tr>
                                                            <td style="width: 20%;">
                                                                Select Refering Physician
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlReferingPhysician" runat="server" OnSelectedIndexChanged="ddlReferingPhysician_SelectedIndexChanged"
                                                                 CssClass ="ddlmedium" AutoPostBack="true">
                                                                </asp:DropDownList>
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 20%;">
                                                                Select Refering Hospital
                                                            </td>
                                                            <td>
                                                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:DropDownList onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);" CssClass ="ddlmedium"
                                                                            ID="ddlReferingHospital" normalWidth="200px" runat="server" Width="200px">
                                                                        </asp:DropDownList>
                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                    </ContentTemplate>
                                                                    <Triggers>
                                                                        <asp:AsyncPostBackTrigger ControlID="ddlReferingPhysician" EventName="SelectedIndexChanged" />
                                                                    </Triggers>
                                                                </asp:UpdatePanel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 20%;">
                                                                Enter Investigation Name
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtInvestigationName" runat="server"  CssClass ="Txtboxlarge" ></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2" align="center">
                                                                <asp:Button ID="btnSearch" ToolTip="Click here to Search" Style="cursor: pointer;"
                                                                    runat="server" Text="Search" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                                    OnClick="btnSearch_Click" OnClientClick="javascript:return validateSearch();" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <asp:Label runat="server" ID="lblMessage" Font-Bold="true" ForeColor="#333"></asp:Label>
                                <%-- <asp:Table ID="masterTab" CssClass="dataheaderInvCtrl" runat="server" CellPadding="2"
                            CellSpacing="0" BorderWidth="1">
                        </asp:Table>--%>
                                <asp:HiddenField ID="hdnPageIndx" Value="0" runat="server" />
                                <asp:HiddenField ID="hdnPageIndx1" Value="0" runat="server" />
                                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                    <ProgressTemplate>
                                        <asp:Image ID="Image1" ImageUrl="~/Images/ajax-loader.gif" runat="server" />
                                        <%=Resources.ReportsLims_AppMsg.ReportsLims_BillWiseDeptCollectionReportLims_aspx_05%>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <asp:GridView ID="gvResult" runat="server" AutoGenerateColumns="False" GridLines="Both"
                                    OnRowDataBound="gvResult_RowDataBound" OnRowCommand="gvResult_RowCommand" CssClass="mytable1"
                                    DataKeyNames="InvestigationID" Width="80%" AllowPaging="True" PageSize="15" OnPageIndexChanging="gvResult_PageIndexChanging">
                                    <Columns>
                                        <asp:BoundField DataField="InvestigationName" HeaderText="Investigation" />
                                        <asp:TemplateField HeaderText="Custom Price">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtCustomPrice" Width="75px"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                    runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnInvestigationID" Value='<%# Eval("InvestigationID") %>' runat="server" />
                                                <asp:LinkButton ID="btnSave" CommandName="pEdit" CommandArgument='<%#Eval("InvestigationID") %>'
                                                    runat="server" Text="Save" ForeColor="Blue" Font-Underline="true" Font-Bold="true" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="dataheader1" />
                                </asp:GridView>
                                <br />
                                <br />
                                <table id="saveTab" visible="false" runat="server" cellpadding="4" cellspacing="0"
                                    border="0" width="100%">
                                    <tr>
                                        <td align="center">
                                            <asp:Button ID="btnSave" ToolTip="Click here to Save Custom Price" Style="cursor: pointer;"
                                                runat="server" Text="Save" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                OnClick="btnSave_Click" OnClientClick="javascript:collectPriceList();" />
                                            <asp:Button ID="btnCancel" ToolTip="Click here to Cancel" Style="cursor: pointer;"
                                                runat="server" Text="Cancel" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                OnClick="btnCancel_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
               </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
