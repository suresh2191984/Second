<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientsCurrDateVist.aspx.cs"
    Inherits="Patient_PatientsCurrDateVist" meta:resourcekey="PageResource1" Culture="auto"
    %>

<%@ Register Src="~/CommonControls/TRFUpload.ascx" TagName="TRFUpload" TagPrefix="TRF" %>
<%@ Register Src="~/CommonControls/PhotoUpload.ascx" TagName="PhotoUpload" TagPrefix="PHOTO" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>
<%@ Register src="../CommonControls/IPClientTpaInsurance.ascx" tagname="IPClientTpaInsurance" tagprefix="uc7" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Today's Patient Visits</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.3.2.js" type="text/javascript"></script>

    <script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>

    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <style type="text/css">
        .Progress
        {
            background-color: #CF4342;
            color: White;
        }
        .Progress img
        {
            vertical-align: middle;
            margin: 2px;
        }
        #UpdateProgress2
        {
            background-color: #CF4342;
            color: #fff;
            top: 0px;
            right: 0px;
            position: fixed;
        }
        #UpdateProgress2 img
        {
            vertical-align: middle;
            margin: 2px;
        }
    </style>

    

</head>
<body>
    <form id="form1" runat="server">
    <script type="text/javascript">
        var userMsg;
        function ShowAlertMsg(key) {
            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else if (key == "Patient\\PatientsCurrDateVist.aspx.cs_3") {
                alert('This action Cannot be Performed as Patient belongs to another Organization');
                return false;
            }
            else if (key == "Patient\\PatientsCurrDateVist.aspx.cs_4") {
                alert('This action cannot be performed');
                return false;
            }
            else if (key == "Patient\\PatientsCurrDateVist.aspx.cs_5") {
                alert('URL Not Found');
                return false;
            }
            else if (key == "Patient\\PatientsCurrDateVist.aspx.cs_6") {
                alert('File Uploaded Successfully');
                return false;
            }
            else if (key == "Patient\\PatientsCurrDateVist.aspx.cs_7") {
                alert('Image Path Not Found');
                return false;
            }

            return true;
        }
        function PrintBill(obj) {

            var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
            strFeatures = strFeatures + ",scrollbars=yes,resizable=no,height=600,width=800";
            // ADDED THE LINE BELOW TO ORIGINAL EXAMPLE
            strFeatures = strFeatures + ",left=0,top=0,";
            var PrintWindow = window.open(obj, "", strFeatures);
            PrintWindow.focus();
            PrintWindow.print();

        }
        function SelectVisit(id, vid, pid, pno, PName, patOrgID) {

            chosen = "";
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(id).checked = true;
            document.getElementById("hdnVID").value = vid;
            document.getElementById("hdnPID").value = pid;
            document.getElementById("hdnPNO").value = pno;
            document.getElementById("hdnPNAME").value = PName;
            document.getElementById("patOrgID").value = patOrgID;
        }

        function CheckVisitID() {

            if (document.getElementById('hdnVID').value == '') {
                userMsg = SListForApplicationMessages.Get('Patient\\PatientsCurrDateVist.aspx_1');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;

                }
                else {

                    alert('Select visit detail');
                    return false;
                }
            }
            else {

                document.getElementById('hdnVisitDetail').value = document.getElementById('ddlVisitActionName').options[document.getElementById('ddlVisitActionName').selectedIndex].innerHTML;
                var action = document.getElementById("ddlVisitActionName");

                var Actionname = action.options[action.selectedIndex].value;
                if (Actionname == "TRF_Upload") {
                    document.getElementById('divUpload').style.display = 'block';
                    document.getElementById('divphoto').style.display = 'none';
                }
                else if (Actionname == "Photo_Upload") {
                    document.getElementById('divUpload').style.display = 'none';
                    document.getElementById('divphoto').style.display = 'block';
                }
                else {
                    document.getElementById('divUpload').style.display = 'none';
                    document.getElementById('divphoto').style.display = 'none';
                }

                return true;
            }

        }

        function popupprint() {
            var prtContent = document.getElementById('printGrid');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            //            WinPrint.close();
        }


        function CallAdmitMessage(sender) {
            var ConfirmString;
            userMsg = SListForApplicationMessages.Get('Patient\\PatientsCurrDateVist.aspx_2');
            if (userMsg != null) {
                ConfirmString = userMsg;

            } else {
                ConfirmString = "Are you sure you wish to admit?";

            }

            if (confirm(ConfirmString)) {

                return true;
            }
            else {

                return false;
            }
        }


        var ddlText, ddlValue, ddl, lblMesg;
        function CacheItems() {
            ddlText = new Array();
            ddlValue = new Array();
            ddl = document.getElementById("<%=ddlPhysician.ClientID %>");
            for (var i = 0; i < ddl.options.length; i++) {
                ddlText[ddlText.length] = ddl.options[i].text;
                ddlValue[ddlValue.length] = ddl.options[i].value;
            }
        }

        window.onload = CacheItems;


        function FilterItems(value) {
            value = value.toLowerCase();
            ddl.options.length = 0;
            for (var i = 0; i < ddlText.length; i++) {
                if (ddlText[i].toLowerCase().indexOf(value) != -1) {
                    AddItem(ddlText[i], ddlValue[i]);
                }
            }

            if (ddl.options.length == 0) {
                AddItem("No Physician Found", "");
            }
        }

        function AddItem(text, value) {
            var opt = document.createElement("option");
            opt.text = text;
            opt.value = value;
            ddl.options.add(opt);
        }
        function AddPhysician() {

            var ddlPhy = document.getElementById("<%= ddlPhysician.ClientID %>");
            var ddlPhyLength = ddlPhy.options.length;
            for (var i = 0; i < ddlPhyLength; i++) {
                if (ddlPhy.options[i].selected) {


                    if (ddlPhy.options[i].text != document.getElementById("hdnselectphysician").value) {

                        document.getElementById('<%= txtNew.ClientID %>').value = ddlPhy.options[i].text;

                    }

                }

            }
        }
        function PrintCaseSheet(vid, pid, vType) {
            window.open("../Physician/ViewIPCaseSheet.aspx?vid=" + vid + "&pid=" + pid + "&vType=" + vType + "&IsPopup=Y&Prt=Y" + "", '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0,Addressbar=no');
            return false;
        }        
  
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
     <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                       
                        <asp:UpdatePanel ID="pnl_Client" runat="server">
                            <ContentTemplate>
                                <asp:UpdateProgress DynamicLayout="False" ID="UpdateProgress2" runat="server">
                                    <ProgressTemplate>
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <table class="w-100p searchPanel">
                                   
                                    <tr>
                                        <td>
                                            <table class="w-35p">
                                                <tr>
                                                    <td nowrap="nowrap"  class="w-25p">
                                                        <asp:Label ID="Rs_FilterbyPatientName" Text="Filter by Patient Name (OR) Number:"
                                                            runat="server" meta:resourcekey="Rs_FilterbyPatientNameResource2"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtname" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtnameResource1"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="w-100p a-left">
                                                        <asp:Label ID="lblddlocation" Text="Location :" runat="server" meta:resourcekey="lblddlocationResource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:DropDownList ID="ddlocation" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlocationResource2">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Button runat="server" CssClass="btn" Text="Search" ID="btnSearch" OnClick="btnSearch_Click"
                                                            meta:resourcekey="btnSearchResource1" Width="61px" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap" style="display:none;">
                                              <uc7:IPClientTpaInsurance ID="IPClientTpaInsurance1" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap">
                                            <div id="divFilter" runat="server" style="display: none;">
                                                <asp:Label ID="Rs_Filterby" Text="Filter by" runat="server" meta:resourcekey="Rs_FilterbyResource1"></asp:Label>
                                                <asp:Label ID="lblPhyType" runat="server" Text="Refering " Visible="False" meta:resourcekey="lblPhyTypeResource1"></asp:Label>
                                                <asp:Label ID="Rs_PhysicianName" Text="Physician Name:" runat="server" meta:resourcekey="Rs_PhysicianNameResource1"></asp:Label>
                                                <asp:TextBox ID="txtNew" runat="server" ToolTip="Enter Text Here" onkeyup="FilterItems(this.value)"
                                                    onblur="AddPhysician()" meta:resourcekey="txtNewResource1" />
                                                    <asp:HiddenField ID="hdnselectphysician" runat="server" Value="Select Physician" />
                                                <asp:DropDownList ID="ddlPhysician" AutoPostBack="True" runat="server" OnSelectedIndexChanged="ddlPhysician_SelectedIndexChanged"
                                                    meta:resourcekey="ddlPhysicianResource1">
                                                </asp:DropDownList>
                                                <ajx:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtNew"
                                                    WatermarkText="Type Physician Name" Enabled="True"  meta:resourcekey="txttypePhysicianResource1"/>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Rs_TotalNoofPatientsVisitedToday" Text="Total No. of Patients Visited Today :"
                                                runat="server" meta:resourcekey="Rs_TotalNoofPatientsVisitedTodayResource1"></asp:Label>
                                            <asp:Label ID="lblNoofPatients" CssClass="ancCSredColorBold" runat="server" meta:resourcekey="lblNoofPatientsResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-right v-middle">
                                            <div id="divPrintBtn" runat="server" style="display: none;">
                                                <asp:Button ID="btnPrint" runat="server" Text="Print Today's Patient List" CssClass="btn"
                                                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="return popupprint();"
                                                    meta:resourcekey="btnPrintResource1" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Panel ID="pHeader" runat="server" CssClass="cpHeader" meta:resourcekey="pHeaderResource1">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Image ID="ImgCollapse" runat="server" meta:resourcekey="ImgCollapseResource1" />
                                                        </td>
                                                        <td>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblText" runat="server" meta:resourcekey="lblTextResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                            <asp:Panel ID="pBody" runat="server" CssClass="cpBody" meta:resourcekey="pBodyResource1">
                                                <table width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBoxList ID="ChkLstColumns" runat="server" meta:resourcekey="ChkLstColumnsResource1">
                                                            </asp:CheckBoxList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right">
                                                            <asp:Button ID="btnUpdateFilter" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" Text="Ok" OnClick="btnUpdateFilter_Click"
                                                                meta:resourcekey="btnUpdateFilterResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                            <ajx:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server" TargetControlID="pBody"
                                                CollapseControlID="pHeader" ExpandControlID="pHeader" Collapsed="True" TextLabelID="lblText"
                                                CollapsedText="Show Result Customization" ExpandedText="Hide Result Customization"
                                                ImageControlID="ImgCollapse" ExpandedImage="../images/collapse.jpg" CollapsedImage="../images/expand.jpg"
                                                Enabled="True" meta:resourcekey="CollapsiblePanelExtender1Resource1">
                                            </ajx:CollapsiblePanelExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="a-center" id="printGrid">
                                                <asp:GridView ID="grdResult" runat="server" AllowPaging="True" CellPadding="4"
                                                    AutoGenerateColumns="False" DataKeyNames="PatientID" OnRowDataBound="grdResult_RowDataBound"
                                                    ForeColor="#333333" OnPageIndexChanging="grdResult_PageIndexChanging" PageSize="15"
                                                    CssClass="mytable1 gridView w-100p" meta:resourcekey="grdResultResource1">
                                                    <PagerTemplate>
                                                        <tr>
                                                            <td colspan="6" class="a-center">
                                                                <asp:ImageButton ID="lnkPrev" CommandName="Page" runat="server" CausesValidation="False"
                                                                    CommandArgument="Prev" ImageUrl="~/Images/previousimage.png" Width="18px" Height="18px"
                                                                    meta:resourcekey="lnkPrevResource1" />
                                                                <asp:ImageButton ID="lnkNext" CommandName="Page" runat="server" CausesValidation="False"
                                                                    CommandArgument="Next" ImageUrl="~/Images/nextimage.png" Width="18px" Height="18px"
                                                                    meta:resourcekey="lnkNextResource1" />
                                                            </td>
                                                        </tr>
                                                    </PagerTemplate>
                                                    <HeaderStyle CssClass="dataheader1" />
                                                    <PagerSettings Mode="NextPrevious" />
                                                    <Columns>
                                                        <asp:BoundField Visible="False" DataField="PatientID" HeaderText="PatientId" meta:resourcekey="BoundFieldResource1" />
                                                        <asp:BoundField Visible="False" DataField="PatientVisitId" HeaderText="PatientVisitId"
                                                            meta:resourcekey="BoundFieldResource2" />
                                                        <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource1">
                                                            <ItemTemplate>
                                                                <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="PatientSelect"
                                                                    meta:resourcekey="rdSelResource1" />
                                                            </ItemTemplate>
                                                            <ItemStyle Width="2%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Patient Name" meta:resourcekey="TemplateFieldResource2">
                                                            <HeaderTemplate>
                                                                <asp:LinkButton ID="lnkPatientName" runat="server" Text="Patient Name" meta:resourcekey="lnkPatientNameResource1"></asp:LinkButton>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPatientName" runat="server" Text='<%# Bind("PatientName") %>' meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="VisitID" meta:resourcekey="TemplateFieldResource3">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblExternalVisitID" runat="server" Text='<%# Bind("ExternalVisitID") %>'
                                                                    meta:resourcekey="lblExternalVisitIDResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Visit Number" meta:resourcekey="TemplateFieldResource3">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblvisitnumber" runat="server" Text='<%# Bind("VisitNumber") %>'
                                                                    meta:resourcekey="lblExternalVisitIDResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="URN" meta:resourcekey="TemplateFieldResource16">
                                                            <HeaderTemplate>
                                                                <asp:LinkButton ID="lnkUrnNo" runat="server" Text="URN" meta:resourcekey="lnkUrnNoResource2"></asp:LinkButton>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblUrnNo" runat="server" Text='<%# Bind("URNO") %>' meta:resourcekey="lblUrnNoResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Patient Number" meta:resourcekey="TemplateFieldResource5">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPatientNo" runat="server" Text='<%# Bind("ID") %>' meta:resourcekey="lblPatientNoResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Contact No" meta:resourcekey="TemplateFieldResource6">
                                                            <HeaderTemplate>
                                                                <asp:LinkButton ID="lnkCont" runat="server" Text="Contact No" meta:resourcekey="lnkContResource1"></asp:LinkButton>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblMobileNumer" runat="server" Text='<%# Bind("MobileNumber") %>'
                                                                    meta:resourcekey="lblMobileNumerResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Age" meta:resourcekey="TemplateFieldResource7">
                                                            <HeaderTemplate>
                                                                <asp:LinkButton ID="lnkAge" runat="server" Text="Age" meta:resourcekey="lnkAgeResource1"></asp:LinkButton>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblAge" runat="server" Text='<%# Bind("PatientAge") %>' meta:resourcekey="lblAgeResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="6%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Address" meta:resourcekey="TemplateFieldResource8">
                                                            <HeaderTemplate>
                                                                <asp:LinkButton ID="lnkAdd" runat="server" Text="Address" meta:resourcekey="lnkAddResource1"></asp:LinkButton>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbAdd" runat="server" Text='<%# Bind("Address") %>' meta:resourcekey="lbAddResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="8%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Visit Time" meta:resourcekey="TemplateFieldResource9">
                                                            <HeaderTemplate>
                                                                <asp:LinkButton ID="lnkVisitDate" runat="server" Text="Visit Time" meta:resourcekey="lnkVisitDateResource1"></asp:LinkButton>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblVisitDate" runat="server" Text='<%# Bind("VisitDate","{0:hh:mm tt}") %>'
                                                                    meta:resourcekey="lblVisitDateResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="3%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Visit Purpose" meta:resourcekey="TemplateFieldResource10">
                                                            <HeaderTemplate>
                                                                <asp:LinkButton ID="lnkVisitPurpose" runat="server" Text="Visit Purpose" meta:resourcekey="lnkVisitPurposeResource1"></asp:LinkButton>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblVisitPurpose" runat="server" Text='<%# Bind("SpecialityName") %>'
                                                                    meta:resourcekey="lblVisitPurposeResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Physician Name" meta:resourcekey="TemplateFieldResource11">
                                                            <HeaderTemplate>
                                                                <asp:LinkButton ID="lnkPhysicianName" runat="server" Text="Physician Name" meta:resourcekey="lnkPhysicianNameResource1"></asp:LinkButton>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPhysicianName" runat="server" Text='<%# Bind("PhysicianName") %>'
                                                                    meta:resourcekey="lblPhysicianNameResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Ref Physician" meta:resourcekey="TemplateFieldResource12">
                                                            <HeaderTemplate>
                                                                <asp:LinkButton ID="lnkReferingPhysicianName" runat="server" Text="Ref Physician"
                                                                    meta:resourcekey="lnkReferingPhysicianNameResource1"></asp:LinkButton>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblReferingPhysicianName" runat="server" Text='<%# Bind("ReferingPhysicianName") %>'
                                                                    meta:resourcekey="lblReferingPhysicianNameResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="WardNo" meta:resourcekey="TemplateFieldResource13">
                                                            <HeaderTemplate>
                                                                <asp:LinkButton ID="lnkWardNo" runat="server" Text="WardNo" meta:resourcekey="lnkWardNoResource1"></asp:LinkButton>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblWardNo" runat="server" Text='<%# Bind("WardNo") %>' meta:resourcekey="lblWardNoResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:BoundField Visible="False" DataField="Investigation" HeaderText="Investigation"
                                                            meta:resourcekey="BoundFieldResource3">
                                                            <ItemStyle Width="25%" />
                                                        </asp:BoundField>
                                                        <asp:BoundField Visible="False" DataField="PerformingPhysicain" HeaderText="Reporting Radiologist"
                                                            meta:resourcekey="BoundFieldResource4">
                                                            <ItemStyle Width="25%" />
                                                        </asp:BoundField>
                                                        <asp:BoundField Visible="False" DataField="Status" HeaderText="Status" meta:resourcekey="BoundFieldResource5">
                                                            <ItemStyle Width="22%" />
                                                        </asp:BoundField>
                                                        <asp:TemplateField HeaderText="Investigationdetails" meta:resourcekey="TemplateFieldResource14">
                                                            <ItemTemplate>
                                                                <asp:GridView ID="ChildGrd" Width="40%" runat="server" AllowPaging="True" CellPadding="4"
                                                                    AutoGenerateColumns="False" ForeColor="#333333" BorderColor="ActiveCaption" PageSize="15"
                                                                    CssClass="mytable1" meta:resourcekey="ChildGrdResource1">
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                    <Columns>
                                                                        <asp:BoundField DataField="InvestigationName" HeaderText="InvestigationList" meta:resourcekey="BoundFieldResource6" />
                                                                        <asp:BoundField DataField="AccessionNumber" HeaderText="AccessionNumber" meta:resourcekey="BoundFieldResource7" />
                                                                        <asp:BoundField Visible="False" DataField="PerformingPhysicain" HeaderText="PerformingPhysicain"
                                                                            meta:resourcekey="BoundFieldResource8" />
                                                                        <asp:BoundField DataField="Status" HeaderText="Status" meta:resourcekey="BoundFieldResource9" />
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="14%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField Visible="False" HeaderText="Action" meta:resourcekey="TemplateFieldResource15">
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnAdmit" runat="server" Text="Admit" CommandArgument='<%# Bind("PatientVisitId") %>'
                                                                    CssClass="btn" OnClientClick="javascript:if(!CallAdmitMessage(this)) return false;"
                                                                    CommandName="Admit" OnClick="btnAdmit_Click" meta:resourcekey="btnAdmitResource1" />
                                                                <asp:HiddenField ID="hdnAdmissionSuggested" Value='<%# Bind("AdmissionSuggested") %>'
                                                                    runat="server" />
                                                            </ItemTemplate>
                                                            <ItemStyle Width="14%" />
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="OrgID" Visible="False" meta:resourcekey="BoundFieldResource10" />
                                                        <asp:TemplateField HeaderText="Location" meta:resourcekey="TemplateFieldResource17">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblLocation" runat="server" Text='<%# Bind("Location") %>' meta:resourcekey="lblLocationResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="5%" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="a-center v-middle">
                                        <td>
                                            <br />
                                            <asp:Label ID="lblResult" runat="server" CssClass="casesheettext" meta:resourcekey="lblResultResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td id="trVisitAction" runat="server" class="defaultfontcolor" >
                                            <asp:Label ID="Rs_Info" Text="Select a patient and Choose one of the following" runat="server"
                                                meta:resourcekey="Rs_InfoResource2"></asp:Label>
                                            <asp:DropDownList ID="ddlVisitActionName" CssClass="ddlmedium" runat="server" meta:resourcekey="ddlVisitActionNameResource1">
                                            </asp:DropDownList>
                                            <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                OnClientClick="return CheckVisitID()" onmouseout="this.className='btn'" OnClick="btnGo_Click"
                                                meta:resourcekey="btnGoResource1" Width="41px" />
                                        </td>
                                    </tr>
                                </table>
                                <div>
                                    <br />
                                    <br />
                                    <br />
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <div id="divUpload" runat="server" style="display: none">
                            <table class="w-70p">
                                <tr>
                                    <td>
                                        <table class="w-100p">
                                            <tr>
                                                <td colspan="4">
                                                    <TRF:TRFUpload ID="TRFImageUpload" runat="server" OnClick="TRFImageUpload_Click"
                                                        Rows="6" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="divphoto" runat="server" style="display: none">
                            <table class="w-70p">
                                <tr>
                                    <td>
                                        <table class="w-100p">
                                            <tr>
                                                <td>
                                                    <PHOTO:PhotoUpload ID="PatientPhoto" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
              
        <input type="hidden" id="hdnVID" name="vid" runat="server" />
        <input type="hidden" id="hdnPID" name="pid" runat="server" />
        <input type="hidden" id="hdnPNO" name="pno" runat="server" />
        <input type="hidden" id="hdnPNAME" name="PName" runat="server" />
        <input type="hidden" id="hdnVisitDetail" runat="server" />
        <input type="hidden" id="patOrgID" runat="server" />
        <input type="hidden" id="hdnSex" runat="server" />
        <Attune:Attunefooter ID="Attunefooter" runat="server" />  
        <asp:HiddenField ID="hdnMessages" runat="server" />
   
    </form>
</body>
</html>
