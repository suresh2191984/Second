<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PerformingPhysician.aspx.cs" Inherits="Physician_PerformingPhysician" %>
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
    <title>Performing Physician</title>
    <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <style type="text/css">
        .style7
        {
            width: 110px;
        }
        .style8
        {
            width: 178px;
        }
    </style>
    <script type="text/javascript" language="javascript">
    function pageLoad() {
        document.getElementById('txtPhysicianName').focus();
        document.getElementById('grdResults').style.display = 'block';
        document.getElementById('grdRefResults').style.display = 'none';
    }
    function sampleValidation() {

        if (document.getElementById('txtPhysicianName').value.trim() == '') {
            alert('Provide PhysicianName name');
            document.getElementById('txtPhysicianName').focus();
            return false;
        }
        if (document.getElementById('txtQulification').value.trim() == '') {
            alert('Provide Qulification name');
            document.getElementById('txtQulification').focus();
            return false;
        }
    }

    function Cancel() {
    
    document.getElementById('txtPhysicianName').value = '';
    document.getElementById('txtQulification').value = '';
    document.getElementById('txtPhysicianName').focus();
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
    <form id="form1" runat="server" defaultbutton="btnSave">
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
                        <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                        <tr>
                            <td>
                            <table width="85%"  align="center">
                            <tr style="height: 25px;">
                                <td colspan="3">
                                  <asp:Label ID="lblRe" Text="" runat="server" ForeColor="Red"></asp:Label>
                                </td>
                            </tr>
                            <tr style="height: 25px;">
                                <td class="style7" >
                                    Physician Name:<asp:Label ID="lblPhId" runat="server" Visible="false" Text="" ></asp:Label>
                                </td>
                                <td class="style8" >
                                    <asp:TextBox ID="txtPhysicianName" runat="server" 
                                    ToolTip="Enter Physician Name" Width="195px"  ></asp:TextBox>
                                </td>
                                <td>
                                </td>
                             </tr>
                             <tr style="height: 25px;">
                                <td class="style7" >
                                    Qulification:
                                </td>
                                <td class="style8" >
                                    <asp:TextBox ID="txtQulification" runat="server" ToolTip="Enter Qulification Name" > </asp:TextBox>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr style="height: 25px;">
                                <td class="style7">
                                    
                                </td>
                                <td class="style8" >
                                    <asp:Button ID="btnSave" runat="server" Text=" Save " ToolTip="Click here to Save"
                                     OnClientClick="return sampleValidation();" OnClick="btnSave_Click" CssClass="btn" />
                                     <asp:Button ID="btnCanecl" runat="server" Text=" Cancel " ToolTip="Click here to Cancel"
                                     OnClientClick="return Cancel();" CssClass="btn" />
                                </td>
                                <td align="right">
                                 <asp:CheckBox ID="chkReferingphysician" runat="server" Text=" REFERING PHYSICIAN" 
                                 Font-Bold="true" ForeColor="#990000" onclick="javascript:grdRefphyClick(this);" />
                                </td>
                            </tr>
                            
                            <tr>
                            <td colspan="3" style="display:none" id="grdResults" >
                                <asp:GridView ID="grdResult" Width="100%"  runat="server" AllowPaging="True" CellPadding="4"
                                    AutoGenerateColumns="False" 
                                    DataKeyNames="performingPhysicianID,physicianName,qualification,status" 
                                    OnRowDataBound="grdResult_RowDataBound" onrowcancelingedit="grdResult_RowCancelling"
                                    ForeColor="#333333" OnRowDeleting="grdResult_RowDeleting" onrowediting="grdResult_RowEditing"
                                    CssClass="mytable1" OnRowCommand="grdResult_RowCommand" onrowupdating="grdResult_RowUpdating"
                                    OnPageIndexChanging="grdResult_PageIndexChanging" >
                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                        PageButtonCount="5" PreviousPageText="" />
                                    <PagerStyle HorizontalAlign="Center" BackColor="White" ForeColor="Red" />
                                    <Columns>
                                    <asp:TemplateField HeaderText="Performing PhysicianID" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblId" runat="server" Visible="false" Text='<%#bind("performingPhysicianID")%>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Physician Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblphysicianName" runat="server" Text='<%#bind("physicianName")%>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtphysicianName" runat="server" Text='<%#Eval("physicianName")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Qualification">
                                    <ItemTemplate>
                                        <asp:Label ID="lblqualification" runat="server" Text='<%#Eval("Qualification")%>'> 
                                        </asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtPhyQul" runat="server" Text='<%#bind("Qualification")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <asp:Label ID="lblstatus" runat="server" Text='<%#bind("Status")%>'> 
                                        </asp:Label>
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <%-- <input id="btnEdit" value="Edit" type="button" cname='<%#Eval("physicianName") %>'
                                          cid='<%#Eval("performingPhysicianID") %>' camount='<%#Eval("Qualification") %>' cdays='<%#Eval("Status") %>'
                                          style='background-color: Transparent;
                                          color: Red; border-style: none; cursor: pointer' size="3" />
                                          &#160;--%>
                                          
                                          <%--<asp:ImageButton ID="imgDelete" runat="server" ToolTip="Delete Physician" 
                                          CommandName="DELETE" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' ImageUrl="~/Images/delete.png" ButtonType="Link"/>--%>
                                          <asp:LinkButton ID="lnkDelete" runat="server" 
                                          CommandName="DELETE" ForeColor="#990000" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                          Font-Size="12px">DELETE</asp:LinkButton>&nbsp;||&nbsp;
                                          <asp:LinkButton ID="LinActive" runat="server" CommandName="ACTIVE" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                          ForeColor="Red" Font-Size="12px"> 
                                          ACTIVE</asp:LinkButton>
                                          <%--<asp:ImageButton ID="imgActive" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                          CommandName="ACTIVE" ImageUrl="~/Images/active.png"  ToolTip="Active Physician" />--%>
                                          <%--<asp:LinkButton ID="LinActive" ForeColor="#00C000" runat="server"
                                           CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' CommandName="ACTIVE">ACTIVE</asp:LinkButton>--%>
                                           &nbsp;||&nbsp;
                                           <%--<asp:ImageButton ID="ImgEdit" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                          CommandName="EDIT" ImageUrl="~/Images/edit.png"  ToolTip="Edit Physician"  />--%>
                                           <asp:LinkButton ID="LnkEdit" ForeColor="#0000FF" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                           runat="server" Text="EDIT" CommandName="EDIT"></asp:LinkButton>
                                         <%-- <asp:LinkButton ID="LnkEdit" ForeColor="#0000FF" runat="server" CommandName="EDIT"
                                          >EDIT</asp:LinkButton> --%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <%--<asp:ImageButton ID="ImgUpdatet" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                          CommandName="UPDATE" ImageUrl="~/Images/update.png"  ToolTip="Update Physician"  />--%>
                                        <asp:LinkButton ID="btnUpdate" Text="UPDATE" ForeColor="#990000" runat="server" 
                                        CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' CommandName="UPDATE" />
                                        &nbsp;||&nbsp;
                                        <%--<asp:ImageButton ID="ImgCancel" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                          CommandName="CANCEL" ImageUrl="~/Images/delete.png"  ToolTip="Cancl"  />--%>
                                        <asp:LinkButton ID="btnCancel" Text="CANCEL" ForeColor="#0000FF" 
                                        CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' runat="server" CommandName="CANCEL" />
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
                        <tr>
                            <td colspan="3" style="display:none" id="grdRefResults" >
                             <asp:GridView ID="grdRefphy" Width="100%" runat="server" AllowPaging="True" CellPadding="4"
                                AutoGenerateColumns="False"  ForeColor="#333333" PageSize="50"
                                DataKeyNames="referingPhysicianID,physicianName,qualification"
                                 GridLines="Both" CssClass="mytable1" OnPageIndexChanging="grdRefphy_PageIndexChanging">
                                <%--<PagerTemplate>
                                    <tr>PageSize="10"PagerSettings-Mode="NextPrevious"
                                        <td colspan="6" align="center">
                                            <asp:ImageButton ID="lnkPrev" CommandName="Page" runat="server" CausesValidation="false"
                                                CommandArgument="Prev" ImageUrl="~/Images/previousimage.png" Width="18px" Height="18px" />
                                            <asp:ImageButton ID="lnkNext" CommandName="Page" runat="server" CausesValidation="false"
                                                CommandArgument="Next" ImageUrl="~/Images/nextimage.png" Width="18px" Height="18px" />
                                        </td>
                                    </tr>
                                </PagerTemplate>--%>
                                <HeaderStyle CssClass="dataheader1" />
                                <Columns>
                                <asp:TemplateField HeaderText="Select">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelect" runat="server" align="Center"/>
                                </ItemTemplate>
                                </asp:TemplateField>
                                    <asp:BoundField DataField="referingPhysicianID" Visible="false" HeaderText="Refering PhysicianID" 
                                        />
                                    <asp:BoundField DataField="physicianName" Visible="true" HeaderText="Physician Name"
                                        />
                                    <asp:BoundField DataField="qualification" Visible="true" HeaderText="Qualification" 
                                        />
                                </Columns>
                            </asp:GridView>
                            <asp:HiddenField ID="hdnSaveRefPhy" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="display:none" id="tdRefadd" align="center">
                                <asp:Button ID="btnAdd" runat="server" Text=" ADD " ToolTip="Click here to ADD"
                                 CssClass="btn" onclick="btnAdd_Click" />
                            </td>
                        </tr>
                        
                        </table>
                            </td>
                        </tr>
                        </table>
                        
                        <br />
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

  