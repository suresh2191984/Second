<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SampleArchival.aspx.cs" Inherits="Lab_SampleArchival"
    EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table class="dataheader3 w-30p">
                    <tr class="h-30">
                        <td>
                            <asp:Label ID="lblSampleBarcodeNo" runat="server" meta:resourcekey="lblSampleBarcodeNoResource1"
                                Text="Sample Barcode No"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSampleBarcodeNo" CssClass="small" runat="server" 
                                meta:resourcekey="txtSampleBarcodeNoResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button ID="btnOk" runat="server" CssClass="btn" Text="Ok" meta:resourcekey="btnOk1"
                                OnClientClick="javascript:return SearchBarcode();" Width="40px" OnClick="btnOk_Click" />
                        </td>
                    </tr>
                </table>
                <table class="dataheader3 w-100p">
                    <tr class="h-50">
                        <td>
                            <asp:Label ID="lblBuilding" Text="Building" runat="server" meta:resourcekey="lblBuildingResource1"></asp:Label>
                            &nbsp;&nbsp;
                            <asp:DropDownList runat="server" ID="ddlBuilding" CssClass="ddlsmall" TabIndex="1"
                                meta:resourcekey="ddlBuildingResource1" AutoPostBack="True" OnSelectedIndexChanged="ddlBuilding_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label ID="lblFloor" Text="Floor" runat="server" meta:resourcekey="lblFloorResource1"></asp:Label>
                            &nbsp;&nbsp;
                            <asp:DropDownList runat="server" ID="ddlFloor" CssClass="ddlsmall" TabIndex="2" meta:resourcekey="ddlFloorResource1"
                                AutoPostBack="True" OnSelectedIndexChanged="ddlFloor_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label ID="lblStorageArea" Text="Storage Area" runat="server" meta:resourcekey="lblStorageAreaResource1"></asp:Label>
                            &nbsp;&nbsp;
                            <asp:DropDownList runat="server" ID="ddlStorageArea" CssClass="ddlsmall" TabIndex="3"
                                meta:resourcekey="ddlStorageAreaResource1" AutoPostBack="True" OnSelectedIndexChanged="ddlStorageArea_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label ID="lblStorageUnit" Text="Storage Unit" runat="server" meta:resourcekey="lblStorageUnitResource1"></asp:Label>
                            &nbsp;&nbsp;
                            <asp:DropDownList runat="server" ID="ddlStorageUnit" CssClass="ddlsmall" TabIndex="3"
                                meta:resourcekey="ddlStorageUnitResource1" AutoPostBack="True" OnSelectedIndexChanged="ddlStorageUnit_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label ID="lblTray" Text="Tray" runat="server" meta:resourcekey="lblTrayResource1"></asp:Label>
                            &nbsp;&nbsp;
                            <asp:DropDownList runat="server" ID="ddlTray" CssClass="ddlsmall" TabIndex="4" AutoPostBack="true"
                                meta:resourcekey="ddlTrayResource1" OnSelectedIndexChanged="ddlTray_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
                <table id="tblCheckbox" runat="server" style="display: none;">
                    <tr>
                        <td>
                            <asp:CheckBox ID="ChkDisposalSamples" Text="Samples For Disposal" onclick="GetSamplesForDisposal(this);"
                                runat="server" meta:resourcekey="ChkDisposalSamplesResource1" />
                        </td>
                        <td>
                            <asp:Button ID="btnBulkCheckOut" runat="server" Text="Bulk CheckOut" OnClientClick="javascript:return ValidateCheckOut();"
                                CssClass="btn" meta:resourcekey="btnBulkCheckOutResource1" />
                        </td>
                    </tr>
                </table>
                <table id="tblLegends" runat="server" class="a-right" style="display: none;">
                    <tr>
                        <td>
                            <asp:TextBox ID="txtCheckedin" Enabled="false" BackColor="#FFDBDC" runat="server"
                                CssClass="w-10 h-10" meta:resourcekey="txtCheckedinResource1"></asp:TextBox>
                            <asp:Label ID="lblCheckedin" Text="Checked-In Samples" runat="server" 
                                meta:resourcekey="lblCheckedinResource1"></asp:Label>
                            <asp:TextBox ID="txtCheckedOut" BackColor="#DCFEC6" Enabled="false" runat="server"
                                CssClass="w-10 h-10" meta:resourcekey="txtCheckedOutResource1"></asp:TextBox>
                            <asp:Label ID="lblCheckedOut" runat="server" Text="Checked-Out Samples" 
                                meta:resourcekey="lblCheckedOutResource1"></asp:Label>
                            <asp:TextBox ID="txtReadytoDispose" BackColor="#FFDBDC" Enabled="false" runat="server"
                                CssClass="w-10 h-10" meta:resourcekey="txtReadytoDisposeResource1"></asp:TextBox>
                            <asp:Label ID="lblReadytoDispose" runat="server" Text="Ready For Disposal" 
                                meta:resourcekey="lblReadytoDisposeResource1"></asp:Label>
                        </td>
                    </tr>
                </table>
                <asp:DataList ID="dlSampleArchival" runat="server" RepeatDirection="Horizontal" OnItemDataBound="dlSampleArchival_ItemDataBound" meta:resourcekey="dlSampleArchivalResource1">
                    <HeaderTemplate>
                        <table class="font11 h-100 a-center" style="font-family: Arial;">
                            <tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <td id="tdSlot" runat="server" class="v-middle" style="border-color: black; border-style: solid;
                            border-width: 1px; color: Black;">
                            <asp:Panel ID='dvFloor' runat="server" HorizontalAlign="Center" meta:resourcekey="dvFloorResource1">
                                <%-- CssClass="borderstyle"--%>
                                <div class="a-center v-bottom w-100p">
                                    <asp:LinkButton ID="lnkCheckin" Style="color: Black; display: none; background-color: Lime;
                                        border-color: Maroon; font-weight: bold;" runat="server" Text="Checkin" meta:resourcekey="lnkCheckinResource1"
                                        OnClientClick="SaveCheckIn(this);return false;"></asp:LinkButton>
                                    <asp:LinkButton ID="lnkCheckOut" Style="color: Black; display: none; background-color: #DCFEC6;
                                        border-color: #99CC00; font-weight: bold;" runat="server" Text="Checkout" 
                                        OnClientClick="SaveCheckOut(this);return false;" 
                                        meta:resourcekey="lnkCheckOutResource1"></asp:LinkButton>
                                </div>
                                <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>' 
                                    Style="display: none;" meta:resourcekey="lblStatusResource1"></asp:Label>
                                <br />
                                <asp:TextBox ID="txtBarcodeNo" CssClass="small" runat="server" Text='<%# Eval("BarcodeNo") %>'
                                    BorderStyle="Solid" meta:resourcekey="txtBarcodeNoResource1"></asp:TextBox>
                                <asp:Label ID="lblBarcode" runat="server" Text='<%# Eval("BarcodeNo") %>' 
                                    Style="display: none;" meta:resourcekey="lblBarcodeResource1"></asp:Label>
                                <br />
                                <asp:Label ID="lblDeptName" runat="server" Text='<%# Eval("DeptName") %>' 
                                    meta:resourcekey="lblDeptNameResource1"></asp:Label>
                                <br />
                                <asp:Label ID="lblDeviceName" runat="server" 
                                    Text='<%# Eval("InstrumentName") %>' meta:resourcekey="lblDeviceNameResource1"></asp:Label>
                                <br />
                                <asp:Label ID="lblCellIndex" runat="server" 
                                    Text='<%# Eval("RowNo") + "," + Eval("ColumnNo") %>' 
                                    meta:resourcekey="lblCellIndexResource1"></asp:Label>
                                <br />
                                <asp:Label ID="lblIsReadyFlag" runat="server" Text='<%# Eval("IsReady") %>' 
                                    Style="display: none;" meta:resourcekey="lblIsReadyFlagResource1"></asp:Label>
                                </br>
                                <asp:CheckBox ID="CheckReadyChkOut" runat="server" Style="display: none;" 
                                    meta:resourcekey="CheckReadyChkOutResource1" />
                            </asp:Panel>
                        </td>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tr> </table>
                    </FooterTemplate>
                </asp:DataList>
                <table class="w-100p">
                    <tr>
                        <td class="a-center">
                            <asp:Button ID="btnSaveSampleArchival" runat="server" CssClass="btn" Text="Finish"
                                Visible="false" OnClientClick="SaveSampleArchival();" OnClick="btnSaveSampleArchival_Click"
                                meta:resourcekey="Rs_btnSaveSampleArchivalResource1" />
                            <asp:Button ID="btnShow" runat="server" CssClass="btn" Text="Finish" Style="display: none;"
                                OnClick="ddlTray_SelectedIndexChanged" meta:resourcekey="Rs_btnSaveSampleArchivalResource1" />
                        </td>
                    </tr>
                </table>
                <asp:HiddenField ID="hdnCurrentDate" runat="server" />
            </ContentTemplate>
            
        </asp:UpdatePanel>
        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
           <ProgressTemplate>
                                       <div id="progressBackgroundFilter" class="a-center">
                                       </div>
                                       <div id="processMessage" class="a-center w-20p">
                                           <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                       </div>
                                   </ProgressTemplate>

        </asp:UpdateProgress>
    </div>
       <Attune:Attunefooter ID="Attunefooter" runat="server" />  
