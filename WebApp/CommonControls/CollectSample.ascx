<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CollectSample.ascx.cs"
    Inherits="CommonControls_CollectSample" %>
<%@ Register Src="~/CommonControls/NewDateTimePicker.ascx" TagName="DatePicker" TagPrefix="DatePicker" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<style type="text/css">
    #tblCollectSample
    {
        border-collapse: collapse;
        width: 100%;
    }
    #tblCollectSample td, #tblCollectSample th
    {
        border: 1px solid white;
        padding: 5px;
    }
    #tblTestInstruction td, #tblTestInstruction th
    {
        border: 1px solid white;
        padding: 5px;
    }
    .divTable, .divColumn
    {
        margin: 0;
        padding: 0;
        border: 0;
        font-size: 100%;
        font: inherit;
        vertical-align: baseline;
        font: 13px/20px "Lucida Grande" , Tahoma, Verdana, sans-serif;
        color: #404040;
    }
    .divTable
    {
        width: 99%;
        margin: -5px 5px 2px 2px;
        display: inline-block;
        vertical-align: baseline;
        zoom: 1; *display:inline;*vertical-align:auto;-webkit-box-shadow:01px1pxrgba(0, 0, 0, 0.04);box-shadow:01px1pxrgba(0, 0, 0, 0.04);}
    .divEmptyColumn
    {
        float: left;
        border: 0;
        margin-top: 10px;
        width: 10px;
    }
    .divColumn
    {
        float: left;
        border-left: 1px solid #d2d2d2;
        margin-top: 10px;
    }
    .divColumn a
    {
        display: block;
        position: relative;
        padding: 0 14px;
        height: 26px;
        line-height: 26px;
        font-size: 11px;
        font-weight: bold;
        color: #666;
        text-decoration: none;
        text-shadow: 0 1px white;
        background: #fafafa;
        background-image: -webkit-linear-gradient(top, #fcfcfc, #f0f0f0);
        background-image: -moz-linear-gradient(top, #fcfcfc, #f0f0f0);
        background-image: -o-linear-gradient(top, #fcfcfc, #f0f0f0);
        background-image: linear-gradient(to bottom, #fcfcfc, #f0f0f0);
        -webkit-box-shadow: inset 0 0 0 1px #fafafa;
        box-shadow: inset 0 0 0 1px #fafafa;
    }
    .divColumn a:hover
    {
        color: #333;
        z-index: 2;
        -webkit-box-shadow: inset 0 0 0 1px #fafafa, 0 0 3px rgba(0, 0, 0, 0.3);
        box-shadow: inset 0 0 0 1px #fafafa, 0 0 3px rgba(0, 0, 0, 0.3);
        text-decoration: none;
        cursor: default;
    }
    .badge
    {
        display: block;
        position: absolute;
        top: -12px;
        right: 3px;
        line-height: 16px;
        height: 16px;
        padding: 0 5px;
        font-family: Arial, sans-serif;
        color: white;
        text-shadow: 0 1px rgba(0, 0, 0, 0.25);
        border: 1px solid;
        border-radius: 10px;
        -webkit-box-shadow: inset 0 1px rgba(255, 255, 255, 0.3), 0 1px 1px rgba(0, 0, 0, 0.08);
        box-shadow: inset 0 1px rgba(255, 255, 255, 0.3), 0 1px 1px rgba(0, 0, 0, 0.08);
    }
    .badge
    {
        background: #4887a7;
        border-color: #336077;
        background-image: -webkit-linear-gradient(top, #acddf6, #67c1ef);
        background-image: -moz-linear-gradient(top, #acddf6, #67c1ef);
        background-image: -o-linear-gradient(top, #acddf6, #67c1ef);
        background-image: linear-gradient(to bottom, #acddf6, #67c1ef);
    }
    .printIcons 
    {
        cursor: pointer!important;
    font-size: 0!important;
    width: 13px;
        background: url("../Images/printer.gif") no-repeat center top!important;
    height: 16px;
    }
    .Txtboxmicro
    {
        width:30px;
    }
</style>
<%--<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

<script src="../Scripts/Common.js" type="text/javascript"></script>

<script src="../Scripts/bid.js" type="text/javascript"></script>
--%>
<%--<script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>--%>

<script type="text/javascript" language="javascript">
    $(function() {
        try {
            ChangeDDLItemListWidth();
            onSampleStatusChange(document.getElementById('divReason'), document.getElementById('divOutsource'), document.getElementById('ddlReason'), document.getElementById('ddlOutsource'), document.getElementById('ddlStatus'));
            onShowContainerCount();
        }
        catch (e) {
        }
    });
</script>

<table class="dataheaderInvCtrl w-100p searchPanel" cellpadding="3" id="CltSample">
    <tr class="h-17" style="font-weight: lighter; color: Gray;">
        <th class="w-25p">
            <asp:Label runat="server" ID="lblAddInvestigations" Text="Investigations" meta:resourcekey="lblAddInvestigationsResource1" />
        </th>
        <th class="w-10p">
            <asp:Label runat="server" ID="lblAddSamples" Text="Samples" meta:resourcekey="lblAddSamplesResource1" />
        </th>
        <th class="w-10p">
            <asp:Label runat="server" ID="lblAddAdditive" Text="Additive-Container" meta:resourcekey="lblAddAdditiveResource1" />
        </th>
        <th id="thAddBarcode" runat="server">
            <asp:Label runat="server" ID="lblAddBarcode" Text="Barcode / Label" meta:resourcekey="lblAddBarcodeResource1" />
        </th>
        <th class="w-10p">
            <asp:Label runat="server" ID="lblAddStatus" Text="Status" meta:resourcekey="lblAddStatusResource1" />
        </th>
       <%-- <th class="w-10p">
            <asp:Label runat="server" ID="Label5" Text="Status" meta:resourcekey="lblAddStatusResource1" />
        </th>--%>
         <th class="w-10p" id="thAddbarcodecount" runat="server">
                <asp:Label runat="server" ID="lblAddBarcodecount" Text="Count" meta:resourcekey="lblbarcodecountResource1" />
                </th>
        <th class="w-10p" id="thAddExternalBarcode" runat="server">
            <asp:Label runat="server" ID="lblAddExternalBarcode" Text="External Barcode" />
        </th>
        <th class="w-12p">
            <asp:Label runat="server" ID="lblAddReason" Text="Reason / Outsource" meta:resourcekey="lblAddReasonResource1" />
        </th>
        <th class="w-10p">
            <asp:Label runat="server" ID="lblAddLocation" Text="Location" meta:resourcekey="lblAddLocationResource1" />
        </th>
        <th class="w-12p">
            <asp:Label runat="server" ID="lblAddCollectedTime" Text="Collected Time" meta:resourcekey="lblAddCollectedTimeResource1" />
        </th>
        <th class="w-15p">
            <asp:Label runat="server" ID="lblAdditionalSamples" Text="Extra Samples" meta:resourcekey="lblAdditionalSamplesResource1" />
        </th>
        <th>
            <asp:Label runat="server" ID="lblAddAction" Text="Action" meta:resourcekey="lblAddActionResource1" />
        </th>
        <th class="w-5p" style="display: none;">
            <asp:Label runat="server" ID="lblAddvolume" Text="volume" meta:resourcekey="lblAddvolumeResource1" />
        </th>
        <th class="w-5p" style="display: none;">
            <asp:Label runat="server" ID="Label4" Text="Units" meta:resourcekey="Label4Resource1" />
        </th>
        <th class="w-7p" style="display: none;">
            <asp:Label runat="server" ID="lblAddcondition" Text="condition" meta:resourcekey="lblAddconditionResource1" />
        </th>
    </tr>
    <tr class="v-top">
        <td class="a-left">
            <asp:DataList ID="dlInvName" runat="server" Width="100%" BorderWidth="1px" BorderColor="White"
                CellPadding="1" RepeatColumns="1" ItemStyle-Wrap="false" meta:resourcekey="dlInvNameResource1">
                <ItemStyle Wrap="False" BorderWidth="1px" BorderColor="White"></ItemStyle>
                <ItemTemplate>
                    <input type="checkbox" value='<%# DataBinder.Eval(Container.DataItem, "InvestigationID") %>'
                        id="chkBox" runat="server" />&nbsp; &nbsp;<asp:Label runat="server" ID="lblInvName"
                            Text='<%# DataBinder.Eval(Container.DataItem, "InvestigationName") %>' meta:resourcekey="lblInvNameResource1"></asp:Label>
                    <asp:Label runat="server" ID="lblPackageName" Text='<%# DataBinder.Eval(Container.DataItem, "PackageName")!=null && DataBinder.Eval(Container.DataItem, "PackageName").ToString()!=""?" (" + DataBinder.Eval(Container.DataItem, "PackageName")+")":"" %>'
                        meta:resourcekey="lblInvNameResource1"></asp:Label>
                    <asp:HiddenField ID="hdnTestType" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "Type") %>' />
                    <asp:Label runat="server" Visible="False" ID="lblType" Text='<%# DataBinder.Eval(Container.DataItem, "Type") %>'
                        meta:resourcekey="lblTypeResource1"></asp:Label>
                    <asp:Label runat="server" Visible="False" ID="lblName" Text='<%# DataBinder.Eval(Container.DataItem, "InvestigationName") %>' meta:resourcekey="lblNameResource1"></asp:Label>
                    <input id="hdnExtraSampleInvID" type="hidden" runat="server" value='<%# DataBinder.Eval(Container.DataItem, "InvestigationID") %>' />
                </ItemTemplate>
            </asp:DataList>
        </td>
        <td>
            <span class="richcombobox">
                <asp:DropDownList CssClass="ddlsmall" Width="90%"  ID="ddlAddSampleName" runat="server"
                    ToolTip="Select Sample" meta:resourcekey="ddlSampleNameResource1">
                </asp:DropDownList>
            </span>
        </td>
        <td>
            <span class="richcombobox">
                <asp:DropDownList CssClass="ddlsmall" Width="90%" ID="ddlAddAdditive" runat="server"
                    ToolTip="Select Additive" meta:resourcekey="ddlAdditiveResource1">
                </asp:DropDownList>
            </span>
        </td>
        <td class="a-center" id="tdAddBarcode" runat="server">
            <asp:TextBox CssClass="Txtboxsmall" ID="txtAddBarCode" ToolTip="Barcode"
                runat="server" meta:resourcekey="txtBarCodeResource1"></asp:TextBox>
        </td>
        <td class="a-center">
            <span class="richcombobox">
                <asp:DropDownList CssClass="ddl" ID="ddlAddStatus" runat="server" ToolTip="Select Sample Status"
                     meta:resourcekey="ddlStatusResource1">
                </asp:DropDownList>
            </span>
        </td>
          <td class="a-center" id="tdAddBarcodeCount" runat="server">
            <span class="richcombobox">
               <asp:TextBox CssClass="Txtboxmicro" ID="TxtAddBarcodeCount" onkeypress="return ValidateOnlyNumeric(this);" onblur="validatePercentageKeyup(this.id);" Text="1"
                runat="server" meta:resourcekey="TxtBarcodeCountResource1"></asp:TextBox>
            </span>
        </td>
        <td class="a-center" id="tdAddExternalBarcode" runat="server">
            <asp:TextBox CssClass="Txtboxsmall" ID="txtAddExternalBarcode" ToolTip="External Barcode" runat="server">
            </asp:TextBox>
        </td>
        <td class="a-center">
            <div id="divAddReason" runat="server" style="display: none;">
                <span class="richcombobox">
                    <asp:DropDownList CssClass="ddlsmall" ID="ddlAddReason" runat="server" ToolTip="Select Reason"
                        meta:resourcekey="ddlReasonResource1">
                    </asp:DropDownList>
                </span>
            </div>
            <div id="divAddOutsource" runat="server" style="display: none;">
                <span class="richcombobox">
                    <asp:DropDownList CssClass="ddlsmall" ID="ddlAddOutsource" runat="server"
                        ToolTip="Select Outsource">
                    </asp:DropDownList>
                </span>
            </div>
        </td>
        <td class="a-center">
            <span class="richcombobox">
                <asp:DropDownList CssClass="ddlsmall" ID="ddlAddLocation" runat="server"
                    ToolTip="Select Location" meta:resourcekey="ddlLocationResource1">
                </asp:DropDownList>
            </span>
        </td>
        <td class="a-left">
            <DatePicker:DatePicker ID="DatePicker1" runat="server" />
            <%--<asp:TextBox CssClass="Txtboxsmall" runat="server" Width="120px" ID="txtAddCollectedDate"
                ToolTip="dd-MM-yyyy hh:mm:ssAM/PM" MaxLength="25" size="10"></asp:TextBox><a href="javascript:NewCssCal('<% = txtAddCollectedDate.ClientID %>','ddmmyyyy','arrow',true,12,'Y','Y')">&nbsp;<img
                    src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>--%>
        </td>
        <td class="a-center">
            <asp:CheckBox ID="chkAddSample" Text="Extra Samples" runat="server" meta:resourcekey="chkAddSampleResource1" />
        </td>
        <td class="a-center">
            <asp:Button ID="btnAdd" runat="server" Style="cursor: pointer;" ToolTip="Click here to Add Sample"
                OnClientClick="return CollectSamplePageAddSample();" Text="Add" CssClass="btn"
                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" meta:resourcekey="btnAddResource1" />
        </td>
        <td class="a-center" style="display: none;">
            <asp:TextBox CssClass="Txtboxsmall" runat="server" Width="40px" ID="txtAddVolume"
                ToolTip="Enter Sample volume" MaxLength="25" size="10" meta:resourcekey="txtAddVolumeResource1"></asp:TextBox>
        </td>
        <td style="display: none;">
            <span class="richcombobox w-50">
                <select id="ddlAddvolumeUnits" class="ddl" style="width: 50px;" runat="server" title="Select volume Units">
                </select>
            </span>
        </td>
        <td class="a-center" style="display: none;">
            <span class="richcombobox" style="width: 120px;">
                <asp:DropDownList CssClass="ddl" ID="ddlAddShippingCondition" Width="120px" runat="server"
                    ToolTip="Select Shipping Condition" meta:resourcekey="ddlAddShippingConditionResource1">
                </asp:DropDownList>
            </span>
        </td>
    </tr>
</table>
<div class="divTable">
    <div id="divContainerCountRow" class="divRow" runat="server">
    </div>
</div>
<asp:Panel runat="server" class="w-100p" ID="pnlSamples" Style="display: none;" meta:resourcekey="pnlSamplesResource1">
    <div class="dataheaderInvCtrl">
        <table id="tblCollectSample" class="searchPanel" cellpadding="3">
            <tr class="Duecolor h-17">
                <th class="w-25p">
                    <asp:Label runat="server" ID="lblInvestigations" Text="Investigations" meta:resourcekey="lblInvestigationsResource1" />
                </th>
                <th class="w-10p">
                    <asp:Label runat="server" ID="lblSamples" Text="Samples" meta:resourcekey="lblSamplesResource1" />
                </th>
                <th class="w-10p">
                    <asp:Label runat="server" ID="lblAdditive" Text="Additive-Container" meta:resourcekey="lblAdditiveResource1" />
                </th>
                <th id="thBarcode" runat="server">
                    <asp:Label runat="server" ID="lblBarcode" Text="Barcode / Label" meta:resourcekey="lblBarcodeResource1" />
                </th>
                <th class="w-10p">
                    <asp:Label runat="server" ID="lblStatus" Text="Status" meta:resourcekey="lblStatusResource1" />
                </th>
                <th class="w-10p" id="thlblbarcodecount" runat="server">
                <asp:Label runat="server" ID="lblbarcodecount" Text="Count" meta:resourcekey="lblbarcodecountResource1" />
                </th>
                <th class="w-10p" id="thlblExternalBarcode" runat="server">
                    <asp:Label runat="server" ID="lblExternalBarcode" Text="External Barcode" />
                </th>
                <th class="w-12p">
                    <asp:Label runat="server" ID="lblReason" Text="Reason / Outsource" meta:resourcekey="lblReasonResource1" />
                </th>
                <th class="w-10p">
                    <asp:Label runat="server" ID="lblLocation" Text="Location" meta:resourcekey="lblLocationResource1" />
                </th>
                <th class="w-12p">
                    <asp:Label runat="server" ID="lblCollectedTime" Text="Collected Time" meta:resourcekey="lblCollectedTimeResource1" />
                </th>
                <th class="a-center">
                    <asp:Label runat="server" ID="lblAction" Text="Action" meta:resourcekey="lblActionResource1" />
                </th>
            </tr>
            <asp:Repeater ID="rptSamples" runat="server" OnItemDataBound="rptSamples_ItemDataBound">
                <ItemTemplate>
                    <tr class="h-17">
                        <td class="a-left">
                            <asp:Label runat="server" ID="lblInvName" Text='<%# Bind("InvestigtionName") %>' meta:resourcekey="lblInvNameResource2"></asp:Label>
                            <input id="hdnInvestigationID" type="hidden" runat="server" value='<%# Bind("InvestigationID") %>' />
                            <input id="hdnIsTimed" type="hidden" runat="server" value='<%# Bind("IsTimed") %>' />
                        </td>
                        <td class="a-left">
                            <asp:Label ID="lblSampleName" runat="server" Text='<%# Bind("SampleDesc") %>' meta:resourcekey="lblSampleNameResource1"> </asp:Label>
                            <input id="hdnSampleCode" type="hidden" runat="server" value='<%# Bind("sampleCode") %>' />
                            <input id="hdnIsAlicotedSample" type="hidden" runat="server" value='<%# Bind("IsAlicotedSample") %>' />
                            <input id="hdnIsOutsourcingSample" type="hidden" runat="server" value='<%# Bind("IsOutsourcingSample") %>' />
                            <input id="hdnOldSampleID" type="hidden" runat="server" value='<%# Bind("SampleID") %>' />&nbsp;
                            <input type="button" value="Samples" id="lnkShow" runat="server" style="background-color: Transparent;
                                color: Blue; border-style: none; text-decoration: underline; cursor: pointer;
                                font-size: 11px;" title="Click here to See Extra Samples" />
                            <button id="btnSampleNameChange" runat="server"  type="button" style="background-color: Transparent;
                                color: Green; border-style: none; text-decoration: underline; cursor: pointer;
                                font-size: 11px;" align="right" onclick="onSampleNameChange(this);"  meta:resourcekey="btnSampleNameChangeResource1"><%=Resources.CommonControls_ClientDisplay.CommonControls_CollectSample_ascx_03%></button>
                        </td>
                        <td class="a-left">
                            <asp:Label ID="lblContainerName" runat="server" Text='<%# Bind("SampleContainerName") %>' meta:resourcekey="lblContainerNameResource1"> </asp:Label>
                            <input id="hdnContainerID" type="hidden" runat="server" value='<%# Bind("sampleContainerID") %>' />
                            <button id="btnContainerNameChange" runat="server"  type="button" style="background-color: Transparent;
                                color: Green; border-style: none; text-decoration: underline; cursor: pointer;
                                font-size: 11px;" align="right" onclick="onContainerNameChange(this);"  meta:resourcekey="btnContainerNameChangeResource1"><%=Resources.CommonControls_ClientDisplay.CommonControls_CollectSample_ascx_04%></button> 
                        </td>
                        <td class="a-center" id="tdBarcode" runat="server">
                            <asp:TextBox Text='<%# Bind("BarcodeNumber") %>' CssClass="Txtboxsmall" Width="100px"
                                runat="server" ID="txtBarcode" ToolTip="Enter Barcode / Label" meta:resourcekey="txtBarcodeLableResource1" />
                        </td>
                        <td class="a-center">
                            <span class="richcombobox w-80">
                                <select id="ddlStatus" runat="server" title="Select Sample Status" class="ddl" style="width: 80px;">
                                </select>
                            </span>
                        </td>
                         <td class="a-center" id="tdBarcodeCount" runat="server">
                               <span class="richcombobox">
                  <asp:TextBox CssClass="Txtboxmicro" ID="TxtBarcodeCount" onkeypress="return ValidateOnlyNumeric(this);" onblur="validatePercentageKeyup(this.id);" Text="1"
                runat="server" meta:resourcekey="TxtBarcodeCountResource1"></asp:TextBox>
                          </span>
                       </td>
                        <td class="a-center" id="tdExternalBarcode" runat="server">
                            <asp:TextBox Text='<%# Bind("ExternalBarcode") %>'  CssClass="Txtboxsmall" Width="100px" runat="server" ID="txtExternalBarcode"
                                ToolTip="Enter External Barcode" Enabled="false"/>
                        </td>
                        <td class="a-center">
                            <div id="divReason" runat="server" style="display: none;">
                                <span class="richcombobox" style="width: 120px;">
                                    <select id="ddlReason" class="ddl" runat="server" style="width: 120px;" title="Select Reason">
                                    </select>
                                </span>
                            </div>
                            <div id="divOutsource" runat="server" style="display: none;">
                                <span class="richcombobox" style="width: 120px;">
                                    <select id="ddlOutsource" class="ddl" style="width: 120px;" runat="server" title="Select Outsource Location">
                                    </select>
                                </span>
                            </div>
                        </td>
                        <td class="a-center">
                            <span class="richcombobox" style="width: 130px;">
                                <select id="ddlLocation" class="ddl" style="width: 130px;" runat="server" title="Select Location">
                                </select>
                            </span>
                        </td>
                        <td class="a-left" width="116px">
                            <%--   <asp:TextBox runat="server" ID="txtCollectedDate" CssClass="Txtboxsmall" Width="116px"
                                Text='<%# Bind("CollectedDateTime", "{0:dd-MM-yyyy hh:mm:sstt}") %>' MaxLength="25"
                                size="10" ToolTip="dd-MM-yyyy hh:mm:ssAM/PM"></asp:TextBox>
                            <a id="Anchor" runat="server">&nbsp;<img src="../Images/Calendar_scheduleHS.png"
                                width="16" height="16" border="0" alt="Pick a date" /></a>--%>
                            <DatePicker:DatePicker ID="DatePicker2" runat="server" />
                        </td>
                        <td class="a-center">
                            <input id="btnDeleteSample" runat="server" value="Delete" type="button" style="background-color: Transparent;
                                color: Blue; border-style: none; text-decoration: underline; cursor: pointer;
                                font-size: 11px;" onclick="onSampleDelete(this);" meta:resourcekey="btnDeleteSampleResource1" class="deleteIcons"  />&nbsp;
                            <input id="btnPrintBarcode" runat="server" value="Print" type="button" style="background-color: Transparent;
                                color: Blue; border-style: none; text-decoration: underline; cursor: pointer;
                                font-size: 11px;" onclick="onPrintBarcode(this);" class="printIcons" meta:resourcekey="btnPrintBarcodeResource1"  />
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
<div id="ShowInstruction" runat="server" style="display:none"></div>
    </div>
    <table class="w-100p">
        <tr>
            <td class="h-15 a-left" style="color: #000;">
                <div id="ACXplusChildSamples" style="display: block;">
                    <img src="../Images/bullet_arrow.gif" alt="Show" width="15" height="15" align="top"
                        style="cursor: pointer" onclick="showResponses('ACXplusChildSamples','ACXminuslChildSamples','ctlCollectSample_pnlChildSamples',1);" />
                    <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACXplusChildSamples','ACXminuslChildSamples','ctlCollectSample_pnlChildSamples',1);">
                        &nbsp;<%=Resources.CommonControls_ClientDisplay.CommonControls_CollectSample_ascx_01 %></span>
                </div>
                <div id="ACXminuslChildSamples" style="display: none;">
                    <img src="../Images/bullet_arrow_Left.gif" alt="hide" width="15px" height="15px"
                        align="top" style="cursor: pointer" onclick="showResponses('ACXplusChildSamples','ACXminuslChildSamples','ctlCollectSample_pnlChildSamples',0);" />
                    <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACXplusChildSamples','ACXminuslChildSamples','ctlCollectSample_pnlChildSamples',0);">
                    &nbsp;<%=Resources.CommonControls_ClientDisplay.CommonControls_CollectSample_ascx_01 %></span>
                </div>
            </td>
        </tr>
    </table>
    <asp:Panel runat="server" class="w-100p a-left" ID="pnlChildSamples" Style="display: none;"  meta:resourcekey="pnlChildSamplesResource1">
        <div class="dataheaderInvCtrl">
            <table id="tblChildCollectSample" class="w-50p searchPanel" cellpadding="3">
                <tr class="Duecolor h-17">
                    <th class="w-10p">
                        <asp:Label runat="server" ID="Label1" Text="Samples" meta:resourcekey="lblSamplesResource1" />
                    </th>
                    <th class="w-10p">
                        <asp:Label runat="server" ID="Label2" Text="Additive-Container" meta:resourcekey="lblAdditiveResource1" />
                    </th>
                    <th class="w-5p">
                        <asp:Label runat="server" ID="Label11" Text="Volume" meta:resourcekey="Label11Resource1" />
                    </th>
                    <th class="w-5p">
                        <asp:Label runat="server" ID="Label3" Text="Units" meta:resourcekey="Label3Resource1" />
                    </th>
                    <th class="w-7p">
                        <asp:Label runat="server" ID="Label12" Text="Condition" meta:resourcekey="Label12Resource1" />
                    </th>
                </tr>
                <asp:Repeater ID="rptChildSamples" runat="server" OnItemDataBound="rptChildSamples_ItemDataBound">
                    <ItemTemplate>
                        <tr class="h-17">
                            <td class="a-left">
                                <asp:Label ID="lblSampleName" runat="server" Text='<%# Bind("SampleDesc") %>' meta:resourcekey="lblSampleNameResource2"> </asp:Label>
                                <input id="hdnSampleCode" type="hidden" runat="server" value='<%# Bind("sampleCode") %>' />
                            </td>
                            <td class="a-left">
                                <asp:Label ID="lblContainerName" runat="server" Text='<%# Bind("SampleContainerName") %>' meta:resourcekey="lblContainerNameResource2"> </asp:Label>
                                <input id="hdnContainerID" type="hidden" runat="server" value='<%# Bind("sampleContainerID") %>' />
                                <input id="hdnInvestigationID" type="hidden" runat="server" value='<%# Bind("InvestigationID") %>' />
                            </td>
                            <td class="a-left">
                                <asp:TextBox CssClass="Txtboxsmall" runat="server" Width="40px" ID="txtVolume" ToolTip="Enter Sample volume"
                                    MaxLength="25" size="10" meta:resourcekey="txtVolumeResource1"></asp:TextBox>
                            </td>
                            <td>
                                <span class="richcombobox w-50">
                                    <select id="ddlvolumeUnits" class="ddl" style="width: 50px;" runat="server" title="Select volume Units">
                                    </select>
                                </span>
                            </td>
                            <td class="a-left">
                                <span class="richcombobox" style="width: 120px;">
                                    <select id="ddlShippingCondition" class="ddl" style="width: 120px;" runat="server"
                                        title="Select Shipping Condition">
                                    </select>
                                </span>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
        </div>
    </asp:Panel>
</asp:Panel>
<asp:Label ID="lblTotalContainerCount" Text="Total Container" runat="server" Style="display: none;" meta:resourcekey="lblTotalContainerCountResource1"/>
<input id="hdnIsBarcodeNeeded" type="hidden" runat="server" value="false" />
<input id="hdnIsSrsNeeded" type="hidden" runat="server" value="false" />
<input id="hdnLstSampleStatus" runat="server" type="hidden" />
<input id="hdnLstReceiveLoc" runat="server" type="hidden" />
<input id="hdnLstOutSourceLoc" runat="server" type="hidden" />
<input id="hdnLstRejectReason" runat="server" type="hidden" />
<input id="hdnShippingCondition" runat="server" type="hidden" />
<input id="hdnvolumeUnits" runat="server" type="hidden" />
<input id="hdnContainerCount" runat="server" type="hidden" />
<input id="hdnDefault" runat="server" type="hidden" value="Y" />
<input id="hdntxtCollectedDateTime" runat="server" type="hidden" />
<input id="hdnOldhdnContainerID" runat="server" type="hidden" />
<input id="hdnDropDownStatus" runat="server" type="hidden" value="N" />
<input id="hdnSampleForLocation" runat="server" type="hidden" value="N" />
<input id="hdnContainerForLocation" runat="server" type="hidden" value="N" />
<input id="hdnBarcodeForExtraSample" runat="server" type="hidden" />
<input id="hdnLabNoBarcode" runat="server" type="hidden" />
<asp:HiddenField  id="hdnIsProsLoc" runat="server" Value ="N" />
<asp:HiddenField ID ="hdnBarcodewithSuffix" runat ="server" /> 
<input id="hdnIsExternalBarcode" runat="server" type="hidden" value="N" /> 
<input id="hdnBarCodeEdit" runat="server" type="hidden" value="N" />
<input id="hdnIsEmptyBarcode" runat="server" type="hidden" value="N" /> 
<input id="hdnIsShowStatus" runat="server" type="hidden" value="N" />

<input id="hdnIsNeedBarcodeCount" runat="server" type="hidden" value="N" />
<input id="hdnAddSampleStatuschange" runat="server" type="hidden" value="N" /> 
<%--<input id="hdnDefault" runat="server" value="N" type="hidden" />
--%>
<asp:UpdatePanel ID="updatePanel1" runat="server">
    <ContentTemplate>
        <table class="w-100p">
            <tr>
                <td>
                    <asp:Button ID="hiddenTargetForShowItems" runat="server" Style="display: none" meta:resourcekey="hiddenTargetForShowItemsResource1" />
                    <ajc:ModalPopupExtender ID="showItemsPopup" runat="server" PopupControlID="ShowItems"
                        TargetControlID="hiddenTargetForShowItems" BackgroundCssClass="modalBackground"
                        BehaviorID="popupPO" CancelControlID="btnCnl">
                    </ajc:ModalPopupExtender>
                    <asp:Panel runat="server" ID="ShowItems" ScrollBars="Both" CssClass="modalPopup dataheaderPopup"
                        Width="80%" Style="display: none; top: 400px; height: 500px" meta:resourcekey="ShowItemsResource2">
                        <table class="w-100p">
                            <tr>
                                <td>
                                    <table id="tblSampleAttributes" border="1" cellpadding="1" class="dataheaderInvCtrl a-left font11 w-100p">
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-center v-bottom">
                                    <asp:Button ID="btnCnl" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" meta:resourcekey="btnCnlResource1" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>
<asp:UpdatePanel ID="updatePaneContainer" runat="server">
    <ContentTemplate>
        <table class="w-100p">
            <tr>
                <td>
                    <asp:Button ID="hiddenTargetContainer" runat="server" Style="display: none" meta:resourcekey="hiddenTargetContainerResource1" />
                    <ajc:ModalPopupExtender ID="ModalPopupExtenderContainer" runat="server" PopupControlID="PanelContainer"
                        TargetControlID="hiddenTargetContainer" BackgroundCssClass="modalBackground"
                        BehaviorID="popupExtenderContainer" CancelControlID="bdnContainerClose">
                    </ajc:ModalPopupExtender>
                    <asp:Panel runat="server" ID="PanelContainer" ScrollBars="None" CssClass="modalPopup dataheaderPopup"
                        Width="30%" Style="display: none; top: 40px; height: 70px" meta:resourcekey="PanelContainerResource1">
                        <table class="w-100p" border="1" cellpadding="1" cellspacing="5">
                            <tr>
                                <td class="w-80p">
                                    <span class="richcombobox" style="width: 340px;">
                                        <asp:DropDownList CssClass="ddl" ID="ddlDynamicSampleContainer" Width="320px" runat="server"
                                            ToolTip="Select Additive" meta:resourcekey="ddlDynamicSampleContainerResource1">
                                        </asp:DropDownList>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-center v-bottom">
                                    <asp:Button ID="bdnContainerUpdate" runat="server" Text="Update" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClientClick="javascript:return OnContainerUpdate();" meta:resourcekey="bdnContainerUpdateResource1"/>
                                    &nbsp;&nbsp;&nbsp;
                                    <asp:Button ID="bdnContainerClose" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" meta:resourcekey="bdnContainerCloseResource1"/>
                                </td>
                                <asp:HiddenField runat="server" ID="hdnSampleRowID" Value="" />
                                <asp:HiddenField runat="server" ID="hdnSampleCode1" Value="" />
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>
<asp:UpdatePanel ID="updatePanelSample" runat="server">
    <ContentTemplate>
        <table class="w-100p">
            <tr>
                <td>
                    <asp:Button ID="hiddenTargetSample" runat="server" Style="display: none" meta:resourcekey="hiddenTargetSampleResource1" />
                    <ajc:ModalPopupExtender ID="ModalPopupExtenderSample" runat="server" PopupControlID="PanelSample"
                        TargetControlID="hiddenTargetSample" BackgroundCssClass="modalBackground" BehaviorID="popupExtenderSample"
                        CancelControlID="bdnSampleClose">
                    </ajc:ModalPopupExtender>
                    <asp:Panel runat="server" ID="PanelSample" ScrollBars="None" CssClass="modalPopup dataheaderPopup"
                        Width="30%" Style="display: none; top: 40px; height: 70px" meta:resourcekey="PanelSampleResource1">
                        <table class="w-100p" border="1" cellpadding="1" cellspacing="5">
                            <tr>
                                <td class="w-80p">
                                    <span class="richcombobox" style="width: 340px;">
                                        <asp:DropDownList CssClass="ddl" ID="ddlDynamicSample" Width="320px" runat="server"
                                            ToolTip="Select Sample Type" meta:resourcekey="ddlDynamicSampleResource1">
                                        </asp:DropDownList>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td class="v-bottom a-center">
                                    <asp:Button ID="bdnSampleUpdate" runat="server" Text="Update" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClientClick="javascript:return OnSampleUpdate();" meta:resourcekey="bdnSampleUpdateResource1"/>
                                    &nbsp;&nbsp;&nbsp;
                                    <asp:Button ID="bdnSampleClose" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" meta:resourcekey="bdnSampleCloseResource1" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>

