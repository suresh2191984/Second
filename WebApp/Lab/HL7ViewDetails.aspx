<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HL7ViewDetails.aspx.cs" Inherits="Lab_HL7View" %>

<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="ucadd" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>HL7View Detail</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/InvPattern.js"></script>

    <script src="../Scripts/ResultCapture.js" type="text/javascript"></script>

    <script src="../Scripts/jquery.min.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <style type="text/css">
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
        .listMain
        {
            width: 350px !important;
        }
        .style2
        {
            width: 1%;
        }
        .style3
        {
            width: 10%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="Scriptmanager1" runat="server">
    </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div id="contentdata">
        
         
                      
                            <asp:Panel ID="Panel1" runat="server" DefaultButton="btnBatchSearch">
                                <div id="DivSearchArea" class="filterdataheader2" style="display: block;">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <asp:UpdateProgress ID="upProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                                                <ProgressTemplate>
                                                    <div id="progressBackgroundFilter">
                                                    </div>
                                                    <div align="center" id="processMessage" style="width: 15%">
                                                        <asp:Label ID="Rs_Pleasewait1" Text="Please wait... " runat="server" Font-Bold="true"
                                                            Font-Size="Larger" />
                                                        <br />
                                                        <br />
                                                        <asp:Image ID="imgProgressbar1" runat="server" ImageUrl="~/Images/ProgressBar.gif" />
                                                    </div>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                            <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                                <tr>
                                                    <td width="10%" align="right">
                                                        <asp:Label ID="lblFromdate" runat="server" class="style1" Text="DateTime" Width="120px"></asp:Label>
                                                    </td>
                                                    <td width="12%" align="left">
                                                        <asp:TextBox ID="txtFrom" runat="server" CssClass="Txtboxsmall" MaxLength="10" size="10"></asp:TextBox>
                                                        <a href="javascript:NewCssCal('<% =txtFrom.ClientID %>','ddmmyyyy','arrow',false,12,'Y','Y')">
                                                            <img alt="Pick a date" border="0" height="16" src="../Images/Calendar_scheduleHS.png"
                                                                width="16"></img></a><%--<img align="middle" alt="" src="../Images/starbutton.png" />--%>
                                                    </td>
                                                    <td align="left" width="10%">
                                                    </td>
                                                    <td align="left" style="width: 8%">
                                                        &nbsp;
                                                        <asp:HiddenField ID="hdnTestID" runat="server" Value="" />
                                                        <asp:HiddenField ID="hdnTestType" runat="server" Value="" />
                                                    </td>
                                                    <td style="width: 12%">
                                                        <asp:Label ID="msgcontrolid" runat="server" Text="Message Control ID" Width="120px"></asp:Label>
                                                        &nbsp;
                                                    </td>
                                                    <td class="style3">
                                                        <asp:TextBox ID="txtInvestigationName" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="8%" align="right">
                                                        <asp:Label ID="lblstat0" runat="server" Text="Message Type"></asp:Label>
                                                    </td>
                                                    <td width="8%" align="center">
                                                        <asp:RadioButtonList ID="rdInbound" runat="server" AutoPostBack="true" ForeColor="Black"
                                                            RepeatDirection="Horizontal">
                                                            <asp:ListItem Selected="True" Value="ORU^R01">Inbound</asp:ListItem>
                                                            <asp:ListItem>Outbound</asp:ListItem>
                                                            <asp:ListItem>All</asp:ListItem>
                                                        </asp:RadioButtonList>
                                                        &nbsp;
                                                    </td>
                                                    <td width="8%" align="left">
                                                        &nbsp;
                                                    </td>
                                                    <td colspan="1" width="8%">
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="pIdentifier" runat="server" Text="Patient Identifier"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtpIdentifier" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <table width="100%" id="tblContent">
                                    <tr>
                                        <td align="Left">
                                            <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                ToolTip="Save As Excel" Height="16px" OnClick="imgBtnXL_Click" />
                                            <asp:LinkButton ID="lnkExportXL" Text="Export To XL" runat="server" Font-Bold="True"
                                                Font-Size="12px" ForeColor="Black" Enabled="false" ToolTip="Click on Image for Save As Excel"></asp:LinkButton>&nbsp;&nbsp;&nbsp;
                                        </td>
                                        <td align="right">
                                            <asp:Button ID="btnBatchSearch" Font-Bold="true" runat="server" Text="Search" CssClass="btn"
                                                Width="70" Height="30" OnClick="btnBatchSearch_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                       
                        <div>
                            <asp:GridView ID="grdHLresult" runat="server" ForeColor="Black" Width="100%" CellPadding="1"
                                CellSpacing="0" AutoGenerateColumns="False" Style="margin-top: 0px" EmptyDataText="No Matching Records Found"
                                GridLines="Both">
                                <HeaderStyle Font-Bold="True" CssClass="dataheader1" />
                                <Columns>
                                    <asp:BoundField DataField="SNo" HeaderText="S.No.">
                                        <ItemStyle HorizontalAlign="left" Width="6%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="MessageControlId" HeaderText="Message Control Id">
                                        <ItemStyle Width="7%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="MessageType" HeaderText="Message Type">
                                        <ItemStyle Width="8%" />
                                    </asp:BoundField>
                                   <%-- <asp:BoundField DataField="Content" HeaderText="Content">
                                        <ItemStyle HorizontalAlign="left" Width="18%" />
                                    </asp:BoundField>--%>
                                    <asp:BoundField DataField="Status" HeaderText="Status">
                                        <ItemStyle Width="8%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ErrorList" HeaderText="Error List">
                                        <ItemStyle Width="15%" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="MessageCreatedDate" HeaderText="Message Created Date">
                                        <ItemStyle Width="12%" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="PatientIdentifier" HeaderText="Patient Identifier">
                                        <ItemStyle Width="8%" />
                                    </asp:BoundField>
                                     <asp:BoundField DataField="HL7Message" HeaderText="HL7Message">
                                        <ItemStyle Width="8%" />
                                    </asp:BoundField>
                                </Columns>
                                <EmptyDataRowStyle CssClass="dataheader1"></EmptyDataRowStyle>
                            </asp:GridView>
                        </div>
                
         </div>
      
        <asp:HiddenField ID="hdnSelectedValue" runat="server" />
         <Attune:Attunefooter ID="Attunefooter" runat="server" />

    </form>
</body>
</html>
