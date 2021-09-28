<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClientBatchMaster.aspx.cs" Inherits="Invoice_ClientBatchMaster"
    EnableEventValidation="false" meta:resourcekey="PageResource1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Client Batch Master</title>
   
    <style type="text/css">
        .dataheaderPopup
        {
            background-image: url(../Images/whitebg.png);
            background-repeat: repeat;
            width: auto;
            margin-left: 0px;
            margin-top: 0px;
            margin-bottom: 10px;
            border-color: #f17215;
            border-style: solid;
            border-width: 5px;
            
            color: #000000;
        }
        .invscrol01
        {
            display: block;
            height: 70px;
            overflow-x: hidden;
            overflow-y: scroll;
        }
        .invscrol
        {
            display: table;
            width: 100% !important;
        }
        .invscrol td
        {
            background: none !important;
            color: #000 !important;
            display: table-cell !important;
        }
        .invscrol tr
        {
            display: table-row;
            width: 100%;
        }
    </style>
     <script src="../Scripts/Common.js" type="text/javascript"></script>
 
   <%--<script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>--%>
    <script type="text/javascript">
    
    
        function ClientitemSelected(source, eventArgs) {

            $('#hdnClientID').val(eventArgs._value.split('^')[5]);
        }
        function ItemSelectedtest(source, eventArgs) {

            var val = eventArgs._value.split(":");
            var value = val[0].split("^");
            var value1 = val[1].split("^");
            $('#hdnInvID').val(value[0]);
            $('#hdnInvType').val(value1[1]);
        }
        function CheckCodes(codeType, TextBoxID) {


            var ClientTypeID = document.getElementById('ddlClientType').options[document.getElementById('ddlClientType').selectedIndex].value;
            var ClientTypeName = document.getElementById('ddlClientType').options[document.getElementById('ddlClientType').selectedIndex].innerText;
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_02") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_02") : "Enter the ClientCode";

            
            if (document.getElementById('txtClientName').value.trim() != '') {
                var txtValue = document.getElementById(TextBoxID).value.trim();
                if (txtValue != '') {
                    WebService.GetCheckCode(codeType, txtValue, onCheckCounts);
                }                         }
            }
            
         //   -----chindhujadatatable

            
//   var Items = lstOfData.d;
//   var i = 0;
 //$('#example').dataTable({
//      
//  
//       //"aaData":lstOfData.d,
//     

//   
//       
//      "aoColumns": [

//                   {"sTitle": "Client Name"
//                                      
//                   },
//                       
//                          { "sTitle": "Client Code"

//                          
//                          },
//                          { "sTitle": "Batch ID" 

//                          },
//                         ]



//   });
//        
//        jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');

