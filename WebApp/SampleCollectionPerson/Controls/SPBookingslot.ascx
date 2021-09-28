<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SPBookingslot.ascx.cs"
    Inherits="SampleCollectionPerson_Controls_SPBookingslot" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>

<script src="../../Scripts/Common.js" type="text/javascript"></script>

<script type="text/javascript" src="https://code.jquery.com/ui/1.9.0/jquery-ui.js">  </script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.26.0/moment.min.js"></script>
<style type="text/css">
    .ui-autocomplete {
	z-index: 10000001;
}
    .foo
    {
        float: right;
        width: 50px;
        height: 10px;
        border: 1px solid rgba(0, 0, 0, .2);
    }
    .green
    {
        background: green;
    }
    .purple
    {
        background: gray;
    }
    .wine
    {
        background: #ae163e;
    }
</style>
<asp:UpdatePanel ID="pp" runat="server">
                <ContentTemplate>
<table width="100%" border="0" cellpadding="4" cellspacing="0" class="dataheader3">
    <tr>
        <td style="width: 15%">
            <asp:Label runat="server" style="" ID="lblpin" Text="PinCode"></asp:Label>
        </td>
        <td style="width: 20%">
            <input type="text" id="txtPincode" maxlength="50"  class="AutoCompletesearchBox"/>
            <span style="color: Red; ">*</span>
        </td>
        <td style="width: 15%">
            <asp:Label runat="server" ID="lblSCPName" Text="Sample Collection Person"></asp:Label>
        </td>
        <td style="width: 20%">
            <input type="text" id="txtname" maxlength="50" class="AutoCompletesearchBox" />
            <span style="color: Red">**</span>
        </td>
        <td style="width: 30%">
        </td>
    </tr>
    <tr>
        <td style="width: 15%">
            <asp:Label runat="server" ID="Label1" Text="Date"></asp:Label>
        </td>
        <td style="width: 20%">
              <asp:TextBox ID="txtDate" runat="server" MaxLength="12" CssClass="Txtboxsmall"></asp:TextBox>
         <span style="color: Red">*</span>
            <asp:ImageButton ID="ImgBntTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png" /><br />
            <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDate"
                Format="dd/MM/yyyy" PopupButtonID="ImgBntTo" Enabled="True" />
        </td>
        <td style="width: 15%">
            <input type="button" name="btnAvailcheck"  id="btnAvailcheck" value="Check" onclick="javascript:onClickAvailableCheck();" />
            <input type="button" name="ck" style="display:none"  id="ck"  onclick="javascript:onclosepopup();"  />
           <%-- <asp:Button ID= "ck" runat="server" OnClientClick="javascript:onclosepopup();" />--%>
        </td>
    </tr>
    <tr>
        <td colspan="5">
            <hr />
        </td>
    </tr>
    <tr id="tr12" >
        <td align="right">
            <img id="imgprv" style="display: none;  cursor: pointer" src="../Images/previous.png"
                alt="Previous" onclick="javascript:onClickPreviousCheck();" />
            <%-- <asp:ImageButton ID="ImageButton1" runat="server" OnClientClick ="javascript:onClickPreviousCheck();" ImageUrl="~/Images/previous.png" />--%>
        </td>
        <td colspan="3" valign="top">
            <div id="dvTable" >
            </div>
        </td>
        <td>
            <img id="imgnext" style="display: none;  cursor: pointer" src="../Images/next.png"
                alt="Next" onclick="javascript:onClickNextCheck();" />
        </td>
    </tr>
    <tr><td> <br /></td></tr>
    <tr id="tr1">
        <td>
      
        </td>
        <td colspan="1">
            <table>
                <tr>
                    <td>
                        Booked
                    </td>
                    <td>
                        <div class="foo green">
                        </div>
                    </td>
                    <td>
                        Open
                    </td>
                    <td>
                        <div class="foo purple">
                        </div>
                    </td>
                </tr>
            </table>
        </td>
        <td>
        </td>
    </tr>
    <tr>
        <td align="right">
        </td>
        <td colspan="3">
            <div id="divTable2">
            </div>
        </td>
        <td>
        </td>
    </tr>
    
</table>

