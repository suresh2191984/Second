<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Audit_History.ascx.cs"
    Inherits="CommonControls_Audit_History" %>
<table class="w-100p searchPanel">
    <tr id="trPatientHistory" runat="server" class="panelContent">
        <td>
            <asp:GridView ID="grdPatientHistory" runat="server" AutoGenerateColumns="False" EmptyDataText="There is no history for this patient"
                meta:resourcekey="grdPatientHistoryResource1" DataKeyNames="PatientID,Name,Age,URNO,MobileNumber,Address,OrgID,PictureName"
                CssClass="gridView w-100p" HeaderStyle-CssClass="gridHeader" 
                OnPageIndexChanging="grdHistory_PageIndexChanging"   OnRowDataBound="grdPatientHistory_RowDataBound"
                >
                <HeaderStyle CssClass="gridHeader" />
                <Columns>
                    <asp:TemplateField HeaderText="UHID" meta:resourcekey="PatientNoResource">
                        <ItemTemplate>
                            <asp:Label ID="lblPatientNumber" Text='<%# Eval("PatientNumber") %>' runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Name" meta:resourcekey="NameResource">
                        <ItemTemplate>
                            <asp:Label ID="lblName" Text='<%# Eval("Name") %>' runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Alias Name" meta:resourcekey="AliasNameResource">
                        <ItemTemplate>
                            <asp:Label ID="lblAliasName" Text='<%# Eval("AliasName") %>' runat="server" meta:resourcekey="lblAliasNameResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Age" meta:resourcekey="AgeResource">
                        <ItemTemplate>
                            <asp:Label ID="lblAge" Text='<%# Eval("Age") %>' runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Address" meta:resourcekey="AddressResource">
                        <ItemTemplate>
                            <asp:Label ID="lblAddress" Text='<%# Eval("Address") %>' runat="server" meta:resourcekey="lblAddressResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--<asp:TemplateField HeaderText="Occupation" meta:resourcekey="OccupationResource">
                        <ItemTemplate>
                            <asp:Label ID="lblOccupation" Text='<%# Eval("OCCUPATION") %>' runat="server" meta:resourcekey="lblOccupationResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                    <asp:TemplateField HeaderText="Marital Status" meta:resourcekey="MaritalStatusResource">
                        <ItemTemplate>
                            <asp:Label ID="lblMaritalStatus" Text='<%# Eval("MaritalStatus") %>' runat="server"
                                meta:resourcekey="lblMaritalStatusResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Relation Name" meta:resourcekey="RelationNameResource">
                        <ItemTemplate>
                            <asp:Label ID="lblRelationName" Text='<%# Eval("RelationName") %>' runat="server"
                                meta:resourcekey="lblRelationNameResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Contact Number" meta:resourcekey="ContactNoResource">
                        <ItemTemplate>
                            <asp:Label ID="lblContactNo" Text='<%# Eval("MobileNumber") %>' runat="server" meta:resourcekey="lblContactNoResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="EMail" meta:resourcekey="EMailResource">
                        <ItemTemplate>
                            <asp:Label ID="lblEMail" Text='<%# Eval("EMail") %>' runat="server" meta:resourcekey="lblEMailResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Nationality" meta:resourcekey="NationalityResource">
                        <ItemTemplate>
                            <asp:Label ID="lblNationality" Text='<%# Eval("NationalityText") %>' runat="server" meta:resourcekey="lblNationalityResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="URNO" meta:resourcekey="URNOResource">
                        <ItemTemplate>
                            <asp:Label ID="lblURNO" Text='<%# Eval("URNO") %>' runat="server" meta:resourcekey="lblURNOResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Modified By" meta:resourcekey="ModifiedByResource">
                        <ItemTemplate>
                            <asp:Label ID="lblModifiedBy" Text='<%# Eval("LoginName") %>' runat="server" meta:resourcekey="lblModifiedByResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Role Name" meta:resourcekey="RoleNameResource">
                        <ItemTemplate>
                            <asp:Label ID="lblRollName" Text='<%# Eval("RoleName") %>' runat="server" meta:resourcekey="lblRollNameResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Modified At" meta:resourceKey="BoundFieldResource16">
                        <ItemTemplate>
                            <span>
                               <%-- <%#((DateTime)DataBinder.Eval(Container.DataItem, "ModifiedAt")).ToString(DateTimeFormat)%>--%>
                             <asp:Label ID="lblModifiedAt" Text='<%# Eval("ModifiedAt") %>' runat="server" ></asp:Label>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--<asp:TemplateField HeaderText="Modified At" meta:resourcekey="ModifiedAtResource">
                        <ItemTemplate>
                            <asp:Label ID="lblModifiedAt" Text='<%# Eval("ModifiedAt").ToString().Equals("01/01/0001 12:00:00 AM") ? "   -" : Eval("ModifiedAt","{0:dd/MM/yyyy}") %>'
                                runat="server" meta:resourcekey="lblModifiedAtResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                </Columns>
            </asp:GridView>
        </td>
    </tr>
    <tr id="trUserMaster" runat="server">
        <td>
            <asp:UpdatePanel ID="upTabControl" runat="server">
                <ContentTemplate>
                    <ajc:TabContainer ID="tcUserMaster" runat="server" ActiveTabIndex="0" CssClass="w-100p auto">
                        <div class="a-left">
                            <ajc:TabPanel ID="tpLogin" runat="server" HeaderText="Login Details" TabIndex="0"
                                meta:resourcekey="LoginDetailsResource2">
                                <HeaderTemplate>
                                    <asp:Label ID="lblLoginDetails" runat="server" Text="LoginDetails" meta:resourcekey="lblLoginDetails" />
                                </HeaderTemplate>
                                <ContentTemplate>
                                    <asp:UpdatePanel ID="upTabLogin" runat="server">
                                        <ContentTemplate>
                                            <asp:GridView ID="grdLoginDetails" runat="server" AutoGenerateColumns="False" CssClass="gridView w-100p"
                                                HeaderStyle-CssClass="gridHeader" EmptyDataText="There is no history for this User!!"
                                                meta:resourcekey="grdLoginDetailsResource1">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No." meta:resourcekey="SNoResource">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1%>
                                                        </ItemTemplate>
                                                        <ItemStyle />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="LoginName" ItemStyle-Wrap="true" HeaderText="Login Name"
                                                        meta:resourcekey="BoundFieldResource11">
                                                        <ItemStyle Wrap="True"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Name" HeaderText="Name" meta:resourcekey="BoundFieldResource12" />
                                                    <asp:BoundField DataField="IsLocked" HeaderText="IsLocked" meta:resourcekey="BoundFieldResource13" />
                                                    <asp:BoundField DataField="Status" HeaderText="Status" meta:resourcekey="BoundFieldResource14" />
                                                    <asp:BoundField DataField="ChangedBy" HeaderText="Changed By" meta:resourcekey="BoundFieldResource15" />
                                                    <asp:TemplateField HeaderText="Modified At" meta:resourceKey="BoundFieldResource16">
                                                        <ItemTemplate>
                                                            <span>
                                                                <%#((DateTime)DataBinder.Eval(Container.DataItem, "ModifiedAt")).ToString(DateTimeFormat)%>
                                                            </span>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <%--<asp:BoundField DataField="ModifiedAt" ItemStyle-Wrap="false" HeaderText="Modified At"
                                                        DataFormatString="{0:dd/MM/yyyy hh:mm:ss tt} " meta:resourcekey="BoundFieldResource16">
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </asp:BoundField>--%>
                                                    <asp:BoundField DataField="RoleName" HeaderText="Role Name" meta:resourcekey="BoundFieldResource17" />
                                                </Columns>
                                                <PagerStyle CssClass="gridPager" />
                                                <HeaderStyle CssClass="gridHeader" />
                                            </asp:GridView>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </ContentTemplate>
                            </ajc:TabPanel>
                            <ajc:TabPanel ID="tpUser" runat="server" HeaderText="User Details" TabIndex="1" meta:resourcekey="UserDetailsResource2">
                                <HeaderTemplate>
                                    <asp:Label ID="lblUserDetails" runat="server" Text="User Details" meta:resourcekey="lblUserDetails" />
                                </HeaderTemplate>
                                <ContentTemplate>
                                    <asp:UpdatePanel ID="upTabUser" runat="server">
                                        <ContentTemplate>
                                            <asp:GridView ID="grdUser" runat="server" AutoGenerateColumns="False" CssClass="gridView w-100p"
                                                HeaderStyle-CssClass="gridHeader" EmptyDataText="There is no history for this User!!" OnRowDataBound="grdUser_RowDataBound"
                                                meta:resourcekey="grdUserResource1">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No." meta:resourcekey="SNoResource2">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1%>
                                                        </ItemTemplate>
                                                        <ItemStyle />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Name" ItemStyle-Wrap="true" HeaderText="Name" meta:resourcekey="NameResource3">
                                                        <ItemStyle Wrap="True"></ItemStyle>
                                                    </asp:BoundField>
                                                    <%--<asp:BoundField DataField="SURNAME" HeaderText="Sur Name" meta:resourcekey="SurNameResource" />--%>
                                                    <asp:TemplateField HeaderText="Date Of Birth" meta:resourcekey="DobResource">
                                                        <ItemTemplate>
                                                            <span>
                                                                <%#((DateTime)DataBinder.Eval(Container.DataItem,"DOB")).ToString(DateFormat)%>
                                                            </span>
                                                            <%--   <asp:Label ID="lblDOB" Text='<%# Eval("DOB").ToString().Equals("01/01/1800 12:00:00 AM") ? "-" : Eval("DOB","{0:dd/MM/yyyy}") %>'
                                                                runat="server" meta:resourcekey="lblDOBResource1"></asp:Label>--%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="SEX" HeaderText="Gender" meta:resourcekey="BoundFieldResource18" />
                                                    <asp:BoundField DataField="Address" HeaderText="Address" meta:resourcekey="BoundFieldResource19" />
                                                    <asp:BoundField DataField="City" HeaderText="City" meta:resourcekey="BoundFieldResource20" />
                                                    <asp:BoundField DataField="StateName" HeaderText="State" meta:resourcekey="BoundFieldResource21" />
                                                    <asp:BoundField DataField="CountryName" HeaderText="Country" meta:resourcekey="BoundFieldResource22" />
                                                    <asp:BoundField DataField="MobileNumber" HeaderText="Mobile" meta:resourcekey="BoundFieldResource23" />
                                                    <asp:BoundField DataField="ChangedBy" HeaderText="Changed By" meta:resourcekey="BoundFieldResource24" />
                                                    <asp:BoundField DataField="RoleName" HeaderText="Role Name" meta:resourcekey="BoundFieldResource25" />
                                                    <asp:TemplateField HeaderText="Modified At" meta:resourcekey="BoundFieldResource26">
                                                        <ItemTemplate>
                                                            <span>
                                                                <%#((DateTime)DataBinder.Eval(Container.DataItem, "ModifiedAt")).ToString(DateTimeFormat)%>
                                                            </span>
                                                            <%--                                                            <asp:Label ID="lblModifiedAt" Text='<%# Eval("ModifiedAt").ToString().Equals("01/01/0001 00:00:00") ? "-" : Eval("ModifiedAt","{0:dd/MM/yyyy H:MM:ss}") %>'
                                                                runat="server" meta:resourcekey="lblModifiedAtResource1"></asp:Label>--%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerStyle CssClass="gridPager" />
                                                <HeaderStyle CssClass="gridHeader" />
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
    <tr id="trProductHistory" runat="server">
        <td>
            <asp:GridView ID="grdProductHistory" runat="server" AutoGenerateColumns="False" CssClass="gridView w-100p"
                HeaderStyle-CssClass="gridHeader" EmptyDataText="There is no history for this Product!!"
                OnRowDataBound="grdHistory_RowDataBound" OnPageIndexChanging="grdHistory_PageIndexChanging"
                meta:resourcekey="grdProductHistoryResource1">
                <Columns>
                    <asp:TemplateField HeaderText="S.No." meta:resourcekey="SNoresource7">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1%>
                        </ItemTemplate>
                        <ItemStyle />
                    </asp:TemplateField>
                    <asp:BoundField DataField="ProductName" ItemStyle-Wrap="true" HeaderText="Product Name"
                        meta:resourcekey="ProductNameResource2">
                        <ItemStyle Wrap="True"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="MfgName" HeaderText="Manufacturer" meta:resourcekey="ManufacturerResource2" />
                    <asp:BoundField DataField="MfgCode" HeaderText="Mfg.Code" meta:resourcekey="MfgCodeResource2" />
                    <%--<asp:BoundField DataField="ReOrderLevel" HeaderText="ReOrder Level" meta:resourcekey="ReorderLevelResource2" />--%>
                    <asp:BoundField DataField="LSU" HeaderText="LSU" meta:resourcekey="LSUResource2" />
                    <asp:BoundField DataField="TaxPercent" HeaderText="Tax(%)" meta:resourcekey="TaxResource2" />
                    <asp:BoundField DataField="ProductCode" HeaderText="Product Code" meta:resourcekey="ProductCodeResource2" />
                    <asp:BoundField DataField="Make" HeaderText="Make/Brand" meta:resourcekey="MakeBrandResource2" />
                    <asp:BoundField DataField="CreatedLoginName" HeaderText="Modified By" meta:resourcekey="ModifiedByResource2" />
                    <asp:BoundField DataField="CreatedRoleName" HeaderText="Role Name" meta:resourcekey="RoleNameResource2" />
                    <%--<asp:BoundField ItemStyle-Wrap="false" DataField="CreatedAt" HeaderText="Modified At"
                        DataFormatString="{0:dd/MM/yyyy hh:mm tt} " meta:resourcekey="ModifiedAtResource3">
                        <ItemStyle Wrap="False"></ItemStyle>
                    </asp:BoundField>--%>
                    <asp:TemplateField HeaderText="Modified At" meta:resourceKey="ModifiedAtResource3">
                        <ItemTemplate>
                            <span>
                                <%#((DateTime)DataBinder.Eval(Container.DataItem, "CreatedAt")).ToString(DateTimeFormat)%>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerStyle CssClass="gridPager" />
                <HeaderStyle CssClass="gridHeader" />
            </asp:GridView>
        </td>
    </tr>
    <tr id="trSupplierHistory" runat="server">
        <td>
            <div class="w-100p o-auto">
                <asp:GridView ID="grdSupplierHistory" runat="server" AutoGenerateColumns="False"
                CssClass="tab-fixcel gridView w-100p" HeaderStyle-CssClass="gridHeader" EmptyDataText="There is no history for this Supplier!!"
                OnRowDataBound="grdHistory_RowDataBound" OnPageIndexChanging="grdHistory_PageIndexChanging"
                meta:resourcekey="grdSupplierHistoryResource1">
                <Columns>
                    <asp:TemplateField HeaderText="S.No." meta:resourcekey="SNoResource4">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1%>
                        </ItemTemplate>
                        <ItemStyle />
                    </asp:TemplateField>
                    <asp:BoundField DataField="SupplierName" ItemStyle-Wrap="true" HeaderText="Supplier Name"
                        meta:resourcekey="SupplierNameResource4">
                        <ItemStyle Wrap="True"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="ContactPerson" HeaderText="Contact Person" meta:resourcekey="ContactPersonResource4" />
                    <asp:BoundField DataField="Address1" ItemStyle-Wrap="true" HeaderText="Address1"
                        meta:resourcekey="Address1Resource4">
                        <ItemStyle Wrap="true"></ItemStyle>
                        <HeaderStyle CssClass="w-14p" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Address2" ItemStyle-Wrap="true" HeaderText="Address2"
                        meta:resourcekey="Address2Resource4">
                        <ItemStyle Wrap="True"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="City" HeaderText="City" meta:resourcekey="CityResource4" />
                    <asp:BoundField DataField="EmailID" ItemStyle-Wrap="true" HeaderText="Email" meta:resourcekey="EmailResource4">
                        <ItemStyle Wrap="True"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="Phone" HeaderText="Phone" meta:resourcekey="PhoneResource4" />
                    <asp:BoundField DataField="Mobile" HeaderText="Mobile" meta:resourcekey="MobileResource4" />
                    <asp:BoundField DataField="GSTIN" HeaderText="GSTIN" meta:resourcekey="GSTinResource4" />
                    <%--<asp:BoundField DataField="TinNo" HeaderText="TIN" meta:resourcekey="TinResource4" />--%>
                    <asp:BoundField DataField="FaxNumber" HeaderText="FAX" meta:resourcekey="FaxResource4" />
                    <asp:TemplateField HeaderText="Status" meta:resourcekey="StatusResource4">
                        <ItemTemplate>
                            <asp:Label ID="lblIsDeleted" Text='<%# Eval("IsDeleted").ToString().Trim().Equals("Y") ? "Inactive" : "Active" %>'
                                runat="server" meta:resourcekey="lblIsDeletedResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Terms&conditions" meta:resourcekey="BoundFieldResource1">
                        <ItemTemplate>
                       
                         <%# HttpUtility.HtmlDecode(Eval("Termsconditions").ToString())%>  
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--<asp:BoundField DataField="Termsconditions" HeaderText="Terms&conditions" meta:resourcekey="BoundFieldResource1" />--%>
                    <asp:BoundField DataField="CstNo" HeaderText="CST NO." meta:resourcekey="BoundFieldResource2" />
                    <asp:BoundField DataField="DrugLicenceNo" HeaderText="DL No." meta:resourcekey="BoundFieldResource3" />
                    <asp:BoundField DataField="ServiceTaxNo" HeaderText="ServiceTax No." meta:resourcekey="BoundFieldResource4" />
                    <asp:BoundField DataField="PanNo" HeaderText="PAN" meta:resourcekey="BoundFieldResource5" />
                    <asp:BoundField DataField="DrugLicenceNo1" HeaderText="DL No.1" meta:resourcekey="BoundFieldResource6" />
                    <asp:BoundField DataField="DrugLicenceNo2" HeaderText="DL No.2" meta:resourcekey="BoundFieldResource7" />
                    <asp:BoundField DataField="CreatedLoginName" HeaderText="Modified By" meta:resourcekey="BoundFieldResource8" />
                    <asp:BoundField DataField="CreatedRoleName" HeaderText="Role Name" meta:resourcekey="BoundFieldResource9" />
                    <%--<asp:BoundField ItemStyle-Wrap="true" DataField="ModifiedAt" HeaderText="Modified At"
                        DataFormatString="{0:dd/MM/yyyy hh:mm tt} " meta:resourcekey="BoundFieldResource10">
                        <ItemStyle Wrap="True"></ItemStyle>
                    </asp:BoundField>--%>
                    <asp:TemplateField HeaderText="Modified At" meta:resourceKey="BoundFieldResource10">
                        <ItemTemplate>
                            <span>
                                <%#((DateTime)DataBinder.Eval(Container.DataItem, "ModifiedAt")).ToString(DateTimeFormat)%>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerStyle CssClass="gridPager" />
                <HeaderStyle CssClass="gridHeader" />
            </asp:GridView>
            </div>
        </td>
    </tr>
    <tr id="trEmergencyPatient" runat="server">
        <td>
            <asp:GridView ID="GrdEmergencyPatient" runat="server" AutoGenerateColumns="False"
                CssClass="gridView w-100p" HeaderStyle-CssClass="gridHeader" EmptyDataText="There is no history for this User!!"
                meta:resourcekey="GrdEmergencyPatientResource1">
                <Columns>
                    <asp:TemplateField HeaderText="S.No." meta:resourcekey="SNoResource6">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1%>
                        </ItemTemplate>
                        <ItemStyle />
                    </asp:TemplateField>
                    <asp:BoundField DataField="Name" HeaderText="Name" meta:resourcekey="NameResource6" />
                    <asp:BoundField DataField="AliasName" HeaderText="Severity Level" meta:resourcekey="SeverityLevelResource6" />
                    <asp:BoundField DataField="LoginName" HeaderText="Changed By" meta:resourcekey="ChangedByResource6" />
                    <%--<asp:BoundField DataField="ModifiedAt" ItemStyle-Wrap="false" HeaderText="Modified At"
                        DataFormatString="{0:dd/MM/yyyy hh:mm tt} " meta:resourcekey="ModifiedAtResource6">
                        <ItemStyle Wrap="False"></ItemStyle>
                    </asp:BoundField>--%>
                    <asp:TemplateField HeaderText="Modified At" meta:resourceKey="ModifiedAtResource6">
                        <ItemTemplate>
                            <span>
                                <%#((DateTime)DataBinder.Eval(Container.DataItem, "ModifiedAt")).ToString(DateTimeFormat)%>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="gridHeader"></HeaderStyle>
            </asp:GridView>
        </td>
    </tr>
</table>
