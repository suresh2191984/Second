<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HCLocation.aspx.cs" Inherits="HomeCollection_HCLocation" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="~/HomeCollection/Controls/LiveLocation.ascx" TagName="LPart" TagPrefix="LiveLocation" %>
<%@ Register Src="~/CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
    <%@ Register Src="~/CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body >
    <form id="form1" runat="server">
      <asp:ScriptManager ID="ToolkitScriptManager1" runat="server">
        </asp:ScriptManager>
    <div id="wrapper">
       <Attune:Attuneheader ID="Attuneheader" runat="server" />
        <div class="contentdata">
            <asp:UpdatePanel ID="ll" runat="server">
                <ContentTemplate>
      <LiveLocation:LPart ID="LiveLoc" runat="server" />
      </ContentTemplate>
      </asp:UpdatePanel>
      </div>
         <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </div>
    </form>
</body>
</html>
