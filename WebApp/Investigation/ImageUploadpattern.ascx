<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ImageUploadpattern.ascx.cs"
    Inherits="Investigation_ImageUploadpattern" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

<script src="../Scripts/Common.js" type="text/javascript"></script>

<script src="../Scripts/jquery-1.3.2.min.js" type="text/javascript"></script>
--%>

<script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>

<style type="text/css">
    .mytable1 td, .mytable1 th
    {
        border: 1px solid #686868;
        border-bottom: 1px solid #686868;
    }
</style>
<style>
    .resultCapgrid span
    {
        width: 145px;
    }
    .csspName span
    {
        width: 110px;
    }
    .cssvName span, .cssvName a
    {
        display: table-cell;
        width: 95px;
    }
</style>

<script type='text/javascript'>
    var Id = 0;
    var MAX = 0;
    var DivFiles;
    var DivListBox;
    var BtnAdd;
    var InvID;
    var AccessionNo;
    function Add(pnlFiles, pnlListBox, btnAdd, ctrlID, accNo, GroupName, ddlStatus, IsAutoValidate) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vAdd = SListForAppMsg.Get('Investigation_ImageUploadpattern_ascx_01') == null ? "Please select a file to add." : SListForAppMsg.Get('Investigation_ImageUploadpattern_ascx_01');
        var vPleaseSelect = SListForAppMsg.Get('Investigation_ImageUploadpattern_ascx_02') == null ? "Please select valid file format (gif/jpg/png/bmp/jpeg)" : SListForAppMsg.Get('Investigation_ImageUploadpattern_ascx_02');
        DivFiles = document.getElementById(pnlFiles);
        DivListBox = document.getElementById(pnlListBox);
        BtnAdd = document.getElementById(btnAdd);
        InvID = ctrlID;
        AccessionNo = accNo;
        var IpFile = GetTopFile();
        if (IpFile == null || IpFile.value == null || IpFile.value.length == 0) {
            var userMsg = SListForApplicationMessages != null ? SListForApplicationMessages.Get('Investigation\\ImageUploadpattern.ascx_1') : null;
            if (userMsg != null) {
                alert(userMsg);
                return false;
            } else {
                //alert('Please select a file to add.');
                ValidationWindow(vAdd, AlertType);
                return false;
            }
            return;
        }
        var fileExt = IpFile.value.split('.').pop();
        var valid_extensions = /(gif|GIF|jpg|JPG|png|PNG|bmp|BMP|jpeg|JPEG|Jpeg)$/i;
        //var valid_extensions = /(\gif|\GIF|\jpg|\JPG|\png|\PNG|\bmp|\BMP|\jpeg|\JPEG|\Jpeg)$/i;
        if (!valid_extensions.test(fileExt)) {
            var userMsg = SListForApplicationMessages != null ? SListForApplicationMessages.Get('Investigation\\ImageUploadpattern.ascx_2') : null;
            if (userMsg != null) {
                alert(userMsg);
                return false;
            } else {
                //alert('Please select valid file format (gif/jpg/png/bmp/jpeg)');
                ValidationWindow(vPleaseSelect, AlertType);
                return false;
            }
            return;
        }
        var NewIpFile = CreateFile();
        DivFiles.insertBefore(NewIpFile, IpFile);
        if (MAX != 0 && GetTotalFiles() - 1 == MAX) {
            NewIpFile.disabled = true;
            BtnAdd.disabled = true;
        }
        IpFile.style.display = 'none';
        DivListBox.appendChild(CreateItem(IpFile));
        setCompletedStatus(GroupName, ddlStatus, IsAutoValidate);
    }
    function CreateFile() {
        var IpFile = document.createElement('input');
        IpFile.id = IpFile.name = 'IpFile_' + Id++ + '_' + InvID + '_' + AccessionNo;
        IpFile.type = 'file';
        return IpFile;
    }
    function CreateItem(IpFile) {
        var vDelete = SListForAppMsg.Get('Investigation_ImageUploadpattern_ascx_05') == null ? "Delete" : SListForAppMsg.Get('Investigation_ImageUploadpattern_ascx_05');
        var Item = document.createElement('div');
        Item.style.backgroundColor = '#ffffff';
        Item.style.fontWeight = 'normal';
        Item.style.textAlign = 'left';
        Item.style.verticalAlign = 'middle';
        Item.style.cursor = 'default';
        Item.style.height = 20 + 'px';
        var Splits = IpFile.value.split('\\');
        Item.innerHTML = Splits[Splits.length - 1] + '&nbsp;';
        Item.value = IpFile.id;
        Item.title = IpFile.value;
        var A = document.createElement('a');
        A.innerHTML = vDelete;
        A.id = 'A_' + Id++;
        A.href = '#';
        A.style.color = 'blue';
        A.onclick = function() {
            DivFiles.removeChild(document.getElementById(this.parentNode.value));
            DivListBox.removeChild(this.parentNode);
            if (MAX != 0 && GetTotalFiles() - 1 < MAX) {
                GetTopFile().disabled = false;
                BtnAdd.disabled = false;
            }
        }
        Item.appendChild(A);
        Item.onmouseover = function() {
            Item.bgColor = Item.style.backgroundColor;
            Item.fColor = Item.style.color;
            Item.style.backgroundColor = '#C6790B';
            Item.style.color = '#ffffff';
            Item.style.fontWeight = 'bold';
        }
        Item.onmouseout = function() {
            Item.style.backgroundColor = Item.bgColor;
            Item.style.color = Item.fColor;
            Item.style.fontWeight = 'normal';
        }
        return Item;
    }
    function Clear(pnlFiles, pnlListBox, btnAdd, ctrlID, accNo) {
        DivFiles = document.getElementById(pnlFiles);
        DivListBox = document.getElementById(pnlListBox);
        BtnAdd = document.getElementById(btnAdd);
        InvID = ctrlID;
        AccessionNo = accNo;
        DivListBox.innerHTML = '';
        DivFiles.innerHTML = '';
        DivFiles.appendChild(CreateFile());
        BtnAdd.disabled = false;
    }
    function GetTopFile() {
        var Inputs = DivFiles.getElementsByTagName('input');
        var IpFile = null;
        for (var n = 0; n < Inputs.length && Inputs[n].type == 'file'; ++n) {
            IpFile = Inputs[n];
            break;
        }
        return IpFile;
    }
    function GetTotalFiles() {
        var Inputs = DivFiles.getElementsByTagName('input');
        var Counter = 0;
        for (var n = 0; n < Inputs.length && Inputs[n].type == 'file'; ++n)
            Counter++;
        return Counter;
    }
    function GetTotalItems() {
        var Items = DivListBox.getElementsByTagName('div');
        return Items.length;
    }
    function DisableTop(pnlFiles, pnlListBox, btnAdd, ctrlID, accNo) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vPleaseBrowse = SListForAppMsg.Get('Investigation_ImageUploadpattern_ascx_03') == null ? "Please browse at least one file to upload." : SListForAppMsg.Get('Investigation_ImageUploadpattern_ascx_03');
        DivFiles = document.getElementById(pnlFiles);
        DivListBox = document.getElementById(pnlListBox);
        BtnAdd = document.getElementById(btnAdd);
        InvID = ctrlID;
        AccessionNo = accNo;
        if (GetTotalItems() == 0) {
            var userMsg = SListForApplicationMessages != null ? SListForApplicationMessages.Get('Investigation\\ImageUploadpattern.ascx_3') : null;
            if (userMsg != null) {
                alert(userMsg);
                return false;

            } else {
                //alert('Please browse at least one file to upload.');
                ValidationWindow(vPleaseBrowse, AlertType);
                return false;
            }
            return false;
        }
        GetTopFile().disabled = true;
        return true;
    }
    function onImageDelete(obj) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vUnable = SListForAppMsg.Get('Investigation_ImageUploadpattern_ascx_04') == null ? "Unable to delete" : SListForAppMsg.Get('Investigation_ImageUploadpattern_ascx_04');
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
    function GetInvMedicalRemarks(source, eventArgs) {

        RemarksDetails = eventArgs.get_value();
        if (document.getElementById('hdnAppRemarksID') != null) {
            var arrValue = RemarksDetails.split("~");
            document.getElementById('hdnAppRemarksID').value = arrValue[1];
            document.getElementById('hdnInvRemGrpIDList').value = document.getElementById('hdnInvRemGrpIDList').value + RemarksDetails + "^";
        }
    }
