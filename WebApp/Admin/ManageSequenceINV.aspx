<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageSequenceINV.aspx.cs"
    Inherits="Admin_ManageSequenceINV" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title></title>
    <%--<link href="~/StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>

    <script>
        function SelectInvSeqRowCommon(rid) {
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(rid).checked = true;
        }

        function getvalue(value, id) {
            var hdn = document.getElementById("<%=hdndata.ClientID%>").value;
            var lst = hdn.split('^');
            var check = id;
            for (j = 0; j <= lst.length - 1; j++) {
                var value = lst[j].split('~');
                if (value[1] == check) {
                    document.getElementById(value[2]).value = "";
                    document.getElementById(value[1]).style.display = "none";
                    document.getElementById(value[0]).style.display = "block";
                    document.getElementById(value[2]).value = "1";
                }
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
      <Attune:Attuneheader ID="Attuneheader" runat="server" />
    
                    <div class="contentdata">
                        <asp:UpdatePanel ID="UpdPnl" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvReckon" EmptyDataText="No matching records found " runat="server"
                                    AutoGenerateColumns="False" CssClass="w-100p gridView"
                                    ForeColor="#333333" CellPadding="3" OnRowDataBound="Gvbound" 
                                    OnRowCommand="gvReckon_RowCommand" meta:resourcekey="gvReckonResource1">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select" 
                                            meta:resourcekey="TemplateFieldResource1">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rdbcheck" runat="server" 
                                                    meta:resourcekey="rdbcheckResource1" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Header Name" 
                                            meta:resourcekey="TemplateFieldResource2">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chk" runat="server" Visible="False" 
                                                    meta:resourcekey="chkResource1" />
                                                <asp:Label ID="dischargeid" runat="server" Visible="False" 
                                                    Text='<%# bind("Dischargesummaryseqid") %>' 
                                                    meta:resourcekey="dischargeidResource1"></asp:Label>
                                                <asp:Label ID="PlaceHolderID" runat="server" Visible="False" 
                                                    Text='<%# bind("PlaceHolderID") %>' meta:resourcekey="PlaceHolderIDResource1"></asp:Label>
                                                <asp:Label ID="sequence" runat="server" Visible="False" 
                                                    Text='<%# bind("SequenceNo") %>' meta:resourcekey="sequenceResource1"></asp:Label>
                                                <asp:TextBox ID="txtheadername" runat="server" Width="80%" 
                                                    Text='<%# bind("HeaderName") %>' meta:resourcekey="txtheadernameResource1"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Move" meta:resourcekey="TemplateFieldResource3">
                                            <ItemTemplate>
                                                <asp:Button ID="btnmove" runat="server" CssClass="btn" Text="Move" CommandName="Move"
                                                    CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' 
                                                    meta:resourcekey="btnmoveResource1" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Remove" 
                                            meta:resourcekey="TemplateFieldResource4">
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnFlag" Value="0" runat="server" />
                                                <asp:ImageButton ID="imgclose" runat="server" Visible="False" CommandName="close"
                                                    CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' 
                                                    ImageUrl="~/Images/close_button.gif" meta:resourcekey="imgcloseResource1" />
                                                <asp:ImageButton ID="imgright" runat="server" ImageUrl="~/Images/RightIcon.png" CommandName="right"
                                                    CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' 
                                                    meta:resourcekey="imgrightResource1" />
                                                <asp:HiddenField ID="hdnremove" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="dataheader1" />
                                </asp:GridView>
                                <table id="tprint" runat="server" class="w-100p">
                                    <tr id="Tr2" runat="server">
                                        <td id="Td2" class="a-center" runat="server">
                                            <asp:HiddenField ID="hdndata" runat="server" />
                                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1"/>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
      <Attune:Attunefooter ID="Attunefooter" runat="server" />        
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
