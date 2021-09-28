<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TpaPaymentCollection.aspx.cs"
    Inherits="InPatient_TpaPaymentCollection" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc112" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <style>
        .odd
        {
            background-color: white;
        }
        .even
        {
            background-color: gray;
        }
    </style>

    <script language="javascript" type="text/javascript">

        function CompareDate(FromDate,hdnAdmissionDate,hdnDischargedDate,txtRemarks) {
            var flag = 0;
            var From = document.getElementById(FromDate);

            var hdnAdmissionDate = document.getElementById(hdnAdmissionDate);
            var hdnDischargedDate = document.getElementById(hdnDischargedDate);

            var txtRemarks = document.getElementById(txtRemarks);
            
            dobDt = From.value.split('/');
            var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
            var mMonth = dobDtTime.getMonth() + 1;
            var mDay = dobDtTime.getDate();
            var mYear = dobDtTime.getFullYear();
            currentTime = new Date();
            var month = currentTime.getMonth() + 1;
            var day = currentTime.getDate();
            var year = currentTime.getFullYear();
            if (mYear > year) {
                flag = 1;
            }
            else if (mYear == year && mMonth > month) {
                flag = 1;
            }
            else if (mYear == year && mMonth == month && mDay > day) {
                flag = 1;
            }
            if (flag == 1) {
                alert("Date cannot Exceeded Current Date.");
                FromDate.value = "__/__/____";
                txtRemarks.focus();
                return false;
            }
            else {
                flag = 0;
                if (hdnDischargedDate != null) {

                    var strSplitFrom = hdnDischargedDate.value.split('/')
                    var myDateFrom = new Date();
                    myDateFrom.setFullYear(strSplitFrom[2], strSplitFrom[1] - 1, strSplitFrom[0]);
                    var strSplitTo = From.value.split('/')
                    myDateTo = new Date();
                    myDateTo.setFullYear(strSplitTo[2], strSplitTo[1] - 1, strSplitTo[0]);

                    if (myDateFrom > myDateTo) {
                        alert("Date can not lesser than Discharge date.");
                        From.value = "__/__/____";
                        
                        return false;
                    }
                }


                if (hdnAdmissionDate != null) {
                    flag = 0;
                    var strSplitFromAdmission = hdnAdmissionDate.value.split('/')
                    var myDateFromAdmission = new Date();
                    myDateFromAdmission.setFullYear(strSplitFromAdmission[2], strSplitFromAdmission[1] - 1, strSplitFromAdmission[0]);
                    var strSplitTo = From.value.split('/')
                    myDateTo = new Date();
                    myDateTo.setFullYear(strSplitTo[2], strSplitTo[1] - 1, strSplitTo[0]);
                    if (myDateFromAdmission > myDateTo) {
                        
                        alert("Date can not lesser than Admission date.");
                        From.value = "__/__/____";
                        return false;
                    }

                }
            }
                   
        }


        function checkTotal(ID1, ID2, TPAamount) {

            var tot = (Number(document.getElementById(ID2).value) + Number(TPAamount));

            if (document.getElementById(ID2).value != '') {
                if (Number(document.getElementById(ID1).innerHTML) < Number(tot)) {
                    alert('Amount is greater than bill amount');
                }
            }
            else {
                alert('Provide received amount');
            }
        }
        function ClickWriteOff(obj, ddlstatus, txtApprovedBy, txtApprovedDate) {
            var obj = document.getElementById(obj);
            if (obj.checked) {
                document.getElementById(ddlstatus).selectedIndex = 1;
                document.getElementById(txtApprovedBy).disabled = false;
                document.getElementById(txtApprovedDate).disabled = false;
            }
            else {
                document.getElementById(ddlstatus).selectedIndex = 0;
                document.getElementById(txtApprovedBy).disabled = true;
                document.getElementById(txtApprovedDate).disabled = true;
                document.getElementById(txtApprovedBy).value = '';
                document.getElementById(txtApprovedDate).value = '';
            }


        }

        function CalcItemCost(lblClaimfromTPA, lblPaidByTPA, lblTDSPaid, txtAmtFromTPA,
                            txtTDS, txtDiscountAmt, lblSettledAmt, lblDisallowedAmt,
                            hdnSettledAmt, hdnDisallowedAmt, ddlStatus, lblPreviousDisc, chkBoxWO, txtApprovedBy, txtApprovedDate) {

            var lblClaimfromTPA = document.getElementById(lblClaimfromTPA);
            var lblPaidByTPA = document.getElementById(lblPaidByTPA);
            var lblTDSPaid = document.getElementById(lblTDSPaid);
            var txtAmtFromTPA = document.getElementById(txtAmtFromTPA);

            var txtTDS = document.getElementById(txtTDS);
            var txtDiscountAmt = document.getElementById(txtDiscountAmt);

            var lblSettledAmt = document.getElementById(lblSettledAmt);
            var lblDisallowedAmt = document.getElementById(lblDisallowedAmt);

            var hdnSettledAmt = document.getElementById(hdnSettledAmt);
            var hdnDisallowedAmt = document.getElementById(hdnDisallowedAmt);
            var lblPreviousDisc = document.getElementById(lblPreviousDisc);

            var tempSettledAmt = 0;
            var settledAmt = 0;
            var disallowedAmt = 0
            lblClaimfromTPA.innerHTML = chkIsnumber(lblClaimfromTPA.innerHTML);
            lblPaidByTPA.innerHTML = chkIsnumber(lblPaidByTPA.innerHTML);
            lblTDSPaid.innerHTML = chkIsnumber(lblTDSPaid.innerHTML);
            txtAmtFromTPA.value = chkIsnumber(txtAmtFromTPA.value);
            txtTDS.value = chkIsnumber(txtTDS.value);
            txtDiscountAmt.value = chkIsnumber(txtDiscountAmt.value);
            lblSettledAmt.innerHTML = chkIsnumber(lblSettledAmt.innerHTML);
            lblDisallowedAmt.innerHTML = chkIsnumber(lblDisallowedAmt.innerHTML);
            lblPreviousDisc.innerHTML = chkIsnumber(lblPreviousDisc.innerHTML);

            settledAmt = Number(lblPaidByTPA.innerHTML) + Number(lblTDSPaid.innerHTML) + Number(txtAmtFromTPA.value) + Number(txtTDS.value);
            tempSettledAmt = Number(lblPaidByTPA.innerHTML) + Number(lblTDSPaid.innerHTML) + Number(txtAmtFromTPA.value) + Number(txtTDS.value) + Number(txtDiscountAmt.value) + Number(lblPreviousDisc.innerHTML);
            if (settledAmt < 0) {
                lblSettledAmt.innerHTML = hdnSettledAmt.value = "0.00";
            }
            else {
                lblSettledAmt.innerHTML = hdnSettledAmt.value = settledAmt.toFixed(2)
            }
            if (settledAmt > 0) {
                disallowedAmt = Number(lblClaimfromTPA.innerHTML) - Number(lblSettledAmt.innerHTML) - Number(txtDiscountAmt.value) - Number(lblPreviousDisc.innerHTML);
            }
            if (disallowedAmt <= 0) {
                lblDisallowedAmt.innerHTML = hdnDisallowedAmt.value = "0.00";
                document.getElementById(chkBoxWO).checked = false;
                document.getElementById(chkBoxWO).disabled = true;
                document.getElementById(txtApprovedBy).disabled = true;
                document.getElementById(txtApprovedDate).disabled = true;
                document.getElementById(txtApprovedBy).value = '';
                document.getElementById(txtApprovedDate).value = '';
            }
            else {
                lblDisallowedAmt.innerHTML = hdnDisallowedAmt.value = disallowedAmt.toFixed(2);
                document.getElementById(chkBoxWO).checked = false;
                document.getElementById(chkBoxWO).disabled = false;
                document.getElementById(txtApprovedBy).disabled = true;
                document.getElementById(txtApprovedDate).disabled = true;
                document.getElementById(txtApprovedBy).value = '';
                document.getElementById(txtApprovedDate).value = '';
            }

            if (lblDisallowedAmt.innerHTML == "0.00" && (lblClaimfromTPA.innerHTML == tempSettledAmt)) {
                document.getElementById(ddlStatus).selectedIndex = 1;
            }
            else {
                document.getElementById(ddlStatus).selectedIndex = 0;

            }



        }
        function expandTextBox(id) {

            document.getElementById(id).rows = "5";
            document.getElementById(id).cols = "150";

        }
        function collapseTextBox(id) {

            document.getElementById(id).rows = "2";
            document.getElementById(id).cols = "20";


        }
        function checkTotal(ID1, ID2, TPAamount) {
            //            alert('Total');
            //            alert(ID1);
            //            alert(ID2);
            // alert(document.getElementById(ID2).value);
            var tot = (Number(document.getElementById(ID2).value) + Number(TPAamount));

            if (document.getElementById(ID2).value != '') {
                if (Number(document.getElementById(ID1).innerHTML) < Number(tot)) {
                    alert('Amount is greater than bill amount');
                }
            }
            else {
                alert('Provide received amount');
            }


        }

        function chkStatus(lblDisallowedAmt, ddlStatus, chkBoxWO) {
            var lblDisallowedAmt = document.getElementById(lblDisallowedAmt);
            var objchkBoxWO = document.getElementById(chkBoxWO);
            if (objchkBoxWO.checked) {
                document.getElementById(ddlStatus).selectedIndex = 1;
                alert('Status cannot be Pending.');
                return false;
            }
            if (Number(lblDisallowedAmt.innerHTML) > 0) { 
                document.getElementById(ddlStatus).selectedIndex = 0;
                alert('Status cannot be Completed.');
                return false;
            }
            if (Number(lblDisallowedAmt.innerHTML) <= 0) {
                document.getElementById(ddlStatus).selectedIndex = 1;
                alert('Status cannot be Pending.');
                return false;
            }


        }

        function ShowStatus() {
            var gv = document.getElementById("grdTPA");
            var items = gv.getElementsByTagName('select');
            var chk = gv.getElementsById('grdTPA_ctl02_chkBoxWO')
            var disallowedamt = gv.getElementById('grdTPA_ctl02_hdnDisallowedAmt');

            var flag = 0;
            if (chk.checked)
                flag = 1;
            for (i = 0; i < items.length; i++) {
                if (items[i].type == "select-one") {
                    var index = items[i].selectedIndex;
                    if (items[i].options[index].value == "Completed") {
                        alert("Please select value");
                        break;
                    }
                }
            }
        }

        function checkForValues() {

            var HidValue = document.getElementById('hdnChkValues').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnChkValues').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var gridItems = list[count].split('~');
                    if (gridItems.length > 1) {


                        if (document.getElementById(gridItems[5]).checked) {
                            if (document.getElementById(gridItems[8]).value == '') {
                                document.getElementById(gridItems[8]).value = '0';
                            }
                            if (gridItems[7] != "0") {
                                var TotAmt = (Number(document.getElementById(gridItems[1]).innerText) + Number(document.getElementById(gridItems[2]).value) + Number(document.getElementById(gridItems[6]).innerText) + Number(document.getElementById(gridItems[7]).innerText) + Number(document.getElementById(gridItems[8]).value));
                            }
                            else {
                                var TotAmt = (Number(document.getElementById(gridItems[1]).innerText) + Number(document.getElementById(gridItems[2]).value) + Number(document.getElementById(gridItems[6]).innerText) + Number(document.getElementById(gridItems[8]).value));
                            }
                            var billAmt = (Number(document.getElementById(gridItems[0]).innerText));

                            if (document.getElementById(gridItems[2]).value == '') {
                                alert('Provide the TPA amount');
                                document.getElementById(gridItems[2]).focus();
                                return false;
                            }
                            if (Number(TotAmt) > Number(billAmt)) {
                                alert('Amount provided is greater than Claim amount');
                                document.getElementById(gridItems[2]).focus();
                                return false;
                            }
                            if (document.getElementById(gridItems[3]).value == '') {
                                alert('Provide Cheque or DD Number');
                                document.getElementById(gridItems[3]).focus();
                                return false;
                            }

                            if (document.getElementById(gridItems[4]).value == '') {
                                alert('Provide the bank name');
                                document.getElementById(gridItems[4]).focus();
                                return false;
                            }
                        }

                    }
                }
            }
            var ans = confirm("Do you want to Save the entered Details");
            if (ans == true) {

                return true;

            }
            else {
                return false;
            }

        }


        function keyDownNumber() {
            var key;
            if (navigator.appName == 'Microsoft Internet Explorer')
                key = event.keyCode;
            else
                key = event.which

            if ((key >= 65 && key <= 90) || (key >= 97 && key <= 122) || (key == 8) || (key == 9)) {
                event.returnValue = true;
            }
            else {
                event.returnValue = false;
            }



        }
        function alternate(id) {
            if (document.getElementsByTagName) {
                var table = document.getElementById(id);
                var rows = table.getElementsByTagName("tr");
                for (i = 0; i < rows.length; i++) {
                    //manipulate rows <br>

                    if (i == 0)
                        rows[i].className = "dataheader1";
                    else {
                        if (i % 2 == 0) {
                            rows[i].className = "even";
                        } else {
                            rows[i].className = "odd";
                        }
                    }
                }
            }
        }
        function PreviousPayments(hdnComments) {

            var oTable = document.getElementById("tblDiagnosisItems");
            while (oTable.rows.length > 0)
                oTable.deleteRow(oTable.rows.length - 1);

            if (document.getElementById('tblDiagnosisItems').rows.length < 1) {
                var row = document.getElementById('tblDiagnosisItems').insertRow(0);
                row.style.background.bold;
                row.id = 0;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);

                cell1.innerHTML = "Paid By TPA";
                cell1.width = "45%";
                cell2.innerHTML = "Payment Type";
                cell2.width = "15%";
                cell3.innerHTML = "TDS Paid";
                cell3.width = "15%";
                cell4.innerHTML = "Cheque/DD Number";
                cell4.width = "15%";
                cell5.innerHTML = "Bank Name";
                cell5.width = "15%";
                cell6.innerHTML = "Paid Date";
                cell6.width = "15%";

            }



            var rwNumber = parseInt(110);
            //var hdnComments = document.getElementById(hdnComments);
            var list = hdnComments.split(',');
            if (list.length > 0 && list.value != '') {

                for (var i = 0; i < list.length; i++) {
                    var tempList = list[i].split('-');

                    var row = document.getElementById('tblDiagnosisItems').insertRow(1);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);
                    cell1.innerHTML = tempList[0];
                    cell1.width = "45%";
                    cell2.innerHTML = tempList[1];
                    cell2.width = "15%";
                    cell3.innerHTML = tempList[2];
                    cell3.width = "15%";
                    cell4.innerHTML = tempList[3];
                    cell4.width = "15%";
                    cell5.innerHTML = tempList[4];
                    cell5.width = "15%";
                    cell6.innerHTML = tempList[5];
                    //cell5.innerHTML = "";

                }

                alternate('tblDiagnosisItems')

            }

        }

        function PreviousPaymentsClear(hdnComments) {
            var hdnComments = document.getElementById(hdnComments);
            hdnComments.value = '';
        }

        function showModalPopup(hdnComments) {
            var hdnComments = document.getElementById(hdnComments);
            document.getElementById('pnlOthers').style.display = "none";

            if (hdnComments.value != '') {
                var modalPopupBehavior = $find('mpeOthersBehavior');
                modalPopupBehavior.show();
                PreviousPayments(hdnComments.value);
            }
            else {
                alert("No Previous Payment made this patient");
            }


        }
        function closePopup() {
            var modalPopupBehavior = $find('mpeOthersBehavior');
            modalPopupBehavior.hide();
        }
    </script>

