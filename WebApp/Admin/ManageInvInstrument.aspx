<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageInvInstrument.aspx.cs"
    Inherits="Admin_ManageInvInstrument" meta:resourcekey="PageResource1" %>

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
    <title>Manage Investigation Instrument</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css"/>
    
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function validateInvestigationInstrumentDetails() {
            debugger;
            var objApp01 = SListForAppMsg.Get("Admin_ManageInvInstrument_aspx_01") == null ? "Provide instrument name" : SListForAppMsg.Get("Admin_ManageInvInstrument_aspx_01");
            var objAlert = SListForAppMsg.Get("Admin_ManageInvInstrument_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ManageInvInstrument_aspx_Alert");

            if (document.getElementById('txtInstrumentName').value.trim() == '') {
                var userMsg = SListForApplicationMessages.Get("Admin\\ManageInvInstrument.aspx_1");
                if (userMsg != null) {
                    //  alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                    //alert('Provide instrument name');
                    ValidationWindow(objApp01, objAlert);
                    return false;
                }

                
                document.getElementById('txtInstrumentName').focus();
                return false;
            }
        }

        function checkSearchInstrumentName() {
            var objApp02 = SListForAppMsg.Get("Admin_ManageInvInstrument_aspx_02") == null ? "Provide the search text to find the instrument" : SListForAppMsg.Get("Admin_ManageInvInstrument_aspx_02");
            var objAlert = SListForAppMsg.Get("Admin_ManageInvInstrument_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ManageInvInstrument_aspx_Alert");

            if (document.getElementById('txtSearchInstrumentName').value.trim() == '') {
                var userMsg = SListForApplicationMessages.Get("Admin\\ManageInvInstrument.aspx_2");
                if (userMsg != null) {
                    //  alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                    //  alert('Provide the search text to find the instrument');
                    ValidationWindow(objApp02, objAlert);
                    return false;
                }

                
                document.getElementById('txtSearchInstrumentName').focus();
                return false;
            }
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="prFrm" runat="server" defaultbutton="btnFinish">
    <asp:ScriptManager ID="ScriptManager1" ScriptMode="Release" runat="server">
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
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata1">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                <table border="0" cellpadding="2" cellspacing="1" width="100%">
                                    <tr>
                                        <td height="32">
                                            <table border="0" id="mytable1" cellpadding="4" cellspacing="0" width="100%">
                                                <tr>
                                                    <td colspan="5" id="us">
                                                        <asp:Literal runat="server" ID="ltHead" Text="Search for existing Instrument details or click on Add New 
                                                Instrument." meta:resourcekey="ltHeadResource1"></asp:Literal>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Panel ID="Panel7" CssClass="dataheader2" BorderWidth="1px" runat="server" meta:resourcekey="Panel7Resource1">
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td style="padding: 3px;">
                                                            <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                                <tr>
                                                                    <td align="right" style="width: 25%;">
                                                                        <asp:Label ID="Rs_EnterInstrumentName" Text="Enter Instrument Name" runat="server"
                                                                            meta:resourcekey="Rs_EnterInstrumentNameResource1"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 35%;">
                                                                        <asp:TextBox ID="txtSearchInstrumentName" ToolTip="Instrument Name" CssClass="Txtboxlarge"
                                                                            runat="server" meta:resourcekey="txtSearchInstrumentNameResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td style="width: 10%;">
                                                                        <asp:Button ID="btnSearch" runat="server" OnClientClick="javascript:return checkSearchInstrumentName();"
                                                                            OnClick="btnSearch_Click" Text="Search" ToolTip="Click here to Search the Instrument"
                                                                            Style="cursor: pointer;" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                            onmouseout="this.className='btn'" meta:resourcekey="btnSearchResource1" />
                                                                    </td>
                                                                    <td style="width: 40%;" align="center">
                                                                        <asp:LinkButton ID="addNewInstrument" Text="Add New Instrument" Font-Underline="True"
                                                                            ToolTip="Click here to Add New Instrument" ForeColor="#000333" runat="server"
                                                                            OnClick="addNewInstrument_Click" meta:resourcekey="addNewInstrumentResource1"></asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-bottom: 10px;">
                                            <asp:Label ID="lblStatus" Visible="False" runat="server" ForeColor="#000333" Text="No Matching Records Found!"
                                                meta:resourcekey="lblStatusResource1"></asp:Label>
                                            <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                CellPadding="4" CssClass="mytable1 gridView w-97p" ForeColor="#333333" OnPageIndexChanging="grdResult_PageIndexChanging"
                                                DataKeyNames="InstrumentID,InstrumentName,QCData" OnRowCommand="grdResult_RowCommand"
                                                OnRowDataBound="grdResult_RowDataBound" meta:resourcekey="grdResultResource1">
                                                <PagerTemplate>
                                                    <tr>
                                                        <td align="center" colspan="6">
                                                            <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                                                CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png" Width="18px"
                                                                meta:resourcekey="lnkPrevResource1" />
                                                            <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                                                CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png" Width="18px"
                                                                meta:resourcekey="lnkNextResource1" />
                                                        </td>
                                                    </tr>
                                                </PagerTemplate>
                                                <HeaderStyle CssClass="dataheader1" />
                                                <RowStyle Font-Bold="False" />
                                                <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                <Columns>
                                                    <asp:BoundField DataField="InstrumentID" HeaderText="InstrumentID" Visible="False"
                                                        meta:resourcekey="BoundFieldResource1" />
                                                    <asp:BoundField DataField="InstrumentName" HeaderText="Instrument Name" meta:resourcekey="BoundFieldResource2">
                                                        <HeaderStyle HorizontalAlign="Left" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="QCData" HeaderText="QC Data" meta:resourcekey="BoundFieldResource3">
                                                        <HeaderStyle HorizontalAlign="Left" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type="hidden" id="hdnInstrumentID" runat="server">
                                                <table border="0" cellpadding="2" cellspacing="0" class="dataheader2" width="100%">
                                                    <tr>
                                                        <td style="height: 5px;">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right" style="width: 25%;">
                                                            <asp:Label ID="Rs_InstrumentName" runat="server" meta:resourcekey="Rs_InstrumentNameResource1"
                                                                Text="Instrument Name"></asp:Label>
                                                        </td>
                                                        <td align="left" style="width: 75%;">
                                                            <asp:TextBox ID="txtInstrumentName" runat="server" CssClass="Txtboxlarge" 
                                                                MaxLength="60" meta:resourceKey="txtInstrumentNameResource1" 
                                                                ToolTip="Instrument Name"></asp:TextBox>
                                                            &nbsp;<img align="middle" alt="" src="../Images/starbutton.png" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right" style="width: 25%;">
                                                            <asp:Label ID="Rs_QCData" runat="server" meta:resourceKey="Rs_QCDataResource1" 
                                                                Text="QC Data"></asp:Label>
                                                        </td>
                                                        <td align="left" style="width: 75%;">
                                                            <asp:TextBox ID="txtQCData" runat="server" CssClass="Txtboxlarge" Height="93px" 
                                                                meta:resourceKey="txtQCDataResource1" Rows="8" TextMode="MultiLine" 
                                                                ToolTip="QC Data" Width="253px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 5px;">
                                                        </td>
                                                    </tr>
                                                </table>
                                          
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="4">
                                            <asp:Button ID="btnFinish" OnClientClick="return validateInvestigationInstrumentDetails();"
                                                runat="server" OnClick="btnFinish_Click" ToolTip="Click here to Save Instrument Details"
                                                Style="cursor: pointer;" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" meta:resourcekey="btnFinishResource1" />
                                            <asp:Button ID="btnUpdate" Visible="False" OnClientClick="return validateInvestigationInstrumentDetails();"
                                                runat="server" OnClick="btnUpdate_Click" ToolTip="Click here to Change Instrument Details"
                                                Style="cursor: pointer;" Text="Save Changes" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" meta:resourcekey="btnUpdateResource1" />
                                            <asp:Button ID="btnDelete" Visible="False" ToolTip="Click here to Remove Instrument Details"
                                                Style="cursor: pointer;" OnClientClick="return validateInvestigationInstrumentDetails();"
                                                runat="server" OnClick="btnDelete_Click" Text="Remove" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" meta:resourcekey="btnDeleteResource1" />
                                            <asp:Button ID="btnCancel" runat="server" Text="Home" ToolTip="Click here to Cancel, View the Home Page"
                                                Style="cursor: pointer;" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
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
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
