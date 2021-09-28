<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Qualification.ascx.cs"
    Inherits="CommonControls_Qualification" %>
<tr>
    <td style="width: 171px;">
        <asp:Label ID="lblQualification" Text="Qualification" runat="server" meta:resourcekey="lblQualificationResource1" />
    </td>
    <td style="width: 300px;">
        <asp:DropDownList ID="ddlQualification" runat="server" onchange="fnGetQualificationValue(this,'0')"
            meta:resourcekey="ddlQualificationResource1">
        </asp:DropDownList>
    </td>
    <td id="tdlblDescriptions" style="width: 150px; display: none">
        <asp:Label ID="lblDescriptions" Text="Descriptions" runat="server" meta:resourcekey="lblDescriptionsResource1" />
    </td>
    <td id="tdddlDescriptions" style="display: none">
        <asp:DropDownList ID="ddlDescriptions" runat="server" onchange="fnGetDescriptionsValue(this)"
            meta:resourcekey="ddlDescriptionsResource1">
        </asp:DropDownList>
        <asp:HiddenField ID="hdnQualification" runat="server" />
        <asp:HiddenField ID="hdnDescriptions" runat="server" />
        <asp:HiddenField ID="hdnOrginID" runat="server" />
    </td>
</tr>

<script type="text/javascript">

    function fnGetQualificationValue(ele, selectedTxt) {      
        $('#<%=hdnQualification.ClientID%>').val('');
        $('#<%=hdnQualification.ClientID%>').val($('#Qualification_ddlQualification option:selected').val());
        fnGetQualification($('#Qualification_ddlQualification option:selected').val(), selectedTxt)
    }

    function fnGetDescriptionsValue(ele) {

        $('#<%=hdnDescriptions.ClientID%>').val('');
        $('#<%=hdnDescriptions.ClientID%>').val($('#Qualification_ddlDescriptions option:selected').val());
    }

    var varselectedTxt = 0;
    function fnGetQualification(val, selectedTxt) {
        varselectedTxt = selectedTxt;
        $.ajax({
            type: "POST",
            url: "../OPIPBilling.asmx/GetQualification",
            data: "{ 'type': '" + val + "','orgID': '" + $("#<%=hdnOrginID.ClientID%>").val() + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var Items = data.d;
                fnBindQualifaction(Items)
            },
            failure: function(msg) {

                var userMsg = SListForApplicationMessages.Get('CommonControls\\Qualification.ascx_1');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('error');
                    return false;
                }
            }
        });
    }


    function fnBindQualifaction(Items) {
        $('#<%=ddlDescriptions.ClientID%>').empty();
        $('#<%=ddlDescriptions.ClientID%>').append('<option value="' + '0' + '">' + '--select--' + '</option>');
        if (Items.length > 0) {
            document.getElementById('tdlblDescriptions').style.display = "block";
            document.getElementById('tdddlDescriptions').style.display = "block";
            $.each(Items, function(index, Item) {
                $('#<%=ddlDescriptions.ClientID%>').append('<option value="' + Item.Code + '">' + Item.Description + '</option>');
            });
        }
        document.getElementById("Qualification_ddlDescriptions").value = varselectedTxt;

    }
    
</script>

