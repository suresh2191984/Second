<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OutsourceReceive.aspx.cs" Inherits="Reception_OutsourceReceive"
    EnableEventValidation="false" meta:resourcekey="PageResource1" %>
<%@ Register Src="../CommonControls/PatientFileUploader.ascx" TagName="PatientFileUploader"
    TagPrefix="PFU" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
<%@ Register Src="~/CommonControls/TRFUpload.ascx" TagName="TRFUpload" TagPrefix="TRF" %>
<%@ Register Src="~/CommonControls/PhotoUpload.ascx" TagName="PhotoUpload" TagPrefix="PHOTO" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Patient Visit Details</title>
    
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
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
    </style></head>
    <body oncontextmenu="return false;">
    <form id="form1" runat="server"> <asp:UpdatePanel>
    <asp:ScriptManager ID="ctlTaskScriptMgr" ScriptMode="Release" runat="server">
    </asp:ScriptManager>
   
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <Attune:Attunefooter ID="Attunefooter1" runat="server" /> </asp:UpdatePanel>
    <div runat="server" id="divPatientDetails">
      <ucPatientdet:PatientDetails ID="PatientDetail" runat="server" />
                                <asp:GridView ID="grdResult" runat="server" 
        AllowPaging="True" CellPadding="1" AutoGenerateColumns="False" 
                                    DataKeyNames="PatientVisitID" 
        CssClass="gridView w-100p" AlternatingRowStyle-CssClass="trEven" 
                                  
                                      class="mytable1" OnRowCommand="grdResult_RowCommand"
        meta:resourcekey="grdResultResource1">

                                    <Columns>
                                       
                                         <asp:TemplateField HeaderText="Select" ItemStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource13">
                                                                        <HeaderTemplate>
                                                                            <asp:CheckBox ID="ChkbxHeaderSelect" runat="server" onClick="checkAllRows(this);"
                                                                                meta:resourcekey="ChkbxHeaderSelectResource1" />
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <%--<asp:RadioButton ID="rbSelect" GroupName="grpSelect" runat="server" OnClick="javascript:CheckOnOff(this.id,'grdSample');" />--%>
                                                                            <asp:CheckBox ID="ChkbxSelect" runat="server" onClick="checkUncheckHeaderCheckBox(this);"
                                                                                meta:resourcekey="ChkbxSelectResource1" />
                                                                            <asp:HiddenField ID="hdnVisitId" runat="server" Value='<%# bind("PatientVisitID") %>' />
                                                                            <asp:HiddenField ID="hdnSampleId" runat="server" Value='<%# bind("SampleID") %>' />
                                                                            <asp:HiddenField ID="hdnGuid" runat="server" Value='<%# bind("gUID") %>' />
                                                                            <asp:HiddenField ID="hdnSampleTrackerID" runat="server" Value='<%# bind("SampleTrackerID") %>' />
                                                                            <asp:HiddenField ID="hdnoutlocid" runat="server" Value='<%# bind("OutSourcingLocationID") %>' />
                                                                            <asp:HiddenField ID="hdnInvID" runat="server" Value='<%# bind("InvestigationID") %>' />
                                                                            <asp:HiddenField  ID="hdnAccessionNo" runat="server" Value='<%# bind("AccessionNumber") %>' />
                                                                            
                                                                
                                                                            <asp:HiddenField ID="hdnAddressID" runat="server" Value='<%# bind("OutSourcingLocationID") %>' />
                                                                            <asp:HiddenField ID="hdnPatientName" runat="server" Value='<%# bind("PatientName") %>' />
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                    </asp:TemplateField>


                                        <asp:BoundField DataField="FeeDescription" HeaderText="TEST NAME"  ItemStyle-HorizontalAlign="Center" meta:resourcekey="BoundFieldResource12"/>
                                        <asp:BoundField DataField="RefOrgName" HeaderText="OUTSOURCING LAB" ItemStyle-HorizontalAlign="Center" meta:resourcekey="BoundFieldResource12"/>
                                        <asp:BoundField DataField="OutsourcedDate" HeaderText="SENT TIME" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" meta:resourcekey="BoundFieldResource12"/>
                                        <asp:BoundField DataField="ReceivedDate" HeaderText="RECEIVE TIME" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" meta:resourcekey="BoundFieldResource12"/>
                                      
                                      
                                       <asp:TemplateField HeaderText="REFERENCE ID"  >
                                         <ItemStyle HorizontalAlign="center"></ItemStyle>
                                         <ItemTemplate>
                                         <asp:TextBox ID="txtreferenceid" runat="server" CssClass="refid"></asp:TextBox>
                                          </ItemTemplate>
                                           </asp:TemplateField>
                                           
                                           
                                         <asp:TemplateField HeaderText="Upload">
                                         <ItemStyle HorizontalAlign="center"></ItemStyle>
                                         <ItemTemplate>
                                           <input type="file"  onchange="fileclick(this);" style="display:none" />
                                     <asp:Button ID="btnupload" runat="server"   Text="Upload"  OnClientClick="return openfileDialog(this);"/>
                                           <asp:Button ID="View" runat="server" Text="View" CommandName="View" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'  />
                                         </ItemTemplate>
                                            </asp:TemplateField>
                                        
                                   
  
                                        
                                       
                                    </Columns>
                                </asp:GridView>
              
            </div>

   
