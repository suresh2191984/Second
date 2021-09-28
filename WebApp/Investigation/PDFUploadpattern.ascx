<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PDFUploadpattern.ascx.cs"
    Inherits="Investigation_PDFUploadpattern" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

<%--<script src="../Scripts/Common.js" type="text/javascript"></script>

<script src="../Scripts/jquery-1.3.2.min.js" type="text/javascript"></script>

<script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>--%>

<style type="text/css">
    .mytable1 td, .mytable1 th
    {
        border: 1px solid #686868;
        border-bottom: 1px solid #686868;
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
    var ExternalID;
    
    function Add(pnlFiles, pnlListBox, btnAdd, ctrlID, accNo, GroupName, ddlStatus, clientID) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vAdd = SListForAppMsg.Get('Investigation_PDFUploadpattern_ascx_01') == null ? "Please select a file to add." : SListForAppMsg.Get('Investigation_PDFUploadpattern_ascx_01');
        var vFormat = SListForAppMsg.Get('Investigation_PDFUploadpattern_ascx_02') == null ? "Please select valid file format(PDF)" : SListForAppMsg.Get('Investigation_PDFUploadpattern_ascx_02');

        DivFiles = document.getElementById(pnlFiles);
        DivListBox = document.getElementById(pnlListBox);
        BtnAdd = document.getElementById(btnAdd);
        InvID = ctrlID;
        AccessionNo = accNo;
        var IpFile = GetTopFile(clientID);
        ExternalID = document.getElementById('<%= hdnExternlID.ClientID %>').value + ".pdf";

        var IPSplits = IpFile.value.split('\\');
        var IPItem = document.createElement('div');
        IPItem.innerHTML = IPSplits[IPSplits.length - 1]
        
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
        var valid_extensions = /(PDF)$/i;
        //var valid_extensions = /(\gif|\GIF|\jpg|\JPG|\png|\PNG|\bmp|\BMP|\jpeg|\JPEG|\Jpeg)$/i;
        if (!valid_extensions.test(fileExt)) {
            var userMsg = SListForApplicationMessages != null ? SListForApplicationMessages.Get('Investigation\\ImageUploadpattern.ascx_2') : null;
            if (userMsg != null) {
                alert(userMsg);
                return false;
            } else {
                //alert('Please select valid file format(PDF)');
                ValidationWindow(vFormat, AlertType);
                return false;
            }
            return;
        }
        var NewIpFile = CreateFile(clientID);
        DivFiles.insertBefore(NewIpFile, IpFile);
        if (MAX != 0 && GetTotalFiles() - 1 == MAX) {
            NewIpFile.disabled = true;
            BtnAdd.disabled = true;
        }
        IpFile.style.display = 'none';
        if (document.getElementById('<%= hdnExternalIDConfig.ClientID %>').value == "Y")
         {
            if (IPItem.innerHTML == ExternalID) {
                DivListBox.appendChild(CreateItem(IpFile));
            }
            else {
                //alert('Please select valid file format(PDF)');
                ValidationWindow("Upload the file with Same Lab Number Name format", AlertType);
                IPItem.innerHTML = '';
                IpFile.value = '';
                return false;
            }
        }
        else {
            DivListBox.appendChild(CreateItem(IpFile));
        }
        setCompletedStatus(GroupName, ddlStatus);
    }
    function CreateFile(clientID) {
        var IpFile = document.createElement('input');
        IpFile.id = IpFile.name = 'IpFile_' + Id++ + '_' + InvID + '_' + AccessionNo;
        IpFile.type = 'file';
        if (document.getElementById(clientID + '_hdnImageList').value == "") {
            document.getElementById(clientID + '_hdnImageList').value = IpFile.name;
        }
        else {
            document.getElementById(clientID + '_hdnImageList').value = document.getElementById(clientID + '_hdnImageList').value + "^" + IpFile.name;
        }
        return IpFile;
    }
    function CreateItem(IpFile) {
        var vDelete = SListForAppMsg.Get('Investigation_PDFUploadpattern_ascx_05') == null ? "Delete" : SListForAppMsg.Get('Investigation_PDFUploadpattern_ascx_05');
    
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
GetTopFile().disabled = true;
        AccessionNo = accNo;
        DivListBox.innerHTML = '';
        DivFiles.innerHTML = '';
        DivFiles.appendChild(CreateFile());
        BtnAdd.disabled = false;
    }
    function GetTopFile(clientID) {

        var Inputs = DivFiles.getElementsByTagName('input');
        var IpFile = null;
        for (var n = 0; n < Inputs.length && Inputs[n].type == 'file'; ++n) {
            IpFile = Inputs[n];
            if (document.getElementById(clientID + '_hdnImageList').value == "") {
                document.getElementById(clientID + '_hdnImageList').value = IpFile.name;
            }
            else {
                document.getElementById(clientID + '_hdnImageList').value = document.getElementById(clientID + '_hdnImageList').value + "^" + IpFile.name;
            }
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
        var vUpload = SListForAppMsg.Get('Investigation_PDFUploadpattern_ascx_03') == null ? "Please browse at least one file to upload." : SListForAppMsg.Get('Investigation_PDFUploadpattern_ascx_03');

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
                ValidationWindow(vUpload, AlertType);
                return false;
            }
            return false;
        }
        GetTopFile().disabled = true;
        return true;
    }
    function onImageDelete(obj) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vUnable = SListForAppMsg.Get('Investigation_PDFUploadpattern_ascx_04') == null ? "Unable to delete" : SListForAppMsg.Get('Investigation_PDFUploadpattern_ascx_04');

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
    function btnAdd_onclick() {

    }
    function ShowPDFPreview(obj) {
        try {
            var $row = $(obj).closest('tr');
            var HiddenProbeImageID = $row.find("input[id$='HiddenProbeImageID']").val();
            var invID = $row.find("input[id$='hdnInvestigationId']").val();
            var orgID = $row.find("input[id$='hdnOrgID']").val();
            var Patientvisitid = $row.find("input[id$='hdnPvisitid']").val();
            var Filepath = $row.find("input[id$='HiddenFilepath']").val();

            $find("mpReportPreview").show();
            $("#iframeplaceholder").html("<iframe id='myiframe' name='myname' src='../Reception/TRFImagehandler.ashx?PDFName=" + Filepath + "&OrgID=" + orgID + "' style='width: 100%;height: 450px; border: 0px; overfow: none;'></iframe>");
        }
        catch (e) {
            return false;
        }
    }
