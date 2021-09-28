<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PatientPrescription.ascx.cs"
    Inherits="CommonControls_PatientPrescription" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<asp:UpdatePanel ID="ctlPatientPrescription" runat="server">
    <ContentTemplate>
        <table>
        <tr><td align="left">
       <%-- <asp:Label ID="lblheading" runat="server" Text="Prescription" />--%>
        </td></tr>
            <tr>
                <td style="width: 760px;" class="mediumfon">
                  
                    <asp:GridView ID="gvTreatment" runat="server" AllowPaging="True" 
                        ForeColor="#333333"  Width="700px"  CaptionAlign="Top"
                        HorizontalAlign="Left" OnPageIndexChanging="gvTreatment_PageIndexChanging" OnRowDataBound="gvTreatment_RowDataBound"
                        AutoGenerateColumns="False" Font-Size="Small" Font-Bold="False" 
                        meta:resourcekey="gvTreatmentResource1" >
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" Wrap="True" 
                            CssClass="dataheader3"/>
                        <Columns>
                            <asp:BoundField  DataField="Formulation"  HeaderText="Formulation"
                                                                ItemStyle-HorizontalAlign="Left" />
                          <asp:BoundField DataField="BrandName" HeaderText="DrugName"
                                                                ItemStyle-HorizontalAlign="Left" />
                         <asp:BoundField  DataField="Dose"  HeaderText="Dose"
                                                                ItemStyle-HorizontalAlign="Left" />
                         
                                                   <asp:BoundField  DataField="DrugFrequency"  HeaderText="Frequency"
                                                                ItemStyle-HorizontalAlign="Left" />
                                                                   <asp:BoundField  DataField="Duration"  HeaderText="Duration"
                                                                ItemStyle-HorizontalAlign="Left" />
                         <asp:BoundField HeaderText="Instruction" DataField="Instruction" ItemStyle-HorizontalAlign="Left"/>                                       
                            <%--<asp:TemplateField HeaderText="Treatment" 
                                meta:resourcekey="TemplateFieldResource1">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblFormulation" Text='<%# Bind("Formulation") %>' 
                                        ></asp:Label>
                                    <asp:Label runat="server" ID="lblBrandName" Text='<%# Bind("BrandName") %>' 
                                       ></asp:Label>
                                    <asp:Label runat="server" ID="lblDose" Text='<%# Bind("Dose") %>' 
                                        ></asp:Label>
                                    <asp:Label runat="server" ID="lblDrugfreq" Text='<%# Bind("DrugFrequency") %>' 
                                        ></asp:Label>
                                    <asp:Label runat="server" ID="lblDuration" Text='<%# Bind("Duration") %>' 
                                        ></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                        </Columns>
                         <HeaderStyle BackColor="LightGray" Width="765px" />
                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    </asp:GridView>
                </td>
                
                
               
                <tr>
                    <td>
                        <asp:Label ID="lblTreatment" runat="server" Font-Bold="True" 
                            ForeColor="#CC66FF" meta:resourcekey="lblTreatmentResource1"></asp:Label>
                    </td>
                </tr>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>
