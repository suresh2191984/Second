<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvResultTemplate.aspx.cs"
    Inherits="Investigation_InvResultTemplate" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<%@ Register Src="../CommonControls/OrderedSamples.ascx" TagName="OrderedSamples"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%--<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>--%>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="FCKeditorV2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Investigation Result Template</title>
    <script language="javascript" type="text/javascript">
        function Invvalidation() {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vTestName = SListForAppMsg.Get('Investigation_InvResultTemplate_ascx_01') == null ? "Provide the Text name" : SListForAppMsg.Get('Investigation_InvResultTemplate_ascx_01');

            if (document.getElementById('txtResultName').value == '') {
                //alert('Provide the Text name');
                ValidationWindow(vTestName, AlertType);
                document.getElementById('txtResultName').focus();
                return false;
            }
        }
        function onselchange() {
            var ddlt = document.getElementById('ddlInvResultTemp').value;
            document.getElementById('txtResultName').value = ddlt
        }
        function clear() {
            var vSave = SListForAppDisplay.Get('Investigation_InvResultTemplate_ascx_01') == null ? "Save" : SListForAppDisplay.Get('Investigation_InvResultTemplate_ascx_01');
            var vUpdate = SListForAppDisplay.Get('Investigation_InvResultTemplate_ascx_02') == null ? "Update" : SListForAppDisplay.Get('Investigation_InvResultTemplate_ascx_02');

            if (document.getElementById('btnSave').value == '' + vUpdate + '') {
                document.getElementById('btnSave').value = '' + vSave + '';
                var oEditor = FCKeditorAPI.GetInstance('content');
                oEditor.SetHTML("");
                return false;
            }
        }
        function showInsTxt() {
            document.getElementById('trtxtresulttemp').style.display = 'none';
            document.getElementById('trddlresulttemp').style.display = 'none';
        }
    </script>

    <style type="text/css">
        .style1
        {
            width: 1%;
        }
        .ie .fckInvDetails textarea, .webkit .fckInvDetails textarea { height:680px!important;}
        #cke_fckInvDetails 
        {
        	margin:0 auto;
        }
    </style>
</head>
<body>
    <form runat="server">
    <asp:ScriptManager ID="ScriptManager1" ScriptMode="Release" runat="server" >
    </asp:ScriptManager>
      <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                               
                <asp:Panel ID="pnlenb" runat="server" BorderWidth="1px" BackColor="AliceBlue" meta:resourcekey="pnlenbResource1">
                                    <table  class="w-100p font11" style="font-weight: normal;color: #000;">
                                        <tr>
                                            <td colspan="2" class="a-center">
                                                <table class="w-100p">
                                                    <tr id="trddlresulttemp" runat="server">
                                                        <td class="a-right w-48p">
                                                        <%=Resources.Investigation_ClientDisplay.Investigation_InvResultTemplate_aspx_01%>
                                                           <%-- Report Type--%>
                                                        </td>
                                                        <td class="a-left">
                                                            <asp:DropDownList Width="192px" ID="ddlInvResultTemplate" AutoPostBack="true" runat="server"
                                                                Height="22px" OnSelectedIndexChanged="ddlInvResultTemplate_SelectedIndexChanged" CssClass="ddlsmall">
                                                                <%--<asp:ListItem Value="0" Text="----Select----"></asp:ListItem>
                                                <asp:ListItem Value="TextReport" Text="TextReport"></asp:ListItem>
                                                <asp:ListItem Value="Letter" Text="Letter"></asp:ListItem>
                                                <asp:ListItem Value="Referral" Text="Referral"></asp:ListItem>
                                                <asp:ListItem Value="Fitness" Text="Fitness"></asp:ListItem>
                                                <asp:ListItem Value="ResultSummary" Text="ResultSummary"></asp:ListItem>
                                                <asp:ListItem Value="ClinicalInterpretation" Text="ClinicalInterpretation"></asp:ListItem>
                                                <asp:ListItem Value="Suggestions" Text="Suggestions"></asp:ListItem>
                                                <asp:ListItem Value="Imaging" Text="Imaging"></asp:ListItem>--%>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="a-center">
                                                <table class="w-100p">
                                                    <tr id="trtxtresulttemp" runat="server" style="display: table-row">
                                                        <td class="a-right w-48p">
                                            <%=Resources.Investigation_ClientDisplay.Investigation_InvResultTemplate_ascx_05 %>
                                                        </td>
                                                        <td class="a-left">
                                                            <asp:TextBox ID="txtResultName" runat="server" Width="189px" CssClass="Txtboxsmall"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr id="ddl1resulttemp" runat="server" style="display: table-row">
                                                        <td class="a-right w-48p">
                                           <%=Resources.Investigation_ClientDisplay.Investigation_InvResultTemplate_ascx_05 %>
                                                        </td>
                                                        <td class="a-left">
                                                            <asp:DropDownList Width="192px" ID="ddlInvResultTemp" AutoPostBack="false" runat="server" CssClass="ddlsmall"
                                                                Height="22px">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" class="a-center">
                                                            <asp:Button ID="btnGo" runat="server" Text="EDIT" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClick="btnGo_Click" meta:resourcekey="btnGoResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="font-weight: normal;color: #000;" class="font11">
                                <asp:Label runat="server" ID="lblName" meta:resourcekey="lblNameResource1"></asp:Label>
                                <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" ForeColor="Red"
                                    meta:resourcekey="lnkEditResource1"></asp:LinkButton>
                                            </td>
                                            <td style="font-weight: normal;color: #000;" class="a-center fckInvDetails font11">
                                                <%--<FCKeditorV2:FCKeditor ID="fckInvDetails" runat="server" Width="680px" Height="680px">
                                                </FCKeditorV2:FCKeditor>--%>
                                                <FCKeditorV2:CKEditorControl ID="fckInvDetails" runat="server" FontNames="Arial" 
                                            Width="680px" Height="680px"  ToolbarSet="Biospy" 
                                            TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="a-center">
                                                <table class="w-100p">
                                                    <tr>
                                                        <td>
                                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" OnClick="btnSave_Click"
                                                meta:resourcekey="btnSaveResource1" />
                                            <asp:Button ID="btnCancel" runat="server" Text="Clear" CssClass="btn" OnClick="btnCancel_Click"
                                                meta:resourcekey="btnCancelResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <asp:HiddenField runat="server" ID="hidVal" />
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
       <Attune:Attunefooter ID="Attunefooter" runat="server" />         
    </form>
</body>
</html>
