<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SampleScheduling.aspx.cs"
    EnableEventValidation="false" Inherits="Waters_SampleScheduling" meta:resourcekey="PageResource2" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link rel="Stylesheet" type="text/css" href="../StyleSheets/jquery.datatable.css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <link rel="Stylesheet" type="text/css" href="../StyleSheets/Common.css" />
    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <style>
        .Invalid
        {
            border-color: red;
            border: 1px solid #ff0000 !important;
            
            
        }
        .Valid
        {
            border-color: green !important;
            outline: none;
        }
        .txtSampleId
        {
        }
		.buttonbackground
        {
            background:url(../Images/Hist2.png) no-repeat;
             width: 20px;
        height : 25px;
        }

    </style>

    <script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="Scripts/SampleSchedule.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script type="text/javascript">


        $(function() {
            TempDateandTime();

        });


        $(document).ready(function() {
            // attach the event binding function to every partial update
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function(evt, args) {

                $(".txtSampleId").blur(function() {
                    CheckTheSampID(this);
                });

            });
        });
  function LimitTextValidation(limitField, limitNum) {
            if (limitField.value.length > limitNum) {
                limitField.value = limitField.value.substring(0, limitNum);
            } else {
                // limitCount.value = limitNum - limitField.value.length;
            }

        }

        function changestatus(ID, ddlstatusID) {
            debugger;
            var Collectionperson = document.getElementById(ID);
            var element = document.getElementById(ddlstatusID);
            if (Collectionperson.value != "-1") {
                if (ID.value != 0) {

                    element.value = "Assigned";
                }
            }
            else {

                element.value = "Unassigned";
            
            }
            
        }
        function SpecialCharRestriction(e) {
            var regex = new RegExp("^[a-zA-Z0-9-]+$");
            var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
            if (regex.test(str)) {
                return true;
            }

            e.preventDefault();
            return false;
        }


        function ValidatePage() {
            if (document.getElementById('txtpageNo').value == "") 
            {
                alert("Provide Page number");
            }
            
        
        }

        function CheckTheSampID(sampID) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '../OPIPBilling.asmx/CheckWatersSampID',
                data: JSON.stringify({ SampID: sampID.value }),
                dataType: "json",
                async: false,
                success: function(data) {


                    if (data.d == 1) {
                        $('#' + sampID.id).removeClass('Valid');
                        $('#' + sampID.id).addClass('Invalid');
                    }
                    else {

                        $('#' + sampID.id).removeClass('Invalid');
                        $('#' + sampID.id).addClass('Valid');
                    }

                    //  alert(event);
                    if (keyCode == 9) {

                        if (event.shiftKey) {
                            //Focus previous input
                        }
                        else {
                            //Focus next input
                        }
                    }

                    //$(sampID.parentElement.parentElement.nextElementSibling).find('.txtSampleId').focus()
                }




            });

        }

        function datetime(id) {
            console.log(id);

        }


        function validate_SSgrd() {
            var grdRow = document.getElementById("grdSampleSchedule");

            $(grdRow).find('input[type="checkbox"]').each(function(idx) {
                if (this.checked == true) {
                    'grdSampleSchedule_ctl' + (idx + 1) + '_txtSampleId'


                    if ($('#' + 'grdSampleSchedule_ctl' + (idx + 1) + '_txtSampleId')) {

                    }

                    return 0;
                }


            });

        }


        function TestItemSelected(source, eventArgs) {
            var varGetVal = eventArgs.get_value();
            var arrGetVal = new Array();
            arrGetVal = varGetVal.split("^");
            document.getElementById('txtTestName').value = arrGetVal[1];
            document.getElementById('hdnSelectedTestID').value = arrGetVal[0]; ;
        }

        function ClientIDSelected(source, eventArgs) {
            var varGetVal = eventArgs.get_value();
            var arrGetVal = new Array();
            arrGetVal = varGetVal.split("~");
            document.getElementById('txtClientName').value = arrGetVal[0];
            document.getElementById('hdnClientId').value = arrGetVal[2]; ;
        }



        var HistoryHeader = [];
        HistoryHeader.push('S.No.');
        HistoryHeader.push('Quotation Number');
        HistoryHeader.push('Sample ID');
        HistoryHeader.push('Scheduling Time');
        HistoryHeader.push('Testing Address');
        HistoryHeader.push('Collection Person');
        HistoryHeader.push('Status');
        HistoryHeader.push('Modified By');
        HistoryHeader.push('Modified At');



        function ValidationWindow(message, tt) {
            jQuery('<div>')
        .html("<p>" + message + "</p>")
        .dialog({
            autoOpen: false,
            modal: true,
            title: tt,
            dialogClass: 'validationwindow',
            close: function() {
                jQuery(this).dialog("destroy");
            },
            buttons: {
                "MyButton": {
                    id: "okbtnid",
                    "class": "btn",
                    click: function() {
                        jQuery(this).dialog("destroy");
                    }
                }
            },
            create: function() {

            }
        }).dialog("open");


        }



        $(document).on('change', ".Invalid", function() {
            $('#' + this.id).removeClass("Invalid");
        });




        function OnHistorybtnClick(ctrl) {



            $('#tblScheduleHistory').empty();

            var thead = '<tr>'
            $.each(HistoryHeader, function(i, Zon) {
                thead = thead + '<th>' + Zon + '</th>';
            });
            thead = thead + '</tr>'
            $('#tblScheduleHistory').append(thead);
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '../OPIPBilling.asmx/GetSampleCollectionHist',
                data: JSON.stringify({ RowID: $(ctrl).parent().parent().find("span:first").attr("title") }),
                dataType: "json",
                async: false,
                success: function(data) {
                    var Row = '';
                    val = data.d;
                    var len = data.d.length;
                    $.each(val, function(i, Zon) {

                        //formatDate(ScheduledTimeString);
                    Row = Row + '<tr><td>' + (i + 1) + '</td><td>' + Zon.QuotationNO + '</td><td>' + Zon.SampleID + '</td><td>' + Zon.TestName + '</td><td>' + Zon.TestingAddress + '</td><td>' + Zon.CollectionPerson + '</td><td>' + Zon.Status + '</td><td>' + Zon.ModifiedBy + '</td><td>' + Zon.ClientType + '</td></tr>';

                    });

                    $("#tblScheduleHistory tr:first").after(Row)


                    $("#HistoryPopUp").dialog({ autoOpen: false,
                        modal: true,
                        dialogClass: 'validationwindow',
                        maxWidth: 800,
                        maxHeight: 500,
                        width: 800,
                        height: 400,
                        close: function() {
                            jQuery(this).dialog("destroy");
                        }
                    }).dialog("open"); ;



                }




            });

        }

        function TempDateandTime() {


            $("#txtFrom").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                showOn: "both",
                buttonImage: "../images/Calendar_scheduleHS.png",
                buttonImageOnly: true,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                    $("#txtTo").datepicker("option", "minDate", selectedDate);

                    var date = $("#txtFrom").datepicker('getDate');

                }
                
            });
            $("#txtTo").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                showOn: "both",
                buttonImage: "../images/Calendar_scheduleHS.png",
                buttonImageOnly: true,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                    $("#txtFrom").datepicker("option", "maxDate", selectedDate);
                }
            });





        }


        function checkAll(objRef) {
            var GridView = objRef.parentNode.parentNode.parentNode;
            var inputList = GridView.getElementsByTagName("input");
            for (var i = 0; i < inputList.length; i++) {
                //Get the Cell To find out ColumnIndex
                var row = inputList[i].parentNode.parentNode;
                var strTest = 1;

                var id = "1";
                

                if (inputList[i].type == "checkbox" && objRef != inputList[i]) {
                    if (objRef.checked) {
                        inputList[i].checked = true;
                    }
                    else {
                        id = 0;
                        inputList[i].checked = false;
                    }
                }
                if (inputList[0].checked == true) {

                    id = "1";
                    '<%Session["EditFlag1"] = "1";%>'
                    // alert('<%=Session["EditFlag1"] %>');



                }
                else {

                    '<%Session["EditFlag1"] = "1";%>'
                
                }
            }
        }                       
                            
  

    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlSampleScheduling" runat="server">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpPnl" runat="server">
            <Triggers>
                <asp:PostBackTrigger ControlID="btnConverttoXL" />
            </Triggers>
            <ContentTemplate>
                <table class="defaultfontcolor w-100p">
                    <tr>
                        <td>
                            <asp:Panel ID="pnlFilter" runat="server" CssClass="defaultfontcolor">
                                <div>
                                    <table class="defaultfontcolor w-100p searchPanel">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblFrom" runat="server" Text="From Date" meta:resourcekey="lblFromResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <table border="0" cellpadding="2" cellspacing="1" class="w-100p">
                                                    <tr class="defaultfontcolor">
                                                        <td Style="cursor: pointer;">
                                                            <asp:TextBox runat="server" ID="txtFrom" CssClass="Txtboxsmall" MaxLength="25" size="20"
                                                                meta:resourcekey="txtFromResource1"></asp:TextBox>
                                                            <%--<a href="javascript:NewCssCal('txtFrom','ddmmyyyy','arrow',true,12,'','past')">
                                                                <img src="../images/Calendar_scheduleHS.png" id="img1" alt="Pick a date"></a>--%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblto" runat="server" Text="To Date" meta:resourcekey="lbltoResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <table border="0" cellpadding="2" cellspacing="1" class="w-100p">
                                                    <tr class="defaultfontcolor">
                                                        <td style="cursor: pointer;">
                                                            <asp:TextBox runat="server" ID="txtTo" MaxLength="25" CssClass="Txtboxsmall" size="20"
                                                                meta:resourcekey="txtToResource1"></asp:TextBox>
                           
                                                            <%-- <a href="javascript:NewCssCal('txtTo','ddmmyyyy','arrow',true,12,'','past')">
                                                                <img src="../images/Calendar_scheduleHS.png" id="img2" alt="Pick a date"></a>--%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblQuotationNo" runat="server" Text="Quotation No" meta:resourcekey="lblQuotationNoResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtQuotationNo" runat="server" CssClass="AutoCompletesearchBox Txtboxsmall"
                                                    meta:resourcekey="txtQuotationNoResource1"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="AutoCompletetxtQuotationNo" runat="server" TargetControlID="txtQuotationNo"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                    MinimumPrefixLength="2" CompletionInterval="0" ServiceMethod="pGetListForAutoComp"
                                                    ServicePath="~/OPIPBilling.asmx" DelimiterCharacters="" Enabled="True" UseContextKey="True">
                                                </ajc:AutoCompleteExtender>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblClientName" runat="server" Text="Client Name" meta:resourcekey="lblClientNameResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtClientName" runat="server" CssClass="AutoCompletesearchBox Txtboxsmall"
                                                    meta:resourcekey="txtClientNameResource1"></asp:TextBox>
                                                <input id="hdnClientId" type="hidden" value="0" runat="server" />
                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientName" runat="server" TargetControlID="txtClientName"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                    MinimumPrefixLength="2" CompletionInterval="0" ServiceMethod="GetQuotationClientName"
                                                    OnClientItemSelected="ClientIDSelected" ServicePath="~/OPIPBilling.asmx" DelimiterCharacters=""
                                                    Enabled="True" UseContextKey="True">
                                                </ajc:AutoCompleteExtender>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblTestName" runat="server" Text="Test Name" meta:resourcekey="lblTestNameResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtTestName" runat="server" CssClass="AutoCompletesearchBox Txtboxsmall"
                                                    meta:resourcekey="txtTestNameResource1"></asp:TextBox>
                                                <input id="hndLocationID" type="hidden" value="0" runat="server" />
                                                <input id="hdnSelectedTestID" type="hidden" value="0" runat="server" />
                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtTestName"
                                                    EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box"
                                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                    ServiceMethod="GetBillingItems" FirstRowSelected="false" ServicePath="~/OPIPBilling.asmx"
                                                    OnClientItemSelected="TestItemSelected" UseContextKey="True" DelimiterCharacters=""
                                                    Enabled="True">
                                                </ajc:AutoCompleteExtender>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblSalesType" runat="server" Text="Sample Type" meta:resourcekey="lblSalesTypeResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSampleType" runat="server" CssClass="AutoCompletesearchBox Txtboxsmall"
                                                    meta:resourcekey="txtSalesTypeResource1"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteSampType" runat="server" TargetControlID="txtSampleType"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                    MinimumPrefixLength="2" CompletionInterval="0" ServiceMethod="pGetListForAutoComp"
                                                    ServicePath="~/OPIPBilling.asmx" DelimiterCharacters="" Enabled="True" UseContextKey="True">
                                                </ajc:AutoCompleteExtender>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblSamColPerson" runat="server" Text="Sample Collection Person" meta:resourcekey="lblSamColPersonResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSamColPerson" runat="server" CssClass="AutoCompletesearchBox Txtboxsmall"
                                                    onkeyup="BindAutocomplete(this.id,'../OPIPBilling.asmx/GetCollectorNameAutoComp',this.value,hdnSampleColPersonValSearch);"
                                                    meta:resourcekey="txtSamColPersonResource1"></asp:TextBox>
                                                <asp:HiddenField ID="hdnSampleColPersonValSearch" runat="server" Value="-1" />
                                                </label>
                                                <%-- <ajc:autocompleteextender id="AutoCompleteExtenderSamColPerson" runat="server" completioninterval="1"
                                            completionlistcssclass="wordWheel listMain .box" completionlisthighlighteditemcssclass="wordWheel itemsSelected3"
                                            completionlistitemcssclass="wordWheel itemsMain" servicemethod="GetCollectorNameAutoComp"
                                            servicepath="~/OPIPBilling.asmx"  firstrowselected="True"
                                            minimumprefixlength="1"  enablecaching="false" completionsetcount="10"
                                            targetcontrolid="txtSamColPerson">--%>
                                                <%--  </ajc:autocompleteextender>--%>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblSampleStatus" runat="server" Text="Status" meta:resourcekey="lblSampleStatusResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="drpStatus" runat="server" meta:resourcekey="drpStatusResource1">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-center" colspan="6">
                                                <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btngrdClear_Click" CssClass="btn"
                                                    meta:resourcekey="btnClearResource1" />
                                                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"
                                                    CssClass="btn" meta:resourcekey="btnSearchResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </asp:Panel>
                            <asp:Panel ID="pnlSampleTime" runat="server">
                                <div>
                                    <table class="w-100p">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblSampleSchTime" runat="server" Text="Sample Schedule Time" meta:resourcekey="lblSampleSchTimeResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSampleSchTime" Enabled="false" runat="server" meta:resourcekey="txtSampleSchTimeResource1"></asp:TextBox>
                                                <a href="javascript:NewCssCal('txtSampleSchTime','ddmmyyyy','arrow',true,12,'','past')">
                                                    <img src="../images/Calendar_scheduleHS.png" id="img3" alt="Pick a date"></a>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblSampleColPerson" runat="server" Text="Sample Collection Person"
                                                    meta:resourcekey="lblSampleColPersonResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSampleColPerson" onkeyup="BindAutocomplete(this.id,'../OPIPBilling.asmx/GetCollectorNameAutoComp',this.value,hdnAssignCollPerson);"
                                                    runat="server" CssClass="AutoCompletesearchBox" meta:resourcekey="txtSampleColPersonResource1"></asp:TextBox>
                                                <asp:Label ID="lblSampleColPersonVal" Style="display: none" runat="server"></asp:Label>
                                            </td>
                                            
                                            <td>
                                                <asp:DropDownList ID="ddlCommonstatus" CssClass="ddlsmall" runat="server"></asp:DropDownList>
                                                <asp:Label ID="txtCommonStatus" Text="Status" runat="server"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="chkApplyAll" runat="server" AutoPostBack="true" OnCheckedChanged="chkApplyAll_CheckedChanged" />
                                                <%--   <input type="checkbox" ID="chkApplyAll"  onchange="CollectionPersonApplyALL();" runat="server"  />--%>
                                                <asp:HiddenField ID="hdnCheckBoxList" runat="server" />
                                                <asp:HiddenField ID="hdnAssignCollPerson" runat="server" />
                                                <asp:Label ID="lblApplyAll" runat="server" Text="Apply All" meta:resourcekey="lblApplyAllResource1"></asp:Label>
                                            </td>
                                           <%-- <td>
                                                <asp:Label ID="lblApplyAll" runat="server" Text="Apply All" meta:resourcekey="lblApplyAllResource1"></asp:Label>
                                            </td>--%>
                                            <td class="a-right" style="color: #000000;">
                                                <asp:ImageButton ID="btnConverttoXL" runat="server" ImageUrl="~/Images/ExcelImage.GIF"
                                                    meta:resourcekey="btnConverttoXLResource1" OnClick="btnConverttoXL_Click" />
                                                <asp:Label ID="lbExcel" Text="Excel Report" Font-Bold="True" ForeColor="#000333"
                                                    runat="server" meta:resourcekey="lbExcelResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="7">
                                                <asp:GridView ID="grdSampleSchedule" runat="server" CssClass="mytable1 w-100p gridView"
                                                    OnRowCancelingEdit="grdSampleSchedule_RowCancelingEdit" OnRowUpdating="grdSampleSchedule_RowUpdating"
                                                    OnRowEditing="grdSampleSchedule_RowEditing" OnRowDataBound="grdSampleSchedule_RowDataBound"
                                                    AutoGenerateColumns="False" meta:resourcekey="grdSampleScheduleResource1">
                                                    <Columns>
                                                        <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                            <HeaderTemplate>
                                                                <asp:CheckBox ID="chkSelectAll" runat="server" AutoPostBack="true" onclick="checkAll(this);"
                                                                    meta:resourcekey="chkSelectAllResource1" />
                                                                <%--OnCheckedChanged="chkboxSelectAll_CheckedChanged"--%>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:CheckBox runat="server" ID="grdChkBox" ToolTip='<%# Eval("RowID") %>' />
                                                                <asp:Label Text='<%# Eval("RowID") %>' runat="server" ID="lblRowID" Visible="false"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="QuotationNO" ReadOnly="true" HeaderText="Quotation No"
                                                            meta:resourcekey="BoundFieldResource1" />
                                                        <asp:BoundField DataField="QuotationDate" ReadOnly="true" HeaderText="Quotation Date" DataFormatString="{0:dd/MM/yyyy}"
                                                            meta:resourcekey="BoundFieldResource2" />
                                                        <asp:BoundField DataField="ClientName" ReadOnly="true" HeaderText="Client Name" meta:resourcekey="BoundFieldResource3" />
                                                        <asp:BoundField DataField="MobileNo" ReadOnly="true" HeaderText="Mobile No" meta:resourcekey="BoundFieldResource4" />
                                                        <asp:BoundField DataField="TestName" ReadOnly="true" HeaderText="Test Name" meta:resourcekey="BoundFieldResource5" />
                                                        <asp:BoundField DataField="SampleType" ReadOnly="true" HeaderText="Sample Type" meta:resourcekey="BoundFieldResource6" />
                                                        <asp:TemplateField HeaderText="Sample Id" meta:resourcekey="TemplateFieldResource2">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtSampleId" CssClass="txtSampleId" MaxLength="14" Text='<%# Eval("SampleID") %>'
                                                                    Style="width: 100px;" runat="server"></asp:TextBox>
                                                                <asp:Label Text='<%# Eval("SampleID") %>' runat="server" ID="lblOrnlSampID" Visible="false"></asp:Label>
                                                                <%--<asp:Label ID="lblSampleId" Text='<%# Eval("SampleID") %>' runat="server"></asp:Label>--%>
                                                            </ItemTemplate>
                                                            <%--<EditItemTemplate>
                                                                <asp:TextBox ID="txtSampleId" Text='<%# Eval("SampleID") %>' Style="width: 100px;"
                                                                    runat="server"></asp:TextBox>
                                                            </EditItemTemplate>--%>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Schedule Time" meta:resourcekey="TemplateFieldResource3">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtScheduleTime" CssClass="txtScheduleTime" Enabled="false" Text='<%# Eval("ScheduledTime","{0:dd-MM-yyyy hh:mm tt}")%>'
                                                                    Style="width: 100px" runat="server" ></asp:TextBox>
                                                                <a id="GrdDatePic"  onclick="javascript:NewCssCal(this.previousElementSibling.id,'ddmmyyyy','arrow',true,12,'','past')">
                                                                    <img src="../images/Calendar_scheduleHS.png" visible="false" id="img2" alt="Pick a date"></a>
                                                                <asp:Label Text='<%# Eval("ScheduledTime") %>' runat="server" ID="lblOrnlSTime" Visible="false"></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtScheduleTime" CssClass="txtScheduleTime" Text='<%# Eval("ScheduledTime","{0:dd-MM-yyyy hh:mm tt}")%>'
                                                                    Style="width: 100px" runat="server"></asp:TextBox>
                                                                <a id="GrdDatePic" onclick="javascript:NewCssCal(this.previousElementSibling.id,'ddmmyyyy','arrow',true,12,'','past')">
                                                                    <img src="../images/Calendar_scheduleHS.png" id="img2" alt="Pick a date"></a>
                                                                <asp:Label Text='<%# Eval("ScheduledTime") %>' runat="server" ID="lblOrnlSTime" Visible="false"></asp:Label>
                                                            </EditItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Testing Address" meta:resourcekey="TemplateFieldResource4">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTestAddress" runat="server" Text='<%# Eval("TestingAddress")  %>'>
                                                                </asp:Label></ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Sample Collection Person" meta:resourcekey="TemplateFieldResource5">
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="drpSamColPerson" Enabled="false" DataSource='<%# GetSampleCollectors() %>'
                                                                    DataTextField="Name" Style="width: 120px" DataValueField="UserID" runat="server"
                                                                    meta:resourcekey="drpSamColPersonResource1">
                                                                </asp:DropDownList>
                                                                <asp:Label ID="lblSampColPersonID" Visible="false" runat="server" Text='<%# Eval("CollectedBy") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:DropDownList ID="drpSamColPerson" Style="width: 120px" DataSource='<%# GetSampleCollectors() %>'
                                                                    DataTextField="Name" DataValueField="UserID" runat="server" meta:resourcekey="drpSamColPersonResource2">
                                                                </asp:DropDownList>
                                                                <asp:Label ID="lblSampColPersonID" Visible="false" runat="server" Text='<%# Eval("CollectedBy") %>'></asp:Label>
                                                            </EditItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Field Test">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblFieldTest" Text='<%# Eval("FieldTest") %>' runat="server" HeaderText="Field Test"
                                                                    meta:resourcekey="BoundFieldResource7" />
                                                            </ItemTemplate>
                                                            <%--<EditItemTemplate>
                                                                <asp:TextBox ID="txtFieldTest" runat="server" Text='<%# Eval("FieldTest") %>' Style="width: 80px;"></asp:TextBox>
                                                            </EditItemTemplate>--%>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Status">
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="drpSampStatus" Enabled="false" DataSource='<%# GetSampleStatus() %>'
                                                                    DataTextField="DisplayText" DataValueField="Code" runat="server" meta:resourcekey="drpSamColPersonResource1">
                                                                </asp:DropDownList>
                                                                <asp:Label ID="lblSampStatus" Visible="false" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:DropDownList ID="drpSampStatus" DataSource='<%# GetSampleStatus() %>' DataTextField="DisplayText"
                                                                    DataValueField="Code" runat="server" meta:resourcekey="drpSamColPersonResource1">
                                                                </asp:DropDownList>
                                                                <asp:Label ID="lblSampStatus" Visible="false" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                                            </EditItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <Columns>
                                                        <asp:CommandField ShowEditButton="true" ButtonType="Button" HeaderText="Edit"  EditText="Edit" UpdateText="Update"
                                                            CancelText="Cancel" />
                                                        <asp:TemplateField HeaderText="History">
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnHistory" runat="server" CssClass="buttonbackground" 
                                                                     OnClientClick="OnHistorybtnClick(this)" /> 
                                                                  <%-- <asp:Image ImageUrl="~/Images/History.jpg" runat="server" ID="btnHistory" runat="server" CssClass="h-25" meta:resourcekey="btnHistoryResource1" OnClientClick="OnHistorybtnClick(this)" /> --%>
                                                                  </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                        <tr class="dataheaderInvCtrl">
                                            <td class="a-center defaultfontcolor" colspan="7">
                                                <div id="divFooterNav" runat="server">
                                                    <asp:Label ID="lblPage" runat="server" meta:resourcekey="lblPageResource1" Text="Page"></asp:Label><asp:Label
                                                        ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label><asp:Label
                                                            ID="lblOf" runat="server" meta:resourcekey="lblOfResource1" Text="Of"></asp:Label><asp:Label
                                                                ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label><asp:Button
                                                                    ID="Btn_Previous" runat="server" OnClick="Btn_Previous_Click" CssClass="btn"
                                                                    meta:resourcekey="Btn_PreviousResource1" Text="Previous" />
                                                    <asp:Button ID="Btn_Next" runat="server" CssClass="btn" OnClick="Btn_Next_Click"
                                                        meta:resourcekey="Btn_NextResource1" Text="Next" />
                                                    <asp:HiddenField ID="hdnCurrent" Value="0" runat="server" />
                                                    <asp:HiddenField ID="hdnPostBack" runat="server" />
                                                    <asp:HiddenField ID="hdnOrgID" runat="server" />
                                                    <asp:Label ID="lblEnter" runat="server" meta:resourcekey="lblEnterResource1" Text="Enter The Page To Go:"></asp:Label><asp:TextBox
                                                        ID="txtpageNo" runat="server" CssClass="Txtboxsmall" onkeypress="return ValidateOnlyNumeric(this);"
                                                        MaxLength="4" meta:resourcekey="txtpageNoResource1" Width="30px"></asp:TextBox><asp:Button
                                                            ID="btnGo" OnClick="btnGo_Click" runat="server" OnClientClick="ValidatePage();" CssClass="btn" meta:resourcekey="btnGoResource1"
                                                            Text="Go" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <tr>
                                                    <td class="a-center" colspan="7">
                                                        <asp:Button ID="btngrdClear" runat="server" Text="Clear" CssClass="btn" meta:resourcekey="btngrdClearResource1"
                                                            OnClick="btngrdClear_Click" />
                                                        <asp:Button ID="btngrdSave" runat="server" Text="Save" OnClientClick="validate_SSgrd();"
                                                            CssClass="btn" meta:resourcekey="btngrdSaveResource1" OnClick="btngrdSave_Click" />
                                                    </td>
                                                </tr>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </asp:Panel>
                            <asp:Panel ID="GrdResult" runat="server" Visible="false">
                                <div>
                                    No Matching Records Found</div>
                            </asp:Panel>
                            <asp:UpdateProgress DynamicLayout="False" ID="UpdateProgress1" runat="server">
                                <ProgressTemplate>
                                    <div id="progressBackgroundFilter" class="a-center">
                                    </div>
                                    <div id="processMessage" class="a-center w-20p">
                                        <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                            meta:resourcekey="img1Resource1" />
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                    </tr>
                </table>
                <div id="HistoryPopUp" title="Sample Schedule History" style="display: none;">
                    <table width="98%" id="tblScheduleHistory" border="1" align='center'>
                    </table>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" Value="" />
    </form>
    <asp:HiddenField ID="hdnCollectionPerson" Value="" runat="server" />
</body>
</html>
