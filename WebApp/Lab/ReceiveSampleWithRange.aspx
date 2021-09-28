<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReceiveSampleWithRange.aspx.cs"
    Inherits="Lab_ReceiveSampleWithRange" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/OrderedSamples.ascx" TagName="OrderedSamples"
    TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/ExpectantSampleQueue.ascx" TagName="ExpSampleQ" TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/Department.ascx" TagName="Department" TagPrefix="uc3" %>
<%@ Register Src="~/CommonControls/Tasks.ascx" TagName="Task" TagPrefix="uc8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Receive Sample</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script type="text/javascript" language="javascript">

        function getFocus() {
            document.getElementById('txtSearchTxt').value = '';
            document.getElementById('txtSearchTxt').focus();
        }
        function txtBoxValidation() {
            if (document.getElementById('txtSearchTxt').value == '') {
                alert('Provide BarCodeNo to search');
                return false;
            }
            return ChkSampleAlreadyExists(document.getElementById('txtSearchTxt').value);
        }
        function expandList(id) {
            document.getElementById(id).style.width = "150px";
        }
        function collapseList(id) {
            document.getElementById(id).style.width = "100px";
        }
        function fnLoadReasons(objReasonID, objStatusID) {
            var newListItem;
            var objReasonID1 = document.getElementById(objReasonID);
            objReasonID1.options.length = 0;
            strSelStatusID = document.getElementById(objStatusID).value;
            var strReasons = document.getElementById('<%= hdnReasonList.ClientID %>').value.split('^');
            if (strReasons.length > 0) {
                newListItem = document.createElement("option");
                objReasonID1.options.add(newListItem);
                newListItem.text = "-----Select-----";
                newListItem.value = "0";
            }
            for (var i = 0; i < strReasons.length; i++) {
                var item1 = strReasons[i].split('~');
                for (var m = 0; m < item1.length; m++) {
                    var item2 = item1[m].split('-');
                    if (strSelStatusID == item2[0]) {
                        newListItem = document.createElement("option");
                        objReasonID1.options.add(newListItem);
                        newListItem.text = item1[1];
                        newListItem.value = item2[1];
                    }
                }
            }
            if (objReasonID1.options.length == 0) {
                newListItem = document.createElement("option");
                objReasonID1.options.add(newListItem);
                newListItem.text = "-----Select-----";
                newListItem.value = "0";
            }
        }
        function fnSetSelectedReason(objReasonID, objHiddenID) {
            document.getElementById(objHiddenID).value = document.getElementById(objReasonID).options[document.getElementById(objReasonID).selectedIndex].text;
        }
        function ChkSampleAlreadyExists(BareCodeNo) {
            var samplesList = new Array();
            var samplesDetail = new Array();
            if (document.getElementById('hdnSampleList').value != undefined && document.getElementById('hdnSampleList').value != "" && document.getElementById('hdnSampleList').value != null) {
                samplesList = document.getElementById('hdnSampleList').value.split('^');
                if (samplesList.length > 1) {
                    for (var i = 0; i < samplesList.length - 1; i++) {
                        samplesDetail = samplesList[i].split('~');
                        if (samplesDetail[1] == BareCodeNo) {
                            alert('Sample Already Received');
                            getFocus();
                            return false;
                        }
                    }
                }
                if (samplesList.length > 25) {
                    alert('Only 25 Sample Received At A Time');
                    return false;
                }
            }
        }
        function ChangeSampleStatus(ddlid, hdnid) {
            var ddlSelectedValue = document.getElementById(ddlid).value;
            var hdnstatusid = hdnid.id;
            var sampleid = ddlid.substring(9);
            var samplesList = new Array();
            var samplesDetail = new Array();
            var formChangedSampledetails = '';
            if (document.getElementById('hdnSampleList').value != undefined && document.getElementById('hdnSampleList').value != "" && document.getElementById('hdnSampleList').value != null) {
                samplesList = document.getElementById('hdnSampleList').value.split('^');
                if (samplesList.length > 0) {
                    for (var i = 0; i < samplesList.length - 1; i++) {
                        samplesDetail = samplesList[i].split('~');
                        if (samplesDetail[0] == sampleid) {
                            for (var j = 0; j < samplesDetail.length; j++) {
                                if (j != samplesDetail.length - 1) {
                                    if (j != 9) {
                                        formChangedSampledetails += samplesDetail[j] + '~';
                                    }
                                    else {
                                        formChangedSampledetails += ddlSelectedValue + '~';
                                    }
                                }
                                else {
                                    formChangedSampledetails += samplesDetail[j] + '^'
                                }

                            }

                        }
                        else {
                            for (var k = 0; k < samplesDetail.length; k++) {
                                if (k != samplesDetail.length - 1) {
                                    formChangedSampledetails += samplesDetail[k] + '~';
                                }
                                else {
                                    formChangedSampledetails += samplesDetail[k] + '^'
                                }
                            }
                        }
                    }
                    document.getElementById('hdnSampleList').value = '';
                    document.getElementById('hdnSampleList').value = formChangedSampledetails;
                }
            }
        }
        function ChangeSampleStatusReason(ddlid, hdnid) {
            var ddlSelectedValue = document.getElementById(ddlid).value;
            var ddl = document.getElementById(ddlid)
            var ddlSelectedText = ddl.options[ddl.selectedIndex].text;
            var hdnstatusid = hdnid.id;
            var sampleid = ddlid.substring(9);
            var samplesList = new Array();
            var samplesDetail = new Array();
            var formChangedSampledetails = '';
            if (document.getElementById('hdnSampleList').value != undefined && document.getElementById('hdnSampleList').value != "" && document.getElementById('hdnSampleList').value != null) {
                samplesList = document.getElementById('hdnSampleList').value.split('^');
                if (samplesList.length > 0) {
                    for (var i = 0; i < samplesList.length - 1; i++) {
                        samplesDetail = samplesList[i].split('~');
                        if (samplesDetail[0] == sampleid) {
                            for (var j = 0; j < samplesDetail.length; j++) {
                                if (j != samplesDetail.length-1) {
                                    if (j != 14) {
                                        formChangedSampledetails += samplesDetail[j] + '~';
                                    }
                                    else {
                                        formChangedSampledetails += ddlSelectedValue + '~';
                                    }
                                }
                                else {
                                    formChangedSampledetails += ddlSelectedText + '^'
                                }

                            }

                        }
                        else {
                            for (var k = 0; k < samplesDetail.length; k++) {
                                if (k != samplesDetail.length - 1) {
                                    formChangedSampledetails += samplesDetail[k] + '~';
                                }
                                else {
                                    formChangedSampledetails += samplesDetail[k] + '^'
                                }
                            }
                        }
                    }
                    document.getElementById('hdnSampleList').value = '';
                    document.getElementById('hdnSampleList').value = formChangedSampledetails;
                }
            }
        }
        function DeleteSample(id) {
            var sampleid = id.substring(8);
            var samplesList = new Array();
            var samplesDetail = new Array();
            var formChangedSampledetails = '';
            if (document.getElementById('hdnSampleList').value != undefined && document.getElementById('hdnSampleList').value != "" && document.getElementById('hdnSampleList').value != null) {
                samplesList = document.getElementById('hdnSampleList').value.split('^');
                if (samplesList.length > 0) {
                    for (var i = 0; i < samplesList.length - 1; i++) {
                        samplesDetail = samplesList[i].split('~');
                        if (samplesDetail[0] == sampleid) {
                        }
                        else {
                            for (var k = 0; k < samplesDetail.length; k++) {
                                if (k != samplesDetail.length - 1) {
                                    formChangedSampledetails += samplesDetail[k] + '~';
                                }
                                else {
                                    formChangedSampledetails += samplesDetail[k] + '^'
                                }
                            }
                        }
                    }
                    document.getElementById('hdnSampleList').value = '';
                    document.getElementById('hdnSampleList').value = formChangedSampledetails;
                }
            }
            var btnDummy = document.getElementById('<%= btnDummy.ClientID %>');
            btnDummy.click();
            javascript: __doPostBack('btnDummy', '');
        }
        

        
        
    </script>

    <style type="text/css">
        .style1
        {
            height: 20px;
            width: 7%;
        }
        .style2
        {
            height: 20px;
            width: 9%;
        }
        .style3
        {
            height: 20px;
            width: 119px;
        }
        .style4
        {
            width: 73px;
        }
        .style5
        {
            height: 20px;
            width: 6%;
        }
        .style6
        {
            width: 46px;
        }
    </style>
