<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VisitPageGeneration.aspx.cs"
    Inherits="Waters_VisitPageGeneration" meta:resourcekey="PageResource1" EnableEventValidation = "false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Visit Page Generation</title>
    <%--    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />
<link rel="Stylesheet" type="text/css" href="../StyleSheets/jquery.datatable.css" />--%>

    <script src="Scripts/VisitPageGeneration.js" type="text/javascript"></script>

    <script src="Scripts/jquery-1.10.2.min.js" type="text/javascript"></script>

    <script src="Scripts/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="Scripts/jquery.loader.js" type="text/javascript"></script>

    <script src="Scripts/ZeroClipboard.js" type="text/javascript"></script>
    <script src="Scripts/TableTools.js" type="text/javascript"></script>

    <script src="Scripts/JsonScript.js" type="text/javascript"></script>
    <style type="text/css">
        .tblVisitPage td, .tblTestParameter td
        {
            padding: 5px 10px;
        }
        .tblVisitSheet td, .tblPaymentDetails td, .tblSignature td
        {
            padding: 10px 10px;
        }
        .lblTestParameter, .lblVisitHeader, .lblPaymentHeader
        {
            background: #446d87;
            color: #fff;
            font-weight: bold;
            padding: 3px 5px;
        }
        .lblPaymentHeader
        {
            display: block;
        }
        .beta  td  {
   border: 1px solid black;
    
  
        
      
}


    </style>
      <script type="text/javascript">
          $(function() {
              $("#WholeVisitSheet").hide();
              $("#btnPrint").hide();
              $("#lnkPrint").hide();
              $("#btnSendMail").hide();

          });
         
          function pageLoad() {
              $("#txtFromDate").datepicker({
                  dateFormat: 'dd/mm/yy',
                  defaultDate: "+1w",
                  changeMonth: true,
                  changeYear: true,
                  buttonImage: "../images/Calendar_scheduleHS.png",
                  maxDate: 0,
                  yearRange: '1900:2100',
                  onClose: function(selectedDate) {
                      $("#txtToDate").datepicker("option", "minDate", selectedDate);

                      var date = $("#txtFromDate").datepicker('getDate');
                      //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                      // $("#txtTo").datepicker("option", "maxDate", d);

                  }
              });
              $("#txtToDate").datepicker({
                  dateFormat: 'dd/mm/yy',
                  defaultDate: "+1w",
                  changeMonth: true,
                  changeYear: true,
                  maxDate: 0,
                  yearRange: '1900:2100',
                  onClose: function(selectedDate) {
                      $("#txtFromDate").datepicker("option", "maxDate", selectedDate);
                  }
              })

          }
          $(function() {
              $("#txtFromDate").datepicker({
                  dateFormat: 'dd/mm/yy',
                  defaultDate: "+1w",
                  changeMonth: true,
                  changeYear: true,
                  maxDate: 0,
                  yearRange: '1900:2100',
                  onClose: function(selectedDate) {
                      $("#txtToDate").datepicker("option", "minDate", selectedDate);

                      var date = $("#txtFromDate").datepicker('getDate');
                      //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                      // $("#txtTo").datepicker("option", "maxDate", d);

                  }
              });
              $("#txtToDate").datepicker({
                  dateFormat: 'dd/mm/yy',
                  defaultDate: "+1w",
                  changeMonth: true,
                  changeYear: true,
                  maxDate: 0,
                  yearRange: '1900:2100',
                  onClose: function(selectedDate) {
                      $("#txtFromDate").datepicker("option", "maxDate", selectedDate);
                  }
              })
          });
          function preventInput(evnt) {
              //Checked In IE9,Chrome,FireFox
              if (evnt.which != 9) evnt.preventDefault();
          }
        
          function validateToDate() {

              if (document.getElementById('txtFromDate').value == '') {
                  alert('Provide / select value for From date');
                  document.getElementById('txtFromDate').focus();
                  return false;
              }
              if (document.getElementById('txtToDate').value == '') {
                  alert('Provide / select value for To date');
                  document.getElementById('txtToDate').focus();
                  return false;
              }
              return true;
          }

          function getTestId(source, eventArgs) {
              document.getElementById('hdnTestCode').value = eventArgs.get_value().split('~')[1];
          }

          function popupprint() {
              var prtContent = document.getElementById('WholeVisitSheet');
              var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
              //alert(WinPrint);
              WinPrint.document.write('<html><head>');
              WinPrint.document.write('<link rel="stylesheet" type="text/css" href="../StyleSheets/Common.css" />');
              WinPrint.document.write('<link href="CSS/jquery.dataTables.css" rel="stylesheet" type="text/css" />');
              WinPrint.document.write('<style type="text/css"> .tblVisitPage td, .tblTestParameter td { padding: 5px 10px;} .tblVisitSheet td, .tblPaymentDetails td, .tblSignature td {  padding: 10px 10px;}.lblTestParameter, .lblVisitHeader, .lblPaymentHeader{ background: #446d87;color: #fff;font-weight: bold; padding: 3px 5px; } .lblPaymentHeader {display: block;} .beta td,th {border: 1px solid black;  }</style>');
              WinPrint.document.write('</head><body>');
              WinPrint.document.write(prtContent.innerHTML);
              WinPrint.document.write('</body></html>');
              setTimeout(function() {
                  WinPrint.document.close();
                  WinPrint.focus();
                  WinPrint.print();
              }, 1000);
              //WinPrint.close();
              return false;
          }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <%-- <script type="text/javascript">
           /*  $(function() {
           $("#txtFDate").datepicker({
           changeMonth: true,
           changeYear: true,
           maxDate: 0,
           yearRange: '2008:2030'
           });
           $("#txtTDate").datepicker({
           changeMonth: true,
           changeYear: true,
           maxDate: 0,
           yearRange: '2008:2030'
           })
           });*/
           $(function() {
               $("#txtValidFrom").datepicker({
                   dateFormat: 'dd/mm/yy',
                   defaultDate: "+1w",
                   changeMonth: true,
                   changeYear: true,
                   maxDate: 0,
                   yearRange: '1900:2100',
                   onClose: function(selectedDate) {
                       $("#txtValidTo").datepicker("option", "minDate", selectedDate);

                       var date = $("#txtValidFrom").datepicker('getDate');
                       //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                       // $("#txtTo").datepicker("option", "maxDate", d);

                   }

               });
               $("#txtValidTo").datepicker({
                   dateFormat: 'dd/mm/yy',
                   defaultDate: "+1w",
                   changeMonth: true,
                   changeYear: true,
                   maxDate: 0,
                   yearRange: '1900:2100',
                   onClose: function(selectedDate) {
                       $("#txtValidFrom").datepicker("option", "maxDate", selectedDate);

                   }
               })
           });
           function clearContextText() {
               $('#contentArea').hide();

           }
                        </script>--%>
    <div class="contentdata">
       <asp:UpdatePanel ID="pnlrate" runat="server">
            <ContentTemplate>
                <table class="w-100p searchPanel">
                    <tr>
                        <td>
                            <table class="w-80p tblVisitPage pull-left">
                                <tr>
                                    <td class="w-20p">
                                        <asp:Label ID="lblFromDate" runat="server" Text="From Date" meta:resourcekey="lblFromDateResource1"></asp:Label>
                                    </td>
                                    <td class="w-20p">
                                        <asp:TextBox ID="txtFromDate" CssClass="Txtboxsmall" Width="160px" runat="server"
                                            meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                        &nbsp;<asp:Image runat="server" ID="ImgBntCalc1" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                            Width="16px" Height="16px" border="0" alt="Pick from date" meta:resourcekey="ImgBntCalcResource1" />
                                       
                                    </td>
                                    <td>
                                        <asp:Label ID="lblToDate" runat="server" Text="To Date" meta:resourcekey="lblToDateResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtToDate" CssClass="Txtboxsmall" Width="160px" runat="server"
                                            meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                        &nbsp;<asp:Image runat="server" ID="Image1" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                            Width="16px" Height="16px" border="0" alt="Pick from date" meta:resourcekey="ImgBntCalcResource1" />
                                       
                                    </td>
                                    <td>
                                        <asp:Label ID="lblPerson" runat="server" Text="Sample Collection Person" meta:resourcekey="lblPersonResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPerson" class="AutoCompletesearchBox" runat="server" meta:resourcekey="txtPersonResource1"></asp:TextBox> <img src="../Images/starbutton.png" alt="" align="middle" />
                                        <ajc:AutoCompleteExtender ID="AutoCompleteCollPerson" runat="server" TargetControlID="txtPerson"
                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                            OnClientItemSelected="GetPersonID" MinimumPrefixLength="2" CompletionInterval="1000" CompletionSetCount="20"
                                            ServiceMethod="GetCollectorNameAutoCompVisit" ServicePath="~/OPIPBilling.asmx" DelimiterCharacters=""
                                            Enabled="True" UseContextKey="true">
                                        </ajc:AutoCompleteExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblClientName" runat="server" Text="Client Name" meta:resourcekey="lblClientNameResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtClientName" class="small" runat="server" meta:resourcekey="txtClientNameResource1"></asp:TextBox> <img src="../Images/starbutton.png" alt="" align="middle" />
                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientName" runat="server" TargetControlID="txtClientName"
                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                            OnClientItemSelected="GetClientID" MinimumPrefixLength="2" CompletionInterval="0"
                                            ServiceMethod="GetQuotationClientName" ServicePath="~/OPIPBilling.asmx" DelimiterCharacters=""
                                            Enabled="True" UseContextKey="true">
                                        </ajc:AutoCompleteExtender>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label1" runat="server" Text=" " ></asp:Label>
                                    </td>
                                    <td> <asp:TextBox ID="txtVisitNo" class="small" runat="server" placeholder="Visit Number" meta:resourcekey="txtClientNameResource1" style="display:none"></asp:TextBox>
                                     <%--<asp:Button ID="btnVisitFind" class="btn" runat="server" Text="View VisitSheet"  OnClientClick="return ViewVisitSheet();"/>--%>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnSearch" class="btn" Text="Search" runat="server" OnClientClick="return ValidVisitSearch();"
                                            meta:resourcekey="btnSearchResource1" OnClick="btnSearch_Click" />
                                        &nbsp;&nbsp;&nbsp;
                                        <asp:Button ID="btnClear" class="btn" runat="server" Text="Clear" OnClientClick="return ClearField();"  meta:resourcekey="btnClearResource1" />
                                    </td>
                                   
                                </tr>
                            </table>
                            <table class="w-20p">
                                <tr class="lh25"><td></td></tr>
                                   <tr class="lh25">
                                         <td colspan="2" class="a-right">
                                         <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" ToolTip="Print"
                                            OnClientClick="return popupprint();" meta:resourcekey="btnPrintResource1" />
                                        <b id="printText" runat="server">
                                            <asp:LinkButton ID="lnkPrint" Text="Print Report" Font-Underline="True" runat="server"
                                                OnClientClick="return popupprint();" Font-Bold="True" Font-Size="12px" ForeColor="Black"
                                                ToolTip="Print" meta:resourcekey="lnkExportXLResource2"></asp:LinkButton></b>
                                        <asp:Button runat="server" ID="btnSendMail" Text="Send Mail" meta:resourcekey="btnSendMailResource1"  OnClientClick="return SendEmail();">
                                        </asp:Button>
                                    
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <asp:Panel ID="wholeVisit"  runat="server">
                <div id="WholeVisitSheet" runat="server">
                        <div id="VisitDetails" class="a-center">
                            <asp:Label ID="lblVisitHeader" CssClass="lblVisitHeader a-center" runat="server"
                                Text="Visit Sheet" meta:resourcekey="lblVisitHeaderResource1"></asp:Label>
                <table class="w-100p borderGery marginB10"  runat="server">
                    <tr>
                                    <td class="a-center">
                                    </td>
                                </tr>
                                <tr>
                        <td class="w-80p">
                            <asp:Panel ID="pnlVisitSheet" runat="server" CssClass="w-100p">
                                            <table class="w-100p tblVisitSheet" runat="server">
                                                <tr class="">
                                                    <td class="w-10p">
                                                        <asp:Label ID="lblVisitClientName" Text="Client Name" runat="server" meta:resourcekey="lblVisitClientNameResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-20p">
                                                        <asp:Label ID="lblVisitClientVal" Text=" " runat="server" meta:resourcekey="lblVisitClientValResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-10p">
                                                        <asp:Label ID="lblVisitContact" Text="Contact Person" runat="server" meta:resourcekey="lblVisitContactResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-20p">
                                                        <asp:Label ID="lblVisitContactVal" Text=" " runat="server" meta:resourcekey="lblVisitContactValResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-10p">
                                                        <asp:Label ID="lblVisitDesignation" Text="Designation" runat="server" meta:resourcekey="lblVisitDesignationResource1"></asp:Label>
                                                    </td>
                                                    <td class="">
                                                        <asp:Label ID="lblVisitDesignationVal" Text=" " runat="server" meta:resourcekey="lblVisitDesignationValResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="">
                                                        <asp:Label ID="lblVisitAddress" Text="Address" runat="server" meta:resourcekey="lblVisitAddressResource1"></asp:Label>
                                                    </td>
                                                    <td class="">
                                                        <asp:Label ID="lblVisitAddressVal" runat="server" meta:resourcekey="lblVisitAddressValResource1"></asp:Label>
                                                    </td>
                                                    <td class="">
                                                        <asp:Label ID="lblVisitContactNumber" Text="Contact Number" runat="server" meta:resourcekey="lblVisitContactNumberResource1"></asp:Label>
                                                    </td>
                                                    <td class="">
                                                        <asp:Label ID="lblVisitContactNumberVal" runat="server" meta:resourcekey="lblVisitContactNumberValResource1"></asp:Label>
                                                    </td>
                                                    <td class="">
                                            <asp:Label ID="lblVisitSheduleTime" Text="Schedule Time" runat="server"></asp:Label>
                                                    </td>
                                                    <td class="">
                                                        <asp:Label ID="lblVisitSheduleTimeVal" Text="" runat="server" meta:resourcekey="lblVisitSheduleTimeResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                    <td class="w-30p">
                                        <div id="immmg">
                                            <img id="imgBarcode" src=""></img>
                                        </div>
                                        <asp:Label runat="server" ID="lblVisitNosShow" Text="" meta:resourcekey="lblLabelResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table class="searchPanel123 h-30 w-100p">
                            <tr>
                                <td class="a-center">
                                    <span class="lblVisitHeader">Sample Details</span>
                                </td>
                            </tr>
                        </table>
                        
                        <table class="w-100p searchpanel marginT2 a-center" >
                            <tr>
                                <td>
                                    <table width='100%' border="1" id="VisitSheetOneTbl" class="beta w-100p" runat="server">
                                    </table>
                                </td>
                            </tr>
                            <tr class="a-center">
                                <td>
                                    <table class="w-100p tblTestParameter a-center">
                                        <tr>
                                        
                                            <td class="a-center" colspan="5">
                                                <asp:Label ID="lblTestParameter" CssClass="lblTestParameter a-center" runat="server" Text="Test Parameter Details"
                                                    meta:resourcekey="lblTestParameterResource1"></asp:Label>
                                            </td>
                                            
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <table border="1" id="tblListTestParameters" width='100%' class="beta w-100p" runat="server">
                                                </table>
                                                <%--   <asp:GridView ID="grdTestParameterDetails" runat="server" AllowPaging="True" CellPadding="1"
                                                AutoGenerateColumns="False" CssClass="gridView w-100p" AlternatingRowStyle-CssClass="trEven"
                                                class="mytable1" meta:resourcekey="grdTestParameterDetailsResource1">
                                                <%-- <PagerStyle HorizontalAlign="Center" />--%>
                                                <%-- <HeaderStyle CssClass="dataheader1" />--%>
                                                <%--  <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                                                PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                                                <Columns>
                                                    <asp:BoundField DataField="SNO" Visible="false" HeaderText="S.No." meta:resourcekey="BoundFieldResource10" />
                                                    <asp:BoundField DataField="TestName" HeaderText="Test Name" meta:resourcekey="BoundFieldResource11" />
                                                    <asp:BoundField DataField="Count" HeaderText="Count" meta:resourcekey="BoundFieldResource12" />
                                                    <asp:BoundField DataField="TestParameter" HeaderText="TestParameters" meta:resourcekey="BoundFieldResource13" />
                                                </Columns>
                                                <AlternatingRowStyle CssClass="trEven"></AlternatingRowStyle>
                                            </asp:GridView>--%>
                                     
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblSampleCollectedBy" runat="server" Text="Sample Collected By" meta:resourcekey="lblSampleCollectedByResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="cbRep" runat="server" Text="Sampling By Equinox Representative" 
                                            meta:resourcekey="cbRepResource1" />
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="cbClient" runat="server" Text="Sampling By Client" 
                                            meta:resourcekey="cbClientResource1" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblSampleCTime" Text="Sample Collected Time" runat="server" meta:resourcekey="lblSampleCTimeResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblSampleCTimeVal" Text=" " runat="server" meta:resourcekey="lblSampleCTimeValResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <br />
                <table class="w-100p searchPanel tblPaymentDetails">
                    <tr>
                        <td colspan="6">
                            <asp:Label ID="lblPaymentHeader" runat="server" CssClass="a-center lblPaymentHeader"
                                Text="Payment Details" meta:resourcekey="lblPaymentHeaderResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="cbAdvancePayment" runat="server" Text="100 % Advance PaymentAgainst Invoice" 
                                meta:resourcekey="cbAdvancePaymentResource1" />
                        </td>
                        <td colspan="5">
                            <asp:CheckBox ID="cbPaymentMode" runat="server" Text="Mode Of Payment"  meta:resourcekey="cbPaymentModeResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="cbPrePaid" runat="server" Text="Prepaid"  meta:resourcekey="cbPrePaidResource1" />
                        </td>
                        <td>
                            <asp:CheckBox ID="cbPostPaid" runat="server" Text="Postpaid"  meta:resourcekey="cbPostPaidResource1" />
                        </td>
                        <td>
                            <asp:CheckBox ID="cb7days" runat="server" Text="7 Days Credit"  meta:resourcekey="cb7daysResource1" />
                        </td>
                        <td colspan="3">
                            <asp:CheckBox ID="cbOnline" runat="server" Text="Online"  meta:resourcekey="cbOnlineResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblAmount" Text="Amount" runat="server" meta:resourcekey="lblAmountResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtAmount"  CssClass="small" runat="server" meta:resourcekey="txtAmountResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblPaymentMode" Text="Payment Mode" runat="server" meta:resourcekey="lblPaymentModeResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlPaymentMode" CssClass="ddlsmall" runat="server" meta:resourcekey="ddlPaymentModeResource1">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label ID="lblPaymentDetails" Text="Details" runat="server" meta:resourcekey="lblPaymentDetailsResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPaymentDetails"  CssClass="small" runat="server" meta:resourcekey="txtPaymentDetailsResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <asp:Label ID="lblNoteVal" runat="server" Text="Note :In Case of cheque Payment ,Cheque to be issued in favour of Equinox Solution"
                                meta:resourcekey="lblNoteValResource1" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblContact" runat="server" Text="Contact" Font-Bold="true" meta:resourcekey="lblContactResource1"></asp:Label>
                        </td>
                        <td colspan="2">
                            <asp:Label ID="lblContactVal" runat="server" Text="For Report Query : support@equinoxlab.com"
                                meta:resourcekey="lblContactValResource1" Font-Bold="true"></asp:Label><br />
                                <asp:Label ID="Label2" runat="server" Text="For Testing Query : Komal@equinoxlab.com"
                                meta:resourcekey="lblContactValResource1" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                </table>
                <table class="w-100p searchPanel tblSignature">
                    <tr>
                        <td>
                            <asp:Label ID="lblPersonName" Text="Person Name :" runat="server" Style="text-decoration: underline;"
                                meta:resourcekey="lblPersonNameResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblPersonVal" runat="server" meta:resourcekey="lblPersonValResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblClientSign" Text="Client Signature :" runat="server" Style="text-decoration: underline;"
                                meta:resourcekey="lblClientSignResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblClientSignVal" runat="server" meta:resourcekey="lblClientSignValResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblCollectionPerson" Text="Sample Collection Person Signature" runat="server"
                                Style="text-decoration: underline;" meta:resourcekey="lblCollectionPersonResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblCollectionPersonVal" runat="server" meta:resourcekey="lblCollectionPersonValResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" class="a-center">
                            <asp:Button ID="btnVisitSave" Text="Save" runat="server"  CssClass="btn" meta:resourcekey="btnVisitSaveResource1" OnClientClick="return SaveData();" />
                            <asp:Button ID="btnVisitCancel" Text="Cancel" runat="server"  CssClass="btn" meta:resourcekey="btnVisitCancelResource1"  OnClientClick="return ClearData();"  />
                        </td>
                    </tr>
                </table>
                </div>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
      <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <asp:HiddenField ID="hdnTargetCtlMailReport" runat="server" />
                <ajc:ModalPopupExtender ID="modalpopupsendemail" runat="server" PopupControlID="pnlMailReports" BehaviorID="mpe"
                    TargetControlID="hdnTargetCtlMailReport" BackgroundCssClass="modalBackground"
                    CancelControlID="img1" DynamicServicePath="" Enabled="True">
                </ajc:ModalPopupExtender>
                <asp:Panel ID="pnlMailReports" BorderWidth="1px" Height="40%" Width="30%"  CssClass="modalPopup dataheaderPopup"
                    runat="server" meta:resourcekey="pnlMailReportResource1" Style="display: none">
                    <asp:Panel ID="Panel5" runat="server" CssClass="dialogHeader" meta:resourcekey="Panel1Resource1">
                        <table class="w-100p">
                            <tr>
                                <td>
                                    <asp:Label ID="Label11" runat="server" Text="Email Report" meta:resourcekey="Label11Resource2"></asp:Label>
                                </td>
                                <td align="right">
                                    <img id="img1" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                        style="cursor: pointer;" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <table width="100%">
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="vertical-align: middle;">
                                <asp:Label ID="lblMailAddress" runat="server" Text="To: " meta:resourcekey="lblMailAddressResource1" />
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtMailAddress" TextMode="MultiLine" Width="300px" Height="40px"
                                    runat="server" meta:resourcekey="txtMailAddressResource1" />
                                <p style="margin: 2px 0 5px 0; font-size: 11px; color: #666;">
                                    <asp:Label ID="lblMailAddressHint" runat="server" Text="example: abc@example.com, def@example.com"
                                        meta:resourcekey="lblMailAddressHintResource1" />
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                    <ProgressTemplate>
                                        <asp:Image ID="imgProgressbars" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                        <asp:Label ID="Rs_Pleasewaits" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                                <asp:Button ID="Send" runat="server" Text="Send" OnClientClick="javascript:return CheckEmpty();"
                                    CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                    OnClick="btnSendMailReport_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HiddenField ID="hdnClientEmail" runat="server" />
                                <asp:HiddenField ID="hdnCountryID" runat="server" Value="0" />
                                <asp:HiddenField ID="hdnSelectedClientID" runat="server" Value="0" />
                                <asp:HiddenField ID="HiddenField1" runat="server" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <input id="hfCustomerId" type="hidden" value="0" runat="server" />
    <input id="hfPersonID" type="hidden" value="0" runat="server" />
    <input id="hdnMessages" type="hidden" value="0" runat="server" />
    <input id="hdnVisitNo" type="hidden" value="0" runat="server" />
    <input id="hdnOrgID" type="hidden" value="0" runat="server" />
    <input id="hdnRoleID" type="hidden" value="0" runat="server" />
    <input id="hdnPageID" type="hidden" value="0" runat="server" />
    <input id="hdnEmailID" type="hidden" value="0" runat="server" />
    <input id="hdfDefaultPaymentMode" type="hidden" value="" runat="server" />

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    </form>
    <script src="Scripts/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="Scripts/jquery.loader.js" type="text/javascript"></script>

    <script src="Scripts/ZeroClipboard.js" type="text/javascript"></script>
    <script src="Scripts/TableTools.js" type="text/javascript"></script>

    <script src="Scripts/JsonScript.js" type="text/javascript"></script>
    <link href="CSS/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    
    <link href="CSS/TableTools_JUI.css" rel="stylesheet" type="text/css" />
</body>


</html>
