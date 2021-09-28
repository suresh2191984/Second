<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportPrintingDetails.aspx.cs" Inherits="Investigation_ReportPrintingDetails" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="AdminHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Report Printing</title>
     <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
     <style>
        #DLInv td
        {
            border-collapse: collapse !important;
            }
            .gridViewCustom{
                border-collapse: collapse;
                line-height: 35px;
                width: 50%;
            }
            .gridViewCustom th {
                background: #3181b1;
                color: #fff;
                font-size: 18px;
            }
            .gridViewCustom td {
                background: #fdfdfd;
                font-weight: bold;
                font-size: 18px;
                text-align: center;
            }
            .font13{
                font-size: 18px;
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
         function ChkNotReadyReports() {




             var VisitID = document.getElementById('hdnVisitID').value;

             $.ajax({
                 type: "POST",
                 url: "../ReportPrintingService.asmx/GetPatientReportPrintingStatus",
                 data: "{ 'VisitID': '" + VisitID + "'}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 async: false,
                 success: function(data) {

                     //debugger;

                     var Items = [];
                     Items = data.d;
                     if (Items != '') {
                         var ReportStatus = Items[0].ReportStatus;
                         var PrintingStatus = Items[0].PrintingStatus;

                         if (ReportStatus == 'Ready' && PrintingStatus == 'Printed') {
                             alert('Report(s) already printed. Please contact customer support department');
                             document.getElementById('hdnPrintingStatus').value = PrintingStatus;
                             return false;
                         }
                         else {
                             var NotReadyRpts = document.getElementById('<%=hdnNotReadyReports.ClientID %>').value;
                             if (NotReadyRpts > 0) {
                                 return confirm('All reports are not ready; Do you want to proceed.');
                             }
                         }
                     }


                 },
                 failure: function(msg) {
                     ShowErrorMessage(msg);
                 }
             });



         }
         
         
         
         
            // debugger;
//             var NotReadyRpts = document.getElementById('<%=hdnNotReadyReports.ClientID %>').value;

//             if (NotReadyRpts>0) {
//                 return confirm('All reports are not ready; Do you want to proceed.');
//               
//            }
            
//        }
//        }
        
    </script>
    <script type="text/javascript">
        function ChkReportPrintingStatus() {
            var VisitID = document.getElementById('hdnVisitID').value;

            $.ajax({
                type: "POST",
                url: "../ReportPrintingService.asmx/GetPatientReportPrintingStatus",
                data: "{ 'VisitID': '" + VisitID + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function(data) {

                    //debugger;

                    var Items = [];
                    Items = data.d;
                    if (Items != '') {
                        var ReportStatus = Items[0].ReportStatus;
                        var PrintingStatus = Items[0].PrintingStatus;

                        if (ReportStatus == 'Ready' && PrintingStatus == 'Printed') {
                            alert('Report(s) already printed. Please contact customer support department');
                            return false;
                        } 
                    }


                },
                failure: function(msg) {
                    ShowErrorMessage(msg);
                }
            });



        }

        function RedirectToHomePage() {
            var url = "..\\Investigation\\ReportPrinting.aspx?";
            window.location.href = url + "&IsPopup=Y";
        }


    </script>
</head>
<body style="background-color: #87CEFA">
    <form id="form1" runat="server">
     <meta http-equiv="refresh" content="7;url=ReportPrinting.aspx" />
     <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
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
    <table  border="0" cellpadding="0" cellspacing="0" width="100%">
   <tr>
                        <td width="15%" valign="top" id="menu" style="display: none;">
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
                                <div id="div1" runat="server" align="center">
                   <asp:image ID="Image1" runat="server" imageurl="~/Images/Logo/Prima_logo.png" />
                </div>
                                <table id="tblPatient" runat="server" width="100%" border="0" cellpadding="2" cellspacing="2">
                                    <tr>
                                        <td>
                                            <asp:Panel ID="PanelReportPrint" Width="100%" BorderWidth="0px" runat="server"
                                                meta:resourcekey="Panel3Resource1">
                                                <div style="display: block; width: 100%" class="dataheader2">
                                                    <table width="100%" border="0" class="font13" cellpadding="2" cellspacing="0">
                                                    <tr>
                                                        <td>&nbsp;&nbsp;</td>
                                                         <td>&nbsp;&nbsp;</td>
                                                          <td>&nbsp;&nbsp;</td>
                                                           <td>&nbsp;&nbsp;</td>
                                                            <td>&nbsp;&nbsp;</td>
                                                         <td>&nbsp;&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblVisitNo" Text="Visit Number :" Font-Bold="True" 
                                                                    runat="server" meta:resourcekey="lblVisitNoaResource1" 
                                                                    Font-Names="Times New Roman"></asp:Label>
                                                            </td>
                                                            <td align="left">
                                                                
                                                                <asp:Label ID="lblVisitNumbner" Font-Names="Times New Roman"  runat="server" meta:resourcekey="lblVisitNoaResource1"></asp:Label>
                                                            </td>
                                                            <td width="15%">
                                                                <asp:Label ID="lblName" Text="Patient Name :" Font-Bold="true" Font-Names="Times New Roman" runat="server" meta:resourcekey="lblNamesResource1"></asp:Label>
                                                            </td>
                                                            <td width="15%">
                                                            <asp:Label ID="lblTitleCode"  Font-Names="Times New Roman" runat="server" meta:resourcekey="lblNamesResource1"></asp:Label>
                                                            <asp:Label ID="lbldot"  Text="." Font-Names="Times New Roman" runat="server" meta:resourcekey="lblNamesResource1"></asp:Label>
                                                             <asp:Label ID="lblPatientName"  Font-Names="Times New Roman" runat="server" meta:resourcekey="lblNamesResource1"></asp:Label>
                                                            </td>
                                                            <td width="15%">
                                                                <asp:Label ID="lblSex" Text="Age/Gender :" Font-Bold="true" Font-Names="Times New Roman" runat="server" meta:resourcekey="lblconResource1"></asp:Label>
                                                            </td>
                                                            <td width="15%">
                                                                <asp:Label ID="lblAge" Font-Names="Times New Roman" runat="server" meta:resourcekey="lblNamesResource1"></asp:Label>/
                                                                <asp:Label ID="lblGender" Font-Names="Times New Roman"  runat="server" meta:resourcekey="lblNamesResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        
                                                        <tr>
                                                        <td>&nbsp;&nbsp;</td>
                                                         <td>&nbsp;&nbsp;</td>
                                                          <td>&nbsp;&nbsp;</td>
                                                           <td>&nbsp;&nbsp;</td>
                                                            <td>&nbsp;&nbsp;</td>
                                                         <td>&nbsp;&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblContact" Text="Contact Number :" Font-Bold="true"  Font-Names="Times New Roman" runat="server" meta:resourcekey="lblclientnameResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                               <asp:Label ID="lblContactNo"  runat="server" Font-Names="Times New Roman" meta:resourcekey="lblclientnameResource1"></asp:Label>
                                                                
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblVisitdate" Text="Visit Date & Time :" Font-Names="Times New Roman" Font-Bold="true" runat="server" meta:resourcekey="lblReferPhysicianResource1"></asp:Label>
                                                            </td>
                                                            <td >
                                                                <asp:Label ID="lblvisitDateTime"  runat="server" Font-Names="Times New Roman" meta:resourcekey="lblclientnameResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblRefering" Text="Referring Doctor :" Font-Names="Times New Roman" Font-Bold="true" runat="server" meta:resourcekey="lblddreglocationResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblReferingDoctor" runat="server" Font-Names="Times New Roman" meta:resourcekey="lblddreglocationResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                        <td>&nbsp;&nbsp;</td>
                                                         <td>&nbsp;&nbsp;</td>
                                                          <td>&nbsp;&nbsp;</td>
                                                           <td>&nbsp;&nbsp;</td>
                                                            <td>&nbsp;&nbsp;</td>
                                                         <td>&nbsp;&nbsp;</td>
                                                        </tr>
                                                        
                                                    </table>
                                                    
                                                </div>
                                                
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    
                                    <tr>
                                <td align="center">
                                
                                                                                                        
                                                                                                        
                                    <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" 
                                OnRowDataBound="grdResult_RowDataBound"  CssClass="gridViewCustom" meta:resourceKey="grdResultResource1">
                                <Columns>
                                  <asp:TemplateField HeaderText="Status" HeaderStyle-HorizontalAlign="left" Visible="false">
                                        <ItemTemplate>
                                               <asp:Label ID="lblStatus" runat="server" Visible="false" Text='<%# Eval("DisplayStatus")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                              
                                 <asp:BoundField DataField="InvestigationName" HeaderStyle-CssClass="abc" HeaderText="Investigation List">

                                    </asp:BoundField>
                                     <asp:BoundField DataField="DisplayStatus" HeaderStyle-CssClass="abc" HeaderText="Status">
                                       
                                    </asp:BoundField>
                                      <asp:TemplateField HeaderText="DueStatus" HeaderStyle-HorizontalAlign="left" Visible="false">
                                        <ItemTemplate>
                                               <asp:Label ID="lblDueStatus" runat="server" Visible="false" Text='<%# Eval("DueStatus")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                </asp:GridView>
                                                                                                        
                                                                                                        
                                </td>
                                </tr>
                                
                                <tr>
                                <td >
                                <br />
                                </td>
                              </tr>
                                   <tr align="center">
                                <td>
                                 <asp:Label ID="lblDueAmountStatus" runat="server"  Font-Names="Times New Roman" 
                                        Text="Alert : Please pay the Outstanding amount to print the report" Font-Size="X-Large" ForeColor="Red" ></asp:Label>
                                </td>
                                </tr>
                               
                                  <tr>
                                <td>
                                <br />
                                </td>
                                </tr>
                                <%-- <tr>
                                <td >
                                
                                </td>
                                </tr>--%>
                                <tr>
                                <td colspan="2" align="center">
                                    <asp:Button ID="btnPrint" runat="server" Text="Print Report"  class="btn barcodebtn font20" onClientclick="javascript:return ChkNotReadyReports();"
                                        onclick="btnPrint_Click"  Visible="false" />
                                     &nbsp;
                                     <asp:Button ID="btnCancel1" runat="server" Text="Cancel "  class="btn barcodebtn font20"
                                        onclick="btnCancel_Click" />
                                
                                </td>
                                </tr>
                                <%-- <tr>
                                <td colspan="2" align="center">
                                   
                                
                                </td>
                                </tr>
                               --%>
                                </table >
                                
                                
                                <%--<table id="tblPatientReport" align="center" runat="server" width="100%" border="0" cellpadding="2" cellspacing="2">
                                
                                </table>--%>
                                
                            </div>
                            
                        </td>
                        
                    </tr>
                       <div id="iframeplaceholder">
                                                                    <iframe runat="server" id='iframeBarcode' name='iframeBarcode' style='position: absolute;
                                                                        top: 0px; left: 0px; width: 0px; height: 0px; border: 0px; overfow: none; z-index: -1' >
                                                                    </iframe>
                                                                </div>
                
                 
    
    </table>

    </div>
    <div class="padding: 100px;">
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
      
     <%--  <div >
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
       </div>--%>
       </td>
       </tr>
       </table>
      
    </div>
    
        <asp:HiddenField ID="hdnPrinterID" runat="server" />
        <asp:HiddenField ID="hdnVisitID" runat="server" />
        <asp:HiddenField ID="hdnPatientID" runat="server" />
        <asp:HiddenField ID="hdnOrgID" runat="server" />
        <asp:HiddenField ID="hdnReadyReports" runat="server" />
        <asp:HiddenField ID="hdnNotReadyReports" runat="server" />
        <asp:HiddenField ID="hdnPrinterCode" runat="server" />
        <asp:HiddenField ID="hdnPrintingStatus" runat="server" />
       
    </form>
</body>
</html>
