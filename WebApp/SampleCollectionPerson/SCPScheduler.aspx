<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SCPScheduler.aspx.cs" Inherits="SampleCollectionPerson_SCPScheduler" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="~/SampleCollectionPerson/Controls/SPschedule.ascx" TagName="Schd" TagPrefix="SPschedule" %>
<%@ Register Src="~/CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"  TagPrefix="Attune" %>
<%@ Register Src="~/CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
    

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>SCP Master Scheduler</title>
    <script src="../../Scripts/Common.js" type="text/javascript"></script>
       <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
   <link href="../PlatForm/StyleSheets/jquery-ui.css" rel ="Stylesheet" type ="text/css" />
   <%-- <script src="js/validate.js" type="text/javascript"></script>--%>
<%--   <script src="js/auto.js"
       type="text/javascript"></script>--%>
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
      <SPschedule:Schd ID="spSchd" runat="server" />
     
      </ContentTemplate>
      </asp:UpdatePanel>
      </div>
         <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </div>
    </form>
</body>
</html>

