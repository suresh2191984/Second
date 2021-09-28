<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HL7MessageFileUploader.ascx.cs" Inherits="CommonControls_HL7MessageFileUploader" %> 
<%--CodeFile="HL7MessageFileUploader.ascx.cs" Inherits="CommonControls_HL7MessageFileUploader"--%> 
<script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>

  
  
  <script>
      $('#btUpload').click(function() {
          if (fileUpload.value.length == 0) {    // CHECK IF FILE(S) SELECTED.
              alert('No files selected.');
              return false;
          }
      });
</script>
<script type='text/javascript'>
    var Id = 0;
    var MAX = 0;
    var DivFiles;
    var DivListBox;
    var BtnAdd;
    $(function() {
       DivFiles = document.getElementById('<%= pnlFiles.ClientID %>');
       // DivListBox = document.getElementById('<%= pnlListBox.ClientID %>');
       DivListBox = document.getElementById('pnlList').innerHTML;
        BtnAdd = document.getElementById('<%= btnAdd.ClientID %>');
    });
    function Add() {
      var IpFile = GetTopFile();
        if (IpFile == null || IpFile.value == null || IpFile.value.length == 0) {

            alert('Please select a file to add.');
            return false;
           }
           
        
        var fileExt = IpFile.value.split('.').pop();
        var valid_extensions = /(HL7|hl7)$/i;
        if (!valid_extensions.test(fileExt)) {
           
                alert('Please select valid file format (HL7)');
           
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
        
        //document.getElementById('<%= ddlFileType.ClientID %>').disabled = true;     
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
        
//        var B = document.createElement('b');
//        B.innerHTML =" -FileType : "+ FileType + '&nbsp;&nbsp;';
//        B.id = 'B_' + Id++;
//        B.href = '#';
//       
//         
//        Item.appendChild(B);
        
//        var A = document.createElement('a');
//        A.innerHTML = 'Delete';
//        A.id = 'A_' + Id++;
//        A.href = '#';
//        A.style.color = 'blue';
//        A.onclick = function() {
//            DivFiles.removeChild(document.getElementById(this.parentNode.value));
//            DivListBox.removeChild(this.parentNode);
//            if (MAX != 0 && GetTotalFiles() - 1 < MAX) {
//                GetTopFile().disabled = false;
//                BtnAdd.disabled = false;
//            }
//        }
//        Item.appendChild(A);
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
        document.getElementById('pnlList').innerHTML = "";
        //DivFiles.innerHTML = '';
        
        //DivFiles.appendChild(CreateFile());
       // BtnAdd.disabled = false;
    }
    function GetTopFile() {
        var Inputs = DivFiles.getElementsByTagName('input');
        var IpFile = null;


        for (var n = 0; n < Inputs.length; n++) {      //&& Inputs[n].type == 'file'
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
            var userMsg = SListForApplicationMessages.Get('CommonControls\\HL7MessageFileUploader.ascx_3');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert('Please browse at least one file to upload.');
            }
            return false;
        }
        GetTopFile().disabled = true;
        document.getElementById('<%= ddlFileType.ClientID %>').disabled = false;
      //  var ddlaction = document.getElementById('<%= ddlFileType.ClientID %>');
       // document.getElementById('hdnFileType').value = ddlaction.options[ddlaction.selectedIndex].value;
        return true;
    }
    function GetFileSizeNameAndType() {
        var fi = document.getElementById('IpFile'); // GET THE FILE INPUT AS VARIABLE.

        var totalFileSize = 0;

        // VALIDATE OR CHECK IF ANY FILE IS SELECTED.
        if (fi.files.length > 0) {
            // RUN A LOOP TO CHECK EACH SELECTED FILE.
            for (var i = 0; i <= fi.files.length - 1; i++) {
                //ACCESS THE SIZE PROPERTY OF THE ITEM OBJECT IN FILES COLLECTION. IN THIS WAY ALSO GET OTHER PROPERTIES LIKE FILENAME AND FILETYPE
                var fsize = fi.files.item(i).size;
                totalFileSize = totalFileSize + fsize;
                document.getElementById('pnlList').innerHTML =
                document.getElementById('pnlList').innerHTML
                +
                '<br /> ' + 'File Name is <b>' + fi.files.item(i).name
                +
                '</b> and Size is <b>' + Math.round((fsize / 1024)) //DEFAULT SIZE IS IN BYTES SO WE DIVIDING BY 1024 TO CONVERT IT IN KB
                +
                '</b> KB and File Type is <b>' + fi.files.item(i).type + "</b>.";
            }
        }
        //document.getElementById('divTotalSize').innerHTML = "Total File(s) Size is <b>" + Math.round(totalFileSize / 1024) + "</b> KB";
    }

