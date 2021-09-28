<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TRFUpload.ascx.cs" Inherits="CommonControls_TRFUpload" %>


<script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>

<script type='text/javascript'>
    /* Common Alert Validation */
    var AlertType;

    $(document).ready(function() {
        AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
    });

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
        /* Added By Venkatesh S */
        AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
        var vSelectFile = SListForAppMsg.Get('CommonControls_TRFUpload_ascx_01') == null ? "Please select a file to add." : SListForAppMsg.Get('CommonControls_TRFUpload_ascx_01');
        var vSelectValidateFile = SListForAppMsg.Get('CommonControls_TRFUpload_ascx_02') == null ? "Please select valid file format" : SListForAppMsg.Get('CommonControls_TRFUpload_ascx_02');

        var IpFile = GetTopFile();
        if (IpFile == null || IpFile.value == null || IpFile.value.length == 0) {
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
            var userMsg = SListForApplicationMessages.Get('CommonControls\\TRFUpload.ascx_1');
            if (userMsg != null) {
               // alert(userMsg);
                ValidationWindow(userMsg, AlertType);
                return false;
            } else {
                ValidationWindow(vSelectFile, AlertType);
                return false;
            }
            return;
        }
        var fileExt = IpFile.value.split('.').pop();
        var valid_extensions = /(gif|GIF|jpg|JPG|png|PNG|bmp|BMP|jpeg|JPEG|pdf|PDF)$/i;
        if (!valid_extensions.test(fileExt)) {
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
        
            var userMsg = SListForApplicationMessages.Get('CommonControls\\TRFUpload.ascx_2');
            if (userMsg != null) {
                //alert(userMsg);
                ValidationWindow(userMsg, AlertType);
                return false;
            } else {
           // alert('' + vSelectValidateFile + ' (gif/jpg/png/bmp/jpeg/pdf)');

            ValidationWindow('' + vSelectValidateFile + ' (gif/jpg/png/bmp/jpeg/pdf)', AlertType);
                return false;
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
    }
    function CreateFile() {
        var IpFile = document.createElement('input');
        IpFile.id = IpFile.name = 'IpFile_' + Id++;
        IpFile.type = 'file';
        return IpFile;
    }
    function CreateItem(IpFile) {
        AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
    
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
        /* Added By Venkatesh S */
        AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
        
        var vBrowseFile = SListForAppMsg.Get('CommonControls_TRFUpload_ascx_03') == null ? "Please browse at least one file to upload." : SListForAppMsg.Get('CommonControls_TRFUpload_ascx_03');

        if (GetTotalItems() == 0) {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\TRFUpload.ascx_3');
            if (userMsg != null) {
                alert(userMsg);
                return false;
                
            } else {
                ValidationWindow(vBrowseFile, AlertType);
                return false;
            }
            return false;
        }
        GetTopFile().disabled = true;
        return true;
    }
</script>

<asp:Panel ID="pnlParent" runat="server" Width="300px" BorderColor="Black" BorderWidth="1px"
    BorderStyle="Solid" meta:resourcekey="pnlParentResource2">
    <asp:Panel ID="pnlFiles" runat="server" Width="300px" HorizontalAlign="Left" meta:resourcekey="pnlFilesResource2">
        <asp:Label ID="lblCaption" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="Small"
            ForeColor="Black" meta:resourcekey="lblCaptionResource2"></asp:Label>&nbsp;
        <br />
        <asp:FileUpload ID="IpFile" runat="server" meta:resourcekey="IpFileResource2" />
    </asp:Panel>
    <asp:Panel ID="pnlListBox" runat="server" Width="292px" BorderStyle="Inset" meta:resourcekey="pnlListBoxResource2">
    </asp:Panel>
    <asp:Panel ID="pnlButton" runat="server" Width="300px" HorizontalAlign="Right" >
        <button id="btnAdd" onclick="javascript:Add();" style="width: 60px" type="button"
            runat="server">
            <%=Resources.Reception_ClientDisplay.CommonControls_TRFUpload_ascx_01 %></button>
        <button id="btnClear" onclick="javascript:Clear();" style="width: 60px" type="button"
            value="Clear" runat="server">
            <%=Resources.Reception_ClientDisplay.CommonControls_TRFUpload_ascx_02 %></button>
        <asp:Button ID="btnUpload" OnClientClick="javascript:return DisableTop();" runat="server"
            Text="Upload" Width="60px" OnClick="btnUpload_Click" meta:resourcekey="btnUploadResource2" />
    </asp:Panel>
</asp:Panel>
