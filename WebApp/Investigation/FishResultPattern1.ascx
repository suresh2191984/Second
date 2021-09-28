<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FishResultPattern1.ascx.cs" Inherits="Investigation_FishResultPattern1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<style type="text/css">
    .mytable1 td, .mytable1 th
    {
        border: 1px solid #686868;
        border-bottom: 1px solid #686868;
    }
</style>

<script  type="text/javascript" >
    var counter = 0;    
    var hdnFishResult = '<%=hdnFishResult.ClientID %>';

    function SaveFishResultsPattern1(hdnInvID, ctrlClientID) {
        
        try {
            var counter1=0

            var lstFishResult = [];
            $('#tblProbes tbody tr').each(function(i, n) {
                var $row = $(n);
                var probes = $row.find($('select[id$="Probes"] option:selected')).text();
                var probeID = $row.find($('select[id$="Probes"] option:selected')).val();
                var resultType = $row.find($('input[id$="Result"]')).val();
//                var resultTypeID = $row.find($('select[id$="Result"] option:selected')).val();
                var spattern = $row.find($('input[id$="txtSignalpattern"]')).val();
                var txtCountedCells = $row.find($('input[id$="txtCountedCells"]')).val();
                var txtResultantcells = $row.find($('input[id$="txtResultantcells"]')).val();
                var txtResults = $row.find($('input[id$="txtResults"]')).val();
                var Issummary = $row.find($('input[id$="Issummary"]')).is(':checked');
                //$('[id$="Issummary"] input[type=checkbox]:checked').is(':checked');
                var imgid = "ImgUpload" + counter1;
                var ImgUpload = probes;
                //var txtDescription = $row.find($('input[id$="txtDescription"]')).val();

                lstFishResult.push({
                    ProbeName: probes,
                    ProbeID: probeID,
                    //ResultTypeID: resultTypeID,
                    ResultType: resultType,
                    SignalPattern: spattern,
                    CountedNoofcells: txtCountedCells,
                    ResultantNoofcells: txtResultantcells,
                    Results: txtResults,
                    Description: Issummary,
                    Images: ImgUpload
                    //Description: txtDescription
                });
            });
            if (lstFishResult.length > 0) {
                document.getElementById(ctrlClientID + "_hdnFishResult").value = JSON.stringify(lstFishResult);               
                
            }
            else {
                document.getElementById(ctrlClientID + "_hdnFishResult").value = "";
            }           
        }
        catch (e) {
            return false;
        }
        return true;
    }


    function AddProbes() {
      
        $('#tblProbes tbody tr').each(function(i, n) {
            var $row = $(n);
        });
        var probeOption = "";
        var lstprobes = JSON.parse($('input[id$="hdnProbes"]').val());
        $.each(lstprobes, function(i, obj) {
            if (obj.Value == probeOption) {
                probeOption += "<option value='" + obj.Value + "' selected>" + obj.Name + "</option>";
            }
            else {
                probeOption += "<option value='" + obj.Value + "'>" + obj.Name + "</option>";
            }
        });
       
        var ddlProbes = '<span class="richcombobox" style="width: 120px;"><select id="Probes" class="ddl" style="width: 100px;" title="Select Probes">' + probeOption + '</select></span>';
        var row$ = $('<tr/>');
       
        //var ddlProbes = $('#Probes').clone();
        var tdddlProbes = $('<td/>').html(ddlProbes);
        var ddlResults = '<input id="Result" type="text" style="width: 80px;"  />';
       // var ddlResults = $('#Result').clone();
        var tdddlResults = $('<td/>').html(ddlResults);
        var txtResults = '<input id="txtResults" type="text" style="width: 170px; height: 40px;"  />';
        var tdtxtResults = $('<td/>').html(txtResults);
        var txtSignalpattern = '<input id="txtSignalpattern" type="text" style="width: 80px;"  />';
        var tdtxtSignalpattern = $('<td/>').html(txtSignalpattern);
        var txtCountedCells = '<input id="txtCountedCells" type="text" style="width: 80px;"   />';
        var tdttxtCountedCells = $('<td/>').html(txtCountedCells);
        var txtResultantcells = '<input id="txtResultantcells" type="text" style="width: 80px;" / >';
        var tdtxtResultantcells = $('<td/>').html(txtResultantcells);
//        var Isummary = '<input type="checkbox" id="Issummary" >';
//        var tdIsummary = $('<td/>').html(Isummary);
        var ImgUpload = document.createElement('DIV');
        ImgUpload.innerHTML = '<input id="ImgUpload' + counter + '" name = "ImgUpload' + counter + '" type="file" size="15" accept="image/*" onchange="checkFile(this.id);"  />';        
        var tdImgUpload = $('<td/>').html(ImgUpload);
        //var txtDescription = '<input id="txtDescription" type="text" style="width: 170px; height: 40px;"/ >';
        //var tdtxtDescription = $('<td/>').html(txtDescription);
        var inputDelete = '<input id="btnDelete"  value="Delete" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onProbeDelete(this);" />';
        var tdDelete = $('<td/>').html(inputDelete);
        //row$.append(tdddlProbes).append(tdddlResults).append(tdtxtSignalpattern).append(tdttxtCountedCells).append(tdtxtResultantcells).append(tdtxtResults).append(tdIsummary).append(tdImgUpload).append(tdDelete);
        row$.append(tdddlProbes).append(tdddlResults).append(tdtxtSignalpattern).append(tdttxtCountedCells).append(tdtxtResultantcells).append(tdtxtResults).append(tdImgUpload).append(tdDelete);
        //row$.append(tdddlProbes).append(tdddlResults).append(tdtxtSignalpattern).append(tdttxtCountedCells).append(tdtxtResultantcells).append(tdtxtResults).append(tdImgUpload).append(tdtxtDescription).append(tdDelete);
        $('#tblProbes tbody').append(row$);
       
        counter++;
    }
    function checkFile(obj) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vSelectFile = SListForAppMsg.Get('Investigation_FishResultPattern_ascx_01') == null ? "You must select a GIF,JPEG,JPG and PNG file for upload" : SListForAppMsg.Get('Investigation_FishResultPattern_ascx_01');
       
        var fileElement = document.getElementById(obj);
        var fileExtension = "";
        if (fileElement.value.lastIndexOf(".") > 0) {
            fileExtension = fileElement.value.substring(fileElement.value.lastIndexOf(".") + 1, fileElement.value.length);
        }
        if (fileExtension == "gif" || fileExtension == "GIF" || fileExtension == "JPEG" || fileExtension == "jpeg" || fileExtension == "jpg" || fileExtension == "JPG" || fileExtension == "PNG" || fileExtension == "png") {
            return true;
        }
        else {
            //alert("You must select a GIF,JPEG,JPG and PNG file for upload");
            ValidationWindow(vSelectFile, AlertType);
            document.getElementById(obj).value = '';
            fileElement.focus();
            return false;
        }
    }


    function onProbeDelete(obj) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vUnable = SListForAppMsg.Get('Investigation_FishResultPattern_ascx_02') == null ? "Unable to delete" : SListForAppMsg.Get('Investigation_FishResultPattern_ascx_02');
       
        try {
            var $row = $(obj).closest('tr');
            var HiddenProbeImageID = $row.find("input[id$='HiddenProbeImageID']").val();
            var invID = $row.find("input[id$='hdnInvestigationId']").val();
            var orgID = $row.find("input[id$='hdnOrgID']").val();
            var Patientvisitid = $row.find("input[id$='hdnPvisitid']").val();                   
            if (HiddenProbeImageID == '' || HiddenProbeImageID == undefined ) {
                HiddenProbeImageID = '0';
            }   
            if (invID == '' || invID == undefined) {
                invID = '0';
            }
            if (orgID == '' || orgID == undefined) {
                orgID = '0';
            }
            if (Patientvisitid == '' || Patientvisitid == undefined) {
                Patientvisitid = '0';
            }          
            
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/DeleteProbeImageDeatils",
                data: "{PVisitId: " + Patientvisitid + ",Pinvid: " + invID + ",OrgID: " + orgID + ",ImageId: " + HiddenProbeImageID + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function Success(data) {
                    $(obj).closest('tr').remove();
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    //alert("Unable to delete");
                    ValidationWindow(vUnable, AlertType);
                }
            });
        }
        catch (e) {
            return false;
        }
        return false;
    }

