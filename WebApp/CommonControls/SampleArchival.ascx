<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SampleArchival.ascx.cs"
    Inherits="CommonControls_SampleArchival" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<div class="contentdata">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table class="dataheader3 w-30p" style="display: none;">
                <tr class="h-30">
                    <td>
                        <asp:Label ID="lblSampleBarcodeNo" runat="server" meta:resourcekey="lblSampleBarcodeNoResource1"
                            Text="Sample Barcode No"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtSampleBarcodeNo" runat="server" CssClass="small" 
                            meta:resourcekey="txtSampleBarcodeNoResource1"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Button ID="btnOk" runat="server"  Text="Ok" meta:resourcekey="btnOk1"
                            OnClientClick="SearchBarcode();return false;" CssClass="w-40 btn" />
                    </td>
                </tr>
            </table>
            <table class="dataheader3 w-100p" id="TblRoomDetails" runat="server">
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
                            AutoPostBack="True" 
                            OnSelectedIndexChanged="ddlStorageUnit_SelectedIndexChanged" 
                            meta:resourcekey="ddlStorageUnitResource1">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Label ID="lblTray" Text="Tray" runat="server" meta:resourcekey="lblTrayResource1"></asp:Label>
                        &nbsp;&nbsp;
                        <asp:DropDownList runat="server" ID="ddlTray" CssClass="ddlsmall" TabIndex="4" AutoPostBack="True"
                            OnSelectedIndexChanged="ddlTray_SelectedIndexChanged" 
                            meta:resourcekey="ddlTrayResource1">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <asp:DataList ID="dlSampleArchival" runat="server" RepeatDirection="Horizontal" 
                OnItemDataBound="dlSampleArchival_ItemDataBound" 
                meta:resourcekey="dlSampleArchivalResource1">
                <HeaderTemplate>
                    <table class="font11 h-100 a-center" style="font-family: Arial;">
                        <tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <td id="tdSlot" runat="server" class="v-middle" style="border-color: black; border-style: solid;
                        border-width: 1px; color: Black; background-color: #DCFEC6;">
                        <asp:Panel ID='dvFloor' runat="server" HorizontalAlign="Center">
                            <div class="v-bottom a-center w-100p paddingL25">
                                <asp:LinkButton ID="lnkCheckin" CssClass="borderstyle" Style="color: Black; display: none;
                                    background-color: #479C41" runat="server" Text="Checkin" meta:resourcekey="lnkCheckinResource1"
                                    OnClientClick="SaveCheckIn(this);return false;"></asp:LinkButton>
                            </div>
                            <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>' 
                                Visible="False" meta:resourcekey="lblStatusResource1"></asp:Label>
                            <br />
                            <asp:Label ID="lblBarCodeNo" runat="server" Text='<%# Eval("BarcodeNo") %>' 
                                meta:resourcekey="lblBarCodeNoResource1"></asp:Label>
                            <asp:TextBox ID="txtBarcodeNo" CssClass="small" runat="server" Text='<%# Eval("BarcodeNo") %>'
                                BorderStyle="Solid" Style="display: none;" 
                                meta:resourcekey="txtBarcodeNoResource1"></asp:TextBox>
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
                            <asp:HiddenField ID="hdnDeptID" runat="server" Value='<%# Eval("DeptID") %>'></asp:HiddenField>
                            <asp:HiddenField ID="hdnTrayID" runat="server" Value='<%# Eval("StorageRackID") %>'>
                            </asp:HiddenField>
                            <asp:HiddenField ID="hdnInstrumentID" runat="server" Value='<%# Eval("InstrumentID") %>'>
                            </asp:HiddenField>
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
                        <asp:Button ID="btnClose" runat="server" CssClass="btn" Text="Close" meta:resourcekey="Rs_btnSaveSampleArchivalResource1"
                            OnClientClick="javascript:return Close();" />
                    </td>
                </tr>
            </table>
            <asp:HiddenField ID="hdnLstSampleArchival" Value="" runat="server" />
             <asp:HiddenField ID="hdnTryID" Value="0" runat="server" />
             <asp:HiddenField ID="hdnBuldID" Value="0" runat="server" />
             <asp:HiddenField ID="hdnFloorID" Value="0" runat="server" />
             <asp:HiddenField ID="hdnStroageID" Value="0" runat="server" />
             <asp:HiddenField ID="hdnStorgeUnit" Value="0" runat="server" />             
             <asp:HiddenField ID="hdnDeptID" runat="server" Value="0" ></asp:HiddenField>                           
             <asp:HiddenField ID="hdnInstrumentID" runat="server" Value="0"></asp:HiddenField>  
             <asp:HiddenField ID="hdnNewBarcode" runat="server" Value="0"></asp:HiddenField> 
              <asp:HiddenField ID="hdnColNo" runat="server" Value="0"></asp:HiddenField>  
             <asp:HiddenField ID="hdnRowNo" runat="server" Value="0"></asp:HiddenField>              
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <asp:Image ID="imgLoadingbars" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgLoadingResource1" />
            <asp:Label ID="Rs_Loading" Text="Loading ..." runat="server" meta:resourcekey="Rs_LoadingResource1" />
        </ProgressTemplate>
    </asp:UpdateProgress>
