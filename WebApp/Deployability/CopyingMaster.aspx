<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CopyingMaster.aspx.cs" Inherits="CopyingMaster_Home" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <script src="../Scripts/jquery-1.11.3.min.js" type="text/javascript"></script>
    <style>
       .TabsMenu span,span,input,label,option,select{font-size:14px !important;}
       #processMessage{z-index:9999999998 !important;}
       #progressBackgroundFilter{z-index:9999999999 !important;}
        .marginL370{margin-left:370px  !important;}
        .marginL570{margin-left:570px  !important;}
        .marginL30{margin-left:30px;}
        .marginL50{margin-left:50px;}
        .marginRR20{margin-right:20px;}
        .w-222{width:222px;}
        .h-82{height:82px;}
        .contentdata
        {
            background: #c0c0c0;
        }
        .marginT200
        {
            margin-top: 200px;
        }
        input[type="text"]
        {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .ui-autocomplete
        {
            width: auto !important;
            min-width: 150px;
            max-width: 300px;
            word-break: break-all;
            word-wrap: break-word;
        }
        .o-auto
        {
            overflow: auto;
        }
        .checkboxlist
        {
            overflow: auto;
            border: 2px;
            background: #fff;
            height: 150px;
            width: 220px;
        }
        .checkboxlist2
        {
            overflow: auto;
            border: 2px;
            background: #fff;
            height: 82px;
            width: 220px;
        }
        .copylist
        {
            border: 2px;
            border-color: #fff;
            height: 390px;
            width: 420px;
        }
        #ddldptname
        {
            width: 222px;
        }
        .finalcopylist
        {
            overflow: auto;
            border: 2px;
            border-color: #fff;
            height: 83px;
            width: 225px;
        }
        .w-300
        {
            width: 300px;
        }
        .w-420
        {
            width: 420px;
        }
        .h-400
        {
            height: 360px !important;
        }
        .h-300
        {
            height: 300px;
        }
        .w-350
        {
            width: 350px;
        }
        .h-450
        {
            height: 450px !important;
        }
    </style>

    <script type="text/javascript">
        var lstTPADetails = {};
        $(document).ready(function() {
            function BindData(FeeType, Status) {
                var Parameter = {};
                Parameter.BaseOrgId = $('#ddlOrgName').val();
                Parameter.FeeType = FeeType;
                $.ajax({
                    type: "POST",
                    url: "CopyingMaster.aspx/GetDataFromDB",
                    data: JSON.stringify(Parameter),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function Success(data) {
                        if (data.d.length > 0) {
                            lstTPADetails = data.d;
                            BindSelectedData(Status);
                        }
                        else {
                            alert("No matching records found");
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert(errorThrown);
                    }
                });
            }
            function BindSelectedData(Status) {
                var vdata = {};
                vdata.InputList = JSON.parse(lstTPADetails);
                vdata.Status = Status;
                $.ajax({
                    type: "POST",
                    url: "CopyingMaster.aspx/GetInactive",
                    data: JSON.stringify(vdata),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function Success(data) {
                        if (data.d.length > 0) {

                            $('#lstLeft').empty("");
                            var returnedData = JSON.parse(data.d);
                            $.each(returnedData, function(index, returnedData) {
                                $('#lstLeft').append('<option value="' + returnedData.InvestigationID + '">' + returnedData.InvestigationName + "(" + returnedData.InvestigationID + ")" + '</option>');
                            });
                        }
                        else {
                            alert("No matching records found");
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                    }
                });
            }
            //Shows inactive
            $('#chkinActive').change(function() {
                if ($(this).is(":checked")) {
                    BindSelectedData('False');
                }
                else {
                    var Status;
                    if ($('#Chkpackage').is(":checked")) {
                        Status = 'A';
                    }
                    else {
                        Status = 'Y';
                    }
                    BindSelectedData(Status);

                }
            });

            //select all the Contents
            $('#ChkSelectAll').click(function() {
                if ($(this).is(":checked")) {
                    $("#lstLeft option").prop("selected", true);
                }
                else {
                    $("#lstLeft option").prop("selected", false);
                }
            });

            //Copying datas from one listbox to another
            $('#btnRight').click(function(e) {
                var selectedOpts = $('#lstLeft option:selected');
                if (selectedOpts.length == 0) {
                    alert("Nothing to move.");
                    e.preventDefault();
                }
                $(selectedOpts).each(function() {
                    if ($("#lstRight option[value='" + this.value + "']").length > 0) {
                        alert("The item " + this.text + " already added")
                    } else {
                        $('#lstRight').append('<option value="' + this.value + '">' + this.text + '</option>');
                        if ($('#Chktest').is(":checked")) {

                            $('#lstTest').append('<option value="' + this.value + '">' + this.text + '</option>');
                        }
                        if ($('#Chkgroup').is(":checked")) {
                            $('#lstGroup').append('<option value="' + this.value + '">' + this.text + '</option>');
                        }
                        if ($('#Chkpackage').is(":checked")) {

                            $('#lstPackage').append('<option value="' + this.value + '">' + this.text + '</option>');
                        }
                    }
                });
                BindSelectedData('False');
                e.preventDefault();
            });

            $('#btnLeft').click(function(e) {
                var selectedOpts = $('#lstRight option:selected');
                if (selectedOpts.length == 0) {
                    alert("Nothing to move.");
                    e.preventDefault();
                }
                $(selectedOpts).remove();

                $(selectedOpts).each(function() {
                    if ($('#Chktest').is(":checked")) {
                        $("#lstTest option[value='" + this.value + "']").remove();
                    }
                    if ($('#Chkgroup').is(":checked")) {
                        $("#lstGroup option[value='" + this.value + "']").remove();
                    }
                    if ($('#Chkpackage').is(":checked")) {
                        $("#lstPackage option[value='" + this.value + "']").remove();
                    }
                });

                e.preventDefault();
            });



            $("#txtName").keyup(function() {
                GetAutoCompleteList();
            });
            function GetAutoCompleteList() {
                var Status;
                if ($('#Chkpackage').is(":checked")) {
                    Status = 'A';
                }
                else {
                    Status = 'Y';
                }
                var vdatas = {};
                vdatas.InputList = JSON.parse(lstTPADetails);
                vdatas.Status = Status;
                vdatas.txtName = $('#txtName').val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "CopyingMaster.aspx/GetAutoComplete",
                    data: JSON.stringify(vdatas),
                    dataType: "json",
                    success: function(data) {
                        var returnedData = JSON.parse(data.d);
                        $('#lstLeft').empty("");
                        $.map(returnedData, function(item) {

                        $('#lstLeft').append('<option value="' + item.InvestigationID + '">' + item.InvestigationName + "(" + item.InvestigationID + ")" + '</option>');

                            //                                return {
                            //                                    label: item.InvestigationName,
                            //                                    val: item.InvestigationID

                            //                                }

                        })
                    },
                    error: function(result) {
                        alert("No Match");
                    }
                });
            }

            //Delete button Click
            $(document).on('click', '.btndelete', function() {
                var selectlabel = $(this).parent("label").text();
                if (selectlabel == 'Test') {
                    $('#lstTest').empty("");
                    $('#lbltest').hide();
                }
                else if (selectlabel == 'Group') {
                    $('#lstGroup').empty("");
                    $('#lblgroup').hide();
                }
                else {
                    $('#lstPackage').empty("");
                    $('#lblpackage').hide();
                }
                if (($("#lstTest option").length <= 0) && ($("#lstGroup option").length <= 0) && ($("#lstPackage option").length <= 0)) {
                    ShowTabContent('tabOrgsettings', 'tabContentOrgsettings');
                    Cleartab();
                    return false;
                }
            });
            //Final Copy button Click
            $('#btnCopy').click(function(e) {
                $("#Chktest").prop("disabled", true);
                $("#Chkgroup").prop("disabled", true);
                $("#Chkpackage").prop("disabled", true);
                $("#divCheckBoxList").empty();
                if (($("#lstTest option").length > 0) || ($("#lstGroup option").length > 0) || ($("#lstPackage option").length > 0)) {
                    $('#conginitalscreen').hide();
                    $('#congfinalscreen').show();
                    if ($("#lstTest option").length > 0) {
                        $('#Chktest').prop('checked', true);
                        var checkBox = "<label class='lh25' id='lbltest'>Test<img title='Click to Delete' alt='Click to Delete' class='btndelete pointer pull-right marginR10' src='../Images/delete11.png' /></label><br/>";
                        $(checkBox).appendTo('#divCheckBoxList');
                    }
                    if ($("#lstGroup option").length > 0) {
                        $('#Chkgroup').prop('checked', true);
                        var checkBox = "<label class='lh25' id='lblgroup'>Group<img title='Click to Delete' alt='Click to Delete' class='btndelete pointer pull-right marginR10' src='../Images/delete11.png' /></label><br/>";
                        $(checkBox).appendTo('#divCheckBoxList');
                    }
                    if ($("#lstPackage option").length > 0) {
                        $('#Chkpackage').prop('checked', true);
                        var checkBox = "<label class='lh25' id='lblpackage'>Package<img title='Click to Delete' alt='Click to Delete' class='btndelete pointer pull-right marginR10' src='../Images/delete11.png' /></label><br/>";
                        $(checkBox).appendTo('#divCheckBoxList');
                    }
                    ShowTabContent('tabConfig', 'tabContentConfig');
                    $('#btnsav').show();
                    $('#btnCopy').hide();
                    $('#btnClear').show();
                    return false;
                }
                else {
                    alert("No records");
                    $('#btnsav').hide();
                    $('#btnCopy').show();
                    $('#btnClear').show();
                    return false;
                }
            });

            //Final Config save button Click
            $('#btnsav').click(function(e) {
                if (($("#lstTest option").length > 0) || ($("#lstGroup option").length > 0) || ($("#lstPackage option").length > 0)) {
                    var obj = [];
                    $('#lstTest option').each(function() {
                        var tmptest = {
                            'ID': $(this).val(),
                            'Name': $(this).text(),
                            'Type': 'INV'
                        };
                        obj.push(tmptest)
                    });
                    $('#lstGroup option').each(function() {
                        var tmpgroup = {
                            'ID': $(this).val(),
                            'Name': $(this).text(),
                            'Type': 'GRP'
                        };
                        obj.push(tmpgroup)
                    });

                    $('#lstPackage option').each(function() {
                        var tmppackage = {
                            'Id': $(this).val(),
                            'Name': $(this).text(),
                            'Type': 'PKG'
                        };
                        obj.push(tmppackage)
                    });
                    var jsonString = JSON.stringify(obj);
                    //alert(jsonString);
                    // return false;
                    SaveFeettpes(jsonString)
                    $('#lstTest').empty("");
                    $('#lstGroup').empty("");
                    $('#lstPackage').empty("");
                    return false;
                }
                else {
                    alert('No Copying items');
                    Cleartab();
                    ShowTabContent('tabOrgsettings', 'tabContentOrgsettings');
                    return false;
                }
            });
            ///Chktest Click
            $('#Chktest').change(function() {
                $('#conginitalscreen').show();
                $('#btnCopy').show();
                $('#lstRight').empty("");
                $('#txtName').val("")
                $("#ChkSelectAll").prop("checked", false);
                $("#chkinActive").prop("checked", false);
                if ($(this).is(":checked")) {
                    BindData('INV', 'Y');
                }
                else {
                    $('#lstLeft').empty("");
                }
            });

            ///ChkGroup Click
            $('#Chkgroup').change(function() {
                $('#conginitalscreen').show();
                $('#btnCopy').show();
                $('#lstRight').val("");
                $('#lstRight').text("");
                $('#txtName').val("")
                $("#ChkSelectAll").prop("checked", false);
                $("#chkinActive").prop("checked", false);
                if ($(this).is(":checked")) {
                    BindData('GRP', 'Y');
                }
                else {
                    $('#lstLeft').text("");
                    $('#lstLeft').val("");
                }
            });

            ///ChkPackage Click
            $('#Chkpackage').change(function() {
                $('#conginitalscreen').show();
                $('#btnCopy').show();
                $('#lstRight').empty("");
                $('#txtName').val("")
                $("#ChkSelectAll").prop("checked", false);
                $("#chkinActive").prop("checked", false);
                if ($(this).is(":checked")) {
                    BindData('PKG', 'A');
                }
                else {
                    $('#lstLeft').empty("");
                }
            });

            //btn First tab Cancel
            $('#btnCancel').click(function(e) {
                // ShowTabContent('tabOrgsettings', 'tabContentOrgsettings');
                Cleartab();
                return false; ;
            });

            //btn first tab save btnsav
            $('#btnFirstSave').click(function() {
                $("#Chktest").prop("disabled", false);
                $("#Chkgroup").prop("disabled", false);
                $("#Chkpackage").prop("disabled", false);
                $("#Chktest").prop("checked", false);
                $("#Chkgroup").prop("checked", false);
                $("#Chkpackage").prop("checked", false);
                var TrustedOrgId = "";
                $('#lsttruestedOrg').find('option').map(function() {
                    TrustedOrgId += $(this).val() + "";
                });

                var BaseOrgId = $("#ddlOrgName :selected").val();
                var selectedItems = $("[id*=CheckBoxList9] input:checked");
                if (BaseOrgId != 0 && TrustedOrgId != '' && selectedItems.length > 0) {
                    ShowTabContent('tabConfig', 'tabContentConfig');
                    $('#conginitalscreen').hide();
                    $('#congfinalscreen').hide();
                    $('#btnsav').hide();
                    $('#btnCopy').hide();
                    $('#btnClear').show();
                }
                else {
                    if (BaseOrgId == 0) {
                        alert('select the base org')
                        return false;
                    }
                    if (selectedItems.length == 0) {
                        alert('select the Org settings ')
                        return false;
                    }
                    if (TrustedOrgId == '') {
                        alert('select the trusted org ')
                        return false;
                    }
                }
                return false; ;
            });

            //btn final tab save
            $('#btnClear').click(function(e) {
                $('#lstTest').empty("");
                $('#lstGroup').empty("");
                $('#lstPackage').empty("");
                $('#lblpackage').text("");
                $('#lstLeft').empty("");
                $('#lstRight').empty("");
                ShowTabContent('tabOrgsettings', 'tabContentOrgsettings');
                Cleartab();
                return false;
            });
            $('.checkboxgroup').click(function(e) {
                var val = $(this).val();
                $('input[value!=' + val + '].checkboxgroup').attr('checked', false);
            });
            function SaveFeettpes(Savedata) {

                $("#copyingProgress").show();
                var TrustedOrgId = "";
                $('#lsttruestedOrg').find('option').map(function() {
                    TrustedOrgId += $(this).val() + ",";
                });
                var BaseOrgId = $("#ddlOrgName :selected").val();
                BaseOrgId = $('#ddlOrgName').val();
                // TrustedOrgId = '110,111';
                // return false;
                var reset = 'Y';
                var selectedItems = $("[id*=CheckBoxList9] input:checked");

                if (BaseOrgId != 0 && TrustedOrgId != '' && selectedItems.length > 0) {
                    $.ajax({
                        type: "POST",
                        url: "CopyingMaster.aspx/SaveFeeTypeDetails",
                        data: "{baseorgid: " + parseInt(BaseOrgId) + ",destorgid:'" + TrustedOrgId + "',reset:'" + reset + "',lstInvestigationDetail:'" + Savedata + "'}",
                        contentType: "application/json; charset=utf-8",
                        datatype: "JSON",
                        success: function(data) {
                            var GetData = data.d;
                            alert("The record has been successfully saved");
                            $("#copyingProgress").hide();
                            ShowTabContent('tabOrgsettings', 'tabContentOrgsettings');
                            Cleartab();
                            return false;
                        },
                        failure: function(msg) {
                            ShowErrorMessage(msg);
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert("Error");
                            return false;
                        }
                    });
                }
                else {
                    if (BaseOrgId == 0) {
                        alert('select the base org')
                        ShowTabContent('tabOrgsettings', 'tabContentOrgsettings');
                        return false;
                    }
                    if (TrustedOrgId == '') {
                        alert('select the trusted org ')
                        ShowTabContent('tabOrgsettings', 'tabContentOrgsettings');
                        return false;
                    }
                    if (selectedItems.length == 0) {
                        alert('select the Org settings ')
                        ShowTabContent('tabOrgsettings', 'tabContentOrgsettings');
                        return false;
                    }
                }
            }
            // CheckboxList on change Event
            $('#ChTruestedOrg').on('click', ':checkbox', function() {
                $('.finalcopylist').css('display', 'inline-block');
                // var value = $(this).parent("span").attr('Orgid')
                var value = 'A' + $(this).attr('id')
                var text = $(this).closest("td").find("label").html();
                var CurrentCheckboxId = $(this).attr("id").split('_')[1];
                if ($(this).is(':checked')) {
                    if ($("#lsttruestedOrg option[value='" + value + "']").length > 0) {
                        alert("The item " + text + " already added")
                    }
                    else {
                        $('#lsttruestedOrg').append(' <option value="' + value.replace('A','') + '">' + text + '</option> ');

                        //                        var checkBox = "<label class='lh25' id='" + value + "'>" + text + "<img title='Click to Delete' alt='Click to Delete' class='btndeleteorg pull-right' src='../Images/delete11.png' /></label><br/>";
                        //                        $(checkBox).appendTo('#divtrustedOrg');

                        var checkBox = "<div id='" + value + "'><label class='lh25'>" + text + "</label><img title='Click to Delete' alt='Click to Delete' class='btndeleteorg pointer pull-right marginRR20' src='../Images/delete11.png' /><input type='hidden' id='hdn" + value + "' value='" + CurrentCheckboxId + "' /></div>";
                        $(checkBox).appendTo('#divtrustedOrg');

                    }
                }
                else {
                    $('#' + value + '').remove();
                    $("#lsttruestedOrg option[value='" + value.replace('A','') + "']").remove();
                }
            });

            //Delete org  button Click in first tab
            $(document).on('click', '.btndeleteorg', function() {
                var selectlabel = $(this).parent("label").text();
                var RemoveItems = $(this).parent().attr('id')
                $('input:checkbox[id=' + RemoveItems.replace('A','') + ']').attr('checked',false);
               // var hdnChkId = $('#hdn' + RemoveItems + '');
              //  $("[id*=ChTruestedOrg] input").eq(hdnChkId.val()).removeAttr('checked');
              //$('#' + RemoveItems + '').prop('checked', false);
                $('#' + RemoveItems + '').remove();
                $("#lsttruestedOrg option[value='" + RemoveItems.replace('A','') + "']").remove();
            });
            function Cleartab() {
                $("[id*=CheckBoxList9] input").removeAttr("checked");
               // $("[id*=ChTruestedOrg] input").removeAttr("checked");
               $("#ChTruestedOrg").empty();
                $("#divtrustedOrg").empty();
                $('#lsttruestedOrg').empty("");
                $('#ddlOrgName').val('Select');
                $('.finalcopylist').css('display', 'none');
            }

  $('#ddlOrgName').change(function() {
   $("#divtrustedOrg").empty();
  PopulateCheckBoxList($('#ddlOrgName').val());
  });
             function PopulateCheckBoxList(baseOrgId) {
            $.ajax({
                type: "POST",
                url: "CopyingMaster.aspx/GetTrustedOrg",
                contentType: "application/json; charset=utf-8",
                data: "{baseorgid: " + parseInt(baseOrgId) + "}",
                dataType: "json",
                success: AjaxSucceeded,
                error: AjaxFailed
            });
        }
        function AjaxSucceeded(result) {
            BindCheckBoxList(result);
        }
        function AjaxFailed(result) {
            alert('Failed to load checkbox list');
        }
        function BindCheckBoxList(result) {

            var items = JSON.parse(result.d);
            CreateCheckBoxList(items);
        }
        function CreateCheckBoxList(checkboxlistItems) {
             $("#ChTruestedOrg").empty();
            var table = $('<table></table>');
            var counter = 0;
            $(checkboxlistItems).each(function () {
                table.append($('<tr></tr>').append($('<td></td>').append($('<input>').attr({
                    type: 'checkbox', name: 'chklistitem', value: this.Value, id: this.OrgID 
                })).append(
                $('<label>').attr({
                    id: 'chklistitem' + counter++
                }).text(this.Name))));
                });
                $('#ChTruestedOrg').append(table);
            }
        });

    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div>
        <Attune:Attuneheader ID="Attune_OrgHeader1" runat="server" />
        <div class="contentdata">
        <div id="copyingProgress" style="display:none;">
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" />
                                        </div>

        </div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div id="TabsMenu" class="TabsMenu ">
                        <ul id="ulTabsMenu">
                            <li id="tabOrgsettings" class="active"><a href="#">
                                <asp:Label ID="lbltabOrgsettings" runat="server" Text="Org Settings" /></a></li>
                            <li id="tabConfig"><a href="#">
                                <asp:Label ID="lbltabConfig" runat="server" Text="Configuration" /></a></li>
                        </ul>
                    </div>
                    <br />
                    <asp:UpdatePanel ID="updatePanel2" runat="server">
                        <ContentTemplate>
                            <table class="w-100p " id="tabContentOrgsettings">
                                <tr class="lh25">
                                    <td class="a-left w-17p ">
                                        <asp:Label runat="server" class="w-100p" ID="lblDoctor" Text="Select Base Org"></asp:Label>
                                    </td>
                                    <td class="a-left w-25p paddingB10 " runat="server" id="tddocname">
                                        <asp:DropDownList ID="ddlOrgName" runat="server" CssClass="w-222">
                                        </asp:DropDownList>
                                    </td>
                                     <td >
                                        <asp:Button ID="Button1" runat="server" CssClass="btn" Text="Create Trusted Org"
                                            OnClick="Button1_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-left v-top">
                                        <asp:Label runat="server" class="w-100p" ID="Label1" Text="Org Settings"></asp:Label>
                                    </td>
                                    <td class="a-left v-top paddingB10 h-82">
                                        <div class="checkboxlist2 borderGrey">
                                            <asp:CheckBoxList ID="CheckBoxList9" CssClass="w-100p" runat="server" meta:resourcekey="chklstGrpResource1">
                                                <asp:ListItem Value="0">Masters</asp:ListItem>
                                            </asp:CheckBoxList>
                                        </div>
                                    </td>
                                    <td class="a-left v-top" rowspan="2">
                                        <asp:ListBox ID="lsttruestedOrg" CssClass="w-100p h-100" Style="display: none;" runat="server">
                                        </asp:ListBox>
                                        <div class="finalcopylist borderGrey  w-50p bg-white h-300 hide">
                                            <div id="divtrustedOrg" class="inline-block w-100p ">
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-left v-top">
                                        <asp:Label runat="server" ID="Label6" Text="Select Trusted Org"></asp:Label>
                                    </td>
                                    <td class="v-top">
                                        <div class="checkboxlist borderGrey">
                                            <div id="ChTruestedOrg" cssclass="w-100p">
                                            </div>
                                        </div>
                                    </td>
                                   
                                </tr>
                                <tr>
                                    <td class="a-center paddingT10" colspan="3">
                                        <asp:Button ID="btnFirstSave" runat="server" CssClass="btn marginR10 " Text="Save" />
                                        <asp:Button ID="btnCancel" runat="server" CssClass="cancel-btn marginL50 " Text="Clear" />
                                    </td>
                                </tr>
                            </table>
                            <table class="w-100p hide paddingL1" id="tabContentConfig">
                                <tr>
                                    <td class="a-left v-top">
                                        <asp:Label runat="server" ID="Label2" Text="Masters"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="v-top" colspan="2">
                                        <div class="checkboxlist2 borderGrey inline-block v-top pull-left marginR5">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">  <input type="checkbox" id="Chktest" name="Chktest"  class="checkboxgroup" value="1">Test</asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">  <input type="checkbox" id="Chkgroup" name="Chkgroup"  class="checkboxgroup" value="2"> Group </asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server"> <input type="checkbox" id="Chkpackage" name="Chkpackage"   class="checkboxgroup" value="3"> Package</asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="conginitalscreen" runat="server" class="w-78p paddingL5 inline-block pull-left">
                                            <div class="copylist  pull-left">
                                                <div class="w-100p lh20 bold">
                                                    <asp:CheckBox ID="ChkSelectAll" runat="server" Text="Select All" />
                                                    <asp:CheckBox ID="chkinActive" runat="server" Text="Show Inactive" />
                                                </div>
                                                <div class="w-100p lh30">
                                                    <asp:TextBox ID="txtName" ToolTip="Search" Placeholder="Search" runat="server" CssClass="w-300 bg-white autotext bg-searchimage marginT6" />
                                                </div>
                                                <asp:ListBox ID="lstLeft" runat="server" SelectionMode="multiple" CssClass="w-420 h-400 marginT5 o-auto">
                                                </asp:ListBox>
                                            </div>
                                            <div class="pull-left w-10p marginT200">
                                                <div class="w-100p a-center">
                                                    <input type="button" class="w-50 btn" id='btnRight' value=">>" />
                                                </div>
                                                <div class="w-100p a-center marginT10">
                                                    <input type="button" class="w-50 btn" id='btnLeft' value="<<" />
                                                </div>
                                            </div>
                                            <div class="copylist marginT30 pull-left">
                                                <div class="w-100p bold paddingT3 paddingB3">
                                                    <asp:Label runat="server" ID="Label5" Text="SelectedData"></asp:Label>
                                                </div>
                                                <asp:ListBox ID="lstRight" runat="server" SelectionMode="multiple" CssClass="w-420 h-400 o-auto">
                                                </asp:ListBox>
                                            </div>
                                        </div>
                                        <div id="congfinalscreen" runat="server" class="w-30p hide pull-left marginL50">
                                            <div class="finalcopylist borderGrey bg-white marginL5 inline-block w-60p">
                                                <div id="divCheckBoxList" class="inline-block  w-100p">
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-left paddingT10 " colspan="2">
                                        <asp:Button ID="btnClear" runat="server" CssClass="cancel-btn marginL30 " Text="Clear" />
                                        <asp:Button ID="btnCopy" runat="server" CssClass="btn marginL570 pull-left " Text="Copy" />
                                        <asp:Button ID="btnsav" runat="server" CssClass="btn marginL10 hide marginL370 pull-left" Text="Save" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <Attune:Attunefooter ID="Attune_Footer1" runat="server" />
        <asp:ListBox ID="lstTest" runat="server"  CssClass="hide"></asp:ListBox>
        <asp:ListBox ID="lstGroup" runat="server"  CssClass="hide"></asp:ListBox>
        <asp:ListBox ID="lstPackage" runat="server"  CssClass="hide"></asp:ListBox>
        <asp:HiddenField ID="hdnList" runat="server" />
    </div>
    </form>
</body>

<script type="text/javascript">
    $(function() {
        $('[id^="tabContent"]').hide();
        $('#tabOrgsettings').addClass('active');
        $('#tabContentOrgsettings').show();
    });
    function ShowTabContent(tabId, DivId) {
        $('#TabsMenu li').removeClass('active');
        $('#' + tabId).addClass('active');
        $('[id^="tabContent"]').hide();
        $('#' + DivId).show();
        return false;
    }
</script>

</html>
