<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LabMaster.aspx.cs" Inherits="Admin_LabMaster"
    EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/TestMaster.ascx" TagName="TM" TagPrefix="TM" %>
<%@ Register Src="~/CommonControls/AddInvestigation.ascx" TagName="AI" TagPrefix="AI" %>
<%@ Register Src="~/CommonControls/PatternMapping.ascx" TagName="PM" TagPrefix="PM" %>  
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%--<head >
  <title>My Page</title>
  <link href="css/common.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="<%# ResolveUrl("~/javascript/leesUtils.js") %>"></script>
</head>--%>
<head id="head1" runat="server">
    <title></title>

    <script type="text/javascript" src="../Scripts/jquery-1.8.1.min.js"></script>

    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>
      <script type="text/javascript" language="javascript">
          function hideHeader() {
              document.getElementById('header').style.display = 'none';
              document.getElementById('Attuneheader_menu').style.display = 'none';
              document.getElementById('imagetd').style.display = 'none';
              $("#navigation").addClass("classNav");
              document.getElementById('Attuneheader_TopHeader1_ImgBtnHome').style.display = 'none';

          }
      
      </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
            <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>

                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <ajc:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0" OnActiveTabChanged="TabContainer1_ActiveTabChanged"
                                                meta:resourcekey="TabContainer1Resource1">
                                <ajc:TabPanel runat="server" HeaderText="Test Master" ID="TabTestMaster" TabIndex="0"
                                    meta:resourcekey="TabTestMasterResource1" CssClass="dataheadergroup">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblTestMaster" runat="server" Text="Test Master" meta:resourcekey="lblTestMasterResource1"></asp:Label>
                                    </HeaderTemplate>
                                    <ContentTemplate>
                                        <TM:TM ID="TM" runat="server" />
                                    </ContentTemplate>
                                </ajc:TabPanel>
                                <ajc:TabPanel runat="server" HeaderText="Add Investigation" ID="TabAddInvestigation"
                                    TabIndex="1" CssClass="dataheadergroup">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblAddInvestigation" runat="server" Text="Add Investigation"></asp:Label>
                                    </HeaderTemplate>
                                    <ContentTemplate>
                                        <AI:AI ID="AI" runat="server" />
                                    </ContentTemplate>
                                </ajc:TabPanel>
                                <ajc:TabPanel runat="server" HeaderText="Pattern Mapping" ID="TabPanel2" TabIndex="2"
                                    CssClass="dataheadergroup">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblPatternMapping" runat="server" Text="Pattern Mapping"
                                        meta:resourcekey ="lblTestMasterResourcekey3"></asp:Label>
                                    </HeaderTemplate>
                                    <ContentTemplate>
                                        <PM:PM ID="PM" runat="server" />
                                    </ContentTemplate>
                                                </ajc:TabPanel>
                                            </ajc:TabContainer>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <asp:Image ID="imgLoadingbars" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgLoadingResource1" />
                                <asp:Label ID="Rs_Loading" Text="Loading..." runat="server" meta:resourcekey="Rs_LoadingResource1" />
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
            <Attune:Attunefooter ID="Attunefooter" runat="server" />       
            <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
