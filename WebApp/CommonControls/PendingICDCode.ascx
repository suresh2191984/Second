<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PendingICDCode.ascx.cs"
    Inherits="CommonControls_PendingICDCode" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="autocom" %>

<script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td>
            <asp:GridView ID="gvPendingICD" runat="server" Width="100%" CellPadding="4" CssClass="mytable1"
                AutoGenerateColumns="False" ForeColor="#333333" HorizontalAlign="Left" OnRowDataBound="gvPendingICD_RowDataBound"
                meta:resourcekey="gvPendingICDResource1">
                <HeaderStyle CssClass="dataheader1" />
                <Columns>
                    <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                        <ItemTemplate>
                            <asp:Label ID="lblComplaintName" Text='<%# Eval("ComplaintName") %>' runat="server"><%--meta:resourcekey="lblComplaintNameResource1"--%></asp:Label>
                            <asp:Label ID="lblComplaintID" runat="server" Text='<%# Eval("ComplaintID") %>' Visible="False"><%--meta:resourcekey="lblComplaintIDResource1"--%></asp:Label>
                            <asp:Label ID="lblComplaintType" runat="server" Text='<%# Eval("ComplaintType") %>'
                                Visible="False"><%--meta:resourcekey="lblComplaintTypeResource1"--%></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ICD 10 Code" meta:resourcekey="TemplateFieldResource2">
                        <ItemTemplate>
                            <asp:Label ID="lblICDCode" Text='<%# Eval("ICDCode") %>' runat="server" Visible="False"><%--meta:resourcekey="lblICDCodeResource1"--%></asp:Label>
                            <asp:TextBox runat="server" ID="txtICDCode" autocomplete="off" OnChange="javascript:GetICDCode(this.id);"
                                TextMode="MultiLine" Text='<%# Eval("ICDCode") %>'><%-- meta:resourcekey="txtICDCodeResource1"--%></asp:TextBox>
                            <autocom:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtICDCode"
                                EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True"
                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getICDCODE"
                                ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
                            </autocom:AutoCompleteExtender>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ICD 10 Description" meta:resourcekey="TemplateFieldResource3">
                        <ItemTemplate>
                            <asp:Label ID="lblICDDescription" Text='<%# Eval("ICDDescription") %>' runat="server"
                                Visible="False"><%--meta:resourcekey="lblICDDescriptionResource1"--%></asp:Label>
                            <asp:TextBox runat="server" ID="txtICDName" autocomplete="off" OnChange="javascript:GetICDName(this.id);"
                                TextMode="MultiLine" Text='<%# Eval("ICDDescription") %>'><%--meta:resourcekey="txtICDNameResource1"--%></asp:TextBox>
                            <autocom:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtICDName"
                                EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True"
                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getICDName"
                                ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
                            </autocom:AutoCompleteExtender>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Change Status" meta:resourcekey="TemplateFieldResource4">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlStatus" runat="server">
                                <%--meta:resourcekey="ddlStatusResource1"--%>
                                <asp:ListItem Value="Pending" Text="Pending"><%--meta:resourcekey="ListItemResource1"--%></asp:ListItem>
                                <asp:ListItem Value="Completed" Text="Completed"><%--meta:resourcekey="ListItemResource2"--%></asp:ListItem>
                                <asp:ListItem Value="Ignored" Text="Ignored"><%-- meta:resourcekey="ListItemResource3"--%></asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Related To" meta:resourcekey="TemplateFieldResource5">
                        <ItemTemplate>
                            <asp:Label ID="lblPage" runat="server"><%-- meta:resourcekey="lblPageResource1"--%></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="White" ForeColor="#000066" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>
        </td>
    </tr>
</table>

<script language="javascript" type="text/javascript">
    function GetICDCode(ICDId) {

        var GridRowID = ICDId.split('_');
        var txtICDCode = GridRowID[0] + "_" + GridRowID[1] + "_" + GridRowID[2] + "_" + "txtICDCode";
        var txtICDName = GridRowID[0] + "_" + GridRowID[1] + "_" + GridRowID[2] + "_" + "txtICDName";


        var Temp = document.getElementById(txtICDCode).value.split('~');
        document.getElementById(txtICDCode).value = Temp[0];
        document.getElementById(txtICDName).value = Temp[1];

        if (document.getElementById(txtICDName).value == "undefined") {

            document.getElementById(txtICDCode).value = "";
            document.getElementById(txtICDName).value = "";


        }
    }

    function GetICDName(pICDName) {

        var GridRowID = pICDName.split('_');
        var txtICDCode = GridRowID[0] + "_" + GridRowID[1] + "_" + GridRowID[2] + "_" + "txtICDCode";
        var txtICDName = GridRowID[0] + "_" + GridRowID[1] + "_" + GridRowID[2] + "_" + "txtICDName";


        var Temp = document.getElementById(txtICDName).value.split('~');
        document.getElementById(txtICDName).value = Temp[0];
        document.getElementById(txtICDCode).value = Temp[1];
        if (document.getElementById(txtICDCode).value == "undefined") {

            document.getElementById(txtICDCode).value = "";
            document.getElementById(txtICDName).value = "";


        }

    }



</script>

