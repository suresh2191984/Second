<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProceduresBill.ascx.cs"
    Inherits="CommonControls_ProceduresBill" %>
<%--
<script src="../Scripts/Common.js" type="text/javascript"></script>--%>

<script language="javascript" type="text/javascript">
    function chkProcedures() {

        var value = document.getElementById('<%= ddlProcedureName.ClientID %>').value;

        var invisibleSlots = document.getElementById('<%= ddlTempProcName.ClientID %>');
        var SpecSlots = document.getElementById('<%= ddlTempProcAndSpec.ClientID %>');
        var drpSlots = document.getElementById('<%= ddlProcName.ClientID %>');

        var intVisibleCount = 0;
        intVisibleCount = invisibleSlots.length;
        var i = 0;

        drpSlots.options.length = 0;

        var optn = document.createElement("option");
        drpSlots.options.add(optn);
        optn.text = "--Select--";
        optn.value = "0";

        for (i = 0; i < SpecSlots.length; i++) {
            var SelVAl = SpecSlots.options[i].text;
            if (SelVAl == value) {
                var j = 0;
                var selobj = SpecSlots.options[i].value;
                for (j = 0; j < invisibleSlots.length; j++) {
                    var SelVals = invisibleSlots.options[j].value;
                    if (SelVals == selobj) {

                        var opt = document.createElement("option");
                        drpSlots.options.add(opt);
                        opt.text = invisibleSlots.options[i].text;
                        opt.value = SelVals;
                    }
                }

            }


        }
    }

    function selProcedures() {

        var drpSlots = document.getElementById('<%= ddlProcName.ClientID %>');

        var drpSpeciality = document.getElementById('<%= ddlProcedureName.ClientID %>');
        var phyName = drpSlots.options[drpSlots.selectedIndex].text;

        var speName = drpSpeciality.options[drpSpeciality.selectedIndex].text;



        if (phyName != "--Select--") {

            var amountval = phyName.split('<%=CurrencyName %>')[1].split('-')[1];
            CmdAddBillItemsType_onclick('PRO', drpSlots.value, drpSpeciality.value, phyName.split('<%=CurrencyName %>')[0].split(':')[0], 1, amountval, amountval);
        }
        else {
            alert("Please Select Procedure Type");
        }



    }
      
</script>

<table>
    <tr>
        <td class="a-center">
            <asp:Label ID="Rs_Sel_Pro_Type" runat="server" Text="Select Procedure Type :" meta:resourcekey="Rs_Sel_Pro_TypeResource1"></asp:Label>
            <asp:DropDownList ID="ddlProcedureName" CssClass="ddlsmall" runat="server" TabIndex="5" onChange="javascript:chkProcedures();"
                meta:resourcekey="ddlProcedureNameResource1">
            </asp:DropDownList>
            <asp:Label ID="Rs_Select_Procedure" runat="server" Text="Select Procedure : " meta:resourcekey="Rs_Select_ProcedureResource1"></asp:Label>
            <asp:DropDownList ID="ddlProcName" runat="server" CssClass="ddlsmall" TabIndex="3" meta:resourcekey="ddlProcNameResource1">
            </asp:DropDownList>
            <asp:DropDownList ID="ddlTempProcName" runat="server" CssClass="ddlsmall" Style="display: none;" meta:resourcekey="ddlTempProcNameResource1">
            </asp:DropDownList>
            <asp:DropDownList ID="ddlTempProcAndSpec" runat="server" CssClass="ddlsmall" Style="display: none;" meta:resourcekey="ddlTempProcAndSpecResource1">
            </asp:DropDownList>
            <input type="button" id="btnAdd" onclick="selProcedures();" class="btn" value="Add" />
        </td>
    </tr>
    <tr>
        <td>
        </td>
    </tr>
</table>
