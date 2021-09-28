<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProcedureMaster.aspx.cs"
    Inherits="Admin_ProcedureMaster" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="Stylesheet" type="text/css" />
     <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function EditFunc(ProcMainID, ProcDesc, RunningID, IsVisitPurpose) {
            document.getElementById('hdnProcID').value = ProcMainID;
            document.getElementById('txtproceduredesc').value = ProcDesc;
            document.getElementById('<%= btnSave.ClientID %>').value = "Update";
            document.getElementById('divChk').style.display = 'block';
            if (IsVisitPurpose == 'Y') {
                document.getElementById('chkActive').checked = true;
            }
            else {
                document.getElementById('chkActive').checked = false;
            }
            document.getElementById('hdnBtnID').value = "1";
            document.getElementById('hdnRunID').value = RunningID;
        }
        function Showpop() {
            document.getElementById('divmodpop').style.display = 'block';
            document.getElementById('txtProcName').value = '';
        }
        function Reset() {
            document.getElementById('hdnProcID').value = '';
            document.getElementById('txtproceduredesc').value = '';
            document.getElementById('<%= btnSave.ClientID %>').value = "Save";
            document.getElementById('hdnBtnID').value = "0";
            document.getElementById('chkActive').checked = false;
            return false;
        }
        function Validate() {
            var isBool;
            isBool = validateRadioButtonList('<%= rdnlstname.ClientID %>');
            if (isBool == true) {
                if (document.getElementById('txtproceduredesc').value == '') {
                    alert("Please Enter Procedure Description");
                    document.getElementById('txtproceduredesc').value = '';
                    document.getElementById('txtproceduredesc').focus();
                    return false;
                }
            }
            else {
                return false;
            }
            return true;
        }
        function validateRadioButtonList(radioButtonListId) {
            var listItemArray = document.getElementsByName(radioButtonListId);
            var isItemChecked = false;
            for (var i = 0; i < listItemArray.length; i++) {
                var listItem = listItemArray[i];
                if (listItem.checked) {
                    isItemChecked = true;
                }
            }
            if (isItemChecked == false) {
                alert('Please Select One Procedure Name!');
                return false;
            }
            return true;
        }
        function ConfirmDelete() {
            var cnfm = confirm("Are you sure you want to delete this?");
            if (cnfm == true) {
                document.getElementById('hdndelete').value = "1";
            }
            else {
                document.getElementById('hdndelete').value = "0";
            }
        }
        function ProcValidate() {
            if (document.getElementById('txtProcName').value == '') {
                alert("Please Enter Procedure Name");
                return false;
            }
        }
        function ShowPopup() {
            $find('ModalPopupExtender1').show();
            //            $get('btnSaveProc').click();
        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="wrapper">
        <div id="header">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc2:Header ID="Header2" runat="server" />
                <uc6:DocHeader ID="docHeader" runat="server" />
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
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc5:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="UdtPanel" runat="server">
                            <ContentTemplate>
                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td align="left" colspan="2">
                                            <table width="100%">
                                                <tr>
                                                    <td>
                                                        <asp:Panel ID="pnl2" runat="server" BorderWidth="1px" 
                                                            CssClass="dataheader2">
                                                                <table width="100%">
                                                                    <tr>
                                                                        <td align="right">
                                                                            <asp:Label runat="server" ID="lblproceduretype" Text="Procedure Type: " meta:resourcekey="lblproceduretypeResource1"></asp:Label>
                                                                        </td>
                                                                        <td width="10%">
                                                                            <asp:Label ID="lblproctype" runat="server" Text="Treatment" meta:resourcekey="lblproctypeResource1"></asp:Label>
                                                                        </td>
                                                                        <td width="12%" align="right">
                                                                            <asp:Label ID="lblprocedurename" runat="server" Text="Procedure Name: " meta:resourcekey="lblprocedurenameResource1"></asp:Label>
                                                                        </td>
                                                                        <td width="45%">
                                                                            <asp:RadioButtonList ID="rdnlstname" runat="server" RepeatDirection="Horizontal"
                                                                                OnSelectedIndexChanged="rdnlstname_SelectedIndexChanged" AutoPostBack="True"
                                                                                meta:resourcekey="rdnlstnameResource1">
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:LinkButton ID="lnkbtnadd" runat="server" Text="Add Procedure Name" ForeColor="Blue"
                                                                                Font-Underline="True" meta:resourcekey="lnkbtnaddResource1" OnClientClick="Showpop();"></asp:LinkButton>
                                                                            <Ajax:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="lnkbtnadd"
                                                                                PopupControlID="Panel1" BackgroundCssClass="modalBackground" CancelControlID="btnClose"
                                                                                DynamicServicePath="" Enabled="True" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    <table>
                                                        <tr>
                                                            <td align="right" width="35%">
                                                                <asp:Label ID="lblproceduredesc" runat="server" Text="Enter Procedure Description: "
                                                                    meta:resourcekey="lblproceduredescResource1"></asp:Label>
                                                            </td>
                                                            <td width="15%">
                                                                <asp:TextBox ID="txtproceduredesc" runat="server" meta:resourcekey="txtproceduredescResource1"
                                                                     CssClass="Txtboxmedium" ></asp:TextBox>
                                                            </td>
                                                            <td width="45%">
                                                                <div id="divChk" runat="server">
                                                                    <asp:CheckBox ID="chkActive" runat="server" Text="Is Active" meta:resourcekey="chkActiveResource1" />
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="2">
                                            <asp:GridView ID="grdView" runat="server" AutoGenerateColumns="False" AllowPaging="True"
                                                CellPadding="4" CssClass="mytable" DataKeyNames="RunningID,ProcMainID,ProcDesc,IsVisitPurpose"
                                                PageSize="50" OnRowDataBound="grdView_RowDataBound" OnRowDeleting="grdView_RowDeleting"
                                                meta:resourcekey="grdViewResource1">
                                                <HeaderStyle CssClass="dataheader1" />
                                                <RowStyle Font-Bold="False" />
                                                <PagerSettings Mode="NextPrevious" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="ProcMain ID" Visible="False" meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTypeID" Text='<%# Bind("ProcMainID") %>' runat="server" meta:resourcekey="lblTypeIDResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Left" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Procedure Description" meta:resourcekey="TemplateFieldResource2">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblIsActive" Text='<%# Bind("ProcDesc") %>' runat="server" meta:resourcekey="lblIsActiveResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Left" />
                                                        <ItemStyle HorizontalAlign="Left" Width="75%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource3">
                                                        <ItemTemplate>
                                                            <input id="btnEdit" runat="server" value="Edit" type="button" style='font-size: 14px;
                                                                background-color: Transparent; color: Blue; border-style: none; cursor: pointer;
                                                                text-decoration: underline' />
                                                            &nbsp;|&nbsp;<asp:LinkButton ID="lnkDelete" runat="server" CommandName="DELETE" ForeColor="Red"
                                                                OnClientClick="ConfirmDelete();" meta:resourcekey="lnkDeleteResource1" Text="DELETE"></asp:LinkButton>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="75%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Running ID" Visible="False" meta:resourcekey="TemplateFieldResource4">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblRunningID" Text='<%# Bind("RunningID") %>' runat="server" meta:resourcekey="lblRunningIDResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Left" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Is Visit Purpose" Visible="False" meta:resourcekey="TemplateFieldResource5">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblIsVisitPurpose" Text='<%# Bind("IsVisitPurpose") %>' runat="server"
                                                                meta:resourcekey="lblIsVisitPurposeResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Left" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                </Columns>
                                                <SelectedRowStyle ForeColor="#000066" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" width="30%">
                                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" Width="75px" OnClick="btnSave_Click" OnClientClick="return Validate();"
                                                meta:resourcekey="btnSaveResource1" />
                                        </td>
                                        <td width="45%" align="">
                                            <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" Width="75px" OnClientClick="return Reset();"
                                                meta:resourcekey="btnResetResource1" />
                                        </td>
                                    </tr>
                                </table>
                                <asp:HiddenField ID="hdnBtnID" runat="server" Value="0" />
                                <asp:HiddenField ID="hdnProcID" runat="server" />
                                <asp:HiddenField ID="hdnRunID" runat="server" Value="0" />
                                <div id="divmodpop" runat="server">
                                    <asp:Panel ID="Panel1" Width="300px" Height="100px" runat="server" CssClass="modalPopup dataheaderPopup"
                                        Style="display: block" meta:resourcekey="Panel1Resource1">
                                        <table width="100%" align="center">
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="lblProcName" runat="server" Text="Procedure Name" meta:resourcekey="lblProcNameResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtProcName" runat="server"  CssClass ="Txtboxsmall" meta:resourcekey="txtProcNameResource1" Text=""></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="2">
                                                    <asp:Button ID="btnSaveProc" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" Width="75px" OnClientClick="return ProcValidate();" OnClick="btnSaveProc_Click"
                                                        meta:resourcekey="btnSaveProcResource1" />
                                                    <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" Width="75px" meta:resourcekey="btnCloseResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc4:Footer ID="Footer1" runat="server" />
        <input type="hidden" id="hdndelete" runat="server" value="0" />
    </div>
    </form>
</body>
</html>