</ContentTemplate>
</asp:UpdatePanel>
<input type="hidden" id="hdnUserID" runat="server" />
<input type="hidden" id="hdnOrgID" runat="server" />

<input type="hidden" id="hdngblResourceID" runat="server" />
<input type="hidden" id="hdngblBookingDate" runat="server" />
<input type="hidden" id="hdngblSlot" runat="server" />
<input type="hidden" id="hdngblpincode" runat="server" />
<input type="hidden" id="hdnTechName" runat="server" />

<script src="../../Scripts/jquery-ui.js" type="text/javascript"></script>
<link href="../../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
   
        var data = [];
        var tempData = [];
        var accessToken = "";
        var objPageNo = 0;
        var jsonresult="";
        var CheckDateColor="";
        var CheckSlotColor="";
        var row1 = 0;
        var row2 = 0;
        var row3 = 0;

        var gblBookingDate ="";
        var gblResourceID="";
        var gblSlot ="";
        var gblpincode="";
        var gblResourceName ="";
       
       
       
    
    $(document).ready(function () {
    
        GetAccessToken();       
        $("#tr1").hide();
        $("#tr2").hide();
        BindAutoCompPinCode();
        PinCodeWiseSCPerson();
        
        
        var today = new Date();

        var date = today.getDate() +'/'+(today.getMonth()+1)+'/'+ today.getFullYear();
       
        document.getElementById('<%=txtDate.ClientID %>').value =  date;
        // $("#txtPincode").val('700002')  ;
    });
    
    
    function GetAccessToken()
    {
    // var vurl = "http://localhost/LIMS_API/api/v1/";
    
     var vurl = '<%=ConfigurationManager.AppSettings["LIMSAPI_URL"] %>';
     vurl = vurl + "v1/";
     vurl = vurl + "Authenticate";
   
     var granttype = "grant_type=" + '<%=ConfigurationManager.AppSettings["grant_type"] %>';
     var username =  "&username=" + '<%=ConfigurationManager.AppSettings["username"] %>';
     var password = "&password=" + '<%=ConfigurationManager.AppSettings["password"] %>';
     var client_id = "&client_id=" + '<%=ConfigurationManager.AppSettings["client_id"] %>';
     var client_Secret= "&client_Secret=" +'<%=ConfigurationManager.AppSettings["client_Secret"] %>';
     var rawdata = granttype + username + password + client_id + client_Secret;
  
                    $.ajax({
                        type: "POST",
                        url: vurl,                        
                        contentType: 'application/json; charset=utf-8',
                        data: rawdata,
                        async: false,
                        dataType: "text",
                         success: function(result) {
                        if (result.length > 0) {
                            var obj = JSON.parse(result);
                          //  console.log(obj.access_token);
                            accessToken = obj.access_token;

                            }
                        }
            });    
     
     
     }
     
     
 function BindAutoCompPinCode() {    
    
    var objmode = "SCP";
    
    $("#txtPincode").autocomplete({  
     
            source: function (request, response) {
               var val = request.term;
               var vurl = '<%=ConfigurationManager.AppSettings["LIMSAPI_URL"] %>';
                var bearerToken =  "bearer " + accessToken;
                vurl = vurl + 'HomeCollection/GetPinCode?PrefixText=' + val + '&pMode=' + objmode ;

                $.ajax({
                    url: vurl,                   
                    type: "GET",
                    contentType: "application/json",
                    dataType: 'json',
                    headers:{"Authorization" : bearerToken },
                    success: function (data) {

                            response($.map(data, function (item) {
                           // console.log(item.Pincode);
                                        return {
                                            label: item.Pincode
                                        };
                                    }));
        
                            
                    },
                    error: function (err) {
                     
                    }
                });
            },
            minLength: 1  , // MINIMUM 1 CHARACTER TO START WITH.
             select: function(event, ui) {
                    $("#txtPincode").val(ui.item.label);  
                    PinCodeWiseSCPerson();                 
                     return false;
                }
        });
        
    }
    
    
    function PinCodeWiseSCPerson() {    
    
     var objOrgID = document.getElementById("<%=hdnOrgID.ClientID%>").value;  
     
     //alert(objOrgID);
     var objPinCode = $("#txtPincode").val();
     
     if (objPinCode == '')
     objPinCode = 0;
     
    $("#txtname").autocomplete({  
     
            source: function (request, response) {
               var val = request.term;
               var vurl = '<%=ConfigurationManager.AppSettings["LIMSAPI_URL"] %>';
                var bearerToken =  "bearer " + accessToken;
          //    var vurl = "http://localhost/LIMS_API/api/";
                vurl = vurl + 'HomeCollection/GetSampleCollectionPersonList?PrefixText=' + $('#txtname').val() + '&OrgID=' + objOrgID + '&pPinCode=' + objPinCode ; 

                $.ajax({
                    url: vurl,                   
                    type: "GET",
                    contentType: "application/json",
                    dataType: 'json',
                    headers:{"Authorization" : bearerToken },
                    success: function (data) {

                            response($.map(data, function (item) {
                                        return {
                                            label: item.Name
                                        };
                                    }));
        
                            
                    },
                    error: function (err) {
                     
                    }
                });
            },
            minLength: 1  , // MINIMUM 1 CHARACTER TO START WITH.
             select: function(event, ui) {
                    $("#txtname").val(ui.item.label);                   
                     return false;
                }
        });
        
       
            
        
    }
     function onClickPreviousCheck(){
            $("#tr1").show();
            $("#tr2").show();
            // $("#dvTable").show();
            $('#divTable2').empty();
            $('#divTable').empty();
            objPageNo = objPageNo - 1 ;

            if (objPageNo >= 0)
            {
                onClickAvailableCheck();
            }
            else{

              objPageNo = 0;
            }
     }
     
        function onClickNextCheck(){
            $("#tr1").show();
            $("#tr2").show();
            $('#divTable2').empty();
            $('#divTable').empty();
            objPageNo = objPageNo + 1 ;
            onClickAvailableCheck();
            $("#dvTable").show();
        }
     
     
     
     
     function addAllColumnHeaders(myList, table_id) {
     
    // console.log(myList[0].ResourceName)
    var columnSet = [];
    var headerTr$ = $('<tr/>');

    for (var i = 0; i < myList.length; i++) {
        var rowHash = myList[i].ResourceName;
        for (var key in rowHash) {
            if ($.inArray(key, columnSet) == -1) {
                columnSet.push(key);
                headerTr$.append($('<th/>').html(key));
            }
        }
    }
    $("#tblslot"+table_id).append(headerTr$);

    return columnSet;
  }


