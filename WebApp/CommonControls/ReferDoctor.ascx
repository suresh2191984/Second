<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ReferDoctor.ascx.cs" Inherits="CommonControls_ReferDoctor" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<script language="javascript" type="text/javascript">
    function datachanged() {
        var ddlDoctor = document.getElementById('<%= ddlDoctor.ClientID %>');
        if (ddlDoctor.value == "Others") {
            document.getElementById('<%= divOtherDoctors.ClientID %>').style.display = 'block'
        }
        else {
            document.getElementById('<%= divOtherDoctors.ClientID %>').style.display = 'none'
        }
    }


    var ddlText, ddlValue, ddl, lblMesg;
    function CacheItems() {
        ddlText = new Array();
        ddlValue = new Array();
        ddl = document.getElementById("<%=ddlDoctor.ClientID %>");
        for (var i = 0; i < ddl.options.length; i++) {
            ddlText[ddlText.length] = ddl.options[i].text;
            ddlValue[ddlValue.length] = ddl.options[i].value;
        }
    }

    window.onload = CacheItems;


    function FilterItems(value) {
        value = value.toLowerCase();
        ddl.options.length = 0;
        for (var i = 0; i < ddlText.length; i++) {
            if (ddlText[i].toLowerCase().indexOf(value) != -1) {
                AddItem(ddlText[i], ddlValue[i]);
            }
        }

        if (ddl.options.length == 0) {
            AddItem("No Physician Found", "");
        }
    }

    function AddItem(text, value) {
        var opt = document.createElement("option");
        opt.text = text;
        opt.value = value;
        ddl.options.add(opt);
    }
    function AddPhysician() {

        var ddlPhy = document.getElementById("<%= ddlDoctor.ClientID %>");
        var ddlPhyLength = ddlPhy.options.length;
        for (var i = 0; i < ddlPhyLength; i++) {
            if (ddlPhy.options[i].selected) {


                if (ddlPhy.options[i].text != '--Select--') {

                    document.getElementById('<%= txtNew.ClientID %>').value = ddlPhy.options[i].text;

                }

            }

        }
    }
    
</script>

<table>
    <tr>
        <td>
            <asp:Label Text="Referred by Dr." runat="server" ID="lblProcedurename" meta:resourcekey="lblProcedurenameResource1"></asp:Label>
        </td>
        <td>
            &nbsp;&nbsp;
        </td>
        <td>
            <asp:TextBox ID="txtNew" runat="server" ToolTip="Enter Text Here" onkeyup="FilterItems(this.value)"
                onblur="AddPhysician()" meta:resourcekey="txtNewResource1" />
            <asp:DropDownList ID="ddlDoctor" runat="server" CssClass="ddlTheme12" onchange="javascript:datachanged();"
                meta:resourcekey="ddlDoctorResource1">
            </asp:DropDownList>
            <ajc:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtNew"
                WatermarkText="Type Physician Name" Enabled="True" />
        </td>
        <td>
            &nbsp;&nbsp;
        </td>
        <td>
            <div id="divOtherDoctors" runat="server" style="display: none">
                <asp:Label ID="Rs_Dr" runat="server" Text="Dr." meta:resourcekey="Rs_DrResource1"></asp:Label>
                <asp:TextBox ID="txtOtherDoctors" runat="server" meta:resourcekey="txtOtherDoctorsResource1"></asp:TextBox>
            </div>
        </td>
    </tr>
</table>
