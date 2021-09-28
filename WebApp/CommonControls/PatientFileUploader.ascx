<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PatientFileUploader.ascx.cs"
    Inherits="CommonControls_PatientFileUploader" %>

<%--<script src="../Scripts/jquery-1.3.2.min.js" type="text/javascript"></script>--%>

<script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>
<%--<link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />--%>

<script type='text/javascript'>
    var Id = 0;
    var MAX = 0;
    var DivFiles;
    var DivListBox;
    var BtnAdd;
    $(function() {
        DivFiles = document.getElementById('<%= pnlFiles.ClientID %>');
        DivListBox = document.getElementById('<%= pnlListBox.ClientID %>');
        BtnAdd = document.getElementById('<%= btnAdd.ClientID %>');
    });
    function Add() {
        var strAlert = SListForAppMsg.Get('CommonControls_PatientFileUploader_ascx_03') == null ? "Alert" : SListForAppMsg.Get('CommonControls_PatientFileUploader_ascx_03');
        var strNoBillAddToClient = SListForAppMsg.Get('CommonControls_PatientFileUploader_ascx_08') == null ? "Please select a file to add." : SListForAppMsg.Get('CommonControls_PatientFileUploader_ascx_08');
        var strvalid = SListForAppMsg.Get('CommonControls_PatientFileUploader_ascx_09') == null ? "Please select valid file format (gif/jpg/png/bmp/jpeg/pdf)" : SListForAppMsg.Get('CommonControls_PatientFileUploader_ascx_09');
        var IpFile = GetTopFile();
        if (IpFile == null || IpFile.value == null || IpFile.value.length == 0) {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\PatientFileUploader.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                ValidationWindow(strNoBillAddToClient, strAlert);
            //    alert('Please select a file to add.');
             }
            return;
        }
        var fileExt = IpFile.value.split('.').pop();
        var valid_extensions = /(gif|GIF|jpg|JPG|png|PNG|bmp|BMP|jpeg|JPEG|pdf|PDF)$/i;
        if (!valid_extensions.test(fileExt)) {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\PatientFileUploader.ascx_2');
            if (userMsg != null) {
                alert(userMsg);
            } else {
            ValidationWindow(strvalid, strAlert);
                //alert('Please select valid file format (gif/jpg/png/bmp/jpeg/pdf)');
            }
            return;
        }
        var NewIpFile = CreateFile();
        DivFiles.insertBefore(NewIpFile, IpFile);
        if (MAX != 0 && GetTotalFiles() - 1 == MAX) {
            NewIpFile.disabled = true;
            BtnAdd.disabled = true;
        }
        IpFile.style.display = 'none';
        DivListBox.appendChild(CreateItem(IpFile));
        document.getElementById('<%= ddlFileType.ClientID %>').disabled = true;     
    }
    function CreateFile() {
        var IpFile = document.createElement('input');
        IpFile.id = IpFile.name = 'IpFile_' + Id++;
        IpFile.type = 'file';
        return IpFile;
    }
    function CreateItem(IpFile) {
        var Item = document.createElement('div');
        Item.style.backgroundColor = '#C6790B';
        Item.style.fontWeight = 'normal';
        Item.style.textAlign = 'left';
        Item.style.verticalAlign = 'middle';
        Item.style.cursor = 'default';
        Item.style.height = 20 + 'px';
        var Splits = IpFile.value.split('\\');
        Item.innerHTML = Splits[Splits.length - 1] + '&nbsp;';
        Item.value = IpFile.id;
        Item.title = IpFile.value;

        
        var obj = document.getElementById('<%=ddlFileType.ClientID%>');
        var FileType = obj.options[obj.selectedIndex].text;

        document.getElementById('hdnFileValue').value += Splits[Splits.length - 1] + "~" + FileType + "^";
        
        var B = document.createElement('b');
        B.innerHTML =" -FileType : "+ FileType + '&nbsp;&nbsp;';
        B.id = 'B_' + Id++;
        B.href = '#';
        //B.style.color = 'black';
         
        Item.appendChild(B);
        
        var A = document.createElement('a');
        A.innerHTML = 'Delete';
        A.id = 'A_' + Id++;
        A.href = '#';
        A.style.color = 'blue';
        A.onclick = function() {
            DivFiles.removeChild(document.getElementById(this.parentNode.value));
            DivListBox.removeChild(this.parentNode);
            if (MAX != 0 && GetTotalFiles() - 1 < MAX) {
                GetTopFile().disabled = false;
                BtnAdd.disabled = false;
            }
        }
        Item.appendChild(A);
        Item.onmouseover = function() {
            Item.bgColor = Item.style.backgroundColor;
            Item.fColor = Item.style.color;
            Item.style.backgroundColor = '#C6790B';
            Item.style.color = '#ffffff';
            Item.style.fontWeight = 'bold';
        }
        Item.onmouseout = function() {
            Item.style.backgroundColor = Item.bgColor;
            Item.style.color = Item.fColor;
            Item.style.fontWeight = 'normal';
        }
        return Item;
    }
    function Clear() {
        DivListBox.innerHTML = '';
        DivFiles.innerHTML = '';
        DivFiles.appendChild(CreateFile());
        BtnAdd.disabled = false;
    }
    function GetTopFile() {
        var Inputs = DivFiles.getElementsByTagName('input');
        var IpFile = null;
        for (var n = 0; n < Inputs.length && Inputs[n].type == 'file'; ++n) {
            IpFile = Inputs[n];
            break;
        }
        return IpFile;
    }
    function GetTotalFiles() {
        var Inputs = DivFiles.getElementsByTagName('input');
        var Counter = 0;
        for (var n = 0; n < Inputs.length && Inputs[n].type == 'file'; ++n)
            Counter++;
        return Counter;
    }
    function GetTotalItems() {
        var Items = DivListBox.getElementsByTagName('div');
        return Items.length;
    }
    function DisableTop() {
        if (GetTotalItems() == 0) {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\PatientFileUploader.ascx_3');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert('Please browse at least one file to upload.');
            }
            return false;
        }
        GetTopFile().disabled = true;
        document.getElementById('<%= ddlFileType.ClientID %>').disabled = false;
        var ddlaction = document.getElementById('<%= ddlFileType.ClientID %>');
        document.getElementById('hdnFileType').value = ddlaction.options[ddlaction.selectedIndex].value;
        return true;
    }