<tr>
                            <td>
                                
 
                                               
                            </td>
                        </tr>
                        
                         
             

 <%--For Outsource document--%>
                    <tr>
                        <td align="center" id="td20" runat="server">
                            <asp:Panel ID="pnlOutDoc" runat="server" Style="display: none; height: 540px; width: 1050px;"
                                ScrollBars="Vertical" CssClass="modalPopup dataheaderPopup" meta:resourcekey="pnlOutDocResource1">
                                <%--<asp:Panel ID="pnlOutDoc" runat="server" Style="display: none; 600px; width: 1050px;"
                                        ScrollBars="Vertical" CssClass="modalPopup dataheaderPopup">--%>
                                <div id="div7">
                                    <table border="0" cellpadding="2" cellspacing="1" width="100%" class="dataheader2 defaultfontcolor">
                                        <tr id="trddlOutsourceDoc" runat="server">
                                            <td>
                                                <select id="ddlOutsourceDocList" runat="server" class="ddl" style="width: 130px;"
                                                    title="Select File Name to View">
                                                </select>
                                            </td>
                                        </tr>
                                        <tr id="trPicPatient1" runat="server">
                                            <td id="Td18" width="2%">
                                                <img id="imgPatient1" runat="server" alt="Patient Photo" src="~/Images/no_Docs.png" />
                                            </td>
                                        </tr>
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
                    <%-- Outsource doc End--%>
                        <script type="text/javascript">
                        
                       function openfileDialog(ctrl) {
                                $(ctrl).prev().click();

                               return false;
                           }

                           function fileclick(filectrl) {

                               var col = $(filectrl).closest('tr').find('td');
                               var input = $(col[0]).find('input[type="hidden"]');
                               
                               
                            
                               var data = new FormData();
                               var FormFiles = $(filectrl).get(0);
                               files1 = FormFiles.files;
                               if (files1.length > 0) {
                                   for (var i = 0; i < files1.length; i++) {

                                       var ke = $("#hdnvisitid").val() + '~' + $("#hdnvisitnumber").val() + '~' + $("#hdnroot").val() + '~' + $("#hdnorgid").val() + '~' + $("#hdnlid").val() + '~' + $("#hdnconfig").val() + '~' + $(input[5]).val() + '~' + $("#hdnpatientid").val();
                                       data.append(ke, files1[i]);
                                   }

                                   var options = {};
                                   options.url = "Outsourcereceive.ashx";


                                   options.type = "POST";
                                   options.data = data;
                                   options.contentType = false;
                                   options.processData = false;
                                   options.success = function(result) {
                                   };
                                   options.error = function(err) { alert(err.statusText); };
                                   $.ajax(options);


                               }
                           }

                            function checkAllRows(obj) {

                                var objGridview = obj.parentNode.parentNode.parentNode;
                                var list = objGridview.getElementsByTagName("input");

                                for (var i = 0; i < list.length; i++) {
                                    var objRow = list[i].parentNode.parentNode;
                                    if (list[i].type == "checkbox" && obj != list[i]) {
                                        if (obj.checked) {

                                            //If the header checkbox is checked then check all 
                                            //checkboxes and highlight all rows.

                                            objRow.style.backgroundColor = "#99E5E5";
                                            list[i].checked = true;
                                        }
                                        else {
                                            objRow.style.backgroundColor = "#FFFFFF";
                                            list[i].checked = false;
                                        }
                                    }
                                }
                            }

                            function checkUncheckHeaderCheckBox(obj) {
                                var objRow = obj.parentNode.parentNode;

                                if (obj.checked) {
                                    objRow.style.backgroundColor = "#99E5E5";
                                }
                                else {
                                    objRow.style.backgroundColor = "#FFFFFF";
                                }
                                var objGridView = objRow.parentNode;

                                //Get all input elements in Gridview
                                var list = objGridView.getElementsByTagName("input");
                                for (var i = 0; i < list.length; i++) {
                                    var objHeaderChkBox = list[0];

                                    //Based on all or none checkboxes are checked check/uncheck Header Checkbox
                                    var checked = true;

                                    if (list[i].type == "checkbox" && list[i] != objHeaderChkBox) {
                                        if (!list[i].checked) {
                                            checked = false;
                                            break;
                                        }
                                    }
                                }
                                objHeaderChkBox.checked = checked;
                            }

                            //------------------------------
                            var selectedOption1;
                            function onClickLnkOutDoc(objID) {
                                try {
                                    if ($("#" + objID + " option").length > 3) {
                                        document.getElementById(objID).selectedIndex = 1;
                                        onChangeFile1(objID);
                                    }
                                    return false;
                                }
                                catch (e) {
                                    return false;
                                }
                            }
                            function onChangeFile(objID) {

                                var orgId = $("[id$='hdnOrgID']").val();
                                try {
                                    var index = objID.lastIndexOf("_");
                                    var prefixId = objID.substring(0, index + 1);
                                    $('#' + prefixId + 'trPicPatient').hide();
                                    $('#' + prefixId + 'trPDF').hide();
                                    $('#' + prefixId + 'imgPatient').attr('src', '<%=ResolveUrl("~/Images/noTRF.png")%>');
                                    $('#' + prefixId + 'ifPDF').html('');
                                    selectedOption = $('#' + objID + ' option:selected');
                                    if ($(selectedOption).val() != 0) {
                                        if ($(selectedOption).val().indexOf('.pdf') != -1) {
                                            $('#' + prefixId + 'trPicPatient').hide();
                                            $('#' + prefixId + 'trPDF').show();
                                            $('#' + prefixId + 'ifPDF').attr('src', '<%=ResolveUrl("~/Reception/TRFImagehandler.ashx?PictureName=' + $(selectedOption).val() + '&OrgID=' + orgId + '")%>');
                                        }
                                        else {
                                            $('#' + prefixId + 'trPicPatient').show();
                                            $('#' + prefixId + 'trPDF').hide();
                                            $('#' + prefixId + 'imgPatient').attr('src', '<%=ResolveUrl("~/Reception/TRFImagehandler.ashx?PictureName=' + $(selectedOption).val() + '&OrgID=' + orgId + '")%>');
                                        }
                                    }
                                    return false;
                                }
                                catch (e) {
                                    return false;
                                }
                            }


                            function onChangeFile1(objID) {
                                var orgId = $("[id$='hdnOrgID']").val();
                                try {
                                    var index = objID.lastIndexOf("_");
                                    var prefixId = objID.substring(0, index + 1);
                                    $('#' + prefixId + 'trPicPatient1').hide();
                                    $('#' + prefixId + 'trPDF1').hide();
                                    $('#' + prefixId + 'imgPatient1').attr('src', '<%=ResolveUrl("~/Images/no_Docs.png")%>');
                                    $('#' + prefixId + 'ifPDF1').html('');
                                    selectedOption1 = $('#' + objID + ' option:selected');
                                    if ($(selectedOption1).val() != 0) {
                                        if ($(selectedOption1).val().indexOf('.pdf') != -1) {
                                            $('#' + prefixId + 'trPicPatient1').hide();
                                            $('#' + prefixId + 'trPDF1').show();
                                            $('#' + prefixId + 'ifPDF1').attr('src', '<%=ResolveUrl("~/Reception/TRFImagehandler.ashx?PictureName=' + $(selectedOption1).val() + '&OrgID=' + orgId + '")%>');
                                        }
                                        else {
                                            $('#' + prefixId + 'trPicPatient1').show();
                                            $('#' + prefixId + 'trPDF1').hide();
                                            $('#' + prefixId + 'imgPatient1').attr('src', '<%=ResolveUrl("~/Reception/TRFImagehandler.ashx?PictureName=' + $(selectedOption1).val() + '&OrgID=' + orgId + '")%>');
                                        }
                                    }
                                    return false;
                                }
                                catch (e) {
                                    return false;
                                }
                            }
                            
                            function clear_click()
                            {

                                $(".refid").val("");
                                     
                                     }