<%--    <script type="text/javascript" src="../Scripts/jquery-1.8.1.min.js"></script>

    <script type="text/javascript" src="../Scripts/JsonScript.js"></script>--%>

    <script type="text/javascript">
        var InformationMsg;
        var InformationMsg1;
        var InformationMsg2;
        var InformationMsg3;
        var InformationSuccess;
        var InformationSuccess1;
        var InfoChecked;
        var InfoCheckedOut;
        var Error;
        $(document).ready(function() {
            Error = SListForAppMsg.Get("Lab_SampleArchival_aspx_01") != null ? SListForAppMsg.Get("Lab_SampleArchival_aspx_01") : "Information";
            InformationMsg = SListForAppMsg.Get("Lab_SampleArchival_aspx_02") != null ? SListForAppMsg.Get("Lab_SampleArchival_aspx_02") : "Provide sample details";
            InformationMsg1 = SListForAppMsg.Get("Lab_SampleArchival_aspx_03") != null ? SListForAppMsg.Get("Lab_SampleArchival_aspx_03") : "There is no sample details to checkin";
            InformationMsg2 = SListForAppMsg.Get("Lab_SampleArchival_aspx_04") != null ? SListForAppMsg.Get("Lab_SampleArchival_aspx_04") : "Given sample details already exists";
            InformationMsg3 = SListForAppMsg.Get("Lab_SampleArchival_aspx_05") != null ? SListForAppMsg.Get("Lab_SampleArchival_aspx_05") : "Unable to Checkin the details";
            InformationSuccess = SListForAppMsg.Get("Lab_SampleArchival_aspx_06") != null ? SListForAppMsg.Get("Lab_SampleArchival_aspx_06") : "Checked-In Successfully";
            InformationSuccess1 = SListForAppMsg.Get("Lab_SampleArchival_aspx_07") != null ? SListForAppMsg.Get("Lab_SampleArchival_aspx_07") : "Checked-Out Successfully";
            InfoChecked = SListForAppMsg.Get("Lab_SampleArchival_aspx_08") != null ? SListForAppMsg.Get("Lab_SampleArchival_aspx_08") : "Unable to Checked-Out the details";
            InfoCheckedOut = SListForAppMsg.Get("Lab_SampleArchival_aspx_09") != null ? SListForAppMsg.Get("Lab_SampleArchival_aspx_09") : "There is no Sample For Checkout";
            
            
        });

        function SearchBarcode() {
            if ($.trim($('#txtSampleBarcodeNo').val()) == '') {

                ValidationWindow(InformationMsg  , Error);

                //alert("Provide sample details");
                return false;
            }
            //            else {
            //                var isBarcodeExists = false;
            //                $("#dlSampleArchival tbody td").each(function(i, row) {
            //                    var txtBarcodeNo = $(this).find("input[id$='txtBarcodeNo']").val();
            //                    if ($.trim(txtBarcodeNo) == $.trim($('#txtSampleBarcodeNo').val())) {
            //                        isBarcodeExists = true;
            //                        return false;
            //                    }
            //                });
            //                if (isBarcodeExists) {
            //                    alert("Given sample details exists");
            //                    return false;
            //                }
            //                else {
            //                    alert("Given sample details not exists");
            //                    return false;
            //                }
            //            }
            return true;
        }
        function SaveCheckIn(obj) {
            var tdSlotID = '';
            var txtBarcodeNoID = '';
            var lnkCheckinID = '';
            var $td = $(obj).closest('td');
            tdSlotID = $td.attr('id');
            var lstSampleArchival = [];
            var selectedTrayID = $("#ddlTray option:selected").val();
            var lblCellIndex = $td.find("span[id$='lblCellIndex']").html();
            if (lblCellIndex != null && lblCellIndex != undefined) {
                var lstCellIndex = lblCellIndex.split(',');
                var lblStatus = $td.find("span[id$='lblStatus']").html();
                var txtBarcodeNo = $td.find("input[id$='txtBarcodeNo']").val();
                txtBarcodeNoID = $td.find("input[id$='txtBarcodeNo']").attr('id');
                lnkCheckinID = $td.find("[id$='lnkCheckin']").attr('id');
                if ($.trim(txtBarcodeNo) == '') {
                    ValidationWindow(InformationMsg1  , Error);

                   // alert('There is no sample details to checkin');
                    return false;
                }
                else {
                    var isBarcodeAlreadyExists = false;
                    $("#dlSampleArchival tbody td").each(function(i, row) {
                        if ($(this).attr('id') != undefined && tdSlotID != $(this).attr('id')) {
                            var txtCheckBarcodeNo = $(this).find("input[id$='txtBarcodeNo']").val();
                            if ($.trim(txtCheckBarcodeNo) == $.trim(txtBarcodeNo)) {
                                isBarcodeAlreadyExists = true;
                            }
                        }
                    });
                    if (isBarcodeAlreadyExists) {
                        ValidationWindow(InformationMsg2  , Error);

                       // alert('Given sample details already exists');
                        return false;
                    }
                    lblStatus = 'Checked-In';
                }
                lstSampleArchival.push({
                    StorageRackID: selectedTrayID,
                    RowNo: lstCellIndex[0],
                    ColumnNo: lstCellIndex[1],
                    BarcodeNo: $.trim(txtBarcodeNo),
                    Status: $.trim(lblStatus)
                });
            }
            if (lstSampleArchival.length > 0) {
                $.ajax({
                    type: "POST",
                    url: "SampleArchival.aspx/SaveCheckIn",
                    data: "{sampleArchival: '" + JSON.stringify(lstSampleArchival) + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function Success(data) {
                        $("#" + tdSlotID).css("background-color", "#FFDBDC");
                        $("#" + tdSlotID).css("border-color", "#CC3300");
                        $("#" + txtBarcodeNoID).css("border-color", "#CC3300");
                        $("#" + txtBarcodeNoID).attr("disabled", "disabled");
                        $("#" + lnkCheckinID).hide();
                      //  alert("Checked-In Successfully");
                        ValidationWindow(InformationSuccess  , Error);
                        var btnShow = document.getElementById('btnShow');
                        btnShow.click();
                    },
                    error: function(xhr, ajaxOptions, thrownError) {

                    ValidationWindow(InformationMsg3  , Error);
                       // alert("Unable to Checkin the details");
                        return false;
                    }
                });
            }
        }

        function SaveSampleArchival() {
            var lstSampleArchival = [];
            var selectedTrayID = $("#ddlTray option:selected").val();
            $("#dlSampleArchival tbody td").each(function(i, row) {
                var lblCellIndex = $(this).find("span[id$='lblCellIndex']").html();
                if (lblCellIndex != null && lblCellIndex != undefined) {
                    var lstCellIndex = lblCellIndex.split(',');
                    var lblStatus = $(this).find("span[id$='lblStatus']").html();
                    var txtBarcodeNo = $(this).find("input[id$='txtBarcodeNo']").val();
                    if ($.trim(txtBarcodeNo) == '') {
                        lblStatus = 'Checked-Out';
                    }
                    else {
                        lblStatus = 'Checked-In';
                    }
                    lstSampleArchival.push({
                        StorageRackID: selectedTrayID,
                        RowNo: lstCellIndex[0],
                        ColumnNo: lstCellIndex[1],
                        BarcodeNo: $.trim(txtBarcodeNo),
                        Status: $.trim(lblStatus)
                    });
                }
            });
            $("#hdnLstSampleArchival").val(JSON.stringify(lstSampleArchival));
        }
        function SaveCheckOut(obj) {
            var tdSlotID = '';
            var txtBarcodeNoID = '';
            var lnkCheckinID = '';
            var $td = $(obj).closest('td');
            tdSlotID = $td.attr('id');
            var lstSampleArchival = [];
            var selectedTrayID = $("#ddlTray option:selected").val();
            var lblCellIndex = $td.find("span[id$='lblCellIndex']").html();
            if (lblCellIndex != null && lblCellIndex != undefined) {
                var lstCellIndex = lblCellIndex.split(',');
                var lblStatus = $td.find("span[id$='lblStatus']").html();
                var txtBarcodeNo = $td.find("input[id$='txtBarcodeNo']").val();
                txtBarcodeNoID = $td.find("input[id$='txtBarcodeNo']").attr('id');
                lnkCheckinID = $td.find("[id$='lnkCheckin']").attr('id');
                if ($.trim(txtBarcodeNo) == '') {
                    ValidationWindow(InformationMsg1  , Error);

                   // alert('There is no sample details to checkin');
                    return false;
                }
                //                else {
                //                    var isBarcodeAlreadyExists = false;
                //                    $("#dlSampleArchival tbody td").each(function(i, row) {
                //                        if (tdSlotID != $(this).attr('id')) {
                //                            var txtCheckBarcodeNo = $(this).find("input[id$='txtBarcodeNo']").val();
                //                            if ($.trim(txtCheckBarcodeNo) == $.trim(txtBarcodeNo)) {
                //                                isBarcodeAlreadyExists = true;
                //                            }
                //                        }
                //                    });
                //                    if (isBarcodeAlreadyExists) {
                //                        alert('Given sample details already exists');
                //                        return false;
                //                    }
                lblStatus = 'checked-out';
                //}
                lstSampleArchival.push({
                    StorageRackID: selectedTrayID,
                    RowNo: lstCellIndex[0],
                    ColumnNo: lstCellIndex[1],
                    BarcodeNo: $.trim(txtBarcodeNo),
                    Status: $.trim(lblStatus)
                });
            }
            if (lstSampleArchival.length > 0) {
                $.ajax({
                    type: "POST",
                    url: "SampleArchival.aspx/SaveCheckIn",
                    data: "{sampleArchival: '" + JSON.stringify(lstSampleArchival) + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function Success(data) {
                        $("#" + tdSlotID).css("background-color", "#FFDBDC");
                        $("#" + tdSlotID).css("border-color", "#CC3300");
                        $("#" + txtBarcodeNoID).css("border-color", "#CC3300");
                        $("#" + txtBarcodeNoID).attr("disabled", "disabled");
                        $("#" + lnkCheckinID).hide();
                        //alert("Checked-Out Successfully");
                        ValidationWindow(InformationSuccess1  , Error);
                        var btnShow = document.getElementById('btnShow');
                        btnShow.click();
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                    ValidationWindow(InfoChecked  , Error);
                       // alert("Unable to Checked-Out the details");
                        return false;
                    }
                });
            }
        }
        function GetSamplesForDisposal(ele) {

            //debugger;
            $("#dlSampleArchival tbody td").each(function(i, row) {

                var lblStatus = $(this).find("span[id$='lblStatus']").html();
                var lblIsReadyFlag = $(this).find("span[id$='lblIsReadyFlag']").html();
                var linkButtonchkin = $(this).find("[id$='lnkCheckin']").attr('id');
                var linkButtonchkout = $(this).find("[id$='lnkCheckOut']").attr('id');
                var CheckReady = $(this).find("input:checkbox[id$=CheckReadyChkOut]").attr('id');
                var DivID = $(this).find("[id$='dvFloor']").attr('id');
                if ($("input:checkbox[id$=ChkDisposalSamples]").is(':checked')) {
                    if (CheckReady != undefined) {
                        if (lblIsReadyFlag == 'Y') {
                            $("#" + DivID).css("background-color", "#BE81F7");
                            $(this).css("border-color", "#BE81F7");
                            $("#" + linkButtonchkin).hide();
                            $("#" + linkButtonchkout).hide();
                            document.getElementById(CheckReady).checked = true;
                        }
                        else {
                            $(this).attr("disabled", "disabled");
                            if (lblStatus != undefined) {
                                if (lblStatus.toLowerCase() == 'checked-out' || lblStatus == '') {
                                    $("#" + linkButtonchkin).hide();
                                }

                            }
                        }
                    }
                }
                else {
                    if (CheckReady != undefined) {
                        if (document.getElementById(CheckReady).checked == true) {
                            $("#" + DivID).css("background-color", "#FFDBDC");
                            $(this).css("border-color", "#CC3300");
                            $("#" + linkButtonchkin).hide();
                            $("#" + linkButtonchkout).show();
                            document.getElementById(CheckReady).checked = false;

                        }
                        else {
                            $(this).removeAttr('disabled');
                            if (lblStatus != undefined) {
                                if (lblStatus.toLowerCase() == 'checked-out' || lblStatus == '') {
                                    $("#" + linkButtonchkin).show();
                                }
                                else {
                                    $("#" + linkButtonchkin).hide();
                                }
                            }
                        }
                    }
                }
            });

        }

        function ValidateCheckOut() {

            var lstSampleArchival = [];
            var selectedTrayID = $("#ddlTray option:selected").val();
            $("#dlSampleArchival tbody td").each(function(i, row) {
                var lblCellIndex = $(this).find("span[id$='lblCellIndex']").html();

                var CheckReady = $(this).find("input:checkbox[id$=CheckReadyChkOut]").attr('id');
                var txtBarcodeNo = $(this).find("input[id$='txtBarcodeNo']").val();
                var lblStatus = $(this).find("span[id$='lblStatus']").html();
                if (lblCellIndex != null && lblCellIndex != undefined) {
                    var lstCellIndex = lblCellIndex.split(',');
                    if (CheckReady != undefined) {
                        if (document.getElementById(CheckReady).checked == true) {
                            lblStatus = 'checked-out';
                            lstSampleArchival.push({
                                StorageRackID: selectedTrayID,
                                RowNo: lstCellIndex[0],
                                ColumnNo: lstCellIndex[1],
                                BarcodeNo: $.trim(txtBarcodeNo),
                                Status: $.trim(lblStatus)
                            });
                        }
                    }
                }
            });

            if (lstSampleArchival.length > 0) {
                $.ajax({
                    type: "POST",
                    url: "SampleArchival.aspx/SaveCheckIn",
                    data: "{sampleArchival: '" + JSON.stringify(lstSampleArchival) + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function Success(data) {

                    //alert("Checked-Out Successfully");
                    ValidationWindow(InformationSuccess1  , Error);
                        var btnShow = document.getElementById('btnShow');
                        btnShow.click();
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                    ValidationWindow(InfoChecked  , Error);
                      //  alert("Unable to Checked-Out the details");
                        return false;
                    }
                });
            }
            else {
                ValidationWindow(InfoCheckedOut  , Error);
               // alert('There is no Sample For Checkout')
                return false;
            }

        }
    </script>

    <asp:HiddenField ID="hdnLstSampleArchival" Value="" runat="server" />
     <asp:HiddenField ID="hdnMessages" Value="" runat="server" />
    </form>
</body>
</html>
