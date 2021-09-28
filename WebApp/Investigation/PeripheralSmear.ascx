<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PeripheralSmear.ascx.cs"
    Inherits="Investigation_PeripheralSmear" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<style type="text/css">
    .style1
    {
        height: 20px;
        width: 19%;
    }
    .listMain
    {
        width: 350px !important;
    }
</style>

<script language="javascript" type="text/javascript">
    function checkRadiobtn(id, ShowDDl) {
        //alert(id);
        var splirid = id.split('_');
        document.getElementById(splirid[0] + "_" + ShowDDl).style.display = 'block';
    }
    
    function checkRadiobtnForNormal(id, ShowDDl) {
        //alert(id);
        var splirid = id.split('_');
        document.getElementById(splirid[0] + "_" + ShowDDl).style.display = 'block';
        document.getElementById(splirid[0] + "_ddlNormalRedcells").style.display = 'none';
    }
    
    
    function hideControl(id, ShowDDl) {
        //alert(id);
        var splirid = id.split('_');
        document.getElementById(splirid[0] + "_" + ShowDDl).style.display = 'none';
    }
    
    function ShowControlForNormal(id, ShowDDl) {
        //alert(id);
        var splirid = id.split('_');
        document.getElementById(splirid[0] + "_" + ShowDDl).style.display = 'none';
        document.getElementById(splirid[0] + "_ddlNormalRedcells").style.display = 'block';
    }

    function checkCheckbox(id, ShowDDl) {
        var splirid = id.split('_');
        if (document.getElementById(id).checked == true) {
            //  alert('tr');

            document.getElementById(splirid[0] + "_" + ShowDDl).style.display = 'block';
        }
        else {
            document.getElementById(splirid[0] + "_" + ShowDDl).style.display = 'none';
        }
    }


    function showTextBox(id) {
        var splitddlID = id.split('_');
        if (document.getElementById(id).options[document.getElementById(id).selectedIndex].text == 'Others') {
            document.getElementById(splitddlID[0] + '_txtOthers').style.display = 'block';
        }
        else {
            document.getElementById(splitddlID[0] + '_txtOthers').style.display = 'none';
        }
    }
</script>

