<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FileUpload.ascx.cs" Inherits="CommonControls_FileUpload" %>
<script type='text/javascript'>
    var Id = 0;
    var MAX = 0;
    var DivFiles;
    var DivListBox;
    var BtnAdd;
    var Alert;
    $(document).ready(function() {
        Alert = SListForAppMsg.Get("CommonControls_Header_Alert") != null ? SListForAppMsg.Get("CommonControls_Header_Alert") : "Alert";
        var InformationMsg = SListForAppMsg.Get("CommonControls_FileUpload_ascx_03") != null ? SListForAppMsg.Get("CommonControls_FileUpload_ascx_03") : "Please select a file to add.";
        var InformationMsg1 = SListForAppMsg.Get("CommonControls_FileUpload_ascx_04") != null ? SListForAppMsg.Get("CommonControls_FileUpload_ascx_04") : "Please select valid file format (gif/jpg/png/bmp/jpeg/pdf)";
        var InformationMsg2 = SListForAppMsg.Get("CommonControls_FileUpload_ascx_05") != null ? SListForAppMsg.Get("CommonControls_FileUpload_ascx_05") : "Please browse at least one file to upload.";
    });
    $(function() {
        DivFiles = document.getElementById('<%= pnlFiles.ClientID %>');
        DivListBox = document.getElementById('<%= pnlListBox.ClientID %>');
        BtnAdd = document.getElementById('<%= btnAdd.ClientID %>');
    });
    function Add() {
       // //debugger;
        var IpFile = GetTopFile();
        if (IpFile == null || IpFile.value == null || IpFile.value.length == 0) {
            //alert('Please select a file to add.');
            ValidationWindow(InformationMsg + '  ' + length, Alert);
            return false;
        }
        var fileExt = IpFile.value.split('.').pop();
        var valid_extensions = /(gif|GIF|jpg|JPG|png|PNG|bmp|BMP|jpeg|JPEG|pdf|PDF)$/i;
        if (!valid_extensions.test(fileExt)) {
            //alert('Please select valid file format (gif/jpg/png/bmp/jpeg/pdf)');
            ValidationWindow(InformationMsg1 + '  ' + length, Alert);
            return false;
        }
        var NewIpFile = CreateFile();
        DivFiles.insertBefore(NewIpFile, IpFile);
        if (MAX != 0 && GetTotalFiles() - 1 == MAX) {
            NewIpFile.disabled = true;
            BtnAdd.disabled = true;
        }
        IpFile.style.display = 'none';
        DivListBox.appendChild(CreateItem(IpFile));
        return false;
    }
    function CreateFile() {
        var IpFile = document.createElement('input');
        IpFile.id = IpFile.name = 'IpFile_' + Id++;
        IpFile.type = 'file';
        return IpFile;
    }
    function CreateItem(IpFile) {
        var Item = document.createElement('div');
        Item.style.backgroundColor = '#ffffff';
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
        return false;
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
            //alert('Please browse at least one file to upload.');
            ValidationWindow(InformationMsg2 + '  ' + length, Alert);
            return false;
        }
        GetTopFile().disabled = true;
        return true;
    }
</script>

<asp:Panel ID="pnlParent" runat="server" Width="600px" BorderColor="Black" BorderWidth="0px"
    BorderStyle="Solid" GroupingText="File Upload" class="searchPanel padding10"
    meta:resourcekey="pnlParentResource1">
    <table class="w-100p">
    <tr>
    <td width="280px">
                <asp:Panel ID="pnlFiles" runat="server" Width="280px" HorizontalAlign="Left" meta:resourcekey="pnlFilesResource1">
                    <asp:FileUpload ID="IpFile" runat="server" meta:resourcekey="IpFileResource1" />
    </asp:Panel>
    </td>
    <td width="110px">
    <asp:Panel ID="Panel1" runat="server" Width="110px" HorizontalAlign="Left">
     <asp:Label ID="lblType" runat="server" Text="Select File Type" meta:resourcekey="lblTypeResource1"></asp:Label>
    </asp:Panel> 
    </td>
    <td>
                <asp:Panel ID="Panel2" runat="server" HorizontalAlign="Left" meta:resourcekey="Panel2Resource1">
                    <asp:DropDownList ID="ddlFileType" runat="server" meta:resourcekey="ddlFileTypeResource1">
                       <%-- <asp:ListItem Text="SOP" Value="0" Selected="True" meta:resourcekey="ListItemResource1"></asp:ListItem>
                        <asp:ListItem Text="MOU" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                        <asp:ListItem Text="SLA" Value="2" meta:resourcekey="ListItemResource3"></asp:ListItem>
                        <asp:ListItem Text="Price Sheet" Value="3" meta:resourcekey="ListItemResource4"></asp:ListItem>
                        <asp:ListItem Text="Others" Value="4" meta:resourcekey="ListItemResource5"></asp:ListItem>--%>
                    </asp:DropDownList>
       </asp:Panel> 
    </td>
  
    </tr>
    <tr>
    <td colspan="3">
                <asp:Panel ID="pnlListBox" runat="server" Width="400px" BorderStyle="Inset" meta:resourcekey="pnlListBoxResource1">
    </asp:Panel>
    </td>
    
    </tr>
    </table>
    <asp:Panel ID="pnlButton" runat="server" Width="300px" HorizontalAlign="Right" meta:resourcekey="pnlButtonResource1">
        <button id="btnAdd" onclick="javascript: return Add();" class="btn" runat="server">
            <%=Resources.CommonControls_AppMsg.CommonControls_FileUpload_ascx_01 %>
        </button>
        <button id="btnClear" onclick="javascript: return Clear();" class="btn" runat="server">
            <%=Resources.CommonControls_AppMsg.CommonControls_FileUpload_ascx_02 %></button>
        <asp:Button ID="btnUpload" OnClientClick="javascript:return DisableTop();" runat="server"
            Text="Upload" class="btn" OnClick="btnUpload_Click" Style="display: none;" meta:resourcekey="btnUploadResource1" />
    </asp:Panel>
  
</asp:Panel>
