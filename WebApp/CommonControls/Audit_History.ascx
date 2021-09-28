<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Audit_History.ascx.cs"
    Inherits="CommonControls_Audit_History" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<table cellpadding="2" cellspacing="0" border="0" width="100%">
    <tr id="trPatientHistory" runat="server" style="display: none;">
        <td>
            <asp:GridView ID="grdPatientHistory" Width="100%" runat="server" AutoGenerateColumns="False"
                EmptyDataText="There is no history for this patient" DataKeyNames="PatientID,Name,Age,URNO,MobileNumber,Address,OrgID,PictureName"
                CellPadding="4" CssClass="mytable1" OnPageIndexChanging="grdHistory_PageIndexChanging"
                meta:resourcekey="grdPatientHistoryResource1">
                <HeaderStyle CssClass="dataheader1" />
                <Columns>
                    <asp:TemplateField HeaderText="Patient Number" meta:resourcekey="TemplateFieldResource1">
                        <ItemTemplate>
                            <asp:Label ID="lblPatientNumber" Text='<%# Eval("PatientNumber") %>' runat="server"
                                meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Name" meta:resourcekey="TemplateFieldResource2">
                        <ItemTemplate>
                            <asp:Label ID="lblName" Text='<%# Eval("Name") %>' runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--  <asp:TemplateField HeaderText="Alias Name">
                        <ItemTemplate>
                            <asp:Label ID="lblName" Text='<%# Eval("AliasName") %>' runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                    <asp:TemplateField HeaderText="Age" meta:resourcekey="TemplateFieldResource3">
                        <ItemTemplate>
                            <asp:Label ID="lblName" Text='<%# Eval("Age") %>' runat="server" meta:resourcekey="lblNameResource2"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Address" meta:resourcekey="TemplateFieldResource4">
                        <ItemTemplate>
                            <asp:Label ID="lblName" Text='<%# Eval("Address") %>' runat="server" meta:resourcekey="lblNameResource3"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--   <asp:TemplateField HeaderText="Occupation">
                        <ItemTemplate>
                            <asp:Label ID="lblName" Text='<%# Eval("OCCUPATION") %>' runat="server"> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                    <asp:TemplateField HeaderText="Marital Status" meta:resourcekey="TemplateFieldResource5">
                        <ItemTemplate>
                            <asp:Label ID="lblMaritalStatus" Text='<%# Eval("MaritalStatus") %>' runat="server"
                                meta:resourcekey="lblMaritalStatusResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--  <asp:TemplateField HeaderText="Relation Name">
                        <ItemTemplate>
                            <asp:Label ID="lblName" Text='<%# Eval("RelationName") %>' runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                    <asp:TemplateField HeaderText="Contact Number" meta:resourcekey="TemplateFieldResource6">
                        <ItemTemplate>
                            <asp:Label ID="lblName" Text='<%# Eval("MobileNumber") %>' runat="server" meta:resourcekey="lblNameResource4"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="EMail" meta:resourcekey="TemplateFieldResource7">
                        <ItemTemplate>
                            <asp:Label ID="lblName" Text='<%# Eval("EMail") %>' runat="server" meta:resourcekey="lblNameResource5"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Nationality" meta:resourcekey="TemplateFieldResource8">
                        <ItemTemplate>
                            <asp:Label ID="lblName" Text='<%# Eval("Nationality") %>' runat="server" meta:resourcekey="lblNameResource6"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="URN NO" meta:resourcekey="TemplateFieldResource9">
                        <ItemTemplate>
                            <asp:Label ID="lblName" Text='<%# Eval("URNO") %>' runat="server" meta:resourcekey="lblNameResource7"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--<asp:TemplateField HeaderText="History">
                        <ItemTemplate>
                            <asp:Label ID="lblName" Text='<%# Eval("CompressedName") %>' runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Remark">
                        <ItemTemplate>
                            <asp:Label ID="lblName" Text='<%# Eval("Comments") %>' runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                    <asp:TemplateField HeaderText="Modified By" meta:resourcekey="TemplateFieldResource10">
                        <ItemTemplate>
                            <asp:Label ID="lblName" Text='<%# Eval("LoginName") %>' runat="server" meta:resourcekey="lblNameResource8"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Role Name" meta:resourcekey="TemplateFieldResource11">
                        <ItemTemplate>
                            <asp:Label ID="lblName" Text='<%# Eval("RoleName") %>' runat="server" meta:resourcekey="lblNameResource9"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="History" meta:resourcekey="TemplateFieldResource12">
                        <ItemTemplate>
                            <asp:Label ID="lblName" Text='<%# Eval("History") %>' runat="server" meta:resourcekey="lblNameResource10"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Remarks" meta:resourcekey="TemplateFieldResource13">
                        <ItemTemplate>
                            <asp:Label ID="lblName" Text='<%# Eval("Remarks") %>' runat="server" meta:resourcekey="lblNameResource11"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Modified At" meta:resourcekey="TemplateFieldResource14">
                        <ItemTemplate>
                            <asp:Label ID="lblName" Text='<%# Eval("ModifiedAt").ToString().Equals("01/01/0001 00:00:00") ? "" : Eval("ModifiedAt") %>'
                                runat="server" meta:resourcekey="lblNameResource12"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </td>
    </tr>
    <tr id="trUserMaster" runat="server" style="display: block;">
        <td>
            <asp:UpdatePanel ID="upTabControl" runat="server">
                <ContentTemplate>
                    <ajc:TabContainer ID="tcUserMaster" runat="server" Style="height: auto; overflow: auto;"
                        ActiveTabIndex="0" Width="100%" meta:resourcekey="tcUserMasterResource1">
                        <div align="left">
                            <ajc:TabPanel ID="tpLogin" runat="server" HeaderText="Login Details" TabIndex="0">
                                <HeaderTemplate>
                                    <%--Login Details--%><%=Resources.CommonControls_AppMsg.CommonControls_AuditHistory_ascx_06 %>
                                </HeaderTemplate>
                                <ContentTemplate>
                                    <asp:UpdatePanel ID="upTabLogin" runat="server">
                                        <ContentTemplate>
                                            <asp:GridView ID="grdLoginDetails" runat="server" AutoGenerateColumns="False" CssClass="mytable1"
                                                Width="100%" AllowPaging="false" EmptyDataText="There is no history for this User!!"
                                                meta:resourcekey="BoundFieldResource8">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No.">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1%>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="8%" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="LoginName" ItemStyle-Wrap="true" HeaderText="Login Name"
                                                        meta:resourcekey="BoundFieldResource1" />
                                                    <asp:BoundField DataField="Name" HeaderText="Name" meta:resourcekey="BoundFieldResource2" />
                                                    <asp:BoundField DataField="IsLocked" HeaderText="IsLocked" meta:resourcekey="BoundFieldResource3" />
                                                    <asp:BoundField DataField="Status" HeaderText="Status" meta:resourcekey="BoundFieldResource4" />
                                                    <asp:BoundField DataField="ChangedBy" HeaderText="Changed By" meta:resourcekey="BoundFieldResourceCH" />
                                                    <asp:BoundField DataField="ModifiedAt" ItemStyle-Wrap="false" HeaderText="Modified At"
                                                        DataFormatString="{0:dd/MM/yyyy hh:mm tt} " meta:resourcekey="BoundFieldResourceMd" />
                                                    <asp:BoundField DataField="RoleName" HeaderText="Role Name" meta:resourcekey="BoundFieldResource7" />
                                                </Columns>
                                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                <HeaderStyle CssClass="dataheader1" />
                                            </asp:GridView>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </ContentTemplate>
                            </ajc:TabPanel>
                            <ajc:TabPanel ID="tpUser" runat="server" HeaderText="User Details" TabIndex="1" meta:resourcekey="BoundFieldResourceUsr">
                                <HeaderTemplate>
                                    <%--User Details--%><%=Resources.CommonControls_AppMsg.CommonControls_AuditHistory_ascx_07 %>
                                </HeaderTemplate>
                                <ContentTemplate>
                                    <asp:UpdatePanel ID="upTabUser" runat="server">
                                        <ContentTemplate>
                                            <asp:GridView ID="grdUser" runat="server" AutoGenerateColumns="False" CssClass="mytable1"
                                                Width="100%" AllowPaging="false" EmptyDataText="There is no history for this User!!"
                                                meta:resourcekey="grdUser1Resource">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1%>
                                                        </ItemTemplate> 
                                                        <ItemStyle Width="8%" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Name" ItemStyle-Wrap="true" HeaderText="Name" meta:resourcekey="BoundFieldResourcenm"/>
                                                    <asp:BoundField DataField="SURNAME" HeaderText="SURNAME" meta:resourcekey="BoundFieldResource9" />
                                                    <asp:TemplateField HeaderText="Date Of Birth" meta:resourcekey="TemplateFieldResource100">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblDOB" Text='<%# Eval("DOB").ToString().Equals("01/01/0001 00:00:00") ? "" : Eval("DOB","{0:dd/MM/yyyy}") %>'
                                                                runat="server">
                                                            </asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="SEX" HeaderText="SEX" meta:resourcekey="BoundFieldResource10"/>
                                                    <asp:BoundField DataField="Address" HeaderText="Address" meta:resourcekey="BoundFieldResource11"/>
                                                    <asp:BoundField DataField="City" HeaderText="City" meta:resourcekey="BoundFieldResource12"/>
                                                    <asp:BoundField DataField="StateName" HeaderText="State" meta:resourcekey="BoundFieldResource13"/>
                                                    <asp:BoundField DataField="CountryName" HeaderText="Country" meta:resourcekey="BoundFieldResource14"/>
                                                    <asp:BoundField DataField="MobileNumber" HeaderText="Mobile" meta:resourcekey="BoundFieldResource15"/>
                                                    <asp:BoundField DataField="ChangedBy" HeaderText="Changed By" meta:resourcekey="BoundFieldResource16"/>
                                                    <asp:BoundField DataField="RoleName" HeaderText="Role Name" meta:resourcekey="BoundFieldResource17"/>
                                                    <asp:BoundField DataField="ModifiedAt" ItemStyle-Wrap="false" HeaderText="Modified At"
                                                        DataFormatString="{0:dd/MM/yyyy hh:mm tt} " meta:resourcekey="BoundFieldResource18"/>
                                                </Columns>
                                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                <HeaderStyle CssClass="dataheader1" />
                                            </asp:GridView>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </ContentTemplate>
                            </ajc:TabPanel>
                        </div>
                    </ajc:TabContainer>
                </ContentTemplate>
            </asp:UpdatePanel>
        </td>
    </tr>
    <tr id="trProductHistory" runat="server" style="display: none;">
        <td>
            <asp:GridView ID="grdProductHistory" runat="server" AutoGenerateColumns="False" CssClass="mytable1"
                Width="100%" EmptyDataText="There is no history for this Product!!" OnRowDataBound="grdHistory_RowDataBound"
                OnPageIndexChanging="grdHistory_PageIndexChanging" meta:resourcekey="grdProductHistoryResource1">
                <Columns>
                    <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource18">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1%>
                        </ItemTemplate>
                        <ItemStyle Width="8%" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="ProductName" ItemStyle-Wrap="true" HeaderText="Product Name"
                        meta:resourcekey="BoundFieldResource19">
                        <ItemStyle Wrap="True"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="MfgName" HeaderText="Manufacturer" meta:resourcekey="BoundFieldResource20" />
                    <asp:BoundField DataField="MfgCode" HeaderText="Mfg.Code" meta:resourcekey="BoundFieldResource21" />
                    <asp:BoundField DataField="ReOrderLevel" HeaderText="ReOrder Level" meta:resourcekey="BoundFieldResource22" />
                    <asp:BoundField DataField="LSU" HeaderText="LSU" meta:resourcekey="BoundFieldResource23" />
                    <asp:BoundField DataField="TaxPercent" HeaderText="Tax(%)" meta:resourcekey="BoundFieldResource24" />
                    <asp:BoundField DataField="ProductCode" HeaderText="Product Code" meta:resourcekey="BoundFieldResource25" />
                    <asp:BoundField DataField="Make" HeaderText="Make/Brand" meta:resourcekey="BoundFieldResource26" />
                    <asp:BoundField DataField="CreatedLoginName" HeaderText="Modified By" meta:resourcekey="BoundFieldResource27" />
                    <asp:BoundField DataField="CreatedRoleName" HeaderText="Role Name" meta:resourcekey="BoundFieldResource28" />
                    <asp:BoundField ItemStyle-Wrap="false" DataField="CreatedAt" HeaderText="Modified At"
                        DataFormatString="{0:dd/MM/yyyy hh:mm tt} " meta:resourcekey="BoundFieldResource29">
                        <ItemStyle Wrap="False"></ItemStyle>
                    </asp:BoundField>
                </Columns>
                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                <HeaderStyle CssClass="dataheader1" />
            </asp:GridView>
        </td>
    </tr>
    <tr id="trSupplierHistory" runat="server">
        <td>
            <asp:GridView ID="grdSupplierHistory" runat="server" AutoGenerateColumns="False"
                CssClass="mytable1" Width="100%" EmptyDataText="There is no history for this Supplier!!"
                OnRowDataBound="grdHistory_RowDataBound" OnPageIndexChanging="grdHistory_PageIndexChanging"
                meta:resourcekey="grdSupplierHistoryResource1">
                <Columns>
                    <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource19">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1%>
                        </ItemTemplate>
                        <ItemStyle Width="8%" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="SupplierName" ItemStyle-Wrap="false" HeaderText="Supplier Name"
                        meta:resourcekey="BoundFieldResource30">
                        <ItemStyle Wrap="False"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="ContactPerson" HeaderText="Contact Person" meta:resourcekey="BoundFieldResource31" />
                    <asp:BoundField DataField="Address1" ItemStyle-Wrap="false" HeaderText="Address1"
                        meta:resourcekey="BoundFieldResource32">
                        <ItemStyle Wrap="False"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="Address2" ItemStyle-Wrap="false" HeaderText="Address2"
                        meta:resourcekey="BoundFieldResource33">
                        <ItemStyle Wrap="False"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="City" HeaderText="City" meta:resourcekey="BoundFieldResource34" />
                    <asp:BoundField DataField="EmailID" ItemStyle-Wrap="false" HeaderText="Email" meta:resourcekey="BoundFieldResource35">
                        <ItemStyle Wrap="False"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="Phone" HeaderText="Phone" meta:resourcekey="BoundFieldResource36" />
                    <asp:BoundField DataField="Mobile" HeaderText="Mobile" meta:resourcekey="BoundFieldResource37" />
                    <asp:BoundField DataField="TinNo" HeaderText="TIN" meta:resourcekey="BoundFieldResource38" />
                    <asp:BoundField DataField="FaxNumber" HeaderText="FAX" meta:resourcekey="BoundFieldResource39" />
                    <asp:TemplateField HeaderText="Status" meta:resourcekey="TemplateFieldResource20">
                        <ItemTemplate>
                            <asp:Label ID="lblIsDeleted" Text='<%# Eval("IsDeleted").ToString().Equals("Y") ? "Inactive" : "Active" %>'
                                runat="server" meta:resourcekey="lblIsDeletedResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Termsconditions" HeaderText="Terms&conditions" meta:resourcekey="BoundFieldResource40" />
                    <asp:BoundField DataField="CstNo" HeaderText="CST NO." meta:resourcekey="BoundFieldResource41" />
                    <asp:BoundField DataField="DrugLicenceNo" HeaderText="DL No." meta:resourcekey="BoundFieldResource42" />
                    <asp:BoundField DataField="ServiceTaxNo" HeaderText="ServiceTax No." meta:resourcekey="BoundFieldResource43" />
                    <asp:BoundField DataField="PanNo" HeaderText="PAN" meta:resourcekey="BoundFieldResource44" />
                    <asp:BoundField DataField="DrugLicenceNo1" HeaderText="DL No.1" meta:resourcekey="BoundFieldResource45" />
                    <asp:BoundField DataField="DrugLicenceNo2" HeaderText="DL No.2" meta:resourcekey="BoundFieldResource46" />
                    <asp:BoundField DataField="CreatedLoginName" HeaderText="Modified By" meta:resourcekey="BoundFieldResource47" />
                    <asp:BoundField DataField="CreatedRoleName" HeaderText="Role Name" meta:resourcekey="BoundFieldResource48" />
                    <asp:BoundField ItemStyle-Wrap="false" DataField="CreatedAt" HeaderText="Modified At"
                        DataFormatString="{0:dd/MM/yyyy hh:mm tt} " meta:resourcekey="BoundFieldResource49">
                        <ItemStyle Wrap="False"></ItemStyle>
                    </asp:BoundField>
                </Columns>
                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                <HeaderStyle CssClass="dataheader1" />
            </asp:GridView>
        </td>
    </tr>
</table>
