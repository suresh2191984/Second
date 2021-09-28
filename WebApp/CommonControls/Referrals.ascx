<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Referrals.ascx.cs" Inherits="CommonControls_Referrals" %>

<script language="javascript" type="text/javascript">
    function RowSelectCommon(rid, pVid, pURN, pIspatient, pRefId, pId, pRefdetailsId, pReferedToOrgID) {
        chosen = "";

        var len = document.forms[0].elements.length;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "radio") {
                document.forms[0].elements[i].checked = false;
            }
        }
        document.getElementById(rid).checked = true;
        document.getElementById("pVisitid").value = pVid;
        document.getElementById("pURN").value = pURN;
        document.getElementById("pIspatient").value = pIspatient;
        document.getElementById("pRefId").value = pRefId;
        document.getElementById("pId").value = pId;
        document.getElementById("pRefdetailsId").value = pRefdetailsId;
        document.getElementById("pReferToOrg").value = pReferedToOrgID;
        
    }
</script>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <table class="w-100p">
            <tr>
                <td>
                    <asp:GridView ID="grdResult" runat="server" AllowPaging="True" CellPadding="4"
                        AutoGenerateColumns="False" ForeColor="#333333"
                        OnPageIndexChanging="grdResult_PageIndexChanging" OnRowDataBound="grdResult_RowDataBound"
                        EmptyDataText="No Record Found" PageSize="15" 
                        meta:resourcekey="grdResultResource1" CssClass="w-100p gridView">
                        <HeaderStyle CssClass="dataheader1" />
                        <Columns>
                            <asp:TemplateField HeaderText="Select" 
                                meta:resourcekey="TemplateFieldResource1">
                                <ItemTemplate>
                                    <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" 
                                        GroupName="Select"/> <%--meta:resourcekey="rdSelResource1"--%> 
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle Width="2%" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="URN" HeaderText="Patient URN" 
                                meta:resourcekey="BoundFieldResource1" />
                            <asp:BoundField DataField="PatientName" HeaderText="Patient Name" 
                                meta:resourcekey="BoundFieldResource2" />
                            <asp:TemplateField HeaderText="Phone Numbers" 
                                meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <%# Eval("PhoneNo")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="OrgName" HeaderText="Refering Org Name" 
                                meta:resourcekey="BoundFieldResource3" />
                            <asp:BoundField DataField="OrgName" HeaderText="Refered Org Name" 
                                meta:resourcekey="BoundFieldResource4" />
                            <asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd/MM/yyyy}" 
                                HeaderText="Created Date" meta:resourcekey="BoundFieldResource5" />
                            <asp:TemplateField Visible="False" meta:resourcekey="TemplateFieldResource3">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hdnReferingVisitID" Value='<%# Eval("ReferedByVisitID") %>'
                                        runat="server" />
                                    <asp:HiddenField ID="hdnReferralID" Value='<%# Eval("ReferralID") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                        </Columns>
                        <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                    </asp:GridView>
                  
                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>