</script>

<asp:Panel ID="pnlParent" runat="server" CssClass="w-100p" BorderColor="Black" BorderWidth="0px"
    BorderStyle="Solid" Font-Bold="True" GroupingText="File Upload" meta:resourcekey="pnlParentResource1">
    <table class="w-100p">
        <tr>
            <td>
                <asp:Panel ID="Panel1" runat="server" Width="110px" HorizontalAlign="Left" meta:resourcekey="Panel1Resource1">
                    <asp:Label ID="lblType" runat="server" Font-Bold="False" Text="Select File Type"
                        meta:resourcekey="lblTypeResource1"></asp:Label>
                </asp:Panel>
            </td>
            <td>
                <asp:Panel ID="Panel2" runat="server" HorizontalAlign="Left" meta:resourcekey="Panel2Resource1">
                    <span class="richcombobox">
                        <asp:DropDownList ID="ddlFileType" CssClass="ddlsmall" runat="server" meta:resourcekey="ddlFileTypeResource1">
                        </asp:DropDownList>
                    </span>
                </asp:Panel>
            </td>
            <td>
                <asp:Panel ID="pnlFiles" runat="server" Width="280px" HorizontalAlign="Left" meta:resourcekey="pnlFilesResource1">
                    <asp:FileUpload ID="IpFile" runat="server" meta:resourcekey="IpFileResource1" />
                </asp:Panel>
            </td>
            <td class="a-center">
                <table class="w-100p">
                    <tr>
                        <td class="a-center">
                            <input id="btnAdd" class="btn" onclick="javascript:Add();" type="button"
                                runat="server" value="Add" meta:resourcekey="btnAddResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center">
                            <input id="btnClear" class="btn" onclick="javascript:Clear();" type="button" value="Clear" runat="server" meta:resourcekey="btnClearResource1"/>
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                <asp:Panel ID="pnlListBox" runat="server" Width="400px" BorderStyle="Inset" meta:resourcekey="pnlListBoxResource1">
                </asp:Panel>
            </td>
            <td class="a-center">
                <asp:Button ID="btnUpload" class="btn" OnClientClick="javascript:return DisableTop();"
                    runat="server" Text="Upload" OnClick="btnUpload_Click" meta:resourcekey="btnUploadResource1" />
            </td>
        </tr>
    </table>
</asp:Panel>

<script type="text/javascript" language="javascript">

       $(function() {
           ChangeDDLItemListWidth();
       });
</script>

