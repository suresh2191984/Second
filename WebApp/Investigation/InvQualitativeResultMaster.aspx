<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvQualitativeResultMaster.aspx.cs" Inherits="Investigation_InvQualitativeResultMaster" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/OrderedSamples.ascx" TagName="OrderedSamples"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Investigation Result Name</title>
    <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <style type="text/css">
        .style8
        {
            width: 178px;
        }
        .style9
        {
            width: 109px;
        }
    </style>
    
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript" language="javascript">
    function pageLoad() {
        document.getElementById('txtInvQualita').focus();
        
        
    }
    function sampleValidation() {

        if (document.getElementById('txtInvQualita').value.trim() == '') {
            alert('Provide Method Name');
            document.getElementById('txtInvQualita').focus();
            return false;
        }
        
    }

    function Cancel() {

        document.getElementById('txtInvQualita').value = '';
        document.getElementById('txtInvQualita').focus();
    return false;

    }
    function grdRefphyClick() {
        if (document.getElementById('chkReferingphysician').checked == true) {
            document.getElementById('grdResults').style.display = 'none';
            document.getElementById('grdRefResults').style.display = 'block';
            document.getElementById('tdRefadd').style.display = 'block';
            document.getElementById('lblRe').value = '';
        }
        else {
            document.getElementById('grdResults').style.display = 'block';
            document.getElementById('grdRefResults').style.display = 'none';
            document.getElementById('tdRefadd').style.display = 'none';
        }
     
    }

//    function Onedit() {

//        document.getElementById('txtPhysicianName').value = '';
//        document.getElementById('txtQulification').value = '';
//        document.getElementById('txtPhysicianName').focus();
//        return false;

//    }
    </script>
</head>
<body  onload="pageLoad();" oncontextmenu="return false;">
    <form id="form1" runat="server" >
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <%--<img alt="" src="<%=LogoPath%>" class="logostyle" />--%>
                </div>
            </div>
            <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <%--<uc3:PatientHeader ID="patientHeader" runat="server" />--%>
                <uc6:UserHeader ID="UserHeader1" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay2" runat="server" />
                            </li>
                        </ul>
                      <asp:UpdatePanel ID="updatePanel2" runat="server">
                       <ContentTemplate>
                       <%--<table style="width:100%" ALIGN="center">
                    <tr>
                        <td>
                            <UcInv:InvQRM ID="InvQRM" runat="server" />
                        </td>
                    </tr>
                    </table>--%>
                        <table style="width:60%" ALIGN="center">
                    <tr>
                        <td class="style9">
                            Method Name:
                        </td>
                        <td class="style8" >
                            <asp:TextBox ID="txtInvQualita" runat="server" ToolTip="Enter InvQualitativeResult Name" CssClass="Txtboxsmall"> </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:Button ID="btnSave" runat="server" CssClass="btn" OnClick="btnSave_Click" 
                             OnClientClick="return sampleValidation();"   Text=" Save " Width="50px" />
                            <asp:Button ID="btnCanecl" runat="server" CssClass="btn" 
                              OnClientClick="return Cancel();" Text=" Cancel " Width="50px" />
                        </td>
                    </tr>
                    <tr>
                            <td colspan="2">
                                <asp:GridView ID="grdInv" Width="100%"  runat="server" 
                                    AllowPaging="True" CellPadding="4"
                                    AutoGenerateColumns="False" 
                                    DataKeyNames="QualitativeResultId ,QualitativeResultName" 
                                    OnRowDataBound="grdInv_RowDataBound" onrowcancelingedit="grdInv_RowCancelling"
                                    ForeColor="#333333" 
                                    OnRowDeleting="grdInv_RowDeleting" onrowediting="grdInv_RowEditing"
                                    CssClass="mytable1" 
                                    OnRowCommand="grdInv_RowCommand" onrowupdating="grdInv_RowUpdating"
                                    OnPageIndexChanging="grdInv_PageIndexChanging" >
                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                        PageButtonCount="5" PreviousPageText="" />
                                    <PagerStyle HorizontalAlign="Center" BackColor="White" ForeColor="Red" />
                                    <Columns>
                                    <asp:TemplateField HeaderText="QualitativeResultId" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblId" runat="server" Visible="false" Text='<%#bind("QualitativeResultId")%>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Qualitative Result Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblQualitativeResultName" runat="server" Text='<%#bind("QualitativeResultName")%>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtQualitativeResultName" runat="server" Width="300" Text='<%#Eval("QualitativeResultName")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                          <asp:LinkButton ID="lnkDelete" runat="server" 
                                          CommandName="DELETE" ForeColor="#990000" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                          Font-Size="12px">DELETE</asp:LinkButton>&nbsp;||&nbsp;
                                          <asp:LinkButton ID="LnkEdit" ForeColor="#0000FF" runat="server" CommandName="EDIT"
                                          CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'>EDIT</asp:LinkButton>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:LinkButton ID="btnUpdate" Text="UPDATE" ForeColor="#990000" runat="server" CommandName="UPDATE"
                                        CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' />
                                        &nbsp;||&nbsp;
                                        <asp:LinkButton ID="btnCancel" Text="CANCEL" ForeColor="#0000FF" runat="server" CommandName="CANCEL" />
                                    </EditItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                <HeaderStyle Font-Size="Small" ForeColor="#FFFFFF" CssClass="grdcolor" Font-Bold="True" />
                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                <RowStyle ForeColor="#000066" />
                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                </asp:GridView>
                                <asp:Label ID="lblMsg" runat="server"></asp:Label>
                                <asp:Label ID="lblLoginNam" runat="server"></asp:Label>
                            </td>
                        </tr>
                    
                </table>
                        
                           <caption>
                               <br />
                           </caption>
                      </ContentTemplate>
                        </asp:UpdatePanel>  
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>

    

    </form>
</body>
</html>