</script>

<table class="defaultfontcolor w-100p">
    <tr>
        <td id="tdPatientDetails" runat="server" style="color: #000;display: none;" valign="top" class="w-30p h-20 font12 bold">
            <table class="w-100p h-20">
                <tr>
                    <td width="45%" class="a-left w-45p">
                        <asp:Label runat="server" ID="lblPatientName" meta:resourcekey="lblPatientNameResource1"></asp:Label>
                    </td>
                    <td class="w-10p" style="display: none;">
                        <asp:Label runat="server" ID="lblPatientNumber" meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                    </td>
                    <td class="w-10p" style="display: none;">
                        <asp:Label runat="server" ID="lblPatientVisitID" meta:resourcekey="lblPatientVisitIDResource1"></asp:Label>
                    </td>
                    <td class="w-10p a-left">
                        <asp:LinkButton ID="lnkPDFReportPreviewer" runat="server" Font-Underline="True" ForeColor="Blue"
                            TabIndex="-1" meta:resourcekey="lnkPDFReportPreviewerResource1"></asp:LinkButton>
                        </asp:LinkButton>
                    </td>
                    <td class="w-40p">
                        <asp:Label runat="server" ID="lblAge" meta:resourcekey="lblAgeResource1"></asp:Label>
                        <span>/</span>
                        <asp:Label runat="server" ID="lblSex" meta:resourcekey="lblSexResource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
        <td id="tdInvName" runat="server" style="display: table-cell;" class="v-top w-19 h-20 font11 csspName">
            <asp:Label ID="lblName" runat="server" Text="Name" meta:resourcekey="lblNameResource1"></asp:Label>
            <asp:Label ID="lblTestStatus" runat="server" BackColor="Yellow" meta:resourcekey="lblTestStatusResource1"></asp:Label>
            &nbsp;
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
        </td>
        <td class="w-7p v-top">
            <asp:Panel ID="pnlParent" runat="server" Width="300px" BorderWidth="0px" BorderStyle="Solid"
                Style="vertical-align: middle;" meta:resourcekey="pnlParentResource1">
                <asp:Panel ID="pnlFiles" runat="server" Width="400px" HorizontalAlign="Left" meta:resourcekey="pnlFilesResource1">
                    <asp:FileUpload ID="IpFile" runat="server" accept="PDF" ToolTip="PDF Files only"
                        meta:resourcekey="IpFileResource1" />&nbsp;<input id="btnAdd" style="width: 60px"
                            type="button" runat="server" value="Add" title="Add PDF Files only" onclick="return btnAdd_onclick()"  meta:resourcekey="btnAddResource1"/>&nbsp;&nbsp;<input
                                id="btnClear" style="width: 60px" type="button" value="Clear" runat="server"
                                visible="False"  meta:resourcekey="btnClearResource1"/>
                </asp:Panel>
                <asp:Panel ID="pnlListBox" runat="server" Width="292px" meta:resourcekey="pnlListBoxResource1">
                </asp:Panel>
                <asp:Panel ID="pnlButton" runat="server" Width="300px" HorizontalAlign="Right" meta:resourcekey="pnlButtonResource1">
                    <asp:Button ID="btnUpload" runat="server"
                        Text="Upload" Width="60px" OnClick="btnUpload_Click" Visible="false" meta:resourcekey="btnUploadResource1" />
                </asp:Panel>
                <asp:HiddenField runat="server" ID="hidVal" />
            </asp:Panel>
        </td>
        <td class="w-29p v-top">
            <div class="mytable1" style="overflow: auto; max-height: 200px" id="tdrptimages" runat="server" visible="false">
                <table id="tblimages" class="w-100p">
                    <thead>
                        <tr class="dataheader1 h-17">
                            <th class="w-15p">
                                <asp:Label runat="server" ID="thProbes" Text="Image Name" meta:resourcekey="thProbesResource1" />
                            </th>
                            <th class="w-15p">
                                <asp:Label runat="server" ID="thimage" Text="Download" meta:resourcekey="thimageResource1" />
                            </th>
                            <th class="w-15p">
                                <asp:Label runat="server" ID="Label2" Text="Action" meta:resourcekey="Label2Resource1" />
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptimages" runat="server" 
                            OnItemDataBound="rptimages_ItemDataBound">
                            <ItemTemplate>
                                <tr class="h-17">
                                    <td class="a-left">
                                        <asp:Label ID="imagpath" runat="server" Text='<%# Bind("FilePath") %>' meta:resourcekey="imagpathResource1"></asp:Label>
                                        
                                        <asp:HiddenField ID="HiddenFilepath" runat="server" Value='<%# Bind("FilePath") %>' />
                                        <asp:HiddenField ID="HiddenProbeImageID" runat="server" Value='<%# Eval("ImageID") %>' />
                                        <asp:HiddenField ID="hdnInvestigationId" runat="server" Value='<%# Eval("InvestigationID") %>' />
                                        <asp:HiddenField ID="hdnOrgID" runat="server" Value='<%# Eval("OrgID") %>' />
                                        <asp:HiddenField runat="server" ID="hdnPvisitid" Value='<%# Eval("PatientVisitID") %>' />
                                    </td>
                                    <td class="a-left">
                                            
                                        <asp:LinkButton ID="linkshowpdf" runat="server" Text="ViewFile" OnClientClick="ShowPDFPreview(this);return false;"
                                            meta:resourcekey="linkshowpdfResource1"></asp:LinkButton>
                                    </td>
                                    <td class="a-center">
                                        <input id="btnDelete" runat="server" value="Delete" type="button" class="pointer font11" style="background-color: Transparent;
                                            color: Blue; border-style: none; text-decoration: underline;" onclick="onImageDelete(this);"  meta:resourcekey="btnDeleteResource1" />
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </td>
        <td id="tdRemarks" runat="server" style="font-weight: normal;color:#000;" class="v-top w-8p h-10 font10">
            <table>
                <tr>
                    <td style="font-weight: normal;color:#000;" class="v-top w-8p h-10 font10">
                        <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server" meta:resourcekey="lblMedRemarksResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtMedRemarks"
                            TabIndex="-1" TextMode="MultiLine" CssClass="Txtboxsmall" Height="30px" Width="150px"
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
        <td style="padding-top: 20px;" class="v-top">
            <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" CssClass="ddl">
                <asp:ListItem Text="Completed"></asp:ListItem>
            </asp:DropDownList>
        </td>
        <td style="padding-top: 20px;" class="v-top">
            <table id="tdInvStatusReason2" runat="server" style="display: none;" class="v-middle">
                <tr>
                    <td>
                        <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1"
                            Width="100px" normalWidth="100px" onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);"
                            meta:resourcekey="ddlStatusReasonResource1" CssClass="ddl">
                            <%--<asp:ListItem Text="--Select--" Value="0"></asp:ListItem>--%>
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
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<input id="hdnImageList" runat="server" type="hidden" value="" />
<input id="hdnExternlID" runat="server" type="hidden" value="0" />
<input id="hdnExternalIDConfig" runat="server" type="hidden" value="N" />
<asp:HiddenField ID="hdnUID" runat="server" Value="0" />
<asp:HiddenField ID="hdnLabNo" runat="server" Value="0" />