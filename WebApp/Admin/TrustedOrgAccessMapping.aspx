<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TrustedOrgAccessMapping.aspx.cs"
    Inherits="Admin_TrustedOrgAccessMapping" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head2" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Trusted Org Access Mapping Page</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />

 <script type="text/javascript">
     function OnTreeClick(evt) {
         var src = window.event != window.undefined ? window.event.srcElement : evt.target;
         var isChkBoxClick = (src.tagName.toLowerCase() == "input" && src.type == "checkbox");
         if (isChkBoxClick) {
             var parentTable = GetParentByTagName("table", src);
             var nxtSibling = parentTable.nextSibling;
             if (nxtSibling && nxtSibling.nodeType == 1)//check if nxt sibling is not null & is an element node
             {
                 if (nxtSibling.tagName.toLowerCase() == "div") //if node has children
                 {
                     //check or uncheck children at all levels
                     CheckUncheckChildren(parentTable.nextSibling, src.checked);
                 }
             }
             //check or uncheck parents at all levels

             CheckUncheckParents(src, src.checked);
         }
     }     
     
    </script>
</head>
<body>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
      <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                       
                        <table class="w-100p searchPanel">
                            <tr>
                                <td>
                                    <table class="w-100p">
                                    <tr>
                                    <td class="w-100p">
                                     <asp:Panel ID="Panel3" CssClass="dataheader2 defaultfontcolor" BorderWidth="1px" 
                                            runat="server" meta:resourcekey="Panel3Resource1">
                                    <table  class="w-100p">
                                       <tr>
                                            <td class="a-right">
                                                <asp:Label ID="Label1" Text="Select Org to Share:" runat="server" 
                                                    meta:resourceKey="Label1Resource1"></asp:Label>
                                                &nbsp;
                                            </td>
                                            <td class="a-left">
                                                <asp:DropDownList ID="ddlSharedOrg" CssClass ="ddlsmall" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                            <td class="a-right">
                                                <asp:Label ID="Label2" Text="Select Action Group to Share:" runat="server" 
                                                    meta:resourceKey="Label2Resource1"></asp:Label>
                                                &nbsp;
                                            </td>
                                            <td class="a-left">
                                                <asp:Panel ID="Panel2" runat="server" meta:resourceKey="Panel2Resource1">
                                                    <asp:CheckBoxList ID="chkActionMaster" runat="server" RepeatColumns="5" AutoPostBack="True"
                                                   
                                                     OnSelectedIndexChanged="chkActionMaster_SelectedIndexChanged"  
                                                        RepeatDirection="Horizontal" meta:resourceKey="chkActionMasterResource1"> 
                                                    </asp:CheckBoxList>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                    </table>
                                     </asp:Panel>
                                    </td>
                                    </tr>
                                       
                                        <tr>
                                            <td colspan="3"  class="defaultfontcolor">
                                            <asp:Panel ID="PnTreeView" CssClass="defaultfontcolor" BorderWidth="1px" 
                                                    runat="server" style="display:none;" meta:resourcekey="PnTreeViewResource1" >
                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                    <ContentTemplate>
                                                        <asp:TreeView ID="tvTrustedItems" runat="server" ShowCheckBoxes="All" EnableTheming="True"
                                                            ExpandDepth="0" style="color:Black;" ForeColor="Black" 
                                                            meta:resourcekey="tvTrustedItemsResource1">
                                                              <RootNodeStyle ImageUrl="~/Images/blockdevice-grp.png" Font-Size="Medium" />
                                                             <ParentNodeStyle ImageUrl="~/Images/settings.png" Font-Size="Larger" />
                                                             <LeafNodeStyle ImageUrl="~/Images/RoleImage.png"  Font-Size="Small"/>
                                                             
                                                             
                                                        </asp:TreeView>
                                                         
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                        <td colspan="3"  class="defaultfontcolor a-center">
                                        <asp:Button ID="btnSave" runat="server" CssClass="btn" Text="Save" style="display:none;"
                                         onclick="btnSave_Click" OnClientClick="return ValidateValues();" 
                                                meta:resourcekey="btnSaveResource1" />
                                             <asp:Label ID="IDSuccessMesg" runat="server" Text="Successfully Mapped.!" 
                                                style="display:none;" meta:resourcekey="IDSuccessMesgResource1"></asp:Label> 
                                              <asp:Label ID="IDNullMesg" runat="server" Text="No Matching Record Found.!" 
                                                style="display:none;" meta:resourcekey="IDNullMesgResource1"></asp:Label>
                                        </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
      <Attune:Attunefooter ID="Attunefooter" runat="server" />         
    </form>
</body>
</html> 
 
 <script type="text/javascript">

     function ValidateValues() {
         var objUmap = SListForAppMsg.Get("Admin_TrustedOrgAccessMapping_aspx_01") == null ? "Do You want to Unmap all Action items" : SListForAppMsg.Get("Admin_TrustedOrgAccessMapping_aspx_01");

         var treeView = document.getElementById("<%= tvTrustedItems.ClientID %>");
         var checkBoxes = treeView.getElementsByTagName("input");
         var checkedCount = 0;
         for (var i = 0; i < checkBoxes.length; i++) {
             if (checkBoxes[i].checked) {
                 checkedCount++;
             }
         }
         if (checkedCount >0) {
             return true;
         } else {
         if (confirm(objUmap)) { return true; } else { return false; }
         
         }
     }        

</script>

