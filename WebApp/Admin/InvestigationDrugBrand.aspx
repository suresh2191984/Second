<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigationDrugBrand.aspx.cs"
    Inherits="Admin_InvestigationDrugBrand" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>
        <%=Resources.Admin_ClientDisplay.Admin_InvestigationDrugBrand_aspx_01 %>
    </title>
 
    <script type="text/javascript">
        function validate1() {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_InvestigationDrugBrand_aspx_01") != null ? SListForAppMsg.Get("Admin_InvestigationDrugBrand_aspx_01") : "Provide DrugName.!";
            var txt = document.getElementById('txtSearch').value;
            if (txt == '') {
                // alert("Provide DrugName.!");
                ValidationWindow(userMsg, AlrtWinHdr);
                document.getElementById('txtSearch').focus();
                return false;
            }
        }

        function validate2() {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_InvestigationDrugBrand_aspx_01") != null ? SListForAppMsg.Get("Admin_InvestigationDrugBrand_aspx_01") : "Provide DrugName.!";
            var txt = document.getElementById('txtDrugName').value;
            if (txt == '') {
                //                alert("Provide DrugName.!");
                ValidationWindow(userMsg, AlrtWinHdr);
                document.getElementById('txtDrugName').focus();
                return false;
            }
        }    
                
        function pageLoadFocus(focusID) {
            if (document.getElementById(focusID).value == '') {
                document.getElementById(focusID).focus();
            }
        }        
    </script>
    <style type="text/css">
        .btn
        {
            height: 26px;
        }
    </style>
</head>
<body onload="pageLoadFocus('txtSearch');">
    <form id="ivgdrug" runat="server">
    <asp:ScriptManager id="scriptmanager1" runat="server"></asp:ScriptManager>
     <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                 <table class="a-center w-100p searchPanel">
                                    <tr>
                                        <td class="h-32">
                                            <table id="mytable1" class="w-100p">
                                                <tr>
                                                    <td class="a-center" style="font-size:small;color:Blue">
                                                        <asp:Label ID="lblstatus" runat="server" meta:resourcekey="lblstatusResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                             </table>
                                         </td>
                                     </tr>
                                     <tr>
                                        <td>
                            <asp:Panel ID="pnlSearch" runat="server" BorderWidth="1px" CssClass="dataheader2"
                                meta:resourcekey="pnlSearchResource1">
                                                <table class="w-100p bg-row">
                                                    <tr>
                                                       <td class="a-right w-34p">
                                            <asp:Label ID="lblSearch" runat="server" Text="Enter To Search Drug Name" meta:resourcekey="lblSearchResource1"></asp:Label>
                                                        </td>
                                                        <td class="w-25p">
                                            <asp:TextBox ID="txtSearch" runat="server" CssClass="Txtboxlarge" meta:resourcekey="txtSearchResource1"></asp:TextBox>
                                                        </td>
                                                        <td class="w-5p">
                                            <asp:RadioButton ID="rdoCode" runat="server" Text="Code" GroupName="Type" meta:resourcekey="rdoCodeResource1" />
                                                        </td>
                                                        <td class="w-5p">
                                            <asp:RadioButton ID="rdoName" runat="server" Text="Name" GroupName="Type" meta:resourcekey="rdoNameResource1" />
                                                        </td>
                                                        <td class="w-65p">
                                            <asp:Button ID="btnSearch" runat="server" Text="Search" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" CssClass="btn" OnClientClick="return validate1();"
                                                OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                     </tr>                                                                             
                                         <tr>
                                             <td>
                                                 <asp:HiddenField ID="hdnDrugID" runat="server" />
                                                
                                                 <asp:Panel ID="pnlEnter" runat="server" 
                                                     CssClass="dataheader2" meta:resourcekey="pnlEnterResource1">
                                                     <table class="w-100p">
                                                         <tr>
                                                             <td class="padding3">
                                                                 <table class="w-100p">
                                                                     <tr>
                                                                         <td class="a-right w-30p">
                                                        <asp:Label ID="DrugName" runat="server" meta:resourcekey="DrugNameResource1" Text="Enter Drug Name"></asp:Label>
                                                                         </td>
                                                                         <td class="w-44p">
                                                        <asp:TextBox ID="txtDrugName" runat="server" AutoComplete="off" meta:resourcekey="txtDrugNameResource1"
                                                            CssClass="Txtboxlarge"></asp:TextBox>
                                                        <asp:Label ID="lblDrugCode" runat="server" Text="Enter Drug Code" meta:resourcekey="lblDrugCodeResource1"></asp:Label>
                                                        <asp:TextBox ID="txtDrugCode" runat="server" AutoComplete="off" CssClass="Txtboxsmall"
                                                            meta:resourcekey="txtDrugCodeResource1"></asp:TextBox>
                                                                         </td>
                                                                          <td class="a-left" colspan="2">
                                                        <asp:Button ID="btnSave" runat="server" CssClass="btn" meta:resourcekey="btnSaveResource1"
                                                            OnClick="btnSave_Click" OnClientClick="return validate2();" onmouseout="this.className='btn'"
                                                            onmouseover="this.className='btn btnhov'" Text="Save" ToolTip="Click Here to Save DrugName" />
                                                                             &nbsp;
                                                        <asp:Button ID="btnCancel" runat="server" CssClass="btn" meta:resourcekey="btnCancelResource2"
                                                            OnClick="btnCancel_Click" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                            Text="Cancel" ToolTip="Click Clear The Text" />
                                                                             &nbsp;
                                                        <asp:Button ID="btnRefresh" runat="server" CssClass="btn" meta:resourcekey="btnRefreshResource1"
                                                            OnClick="btnRefresh_Click" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                            Text="Refresh" ToolTip="Click Here To Refresh" />
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
                                              <asp:GridView ID="grdView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                CellPadding="4" CssClass="mytab1e w-70p gridView m-auto" DataKeyNames="DrugID,BrandName,Code"
                                ForeColor="#333333" meta:resourcekey="grdViewResource1" OnPageIndexChanging="grdView_PageIndexChanging"
                                OnRowCommand="grdView_RowCommand" OnRowDataBound="grdView_RowDataBound" PageSize="100">
                                <PagerTemplate>
                                    <tr>
                                    </tr>
                                </PagerTemplate>
                                <HeaderStyle CssClass="dataheader1" />
                                <RowStyle Font-Bold="False" />
                                <PagerSettings Mode="NextPrevious" />
                                <Columns>
                                    <asp:BoundField DataField="DrugID" HeaderText="DrugID" meta:resourcekey="BoundFieldResource1"
                                        Visible="false">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Left" Width="250px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Code" HeaderText="Drug Code" meta:resourcekey="BoundFieldResource3" />
                                    <asp:BoundField DataField="BrandName" HeaderText="DrugBrand Name" meta:resourcekey="BoundFieldResource2">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                </Columns>
                                <SelectedRowStyle ForeColor="#000066" />
                            </asp:GridView>
                                             </td>
                                         </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                         </div>
       <Attune:Attunefooter ID="Attunefooter" runat="server" />               
    </form>
</body>
</html>
