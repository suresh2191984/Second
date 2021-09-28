<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Analyzer.aspx.cs" Inherits="Admin_Analyzer" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="~/CommonControls/FileUpload.ascx" TagName="FileUpload" TagPrefix="TRF" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Analyzer</title>

   <%-- <script src="../Scripts/jquery-1.3.2.js" type="text/javascript"></script>--%>

    <script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        function setUOM(id) {
            document.getElementById('hdnSelUOMInvID').value = id;
            window.open('ChangeUOM.aspx?Ispopup=Y', '', 'width=800,height=600');
        }
        function SelectUOMCode1(id, uomID, uomCode) {
            Controlid = document.getElementById('hdnSelUOMInvID').value;
            if (Controlid == "hypLnkUOM") {
                document.getElementById(Controlid).innerHTML = uomCode;
                document.getElementById('uomID').value = uomID;
                document.getElementById('uomCode').value = uomCode;
            }
            if (Controlid == "hypLnkUOM1") {
                document.getElementById(Controlid).innerHTML = uomCode;
                document.getElementById('uomID1').value = uomID;
                document.getElementById('uomCode1').value = uomCode;
            }
            if (Controlid == "hypLnkUOM2") {
                document.getElementById(Controlid).innerHTML = uomCode;
                document.getElementById('uomID2').value = uomID;
                document.getElementById('uomCode2').value = uomCode;
            }
        }
        function disableAll(obj) {
            if (document.getElementById(obj).value == "") {
                ClearFields("");
            }
            return false;
        }
        function OnSelectProducts(source, eventArgs) {
            var tName = eventArgs.get_text().trim();
            var Str = eventArgs.get_value();
            fill(Str, tName, "Y", "");
        }
        function fill(Str, name, obj, path) {
            var userMsg = SListForAppMsg.Get("Admin_Analyzer_aspx_Unit") != null ? SListForAppMsg.Get("Admin_Analyzer_aspx_Unit") : "<U>Unit</U>";
            var userMsg1 = SListForAppMsg.Get("Admin_Analyzer_aspx_Update") != null ? SListForAppMsg.Get("Admin_Analyzer_aspx_Update") : "Update";
           
            if (obj == "N") {
                document.getElementById('btnSave').value = userMsg1;
                document.getElementById('txtProductName').value = name;
                CreateDocTable(path);
            }
            var tInstrumentID = Str.split('~')[0].trim();
            var Process = "0";
            var txtDataStorage = "";
            var ddlDataStorage = userMsg;
            var txtThroughput = "";
            var ddlThroughput = userMsg;
            var ddlDirection = "0";
            var txtSampleValue = "";
            var ddlSampleValue = userMsg;
            var TRFUrl = "";

            var ProductCode = Str.split('~')[2].trim();
            var Model = Str.split('~')[3].trim();
            var Manufacturer = Str.split('~')[4].trim();
            var Method = Str.split('~')[5].trim();
            var Principle = Str.split('~')[6].trim();
            var Department = Str.split('~')[7].trim();
            var strStorage = Str.split('~')[10].trim();
            if (Str.split('~')[9].trim() != "" && Str.split('~')[9].trim() != "0") {
                txtSampleValue = Str.split('~')[9].trim().split(',')[0].trim();
                ddlSampleValue = Str.split('~')[9].trim().split(',')[1].trim();
            }
            if (strStorage != "" && strStorage != "0") {
                txtDataStorage = strStorage.split(',')[0].trim();
                ddlDataStorage = strStorage.split(',')[1].trim();
            }
            var strThroughPut = Str.split('~')[11].trim();
            if (strThroughPut != "" && strThroughPut != "0") {
                txtThroughput = strThroughPut.split(',')[0].trim();
                ddlThroughput = strThroughPut.split(',')[1].trim();
            }
            var strddlDirection = Str.split('~')[12].trim();
            if (strddlDirection != "" && strddlDirection != "0") {
                ddlDirection = strddlDirection;
            }
            if (Str.split('~')[8].trim() != "" && Str.split('~')[8].trim() != "0") {
                Process = Str.split('~')[8].trim();
            }
            document.getElementById('hdnInstrumentID').value = tInstrumentID;
            document.getElementById('txtProductCode').value = ProductCode;
            document.getElementById('txtModel').value = Model;
            document.getElementById('txtManufacturer').value = Manufacturer;
            document.getElementById('hdnProductCode').value = ProductCode;
            document.getElementById('hdnModel').value = Model;
            document.getElementById('hdnManufaturer').value = Manufacturer;
            if (Number(tInstrumentID) > Number(0)) {
                document.getElementById('txtProductCode').disabled = true;
                document.getElementById('txtModel').disabled = true;
                document.getElementById('txtManufacturer').disabled = true;
            }
            else {
                document.getElementById('txtProductCode').disabled = false;
                document.getElementById('txtModel').disabled = false;
                document.getElementById('txtManufacturer').disabled = false;
            }
            var mthd = document.getElementById('hdnMethod').value.split('^');
            if (mthd != "") {
                if (Method != "") {
                    for (var i = 0; i < mthd.length; i++) {
                        if (mthd[i].split('~')[0].trim() == Method) {
                            document.getElementById('ddlMethod').value = mthd[i].split('~')[1];
                            break;
                        }
                    }
                }
                else {
                    document.getElementById('ddlMethod').value = "0";
                }
            }
            var PrincipleVal = document.getElementById('hdnPrinciple').value.split('^');
            if (PrincipleVal != "") {
                if (Principle != "") {
                    for (var i = 0; i < PrincipleVal.length; i++) {
                        if (PrincipleVal[i].split('~')[0].trim() == Principle) {
                            document.getElementById('ddlPrinciple').value = PrincipleVal[i].split('~')[1];
                            break;
                        }
                    }
                }
                else {
                    document.getElementById('ddlPrinciple').value = "0";
                }
            }
            var DepartmentVal = document.getElementById('hdnDepartment').value.split('^');
            if (DepartmentVal != "") {
                if (Department != "") {
                    for (var i = 0; i < DepartmentVal.length; i++) {
                        if (DepartmentVal[i].split('~')[0].trim() == Department) {
                            document.getElementById('ddlDepartment').value = DepartmentVal[i].split('~')[1];
                            break;
                        }
                    }
                }
                else {
                    document.getElementById('ddlDepartment').value = "0";
                }
            }
            var ProcessVal = document.getElementById('hdnProcessMode').value.split('^');
            if (ProcessVal != "") {
                for (var i = 0; i < ProcessVal.length; i++) {
                    if (ProcessVal[i].split('~')[0].trim() == Process) {
                        document.getElementById('ddlProcess').value = ProcessVal[i].split('~')[1];
                        break;
                    }
                }
            }
            var DirectionVal = document.getElementById('hdnDirection').value.split('^');
            if (DirectionVal != "") {
                for (var i = 0; i < DirectionVal.length; i++) {
                    if (DirectionVal[i].split('~')[0].trim() == ddlDirection) {
                        document.getElementById('ddlDirection').value = DirectionVal[i].split('~')[1];
                        break;
                    }
                }
            }
            document.getElementById('txtSampleValue').value = txtSampleValue;
            document.getElementById('hypLnkUOM').innerHTML = ddlSampleValue.trim() == "" ? userMsg : ddlSampleValue.trim();
            document.getElementById('txtDataStorage').value = txtDataStorage;
            document.getElementById('hypLnkUOM1').innerHTML = ddlDataStorage.trim() == "" ? userMsg : ddlDataStorage.trim();
            document.getElementById('txtThroughput').value = txtThroughput;
            document.getElementById('hypLnkUOM2').innerHTML = ddlThroughput.trim() == "" ? userMsg : ddlThroughput.trim();
        }
        function CreateDocTable(pathaName) {
            document.getElementById('<%= divCreateDoc.ClientID %>').innerHTML = "";
            var startTag, bodytag, endtag;
            var path = pathaName.split('###');
            if (pathaName != '') {
                startTag = "<TABLE ID='tabDrg1' Cellpadding='2' Cellspacing='2' width='80%' class='dataheaderInvCtrl gridView' style='font-size: 11px;'><TBODY><tr class='dataheader1'><th scope='col' align='center' width='5%'>S.No</th><th scope='col' align='center' width='87%'> File Name </th><th scope='col' align='center' width='8%'> Action </th>";
                endtag = "</TBODY></TABLE>";
                bodytag = startTag;
                var count = 0;
                for (var i = 0; i < path.length; i++) {
                    if (path[i] != '') {
                        count = count + 1;
                        bodytag += "<TR><TD STYLE='display:table-cell'>" + count + "</TD>";
                        bodytag += "<TD align='left'>" + path[i].split('~')[1];
                        bodytag += "<a href=" + path[i].split('~')[1] + "</a></TD>";
                        bodytag += "<TD align='centre'><input type='button' id='btnShow' value='Show' class='btn1' style='cursor:pointer ; color:white' name='" + path[i].split('~')[1] + "' onclick='onChangeFile(name);' </TD>";
                    }
                }
                bodytag += endtag;
                document.getElementById('divCreateDoc').style.display = 'block';
                document.getElementById('tdCreateDoc').style.display = 'table-cell';
                document.getElementById('<%= divCreateDoc.ClientID %>').innerHTML = bodytag;
            }
        }

        function onChangeFile(name) {
            $("[id$='btnTarget']").click();
            var orgID = '<%= OrgID %>';
            $('[id$="ifPDF"]').show();
            $('[id$="trPDF"]').show();
            $("[id$='ifPDF']").attr('src', '<%=ResolveUrl("~/Reception/TRFImagehandler.ashx?PictureName=' + name + '&OrgID=' + orgID + '")%>');
        }

        function isSpclChar(e) {
            var key;
            var isCtrl = false;
            if (window.event) // IE8 and earlier
            {
                key = e.keyCode;
            }
            else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
            {
                key = e.which;
            }
            //*************To block slash(/) into text box change the key value to 48***************************//
            if ((key >= 47 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32)) {
                isCtrl = true;
            }
            return isCtrl;
        }
        function ValidateItems() {
            var errorMsg = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") == null ? "Information" : SListForAppMsg.Get("Admin_TestInvestigation_aspx_02");
            var userMsg = SListForAppMsg.Get("Admin_Analyzer_aspx_01") == null ? "Provide Device name" : SListForAppMsg.Get("Admin_Analyzer_aspx_01");
            var userMsg1 = SListForAppMsg.Get("Admin_Analyzer_aspx_02") == null ? "Provide Device Code" : SListForAppMsg.Get("Admin_Analyzer_aspx_02");
                  
            if (document.getElementById('txtProductName').value.trim() == "") {
                ValidationWindow(userMsg, errorMsg);
                //alert('Provide Device name');
                document.getElementById('txtProductName').value = "";
                document.getElementById('txtProductName').focus();
                return false;
            }
            if (document.getElementById('txtProductCode').value.trim() == "") {
                //alert('Provide Device code');
                ValidationWindow(userMsg1, errorMsg);
                document.getElementById('txtProductCode').value = "";
                document.getElementById('txtProductCode').focus();
                return false;
            }
            //            if (document.getElementById('txtModel').value.trim() == "") {
            //                alert('Provide product model');
            //                document.getElementById('txtModel').value = "";
            //                document.getElementById('txtModel').focus();
            //                return false;
            //            }
            //            if (document.getElementById('txtManufacturer').value.trim() == "") {
            //                alert('Provide Manufacturer');
            //                document.getElementById('txtManufacturer').value = "";
            //                document.getElementById('txtManufacturer').focus();
            //                return false;
            //            }
            //            if (document.getElementById('ddlMethod').value == "0") {
            //                alert('Provide Method');
            //                document.getElementById('ddlMethod').value = "0";
            //                document.getElementById('ddlMethod').focus();
            //                return false;
            //            }
            //            if (document.getElementById('ddlPrinciple').value.trim() == "0") {
            //                alert('Provide Principle');
            //                document.getElementById('ddlPrinciple').value = "0";
            //                document.getElementById('ddlPrinciple').focus();
            //                return false;
            //            }
            //            if (document.getElementById('ddlProcess').value.trim() == "0") {
            //                alert('Provide Process mode');
            //                document.getElementById('ddlProcess').focus();
            //                return false;
            //            }
            //            if (document.getElementById('txtSampleValue').value.trim() == "") {
            //                alert('Provide Sample Value');
            //                document.getElementById('txtSampleValue').value = "";
            //                document.getElementById('txtSampleValue').focus();
            //                return false;
            //            }
            //            if (document.getElementById('hypLnkUOM').value == "--") {
            //                alert('Provide sample value Unit');
            //                //                document.getElementById('hypLnkUOM').focus();
            //                return false;
            //            }
            //            if (document.getElementById('txtDataStorage').value.trim() == "") {
            //                alert('Provide data storage value');
            //                document.getElementById('txtDataStorage').value = "";
            //                document.getElementById('txtDataStorage').focus();
            //                return false;
            //            }
            //            if (document.getElementById('hypLnkUOM1').value == "--") {
            //                alert('Provide storage value unit');
            //                //                document.getElementById('ddlDataStorage').focus();
            //                return false;
            //            }
            //            if (document.getElementById('txtThroughput').value.trim() == "") {
            //                alert('Provide Through put value');
            //                document.getElementById('txtThroughput').value = "";
            //                document.getElementById('txtThroughput').focus();
            //                return false;
            //            }
            //            if (document.getElementById('hypLnkUOM2').value == "--") {
            //                alert('Provide Through put unit');
            //                //                document.getElementById('ddlThroughput').focus();
            //                return false;
            //            }
            //            if (document.getElementById('ddlDirection').value == "0") {
            //                alert('Provide Direction');
            //                document.getElementById('ddlDirection').focus();
            //                return false;
            //            }
        }
        function ClearFields(obj) {
            var userMsg1 = SListForAppMsg.Get("Admin_Analyzer_aspx_Save") == null ? "Save" : SListForAppMsg.Get("Admin_Analyzer_aspx_Save");
            var userMsg = SListForAppMsg.Get("Admin_Analyzer_aspx_Unit") != null ? SListForAppMsg.Get("Admin_Analyzer_aspx_Unit") : "<U>Unit</U>";
           
            document.getElementById('txtProductCode').disabled = false;
            document.getElementById('txtModel').disabled = false;
            document.getElementById('txtManufacturer').disabled = false;
            CreateDocTable("");
            if (obj != "SRCH") {
                document.getElementById('txtSearch').value = "";
            }
            document.getElementById('btnSave').value = userMsg1;

            document.getElementById('hdnInstrumentID').value = "0";
            document.getElementById('txtProductName').value = "";
            document.getElementById('txtProductCode').value = "";
            document.getElementById('txtModel').value = "";
            document.getElementById('txtManufacturer').value = "";
            document.getElementById('ddlMethod').value = "0";
            document.getElementById('ddlPrinciple').value = "0";
            document.getElementById('ddlDepartment').value = "0";
            document.getElementById('ddlProcess').value = "0";
            document.getElementById('txtSampleValue').value = "";
            document.getElementById('hypLnkUOM').innerHTML = userMsg;
            document.getElementById('txtDataStorage').value = "";
            document.getElementById('hypLnkUOM1').innerHTML = userMsg;
            document.getElementById('txtThroughput').value = "";
            document.getElementById('hypLnkUOM2').innerHTML = userMsg;
            document.getElementById('ddlDirection').value = "0";
            return false;
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                       
                        <table class="w-100p">
                            <tr>
                                <td>
                                    <div class="dataheader3">
                                        <asp:UpdatePanel ID="updtAnalyzer" runat="server">
                                            <ContentTemplate>
                                                <asp:Panel ID="pnlGeneralDetails" class="bg-row padding10" 
                                            runat="server" GroupingText="<b><I>Device Details</I></b>" 
                                            meta:resourcekey="pnlGeneralDetailsResource1">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="w-10p" nowrap="nowrap">
                                                                <asp:Label runat="server" ID="lblProductName" Text="Device Name" 
                                                                    meta:resourcekey="lblProductNameResource1"></asp:Label>
                                                                &nbsp;
                                                            </td>
                                                            <td class="w-22p">
                                                                <asp:TextBox runat="server" ID="txtProductName" onblur="disableAll(this.id);"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" 
                                                                    CssClass="Txtboxmedium" meta:resourcekey="txtProductNameResource1"></asp:TextBox>
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtProductName"
                                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                MinimumPrefixLength="1" CompletionInterval="1" OnClientItemSelected="OnSelectProducts"
                                                                FirstRowSelected="True" ServiceMethod="GetAnalyzerProducts" ServicePath="~/InventoryWebService.asmx"
                                                                DelimiterCharacters="" Enabled="True">
                                                            </ajc:AutoCompleteExtender>
                                                            <td class="w-15p">
                                                                <asp:Label runat="server" ID="lblProductCode" Text="Device Code" 
                                                                    meta:resourcekey="lblProductCodeResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-24p">
                                                                <asp:TextBox runat="server" ID="txtProductCode" CssClass="Txtboxmedium" 
                                                                    meta:resourcekey="txtProductCodeResource1"></asp:TextBox>
                                                               &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                            <td class="w-10p">
                                                                <asp:Label runat="server" ID="lblModel" Text="Model" 
                                                                    meta:resourcekey="lblModelResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox runat="server" ID="txtModel" CssClass="Txtboxmedium" 
                                                                    meta:resourcekey="txtModelResource1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="w-10p">
                                                                <asp:Label runat="server" ID="lblManufacturer" Text="Manufacturer" 
                                                                    meta:resourcekey="lblManufacturerResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-22p">
                                                                <asp:TextBox runat="server" ID="txtManufacturer" CssClass="Txtboxmedium" 
                                                                    meta:resourcekey="txtManufacturerResource1"></asp:TextBox>
                                                            </td>
                                                            <td class="w-15p">
                                                                <asp:Label runat="server" ID="lblMethod" Text="Method" 
                                                                    meta:resourcekey="lblMethodResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-24p">
                                                                <asp:DropDownList runat="server" ID="ddlMethod" CssClass="ddlsmall" 
                                                                    meta:resourcekey="ddlMethodResource1">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td class="w-10p">
                                                                <asp:Label runat="server" ID="lblPrinciple" Text="Principle" 
                                                                    meta:resourcekey="lblPrincipleResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList runat="server" ID="ddlPrinciple" CssClass="ddlsmall" 
                                                                    meta:resourcekey="ddlPrincipleResource1">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblDepartment" runat="server" Text="Department" 
                                                                    meta:resourcekey="lblDepartmentResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="ddlsmall" 
                                                                    meta:resourcekey="ddlDepartmentResource1">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                                <br />
                                                <asp:Panel ID="pnlEquipmentDetails" class="bg-row padding10" 
                                            runat="server" GroupingText="<b><I>Equipment Test Details</I></b>" 
                                            meta:resourcekey="pnlEquipmentDetailsResource1">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="w-10p">
                                                                <asp:Label runat="server" ID="lblProcess" Text="Processing Mode" 
                                                                    meta:resourcekey="lblProcessResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-22p">
                                                                <asp:DropDownList runat="server" ID="ddlProcess" CssClass="ddlsmall" 
                                                                    meta:resourcekey="ddlProcessResource1">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td class="w-15p">
                                                                <asp:Label runat="server" ID="lblSampleValue" Text="Optimal Sample Volume" 
                                                                    meta:resourcekey="lblSampleValueResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-14p">
                                                                <asp:TextBox runat="server"      onkeypress="return ValidateOnlyNumeric(this);"    ID="txtSampleValue"
                                                                    CssClass="Txtboxmedium" Width="50px" 
                                                                    meta:resourcekey="txtSampleValueResource1"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;
                                                                <asp:HyperLink ID="hypLnkUOM" Style="cursor: pointer;" runat="server" Text="<U>Unit</U>"
                                                                    ToolTip="Click here to select unit Measurment" 
                                                                    meta:resourcekey="hypLnkUOMResource1"></asp:HyperLink>
                                                            </td>
                                                            <td class="w-10p">
                                                                <asp:Label runat="server" ID="lblDataStorage" Text="Data storage" 
                                                                    meta:resourcekey="lblDataStorageResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox runat="server"      onkeypress="return ValidateOnlyNumeric(this);"    ID="txtDataStorage"
                                                                    Width="50px" CssClass="Txtboxmedium" 
                                                                    meta:resourcekey="txtDataStorageResource1"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;
                                                                <asp:HyperLink ID="hypLnkUOM1" Style="cursor: pointer;" runat="server" Text="<U>Unit</U>"
                                                                    ToolTip="Click here to select unit Measurment" 
                                                                    meta:resourcekey="hypLnkUOM1Resource1"></asp:HyperLink>
                                                               
                                                                <%--&nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="w-10p">
                                                                <asp:Label runat="server" ID="lblThroughput" Text="Through put" 
                                                                    meta:resourcekey="lblThroughputResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-22p">
                                                                <asp:TextBox runat="server"      onkeypress="return ValidateOnlyNumeric(this);"    ID="txtThroughput"
                                                                    Width="50px" CssClass="Txtboxmedium" 
                                                                    meta:resourcekey="txtThroughputResource1"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;
                                                                <asp:HyperLink ID="hypLnkUOM2" Style="cursor: pointer;" runat="server" Text="<U>Unit</U>"
                                                                    ToolTip="Click here to select unit Measurment" 
                                                                    meta:resourcekey="hypLnkUOM2Resource1"></asp:HyperLink>
                                                            </td>
                                                            <td class="w-15p">
                                                                <asp:Label runat="server" ID="lblDirection" Text="Direction" 
                                                                    meta:resourcekey="lblDirectionResource1"></asp:Label>
                                                            </td>
                                                            <td colspan="3" class="w-24p">
                                                                <asp:DropDownList runat="server" ID="ddlDirection" CssClass="ddlsmall" meta:resourcekey="ddlDirectionResource1">
                                                                </asp:DropDownList>
                                                                <%-- &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                                <asp:HiddenField ID="hdnInstrumentID" runat="server" Value="0" />
                                                <input type="hidden" id="hdnSelUOMInvID" value="" runat="server" />
                                                <input type="hidden" id="uomID" value="" runat="server" />
                                                <input type="hidden" id="uomCode" value="" runat="server" />
                                                <input type="hidden" id="uomID1" value="" runat="server" />
                                                <input type="hidden" id="uomCode1" value="" runat="server" />
                                                <input type="hidden" id="uomID2" value="" runat="server" />
                                                <input type="hidden" id="uomCode2" value="" runat="server" />
                                                <asp:HiddenField ID="hdnProductCode" runat="server" />
                                                <asp:HiddenField ID="hdnModel" runat="server" />
                                                <asp:HiddenField ID="hdnManufaturer" runat="server" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                        <br />
                                        <asp:Panel ID="pnlDocumentDetails" class="bg-row padding10" runat="server" 
                                            GroupingText="<b><I>Document Details</I></b>" 
                                            meta:resourcekey="pnlDocumentDetailsResource1">
                                            <div id="divUpload" runat="server" class="w-100p" style="display: block">
                                                <table class="w-100p">
                                                    <tr>
                                                        <td class="w-50p">
                                                            <TRF:FileUpload ID="TRFImageUpload" runat="server" Rows="6" OnClick="EpisodeFileUpload_Click" />
                                                        </td>
                                                        <td style="display: none;" id="tdCreateDoc" runat="server" class="v-top a-left w-50p">
                                                            <br />
                                                            <br />
                                                            <div id="divCreateDoc" class="w-100p" style="overflow: scroll; height: 220px; display: none;"
                                                                runat="server">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <input type="hidden" id="hdnFileValue" runat="server" >
                                                </input>
                                            </input>
                                        </asp:Panel>
                                        <table class="w-100p">
                                            <tr>
                                                <td class="a-center">
                                                    <asp:Button runat="server" ID="btnSave" Text="Save" CssClass="btn" OnClientClick="javascript:return ValidateItems();"
                                                        OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                                    <asp:Button runat="server" ID="btnClear" OnClientClick="javascript:return ClearFields();"
                                                        Text="Clear" CssClass="btn" meta:resourcekey="btnClearResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <br />
                                        <asp:UpdatePanel ID="updtAllProducts" runat="server">
                                            <ContentTemplate>
                                                <asp:Panel ID="pnlAllProductDetails" runat="server" 
                                            meta:resourcekey="pnlAllProductDetailsResource1">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="w-100p">
                                                                <asp:Label ID="lblSearch" runat="server" Text="<b>Search product :</b>" 
                                                                    meta:resourcekey="lblSearchResource1"></asp:Label>&nbsp;
                                                                <asp:TextBox ID="txtSearch" runat="server" Width="120px" 
                                                                    CssClass="Txtboxmedium" meta:resourcekey="txtSearchResource1"></asp:TextBox>
                                                                &nbsp;&nbsp;
                                                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" onmouseover="this.className='btn1 btnhov'"
                                                                    OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="w-100p">
                                                                <asp:GridView ID="grdAllProducts" runat="server" AutoGenerateColumns="False"
                                                                    CssClass="mytable1 w-100p gridView" EmptyDataText="No Results Found !!" 
                                                                    AllowPaging="True" OnPageIndexChanging="grdAllProducts_PageIndexChanging" 
                                                                    OnRowDataBound="grdAllProducts_RowDataBound" 
                                                                    meta:resourcekey="grdAllProductsResource1">
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                                                            <ItemTemplate>
                                                                                <%# Container.DataItemIndex+1%>
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Center" Width="3%" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Name" meta:resourcekey="TemplateFieldResource2">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblInstrumentName" runat="server" 
                                                                                    Text='<%# Eval("InstrumentName") %>' 
                                                                                    meta:resourcekey="lblInstrumentNameResource1"></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="200px" />
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="InstrumentType" HeaderText="Type" Visible="False" 
                                                                            meta:resourcekey="BoundFieldResource1" />
                                                                        <asp:BoundField DataField="ProductCode" HeaderText="Code" 
                                                                            meta:resourcekey="BoundFieldResource2" />
                                                                        <asp:BoundField DataField="Model" HeaderText="Model" 
                                                                            meta:resourcekey="BoundFieldResource3" />
                                                                        <asp:BoundField DataField="Manufacturer" HeaderText="Manufacturer" 
                                                                            meta:resourcekey="BoundFieldResource4" />
                                                                        <asp:TemplateField HeaderText="Method" 
                                                                            meta:resourcekey="TemplateFieldResource3">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblMethod" runat="server" Text='<%# Eval("Method") %>' 
                                                                                    meta:resourcekey="lblMethodResource2"></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="150px" />
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="Principle" HeaderText="Principle" 
                                                                            meta:resourcekey="BoundFieldResource5" />
                                                                        <asp:BoundField DataField="Department" HeaderText="Department" 
                                                                            meta:resourcekey="BoundFieldResource6" />
                                                                        <asp:BoundField DataField="ProcessingMode" HeaderText="Processing Mode" 
                                                                            meta:resourcekey="BoundFieldResource7" />
                                                                        <asp:TemplateField HeaderText="Sample Volume" 
                                                                            meta:resourcekey="TemplateFieldResource4">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblSampleVolume" runat="server" 
                                                                                    Text='<%# BindValue(Eval("SampleVolume").ToString()) %>' 
                                                                                    meta:resourcekey="lblSampleVolumeResource1"></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="120px" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Data Storage" 
                                                                            meta:resourcekey="TemplateFieldResource5">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblDataStorage" runat="server" 
                                                                                    Text='<%# BindValue(Eval("DataStorage").ToString()) %>' 
                                                                                    meta:resourcekey="lblDataStorageResource2"></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="120px" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Through Put" 
                                                                            meta:resourcekey="TemplateFieldResource6">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblThroughPut" runat="server" 
                                                                                    Text='<%# BindValue(Eval("ThroughPut").ToString()) %>' 
                                                                                    meta:resourcekey="lblThroughPutResource2"></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="120px" />
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="Direction" HeaderText="Direction" 
                                                                            meta:resourcekey="BoundFieldResource8" />
                                                                        <asp:BoundField DataField="Status" HeaderText="Status" Visible="False" 
                                                                            meta:resourcekey="BoundFieldResource9" />
                                                                        <asp:BoundField DataField="CreatedBy" HeaderText="Created By" Visible="False" 
                                                                            meta:resourcekey="BoundFieldResource10" />
                                                                        <asp:BoundField DataField="QCData" HeaderText="QCData" Visible="False" 
                                                                            meta:resourcekey="BoundFieldResource11" />
                                                                        <asp:TemplateField HeaderText="Path" Visible="False" 
                                                                            meta:resourcekey="TemplateFieldResource7">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblPath" runat="server" Text='<%# Eval("ImagePath") %>' 
                                                                                    meta:resourcekey="lblPathResource1"></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="values" Visible="False" 
                                                                            meta:resourcekey="TemplateFieldResource8">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblValues" runat="server" Text='<%# Eval("InstrumentID").ToString()+"~"+ Eval("InstrumentType")+"~"+ Eval("ProductCode")
                                                                                +"~"+ Eval("Model")+"~"+ Eval("Manufacturer")+"~"+ Eval("Method")+"~"+ Eval("Principle")+"~"+ Eval("Department")
                                                                                +"~"+ Eval("ProcessingMode")+"~"+ Eval  ("SampleVolume")+"~"+ Eval("DataStorage")+"~"+ Eval("ThroughPut")
                                                                                +"~"+ Eval("Direction")+"~"+ Eval("Status")+"~"+ Eval("QCData") %>' 
                                                                                    meta:resourcekey="lblValuesResource1"></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                                </asp:GridView>
                                                                <asp:HiddenField ID="hdnMethod" runat="server" />
                                                                <asp:HiddenField ID="hdnPrinciple" runat="server" />
                                                                <asp:HiddenField ID="hdnDepartment" runat="server" />
                                                                <asp:HiddenField ID="hdnProcessMode" runat="server" />
                                                                <asp:HiddenField ID="hdnDirection" runat="server" />
                                                                <asp:HiddenField ID="hdnUnits" runat="server" />
                                                                <asp:HiddenField ID="hdnMessages" runat="server" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                        <asp:Button ID="btnTarget" runat="server" Style="display: none;" 
                                            meta:resourcekey="btnTargetResource1" />
                                        <asp:Panel ID="pnlOthers" runat="server" Style="display: none; height: 550px; width: 649px;"
                                            CssClass="modalPopup dataheaderPopup" 
                                            meta:resourcekey="pnlOthersResource1">
                                            <div id="divFullImage">
                                                <table class="dataheader2 defaultfontcolor w-100p">
                                                    <tr id="trPDF" runat="server">
                                                        <td runat="server">
                                                            <iframe id="ifPDF" runat="server" style="display: none; border: 1; overflow: auto;"
                                                                width="620px" height="520px"></iframe>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-center">
                                                            <input id="btnClose" runat="server" class="btn" type="button" value="Close" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </asp:Panel>
                                        <ajc:ModalPopupExtender ID="mpeOthers" runat="server" BehaviorID="mpeOthersBehavior"
                                            BackgroundCssClass="modalBackground" PopupControlID="pnlOthers"
                                            CancelControlID="btnClose" TargetControlID="btnTarget" Enabled="True" 
                                            DynamicServicePath="">
                                        </ajc:ModalPopupExtender>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                            <td>&nbsp;<br></td>
                            </tr>
                        </table>
                    </div>
        <Attune:Attunefooter ID="Attunefooter" runat="server" />       
    </form>
</body>
</html>
