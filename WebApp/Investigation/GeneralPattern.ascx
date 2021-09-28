<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GeneralPattern.ascx.cs" Inherits="Investigation_GeneralPattern" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<%--<script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js">--%>

<style type="text/css">
    .mytable1 td, .mytable1 th
    {
        border: 1px solid #686868;
        border-bottom: 1px solid #686868;
    }
</style>

<script type="text/javascript">
    var counter = 0;
    var hdnGeneral = '<%=hdnGeneral.ClientID %>';
    function SaveGeneralPattern(hdnInvID, ctrlClientID) {
        try {
            var lstHPVPattern = [];
            var lstImageResult = [];
            var lstPattern = [];
            var results = "";
            var ControlType = JSON.parse(document.getElementById(ctrlClientID + '_hdnControlType').value);
            var tbl = document.getElementById(ctrlClientID + "_tbl");
            var tbody = $(tbl).find('tbody');
            $(tbody).find('tr').each(function(i, n) {
                var $row = $(n);
                var count = 0;
                var lstTD = $row.find('td');
                results = "";
                lstPattern = [];
                $.each(lstTD, function(j, obj) {
                    count++;
                    var Type = $(this).find($('input[id$="hdn' + count + '"]')).val();
                    if (Type != undefined) {
                        if (Type == "dropdown") {
                            results = $(this).find($('select[id$="ctl' + count + '"] option:selected')).text();
                        }
                        else if (Type == "textbox") {
                            results = $(this).find($('input[id$="ctl' + count + '"]')).val();
                        }
                        else if (Type == "image") {
                            var imageID = $row.find($("input:file")).attr('id');
                            var parentid = 0;
                            var parentimgid = $(this).find($('input[id$="hdnImg' + count + '"]')).val();
                            var filePath = $(this).find($('input[id^="hdnFilePath"]')).val();
                            if (filePath != undefined) {
                                row = filePath;
                                results = filePath;
                            }
                            else {
                            }
                            if (parentimgid != undefined)
                                parentid = parentimgid;
                            lstImageResult.push({
                                ParentID: parentid,
                                Name: imageID,
                                Value: row
                            });
                        }
                        lstPattern.push(results);
                    }
                });
                lstHPVPattern.push(lstPattern);
            });
            if (lstHPVPattern.length > 0) {
                document.getElementById(ctrlClientID + "_hdnImageList").value = JSON.stringify(lstImageResult);
                document.getElementById(ctrlClientID + "_hdnGeneral").value = JSON.stringify(lstHPVPattern);
            }
            else {
                document.getElementById(ctrlClientID + "_hdnGeneral").value = "";
            }
        }
        catch (e) {
            return false;
        }
        return true;
    }

    function DynamicTable(invid, orgid, visitid, ctrlID) {
        try {
            var lstArrray = [];
            var lstImage = [];
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetGeneralPattern",
                data: "{ Pinvid: " + invid + ",OrgID: " + orgid + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function Success(data) {
                    var tbl = document.getElementById(ctrlID + "_tbl");
                    var thead$ = $('<thead/>');
                    var row$ = $('<tr  style="height: 17px;" class="dataheader1"/>');
                    for (var i = 0; i < data.d.length; i++) {
                        row$.append("<td>" + data.d[i].HeaderName + "</td>");
                        var controltype = data.d[i].ControlType;
                        var headername = data.d[i].HeaderName;
                        var id = data.d[i].ID;
                        var investigationID = data.d[i].InvestigationID;
                        var Height = data.d[i].Height;
                        var Width = data.d[i].Width;
                        lstArrray.push({
                            HeaderName: headername,
                            ControlType: controltype,
                            ID: id,
                            InvestigationID: investigationID
                        });
                        lstImage.push({
                            ParentID: controltype,
                            Name: Height,
                            Value: Width
                        });
                    }
                    thead$.append(row$);
                    $(tbl).append(thead$);
                    document.getElementById(ctrlID + '_hdnControlType').value = JSON.stringify(lstArrray);
                    document.getElementById(ctrlID + '_hdnimghtwidth').value = JSON.stringify(lstImage);
                    BindTable(invid, orgid, visitid, ctrlID);
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error");
                }
            });
        }
        catch (e) {
            return false;
        }
        return true;
    }
    function AddGeneralPattern(tbl, ctrlID, GroupName, ddlStatus) {
        var ControlCount = 0;
        var tbl = document.getElementById(ctrlID + "_tbl");
        var name = document.getElementById(ctrlID + "_hdnconfig").value;
        var tbody$ = $('<tbody/>');
        var count = 0;
        var ddlVal = "";
        var ctrlVal = "";
        var bindCtrlVal = "";
        var headername = "";
        var rowCount = tbody$.find('tr').length;
        rowCount = rowCount + 1;
        var ControlType = JSON.parse(document.getElementById(ctrlID + '_hdnControlType').value);
        var row$ = $('<tr/>');
        setCompletedStatus(GroupName, ddlStatus);
        $.each(ControlType, function(i, obj) {
            ControlCount++;
            var Type = obj.ControlType;
            headername = obj.HeaderName;
            count++;
            if (Type == "dropdown") {
                var lstGenPtn = JSON.parse(document.getElementById(ctrlID + '_hdnGeneralPattern').value);
                $.each(lstGenPtn, function(i, obj) {
                    if (obj.Name == headername) {
                        ddlVal += "<option value='" + obj.Value + "'>" + obj.Value + "</option>";
                    }
                });
                ctrlVal = '<span class="richcombobox" style="width: 120px;"><select id="ctl' + count + '" class="ddl" style="width: 100px;" title="' + obj.HeaderName + '">' + ddlVal + '</select></span><input id="hdn' + count + '" type="hidden" value="' + Type + '"/>';
                bindCtrlVal = $('<td/>').html(ctrlVal);
                row$.append(bindCtrlVal);
                Type = "";
                ddlVal = "";
                ctrlVal = "";
                bindCtrlVal = "";
            }
            else if (Type == "textbox") {
            if (ControlCount == 1) {
                    if (name == "Y") {

                        ctrlVal = '<input id="ctl' + count + '" type="text" value="' + GroupName + '" style="width: 170px; height: 40px;"  /><input id="hdn' + count + '" type="hidden" value="' + Type + '"/>';
                    }
                    else {
                        ctrlVal = '<input id="ctl' + count + '" type="text" value="" style="width: 170px; height: 40px;"  /><input id="hdn' + count + '" type="hidden" value="' + Type + '"/>';
                    }
                }
                else {
                    ctrlVal = '<input id="ctl' + count + '" type="text" value="" style="width: 170px; height: 40px;"  /><input id="hdn' + count + '" type="hidden" value="' + Type + '"/>';
                }
                bindCtrlVal = $('<td/>').html(ctrlVal);
                row$.append(bindCtrlVal);
                Type = "";
                ctrlVal = "";
                bindCtrlVal = "";
            }
            else if (Type == "image") {
                var maxFilePath = JSON.parse(document.getElementById(ctrlID + '_hdnMaxFilePath').value);
                maxFilePath = parseInt(maxFilePath) + 1;
                document.getElementById(ctrlID + '_hdnMaxFilePath').value = maxFilePath;
                ctrlVal = '<input id="ImageUpload' + counter + '" name="ImageUpload' + counter + '" type="file" size="15" accept="image/*" onchange="checkFile(this.id);" width="200" height="100" /><input id="hdn' + count + '" type="hidden" value="' + Type + '"/><input id="hdnFilePath' + count + '" type="hidden" value="' + maxFilePath + '"/>';
                bindCtrlVal = $('<td/>').html(ctrlVal);
                row$.append(bindCtrlVal);
                Type = "";
                ctrlVal = "";
                bindCtrlVal = "";
            }
            else if (Type == "linkbutton") {
                ctrlVal = '<input id="ctl' + count + '"  value="Delete" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onRowDelete(this);" />';
                bindCtrlVal = $('<td/>').html(ctrlVal);
                row$.append(bindCtrlVal);
                Type = "";
                ctrlVal = "";
                bindCtrlVal = "";
            }
        });
        tbody$.append(row$);
        $(tbl).append(tbody$);
        counter++;
    }
    function checkFile(obj) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vUpload = SListForAppMsg.Get('Investigation_GeneralPattern_ascx_01') == null ? "You must select a GIF,JPEG,JPG and PNG file for upload" : SListForAppMsg.Get('Investigation_GeneralPattern_ascx_01');
        var fileElement = document.getElementById(obj);
        var fileExtension = "";
        if (fileElement.value.lastIndexOf(".") > 0) {
            fileExtension = fileElement.value.substring(fileElement.value.lastIndexOf(".") + 1, fileElement.value.length);
        }
        if (fileExtension == "gif" || fileExtension == "GIF" || fileExtension == "JPEG" || fileExtension == "jpeg" || fileExtension == "jpg" || fileExtension == "JPG" || fileExtension == "PNG" || fileExtension == "png") {
            return true;
        }
        else {
            //alert("You must select a GIF,JPEG,JPG and PNG file for upload");
            ValidationWindow(vUpload, AlertType);
            document.getElementById(obj).value = '';
            fileElement.focus();
            return false;
        }
    }
    function BindTable(invid, orgid, visitid, ctrlID) {
        if (document.getElementById(ctrlID + '_hdnBindData').value != "") {
            var ddlVal = "";
            var ctrlVal = "";
            var bindCtrlVal = "";
            var headername = "";
            var row$ = "";
            var tbl = document.getElementById(ctrlID + "_tbl");
            var tbody = $('<tbody/>');
            var BindData = JSON.parse(document.getElementById(ctrlID + '_hdnBindData').value);
            var ControlType = JSON.parse(document.getElementById(ctrlID + '_hdnControlType').value);
            var ImgSourceDetails = JSON.parse(document.getElementById(ctrlID + '_hdnImgSourceDetails').value);
            var rowCount = 0;
            $.each(BindData, function(i, obj) {
                rowCount = i + 1;
                var count = 0;
                var j = 0;
                row$ = $('<tr/>');
                $.each(ControlType, function(k, obj1) {
                    var value = obj[j];
                    j++;
                    var Type = obj1.ControlType;
                    headername = obj1.HeaderName;
                    count++;
                    if (Type == "dropdown") {
                        var lstGenPtn = JSON.parse(document.getElementById(ctrlID + '_hdnGeneralPattern').value);
                        $.each(lstGenPtn, function(i, obj2) {
                            if (obj2.Name == headername) {
                                if (obj2.Value == value)
                                    ddlVal += "<option value='" + obj2.Name + "' selected='true'>" + obj2.Value + "</option>";
                                else
                                    ddlVal += "<option value='" + obj2.Name + "'>" + obj2.Value + "</option>";
                            }
                        });
                        ctrlVal = '<span class="richcombobox" style="width: 120px;"><select id="ctl' + count + '" class="ddl" style="width: 100px;" title="' + obj.HeaderName + '">' + ddlVal + '</select></span><input id="hdn' + count + '" type="hidden" value="' + Type + '"/> ';
                        bindCtrlVal = $('<td/>').html(ctrlVal);
                        row$.append(bindCtrlVal);
                        Type = "";
                        ddlVal = "";
                        ctrlVal = "";
                        bindCtrlVal = "";
                    }
                    else if (Type == "textbox") {
                        ctrlVal = '<input id="ctl' + count + '" type="text" style="width: 170px; height: 40px;" value="' + value + '"/><input id="hdn' + count + '" type="hidden" value="' + Type + '"/> ';
                        bindCtrlVal = $('<td/>').html(ctrlVal);
                        row$.append(bindCtrlVal);
                        Type = "";
                        ctrlVal = "";
                        bindCtrlVal = "";
                    }
                    else if (Type == "linkbutton") {
                        ctrlVal = '<input id=' + count + '  value="Delete" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onRowDelete(this);" />';
                        ctrlVal += '<input id="hdnInvestigationId" type="hidden" value="' + invid + '"/>';
                        ctrlVal += '<input id="hdnOrgID" type="hidden" value="' + orgid + '"/>';
                        ctrlVal += '<input id="hdnPvisitid" type="hidden" value="' + visitid + '"/>';
                        bindCtrlVal = $('<td/>').html(ctrlVal);
                        row$.append(bindCtrlVal);
                        Type = "";
                        ctrlVal = "";
                        bindCtrlVal = "";
                    }
                    else if (Type == "image") {
                        var imgval = true;
                        $.each(ImgSourceDetails, function(m, obj3) {
                            if (ImgSourceDetails[m].FilePath == value) {
                                var imageURL = "ProbeImagehandler.ashx?InvID=" + invid + "&VisitId=" + visitid + "&POrgID=" + orgid + "&ImageID=" + ImgSourceDetails[m].ImageID;
                                
                                
                                var downloadURL = "ProbeImagehandler.ashx?Download=true&InvID=" + invid + "&VisitId=" + visitid + "&POrgID=" + orgid + "&ImageID=" + ImgSourceDetails[m].ImageID + "&ImageName=" + ImgSourceDetails[m].FilePath;
                                ctrlVal = '<img src="' + imageURL + '" alt="' + Type + '" id="ctlimg' + i + '" width="200" height="100">';
                                
                                
                                ctrlVal += '<input id="ImageUpload' + counter + '" name="ImageUpload' + counter + '" type="file" size="15" accept="image/*" onchange="checkFile(this.id);" width="200" height="100" /><input id="hdn' + count + '" type="hidden" value="' + Type + '"/> <input id="hdnImg' + count + '" type="hidden" value="' + ImgSourceDetails[m].ImageID + '"/><input id="hdnFilePath' + count + '" type="hidden" value="' + ImgSourceDetails[m].FilePath + '"/>';
                                ctrlVal += '<a href="' + downloadURL + '" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; alt="#">Download</a>'
                                bindCtrlVal = $('<td/>').html(ctrlVal);
                                row$.append(bindCtrlVal);
                                Type = "";
                                ctrlVal = "";
                                bindCtrlVal = "";
                                imgval = false;
                            }


                        });
                        if (imgval == true) {
                            var maxFilePath = JSON.parse(document.getElementById(ctrlID + '_hdnMaxFilePath').value);
                            maxFilePath = parseInt(maxFilePath) + 1;
                            document.getElementById(ctrlID + '_hdnMaxFilePath').value = maxFilePath;
                            ctrlVal = '<input id="ImageUpload' + counter + '" name="ImageUpload' + counter + '" type="file" size="15" accept="image/*" onchange="checkFile(this.id);" width="200" height="100" /><input id="hdn' + count + '" type="hidden" value="' + Type + '"/><input id="hdnFilePath' + count + '" type="hidden" value="' + maxFilePath + '"/>';
                            bindCtrlVal = $('<td/>').html(ctrlVal);
                            row$.append(bindCtrlVal);
                            Type = "";
                            ctrlVal = "";
                            bindCtrlVal = "";
                        }

                    }
                });
                $(tbody).append(row$);
                counter++;
            });
            $(tbl).append(tbody);
        }
    }

    function onRowDelete(obj) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vUnable = SListForAppMsg.Get('Investigation_GeneralPattern_ascx_02') == null ? "Unable to delete" : SListForAppMsg.Get('Investigation_GeneralPattern_ascx_02');
        try {
            var $row = $(obj).closest('tr');
            var invID = $row.find("input[id^='hdnInvestigationId']").val();
            var orgID = $row.find("input[id^='hdnOrgID']").val();
            var Patientvisitid = $row.find("input[id^='hdnPvisitid']").val();
            var imageID = $row.find("input[id^='hdnImg']").val();
            if (invID == '' || invID == undefined) {
                invID = '0';
            }
            if (orgID == '' || orgID == undefined) {
                orgID = '0';
            }
            if (Patientvisitid == '' || Patientvisitid == undefined) {
                Patientvisitid = '0';
            }
            if (imageID == '' || imageID == undefined) {
                imageID = '0';
            }
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/DeleteProbeImageDeatils",
                data: "{PVisitId: " + Patientvisitid + ",Pinvid: " + invID + ",OrgID: " + orgID + ",ImageId: " + imageID + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function Success(data) {
                    $(obj).closest('tr').remove();
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    //alert("Unable to delete");
                    ValidationWindow(vUnable, AlertType);
                }
            });
        }
        catch (e) {
            return false;
        }
        return false;
    }
    