<%--
    <script type="text/javascript" src="../Scripts/jquery-1.8.1.min.js"></script>

    <script type="text/javascript" src="../Scripts/JsonScript.js"></script>
--%>
    <script type="text/javascript">
        function SearchBarcode() {
            var AlrtWinHdr = SListForAppMsg.Get("CommonControls_Header_Alert") != null ? SListForAppMsg.Get("CommonControls_Header_Alert") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_SampleArchival_ascx_02") != null ? SListForAppMsg.Get("CommonControls_SampleArchival_ascx_02") : "Given sample details exists";
            var UsrAlrtMsg1 = SListForAppMsg.Get("CommonControls_SampleArchival_ascx_03") != null ? SListForAppMsg.Get("CommonControls_SampleArchival_ascx_03") : "Given sample details not exists";
            var UsrAlrtMsg2 = SListForAppMsg.Get("CommonControls_SampleArchival_ascx_04") != null ? SListForAppMsg.Get("CommonControls_SampleArchival_ascx_04") : "Provide sample details";
            if ($.trim($('#<%= txtSampleBarcodeNo.ClientID %>').val()) == '') {
                // alert("Provide sample details");
                ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                return false;
            }
            else {
                var isBarcodeExists = false;
                $("#<%= dlSampleArchival.ClientID %> tbody td").each(function(i, row) {
                    var txtBarcodeNo = $(this).find("input[id$='txtBarcodeNo']").val();
                    if ($.trim(txtBarcodeNo) == $.trim($('#txtSampleBarcodeNo').val())) {
                        isBarcodeExists = true;
                        return false;
                    }
                });
                if (isBarcodeExists) {
                    // alert("Given sample details exists");
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    //  alert("Given sample details not exists");
                    ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                    return false;
                }
            }
        }
        function SaveCheckIn(obj) {
            var AlrtWinHdr = SListForAppMsg.Get("CommonControls_Header_Alert") != null ? SListForAppMsg.Get("CommonControls_Header_Alert") : "Alert";
            var UsrAlrtMsg3 = SListForAppMsg.Get("CommonControls_SampleArchival_ascx_05") != null ? SListForAppMsg.Get("CommonControls_SampleArchival_ascx_05") : "There is no sample details to checkin";
            var UsrAlrtMsg4 = SListForAppMsg.Get("CommonControls_SampleArchival_ascx_06") != null ? SListForAppMsg.Get("CommonControls_SampleArchival_ascx_06") : "Checked-In Successfully";
            var UsrAlrtMsg5 = SListForAppMsg.Get("CommonControls_SampleArchival_ascx_07") != null ? SListForAppMsg.Get("CommonControls_SampleArchival_ascx_07") : "Unable to Checkin the details";
            var tdSlotID = '';
            var txtBarcodeNoID = '';
            var lnkCheckinID = '';
            var $td = $(obj).closest('td');
            tdSlotID = $td.attr('id');
            var lstSampleArchival = [];
            var selectedTrayID = $("#<%= ddlTray.ClientID %> option:selected").val();
            var lblCellIndex = $td.find("span[id$='lblCellIndex']").html();
            var lblStatus = $td.find("span[id$='lblStatus']").html();
            var txtBarcodeNo = $td.find("input[id$='txtBarcodeNo']").val();
            txtBarcodeNoID = $td.find("input[id$='txtBarcodeNo']").attr('id');
            lnkCheckinID = $td.find("[id$='lnkCheckin']").attr('id');
            
            if (lblCellIndex != null && lblCellIndex != undefined) {
                var lstCellIndex = lblCellIndex.split(',');                
                if ($.trim(txtBarcodeNo) == '') {
                   /// alert('There is no sample details to checkin');
                    ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                    return false;
                }
                else {
                    var isBarcodeAlreadyExists = false;
                    $("#<%= dlSampleArchival.ClientID %> tbody td").each(function(i, row) {
                        if (tdSlotID != $(this).attr('id')) {
                            var txtCheckBarcodeNo = $(this).find("input[id$='txtBarcodeNo']").val();
                            if ($.trim(txtCheckBarcodeNo) == $.trim(txtBarcodeNo)) {
                                isBarcodeAlreadyExists = true;
                            }
                        }
                    });
//                    if (isBarcodeAlreadyExists) {
//                        alert('Given sample details already exists');
//                        return false;
//                    }
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
                        // alert("Checked-In Successfully");
                        ValidationWindow(UsrAlrtMsg4, AlrtWinHdr);
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                    // alert("Unable to Checkin the details");
                    ValidationWindow(UsrAlrtMsg5, AlrtWinHdr);
                        return false;
                    }
                });
            }
        }

        function SaveSampleArchival() {
            var lstSampleArchival = [];
            var selectedTrayID = $("#<%= ddlTray.ClientID %> option:selected").val();
            $("#<%= dlSampleArchival.ClientID %> tbody td").each(function(i, row) {
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
            $("#<%= hdnLstSampleArchival.ClientID %>").val(JSON.stringify(lstSampleArchival));
        }
      
    </script>

</div>
