<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MicroBio1.ascx.cs" Inherits="Investigation_MicroBio1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

<script src="../Scripts/bid.js" type="text/javascript"></script>

<script src="../Scripts/Common.js" type="text/javascript"></script>

<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />--%>
<style type="text/css">
    .mytable1 td, .mytable1 th
    {
        border: 1px solid #686868;
        border-bottom: 1px solid #686868;
    }
</style>

<script type="text/javascript">
    var counter = 0;
    var hdnFishResult = '<%=hdnFishResult.ClientID %>';

    function SaveMicroBio1Pattern(hdnInvID, ctrlClientID) {

        try {
            var counter1 = 0

            var lstFishResult = [];
            $('#tblProbes tbody tr').each(function(i, n) {
                var $row = $(n);

                var spattern = $row.find($('input[id$="txtSignalpattern"]')).val();
                var txtCountedCells = $row.find($('input[id$="txtCountedCells"]')).val();
                var txtResultantcells = $row.find($('input[id$="txtResultantcells"]')).val();
                var txtResults = $row.find($('input[id$="txtResults"]')).val();


                lstFishResult.push({

                    SignalPattern: spattern,
                    CountedNoofcells: txtCountedCells,
                    ResultantNoofcells: txtResultantcells,
                    Results: txtResults

                });
            });
            if (lstFishResult.length > 0) {
                document.getElementById(ctrlClientID + "_hdnFishResult").value = JSON.stringify(lstFishResult);

            }
            else {
                document.getElementById(ctrlClientID + "_hdnFishResult").value = "";
            }
        }
        catch (e) {
            return false;
        }
        return true;
    }


    function AddProbes() {

        $('#tblProbes tbody tr').each(function(i, n) {
            var $row = $(n);
        });
        var row$ = $('<tr/>');

        var txtResults = '<input id="txtResults" type="text" style="width: 170px; height: 30px;"  />';
        var tdtxtResults = $('<td/>').html(txtResults);
        var txtSignalpattern = '<input id="txtSignalpattern" type="text" style="width: 170px; height: 30px;"  />';
        var tdtxtSignalpattern = $('<td/>').html(txtSignalpattern);
        var txtCountedCells = '<input id="txtCountedCells" type="text" style="width: 170px; height: 30px;"   />';
        var tdttxtCountedCells = $('<td/>').html(txtCountedCells);
        var txtResultantcells = '<input id="txtResultantcells" type="text" style="width: 170px; height: 30px;" / >';
        var tdtxtResultantcells = $('<td/>').html(txtResultantcells);

        var inputDelete = '<input id="btnDelete"  value="Delete" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onProbeDelete(this);" />';
        var tdDelete = $('<td/>').html(inputDelete);
        row$.append(tdtxtSignalpattern).append(tdttxtCountedCells).append(tdtxtResultantcells).append(tdtxtResults).append(tdDelete);
        $('#tblProbes tbody').append(row$);
        counter++;
    }
    function checkFile(obj) {

        var fileElement = document.getElementById(obj);
        var fileExtension = "";
        if (fileElement.value.lastIndexOf(".") > 0) {
            fileExtension = fileElement.value.substring(fileElement.value.lastIndexOf(".") + 1, fileElement.value.length);
        }
        if (fileExtension == "gif" || fileExtension == "GIF" || fileExtension == "JPEG" || fileExtension == "jpeg" || fileExtension == "jpg" || fileExtension == "JPG" || fileExtension == "PNG" || fileExtension == "png") {
            return true;
        }
        else {
            alert("You must select a GIF,JPEG,JPG and PNG file for upload");
            document.getElementById(obj).value = '';
            fileElement.focus();
            return false;
        }
    }


    function onProbeDelete(obj) {

        try {
            var $row = $(obj).closest('tr');
            var HiddenProbeImageID = $row.find("input[id$='HiddenProbeImageID']").val();
            var invID = $row.find("input[id$='hdnInvestigationId']").val();
            var orgID = $row.find("input[id$='hdnOrgID']").val();
            var Patientvisitid = $row.find("input[id$='hdnPvisitid']").val();
            if (HiddenProbeImageID == '' || HiddenProbeImageID == undefined) {
                HiddenProbeImageID = '0';
            }
            if (invID == '' || invID == undefined) {
                invID = '0';
            }
            if (orgID == '' || orgID == undefined) {
                orgID = '0';
            }
            if (Patientvisitid == '' || Patientvisitid == undefined) {
                Patientvisitid = '0';
            }

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/DeleteProbeImageDeatils",
                data: "{PVisitId: " + Patientvisitid + ",Pinvid: " + invID + ",OrgID: " + orgID + ",ImageId: " + HiddenProbeImageID + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function Success(data) {
                    $(obj).closest('tr').remove();
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Unable to delete");
                }
            });
        }
        catch (e) {
            return false;
        }
        return false;
    }

</script>