</script>

<table class="defaultfontcolorc w-100p">
    <tr>
        <td id="tdInvName" runat="server" style="color: #000;display: table-cell;" colspan="3" class="w-19p h-30 font10">
            <asp:Label ID="lblName" runat="server" Text="Name" 
                meta:resourcekey="lblNameResource1"></asp:Label>
            &nbsp;
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <table>
                <tr>
                    <td style="color: #000;display: table-cell;" class="w-19p h-30 font10">
                        <input id="BtnAdd" value="Add" type="button" class="btn" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
        <td style="color: #000;display: table-cell;" class="w-19p h-30 font10">
        </td>
        <td style="color: #000;display: table-cell;" class="w-19p h-30 font10">
        </td>
    </tr>
    <tr>
        <td id="tdDynamic" runat="server">
            <div id="divtable" class="mytable1" style="overflow: auto; height: 200px">
                <table id="tbl" class="w-98p" runat="server">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <table class="w-100p">
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td class="v-middle a-right w-42p">
                        <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" CssClass="ddl"
                            OnSelectedIndexChanged="ddlstatus_SelectedIndexChanged" 
                            meta:resourcekey="ddlstatusResource1">
                            <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource1"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="w-14p">
                        <table id="tdInvStatusReason2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1"
                                        Width="100px" normalWidth="100px" onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);"
                                        meta:resourcekey="ddlStatusReasonResource1" CssClass="ddl">
                                        <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <span class="richcombobox w-100">
                                        <asp:DropDownList ForeColor="Black" ID="ddlOpinionUser" runat="server" TabIndex="-1"
                                            CssClass="ddl" Width="100px" meta:resourcekey="ddlOpinionUserResource1">
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
            <asp:HiddenField runat="server" ID="hdnGeneral" Value="" />
            <asp:HiddenField runat="server" ID="hdnpatientvisitid" Value="0" />
            <asp:HiddenField runat="server" ID="hdninvid" Value="0" />
            <input id="hdnGeneralPattern" runat="server" type="hidden" />
            <input id="hdnControlType" runat="server" type="hidden" />
            <input id="hdnBindData" runat="server" type="hidden" />
            <input id="hdnInvestigationId" runat="server" type="hidden" value="" />
            <input id="hdnOrgID" runat="server" type="hidden" value="" />
            <input id="hdnPvisitid" runat="server" type="hidden" value="" />
            <input id="hdnconfig" runat="server" type="hidden" value='N' />
        </td>
    </tr>
</table>
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<input id="hdnImageList" runat="server" type="hidden" value="" />
<input id="hdnImgSourceDetails" runat="server" type="hidden" value="" />
<input id="hdnMaxFilePath" runat="server" type="hidden" value="0" />
<input id="hdnimghtwidth" runat="server" type="hidden" value="0" />
