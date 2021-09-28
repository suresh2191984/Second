<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvCreateUpdate.aspx.cs"
    Inherits="InvestigationBulkData_InvCreateUpdate" %>

<%@ Register Src="~/CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>

    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript">
        function checkexlfileornot() {
            var selectedfileformat = document.getElementById('ddlfiletype').value;
            if (selectedfileformat != '0') {
                var selectedtype = document.getElementById('ddltype').value;
                if (selectedtype!=0)
                {               
                var fileElement = document.getElementById('<%=fileupload1.ClientID%>');
                if (fileElement.value != '') {
                    var fileExtension = "";
                    if (fileElement.value.lastIndexOf(".") > 0) {
                        fileExtension = fileElement.value.substring(fileElement.value.lastIndexOf(".") + 1, fileElement.value.length);
                    }
                    if (selectedfileformat == '1' && fileExtension == "csv") {
                        var selectedfile = fileElement.value.substring(fileElement.value.lastIndexOf('\\') + 1, fileElement.value.length);
                        var FileName = selectedfile.split(".")[0];
                        if (selectedtype == "TestMaster" && FileName == "Testmaster") {
                            return true;
                        }
                        else if (selectedtype == "GroupMaster" && FileName == "Groupmaster") {
                            return true;
                        }
                        else if (selectedtype == "PackageMaster" && FileName == "Packagemaster") {
                            return true;
                        }
                        else if (selectedtype == "GroupContentMaster" && FileName == "Groupcontent") {
                            return true;
                        }
                        else if (selectedtype == "Packagecontent" && FileName == "Packagecontent") {
                            return true;
                        }
                        else {
                            alert("Incorrect Excel sheet");
                            return false;
                        }
                    }
                    // else {
                    //alert("Upload a .csv file");
                    //return false;
                    // }
                    else if (selectedfileformat == '2' && (fileExtension == "xlsx" || fileExtension == "xls")) {
                        return true;
                    }
                    else {
                        alert("select correct file type and format");
                        return false;
                    }
                }
                else {
                    alert("Please Upload a file");
                    return false;
                }
            }
            else {
                alert("Select the content type");
                return false;
            }
            }
            else {
                alert("Select the file type");
                return false;
            }
        }
        function ClearFields() {
            document.getElementById('<%=fileupload1.ClientID%>').value = '';
        }
        function GetTemplateFormat() {
            var selectedtype = document.getElementById('ddltype').value;
            if (selectedtype != '0') {
                if (selectedtype == "TestMaster") {
                    window.open("../BulkDataUploadformat/Testmaster.csv");
                }
                if (selectedtype == "GroupMaster") {
                    window.open("../BulkDataUploadformat/Groupmaster.csv");
                }
                if (selectedtype == "PackageMaster") {
                    window.open("../BulkDataUploadformat/Packagemaster.csv");
                }
                if (selectedtype == "GroupContentMaster") {
                    window.open("../BulkDataUploadformat/Groupcontent.csv");
                }
                if (selectedtype == "Packagecontent") {
                    window.open("../BulkDataUploadformat/Packagecontent.csv");
                }
            }
            else {
                alert("Select the type");
            }
        }  
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata" style="height: 490px;">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table border="0" cellpadding="2" cellspacing="1" class="tabledata searchPanel w-100p">
                <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="Select File Type"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlfiletype" runat="server">
                            <asp:ListItem Value="0">--Select--</asp:ListItem>
                            <asp:ListItem Value="1">CSV</asp:ListItem>
                            <asp:ListItem Value="2">Excel</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbltype" runat="server" Text="Select Type"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddltype" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Button ID="btnloadsheet" runat="server" Text="Load Excel Template" OnClientClick="javascript:return GetTemplateFormat();" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblselectfile" runat="server" Text="Select the file"></asp:Label>
                        </td>
                        <td>
                            <asp:FileUpload ID="fileupload1" CssClass="f-browse" runat="server" />
                            <%--</td>
                            <td>--%>
                            <asp:Button ID="btnclear" runat="server" OnClientClick="ClearFields()" Text="Clear" />
                            <asp:Button ID="btnupload" runat="server" CssClass="f-upload" OnClick="btnupload_Click"
                                OnClientClick="javascript:return checkexlfileornot();" Text="Upload" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnupload" />
            </Triggers>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="updatePanel2" runat="server">
            <ContentTemplate>
                <asp:Panel ID="Pnl" runat="server">
                    <table class="w-100p" cellpadding="3" cellspacing="3">
                        <tr>
                            <td class="a-center">
                                <asp:GridView ID="grderrorinfo" runat="server" HeaderStyle-CssClass="dataheader1"
                                    CssClass="gridView w-50p m-auto" ForeColor="#333333" CellPadding="5" CellSpacing="5"
                                    AllowPaging="true" PageSize="10" AutoGenerateColumns="false" OnPageIndexChanging="grderrorinfo_PageIndexChanging"
                                    Caption="Error Information" Font-Names="arial" Font-Size="12px" Visible="false">
                                    <Columns>
                                        <asp:BoundField DataField="T_Code" HeaderText="TCODE" />
                                        <asp:BoundField DataField="ErrorType" HeaderText="Error Type" />
                                    </Columns>
                                    <%--    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />--%>
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
        <%--Log Info grid--%>
        <asp:UpdatePanel ID="updatePaneloginfo" runat="server">
            <ContentTemplate>
                <asp:Panel ID="Panelloginfo" runat="server">
                    <table class="w-100p" cellpadding="3" cellspacing="3">
                        <tr>
                            <td>
                                <asp:GridView ID="grdloginfo" runat="server" HeaderStyle-CssClass="dataheader1" CssClass="gridView w-100p"
                                    ForeColor="#333333" CellPadding="5" CellSpacing="5" AllowPaging="true" PageSize="10"
                                    AutoGenerateColumns="false" Caption="Log Information" Font-Names="arial" Font-Size="12px"
                                    OnPageIndexChanging="grdloginfo_PageIndexChanging">
                                    <Columns>
                                        <asp:BoundField DataField="CreatedAt" HeaderText="Date/Time" />
                                        <asp:BoundField DataField="TestType" HeaderText="File Type" />
                                        <asp:BoundField DataField="UploadedFilename" HeaderText="File Name" />
                                        <asp:BoundField DataField="Username" HeaderText="User Name" />
                                        <asp:BoundField DataField="UploadedStatus" HeaderText="Status" />
                                    </Columns>
                                    <%--<PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />--%>
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    </form>
</body>
</html>