<table>
    <tr>
        <td class="bold font10 w-20p" style="color: #000;">
            <asp:Label ID="lblName" runat="server" onclick="javascript:changeTestName(this.id);"
                meta:resourcekey="lblNameResource1"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false"><u><%=Resources.Investigation_ClientDisplay.Investigation_CultureandSensitivityReport_aspx_08 %></u></a>
        </td>
    </tr>
    <tr>
        <td class="bold font11 w-20p" style="color: #000;">
            <asp:Label ID="lblRedcells" runat="server" Text="RedCells" meta:resourcekey="lblRedcellsResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="font10 w-20p" style="font-weight: normal; color: #000;">
            <asp:Label ID="lblmorphology" runat="server" Text="Morphology" meta:resourcekey="lblmorphologyResource1"></asp:Label>
        </td>
        <td class="font11 w-15p" style="font-weight: normal; color: #000;">
            <asp:RadioButtonList ForeColor="Black" runat="server" ID="rdlrbcMorphology" RepeatColumns="2"
                meta:resourcekey="rdlrbcMorphologyResource1">
                <asp:ListItem Selected="True" onclick="javascript:ShowControlForNormal(this.id,'ddlredcells');"
                    Text="Normal" meta:resourcekey="ListItemResource1"></asp:ListItem>
                <asp:ListItem Text="AbNormal" onclick="javascript:checkRadiobtnForNormal(this.id,'ddlredcells');"
                    meta:resourcekey="ListItemResource2"></asp:ListItem>
            </asp:RadioButtonList>
        </td>
        <td>
            <asp:DropDownList ID="ddlredcells" CssClass="ddlsmall" Style="display: none;" onchange="javascript:showTextBox(this.id);"
                runat="server" meta:resourcekey="ddlredcellsResource1">
            </asp:DropDownList>
            <asp:DropDownList ForeColor="Black" ID="ddlNormalRedcells" CssClass="ddlsmall" onchange="javascript:return setCompletedStatus(this.id);"
                runat="server" meta:resourcekey="ddlNormalRedcellsResource1">
            </asp:DropDownList>
        </td>
        <td>
            <asp:TextBox ID="txtOthers" CssClass="small" runat="server" Style="display: none;"
                meta:resourcekey="txtOthersResource1"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="font11 w-20p" style="font-weight: normal; color: #000;">
            <asp:Label ID="lblRbcDistribution" runat="server" Text="Distribution" meta:resourcekey="lblRbcDistributionResource1"></asp:Label>
        </td>
        <td class="font11 w-15p" style="font-weight: normal; color: #000;">
            <asp:RadioButtonList ForeColor="Black" runat="server" ID="rdlRbcDistribution" RepeatColumns="2"
                meta:resourcekey="rdlRbcDistributionResource1">
                <asp:ListItem Selected="True" onclick="javascript:hideControl(this.id,'ddldistribution');"
                    Text="Normal" meta:resourcekey="ListItemResource3"></asp:ListItem>
                <asp:ListItem Text="AbNormal" onclick="javascript:checkRadiobtn(this.id,'ddldistribution');"
                    meta:resourcekey="ListItemResource4"></asp:ListItem>
            </asp:RadioButtonList>
        </td>
        <td>
            <asp:DropDownList runat="server" CssClass="ddlsmall" ID="ddldistribution" Style="display: none;"
                meta:resourcekey="ddldistributionResource1">
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td class="font11 w-20p" style="font-weight: normal; color: #000;">
            <asp:CheckBox ID="chkAsinocytesis" runat="server" Text="Anisocytosis" meta:resourcekey="chkAsinocytesisResource1" />
        </td>
        <td class="font11 w-15p" style="font-weight: normal; color: #000;">
            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtAsino" CssClass="small" onkeyup="javascript:return setCompletedStatus(this.id);"
                runat="server" meta:resourcekey="txtAsinoResource1"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="font11 w-20p" style="font-weight: normal; color: #000;">
            <asp:CheckBox ID="chkpoikilocytesis" runat="server" Text="Poikilocytosis" meta:resourcekey="chkpoikilocytesisResource1" />
        </td>
        <td class="font11 w-15p" style="font-weight: normal; color: #000;">
            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtpoikilocytesis" CssClass="small"
                onkeyup="javascript:return setCompletedStatus(this.id);" runat="server" meta:resourcekey="txtpoikilocytesisResource1"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="font11 w-20p" style="font-weight: normal; color: #000;">
            <asp:CheckBox ID="chkPolychromasia" runat="server" Text="Polychromasia" meta:resourcekey="chkPolychromasiaResource1" />
        </td>
        <td class="font11 w-15p" style="font-weight: normal; color: #000;">
            <asp:TextBox ForeColor="Black" Font-Bold="true" CssClass="small" ID="txtPolychromasia"
                onkeyup="javascript:return setCompletedStatus(this.id);" runat="server" meta:resourcekey="txtPolychromasiaResource1"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="bold font11 w-20p" style="color: #000;">
            <asp:Label ID="lblWBC" runat="server" Text="WBC" meta:resourcekey="lblWBCResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="font11 w-20p" style="font-weight: normal; color: #000;">
            <asp:Label ID="lblWbcCount" runat="server" Text="WBC Count" meta:resourcekey="lblWbcCountResource1"></asp:Label>
        </td>
        <td class="bold font11 w-20p" style="color: #000;">
            <asp:DropDownList ForeColor="Black" CssClass="ddlsmall" ID="ddlWbcCount" onchange="javascript:return setCompletedStatus(this.id);"
                runat="server" meta:resourcekey="ddlWbcCountResource1">
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td class="font11 w-20p" style="font-weight: normal; color: #000;">
            <asp:Label ID="lblwbcDistribution" runat="server" Text="Distribution" meta:resourcekey="lblwbcDistributionResource1"></asp:Label>
        </td>
        <td class="font11 w-18p" style="font-weight: normal; color: #000;">
            <asp:RadioButtonList ForeColor="Black" runat="server" ID="rdlwbcDistribution" RepeatColumns="2"
                meta:resourcekey="rdlwbcDistributionResource1">
                <asp:ListItem Selected="True" onclick="javascript:hideControl(this.id,'txtwbcDistribution');"
                    Text="Normal" meta:resourcekey="ListItemResource5"></asp:ListItem>
                <asp:ListItem Text="AbNormal" onclick="javascript:checkRadiobtn(this.id,'txtwbcDistribution');"
                    meta:resourcekey="ListItemResource6"></asp:ListItem>
            </asp:RadioButtonList>
        </td>
        <td class="font11 h-20 w-20p" style="font-weight: normal; color: #000;">
            <asp:TextBox ID="txtwbcDistribution" CssClass="small" Style="display: none;" runat="server" meta:resourcekey="txtwbcDistributionResource1"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="font11 w-20p" style="font-weight: normal; color: #000;">
            <asp:Label runat="server" Text="WBC Immature Cells" ID="lblImmCells" meta:resourcekey="lblImmCellsResource1"></asp:Label>
        </td>
        <td class="font11 w-18p" style="font-weight: normal; color: #000;">
            <asp:RadioButtonList ForeColor="Black" runat="server" ID="rdlImmatureCells" RepeatColumns="2"
                meta:resourcekey="rdlImmatureCellsResource1">
                <asp:ListItem Selected="True" Text="Absent" onclick="javascript:hideControl(this.id,'txtImmatureCells');"
                    meta:resourcekey="ListItemResource7"></asp:ListItem>
                <asp:ListItem Text="Present" onclick="javascript:checkRadiobtn(this.id,'txtImmatureCells');"
                    meta:resourcekey="ListItemResource8"></asp:ListItem>
            </asp:RadioButtonList>
        </td>
        <td class="font11 h-20 w-20p" style="font-weight: normal; color: #000;">
            <asp:TextBox ID="txtImmatureCells" CssClass="small" Style="display: none;" runat="server" meta:resourcekey="txtImmatureCellsResource1"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="font11 w-20p" style="font-weight: normal; color: #000;">
            <asp:Label runat="server" Text="WBC Malignant cells" ID="lblMalignantscell" meta:resourcekey="lblMalignantscellResource1"></asp:Label>
        </td>
        <td class="font11 w-18p" style="font-weight: normal; color: #000;">
            <asp:RadioButtonList ForeColor="Black" runat="server" ID="rdlMalignantscell" RepeatColumns="2"
                meta:resourcekey="rdlMalignantscellResource1">
                <asp:ListItem Selected="True" onclick="javascript:hideControl(this.id,'txtMalignantcells');"
                    Text="Absent" meta:resourcekey="ListItemResource9"></asp:ListItem>
                <asp:ListItem Text="Present" onclick="javascript:checkRadiobtn(this.id,'txtMalignantcells');"
                    meta:resourcekey="ListItemResource10"></asp:ListItem>
            </asp:RadioButtonList>
        </td>
        <td class="font11 h-20 w-18p" style="font-weight: normal; color: #000;">
            <asp:TextBox runat="server" CssClass="small" Style="display: none;" ID="txtMalignantcells" meta:resourcekey="txtMalignantcellsResource1"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="font11 w-20p" style="font-weight: normal; color: #000;">
            <asp:Label ID="lblSpecificpatterns" runat="server" Text="Specific Patterns" meta:resourcekey="lblSpecificpatternsResource1"></asp:Label>
        </td>
        <td class="font11 w-18p" style="font-weight: normal; color: #000;">
            <asp:TextBox ForeColor="Black" CssClass="small" Font-Bold="true" runat="server"
                onkeyup="javascript:return setCompletedStatus(this.id);" ID="txtspepcificpatterns"
                meta:resourcekey="txtspepcificpatternsResource1"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="font11 w-20p" style="font-weight: normal; color: #000;">
            <asp:Label runat="server" ID="lblPlatelets" Text="Platelets" meta:resourcekey="lblPlateletsResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="font11 w-20p" style="font-weight: normal; color: #000;">
            <asp:Label runat="server" ID="lblpltDistribution" Text="Distribution" meta:resourcekey="lblpltDistributionResource1"></asp:Label>
        </td>
        <td class="font11 w-18p" style="font-weight: normal; color: #000;">
            <asp:RadioButtonList ForeColor="Black" runat="server" ID="rdlpltDistribution" RepeatColumns="2"
                meta:resourcekey="rdlpltDistributionResource1">
                <asp:ListItem Selected="True" onclick="javascript:hideControl(this.id,'txtpltDistribution');"
                    Text="Normal" meta:resourcekey="ListItemResource11"></asp:ListItem>
                <asp:ListItem Text="AbNormal" onclick="javascript:checkRadiobtn(this.id,'txtpltDistribution');"
                    meta:resourcekey="ListItemResource12"></asp:ListItem>
            </asp:RadioButtonList>
        </td>
        <td class="font11 h-20 w-20p" style="font-weight: normal; color: #000;">
            <asp:TextBox ID="txtpltDistribution" CssClass="small" Style="display: none;" runat="server" meta:resourcekey="txtpltDistributionResource1"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="font11 w-20p" style="font-weight: normal; color: #000;">
            <asp:Label ID="lblpltMorphology" runat="server" Text="Morphology" meta:resourcekey="lblpltMorphologyResource1"></asp:Label>
        </td>
        <td class="font11 w-18p" style="font-weight: normal; color: #000;">
            <asp:RadioButtonList ForeColor="Black" runat="server" ID="rdlpltmorphology" RepeatColumns="2"
                meta:resourcekey="rdlpltmorphologyResource1">
                <asp:ListItem Selected="True" onclick="javascript:hideControl(this.id,'txtpltmorphology');"
                    Text="Normal" meta:resourcekey="ListItemResource13"></asp:ListItem>
                <asp:ListItem Text="AbNormal" onclick="javascript:checkRadiobtn(this.id,'txtpltmorphology');"
                    meta:resourcekey="ListItemResource14"></asp:ListItem>
            </asp:RadioButtonList>
        </td>
        <td class="font11 h-20 w-18p" style="font-weight: normal; color: #000;">
            <asp:TextBox ID="txtpltmorphology" CssClass="small" Style="display: none;" runat="server" meta:resourcekey="txtpltmorphologyResource1"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="font11 w-20p" style="font-weight: normal; color: #000;">
            <asp:Label ID="lblparasites" runat="server" Text="Parasites" meta:resourcekey="lblparasitesResource1"></asp:Label>
        </td>
        <td class="font11 w-18p" style="font-weight: normal; color: #000;">
            <asp:RadioButtonList ForeColor="Black" runat="server" ID="rdlparasites" RepeatColumns="2"
                meta:resourcekey="rdlparasitesResource1">
                <asp:ListItem Selected="True" onclick="javascript:hideControl(this.id,'chkList');"
                    Text="Absent" meta:resourcekey="ListItemResource15"></asp:ListItem>
                <asp:ListItem Text="Present" onclick="javascript:checkRadiobtn(this.id,'chkList');"
                    meta:resourcekey="ListItemResource16"></asp:ListItem>
            </asp:RadioButtonList>
        </td>
        <td>
            <asp:CheckBoxList ID="chkList" CssClass="font10 h-20 w-10p" RepeatColumns="3" Style="font-weight: normal;
                color: #000; display: none;" runat="server" meta:resourcekey="chkListResource1">
                <asp:ListItem Text="Malarial" onclick="javascript:checkCheckbox(this.id,'ddlParasites');"
                    meta:resourcekey="ListItemResource17"></asp:ListItem>
                <asp:ListItem Text="Filarial" meta:resourcekey="ListItemResource18"></asp:ListItem>
            </asp:CheckBoxList>
        </td>
        <td class="w-18">
            <asp:DropDownList ID="ddlParasites" CssClass="small" Style="display: none;" runat="server"
                meta:resourcekey="ddlParasitesResource1">
            </asp:DropDownList>
        </td>
    </tr>
</table>
<table class="w-100p">
    <tr>
        <td colspan="2">
            <table class="w-100p">
                <tr>
                    <td style="font-weight: normal; color: #000;" class="style1 font10">
                        <asp:Label ID="lblTotalCount" runat="server" Text="Total Count" meta:resourcekey="lblTotalCountResource1"></asp:Label>
                    </td>
                    <td class="w-10p">
                        <asp:TextBox ForeColor="Black" CssClass="Txtboxverysmall w-40p" Font-Bold="true"
                            ID="txtValue" onkeyup="javascript:return setCompletedStatus(this.id);" runat="server"
                               onkeypress="return ValidateOnlyNumeric(this);"   onbeforepaste="BeforePaste_Event()"
                            onPaste="Paste_Event()" meta:resourcekey="txtValueResource1"></asp:TextBox>
                    </td>
                    <td class="bold font10 h-20 w-15p" style="color: #000;">
                        <asp:Label ID="lblUnit" runat="server" meta:resourcekey="lblUnitResource1"></asp:Label><asp:HiddenField
                            ID="HiddenField1" runat="server" />
                    </td>
                    <td class="font10 h-50 w-60p" style="font-weight: normal; color: #000;">
                        <table>
                            <tr>
                                <td class="font10 h-10 w-8p" style="font-weight: normal; color: #000;">
                                    <asp:Label ID="Rs_ReferenceRange" Text="Reference Range" runat="server" meta:resourcekey="Rs_ReferenceRangeResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="font10 h-50 w-8p" style="font-weight: normal; color: #000;">
                                    <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                                        ID="TextBox2" TextMode="MultiLine" CssClass="textbox_pattern small" Height="77%"
                                        meta:resourcekey="TextBox2Resource1"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="bold font12 h-20 w-19p" colspan="3" style="font-weight: bold; color: #000;">
            <asp:Label ID="lblCaption" Text="Differential Count" runat="server" meta:resourcekey="lblCaptionResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="font11 h-20 w-19p paddingL20" style="font-weight: normal; color: #000;">
            <asp:Label ID="lblName1" Text="Lymphocytes" runat="server" meta:resourcekey="lblName1Resource1"></asp:Label>
        </td>
        <td class="font11 h-20 w-83p paddingL20" style="font-weight: normal; color: #000;"
            colspan="2">
            <asp:TextBox ForeColor="Black" CssClass="small" Font-Bold="true" ID="txt1" runat="server"
                onkeyup="javascript:return setCompletedStatus(this.id);" meta:resourcekey="txt1Resource1"></asp:TextBox>
            <asp:Label ID="lblUom1" runat="server" CssClass="blackfontcolor" meta:resourcekey="lblUom1Resource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="font11 h-20 w-17p" style="font-weight: normal; color: #000; padding-left: 20px">
            <asp:Label ID="lblName2" Text="Monocytes" runat="server" meta:resourcekey="lblName2Resource1"></asp:Label>
        </td>
        <td class="font11 h-20 w-83p" style="font-weight: normal; color: #000; padding-left: 20px"
            colspan="2">
            <asp:TextBox ForeColor="Black" CssClass="small" Font-Bold="true" ID="txt2" runat="server"
                onkeyup="javascript:return setCompletedStatus(this.id);" meta:resourcekey="txt2Resource1"></asp:TextBox>
            <asp:Label ID="lblUom2" runat="server" CssClass="blackfontcolor" meta:resourcekey="lblUom2Resource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="font11 h-20 w-19p" style="font-weight: normal; color: #000; padding-left: 20px;">
            <asp:Label ID="lblName3" Text="Neutrophils" runat="server" meta:resourcekey="lblName3Resource1"></asp:Label>
        </td>
        <td class="font11 h-20 w-83p" style="font-weight: normal; color: #000; padding-left: 20px"
            colspan="2">
            <asp:TextBox ForeColor="Black" CssClass="small" Font-Bold="true" ID="txt3" runat="server"
                onkeyup="javascript:return setCompletedStatus(this.id);" meta:resourcekey="txt3Resource1"></asp:TextBox>
            <asp:Label ID="lblUom3" runat="server" CssClass="blackfontcolor" meta:resourcekey="lblUom3Resource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="font11 h-20 w-19p" style="font-weight: normal; color: #000; padding-left: 20px;">
            <asp:Label ID="lblName4" Text="Eosinophils" runat="server" meta:resourcekey="lblName4Resource1"></asp:Label>
        </td>
        <td class="font11 h-20 w-83p" style="font-weight: normal; color: #000; padding-left: 20px"
            colspan="2">
            <asp:TextBox ForeColor="Black" CssClass="small" Font-Bold="true" ID="txt4" runat="server"
                onkeyup="javascript:return setCompletedStatus(this.id);" meta:resourcekey="txt4Resource1"></asp:TextBox>
            <asp:Label ID="lblUom4" runat="server" CssClass="blackfontcolor" meta:resourcekey="lblUom4Resource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="font11 h-20 w-19p" style="font-weight: normal; color: #000; padding-left: 20px;">
            <asp:Label ID="lblName5" Text="Basophils" runat="server" meta:resourcekey="lblName5Resource1"></asp:Label>
        </td>
        <td class="font11 h-20 w-83p" style="font-weight: normal; color: #000; padding-left: 20px"
            colspan="2">
            <asp:TextBox ForeColor="Black" CssClass="small" Font-Bold="true" ID="txt5" runat="server"
                onkeyup="javascript:return setCompletedStatus(this.id);" meta:resourcekey="txt5Resource1"></asp:TextBox>
            <asp:Label ID="lblUom5" runat="server" CssClass="blackfontcolor" meta:resourcekey="lblUom5Resource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="font11 h-20 w-19p" style="font-weight: normal; color: #000; padding-left: 20px;">
            <asp:Label ID="lblName6" Text="Bands" runat="server" meta:resourcekey="lblName6Resource1"></asp:Label>
        </td>
        <td class="font11 h-20 w-83p" style="font-weight: normal; color: #000; padding-left: 20px"
            colspan="2">
            <asp:TextBox ForeColor="Black" CssClass="small" Font-Bold="true" ID="txt6" runat="server"
                onkeyup="javascript:return setCompletedStatus(this.id);" meta:resourcekey="txt6Resource1"></asp:TextBox>
            <asp:Label ID="lblUom6" runat="server" CssClass="blackfontcolor" meta:resourcekey="lblUom6Resource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="font11 h-20 w-19p" style="font-weight: normal; color: #000; padding-left: 20px;">
            <asp:Label ID="lblName7" Text="Metamyelocytes" runat="server" meta:resourcekey="lblName7Resource1"></asp:Label>
        </td>
        <td class="font11 h-20 w-83p" style="font-weight: normal; color: #000; padding-left: 20px"
            colspan="2">
            <asp:TextBox ForeColor="Black" CssClass="small" Font-Bold="true" ID="txt7" runat="server"
                onkeyup="javascript:return setCompletedStatus(this.id);" meta:resourcekey="txt7Resource1"></asp:TextBox>
            <asp:Label ID="lblUom7" runat="server" CssClass="blackfontcolor" meta:resourcekey="lblUom7Resource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="font11 h-20 w-19p" style="font-weight: normal; color: #000; padding-left: 20px;">
            <asp:Label ID="lblName8" Text="PDW" runat="server" meta:resourcekey="lblName8Resource1"></asp:Label>
        </td>
        <td class="font11 h-20 w-83p" style="font-weight: normal; color: #000; padding-left: 20px"
            colspan="2">
            <asp:TextBox ForeColor="Black" CssClass="small" Font-Bold="true" ID="txt8" onkeyup="javascript:return setCompletedStatus(this.id);"
                runat="server" meta:resourcekey="txt8Resource1"></asp:TextBox>
            <asp:Label ID="lblUom8" runat="server" CssClass="blackfontcolor" meta:resourcekey="lblUom8Resource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="font11 h-20 w-19p" style="font-weight: normal; color: #000; padding-left: 20px;">
            <asp:Label ID="lblName9" Text="RDW" runat="server" meta:resourcekey="lblName9Resource1"></asp:Label>
        </td>
        <td class="font11 h-20 w-83p" style="font-weight: normal; color: #000; padding-left: 20px"
            colspan="2">
            <asp:TextBox ForeColor="Black" CssClass="small" Font-Bold="true" ID="txt9" onkeyup="javascript:return setCompletedStatus(this.id);"
                runat="server" meta:resourcekey="txt9Resource1"></asp:TextBox>
            <asp:Label ID="lblUom9" runat="server" CssClass="blackfontcolor" meta:resourcekey="lblUom9Resource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="bold font10 h-20 w-8p" style="color: #000;">
            <asp:Label ID="Rs_ReferenceRange1" Text="Reference Range" runat="server" meta:resourcekey="Rs_ReferenceRange1Resource1"></asp:Label>
        </td>
        <td class="bold font11 h-20 w-8p" style="color: #000;">
            <asp:TextBox ForeColor="Black" CssClass="small" Font-Bold="true" runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                ID="txtRefRange" TextMode="MultiLine" Height="91%" meta:resourcekey="txtRefRangeResource1"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="bold font11 w-20p" style="color: #000;">
            <asp:Label ID="Rs_Status" Text="Status" runat="server" meta:resourcekey="Rs_StatusResource1"></asp:Label>
        </td>
        <td class="bold font11 w-18p" style="color: #000;">
            <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server"></asp:Label>
        </td>
        <td class="bold font11 w-18p" style="color: #000;">
            <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="font11 w-20p" style="font-weight: normal; color: #000;">
            <asp:DropDownList ForeColor="Black" CssClass="ddlsmall" ID="ddlStatus" runat="server"
                meta:resourcekey="ddlStatusResource1">
            </asp:DropDownList>
        </td>
        <td class="font11" style="font-weight: normal; color: #000;">
            <asp:TextBox ForeColor="Black" Font-Bold="true" CssClass="small" TextMode="MultiLine"
                onkeyup="javascript:return setCompletedStatus(this.id);" runat="server" ID="txtReason"
                 meta:resourcekey="txtReasonResource1"></asp:TextBox>
            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
            </ajc:AutoCompleteExtender>
            <asp:HiddenField ID="hdnRemarksID" runat="server" />
        </td>
        <td class="font11" style="font-weight: normal; color: #000;">
            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtMedRemarks"
                onkeyup="javascript:return setCompletedStatus(this.id);" TabIndex="-1" TextMode="MultiLine"
                CssClass="textbox_pattern small"></asp:TextBox>
            <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                TargetControlID="txtMedRemarks" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="GetInvMedicalRemarks">
            </ajc:AutoCompleteExtender>
            <asp:HiddenField ID="hdnMedicalRemarksID" runat="server" />
        </td>
    </tr>
    <tr>
        <td class="font11 w-20p" style="font-weight: normal; color: #000;">
            <asp:Label ID="lblReason" Text="Reason" runat="server"></asp:Label>
        </td>
        <td class="font11" style="font-weight: normal; color: #000;">
            <table>
                <tr>
                    <td>
                        <asp:DropDownList ForeColor="Black" CssClass="ddlsmall" ID="ddlStatusReason" runat="server"
                            TabIndex="-1" onChange="javascript:CheckIfEmpty(this.id,'txtValue');ShowStatusReason(this.id);"
                             onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);">
                        </asp:DropDownList>
                    </td>
                    <td class="font10 h-10" style="font-weight: normal; color: #000;">
                        <table id="tdInvStatusReason1" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <asp:Label ID="Label1" Text="Reason" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <table id="tdInvStatusOpinion1" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblOpinionUser" runat="server" Text="User" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table id="tdInvStatusReason2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <asp:DropDownList ForeColor="Black" ID="DropDownList1" runat="server" TabIndex="-1"
                                        CssClass="ddlsmall" onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <span class="richcombobox w-100">
                                        <asp:DropDownList ForeColor="Black" ID="ddlOpinionUser" runat="server" TabIndex="-1"
                                            CssClass="ddlsmall>
                                            <asp:ListItem Text="--Select--" meta:resourcekey="OpinionUserListItemResource1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
