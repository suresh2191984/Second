<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LabPatientSearch.ascx.cs"
    Inherits="CommonControls_LabPatientSearch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%--<link rel="stylesheet" type="text/css" href="../StyleSheets/style.css" />--%>

<script language="javascript" type="text/javascript">
    var x;
    function nameValidate(id) {

        x = id.split("_");
        if (document.getElementById(x[0] + '_txtPatientName').value == '') {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\LabPatientSearch.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert("Please Enter Patient Name");
            }
            document.getElementById(x[0] + '_txtPatientName').focus();
            return false;


        }
    }
    function SelectRowCommonForLab(rid, patid) {
        chosen = "";

        var len = document.forms[0].elements.length;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "radio") {
                document.forms[0].elements[i].checked = false;
            }
        }
        document.getElementById(rid).checked = true;
        document.getElementById("pid").value = patid;
    }

</script>

<asp:Panel ID="pnlPSearch" runat="server" DefaultButton="btnSearch" meta:resourcekey="pnlPSearchResource1">
    <table width="100%" class="dataheader2" border="0" cellpadding="4" cellspacing="0"
        class="defaultfontcolor">
        <tr>
            <td style="height: 10px;">
            </td>
        </tr>
        <tr>
            <td style="width: 15%;" align="right">
                <asp:Label ID="Rs_PatientsName" runat="server" Text="Patient's Name" meta:resourcekey="Rs_PatientsNameResource1"></asp:Label>
            </td>
            <td style="width: 20%">
                <asp:TextBox ID="txtPatientName" ToolTip="Patient Name" runat="server" MaxLength="255"
                    CssClass="txtboxps" meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
            </td>
            <td align="right" style="width: 25%">
                <asp:Label ID="Rs_MobileNumber" runat="server" Text="Mobile Number" meta:resourcekey="Rs_MobileNumberResource1"></asp:Label>
            </td>
            <td style="width: 30%">
                <asp:TextBox ID="txtMobilenumber" ToolTip="Contact Mobile Number" runat="server"
                    CssClass="txtboxps" meta:resourcekey="txtMobilenumberResource1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 15%;" align="right">
                <asp:Label ID="Rs_VisitNo" runat="server" Text="Visit No" meta:resourcekey="Rs_VisitNoResource1"></asp:Label>
            </td>
            <td style="width: 20%">
                <asp:TextBox ID="txtVisitNo" runat="server" ToolTip="Sample ID No(Visit No)" MaxLength="255"
                    CssClass="txtboxps" meta:resourcekey="txtVisitNoResource1"></asp:TextBox>
            </td>
            <td align="right" style="width: 25%">
                <asp:Label ID="Rs_BillNo" runat="server" Text="Bill No" meta:resourcekey="Rs_BillNoResource1"></asp:Label>
            </td>
            <td style="width: 30%">
                <asp:TextBox ID="txtBillNo" ToolTip="Bill No" runat="server" CssClass="txtboxps"
                    meta:resourcekey="txtBillNoResource1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="4" style="padding-bottom: 10px;" align="center">
                <asp:Button ID="btnSearch" ToolTip="Click here to Search the Patient" Style="cursor: pointer;"
                    runat="server" Text="Search" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                    onmouseout="this.className='btn1'" OnClick="btnSearch_Click" OnClientClick="javascript:return nameValidate(this.id);"
                    meta:resourcekey="btnSearchResource1" />
                &nbsp;
                <asp:Button ID="btnCancel" runat="server" Style="cursor: pointer;" ToolTip="Click here to Cancel"
                    Text="Reset" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                    OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
            </td>
        </tr>
        <tr>
            <td colspan="4" align="center">
            </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="5" cellspacing="0">
        <tr>
            <td>
                <asp:Label ID="lblResult" ForeColor="#000333" runat="server" meta:resourcekey="lblResultResource1"></asp:Label>
            </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <asp:GridView ID="grdResult" Width="100%" runat="server" AllowPaging="True" CellPadding="4"
                    AutoGenerateColumns="False" DataKeyNames="PatientID" OnRowDataBound="grdResult_RowDataBound"
                    ForeColor="#333333" OnPageIndexChanging="grdResult_PageIndexChanging" CssClass="mytable1"
                    meta:resourcekey="grdResultResource1">
                    <Columns>
                        <asp:BoundField DataField="PatientID" HeaderText="PatientID" meta:resourcekey="BoundFieldResource1"
                            Visible="False" />
                        <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource1">
                            <ItemTemplate>
                                <asp:RadioButton ID="rdSel" runat="server" GroupName="PatientSelect" ToolTip="Select Row" /><%--meta:resourcekey="rdSelResource1"--%>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle Width="2%" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="Name" HeaderText="Name" meta:resourcekey="BoundFieldResource2">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" Width="15%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Age" HeaderText="Age" meta:resourcekey="BoundFieldResource3">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" Width="5%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PatientNumber" HeaderText="Mobile" meta:resourcekey="BoundFieldResource4">
                            <ItemStyle Width="15%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Occupation" HeaderText="Occupation" meta:resourcekey="BoundFieldResource5"
                            Visible="False">
                            <ItemStyle Width="17%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="EMail" HeaderText="EMail" meta:resourcekey="BoundFieldResource6"
                            Visible="False">
                            <ItemStyle Width="25%" />
                        </asp:BoundField>
                    </Columns>
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerSettings Mode="NextPrevious" />
                    <PagerTemplate>
                        <tr>
                            <td align="center" colspan="6">
                                <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                    CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png" meta:resourcekey="lnkPrevResource1"
                                    Width="18px" />
                                <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                    CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png" meta:resourcekey="lnkNextResource1"
                                    Width="18px" />
                            </td>
                        </tr>
                    </PagerTemplate>
                </asp:GridView>
            </td>
        </tr>
    </table>
    <input type="hidden" id="pid" name="pid" />
</asp:Panel>
