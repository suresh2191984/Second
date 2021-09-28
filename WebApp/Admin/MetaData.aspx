<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MetaData.aspx.cs" Inherits="Admin_MetaData" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Meta Data</title>
    <%-- <script type="text/javascript" src="scripts/jquery.js"></script>--%>
    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css" />

    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>

    <style type="text/css">
        .hide_Column
        {
            display: none;
        }
    </style>

    <script type="text/javascript">
        //insert and update
        $(function() {
            $("#btnSave").bind("click", function() {
                var objMetaData = {};
                objMetaData.Domain = $("[id*=txtDomain]").val();
                objMetaData.Code = $("[id*=txtCode]").val();
                objMetaData.Name = $("[id*=txtName]").val();
                objMetaData.DisplayText = $("[id*=txtDisplayText]").val();
                objMetaData.ParentID = 0;
                objMetaData.SeqNo = 0;
                objMetaData.LangCode = $("#ddlLanguageCode").val();
                //alert(objMetaData.LangCode);
                if (objMetaData.Domain == "") {
                    $("#txtDomain").focus();
                    alert('Domain name cannot be empty');
                    return false;
                }
                if (objMetaData.Code == "") {
                    $("#txtCode").focus();
                    alert('Code cannot be empty');
                    return false;
                }
                if (objMetaData.Name == "") {
                    $("#txtName").focus();
                    alert("Name cannot be empty");
                    return false;
                }
                if (objMetaData.DisplayText == "") {
                    $("#txtDisplayText").focus();
                    alert('DisplayText cannot be empty');
                    return false;
                }
                if (objMetaData.LangCode == "0") {
                    $("#ddlLanguageCode").focus();
                    alert("Select Language");
                    return false;
                }
                //added for update and save diff

                var button_text = $('#btnSave').val();
                if (button_text == "Update") {
                    objMetaData.MetaDataID = $("#hdnMetaDataId").val();
                }
                else {
                    objMetaData.MetaDataID = 0;
                }

                $.ajax({

                    type: "POST",
                    url: "../WebService.asmx/pInsertMetaData",
                    data: '{objMetaData: ' + JSON.stringify(objMetaData) + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(response) {
                        if (response.d == 2) {
                            alert("Domain Name already mapped for this org and language");
                            return false;
                        }
                        else {
                            showData();
                           // HttpContext.Current.Cache.Remove("MetaDataCacheLIS");
                            alert("Meta Data has been added successfully.");
                        }
                        // window.location.reload();
                    }
                });

            });

        });

        //Load record
        function showData() {

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetMetaData",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function Aj(dat) {
                    AjaxGetFieldDataSuccees(dat);
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error in Webservice showData calling");
                    //$('#divHistoryDetail').hide();
                    return false;
                }
            });
        }
        var lstEdithis = [];
        function AjaxGetFieldDataSuccees(result) {
            lstEdithis = result.d[0];
            if (lstEdithis.length > 0) {

                $.each(result.d[1], function(key, value) {
                    $("#ddlLanguageCode").append($("<option></option>").val(value.Code).html(value.Name))
                });


                $('#tblMetaData  tbody > tr').remove();


                $('#tblMetaData').dataTable({
                    paging: true,
                    "aLengthMenu": [[20, 40, 60, 80, -1], [20, 40, 60, 80, "All"]],
                    data: lstEdithis,
                    "bDestroy": true,
                    "searchable": true,
                    "sort": true,

                    columns: [
                                            { 'data': 'MetaDataID',
                                                "sClass": "hide_Column"

                                            },
                                            { 'data': 'Domain'

                                            },
                                            { 'data': 'Code'

                                            },
                                            { 'data': 'Name'

                                            },
                                           { 'data': 'DisplayText'
                                           },
                                           {
                                               'data': 'LangName'
                                           },
                                           { 'data': 'LangCode',
                                               "sClass": "hide_Column"
                                           },
                                                          {
                                                              'data': 'Edit',
                                                              "mRender": function(data, type, full, meta) {
                                                                  return '<input value = "Edit" class="deleteIcons1" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer"  />';
                                                              }
                                                          },
                ]
                });
            }
            else {
                alert('No records found');
            }
        }
        //Edit
        $(function() {
            debugger;
            $(document).on('click', '#tblMetaData tr', function() {
                var A = $("#tblMetaData tr:nth(" + this.rowIndex + ")");
                $("#hdnMetaDataId").val(A[0].cells[0].innerText);
                $("#txtDomain").val(A[0].cells[1].innerText);
                $("#txtCode").val(A[0].cells[2].innerText);
                $("#txtName").val(A[0].cells[3].innerText);
                $("#txtDisplayText").val(A[0].cells[4].innerText);
                $("#ddlLanguageCode").val(A[0].cells[6].innerText);
                $("#btnSave").attr('value', 'Update');
                var button_text = $('#btnSave').val();

            });
        });
        //end
        $(document).ready(function() {
            $("#btnClear").click(function() {
                $("#txtDomain").val("");
                $("#txtCode").val("");
                $("#txtDisplayText").val("");
                $("#txtName").val("");
                $("#ddlLanguageCode").val('0');
                $("#btnSave").attr('value', 'Save');
            });
        });
       //
        $(document).ready(function() {
            showData();
        });
        
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="upMetaData" runat="server">
            <ContentTemplate>
                <table class="w-90p searchPanel b-tab">
                    <tr>
                        <td>
                            Domain
                        </td>
                        <td>
                            <%-- <asp:TextBox ID="txtDomain" runat="server" class="small" TabIndex="1"></asp:TextBox>--%>
                            <input type="text" id="txtDomain" class="small" tabindex="1" maxlength="100"/>
                            <span style="color: Red">*</span>
                        </td>
                        <td>
                            Code
                        </td>
                        <td>
                            <%--<asp:TextBox ID="txtCode" runat="server" class="small" TabIndex="2"></asp:TextBox>--%>
                            <input type="text" id="txtCode" class="small" tabindex="2" maxlength="100"/>
                            <span style="color: Red">*</span>
                        </td>
                        <td>
                            Name
                        </td>
                        <td>
                            <%--<asp:TextBox ID="txtName" runat="server" class="small" TabIndex="3"></asp:TextBox>--%>
                            <input type="text" id="txtName" class="small" tabindex="3" maxlength="200"/>
                            <span style="color: Red">*</span>
                        </td>
                        <td>
                            Display Text
                        </td>
                        <td>
                            <%--<asp:TextBox ID="txtDisplayText" runat="server" class="small" TabIndex="4"></asp:TextBox>--%>
                            <input id="txtDisplayText" type="text" class="small" tabindex="4" maxlength="200"/>
                            <span style="color: Red">*</span>
                        </td>
                        <td>
                            Language
                        </td>
                        <td>
                            <select id="ddlLanguageCode">
                            </select>
                            <span style="color: Red">*</span>
                        </td>
                        <td>
                            <%--<asp:Button ID="btnSave" runat="server" Text="Save" TabIndex="5" />--%>
                            <input id="btnSave" type="button" value="Save" class="btn" tabindex="5" />
                        </td>
                        <td>
                            <%--<asp:Button ID="btnClear" runat="server" Text="Clear" TabIndex="5" />--%>
                            <input type="button" value="Clear" id="btnClear" class="btn" tabindex="6" />
                        </td>
                    </tr>
                </table>
                <table id="tblMetaData" cellspacing="0" border="1" style="cursor: pointer">
                    <thead>
                        <tr class='dataheader1'>
                            <th>
                                MetaDataID
                            </th>
                            <th>
                                Domain
                            </th>
                            <th>
                                Code
                            </th>
                            <th>
                                Name
                            </th>
                            <th>
                                DisplayText
                            </th>
                            <th>
                                LangName
                            </th>
                            <th>
                                LangCode
                            </th>
                            <th>
                                Actions
                            </th>
                        </tr>
                    </thead>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div>
        <%--<asp:HiddenField ID="hdnMetaDataId" runat="server" />--%>
        <input type="hidden" id="hdnMetaDataId" />
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <%--<script type="text/javascript" src="../PlatForm/Scripts/DataTable/jquery.dataTables.js"></script>--%>
    <%-- <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>--%>

    <script src="../QMS/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>

    </form>
</body>
</html>
