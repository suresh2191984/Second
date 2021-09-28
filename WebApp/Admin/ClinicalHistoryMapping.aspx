<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClinicalHistoryMapping.aspx.cs"
    Inherits="Admin_ClinicalHistoryMapping" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>--%>
    <%--<script language="javascript" type="text/javascript">
    --%>
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />
    <%--<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
--%>
    <style>
        .even
        {
            text-align: center;
        }
        .odd
        {
            text-align: center;
        }
    </style>

    <script type="text/javascript">


        function SetTestName(source, eventArgs) {
            var varGetVal = eventArgs.get_value();
            //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
            var ID;
            var name;
            var InvType;

            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        ID = list[0];
                        name = list[1];
                        InvType = list[2];
                        document.getElementById('hdnInvID').value = ID;
                        document.getElementById('hdnInvName').value = name;
                        document.getElementById('txt_TestName').value = name;
                        document.getElementById('hdnInvType').value = InvType;
                        //                document.getElementById('hdnInvType').value = InvType;
                        //                document.getElementById('ddlFrom').focus();

                    }
                }
            }
        }

        function SetHistoryInfo(source, eventArgs) {
            var varGetVal = eventArgs.get_value();
            debugger;
            var list = eventArgs.get_value().split('~');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        var id = list[0];
                        var displayTxt = list[1];
                        document.getElementById('txt_HistoryNameOrCode').value = displayTxt;
                        document.getElementById('hdnHistoryMasterId').value = id;
                    }
                }
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <%-- <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>--%>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="div_historyMap">
            <table class="w-100p searchPanel">
                <tr>
                    <td>
                        <asp:Label ID="lbl_TestName" runat="server" Text="Test/Group/Package Name/Code :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txt_TestName" runat="server" TabIndex="0" meta:resourcekey="txt_Err_CodeResource1" style=" width:90%"></asp:TextBox>
                        <img src="../Images/starbutton.png" alt="" align="middle" />
                        <%--<div id="aceDiv" style="z-index: 99999">
                        </div>--%>
                        <%--<ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txt_TestName"
                        FirstRowSelected="true" ServiceMethod="GetOrgInvestigationsGroupandPKG" ServicePath="~/WebService.asmx"
                        CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="2" CompletionInterval="0"
                        DelimiterCharacters="" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected" OnClientItemSelected="SetTestName"
                        UseContextKey="true">
                    </ajc:AutoCompleteExtender>--%>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txt_TestName"
                            EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" FirstRowSelected="True"
                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetOrgInvestigationsGroupandPKG"
                            OnClientItemSelected="SetTestName" ServicePath="~/WebService.asmx" UseContextKey="True"
                            DelimiterCharacters="" Enabled="True">
                        </ajc:AutoCompleteExtender>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_HistoryNameOrCode" runat="server" Text="History Name/Code :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txt_HistoryNameOrCode" runat="server" TabIndex="1" meta:resourcekey="txt_Err_CodeResource1" style=" width:90%"></asp:TextBox>
                        <img src="../Images/starbutton.png" alt="" align="middle" />
                        <%-- <div id="Div2" style="z-index: 99999">
                        </div>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txt_HistoryNameOrCode"
                            FirstRowSelected="true" ServiceMethod="GetAllActiveHistoryMasterItems" ServicePath="~/WebService.asmx"
                            CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="2" CompletionInterval="0"
                            DelimiterCharacters="" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected" OnClientItemSelected="SetHistoryInfo"
                            UseContextKey="true">
                        </ajc:AutoCompleteExtender>--%>
                        
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txt_HistoryNameOrCode"
                            FirstRowSelected="true" ServiceMethod="GetAllHistoryMasterInfos" ServicePath="~/WebService.asmx"
                            CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="2" CompletionInterval="0"
                            DelimiterCharacters="" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected" OnClientItemSelected="SetHistoryInfo"
                            UseContextKey="true">
                        </ajc:AutoCompleteExtender>
                    </td>
                    <td>
                        <asp:Label ID="lbl_historySequenceNo" runat="server" Text="History Sequence :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txt_historySequenceNo" runat="server" TabIndex="2" meta:resourcekey="txt_Err_CodeResource1"
                            onkeydown="return DisableEnterKey()"></asp:TextBox>
                        <img src="../Images/starbutton.png" alt="" align="middle" />
                    </td>
                    <td>
                        <asp:CheckBox ID="chkIsMandatory" runat="server" TabIndex="3" Text="Is Mandatory" />
                    </td>
                    <td>
                        <asp:Button ID="btnSave" runat="server" Text="Add" TabIndex="3" OnClientClick="return Save(); " />
                        <asp:Button ID="btnUpdate" runat="server" Text="Update" />
                        <asp:Button ID="btnReset" runat="server" Text="Reset" OnClientClick="Reset(); return false"/>
                    </td>
                </tr>
            </table>
        </div>
        <div id="div_HistoryMapMaster_Grid" align="left">
            <div id="ClinicalHistory" class="w-100p o-auto max-h-400">
                <%--<table id="tblHistoryMapping" style="display: none">--%>
                <table id="tblHistoryMapping" width="100%">
                    <thead>
                        <tr>
                            <th class="a-center">
                                Test Name
                            </th>
                            <th class="a-center">
                                History Name
                            </th>
                            <th class="a-center">
                                History Code
                            </th>
                            <th class="a-center">
                                History Sequence
                            </th>
                            <th class="a-center">
                                Mandatory
                            </th>
                            <th class="a-center">
                                Action
                            </th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
    <%-- <div id="div1" align="left">
        <table id="Table1" style="display: none">
            <tr>
                <td>
                    <asp:Button ID="btnSave" runat="server" Text="Submit" TabIndex="4" OnClientClick="Save(); return false" />
                </td>
                <td>
                    <asp:Button ID="btnClose" runat="server" Text="Close" TabIndex="5" OnClientClick="Close(); return false" />
                </td>
            </tr>
        </table>
    </div>--%>
    <%--<asp:HiddenField ID="hdnEditHistoryId" runat="server" Value="" />--%>
    <asp:HiddenField ID="hdnInvID" runat="server" Value="" />
    <asp:HiddenField ID="hdnInvType" runat="server" Value="" />
    <asp:HiddenField ID="hdnInvName" runat="server" Value="" />
    <asp:HiddenField ID="hdnHistoryMasterId" runat="server" Value="" />
    <asp:HiddenField ID="hdn_EditHistoryMapId" runat="server" Value="" />
    <asp:HiddenField ID="hdnOrgId" runat="server" Value="" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />

    <script language="javascript" type="text/javascript">
        $(document).ready(function() {
            orgID = '<%=base.OrgID %>';
            //locId = '<%=base.ILocationID %>';

            //alert("hai")
        });
    </script>

    </form>

    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

    <script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>

    <script src="../Scripts/AdobeReaderDetection.js" type="text/javascript" language="javascript" />

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>

    <%-- <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>
--%>

    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/ClinicalHistoryMapping.js" type="text/javascript"></script>

    <script src="../PlatForm/Scripts/linq.min.js" type="text/javascript"></script>

</body>
</html>
