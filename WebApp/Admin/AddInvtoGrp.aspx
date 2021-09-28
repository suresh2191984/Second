<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddInvtoGrp.aspx.cs" Inherits="Admin_AddInvtoGrp" %>

<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mapping Inv to Group</title>
    <%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function winClose() {

            window.close();
        }
        function chkonchange() {

            var tableBody = document.getElementById('chklstGrp').childNodes[0];
            var j = 0;
            for (var i = 0; i < tableBody.childNodes.length; i++) {
                var currentTd = tableBody.childNodes[i].childNodes[0];
                var listControl = currentTd.childNodes[0];
                if (listControl.checked == true) {
                    j = j + 1;
                }
            }
            if (j == 0) {
                alert('Select the items in investigation master');
                return false;
            }
        }
        function chklstonchange() {

            var tableBody = document.getElementById('chkGrpMap').childNodes[0];
            var j = 0;
            for (var i = 0; i < tableBody.childNodes.length; i++) {
                var currentTd = tableBody.childNodes[i].childNodes[0];
                var listControl = currentTd.childNodes[0];
                if (listControl.checked == true) {
                    j = j + 1;
                }
            }
            if (j == 0) {
                alert('Select the items in investigation mapping');
                return false;
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div style="display: none;">
        <t1:Theme ID="Theme1" runat="server" />
    </div>
    <div class="contentdatapopup">
        <asp:Panel ID="pnlGRP" CssClass="dataheader2" BorderWidth="1px" runat="server">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <div id="divInvGp" runat="server">
                        <table border="1" cellpadding="0" width="100%">
                            <tr>
                                <td>
                                    UnMapped Investigation
                                    <asp:TextBox ID="txtInvestigationName" runat="server" Width="81px"></asp:TextBox>
                                    <asp:Button ID="btnSearch" Text="Search" runat="server" class="btn" onmouseout="this.className='btn'"
                                        onmouseover="this.className='btn btnhov'" OnClick="btnSearch_Click" />
                                </td>
                                <td>
                                </td>
                                <td>
                                    Mapped Investigation
                                    <asp:TextBox ID="txtInvname" runat="server" Width="94px"></asp:TextBox>
                                    <asp:Button ID="btnfind" Text="Search" runat="server" class="btn" onmouseout="this.className='btn'"
                                        onmouseover="this.className='btn btnhov'" OnClick="btnfind_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Master Investigation
                                </td>
                                <td>
                                </td>
                                <td>
                                    Investigation Mapped to
                                    <asp:Label ID="lbl_id" runat="server">
                                    </asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 51px;">
                                    <div style="overflow: auto; border: 2px none #fff; height: 259px;" class="ancCSviolet">
                                        <asp:CheckBoxList ID="chklstGrp" runat="server" Height="51px" Width="270px" Font-Size="Small">
                                        </asp:CheckBoxList>
                                    </div>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:HiddenField ID="hdnInv" runat="server" />
                                                <asp:HiddenField ID="hdnRemoveInv" runat="server" />
                                                <asp:Button ID="btnGrpAdd" runat="server" class="btn"  Text="Add" Width="50px" 
                                                    OnClientClick="javascript:return chkonchange();" OnClick="btnGrpAdd_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" style="height: 15px">
                                                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                                    <ProgressTemplate>
                                                        <asp:Image ID="Img1" ImageUrl="~/Images/ajax-loader.gif" runat="server" Height="33px"
                                                            Width="50px" /><%=Resources.ReportsLims_AppMsg.ReportsLims_BillWiseDeptCollectionReportLims_aspx_05%>
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnGrpRemove" runat="server" class="btn" Text="Remove"
                                                     OnClientClick="javascript:return chklstonchange();" OnClick="btnGrpRemove_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <div style="overflow: scroll; border-color: Red; height: 280px;">
                                        <asp:CheckBoxList ID="chkGrpMap" runat="server" Height="51px" Width="270px" Font-Size="Small">
                                        </asp:CheckBoxList>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <table border="1" cellpadding="0" width="100%">
                            <tr>
                                <td width="10%">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbl1" runat="server" Text="Investigation"></asp:Label>
                                            <asp:TextBox ID="txt1" runat="server" Width="2" BackColor="Orange"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Label ID="lbl2" runat="server" Text="Group"></asp:Label>
                                            <asp:TextBox ID="txt2" runat="server" Width="2" BackColor="Black"></asp:TextBox>
                                        </td>
                                    </tr>
                                </td>
                                <tr>
                                    <td width="20%">
                                        <a href="javascript:winClose();" 
                                            style="cursor: pointer; text-decoration: none; font-weight: bold; color: Blue;">
                                        Close Window </a>
                                        <asp:HiddenField ID="Hdngid" runat="server" />
                                        <asp:HiddenField ID="HdnMap" runat="server" />
                                        <asp:HiddenField ID="HdnAdd" runat="server" />
                                        <asp:HiddenField ID="HdnRemove" runat="server" />
                                    </td>
                                </tr>
                        </table>
                        </td> </tr>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>
    </div>
    </form>
</body>
</html>
