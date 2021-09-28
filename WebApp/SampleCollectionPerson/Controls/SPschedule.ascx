<%@Control Language="C#" AutoEventWireup="true" CodeFile="SPschedule.ascx.cs" Inherits="SampleCollectionPerson_Controls_SPschedule" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%--<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>--%>

<script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
 <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    
   
<script src="../../Scripts/Common.js" type="text/javascript"></script>
<%--<script type="text/javascript" src="../js/sampleCollection.js"></script>--%>
<%--<link href="../css/jquery-ui.css" rel="stylesheet" type="text/css" />
<script src="../js/jquery.autocomplete.js" type="text/javascript"></script>--%>
<%--<script src="../../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>--%>
<%--  <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />--%>

<script type="text/javascript" src="https://code.jquery.com/ui/1.9.0/jquery-ui.js">  </script>

<%--   <link type="text/css" href="../../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />--%>
<link href="../../StyleSheets/Common.css" rel="stylesheet" type="text/css" />


<table width="100%" border="0" cellpadding="4" cellspacing="0" class="dataheader3">
    <tr>
        <td style="width: 15%">
            <asp:Label runat="server" ID="lblSCPName" Text="Sample Collection Person"></asp:Label>
        </td>
        <td style="width: 15%">
            <input type="text" id="txtname"  maxlength="50" class="AutoCompletesearchBox" tabindex="1" />
            <span style="color: Red">*</span>
        </td>
        <td style="width: 15%">
            <%--<asp:Button ID="ImgBntFromDate" runat="server" Text="Load" TabIndex="1" />--%>
            <%--<asp:Button ID="Button3" runat="server" Text="History" TabIndex="1" />       --%>
             <input type="button" name="btnSave" value="Load" onclick="javascript:onClickLoad();" tabindex="2"/>
        </td>
        <td style="width: 15%">
        </td>
        <td style="width: 15%">
        </td>
        <td style="width: 25%">
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label runat="server" ID="Label1" Text="Working Days"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtCombo" runat="server" ReadOnly="true" CssClass="Txtboxsmall" TabIndex ="3"></asp:TextBox>
            <cc1:PopupControlExtender ID="PopupControlExtender111" runat="server" TargetControlID="txtCombo"
                PopupControlID="Panel111" Position="Bottom">
            </cc1:PopupControlExtender>
            <input type="hidden" name="hidVal" id="hidVal" runat="server" />
            <input type="hidden" name="hidchklistvalue" id="hidchklistvalue" runat="server" />
            <asp:Panel ID="Panel111" runat="server" ScrollBars="Vertical" Width="155" Height="150"
                BackColor="#cccccc" BorderColor="Gray" BorderWidth="1">
                <asp:CheckBoxList ID="chkList" runat="server" Height="150" onclick="CheckItem(this)">                  
                    <asp:ListItem Text="Monday" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Tuesday" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Wednesday" Value="3"></asp:ListItem>
                    <asp:ListItem Text="Thursday" Value="4"></asp:ListItem>
                    <asp:ListItem Text="Friday" Value="5"></asp:ListItem>
                    <asp:ListItem Text="Saturday" Value="6"></asp:ListItem>
                    <asp:ListItem Text="Sunday" Value="7"></asp:ListItem>
                </asp:CheckBoxList>
            </asp:Panel>
            <span style="color: Red">*</span>
        </td>
        <td>
            <asp:Label runat="server" ID="Label2" Text="PinCode Mapping"></asp:Label>
        </td>
        <td style="width: 15%">
            <%--  <asp:TextBox ID="txtPincode" runat="server"  onkeyup="return GetPincodeSearchList();"  MaxLength="20" CssClass="Txtboxsmall bg-searchimage" ></asp:TextBox>
      --%>
            <input type="text" id="txtPincode" onkeypress="return blockNonNumbers(this, event, true, false);"
                maxlength="6" class="AutoCompletesearchBox" tabindex="4" />
            <span style="color: Red">*</span>
        </td>
        <td>
            <input type="button" name="add" value="Add" onclick="javascript:onClickPinCode();" tabindex="5"/>
        </td>
        <td rowspan="3" valign="top">
            <div style="height: 100px; overflow: auto; width: 120px;">
                <table id="tblPinCode" runat="server" class="dataheaderInvCtrl w-93p">
                    <tr id="Tr1" runat="server" class="colorforcontent">
                        <td id="Td3" runat="server" class="bold font10 h-8 w-5p" style="color: White;">
                            <asp:Label ID="Rs_Delete1" runat="server" Text="Delete"></asp:Label>
                        </td>
                        <td id="Td4" runat="server" class="bold font10 h-8 w-25p" style="color: White;">
                            <asp:Label ID="Rs_Speciality" runat="server" Text="PinCode"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
            <%-- <select name="lstValue" multiple>
	    <option value="empty"></option></select>
	    <input type="button" name="delete" value="Delete" onclick="deleteValue();" />--%>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label runat="server" ID="lblStarttime" Text="Start Time"></asp:Label>
        </td>
        <td>
            <asp:DropDownList runat="server" ID="ddlFrom" CssClass="small"  TabIndex ="6">
            </asp:DropDownList>
            <span style="color: Red">*</span>
        </td>
        <td>
            <asp:Label runat="server" ID="lblEndtime" Text="End Time"></asp:Label>
        </td>
        <td>
            <asp:DropDownList runat="server" ID="ddlTo" CssClass="small"  TabIndex ="7">
            </asp:DropDownList>
            <span style="color: Red">*</span>
        </td>
        <td>
        </td>
        <td>
        </td>
    </tr>
       <tr>
        <td>
            <asp:Label runat="server" ID="Label11" Text=""></asp:Label>
        </td>
        <td>
        <table style="width: 100%"><tr><td style="width: 30%"> <asp:Label runat="server" ID="Label14" Text="Hours"></asp:Label></td>
        <td style="width: 70%"><asp:Label runat="server" ID="Label16" Text="Mints"></asp:Label></td></tr></table>
            
              
        </td>
        <td colspan="2">
          
        </td>
        <td>
        </td>
        <td>
        </td>
        <td>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label runat="server" ID="Label3" Text="Slot Duration"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txthours" runat="server" CssClass="Txtboxsmall" Width="50px" onkeypress="return blockNonNumbers(this, event, true, false);"
                MaxLength="2" TabIndex="8"></asp:TextBox>
            <asp:DropDownList ID="ddlmints" runat="server" TabIndex="9" CssClass="ddlsmall" Width="95px" >
            </asp:DropDownList>
            <span style="color: Red">*</span>
        </td>
        <td colspan="2">
            <input type="button" name="slotAdd" value="Add" onclick="javascript:onClickTimeSlot();" tabindex ="10" />
        </td>
        <td>
        </td>
        <td>
        </td>
        <td>
        </td>
    </tr>
    <tr>
        <td>
            <br />
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <div style="height: 150px; overflow: auto; display: block;" id="divslot">
                <table id="tblSlot" runat="server" class="dataheaderInvCtrl" width="100%" border="1">
                    <tr id="Tr2" runat="server" class="colorforcontent">
                     <td id="Td8" runat="server" class="bold font10 h-8 w-55p" style="color: White; width: 10%;
                            font-size: 12px">
                            <asp:Label ID="Label17" runat="server" Text="SlNo"></asp:Label>
                        </td>
                        <td id="Td1" runat="server" class="bold font10 h-8 w-55p" style="color: White; width: 45%;
                            font-size: 12px">
                            <asp:Label ID="Label4" runat="server" Text="Working Days"></asp:Label>
                        </td>
                        <td id="Td2" runat="server" class="bold font10 h-8 w-15p" style="color: White; width: 10%;
                            font-size: 12px">
                            <asp:Label ID="Label5" runat="server" Text="Start Time"></asp:Label>
                        </td>
                        <td id="Td5" runat="server" class="bold font10 h-8 w-15p" style="color: White; width: 10%;
                            font-size: 12px">
                            <asp:Label ID="Label6" runat="server" Text="End Time"></asp:Label>
                        </td>
                        <td id="Td6" runat="server" class="bold font10 h-8 w-15p" style="color: White; width: 15%;
                            font-size: 12px">
                            <asp:Label ID="Label7" runat="server" Text="Slot Duration"></asp:Label>
                        </td>
                        <td id="Td7" runat="server" class="bold font10 h-8 w-10p" style="color: White; width: 10%;
                            font-size: 12px">
                            <asp:Label ID="Label8" runat="server" Text="Action"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label runat="server" ID="Label9" Text="Restricted Days"></asp:Label>
        </td>
        <td>
            <%-- <asp:DropDownList runat="server" ID="ddlHolidays" TabIndex="9" CssClass="small" >
            </asp:DropDownList>
          --%>
            <select id="ddlHolidays" class="small">
            </select>
        </td>
        <td>
            <asp:Label runat="server" ID="Label10" Text="Leave Calendar"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtleaveFrom" runat="server" MaxLength="20" CssClass="Txtboxsmall"></asp:TextBox>
            <asp:ImageButton ID="ImgBntCalcFrom1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png" /><br />
            <%--    <ajc:MaskedEditExtender ID="MaskedEditExtender8" runat="server" TargetControlID="txtleaveFrom"
                                                            Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                            Enabled="True" />--%>
            <%--<ajc:MaskedEditValidator ID="MaskedEditValidator8" runat="server" 
                                                            ControlToValidate="txtleaveFrom"  InvalidValueMessage="Date is invalid"
                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                             />--%>
            <ajc:CalendarExtender ID="CalendarExtender8" runat="server" TargetControlID="txtleaveFrom"
                Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom1" Enabled="True" />
                 <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" CultureAMPMPlaceholder=""
                                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                            Enabled="True" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date" TargetControlID="txtleaveFrom">
                                                        </ajc:MaskedEditExtender>
        </td>
        <td>
            <asp:TextBox ID="txtleaveTo" runat="server" MaxLength="20" CssClass="Txtboxsmall"></asp:TextBox>
            <asp:ImageButton ID="ImgBntTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png" /><br />
            <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtleaveTo"
                Format="dd/MM/yyyy" PopupButtonID="ImgBntTo" Enabled="True" />
                 <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" CultureAMPMPlaceholder=""
                                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                            Enabled="True" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date" TargetControlID="txtleaveTo">
                                                        </ajc:MaskedEditExtender>
        </td>
        <td>
            <input type="button" name="btnLeaveAdd" value="Add" onclick="javascript:onClickLeave();" />
        </td>
    </tr>
    <tr>
        <td>
        </td>
        <td>
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <br />
            <div style="height: 100px; overflow: auto; display: block;" id="divleave">
                <table id="tblLeave" runat="server" class="dataheaderInvCtrl" width="100%" border="1">
                    <tr id="Tr3" runat="server" class="colorforcontent">
                    <td id="Td11" runat="server" class="bold font10 h-8 w-10p" style="color: White; width: 10%;
                            font-size: 12px">
                            <asp:Label ID="Label18" runat="server" Text="SlNo "></asp:Label>
                        </td>
                        <td id="Td13" runat="server" class="bold font10 h-8 w-25p" style="color: White; width: 20%;
                            font-size: 12px">
                            <asp:Label ID="Label19" runat="server" Text="Restricted Days"></asp:Label>
                        </td>
                        <td id="Td9" runat="server" class="bold font10 h-8 w-25p" style="color: White; width: 25%;
                            font-size: 12px">
                            <asp:Label ID="Label12" runat="server" Text="Leave FromDate "></asp:Label>
                        </td>
                        <td id="Td10" runat="server" class="bold font10 h-8 w-5p" style="color: White; width: 25%;
                            font-size: 12px">
                            <asp:Label ID="Label13" runat="server" Text="Leave ToDate"></asp:Label>
                        </td>
                        <td id="Td12" runat="server" class="bold font10 h-8 w-25p" style="color: White; width: 20%;
                            font-size: 12px">
                            <asp:Label ID="Label15" runat="server" Text="Action"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="6" align="center">
            <br />
            <input type="button" id="btnSave" value="Save" onclick="javascript:onClickSave();" style ="display:none;" />
             <input type="button" id="btnUpdate" value="Update" onclick="javascript:onClickUpdate();" style ="display:none;" />
            <input type="button" id="btnCancel" value="Cancel" onclick="javascript:onClickCancel();" />
        </td>
    </tr>
