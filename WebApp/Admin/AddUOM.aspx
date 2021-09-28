<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddUOM.aspx.cs" Inherits="Admin_ChangeUOM" meta:resourcekey="PageResource1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body id="oneColLayout">
    <form id="form1" runat="server">
      <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table>
    <tr>
        <td>
            <asp:Label ID="lblUOMCode" Text="UOM Code" runat="server" />
            <asp:TextBox ID="txtUOMCode" runat="server" />
        </td>
        <td>
            <asp:Label ID="lblUOM" Text="UOM" runat="server" />
            <asp:TextBox ID="txtUOM" runat="server" />
            <button id="btnUOMAdd" >ADD</button>
        </td>
    </tr>
    <tr>
    <td colspan="2">
    <table width="450px" height="450px" class="dataheaderInvCtrl">
    <tr>
        <td>
            <asp:DataList ID="dlUOMCode" runat="server"
                CellPadding="4" GridLines="Horizontal"
                RepeatColumns="8" 
                onitemdatabound="dlUOMCode_ItemDataBound" 
                meta:resourcekey="dlUOMCodeResource1">
                <ItemTemplate>
                    <table>
                        <tr>
                            <td>
                                <asp:RadioButton ID="rbUOMCode" runat="server" Text='<%# Bind("UOMCode") %>' 
                                    meta:resourcekey="rbUOMCodeResource1" />
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>
            
        </td>
    </tr>
    </table>
    </td>
    </tr></table>
    </form>

    
</body>
<script src="../Scripts/jquery-1.10.2.min.js" type="text/javascript"></script>
<link href="../Scripts/CustomAlerts/jquery.alerts.css" rel="stylesheet" type="text/css" />
<script src="../Scripts/CustomAlerts/jquery.alerts.js" type="text/javascript"></script>
<script type="text/javascript">
   
    $('#txtUOMCode').blur(function() {
        var vparams = {};
        vparams.UOMCode = $("#txtUOMCode").val();
        vparams.UOMDescription = $("#txtUOM").val();
        $.ajax({
            type: "POST",
            url: 'AddUOM.aspx/IsUOMCodeExists',
            data: JSON.stringify(vparams),
            contentType: "application/json; charset=utf-8",
            dataType: 'json',
            success: function(data) {
                var count = data.d;
                if (count == 1) {
                    $("#txtUOMCode").val('');
                    $("#txtUOMCode").focus();
                    alert("The UOM Code is Already Exists..");
                }

            },
            error: function(err) {
                alert('Error While Saving UOM..');
            }
        });
    });
    $(document).ready(function() { 
        $('#btnUOMAdd').click(function() {
            AddUOM();
        });
    });
    function AddUOM() {
        if (validation()) {
            var vparams = {};
            vparams.UOMCode = $("#txtUOMCode").val();
            vparams.UOMDescription = $("#txtUOM").val();
            $.ajax({
                type: "POST",
                url: 'AddUOM.aspx/AddUOM',
                data: JSON.stringify(vparams),
                contentType: "application/json; charset=utf-8",
                dataType: 'json',
                async: false,
                success: function(data) {
                    var UOMID = data.d;
                    //jConfirm('UOM Code Saved Successfully..Do you want to Assign this UOMCode?', 'Confirmation Dialog', function(ReturnResponse) {
                    var ReturnResponse = confirm("UOM Code Saved Successfully..Do you want to Assign this UOMCode?");
                        if (ReturnResponse) {
                            SelectUOMCode(UOMID, $('#txtUOMCode').val());
                        }
                        else {
                            $("#txtUOMCode").val('');
                            $("#txtUOM").val('');
                        }
                    //});
                    return false;
                },
                error: function(err) {
                    alert('Error While Saving UOM..');
                }
            });
        }
        
    }
    function SelectUOMCode(uomID, uomCode) {
        var rid = "TabContainer1_TabTestMaster_TM_TabContainer1_TabRangeMapping_hypLnkUOM";
        window.opener.SelectUOMCode1(rid, uomID, uomCode);
        window.close();
    }
    function validation() {
        if ($("#txtUOMCode").val() == '') {
            alert('Provide the values for UOMCode');
            return false;
        }
        if ($("#txtUOM").val() == '') {
            alert('Provide the values for UOM');
            return false;
        }
        return true;
    }
   
</script>
</html>