//        $('#ScrollArea').addClass('show');
        
       
    

         
        // -------------------------------chin

            function GetData() {

                try {
//                    if (document.getElementById('CliFromdate').value == "") {

//                        alert('Please Enter From date');
//                    }
//                    else if (document.getElementById('CliTodate').value == "") {
//                    alert('Please Enter Todate');
                    //}
                    var status=''
                    if ($('[id*=ddlstatusbatch] option:selected').text() == 'Yet To Request') {
                        status = "Request";
                    }
                    else if ($('[id*=ddlstatusbatch] option:selected').text() == 'Reported') {
                        status = "View";
                    }
                    else if ($('[id*=ddlstatusbatch] option:selected').text() == '-----Select-----') {
                        status = "";
                    }
                    else {
                        status = $('[id*=ddlstatusbatch] option:selected').text(); 
                    }
                    
                
                    
                    var obj = {};
                    obj.orgID = document.getElementById("hdnOrgID").value;
                    obj.Clientid = document.getElementById("hdnClientID").value;
                    obj.clientcode = document.getElementById("txtClientCodeSrch").value;
                    obj.batchid = document.getElementById("CliBatchid").value;
                    obj.Fromdateb = document.getElementById("CliFromdate").value;
                    obj.Todateb = document.getElementById("CliTodate").value;
                    obj.Status = status; 
                    var Task = "Search";
                    var PageSize = 10;
                    var currentPageNo = 1;
                    
                    
                    
                    $.ajax({
                        type: "POST",
                        url: "../OPIPBilling.asmx/Getsearchclientbatchmaster",
                        contentType: "application/json; charset=utf-8",
                        // data: "{Clientname:" + Clientname + ",ClientCode:" + ClientCode + ",Batchid:" + Batchid + "}",
                       data:JSON.stringify(obj),
                        dataType: "json",
                        success: AjaxGetFieldsDataSucceeded,
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert("Error");
                            $('#example').hide();
                           
                            return false;
                        }
                    });
                }
                catch (e) {
                    alert("Error");
                }
            
            }
            function enable() {
                $('#example > tr').remove();
                $("#nav").empty();
            }


            function repeat() {
            try {
                var obj = {};
                obj.orgID = document.getElementById("hdnOrgID").value;
                obj.Clientid = document.getElementById("hdnClientID").value;
                obj.batchid = document.getElementById("txtBatchID").value;
                 $.ajax({
                        type: "POST",
                        url: "../OPIPBilling.asmx/Getsearchbatchid",
                        contentType: "application/json; charset=utf-8",
                        // data: "{Clientname:" + Clientname + ",ClientCode:" + ClientCode + ",Batchid:" + Batchid + "}",
                       data:JSON.stringify(obj),
                        dataType: "json",
                        success: getbatchid,
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert("Error");
                          
                           
                            return false;
                        }
                    });
                }
                catch (e) {
                    alert("Error");
                }

            }
                
              //  ----------------------------------------------

                 
    </script>
    </head>
    <body>
    <form runat="server">
    <asp:HiddenField ID="hdnOrgID" runat="server" />
    <asp:HiddenField ID="hdnInvID"  value="0" runat="server" />
    <asp:HiddenField ID="hdnInvType" value=""  runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <asp:Panel ID="pnlCommercials" runat="server" CssClass="w-100p" meta:resourceKey="pnlCommercialsResource2">
   <table style="background-color:inherit">
    <tr class="colorforcontent">
                                                                                                                    <td colspan="20" class="padding8">
                                                                                                                        <p class="bold">
                                                                                                    <%--NEW BATCH REGISTER--%><%=Resources.Invoice_ClientDisplay.Invoice_ClientBatchMaster_aspx_012%> </p>
                                                                                                                    </td>
                                                                                                                </tr>
                 <tr><td style="padding:8px" ></td></tr>                                                                                               

   <tr>
                                                <td id="tdClientPart"  runat="server" width="125px">
                                                    <asp:Label ID="Rs_ClientName" runat="server" AccessKey="C" AssociatedControlID="txtClient"
                                                        Text="Client Name" meta:resourcekey="Rs_ClientNameResource1"></asp:Label>
                                                </td>
                                                <td id="tdClientParttxt" runat="server" style="padding-left:10px">
                                                    <asp:TextBox ID="txtClient" runat="server" autocomplete="off" CssClass="AutoCompletesearchBox Txtboxsmall"
                                                        meta:resourcekey="txtClientResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" CompletionInterval="1"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="2" 
                                                        OnClientItemSelected="ClientitemSelected" ServiceMethod="GetRateCardForBilling" ServicePath="~/OPIPBilling.asmx"
                                                        TargetControlID="txtClient">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
<td id="td1" runat="server" style="padding-left:35px">
            <asp:Label ID="Label1" runat="server" Text="Batch ID" meta:resourcekey="lblTimeResource1"></asp:Label>
