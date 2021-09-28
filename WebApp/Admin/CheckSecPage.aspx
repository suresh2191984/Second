<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CheckSecPage.aspx.cs" Inherits="Admin_CheckSecPage"
    meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/SecPrescriptionPage.ascx" TagName="ucSecPage"
    TagPrefix="uc6" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="../Scripts/animatedcollapse.js"></script>

    <script language="javascript" type="text/javascript">

        //        animatedcollapse.addDiv('Sec', 'fade=1,height=1%');
        //        animatedcollapse.init();

        function ChangeSecImage() {
            //if (Number(document.getElementById('hdnCount').value) > 0) {
            //                animatedcollapse.toggle('Sec');
            //                if (document.getElementById('imgSec').src.split('Images')[1] == '/collapse.jpg')
            //                    document.getElementById('imgSec').src = '../Images/expand.jpg';
            //                else if (document.getElementById('imgSec').src.split('Images')[1] == '/expand.jpg')
            //                    document.getElementById('imgSec').src = '../Images/collapse.jpg';
            //}
            //else {
            //alert('Invalid Patient');
            //}
        }

        function ValidateCode() {
            if (document.getElementById('txtSecCode').value == '') {
                var userMsg = SListForApplicationMessages.Get("Admin\\CheckSecPage.aspx_2");
          if (userMsg != null) {
              alert(userMsg);
              return false;
          }
          else {
              alert('Provide the secured code');
              return false;
          }
                document.getElementById('txtSecCode').focus();
                return false;
            }
            return true;
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                       
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <div class="dataheader2">
                                    <table class="w-50p searchPanel">
                                        <tr>
                                            <td class="w-40p paddingT10">
                                                <asp:Label ID="Rs_TypetheSecuredCodebelow" Text="Type the Secured Code below" runat="server"
                                                    meta:resourcekey="Rs_TypetheSecuredCodebelowResource1"></asp:Label>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="txtSecCode"  CssClass="Txtboxlarge" runat="server" meta:resourcekey="txtSecCodeResource1"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Button ID="btnSearch" Text="Search" OnClientClick="return ValidateCode()" runat="server"
                                                    CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                    OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblMessage" Font-Bold="True" runat="server" meta:resourcekey="lblMessageResource1"></asp:Label>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Panel ID="Panel2" runat="server" CssClass="collapsePanelHeader h-30"
                                                    meta:resourcekey="Panel2Resource1">
                                                    <div class="pointer v-middle">
                                                        <div style="float: left; margin-left: 20px;">
                                                            <asp:Label ID="Label1" runat="server" meta:resourcekey="Label1Resource1" Text="(View Details...)"></asp:Label>&nbsp;<asp:ImageButton
                                                                ID="Image1" OnClientClick="ChangeSecImage();" runat="server" ImageUrl="../Images/collapse.jpg"
                                                                AlternateText="(Click to View Details...)" meta:resourcekey="Image1Resource1" />
                                                        </div>
                                                        <div class="v-middle" style="float: right;">
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                </div>
                                <br />
                                <table class="w-90p">
                                    <tr>
                                        <td>
                                            <asp:Panel ID="Panel1" runat="server" CssClass="collapsePanel" Height="0px" meta:resourcekey="Panel1Resource1">
                                                <uc6:ucSecPage ID="UcSecPage1" runat="server" />
                                            </asp:Panel>
                                            <ajc:CollapsiblePanelExtender ID="cpeDemo" runat="server" TargetControlID="Panel1"
                                                ExpandControlID="Panel2" CollapseControlID="Panel2" Collapsed="True" TextLabelID="Label1"
                                                ImageControlID="Image1" ExpandedText="(Click to Hide Details...)" CollapsedText="(Click to View Details...)"
                                                ExpandedImage="../Images/collapse.jpg" CollapsedImage="../Images/expand.jpg"
                                                SuppressPostBack="True" SkinID="CollapsiblePanelDemo" Enabled="True" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
               
       <Attune:Attunefooter ID="Attunefooter" runat="server" />
        <asp:HiddenField ID="hdnCount" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
