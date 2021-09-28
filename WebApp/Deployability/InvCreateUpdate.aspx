<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvCreateUpdate.aspx.cs" EnableEventValidation="false"
    Inherits="Deployability_InvCreateUpdate" %>


<%@ Register Src="~/CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    
   
    <style type="text/css" >
    
    .AutoCompleteClass 
  
       .ui-autocomplete.ui-front{width:160px !important;min-height:20px;max-height:200px;overflow:auto;}
  
  

 </style>   
 


    <script type="text/javascript" language="javascript">


        function checkexlfileornot() {
            var selectedfileformat = document.getElementById('ddlfiletype').value;
            if (selectedfileformat != '0') {
                var selectedtype = document.getElementById('ddltype').value;
                if (selectedtype != 0) {
                    var fileElement = document.getElementById('<%=fileupload1.ClientID%>');
                    if (fileElement.value != '') {
                        var fileExtension = "";
                        if (fileElement.value.lastIndexOf(".") > 0) {
                            fileExtension = fileElement.value.substring(fileElement.value.lastIndexOf(".") + 1, fileElement.value.length);
                        }
                        if (selectedfileformat == '1' && fileExtension == "csv") {
                            var selectedfile = fileElement.value.substring(fileElement.value.lastIndexOf('\\') + 1, fileElement.value.length);
                            var FileName = selectedfile.split(".")[0];
                            if (selectedtype == "InvestigationMaster" && FileName == "Investigationmaster") {
                                return true;
                            }
                            else if (selectedtype == "GroupMaster" && FileName == "Groupmaster") {
                                return true;
                            }
                            else if (selectedtype == "PackageMaster" && FileName == "Packagemaster") {
                                return true;
                            }
                            else if (selectedtype == "GroupContentMaster" && FileName == "Groupcontent") {
                                return true;
                            }
                            else if (selectedtype == "Packagecontent" && FileName == "Packagecontent") {
                                return true;
                            }

                            else if (selectedtype == "ClientMaster" && FileName == "ClientMaster") {
                                return true;
                            }
                            else if (selectedtype == "ClientRateMapping" && FileName == "ClientRateMapping") {
                                return true;
                            }
                            else if (selectedtype == "RateCard" && FileName == "RateCard") {
                                return true;
                            }
                            else if (selectedtype == "RateMaster" && FileName == "RateMaster") {
                                return true;
                            }
                            else if (selectedtype == "ReferingHospital" && FileName == "ReferingHospital") {
                                return true;
                            }
                            else if (selectedtype == "RefferingPhysician" && FileName == "RefferingPhysician") {
                                return true;
                            }
                            else if (selectedtype == "RefrenceRange" && FileName == "RefrenceRange") {
                                return true;
                            }
                            else if (selectedtype == "TATDetails" && FileName == "TATDetails") {
                                return true;
                            }
                            else if (selectedtype == "UserMaster" && FileName == "UserMaster") {
                                return true;
                            }


                            else {
                                alert("Incorrect Excel sheet");
                                return false;
                            }
                        }
                        // else {
                        //alert("Upload a .csv file");
                        //return false;
                        // }



                        else if (selectedfileformat == '1' && fileExtension == "xls") {
                            return true;
                        }
                        else if (selectedfileformat == '2' && fileExtension == "xlsx") {
                            return true;
                        }

                        else if (selectedfileformat == '3' && fileExtension == "csv") {
                            return true;
                        }
                        else {
                            alert("Select correct File Type and format");
                            return false;
                        }
                    }
                    else {
                        alert("Please Upload a file");
                        return false;
                    }
                }
                else {
                    alert("Select the Content Type");
                    return false;
                }
            }
            else {
                alert("Select the File Type");
                return false;
            }
        }
        function ClearFields() 
        {

            if (/*@cc_on!@*/false || !!document.documentMode) 
            {
                var fil = document.getElementById('<%=fileupload1.ClientID%>');
                fil.select();
                n = fil.createTextRange();
                n.execCommand('delete');
                fil.focus(); return false;
            }
            else 
            {
                document.getElementById('<%=fileupload1.ClientID%>').value='';
            }
           
        }
        function GetTemplateFormat() {


            //return;
            var selectedtype = $("#ddltype").val();  //document.getElementById('ddltype').value;

            var filetype = $("#ddlfiletype").val();  // document.getElementById('ddlfiletype').value;

            if (filetype == '2') {
                return true;
            }
                   if (filetype == '0')
                     {

        alert("Select the File Type");
        return false;
                 }
    else if (selectedtype == '0') {

        alert("Select the Content Type");
        return false;
    }
    else {
        var fileextension = ".xls";

        if (filetype == "1") {
            fileextension = '.xls';
        }
        else if (filetype == "2") {

            fileextension = '.xlsx';
        }

        else {
            fileextension = '.csv';
        }

        if (selectedtype == "InvestigationMaster") {

            // window.open("../BulkDataUploadformat/TextFile.txt");
            window.open("../BulkDataUploadformat/Investigationmaster" + fileextension);
        }
        if (selectedtype == "Group") {
            window.open("../BulkDataUploadformat/Groupmaster" + fileextension);
        }
        if (selectedtype == "Package") {
            window.open("../BulkDataUploadformat/Packagemaster" + fileextension);
        }
        if (selectedtype == "Group Content") {
            window.open("../BulkDataUploadformat/Groupcontent" + fileextension);
        }
        if (selectedtype == "Package Content") {
            window.open("../BulkDataUploadformat/Packagecontent" + fileextension);
        }
        if (selectedtype == "ClientMaster") {



            //  window.open("../BulkDataUploadformat/ClientMaster.xlsx");
            window.open("../BulkDataUploadformat/ClientMaster" + fileextension);
        }
        if (selectedtype == "ClientRateMapping") {
            window.open("../BulkDataUploadformat/ClientRateMapping" + fileextension);
        }
        if (selectedtype == "RateCard") {
            window.open("../BulkDataUploadformat/RateCard" + fileextension);
        }
        if (selectedtype == "RateMaster") {
            alert("Not allowed to use Download Template for RateMaster");
            return;

            //window.open("../BulkDataUploadformat/RateMaster" + fileextension);


            // window.open("../BulkDataUploadformat/CopyofRateMaster" + fileextension);
        }


        if (selectedtype == "ReferingHospital") {
            window.open("../BulkDataUploadformat/ReferingHospital" + fileextension);
        }
        if (selectedtype == "RefferingPhysician") {
            window.open("../BulkDataUploadformat/RefferingPhysician" + fileextension);
        }
        if (selectedtype == "RefrenceRange") {
            window.open("../BulkDataUploadformat/RefrenceRange" + fileextension);
        }
        if (selectedtype == "TATDetails") {
            window.open("../BulkDataUploadformat/TATDetails" + fileextension);
        }
        if (selectedtype == "UserMaster") {
            window.open("../BulkDataUploadformat/UserMaster" + fileextension);
        }

    }
   }
       

        function GetValidation() {
            var type = $("#ddltype").val();// document.getElementById('ddltype').value;

            var filetype = $("#ddlfiletype").val(); // document.getElementById('ddlfiletype').value;
            if (filetype == '0') {
                alert("Select the File Type");
                return false;
            }
            if (type == '0') {
                alert("Select the Content Type");
                return false;
            }
            if (type == 'RateMaster') {
                $('#chk').show();
                $('#lid').show();
                $('#chk').attr('checked', false); 
                alert("Select the  download Existing RateType to download Data");
                return false;
            }
            
            if ((type == 'UserMaster')) {
                $('#btndownloadtemplatedata').prop('disabled', true);
                alert("Not allowed to download " + type + " " + "Data");
                return false;
            }
            else {
                $('#btndownloadtemplatedata').removeAttr('disabled');


            }
         
           
            return true;


        }

        function GetValidationRateType() {
            var type = $("#ddltype").val(); // document.getElementById('ddltype').value;

            var filetype = $("#ddlfiletype").val(); // document.getElementById('ddlfiletype').value;

            var txtsearch =$('#hdnRateTypeVal').val();
           
            if (txtsearch == '') 
            {
                alert("Select the Rate Type");
                return false;
            }
            if (filetype == '0') {
                alert("Select the File Type");
                return false;
            }
            if (type == '0') {
                alert("Select the Content type");
                return false;
            }
           

            if ((type == 'UserMaster')) {
                $('#btndownloadtemplatedata').prop('disabled', true);
                alert("Not allowed to download " + type + "Data");
                return false;
            }
            else {
                $('#btndownloadtemplatedata').removeAttr('disabled');


            }
    
            if ((type == 'RateMaster') && ($('#txtCopyToRate').val() == '')) {
                alert("Please select the Rate Type");
                return false;
            }
            return true;


        }

     
       
    </script>

    
    
    <style type="text/css">
        #chk
        {
            width: 36px;
        }
        .searchPanel
        {
            width: 87%;
        }
        .style1
        {
            width: 354px;
        }
        .style2
        {
            width: 164px;
        }
    </style>

    
    