</head>
<body>
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div style="display: none;">
        <t1:Theme ID="Theme1" runat="server" />
    </div>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc112:Header ID="AdminHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc121:LeftMenu ID="LeftMenu1" runat="server" />
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
                        <asp:UpdatePanel ID="pnl" runat="server">
                            <ContentTemplate>
                                <table width="100%">
                                    <tr>
                                        <td align="center">
                                            <asp:Label ForeColor="Red" Font-Bold="True" runat="server" ID="lblStatus" meta:resourcekey="lblStatusResource1"></asp:Label>
                                            <div align="Right">
                                                <asp:LinkButton ID="lnkHome" runat="server" CssClass="details_label_age" OnClick="lnkHome_Click"
                                                    meta:resourcekey="lnkHomeResource1">Home &nbsp;</asp:LinkButton>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:HiddenField ID="hdnChkValues" runat="server" />
                                            <asp:GridView ID="grdTPA" runat="server" AutoGenerateColumns="False" DataKeyNames="PatientID,PatientVisitID,FinalBillID"
                                                PageSize="1" OnRowDataBound="grdTPACollection_RowDataBound" Width="100%" OnRowCommand="grdTPACollection_RowCommand"
                                                meta:resourcekey="grdTPAResource1">
                                                <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <HeaderStyle CssClass="dataheader1" />
                                                <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                    PageButtonCount="5" PreviousPageText="" />
                                                <Columns>
                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkBox" runat="server" Checked="True" meta:resourcekey="chkBoxResource1" />
                                                            <%--<asp:Label Visible="false" ID="lblComments" Text='<%# DataBinder.Eval(Container.DataItem,"Comments") %>'
                                                                runat="server"></asp:Label>--%>
                                                            <asp:HiddenField ID="hdnComments" Value='<%# DataBinder.Eval(Container.DataItem,"Comments") %>'
                                                                runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <%--<asp:LinkButton ID="lnkButton" runat="server" Text="Pre" ></asp:LinkButton>--%>
                                                            <%--  <input id="lnkButton" runat="server" style="cursor:hand;no-repeat;background-image:url('../Images/show.png');"
                                                                 />--%>
                                                            <img alt="" src="../Images/view_button.gif" id="showmenu" style="cursor: pointer;" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="PatientID" HeaderText="PatientID" Visible="False" meta:resourcekey="BoundFieldResource1" />
                                                    <asp:BoundField DataField="Name" HeaderText="Name" meta:resourcekey="BoundFieldResource2">
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="TPAName" HeaderText="TPA/Corporate Name" meta:resourcekey="BoundFieldResource3">
                                                        <HeaderStyle Width="100px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="BillAmount" HeaderText="Bill Amount">
                                                        <HeaderStyle Width="60px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="CoPaymentAmount" HeaderText="Co-Pay Amt">
                                                        <HeaderStyle Width="60px" />
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Claim From TPA">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblBillAmt" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TPABillAmount") %>'
                                                                meta:resourcekey="lblBillAmtResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="60px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Paid By TPA" meta:resourcekey="TemplateFieldResource3">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTPAAmount" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TPAAmount") %>'
                                                                meta:resourcekey="lblTPAAmountResource1"></asp:Label>
                                                            <asp:LinkButton CommandName="OEdit" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                ID="lnkEdit" runat="server" Text="Edit" ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="50px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="TDS Paid">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTDSPaid" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TDS") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Pre Disc Amt">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblPreviousDisc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TPADiscountAmt") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Amount From TPA" meta:resourcekey="TemplateFieldResource4">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtTPAAmount"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                                Width="80px" runat="server" MaxLength="11" meta:resourcekey="txtTPAAmountResource1"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="60px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Write Off" meta:resourcekey="TemplateFieldResource5">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkBoxWO" runat="server" meta:resourcekey="chkBoxWOResource1" />
                                                            <asp:Label Visible="False" ID="lblWriteOff" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"RightOff") %>'
                                                                meta:resourcekey="lblWriteOffResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="20px" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="TDS" meta:resourcekey="TemplateFieldResource6">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtTDS"  onkeypress="return ValidateOnlyNumeric(this);"  Width="40px"
                                                                runat="server" meta:resourcekey="txtTDSResource1"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Disc Amt">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtDiscountAmt" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <ControlStyle Width="40px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField ItemStyle-HorizontalAlign="Right" HeaderText="Settled Amt">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblSettledAmt" Text="0.00" runat="server"></asp:Label>
                                                            <asp:HiddenField ID="hdnSettledAmt" Value="0.00" runat="server" />
                                                        </ItemTemplate>
                                                        <ControlStyle Width="60px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField ItemStyle-HorizontalAlign="Right" HeaderText="Disallowed Amt">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblDisallowedAmt" Text="0.00" runat="server"></asp:Label>
                                                            <asp:HiddenField ID="hdnDisallowedAmt" Value="0.00" runat="server" />
                                                        </ItemTemplate>
                                                        <ControlStyle Width="60px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Payment Type" meta:resourcekey="TemplateFieldResource7">
                                                        <ItemTemplate>
                                                            <asp:DropDownList ID="ddlCashType" runat="server" Width="86px" meta:resourcekey="ddlCashTypeResource1">
                                                                <asp:ListItem Text="Cheque" Value="2" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                <asp:ListItem Text="Demand Draft" Value="4" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Cheque/DD No" meta:resourcekey="TemplateFieldResource8">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtChqNo" runat="server" meta:resourcekey="txtChqNoResource1"></asp:TextBox>
                                                            <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="filtxtChqNo"
                                                                TargetControlID="txtChqNo" Enabled="True">
                                                            </ajc:FilteredTextBoxExtender>
                                                        </ItemTemplate>
                                                        <ControlStyle Width="60px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Bank Name" meta:resourcekey="TemplateFieldResource9">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtBankName" onkeydown="javascript:return keyDownNumber();" runat="server"
                                                                meta:resourcekey="txtBankNameResource1"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <ControlStyle Width="40px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Status" meta:resourcekey="TemplateFieldResource10">
                                                        <ItemTemplate>
                                                            <asp:DropDownList ID="ddlStatus" runat="server" meta:resourcekey="ddlStatusResource1">
                                                                <asp:ListItem Text="Pending" Value="Pending" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                                <asp:ListItem Text="Completed" Value="Completed" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </ItemTemplate>
                                                        <ControlStyle Width="70px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Settlement Date" meta:resourcekey="TemplateFieldResource11">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtFrom" runat="server" MaxLength="1" Style="text-align: justify"
                                                                ValidationGroup="MKE" Width="70px" meta:resourcekey="txtFromResource1" />
                                                            <%-- <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImageButton1Resource1" />--%>
                                                            <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFrom"
                                                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                Enabled="True" />
                                                            <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                                ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                            <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFrom"
                                                                PopupButtonID="ImageButton1" Format="dd/MM/yyyy" Enabled="True" />
                                                            <%--  &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                                        </ItemTemplate>
                                                        <ControlStyle Width="70px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Claim Forwared Date" meta:resourcekey="TemplateFieldResource12">
                                                        <ItemTemplate>
                                                            <asp:TextBox Enabled="false" ID="txtFromCF" runat="server" MaxLength="1" Style="text-align: justify"
                                                                ValidationGroup="MKE" Width="80px" meta:resourcekey="txtFromCFResource1" />
                                                            <%--<asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImageButton2Resource1" />--%>
                                                            <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtFromCF"
                                                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                Enabled="True" />
                                                            <ajc:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                                                ControlToValidate="txtFromCF" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" meta:resourcekey="MaskedEditValidator2Resource1" />
                                                            <%--<ajc:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtFromCF"
                                                                PopupButtonID="ImageButton2" Format="dd/MM/yyyy" Enabled="True" />--%>
                                                            <%--&nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Approved By">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtApprovedBy" Enabled="false" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <ControlStyle Width="40px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Approved Date">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtApprovedDate" Enabled="false" Width="80px" runat="server" Style="text-align: justify"
                                                                ValidationGroup="MKE" />
                                                            <ajc:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="txtApprovedDate"
                                                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                Enabled="True" />
                                                            <ajc:MaskedEditValidator ID="MaskedEditValidator3" runat="server" ControlExtender="MaskedEditExtender3"
                                                                ControlToValidate="txtApprovedDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" />
                                                            <ajc:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtApprovedDate"
                                                                Format="dd/MM/yyyy" PopupButtonID="imgApproved" Enabled="True" />
                                                        </ItemTemplate>
                                                        <ControlStyle Width="80px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Remarks">
                                                        <ItemTemplate>
                                                            <asp:TextBox TextMode="MultiLine" ID="txtRemaks" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <ControlStyle Width="200px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField Visible="false" HeaderText="Admission Date">
                                                        <ItemTemplate>
                                                            <asp:label  ID="lblAdmissionDate" Text='<%# Eval("AdmissionDate", "{0:dd/MM/yyyy}") %>' runat="server"></asp:label>
                                                            <asp:HiddenField ID="hdnAdmissionDate" runat="server" />
                                                        </ItemTemplate>
                                                        <ControlStyle Width="200px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField Visible="false" HeaderText="Discharge Date">
                                                        <ItemTemplate>
                                                            <asp:label ID="lblDischargeDate" Text='<%# Eval("ModifiedAt", "{0:dd/MM/yyyy}") %>'  runat="server"></asp:label>
                                                            <asp:HiddenField ID="hdnDischargeDate" runat="server" />
                                                        </ItemTemplate>
                                                        <ControlStyle Width="200px" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:HiddenField ID="hdnVisitID" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <table>
                                                <tr>
                                                    <td align="center">
                                                        <asp:Button ID="bGo" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'" OnClick="bGo_Click" OnClientClick="javascript:return checkForValues();"
                                                            meta:resourcekey="bGoResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnClose" CssClass="btn" runat="server" Text="Cancel" onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'" OnClick="btnCancel_Click" />
                                                    </td>
                                                    <td style="display:none;">
                                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn"  meta:resourcekey="btnCancelResource1" />
                                                    </td>
                                                    
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <asp:Panel ID="pnlOthers" runat="server" Style="display: none;" CssClass="modalPopup dataheaderPopup">
                                    <center>
                                        <div id="divOthers" style="width: 450px; height: 180px; padding-top: 50px; padding-left: 15px">
                                            <table width="90%" align="center">
                                                <tr align="left">
                                                    <td>
                                                        <table id="tblDiagnosisItems" class="dataheaderInvCtrl" runat="server" cellpadding="4"
                                                            cellspacing="0" border="1">
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center">
                                                        <input type="button" id="btnpopClose" onclick="javascript:return closePopup();" class="btn"
                                                            runat="server" value="Close" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </center>
                                </asp:Panel>
                                <ajc:ModalPopupExtender ID="mpeOthers" runat="server" BehaviorID="mpeOthersBehavior"
                                    PopupControlID="pnlOthers" TargetControlID="hiddenTargetControlFormpeOthers"
                                    CancelControlID="btnCancel" DynamicServicePath="" Enabled="True">
                                </ajc:ModalPopupExtender>
                                <asp:HiddenField ID="hiddenTargetControlFormpeOthers" runat="server" />
                                <table width="80%">
                                    <tr>
                                        <td>
                                            <asp:Panel ID="pnlPaymentDetail" runat="server" CssClass="modalPopup dataheaderPopup"
                                                Width="90%" Style="display: none" meta:resourcekey="pnlPaymentDetailResource1">
                                                <div style="overflow: auto;">
                                                    <table border="0" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="gvTPAItems" Width="100%" runat="server" AutoGenerateColumns="False"
                                                                    DataKeyNames="TPAPaymentID,VisitID,FinalBillID,DueDetails,TPAPaymentStatus" PageSize="1"
                                                                    OnRowCommand="gvTPAItems_RowCommand" OnRowDataBound="gvTPAItems_RowDataBound"
                                                                    meta:resourcekey="gvTPAItemsResource1">
                                                                    <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                                        PageButtonCount="5" PreviousPageText="" />
                                                                    <Columns>
                                                                        <asp:BoundField DataField="CreatedAt" HeaderText="Date" meta:resourcekey="BoundFieldResource4" />
                                                                        <asp:TemplateField HeaderText="Amount to be Updated" meta:resourcekey="TemplateFieldResource13">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtTPAAmount"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                                                    Width="80%" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Amount") %>'
                                                                                    meta:resourcekey="txtTPAAmountResource2"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="20%"></ItemStyle>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="TDS" meta:resourcekey="TemplateFieldResource14">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtTDS"  onkeypress="return ValidateOnlyNumeric(this);"  Width="80%"
                                                                                    runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TDS") %>' meta:resourcekey="txtTDSResource2"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="10%" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Payment Type" meta:resourcekey="TemplateFieldResource15">
                                                                            <ItemTemplate>
                                                                                <asp:DropDownList ID="ddlCashTypeC" runat="server" meta:resourcekey="ddlCashTypeCResource1">
                                                                                    <asp:ListItem Text="Cheque" Value="2" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                                                    <asp:ListItem Text="Demand Draft" Value="4" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="8%" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Cheque/DD No" meta:resourcekey="TemplateFieldResource16">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtChqNoC"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                                                    runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ChequeorCardNumber") %>'
                                                                                    meta:resourcekey="txtChqNoCResource1"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="10%" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Bank Name" meta:resourcekey="TemplateFieldResource17">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtBankNameC" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"BankNameorCardType") %>'
                                                                                    meta:resourcekey="txtBankNameCResource1"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="10%" />
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">
                                                                <asp:Label ID="Rs_Status" Text="Status:" runat="server" meta:resourcekey="Rs_StatusResource1"></asp:Label>
                                                                <asp:DropDownList ID="ddlStatusC" runat="server" meta:resourcekey="ddlStatusCResource1">
                                                                    <asp:ListItem Text="Pending" Value="Pending" meta:resourcekey="ListItemResource7"></asp:ListItem>
                                                                    <asp:ListItem Text="Completed" Value="Completed" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr align="center">
                                                            <td>
                                                                <asp:Label ID="Rs_SettlemetDate" Text="Settlemet Date :" runat="server" meta:resourcekey="Rs_SettlemetDateResource1"></asp:Label>
                                                                <asp:TextBox ID="txtSettlementDate" runat="server" Width="130px" TabIndex="13" MaxLength="1"
                                                                    Style="text-align: justify" ValidationGroup="MKE" meta:resourcekey="txtSettlementDateResource1" />
                                                                <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                    CausesValidation="False" meta:resourcekey="ImageButton2Resource2" />
                                                                <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtSettlementDate"
                                                                    Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                    Enabled="True" />
                                                                <ajc:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtSettlementDate"
                                                                    PopupButtonID="ImageButton2" Format="dd/MM/yyyy" Enabled="True" />
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                        </tr>
                                                        <tr align="center">
                                                            <td>
                                                                <asp:Label ID="Rs_ClaimForwaredDate" Text="Claim Forwared Date:" runat="server" meta:resourcekey="Rs_ClaimForwaredDateResource1"></asp:Label>
                                                                <asp:TextBox ID="txtClaimFD" runat="server" Width="130px" TabIndex="15" MaxLength="1"
                                                                    Style="text-align: justify" ValidationGroup="MKE" meta:resourcekey="txtClaimFDResource1" />
                                                                <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                    CausesValidation="False" meta:resourcekey="ImageButton3Resource1" />
                                                                <ajc:MaskedEditExtender ID="MaskedEditExtender4" runat="server" TargetControlID="txtClaimFD"
                                                                    Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                    Enabled="True" />
                                                                <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtClaimFD"
                                                                    PopupButtonID="ImageButton3" Format="dd/MM/yyyy" Enabled="True" />
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">
                                                                <asp:Button ID="btnSave" runat="server" Text="Update" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                    onmouseout="this.className='btn'" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                                                <asp:Button ID="BtnClosePaymentDetail" runat="server" Text="Close" CssClass="btn"
                                                                    meta:resourcekey="BtnClosePaymentDetailResource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </asp:Panel>
                                            <ajc:ModalPopupExtender ID="ModelPopPaymentDetail" runat="server" TargetControlID="btnR"
                                                PopupControlID="pnlPaymentDetail" BackgroundCssClass="modalBackground" OkControlID="BtnClosePaymentDetail"
                                                DynamicServicePath="" Enabled="True" />
                                            <input type="button" id="btnR" runat="server" style="display: none;" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <input id="poNoid" type="hidden" value="0" runat="server" />
        <input id="SupID" type="hidden" value="0" runat="server" />
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
