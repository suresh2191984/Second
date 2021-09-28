<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="PageContext.aspx.cs"
    Inherits="Admin_PageContext" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Page Context</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.11.3.min.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" ScriptMode="Release" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel runat="server" ID="uPanel1">
            <ContentTemplate>
                <asp:UpdateProgress ID="Progressbar1" AssociatedUpdatePanelID="uPanel1" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter" class="a-center">
                        </div>
                        <div id="processMessage" class="a-center w-20p">
                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <div style="height: 100%;">
                    <ajc:TabContainer ID="TabContainer1" runat="server" Visible="true" Enabled="true"
                        Height="520px">
                        <ajc:TabPanel ID="TabPanel1" runat="server">
                            <HeaderTemplate>
                                Page Context
                            </HeaderTemplate>
                            <ContentTemplate>
                                <div class="bg-row padding10">
                                    <table class="w-80p">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblPageName" runat="server" Text="Page Name"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlPageName" TabIndex="1" CssClass="ddl" Style="width: 57%"
                                                    runat="server">
                                                </asp:DropDownList>
                                                <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                <asp:HiddenField runat="server" ID="PageId" />
                                            </td>
                                            <%--</tr>
                                        <tr>--%>
                                            <td>
                                                <asp:Label ID="lnlButtonName" runat="server" Text="Button Name"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtButtonName" TabIndex="2" MaxLength="248" runat="server"></asp:TextBox>
                                                <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                            </td>
                                            <%--</tr>
                                        <tr>--%>
                                            <td>
                                                <asp:Label ID="lblButtonValue" runat="server" Text="Button Value"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtButtonValue" TabIndex="3" MaxLength="245" runat="server"></asp:TextBox>
                                                <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                            </td>
                                            <td class="a-center">
                                                <input type="button" id="btnAdd" tabindex="4" value="Save" class="btn1 btn-medium"
                                                    onclick="InsertPageContext();" />
                                                <input type="reset" id="btnClear" tabindex="5" value="Clear" cssclass="btn" onclick="Clear();" />
                                                <asp:HiddenField runat="server" ID="hdnId" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <br />
                                <br />
                                <div id="divtable" style="height: 420px;">
                                </div>
                            </ContentTemplate>
                        </ajc:TabPanel>
                        <ajc:TabPanel ID="tpActionManager" runat="server">
                            <HeaderTemplate>
                                Action Manager
                            </HeaderTemplate>
                            <ContentTemplate>
                                <div class="bg-row padding10">
                                    <table class="w-100p">
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label1" runat="server" Text="Action Type"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtActionType" MaxLength="245" runat="server" TabIndex="1"></asp:TextBox>
                                                <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                            </td>
                                            <%-- </tr>
                                        <tr>--%>
                                            <td>
                                                <asp:Label ID="Label3" runat="server" Text="Action Code"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtActionCode" MaxLength="100" runat="server" TabIndex="2"></asp:TextBox>
                                                <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                            </td>
                                            <%--</tr>
                                        <tr>--%>
                                            <td>
                                                <asp:Label ID="Label4" runat="server" Text="Type"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtType" MaxLength="100" runat="server" TabIndex="3"></asp:TextBox>
                                                <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label5" runat="server" Text="Language Code"></asp:Label>
                                            </td>
                                            <td>
                                                <%--<asp:TextBox ID="txtLanguageCode" runat="server" TabIndex="4"></asp:TextBox>--%>
                                                <select id="ddlLanguage" class="ddl" style="width: 175px;">
                                                </select>
                                                <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                            </td>
                                            <%--</tr>
                                        <tr>--%>
                                            <td>
                                                <asp:Label ID="Label2" runat="server" Text="Is Display"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="chkIsDispaly" runat="server" TabIndex="5"></asp:CheckBox>
                                                <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" class="a-center">
                                                <input type="button" id="btnSaveActionManager" tabindex="6" value="Save" class="btn1 btn-medium"
                                                    tabindex="6" onclick="SaveActionMaster();" />
                                                <input type="reset" id="btnreset" tabindex="7" value="Clear" cssclass="btn1 btn-small"
                                                    tabindex="7" onclick="ActionManagerClear();" />
                                                <%--<asp:HiddenField runat="server" ID="hdnActionmanagerId" />--%>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <br />
                                <br />
                                <div id="divActionManager" style="height: 390px;">
                                </div>
                            </ContentTemplate>
                        </ajc:TabPanel>
                        <ajc:TabPanel ID="tpActionTemplateType" runat="server">
                            <HeaderTemplate>
                                Action Template Type
                            </HeaderTemplate>
                            <ContentTemplate>
                                <div class="bg-row padding10">
                                    <table style="margin-right: 30%; margin-left: 30%;">
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label7" runat="server" Text="Action Template Type"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtTemplateType" MaxLength="245" TabIndex="1" runat="server"></asp:TextBox>
                                                <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                            </td>
                                            <td colspan="3" class="a-center">
                                                <input type="button" id="btnTemplateTypeSave" tabindex="2" value="Save" class="btn1 btn-medium"
                                                    onclick="InsertActionTemplateMaster();" />
                                                <input type="reset" id="btnTemplateTypeClear" tabindex="3" value="Clear" cssclass="btn1 btn-small"
                                                    onclick="ClearTemplateType();" />
                                                <%--<asp:HiddenField runat="server" ID="hdnActionTemplateMaster" />--%>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <br />
                                <div id="divActionTemplateType" style="height: 390px; margin-right: 30%; margin-left: 30%;">
                                </div>
                            </ContentTemplate>
                        </ajc:TabPanel>
                        <ajc:TabPanel ID="tpActionTemplate" runat="server">
                            <HeaderTemplate>
                                Action Template
                            </HeaderTemplate>
                            <ContentTemplate>
                                <div class="bg-row padding10">
                                    <table class="w-100p">
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label12" runat="server" Text="Action Template Type"></asp:Label>
                                            </td>
                                            <td>
                                                <select id="ddlActionTemplateType" tabindex="1" class="ddl" style="width: 175px;">
                                                </select>
                                                <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                            </td>
                                            <%--</tr>
                                        <tr>--%>
                                            <td>
                                                <asp:Label ID="Label6" runat="server" Text="Template"></asp:Label>
                                            </td>
                                            <td>
                                                <textarea id="txtActionTemplate" cols="40" rows="5" style="resize: auto !important;"
                                                    max="1000"></textarea>
                                                <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                            </td>
                                            <%--</tr>
                                        <tr>--%>
                                            <td>
                                                <asp:Label ID="Label8" runat="server" Text="Subject"></asp:Label>
                                            </td>
                                            <td>
                                                <textarea id="txtSubject" cols="40" style="resize: auto !important;" rows="5" max="399"></textarea>
                                                <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label9" runat="server" Text="Template Name"></asp:Label>
                                            </td>
                                            <td>
                                                <textarea id="txtTemplateName" cols="40" style="resize: auto !important;" rows="5"
                                                    max="200"></textarea>
                                                <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                            </td>
                                            <%-- </tr>
                                        <tr>--%>
                                            <td>
                                                <asp:Label ID="Label10" runat="server" Text="Attachment Name"></asp:Label>
                                            </td>
                                            <td>
                                                <textarea id="txtAttachmentName" cols="40" style="resize: auto !important;" rows="5"
                                                    max="999"></textarea>
                                                <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <br />
                                            <td colspan="6" class="a-center">
                                                <input type="button" id="btnActionTemplateSave" tabindex="6" value="Save" class="btn1 btn-medium"
                                                    onclick="InsertActionTemplate();" />
                                                <input type="reset" id="btnActionTemplateClear" tabindex="7" value="Clear" cssclass="btn1 btn-small"
                                                    onclick="ClearTemplate();" />
                                                <%--<asp:HiddenField runat="server" ID="hdnActionTemplate" />--%>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <br />
                                <br />
                                <div id="divActionTemplate" style="height: 260px;">
                                </div>
                            </ContentTemplate>
                        </ajc:TabPanel>
                        <ajc:TabPanel ID="tpPageContextActionMapping" runat="server">
                            <HeaderTemplate>
                                Page Context Action Mapping
                            </HeaderTemplate>
                            <ContentTemplate>
                                <div class="bg-row padding10">
                                    <table class="w-100p">
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label11" runat="server" Text="Page Context"></asp:Label>
                                            </td>
                                            <td>
                                                <select id="ddlPageContext" tabindex="1" class="ddl" style="width: 175px;">
                                                </select>
                                                <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                            </td>
                                            <%--</tr>
                                        <tr>--%>
                                            <td>
                                                <asp:Label ID="Label13" runat="server" Text="Role"></asp:Label>
                                            </td>
                                            <td>
                                                <select id="ddlRoles" tabindex="1" class="ddl" style="width: 175px;">
                                                </select>
                                                <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                            </td>
                                            <%--   </tr>
                                        <tr>--%>
                                            <td>
                                                <asp:Label ID="Label14" runat="server" Text="Action Type"></asp:Label>
                                            </td>
                                            <td>
                                                <select id="ddlActionType" tabindex="1" class="ddl" style="width: 175px;">
                                                </select>
                                                <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label15" runat="server" Text="Template"></asp:Label>
                                            </td>
                                            <td>
                                                <select id="ddlTemplate" tabindex="1" class="ddl" style="width: 175px;">
                                                </select>
                                                <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                            </td>
                                            <%--</tr>
                                        <tr>--%>
                                            <td>
                                                <asp:Label ID="Label16" runat="server" Text="Context Type"></asp:Label>
                                            </td>
                                            <td>
                                                <textarea id="txtContextType" cols="30" style="resize: auto !important;" rows="30"
                                                    max="99"></textarea>
                                                <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                            </td>
                                            <%--</tr>
                                        <tr>--%>
                                            <td>
                                                <asp:Label ID="Label18" runat="server" Text="Additional Context"></asp:Label>
                                            </td>
                                            <td>
                                                <textarea id="txtAdditionalContext" cols="30" style="resize: auto !important;" rows="30"
                                                    max="505"></textarea>
                                                <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label17" runat="server" Text="Description"></asp:Label>
                                            </td>
                                            <td>
                                                <textarea id="txtDescriptions" cols="30" style="resize: auto !important;" rows="30"
                                                    max="505"></textarea>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label20" runat="server" Text="Category"></asp:Label>
                                            </td>
                                            <td>
                                                <textarea id="txtCategory" cols="30" style="resize: auto !important;" rows="30" max="199"></textarea>
                                            </td>
                                            <%--</tr>
                                        <tr>--%>
                                            <td>
                                                <asp:Label ID="Label19" runat="server" Text="Is Attachment"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:CheckBox runat="server" ID="IsAttachment" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" class="a-center">
                                                <input type="button" id="btbPageContextActionMappingAdd" tabindex="6" value="Save"
                                                    class="btn1 btn-medium" onclick="InsertPageContextActionMapping();" />
                                                <input type="reset" id="btnPageContextActionMappingClear" tabindex="7" value="Clear"
                                                    cssclass="btn1 btn-small" onclick="ClearActionMapping();" />
                                                <asp:HiddenField runat="server" ID="HiddenField2" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <br />
                                <div id="dvPageContextActionMapping" style="height: 260px;">
                                </div>
                            </ContentTemplate>
                        </ajc:TabPanel>
                    </ajc:TabContainer>
                    <asp:HiddenField ID="hdnOrgId" runat="server" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div>
        </div>
        <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </div>
    </form>

    <script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.js" type="text/javascript"></script>

    <script type="text/javascript">

        // Page Context Tab
        var lstData;
        $(document).ready(function() {
            $('input[id$="txtPageName"]').focus();
            LoadLanguageCode();
            LoadPageNames();
            LoadPagecontext();
            LoadActionTemplateType();
        });
        function Clear() {
            $('select[id$="ddlPageName"]').val(0);
            $('input[id$="txtButtonName"]').val('');
            $('input[id$="txtButtonValue"]').val('');
            $('input[id$="txtPageName"]').focus();
            $('#btnAdd').val('Save');
            $('#TabContainer1_TabPanel1_hdnId').val(0);
            $('#TabContainer1_TabPanel1_ddlPageName').prop('disabled', false);
        }

        function LoadPageNames() {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetPagenames",
                contentType: "application/json; charset=utf-8",
                success: function(data) {
                    var ddlCustomers = $("[id=TabContainer1_TabPanel1_ddlPageName]");
                    ddlCustomers.empty().append('<option selected="selected" value="0">Please select</option>');
                    $.each(data.d, function() {
                        ddlCustomers.append($("<option></option>").val(this['PageID']).html(this['PageName']));
                    });
                },
                error: function(d) {
                    debugger;
                    alert('error')
                }
            });
        }
        function LoadPagecontext() {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetPageContext",
                contentType: "application/json; charset=utf-8",
                success: function(data) {
                    lstData = data;
                    var ddlCustomers = $("[id=TabContainer1_TabPanel1_ddlPageName]");
                    var value = '<table id="tbl" class="mytable1 w-100p gridView" ><thead><tr><th>PageName</th><th>Button Value</th><th>Button Name</th><th>Action</th></tr></thead><tbody>';
                    $.each(data.d, function(key, index) {
                        value += "<tr><td>" + data.d[key].PageName + "</td><td>" + data.d[key].ButtionValue + "</td><td>" + data.d[key].ButtonName + "</td><td><input style='margin-left: 5px;border-style: none;text-decoration: underline;' type='button' id='u" + data.d[key].PageContextID + "' class='btn1 btn-medium' onclick = 'FetchRecordForEdit(event)' value='Edit'/><input type='button' id='d" + data.d[key].PageContextID + "' style='margin-left: 5px;border-style: none;text-decoration: underline;' class='deleteIcons' onclick = 'FetchRecordForDelete(" + data.d[key].PageContextID + ")' value='Delete'/><input type='hidden'  value='" + data.d[key].PageContextID + "'/><input type='hidden' value='" + data.d[key].PageID + "'/></td></tr>";
                    });
                    value += "</tbody></table>"
                    $("#divtable").html(value);
                    $("#tbl").DataTable({ "scrollY": "300px",
                        "scrollCollapse": true,
                        "paging": true
                    });
                    //$("#tbl").removeClass("dataTable");
                },
                error: function(d) {
                    alert('error')
                }
            });
        }

        function InsertPageContext() {
            debugger;
            var id = $('#TabContainer1_TabPanel1_hdnId').val() == "" ? 0 : $('#TabContainer1_TabPanel1_hdnId').val();

            var Pagecontext = { 'pageContextID': id, 'pageID': $('#TabContainer1_TabPanel1_ddlPageName').val(),
                'buttonName': $('#TabContainer1_TabPanel1_txtButtonName').val(), 'buttionValue': $('#TabContainer1_TabPanel1_txtButtonValue').val(),
                'pageName': $('#TabContainer1_TabPanel1_ddlPageName option:selected').text()
            }
            if ($('#TabContainer1_TabPanel1_ddlPageName').val() == 0) {
                alert('Please select Page Name.');
            }
            else if ($('#TabContainer1_TabPanel1_txtButtonName').val() == "") {
                alert('Plese enter Buton Name.');
            }
            else if ($('#TabContainer1_TabPanel1_txtButtonValue').val() == "") {
                alert('Please enter Button Value.');
            }
            else if (!ValidateDuplicate()) {
                alert('Record is available alredy.');
            }
            else {
                debugger;
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/InsertPageContext",
                    data: JSON.stringify({ pagecontext: Pagecontext }),
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function(ds) { debugger; id == 0 ? alert('Saved successfully.') : alert('Updated successfully.'); $('#TabContainer1_TabPanel1_hdnId').val(0); Clear(); $('#btnAdd').val('Save'); $('#TabContainer1_TabPanel1_ddlPageName').prop('disabled', false); LoadPagecontext(); },
                    error: function(data) { alert(data); }
                });
            }
        }

        function FetchRecordForEdit(values) {
            debugger;
            if (values == 0) {
                alert('Please select the record to edit.');
                return;
            }
            else {
                debugger;
                var f = $("#tbl tr:nth(" + parseInt(values.path[2].rowIndex) + ")");
                var columns = f.find('td');

                $('#btnAdd').val('Update');
                $('#TabContainer1_TabPanel1_ddlPageName').prop('disabled', true);
                $('#TabContainer1_TabPanel1_ddlPageName').val(columns[3].childNodes[3].value);
                $('#TabContainer1_TabPanel1_txtButtonValue').val(columns[1].innerText);
                $('#TabContainer1_TabPanel1_txtButtonName').val(columns[2].innerText);
                $('#TabContainer1_TabPanel1_hdnId').val(columns[3].childNodes[2].value);
            }
        }

        function FetchRecordForDelete(values) {
            debugger;
            if (values == 0) {
                alert('Please select the record to edit.');
                return;
            }
            else if (confirm('Are you sure to delete?')) {
                $.ajax({
                    url: '../WebService.asmx/DeletePageContextbyId',
                    type: 'POST',
                    dataType: 'json',
                    data: JSON.stringify({ val: values }),
                    contentType: 'application/json; charset=utf-8',
                    success: function(data) { debugger; alert('Deleted successfully.'); LoadPagecontext(); },
                    error: function() { debugger; alert('error'); }
                });
            }
        }

        function ValidateDuplicate() {
            var istrue = true;
            var id = $('#TabContainer1_TabPanel1_hdnId').val() == "" ? 0 : $('#TabContainer1_TabPanel1_hdnId').val();
            var Pagecontext = { 'pageContextID': id, 'pageID': $('#TabContainer1_TabPanel1_ddlPageName').val(),
                'buttonName': $('#TabContainer1_TabPanel1_txtButtonName').val(), 'buttionValue': $('#TabContainer1_TabPanel1_txtButtonValue').val(),
                'pageName': $('#TabContainer1_TabPanel1_ddlPageName option:selected').text()
            }
            $.each(lstData.d, function(key) {
                if (id == 0) {
                    if (Pagecontext.pageName == lstData.d[key].PageName && Pagecontext.buttionValue == lstData.d[key].ButtionValue && Pagecontext.buttonName == lstData.d[key].ButtonName) {
                        istrue = false;
                        return istrue;
                    }
                }
                //                else if (id > 0) {
                //                    if (Pagecontext.pageName == lstData.d[key].PageName && Pagecontext.buttionValue == lstData.d[key].ButtionValue && Pagecontext.buttonName == lstData.d[key].ButtonName && Pagecontext.pageContextID == lstData.PageContextID) {
                //                        istrue = false;
                //                        return istrue;
                //                    }
                //}
            });
            return istrue;
        }
    
    </script>

    <script type="text/javascript">
        // Action Manager

        function ActionManagerClear() {
            debugger;
            $('#TabContainer1_tpActionManager_txtActionType').val("");
            $('#TabContainer1_tpActionManager_txtActionCode').val("");
            $('#TabContainer1_tpActionManager_txtType').val("");
            $('#ddlLanguage').val(0);
            $('#TabContainer1_tpActionManager_chkIsDispaly').prop('checked', false);
            $('#TabContainer1_tpActionManager_txtActionType').focus();
            $('#btnSaveActionManager').val('Save');
        }

        function LoadLanguageCode() {
            debugger;
            $.ajax({
                type: 'POST',
                url: "../WebService.asmx/FetchLanguage",
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function(data) {
                    debugger;
                    var ddlCustomers = $("[id=ddlLanguage]");
                    ddlCustomers.empty().append('<option selected="selected" value="0">Please select</option>');
                    $.each(data.d, function(key, data) {
                        debugger;
                        ddlCustomers.append($("<option></option>").val(this['Code']).html(this['Name']));
                    });
                },
                error: function() {
                    debugger;
                    alert("An error occurred.");
                }
            });
        }

        function LoadActionManagerTypeDetails() {
            debugger;
            $.ajax({
                url: '../WebService.asmx/FetchActionManagerType',
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function(data) {
                    debugger;
                    var table = '<table id="tblActionManager"  class="mytable1 w-100p gridView"><thead><tr><th>Action Type</th><th>Action Code</th><th>Is Display</th><th>Type</th><th>Lang Code</th><th>Action</th></tr></thead><tbody>';
                    $.each(data.d, function(key) {
                        table += '<tr><td>' + data.d[key].ActionType + '</td><td>' + data.d[key].ActionCode + '</td><td>' + data.d[key].IsDisplay + '</td><td>' + data.d[key].Type +
                    '</td><td>' + data.d[key].LangCode + '</td><td><input type="button" style="margin-left: 5px;border-style: none;text-decoration: underline;" value="Edit" onclick=Editactionmanagertype(event) class="btn1"/>' +
                    '<input type="button" onclick=DeleteActionmanagertype(' + data.d[key].ActionTypeID + ') value="Delete" style="margin-left: 5px;border-style: none;text-decoration: underline;" class="deleteIcons"/>' +
                    '<input type="hidden" value=' + data.d[key].ActionTypeID + '></td></tr>';
                    });
                    table += '</tbody></table>';
                    $('#divActionManager').html(table);
                    $("#tblActionManager").DataTable({ "scrollY": "300px",
                        "scrollCollapse": false,
                        "paging": true,
                        "loading": true
                    });

                },
                error: function() { debugger; alert('error'); }
            });
        }

        function SaveActionMaster() {
            debugger;
            if ($('#TabContainer1_tpActionManager_txtActionCode').val() == "") {
                alert('Please enter Action Code.');
            }
            else if ($('#TabContainer1_tpActionManager_txtActionType').val() == "") {
                alert('Please enter Action Type.');
            }
            else if ($('#ddlLanguage').val() == 0) {
                alert('Please select Language Code');
            }
            else if ($('#TabContainer1_tpActionManager_txtType').val() == "") {
                alert('Please enter Type');
            }
            else {
                var chek = $('#TabContainer1_tpActionManager_chkIsDispaly').prop('checked') == true ? 'Y' : 'N';
                var Id = $('#TabContainer1_TabPanel1_hdnId').val() == "" ? 0 : $('#TabContainer1_TabPanel1_hdnId').val();
                var ActionMaster = { 'ActionCode': $('#TabContainer1_tpActionManager_txtActionCode').val(), 'ActionType': $('#TabContainer1_tpActionManager_txtActionType').val(), 'IsDisplay': chek, 'LangCode': $('#ddlLanguage').val(), 'Type': $('#TabContainer1_tpActionManager_txtType').val(), 'ActionTypeID': Id };

                $.ajax({
                    url: '../WebService.asmx/SaveActionManagerType',
                    type: 'POST',
                    data: JSON.stringify({ 'actionmanager': ActionMaster }),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function(data) {
                        debugger; if (data.d == 1) { alert('Saved successfully.'); $('#btnSaveActionManager').val('Save'); ActionManagerClear(); LoadActionManagerTypeDetails(); }
                        else if (data.d == 10) {
                            alert('Record is already exist.');
                        }
                    },
                    error: function() { debugger; alert('error'); }
                });
            }
        }

        function DeleteActionmanagertype(Id) {
            debugger;
            if (Id == 0) {
                alert('Please select the record to delete.');
            }
            else if (confirm('Are you sure to delete?')) {
                $.ajax({
                    url: '../WebService.asmx/DeletActionManagerType',
                    type: 'POST',
                    data: JSON.stringify({ 'Id': Id }),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function(data) { if (data.d > 0) { alert('Deleted successfully.'); LoadActionManagerTypeDetails(); } },
                    error: function() { alert('error'); }
                });
            }
        }

        function Editactionmanagertype(event) {
            debugger;
            var row = $('#tblActionManager tr:nth(' + event.path[2].rowIndex + ')');
            var columns = row.find('td');
            if (columns.length > 0) {
                $('#btnSaveActionManager').val('Update');
                $('#TabContainer1_tpActionManager_txtActionType').val(columns[0].innerText);
                $('#TabContainer1_tpActionManager_txtActionCode').val(columns[1].innerText);
                $('#TabContainer1_tpActionManager_txtType').val(columns[3].innerText);
                $('#ddlLanguage').val(columns[4].innerText);
                $('#TabContainer1_tpActionManager_chkIsDispaly').prop('checked', columns[2].innerText == 'Y' ? true : false);
                $('#TabContainer1_TabPanel1_hdnId').val(columns[5].childNodes[2].value);
            }
            else {
                alert('Please select the rows to edit.');
            }
        }

        $(document.body).on('click', '#__tab_TabContainer1_tpActionManager', function() {
            LoadActionManagerTypeDetails();
        });
        
        
    </script>

    <script type="text/javascript">

        //ActionTemplateTypeMaster
        function FetchActionTemplateType() {
            $.ajax({
                type: 'POST',
                url: '../WebService.asmx/FetchActionTemplateType',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function(data) {
                    debugger;
                    var table = '<table id="tblActionTemplateType" class="mytable1 w-100p gridView"><thead><tr><th>Action Template Type</th><th style="width: 35px !Important;">Action</th></tr></thead><tbody>';
                    $.each(data.d, function(key, s) {
                        debugger;
                        table += '<tr><td>' + s.TemplateType + '</td><td style="width: 50px !Important;"><input type="button" onclick="AssignTemplateType(event)" style="margin-left: 5px;border-style: none;text-decoration: underline;" value="Edit" class="EditIcon"/>' +
                        '<input type="button" onclick="DeleteTemplateType(' + s.TemplateTypeID + ')" style="margin-left: 5px;border-style: none;text-decoration: underline;" value="Delete" class="deleteIcons"/>' +
                        '<input type="hidden" value=' + s.TemplateTypeID + '></td></tr>';
                    });
                    table += '</tbody></table>';
                    $('#divActionTemplateType').html(table);
                    $('#tblActionTemplateType').DataTable({
                        "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
                    });
                    //$('#tblActionTemplateType').removeClass('dataTable');

                },
                error: function() { debugger; alert('Error'); }
            });
        }

        function ClearTemplateType() {
            $('#TabContainer1_tpActionTemplateType_txtTemplateType').val("");
            $('#TabContainer1_TabPanel1_hdnId').val("");
            $('#TabContainer1_tpActionTemplateType_txtTemplateType').focus();
            $('#btnTemplateTypeSave').val('Save');
        }

        function AssignTemplateType(event) {
            debugger;
            var row = $('#tblActionTemplateType tr:nth(' + event.path[2].rowIndex + ')');
            var columns = row.find('td');
            if (columns.length > 0) {
                $('#btnTemplateTypeSave').val('Update');
                $('#TabContainer1_tpActionTemplateType_txtTemplateType').val(columns[0].innerText);
                $('#TabContainer1_TabPanel1_hdnId').val(columns[1].childNodes[2].value);
            }
            else {
                alert('Please select the rows to edit.');
            }
        }

        function DeleteTemplateType(Id) {
            debugger;
            if (Id == 0) { alert('Please select record to delete.'); }
            else if (confirm('Are you sure to delete.')) {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/DeletActionTemplateType",
                    data: JSON.stringify({ "Id": Id }),
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function() { debugger; alert('Record deleted successfully.'); FetchActionTemplateType(); },
                    error: function() { alert('Error'); }
                });
            }
        }
        function InsertActionTemplateMaster() {
            debugger;
            if ($('#TabContainer1_tpActionTemplateType_txtTemplateType').val() == "") {
                alert('Please enter Template Type.');
            }
            else {
                var id = $('#TabContainer1_TabPanel1_hdnId').val() == "" ? 0 : $('#TabContainer1_TabPanel1_hdnId').val();
                var value = { 'TemplateType': $('#TabContainer1_tpActionTemplateType_txtTemplateType').val(), 'TemplateTypeID': id };

                $.ajax({
                    url: '../WebService.asmx/InsertActionTemplateType',
                    type: 'POST',
                    data: JSON.stringify({ 'actionTemplateType': value }),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function(data) {
                        debugger;
                        if (data.d == 1)
                        { alert('Saved successfully.'); ClearTemplateType(); FetchActionTemplateType(); $('#btnTemplateTypeSave').val('Save'); }
                        else if (data.d == 10)
                        { alert('Record is already exist.'); }
                    },
                    error: function() { debugger; alert('Error'); }
                });
            }
        }


        $(document.body).on('click', '#__tab_TabContainer1_tpActionTemplateType', function() {
            FetchActionTemplateType();
        });
        
    </script>

    <script type="text/javascript">

        //ActionTemplateMaster

        function LoadActionTemplateType() {
            $.ajax({
                type: 'POST',
                url: '../WebService.asmx/FetchActionTemplateType',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function(data) {
                    var ddlActionTemplateType = $("[id=ddlActionTemplateType]");
                    ddlActionTemplateType.empty().append('<option selected="selected" value="0">Please select</option>');
                    $.each(data.d, function(key, data) {
                        debugger;
                        ddlActionTemplateType.append($("<option></option>").val(this['TemplateTypeID']).html(this['TemplateType']));
                    });
                },
                error: function() { alert('Error'); }
            });
        }

        function FetchActionTemplate() {
            $.ajax({
                type: 'POST',
                url: '../WebService.asmx/FetchActionTemplate',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function(data) {
                    debugger;
                    var table = '<table name="tblActionTemplates" id="tblAction" class="mytable1 w-100p gridView" ><thead><tr><th>Template Type</th><th>Template</th><th>Subject</th><th>Template Name</th><th>Attachment Name</th><th>Action</th></tr></thead><tbody>';
                    $.each(data.d, function(key, s) {
                        debugger;
                        table += '<tr><td>' + s.TemplateType + '</td><td>' + s.Template + '</td><td style="width:250px !Important; word-break:break-all;">' + s.Subject + '</td><td>' + s.TemplateName + '</td><td style="width:250px !Important; word-break:break-all;">' + s.AttachmentName + '</td><td><input type="button" onclick="AssignTemplate(event)" style="margin-left: 5px;border-style: none;text-decoration: underline;" value="Edit" class="EditIcon"/>' +
                        '<input type="button" onclick="DeleteTemplate(' + s.TemplateID + ')" style="margin-left: 5px;border-style: none;text-decoration: underline;" value="Delete" class="deleteIcons"/>' +
                        '<input type="hidden" value=' + s.TemplateID + '><input type="hidden" value=' + s.TemplateTypeID + '></td></tr>';
                    });
                    table += '</tbody></table>';
                    $('#divActionTemplate').html(table);
                    $('#tblAction').DataTable({ scrollY: "260px",
                        scrollCollapse: true,
                        loading: true
                    });
                    debugger;
                },
                error: function() { debugger; alert('Error'); }
            });
        }

        function ClearTemplate() {
            $('#ddlActionTemplateType').val(0);
            $('#TabContainer1_TabPanel1_hdnId').val("");
            $('#txtActionTemplate').val("");
            $('#txtSubject').val("");
            $('#txtTemplateName').val("");
            $('#txtAttachmentName').val("");
            $('#btnActionTemplateSave').val('Save');
        }

        function AssignTemplate(event) {
            debugger;
            var row = $('#tblAction tr:nth(' + event.path[2].rowIndex + ')');
            var columns = row.find('td');
            if (columns.length > 0) {
                $('#btnActionTemplateSave').val('Update');
                $('#ddlActionTemplateType').val(columns[5].childNodes[3].value);
                $('#txtActionTemplate').val(columns[1].innerText);
                $('#txtSubject').val(columns[2].innerText);
                $('#txtTemplateName').val(columns[3].innerText);
                $('#txtAttachmentName').val(columns[4].innerText);
                $('#TabContainer1_TabPanel1_hdnId').val(columns[5].childNodes[2].value);
            }
            else {
                alert('Please select the rows to edit.');
            }
        }

        function DeleteTemplate(Id) {
            debugger;
            if (Id == 0) { alert('Please select record to delete.'); }
            else if (confirm('Are you sure to delete.')) {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/DeletActionTemplate",
                    data: JSON.stringify({ "Id": Id }),
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function() { debugger; alert('Record deleted successfully.'); FetchActionTemplate(); },
                    error: function() { alert('Error'); }
                });
            }
        }
        function InsertActionTemplate() {
            debugger;
            if ($('#ddlActionTemplateType').val() == 0) {
                alert('Please select Action Template Type.');
            }
            else if ($('#txtActionTemplate').val() == "") {
                alert('Please enter Action Template.');
            }
            else if ($('#txtSubject').val() == "") {
                alert('Please enter Subject.');
            }
            else if ($('#txtTemplateName').val() == "") {
                alert('Please enter Template Name');
            }
            else if ($('#txtAttachmentName').val() == "") {
                alert('Please enter Attachment Name');
            }
            else {
                var id = $('#TabContainer1_TabPanel1_hdnId').val() == "" ? 0 : $('#TabContainer1_TabPanel1_hdnId').val();
                var value = { 'AttachmentName': $('#txtAttachmentName').val(), 'Subject': $('#txtSubject').val(), 'Template': $('#txtActionTemplate').val(),
                    'TemplateID': id, 'TemplateName': $('#txtTemplateName').val(), 'TemplateTypeID': $('#ddlActionTemplateType').val()
                };

                $.ajax({
                    url: '../WebService.asmx/InsertActionTemplate',
                    type: 'POST',
                    data: JSON.stringify({ 'actionTemplate': value }),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function(data) {
                        debugger;
                        if (data.d == 1)
                        { alert('Saved successfully.'); ClearTemplate(); FetchActionTemplate(); $('#btnActionTemplateSave').val('Save'); }
                        else if (data.d == 10)
                        { alert('Record is already exist.'); }
                    },
                    error: function() { debugger; alert('Error'); }
                });
            }
        }


        $(document.body).on('click', '#__tab_TabContainer1_tpActionTemplate', function() {
            FetchActionTemplate();
            LoadActionTemplateType();
        });
        
    </script>

    <script type="text/javascript">

        //PageContextActionMapping

        function LoadPageContext() {
            $.ajax({
                type: 'POST',
                url: '../WebService.asmx/GetPageContext',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function(data) {
                    var ddlPageContext = $("[id=ddlPageContext]");
                    ddlPageContext.empty().append('<option selected="selected" value="0">Please select</option>');
                    $.each(data.d, function(key, data) {
                        ddlPageContext.append($("<option></option>").val(this['PageContextID']).html(this['PageName']));
                    });
                },
                error: function() { alert('Error'); }
            });
        }
        function LoadRole() {
            debugger;
            $.ajax({
                type: 'POST',
                url: '../WebService.asmx/BindRole',
                dataType: 'json',
                data: JSON.stringify({ 'orgID': $('#hdnOrgId').val() }),
                contentType: 'application/json; charset=utf-8',
                success: function(data) {
                    debugger;
                    var ddlRole = $("[id=ddlRoles]");
                    ddlRole.empty().append('<option selected="selected" value="0">Please select</option>');
                    var roleId = 0;
                    $.each(data.d, function(key, data) {
                        debugger;
                        roleId = this['RoleName'];
                        ddlRole.append($("<option></option>").val(roleId.split('~')[0]).html(this['Description']));
                    });
                },
                error: function() { alert('Error'); }
            });
        }

        function LoadActionType() {
            $.ajax({
                type: 'POST',
                url: '../WebService.asmx/FetchActionManagerType',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function(data) {
                    var ddlActionType = $("[id=ddlActionType]");
                    ddlActionType.empty().append('<option selected="selected" value="0">Please select</option>');
                    $.each(data.d, function(key, data) {
                        ddlActionType.append($("<option></option>").val(this['ActionTypeID']).html(this['ActionType']));
                    });
                },
                error: function() { alert('Error'); }
            });
        }

        function LoadddlTemplate() {
            $.ajax({
                type: 'POST',
                url: '../WebService.asmx/FetchActionTemplate',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function(data) {
                    var ddlTemplate = $("[id=ddlTemplate]");
                    ddlTemplate.empty().append('<option selected="selected" value="0">Please select</option>');
                    $.each(data.d, function(key, data) {
                        ddlTemplate.append($("<option></option>").val(this['TemplateID']).html(this['TemplateName']));
                    });
                },
                error: function() { alert('Error'); }
            });
        }


        function FetchPageContextActionMapping() {
            $.ajax({
                type: 'POST',
                url: '../WebService.asmx/FetchPageContextActionMapping',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function(data) {
                    debugger;
                    var table = '<table  id="tblPageContext" class="mytable1 w-100p gridView" ><thead><tr><th>Page Context</th><th>Role</th><th>Action Type</th><th>Template</th><th>Context Type</th><th>Additional Context</th><th>Description</th><th>Category</th><th>Is Attachment</th><th>Action</th></tr></thead><tbody>' //'<table  id="tblPageContextActionMapping" class="mytable1 w-100p gridView" ><thead><tr><th>Page Context</th></tr></thead><tbody>';
                    $.each(data.d, function(key, s) {
                        debugger;
                        table += '<tr><td>' + s.PageName + '</td><td>' + s.RoleName + '</td><td>' + s.ActionType + '</td><td>' + s.TemplateName + '</td><td>' + s.ContextType + '</td><td>' + s.AdditionalContext + '</td><td>' + s.Description + '</td><td>' + s.Category + '</td><td>' + s.IsAttachment + '</td><td><input type="button" onclick="AssignPageContextActionMapping(event)" style="margin-left: 5px;border-style: none;text-decoration: underline;" value="Edit" class="EditIcon"/><input type="button" onclick="DeletePageContextActionMapping(' + s.MappingID + ')" style="margin-left: 5px;border-style: none;text-decoration: underline;" value="Delete" class="deleteIcons"/>' +
                        '<input type="hidden" value=' + s.MappingID + '><input type="hidden" value=' + s.PageContextID + '><input type="hidden" value=' + s.RoleID + '><input type="hidden" value=' + s.ActionTypeID + '><input type="hidden" value=' + s.TemplateID + '></td></tr>';
                    });
                    table += '</tbody></table>';
                    $('#dvPageContextActionMapping').html(table);

                    $('#tblPageContext').DataTable({ scrollY: "270px", scrollCollapse: true });
                    debugger;
                    //$('#tblPageContextActionMapping').removeClass("dataTable");
                },
                error: function() { debugger; alert('Error'); }
            });
        }

        function ClearActionMapping() {
            $('#ddlPageContext').val(0);
            $('#ddlRoles').val(0);
            $('#ddlActionType').val(0);
            $('#ddlTemplate').val(0);
            $('#TabContainer1_TabPanel1_hdnId').val("");
            $('#txtContextType').val("");
            $('#txtAdditionalContext').val("");
            $('#txtDescriptions').val("");
            $('#txtCategory').val("");
            $('#btbPageContextActionMappingAdd').val('Save');
            $('#TabContainer1_tpPageContextActionMapping_IsAttachment').prop('checked', false);
        }

        function AssignPageContextActionMapping(event) {
            debugger;
            var row = $('#tblPageContext tr:nth(' + event.path[2].rowIndex + ')');
            var columns = row.find('td');
            if (columns.length > 0) {
                $('#btbPageContextActionMappingAdd').val('Update');
                $('#ddlPageContext').val(columns[9].childNodes[3].value);
                $('#ddlRoles').val(columns[9].childNodes[4].value);
                $('#ddlActionType').val(columns[9].childNodes[5].value);
                $('#ddlTemplate').val(columns[9].childNodes[6].value);
                $('#txtContextType').val(columns[4].innerText);
                $('#txtAdditionalContext').val(columns[5].innerText);
                $('#txtDescriptions').val(columns[6].innerText);
                $('#txtCategory').val(columns[7].innerText);
                var v =
                $('#TabContainer1_tpPageContextActionMapping_IsAttachment').prop('checked', columns[8].innerText == 'Y' ? true : false);
                $('#TabContainer1_TabPanel1_hdnId').val(columns[9].childNodes[2].value);
            }
            else {
                alert('Please select the rows to edit.');
            }
        }

        function DeletePageContextActionMapping(Id) {
            debugger;
            if (Id == 0) { alert('Please select record to delete.'); }
            else if (confirm('Are you sure to delete.')) {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/DeletPageContextActionMapping",
                    data: JSON.stringify({ "Id": Id }),
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function() { debugger; alert('Record deleted successfully.'); FetchPageContextActionMapping(); },
                    error: function() { alert('Error'); }
                });
            }
        }
        function InsertPageContextActionMapping() {
            debugger;
            if ($('#ddlPageContext').val() == 0) {
                alert('Please select Page Context.');
            }
            else if ($('#ddlRoles').val() == 0) {
                alert('Please select Role.');
            }
            else if ($('#ddlActionType').val() == 0) {
                alert('Please select Action Type.');
            }
            else if ($('#ddlTemplate').val() == 0) {
                alert('Please select Template.');
            }
            else if ($('#txtContextType').val() == "") {
                alert('Please enter Context Type.');
            }
            else if ($('#txtAdditionalContext').val() == "") {
                alert('Please enter Additional Context.');
            }
            //            else if ($('#txtDescriptions').val() == "") {
            //                alert('Please enter Description.');
            //            }
            //            else if ($('#txtCategory').val() == "") {
            //                alert('Please enter Category.');
            //            }
            else {
                debugger;
                var id = $('#TabContainer1_TabPanel1_hdnId').val() == "" ? 0 : $('#TabContainer1_TabPanel1_hdnId').val();
                var isattachment = $('#TabContainer1_tpPageContextActionMapping_IsAttachment').prop('checked') == true ? "Y" : "N";
                var value = { 'MappingID': id, 'PageContextID': $('#ddlPageContext').val(), 'RoleID': $('#ddlRoles').val(),
                    'ActionTypeID': $('#ddlActionType').val(), 'TemplateID': $('#ddlTemplate').val(), 'ContextType': $('#txtContextType').val(), 'AdditionalContext': $('#txtAdditionalContext').val(),
                    'Description': $('#txtDescriptions').val(), 'IsAttachment': isattachment, 'Category': $('#txtCategory').val()
                };

                $.ajax({
                    url: '../WebService.asmx/InsertPageContextActionMapping',
                    type: 'POST',
                    data: JSON.stringify({ 'actionmapping': value }),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function(data) {
                        debugger;
                        if (data.d == 1)
                        { alert('Saved successfully.'); ClearActionMapping(); FetchPageContextActionMapping(); $('#btbPageContextActionMappingAdd').val('Save'); }
                        else if (data.d == 10)
                        { alert('Record is already exist.'); }
                    },
                    error: function() { debugger; alert('Error'); }
                });
            }
        }


        $(document.body).on('click', '#__tab_TabContainer1_tpPageContextActionMapping', function() {
            FetchPageContextActionMapping();
            LoadPageContext();
            LoadActionType();
            LoadddlTemplate();
            LoadRole();
        });
        
    </script>

</body>
</html>
