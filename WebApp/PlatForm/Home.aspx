<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Reception_Home" %>
<%@ Register Src="~/PlatFormControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
       <Services>
            <asp:ServiceReference Path="~/PlatForm/CommonWebServices/CommonServices.asmx" />          
        </Services>
    </asp:ScriptManager>
    <div>
        <Attune:Attuneheader ID="Attune_OrgHeader1" runat="server" />
        <uc6:taskcontrol id="UcTask" runat="server" />
        <ajc:ModalPopupExtender ID="mpExtender" runat="server" TargetControlID="Button2"
        PopupControlID="pContainer" BackgroundCssClass="modalBackground" Enabled="True"
        DropShadow="True" DynamicServicePath="" />
        <input type="button" id="Button2" runat="server" class="hide" />
        <asp:Panel ID="pContainer" runat="server" 
            CssClass="modalPopup Page-tableINVOICE1" meta:resourcekey="pContainerResource1">
            <%--<up:UpdateVisitPerformer ID="UpdateVisitPerformer" runat="server"></up:UpdateVisitPerformer>--%>
        </asp:Panel>
        <asp:Button runat="server" ID="btninvisible" OnClick="btninvisible_Click" CssClass="hide"/>
        <asp:HiddenField ID="hdnpid" runat="server" Value="0" />
        <asp:HiddenField ID="hdnvid" runat="server" Value="0" />
        <asp:HiddenField ID="hdntid" runat="server" Value="0" />
	<asp:HiddenField ID="hdnpackid" runat="server" Value="0" />
        <Attune:Attunefooter ID="Attune_Footer1" runat="server" />
    </div>
    <script type="text/javascript" >
     function CloseFrame() {           
            $find('mpExtender').hide();
            return false;
         }
      function OpenFrame(pid,vid,tid,Packid) {    
            $("#hdnpid").val(pid);
            $("#hdnvid").val(vid);
            $("#hdntid").val(tid);
	    $("#hdnpackid").val(Packid);
            $("#btninvisible").click();
            return false;
         }   
    </script>
    </form>
</body>
</html>
