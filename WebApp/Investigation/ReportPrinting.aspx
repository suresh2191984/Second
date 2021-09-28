<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportPrinting.aspx.cs" Inherits="Investigation_ReportPrinting" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="AdminHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer1.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>KIOSK REPORT PRINTING</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <%--<script src="../Scripts/CommonBilling.js?v=19" type="text/javascript"></script>--%>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
    <style>
        .barcodePanel
        {
                text-align: center;
               border: 1px solid #3886b5;
            width: 40%;
            margin: auto;
            padding: 20px;
            background: #3886b5;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
            border-radius: 5px;
        }    
        .barcodeNo
        {
            color: #fff;
            font-size: 30px;
            line-height: 85px;
            font-weight: bold;
        }
    
    input.btn.barcodebtn {
    padding: 1px;
    color: #ffffff;
    font: 20px 'Arial',helvetica,sans-serif;
    background-color: #174a69;
    border: 1px solid #23465d;
    cursor: pointer;
    margin-left: 15px;
    height: 50px;
    padding: 0 14px;
    box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
    }
    input.btn.barcodebtn:hover {
        background: #246288;
    }
    .txtstyleBar{
        font-size: 25px;
        font-weight: bold;
        text-align: center;
    }
    .font20
    {
        font-size: 20px;
    }
    </style>
    
    
    
    
    <script type="text/javascript">
   
       $(function() {
                 $("#txtBarcode").focus();
         });
		 
        function ChkVisitnumber() {
            //debugger;
            if (document.getElementById('txtBarcode').value == '' || document.getElementById('txtBarcode').value == '0') {
                alert('Please enter Barcode details');
                document.getElementById('txtBarcode').focus();
                return false;
            }
            else {
                var visitnumber = document.getElementById('txtBarcode').value;

                $.ajax({
                    type: "POST",
                    url: "../ReportPrintingService.asmx/GetPatientDetailsVisitNumber",
                    data: "{ 'prefixText': '" + visitnumber + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function(data) {

                        //debugger;

                        var Items = [];
                        Items = data.d;
                        if (Items != '') {
                            var PatientID = Items[0].PatientID;
                            var PatientVisitID = Items[0].PatientVisitID;
                            var VisitNumber1 = Items[0].VisitNumber;
                            var OrganizationID = Items[0].OrganizationID;
                            var MobileNumber = Items[0].MobileNumber;
                            document.getElementById('hdnPatientID').value = PatientID;
                            document.getElementById('hdnVisitID').value = PatientVisitID;
                            document.getElementById('hdnVisitNumber').value = VisitNumber1;
                            document.getElementById('hdnOrgID').value = OrganizationID;
                            document.getElementById('hdnMobileNo').value = MobileNumber;


//                            if (document.getElementById('hdnBarcodeButtonType').value == 1) {
                                var url = "..\\Investigation\\ReportPrintingDetails.aspx";
                                var RedirectUrl = url + '?vid=' + document.getElementById('hdnVisitID').value + '&pid=' + document.getElementById('hdnPatientID').value + '&orgid=' + document.getElementById('hdnOrgID').value + '&visitnumber=' + document.getElementById('hdnVisitNumber').value + '&mobno=' + document.getElementById('hdnMobileNo').value;
                                window.location.href = RedirectUrl + "&IsPopup=Y";
//                            }
//                            else {
//                                document.getElementById('divBarcodeNumber').style.display = 'none';
//                                document.getElementById('divMobileNumber').style.display = 'block';
//                                document.getElementById('txtMobileNo').focus();
//                            }
                        }
                        else {

                            alert('Invalid Barcode. Please enter valid details');
                            clearBarcode();
                            return false;
                        }

                    }
                    //                    ,
                    //                    failure: function(msg) {
                    //                        ShowErrorMessage(msg);
                    //                    }
                });
            }


        }



        function clearBarcode() {
            $('#txtBarcode').val('');
            $('#txtMobileNo').val('');
            $('#hdnPatientID').val('');
            $('#hdnVisitID').val('');
            $('#hdnVisitNumber').val('');
            $('#hdnOrgID').val('');
            $('#hdnMobileNo').val('');
            $('#hdnBarcodeButtonType').val('');

            document.getElementById('divBarcodeNumber').style.display = 'block';
            document.getElementById('divMobileNumber').style.display = 'none';
            document.getElementById('txtBarcode').focus();
        }
        
        
           function ChkMobilenumber() {
            if (document.getElementById('txtMobileNo').value == '' || document.getElementById('txtMobileNo').value == '0') {
                alert('Please enter valid Mobile number');
                return false;
            }
            else if (document.getElementById('txtMobileNo').value != document.getElementById('hdnMobileNo').value) {
                //debugger;
                alert('Invalid Mobile Number. Please enter valid number');
                $('#txtMobileNo').val('');
                return false;
            }
            else {         
                var url = "..\\Investigation\\ReportPrintingDetails.aspx";
                //popup = window.open(url + '?vid=' + document.getElementById('hdnVisitID').value + '&pid=' + document.getElementById('hdnPatientID').value + '&orgid=' + document.getElementById('hdnOrgID').value + '&visitnumber=' + document.getElementById('hdnVisitNumber').value + '&mobno=' + document.getElementById('hdnMobileNo').value);
                var RedirectUrl =url + '?vid=' + document.getElementById('hdnVisitID').value + '&pid=' + document.getElementById('hdnPatientID').value + '&orgid=' + document.getElementById('hdnOrgID').value + '&visitnumber=' + document.getElementById('hdnVisitNumber').value + '&mobno=' + document.getElementById('hdnMobileNo').value;
                window.location.href = RedirectUrl + "&IsPopup=Y";
                
            }
        }
        
             function EnterEvent(e) {
            //debugger;
            var ChkVid = document.getElementById('<%= hdnVisitID.ClientID%>').value;
            if (e.keyCode == 13) {

                //var ChkVid = document.getElementById('<%= hdnVisitID.ClientID%>').value;
                if (ChkVid) {
                    ChkMobilenumber();
                }
                else {
                    document.getElementById('hdnBarcodeButtonType').value = 1;
                    $("#btnProceed").click();
                }
            }
           
        }
        
    </script>

   

    

    <style type="text/css">
        .style2
        {
            width: 532px;
        }
        .style3
        {
            width: 530px;
        }
        .style4
        {
            width: 15%;
        }
    </style>