</td> 
<td style="padding-left:55px">
            <asp:TextBox ID="txtBatchID" runat="server" onkeyup="repeat()"  meta:resourcekey="txtDoFrmVisitNumberResource1"></asp:TextBox>
             <asp:Label ID="Label9"  Width="10" runat="server" meta:resourcekey="lblTimeResource1"></asp:Label>
            </td>
    <%-- <td id="td13" style="width: 125px;" runat="server" align="left">--%>
           <%-- <asp:Label ID="Label9" Width="10" runat="server" meta:resourcekey="lblTimeResource1"></asp:Label>--%>
<%--</td>        --%>
 <td  runat="server"  style="padding-left:35px">
                              <asp:Label ID="Label11" runat="server" AccessKey="C" AssociatedControlID="TextBox1"
                                                        Text="Test Name" meta:resourcekey="Rs_ClientNameResource1"></asp:Label>
                        </td>
                   
                                                <td id="td15" runat="server" style="padding-left:56px">
                                                    <asp:TextBox ID="TextBox1" runat="server" autocomplete="off" CssClass="AutoCompletesearchBox Txtboxsmall"
                                                        meta:resourcekey="txtClientResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" CompletionInterval="1"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="2" 
                                                        OnClientItemSelected="ItemSelectedtest" ServiceMethod="GetBillingItemsForClientBatch" ServicePath="~/OPIPBilling.asmx"
                                                        TargetControlID="TextBox1">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                           </tr>
                           <tr><td style="padding:8px"></td></tr>         
                          <tr> 
                          
                          <td  runat="server" align="center">
                          
                           
                           </td>
                            
                           </tr>


                          
                           <tr >
<td id="td3" runat="server">
            <asp:Label ID="Label3" runat="server" Text="From Date" meta:resourcekey="lblTimeResource1"></asp:Label>
</td> 
<td id="tdtimetxt" runat="server" style="padding-left:10px">
             <asp:TextBox ID="Fromdate" runat="server" CssClass="Txtboxsmall w-70p" 
                                                        meta:resourcekey="txtSampleDateResource1"></asp:TextBox>
                                                    <a href="javascript:NewCssCal('Fromdate','ddmmyyyy','arrow',true,12);">
                                                        <img src="../images/Calendar_scheduleHS.png" id="imgCalc" alt="Pick a date"></a>
</td>
<td id="td4" runat="server" style="padding-left:35px">
             <asp:Label ID="Label4" runat="server" Text="To Date" meta:resourcekey="lblTimeResource1" ></asp:Label>
</td> 
<td id="tdtimetxt1" style="padding-left:55px">
              <asp:TextBox ID="Todate" runat="server" CssClass="Txtboxsmall w-70p" onblur="AdditionalDetails();"
                                                        meta:resourcekey="txtSampleDateResource1"></asp:TextBox>
                                                    <a href="javascript:NewCssCal('Todate','ddmmyyyy','arrow',true,12);">
                                                        <img src="../images/Calendar_scheduleHS.png" id="img1" alt="Pick a date"></a>
</td>
<td id="td5" runat="server"  style="padding-left:35px" >
               <asp:Label ID="Label5" runat="server" Text="Registration Count" meta:resourcekey="lblTimeResource1"></asp:Label>
</td> 
<td style="padding-left:55px">
               <asp:TextBox ID="TxtBillingID" runat="server" meta:resourcekey="txtDoFrmVisitNumberResource1"></asp:TextBox>
</td>
</tr>
<tr><td style="padding:8px"></td></tr>         
  