function onClickSlot(Currval)
{
        $("#tr1").show();
        $("#tr2").show();
        
        //get previous tab color change code
        $('#td-1').css('background-color','white')
        $(CheckDateColor).css('background-color','white')
//        para=1;
        var BookClickDate = $(Currval).attr('BookingDate');

        CheckDateColor = Currval;
        //$(Currval).toggleClass('selected');
        $(Currval).css('background-color','#66ff99')
        //var result = jsonresult;
        $('#divTable2').empty();
        row1 = 0;
        row2 = 0;
        row3 = 0;

        DataBinding(jsonresult, BookClickDate);
} 


function onclosepopup(){

//$('#divTable2').empty();
}
    
    function onClickAvailableCheck(){
    
    
        if ($("#txtPincode").val() == '') {
                //alert('Leave FromDate should not empty');
                 ValidationWindow("PinCode should not empty.", "Alert");
	             $("#txtPincode").focus();
	             return false;
            }
          var FDate = document.getElementById('<%=txtDate.ClientID %>').value;
          
        if (FDate == '') {
                //alert('Leave FromDate should not empty');
                 ValidationWindow("Date should not empty.", "Alert");
	             document.getElementById('<%=txtDate.ClientID %>').focus();
	             return false;
            }
               // para=0;
                $('#divTable2').empty();
                $('#divTable').empty();
            
            
                var arrayF = new Array();
                arrayF = FDate.split('/');
                var CheckDate = (arrayF[2] + "/" + arrayF[1] + "/" + arrayF[0]);
                var LoginName =""
                
                var arrUN = new Array();
                try{
                
                    if($('#txtname').val() != ""){
                         arrUN = $('#txtname').val().split('(');
                    }
                    var objUserLogin =   arrUN[1];             
                    objUserLogin = objUserLogin.split(')');
                   
                    LoginName = objUserLogin[0];   
                    
                }
                catch(ex){
                    LoginName = "";
                } 
               
                var pincode = $("#txtPincode").val();               
                var objDate = CheckDate; 
                var objUser = document.getElementById("<%=hdnUserID.ClientID%>").value;                     
               // var LoginName = "";           
                var vurl = '<%=ConfigurationManager.AppSettings["LIMSAPI_URL"] %>';
                var bearerToken =  "bearer " + accessToken;
               // http://localhost:56508/api/HomeCollection/GetSCPBookingslot?pPinCode=0&pSCPPerson=testAttuneaaru&pCheckDate=2021-04-30&pUserID=1&PPageCount=0
                 vurl = vurl + 'HomeCollection/GetSCPBookingslot?pPinCode=' + pincode + '&pSCPPerson=' + LoginName + '&pCheckDate=' + objDate + '&pUserID=' + objUser + '&PPageCount=' +  objPageNo ;
                //    alert(vurl);
                 $.ajax({
                        type: "GET",
                        url: vurl,                        
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',  
                        async: false,                      
                        headers: {
                                   Authorization: bearerToken
                                 },   
                        dataType: "json",                 
                        success: function(result) {
                         $("#tr1").show();
                         $("#tr2").show();
                ///////////////////////////////Table 1 start ///////////////////////////////////////////////////////////////////////       
                      var table = $("<table width=900px />");
                        table[0].border = "1";
                              
                            //Add the header row.
                            var row = $(table[0].insertRow(-1));
                        
                             for (var i = 0; i < result.SCPBookingTable1.length; i++) {
                                  var headerCell = $('<th style="background-color:#87CEEB!important" />');
                                  headerCell.html(result.SCPBookingTable1[i].CheckingDate);
                                  row.append(headerCell);
                             
                             }
                         
                             //Add the data rows.
                           for (var i = 1; i < 2; i++) {
                                row = $(table[0].insertRow(-1));
                                
                                for (var j = 0; j < result.SCPBookingTable1.length; j++) {
                                     var Bookdate = result.SCPBookingTable1[j].ClickDate;                                
                                    if(j==0){
                                    var cell = $('<td id="td-'+(j+1)+'" BookingDate = ' + Bookdate + ' style="background-color:#66ff99!important;cursor:pointer;height:50px;text-align:center; text-decoration:underline;font-weight:bold;" onclick="javascript:onClickSlot(this);" ></td>');
                                      
                                    }
                                    else{
                                        var cell = $('<td id="td-'+(j+1)+'" BookingDate = ' + Bookdate + ' style="background-color:#fff!important;cursor:pointer;height:50px;text-align:center; text-decoration:underline;font-weight:bold;" onclick="javascript:onClickSlot(this);" ></td>');
                                       }
                                        cell.html(result.SCPBookingTable1[j].Available);
                                        row.append(cell);
                                }
                               
                                
                             }
                             
                             var dvTable = $("#dvTable");
                             dvTable.html("");
                             dvTable.append(table);                             
                             
                         ///////////////////////////////Table 1 end ///////////////////////////////////////////////////////////////////////       
                  
                        jsonresult = result;                       
                        DataBinding(result, "");                        
                        }
                        
                        
                 });
                 
           if (objPageNo <= 0)
           {
                $("#imgprv").hide(); 
                $("#imgnext").show();              
           }
           else{
                $("#imgprv").show(); 
                $("#imgnext").show();        
           }
          

    
    }
    
   
    
   function onClickBookingSlot(Currval){   
   
       gblBookingDate = $(Currval).attr('BookingDate');
       gblResourceID = $(Currval).attr('ResourceID');
       gblSlot = $(Currval).attr('Slot');
       
       gblpincode = $("#txtPincode").val(); 
       gblResourceName = $(Currval).attr('ResName');      
       
        //  alert(gblSlot);
         var now = new Date();
        
        var convertedTime = moment(gblSlot, 'hh:mm A').format('HH:mm')

        var d1 = gblBookingDate + " " + convertedTime;
        
       // var d4 = "2021-06-07 16:00";
    //   alert(convertedTime)
     // var d5 = convertedTime
      //  var d4 = gblBookingDate + "" + convertedTime;
      //  gblBookingDate.concat(d5);
       
      //  alert(gblBookingDate)
        var d2 = stringToDate(d1);
//       alert(gblBookingDate)
//        alert(d2)
        if ( Date.parse(now) > d2)
        {
           
             ValidationWindow("Please choose greater than Current time.", "Alert");
            return false;
        }
        
        
        var vurl = '<%=ConfigurationManager.AppSettings["LIMSAPI_URL"] %>';
              
                     vurl = vurl + 'HomeCollection/CheckDuplicateBookingSlot?pPinCode=' + gblpincode + '&pUserID=' + gblResourceID + '&pDate=' + gblBookingDate + '&pTime=' + convertedTime ;
                     var bearerToken =  "bearer " + accessToken;
                    $.ajax({
                        type: "POST",
                        url: vurl,                        
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',
                        headers:{"Authorization" : bearerToken },
                        success: function(result) {
                     //   alert(result);
                        if (result== 0) {
                           
                           
                           $(CheckSlotColor).css('background-color','gray');
                           $(Currval).css('background-color','#FFA6C9');
                           CheckSlotColor = Currval;
                           
                        
                            document.getElementById("<%=hdngblResourceID.ClientID%>").value = gblResourceID;   
                            document.getElementById("<%=hdngblBookingDate.ClientID%>").value = gblBookingDate;   
                            document.getElementById("<%=hdngblSlot.ClientID%>").value = gblSlot;   
                            document.getElementById("<%=hdngblpincode.ClientID%>").value = gblpincode;   
                            document.getElementById("<%=hdnTechName.ClientID%>").value = gblResourceName; 
                           
                             }
                             else{
                               ValidationWindow("User Mapped with Other location for this Slot.", "Alert");
                             }
                        
                        }
            });   


      
        
   }
   
   
    
    function DataBinding(result, BookClickDate){
                         
            var starttime = '06:00AM'; 
            var endtime = '11:59PM';
                       
             for (var i = 0; i < result.SCPBookingTable3[0].SCPCount; i++) { 
                   
                       if(BookClickDate == ""){                       
                            BookClickDate = result.SCPBookingTable1[0].ClickDate 
                       }
                    //alert(BookClickDate)
                        $('#divTable2').append('<br />');
                        var $table = $('<table  width="900px" id="tblslot-'+(i+1)+'"  style= "background-color: #ffffff; filter: alpha(opacity=40); opacity: 0.95;border:1px Gray solid;"></table>');
                        $('#divTable2').append($table);
                        
                        var row = $($table[0].insertRow(-1));
                                    
                            var headerCell = $('<th style="width:500px" colspan= 20/>');
                                  
                             headerCell.html(result.SCPBookingTable3[i].ResourceName);
                             row.append(headerCell);
                       

                   for (var j = 0; j < 3; j++) {
                            var row$ = $('<tr id="tr-'+(j+1)+'" > </tr>');
                       
                        for (var colIndex = 0; colIndex < result.SCPBookingTable2.length; colIndex++) {
                                
                                if(BookClickDate == result.SCPBookingTable2[colIndex].ClickDate){
                                
                                    if(result.SCPBookingTable3[i].ResourceTemplateID == result.SCPBookingTable2[colIndex].ResourceTemplateID){
                                      
                                        var cellValue =  result.SCPBookingTable2[colIndex].SlotDuration;
                                         var bookingslot =  result.SCPBookingTable2[colIndex].BookedSlot;
                                         var ResourceID =  result.SCPBookingTable2[colIndex].ResourceID;
                                         var ClickDate =  result.SCPBookingTable2[colIndex].ClickDate;
                                         var RName =  result.SCPBookingTable2[colIndex].ResourceName;
                                         
                                         var dummy= 0;
                                        if (cellValue == null) {
                                        cellValue = "";
                                        }
                                        
                                      
                                         if(cellValue.length == 6){
                                         cellValue = '0' + cellValue;
                                         }
                                         
                                      if(cellValue != ""){                                            
                                         
                                        if(j==0){                                       
                                                starttime = '00:00AM';
                                                endtime = '11:59AM';

                                                var start_date = '04/20/2017 ' + starttime;
                                                var end_date = '04/20/2017 '  + endtime;
                                                
                                                var  cellValue1 = cellValue.split("-");
                                                 var   cellValue2 = cellValue1[0];
                                       
                                             
                                                 //  console.log( cellValue2.length)
                                                 if(cellValue2.length == 7){
                                                 
                                                 cellValue2 = '0' + cellValue2;
                                                 }
                                                  //console.log( cellValue2)
                                           
                                                var cellV = '04/20/2017 '  + cellValue2;
                                                
                                                

                                                var d1 = stringToDate(start_date);
                                                var d2 = stringToDate(end_date);
                                                var d3 = stringToDate(cellV);
                                               
                                                var diff = d2.getTime() - d3.getTime();

                                                if (diff < 0) {                                                  
                                                }else{                                                
                                                if(row1==0 ){                                              
                                                    row$.append($('<td id="td1-'+(colIndex+1)+'" style="width:100px;height:20px;text-align:left;color:green;background-color:#fff!important;font-weight:bold;" ><img src="../Images/Morning.png" />  Morning</td>'));
                                                    row1 = 1;                                                
                                                }  
                                                    if(result.SCPBookingTable2[colIndex].BookedSlot== 0){
                                                       row$.append($('<td id="td-'+(colIndex+1)+'" BookingDate = "' + ClickDate + '" ResourceID = ' + ResourceID + ' ResName = "' + RName + '" Slot = ' + cellValue + ' style="padding-right:2px;width:75px;height:25px;text-align:center; text-decoration:underline;background-color:gray!important;border :5px solid white;cursor:pointer;color:white;" onclick="javascript:onClickBookingSlot(this);" ></td>').html(cellValue));
                                                    } 
                                                    else{
                                                    row$.append($('<td id="td-'+(colIndex+1)+'" style="padding-right:2px;width:75px;height:25px;text-align:center;background-color:green!important;border :5px solid white;color:white;" ></td>').html(cellValue));
                                                     }                                  
                                                    
                                                }
                                        }
                                        
                                        if(j==1){                                       
                                                starttime = '12:00PM';
                                                endtime = '03:59PM';

                                                var start_date = '04/20/2017 ' + starttime;
                                                var end_date = '04/20/2017 '  + endtime;
                                               var  cellValue1 = cellValue.split("-");
                                                 var   cellValue2 = cellValue1[0];
                                                 
                                                 if(cellValue2.length == 7){
                                                 cellValue2 = '0' + cellValue2;
                                                 }
                                       
                                                    
                                                var cellV = '04/20/2017 '  + cellValue2;

                                                var d1 = stringToDate(start_date);
                                                var d2 = stringToDate(end_date);
                                                var d3 = stringToDate(cellV);

                                                var diff = d2.getTime() - d3.getTime();
                                                var diffS = d3.getTime() - d1.getTime();
                                         
                                                if (diffS < 0) {
                                                  
                                                }else{

                                                    if (diff < 0) {
                                                      
                                                    }else{
                                                     if(row2==0 ){
                                                        row$.append($('<td id="td1-'+(colIndex+1)+'" style="width:100px;height:20px;text-align:left;color:Red;background-color:#fff!important;font-weight:bold;"  ><img src="../Images/Afternoon.png" />  Afternoon</td>'));
                                                        row2 = 1;
                                                    }
                                                     if(result.SCPBookingTable2[colIndex].BookedSlot== 0){
                                                       row$.append($('<td id="td-'+(colIndex+1)+'" BookingDate = ' + ClickDate + ' ResourceID = ' + ResourceID + ' ResName = "' + RName + '" Slot = ' + cellValue + '  style="padding-right:2px;width:75px;height:25px;text-align:center; text-decoration:underline;background-color:gray!important;border :5px solid white;cursor:pointer;color:white;" onclick="javascript:onClickBookingSlot(this);" ></td>').html(cellValue));
                                                    } 
                                                    else{
                                                    row$.append($('<td id="td-'+(colIndex+1)+'" style="padding-right:2px;width:75px;height:25px;text-align:center;background-color:green!important;border :5px solid white;color:white;" ></td>').html(cellValue));
                                                     }  
                                                    }
                                                
                                                }
                                        }

                                       if(j==2){                                       
                                                starttime = '04:00PM';
                                                endtime = '09:59PM';

                                                var start_date = '04/20/2017 ' + starttime;
                                                var end_date = '04/20/2017 '  + endtime;
                                                
                                               var  cellValue1 = cellValue.split("-");
                                                 var   cellValue2 = cellValue1[0];
                                                 
                                                 if(cellValue2.length == 7){
                                                 cellValue2 = '0' + cellValue2;
                                                 }
                                       
                                                    
                                                var cellV = '04/20/2017 '  + cellValue2;

                                                var d1 = stringToDate(start_date);
                                                var d2 = stringToDate(end_date);
                                                var d3 = stringToDate(cellV);

                                                var diff = d2.getTime() - d3.getTime();
                                                var diffS = d3.getTime() - d1.getTime();
                                        
                                                if (diffS < 0) {
                                                  
                                                }else{

                                                if (diff < 0) {
                                                  
                                                }else{
                                                if(row3==0 ){
                                                    row$.append($('<td id="td-'+(colIndex+99)+'" style="width:100px;height:20px;text-align:left;color:orange;background-color:#fff!important;font-weight:bold;"  ><img src="../Images/Evening.png" />  Evening</td>'));
                                                    row3=1;
                                                }
                                                    if(result.SCPBookingTable2[colIndex].BookedSlot== 0){
                                                       row$.append($('<td id="td-'+(colIndex+1)+'" BookingDate = ' + ClickDate + ' ResourceID = ' + ResourceID + ' ResName = "' + RName + '" Slot = ' + cellValue + '  style="padding-right:2px;width:75px;height:25px;text-align:center; text-decoration:underline;background-color:gray!important;border :5px solid white;cursor:pointer;color:white;" onclick="javascript:onClickBookingSlot(this);" ></td>').html(cellValue));
                                                    } 
                                                    else{
                                                    row$.append($('<td id="td-'+(colIndex+1)+'" style="padding-right:2px;width:75px;height:25px;text-align:center;background-color:green!important;border :5px solid white;color:white;" ></td>').html(cellValue));
                                                     }  
                                                }
                                                
                                           }
                                        }
                                        
                                     }
    
                                        
                                    }
                                }

                                $("#tblslot-"+(i+1)).append(row$)
                                
                                }
                                row1 = 0;
                                row2 = 0;
                                row3 = 0;

                            }
                            
                            $('#divTable2').append('<br />');
                            
                        
                        
                    }
    
 }
     
 function compareDateTimes() {
    //date format ex "04/20/2017 01:30PM"
    //the problem is that this format results in Invalid Date
    //var d0 = new Date("04/20/2017 01:30PM"); => Invalid Date

    var start_date = '04/20/2017 04:30PM';
    var end_date = '04/20/2017 01:30PM';

    if (start_date=="" || end_date=="") {
        return;
    }
    //break it up for processing
    var d1 = stringToDate(start_date);
    var d2 = stringToDate(end_date);

    var diff = d2.getTime() - d1.getTime();

    if (diff < 0) {
       alert(1)
    }else{
     alert(2)
    }
}

function stringToDate(the_date) {
    var arrDate = the_date.split(" ");
    var the_date = arrDate[0];
    var the_time = arrDate[1];
    var arrTime = the_time.split(":");
    var blnPM = (arrTime[1].indexOf("PM") > -1);
    //first fix the hour
    if (blnPM) {
        if (arrTime[0].indexOf("0")==0) {
            var clean_hour = arrTime[0].substr(1,1);
            arrTime[0] = Number(clean_hour) + 12;
        }
        arrTime[1] = arrTime[1].replace("PM", ":00");
    } else {
        arrTime[1] = arrTime[1].replace("AM", ":00");
    }
    var date_object =  new Date(the_date);
    //now replace the time
    date_object = String(date_object).replace("00:00:00", arrTime.join(":"));
    date_object =  new Date(date_object);

    return date_object;
}



</script>

