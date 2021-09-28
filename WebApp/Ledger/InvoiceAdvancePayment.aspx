<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvoiceAdvancePayment.aspx.cs"
    Inherits="Ledger_InvoiceAdvancePayment" EnableEventValidation="false" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="~/CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay"
    TagPrefix="uc7" %>

<script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Invoice Advance Payment</title>
    <style type="text/css">
        .schedule_title
        {
            width: 452px;
            color: #fff;
            font-weight: bold;
            background: #3D667F;
            margin: 50px auto 0 auto;
            height: 15px;
            text-align: center;
            padding: 10px 0;
        }
        .scheduledataheader2
        {
            background: #d8dfd8;
            width: 452px;
            margin: 0px auto 0 !important;
            border: 0.12em solid #446d87;
            padding: 15px;
        }
        #DivLpwd table tr td span
        {
            font-weight: bold;
            box-shadow: none !important;
            font-family: arial;
        }
        #DivRpwd table tr td span
        {
            font-weight: bold;
            box-shadow: none !important;
            font-family: arial;
        }
        #DivCash table tr td span
        {
            font-weight: bold;
            box-shadow: none !important;
            font-family: arial;
        }
        #DivCheque table tr td span
        {
            font-weight: bold;
            box-shadow: none !important;
            font-family: arial;
        }
        #DivRpwd.scheduledataheader2
        {
            margin: 50px auto 0;
            padding: 15px;
        }
        #DivCash.scheduledataheader2
        {
            margin: 50px auto 0;
            padding: 15px;
        }
        #DivCheque.scheduledataheader2
        {
            margin: 50px auto 0;
            padding: 15px;
        }
    </style>
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
 <link href="../StyleSheets/DataTable/demo_page.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DataTable/demo_table.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DataTable/demo_table_jui.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet"
        type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div id="pendingProgress" style="display: none;">
        <div id="progressBackgroundFilter" class="a-center">
        </div>
        <div id="processMessage" class="a-center w-20p">
            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                meta:resourcekey="img1Resource1" />
        </div>
    </div>
    <div class="contentdata">
        <div class="schedule_title" id="DivReciept">
            INVOICE ADVANCE PAYMENT
        </div>
        <div class="scheduledataheader2 a-center" id="DivRpwd" runat="server">
            <table class="w-100p a-center">
                <tr>
                    <td class="a-left w-35p" nowrap="nowrap">
                        <asp:Label ID="lblRClientName" runat="server" Text="TSP Code"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:HiddenField ID="hdnRClientid" runat="server" />
                        <asp:TextBox ID="txtRClientName" runat="server" autocomplete="off" CssClass="medium"></asp:TextBox>
                        <cc1:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtRClientName"
                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                            MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="FetchClientNameForBilling"
                            OnClientItemSelected="SetRClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                            OnClientItemOver="SelectedClient" Enabled="True">
                        </cc1:AutoCompleteExtender>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 3px;">
                    </td>
                </tr>
                <tr>
                    <td class="emptyrow">
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblCashDate" runat="server" Text="Date"></asp:Label>
                         <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtCashDate" Width="200px" MaxLength="25" size="20" CssClass="datePicker"
                            onchange="FromDateCheck();" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;<br />
                    </td>
                </tr>
                <tr>
                    <td class="emptyrow">
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblCashAmount" runat="server" Text="Amount"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtCashAmount" Width="200px" MaxLength="8" runat="server" onkeypress="return NumbersOnly(event);"
                            onblur="validateCash()"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;<br />
                    </td>
                </tr>
                <tr>
                    <td class="emptyrow">
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblReCashAmount" runat="server" Text="Re-Enter Amount"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtCashReAmount" Width="200px" MaxLength="8" runat="server" onblur="validateCashAmount()"
                            onkeypress="return NumbersOnly(event);"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;<br />
                    </td>
                </tr>
                <tr>
                    <td class="emptyrow">
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblType" runat="server" Text="Type"></asp:Label>
                         <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:DropDownList ID="ddlType" runat="server">
                            <asp:ListItem Value="0">--Select--</asp:ListItem>
                            <asp:ListItem Value="1">Cash</asp:ListItem>
                            <asp:ListItem Value="2">Cheque</asp:ListItem>
                            <asp:ListItem Value="2">Demand Draft</asp:ListItem>
                            <asp:ListItem Value="2">Bank Deposit</asp:ListItem>
                            <asp:ListItem Value="3">Online</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        &nbsp;<br />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 3px;">
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 3px;">
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblCashRemarks" runat="server" Text="Remarks"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtCashRemarks" runat="server" TextMode="MultiLine" MaxLength="200"
                            Width="200px" onKeyUp="Count(this,200)" onChange="Count(this,200)"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;<br />
                    </td>
                </tr>
                <tr>
                    <td class="emptyrow">
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblProofCopy" runat="server" Text="Proof Copy"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:FileUpload ID="fpProofCopy" runat="server" accept="gif|GIF|jpg|JPG|png|PNG|bmp|BMP|jpeg|JPEG"
                            ToolTip="Upload GIF,JPG,PNG,BMP and JPEG images only" />
                        <asp:RegularExpressionValidator ID="uplValidator" runat="server" ControlToValidate="fpProofCopy"
                            ErrorMessage=".jpg, .gif,.png & .jpeg formats are allowed" ValidationExpression="(.+\.([Jj][Pp][Gg])|.+\.([Pp][Nn][Gg])|.+\.([Gg][Ii][Ff])|.+\.([Jj][Pp][Ee][Gg]))">

                        </asp:RegularExpressionValidator>
                    </td>
                    <td>
                        &nbsp;<br />
                    </td>
                </tr>
                <tr>
                    <td class="emptyrow">
                    </td>
                </tr>
                <tr>
                    <td class="a-center" colspan="3">
                        <asp:Button ID="btnCashSubmit" runat="server" Text="Submit" OnClientClick="javascript:return Cashvalidate()"
                            OnClick="btnCashSubmit_Click" CssClass="btn" />
                        &nbsp;
                        <asp:Button ID="btnCashReset" runat="server" Text="Cancel" CssClass="btn" OnClick="btnCashReset_Click" />
                    </td>
                </tr>
                <tr>
                    <td class="a-left w-35p" nowrap="nowrap">
                        &nbsp;
                    </td>
                    <td align="right">
                        <img align="middle" alt="" src="../Images/starbutton.png" /> Mandatory Fields
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </div>
        <%-- ---Murali----%>
        <%--</ContentTemplate> </asp:UpdatePanel>--%>
    </div>
    <asp:HiddenField ID="hdnBarcodeNumber" runat="server" />
    <asp:HiddenField ID="hdnCID" runat="server" />
    <asp:HiddenField ID="hdnPaymentType" runat="server" />
    <asp:HiddenField ID="hdnClientLoginID" runat="server" />
    <asp:HiddenField ID="hdnDate" runat="server" />
    <asp:HiddenField ID="hdnOrgID" runat="server" />
    <asp:HiddenField ID="hdnDrivePath" runat="server" />
    <%--  <asp:HiddenField ID="handlerpath" runat="server" /> value="F:\\ReceiptEntryImages\\"  --%>
    <asp:HiddenField ID="FileName" runat="server" />
    <Attune:Attunefooter ID="Footer1" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">
        function NumbersOnly(e) {
            var charCode = e.charCode ? e.charCode : e.keyCode

            var testValue = document.getElementById('txtCashAmount').value;

            if (charCode != 8 && charCode != 9 && charCode != 46) {
                if (charCode < 48 || charCode > 57)
                    return false;
            }

        }
    </script>

    <script language="javascript" type="text/javascript">
        $(document).ready(function() {
            // GetNattation();
            // enableEntry();

        });


        function ClearData() {
            document.getElementById('txtEnterBarCode').value = "";
            document.getElementById('txtReEnterBarCode').value = "";
            document.getElementById('txtEnterAmount').value = "";
            document.getElementById('txtReEnterAmount').value = "";
            document.getElementById('txtRemarks').value = "";
        }


        function Reset() {
            //document.getElementById('ddlEntrytype').SelectedItem == "C"
            document.getElementById('txtRClientName').value = '';
            document.getElementById('hdnRClientid').value = '';
            document.getElementById('txtcashPhysicalReceiptNo').value = '';
            document.getElementById('txtCashAmount').value = '';
            document.getElementById('txtCashReAmount').value = '';
            document.getElementById('txtCashRemarks').value = '';
            document.getElementById('txtChequePhysicalReceiptNo').value = '';
            document.getElementById('txtBankName').value = '';
            document.getElementById('txtChequeNumber').value = '';
            document.getElementById('txtReChequeNumber').value = '';
            document.getElementById('txtChequeEnterAmount').value = '';
            document.getElementById('txtChequeAmount').value = '';
            document.getElementById('txtChequeRemarks').value = '';
            //window.location.href = "../Ledger/ClientCreditDebit.aspx";
            return true;
        }
    </script>

    <script language="javascript" type="text/javascript">

        function SelectedClient(source, eventArgs) {
            $find('AutoCompleteExtender2')._onMethodComplete = function(result, context) {
                //var Perphysicianname = document.getElementById('txtperphy').value;
                $find('AutoCompleteExtender2')._update(context, result, /* cacheResults */false);
                if (result == "") {
                    alert('Please select from the list');
                    document.getElementById('txtRClientName').value = '';
                    document.getElementById('<%=hdnRClientid.ClientID %>').value = '';
                    document.getElementById('<%=hdnCID.ClientID %>').value = ''
                }
            };
        }
        function SetRClientID(source, eventArgs) {
            // alert(eventArgs.get_value());
            var list = eventArgs.get_value().split('^');
            document.getElementById('<%=hdnRClientid.ClientID %>').value = list[3];
            document.getElementById('<%=hdnCID.ClientID %>').value = list[5];


        }
    </script>

    <script language="javascript" type="text/javascript">

        function FromDateCheck() {
            if ($("#txtCashDate").val() != null) {
                if ($("#txtCashDate").val() != '') {
                    var obj = $("#txtCashDate").val();

                    var currentTime;
                    if (obj != '' && obj != '01/01/1901' && obj != '__/__/____' && obj != 'dd/MM/yyyy') {
                        dobDt = obj.split('/');
                        var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
                        var mMonth = dobDtTime.getMonth() + 1;
                        var mDay = dobDtTime.getDate();
                        var mYear = dobDtTime.getFullYear();
                        currentTime = new Date();
                        var month = currentTime.getMonth() + 1;
                        var day = currentTime.getDate();
                        var year = currentTime.getFullYear();
                        var CurrentFullDate = day + "/" + month + "/" + year;
                        if (mYear == year && mMonth == month && mDay > day) {
                            alert('Selected date should not be greater than currentdate');
                            $("#txtCashDate").val(CurrentFullDate);
                             return false;
                        }
                        else if (mYear > year) {
                            alert('Selected date should not be greater than currentdate');
                            $("#txtCashDate").val(CurrentFullDate);
                            return false;
                        }
                        else if (mYear == year && mMonth > month) {
                            alert('Selected date should not be greater than currentdate');
                            $("#txtCashDate").val(CurrentFullDate);
                            //$("#txtFrom").IsSelectable = false;
                            return false;
                        }
                    }

                }

            }

        }

        function validateCash() {
            var enteredAmount = document.getElementById("<%=txtCashAmount.ClientID%>").value;
            var re = /^\d+(?:\.\d{1,3})?$/;
            if (re.test(enteredAmount)) {
                return true;
            }
            else {
                alert('Please Enter valid amount');
                document.getElementById("<%=txtCashAmount.ClientID%>").value = "";
                //document.getElementById("<%=txtCashAmount.ClientID%>").focus();
                return false;
            }
        }


        function validateCashAmount() {

            var enteredAmount = document.getElementById("<%=txtCashAmount.ClientID%>").value;
            var ReEnteredAmount = document.getElementById("<%=txtCashReAmount.ClientID%>").value;

            if (enteredAmount != '' && ReEnteredAmount != '') {
                if (enteredAmount != ReEnteredAmount) {
                    alert("Amount not matched");
                    document.getElementById("<%=txtCashAmount.ClientID%>").value = "";
                    document.getElementById("<%=txtCashReAmount.ClientID%>").value = "";
                    return false;
                }
            }
        }


        function Cashvalidate() {

            if (document.getElementById("<%=txtRClientName.ClientID%>").value == "" || document.getElementById("<%=txtRClientName.ClientID%>").value == "0") {
                alert("Select the TSP Code");
                document.getElementById("<%=txtRClientName.ClientID%>").focus();
                return false;
            }
            if (document.getElementById("<%=txtCashDate.ClientID%>").value == "") {
                alert("Choose Advance Date ");
                document.getElementById("<%=txtCashDate.ClientID%>").focus();
                return false;
            }

            if (document.getElementById("<%=txtCashAmount.ClientID%>").value == "") {
                alert("Enter the Amount ");
                document.getElementById("<%=txtCashAmount.ClientID%>").focus();
                return false;
            }

            if (document.getElementById("<%=txtCashReAmount.ClientID%>").value == "") {
                alert("Enter the ReEnter Amount");
                document.getElementById("<%=txtCashReAmount.ClientID%>").focus();
                return false;
            }
            if (document.getElementById("<%=ddlType.ClientID%>").value == "0") {
                alert("Select Advance Type");
                document.getElementById("<%=ddlType.ClientID%>").focus();
                return false;
            }

            if (document.getElementById("<%=txtCashRemarks.ClientID%>").value == "") {
                alert("Remarks should not be empty");
                document.getElementById("<%=txtCashRemarks.ClientID%>").focus();
                return false;
            }
            if (document.getElementById("<%=fpProofCopy.ClientID%>").value == "") {
                alert("Please Upload the Proof Copy..!");
                document.getElementById("<%=fpProofCopy.ClientID%>").focus();
                return false;
            }

            SaveReceipt();
            return true;
        }

    </script>

    <script language="javascript" type="text/javascript">

        function imagesave(succescode) {
            debugger;
            var fileUpload = $("#fpProofCopy").get(0);
            var files = fileUpload.files;
            var fileName;
            var data = new FormData();
            for (var i = 0; i < files.length; i++) {
                data.append(files[i].name, files[i]);
            }
            var fp = $("#fpProofCopy");
            var lg = fp[0].files.length; // get length
            var items = fp[0].files;
            if (lg > 0) {
                for (var i = 0; i < lg; i++) {
                    fileName = items[i].name; // get file name
                }
            }

            // document.getElementById('hdnDrivePath').value = GetConfigValue("ReceiptEntryProofPath", OrgID);
            var FolderName = document.getElementById('hdnDrivePath').value;
            var OrgID = parseInt(document.getElementById('hdnOrgID').value);
            var SourceCode = document.getElementById('hdnRClientid').value;
            var PaymentReceiptNo = document.getElementById('txtCashDate').value;
            //var filenamepath = SourceCode + "_" + PaymentReceiptNo + "_"; //FolderName +
            document.getElementById('FileName').value = fileName;
            //var folder;
            $.ajax({
                url: "AjaxFileHandler.ashx?fname=" + FolderName + "&SCRN=" + SourceCode + "_" + succescode + "_INVADV",
                type: "POST",
                data: data,
                //data: "{filenamepath:'" + filenamepath + "','FolderName':'" + FolderName + "'}",
                //data: "{ 'filepath' : 'myFileName' }",  //new                                 
                //contentType: "application/json; charset=utf-8",//new
                contentType: false,
                processData: false,
                //dataType: "json",//new
                success: function(result) {

                    //folder = result;
                    // folder = result(path);
                    //alert('Photocopy Uploaded successfully');
                },
                error: function(err) {
                    alert(err.statusText)
                }
            });
            /* Selva End  */

        }


        function SaveReceipt() {
            debugger;
            var fileUpload = $("#fpProofCopy").get(0);
            var files = fileUpload.files;
            var fileName;
            var data = new FormData();
            for (var i = 0; i < files.length; i++) {
                data.append(files[i].name, files[i]);
            }
            var fp = $("#fpProofCopy");
            var lg = fp[0].files.length; // get length
            var items = fp[0].files;
            if (lg > 0) {
                for (var i = 0; i < lg; i++) {
                    fileName = items[i].name; // get file name
                }
            }
            document.getElementById('FileName').value = fileName;
            var FolderName = document.getElementById('hdnDrivePath').value;
            var FiName = document.getElementById('FileName').value;
            var OrgID = parseInt(document.getElementById('hdnOrgID').value);
            var SourceCode = document.getElementById('hdnRClientid').value;
            var CreatedBy = document.getElementById('hdnClientLoginID').value;
            var CreatedAt = document.getElementById('hdnDate').value;
            var Amount = parseFloat(document.getElementById('txtCashAmount').value);
            var Cashdatetemp = document.getElementById('txtCashDate').value;
            var chunks = Cashdatetemp.split('/');
            var Cashdate = chunks[1] + '/' + chunks[0] + '/' + chunks[2];
            var lstAdvancePay = [];
            var ClientId = document.getElementById('hdnCID').value;
            var e = document.getElementById("ddlType");
            var PaymentType = e.options[e.selectedIndex].text;
            var filenamepath = 'InvoiceLedger|AdvancePayment|' + SourceCode + "|" + SourceCode + "_"; //+ FiName; //get clientcode,receipt no and filname
            var Address = FolderName + filenamepath; //'F:|ReceiptEntryImages|' + filenamepath; ////FolderName +
            var Remarks = document.getElementById('txtCashRemarks').value;
            var a = document.getElementById('hdnRClientid').value;
            //var PaymentType = document.getElementById('ddlType').value;
            lstAdvancePay.push({
                OrgID: OrgID,
                SourceCode: SourceCode,
                PaymentMode: PaymentType,
                Amount: Amount,
                Remarks: Remarks,
                CreatedBy: CreatedBy,
                CreditDate: Cashdate,
                ClientId: ClientId
            });
            debugger;
            var AdvancePayment = JSON.stringify(lstAdvancePay);
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/SaveAdvancePayment",
                contentType: "application/json;charset=utf-8",
                data: "{lstAdvancePayment:'" + AdvancePayment + "','Address':'" + Address + "','Orgid':'" + OrgID + "'}",
                dataType: "json",
                async: false,
                success: function(data) {
                    var succescode = data.d;

                    if (succescode > 0) {
                        imagesave(succescode);
                        alert('Advance Details Sumitted Successfully!');
                        Reset();
                        // window.location = "http://localhost:3602/WebApp/Ledger/InvoicePayment.aspx";

                    }
                    else {
                        alert('Error Exist!');
                        Reset();
                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error");
                    return false;
                }

            });
            return true;
        }

        $('#fpProofCopy').bind('change', function() {
            debugger;
            var validSize = 20;
            var CaptureFileSize = Math.round(this.files[0].size / 1024)
            if (CaptureFileSize > validSize) {
                alert('Uploded File Size Should Be Less Than 20 KB..!!');
                document.getElementById('fpProofCopy').value = ""; 
                return false;
            }

        });

    </script>

<script language="javascript" type="text/javascript">

    function pageLoad() {
        $("#txtCashDate").datepicker({
            dateFormat: 'dd/mm/yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '2008:2050'
        }); // Will run at every postback/AsyncPostback 


    }
    function popupClose() {
        return true;
    }
    $(function() {
    $("#txtCashDate").datepicker({
            dateFormat: 'dd/mm/yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '2008:2050'
        });

    }); 
                      
</script>
</body>
</html>

<script src="../Scripts/CollectSample.js" type="text/javascript"></script>

<script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

<script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.min.js"></script>
