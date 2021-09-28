<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MergeBills.aspx.cs" Inherits="Reception_MergeBills" %>

<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Convert OP Bills to IP</title>
    <script type="text/javascript" language="javascript">
         
        function ValidateGrid() {
            var chkboxrowcount = $("#grdConvertToIP input[id*='chkSelect']:checkbox:checked").size();
            if (chkboxrowcount == 0) {
                alert("please select at least one record");
                return false;
            }
        }
    </script>
</head>
<body onkeydown="SuppressBrowserRefresh();">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scrpt" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="UsrHeader1" runat="server" />
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
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <div id="YesData" runat="server">
                            <table width="100%" border="0" cellspacing="5" cellpadding="5">
                                <tr>
                                    <td colspan="2">
                                        <asp:GridView ID="grdConvertToIP" runat="server" AutoGenerateColumns="False" Width="100%"
                                            OnRowDataBound="grdConvertToIP_RowDataBound">
                                            <Columns>
                                                <asp:TemplateField HeaderText="select">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkSelect" runat="server" />
                                                        <asp:HiddenField ID="hdnPatientID" runat="server" Value='<%# Eval("PatientID") %>' />
                                                        <asp:HiddenField ID="hdnVisiID" runat="server" Value='<%# Eval("PatientVisitId") %>' />
                                                        <asp:HiddenField ID="hdnFinalBillID" runat="server" Value='<%# Eval("FinalBillID") %>' />
                                                        <asp:HiddenField ID="hdnIsCreditBill" runat="server" Value='<%# Eval("IsCreditBill") %>' />
                                                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("IsCreditBill") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderText="Patient No." DataField="PatientNumber" />
                                                <asp:BoundField HeaderText="Patient Name" DataField="PatientName" />
                                                <asp:BoundField HeaderText="Bill No" DataField="BillNumber" />
                                                <asp:BoundField HeaderText="Visit Date" DataField="VisitDate" />
                                                <asp:BoundField ItemStyle-HorizontalAlign="Right" HeaderText="Bill Amt" DataField="ActualBilled" />
                                                <asp:BoundField ItemStyle-HorizontalAlign="Right" HeaderText="Discount Amt" DataField="Discount" />
                                                <asp:BoundField ItemStyle-HorizontalAlign="Right" HeaderText="Tax Amt" DataField="TaxAmount" />
                                                <asp:BoundField ItemStyle-HorizontalAlign="Right" HeaderText="Net Amt" DataField="NetValue" />
                                                <asp:BoundField ItemStyle-HorizontalAlign="Right" HeaderText="Amt Received" DataField="AmountReceived" />
                                                <asp:BoundField ItemStyle-HorizontalAlign="Right" HeaderText="Due" DataField="Due" />
                                                <asp:TemplateField HeaderText="Description">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDescription" runat="server" Text='<%#Bind("Description")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:Button ID="btnConvert" runat="server" Text=" Convert to IP " CssClass="btn" 
                                            onclick="btnConvert_Click" OnClientClick="return ValidateGrid();" />
                                        <asp:Button ID="btnCancel" runat="server" Text=" Cancel " CssClass="btn" 
                                            onclick="btnCancel_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