</head>
<body style="background-color: #87CEFA">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
   <%-- <div id="wrapper">--%>
        <div id="header" runat="server" visible="false">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <%--<img alt="" src="<%=LogoPath%>" class="logostyle" />--%>
                </div>
            </div>
            <div class="middleheader">
                <uc2:Header ID="Header2" runat="server" />
                <uc7:AdminHeader ID="AdminHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td valign="top" id="menu" style="display: none;" class="style4">
                    <div id="navigation">
                        <uc3:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="100%" valign="top" class="tdspace">
                    <%--<img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                                style="cursor: pointer;" />--%>
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
                                <uc5:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                       <%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>--%>
                
                       <%-- <div id="divBarcodeNumber" runat="server" style="margin-top: 10%;">--%>
                        <div id="div1" runat="server"  width="100%" align="center" class="padding23">
                   <asp:image ID="Image1" runat="server" imageurl="~/Images/Logo/Prima_logo.png" />
                </div>
                        <div class="barcodePanel"  >
                        
                            
                            <table width="100%" align="center" >
                                
                                <tr>
                                    <td align="center" valign="middle" >
                                        <asp:Label ID="lblBarcode" runat="server" CssClass="barcodeNo" Text="Please Enter Barcode Number"></asp:Label>
                                    </td>
                                    </tr>
                                    <tr>
                                    
                                    <td align="center">
                                        <asp:TextBox ID="txtBarcode" MaxLength="12" Height="45" Width="300" CssClass="Txtboxsmall txtstyleBar" placeholder="Barcode"
                                            runat="server"  TabIndex="1" onkeypress="return EnterEvent(event)"
                                              ></asp:TextBox>
                                          <%-- onkeydown="javascript:return chkPros();" --%>
                                        <%--<ajc:TextBoxWatermarkExtender ID="txtBarcodeWatermarkExtender" runat="server" 
                                                                            Enabled="True" TargetControlID="txtBarcode" WatermarkCssClass="watermarked" WatermarkText="Barcode Number">
                                                                        </ajc:TextBoxWatermarkExtender>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="style2">
                                        <br />
                                    </td>
                                    
                                </tr>
                            </table>
                            <table width="100%" align="center">
                                <tr>
                                    <td align="center">
                                        <%--<asp:Button ID="btnProceed" runat="server" Text="Proceed"  onclientclick="javascript:ChkVisitnumber();" class="btn barcodebtn"
            />--%>
                                        <input id="btnProceed" runat="server" class="btn barcodebtn font20" onclick="javascript:return ChkVisitnumber();"
                                            type="button" value="Proceed"  tabindex="2" />
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                        <%--<asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" OnClick="btnCancel_Click" />--%>
                                        
                                        <input id="btnCancel" class="btn barcodebtn font20" onclick="javascript:return clearBarcode();"
                                            type="button" value="Cancel " />
                                    </td>
                                </tr>
                            </table>
                           
                        
                        
                        </div>
                       <%-- </div>--%>
                      
                        <div id="divMobileNumber" style="display:none;margin-top: 10%;"   runat="server">
                        <div class="barcodePanel">
                            <table width="100%" align="center">
                                <tr>
                                    <td  class="style3">
                                        <asp:Label ID="lblMobileNo" runat="server" CssClass="barcodeNo" Text="Please Enter Mobile Number"></asp:Label>
                                    </td>
                                    </tr>
                                    <tr>
                                    <td >
                                        <asp:TextBox ID="txtMobileNo" MaxLength="15" Height="45" Width="300" placeholder="Mobile Number"
                                            runat="server" CssClass="Txtboxsmall txtstyleBar" onkeydown="return EnterEvent(event)" onkeypress="return blockNonNumbers(this, event, false, false);"></asp:TextBox>
                                        <%--<ajc:TextBoxWatermarkExtender ID="txtMobileNoWatermarkExtender1" runat="server"
                                                                            Enabled="True" TargetControlID="txtMobileNo" WatermarkCssClass="watermarked" WatermarkText="Mobile Number">
                                                                        </ajc:TextBoxWatermarkExtender>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="style2">
                                        <br />
                                    </td>
                                    
                                </tr>
                            </table>
                            <table width="100%" align="center">
                                <tr>
                                    <td align="center">
                                        <%--<asp:Button ID="btnContinue" runat="server" Text="Continue"  OnClientClick="javascript:return ChkMobilenumber();"
                                            CssClass="btn barcodebtn" OnClick="btnContinue_Click" />--%>
                                            <input id="btnContinue" class="btn barcodebtn font20"  type="button" value="Continue"  onclick="javascript:return ChkMobilenumber();"
                                             />
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                        <%--<asp:Button ID="btnContinueCancel" runat="server" Text="Cancel" CssClass="btn" OnClick="btnContinueCancel_Click" />--%>
                                        <input id="btnCancelMob" class="btn barcodebtn font20" onclick="javascript:return clearBarcode();"
                                            type="button" value="Cancel " />
                                    </td>
                                </tr>
                            </table>
                            </div>
                        </div>
                       <%--    </ContentTemplate>
            </asp:UpdatePanel>--%>
                    </div>
                </td>
            </tr>
            <%--<tr>
             
            </tr>--%>
        </table>
        
         
       
     <%--</div>--%>
     
    <%--<div class="padding: 100px;">
       <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
    <td>
       <table border="0" cellpadding="0" cellspacing="0" width="100%"  >
       <tr>
       <td >
            <asp:label id="label1" runat="server"  font-names="times new roman" 
                                        text="Powered By" font-size="X-Large" font-bold="true" ></asp:label>
       </td>
       </tr>
       <tr>
       <td >
       <asp:image ID="Image2" runat="server" imageurl="~/images/logo/attunelogo.png" />
       </td>
      
  <div >
       <table style="background-color:#FFFAFA">
       <tr>
       <td >
     <a><asp:label id="lbldisclaimer" runat="server"  font-names="times new roman" 
                                        text="Disclaimer" font-size="medium" font-bold="true" ></asp:label></a>
      <asp:label id="lbldisclaimer" runat="server"  font-names="times new roman" 
                                        text="Disclaimer" font-size="medium" font-bold="true" ></asp:label>
       </td>
       </tr>
       <tr>
       <td>
       <asp:label id="lbltext" runat="server"  font-names="times new roman" 
                                        text="Page will get refreshed in 10 seconds to home screen" font-size="medium" font-bold="true" ></asp:label>
       </td>
       </tr>
       </table>
       </div>
       </td>
       </tr>
       </table>
      
    </div>--%>
    <asp:HiddenField ID="hdnVisitNumber" runat="server" />
    <asp:HiddenField ID="hdnVisitID" runat="server" />
    <asp:HiddenField ID="hdnPatientID" runat="server" />
    <asp:HiddenField ID="hdnOrgID" runat="server" />
    <asp:HiddenField ID="hdnMobileNo" runat="server" />
    <asp:HiddenField ID="hdnBarcodeButtonType" runat="server" />
     
    </form>
   
</body>
<uc4:Footer ID="Footer1" runat="server" />
</html>
