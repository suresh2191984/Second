<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ReferedPhysician.ascx.cs"
    Inherits="CommonControls_ReferedPhysician" %>
<%@ Register Src="AddingRefPhysician.ascx" TagName="AddingRef" TagPrefix="uc8" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<style type="text/css">
    .style1
    {
        width: 20%;
    }
</style>
  <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../Scripts/jquery-1.2.2.pack.js"></script>

<%--<script type="text/javascript">
    $(function() {
        var $txt = $('input[id$=txtNew]');
        var $ddl = $('select[id$=ddlConsultingName]');
        var $items = $('select[id$=ddlConsultingName] option');

        $txt.keyup(function() {
            searchDdl($txt.val());
            
        });

        function searchDdl(item) {
            $ddl.empty();
            var exp = new RegExp(item, "i");
            var arr = $.grep($items,
                    function(n) {
                        return exp.test($(n).text());
                    });

            if (arr.length > 0) {
                countItemsFound(arr.length);
                $.each(arr, function() {
                    $ddl.append(this);
                    $ddl.get(0).selectedIndex = 0;
                }
                    );
            }
            else {
                countItemsFound(arr.length);
                $ddl.append("<option>No Physician Found</option>");
            }
        }

        function countItemsFound(num) {
            $("#para").empty();
            if ($txt.val().length) {
                $("#para").html(num + " items found");
            }

        }
    });

    function AddPhysician() {

        var ddlPhy = document.getElementById("<%= ddlConsultingName.ClientID %>");
        var ddlPhyLength = ddlPhy.options.length;
        for (var i = 0; i < ddlPhyLength; i++) {
            if (ddlPhy.options[i].selected) {
            
            
                if (ddlPhy.options[i].text != '-----Select-----') {
                     
                    document.getElementById('<%= txtNew.ClientID %>').value = ddlPhy.options[i].text;
                     
                }

            }

        }
    
    
    }

    </script>--%>

<script type="text/javascript">

   
    var ddlText1, ddlValue1, ddlConName, lblMesg;
    function RefCacheItems() {

        ddlText1 = new Array();
        ddlValue1 = new Array();
        ddlConName = document.getElementById("<%=ddlConsultingName.ClientID %>");
        for (var i = 0; i < ddlConName.options.length; i++) {
            ddlText1[ddlText1.length] = ddlConName.options[i].text;
            ddlValue1[ddlValue1.length] = ddlConName.options[i].value;
        }
    }

   

    function RefFilterItems(value) {

        ddlConName.options.length = 0;
        for (var i = 0; i < ddlText1.length; i++) {
            if (ddlText1[i].toLowerCase().indexOf(value) != -1) {
                RefAddItem(ddlText1[i], ddlValue1[i]);
            }
        }

        if (ddlConName.options.length == 0) {
            RefAddItem("No Physician Found", "");
        }
    }

    function RefAddItem(text, value) {
        
        var opt = document.createElement("option");
        opt.text = text;
        opt.value = value;
        ddlConName.options.add(opt);
    }
    function RefAddPhysician() {

        var ddlPhy = document.getElementById("<%= ddlConsultingName.ClientID %>");
        var ddlPhyLength = ddlPhy.options.length;
        for (var i = 0; i < ddlPhyLength; i++) {
            if (ddlPhy.options[i].selected) {


                if (ddlPhy.options[i].text != '-----Select-----') {

                    document.getElementById('<%= txtNew.ClientID %>').value = ddlPhy.options[i].text;

                }
                else {
                    document.getElementById('<%= txtNew.ClientID %>').focus();
                }

            }

        }
        
    }
    
</script>

<table class="defaultfontcolor">
    <tr class="h-15">
        <td colspan="6" class="a-left h-15">
            <asp:Label ID="lbl" runat="server" Text="Referring Physician" Font-Bold="True" meta:resourcekey="lblResource1"></asp:Label>
        </td>
    </tr>
    <tr class="h-2">
        <td>
        </td>
    </tr>
    <tr>
        <td class="v-top w-5p a-left">
            <asp:Label ID="lblConsultingName" runat="server" Text="Name:" meta:resourcekey="lblConsultingNameResource1"></asp:Label>
        </td>
        <td class="v-top w-8p a-left" nowrap="nowrap">
            <asp:TextBox ID="txtNew" runat="server" CssClass="small" ToolTip="Enter Text Here"
                onkeyup="RefFilterItems(this.value)" onblur="RefAddPhysician()"></asp:TextBox>
            <ajc:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtNew"
                WatermarkText="Type Physician Name" Enabled="True" />
            &nbsp;&nbsp;&nbsp;
        </td>
        <td nowrap="nowrap" class="v-top w-8p a-left">
            <div id="divConsultingName">
                <asp:UpdatePanel ID="pnlConsulting" runat="server">
                    <ContentTemplate>
                        <asp:DropDownList ID="ddlConsultingName" ToolTip="Click here to Select Refering Physician"
                            onchange="RefAddPhysician()" CssClass="ddlsmall" runat="server" meta:resourcekey="ddlConsultingNameResource1">
                        </asp:DropDownList>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <!-- OnSelectedIndexChanged="ddlConsultingName_SelectedIndexChanged"> -->
        </td>
        <td class="v-top w-7p a-left">
            <uc8:AddingRef ID="AddingRefPhysician" runat="server" />
        </td>
        <td class="v-top w-5p a-left">
            <asp:Label ID="lblSpeciality" runat="server" Text="Speciality:" meta:resourcekey="lblSpecialityResource1"></asp:Label>
        </td>
        <td class="v-top a-left style1">
            <div>
                <asp:UpdatePanel ID="pnlSpeciality" runat="server">
                    <ContentTemplate>
                        <asp:DropDownList ID="ddlSpeciality" CssClass="ddlsmall" ToolTip="Click here to Select Speciality"
                            runat="server" meta:resourcekey="ddlSpecialityResource1">
                        </asp:DropDownList>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </td>
    </tr>
</table>

<script type="text/javascript">
    RefCacheItems();
</script>

