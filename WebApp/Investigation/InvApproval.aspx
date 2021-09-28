<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvApproval.aspx.cs" Inherits="Investigation_InvApproval"
    EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
<%@ Register Src="../CommonControls/ViewTRFImage.ascx" TagName="ViewTRFImage" TagPrefix="TRF" %>
<%@ Register Src="CultureandSensitivityReportV2.ascx" TagName="CultureandSensitivityReportV2"
    TagPrefix="ucCulturev2" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Investigation Approval</title>
    <style type="text/css">
        .hide_column
        {
            display: none;
        }
        .ui-dialog
        {
            position: absolute;
            padding: .2em;
            width: 300px;
            overflow: hidden;
        }
        .ui-dialog .ui-dialog-titlebar
        {
            padding: .4em 1em;
            position: relative;
        }
        .ui-dialog .ui-dialog-title
        {
            float: left;
            margin: .1em 16px .1em 0;
        }
        .ui-dialog .ui-dialog-titlebar-close
        {
            position: absolute;
            right: .3em;
            top: 22%!important;
            width: 19px;
            margin: -10px 0 0 0;
            padding: 1px;
            height: 18px;
        }
        .ui-dialog .ui-dialog-titlebar-close span
        {
            display: block;
            margin: -8px;
        }
        .ui-dialog .ui-dialog-titlebar-close:hover, .ui-dialog .ui-dialog-titlebar-close:focus
        {
            padding: 0;
        }
        .ui-dialog .ui-dialog-content
        {
            position: relative;
            border: 0;
            padding: .5em 1em;
            background: none;
            overflow: auto;
        }
        .ui-dialog .ui-dialog-buttonpane
        {
            text-align: left;
            border-width: 1px 0 0 0;
            background-image: none;
            margin: .5em 0 0 0;
            padding: .3em 1em .5em .4em;
        }
        .ui-dialog .ui-dialog-buttonpane .ui-dialog-buttonset
        {
            float: right;
        }
        .ui-dialog .ui-dialog-buttonpane button
        {
            margin: .5em .4em .5em 0;
            cursor: pointer;
        }
        .ui-dialog .ui-resizable-se
        {
            width: 14px;
            height: 14px;
            right: 3px;
            bottom: 3px;
        }
        .ui-draggable .ui-dialog-titlebar
        {
            cursor: move;
        }
        .loading
        {
            font-family: Arial;
            font-size: 10pt;
            border: 5px solid #67CFF5;
            width: 150px;
            height: 70px;
            display: block;
            position: fixed;
            background-color: White;
            z-index: 1;
            text-align: center;
        }
        .modal
        {
            position: fixed;
            top: 0;
            left: 0;
            background-color: black;
            z-index: 100;
            opacity: 0.2;
            filter: alpha(opacity=80);
            -moz-opacity: 0.8;
            min-height: 100%;
            width: 100%;
        }
        .scroller_anchor
        {
            height: 0px;
            margin: 0;
            padding: 0;
        }
        .scroller
        {
            background: #CCC;
            margin: 0 0 10px;
            z-index: 100;
            text-align: center;
            width: 1330px;
            position:inherit!important;
        }
        #ViewTRF td {
        padding: 0;
    }
    </style>