<tr class="a-center">
<td colspan="20">
              <asp:Button ID="Save" runat="server" CssClass="btn"
              Text="SAVE" meta:resourcekey="btnUpdateResource1" OnClientClick="return validate(this);" onclick="Save_Click" /></td>
              </tr>

     <tr><td style="padding:8px"></td></tr>         
          </table> 
          
          
    </asp:Panel>
          
           <asp:Panel ID="pnlCommercialss" runat="server" CssClass="w-100p">
           <table>
           <tr class="colorforcontent">
                                                                                                                    <td colspan="12" class="padding8">
                                                                                                                        <p class="bold">
                                                                                                    <%--BATCH SEARCH--%><%=Resources.Invoice_ClientDisplay.Invoice_ClientBatchMaster_aspx_013%> </p>
                                                                                                                    </td>
               
                 <tr><td><br/></td></tr>                                                                                                 </tr>
           <tr>
           <td width="125px">  
            <asp:Label ID="Label2" runat="server" AccessKey="C" AssociatedControlID="txtClient"
                                                        Text="Client Name" meta:resourcekey="Rs_ClientNameResource1"></asp:Label>
             </td>
              <td id="td2" runat="server">
                                                    <asp:TextBox ID="Cliclientname" runat="server" autocomplete="off" CssClass="AutoCompletesearchBox Txtboxsmall"
                                                        meta:resourcekey="txtClientResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionInterval="1"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="2" 
                                                        OnClientItemSelected="ClientitemSelected" ServiceMethod="GetRateCardForBilling" ServicePath="~/OPIPBilling.asmx"
                                                        TargetControlID="Cliclientname">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                                 <td id="Td10" runat="server" style="padding-left:35px">
                                                                            <asp:Label ID="Rs_TinNo1" Text="Client Code" runat="server" meta:resourcekey="Rs_TinNo1Resource1"></asp:Label>
                                                                        </td>
                                                                        <td id="Td11" runat="server" style="padding-left:55px">
                                                                            <asp:TextBox ID="txtClientCodeSrch" runat="server" MaxLength="20" CssClass="small"></asp:TextBox>
                                                                            <div id="aceClientCodeSrch">
                                                                            </div>
                                                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender10" runat="server" TargetControlID="txtClientCodeSrch"
                                                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                                MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetHospAndRefPhy"
                                                                                ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True" UseContextKey="True"
                                                                                >
                                                                            </ajc:AutoCompleteExtender>
                                                                        </td>
                                                                        
                                                <td id="td6"  runat="server" style="padding-left:35px">
            <asp:Label ID="Label6" runat="server" Text="Batch ID"  meta:resourcekey="lblTimeResource1"></asp:Label>
</td> 
<td style="padding-left:55px">
            <asp:TextBox ID="CliBatchid" runat="server" meta:resourcekey="txtDoFrmVisitNumberResource1"></asp:TextBox>
            </td>
            </tr>
              <tr><td><br/></td></tr>
            <tr>
            <td id="td7" runat="server">
              <asp:Label ID="Label8" runat="server" Text="From Date" meta:resourcekey="lblTimeResource1"></asp:Label>
</td> 
            <td>
             <asp:TextBox ID="CliFromdate" runat="server" CssClass="Txtboxsmall w-70p" 
                                                        meta:resourcekey="txtSampleDateResource1"></asp:TextBox>
                                                   
                                                        <a href="javascript:NewCssCal('CliFromdate','ddmmyyyy','arrow',true,12);">
                                                        <img ID="img2" alt="Pick a date" src="../images/Calendar_scheduleHS.png"></img></a>
                                                        </td>
                                                        
                                                            
                                                                <td ID="td8" runat="server" style="padding-left:35px">
                                                                    <asp:Label ID="Label7" runat="server" meta:resourcekey="lblTimeResource1" 
                                                                        Text="To Date"></asp:Label>
                                                                </td>
                                                                <td ID="td9" runat="server" style="padding-left:55px">
                                                                    <asp:TextBox ID="CliTodate" runat="server" CssClass="Txtboxsmall w-70p" 
                                                                        meta:resourcekey="txtSampleDateResource1" ></asp:TextBox>
                                                                    <a href="javascript:NewCssCal('CliTodate','ddmmyyyy','arrow',true,12);">
                                                                    <img ID="img3" alt="Pick a date" src="../images/Calendar_scheduleHS.png"></img></a>
                                                                </td>
                                                                 <td ID="td13" runat="server" style="padding-left:35px">
                                                                    <asp:Label ID="Label10" runat="server" meta:resourcekey="lblTimeResource1" 
                                                                        Text="Batch Status"></asp:Label>
                                                                </td>
                                                                 <td style="padding-left:55px">
                                                            <asp:DropDownList ID="ddlstatusbatch" CssClass="ddlsmall" runat="server" >
                                                               <%-- onblur="collapseDropDownList(this);">--%>
                                                            </asp:DropDownList>
                                                        </td>
                                                              
                
                </tr>
                  <tr><td><br/></td></tr>
