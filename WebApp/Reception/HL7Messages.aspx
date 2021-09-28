<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="HL7Messages.aspx.cs"
    Inherits="Reception_HL7Messages" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/HL7MessageFileUploader.ascx" TagName="HL7MessageFileUploader"
    TagPrefix="HL7MFU" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="AttuneH" %>
<%@ Register Src="~/CommonControls/Attune_Footer.ascx" TagName="AttuneFooter" TagPrefix="AttuneF" %>
<%@ Register Src="../CommonControls/NewDateTimePicker.ascx" TagName="DateTimePicker"
    TagPrefix="DateTimePicker" %>
    

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>HL7 Messages</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    
    <script src="../Scripts/jquery-1.7.2.min.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/animatedcollapse.js"></script>

    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker_css.js" type="text/javascript"></script>
    
    <script type="text/javascript">


    
        function ResetValues() {           
            $('#txtMessageId').val("");
            $('#txtPatientExternalVisitId').val("");
            $('#divLabData').hide();
            $('#divPatientandorder').hide();
            //            $('#divLabData').load(self);
            //            $('#divPatientandorder').load(self);
            return true;
        }
        function Validate() {
            var istrue = true;
            if ($('#txtFromPeriod').val() == "") {
                istrue = false;
                alert('Please select From date.');
            } else if ($('#txtToPeriod').val() == "") {
                istrue = false;
                alert('Please select To date.');
            }
            // $('#divUploadUC').hide();
            closewin("txtToPeriod");
            closewin("txtFromPeriod");

            return istrue;
        }
        //        function DisplayTab() {
        //            var selected_tab = $("#Grouptab").tabs();
        //            if ($(".ajax__tab_active").first().attr('id') == "Grouptab_HealthLabDatatab_tab") {
        //                $('#divPatientandorder').show();
        //            } else {
        //                $('#divPatientandorder').hide();
        //            }
        //            //console.log($(".ajax__tab_active").first().attr('id'));
        //            //alert(selected_tab.index());
        //        }

        //Disable PatientOrder details tab -- click on UploadHL7Message tab
        function DisplayTab() {

            var a = $(".ajax__tab_active").first().attr('id');
            if (a == "Grouptab_HealthLabDatatab_tab") {
                $('#divPatientandorder').show();
		$('#divErrorDetails').show();
                //$('#divUploadUC').hide();
            }
//            if (a == "Grouptab_Grouptab_tabUpload_tab_tab") {
//                $('#divPatientandorder').hide();
//                //$('#divUploadUC').show();
//            }
            if (a == "Grouptab_Grouptab_HealthLabDatatab_tab_tab") {
                $('#divPatientandorder').hide();
		$('#divErrorDetails').hide();
                //$('#divUploadUC').hide();
            }
        }
        $(document).on("click", ".btnsel", function() {

            var $row = $(this).closest("tr");    // Find the row
            var $test = $row.find(".hid").val(); //"input:hidden").val(); // Find the text
            var modal = document.getElementById('myModal');

            // Get the button that opens the modal
            var btn = document.getElementById("myBtn");

            // Get the <span> element that closes the modal
            var span = document.getElementsByClassName("close")[0];
            span.onclick = function() {
                modal.style.display = "none";
            }

            // When the user clicks anywhere outside of the modal, close it
            window.onclick = function(event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
            modal.style.display = "block";
            document.getElementById('pdp').innerHTML = $test.replace(/\n/g, "<br />");
        });
        //  });

        $(document).on("change", "#txtFromPeriod", function(event) {
            var re = /^(\d{1,2})\/(\d{1,2})\/(\d{4})$/;
            var regs = [];
            var td = [];
            td = $('#txtToPeriod').val().split('/');
            regs = $('#txtFromPeriod').val().split('/');
            var fromdate = new Date($('#txtFromPeriod').val());
            var todate = new Date(td[2], td[1] - 1, td[0]);
            if (fromdate.getDate.length == 0) {
                var d = event.target.value.split("/");
                fromdate = new Date(d[2], d[1] - 1, d[0]);
            } //event.target.value);
            var today = new Date();
            debugger;
            if ($('#txtFromPeriod').val() != '') {
                if (regs = $('#txtFromPeriod').val().match(re)) {
                    // day value between 1 and 31
                    if (regs[1] < 1 || regs[1] > 31) {
                        alert("Invalid value for day: " + regs[1]);
                        $('#txtFromPeriod').val('');
                        $('#txtFromPeriod').focus();
                        return false;
                    }
                    // month value between 1 and 12
                    else if (regs[2] < 1 || regs[2] > 12) {
                        alert("Invalid value for month: " + regs[2]);
                        $('#txtFromPeriod').val('');
                        $('#txtFromPeriod').focus();
                        return false;
                    }
                    // year value between 1902 and 2017
                    else if (regs[3] < 1902 || regs[3] > (new Date()).getFullYear()) {
                        alert("Invalid value for year: " + regs[3] + " - must be between 1902 and " + (new Date()).getFullYear());
                        $('#txtFromPeriod').val('');
                        $('#txtFromPeriod').focus();
                        return false;
                    }
                    else if (fromdate > todate) {
                        alert('From date is greater than the To date.');
                        $('#txtToPeriod').val('');
                        return false;
                    }
                    else if (fromdate > today) {
                        alert('From date can not be future date.');
                        $('#txtFromPeriod').val('');
                        $('#txtFromPeriod').focus();
                        return false;
                    }
                } else {
                    alert("Invalid date format: " + $('#txtFromPeriod').val());
                    $('#txtFromPeriod').val('');
                    $('#txtFromPeriod').focus();
                    return false;
                }
            }
        });

        $(document).on("change", "#txtToPeriod", function(event) {
            debugger;
            var re = /^(\d{1,2})\/(\d{1,2})\/(\d{4})$/;
            var regs = [];
            var fd = [];
            fd = $('#txtFromPeriod').val().split('/');
            regs = $('#txtToPeriod').val().split('/');
            var fromdate = new Date(new Date(fd[2], fd[1] - 1, fd[0]));
            var todate = new Date($('#txtToPeriod').val());
            if (todate.getDate.length == 0) {
                var d = event.target.value.split("/");
                todate = new Date(d[2], d[1] - 1, d[0]);
            }
            var today = new Date();
            debugger;
            if ($('#txtToPeriod').val() != '') {
                if (regs = $('#txtToPeriod').val().match(re)) {
                    // day value between 1 and 31
                    if (regs[1] < 1 || regs[1] > 31) {
                        alert("Invalid value for day: " + regs[1]);
                        $('#txtToPeriod').val('');
                        $('#txtToPeriod').focus();
                        return false;
                    }
                    // month value between 1 and 12
                    else if (regs[2] < 1 || regs[2] > 12) {
                        alert("Invalid value for month: " + regs[2]);
                        $('#txtToPeriod').val('');
                        $('#txtToPeriod').focus();
                        return false;
                    }
                    // year value between 1902 and 2017
                    else if (regs[3] < 1902 || regs[3] > (new Date()).getFullYear()) {
                        alert("Invalid value for year: " + regs[3] + " - must be between 1902 and " + (new Date()).getFullYear());
                        $('#txtToPeriod').val('');
                        $('#txtToPeriod').focus();
                        return false;
                    }
                    else if (fromdate > todate) {
                        alert('To date can not be less than the From date.');
                        $('#txtToPeriod').val('');
                        return false;
                    }
                    else if (todate > today) {
                        alert('To date can not be future date.');
                        $('#txtToPeriod').val('');
                        $('#txtToPeriod').focus();
                        return false;
                    }
                } else {
                    alert("Invalid date format: " + $('#txtToPeriod').val());
                    $('#txtToPeriod').focus();
                    $('#txtToPeriod').val('');
                    return false;
                }
            }
        }); 
 function   itempopupapproved() {
           document.getElementById('divapprovedus').style.display = 'block';
         
           document.getElementById('fade').style.display = 'block';
      
            $("#HL7MessageFileUploader_pnlListBox").empty();
           //document.getElementById('footerid').style.display = 'none';
           return false;
       }

    </script>

    <style type="text/css">
        .ScrollStyle
{
    max-height: 150px;
    overflow-y: scroll;
   
}
 #divErrorDetails
{
    margin: 20px 0;
}

         .black_overlay {
           display: none;
           position: fixed;
           top: 0%;
           left: 0%;
           width: 100%;
           height: 100%;
           background-color: black;
           z-index: 1001;
           -moz-opacity: 0.8;
           opacity: .80;
           filter: alpha(opacity=80);
       }
        .white_content1 {
           display: none;
           position: fixed;
           top: 22%;
           height: 50% !important ;
           padding: 16px;
           border: none !important ;
           background-color: white;
           z-index: 1002;
           width: 77%  !important ;
           left: 12%  !important ;
          border-radius: 10px;
          

       }
        #LnkHl7upload
        {
            padding-left:15px;    
        }
        /* The Modal (background) */.modal
        {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 100px; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
        /* Modal Content */.modal-content
        {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }
        /* The Close Button */.close
        {
            color: red;
            text-align: center;
            font-size: 15px;
            font-weight: bold;
        }
        .close:hover, .close:focus
        {
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }
        .btnsel
        {
            background-color: Transparent !important;
            color: Blue !important;
            border: none !important;
        }
        .header
        {
            background-color: green;
            text-decoration: dotted;
            font-weight: bolder;
            color: white;
            height: 30px;
            text-align: -webkit-center;
            padding-top: 10px;
        }
        .modal-content
        {
            text-align: center;
            padding: 20px 0px;
            margin: auto;
            overflow: auto;
            word-break: break-all;
            max-height: 370px;
        }
        .lh60
        {
            line-height: 60px;
        }
        .marginT15
        {
            margin-top: 15px;
        }
        .marginB15
        {
            margin-bottom: 15px;
        }
    </style>
    <style type="text/css">
        .Hide
        {
            display: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" EnablePartialRendering="true">
    </asp:ScriptManager>
    <AttuneH:Attuneheader ID="Attuneheader" runat="server" />
    <asp:Panel runat="server" DefaultButton="btnSearch">
    <div class="contentdata">
    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
        <ContentTemplate>
            <div class="w-100p marginT15 marginB15">
                <fieldset>
                    <div class="w-100p">
                        <asp:Label ID="FromDate2" runat="server" Text="From Date"></asp:Label><span style="color: Red">*</span>
                        
                        <asp:TextBox ID="txtFromPeriod"  runat="server"   
                            CssClass="small"  ></asp:TextBox>
                     <a href="javascript:NewCssCall('<%=txtFromPeriod.ClientID %>','ddMMyyyy','arrow',true,12,'Y','N','Y')">
                                        <img src="../Images/Calendar_scheduleHS.png" alt="Pick a date"></a>
       
                                        
                                        
                       
                        <asp:Label ID="ToDate2" runat="server" Text="To Date"></asp:Label><span style="color: Red">*</span>
                        <asp:TextBox runat="server" ID="txtToPeriod"   ></asp:TextBox>
                              
                      <a href="javascript:NewCssCall('<%=txtToPeriod.ClientID %>','ddMMyyyy','arrow',true,12,'Y','N','Y')">
                                        <img src="../Images/Calendar_scheduleHS.png" alt="Pick a date"></a>    
                    
                      
                            <asp:Label ID="lblMessageId" runat="server" Text="Message Control Id"></asp:Label>
                            <asp:TextBox CssClass="small" ID="txtMessageId" runat="server"></asp:TextBox>
                            <asp:Label ID="lbltxtPatientExternalVisitId" runat="server" Text="Lab Number  "></asp:Label>
                            <asp:TextBox CssClass="small" ID="txtPatientExternalVisitId" runat="server"></asp:TextBox>
                            <asp:Button ID="btnSearch" Text="Search" OnClientClick="return Validate();" CssClass="btn1"
                                runat="server" OnClick="btnSearch_Click"></asp:Button>
                            <asp:Button ID="btnReset" Text="Reset" OnClientClick="return ResetValues();" 
                                CssClass="btn1" runat="server" OnClick="btnReset_Click"></asp:Button>
                            <asp:LinkButton ID="LnkHl7upload" runat="server" Text="Upload HL7 Messages" 
                            OnClientClick="itempopupapproved();return ResetValues();" OnClick="LnkHl7upload_Click"></asp:LinkButton>
                        </div>
                    </fieldset>
                </div>

                                        <div id="divHealthLabData" runat="server">
                                            <asp:GridView ID="gvHealthLabData" CssClass="mytable1" PagerStyle-Font-Bold="true"
                                                Font-Size="12px" Width="100%" AllowPaging="True" PageSize="10" runat="server"
                                                AutoGenerateColumns="False" OnPageIndexChanging="gvHealthLabData_PageIndexChanging"
                                                ForeColor="#333333" OnRowDataBound="gvHealthLabData_OnRowDataBound" SelectedRowStyle-BackColor="YellowGreen"
                                                OnSelectedIndexChanged="gvHealthLabData_SelectedIndexChanged">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="SNo">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField ShowHeader="false" HeaderText="Message Control Id">
                                                        <ItemTemplate>
                                                            <asp:HiddenField ID="HFMessageId" Value='<%# Eval("HLMessagesID") %>' runat="server" />
                                                            <asp:Label ID="Label1" Text='<%# Eval("MsgControlId") %>' HeaderText="Msg Control Id"
                                                                runat="server" HeaderStyle-Wrap="false"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="HLMessagesID" HeaderText="HLMessagesID" HeaderStyle-Wrap="false"
                                                        Visible="false"></asp:BoundField>
                            <asp:BoundField DataField="MsgType" HeaderText="Lab Number" HeaderStyle-Wrap="false">
                                                        <HeaderStyle Wrap="False" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Sending_App" HeaderText="Sending App" HeaderStyle-Wrap="false">
                                                        <HeaderStyle Wrap="False" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Rec_App" HeaderText="Receiving App" HeaderStyle-Wrap="false">
                                                        <HeaderStyle Wrap="False" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="TransferDatetime" HeaderText="Transfer date time" HeaderStyle-Wrap="false">
                                                        <HeaderStyle Wrap="False" />
                                                    </asp:BoundField>
                            <asp:BoundField DataField="Status" HeaderText="Status" HeaderStyle-Wrap="false" HeaderStyle-CssClass="Hide"
                                ItemStyle-CssClass="Hide">
                                                        <HeaderStyle Wrap="False" />
                                                    </asp:BoundField>
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <asp:Label ID="lblStatus" Text='<%#Eval("Status") %>' runat="server" HeaderStyle-Wrap="false"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="FileNames" HeaderText="File Name" HeaderStyle-Wrap="false" />

                                                    <asp:TemplateField HeaderText="HL7 Message">
                                                        <ItemTemplate>
                                                            <input type="button" class="btnsel" value="View HL7 Message..." id="df" />
                                                            <input type="hidden" id="hfHL7Message" class="hid" value='<%# Eval("HL7Message") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerStyle Font-Bold="True" />
                                            </asp:GridView>
                                        </div>
                           
                <div class="divgvOtherLabData o-auto-x" id="divOtheLabData" runat="server" style="display:none">
                 <ajc:TabContainer ID="tabOtherData" runat="server" ActiveTabIndex="0">
                        <ajc:TabPanel ID="tabOtherPanel" runat="server" HeaderText="Other Lab Data">
                            <HeaderTemplate>
                                Other Lab Data
                            </HeaderTemplate>
                            <ContentTemplate>
                                <asp:UpdatePanel ID="UpdatePanelOtherData" runat="server">
                                    <ContentTemplate>
                                        <div class="ScrollStyle">

                    <asp:GridView ID="gvOtherLabData" CssClass="mytable1" PagerSettings-Mode="NumericFirstLast"
                        Font-Size="12px" Width="100%" PagerSettings-FirstPageText="First" PagerSettings-LastPageText="Last"
                        PagerStyle-Font-Bold="true" PagerSettings-PageButtonCount="1" AllowPaging="True"
                        PageSize="13" runat="server" AutoGenerateColumns="False" OnPageIndexChanging="gvOtherLabData_PageIndexChanging"
                        ForeColor="#333333" OnRowDataBound="gvOtherLabData_OnRowDataBound" SelectedRowStyle-BackColor="YellowGreen"
                        OnSelectedIndexChanged="gvOtherLabData_SelectedIndexChanged">
                        <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NumericFirstLast"
                            PageButtonCount="5" />
                        <Columns>
                        <asp:TemplateField HeaderText="SNo">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                            <asp:TemplateField ShowHeader="false" HeaderText="Message Control Id">
                                <ItemTemplate>
                                    <asp:HiddenField ID="HFMessageId" Value='<%# Eval("HLMessagesID") %>' runat="server" />
                                    <asp:HiddenField ID="hdnOtherLocation" Value='<%# Eval("Location") %>' runat="server" />
                                    <asp:Label ID="Label1" Text='<%# Eval("MsgControlId") %>' HeaderText="Msg Control Id"
                                        runat="server" HeaderStyle-Wrap="false"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="HLMessagesID" HeaderText="HLMessagesID" HeaderStyle-Wrap="false">
                                <HeaderStyle Wrap="False" />
                            </asp:BoundField>--%>
                            <asp:BoundField DataField="MsgType" HeaderText="Lab Number" HeaderStyle-Wrap="false">
                                <HeaderStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Sending_App" HeaderText="Sending App" HeaderStyle-Wrap="false">
                                <HeaderStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Rec_App" HeaderText="Receiving App" HeaderStyle-Wrap="false">
                                <HeaderStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TransferDatetime" HeaderText="Transfer date time" HeaderStyle-Wrap="false">
                                <HeaderStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Status" HeaderText="Status" HeaderStyle-Wrap="false" Visible="false">
                                <HeaderStyle Wrap="False" />
                            </asp:BoundField>
                                                    <asp:BoundField DataField="OrderStatus" HeaderText="Status" HeaderStyle-Wrap="false"
                                                        HeaderStyle-CssClass="Hide" ItemStyle-CssClass="Hide">
                                <HeaderStyle Wrap="False" />
                            </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Status">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblOrderStatus" runat="server" Text='<%#Eval("OrderStatus")%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                            <asp:BoundField DataField="Location" HeaderText="Location" HeaderStyle-Wrap="false">
                                <HeaderStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="FileNames" HeaderText="File Name" HeaderStyle-Wrap="false">
                                <HeaderStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="HL7 Message">
                                <ItemTemplate>
                                    <input type="button" class="btnsel" value="View HL7 Message..." id="df" />
                                    <input type="hidden" id="hfHL7Message" class="hid" value='<%# Eval("HL7Message") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle Font-Bold="True" />
                    </asp:GridView>
 </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </ContentTemplate>
                    </ajc:TabPanel>
                    </ajc:TabContainer>
                </div>
                <br />
                <div runat="server" id="divPatientandorder">
                    <ajc:TabContainer ID="tabPattientandOrder" runat="server" ActiveTabIndex="0" OnClientActiveTabChanged="ChangeDisplay">
                        <ajc:TabPanel ID="TabPanel2" runat="server" HeaderText="Patient Details">
                            <HeaderTemplate>
                                Patient Details
                            </HeaderTemplate>
                            <ContentTemplate>
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                                        <div class="ScrollStyle">
                                            <asp:GridView ID="gvPatientDetails" CssClass="mytable1" RowStyle-Height="20px" PagerStyle-Font-Bold="true"
                                                OnRowDataBound="gvPatientDetails_OnRowDataBound" OnPageIndexChanging="gvPatientDetails_PageIndexChanging"
                                                AllowPaging="True" PageSize="4" runat="server" AutoGenerateColumns="False" ForeColor="#333333"
                                                Width="50%">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="SNo">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField ShowHeader="false" HeaderText="Patient_Id">
                                                        <ItemTemplate>
                                                            <asp:HiddenField ID="HLMessageID" Value='<%# Eval("HLMessageID") %>' runat="server" />
                                                            <asp:Label ID="Label1" Text='<%# Eval("Patient_ID") %>' HeaderText="Patient_Id" runat="server"
                                                                HeaderStyle-Wrap="false"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="MsgControlId" HeaderText="MsgControl Id" HeaderStyle-Wrap="false">
                                                        <HeaderStyle Wrap="False" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="HLMessagePatientIDDetailsID" HeaderText="HLMessagePatientIDDetailsID"
                                                        HeaderStyle-Wrap="false" ItemStyle-CssClass="Hide" HeaderStyle-CssClass="Hide">
                                                        <HeaderStyle Wrap="False" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PIDEvent_Type" HeaderText="PIDEvent_Type" HeaderStyle-Wrap="false"
                                                     ItemStyle-CssClass="Hide" HeaderStyle-CssClass="Hide">
                                                        <HeaderStyle Wrap="False" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Set_ID_PID" HeaderText="Set_ID_PID" HeaderStyle-Wrap="false">
                                                        <HeaderStyle Wrap="False" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PIDIdentifier" HeaderText="PID Identifier" HeaderStyle-Wrap="false">
                                                        <HeaderStyle Wrap="False" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Pidprefix" HeaderText="Pid Prefix" HeaderStyle-Wrap="false">
                                                        <HeaderStyle Wrap="False" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PIDSuffix" HeaderText="PIDSuffix">
                                                        <HeaderStyle Wrap="False" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Patient_Name" HeaderText="Patient Name" HeaderStyle-Wrap="false">
                                                        <HeaderStyle Wrap="False" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Second_and_further_given_Names_or_Initials_Thereof" HeaderText="Second_and_further_given_Names_or_Initials_Thereof"
                                                        HeaderStyle-Wrap="false">
                                                        <HeaderStyle Wrap="False" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PIDFamily_Name" HeaderText="PID Family Name">
                                                        <HeaderStyle Wrap="False" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Patient_Identifier_List" HeaderText="Patient Identifier List">
                                                        <HeaderStyle Wrap="False" />
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Date_time_Of_Birth">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblDob" Text='<%# Eval("Date_time_Of_Birth") %>' runat="server" HeaderStyle-Wrap="false"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Phone_Number_home" HeaderText="Phone Number home" ItemStyle-CssClass="Hide"
                                                        HeaderStyle-CssClass="Hide"></asp:BoundField>
                                                
                                                <asp:BoundField DataField="HTelephone_Number" HeaderText="Telephone_Number">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="HTelecommunication_Equipment_Type" HeaderText="HTelecommunication_Equipment_Type">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="HTelecommunication_use_code" HeaderText="HTelecommunication_use_code">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Telecommunication_use_code" HeaderText="Telecommunication_use_code">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="HCommunication_Address" HeaderText="HCommunication_Address">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Patient_Address" HeaderText="Patient Address">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="City" HeaderText="City">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Zip_Or_Postal_Code" HeaderText="Postal Code">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Country" HeaderText="Country">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Birth_Order" HeaderText="Birth Order">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Multiple_Birth_Indicator" HeaderText="Multiple_Birth_Indicator">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Date_Administrative_Sex" HeaderText="Date_Administrative_Sex">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Species_Code" HeaderText="Species_Code">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="PIDEvent_Type" HeaderText="PIDEvent_Type"  ItemStyle-CssClass="Hide" HeaderStyle-CssClass="Hide">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ID_Number" HeaderText="ID_Number">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Given_Name" HeaderText="Given_Name">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Birth_Place" HeaderText="Birth_Place">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Identifier_Check_Digit" HeaderText="Identifier_Check_Digit">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Check_Digit_Scheme" HeaderText="Check_Digit_Scheme">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Alteration_Patient_ID_PID" HeaderText="Alteration_Patient_ID_PID">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="PIDDegree" HeaderText="PIDDegree">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Mother_Maiden_Name" HeaderText="Mother_Maiden_Name">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Patient_Alies" HeaderText="Patient_Alies">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Race" HeaderText="Race">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Street_Mailing_Address" HeaderText="Street_Mailing_Address">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Other_Designation" HeaderText="Other_Designation">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="State_Of_Province" HeaderText="State_Of_Province">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="PIDCountry_Code" HeaderText="PIDCountry_Code">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="HPhone_Number_Business" HeaderText="HPhone_Number_Business">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="HBTelephone_Number" HeaderText="HBTelephone_Number">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Communication_Address" HeaderText="Communication_Address">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Phone_Number_Business" HeaderText="Phone_Number_Business">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="PIDTelephone_Number" HeaderText="PIDTelephone_Number">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Primary_Language" HeaderText="Primary_Language">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Marital_Status" HeaderText="Marital_Status">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Religion" HeaderText="Religion">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Patient_Account_Number" HeaderText="Patient_Account_Number">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ACID_Number" HeaderText="ACID_Number">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="SSN_Number_Patient" HeaderText="SSN_Number_Patient">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Driver_License_Number_Patient" HeaderText="Driver_License_Number_Patient">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Mother_Identifier" HeaderText="Mother_Identifier">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="MID_Number" HeaderText="MID_Number">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Ethnic_Group" HeaderText="Ethnic_Group">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="EGIdentifier" HeaderText="EGIdentifier">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Citizenship" HeaderText="Citizenship">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Ethnic_Group" HeaderText="Ethnic_Group">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Veterans_Military_Status" HeaderText="Veterans_Military_Status">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Nationality" HeaderText="Nationality">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                               
                                                <asp:TemplateField HeaderText="Patient_Death_Date_and_Time">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDeathDate" Text='<%# Eval("Patient_Death_Date_and_Time") %>' runat="server"
                                                            HeaderStyle-Wrap="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Patient_Death_Indicator" HeaderText="Patient_Death_Indicator">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Identity_Unknown_Indicator" HeaderText="Identity_Unknown_Indicator">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Identity_reliability_Code" HeaderText="Identity_reliability_Code">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                            
                                                <asp:TemplateField HeaderText="Last_Updated_DateTime">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblLastUpdatedDate" Text='<%# Eval("Last_Updated_DateTime") %>' runat="server"
                                                            HeaderStyle-Wrap="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Last_Update_Facility" HeaderText="Last_Update_Facility">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="NamespaceID" HeaderText="NamespaceID">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Breed_Code" HeaderText="Breed_Code">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Strain" HeaderText="Strain">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Production_Class_Code" HeaderText="Production_Class_Code">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Tribal_Citizenship" HeaderText="Tribal_Citizenship">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Ward_Code" HeaderText="Ward_Code">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="HLMessagePatientIDContent" HeaderText="HLMessagePatientIDContent">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="PIDAssigning_Authority" HeaderText="PIDAssigning_Authority">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                            </Columns>
                                            <PagerStyle Font-Bold="True" />
                                        </asp:GridView>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </ContentTemplate>
                    </ajc:TabPanel>
                     <ajc:TabPanel ID="tabPanelVisitDetails" runat="server" HeaderText="Visit Details">
                        <HeaderTemplate>
                            Visit Details
                        </HeaderTemplate>
                        <ContentTemplate>
                            <asp:UpdatePanel ID="updVisitDetails" runat="server">
                                <ContentTemplate>
                                    <div class="ScrollStyle">
                                        <asp:GridView ID="gvVisitDetails" runat="server" AutoGenerateColumns="false" CssClass="mytable1 w-100p"
                                            PagerStyle-Font-Bold="true" PagerSettings-PageButtonCount="1" AllowPaging="True"
                                            PageSize="4" ForeColor="#333333" OnRowDataBound="gvVisitDetails_OnRowDataBound"
                                            OnPageIndexChanging="gvVisitDetails_PageIndexChanging">
                                            <Columns>
                                                <asp:TemplateField HeaderText="SNo">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="HLMessageID" HeaderText="HLMessageID" HeaderStyle-Wrap="false" ItemStyle-CssClass="Hide" HeaderStyle-CssClass="Hide" />
                                                <asp:BoundField DataField="Order_Status" HeaderText="Order_Status" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Date_Time_Of_Transaction" HeaderText="Date_Time_Of_Transaction"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Entered_By" HeaderText="Entered_By" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Placer_Group_Number" HeaderText="Placer_Group_Number"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Order_Control" HeaderText="Order_Control" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Start_Date_Time" HeaderText="Start_Date_Time" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="End_Date_Time" HeaderText="End_Date_Time" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="ORCOrdering_Provider" HeaderText="ORCOrdering_Provider"
                                                    HeaderStyle-Wrap="false" HeaderStyle-CssClass="Hide" ItemStyle-CssClass="Hide" />
                                                <asp:BoundField DataField="OrderingPerson_Identifier" HeaderText="OrderingPerson_Identifier"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="OrderingFamily_Name" HeaderText="OrderingFamily_Name"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="ORCEvent_Type" HeaderText="ORCEvent_Type" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Place_Order_Number" HeaderText="Place_Order_Number" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="ORCPlEntity_Identifier" HeaderText="ORCPlEntity_Identifier"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="ORCFiller_Order_Number" HeaderText="ORCFiller_Order_Number"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="ORCFEntity_Identifier" HeaderText="ORCFEntity_Identifier"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="ORCPrEntity_Identifier" HeaderText="ORCPrEntity_Identifier"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Response_Flag" HeaderText="Response_Flag" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="ORCQuantity_Timing" HeaderText="ORCQuantity_Timing" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Quantity" HeaderText="Quantity" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Interval" HeaderText="Interval" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Duration" HeaderText="Duration" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="ORCPriority" HeaderText="ORCPriority" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Parent_Order" HeaderText="Parent_Order" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Placer_Assigned_Identifier" HeaderText="Placer_Assigned_Identifier"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="EnterPerson_Identifier" HeaderText="EnterPerson_Identifier"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="EnterFamily_Name" HeaderText="EnterFamily_Name" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="EnterGiven_Name" HeaderText="EnterGiven_Name" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="EnterSecond_and_Further_Given_Names_or_Initials_Thereof"
                                                    HeaderText="EnterSecond_and_Further_Given_Names_or_Initials_Thereof" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Verified_By" HeaderText="Verified_By" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="OrderingGiven_Name" HeaderText="OrderingGiven_Name" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="OrderingSecond_and_Further_Given_Names_or_Initials_Thereof"
                                                    HeaderText="OrderingSecond_and_Further_Given_Names_or_Initials_Thereof" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="ORCSuffix" HeaderText="ORCSuffix" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="ORCPrefix" HeaderText="ORCPrefix" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="ORCDegree" HeaderText="ORCDegree" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Enterer_Location" HeaderText="Enterer_Location" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Point_of_Care" HeaderText="Point_of_Care" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Room" HeaderText="Room" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Bed" HeaderText="Bed" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Facility" HeaderText="Facility" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Call_Back_Phone_Number" HeaderText="Call_Back_Phone_Number"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="ORCTelephone_number" HeaderText="ORCTelephone_number"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Order_Effective_Date_Time" HeaderText="Order_Effective_Date_Time"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Order_Control_Code_Reason" HeaderText="Order_Control_Code_Reason"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Entering_Organization" HeaderText="Entering_Organization"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Entering_Device" HeaderText="Entering_Device" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Action_By" HeaderText="Action_By" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Advanced_Beneficiary_Notice_Code" HeaderText="Advanced_Beneficiary_Notice_Code"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Ordering_Facility_Name" HeaderText="Ordering_Facility_Name"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Ordering_Facility_Address" HeaderText="Ordering_Facility_Address"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Ordering_Facility_Phone_Number" HeaderText="Ordering_Facility_Phone_Number"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Ordering_Provider_Address" HeaderText="Ordering_Provider_Address"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Order_Status_Modifier" HeaderText="Order_Status_Modifier"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Advanced_Beneficiary_Notice_Override_Reason" HeaderText="Advanced_Beneficiary_Notice_Override_Reason"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Filler_Expected_Availability_Date_time" HeaderText="Filler_Expected_Availability_Date_time"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Confidentially_Code" HeaderText="Confidentially_Code"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Order_Type" HeaderText="Order_Type" HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="Enterer_Authorization_Mode" HeaderText="Enterer_Authorization_Mode"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="ORCParent_Universal_Service_Identifier" HeaderText="ORCParent_Universal_Service_Identifier"
                                                    HeaderStyle-Wrap="false" />
                                                <asp:BoundField DataField="HLMessageORCContent" HeaderText="HLMessageORCContent"
                                                    HeaderStyle-Wrap="false" />
                                            </Columns>
                                            <PagerStyle Font-Bold="True" />
                                        </asp:GridView>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </ContentTemplate>
                    </ajc:TabPanel>
                    <ajc:TabPanel ID="TabPanel3" runat="server" HeaderText="Order Details">
                        <HeaderTemplate>
                            Order Details
                        </HeaderTemplate>
                        <ContentTemplate>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                        <div class="ScrollStyle" style="height:100px">
                                        <asp:GridView ID="gvOrderDetails" PagerStyle-Font-Bold="true" CssClass="mytable1"
                                            OnRowDataBound="gvOrderDetails_OnRowDataBound" 
                                            runat="server" AutoGenerateColumns="False"
                                            ForeColor="#333333">
                                            <Columns>
                                                <asp:TemplateField HeaderText="SNo">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ShowHeader="false" HeaderText="Set_ID_OBR">
                                                    <ItemTemplate>
                                                        <asp:HiddenField ID="HLMessageID" Value='<%# Eval("HLMessageID") %>' runat="server" />
                                                        <asp:Label ID="Label1" Text='<%# Eval("Set_ID_OBR") %>' HeaderText="Set_ID_OBR" runat="server"
                                                            HeaderStyle-Wrap="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Tasks_Sales_ID" HeaderText="MsgControl Id" HeaderStyle-Wrap="false">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="universal_Service_Identifier" HeaderText="Universal_Service_Identifier"
                                                    HeaderStyle-Wrap="false">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="OBRIdentifier" HeaderText="OBR Identifier" HeaderStyle-Wrap="false">
                                                    <HeaderStyle Wrap="False" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Requested_Date_Time">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRequestDate" Text='<%# Eval("Requested_Date_Time") %>' runat="server"
                                                            HeaderStyle-Wrap="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Observation_Date_Time">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblObservationStartDate" Text='<%# Eval("Observation_Date_Time") %>'
                                                            runat="server" HeaderStyle-Wrap="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Placer_Field1" HeaderText="Placer_Field1"></asp:BoundField>
                                                <asp:BoundField DataField="placer_Field2" HeaderText="Placer_Field2"></asp:BoundField>
                                                <asp:BoundField DataField="filler_Field1" HeaderText="Filler_Field1"></asp:BoundField>
                                                <asp:BoundField DataField="Filler_Field2" HeaderText="Filler_Field2"></asp:BoundField>
                                                <asp:TemplateField HeaderText="Observation_End_Date_Time">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblObservationEndDate" Text='<%# Eval("Observation_End_Date_Time") %>'
                                                            runat="server" HeaderStyle-Wrap="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Specimen_Received_Date_Time">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblSpecimenReceivedDate" Text='<%# Eval("Specimen_Received_Date_Time") %>'
                                                            runat="server" HeaderStyle-Wrap="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Collector_Identifier" HeaderText="Collector_Identifier">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Person_Identifier" HeaderText="Person_Identifier"></asp:BoundField>
                                                <asp:BoundField DataField="OBRFamily_Name" HeaderText="OBRFamily_Name"></asp:BoundField>
                                      
                                                <asp:TemplateField HeaderText="Results_Rpt_Status_Chng_DateTime">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblResults_Rpt_Status_Chng_DateTime" Text='<%# Eval("Results_Rpt_Status_Chng_DateTime") %>'
                                                            runat="server" HeaderStyle-Wrap="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Change_to_Practice" HeaderText="Change_to_Practice" HeaderStyle-CssClass="Hide"
                                                    ItemStyle-CssClass="Hide"></asp:BoundField>
                                                <asp:BoundField DataField="Tasks_Line_Discount" HeaderText="Tasks_Line_Discount"
                                                        HeaderStyle-CssClass="Hide" ItemStyle-CssClass="Hide"></asp:BoundField>
                                                    <asp:BoundField DataField="Tasks_Line_Amount" HeaderText="Tasks_Line_Amount" HeaderStyle-CssClass="Hide"
                                                        ItemStyle-CssClass="Hide"></asp:BoundField>
                                                    <asp:BoundField DataField="Tasks_Sales_Price" HeaderText="Tasks_Sales_Price" HeaderStyle-CssClass="Hide"
                                                        ItemStyle-CssClass="Hide"></asp:BoundField>
                                                    <asp:BoundField DataField="OBRQuantity_Timing" HeaderText="OBRQuantity_Timing"></asp:BoundField>
                                                    <asp:TemplateField HeaderText="OBRQuantity_TimingStartDate" HeaderStyle-CssClass="Hide"
                                                        ItemStyle-CssClass="Hide">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblOBRQuantityStartDate" Text='<%# Eval("OBRQuantity_TimingStartDate") %>'
                                                                runat="server" HeaderStyle-Wrap="false"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="OBRQuantity_TimingPriority" HeaderText="OBRQuantity_TimingPriority" HeaderStyle-CssClass="Hide"
                                                        ItemStyle-CssClass="Hide">
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Login_Create_DateTime" HeaderStyle-CssClass="Hide"
                                                        ItemStyle-CssClass="Hide">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblLogin_Create_DateTime" Text='<%# Eval("Login_Create_DateTime") %>'
                                                                runat="server" HeaderStyle-Wrap="false"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Scheduled_Date_Time">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblScheduled_Date_Time" Text='<%# Eval("Scheduled_Date_Time") %>'
                                                                runat="server" HeaderStyle-Wrap="false"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="HLMessageOBRDetailsID" HeaderText="HLMessageOBRDetailsID"
                                                        HeaderStyle-Wrap="false" HeaderStyle-CssClass="Hide" ItemStyle-CssClass="Hide">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="OBREvent_Type" HeaderText="OBREvent_Type" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Placer_Order_Number" HeaderText="Placer_Order_Number"
                                                        HeaderStyle-Wrap="false"></asp:BoundField>
                                                    <asp:BoundField DataField="OBRFiller_Order_Number" HeaderText="OBRFiller_Order_Number"
                                                        HeaderStyle-Wrap="false"></asp:BoundField>
                                                    <asp:BoundField DataField="OBRText" HeaderText="OBRText" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Name_Of_Coding_System" HeaderText="Name_Of_Coding_System"
                                                        HeaderStyle-Wrap="false"></asp:BoundField>
                                                    <asp:BoundField DataField="OBRPriority" HeaderText="OBRPriority" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Collection_Volume" HeaderText="Collection_Volume" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Spicemen_Action_Code" HeaderText="Spicemen_Action_Code"
                                                        HeaderStyle-Wrap="false"></asp:BoundField>
                                                    <asp:BoundField DataField="Danger_Code" HeaderText="Danger_Code" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Relevant_Clinical_Information" HeaderText="Relevant_Clinical_Information"
                                                        HeaderStyle-Wrap="false"></asp:BoundField>
                                                    <asp:BoundField DataField="Specimen_Source" HeaderText="Specimen_Source" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="OBROrdering_Provider" HeaderText="OBROrdering_Provider"
                                                        HeaderStyle-Wrap="false"></asp:BoundField>
                                                    <asp:BoundField DataField="Given_Name" HeaderText="Given_Name" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Second_and_Further_Given_Names_or_Initials_There_of" HeaderText="Second_and_Further_Given_Names_or_Initials_There_of"
                                                        HeaderStyle-Wrap="false"></asp:BoundField>
                                                    <asp:BoundField DataField="OBRSuffix" HeaderText="OBRSuffix" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="OBRPrefix" HeaderText="OBRPrefix" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="OBRDegree" HeaderText="OBRDegree" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Order_Callback_Phone_Number" HeaderText="Order_Callback_Phone_Number"
                                                        HeaderStyle-Wrap="false"></asp:BoundField>
                                                    <asp:BoundField DataField="Diagnostic_Serv_Sect_ID" HeaderText="Diagnostic_Serv_Sect_ID"
                                                        HeaderStyle-Wrap="false"></asp:BoundField>
                                                    <asp:BoundField DataField="Result_Status" HeaderText="Result_Status" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Parent_Status" HeaderText="Parent_Status" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Login_Priority" HeaderText="Login_Priority" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Result_Copies_To" HeaderText="Result_Copies_To" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Parent_Result_Observation_Identifier" HeaderText="Parent_Result_Observation_Identifier"
                                                        HeaderStyle-Wrap="false"></asp:BoundField>
                                                    <asp:BoundField DataField="Transporation_Mode" HeaderText="Transporation_Mode" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Reason_For_Study" HeaderText="Reason_For_Study" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Principal_Result_Interpreter" HeaderText="Principal_Result_Interpreter"
                                                        HeaderStyle-Wrap="false"></asp:BoundField>
                                                    <asp:BoundField DataField="Assistant_Result_Interpreter" HeaderText="Assistant_Result_Interpreter"
                                                        HeaderStyle-Wrap="false"></asp:BoundField>
                                                    <asp:BoundField DataField="Technician" HeaderText="Technician" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Transcriptionist" HeaderText="Transcriptionist" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Number_Of_Sample_Containers" HeaderText="Number_Of_Sample_Containers"
                                                        HeaderStyle-Wrap="false"></asp:BoundField>
                                                    <asp:BoundField DataField="Transport_Logistics_Of_Collected_Samlpe" HeaderText="Transport_Logistics_Of_Collected_Samlpe"
                                                        HeaderStyle-Wrap="false"></asp:BoundField>
                                                    <asp:BoundField DataField="Collectors_Comment" HeaderText="Collectors_Comment" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Transport_Arrangement_Responsibility" HeaderText="Transport_Arrangement_Responsibility"
                                                        HeaderStyle-Wrap="false"></asp:BoundField>
                                                    <asp:BoundField DataField="Transport_Arranged" HeaderText="Transport_Arranged" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Escort_Required" HeaderText="Escort_Required" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Planned_Patient_Transport_Comment" HeaderText="Planned_Patient_Transport_Comment"
                                                        HeaderStyle-Wrap="false"></asp:BoundField>
                                                    <asp:BoundField DataField="Procedure_Code" HeaderText="Procedure_Code" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Procedure_Code_Modifier" HeaderText="Procedure_Code_Modifier"
                                                        HeaderStyle-Wrap="false"></asp:BoundField>
                                                    <asp:BoundField DataField="Placer_Supplemental_Service_Information" HeaderText="Placer_Supplemental_Service_Information"
                                                        HeaderStyle-Wrap="false"></asp:BoundField>
                                                    <asp:BoundField DataField="Filler_Supplemental_Service_Information" HeaderText="Filler_Supplemental_Service_Information"
                                                        HeaderStyle-Wrap="false"></asp:BoundField>
                                                    <asp:BoundField DataField="Medically_Necessary_Duplicate_Procedure_Reason" HeaderText="Medically_Necessary_Duplicate_Procedure_Reason"
                                                        HeaderStyle-Wrap="false"></asp:BoundField>
                                                    <asp:BoundField DataField="Result_Handling" HeaderText="Result_Handling" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Parent_Universal_Service_Identifier" HeaderText="Parent_Universal_Service_Identifier"
                                                        HeaderStyle-Wrap="false"></asp:BoundField>
                                                    <asp:BoundField DataField="HLMessageOBRContent" HeaderText="HLMessageOBRContent"
                                                        HeaderStyle-Wrap="false"></asp:BoundField>
                                                    <asp:BoundField DataField="LocationSource" HeaderText="LocationSource" HeaderStyle-Wrap="false">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="OBRQuantity_TimingQuantity" HeaderText="OBRQuantity_TimingQuantity"
                                                        HeaderStyle-Wrap="false" HeaderStyle-CssClass="hide" ItemStyle-CssClass="hide"></asp:BoundField>
                                                    <asp:BoundField DataField="OBRQuantity_TimingInterval" HeaderText="OBRQuantity_TimingInterval"
                                                        HeaderStyle-Wrap="false" HeaderStyle-CssClass="hide" ItemStyle-CssClass="hide"></asp:BoundField>
                                                    <asp:BoundField DataField="OBRQuantity_TimingDuration" HeaderText="OBRQuantity_TimingDuration"
                                                        HeaderStyle-Wrap="false" HeaderStyle-CssClass="hide" ItemStyle-CssClass="hide"></asp:BoundField>
                                                    <asp:TemplateField HeaderText="OBRQuantity_TimingEndDate"  HeaderStyle-CssClass="hide" ItemStyle-CssClass="hide">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblOBRQuantity_TimingEndDate" Text='<%# Eval("OBRQuantity_TimingEndDate") %>'
                                                                runat="server" HeaderStyle-Wrap="false"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
 
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </ContentTemplate>
                    </ajc:TabPanel>
                   
                </ajc:TabContainer>
                </div>
                <div runat ="server" id="divErrorDetails">
                   <asp:GridView ID="gvErrorMsg" AllowPaging="true" PageSize="10" runat="server" AutoGenerateColumns="false"
                    OnPageIndexChanging="gvErrorMsg_PageIndexChanging" OnRowDataBound="gvErrorMsg_OnRowDataBound" 
                                            ForeColor="#333333" CssClass="mytable1">
                                            <Columns>
                            <asp:TemplateField HeaderText="S.No">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="HLMessageColumns" HeaderText="Code" />
                                                <asp:BoundField DataField="HLMessageError" HeaderText="Error Message" />
                                            </Columns>
                                            <PagerStyle Font-Bold="True" />
                                        </asp:GridView>
                </div>
              
              
                                     
        </ContentTemplate>
    </asp:UpdatePanel>
    
    <div id="myModal" class="modal">
        <!-- Modal content -->
        <div class="modal-content">
            <div class="header">
                <div class="lh60">
                    HL7 Message </div>
            </div>
            <div>          
<div id="pdp" style="text-align: left; padding: 10px;">
                </div>
            </div>
            <div>
                <input type="button" class="close" value="Close" />
            </div>
        </div>
    </div>
    <div>
        <input type="hidden" id="hdnFileValue" runat="server" />
        <asp:HiddenField ID="hdnMessages" runat="server" />
    </div>
    <asp:HiddenField ID="MessageSelectedId" runat="server" />
     <div id="fade" class="black_overlay"></div>
      <div id="divapprovedus" class="white_content1" style="height: 60%">
    
      <div id="divUploadUC" runat="server">
        <table width="60%">
            <tr>
                <td>
                    <HL7MFU:HL7MessageFileUploader ID="HL7MessageFileUploader" runat="server" OnClick="HL7MessageFileUploader_Click" />
                </td>
            </tr>
            <tr>
                <td class="a-center">
                    <asp:Button runat="server" ID="btdGoBack" CssClass="btn" Visible="false" Text="Go Back"
                        meta:resourcekey="btdGoBackResource1" />
                </td>
            </tr>
        </table>
    </div>
  <div align="center">
            <input type="button" cssclass="btn" value="Close" 
            onclick= "javascript:ClearHL7()" />
        </div>
    </div>
    </div>
    </asp:Panel>
    <AttuneF:AttuneFooter ID="Attunefooter1" runat="server" />
    </form>

    <script type="text/javascript">
        $(document).ready(function() {
            CalculateHeight();
        });

        function ClearHL7() {
            IpFile = null;
            $("#HL7MessageFileUploader_pnlListBox").empty();
            $("#IpFile").val("");
            Clear();
            document.getElementById('divapprovedus').style.display = 'none'; document.getElementById('fade').style.display = 'none';
            
        }
        function CalculateHeight() {
            var wdt = $(window).width() - 40;
            var scrollWdt = $(window).width() - 26;
            $(".divgvHealthLabData").css("width", wdt);
            $(".ScrollStyle").css("width", wdt);
            $(".ScrollStyle").css("overflow-x", "auto");
            $(".divgvHealthLabData").css("overflow-x", "auto");
        }

        function CheckFromDateToDate() {
            alert('To date can not be less than the From date.');
        }
        function ChangeDisplay() {
            CalculateHeight
        }
    </script>

</body>
</html>