</table>
<input type="hidden" id="hdnPincode" runat="server" />
<input type="hidden" id="hdnRestempID" runat="server" />
<input type="hidden" id="hdnUserID" runat="server" />
<input type="hidden" id="hdnOrgID" runat="server" />
<input type="hidden" id="hdnLocName" runat="server" />


<script src="../../Scripts/jquery-ui.js" type="text/javascript"></script>
<script type="text/javascript">
   
        var data = [];
        var tempData = [];
        var listTime=new Array();
        var listTimeobj=new Object();
        var combined="";
        var listleave=new Array();        
        var listleaveobj=new Object();
        var gblleaveFrom = "";
        var gblTimeslot = "";
        var accessToken = "";
        
    $(document).ready(function () {
    
        GetAccessToken();
        BindAutoComplete();
        BindAutoCompPinCode();
        BindHolidays();
        $("#btnSave").show();
       $("#btnUpdate").hide();
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
   //  var rawdata = "grant_type=password&username=LIMSAPI&password=LIMSAPI&client_id=LIMSAPI&client_Secret=";
   
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
                            //console.log(obj.access_token);
                            accessToken = obj.access_token;

                            }
                        }
            });    
     }
     
     function clearfields(){
             
             $('#txtname').val('');
             
             document.getElementById("<%=hdnPincode.ClientID%>").value = '';
             document.getElementById('<%=txtleaveFrom.ClientID %>').value =  '';
             document.getElementById('<%=txtleaveTo.ClientID %>').value =  '';
             document.getElementById("<%=hdnRestempID.ClientID%>").value = '';
             document.getElementById("<%=txtCombo.ClientID%>").value = '';
             document.getElementById("<%=txthours.ClientID%>").value = '';
              
             
              $('#txtPincode').val('');
              $("#<%=ddlFrom.ClientID%>")[0].selectedIndex=0;
              $("#<%=ddlTo.ClientID%>")[0].selectedIndex=0;
              $("#<%=ddlmints.ClientID%>")[0].selectedIndex=0;
              
            
             combined = '';
             listleave = [];
             listTime = [];
             $("#btnSave").show();
             $("#btnUpdate").hide();
            
            $('#spSchd_tblSlot').find("tr:gt(0)").remove();
            $('#spSchd_tblSlot').find("tr:gt(0)").remove();
            $('#spSchd_tblPinCode').find("tr:gt(0)").remove();
            $('#spSchd_tblLeave').find("tr:gt(0)").remove();

     }
     
     function clearLoadfields(){
             
                          
             document.getElementById("<%=hdnPincode.ClientID%>").value = '';
             document.getElementById('<%=txtleaveFrom.ClientID %>').value =  '';
             document.getElementById('<%=txtleaveTo.ClientID %>').value =  '';
             document.getElementById("<%=hdnRestempID.ClientID%>").value = '';
             document.getElementById("<%=txtCombo.ClientID%>").value = '';
             document.getElementById("<%=txthours.ClientID%>").value = '';
              
             
              $('#txtPincode').val('');
              $("#<%=ddlFrom.ClientID%>")[0].selectedIndex=0;
              $("#<%=ddlTo.ClientID%>")[0].selectedIndex=0;
              $("#<%=ddlmints.ClientID%>")[0].selectedIndex=0;
             combined = '';
             listleave = [];
             listTime = [];            
            
            $('#spSchd_tblSlot').find("tr:gt(0)").remove();
            $('#spSchd_tblSlot').find("tr:gt(0)").remove();
            $('#spSchd_tblPinCode').find("tr:gt(0)").remove();
            $('#spSchd_tblLeave').find("tr:gt(0)").remove();

     }
     
     
     
   
    function  onClickCancel(){
    
        clearfields();
    } 
    
    function  onClickLoad(){
    
     clearLoadfields();
        
      var bearerToken =  "bearer " + accessToken;
      var vurl = '<%=ConfigurationManager.AppSettings["LIMSAPI_URL"] %>';
      
      if ($('#txtname').val() == '')
              {
                // alert("Sample Collection Person is required");
                  ValidationWindow("Sample Collection Person is required.", "Alert");
                 return false;
              }
              
    
      
         
             var arrUN = new Array();
               arrUN = $('#txtname').val().split('(');
               
               var objUserLogin =   arrUN[1];             
                   objUserLogin = objUserLogin.split(')');
                   //alert(objUserLogin[0]);
                           
                var LoginName = objUserLogin[0];           
                           
                //http://localhost:56508/api/HomeCollection/GetScheduleBySCPDetails?pSCPerson=test 
                 vurl = vurl + 'HomeCollection/GetScheduleBySCPDetails?pSCPerson=' + LoginName;
               //alert(vurl);
               $.ajax({
                        type: "GET",
                        url: vurl,                        
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',                        
                        headers: {
                                    orgcode :"LIMSAPI",
                                    Authorization: bearerToken
                                 },   
                        dataType: "json",                 
                        success: function(result) {
                        
                        if(result.ResourceTemplateID > 0 )
                        {
                         $("#btnSave").hide();
                        $("#btnUpdate").show();
                         document.getElementById("<%=hdnRestempID.ClientID%>").value = result.ResourceTemplateID;
                         
                         
                            for (var i = 0; i < result.SCPPinCode.length; i++) {
                           
                                document.getElementById("<%=tblPinCode.ClientID%>").style.display = 'table';                 
                                var row = document.getElementById("<%=tblPinCode.ClientID%>").insertRow(1);  
                                var obj = result.SCPPinCode[i].PinCode;           
                                row.id = obj;
                                var cell1 = row.insertCell(0);
                                var cell2 = row.insertCell(1);
                                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickSpecial(" + obj + ");' src='../Images/Delete.jpg' />";
                                cell1.width = "5%";
                                cell2.innerHTML = obj;
                                document.getElementById("<%=hdnPincode.ClientID%>").value += obj + "^";
                           } 
                        
                         for (var i = 0; i < result.SCPTimeInfoDet.length; i++) {
                     
                                //console.log(result.SCPTimeInfoDet[i].WorkingDays);
                                             
                                var totalRowCount = document.getElementById("<%=tblSlot.ClientID%>").rows.length
                                
                                var row = document.getElementById("<%=tblSlot.ClientID%>").insertRow(totalRowCount);            
                                row.id = totalRowCount;
                                
                                var cell0 = row.insertCell(0);
                                var cell1 = row.insertCell(1);
                                var cell2 = row.insertCell(2);
                                var cell3 = row.insertCell(3);
                                var cell4 = row.insertCell(4);
                                var cell5 = row.insertCell(5);                                
                                
                                var objWorkingDays = result.SCPTimeInfoDet[i].WorkingDays;
                                var objStartTime = result.SCPTimeInfoDet[i].StartTime.substring(0, 5);
                                var objEndTime = result.SCPTimeInfoDet[i].EndTime.substring(0, 5)
                                var objSlotDuration = result.SCPTimeInfoDet[i].SlotDuration.substring(0, 5)
                                 var objDeleteType = result.SCPTimeInfoDet[i].DeleteType;
                                   
                       var val = "";  
                       var arrWD = new Array();
                           arrWD = objWorkingDays.split(',');
                       
                       
                    if (arrWD != "") {
                     //alert(arrWD.length)
                        for (var count = 0; count < arrWD.length; count++) {
                            var SList = arrWD[count];
                             //alert(SList)
                           
                             if (SList == 1)
                                val = val + ", "+ 'Monday'; 
                            else if (SList == 2)
                                val = val + ", "+ 'Tuesday'; 
                            else if (SList == 3)
                                val = val + ", "+ 'Wednesday'; 
                            else if (SList == 4)
                                val = val + ", "+ 'Thursday'; 
                            else if (SList == 5)
                                val = val + ", "+ 'Friday'; 
                            else if (SList == 6)
                                val = val + ", "+ 'Saturday'; 
                            else if(SList == 7)
                                val = val + ", "+ 'Sunday'; 
                            
                             
                            }
                         }
                       
      
                                if(val.length > 0) 
                                {       
                                val = val.substring(2, val.length); //sacar la primer 'coma'
                                }
                                
                                cell0.innerHTML = totalRowCount;
                                cell1.innerHTML = val;
                                cell2.innerHTML = objStartTime;
                                cell3.innerHTML = objEndTime;
                                cell4.innerHTML = objSlotDuration;
                                if(objDeleteType == 0){
                                cell5.innerHTML = " &nbsp;&nbsp;<img id='imgbtn' style='cursor:pointer;' WorkingDay = '" + objWorkingDays + "' StartTime = " + objStartTime + " EndTime = " + objEndTime + " OnClick='ImgOnclickTimeDelete( this, " + totalRowCount + ");' src='../Images/Delete.jpg' />";
                                    }
                                listTime.push({
                                    WorkingDays: objWorkingDays,
                                    StartTime: objStartTime,
                                    EndTime    : objEndTime,
                                    SlotDuration   : objSlotDuration
                                });

                                combined = {
                                    LeaveInfoList: listleave,
                                    TimeInfoList: listTime
                                }
                                //console.log(JSON.stringify({ "Workingslot ":  listTime }));
                                console.log(JSON.stringify(combined));
                          
               
                            
                  }
                  
                   for (var i = 0; i < result.SCPLeave.length; i++) {
                   
                                var totalRowCount = document.getElementById("<%=tblLeave.ClientID%>").rows.length
                                var row = document.getElementById("<%=tblLeave.ClientID%>").insertRow(totalRowCount);
                                
                                row.id = "L" + totalRowCount;  
                                
                                var cell0 = row.insertCell(0); 
                                var cell1 = row.insertCell(1);
                                var cell2 = row.insertCell(2);
                                var cell3 = row.insertCell(3);
                                var cell4 = row.insertCell(4);
                                         
                              // str.substring(1, 4);
                              
                              var FDate = result.SCPLeave[i].StartDate.substring(0, 10)
                              var TDate = result.SCPLeave[i].EndDate.substring(0, 10)
                                var HDate = result.SCPLeave[i].Holidays.substring(0, 10)
                               
                                var arrayF = new Array();
                                var arrayT = new Array();
                                var arrayH = new Array();
                                
                                arrayF = FDate.split('-');
                                arrayT = TDate.split('-');
                                arrayH = HDate.split('-');
                                
                                var leavefromDate = (arrayF[2] + "/" + arrayF[1] + "/" + arrayF[0]);
                                var leaveToDate = (arrayT[2] + "/" + arrayT[1] + "/" + arrayT[0]);
                                 var leaveHoliday = (arrayH[2] + "/" + arrayH[1] + "/" + arrayH[0]);   
                                 
                                 if (leaveHoliday == "01/01/2021")
                                 {
                                 leaveHoliday = 'Happy New Year'
                                 }
                                 else if (leaveHoliday == "26/01/2021")
                                 {
                                 leaveHoliday = 'RepublicDay'
                                 }
                                 else if (leaveHoliday == "14/04/2021")
                                 {
                                 leaveHoliday = 'Tamil NewYear'
                                 }
                                 else if (leaveHoliday == "01/05/2021")
                                 {
                                 leaveHoliday = 'Labour Day'
                                 }
                                 else if (leaveHoliday == "15/08/2021")
                                 {
                                 leaveHoliday = 'Independence Day'
                                 }
                                 else if (leaveHoliday == "02/10/2021")
                                 {
                                 leaveHoliday = 'Gandhi Jayanti'
                                 }
                                 else if (leaveHoliday == "25/12/2021")
                                 {
                                 leaveHoliday = 'Christmas'
                                 }
                                 else 
                                 {
                                 leaveHoliday = 'Others'
                                 }
                                 var leavefrom = (arrayF[0] + "/" + arrayF[1] + "/" + arrayF[2]);
                                var leaveTo = (arrayT[0] + "/" + arrayT[1] + "/" + arrayT[2]);
                                 var leaveHoli = (arrayH[0] + "/" + arrayH[1] + "/" + arrayH[2]); 
                                        
                                 cell0.innerHTML = totalRowCount;
                                 cell1.innerHTML = leaveHoliday;
                                 cell2.innerHTML = leavefromDate;
                                 cell3.innerHTML = leaveToDate;
                                
                //                cell3.innerHTML = "<img id='imgbtn1' style='cursor:pointer;' LeaveFrom = " + objleaveFrom + " LeaveTo = " + objleaveFrom + " OnClick='ImgOnclickLeaveEdit(this);' src='../Images/edit.png' />&nbsp;&nbsp;<img id='imgbtn' style='cursor:pointer;' LeaveFrom = " + leavefromDate + " LeaveTo = " + leaveToDate + " OnClick='ImgOnclickLeaveDelete(this, " + totalRowCount + " );' src='../Images/Delete.jpg' />";
                                  cell4.innerHTML = "&nbsp;&nbsp;<img id='imgbtn' style='cursor:pointer;' LeaveFrom = " + leavefrom + " LeaveTo = " + leaveTo + " OnClick='ImgOnclickLeaveDelete(this, " + totalRowCount + " );' src='../Images/Delete.jpg' />";
                                              
                                listleave.push({
                                             StartDate: leavefrom,
                                             EndDate: leaveTo,
                                             Holidays: leaveHoli
                                          
                                         });

                                 combined = {
                                    LeaveInfoList: listleave,
                                    TimeInfoList: listTime
                                }
                                
//                             var arrPin = new Array();
//                           arrPin = result.SCPPinCode.split(',');   
                                
                          
                
                      }
                   }
                   else{
                    // alert('');
                    $("#btnSave").show();
                    $("#btnUpdate").hide();
                     ValidationWindow("No data found.", "Alert");
                  
  
                   }
                        },
                        error: function (err) {
                         alert('err');
                       } 
            });      
        
    } 
    
    
     function onClickUpdate(){
        
        var bearerToken =  "bearer " + accessToken;
        var ResTempID = document.getElementById("<%=hdnRestempID.ClientID%>").value;
                        
         
          
            if (document.getElementById("<%=hdnPincode.ClientID%>").value == '')
               {
                 //alert("Pincode is required");
                  ValidationWindow("Pincode is required.", "Alert");
                 return false;
               }
                if (combined == '')
                {
                // alert("Should be add Working Days Time Slot");
                  ValidationWindow("Select Working Days.", "Alert");
                 return false;
                }
                
                 var rawdata = JSON.stringify(combined);
               
                 var objPinCode = document.getElementById("<%=hdnPincode.ClientID%>").value; 
                 var objUserID = document.getElementById("<%=hdnUserID.ClientID%>").value;  
     
                var vurl = '<%=ConfigurationManager.AppSettings["LIMSAPI_URL"] %>';
                 vurl = vurl + 'HomeCollection/PostUpdateSampleCollectionPerson?pResourceTemplateID=' + ResTempID + '&pPinCode=' + objPinCode + '&pUserID=' + objUserID;
                   // alert(vurl);
                      $.ajax({
                        type: "POST",
                        url: vurl,                        
                        data: combined,
                        headers: {                                    
                                    Authorization: bearerToken
                                 },   
                        dataType: "json",                 
                        success: function(result) {
                        if (result.length > 0) {
                                //alert("Updated Successfully.");
                                 ValidationWindow("Updated Successfully.", "Alert");
                                clearfields();
                            }
                        },
                        error: function (err) {
                         alert('err');
                       }
            });
    
    }
    
    function onClickSave(){
   
   
            //var vurl = "http://localhost/LIMS_API/Api/HomeCollection/PostSampleCollectionPerson?pSCPerson=testAttuneaaru&pPinCode=600001&pUserID=2222";
              var bearerToken =  "bearer " + accessToken;
             // alert($('#txtname').val())
              if ($('#txtname').val() == '')
              {
                // alert("Sample Collection Person is required");
                  ValidationWindow("Sample Collection Person is required.", "Alert");
                 return false;
              }
              
              if (document.getElementById("<%=hdnPincode.ClientID%>").value == '')
              {
                // alert("Pincode is required");
                  ValidationWindow("Pincode is required.", "Alert");
                 return false;
              }
             if (combined == '')
             {
                // alert("Should be add Working Days Time Slot");
                  ValidationWindow("Slot Duration is required.", "Alert");
                 return false;
             }
               var rawdata = JSON.stringify(combined);
     
             //   var raw = JSON.stringify({"LeaveInfoList":[{"StartDate":"2021/04/01","EndDate":"2021/04/05","Holidays":"2021/04/28"},{"StartDate":"2021/05/01","EndDate":"2021/05/18","Holidays":"2021/04/01"}],"TimeInfoList":[{"WorkingDays":"0, 1","StartTime":"11:00","EndTime":"11:30","SlotDuration":"1:00"},{"WorkingDays":"2, 3","StartTime":"14:00","EndTime":"15:30","SlotDuration":"5:00"}]});
             //   var raw = "";
               // alert(JSON.stringify(combined));
                //alert(rawdata);
   
             var objPinCode = document.getElementById("<%=hdnPincode.ClientID%>").value; 
             var objUserID = document.getElementById("<%=hdnUserID.ClientID%>").value;  
             var objOrgID = document.getElementById("<%=hdnOrgID.ClientID%>").value;  
             var objLocName = document.getElementById("<%=hdnLocName.ClientID%>").value;  
               
              
               
              var arrUN = new Array();
               arrUN = $('#txtname').val().split('(');
               
               var objUserLogin =   arrUN[1];             
                   objUserLogin = objUserLogin.split(')');
                   //alert(objUserLogin[0]);
                           
                var LoginName = objUserLogin[0];      
                     
                LoginName  = LoginName +'~' + objOrgID +'~' + objLocName
                
                //console.log(LoginName);
                
                
               //      vurl = vurl + 'HomeCollection/PostSampleCollectionPerson?pSCPerson=testAttuneaaru&pPinCode=600003&pUserID=4444';
                 var vurl = '<%=ConfigurationManager.AppSettings["LIMSAPI_URL"] %>';
                 vurl = vurl + 'HomeCollection/PostSampleCollectionPerson?pSCPerson=' + LoginName + '&pPinCode=' + objPinCode + '&pUserID=' + objUserID;
                   // alert(vurl);
                      $.ajax({
                        type: "POST",
                        url: vurl,                        
                        data: combined,
                        headers: {
                                    orgcode :"LIMSAPI",
                                    Authorization: bearerToken
                                 },   
                        dataType: "json",                 
                        success: function(result) {
                        if (result.length > 0) {
                               
                                if(result == 'Schedule Added Successfully.')
                                {
                                // alert(result);
                                  ValidationWindow(result, "Alert");
                                 clearfields();
                                }
                                else{
                                 ValidationWindow(result, "Alert");
                                }
                            }
                        },
                        error: function (err) {
                         alert('err');
                       }
            });    
           
    }
    
    
      function BindHolidays() {
      
                var vurl = '<%=ConfigurationManager.AppSettings["LIMSAPI_URL"] %>';
                // var vurl = "http://localhost/LIMS_API/api/";
                     vurl = vurl + 'HomeCollection/GetHolidayList';
                     var bearerToken =  "bearer " + accessToken;
                    $.ajax({
                        type: "GET",
                        url: vurl,                        
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',
                        headers:{"Authorization" : bearerToken },
                        success: function(result) {
                        if (result.length > 0) {
                            $.each(result, function(key, value) {
                                    $('#ddlHolidays').append($("<option></option>").val(value.HolidayDate).html(value.Description));
                                });

                             }
                        
                        }
            });    
     }
     
     
     
    function isValidDate(s) {
	  var bits = s.split('/');
	  var d = new Date(bits[2] + '/' + bits[1] + '/' + bits[0]);
	  return !!(d && (d.getMonth() + 1) == bits[1] && d.getDate() == Number(bits[0]));
	} 
    
    function onClickLeave() {
    
    
            
     
                document.getElementById('divleave').style.display = 'block';
                var type;
                var AddStatus = 0;
                var objleaveFrom = document.getElementById('<%=txtleaveFrom.ClientID %>').value ; 
                var objleaveTo = document.getElementById('<%=txtleaveTo.ClientID %>').value ;   
    
        if(gblleaveFrom == objleaveFrom)
        {
          ValidationWindow("Duplicate not allowed.", "Alert");
        return false;
        }
        
        if (objleaveFrom == '') {
            //alert('Leave FromDate should not empty');
             ValidationWindow("Leave FromDate should not empty.", "Alert");
	         document.getElementById('<%=txtleaveFrom.ClientID %>').focus();
	         return false;
        }
        if (objleaveTo =='') {
            //alert('Leave ToDate should not empty');
             ValidationWindow("Leave ToDate should not empty.", "Alert");
	         document.getElementById('<%=txtleaveTo.ClientID %>').focus();
	         return false;
        }
            if (!isValidDate(objleaveFrom))
	        {
	         //alert('Invalid Leave FromDate');
	          ValidationWindow("Invalid Leave FromDate.", "Alert");
	         document.getElementById('<%=txtleaveFrom.ClientID %>').value =  '';
	         return false;
	        }
	        if (!isValidDate(objleaveTo))
	        {
	          // alert('Invalid Leave ToDate');
	            ValidationWindow("Invalid Leave ToDate.", "Alert");
	           document.getElementById('<%=txtleaveTo.ClientID %>').value =  '';
	           return false;
	        }

        if (objleaveFrom != '' && objleaveTo !='') {

           if (Date.parse(objleaveFrom) > Date.parse(objleaveTo)) {
               document.getElementById('<%=txtleaveTo.ClientID %>').value = '';
                ValidationWindow("Start date should not be greater than end date.", "Alert");
             //  alert("Start date should not be greater than end date");
               return false;
           }
       }


                var objHoliday1 = $( "#ddlHolidays option:selected" ).text();
                 var objHoliday = $( "#ddlHolidays option:selected" ).val();
                var arrayF = new Array();
                var arrayT = new Array();
                arrayF = objleaveFrom.split('/');
                arrayT = objleaveTo.split('/');
                arrayH = objHoliday.split('/');
                
                var leavefromDate = (arrayF[2] + "/" + arrayF[1] + "/" + arrayF[0]);
                var leaveToDate = (arrayT[2] + "/" + arrayT[1] + "/" + arrayT[0]);
                 var leaveHoliday = (arrayH[2] + "/" + arrayH[1] + "/" + arrayH[0]);
                 
                var totalRowCount = document.getElementById("<%=tblLeave.ClientID%>").rows.length
                var row = document.getElementById("<%=tblLeave.ClientID%>").insertRow(totalRowCount);
                 row.id = "L" + totalRowCount; 
                
                //row.id = totalRowCount; 
                var cell0 = row.insertCell(0);  
                var cell1 = row.insertCell(1);  
                var cell2 = row.insertCell(2);
                var cell3 = row.insertCell(3);
                var cell4 = row.insertCell(4);
                   
                 cell0.innerHTML = totalRowCount;
                 cell1.innerHTML = objHoliday1;      
                 cell2.innerHTML = objleaveFrom;
                 cell3.innerHTML = objleaveTo;
                
//                cell3.innerHTML = "<img id='imgbtn1' style='cursor:pointer;' LeaveFrom = " + objleaveFrom + " LeaveTo = " + objleaveFrom + " OnClick='ImgOnclickLeaveEdit(this);' src='../Images/edit.png' />&nbsp;&nbsp;<img id='imgbtn' style='cursor:pointer;' LeaveFrom = " + leavefromDate + " LeaveTo = " + leaveToDate + " OnClick='ImgOnclickLeaveDelete(this, " + totalRowCount + " );' src='../Images/Delete.jpg' />";
                 cell4.innerHTML = "&nbsp;&nbsp;<img id='imgbtn' style='cursor:pointer;' LeaveFrom = " + leavefromDate + " LeaveTo = " + leaveToDate + " OnClick='ImgOnclickLeaveDelete(this, " + totalRowCount + " );' src='../Images/Delete.jpg' />";
                              
                listleave.push({
                             StartDate: leavefromDate,
                             EndDate: leaveToDate,
                             Holidays: leaveHoliday
                          
                         });
                         
                         gblleaveFrom = objleaveFrom;

                 combined = {
                    LeaveInfoList: listleave,
                    TimeInfoList: listTime
                }

            document.getElementById('<%=txtleaveFrom.ClientID %>').value = '';
            document.getElementById('<%=txtleaveTo.ClientID %>').value = '';
            console.log(JSON.stringify(combined));            
          // console.log(JSON.stringify({ "Workingslot ":  listleaveobj }));    
     }
     
     
    function ImgOnclickLeaveDelete(Currval, imgid)
        {
             gblleaveFrom="";
                var From = $(Currval).attr('LeaveFrom');
                var To = $(Currval).attr('LeaveTo');
                var rowid = "L" + imgid
                document.getElementById(rowid).style.display = "none";

                var filters = {StartDate: From, EndDate: To};

                listleave= listleave.filter(function(item) {
                for (var key in filters) {
                if ( item[key] == filters[key])
                return false;
                }
                return true;
                });

                combined = {
                        LeaveInfoList: listleave,
                        TimeInfoList: listTime
                    }

         //console.log(JSON.stringify(combined));
           
           }
 
     
     
     function onClickTimeSlot() {
     
               // document.getElementById('divslot').style.display = 'block';
                var objWorkingDays = document.getElementById('<%=hidVal.ClientID %>').value; 
                var objWorkingDaysvalue = document.getElementById('<%=hidchklistvalue.ClientID %>').value; 
                var type;
                var AddStatus = 0;
                var objStarttime = document.getElementById('<%=ddlFrom.ClientID %>').value ; 
                var objEndtime = document.getElementById('<%=ddlTo.ClientID %>').value ; 
                var objHours = document.getElementById('<%=txthours.ClientID %>').value ; 
                var objMints = document.getElementById('<%=ddlmints.ClientID %>').value ; 
                
                if(gblTimeslot== objWorkingDays){
                  ValidationWindow("Duplicate not allowed.", "Alert");
                     return false;
                }
                
                if (objWorkingDays == ""){
                   // alert("WorkingDays is required");
                      ValidationWindow("WorkingDays is required.", "Alert");
                    return false;
                }
                else if (objHours == ""){
                    //alert("Time Slot is required");
                      ValidationWindow("Slot Duration is required.", "Alert");
                    return false;
                }

                // alert(objStarttime);   
                
                // var row = document.getElementById('tblPinCode').iinsertRow(1);
                var totalRowCount = document.getElementById("<%=tblSlot.ClientID%>").rows.length
                if(totalRowCount == 0)
                totalRowCount = 1 ;                
              //  alert(totalRowCount);   
                var row = document.getElementById("<%=tblSlot.ClientID%>").insertRow(totalRowCount);
                row.id = totalRowCount;
               
                var cell0 = row.insertCell(0);
                var cell1 = row.insertCell(1);
                var cell2 = row.insertCell(2);
                var cell3 = row.insertCell(3);
                var cell4 = row.insertCell(4);
                var cell5 = row.insertCell(5);
                
                
                cell0.innerHTML = totalRowCount;
                cell1.innerHTML = objWorkingDays;
                cell2.innerHTML = objStarttime;
                cell3.innerHTML = objEndtime;
                cell4.innerHTML = objHours + ":" + objMints;
                cell5.innerHTML = " &nbsp;&nbsp;<img id='imgbtn' style='cursor:pointer;' WorkingDay = '" + objWorkingDaysvalue + "' StartTime = " + objStarttime + " EndTime = " + objEndtime + " OnClick='ImgOnclickTimeDelete( this, " + totalRowCount + ");' src='../Images/Delete.jpg' />";

                gblTimeslot= objWorkingDays;
                
                 listTime.push({
                             WorkingDays: objWorkingDaysvalue,
                             StartTime: objStarttime,
                             EndTime    : objEndtime,
                             SlotDuration   : objHours + ":" + objMints
                    });

                 combined = {
                    LeaveInfoList: listleave,
                    TimeInfoList: listTime
                }
                    //console.log(JSON.stringify({ "Workingslot ":  listTime }));
                  console.log(JSON.stringify(combined));
     }
     
     
     function ImgOnclickTimeDelete(Currval, imgid){        
     
     gblTimeslot="";
                var WDay = $(Currval).attr('WorkingDay');
                var STime = $(Currval).attr('StartTime');
                var ETime = $(Currval).attr('EndTime');
               
                document.getElementById(imgid).style.display = "none";
        
       
                var filters = {WorkingDays: WDay, Starttime: STime , Endtime: ETime};


                listTime= listTime.filter(function(item) {
                for (var key in filters) {
                    if ( item[key] == filters[key])
                    return false;
                    }
                    return true;
                 });

                combined = {
                        LeaveInfoList: listleave,
                        TimeInfoList: listTime
                }

            console.log(JSON.stringify(combined));
   
   }
 
         
    function onClickPinCode() {
        var type;
        var AddStatus = 0;
        var obj = $('#txtPincode').val();
        var HidValue = document.getElementById("<%=hdnPincode.ClientID%>").value; 
           
           if(obj == "")
           {
           // alert("PinCode is required");
             ValidationWindow("PinCode is required.", "Alert");
            return false;
           
           }            
        var list = HidValue.split('^');
//            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
//            var UsrAlrtMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_02") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_02") : "Speciality already added";
        if (HidValue != "") {
       
            for (var count = 0; count < list.length; count++) {
                var SpecialList = list[count];
                if (SpecialList != '') {
                        if (SpecialList == obj) {
                            AddStatus = 1;
                        }
                }
            }
        }
        else {
               
                document.getElementById("<%=tblPinCode.ClientID%>").style.display = 'table';                 
                var row = document.getElementById("<%=tblPinCode.ClientID%>").insertRow(1);             
                row.id = obj;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickSpecial(" + obj + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj;
                document.getElementById("<%=hdnPincode.ClientID%>").value += obj + "^";
                AddStatus = 2;
            }
            
        if (AddStatus == 0) {
        //alert(AddStatus);
                document.getElementById("<%=tblPinCode.ClientID%>").style.display = 'table'; 
                 var row = document.getElementById("<%=tblPinCode.ClientID%>").insertRow(1);
                row.id = obj;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickSpecial(" + obj + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                document.getElementById("<%=hdnPincode.ClientID%>").value += obj + "^";
                cell2.innerHTML = obj;
            }
            else if (AddStatus == 1) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_2");
               // alert("Duplicate PinCode not allowed");
                
                if (UsrAlrtMsg != null) {
                    //alert("1");
                    //ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
                else {
                // alert("0");
                   // alert('PinCode already added');
                      ValidationWindow("PinCode already added.", "Alert");
                  //  ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
            }
        }
        
        
   
    function ImgOnclickSpecial(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById("<%=hdnPincode.ClientID%>").value
        var list = HidValue.split('^');
        var NewSpecialList = '';
        if (document.getElementById("<%=hdnPincode.ClientID%>").value != "") {
            for (var count = 0; count < list.length; count++) {
                var SpecialList = list[count];
                if (SpecialList != '') {
                    if (SpecialList != ImgID) {

                        NewSpecialList += list[count] + '^';
                    }
                }
            }
           // document.getElementById('hdnPincode').value = NewSpecialList;
            document.getElementById("<%=hdnPincode.ClientID%>").value= NewSpecialList;
        }
    }
       
function CheckItem(checkBoxList)
{
            var options = checkBoxList.getElementsByTagName('input');
            var arrayOfCheckBoxLabels= checkBoxList.getElementsByTagName("label");

            var s = "";
            var val = "";

            for(i=0;i<options.length;i++)
            {
            var opt = options[i];

            if(opt.checked)
            {

            s = s + ", "+ arrayOfCheckBoxLabels[i].innerText; 

            if(arrayOfCheckBoxLabels[i].innerText == 'Sunday')
                val = val + ", "+ 7; 
            else if (arrayOfCheckBoxLabels[i].innerText == 'Monday')
                val = val + ", "+ 1; 
            else if (arrayOfCheckBoxLabels[i].innerText == 'Tuesday')
                val = val + ", "+ 2; 
            else if (arrayOfCheckBoxLabels[i].innerText == 'Wednesday')
                val = val + ", "+ 3; 
            else if (arrayOfCheckBoxLabels[i].innerText == 'Thursday')
                val = val + ", "+ 4; 
            else if (arrayOfCheckBoxLabels[i].innerText == 'Friday')
                val = val + ", "+ 5; 
            else if (arrayOfCheckBoxLabels[i].innerText == 'Saturday')
                val = val + ", "+ 6; 

            } 
            }
            if(s.length > 0) 
            {       
            s = s.substring(2, s.length); //sacar la primer 'coma'
            }
            if(val.length > 0) 
            {  
           // alert( val.substring(2, val.length));
            }
            var TxtBox = document.getElementById("<%=txtCombo.ClientID%>");       
            TxtBox.value = s;
            document.getElementById('<%=hidVal.ClientID %>').value = s;
            document.getElementById('<%=hidchklistvalue.ClientID %>').value = val;
}



function BindAutoComplete() {

        var objOrgID = document.getElementById("<%=hdnOrgID.ClientID%>").value;  
        var objPinCode = 0;
        $("#txtname").autocomplete({  
     
            source: function (request, response) {
               var val = request.term;
               var vurl = '<%=ConfigurationManager.AppSettings["LIMSAPI_URL"] %>';
                var bearerToken =  "bearer " + accessToken;
          //    var vurl = "http://localhost/LIMS_API/api/";
                vurl = vurl + 'HomeCollection/GetSampleCollectionPersonList?PrefixText=' + $('#txtname').val()+ '&OrgID=' + objOrgID + '&pPinCode=' + objPinCode  ; 

                $.ajax({
                    url: vurl,                   
                    type: "GET",
                    contentType: "application/json",
                    dataType: 'json',
//                    headers:{"Authorization" :"bearer cn3Q_TKjS-QOM4vxoQHdldbkXgnBIdPZhBfvwJcFESLAarH--9jAQNlczob3XA_Al1qh8ml_1rfcTy9rXW4rBZRMilsK5_bXafSuc6CLPfsyszAO4N5Ezhx1MCxiidSFW08ZBSJTpHoTgdnrQthcxtZcJA58vCaYUUUkdZcmTg9v8csDTw6_XiCFY0cSO9iDxqGSXnU7hc4zuUpL3AVrfO7ZxDopUg5A7QBozKeYzvbyprxaygTl7Jje9h_9zlTttO52a6M7R1rqo4mjKlvHpQOOcfezol7II5UJMcqk0exNmMmTd2lZN4iqgiv-GVqJjm-pfINb8WfOaSyPgvd_DQRftXR6WiAsP7lVDeW0tiPdE5xyd_O3uRSUGhwgf391mGOsohxoURUO2sXBjFqdMW-bDg72G8fjetjXqsv4xzX-gooMaDPdNc-qgZCPBG0d"},
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
    
    function BindAutoCompPinCode() {    
    
    var objmode = "GET";
    
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
                     return false;
                }
        });
    
//     $("#txtPincode").autocomplete({
//          
//                source: function(request, response) {
//                    var val = request.term;
//                    var vurl = '<%=ConfigurationManager.AppSettings["LIMSAPI_URL"] %>';                
//                    vurl = vurl + 'HomeCollection/GetPinCode?PrefixText=' + val ;
//                    var bearerToken =  "bearer " + accessToken;
//                    $.ajax({
//                        type: "GET",
//                        url: vurl,
//                        contentType: 'application/json; charset=utf-8',
//                        dataType: 'json',
//                        headers:{"Authorization" : bearerToken },
//                        success: function(data) {                      
//                            index = 0;
//                            var autoCompleteArray = new Array();
//                         
//                            autoCompleteArray = $.map(data, function(item) {                            
//                                return {label: item.Pincode
//                                    
//                                };
//                            });
//                            
//                            response(autoCompleteArray);
//                        }
//                    });
//                                   
//                },
//                error: function (err) {
//                        alert(err.status);
//                        },
//                minlength: 1,
//                select: function(event, ui) {
//                    $('#txtPincode').val(ui.item.label);
//                     return false;
//                }
//            });
    }
    
       function blockNonNumbers(obj, e, allowDecimal, allowNegative) {
                            var key;
                            var isCtrl = false;
                            var keychar;
                            var reg;

                            if (window.event) {
                                key = e.keyCode;
                                isCtrl = window.event.ctrlKey
                            }
                            else if (e.which) {
                                key = e.which;
                                isCtrl = e.ctrlKey;
                           }

                            if (isNaN(key)) return true;

                            keychar = String.fromCharCode(key);

                            // check for backspace or delete, or if Ctrl was pressed
                           if (key == 8 || isCtrl) {
                                return true;
                           }

                            reg = /\d/;
                            var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
                            var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;

                            return isFirstN || isFirstD || reg.test(keychar);
                       }  
                       
 
 
</script>

