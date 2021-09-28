<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LocationPrinterMapping.aspx.cs"
    Inherits="Admin_LocationPrinterMapping" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>

<html xmlns="http://www.w3.org/1999/xhtml"><head id="head1" runat="server"><title>Location Printer Mapping</title><script src="../Scripts/Common.js" type="text/javascript"></script><script src="../Scripts/MessageHandler.js" type="text/javascript"></script><script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script><script type="text/javascript" src="../Scripts/bid.js"></script><script language="javascript" type="text/javascript">
        function validate() {
            try {
                var txtPrinterName = $.trim($("#txtPrinterName").val());
                var e = document.getElementById("ddltype2");
                var selectedLocation = e.options[e.selectedIndex].value;
               // alert(selectedLocation);
                var TxtDescription = $.trim($("#TxtDescription").val());
              var TxtPath = $.trim($("#TxtPath").val());
              if ((txtPrinterName == "") || (TxtDescription == "") || (TxtPath == "") || (selectedLocation == "--Select--")) {
                    alert('Enter the Values in the Corresponding controls and dropdown');
                    return false;
                }
            }
            catch (e) {
                return false;
            }
        }
        function GetTeamUsersByTeamID(selectedvalue) {

            alert(selectedvalue);
        }


        function ConfirmationBox(username) {

            var result = confirm('Are you sure you want to delete ' + username + ' Details');
            if (result) {

                return true;
            }
            else {
                return false;
            }
        }
        
        
        
        
        function clearValues() {
            try {
                $("#txtPrinterName").val('');
                $("#TxtDescription").val('');
                $("#TxtPath").val('');
                $("#hdnPrinterID").val('0');
                $("#hdnPrinterCode").val('0');
                $("#btnSave").val('Add');
                document.getElementById("chkActive").checked = false;
//                document.getElementById("LblFileName1").Visible = false;
//                document.getElementById("LblFileName").Visible = false;
                document.getElementById('<%=LblFileName1.ClientID%>').style.display = 'none';
                document.getElementById('<%=LblFileName.ClientID%>').style.display = 'none';
                return false;
            }
            catch (e) {
                return false;
            }
        }
    </script></head>
    <body>
    <form id="form1" runat="server">
    
          <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
      <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                               
                        <asp:UpdatePanel ID="UdtPanel" runat="server">
                            <ContentTemplate>
                           
                                    <table border="0" cellspacing="0" cellpadding="5" class="w-50p">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblPrinterName" runat="server" Text="Printer Name"></asp:Label>
                                            </td>
                                            <td width="30%" align="left">
                                                <asp:TextBox ID="txtPrinterName" runat="server" CssClass="Txtboxsmall" AutoComplete="off"></asp:TextBox>
                                                <img src="../Images/starbutton.png" alt="" />
                                            </td>
                                           
                                            <td>
                                                <asp:Button ID="btnSave" runat="server"  OnClick="btnSave_Click" OnClientClick="javascript:return validate()"
                                                    Text="Add" />
                                                <asp:Button ID="btnClear" runat="server" OnClientClick="javascript:return clearValues()"
                                                    Text="Clear"  />
                                                <input id="hdnPrinterID" runat="server" type="hidden" value="0" />
                                                <input id="hdnPrinterCode" runat="server" type="hidden" value="0" />
                                            </td>
                                        </tr>
                                        </tr>
                                        
                                        
                                        
                                        <%--*****************--%>
                                      <%--  <tr>
                                        <td>
                                        <asp:Label ID="LblOrgID" runat="server" Text="Org ID"></asp:Label>
                                        </td>
                                        <td width="30%" align="left">
                                         <asp:TextBox ID="TxtOrgID" runat="server" CssClass="Txtboxsmall" AutoComplete="off"></asp:TextBox>
                                        </td>
                                        </tr>
                                        
                                           <tr>
                                        <td>
                                        <asp:Label ID="LblOrgAddId" runat="server" Text="OrgAddress ID"></asp:Label>
                                        </td>
                                        <td width="30%" align="left">
                                         <asp:TextBox ID="TxtOrgAddId" runat="server" CssClass="Txtboxsmall" AutoComplete="off"></asp:TextBox>
                                        </td>
                                        </tr>
                                        
                                        
                                         <tr>
                                        <td>
                                        <asp:Label ID="LblPrintCode" runat="server" Text="Printer Code"></asp:Label>
                                        </td>
                                        <td width="30%" align="left">
                                         <asp:TextBox ID="TxtPrintCode" runat="server" CssClass="Txtboxsmall" AutoComplete="off"></asp:TextBox>
                                        </td>
                                        </tr>--%>
                                        
                                        
                                        
                                      <%--  <tr visible ="false" >
                                        <td>
                                        <asp:Label ID="lblType" runat="server" Text="Type"></asp:Label>
                                        </td>
                                        <td width="30%" align="left">
                                         <asp:TextBox ID="TxtType" runat="server" CssClass="Txtboxsmall" AutoComplete="off"></asp:TextBox>
                                          <asp:Label ID="Lbltype1" runat="server" ></asp:Label>
                                        </td>
                                        </tr>--%>
                                        
                                        
                                         <tr>
                                        <td>
                                        <asp:Label ID="Label1" runat="server" Text="Type1"></asp:Label>
                                        </td>
                                        <td width="30%" align="left">
                                        <asp:DropDownList ID="ddltype2"  Width ="62%"  runat="server" >
                </asp:DropDownList>
                 <img src="../Images/starbutton.png" alt="" />
                                        </td>
                                        </tr>
                                        
                                        
                                        
                                        <tr>
                                        <td>
                                        <asp:Label ID="LblDescription" runat="server" Text="Description"></asp:Label>
                                        </td>
                                        <td width="30%" align="left">
                                         <asp:TextBox ID="TxtDescription" runat="server" CssClass="Txtboxsmall" AutoComplete="off"></asp:TextBox>
                                          <img src="../Images/starbutton.png" alt="" />
                                        </td>
                                        </tr>
                                        
                                        
                                         <tr>
                                        <td>
                                        <asp:Label ID="LblPath" runat="server" Text="Path"></asp:Label>
                                        </td>
                                        <td width="30%" align="left">
                                         <asp:TextBox ID="TxtPath" runat="server" CssClass="Txtboxsmall" AutoComplete="off"></asp:TextBox>
                                          <img src="../Images/starbutton.png" alt="" />
                                        </td>
                                        </tr>
                                        
                                        
                                        
                                         <%-- *******************File Content && File Name***************************--%>
                                        
                                        
                                        
                                          <tr>
                                        <td>
                                        <asp:Label ID="LblFileName" runat="server" Text="FilePathAndName"></asp:Label>
                                        </td>
                                        <td width="30%" align="left">
                                         <asp:Label ID="LblFileName1" runat="server" Text=""></asp:Label>
                                          
                                        </td>
                                        <td></td>
                                        <td>
                                        <asp:LinkButton ID="Link_Del" runat ="server" Visible ="false" Text="Delete Exisisting FileContent" 
                                                onclick="Link_Del_Click"></asp:LinkButton>
                                        </td>
                                        </tr>
                                        
                                        
                                          <tr>
                                      <%--  <td>
                                        <asp:Label ID="LblFileContent" runat="server" Text="FileContent"></asp:Label>
                                        </td>
                                        <td width="30%" align="left">
                                         <asp:Label ID="LblFileContent1" runat="server" Text=""></asp:Label>
                                          
                                        </td>--%>
                                        </tr>
                                        
                                        
                                          <%-- *******************File Content && File Name***************************--%>
                                        
                                       <tr>
                                       <td>
                                         <asp:CheckBox ID="chkActive" runat="server" Text="IsActive" TabIndex="6"  
                                                                TextAlign="Left" meta:resourcekey="chkActiveResource1"
                                                                            />
                                        <td>
                                         <asp:CheckBox ID="chkColorPrinter" runat="server" Text="IsColorPrinter" TabIndex="6"  
                                                                TextAlign="Left" meta:resourcekey="chkColorPrinterResource1"
                                                                            />
                                        </td>
                                        </tr>
                                        
                                         <%-- ****************************************--%>
                                        <tr id ="TRfileUpload">
                                        <td>
                                         <asp:label id="lblFileUpload" localize="file_upload"  runat="server" text="File Upload" meta:resourcekey="lblFileUploadResource1"></asp:label>
                                        </td>
                                        <td>
                                         <asp:fileupload id="txtfileupload" runat="server"  ></asp:fileupload>
                                        
                                        </td>
                                       
                                        
                                        </tr>
                                       <%-- ****************************************--%>
                                    </table>
                               
                                <table border="0" cellspacing="0" align="left" cellpadding="5" width="100%">
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td>
                                            <asp:GridView ID="grdPrinter" runat="server" AutoGenerateColumns="False"
                                              AllowPaging ="true" PageSize ="10" CssClass="gridView w-100p"
                                               
                                                DataKeyNames="AutoID,PrinterName,Type,Description,Path,OrgID,OrgAddressID,IsColorPrinter,IsActive,FilePathAndName"
                                                 OnRowDataBound="grdPrinter_RowDataBound" 
                                                OnRowCommand="grdPrinter_RowCommand" 
                                                onpageindexchanging="grdPrinter_PageIndexChanging">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No.">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1%>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="8%" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="AutoID" HeaderText="Auto Id" visible="false" />
                                                    <asp:BoundField DataField="PrinterName" HeaderText="Printer Name" />
                                                   <asp:BoundField DataField="Type" HeaderText="Type" />
                                                <%--    <asp:TemplateField HeaderText = "Type">
           <ItemTemplate>
                <%--<asp:Label ID="lblCountry" runat="server" Text='<%# Evalundefined("Code") %>' Visible = "false" />
              
                <asp:DropDownList ID="ddltype"   runat="server" AutoPostBack ="true"  >
                </asp:DropDownList>
            </ItemTemplate>
        </asp:TemplateField>--%>
                                                    
                                                      <asp:BoundField DataField="Description" HeaderText="Description" />
                                                      <asp:BoundField DataField="Path" HeaderText="Path" />
                                                      <asp:BoundField DataField="IsActive" HeaderText="Is Active" />
                                                       <asp:BoundField DataField="IsColorPrinter" HeaderText="Is ColorPrinter" />
                                                      <asp:BoundField DataField ="OrgID" Visible ="false" HeaderText="OrgID" />
                                                        <asp:BoundField DataField ="FilePathAndName"  HeaderText="FilePathAndName" />
                                                      <asp:BoundField DataField ="FileContent"  HeaderText="FileContent" />
                                                      <asp:BoundField DataField ="OrgAddressID" Visible ="false" HeaderText="OrgAddressID" />
                                                        <asp:TemplateField HeaderText="OrgID" SortExpression="OrgID" 
                                                                                  Visible="false" meta:resourcekey="TemplateFieldResource2">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblOrgID" runat="server" 
                                                                                        Text='<%# Bind("OrgID") %>' meta:resourcekey="lblOrgIDResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtOrgID1" runat="server" 
                                                                                        Text='<%# Bind("OrgID") %>' meta:resourcekey="txtOrgID1Resource1"></asp:TextBox>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                   <%-- <asp:TemplateField HeaderText="Created Date">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblCreatedDate" runat="server" Text=""> </asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="ModifiedUser" HeaderText="Modified User" />
                                                    <asp:TemplateField HeaderText="Modified Date">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblModifiedDate" runat="server" Text=""> </asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>--%>
                                                    <asp:TemplateField HeaderText="Action">
                                                        <ItemTemplate>
                                                            <table width="100%" class="mytable1">
                                                                <tr>
                                                                    <td>
                                                                        <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Select" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'></asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="DeleteAction">
                                                        <ItemTemplate>
                                                            <table width="100%" class="mytable1">
                                                                <tr>
                                                                    <td>
                                                                     <%--   <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandName="Delete" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'></asp:LinkButton>--%>
                                                                     <asp:LinkButton ID="lnkdelete" runat="server"  Text="Delete" OnClick="lnkdelete_Click"></asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                        <HeaderStyle CssClass="colorforcontent" ForeColor="White" />
                                                                        <EmptyDataRowStyle BackColor="LightBlue" ForeColor="Black" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                            <Triggers>
                             <asp:PostBackTrigger ControlID = "btnSave" />
                             </Triggers>
                        </asp:UpdatePanel>
              
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" /> 
    </form>
</body>
</html>