<tr>
                                                                    <td id="Td12" colspan="8" align="center"  runat="server">
                                                                     
                                                                           <button type="button"  id="btnSaveBook" class="btn"  onclick="GetData();">
                                                            SEARCH</button>
                                                                        </td></tr>
                                                                        <tr><td style="padding:8px"></td></tr>         
<%--                  //-----chindhujapdf----                                                      --%>
                    <tr>
                        <td align="center" id="td20" runat="server">
                            <asp:Panel ID="pnlOutDoc" runat="server" Style="display: none; height: 540px; width: 1050px;"
                                ScrollBars="Vertical" CssClass="modalPopup dataheaderPopup" meta:resourcekey="pnlOutDocResource1">
                                <%--<asp:Panel ID="pnlOutDoc" runat="server" Style="display: none; 600px; width: 1050px;"
                                        ScrollBars="Vertical" CssClass="
                                        Popup dataheaderPopup">--%>
                                <div id="div7">
                                    <table border="0" cellpadding="2" cellspacing="1" width="100%" class="dataheader2 defaultfontcolor">
                                        
                                        <tr id="trPDF1" runat="server">
                                            <td>
                                                <iframe id="ifPDF1" runat="server" width="1000" height="550"></iframe>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <input id="btnClose1" runat="server" class="btn" type="button" value="Close" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <input type="button" id="Button2" runat="server" style="display: none;" />
                                            </td>
                                        </tr>
                                        </table>
                                </div>
                            </asp:Panel>
                            <cc1:ModalPopupExtender ID="mpopOutDoc" runat="server" BackgroundCssClass="modalBackground"
                                DropShadow="false" PopupControlID="pnlOutDoc" CancelControlID="btnClose1" TargetControlID="Button2"
                                Enabled="True">
                            </cc1:ModalPopupExtender>
                        </td>
                    </tr>
   
                  <%------pdfclose---                                           --%>
             
           </table>
             <table id="tblbatchlist"></table>
           </asp:Panel>      
        
                                                        
   

                        
                      <input id="Hidden1" type="hidden" value="0" runat="server" />                           
     <input id="hdnSelectedClientTempDetails" type="hidden" value="0" runat="server" />
     <input type="hidden" runat="server" value="N" id="hdnIsCashClient" />
      <input type="hidden" runat="server" value="N" id="hdnIsMappedItem" />
      <input id="hdnSelectedClientID" type="hidden" value="-1" runat="server" />
      <input id="hdnSelectedClientCode" type="hidden" value="-1" runat="server" />
    <input id="hdnSelectedClientRateID" type="hidden" value="-1" runat="server" />
    <input id="hdnSelectedClientClientID" type="hidden" value="0" runat="server" />
    <input id="hdnSelectedClientMappingID" type="hidden" value="0" runat="server" />
    <input id="hdnCollectionID" runat="server" value="0" type="hidden" />
      <input id="hdnTotalDepositAmount" runat="server" value="0" type="hidden" />
      <input id="hdnTotalDepositUsed" runat="server" value="0" type="hidden" />
       <input id="hdnAmtRefund" runat="server" value="0" type="hidden" />
        <asp:HiddenField ID="hdnClientAttrList" Value="" runat="server" />
          <input id="hdnRateID" runat="server" type="hidden" value="0" />
          <input id="hdnClientID" type="hidden" value="-1" runat="server" />
          <input type="hidden" id="HdnCoPay" runat="server" />
            <input id="hdnCpedit" type="hidden" value="N" runat="server" />
          <asp:HiddenField ID="hdnPageType" runat="server" Value="B2C" />
            <asp:HiddenField runat="server" ID="hdnloginRoleName" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
      <%--<script src="../Scripts/jquery-1.11.3.min.js" type="text/javascript"></script>--%>
   
   <%-- <script src="../Scripts/jquery.dataTables.min.js" type="text/javascript"></script>--%>

    <script src="../QMS/plugins/datatables/jquery.dataTables.js" type="text/javascript"></script>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../QMS/plugins/datatables/jquery.dataTables.min.css" rel="stylesheet"
 type="text/css" />
    <%--<link href="../StyleSheets/jquery.datatable.css" rel="stylesheet" type="text/css" />--%>
     
    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>
   <script type="text/javascript">
       function validate(Event) {




           if (document.getElementById('txtClient').value == "") {

               alert('Please Enter Client Name');
               document.getElementById('txtClient').focus();
               return false;
           }
           else if (document.getElementById('txtBatchID').value == "") {

               alert('Please Enter BatchID');
               document.getElementById('txtClient').focus();
               return false;
           }
          else if (document.getElementById('Fromdate').value == "") {

               alert('Please Enter Fromdate');
               document.getElementById('txtClient').focus();
               return false;
           }
         else  if (document.getElementById('Todate').value == "") {

               alert('Please Enter Todate');
               document.getElementById('txtClient').focus();
               return false;
           }
       else if (document.getElementById('TxtBillingID').value == "") {

               alert('Please Enter BillingID');
               document.getElementById('txtClient').focus();
               return false;
           }
           }

       

       function getbatchid(arraybatchid) {
           if (arraybatchid.d.length > 0) {
               $('#Label9').html('Batchid Already exist');
               $('#Label9').css('color', 'red');
               
           }
           else {
               $('#Label9').html('');
           }
           
           

       }
       
       
       function AjaxGetFieldsDataSucceeded(lstOfData) {
           

           //var Items = lstOfData.d;
           //var i = 0;
           $('#tblbatchlist').dataTable({
  'destroy': true,
  'paging': true,
  'lengthChange': true,
  'searching': true,
  'ordering': true,
  'info': true,
  'autoWidth': true,

               "aaData": lstOfData.d,




               "aoColumns": [

                   { "sTitle": "ClientName", "mData": "ClientName"

                   },

                          { "sTitle": "ClientCode", "mData": "ClientCode"


                          },
                          { "sTitle": "BatchID", "mData": "Batchid"

                          }
                          ,
                          { "sTitle": "RegisteredCount", "mData": "RegisteredCount"

                          }
                          ,
                            { "sTitle": "Fromdate", "mData": "Fromdate", "mRender": function(data, type, full) {

                                return formatJsonDateTime(data);

                            }

                            },
                              { "sTitle": "Todate", "mData": "Todate", "mRender": function(data, type, full) {

                                  return formatJsonDateTime(data);

                              }

                              } ,
                          { "sTitle": "Status", "mData": "ReportStatus"

                          }
                              ,
                               {
                                   "sTitle": "Action", "mData": "FilePath",
                                   "mRender": function(data, type, row, meta) {
                                   if (type === 'display') {
                                      // data = '<a href="' + row.FilePath + '">' + row.ReportStatus + '</a>';
                                     //  return '<a href="Video2.aspx?videoId=' + data + '" class="videowindow">Watch</a>';
                                      // data='<input type="button" url="' + row.FilePath + '" "Class="videowindow" BatchID="'+row.Batchid+'" onclick="onPdfView(this);" value='+ row.ReportStatus+' status="'+  row.ReportStatus  +'">' 
                                      if(row.ReportStatus =="Requested")
                                      {
                                      data = '<label style="cursor: pointer;" BatchID="'+row.Batchid+'" status="'+  row.ReportStatus  +'" >' + row.ReportStatus + '</label>';   
                                      }
                                      else{
                                       data = '<label style="cursor: pointer; color: #0000EE; text-decoration: underline;" BatchID="'+row.Batchid+'" onclick="onPdfView(this);" status="'+  row.ReportStatus  +'"  url="' + row.FilePath + '"Class="videowindow" >' + row.ReportStatus + '</label>';                                     
                                      }
                                       }
//                                       $('td > i', row).on('click', function() {};


                                       return data;
                                   }
                               } 
                          
                          
                         ]


    
           });

           jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');

          
       }
        function onPdfView(ctrl) {
          
               var status=$(ctrl).attr('status');
               var batid=$(ctrl).attr('BatchID')
              if(status=="Request")
              {
                objClear = "Are you sure you want to confirm the request?";

                   if (window.confirm(objClear)) {
                    InsertRequest(batid,ctrl);
                    // set link as label as a request
                    $(ctrl).css("text-decoration","none");
                    $(ctrl).attr("href","");
                   }
                   return false;

              }
              else if(status=='View')
              {
              $("#ifPDF1").attr('src','ClientBatchMaster.ashx?PictureName=' +$(ctrl).attr('url')+ "&OrgID=" + <%= OrgID %> );
               $('#Button2').click();
               }
               else
               {
               event.preventDefault();
               
               }
               return false;
               
           }
       function InsertRequest(batid,ctrl)
       {
      
      var obj = {};
      obj.orgID = document.getElementById("hdnOrgID").value;
      obj.batchid=batid;
      $.ajax({
                        type: "POST",
                        url: "../OPIPBilling.asmx/Insertpushingordereddetails",
                        contentType: "application/json; charset=utf-8",
                       
                       data:JSON.stringify(obj),
                        dataType: "json",
                        
                        success: function (data)
                        {
                        $(ctrl).html('Requested');
                         $(ctrl).attr('status','Requested');
                           GetData();
                         
                        },
                        
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert("Error");
                            $('#example').hide();
                           
                            return false;
                        }
                    });
                
               return false;
       
       }
       
       
       
       
       
     



       function formatJsonDateTime(jsonDate) {
           var monthNames = [
        "Jan", "Feb", "Mar",
        "Apr", "May", "Jun", "Jul",
        "Aug", "Sep", "Oct",
        "Nov", "Dec"
    ];
           var oldDate = new Date(parseInt(jsonDate.slice(6, -2)));
           var month;
           var hours = oldDate.getHours();
           var minutes = oldDate.getMinutes();
           var ampm = hours >= 12 ? 'pm' : 'am';
           hours = hours % 12;
           hours = hours ? hours : 12; // the hour '0' should be '12'
           minutes = minutes < 10 ? '0' + minutes : minutes;
           hours = hours < 10 ? '0' + hours : hours;
           var strTime = hours + ':' + minutes + ' ' + ampm;

           //    if ((1 + oldDate.getMonth()) == 12) {
           //        month = monthNames[0 + oldDate.getMonth()]
           //    }
           //    else {
           month = monthNames[0 + oldDate.getMonth()]
           //    }
           //var DateTime = (oldDate.getDate() + '/' + (1 + oldDate.getMonth()) + '/' + oldDate.getFullYear() + ' ' + oldDate.getHours() + ":" + oldDate.getMinutes().toString().slice(-2));
           //var DateTime = (oldDate.getDate() + '/' + (month) + '/' + oldDate.getFullYear() + ' ' + oldDate.getHours() + ":" + oldDate.getMinutes().toString().slice(-2));
           var DateTime = (oldDate.getDate() + '/' + (month) + '/' + oldDate.getFullYear() + ' ' + strTime);
           return DateTime;
       }
       
      

       

//        $('#ScrollArea').addClass('show');
                  </script>   
                   
   </form>
                   
    </body>
    </html>
    