</head>
<body oncontextmenu="return false;" onload="javascript:getFocus();">
    <form id="form1" runat="server" defaultbutton="btnGo">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <%--<uc3:PatientHeader ID="patientHeader" runat="server" />--%>
                <uc6:UserHeader ID="UserHeader1" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table cellpadding="2" cellspacing="1" width="100%">
                            <tr id="tdAberrant" runat="server" style="display:none;">
                                <td width="100%" align="right">  
                                 <uc11:ExpSampleQ  ID="ExpectantSampleQueue" runat="server" />  
                                </td>
                            </tr>
                            <tr id="trPedingTask" runat="server" style="display:none;">
                                <td align="left" class="defaultfontcolor">
                                    <asp:Label ID="Rs_PendingTaskList" Text="Pending Task List" runat="server" 
                                        meta:resourcekey="Rs_PendingTaskListResource1" ></asp:Label>
                                    <uc3:Department ID="Department1" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <br />
                        <br />
                        <table width="100%" align="left" border="0">
                            <tr>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <table width="100%" align="left" border="0">
                                                <tr>
                                                    <td valign="top">
                                                        <asp:Panel ID="pnlSerch" CssClass="dataheader2" BorderWidth="1px" Width="85%" 
                                                            runat="server" meta:resourcekey="pnlSerchResource1">
                                                            <table border="0" id="searchTab" runat="server" cellpadding="4" cellspacing="0" width="100%">
                                                                <tr id="Tr1" runat="server" align="center">
                                                                    <td id="Td1" style="font-weight: normal; height: 20px; color: #000; width: 40%;"
                                                                        align="center" runat="server">
                                                                        <asp:Label ID="lblSearch" Text="Enter The BarcodeNo to Search The Sample" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td id="tdSearchCreteria" runat="server" style="display: none">
                                                                        <asp:DropDownList ID="ddlSearchType" runat="server" CssClass="ddlsmall">
                                                                            <asp:ListItem Text="Barcode No" Value="0" Selected="True"></asp:ListItem>
                                                                            <asp:ListItem Text="Sample ID" Value="1"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td id="Td2" style="font-weight: normal; height: 20px; color: #000; width: 20%;"
                                                                        align="left" runat="server">
                                                                        <asp:TextBox ID="txtSearchTxt" ToolTip="Search No" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                                    </td>
                                                                    <td id="Td5" style="width: 10%;" align="left" runat="server">
                                                                        <asp:Button ID="btnGo" runat="server" ToolTip="Click here to Receive the Sample"
                                                                            Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                                            Style="cursor: pointer;" OnClientClick="return txtBoxValidation();" OnClick="btnGo_Click" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:UpdatePanel ID="upnlProgress" runat="server">
                                        <ContentTemplate>
                                            <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel2" runat="server">
                                                <ProgressTemplate>
                                                    <div id="progressBackgroundFilter">
                                                    </div>
                                                    <div align="center" id="processMessage">
                                                        <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                                        <br />
                                                        <br />
                                                        <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                    </div>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>
                                            <table width="100%" align="left" border="0">
                                                <tr>
                                                    <td id="tdRowNum" runat="server" align="right" style="display: none">
                                                        <asp:Label ID="lblRowNumber" Font-Bold="True" CssClass="Duecolor" 
                                                            runat="server" meta:resourcekey="lblRowNumberResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Table ID="listTab" runat="server" CellPadding="2" CellSpacing="0" BorderWidth="1px"
                                                            BorderColor="#000000" Width="100%" meta:resourcekey="listTabResource1">
                                                        </asp:Table>
                                                    </td>
                                                </tr>
                                            </table>
                                            <asp:HiddenField ID="hdnReasonList" runat="server" />
                                            <asp:HiddenField ID="hdnSampleList" runat="server" />
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                        <ContentTemplate>
                                            <table width="100%" id="tbBtns" runat="server" style="display: none" align="center"
                                                border="0">
                                                <tr runat="server">
                                                    <td id="Td3" style="width: 10%;" align="center" runat="server">
                                                        <asp:Button ID="btnSave" runat="server" ToolTip="Click here to Save the Sample Status"
                                                            Text="Save" CssClass="btn" OnClick="btnSave_Click" onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'" Style="cursor: pointer;" />
                                                        <asp:Button ID="btnCancel" runat="server" ToolTip="Click here to Save the Sample Status"
                                                            Text="Cancel" CssClass="btn" OnClick="btnCancel_Click" OnClientClick="getFocus();"
8                                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" Style="cursor: pointer;" />
                                                    </td>
                                                    <td style="display:none" runat="server">
                                                    <asp:Button ID="btnDummy" runat="server"  CssClass="btn" OnClick="btnDummy_Click"/>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                        <asp:HiddenField ID="hdnDefaultSampleStatus" runat="server" />
                        <asp:HiddenField ID="hdnchangedSampleStatus" runat="server" />
                        <asp:HiddenField ID="hdnChangedReason" runat="server" />
                        <asp:HiddenField ID="hdnReasontxt" runat="server" />
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
