<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IPInvSampleCollection.aspx.cs"
    Inherits="Lab_IPInvSampleCollection" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/InvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <script language="javascript" type="text/javascript">
        function datachanged() {
            var ddlDoctor = document.getElementById('<%= ddlStatus.ClientID %>');

            if (ddlDoctor.value == "4") {
                document.getElementById('<%= divRejectedReason.ClientID %>').style.display = 'block';
                document.getElementById('<%= divreasontxt.ClientID %>').style.display = 'block';
            }
            else {
                document.getElementById('<%= divRejectedReason.ClientID %>').style.display = 'none';
                document.getElementById('<%= divreasontxt.ClientID %>').style.display = 'none';
            }
        }
    </script>

    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:PatientHeader ID="patientHeader" runat="server" />
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
                    <div class="contentdata" id="dMain">
                        <%--<asp:UpdatePanel ID="upSample" runat="server">
                    <ContentTemplate>--%>
                        <table width="100px" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="colorforcontent" style="width: 25%;" height="23" align="left">
                                    <div id="ACX2plus1" style="display: none;">
                                        <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                            onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);" />
                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);">
                                            &nbsp;<asp:Label ID="Rs_ListofSamples" Text="List of Samples" runat="server" meta:resourcekey="Rs_ListofSamplesResource1"></asp:Label></span>
                                    </div>
                                    <div id="ACX2minus1" style="display: block;">
                                        <img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                            style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);" />
                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);">
                                            &nbsp;<asp:Label ID="Rs_ListofSamples1" Text="List of Samples" runat="server" meta:resourcekey="Rs_ListofSamples1Resource1"></asp:Label></span>
                                    </div>
                                </td>
                                <td style="width: 75%" height="23" align="left">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="tablerow" id="ACX2responses1" style="display: block;">
                                <td colspan="2">
                                    <div class="dataheader2">
                                        <table border="0" style="border-color: white">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Rs_Samples" Text="Samples" runat="server" meta:resourcekey="Rs_SamplesResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Rs_Status" Text="Status" runat="server" meta:resourcekey="Rs_StatusResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Rs_Barcode" Text="Barcode" runat="server" meta:resourcekey="Rs_BarcodeResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <div id="divreasontxt" runat="server" style="display: none;">
                                                        <asp:Label ID="Rs_Reason" Text="Reason" runat="server" meta:resourcekey="Rs_ReasonResource1"></asp:Label>
                                                    </div>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr valign="top">
                                                <td>
                                                    <asp:DropDownList ID="ddlSampleName" runat="server" meta:resourcekey="ddlSampleNameResource1" CssClass="ddlsmall">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlStatus" runat="server" onchange="javascript:datachanged();"
                                                        meta:resourcekey="ddlStatusResource1" CssClass="ddlsmall">
                                                        <asp:ListItem Text="SampleReceived" Value="3" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                        <asp:ListItem Text="SampleRejected" Value="4" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtBarCode" Width="75px" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtBarCodeResource1"></asp:TextBox>
                                                    <ajc:FilteredTextBoxExtender ID="ftbetxtBarCode" runat="server" FilterType="Numbers"
                                                        TargetControlID="txtBarCode" Enabled="True">
                                                    </ajc:FilteredTextBoxExtender>
                                                </td>
                                                <td>
                                                    <div id="divRejectedReason" runat="server" style="display: none;">
                                                        <asp:TextBox ID="txtRejectedReason" Width="125px" runat="server" meta:resourcekey="txtRejectedReasonResource1"></asp:TextBox>
                                                    </div>
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnAdd" runat="server" OnClick="btnAdd_Click" Text="Add" CssClass="btn"
                                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" meta:resourcekey="btnAddResource1" />
                                                </td>
                                                <td>
                                                    <asp:Repeater ID="repDepts" runat="server">
                                                        <ItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:CheckBox ID="chkDept" runat="server" Checked="True" meta:resourcekey="chkDeptResource1" />
                                                                        <asp:Label ID="lblDeptName" runat="server" CssClass="defaultfontcolor" Text='<%# DataBinder.Eval(Container.DataItem, "DeptName") %>'
                                                                            meta:resourcekey="lblDeptNameResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblDeptID" runat="server" CssClass="defaultfontcolor" Text='<%# DataBinder.Eval(Container.DataItem, "DeptID") %>'
                                                                            Visible="False" meta:resourcekey="lblDeptIDResource1"></asp:Label>
                                                                        <asp:Label ID="lblRoleID" runat="server" CssClass="defaultfontcolor" Text='<%# DataBinder.Eval(Container.DataItem, "RoleID") %>'
                                                                            Visible="False" meta:resourcekey="lblRoleIDResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div id="divSamples" style="overflow: auto;">
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td class="Duecolor" style="width: 25%; height: 20px;">
                                                    <asp:Label ID="Rs_SampleName" Text="SampleName" runat="server" meta:resourcekey="Rs_SampleNameResource1"></asp:Label>
                                                </td>
                                                <td class="Duecolor" style="width: 20%;">
                                                    <asp:Label ID="Rs_Status1" Text="Status" runat="server" meta:resourcekey="Rs_Status1Resource1"></asp:Label>
                                                </td>
                                                <td class="Duecolor" style="width: 20%;">
                                                    <asp:Label ID="Rs_Barcode1" Text="Barcode" runat="server" meta:resourcekey="Rs_Barcode1Resource1"></asp:Label>
                                                </td>
                                                <td class="Duecolor" style="width: 20%;">
                                                    <asp:Label ID="Rs_Reason1" Text="Reason" runat="server" meta:resourcekey="Rs_Reason1Resource1"></asp:Label>
                                                </td>
                                                <td class="Duecolor" style="width: 15%;">
                                                    <asp:Label ID="Rs_Delete" Text="Delete" runat="server" meta:resourcekey="Rs_DeleteResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:Repeater ID="rptSamples" runat="server" OnItemCommand="rptSamples_ItemCommand">
                                            <ItemTemplate>
                                                <table width="100%" border="1" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td style="width: 25%; height: 20px;">
                                                            <asp:Label ID="lblSampleName" runat="server" CommandName="text" Text='<%# Bind("SampleDesc") %>'
                                                                meta:resourcekey="lblSampleNameResource1"></asp:Label>
                                                            <asp:Label Visible="False" Text='<%# Bind("sampleCode") %>' runat="server" ID="lblSampleCode"
                                                                meta:resourcekey="lblSampleCodeResource1"></asp:Label>
                                                        </td>
                                                        <td style="width: 20%;">
                                                            <asp:Label Text='<%# Bind("InvSampleStatusDesc") %>' runat="server" ID="lblstatus"
                                                                meta:resourcekey="lblstatusResource1"></asp:Label>
                                                            <asp:Label Visible="False" Text='<%# Bind("InvSampleStatusID") %>' runat="server"
                                                                ID="lblstatusID" meta:resourcekey="lblstatusIDResource1"></asp:Label>
                                                        </td>
                                                        <td style="width: 20%;">
                                                            <asp:Label Text='<%# Bind("BarcodeNumber") %>' runat="server" ID="lblBarcode" meta:resourcekey="lblBarcodeResource1"></asp:Label>
                                                        </td>
                                                        <td style="width: 20%;">
                                                            <asp:Label Text='<%# Bind("Reason") %>' runat="server" ID="lblReason" meta:resourcekey="lblReasonResource1"></asp:Label>
                                                        </td>
                                                        <td style="width: 15%;">
                                                            <asp:LinkButton ID="lnkBtnDelete" CssClass="colorsample" runat="server" Text="Delete"
                                                                CommandName="Delete" meta:resourcekey="lnkBtnDeleteResource1"></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <%--</ContentTemplate>
                    </asp:UpdatePanel>--%>
                        <br />
                        <br />
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td align="left" height="23" class="colorforcontent" width="25%">
                                    <div id="ACX2plusInv" style="display: none">
                                        &nbsp;<img align="top" alt="Show" height="15" onclick="showResponses('ACX2plusInv','ACX2minusInv','ACX2responsesInv',1);"
                                            src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                        <span class="dataheader1txt" onclick="showResponses('ACX2plusInv','ACX2minusInv','ACX2responsesInv',1);"
                                            style="cursor: pointer">&nbsp;<asp:Label ID="Rs_Investigation" Text="Investigation"
                                                runat="server" meta:resourcekey="Rs_InvestigationResource1"></asp:Label></span>
                                    </div>
                                    <div id="ACX2minusInv" style="display: block">
                                        &nbsp;<img align="top" alt="hide" height="15" onclick="showResponses('ACX2plusInv','ACX2minusInv','ACX2responsesInv',0);"
                                            src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                        <span class="dataheader1txt" onclick="showResponses('ACX2plusInv','ACX2minusInv','ACX2responsesInv',0);"
                                            style="cursor: pointer">&nbsp;<asp:Label ID="Rs_Investigation1" Text="Investigation"
                                                runat="server" meta:resourcekey="Rs_Investigation1Resource1"></asp:Label></span>
                                    </div>
                                </td>
                                <td align="left" height="23" width="70%">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="ACX2responsesInv" class="tablerow" style="display: block">
                                <td colspan="2">
                                    <div class="dataheader2">
                                        <br />
                                        <label class="defaultfontcolor" style="cursor: pointer" onclick="ShowProfile('DivProfile')">
                                            <asp:Label ID="Rs_ClickheretoOrderInvestigations" Text="Click here to Order Investigations..."
                                                runat="server" meta:resourcekey="Rs_ClickheretoOrderInvestigationsResource1"></asp:Label></label>
                                        <br />
                                        <br />
                                        <asp:UpdatePanel ID="UpdatePanelBTN" runat="server">
                                            <ContentTemplate>
                                                &nbsp;&nbsp;&nbsp;&nbsp;
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                        <br />
                                        <br />
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <br />
                        <table width="300px">
                            <tr>
                                <td>
                                    <asp:Label ID="lblErrorMessage" runat="server" CssClass="errormsg" meta:resourcekey="lblErrorMessageResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="DivProfile" style="display: none;" class="contentdata">
                        <uc7:InvestigationControl ID="InvestigationControl1" runat="server" />
                        <%--<input type="button" value="OK" id="Button1" runat="server" class="btn" onmouseover="this.className='btn btnhov'"
                            onmouseout="this.className='btn'" onclick="ShowProfile('DivProfile')" />
                     <input type="button" id="btnClose" value="Close" class="btn" onclick="ShowProfile('DivProfile')"
                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" />--%>
                        <asp:Button ID="btnSubmit" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                            onmouseout="this.className='btn'" OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                            onmouseout="this.className='btn'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
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
