<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HistopathDetailExaminationreport.aspx.cs" Inherits="ReportsLims_HistopathDetailExaminationreport" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Histopathology Detailed Report</title>
        <link href="../Images/favicon.ico" rel="shortcut icon" />
 
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table id="tblCollectionOPIP" class="a-center w-100p">
            <tr class="a-center">
                <td class="a-left">
                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
                                <ProgressTemplate>
                                    <div id="progressBackgroundFilter">
                                    </div>
                                    <div align="center" id="processMessage" width="60%">
                                        <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" />
                                        <br />
                                        <br />
                                        <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                            <div class="dataheaderWider">
                                <table id="tbl" class="w-100p">
                                    <tr>
                                        
                                        <td>
                                            <asp:Label ID="Rs_FromDate" Text="From Date" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                            </td>
                                            <td>
                                            <asp:TextBox ID="txtFDate" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                            <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                PopupButtonID="ImgBntCalc" Enabled="True" />
                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                        </td>                                                                             
                                        <td>
                                            <asp:Label ID="Rs_ToDate" Text="To Date" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                            </td>
                                            <td>
                                            <asp:TextBox ID="txtTDate" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                             <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                                PopupButtonID="ImgBntCalc" Enabled="True" />
                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                        
                                        </td>
                                       
                                              <td>
                                            <asp:Label runat="server" ID="lblVisitno" Text="Visit No" CssClass="label_title"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtvisitno" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                        </td>                                               
                                                          
                                    </tr>
                                    <tr>
                                    
                                      <td>
                                            <asp:Label runat="server" ID="lblPNO" Text="Patient No" CssClass="label_title"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPatientNo" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                        </td>                                               
                                             
                                             <td>
                                            <asp:Label runat="server" ID="lblpName" Text="Patient Name" CssClass="label_title"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPName" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                        </td>   
                                    
                                     <td>
                                            <asp:Label runat="server" ID="lblhistono" Text="Histopathology No" CssClass="label_title"></asp:Label>
                                        </td>
                                        <td>
                                             <asp:TextBox ID="txtHistono" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                        </td>                                 
                                        </tr>
                                        <tr>
                                        
                                        <td>
                                            <asp:Label runat="server" ID="lblTestID" Text="Test Name" CssClass="label_title"></asp:Label>
                                        </td>
                                        <td>
                                             <asp:TextBox ID="txtTestName" onkeyup="HistoTestNames(this.id)" runat="server" CssClass="Txtboxsmall ui-autocomplete-input"></asp:TextBox>
                                        </td>   
                                        
                                         <td>
                                            <asp:Label runat="server" ID="lblspec" Text="Specimen" CssClass="label_title"></asp:Label>
                                        </td>
                                        <td >
                                             <asp:TextBox ID="txtSpecimen" onkeyup="SpecimenAuto(this.id)" runat="server" CssClass="Txtboxsmall ui-autocomplete-input"></asp:TextBox>
                                        </td> 
                                    
                                         <td>
                                            <asp:Label runat="server" ID="lblImpression" Text="Impression" CssClass="label_title"></asp:Label>
                                        </td>
                                        <td>
                                             <asp:TextBox ID="txtImpression" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                        </td> 
                                    
                                    
                                    
                                    </tr>
                                    <tr>
                                    
                                     <td>
                                            <asp:Label runat="server" ID="lblclassification" Text="WHO Classification" CssClass="label_title"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtWHO" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                        </td> 
                                        
                                         <td>
                                            <asp:Label runat="server" ID="lblstaging" Text="Staging" CssClass="label_title"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtStaging" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                        </td> 
                                        
                                        <td>
                                            <asp:Label runat="server" ID="lblgrading" Text="Grading" CssClass="label_title"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtGrading" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                        </td> 
                                        
                                        </tr>
                                        <tr>
                                         <td>
                                            <asp:Label runat="server" ID="lblMalignant" Text="Malignant" CssClass="label_title"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtmalignant" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                        </td> 
                                    <td align="left">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                        </td>
                                        <td align="left">
                                            <asp:LinkButton ID="lnkBack" runat="server" Text="Back &nbsp; " CssClass="details_label_age"
                                                OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            
                            <div id="Excel" runat="server" style="display: none">
                                <table class="w-100p">
                                    <tr>
                                        <td id="tdexcel" style="padding-right: 10px; color: #000000;" runat="server">
                                            <asp:Label ID="lbExcel" Text="Excel Report" Font-Bold="True" ForeColor="#000333"
                                                runat="server" meta:resourcekey="lbExcelResource1"></asp:Label>
                                            <asp:ImageButton ID="btnConverttoXL" OnClick="btnConverttoXL_Click" runat="server"
                                                ImageUrl="~/Images/ExcelImage.GIF" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="divSummary" runat="server">
                                <asp:Panel ID="pnl" runat="server" ScrollBars="Vertical" Style="width: auto; height: 500px;
                                    display: none;">
                                    <table class="w-100p">
                                        <tr>
                                            <td>
                                                <asp:GridView ID="grdHistoReport" AlternatingRowStyle-CssClass="trEven" runat="server"
                                                    AutoGenerateColumns="False" ForeColor="#333333" CssClass="gridView" meta:resourcekey="gvIPSummaryResource1">
                                                    <HeaderStyle CssClass="dataheader1" />
                                                    <FooterStyle CssClass="dataheader1" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="S.No" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <%# Container.DataItemIndex + 1 %>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="PatientNumber" HeaderText="Patient Number">
                                                            <ItemStyle HorizontalAlign="Left"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="PatientName" HeaderText="Patient Name">
                                                            <ItemStyle HorizontalAlign="Left"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="VisitNumber" HeaderText="Visit No">
                                                            <ItemStyle HorizontalAlign="Left"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="HistopathNumber" HeaderText="Histopathology No">
                                                            <ItemStyle HorizontalAlign="Left"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="TestName" HeaderText="Test Name">
                                                            <ItemStyle HorizontalAlign="Left"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Specimen" HeaderText="Specimen">
                                                            <ItemStyle HorizontalAlign="Left"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Impression" HeaderText="Impression">
                                                            <ItemStyle HorizontalAlign="Left"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="WHOClassification" HeaderText="WHO Classification">
                                                            <ItemStyle HorizontalAlign="Left"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="IsMalignant" HeaderText="Malignant">
                                                            <ItemStyle HorizontalAlign="Left"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Staging" HeaderText="Staging">
                                                            <ItemStyle HorizontalAlign="Left"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Grading" HeaderText="Grading">
                                                            <ItemStyle HorizontalAlign="Left"/>
                                                        </asp:BoundField>
 							<asp:BoundField DataField="TissueType" HeaderText="Tissue Type">
                                                            <ItemStyle HorizontalAlign="Left"/>
                                                        </asp:BoundField>
 							<asp:BoundField DataField="Diagnosis" HeaderText="Diagnosis/Remarks">
                                                            <ItemStyle HorizontalAlign="Left"/>
                                                        </asp:BoundField>
 							<asp:BoundField DataField="ICD" HeaderText="ICD">
                                                            <ItemStyle HorizontalAlign="Left"/>
                                                        </asp:BoundField>
 							<asp:BoundField DataField="Category" HeaderText="Category">
                                                            <ItemStyle HorizontalAlign="Left"/>
                                                        </asp:BoundField> 
							<asp:BoundField DataField="TechnicalRemark" HeaderText="Technical Remarks">
                                                            <ItemStyle HorizontalAlign="Left"/>
                                                        </asp:BoundField>                                                     
                                                    </Columns>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label Font-Bold="True" Font-Size="13px" runat="server" ID="totTest" meta:resourcekey="totTestResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="btnConverttoXL" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
          <input type="hidden" id="hdnspecimenid" runat="server" />
          <input type="hidden" id="hdnspecimenname" runat="server" />
          <input type="hidden" id="hdnTestID" runat="server" value="0" />
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">
        function ShowAlertMsg(key) {
            var AlrtWinHdr = SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_winhdr") != null ? SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_winhdr") : "Alert";
            var UsrMsgDisp = SListForAppMsg.Get("ReportsLims_LabStatisticsReportLims_aspx_01") != null ? SListForAppMsg.Get("ReportsLims_LabStatisticsReportLims_aspx_01") : "No Matching Records found for the selected dates";
            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                // alert(userMsg);
                ValidationWindow(userMsg, AlrtWinHdr);

            }
            else if (key == "CommonMessages_20") {
                //alert(' No Matching Records found for the selected dates');
                ValidationWindow(UsrMsgDisp, AlrtWinHdr);

            }

            return false;
        }
        function validateToDate() {
            var AlrtWinHdr = SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_winhdr") != null ? SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_winhdr") : "Alert";
            var UsrMsgDisp = SListForAppMsg.Get("ReportsLims_LabStatisticsReportLims_aspx_02") != null ? SListForAppMsg.Get("ReportsLims_LabStatisticsReportLims_aspx_02") : "Provide / select value for From date";
            var UsrMsgDisp1 = SListForAppMsg.Get("ReportsLims_LabStatisticsReportLims_aspx_03") != null ? SListForAppMsg.Get("ReportsLims_LabStatisticsReportLims_aspx_03") : "Provide / select value for To date";
            if (document.getElementById('txtFDate').value == '') {
                //alert('Provide / select value for From date');
                ValidationWindow(UsrMsgDisp, AlrtWinHdr);
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                //alert('Provide / select value for To date');
                ValidationWindow(UsrMsgDisp1, AlrtWinHdr);
                document.getElementById('txtTDate').focus();
                return false;
            }
        }
        function popupprint(prnReport) {
            var prtContent = document.getElementById(prnReport);
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
        function clearContextText() {
            $('#contentArea').hide();

        }
    </script>

    <%--<script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

                        <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>--%>
</body>
 <style>
       .autocmp .ui-corner-all
        {
            -moz-border-radius: 4px 4px 4px 4px;
        }
    .ui-widget-content
        {
            border: 1px solid black;
            color: #222222;
            background-color: White;
        }
      
      .ui-menu
        {
            display: block;
            float: left;
            list-style: none outside none;
            margin: 0;
            padding: 2px;
        }
      .ui-autocomplete
        {
            cursor: default;
            position: absolute;
        }
        .ui-menu .ui-menu-item
        {
            clear: left;
            float: left;
            margin: 0;
            padding: 0;
            width: 100%;
        }
        .ui-menu .ui-menu-item a
        {
            display: block;
            padding: 3px 3px 3px 3px;
            text-decoration: none;
            cursor: pointer;
            background-color: White;
        }
        .ui-menu .ui-menu-item a:hover
        {
            display: block;
            padding: 3px 3px 3px 3px;
            text-decoration: none;
            color: White;
            cursor: pointer;
            background-color: ButtonText;
        }
        .ui-widget-content a
        {
            color: #222222;
        }
    </style>
 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script type="text/javascript">

      $(function() {
          SpecimenAuto(id);
          HistoTestNames(id);
      });

      function SpecimenAuto(id) {

          $("#" + id).autocomplete({
              source: function(request, response) {
                  $.ajax({
                      type: "POST",
                      contentType: "application/json; charset=utf-8",
                      url: '../OPIPBilling.asmx/LoadSpecialSamples',
                      data: JSON.stringify({ prefixText: request.term }),
                      dataType: "json",
                      success: function(data) {
                          if (data.d.length > 0) {
                              response($.map(data.d, function(item) {
                                  var rsltlable = item.SampleDesc;
                                  var rsltvalue = item.SampleCode;
                                  return {
                                      label: rsltlable,
                                      val: rsltvalue
                                  }
                              }))
                          }
                          else {
                              response([{ label: 'No results found.', val: -1}]);
                              // Clear();
                          }
                      },
                      error: function(response) {
                          alert(response.responseText);
                      },
                      failure: function(response) {
                          alert(response.responseText);
                      }
                  });
              },
              select: function(e, i) {
                  if (i.item.val == -1) {
                      $("#hdnspecimenid").val("");
                      $("#hdnspecimenname").val("");
                      $('#txtSpeciman').val("");
                  }
                  else {
                      $("#hdnspecimenid").val(i.item.val);
                      $("#hdnspecimenname").val(i.item.label);

                  }
              },
              minLength: 2
          });


      }


      function HistoTestNames(id) {

          $("#" + id).autocomplete({
              source: function(request, response) {
                  $.ajax({
                      type: "POST",
                      contentType: "application/json; charset=utf-8",
                      url: '../OPIPBilling.asmx/GetHistoDeptTestNames',
                      data: JSON.stringify({ DeptID: 0 }),
                      dataType: "json",
                      success: function(data) {
                          if (data.d.length > 0) {
                              response($.map(data.d, function(item) {
                                  var rsltlable = item.DeptName;
                                  var rsltvalue = item.DeptID;
                                  return {
                                      label: rsltlable,
                                      val: rsltvalue
                                  }
                              }))
                          }
                          else {
                              response([{ label: 'No results found.', val: -1}]);
                              // Clear();
                          }
                      },
                      error: function(response) {
                          alert(response.responseText);
                      },
                      failure: function(response) {
                          alert(response.responseText);
                      }
                  });
              },
              select: function(e, i) {
                  if (i.item.val == -1) {
                      $("#hdnTestID").val("");
                      $('#txtTestName').val("");
                  }
                  else {
                      $("#hdnTestID").val(i.item.val); 

                  }
              },
              minLength: 2
          });


      }



      function validateFrom(obj1, obj2) {
          var obj = document.getElementById(obj1);
          var obj3 = document.getElementById(obj2);
          if (obj.value != '' && obj.value != '__/__/____' || obj3.value != '') {
              dobDt1 = obj.value.split('/');
              var dobDt2 = obj3.value.split('/');
              var dobDtTime = new Date(dobDt1[2] + '/' + dobDt1[1] + '/' + dobDt1[0]);
              var dobDtTime2 = new Date(dobDt2[2] + '/' + dobDt2[1] + '/' + dobDt2[0]);
              var month = (dobDtTime.getMonth() + 1).toString();
              var monthTo = (dobDtTime2.getMonth() + 1).toString();
              var day = dobDt1[0];
              var year = dobDt1[2];
              var dayTo = dobDt2[0];
              var yearTo = dobDt2[2];
              if ((obj3.value != '') && (day > dayTo && month > monthTo && year > yearTo)) {

                  alert("ValidTO Must be Greater than or Equalto From Date");
                  obj3.value = '__/__/____';

              }
          }

          if (year > yearTo) {
              alert("FromDate year not be greater than todate year");
              obj.value = '__/__/____';
              obj.focus();
              return false;
          }
          else if (year == yearTo && month > monthTo) {
              alert("FromDate month not be greater than todate month");
              obj.value = '__/__/____';
              obj.focus();
              return false;
          }
          else if (year == yearTo && month == monthTo && day > dayTo) {
              alert("FromDate day not be greater than todate day");
              obj.value = '__/__/____';
              obj.focus();
              return false;
          }
      }

      function ValidDate(obj1, obj2, StartDt, wedFlag, BAflage) {
          var obj = document.getElementById(obj1);
          var obj1 = document.getElementById(obj2);
          if (obj.value == '') {
              alert("Please Select Valid From Date");
              obj1.value = '';
              obj.focus();
          }
          var currentTime;
          if (obj.value != '' && obj.value != '__/__/____') {
              dobDt = obj.value.split('/');
              var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
              var mMonth = (dobDtTime.getMonth() + 1).toString();
              var mDay = dobDt[0];
              var mYear = dobDt[2];
          }
          if (obj1.value != '' && obj1.value != '__/__/____') {
              dobDt1 = obj1.value.split('/');
              var dobDtTime = new Date(dobDt1[2] + '/' + dobDt1[1] + '/' + dobDt1[0]);
              var month = (dobDtTime.getMonth() + 1).toString();
              var day = dobDt1[0];
              var year = dobDt1[2];
          }
          if (mYear > year) {
              alert("ValidTo Must be Greater than or Equalto ValidFrom Date");
              document.getElementById('txtTDate').value = '';
              return false;
              obj1.value = '__/__/____';
              obj1.focus();
              return false;

          }
          else if ((mYear == year) && (mMonth > month)) {

              alert('ValidTo Must be Greater than or Equalto ValidFrom Date');

              document.getElementById('txtTDate').value = '';
              obj1.value = '__/__/____';
              obj1.focus();
              return false;

          }
          else if (mYear == year && mMonth == month && mDay > day) {
              alert('ValidTo Must be Greater than or Equalto ValidFrom Date');
              document.getElementById('txtTDate').value = '';
              obj1.value = '__/__/____';
              obj1.focus();
              return false;
          }
      }

    
    </script>
</html>