</head>
<body>

    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="1000">
    </asp:ScriptManager>
  
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <script src="../Scripts/jquery.dataTables.min.js" type="text/javascript"></script>
    
    
      <div class="contentdata" style="height: 490px;">


                               
     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
            
            
             <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                    <ProgressTemplate>
                                        <div id="progressBackgroundFilter">
                                        </div>
                                        <div id="processMessage">
                                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                                meta:resourcekey="img1Resource1" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                
                                
         
                   <div id="divDetails" runat="server">
<asp:GridView ID="gvDetails" AutoGenerateColumns="true" CellPadding="5" runat="server" style="display:none" >
</asp:GridView>
</div>
                <table border="0" cellpadding="2" cellspacing="1" class="tabledata searchPanel">
             
                <tr class="lh30">
                        <td style="padding-left: 100px;" class="style2">
                            <asp:Label ID="Label1" runat="server" Text="Select File Type" Font-Bold="true"></asp:Label>
                        </td>  
                        <td class="style1">
                            <asp:DropDownList ID="ddlfiletype" runat="server" Width="135px">
                            <asp:ListItem Value="0">--Select--</asp:ListItem>
                            <asp:ListItem Value="1">Excel(.xls)</asp:ListItem>
                               <asp:ListItem Value="2">Excel(.xlsx)</asp:ListItem>
                              <asp:ListItem Value="3">CSV(.csv)</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td></td>
                        </tr>
                        
             <tr class="lh30">
                        <td  style="padding-left: 100px;" class="style2">
                            <asp:Label ID="lbltype" runat="server" Text="Select Content Type" 
                                Font-Bold="True"></asp:Label>
                        </td>
                        <td class="style1">
                            <asp:DropDownList ID="ddltype" runat="server"  Width="135px" >
                            </asp:DropDownList>
                            <asp:Button ID="btnloadsheet" runat="server" onclick="btnloadsheet_Click" 
                                OnClientClick="javascript:return GetTemplateFormat();" 
                                Text="DownLoad Template" Width="148px" 
                              />
                        </td>
                        <td id="tdchks" runat="server" >
                           <input type="checkbox" onClick="showHide(this);"  runat="server" class="hide" id="chk" /> 
                            
                            <asp:Label ID="lid" runat="server" Text="Is Download Existing RateType?" class="hide" ></asp:Label>
                            </td>
                    </tr>
                    <tr id="tr" runat="server" class="hide" >
                    <td style="padding-left: 100px;" class="style2"><asp:Label ID="lblratetype" 
                            runat="server" Text="Select Rate" Font-Bold="True"></asp:Label>
                                                                </td> 
                                                                <td class="style1">
                                                                  
                                                                    <asp:TextBox ID="txtCopyToRate" runat="server" CssClass="AutoCompleteClass" 
                                                                        Width="130px"></asp:TextBox>
                                                                    <asp:Button ID="btndownloadtemplatedata0" runat="server" 
                                                                        onclick="btndownloadtemplatedata_Click" 
                                                                        OnClientClick="javascript:return GetValidationRateType();" Text="DownLoad Data" 
                                                                        Width="150px" />
                                                                </td>
                                                                <td></td>
                    </tr>
                     <tr class="lh30">
                        <td  style="padding-left: 100px;" class="style2">
                            <asp:Label ID="lblselectfile" runat="server" Text="Select the file" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="style1">
                     
                            <asp:FileUpload ID="fileupload1" runat="server" CssClass="f-browse" />
                               <asp:Button ID="btnclear" runat="server" CssClass="f-upload" 
                             
                             Text="Clear" onclick="btnclear_Click" /> 
                           <%-- <input type="button"  id="btnclear"  onclick="ClearFields()" 
                                value="Clear" />--%>
                            <asp:Button ID="btnupload" runat="server" CssClass="f-upload" 
                                OnClick="btnupload_Click" 
                                OnClientClick="javascript:return checkexlfileornot();" Text="Upload" /> 
                        </td>
                        <td id="tddownloadtemplatedata" runat="server" class="show">
                            <asp:Button ID="btndownloadtemplatedata" runat="server"  OnClientClick="javascript:return GetValidation();"   onclick="btndownloadtemplatedata_Click" Text="DownLoad Data"  />
                            </td>
                    </tr>
                  
                    
                </table>
        </ContentTemplate>
            <Triggers>
               <asp:PostBackTrigger ControlID="btnupload" />
                <asp:PostBackTrigger ControlID="btndownloadtemplatedata0" />
                   <asp:PostBackTrigger ControlID="btndownloadtemplatedata" />
                 <asp:PostBackTrigger ControlID="btnloadsheet" />
            </Triggers>
        </asp:UpdatePanel>
     
           <div id="testgrid">
    <table id="example" runat="server">
    </table> 
    </div>
    <asp:Label ID="lbl" Text="" runat="server"></asp:Label>
     <asp:Label ID="Label2" Text="" runat="server"></asp:Label>
     <asp:HiddenField ID="hdnRateTypeVal" runat="server" />
      <asp:GridView ID="grdResult" runat="server" ></asp:GridView>
    </div>
    
     <script language="javascript" type="text/javascript">

         function showHide(id) {



             var lfckv = $('#chk').prop('checked');

             var type = $("#ddltype").val();





             if ((lfckv)) {
                 $('#tr').show();

             }
             else {
                 $('#tr').hide();
                 $('#tddownloadtemplatedata').show();

             }

             $('#txtCopyToRate').val("");
             $('#hdnRateTypeVal').val("");
             if ((lfckv) || (type == 'RateMaster')) {
                 $('#tddownloadtemplatedata').hide();

             }
         }


     
     $(document).ready(function($) {

     LoadTable();

    

     });

     function LoadTable() {


         var orgid = '<%= OrgID %>';
         var createdby = '<%= LID %>';
         var type = $('#ddltype option:selected').text();


         $.ajax({
             type: "POST",
             url: "InvCreateUpdate.aspx/GetDataFromDB",
             data: "{'orgid': '" + orgid + "','type': '" + type + "','createdby':" + createdby + "}",
             contentType: "application/json; charset=utf-8",
             dataType: "json",
             async: true,
             success: function(data) {

                 AjaxGetFieldDataSucceeded(data);




             },

             error: function(xhr, ajaxOptions, thrownError) {
//                 alert(thrownError);
//                 alert("Error test");
                 return false;
             }
         });
     }



     function dtConvFromJSON(dateStr) {
         jsonDate = dateStr;
         var d = new Date(parseInt(jsonDate.substr(6)));
         var m, day;
         m = d.getMonth() + 1;
         if (m < 10)
             m = '0' + m
         if (d.getDate() < 10)
             day = '0' + d.getDate()
         else
             day = d.getDate();
         var formattedDate = m + "/" + day + "/" + d.getFullYear();
         var hours = (d.getHours() < 10) ? "0" + d.getHours() : d.getHours();
         var minutes = (d.getMinutes() < 10) ? "0" + d.getMinutes() : d.getMinutes();
         var formattedTime = hours + ":" + minutes + ":" + d.getSeconds();
         formattedDate = formattedDate +" "+ formattedTime;


         return formattedDate;
     }
     function AjaxGetFieldDataSucceeded(result) {

         var oTable;
         if (result != "[]") {
             oTable = $('#example').dataTable({
                 "bDestroy": true,
                 "bAutoWidth": false,
                 "bProcessing": true,
                 "aaData": result.d,
                 "aoColumns": [


            { "mDataProp": "CreatedAt", sTitle: "Created Date", "mRender": function(data, type, full) { return dtConvFromJSON(data); } },
            { "mDataProp": "TestType", sTitle: "Master Type" },
            { "mDataProp": "UploadedFilename", sTitle: "Uploaded Filename" },
            { "mDataProp": "Username", sTitle: "Username" },
            { "mDataProp": "UploadedStatus", sTitle: "Status" }
            ],
                 "sPaginationType": "full_numbers",
                 "aaSorting": [],
                 "bJQueryUI": true,
                 "iDisplayLength": 15,
                 "sDom": '<"H"Tfr>t<"F"ip>',
                 "oTableTools": {
                     "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
                     "aButtons": [
                            "copy", "csv", "xls", "pdf",
                             {
                                 "sExtends": "collection",
                                 "sButtonText": "Save",
                                 "aButtons": ["csv", "xls", "pdf"]
                             }
                          ]
                 }
             });
             $('#example').show();
         }
     }



     $(function() {
         $('#btndownloadtemplatedata').click(function() {
             LoadTable();

         })
     });


     function pageLoad() {


         var orgid = '<%= OrgID %>';
        
         $("#txtCopyToRate").autocomplete({
            
             source: function(request, response) {
                 $.ajax({
                     type: "POST",
                     url: "InvCreateUpdate.aspx/loadRateType",
                     data: "{'OrgID':'" + orgid + "' ,'txtSearchName':'" + $('#txtCopyToRate').val() + "' }",
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function(data) {
                         var returnedData = JSON.parse(data.d);
                         response($.map(returnedData, function(item) {
                             return {
                                 label: item.RateName,
                                 val: item.RateId
                                 
                             }
                         }))
                     },
                     error: function(result) {
                         alert("Failed to load names");
                     }
                 });
             },
             select: function(e, i) {
                 $('#hdnRateTypeVal').val(i.item.val);

             },
             minLength: 1
             
         });
         $('#ddltype').change(function() 
         {
             LoadTable();
             var type = $("#ddltype").val();
             if ((type != 'UserMaster'))
              {
                 $('#btndownloadtemplatedata').removeAttr('disabled');
             }


             if ((type == 'RateMaster')) 
             {


                 $('#tddownloadtemplatedata').hide();
                
                 $('#chk').attr('checked', false); 
                              
                              
                 $('#chk').show();
                 $('#lid').show();
                 
             }
             else 
             {
                 $('#chk').hide();
                 $('#lid').hide();
                 $('#tr').hide();
                 $('#tddownloadtemplatedata').show();

             }


         })
         check();
     
      }
     function check() {
         var type = $("#ddltype").val();

         if ((type == 'RateMaster'))
          {
             $('#txtCopyToRate').val("");
             $('#hdnRateTypeVal').val("");
             $('#chk').attr('checked', false); 
           
             $('#chk').show();
             $('#lid').show();
         }

      return false;
     }
    
</script>
     </form>
</body>
</html>

 