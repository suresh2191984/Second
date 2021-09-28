<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportTemplate.aspx.cs" Inherits="Admin_ReportTemplate" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/InvReportTemplateMaster.ascx" TagName="ReportTemplateMaster" TagPrefix="ucRTM" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Report Template</title>

    <script language="javascript" type="text/javascript">
        function ShowPopUp(id) {
            document.getElementById('btnDummy').click();
            document.getElementById('hdnRptPathControl').value = id; //'txtReportTemplateM';
        }
        function ClosePopUp() {
            document.getElementById('btnpopClose').click();            
        }
        function SetPathControl(id) {
            document.getElementById('hdnRptPathControl').value = id;
        }
        function SetSelectedPath() {
            //document.getElementById(document.getElementById('hdnRptPathControl').value).value = document.getElementById('hdnClikedValue').value;
            document.getElementById(document.getElementById('hdnRptPathControl').value).value = document.getElementById('RT1_hdnSelctedValue').value;
            ClosePopUp();
            return false;
        }
        function SingleCheckAlert(chkID) {
            var objVarRep01 = SListForAppMsg.Get("Admin_ReportTemplate_aspx_01") == null ? "Select One Default Template only" : SListForAppMsg.Get("Admin_ReportTemplate_aspx_01");
            var objAlert = SListForAppMsg.Get("Admin_ReportTemplate_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ReportTemplate_aspx_Alert");

            var varChklist = new Array();
            varChklist = document.getElementById('hdnChkControls').value.split('~');
            if (varChklist.length > 0) {
                for (i = 0; i < varChklist.length; i++) {
                    if (document.getElementById(varChklist[i]) != null) {
                        if ((varChklist[i] != chkID) && document.getElementById(varChklist[i]).checked == true) {
                            //alert("Select One Default Template only");
                            ValidationWindow(objVarRep01, objAlert);
                            document.getElementById(chkID).checked = false;
                            return;
                        }
                    }
                }
            }
        }
    </script>

</head>
<body  oncontextmenu="return false;">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                     
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <table class="w-100p searchPanel">
                                    <tr>
                                        <td>
                                            <asp:Panel ID="Panel7" CssClass="dataheader2" BorderWidth="1px" runat="server" 
                                                meta:resourcekey="Panel7Resource1">
                                            <table class="w-100p">
                                            <tr>
                                                <td class="a-center w-25p">
                                                    <table class="w-100p bg-row">
                                                        <tr>
                                                            <td class="padding3">
                                                                <table class="w-60p">
                                                                    <tr>
                                                                        <td class="a-right w-15p">
                                                                            <asp:Label ID="lblReportTemplate" Text="Report Template" runat="server" 
                                                                                meta:resourcekey="lblReportTemplateResource1"></asp:Label>
                                                                        </td>
                                                                        <td class="a-right w-5p">
                                                                            <asp:TextBox ID="txtReportTemplateM" Width="360px" MaxLength="255"  
                                                                                CssClass ="Txtboxlarge" runat="server" 
                                                                                meta:resourcekey="txtReportTemplateMResource1"></asp:TextBox>
                                                                        </td>
                                                                        <td class="a-left w-5p">
                                                                            <a id="aBrowseM" runat="server" onclick="ShowPopUp(this.id);" 
                                                                                title="Click here to Browse Report Template Path" 
                                                                                style="display: block; font-size:large;cursor: pointer;"><B>
                                                                            <img src="../Images/SearchIcon.PNG" /></B></a>
                                                                        </td>
                                                                        <td class="a-left w-20p">
                                                                            <asp:Button ID="btnSearch" runat="server" ToolTip="Click here to find Report Template"
                                                                                Style="cursor: pointer;" 
                                                                                Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                                onmouseout="this.className='btn'" onclick="btnSearch_Click" 
                                                                                meta:resourcekey="btnSearchResource1" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="a-right" >
                                                                            <asp:CheckBox ID="chkIsDefaultM" Text="IsDefault" runat="server" 
                                                                                meta:resourcekey="chkIsDefaultMResource1" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="a-center" colspan="2">
                                                                            <asp:Button ID="btnAddNew" Text="Add" runat="server" 
                                                                                ToolTip="Click here to Save New Report Template Name" Style="cursor: pointer;"
                                                                                CssClass="btn" onmouseover="this.className='btn btnhov'" 
                                                                                onmouseout="this.className='btn'" 
                                                                                Width="70px" onclick="btnAddNew_Click" 
                                                                                meta:resourcekey="btnAddNewResource1" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
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
                                            <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center paddingB10">
                                            <asp:Label ID="lblStatus" Visible="False" runat="server" ForeColor="#000333" 
                                                Text="No Matching Records Found!" meta:resourcekey="lblStatusResource1"></asp:Label>
                                            <asp:GridView ID="grdResult" runat="server" AllowPaging="True" PagerSettings-Mode="Numeric"
                                                AutoGenerateColumns="False"
                                                CellPadding="4" CssClass="mytable1 w-100p gridView" ForeColor="#333333" OnPageIndexChanging="grdResult_PageIndexChanging"
                                                DataKeyNames="TemplateID,ReportTemplateName" OnRowCommand="grdResult_RowCommand"
                                                OnRowDataBound="grdResult_RowDataBound" 
                                                meta:resourcekey="grdResultResource1" >
                                                <HeaderStyle CssClass="dataheader1" />
                                                <RowStyle Font-Bold="False" />
                                                <Columns>
                                                    <asp:BoundField DataField="TemplateID" HeaderText="Template ID" Visible="False" 
                                                        meta:resourcekey="BoundFieldResource1"/>
                                                    <asp:TemplateField HeaderText="Template Name" 
                                                        meta:resourcekey="TemplateFieldResource1">
                                                        <ItemStyle HorizontalAlign="left" Width="30px" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtTemplateNameD" width="500px" MaxLength="255" 
                                                            Text='<%# Bind("ReportTemplateName") %>' runat="server" 
                                                                meta:resourcekey="txtTemplateNameDResource1"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Path" HeaderStyle-HorizontalAlign="Center" 
                                                        meta:resourcekey="TemplateFieldResource2">