</script>
<asp:UpdatePanel ID="up1" runat="server">
<ContentTemplate>
 <asp:UpdateProgress ID="Progressbar1" AssociatedUpdatePanelID="up1" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter" class="a-center">
                        </div>
                        <div id="processMessage" class="a-center w-20p">
                            <asp:Image ID="imgProgressbar1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                meta:resourcekey="img1Resource1" />
                        </div>
                    </ProgressTemplate>
                      </asp:UpdateProgress>

<table class="defaultfontcolor w-100p">
    <tr>
        <td id="tdPatientDetails" class="bold font12 h-20 w-30p v-top" runat="server" style="color: #000;
            display: none;">
            <table class="w-100p h-20">
                <tr>
                    <td class="w-45p a-left csspName">
                        <asp:Label runat="server" ID="lblPatientName" meta:resourcekey="lblPatientNameResource1"></asp:Label>
                    </td>
                    <td class="w-10p" style="display: none;">
                        <asp:Label runat="server" ID="lblPatientNumber" 
                            meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                    </td>
                    <td class="w-10p" style="display: none;">
                        <asp:Label runat="server" ID="lblPatientVisitID" 
                            meta:resourcekey="lblPatientVisitIDResource1"></asp:Label>
                    </td>
                    <td class="w-10p a-left cssvName">
                        <asp:LinkButton ID="lnkPDFReportPreviewer" runat="server" Font-Underline="True"
                            ForeColor="Blue" TabIndex="-1" 
                            meta:resourcekey="lnkPDFReportPreviewerResource1"></asp:LinkButton>
                    </td>
                    <td class="w-40p">
                        <asp:Label runat="server" ID="lblAge" meta:resourcekey="lblAgeResource1"></asp:Label>
                        <span>/</span>
                        <asp:Label runat="server" ID="lblSex" meta:resourcekey="lblSexResource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
        <td id="tdInvName" runat="server" class="font11 h-20 w-19p v-top csspName" style="font-weight: normal;
            color: #000; display: table-cell;">
            <asp:Label ID="lblName" runat="server" Text="Name" 
                meta:resourcekey="lblNameResource1"></asp:Label>
            <asp:Label ID="lblTestStatus" runat="server" BackColor="Yellow" 
                meta:resourcekey="lblTestStatusResource1"></asp:Label>
            &nbsp;
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
        </td>
        <td class="w-2p v-middle a-left">
            <asp:Label ID="lblPVisitID" runat="server" Style="display: none;" 
                meta:resourcekey="lblPVisitIDResource1"></asp:Label>
            <asp:Label ID="lblPatternID" runat="server" Style="display: none;" 
                meta:resourcekey="lblPatternIDResource1"></asp:Label>
            <asp:Label ID="lblInvID" runat="server" Style="display: none;" 
                meta:resourcekey="lblInvIDResource1"></asp:Label>
            <asp:Label ID="lblOrgID" runat="server" Style="display: none;" 
                meta:resourcekey="lblOrgIDResource1"></asp:Label>
        </td>
        <td class="w-7p v-top">
            <asp:Panel ID="pnlParent" runat="server" Width="300px" CssClass="v-middle" 
                BorderStyle="Solid" meta:resourcekey="pnlParentResource1">
                <asp:Panel ID="pnlFiles" runat="server" Width="400px" CssClass="a-left" 
                    meta:resourcekey="pnlFilesResource1">
                    <asp:FileUpload ID="IpFile" runat="server" accept="gif|GIF|jpg|JPG|png|PNG|bmp|BMP|jpeg|JPEG"
                        ToolTip="Upload GIF,JPG,PNG,BMP and JPEG images only" 
                        meta:resourcekey="IpFileResource1" />&nbsp;<input id="btnAdd"
                            type="button" runat="server" value="Add" title="Add GIF,JPG,PNG,BMP and JPEG images only" meta:resourcekey="btnAddResource1" />&nbsp;&nbsp;<input
                                id="btnClear" class="w-60" type="button" value="Clear" 
                        runat="server" visible="False" />
                </asp:Panel>
                <asp:Panel ID="pnlListBox" runat="server" Width="292px" 
                    meta:resourcekey="pnlListBoxResource1">
                </asp:Panel>
                <asp:Panel ID="pnlButton" runat="server" Width="300px" CssClass="a-right" 
                    meta:resourcekey="pnlButtonResource1">
                    <asp:Button ID="btnUpload" runat="server" Text="Upload" CssClass="w-60" OnClick="btnUpload_Click"
                        Visible="False" meta:resourcekey="btnUploadResource1" />
                </asp:Panel>
                <asp:HiddenField runat="server" ID="hidVal" />
            </asp:Panel>
        </td>
        <td class="w-30p v-top">
            <div class="mytable1" style="overflow: auto; max-height: 200px" id="tdrptimages"
                runat="server" visible="false">
                <table id="tblimages" cellpadding="3" class="w-100p">
                    <thead>
                        <tr class="dataheader1 h-17">
                            <th class="w-15p">
                                <asp:Label runat="server" ID="thProbes" Text="Image Name" 
                                    meta:resourcekey="thProbesResource1" />
                            </th>
                            <th class="w-15p">
                                <asp:Label runat="server" ID="thimage" Text="Image" 
                                    meta:resourcekey="thimageResource1" />
                            </th>
                            <th class="w-15p">
                                <asp:Label runat="server" ID="Label2" Text="Action" 
                                    meta:resourcekey="Label2Resource1" />
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptimages" runat="server" OnItemDataBound="rptimages_ItemDataBound">
                            <ItemTemplate>
                                <tr class="h-17">
                                    <td class="a-left">
                                        <asp:Label ID="imagpath" runat="server" Text='<%# Bind("FilePath") %>' 
                                            meta:resourcekey="imagpathResource1"></asp:Label>
                                        <asp:HiddenField ID="HiddenProbeImageID" runat="server" Value='<%# Eval("ImageID") %>' />
                                        <asp:HiddenField ID="hdnInvestigationId" runat="server" Value='<%# Eval("InvestigationID") %>' />
                                        <asp:HiddenField ID="hdnOrgID" runat="server" Value='<%# Eval("OrgID") %>' />
                                        <asp:HiddenField runat="server" ID="hdnPvisitid" Value='<%# Eval("PatientVisitID") %>' />
                                    </td>
                                    <td class="a-left">
                                        <asp:Image ID="imgchrome" runat="server" CssClass="w-30 h-30" 
                                            meta:resourcekey="imgchromeResource1" />
                                    </td>
                                    <td class="a-center">
                                        <input id="btnDelete" runat="server" value="Delete" class="font11" type="button"
                                            style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline;
                                            cursor: pointer;" onclick="onImageDelete(this);" meta:resourcekey="btnDeleteResource1" />
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </td>
        <td id="tdRemarks" runat="server" class="font10 h-10 w-8p v-top" style="font-weight: normal;
            color: #000;">
            <table>
                <tr>
                    <td class="font10 h-10 w-8p" style="font-weight: normal; color: #000;">
                        <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server" 
                            meta:resourcekey="lblMedRemarksResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtMedRemarks"
                            TabIndex="-1" TextMode="MultiLine" CssClass="small" 
                            meta:resourcekey="txtMedRemarksResource1"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                            TargetControlID="txtMedRemarks" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                            EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                            DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="GetInvMedicalRemarks">
                        </ajc:AutoCompleteExtender>
                        <asp:HiddenField ID="hdnMedicalRemarksID" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
        <td class="v-top" style="padding-top: 20px;">
            <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" 
                CssClass="ddlsmall" meta:resourcekey="ddlstatusResource1">
                <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource1"></asp:ListItem>
            </asp:DropDownList>
        </td>
        <td class="v-top" style="padding-top: 20px;">
            <table id="tdInvStatusReason2" runat="server" class="v-middle" style="display: none;">
                <tr>
                    <td>
                        <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1"
                            onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);"
                            meta:resourcekey="ddlStatusReasonResource1" CssClass="ddlsmall">
                            <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                <tr>
                    <td>
                        <span class="richcombobox" class="w-100">
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
</ContentTemplate>
</asp:UpdatePanel>
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnUID" runat="server" Value="0" />
<asp:HiddenField ID="hdnLabNo" runat="server" Value="0" />
<asp:HiddenField ID="hdnGroupID" runat="server" Value="0" />
<asp:HiddenField ID="hdnGroupName" runat="server" Value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
<asp:HiddenField ID="hdnIsAutoValidate" runat="server" Value="" />
