<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TemplateMaker.aspx.cs" Inherits="TemplateMaker" meta:resourcekey="PageResource1" %>

<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Radiology Template Master</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />

    <script language="javascript" type="text/javascript">
        function ValidateNullField() {
            var objvar01 = SListForAppMsg.Get("Admin_TemplateMaker_aspx_05") == null ? "Provide template name" : SListForAppMsg.Get("Admin_TemplateMaker_aspx_05");
            var objAlert = SListForAppMsg.Get("Admin_TemplateMaker_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_TemplateMaker_aspx_Alert");

            if (document.getElementById('txtTemplateHeader').value == '') {
                //alert('Provide template name');
                ValidationWindow(objvar01, objAlert);
                return false;
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
      <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                         <asp:UpdatePanel ID="updatePanelSearch" runat="server">
                            <ContentTemplate>
                                <table class="w-100p searchPanel">
                                    <tr>
                                        <td class="a-center font12 hieght20 w-10p" style="font-weight: normal;color: #000;">
                                            <asp:Label runat="server" ID="lblName" meta:resourcekey="lblNameResource1"></asp:Label>
                                            <asp:HiddenField ID="HdnResultID" Value="0" runat="server" />
                                            <asp:HiddenField ID="hdnPageIndx" Value="0" runat="server" />
                                            &nbsp;
                                            <%-- <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="false" OnClick="lnkEdit_Click"
                                        ForeColor="Red"></asp:LinkButton>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Panel ID="pnlV" runat="server" meta:resourcekey="pnlVResource1">
                                                <table class="w-100p">
                                                    <tr>
                                                        <td class="colorforcontent w-35p a-left">
                                                            <div style="display: none;" runat="server" id="ACX2plusEU">
                                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                                    style="cursor: pointer" onclick="showResponses('ACX2plusEU','ACX2minusEU','ACX2responsesEU',1);" />
                                                                <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusEU','ACX2minusEU','ACX2responsesEU',1);">
                                                                <%=Resources.Admin_ClientDisplay.Admin_TemplateMaker_aspx_01 %>    <%--Edit Existing Template--%></span>
                                                            </div>
                                                            <div style="display: block; height: 18px;" runat="server" id="ACX2minusEU">
                                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                                    style="cursor: pointer" onclick="showResponses('ACX2plusEU','ACX2minusEU','ACX2responsesEU',0);" />
                                                                <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusEU','ACX2minusEU','ACX2responsesEU',0);">
                                                                   <%=Resources.Admin_ClientDisplay.Admin_TemplateMaker_aspx_01 %>  <%-- Edit Existing Template--%></span>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr class="tablerow" id="ACX2responsesEU" style="display: table-row;">
                                                        <td colspan="5">
                                                            <div class="dataheader2">
                                                                <div id="divEdit">
                                                                    <table class="w-100p bg-row">
                                                                        <tr>
                                                                            <td>
                                                                                <br />
                                                                                <table class="w-100p">
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:Label ID="Label1" runat="server" Text="Template Name:" 
                                                                                                meta:resourcekey="Label1Resource1"></asp:Label>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:TextBox ID="txtResultname" autocomplete="off"  CssClass ="Txtboxsmall" 
                                                                                                runat="server" meta:resourcekey="txtResultnameResource1"></asp:TextBox>
                                                                                        </td>
                                                                                        <td  class="font12 h-20 w-22p" style="color:#000;">
                                                                                            <asp:Label runat="server" ID="Label2" Text="Select Department Name:" 
                                                                                                meta:resourcekey="Label2Resource1"></asp:Label>
                                                                                        </td>
                                                                                        <td class="font12 h-20 w-22p" style="color:#000;">
                                                                                            <asp:DropDownList ID="ddlDept"  CssClass ="ddlsmall" runat="server" >
                                                                                            </asp:DropDownList>
                                                                                            <img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:Button ID="btnSearch" Text="Search" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                                                onmouseout="this.className='btn'" OnClick="BtnSearch_click" 
                                                                                                meta:resourcekey="btnSearchResource1" />
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="a-center">
                                                                                <asp:GridView ID="grdResult" runat="server" AllowPaging="True" OnPageIndexChanging="Result_PageIndexChanging"
                                                                                    CellPadding="4" AutoGenerateColumns="False" OnRowCommand="Result_RowCommand"
                                                                                    DataKeyNames="ResultID,ResultName" ForeColor="#333333"
                                                                                    CssClass="mytable1 gridView w-54p" meta:resourcekey="grdResultResource1">
                                                                                    <PagerTemplate>
                                                                                        <tr>
                                                                                            <td colspan="6" class="a-center">
                                                                                                <asp:ImageButton ID="lnkPrev" CommandName="Page" runat="server" CausesValidation="False"
                                                                                                    CommandArgument="Prev" ImageUrl="~/Images/previousimage.png" Width="18px" 
                                                                                                    Height="18px" meta:resourcekey="lnkPrevResource1" />
                                                                                                <asp:ImageButton ID="lnkNext" CommandName="Page" runat="server" CausesValidation="False"
                                                                                                    CommandArgument="Next" ImageUrl="~/Images/nextimage.png" Width="18px" 
                                                                                                    Height="18px" meta:resourcekey="lnkNextResource1" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </PagerTemplate>
                                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                                    <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                                                    <Columns>
                                                                                        <asp:TemplateField HeaderText="Select" 
                                                                                            meta:resourcekey="TemplateFieldResource1">
                                                                                            <ItemTemplate>
                                                                                                <asp:RadioButton ID="chkSel" runat="server" GroupName="ResultSelect" 
                                                                                                    meta:resourcekey="chkSelResource1" ToolTip="Select Row" />
                                                                                                <asp:HiddenField ID="lblResultID" runat="server" 
                                                                                                    Value='<%# bind("ResultID") %>' />
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle Width="10%"></ItemStyle>
                                                                                        </asp:TemplateField>
                                                                                        <asp:BoundField DataField="ResultName" HeaderText="Name" 
                                                                                            meta:resourcekey="BoundFieldResource1">
                                                                                            <ItemStyle HorizontalAlign="Left" Width="25%"></ItemStyle>
                                                                                        </asp:BoundField>
                                                                                        <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                                                            <ItemStyle HorizontalAlign="Left" Width="25%" />
                                                                                            <ItemTemplate>
                                                                                                <asp:LinkButton ID="btnSave" runat="server" 
                                                                                                    CommandArgument='<%# Eval("ResultID") %>' CommandName="pDelete" 
                                                                                                    Font-Bold="True" Font-Underline="True" ForeColor="Blue" 
                                                                                                    meta:resourcekey="btnSaveResource1" Text="Delete" Width="25%"></asp:LinkButton>
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                    </Columns>
                                                                                </asp:GridView>
                                                                                <asp:Label ID="lblMsg" runat="server" meta:resourcekey="lblMsgResource1"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="a-center">
                                                                                <br />
                                                                                &nbsp;<asp:Button ID="btnEdit" Visible="false" runat="server" Text="Edit" CssClass="btn"
                                                                                    onmouseover="this.className='btn btnhov'" OnClick="btnEdit_Click" onmouseout="this.className='btn'"
                                                                                    Width="75px" meta:resourcekey="btnEditResource1" />
                                                                                <asp:Button ID="btnDelete" Visible="false" runat="server" Text="Delete" CssClass="btn"
                                                                                    onmouseover="this.className='btn btnhov'" OnClick="btnDelete_click" onmouseout="this.className='btn'"
                                                                                    Width="75px" meta:resourcekey="btnDeleteResource1" />
                                                                                <asp:Label ID="lblLoginName" runat="server" 
                                                                                    meta:resourcekey="lblLoginNameResource1"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="colorforcontent w-100p a-left">
                                                            <div style="display: none" id="ACX2plus2">
                                                                <img src="../Images/showBids.gif" class="" alt="Show" width="15" height="15" align="top"
                                                                    style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1);" />
                                                                <span class="dataheader1txt" style="cursor: pointer" onclick="return showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1);">
                                                                <%=Resources.Admin_ClientDisplay.Admin_TemplateMaker_aspx_02 %>    <%--Create New Template--%></span>
                                                            </div>
                                                            <div style="display: block" id="ACX2minus2">
                                                                <img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer"
                                                                    onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);" />
                                                                <span class="dataheader1txt" style="cursor: pointer" onclick="return showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);">
                                                                 <%=Resources.Admin_ClientDisplay.Admin_TemplateMaker_aspx_02 %>   <%--Create New Template--%></span>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr id="ACX2responses2" style="display: table-row">
                                                        <td>
                                                            <table class="w-100p">
                                                                <tr>
                                                                    <td style="font-weight: normal;color: #000;" class="w-20p font12">
                                                                        <asp:Label runat="server" ID="lblPerfPhysician" Text="Select Department Name:" 
                                                                            meta:resourcekey="lblPerfPhysicianResource1"></asp:Label>
                                                                    </td>
                                                                    <td style="color: #000; width: 155Px;" class="w-80p font12 h-20">
                                                                        <asp:DropDownList ID="ddlDepartment"  CssClass ="ddlsmall" runat="server">
                                                                        </asp:DropDownList>
                                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                                    </td>
                                                                    <td class="a-right font12 h-20 w-30p" style="color: #000;">
                                                                        <%--  <asp:LinkButton ID="lnkAutoSave" runat="server" Text="AutoSave" ForeColor="Black"
                                                                        OnClick="lnkAutoSave_Click"></asp:LinkButton>--%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-right font12 h-20" style="color: #000;">
                                                                   <%=Resources.Admin_ClientDisplay.Admin_TemplateMaker_aspx_03 %>     <%--Enter Template Name :--%>
                                                                    </td>
                                                                    <td class="a-right font12 h-20" style="color: #000; margin-left: 40px;">
                                                                        <asp:TextBox runat="server" ID="txtTemplateHeader" Height="20px" 
                                                                            CssClass ="Txtboxsmall" meta:resourcekey="txtTemplateHeaderResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td style="color: #000;" class="a-right font12 h-20">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="color: #000;"  class="a-right font12 h-20 w-10p">
                                                                        <asp:Label runat="server" ID="lblInvDetails" Text="Investigation Details" 
                                                                            meta:resourcekey="lblInvDetailsResource1"></asp:Label>
                                                                    </td>
                                                                    <td style="color: #000;"  class="a-right font12 h-20 w-10p">
                                                                        <FCKeditorV2:FCKeditor ID="fckInvDetails" runat="server" Width="580px" Height="100px">
                                                                        </FCKeditorV2:FCKeditor>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="color: #000;"  class="a-right font12 h-20 w-10p">
                                                                        <asp:Label ID="lblFindings" runat="server" Text="Investigation Findings" 
                                                                            meta:resourcekey="lblFindingsResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <FCKeditorV2:FCKeditor ID="FCKinvFinidings" runat="server" Width="580px" Height="150px">
                                                                        </FCKeditorV2:FCKeditor>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="color: #000;"  class="a-right font12 h-20 w-10p">
                                                                        <asp:Label ID="lblImpression" runat="server" Text="Impression" 
                                                                            meta:resourcekey="lblImpressionResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <FCKeditorV2:FCKeditor ID="FCKImpression" runat="server" Width="580px" Height="150px">
                                                                        </FCKeditorV2:FCKeditor>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="color: #000;"  class="a-right font12 h-20 w-10p">
                                                                        <asp:Label ID="lblAddNotes" Visible="False" runat="server" 
                                                                            Text="Additional Notes" meta:resourcekey="lblAddNotesResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtAddNotes" Visible="False" runat="server" TextMode="MultiLine"
                                                                            Height="116px" Width="580px" meta:resourcekey="txtAddNotesResource1"></asp:TextBox>
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
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Finish" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClick="btnsubmit_click" 
                                                meta:resourcekey="btnSubmitResource1" />
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" OnClick="btnCancel_Click"
                                                onmouseover="this.className='btn btnhov'" 
                                                onmouseout="this.className='btn'" meta:resourcekey="btnCancelResource1" />
                                        </td>
                                    </tr>
                                    <asp:HiddenField runat="server" ID="hidVal" />
                                </table>
                                </div> </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
        <Attune:Attunefooter ID="Attunefooter" runat="server" />         
    </form>
</body>
</html>