//---------------------------------------
        
</script>
                                          
                                             
                                        

                        
                                         
                             <input type="hidden" runat="server" id="hdnFileType" />       
                             <input type="hidden" runat="server" id="hdnconfig" />  
                             <input type="hidden" runat="server" id="hdnvisitid" />  
                             <input type="hidden" runat="server" id="hdnvisitnumber" />  
                             <input type="hidden" runat="server" id="hdnpno" />  
                             <input type="hidden" runat="server" id="hdnroot" />  
                             <input type="hidden" runat="server" id="hdnorgid" />  
                             <input type="hidden" runat="server" id="hdnlid" />  
                             <input type="hidden" runat="server" id="hdnpatientid" />  
                               
                          
                                           <asp:Button ID="Back" runat="server" CssClass="btn"
                                           Text="Back" OnClick="Backbutton_click" meta:resourcekey="btnBackResource1" />
                                           <asp:Button ID="Update" runat="server" CssClass="btn"
                                           Text="Update" OnClick="Update_Click" meta:resourcekey="btnUpdateResource1"/>
                                           <asp:Button ID="Clear" runat="server" CssClass="btn"
                                           Text="Clear" OnClientClick="clear_click();return false;" meta:resourcekey="btnClearResource1" /> 
                                           <asp:Label ID="EmptyGrid" BackColor=AliceBlue Font-Size=X-Large ForeColor=Blue runat="server" />
                                         


                        </form>
    </body>
    </html>
    