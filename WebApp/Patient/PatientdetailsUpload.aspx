<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientdetailsUpload.aspx.cs"
    Inherits="Patient_PatientdetailsUpload" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/PatientFileUploader.ascx" TagName="PatientFileUploader"
    TagPrefix="PFU" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Patient Details Upload</title>

 <%--     <script src="../Scripts/jquery-1.3.2.js" type="text/javascript"></script>--%>
    <script language="javascript" type="text/javascript">
        function CheckAll() {
            var intIndex = 0;
            var rowCount = document.getElementById('chkDocs').getElementsByTagName("input").length;
            for (i = 0; i < rowCount; i++) {
                if (document.getElementById('chkDocAll').checked == true) {
                    if (document.getElementById("chkDocs" + "_" + i)) {
                        if (document.getElementById("chkDocs" + "_" + i).disabled != true)
                            document.getElementById("chkDocs" + "_" + i).checked = true;
                    }
                }
                else {
                    if (document.getElementById("chkDocs" + "_" + i)) {
                        if (document.getElementById("chkDocs" + "_" + i).disabled != true)
                            document.getElementById("chkDocs" + "_" + i).checked = false;
                    }
                }
            }
        }

        function checkDocs() {
            var result;
            var Doc;
            var Check = false;
            var chkBoxList = document.getElementById('chkDocs');
            var chkBoxCount = chkBoxList.getElementsByTagName("input");          

            for (var i = 0; i < chkBoxCount.length; i++) {
                Doc = chkBoxCount[i].checked;
                if (Doc == true) {
                    Check = Doc;
                }  
            }           

            if (Check == false) {
                alert('Select file to delete');
                return false;
            }
            result = confirm('Are you sure want to delete the Files?');
            if (result == false) {
                return false;
            }
            else {

                return true;
            }

           

        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table id="TRFImageDetails" runat="server">
            <tr>
                <td>
                    <asp:GridView ID="grdviewTRF" runat="server" AllowPaging="true" CellPadding="1" AutoGenerateColumns="false"
                        DataKeyNames="RefID,PatientID,VisitID,FileID,FileUrl" CssClass="gridView w-100p"
                        AlternatingRowStyle-CssClass="trEven" class="mytable1" OnRowCommand="grdviewTRF_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="RefID" HeaderText="VisitNumber" />
                            <asp:BoundField DataField="PatientID" Visible="false" HeaderText="PatientID" />
                            <asp:BoundField DataField="VisitID" Visible="false" HeaderText="VisitID" />
                            <asp:BoundField DataField="FileID" Visible="false" HeaderText="FileID" />
                            <asp:BoundField DataField="FileUrl" Visible="false" HeaderText="FileUrl" />
                            <asp:BoundField DataField="FileName" HeaderText="TRF File Name" />
                            <asp:TemplateField HeaderText="View">
                                <ItemTemplate>
                                    <%--CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'--%>
                                    <asp:LinkButton ID="lnkbtnView" Text="View" runat="server" CommandName="View" CommandArgument='<%#Eval("PatientID")+","+Eval("VisitID")+","+Eval("FileUrl")%>'></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkbtnDelete" Text="Delete" runat="server" CommandName="Remove"
                                        CommandArgument='<%#Eval("PatientID")+","+Eval("VisitID")+","+Eval("FileID")%>'></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Download">
                            <ItemTemplate>
                            <asp:LinkButton ID="btndownloadTRF" runat="server" Text="Download" CommandName="Download"
                            CommandArgument='<%#Eval("PatientID")+","+Eval("VisitID")+","+Eval("FileID")%>'></asp:LinkButton>
                            </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
                <td>
                    <iframe id="ifDisplayPdf" runat="server" width="250" height="250" visible="false">
                    </iframe>
                </td>
            </tr>
        </table>
        <asp:Panel ID="pnlParent" runat="server" CssClass="w-100p" BorderColor="Black" BorderWidth="0px"
            BorderStyle="Solid" Font-Bold="True" GroupingText="Delete Uploaded OutSource Docs" Style="display: none;">
            <table id="tblDeleteDoc" runat="server" class="defaultfontcolor searchPanel">
                <tr>
                    <td>
                        <asp:Label runat="server" ID="s1" Text="select all" Visible="false"></asp:Label>
                        <asp:CheckBox ID="chkDocAll" AutoPostBack="false" runat="server" onclick="CheckAll();"
                            Visible="false" Text="Select All" ToolTip="select row" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:CheckBoxList ID="chkDocs" RepeatColumns="1" runat="server">
                        </asp:CheckBoxList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClientClick="javascript:return checkDocs();"
                            CssClass="btn" OnClick="btnDelete_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <table class="defaultfontcolor w-100p searchPanel">
            <tr>
                <td>
                    <PFU:PatientFileUploader ID="PatientFileUploader" runat="server" OnClick="PatientFileUploader_Click" />
                </td>
            </tr>
            <tr>
                <td class="a-center">
                    <asp:Button runat="server" ID="btdGoBack" CssClass="btn" Text="Go Back" OnClick="btdGoBack_Click"
                        meta:resourcekey="btdGoBackResource1" />
                </td>
            </tr>
        </table>
    </div>
    <input type="hidden" id="hdnFileValue" runat="server" />
    <input type="hidden" runat="server" id="hdnFileType" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