<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                                                        <ItemStyle HorizontalAlign="Center" Width="30px" />
                                                        <ItemTemplate>
                                                            <a id="aBrowseD" runat="server" onclick="ShowPopUp(this.id);" 
                                                                title="Click here to Browse Report Template Path" 
                                                                style="text-align: center;display: block; font-size:large;cursor: pointer;"><B><img style="text-align:center;" src="../Images/SearchIcon.PNG" /></B></a>
                                                            <asp:HiddenField ID="hdnTemplateID" Value='<%# Bind("TemplateID") %>' runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="IsDefault" 
                                                        meta:resourcekey="TemplateFieldResource3">
                                                        <ItemStyle HorizontalAlign="Center" Width="50px"/>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkIsDefaultD" runat="server" 
                                                                meta:resourcekey="chkIsDefaultDResource1"/>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="IsActive" 
                                                        meta:resourcekey="TemplateFieldResource4">
                                                        <ItemStyle HorizontalAlign="Center" Width="50px"/>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkIsActive" runat="server" 
                                                                meta:resourcekey="chkIsActiveResource1"/>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center">
                                            <asp:Button ID="btnSave" ToolTip="Click here to Save Report Template" Style="cursor: pointer;"
                                                runat="server" 
                                                Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" 
                                                Width="58px" onclick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                        </td>
                                    </tr>
                                </table>
                                <asp:HiddenField ID="hdnChkControls" runat="server" />
                                <asp:HiddenField ID="hdnRptPathControl" runat="server" />
                                <asp:HiddenField ID="hdnClikedValue" runat="server" />
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <ajc:ModalPopupExtender ID="mpeRoomType" runat="server" BackgroundCssClass="modalBackground" 
            CancelControlID="btnpopClose" DynamicServicePath="" Enabled="True" PopupControlID="pnlLocation"
            TargetControlID="btnDummy">
        </ajc:ModalPopupExtender>
        <input id="btnDummy" runat="server" style="display: none;" type="button"></input>
        <asp:Panel ID="pnlLocation" Width="1000px" Height="450px" runat="server" 
        CssClass="modalPopup dataheaderPopup" Style="display: none" 
        meta:resourcekey="pnlLocationResource1">
      
            <table class="a-center w-90p">
                <tr>
                    <td class="a-center a-right">
                        <table class="a-right">
                            <tr>
                                <td class="a-left">
                                    <%--<input id="btnapply" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                        type="button" value="Apply" onclick="SetSelectedPath()" runat="server"/>--%>
                                        <button  id="btnapply" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                        onclick="return SetSelectedPath()" runat="server">
<%=Resources.Admin_ClientDisplay.Admin_ReportTemplate_aspx_01 %></button>
                                </td>
                                <td class="a-left">
                                    <%--<input id="btnpopClose" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                        type="button" value="Close" />--%>
                                        <button id="btnpopClose" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" ><%=Resources.Admin_ClientDisplay.Admin_ReportTemplate_aspx_02 %></button>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                                                            <div style="height:350px; overflow:auto;">
<%--                                                                <div style="display: inline">
                            <asp:TreeView ID="tvCatalog" runat="server" ImageSet="XPFileExplorer" 
                                BorderWidth="2" BorderStyle="Inset"
                                NodeIndent="15" >
                                <ParentNodeStyle Font-Bold="False" />
                                <HoverNodeStyle Font-Underline="True" ForeColor="#6666AA" />
                                <SelectedNodeStyle BackColor="#B5B5B5" Font-Underline="False" HorizontalPadding="0px"
                                    VerticalPadding="0px" />
                                <NodeStyle ForeColor="Black" HorizontalPadding="2px"
                                    NodeSpacing="0px" VerticalPadding="2px" />
                            </asp:TreeView>
                        </div>--%>
                        <ucRTM:ReportTemplateMaster ID="RT1" runat="server" />
                                                                </div>
                    </td>
                </tr>
                <%--<tr>
                    <td align="center">
                        <table>
                            <tr>
                                <td align="left">
                                    <input id="btnapply" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                        type="button" value="Apply" onclick="SetSelectedPath()" runat="server"/>
                                </td>
                                <td align="left">
                                    <input id="btnpopClose" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                        type="button" value="Close" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>--%>
            </table>
        </asp:Panel>
                    </div>
                
         <Attune:Attunefooter ID="Attunefooter" runat="server" />     
    </form>
</body>
</html>