</head>
<body id="Body1" oncontextmenu="return true;" runat="server" onkeydown="SuppressBrowserBackspaceRefresh();">
    <form id="form1" runat="server" enctype="multipart/form-data">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <asp:HiddenField ID="hdnAutoMedicalComments" runat="server" />
    <%--<asp:UpdatePanel runat="server">
                                    <ContentTemplate>--%>
    <div id="ViewTRF" runat="server" class="viewtrf" style="display: block; z-index: 101;">
        <TRF:ViewTRFImage ID="TRFUC" runat="server" />
    </div>
    <%-- </ContentTemplate>
                                </asp:UpdatePanel>--%>
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="scroller_anchor">
                </div>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div runat="server" id="divPatientDetails" class="scroller">
                            <ucPatientdet:PatientDetails ID="PatientDetail" runat="server" />
                            <table class="w-95p" style="display: table;" runat="server" id="CheakInv" 
                                >
                                <tr>
                                    <td class="a-left h-23">
                                        <asp:HiddenField ID="HdnInvID" runat="server" />
                                        <div id="ACX2plus21" class="dataheader2" style="display: block;">
                                            <img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top"  style="cursor: pointer"
                                                onclick="showResponses('ACX2plus21','ACX2minus21','ACX2responses211',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus21','ACX2minus21','ACX2responses211',1);">
                                                <%=Resources.Investigation_ClientDisplay.Investigation_InvApproval_aspx_01 %></span>
                                        </div>
                                        <div id="ACX2minus21" class="dataheader2" style="display: none;">
                                            <img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top" 
                                                style="cursor: pointer" onclick="showResponses('ACX2plus21','ACX2minus21','ACX2responses211',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus21','ACX2minus21','ACX2responses211',0);">
                                                &nbsp;<%=Resources.Investigation_ClientDisplay.Investigation_InvApproval_aspx_01 %></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="tablerow" id="ACX2responses211" style="display: table-row;">
                                    <td colspan="2">
                                        <div class="dataheader2">
                                            <asp:UpdatePanel ID="UpdPnl1" runat="server">
                                                <ContentTemplate>
                                                    <table id="tblOrderedInvestigaion" class="w-100p bg-row" style="display: none; ">
                                                        <tbody>
                                                        </tbody>
                                                    </table>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <div id="divSave1" runat="server">
                                <table class="defaultfontcolor">
                                    <tr>
                                        <td id="trsavecontinue" runat="server" style="display: none;">
                                            <asp:Button ID="btnSave1" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                                onmouseover="this.className='btn btnhov'" Text="Save" meta:resourcekey="btnSave1Resource1" />
                                        </td>
                                        <td id="trsaveorg" runat="server">
                                            <asp:Button ID="btnSaveToDispatch1" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                                onmouseover="this.className='btn btnhov'" Text="Save And Home" OnClientClick="javascript:return fnSave();"
                                                OnClick="btnSave_Click" meta:resourcekey="btnSaveToDispatch1Resource1" />
                                        </td>
                                        <td id="trSaveandNext" runat="server">
                                            <asp:Button ID="btsaveandnext" runat="server" CssClass="btn" OnClick="btnSave_Click"
                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Save And Next"
                                                OnClientClick="javascript:return CheckSaveAndNext();" meta:resourcekey="btsaveandnextResource1" />
                                        </td>
                                        <td id="trSkipandNext" runat="server">
                                            <asp:Button ID="btskipandnext" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                                onmouseover="this.className='btn btnhov'" Text="Skip And Next" OnClick="btnbtmskipnnext_Click" />
                                                meta:resourcekey="btskipandnextResource1" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnCancel" runat="server" CssClass="btn" OnClick="btnCancel_Click"
                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Cancel" 
                                                meta:resourcekey="btnCancelResource1" />
                                        </td>
                                        <td>
                                            <asp:ImageButton ID="Image1" ImageUrl="../Images/pdf.ico" runat="server" Style="cursor: pointer;"
                                                Height="10%" meta:resourcekey="Image1Resource1" />
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtAuto" Enabled="False" runat="server" CssClass="w-10 h-10" meta:resourcekey="txtAutoResource1"></asp:TextBox>
                                            <asp:Label ID="lblAutoColor" Text="Auto Authorization Range" runat="server" meta:resourcekey="lblAutoColorResource1"></asp:Label>
                                            <asp:TextBox ID="txtPanic" Enabled="False" runat="server" CssClass="w-10 h-10" meta:resourcekey="txtPanicResource1"></asp:TextBox>
                                            <asp:Label ID="lblPanicColor" runat="server" Text="Panic Range" meta:resourcekey="lblPanicColorResource1"></asp:Label>
                                            <asp:TextBox ID="txtReference" Enabled="False" runat="server" CssClass="w-10 h-10"
                                                meta:resourcekey="txtReferenceResource1"></asp:TextBox>
                                            <asp:Label ID="lblreferencecolor" Text="Normal Range" runat="server" meta:resourcekey="lblreferencecolorResource1"></asp:Label>
                                            <asp:TextBox ID="txtLower" Enabled="False" runat="server" CssClass="w-10 h-10" meta:resourcekey="txtLowerResource1"></asp:TextBox>
                                            <asp:Label ID="lblLower" Text="Lower Abnormal Range" runat="server" meta:resourcekey="lblLowerResource1"></asp:Label>
                                            <asp:TextBox ID="txtHigher" Enabled="False" runat="server" CssClass="w-10 h-10" meta:resourcekey="txtHigherResource1"></asp:TextBox>
                                            <asp:Label ID="lblHigher" Text="Higher Abnormal Range" runat="server" meta:resourcekey="lblHigherResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div id="divInv" style="display: none;">
                    <div>
                        <table id="tblInvestigatonResultsCapture" class="gridView" style="display: none;">
                            <thead>
                                <tr>
                                    <th>
                                        <b><%=Resources.Investigation_ClientDisplay.Investigation_InvApproval_aspx_02 %> </b>
                                    </th>
                                    <th class="w-14p">
                                        <b><%=Resources.Investigation_ClientDisplay.Investigation_InvApproval_aspx_03 %> </b>
                                    </th>
                                    <th class="w-28p">
                                        <b><%=Resources.Investigation_ClientDisplay.Investigation_InvApproval_aspx_04 %> </b>
                                    </th>
                                    <th class="w-8p">
                                        <b><%=Resources.Investigation_ClientDisplay.Investigation_InvApproval_aspx_05 %> </b>
                                    </th>
                                    <th class="w-10p">
                                        <b><%=Resources.Investigation_ClientDisplay.Investigation_InvApproval_aspx_06 %> </b>
                                    </th>
                                    <th class="w-15p">
                                        <b><%=Resources.Investigation_ClientDisplay.Investigation_InvApproval_aspx_07 %> </b>
                                    </th>
                                    <th class="w-15p">
                                        <b><%=Resources.Investigation_ClientDisplay.Investigation_InvApproval_aspx_08 %></b>
                                    </th>
                                    <th class="w-15p">
                                        <b><%=Resources.Investigation_ClientDisplay.Investigation_InvApproval_aspx_09 %> </b>
                                    </th>
                                    <th class="w-7p">
                                        <b><%=Resources.Investigation_ClientDisplay.Investigation_InvApproval_aspx_10 %> </b>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div id="divSave" runat="server">
                        <table class="defaultfontcolor">
                            <tr>
                                <td id="trbottomsavecontinue" runat="server" style="display: none;">
                                    <asp:Button ID="btnSave" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                        onmouseover="this.className='btn btnhov'" Text="Save" OnClientClick="javascript:return fnSave();"
                                        OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                </td>
                                <td id="trbottom" runat="server" class="w-40p a-right">
                                    <asp:Button ID="btnSaveToDispatch" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                        onmouseover="this.className='btn btnhov'" Text="Save And Home" OnClientClick="javascript:return fnSave();"
                                        OnClick="btnSave_Click" meta:resourcekey="btnSaveToDispatchResource1" />
                                </td>
                                <td id="btnbottomsavennext" runat="server" class="w-7p a-left">
                                    <asp:Button ID="btnbtmsavennext" runat="server" CssClass="btn" OnClick="btnSave_Click"
                                        onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Save And Next"
                                        OnClientClick="javascript:return CheckSaveAndNext();" meta:resourcekey="btnbtmsavennextResource1" />
                                </td>
                                <td id="btnbottomskipnnext" runat="server" class="w-7p a-left">
                                    <asp:Button ID="btnbtmskipnnext" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                        onmouseover="this.className='btn btnhov'" Text="Skip And Next" OnClick="btnbtmskipnnext_Click"
                                        meta:resourcekey="btnbtmskipnnextResource1" />
                                </td>
                                <td>
                                    <asp:Button ID="btnCancel1" runat="server" CssClass="btn" OnClick="btnCancel_Click"
                                        onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Cancel" 
                                        meta:resourcekey="btnCancel1Resource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="divUpdate" title="Update Value" class="bold" style="display: none;">
                        <div>
                            <div class="w-100p">
                                <div class="w-35p" style=" float: left; word-break: break-all;">
                                    <asp:Label ID="lbldivupInvName" Text="" runat="server" Style="font-weight: bold;"
									meta:resourcekey="lbldivupInvNameResource1"></asp:Label>
                                </div>
                                <div id="divupPattern1" class="w-65p" style="float: left; display: none;">
                                    <asp:TextBox ForeColor="Black" Font-Bold="True" ID="txtdivupInvValue" TextMode="MultiLine"
                                        runat="server" CssClass="small" meta:resourcekey="txtdivupInvValueResource1"></asp:TextBox>
                                </div>
                                <div id="divupPattern2" class="w-65p" style="float: left; display: none;">
                                    <asp:DropDownList ID="ddldivupPatt2Data" ForeColor="Black" runat="server" CssClass="ddlsmall"
                                        meta:resourcekey="ddldivupPatt2DataResource1">
                                        <asp:ListItem Text="Select" Value="Select" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                    </asp:DropDownList>
                                    <br>
                                        <br>
                                            <br>
                                                <br>
                                                    <br>
                                                        <br></br>
                                                        <asp:HiddenField ID="HiddenField1" runat="server" />
                                    <asp:TextBox ID="txtdivupPatt2Value" runat="server" CssClass="small" 
                                        Font-Bold="True" ForeColor="Black" 
                                        meta:resourcekey="txtdivupPatt2ValueResource1" 
                                        onkeypress="return validatenumberOnly(event,'txtdivupPatt2Value');"></asp:TextBox>
                                                            ></asp:TextBox>
                                                        <br>
                                                            <br>
                                                                <br>
                                                                    <br></br>
                                                                    <br>
                                                                        <br>
                                                                            <br></br>
                                                                            <br>
                                                                                <br>
                                                                                    <br></br>
                                                                                    <br>
                                                                                        <br></br>
                                                                                        <br>
                                                                                            <br></br>
                                                                                            <br>
                                                                                                <br></br>
                                                                                                <br>
                                                                                                    <br></br>
                                                                                                    <br></br>
                                                                                                    <br></br>
                                                                                                    <br></br>
                                                                                                    <br></br>
                                                                                                    <br></br>
                                                                                                    <br></br>
                                                                                                    <br></br>
                                                                                                    <br></br>
                                                                                                </br>
                                                                                            </br>
                                                                                        </br>
                                                                                    </br>
                                                                                </br>
                                                                            </br>
                                                                        </br>
                                                                    </br>
                                                                </br>
                                                            </br>
                                                        </br>
                                                    </br>
                                                </br>
                                            </br>
                                        </br>
                                    </br>
                                </div>
                                <div id="divupPattern3" class="w-65p" style="float: left; display: none;">
                                    <asp:DropDownList ID="ddldivupPatt3Data" ForeColor="Black" runat="server" CssClass="ddlsmall"
                                        meta:resourcekey="ddldivupPatt3DataResource1">
                                        <asp:ListItem Text="Select" Value="Select" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:HiddenField ID="hdnDDL" runat="server" />
                                </div>
                                <div id="divupFishPattern2" class="w-65p" style="float: left; display: none;">
                                    <asp:TextBox ForeColor="Black" Font-Bold="True" ID="txtdivupFishPatternCode" runat="server"
                                        CssClass="small" meta:resourcekey="txtdivupFishPatternCodeResource1"></asp:TextBox>
                                    <ajc:AutoCompleteExtender ID="acedivupFishPatternAutoComments" OnClientPopulated="onListPopulated22"
                                        MinimumPrefixLength="2" runat="server" OnClientItemSelected="setAutoComments"
                                        TargetControlID="txtdivupFishPatternCode" ServiceMethod="GetAutoComments" ServicePath="~/WebService.asmx"
                                        EnableCaching="False" CompletionInterval="1" FirstRowSelected="True" CompletionListCssClass="wordWheel listMain .box"
                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                        DelimiterCharacters=";,:" Enabled="True">
                                    </ajc:AutoCompleteExtender>
                                    <asp:TextBox ForeColor="Black" Font-Bold="True" ID="txtdivupFishPatternValue" TextMode="MultiLine"
                                       runat="server"  CssClass="small" meta:resourcekey="txtdivupFishPatternValueResource1"></asp:TextBox>
                                    <%--<ajc:AutoCompleteExtender ID="acedivupFishPatternValue" MinimumPrefixLength="2" runat="server"
                                                        TargetControlID="txtdivupFishPatternValue" ServiceMethod="GetInvBulkDataAuto"
                                                        ServicePath="~/WebService.asmx" EnableCaching="False" CompletionInterval="2"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                                        Enabled="True">
                                                    </ajc:AutoCompleteExtender>--%>
                                    <asp:HiddenField runat="server" ID="hidVal" />
                                </div>
                                <div id="divupDefault" class="w-50p" style="float: left; display: none;">
                                    <asp:TextBox ForeColor="Black" Font-Bold="True" ID="txtdivupDefaultPatternValue"
                                        TextMode="MultiLine" runat="server" CssClass="small" meta:resourcekey="txtdivupDefaultPatternValueResource1"></asp:TextBox>
                                </div>
                            </div>
                            <div id="divRefRange" class="w-100p">
                                <div class="w-35p marginT5" style=" float: left;">
                                    <asp:Label ID="lbldivupRefRange" Text="Reference Range" CssClass="bold" runat="server" 
                                        meta:resourcekey="lbldivupRefRangeResource1"></asp:Label>
                                </div>
                                <div class="w-65p marginT5" style=" float: left;">
                                    <asp:Label ID="lbldivupRefRangeItem" runat="server" meta:resourcekey="lbldivupRefRangeItemResource1"></asp:Label>
                                </div>
                            </div>
                            <div class="w-100p">
                                <div class="w-35p marginT5" style=" float: left; ">
                                    <asp:Label ID="lbldivupMedRemarks" Text="Medical Remarks" runat="server" Style="font-weight: bold"
                                        meta:resourcekey="lbldivupMedRemarksResource1"></asp:Label>
                                </div>
                                <div class="w-65p marginT5" style=" float: left; ">
                                    <asp:TextBox ForeColor="Black" Font-Bold="True" ID="txtdivupcode" runat="server"
                                        CssClass="small" meta:resourcekey="txtdivupcodeResource1"></asp:TextBox>
                                    <ajc:AutoCompleteExtender ID="acedivupMedRem" MinimumPrefixLength="1" runat="server"
                                        TargetControlID="txtdivupcode" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                                        EnableCaching="false" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                        DelimiterCharacters=";,:" Enabled="true" OnClientItemSelected="setAutoMedicalRemarks">
                                    </ajc:AutoCompleteExtender>
                                    <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtdivupMedRem"
                                        TabIndex="-1" TextMode="MultiLine" CssClass="small" meta:resourcekey="txtdivupMedRemResource1"></asp:TextBox>
                                    <asp:HiddenField ID="hdnRemarksID" runat="server" />
                                </div>
                            </div>
                            <div id="divStatus" class="w-100p" >
                                <div class="w-35p marginT5" style="float: left;">
                                    <asp:Label ID="lbldivupStatus" Text="Status" runat="server" CssClass="bold" meta:resourcekey="lbldivupStatusResource1"></asp:Label>
                                </div>
                                <div  class="w-65p marginT5" style=" float: left;">
                                    <asp:DropDownList ForeColor="Black" ID="ddldivupstatus" runat="server" TabIndex="-1"
                                        CssClass="ddlsmall" onchange="fnOpenReason();" meta:resourcekey="ddldivupstatusResource1">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div id="divReason" class="w-100p" style=" display: none;">
                                <div  class="w-35p marginT5" style=" float: left;">
                                    <asp:Label ID="lbldivupReason" Text="Reason" runat="server" CssClass="bold" meta:resourcekey="lbldivupReasonResource1"></asp:Label>
                                </div>
                                <div  class="w-65p marginT5" style="float: left; ">
                                    <asp:DropDownList ForeColor="Black" ID="ddldivupReason" runat="server" TabIndex="-1"
                                        CssClass="ddlsmall" meta:resourcekey="ddldivupReasonResource1">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%-- <div id="divCultandSensHd" style="font-weight: bold; display: none;">
                                        <div id="divCultandSens" title="Update Value">
                                        </div>
                                        <div>
                                            <asp:Button ID="btnUp" runat="server" Text="Update" OnClick="btnUpdate_Click" />
                                        </div>
                                    </div>--%>
                </div>
                <ajc:ModalPopupExtender ID="modalPopUp" runat="server" DropShadow="false" PopupControlID="pnlOthers"
                    BackgroundCssClass="modalBackground" Enabled="True" TargetControlID="btnDummy">
                </ajc:ModalPopupExtender>
                <asp:Panel ID="pnlOthers" runat="server" CssClass="v-bottom" Style="display: none; height: 600px; width: 1050px;
                    top: 80px;">
                    <table class="w-100p a-center">
                        <tr>
                            <td class="a-right" style="padding-right: 45px;">
                                <img src="../Images/CloseIcon.png" alt="Close" id="img2" onclick="ClosePopUp()" class="w-3p" style="
                                    height: 3%; cursor: pointer;" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <iframe id="ifPDF" runat="server" width="1000" height="550"></iframe>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="button" id="btnDummy" runat="server" style="display: none;" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <ajc:ModalPopupExtender ID="mpeAttributeLocation" runat="server" BackgroundCssClass="modalBackground"
                    Drag="false" DropShadow="false" PopupControlID="pnlPop" TargetControlID="btnDummy2" />
                <input id="btnDummy2" runat="server" style="display: none;" type="button" />
                <asp:Panel ID="pnlPop" runat="server" Style="display: none; max-height: 200px;" Width="400px">
                    <asp:UpdatePanel ID="selectpnl" runat="server">
                        <ContentTemplate>
                            <div id="floatdiv" runat="server" class="w-100p" style="display: block; border: 1px solid #ccc; z-index: 100">
                                <table  class="w-100p" style="background-color: #333;
                                    border-color: #000; color: #fff;">
                                    <tr  class="h-20 a-center colorforcontent">
                                        <td>
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <%=Resources.Investigation_ClientDisplay.Investigation_InvApproval_aspx_11 %>
                                                    </td>
                                                    <td class="a-right">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="padding10">
                                            <font face="arial" size="2"><%=Resources.Investigation_ClientDisplay.Investigation_InvApproval_aspx_12 %></font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-left">
                                            <div id="divscrl" runat="server" class="w-92p padding10" style="overflow: auto; max-height: 190px; ">
                                                <table class="w-90p marginL10">
                                                    <font color="yellow" face="arial" size="2">
                                                        <asp:Label ID="ltrlTestName" runat="server" meta:resourcekey="ltrlTestNameResource1"></asp:Label>
                                                    </font>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center">
                                            <font face="arial" size="2"><%=Resources.Investigation_ClientDisplay.Investigation_InvApproval_aspx_13 %></font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center">
                                            <table class="w-100p">
                                                <tr>
                                                    <td colspan="2">
                                                        <asp:Button ID="btnSaveConfirm" runat="server" CssClass="btn" OnClick="btnSave_Click"
                                                            OnClientClick="javascript:return displayProgress();" onmouseout="this.className='btn'"
                                                            onmouseover="this.className='btn btnhov'" Text="Yes" meta:resourcekey="btnSaveConfirmResource1" />
                                                            <asp:Button ID="btnCloseWarning" runat="server" CssClass="btn" OnClientClick="return HideAbnormalPopup();"
                                                            onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="No" 
                                                            meta:resourcekey="btnCloseWarningResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </asp:Panel>
                <div id="divGroupComment" runat="server" style="border-width: 1px; border-color: #000;
                    display: none; position: fixed; z-index: 2; top: 200px; right: 200px;">
                    <table  style="background-color: #333;
                        border-color: #000; color: #fff;">
                        <tr class="colorforcontent h-20">
                            <td>
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <%=Resources.Investigation_ClientDisplay.Investigation_InvApproval_aspx_14 %>
                                        </td>
                                        <td class="a-right">
                                            <img id="img3" onclick="javascript:fnCloseGrpRemarksDiv();" src="../Images/Delete.jpg"
                                                style="cursor: pointer;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblDivGrpCmtName" runat="server" ForeColor="#ffffff"></asp:Label>
                                <asp:Label ID="lblDivGrpcmtRotGrpID" runat="server" Style="display: none;"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblDivTechRem" Text="Technical Remarks:" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtDivGrpCmt" runat="server" CssClass="small" Columns="6" Rows="2"
                                    TextMode="MultiLine" meta:resourcekey="txtDivGrpCmtResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="aceDivGrpCmt" MinimumPrefixLength="1" runat="server"
                                    TargetControlID="txtDivGrpCmt" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                                    EnableCaching="False" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box"
                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarksGrpTech">
                                </ajc:AutoCompleteExtender>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblDivMedRem" Text="Medical Remarks:" runat="server" meta:resourcekey="lblDivMedRemResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtDivGrpMed" runat="server" CssClass="small" Columns="6" Rows="2"
                                    TextMode="MultiLine" meta:resourcekey="txtDivGrpMedResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="aceDivGrpMed" MinimumPrefixLength="1" runat="server"
                                    TargetControlID="txtDivGrpMed" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                                    EnableCaching="False" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box"
                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="GetInvMedicalRemarksGrpMed">
                                </ajc:AutoCompleteExtender>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-center">
                                <input id="hdnLstGrpMedRem" runat="server" type="hidden" />
                                <asp:Label ID="lblDivGrpCmtAdd" runat="server" Font-Bold="true" ForeColor="#ffffff"
                                    OnClick="javascript:fnSetGrpRemarks();" Style="cursor: pointer;" meta:resourcekey="lblDivGrpCmtAddResource1" >Add</asp:Label>
                                &nbsp;&nbsp;&nbsp;
                                <asp:Label ID="lblDivGrpCmtCancel" runat="server" Font-Bold="true" ForeColor="#ffffff"
                                    OnClick="javascript:fnCloseGrpRemarksDiv();" Style="cursor: pointer;" meta:resourcekey="lblDivGrpCmtCancelResource1">Cancel</asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
                <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <%--<asp:UpdateProgress ID="UpdateProgress4" runat="server">
                                            <ProgressTemplate>
                                               <div id="modal1" class="modal" runat="server">--%>
                        <%--<div class="loading" style="position: fixed; top: 50%; left: 50%; margin-left: -32px;
                                                        margin-top: -32px; display: block; z-index: 9999;" align="center">
                                                        Loading....<br />
                                                        <br />
                                                        <img src="../Images/loader.gif" alt="" />
                                                    </div>
                                                </div>
                                            </ProgressTemplate>--%>
                        <%--</asp:UpdateProgress>--%>
                        <ajc:ModalPopupExtender ID="mpeShowCulture" runat="server" TargetControlID="lnkShowCulture"
                            PopupControlID="pnlCulture" DropShadow="True" BackgroundCssClass="modalBackground"
                            OkControlID="btnCultureClose" CancelControlID="btnCultureClose1" DynamicServicePath=""
                            Enabled="True" />
                        <asp:Button ID="btnMClose" runat="server" Style="visibility: hidden" CssClass="btn"
                            meta:resourcekey="btnMCloseResource1" />
                        <asp:LinkButton ID="lnkShowCulture" runat="server" ForeColor="Red" meta:resourcekey="lnkResource1"
                            OnClick="ShowCulture"></asp:LinkButton>
                        <asp:Panel ID="pnlCulture" runat="server" Style="display: none; z-index: 99;" CssClass="modalPopup"
                            Width="850px" Height="529px" meta:resourcekey="ModalPanelResource1">
                            <table>
                                <tr>
                                    <td style="font-size: medium;  color: White; " class="btn w-99p bold">
                                        <div id="tdCulturename" class="w-91p a-center" runat="server" style=" border: 2px;
                                            float: left;">
                                            <%=Resources.Investigation_ClientDisplay.Investigation_InvApproval_aspx_15 %>
                                        </div>
                                        <div  class="w-9p" style=" border: 2px; float: left;">
                                            <input type="button" value="Close" id="btnCultureClose1" class="btn" />
                                        </div>
                                    </td>
                                </tr>
                                <tr class="a-center">
                                    <td class="a-left">
                                        <asp:Panel ID="pnlUCCulture" runat="server" Height="500px" Width="850px" ScrollBars="Both"
                                            meta:resourcekey="pnlUCCultureResource1">
                                            <ucCulturev2:CultureandSensitivityReportV2 ID="ucCultureandSensitivityReportV2" runat="server" />
                                            <%--<asp:Button ID="OKButton" runat="server" Text="Close" CssClass="btn" meta:resourcekey="OKButtonResource1" />--%>
                                            <input type="button" value="Close" id="btnCultureClose" class="btn" />
                                            <asp:Button ID="btnCultureUpdate" runat="server" CssClass="btn" Text="Update" OnClientClick="CallingSaveCultureSensitiveV2();"
                                                OnClick="GetCultureResult" meta:resourcekey="btnCultureUpdateResource1" />
                                        </asp:Panel>
                                        <%--<input type="button" value="Update" id="btnCultureUpdate" class="btn" onclick="GetCultureResult" />--%>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </ContentTemplate>
                    <Triggers>
                        <%--<asp:AsyncPostBackTrigger ControlID="btnCultureUpdate" EventName="Click" />--%>
                        <%--<asp:PostBackTrigger ControlID="btnCultureUpdate" />--%>
                    </Triggers>
                </asp:UpdatePanel>
            </ContentTemplate>
        </asp:UpdatePanel>
        <%--<asp:UpdateProgress DynamicLayout="true" ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <div id="modal2" class="modal" runat="server">
                                    <div class="loading" style="position: absolute; top: 300px; left: 550px; display: block;
                                        z-index: 9999;" align="center">
                                        Loading.............<br />
                                        <br />
                                        <img src="../Images/loader.gif" alt="" />
                                    </div>
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>--%>
        <asp:HiddenField ID="hdnOrgID" runat="server" />
        <asp:HiddenField ID="hdnRoleID" runat="server" />
        <input id="hdnVID" runat="server" type="hidden" value="0" />
        <input id="hdnGuid" runat="server" type="hidden" value="0" />
        <asp:HiddenField ID="hdnValidationRule" runat="server" Value="" />
        <asp:HiddenField ID="hdnIsExcludeAutoApproval" runat="server" Value="" />
        <asp:HiddenField ID="hdnStatus" runat="server" Value="" />
        <asp:HiddenField ID="hdnDisplayStatus" runat="server" Value="" />
        <asp:HiddenField ID="hdnLstPatientInvestigation" runat="server" Value="" />
        <asp:HiddenField ID="hdnLstInvestigationValues" runat="server" Value="" />
        <asp:HiddenField ID="hdnSaveToDispatch" runat="server" Value="0" />
        <asp:HiddenField ID="hdnSaveandNext" runat="server" Value="N" />
        <asp:HiddenField ID="hdnLstStatus" runat="server" />
        <asp:HiddenField ID="hdnLstreasons" runat="server" />
        <asp:HiddenField ID="hdnLstGrpRem" runat="server" />
        <asp:HiddenField ID="hdnValidationText" runat="server" Value="" />
        <asp:HiddenField ID="hdnPatientGender" runat="server" Value="" />
        <asp:HiddenField ID="hdnpagearraw" runat="server" />
        <asp:HiddenField ID="hdnPatternId" runat="server" />
        <asp:HiddenField ID="hdnDCcheck" runat="server" Value="false" />
        <asp:HiddenField ID="hdnisRM" runat="server" Value="false" />
        <asp:HiddenField ID="hdnTotDc" runat="server" Value="false" />
        <input type="hidden" id="hdnTaskDate" runat="server" value="-1" />
        <input type="hidden" id="hdncategory" runat="server" value="-1" />
        <input type="hidden" id="hdnspecId" runat="server" value="-1" />
        <input type="hidden" id="hdnInvLocationID" runat="server" value="0" />
        <input type="hidden" id="hdncurrentPageNo" runat="server" value="0" />
        <input type="hidden" id="hdnDeptID" runat="server" value="-1" />
        <asp:HiddenField ID="hdnValidationTextOnLoad" runat="server" Value="" />
        <asp:HiddenField ID="hdnValidationRuleOnLoad" runat="server" Value="" />
        <asp:HiddenField ID="hdnLstPatientInvestigationCulture" runat="server" Value="" />
        <asp:HiddenField ID="hdnCultureRowPosition" runat="server" Value="0" />
        <asp:HiddenField ID="hdnEditableFormulaFields" runat="server" Value="" />
        <asp:HiddenField ID="hdnEditComputation" runat="server" Value="" />
    </div>
    
    <div id="modal" class="modal" runat="server" style="z-index: 9999;">
        <%-- <div class="loading" style="position: absolute; top: 300px; left: 550px; display: block;
                z-index: 9999;" align="center">
                Loading....../Images/loader.gif" alt="" />
            </div>
        </div>--%>
        <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </div>

    <script src="../Scripts/JsonScript.js" type="text/javascript"></script>

    <%--    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>--%>

    <script type="text/javascript" src="../Scripts/InvPattern.js"></script>

    <script type="text/javascript" src="../Scripts/ResultCapture.js"></script>
<%--
    <script src="../Scripts/jquery-1.6.1.min.js" type="text/javascript"></script>--%>

<%--    <script src="../Scripts/jquery-ui.min.1.8.13.js" type="text/javascript"></script>--%>

    <script src="../Scripts/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="../Scripts/InvApproval.js" type="text/javascript"></script>

    </form>
</body>
</html>