</script>


<table class="w-100p defaultfontcolor">
    <tr>
        <td id="tdInvName" runat="server" class="font10 h-30 w-19p" style="font-weight: normal; 
            color: #000;  display: table-cell;">
            <asp:Label ID="lblName" runat="server" Text="Name" 
                meta:resourcekey="lblNameResource1"></asp:Label>
            &nbsp;
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <table><tr><td class="font10 h-30 w-19p" style="font-weight: normal;
            color: #000;  display: table-cell;"><input id="Button1" value="Add" type="button"  Class="btn" 
             onclick="return AddProbes()" /></td></tr></table>
        </td>
        <td class="font10 h-30 w-19p" style="font-weight: normal; 
            color: #000;  display: table-cell;"></td>
        <td  class="font10 h-30 w-19p" style="font-weight: normal; 
            color: #000; display: table-cell;"></td>
    </tr>
    <tr>
        
        
        <td>
            <div class="mytable1" style="overflow: auto; height: 200px">
                <table id="tblProbes" class="w-98p">
                    <thead>
                        <tr class="h-17p dataheader1">
                            <th class="w-4p">
                                <asp:Label runat="server" ID="thProbes" Text="Probe" 
                                    meta:resourcekey="thProbesResource1" />
                            </th>
                            <th class="w-4p">
                                <%=Resources.Investigation_ClientDisplay.Investigation_FishResultPattern1_ascx_01 %>
                            </th>
                            <th class="a-center w-3p">
                                <%=Resources.Investigation_ClientDisplay.Investigation_FishResultPattern1_ascx_02 %>
                            </th>
                            <th class="a-center w-3p">
                                <%=Resources.Investigation_ClientDisplay.Investigation_FishResultPattern1_ascx_03 %>
                            </th>
                            <th class="a-center w-3p">
                                <%=Resources.Investigation_ClientDisplay.Investigation_FishResultPattern1_ascx_04 %>
                            </th>
                            <th class="a-center w-6p">
                                <asp:Label runat="server" ID="lblResult" Text="Comment(s)" 
                                    meta:resourcekey="lblResultResource1" />
                            </th>
                            
                            <th class="a-center w-5p">
                                <asp:Label runat="server" ID="lblImages" Text="Images" 
                                    meta:resourcekey="lblImagesResource1" />
                            </th>
                            <%--<th align="center" style="width: 10%;">
                                <asp:Label runat="server" ID="lblImagesdescription" Text="Description" />
                            </th>--%>
                            <th class="a-center w-3p">
                                <asp:Label runat="server" ID="lblAction" Text="Action" 
                                    meta:resourcekey="lblActionResource1" />
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptProbes" runat="server" 
                            onitemdatabound="rptProbes_ItemDataBound">
                            <ItemTemplate>
                                <tr class="h-17">
                                    <td class="a-left">
                                        <select id="Probes" class="ddlsmall" runat="server" title="Select Probe" >                                                                                       
                                        </select>
                                    </td>
                                    <td class="a-left">
                                        <%--<select id="Result"  class="ddl" style="width: 100px;" runat="server" title="Select Result" >
                                        <option value="0">--Select--</option>                                            
                                        </select>--%>
                                         <input type="text" id="Result" runat="server" value='<%# Bind("ResultType") %>' class="w-80"/>
                                    </td>
                                    <td class="a-left w-3p">
                                    <input type="hidden" runat="server" id="ProbeID" value='<%# Bind("ProbeID") %>' visible="false" />
                                    <%--<input type="hidden" runat="server" id="ResultTypeID" value='<%# Bind("ResultTypeID") %>' visible="false" />--%>
                                        <input type="text" id="txtSignalpattern" runat="server" value='<%# Bind("SignalPattern") %>' class="w-80" />
                                       
                                    </td>
                                    <td class="a-left w-3p">
                                        <input type="text" id="txtCountedCells" runat="server" class="w-80" value='<%# Bind("CountedNoofcells") %>' />
                                       
                                    </td>
                                    <td class="a-left w-3p">
                                        <input type="text" id="txtResultantcells" runat="server" class="w-80" value='<%# Bind("ResultantNoofcells") %>' />
                                       
                                    </td>
                                    <td class="a-left w-6p">
                                        <input type="text" id="txtResults" runat="server" cssclass="small"  value='<%# Bind("Results") %>' />
                                       
                                    </td>                                    
                                    <td class="a-left w-3p">
                                        <input type="file" name="ImgUpload" size="20" accept="image/*" onchange="checkFile(this.id);"  >
                                        <asp:Label ID="imagpath" runat="server" Text= '<%# Bind("Images") %>'
                                            meta:resourcekey="imagpathResource1"></asp:Label>
                                          <asp:HiddenField ID="hdnImagePath" runat="server" Value='<%# Eval("Images") %>' />
                                          <asp:HiddenField ID="HiddenProbeImageID" runat="server" Value='<%# Eval("ProbeImageID") %>' />
                                          <asp:HiddenField ID="hdnInvestigationId" runat="server" Value='<%# Eval("InvestigationID") %>' />
                                          <asp:HiddenField ID="hdnOrgID" runat="server" Value='<%# Eval("OrgID") %>' />
                                           <asp:HiddenField runat="server" ID="hdnPvisitid" Value='<%# Eval("PVisitId") %>' />
                                            <asp:HiddenField ID="hdnProbeName" runat="server" Value='<%# Eval("ProbeName") %>' />
                                            <asp:HiddenField ID="hdnProbeid" runat="server" Value='<%# Eval("ProbeID") %>' />
                                            <asp:HiddenField ID="hdnResult" runat="server" Value='<%# Eval("ResultType") %>' />
                                        <p  class="a-right">
                                            <asp:Image ID="Probeimage" CssClass="w-30 h-30" runat="server" 
                                                meta:resourcekey="ProbeimageResource1" />
                                    </td>
                                    <%--<td align="left">   
                                     <input type="text" id="txtDescription" runat="server" cssclass="Txtboxsmall" style="width: 170px; height: 40px;"  value='<%# Bind("Description") %>' /> 
                                      
                                    </td>--%>
                                    <td class="a-center w-2p">
                                        <input id="btnDelete" runat="server" value="Delete" type="button" style="background-color: Transparent;
                                            color: Blue; border-style: none; text-decoration: underline; cursor: pointer;
                                            font-size: 11px;" onclick="onProbeDelete(this);"  />
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </td>        
    </tr>
    <td >
    <table class="w-100p"><tr><td></td><td></td><td class="w-42p a-right v-middle">
	<asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" 
                        CssClass="ddlsmall" meta:resourcekey="ddlstatusResource1">
                        <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource1"></asp:ListItem>
                    </asp:DropDownList>
	</td><td class="w-14p">
                        <table id="tdInvStatusReason2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1"
                                         onmousedown="expandDropDownList(this);" 
                                        onblur="collapseDropDownList(this);" 
                                        meta:resourcekey="ddlStatusReasonResource1" CssClass="ddlsmall">
                                    <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <span class="richcombobox" class="w-100">
                                        <asp:DropDownList ForeColor="Black" ID="ddlOpinionUser" runat="server" TabIndex="-1"
                                            CssClass="ddlsmall" 
                                        meta:resourcekey="ddlOpinionUserResource1">
                                            <asp:ListItem Text="--Select--" meta:resourcekey="OpinionUserListItemResource1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </td></tr></table>
            
            <asp:HiddenField runat="server" ID="hidVal" />
             <asp:HiddenField runat="server" ID="hdnFishResult" Value="" />
             <asp:HiddenField runat="server" ID="hdnpatientvisitid" Value="0" />
              <asp:HiddenField runat="server" ID="hdninvid" Value="0" />
              <input id="hdnProbes" runat="server" type="hidden" />
              <input id="hdnResultType" runat="server" type="hidden" />
        </td>
    </table>
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />