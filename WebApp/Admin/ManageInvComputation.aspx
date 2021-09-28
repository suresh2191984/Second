<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageInvComputation.aspx.cs"
    Inherits="Admin_ManageInvComputation" meta:resourcekey="PageResource1" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Investigation Computation</title>
    <link rel="Stylesheet" type="text/css" />
    <%--    <script src="../Scripts/jquery-1.3.2.min.js" type="text/javascript"></script>--%>

    <script src="../Scripts/TapDigit.js" type="text/javascript"></script>

    <style type="text/css">
        .fixedHeader
        {
            position: relative;
        }
        .style1
        {
            width: 78px;
        }
        .style2
        {
            width: 92px;
        }
        .style3
        {
            height: 19px;
        }
        .style4
        {
            height: 58px;
        }
        .style5
        {
            height: 146px;
        }
        .style6
        {
            height: 27px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata w-100p">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <table id="tblgrpSearch" class="w-100p searchPanel">
                    <tr>
                        <td class="a-right" colspan="2">
                            <asp:LinkButton ID="lnkPatterns" Text="Click here to see assigned patterns" Font-Underline="True"
                                OnClientClick="ClearSearch();return false;" runat="server" ForeColor="Red" meta:resourcekey="lnkPatternsResource1"
                                TabIndex="1"></asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center padding5">
                            <asp:Label ID="lblInvGroup" runat="server" Text="Select Group" Font-Size="Small"
                                Font-Bold="True" meta:resourcekey="lblInvGroupResource1" />&nbsp;
                            <asp:DropDownList ID="ddlInvGroup" runat="server" AutoPostBack="True" CssClass="ddlmedium"
                                TabIndex="2" OnSelectedIndexChanged="ddlInvGroup_SelectedIndexChanged" meta:resourcekey="ddlInvGroupResource1">
                            </asp:DropDownList>
                        </td>
                        <td id="tdddlTargetInv">
                            &nbsp;&nbsp;&nbsp;
                            <asp:Label ID="lblTargetInv" runat="server" Text="Select Dependent Investigation"
                                Font-Size="Small" Font-Bold="True" meta:resourcekey="lblTargetInvResource1" />&nbsp;
                            <asp:DropDownList ID="ddlTargetInv" runat="server" meta:resourcekey="ddlTargetInvResource1"
                                CssClass="ddlmedium" TabIndex="3">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
                <table id="tblContent" runat="server" class="w-100p">
                    <tr runat="server">
                        <td runat="server">
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <table class="w-100p a-center bg-row">
                                            <tr>
                                                <td colspan="5">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblInvestigation" runat="server" Text="Select Primary Investigation"
                                                        Font-Size="Small" Font-Bold="True" meta:resourcekey="lblInvestigationResource1" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblOperator" runat="server" Text="Select Operator" Font-Size="Small"
                                                        Font-Bold="True" meta:resourcekey="lblOperatorResource1" />
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblSelectedItems" runat="server" Text="Selected Pattern" Font-Size="Small"
                                                        Font-Bold="True" meta:resourcekey="lblSelectedItemsResource1" />
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:ListBox ID="lstBoxInvestigation" Width="260px" runat="server" Height="150px"
                                                        TabIndex="4" meta:resourcekey="lstBoxInvestigationResource1" onchange="InvChange();"
                                                        ondblclick="return AddInvItemValues()"></asp:ListBox>
                                                </td>
                                                <td>
                                                    <asp:ListBox ID="lstBoxOperator" Width="150px" runat="server" Height="150px" 
                                                        onchange="return OprChange()" ondblclick="return AddOprItemValues()" TabIndex="6">
                                                   <%--     <asp:ListItem Value="const" meta:resourcekey="ListItemResource1">Number</asp:ListItem>
                                                        <asp:ListItem Value="+" meta:resourcekey="ListItemResource2">+</asp:ListItem>
                                                        <asp:ListItem Value="-" meta:resourcekey="ListItemResource3">-</asp:ListItem>
                                                        <asp:ListItem Value="/" meta:resourcekey="ListItemResource4">/</asp:ListItem>
                                                        <asp:ListItem Value="*" meta:resourcekey="ListItemResource5">*</asp:ListItem>
                                                        <asp:ListItem Value="(" meta:resourcekey="ListItemResource6">(</asp:ListItem>
                                                        <asp:ListItem Value=")" meta:resourcekey="ListItemResource7">)</asp:ListItem>
                                                        <asp:ListItem Value="Round" meta:resourcekey="ListItemResource8">Round</asp:ListItem>
                                                        <asp:ListItem Value="+toFixed" meta:resourcekey="ListItemResource9">toFixed</asp:ListItem>
                                                        <asp:ListItem Value="Power" meta:resourcekey="ListItemResource10">Power</asp:ListItem>
                                                        <asp:ListItem Value="," meta:resourcekey="ListItemResource11">,</asp:ListItem>
                                                        <asp:ListItem Value="logBaseE" meta:resourcekey="ListItemResource12">logBaseE</asp:ListItem>
                                                        <asp:ListItem Value="logBase10" meta:resourcekey="ListItemResource13">logBase10</asp:ListItem>
                                                        <asp:ListItem Value="ALogBase10" meta:resourcekey="ListItemResource14">ALogBase10</asp:ListItem>
                                                        <asp:ListItem Value="ALogBaseE" meta:resourcekey="ListItemResource15">ALogBaseE</asp:ListItem>
                                                        <asp:ListItem Value="e" meta:resourcekey="ListItemResource16">e</asp:ListItem>
                                                        <asp:ListItem Value="^" meta:resourcekey="ListItemResource17">^</asp:ListItem>--%>
                                                    </asp:ListBox>
                                                </td>
                                                <td style="width: 110px;">
                                                    &nbsp;
                                                    <div id="divNumber" style="display: none;">
                                                        <asp:TextBox ID="txtNumber" runat="server" Width="80px" TabIndex="7" meta:resourcekey="txtNumberResource1" />
                                                        <asp:RegularExpressionValidator ID="REVNumber" runat="server" Display="Dynamic" ControlToValidate="txtNumber"
                                                            ErrorMessage="Invalid Number" ValidationExpression="^[-+]?[0-9]\d{0,9}(\.\d{1,9})?%?$"
                                                            meta:resourcekey="REVNumberResource1" SetFocusOnError="True" ValidationGroup="ValidateNumber" />
                                                    </div>
                                                </td>
                                                <td>
                                                    <asp:ListBox ID="lstBoxSelectedItems" runat="server" Height="150px" Width="260px"
                                                        TabIndex="9" meta:resourcekey="lstBoxSelectedItemsResource1" ondblclick="return RemoveItemValues()">
                                                    </asp:ListBox>
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnUp" runat="server" Text="    UP   " OnClientClick="return MoveUpDown('up')"
                                                        TabIndex="11" Style="cursor: pointer;" CssClass="btn" onmouseout="this.className='btn'"
                                                        onmouseover="this.className='btn btnhov'" meta:resourcekey="btnUpResource1" />
                                                    <br />
                                                    <br />
                                                    <asp:Button ID="btnDown" runat="server" Text="DOWN" Style="cursor: pointer;" CssClass="btn"
                                                        TabIndex="12" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                        OnClientClick="return MoveUpDown('down')" meta:resourcekey="btnDownResource1" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnAddInv" runat="server" Text=">>ADD>>" Style="cursor: pointer;"
                                                        TabIndex="5" CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                        OnClientClick="return AddInvItemValues()" meta:resourcekey="btnAddInvResource1" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnAddOpr" runat="server" Text=">>ADD>>" Style="cursor: pointer;"
                                                        TabIndex="8" CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                        OnClientClick="return AddOprItemValues()" meta:resourcekey="btnAddOprResource1"
                                                        ValidationGroup="AddOpr" />
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnRemove" runat="server" Text="<<REMOVE<<" Style="cursor: pointer;"
                                                        TabIndex="10" CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                        OnClientClick="return RemoveItemValues()" meta:resourcekey="btnRemoveResource1" />
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table class="w-100p">
                                <tr>
                                    <td class="a-center">
                                        <asp:Button ID="btnAssignPattern" runat="server" Text="Assign Pattern" Style="cursor: pointer;"
                                            TabIndex="13" CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                            OnClientClick="return AssignPattern()" meta:resourcekey="btnAssignPatternResource1" />
                                        <asp:Button ID="btnReset" runat="server" Text="Reset" Style="cursor: pointer;" CssClass="btn"
                                            TabIndex="14" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                            OnClientClick="return Reset()" meta:resourcekey="btnResetResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                            <table class="w-100p">
                                <tr>
                                    <td class="a-center">
                                        <asp:Table ID="tblSelectedPatterns" runat="server" CellPadding="0" CellSpacing="10"
                                            CssClass="gridView" BorderWidth="1px" Width="100%" 
                                            meta:resourcekey="tblSelectedPatternsResource1">
                                            <asp:TableHeaderRow Font-Size="14px" Font-Underline="True" HorizontalAlign="Center"
                                                runat="server" meta:resourcekey="TableHeaderRowResource1">
                                                <asp:TableHeaderCell HorizontalAlign="Center" runat="server" 
                                                    meta:resourcekey="TableHeaderCellResource1">Dependent Investigation</asp:TableHeaderCell>
                                                <asp:TableHeaderCell HorizontalAlign="Center" runat="server" 
                                                    meta:resourcekey="TableHeaderCellResource2">Pattern</asp:TableHeaderCell>
                                                <asp:TableHeaderCell HorizontalAlign="Center" runat="server" 
                                                    meta:resourcekey="TableHeaderCellResource3">Action</asp:TableHeaderCell>
                                                <asp:TableHeaderCell Style="display: none;" runat="server" 
                                                    meta:resourcekey="TableHeaderCellResource4">Validation Text</asp:TableHeaderCell>
                                                <asp:TableHeaderCell Style="display: none;" runat="server" 
                                                    meta:resourcekey="TableHeaderCellResource5">Validation Rule</asp:TableHeaderCell>
                                            </asp:TableHeaderRow>
                                        </asp:Table>
                                    </td>
                                </tr>
                            </table>
                            <table class="w-100p">
                                <tr>
                                    <td class="a-center">
                                        <asp:Button ID="btnSave" runat="server" Text="Save" Style="cursor: pointer;" CssClass="btn"
                                            TabIndex="15" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                            OnClientClick="return Save()" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <asp:Panel ID="pnlPatterns" Width="800px" Height="500px" runat="server" CssClass="modalPopup dataheaderPopup"
                    Style="display: none" meta:resourcekey="pnlPatternsResource1">
                    <table align="center" width="98%">
                        <tr>
                            <td>
                                <asp:Label ID="lblSearchText" Text="Search Text" runat="server" meta:resourcekey="lblSearchTextResource1"></asp:Label>&nbsp;
                                <asp:TextBox ID="txtSearch" runat="server" meta:resourcekey="txtSearchResource1"></asp:TextBox>&nbsp;&nbsp;&nbsp;
                                <%--<input id="btnSubmit" onclick="return SearchText();return false;" type="button" style="cursor: pointer;"
                                    class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                    value="Search" meta:resourcekey="btnSubmitResource1" />--%>
                                    <asp:Button ID="btnSubmit" runat="server" OnClientClick="return SearchText();return false;" style="cursor: pointer;" Text="Search" CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" meta:resourcekey="btnSubmitResource1"  />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Panel ID="panelContainer" runat="server" Height="400px" CssClass="w-100p" ScrollBars="Vertical"
                                    meta:resourcekey="panelContainerResource1">
                                    <asp:GridView ID="grdGroups" runat="server" CssClass="w-97p gridView" AutoGenerateColumns="False"
                                        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                        OnPreRender="grdGroups_PreRender" CellPadding="3" meta:resourcekey="grdGroupsResource1"
                                        OnRowDataBound="grdGroups_RowDataBound">
                                        <RowStyle ForeColor="#000066" />
                                        <HeaderStyle CssClass="fixedHeader" BackColor="#8CBED9" />
                                        <Columns>
                                            <asp:BoundField DataField="GroupName" HeaderText="Group Name" 
                                                meta:resourceKey="BoundFieldResource1">
                                                <HeaderStyle Width="25%" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Pattern" 
                                                meta:resourceKey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="hdnOrgGroupID" runat="server" 
                                                        Value='<%# Eval("OrgGroupID") %>' />
                                                    <asp:GridView ID="grdPatterns" runat="server" AutoGenerateColumns="False" 
                                                        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                                        CellPadding="3" meta:resourceKey="grdPatternsResource1" Width="100%">
                                                        <RowStyle ForeColor="#000066" />
                                                        <Columns>
                                                            <asp:BoundField DataField="DependentInvestigation" 
                                                                HeaderText="Dependent Investigation" meta:resourceKey="BFDeptInvResource2">
                                                                <HeaderStyle Width="40%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Pattern" HeaderText="Computation Rule" 
                                                                meta:resourceKey="BFPatternResource2" />
                                                            <asp:TemplateField HeaderText="Action" 
                                                                meta:resourceKey="TemplateFieldResource2">
                                                                <ItemTemplate>
                                                                    <asp:HiddenField ID="hdnDepInvestigationID" runat="server" 
                                                                        Value='<%# Eval("DepInvestigationID") %>' />
                                                                    <asp:LinkButton ID="lnkbtnEdit" runat="server" CssClass="editIcons" 
                                                                        Font-Bold="True" Font-Underline="True" ForeColor="Blue" 
                                                                        meta:resourceKey="lnkbtnEditResource1" OnClick="lnkbtnEdit_Click" Text="Edit"></asp:LinkButton>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="10%" />
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <HeaderStyle BackColor="#E7E7E7" />
                                                        <RowStyle ForeColor="#000066" />
                                                    </asp:GridView>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle BackColor="#8CBED9" CssClass="fixedHeader" />
                                        <RowStyle ForeColor="#000066" />
                                    </asp:GridView>
                                    <asp:Label ID="lblNoRecords" Text="No records to display" runat="server" ForeColor="Red"
                                        meta:resourcekey="lblNoRecordsResource1" Style="display: none;"></asp:Label>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td class="h-20">
                            </td>
                        </tr>
                        <tr>
                            <td class="a-center">
                                <asp:Button ID="btnOk" runat="server" Text="OK" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" Width="70px" meta:resourcekey="btnOkResource1"
                                    TabIndex="16" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <ajc:modalpopupextender id="mpePatternSelection" runat="server" targetcontrolid="lnkPatterns"
                    popupcontrolid="pnlPatterns" backgroundcssclass="modalBackground" cancelcontrolid="btnOk"
                    dynamicservicepath="" enabled="True" />
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <attune:attunefooter id="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnRowID" Value="-1" runat="server" />
    <asp:HiddenField ID="hdnValidationRule" runat="server" />
    <asp:HiddenField ID="hdnValidationText" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
    <script language="javascript" type="text/javascript">
        var lexer, parseId;
        function parse(code, text, validationRule) {
            //            if (parseId) {
            //                window.clearTimeout(parseId);
            //            }

            //parseId = window.setTimeout(function() {
            var objDel = SListForAppMsg.Get("Admin_ManageInvComputation_aspx_15") == null ? "Delete" : SListForAppMsg.Get("Admin_ManageInvComputation_aspx_15");
            var objEdit = SListForAppMsg.Get("Admin_ManageInvComputation_aspx_16") == null ? "Edit" : SListForAppMsg.Get("Admin_ManageInvComputation_aspx_16");
            var objAssgnPattern = SListForAppMsg.Get("Admin_ManageInvComputation_aspx_17") == null ? "Assign Pattern" : SListForAppMsg.Get("Admin_ManageInvComputation_aspx_17");
            var str, i, parser, syntax;

            try {
                //                    if (typeof parser === 'undefined') {
                //                        parser = new TapDigit.Parser();
                //                    }
                //syntax = parser.parse(code);
                syntax = code;
                function stringify(object, key, depth) {
                    var indent = '',
                    str = '',
                    value = object[key],
                    i,
                    len;

                    while (indent.length < depth * 3) {
                        indent += ' ';
                    }

                    switch (typeof value) {
                        case 'string':
                            str = value;
                            break;
                        case 'number':
                        case 'boolean':
                        case 'null':
                            str = String(value);
                            break;
                        case 'object':
                            for (i in value) {
                                if (value.hasOwnProperty(i)) {
                                    str += ('<br>' + stringify(value, i, depth + 1));
                                }
                            }
                            break;
                    }
                    return indent + ' ' + key + ': ' + str;
                }

                stringify(syntax, 'Expression', 0);
                var valText = '';
                var lstInv = 0;
                $('#lstBoxSelectedItems').children("option").each(function() {
                    var $this = $(this);
                    if ($("#lstBoxOperator").find("option[text='" + $this.text() + "']").length > 0) {

                        switch ($this.val()) {
                            case ("Round"):
                                valText = valText + "Math.round";
                                break;
                            case ("logBaseE"):
                                valText = valText + "Math.log";
                                break;
                            case ("logBase10"):
                                valText = valText + "Math.log";
                                break;
                            case ("Power"):
                                valText = valText + "Math.pow";
                                break;
                            case ("ALogBaseE"):
                                valText = valText + "Math.exp";
                                break;
                            case ("ALogBase10"):
                                valText = valText + "Math.pow";
                                break;
                            default:
                                valText = valText + $this.val();
                                break;

                        }
                        // if ($this.val() == "Round") {
                        //  valText = valText + "Math.round";
                        // }
                        //else if ($this.val() == "Power") {
                        //valText = valText + "Math.pow";
                        //  }
                        //  else {
                        //valText = valText + $this.val();
                        // }
                    }
                    else if ($("#lstBoxInvestigation").find("option[text='" + $this.text() + "']").text.length > 0) {
                        if ($this.val() == "(" || $this.val() == ")" || $this.val() == "^" || $this.val() == "+" || $this.val() == "-" || $this.val() == "*" || $this.val() == "/") {
                            valText = valText + $this.val();
                        }
                        else if ($this.val() == "0" || $this.val() == "1" || $this.val() == "2" || $this.val() == "3" || $this.val() == "4" || $this.val() == "5" || $this.val() == "6"
                            || $this.val() == "7" || $this.val() == "8" || $this.val() == "9" || $this.val() == "10") {
                            valText = valText + $this.val();
                        }
                        else {
                            if ($this.val().indexOf("toFixed") >= 0) {
                                valText = valText + '.' + $this.text();
                            }
                            else if ($this.val().indexOf(".") >= 0) {
                                valText = valText + $this.val();
                            }
                            else {
                                valText = valText + '(parseFloat([' + $this.val() + ']))';
                            }

                            lstInv = lstInv + 1;
                        }
                    }
                    else {
                        if ($this.val().indexOf("toFixed") >= 0) {
                            valText = valText + '.' + $this.text();
                        }
                        else {
                            valText = valText + $this.val();
                        }
                    }
                });
                if (lstInv == 0) {
                    var objvar32 = SListForAppMsg.Get("Admin_ManageInvComputation_aspx_13") == null ? "Primary investigation not available in selected pattern" : SListForAppMsg.Get("Admin_ManageInvComputation_aspx_13");
                    var objAlert = SListForAppMsg.Get("Admin_Alert_aspx") == null ? "Alert" : SListForAppMsg.Get("Admin_Alert_aspx");
                    ValidationWindow(objvar32, objAlert);

                    //alert("Primary investigation not available in selected pattern");
                }
                else {
                    valText += ';';
                    var varCount = 0;
                    var rowcount = $('#tblSelectedPatterns tr').length;
                    if ($('#hdnRowID').val() == '-1')
                        varCount = rowcount;
                    else
                        varCount = $('#hdnRowID').val();
                    valText = "var txtEditable"
                    + varCount + " = false; if(document.getElementById('hdnEditableFormulaFields') != null){txtEditable"
                    + varCount + " = document.getElementById('hdnEditableFormulaFields').value.indexOf('["
                    + $('#ddlTargetInv :selected').val() + "]') >= 0 ? true : false;} if(!txtEditable"
                    + varCount + "){ var temp" + varCount + " = " + valText + " if(isNaN(temp"
                    + varCount + ")) {[" + $('#ddlTargetInv :selected').val() + "] = '';} else {[" 
                    + $('#ddlTargetInv :selected').val() + "] = " + valText + "}}";

                    var pattern = text.replace(/~/g, "");
                    text = $('#ddlTargetInv :selected').text() + '=' + text;
                    validationRule = '[' + $('#ddlTargetInv :selected').val() + ']=' + validationRule;
                    if ($('#hdnRowID').val() == '-1') {
                        $('#tblSelectedPatterns').append('<tr><td>' + $('#ddlTargetInv :selected').text() + '</td><td>'
                        + pattern + '</td><td><input id="btnEdit'
                        + rowcount + '" name="Edit" value=' + objEdit + ' type="button" onclick="EditInvPattern('
                        + rowcount + ');" style="background-color:Transparent;color: Blue;border-style:none;text-decoration:underline;cursor:pointer"/>&nbsp;&nbsp;<input id="btnDelete'
                        + rowcount + '"  name="Delete" value=' + objDel + ' type="button" style="background-color:Transparent;color: Blue;border-style:none;text-decoration:underline;cursor:pointer" onclick="DeleteInvPattern(this);"/></td><td style="display:none;">' 
                        + valText + '</td><td style="display:none;">' + validationRule + '</td></tr>');
                    }
                    else {
                        var $tableRow = $('#tblSelectedPatterns tbody tr:eq(' + $('#hdnRowID').val() + ')');
                        $tableRow.find('td:eq(0)').html($('#ddlTargetInv :selected').text());
                        $tableRow.find('td:eq(1)').html(pattern);
                        $tableRow.find('td:eq(3)').html(valText);
                        $tableRow.find('td:eq(4)').html(validationRule);

                        $('#hdnRowID').val('-1');
                        $('#btnAssignPattern').val(objAssgnPattern);
                    }
                    $('#ddlTargetInv').attr('selectedIndex', '0');
                    $('#lstBoxSelectedItems').empty();
                }
            } catch (e) {
            var objvar31 = SListForAppMsg.Get("Admin_ManageInvComputation_aspx_12") == null ? "Invalid Pattern: " : SListForAppMsg.Get("Admin_ManageInvComputation_aspx_12");

            var objAlert = SListForAppMsg.Get("Admin_Alert_aspx") == null ? "Alert" : SListForAppMsg.Get("Admin_Alert_aspx");
            ValidationWindow(objvar31+" " + e.message, objAlert);

                //alert("Invalid Pattern: " + e.message);
            }
            //  parseId = undefined;
            //}, 345);
        }
        function EditInvPattern(rowIndex) {
            $('#hdnRowID').val(rowIndex);
            $('#btnAssignPattern').val("Update Pattern");
            var lstBoxInv = document.getElementById('lstBoxInvestigation');
            var lstBoxOpr = document.getElementById('lstBoxOperator');
            var computationRule = $('#tblSelectedPatterns tbody tr:eq(' + rowIndex + ') td:eq(4)').html();
            var patternText = computationRule.split('=');
            $('#ddlTargetInv').val(patternText[0].replace('[', '').replace(']', ''));
            var selectedPattern = patternText[1].split('~');
            $('#lstBoxSelectedItems').empty();

            var optionText = "";
            var optionValue = "";
            for (var i = 0; i < selectedPattern.length; i++) {
                optionText = "";
                optionValue = "";
                if ($("#lstBoxOperator").find("option[text='" + selectedPattern[i] + "']").length > 0) {
                    var selectOption = $("#lstBoxOperator").find("option[text='" + selectedPattern[i] + "']");
                    optionText = $(selectOption).text();
                    optionValue = $(selectOption).val();
                }
                else if ($("#lstBoxInvestigation").find("option[value='" + selectedPattern[i].replace('[', '').replace(']', '') + "']").length > 0) {
                    var selectOption = $("#lstBoxInvestigation").find("option[value='" + selectedPattern[i].replace('[', '').replace(']', '') + "']");
                    optionText = $(selectOption).text();
                    optionValue = $(selectOption).val();
                }
                else if (selectedPattern[i].indexOf("toFixed") >= 0) {
                    optionText = selectedPattern[i].replace('.', '');
                    optionValue = selectedPattern[i].replace('.', '+');
                }
                else {
                    optionText = selectedPattern[i];
                    optionValue = selectedPattern[i];
                }

                if (optionText != "" && optionValue != "")
                    $('#lstBoxSelectedItems').append('<option value="' + optionValue + '">' + optionText + '</option>');
            }
        }
        function DeleteInvPattern(obj) {
            $(obj).closest('tr').remove();
            $('#lstBoxSelectedItems').children().remove();
            $('#ddlTargetInv').attr('selectedIndex', '0');
            $('#hdnRowID').val('-1');
            $('#btnAssignPattern').val("Assign Pattern");
            return false;
        }
        function InvChange() {
            if ($('#lstBoxInvestigation :selected').val() == "0") {
                $('#lstBoxInvestigation').attr('selectedIndex', '-1');
                $("#lstBoxInvestigation option:selected").attr("selected", false);
            }
        }
        function OprChange() {
            if ($('#lstBoxOperator :selected').val() == "const" || $('#lstBoxOperator :selected').val().indexOf("toFixed") >= 0) {
                $('#divNumber').attr('style', 'display:block');
                $('#txtNumber').val('');
            }
            else {
                $('#txtNumber').val('');
                $('#divNumber').attr('style', 'display:none');
            }
        }
        function AddInvItemValues() {
            var objvar30 = SListForAppMsg.Get("Admin_ManageInvComputation_aspx_11") == null ? "Select primary investigation to add." : SListForAppMsg.Get("Admin_ManageInvComputation_aspx_11");
            var objAlert = SListForAppMsg.Get("Admin_Alert_aspx") == null ? "Alert" : SListForAppMsg.Get("Admin_Alert_aspx");
            var selectedOption = $('#lstBoxInvestigation :selected');
            //if ($('#lstBoxInvestigation').attr("selectedIndex") == -1) {
            if ($("#lstBoxInvestigation option:selected").index() == -1) {
                //alert("Select primary investigation to add.");
                ValidationWindow(objvar30, objAlert);
            }
            else {
                var existsoption = $('#lstBoxSelectedItems');
                if (existsoption[0].length > 0) {
                    if ($("#lstBoxSelectedItems option[value='" + $(selectedOption).val() + "']").length > 0) {

                        //////////////////////////////////////alert('This item already added'); Commented by karthick
                        $('#lstBoxSelectedItems').append('<option value="' + $(selectedOption).val() + '">' + $(selectedOption).text() + '</option>');
                        $('#lstBoxInvestigation').attr('selectedIndex', '-1');
                    }
                    else {
                        $('#lstBoxSelectedItems').append('<option value="'
                            + $(selectedOption).val() + '">' + $(selectedOption).text() + '</option>');
                        $('#lstBoxInvestigation').attr('selectedIndex', '-1');
                    }
                }
                else {
                    $('#lstBoxSelectedItems').append('<option value="' + $(selectedOption).val() + '">' + $(selectedOption).text() + '</option>');
                    $('#lstBoxInvestigation').attr('selectedIndex', '-1');
                }
            }
            return false;
        }
        function AddOprItemValues() {
            var objAlert = SListForAppMsg.Get("Admin_Alert_aspx") == null ? "Alert" : SListForAppMsg.Get("Admin_Alert_aspx");
            var objvar28 = SListForAppMsg.Get("Admin_ManageInvComputation_aspx_09") == null ? "Enter value in number textbox" : SListForAppMsg.Get("Admin_ManageInvComputation_aspx_09");
            var objvar29 = SListForAppMsg.Get("Admin_ManageInvComputation_aspx_10") == null ? "Select an operator to add." : SListForAppMsg.Get("Admin_ManageInvComputation_aspx_10");

      
         var objvar27 = SListForAppMsg.Get("Admin_ManageInvComputation_aspx_08") == null ? "This action cannot be performed" : SListForAppMsg.Get("Admin_ManageInvComputation_aspx_08");
                 //   var objvar27 = SListForAppMsg.Get("Admin_ManageInvComputation_aspx_08") == null ? "This action cannot be performed" : SListForAppMsg.Get("Admin_ManageInvComputation_aspx_08");
                var objAlert = SListForAppMsg.Get("Admin_Alert_aspx") == null ? "Alert" : SListForAppMsg.Get("Admin_Alert_aspx");
      
      
            var selectedOption = $('#lstBoxOperator :selected');
            //  if ($('#lstBoxOperator').attr("selectedIndex") == -1) {
            if ($("#lstBoxOperator option:selected").index() == -1) {
                //alert("Select an operator to add.");
                ValidationWindow(objvar29, objAlert);
            }
            else {
                if ($('#lstBoxInvestigation').children().length > 0) {
                    if ($('#lstBoxOperator :selected').val() == "const" || $('#lstBoxOperator :selected').val().indexOf("toFixed") >= 0) {
                        if ($('#txtNumber').val() == '')
                        // alert("Enter value in number textbox");
                            ValidationWindow(objvar28, objAlert);
                        else {
                            if (Page_ClientValidate('ValidateNumber')) {
                                if ($('#lstBoxOperator :selected').val().indexOf("toFixed") >= 0) {
                                    $('#lstBoxSelectedItems').append('<option value="'
                                    + $(selectedOption).val() + '(' + $('#txtNumber').val() + ')' + '">' 
                                    + $(selectedOption).text() + '(' + $('#txtNumber').val() + ')' + '</option>');
                                }
                                else {
                                    if ($('#txtNumber').val().indexOf(".") >= 0) {
                                        $('#lstBoxSelectedItems').append('<option value="'
                                    + $('#txtNumber').val() + '">' + $('#txtNumber').val() + '</option>');
                                    } else {
                                    $('#lstBoxSelectedItems').append('<option value="'
                                    + $('#txtNumber').val()+'.00' + '">' + $('#txtNumber').val()+'.00' + '</option>');
                                    }
                                }
                                $('#lstBoxOperator').attr('selectedIndex', '-1');
                                $('#txtNumber').val('');
                                $('#divNumber').attr('style', 'display:none');
                            }
                        }
                    }
                    else {
                        $('#lstBoxSelectedItems').append('<option value="'
                        + $(selectedOption).val() + '">' 
                        + $(selectedOption).text() + '</option>');
                        $('#lstBoxOperator').attr('selectedIndex', '-1');
                    }
                }
                else
                    //alert("This action cannot be performed");
                    ValidationWindow(objvar27, objAlert);
            }
            return false;
        }
        function RemoveItemValues() {
            var objAlert = SListForAppMsg.Get("Admin_Alert_aspx") == null ? "Alert" : SListForAppMsg.Get("Admin_Alert_aspx");
            var objvar26 = SListForAppMsg.Get("Admin_ManageInvComputation_aspx_07") == null ? "Select an item to remove." : SListForAppMsg.Get("Admin_ManageInvComputation_aspx_07");
            var selectedOption = $('#lstBoxSelectedItems :selected');
            // if ($('#lstBoxSelectedItems').attr("selectedIndex") == -1) {
            if ($("#lstBoxSelectedItems option:selected").index() == -1) {
                //alert("Select an item to remove.");
                ValidationWindow(objvar26, objAlert);
            }
            else {
                $('#lstBoxSelectedItems :selected').remove();
                $('#lstBoxSelectedItems').attr('selectedIndex', '-1');
            }
            return false;
        }
        function MoveUpDown(direction) {
            var objvar25 = SListForAppMsg.Get("Admin_ManageInvComputation_aspx_06") == null ? "Select an option to move." : SListForAppMsg.Get("Admin_ManageInvComputation_aspx_06");
            var objAlert = SListForAppMsg.Get("Admin_Alert_aspx") == null ? "Alert" : SListForAppMsg.Get("Admin_Alert_aspx");
            var listbox = document.getElementById('lstBoxSelectedItems');
            var selIndex = listbox.selectedIndex;
            if (-1 == selIndex) {
                //alert("Select an option to move.");
                ValidationWindow(objvar25, objAlert);
                return false;
            }

            var increment = -1;
            if (direction == 'up')
                increment = -1;
            else
                increment = 1;

            if ((selIndex + increment) < 0 ||
        (selIndex + increment) > (listbox.options.length - 1)) {
                return false;
            }

            var selValue = listbox.options[selIndex].value;
            var selText = listbox.options[selIndex].text;
            listbox.options[selIndex].value = listbox.options[selIndex + increment].value
            listbox.options[selIndex].text = listbox.options[selIndex + increment].text

            listbox.options[selIndex + increment].value = selValue;
            listbox.options[selIndex + increment].text = selText;

            listbox.selectedIndex = selIndex + increment;

            return false;
        }

        function AssignPattern() {
            var objvar23 = SListForAppMsg.Get("Admin_ManageInvComputation_aspx_04") == null ? "There is no pattern to assign" : SListForAppMsg.Get("Admin_ManageInvComputation_aspx_04");
            var objvar24 = SListForAppMsg.Get("Admin_ManageInvComputation_aspx_05") == null ? "Select Dependent investigation" : SListForAppMsg.Get("Admin_ManageInvComputation_aspx_05");
            var objAlert = SListForAppMsg.Get("Admin_Alert_aspx") == null ? "Alert" : SListForAppMsg.Get("Admin_Alert_aspx");
            //if ($('#ddlTargetInv').attr("selectedIndex") < 1) {
            if ($("#ddlTargetInv option:selected").index() < 1) {
                //alert("Select Dependent investigation");
                ValidationWindow(objvar24, objAlert);
                $('#ddlTargetInv').focus();
                return false;
            }
            else if ($('#lstBoxSelectedItems').children().length < 1) {
                //alert("There is no pattern to assign");
            ValidationWindow(objvar23, objAlert);
                return false;
            }
            else {
                var isNotExist = true;
                if ($('#hdnRowID').val() == '-1') {
                    $('#tblSelectedPatterns').find("tr").each(function() {
                        if ($('#ddlTargetInv :selected').text() == $(this).find("td:first").html())
                            isNotExist = false;
                    });
                }
                if (isNotExist) {
                    var patternValue = "";
                    var patternText = "";
                    var validationRule = "";
                    var index = 0;
                    $('#lstBoxSelectedItems').children("option").each(function() {
                        var $this = $(this);
                        if ($this.val().indexOf("toFixed") >= 0) {
                            if (index > 0) {
                                var preIndex = index - 1;
                                if ($('#lstBoxSelectedItems').find("option[index='" + preIndex + "']").prevObject[0][preIndex].value != ")") {
                                    // if ($('#lstBoxSelectedItems').find("option[index='" + preIndex + "']").val() != ")") {
                                    var objAlert = SListForAppMsg.Get("Admin_Alert_aspx") == null ? "Alert" : SListForAppMsg.Get("Admin_Alert_aspx");
                                    var objvar3 = SListForAppMsg.Get("Admin_ManageInvComputation_aspx_03") == null ? "Invalid Pattern" : SListForAppMsg.Get("Admin_ManageInvComputation_aspx_03");
                                    //alert("Invalid Pattern");
                                    ValidationWindow(objvar3, objAlert);
                                    return false;
                                }
                                else {
                                    patternValue += $this.val();
                                    if (patternText != "") {
                                        patternText += "~." + $this.text();
                                        validationRule += "~." + $this.text();
                                    }
                                    else {
                                        patternText += "." + $this.text();
                                        validationRule += "." + $this.text();
                                    }
                                }
                            }
                            else {
                                var objAlert = SListForAppMsg.Get("Admin_Alert_aspx") == null ? "Alert" : SListForAppMsg.Get("Admin_Alert_aspx");
                                var objvar3 = SListForAppMsg.Get("Admin_ManageInvComputation_aspx_03") == null ? "Invalid Pattern" : SListForAppMsg.Get("Admin_ManageInvComputation_aspx_03");

                                //alert("Invalid Pattern");
                                ValidationWindow(objvar3, objAlert);
                                return false;
                            }
                        }
                        else if ($this.text() == "Round") {
                            var $this = $(this);
                        var objAlert = SListForAppMsg.Get("Admin_Alert_aspx") == null ? "Alert" : SListForAppMsg.Get("Admin_Alert_aspx");
                        var objvar3 = SListForAppMsg.Get("Admin_ManageInvComputation_aspx_03") == null ? "Invalid Pattern" : SListForAppMsg.Get("Admin_ManageInvComputation_aspx_03");
                            if ($this.val().indexOf("Round") >= 0) {
                                if (index > 0) {
                                    var postIndex = index - 1;
                                    //   if (index + 1 < $('#lstBoxSelectedItems').children().length - 1) {
                                    //var postIndex = index + 1;
                                    if ($('#lstBoxSelectedItems').find("option[index='" + postIndex + "']").prevObject[0][postIndex].value != "(") {
                                        //if ($('#lstBoxSelectedItems').find("option[index='" + postIndex + "']").val() != "(") {
                                        //alert("Invalid Pattern");
                                        ValidationWindow(objvar3, objAlert);
                                        return false;
                                    }
                                    else {
                                        patternValue += $this.text();
                                        if (patternText != "") {
                                            patternText += "~" + $this.text();
                                            validationRule += "~" + $this.text();
                                        }
                                        else {
                                            patternText += $this.text();
                                            validationRule += $this.text();
                                        }
                                    }
                                }
                            }
                            else {
                                //alert("Invalid Pattern");
                                ValidationWindow(objvar3, objAlert);
                                return false;
                            }
                        }
                        else if ($("#lstBoxInvestigation").find("option[text='" + $this.text() + "']").length > 0) {
                            patternValue += $this.val();
                            if (patternText != "") {
                                patternText += "~" + $this.text();
                                validationRule += "~[" + $this.val() + "]";
                            }
                            else {
                                patternText += $this.text();
                                validationRule += "[" + $this.val() + "]";
                            }
                        }
                        else {
                            patternValue += $this.val();
                            if (patternText != "") {
                                patternText += "~" + $this.text();
                                validationRule += "~" + $this.val();
                            }
                            else {
                                patternText += $this.text();
                                validationRule += $this.val();
                            }
                        }
                        index += 1;
                    });
                    if (patternValue.length > 0) {
                        parse(patternValue, patternText, validationRule);
                    }
                }
                else {
                    var objAlert = SListForAppMsg.Get("Admin_Alert_aspx") == null ? "Alert" : SListForAppMsg.Get("Admin_Alert_aspx");
                    var objvar2 = SListForAppMsg.Get("Admin_ManageInvComputation_aspx_02") == null ? "Selected dependent investigation is already exist" : SListForAppMsg.Get("Admin_ManageInvComputation_aspx_02");

                    
                    ValidationWindow(objvar2, objAlert);
                    //alert("Selected dependent investigation is already exist");
                    return false;
                }
            }
            return false;
        }
        function Reset() {
            $('#tblgrpSearch').show();
            $('#tblContent').hide();
            $('#tdddlTargetInv').hide();

            $("#ddlInvGroup").val($("#ddlInvGroup option:first").val());


            if ($('#ddlInvGroup').children().length > 0) {
                $('#ddlInvGroup').attr('selectedIndex', '0');
            }
            ClearControls();
            return false;
        }
        function ClearControls() {
            $('#lstBoxInvestigation').children().remove();
            $('#lstBoxSelectedItems').children().remove();
            $('#ddlTargetInv').children().remove();
            $('#tblSelectedPatterns tr:not(:first)').remove();
            $('#hdnRowID').val('-1');
            $('#btnAssignPattern').val("Assign Pattern");
            $('tblContent').hide();
        }
        function Save() {
            var validationText = "";
            var patternText = "";
            if ($('#tblSelectedPatterns tr').length > 1) {
                $('#tblSelectedPatterns tr').each(function() {
                    if ($(this).find("td:first").length > 0) {
                        if (validationText != "" && patternText != "") {
                            validationText += " " + $(this).find("td:eq(3)").html();
                            patternText += "^" + $(this).find("td:eq(4)").html();
                        }
                        else {
                            validationText = $(this).find("td:eq(3)").html();
                            patternText = $(this).find("td:eq(4)").html();
                        }
                    }
                });
            }
            $("#hdnValidationText").val(validationText);
            $("#hdnValidationRule").val(patternText);
            return true;
        }
        function expandcollapse(obj, row) {
            var div = document.getElementById(obj);
            var img = document.getElementById('img' + obj);

            if (div.style.display == "none") {
                div.style.display = "block";
                if (row == 'alt') {
                    img.src = "../Images/minus.png";
                }
                else {
                    img.src = "../Images/minus.png";
                }
                img.alt = "Close to view other group";
            }
            else {
                div.style.display = "none";
                if (row == 'alt') {
                    img.src = "../Images/plus.png";
                }
                else {
                    img.src = "../Images/plus.png";
                }
                img.alt = "Expand to show investigation";
            }
        }

        $(document).ready(function() {
            $('#lblNoRecords').css('display', 'none');
        })
        function ClearSearch() {
            $('#txtSearch').val('');
            $('#lblNoRecords').css('display', 'none');
            $("#grdGroups tr:has(td)").show();
        }
        function SearchText() {
            $('#lblNoRecords').css('display', 'none'); // Hide No records to display label.
            $("#grdGroups tr:has(td)").hide(); // Hide all the rows.

            var iCounter = 0;
            var sSearchTerm = $('#txtSearch').val(); //Get the search box value

            if (sSearchTerm.length == 0) //if nothing is entered then show all the rows.
            {
                $("#grdGroups tr:has(td)").show();
                return false;
            }
            var tdIndex = 0;
            var tblId = '';
            var isParent = false;
            var isChild = false;
            var ChildtableId = '';
            var tdCount = $("#grdGroups tr:has(td)").children().length;
            //Iterate through all the td.
            $("#grdGroups tr:has(td)").children().each(function() {
                if ($(this).parents('table').attr('id') != 'grdGroups')
                    tblId = $(this).parents('table').attr('id');
                tdIndex = tdIndex + 1;
                if ($(this).parents('table').attr('id') == 'grdGroups' && $(this).html().indexOf('grdPatterns') == -1 && tdIndex > 0) {
                    if (isParent && !isChild) {
                        if (ChildtableId != '')
                            ChildtableId = ChildtableId + "~" + tblId;
                        else
                            ChildtableId = tblId;
                    }
                    else {
                        isParent = false;
                        isChild = false;
                    }
                }
                var cellText = $(this).text().toLowerCase();
                if (cellText.indexOf(sSearchTerm.toLowerCase()) >= 0) //Check if data matches
                {
                    if ($(this).parents('table').attr('id') == 'grdGroups')
                        isParent = true;
                    if ($(this).parents('table').attr('id').indexOf('grdPatterns') >= 0)
                        isChild = true;
                    $(this).parent().show();
                    iCounter++;
                    return true;
                }
                if (tdIndex == tdCount) {
                    if (isParent && !isChild) {
                        if (ChildtableId != '')
                            ChildtableId = ChildtableId + "~" + tblId;
                        else
                            ChildtableId = tblId;
                    }
                    else {
                        isParent = false;
                        isChild = false;
                    }
                }
            });
            var lstChildtableId = ChildtableId.split('~');

            for (var i = 0; i < lstChildtableId.length; i++) {
                if (lstChildtableId[i] != '')
                    $("#" + lstChildtableId[i] + " tr:has(td)").show();
            }
            if (iCounter == 0) {
                $('#lblNoRecords').css('display', 'block');
            }
            return false;
        }
        function Savemsg() {
            var objAlert = SListForAppMsg.Get("Admin_Alert_aspx") == null ? "Alert" : SListForAppMsg.Get("Admin_Alert_aspx");
            var objvar1 = SListForAppMsg.Get("Admin_ManageInvComputation_aspx_01") == null ? "Alert" : SListForAppMsg.Get("Admin_ManageInvComputation_aspx_01");

            // alert('Changes Saved Successfully');
            ValidationWindow(objvar1, objAlert);
        }
    </script>

</body>
</html>
