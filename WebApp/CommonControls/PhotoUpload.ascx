<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PhotoUpload.ascx.cs" Inherits="CommonControls_PhotoUpload" %>
<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>

<script type="text/javascript">

    function ShowUpload(obj, id) {
   
        if (obj.checked) {
            $('[name$="PhotoUpload"]').show();
             
        }
        else{
            $('[name$="PhotoUpload"]').hide();
             if(document.getElementById('PhotoUpload')!=null&&document.getElementById('PhotoUpload')!=undefined )
             {
                document.getElementById('PhotoUpload').value='';
             }
        }
    }

    
    function SetValues() {
     
         
            $('input[name$="hdnPATNO"]').val($('input[name$="hdnPNO"]').val());
            $('input[name$="hdnPATID"]').val($('input[name$="hdnPID"]').val());
        
    }
</script>

<ul>
    <li>
        <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
    </li>
</ul>
<table border="0" cellpadding="0" cellspacing="0" width="50%">
    <tr>
        <td colspan="2">
            <img id="imgPatient" runat="server" alt="Patient Photo" src="~/Images/ProfileDefault.jpg" />
        </td>
    </tr>
    <tr>
        <td>
            <input id="chkUploadPhoto" runat="server" value="Upload" type="checkbox" onclick="ShowUpload(this, this.id);" />
            <label id="lblUploadPhoto" runat="server" for="chkUploadPhoto" style="color: #2C88B1;
                font-weight: bold;">
                <%=Resources.Reception_ClientDisplay.CommonControls_PhotoUpload_ascx_01 %></label>
        </td>
        <td>
            <div id="divRemovePhoto" runat="server" style="display: none;">
                <input id="chkRemovePhoto" runat="server" value="Remove" type="checkbox" onclick="RemovePhoto(this, this.id);" />
                <label for="chkRemovePhoto" style="color: #2C88B1; font-weight: bold;">
                    <%=Resources.Reception_ClientDisplay.CommonControls_PhotoUpload_ascx_02 %></label>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            &nbsp;
            <input id="PhotoUpload" type="file" runat="server" style="width: 150px; display: none;" />
            <asp:Button ID="btnadd" runat="server" Text="Go" OnClientClick="return SetValues()"
                OnClick="btnadd_Click" meta:resourcekey="btnaddResource1" />
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
</table>
<asp:HiddenField ID="hdnPatientImageName" runat="server" />
<asp:HiddenField ID="hdnPATNO" runat="server" />
<asp:HiddenField ID="hdnPATID" runat="server" />