</script>


<script>
    function FileDetails() {

        // GET THE FILE INPUT.
        var fi = document.getElementById('file');

        // VALIDATE OR CHECK IF ANY FILE IS SELECTED.
        if (fi.files.length > 0) {

            // THE TOTAL FILE COUNT.
            document.getElementById('fp').innerHTML =
                'Total Files: <b>' + fi.files.length + '</b></br >';

            // RUN A LOOP TO CHECK EACH SELECTED FILE.
            for (var i = 0; i <= fi.files.length - 1; i++) {

                var fname = fi.files.item(i).name;      // THE NAME OF THE FILE.
                var fsize = fi.files.item(i).size;      // THE SIZE OF THE FILE.

                // SHOW THE EXTRACTED DETAILS OF THE FILE.
                document.getElementById('fp').innerHTML =
                    document.getElementById('fp').innerHTML + '<br /> ' +
                        fname + ' (<b>' + fsize + '</b> bytes)';
            }
        }
        else {
            alert('Please select a file.')
        }
    }
</script>

 <%--Parthi Added--%>
<script type="text/javascript">
    var selDiv = "";

    document.addEventListener("DOMContentLoaded", init, false);

    function init() {
        document.querySelector('#IpFile').addEventListener('change', handleFileSelect, false);
        selDiv = document.querySelector("#pnlList"); 
    }

    function handleFileSelect(e) {

        if (!e.target.files) return;

        selDiv.innerHTML = "";

        var files = e.target.files;
        for (var i = 0; i < files.length; i++) {
            var f = files[i];

            selDiv.innerHTML += f.name + "<br/>";

        }

    }
    </script>

<asp:Panel ID="pnlParent" runat="server" CssClass="w-100p" BorderColor="Black" BorderWidth="0px"  
    BorderStyle="Solid" Font-Bold="True" Font-Size="Large"   GroupingText="File Upload" meta:resourcekey="pnlParentResource1">
    <table class="w-100p" style="font-family:Sans-Serif:Gabriola">
        <tr>
            <td visible="false">
                <asp:Panel ID="Panel1" runat="server" Width="110px" HorizontalAlign="Left" meta:resourcekey="Panel1Resource1">
                    <asp:Label ID="lblType" runat="server" Font-Bold="False"   Text="Select File Type"
                        meta:resourcekey="lblTypeResource1"></asp:Label>
                </asp:Panel>
            </td>
            <td visible="false">
                <asp:Panel ID="Panel2" runat="server" HorizontalAlign="Left" meta:resourcekey="Panel2Resource1">
                    <span class="richcombobox">
                        <asp:DropDownList ID="ddlFileType" CssClass="ddlsmall" runat="server" 
                        meta:resourcekey="ddlFileTypeResource1" Enabled="false">
                        <asp:ListItem>HL7</asp:ListItem>
                        </asp:DropDownList>
                    </span>
                </asp:Panel>
            </td>
            <td>
           <%--  <asp:FileUpload ID="FileUpload1" AllowMultiple="true" runat="server" meta:resourcekey="IpFileResource1" />--%>
                <asp:Panel ID="pnlFiles" runat="server" Width="280px" HorizontalAlign="Left" meta:resourcekey="pnlFilesResource1">
                     
                  <input type="file" name="img" accept=".HL7"  id="IpFile" multiple  />
             <%--  <asp:FileUpload ID="IpFile"  runat="server" meta:resourcekey="IpFileResource1" />--%></asp:Panel>
            </td>
            
            <td class="a-center">
                <table class="w-100p">
                    <tr>
                        <td class="a-center">
                            <input id="btnAdd" class="btn1"  type="button"   onclick="javascript:Add();" visible="false"   
                                runat="server" value="Add" meta:resourcekey="btnAddResource1" />    <%-- onclick="FileDetails()"  --%>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center">
                            <input id="btnClear" class="btn1" onclick="javascript:Clear();" type="button" value="Clear" runat="server" meta:resourcekey="btnClearResource1"  />
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                <asp:Panel ID="pnlListBox" runat="server" Width="400px" BorderStyle="Inset" meta:resourcekey="pnlListBoxResource1" Visible="false">
                </asp:Panel>
             
                <div id="pnlList" style="width:300px ; height:150px; background-color:#CCD6D4; border-style:inset;overflow: auto;" ></div>
            </td>
            <td class="a-center">
                <asp:Button ID="btnUpload" class="btn1" OnClientClick="javascript:return DisableTop();"
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