<table class="w-100p defaultfontcolor">
    <tr>
        <td class="bold font11 h-20" id="tdInvName" runat="server" style="color: #000; display: table-cell;">
            <asp:Label ID="lblName" runat="server" Text="Name"></asp:Label>
            &nbsp;
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <table>
                <tr>
                    <td class="font10 h-30 w-19p" style="font-weight: normal; color: #000; display: table-cell;">
                        <input id="Button1" value="Add" type="button" class="btn" onclick="return AddProbes()" />
                    </td>
                </tr>
            </table>
        </td>
        <td class="font10 h-30 w-19p a-center" style="font-weight: normal; color: #000; display: table-cell;">
            Comments
        </td>
        <td class="font10 h-30 w-25p a-center" style="font-weight: normal; color: #000; display: table-cell;">
            Status
        </td>
    </tr>
    <tr>
        <td>
            <div class="mytable1" style="overflow: auto; height: 200px">
                <table id="tblProbes" class='dataheaderInvCtrl w-100p'>
                    <thead>
                        <tr class="colorforcontent h-20">
                            <th class="font11 bold h-8" style="color: White;">
                                <asp:Label ID="Site" Text="Site" runat="server" />
                            </th>
                            <th class="font11 bold h-8" style="color: White;">
                                <asp:Label ID="Aerobic" Text="Aerobic Culture" runat="server" />
                            </th>
                            <th class="font11 bold h-8" style="color: White;">
                                <asp:Label ID="Anaerobic" Text="Anaerobic Culture" runat="server" />
                            </th>
                            <th class="font11 bold h-8" style="color: White;">
                                <asp:Label ID="Fungal" Text="Fungal Culture" runat="server" />
                            </th>
                            <th class="font11 bold h-8" style="color: White;">
                                <asp:Label ID="lblAction" Text="Action" runat="server" />
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptProbes" runat="server" OnItemDataBound="rptProbes_ItemDataBound">
                            <ItemTemplate>
                                <tr class="h-20">
                                    <td class="a-left w-3p">
                                        <input type="text" id="txtSignalpattern" runat="server" value='<%# Bind("SignalPattern") %>'
                                            class="h-30" style="width: 170px;" />
                                    </td>
                                    <td class="a-left w-3p">
                                        <input type="text" id="txtCountedCells" runat="server" class="h-30" style="width: 170px;"
                                            value='<%# Bind("CountedNoofcells") %>' />
                                    </td>
                                    <td class="a-left w-3p">
                                        <input type="text" id="txtResultantcells" runat="server" class="h-30" style="width: 170px;"
                                            value='<%# Bind("ResultantNoofcells") %>' />
                                    </td>
                                    <td class="a-left w-6p">
                                        <input type="text" id="txtResults" runat="server" cssclass="Txtboxsmall" class="h-30"
                                            style="width: 170px;" value='<%# Bind("Results") %>' />
                                        <asp:HiddenField ID="hdnInvestigationId" runat="server" Value='<%# Eval("InvestigationID") %>' />
                                        <asp:HiddenField ID="hdnOrgID" runat="server" Value='<%# Eval("OrgID") %>' />
                                        <asp:HiddenField runat="server" ID="hdnPvisitid" Value='<%# Eval("PVisitId") %>' />
                                        <asp:HiddenField ID="hdnResult" runat="server" Value='<%# Eval("ResultType") %>' />
                                    </td>
                                    <td class="a-center w-2p">
                                        <input id="btnDelete" runat="server" value="Delete" type="button" class="font11"
                                            style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline;
                                            cursor: pointer;" onclick="onProbeDelete(this);" />
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </td>
        <td class="v-top a-center">
            <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtMedRemarks"
                TabIndex="1" TextMode="MultiLine" CssClass="small"></asp:TextBox>
            <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                TargetControlID="txtMedRemarks" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="GetInvMedicalRemarks">
            </ajc:AutoCompleteExtender>
            <asp:HiddenField ID="hdnMedicalRemarksID" runat="server" />
        </td>
        <td class="v-top a-center">
            <table>
                <tr>
                    <td class="w-42p a-right v-middle">
                        <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" CssClass="ddlsmall">
                            <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource1"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="w-14p">
                        <table id="tdInvStatusReason2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1"
                                        onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);"
                                        meta:resourcekey="ddlStatusReasonResource1" CssClass="ddlsmall">
                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <span class="richcombobox w-100">
                                        <asp:DropDownList ForeColor="Black" ID="ddlOpinionUser" runat="server" TabIndex="-1"
                                            CssClass="ddlsmall" meta:resourcekey="ddlOpinionUserResource1">
                                            <asp:ListItem Text="--Select--" meta:resourcekey="OpinionUserListItemResource1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <asp:HiddenField runat="server" ID="hidVal" />
            <asp:HiddenField runat="server" ID="hdnFishResult" Value="" />
            <asp:HiddenField runat="server" ID="hdnpatientvisitid" Value="0" />
            <asp:HiddenField runat="server" ID="hdninvid" Value="0" />
            <input id="hdnProbes" runat="server" type="hidden" />
            <input id="hdnResultType" runat="server" type="hidden" />
        </td>
    </tr>
</table>
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />