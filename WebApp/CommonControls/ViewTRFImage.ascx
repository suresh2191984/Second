<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ViewTRFImage.ascx.cs"
    Inherits="CommonControls_ViewTRFImage" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/EMR/His.ascx" TagName="History" TagPrefix="His" %>
<%--
<script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

<script src="../Scripts/jquery.min.js" language="javascript" type="text/javascript"></script>

<script type="text/javascript" src="../Scripts/bid.js"></script>
--%>
<link rel="stylesheet" type="text/css" href="../Images/TRFImage/style.css" />

<script type="text/javascript" language="javascript">

    function dialogfunc() {

        $(function() {
            
            $("#dialog1").dialog({
                modal: true,
                autoOpen: false,
                resizable: false,
                title: "Information",
                width: 1100,
                height: 300
            });
            
           
        });
    }

    function OnClickTestHistory(Visitid) {
        if (Visitid == 0) {
            var visitid = document.getElementById('hdnVisitID').value;
        }
        else {
            visitid = Visitid;
        }
        var OrgID = document.getElementById('hdnOrgID').value;
        if (visitid > 0) {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/PatientTestHistoryValues",
                data: "{'OrgID' :" + parseInt(OrgID) + ",'PatientVisitID' :" + parseInt(visitid) + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function Validate(data) {
                    if (data.d.length > 0) {
                        GenerateTableTestHistory(data);
                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                alert("Error in Webservice Calling for PatientTestHistoryValues");
                    return false;
                }
            });
            return false;
        }
        
    }
    function onClickLnkSensitiveRemarks(visitid) {
        var visitid = document.getElementById('hdnVisitID').value;
        var OrgID = document.getElementById('hdnPatOrgID').value;
        var data1 = "{'OrgID' :" + parseInt(OrgID) + ",'VisitID' :" + parseInt(visitid) + "}";
        var OrgID1 = $("[id$='hdnPatOrgID']").val();
        if (visitid > 0) {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetSensitiveTestRemarks",
                data: "{'OrgID' :" + parseInt(OrgID) + ",'VisitID' :" + parseInt(visitid) + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function Validate(data) {
                    if (data.d.length > 0) {
                        GenerateTable(data);
                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error in Webservice Calling for GetSensitiveTestRemarks");
                    return false;
                }
            });
            return false;
        }

    }
    function GenerateTable(data) {
        //Build an array containing Customer records.
        var counsellingremarks = new Array();
        var lstHis = [];
        lstHis = data.d;
        counsellingremarks.push(["Patient History", "Remarks"]);
        for (var i = 0; i < lstHis.length; i++) {
            counsellingremarks.push([lstHis[i].HistoryName, lstHis[i].AttributeValueName]);
            //counsellingremarks.push(["Test", "Test"]); 
        }

        //Create a HTML Table element.
        var table = document.createElement("TABLE");
        table.border = "1";

        //Get the count of columns.
        var columnCount = counsellingremarks[0].length;

        //Add the header row.
        var row = table.insertRow(-1);
        var txtheader = '<thead>';
        for (var i = 0; i < columnCount; i++) {
            //var headerCell = document.createElement("TH");
            txtheader = txtheader + '<th>' + counsellingremarks[0][i] + '</th>';
            //row.appendChild(headerCell);
        }
        txtheader = txtheader + '</thead>';
        //Add the data rows.
        var trow = '';
        for (var i = 1; i < counsellingremarks.length; i++) {
            // row = table.insertRow(-1);
            var rtxt = '<tr>';
            for (var j = 0; j < columnCount; j++) {
                //var cell = row.insertCell(-1);
                rtxt = rtxt + '<td>' + counsellingremarks[i][j] + '</td>';
            }
            rtxt = rtxt + '</tr>';
        }

        var dvTable = document.getElementById("tblSensitiveRemarks");
        $('#tblSensitiveRemarks thead').remove();
        $('#tblSensitiveRemarks tbody').remove();
        $('#tblSensitiveRemarks tbody').removeClass();
        $('#tblSensitiveRemarks').prepend(txtheader + rtxt);
        
    }
    function GenerateTableTestHistory(data) {
        var Result = [];
        Result = JSON.parse(data.d);



        if (Result.length > 0) {


            var tablehead = "";
            tablehead = "<table id='tblTestHistory' class='w-50p lh35'>"
            var inptstr = "";
            var inptestname = "";
            var Resultdone = [];
        
            



            for (i = 0; i < Result.length; i++) {

                if ($.inArray(Result[i].ReferenceID, Resultdone) == -1) {
                    Resultdone.push(Result[i].ReferenceID);
                    inptestname = '<span style="font-weight:bold"> ' + Result[i].TestName + ' </span>';

                    tablehead += "<tr style='height:30px'><td>" + inptestname + "</td><td></td></tr>";

                    inptstr = '<span> ' + Result[i].Valuedata + ' </span>';



                    tablehead += "<tr><td>" + Result[i].Key + "</td><td>" + inptstr + "</td></tr>";

                   
                }
                else {


                  

                    inptstr = '<span> ' + Result[i].Valuedata + ' </span>';



                    tablehead += "<tr><td>" + Result[i].Key + "</td><td>" + inptstr + "</td></tr>";

                  



                }

            }

            tablehead += "</table>";

            if (Result.length > 0) {
                $('#dialog1').html('');
                $('#dialog1').append(tablehead);
            }
            $('#dialog1').dialog('open');
        }
    }

    var selectedOption;
    var orgId = $("[id$='hdnOrgID']").val();
    function onClickLnkTRF(objID) {
        try {
            if ($("#" + objID + " option").length > 3) {
                document.getElementById(objID).selectedIndex = 1;
                onChangeFile(objID);
            }
            return false;
        }
        catch (e) {
            return false;
        }
    }

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
 
</script>

<asp:UpdatePanel ID="UpdatePanel2" runat="server">
    <ContentTemplate>
        <table class="w-100p a-right" style="margin-right: 50px">
            <tr>
                <td>
                    <ul id="nav" style="position: absolute">
                        <li><a href="../Phlebotomist/Home.aspx" id="view" class="top_link" onclick="return false">
                            <span class="down"><%=Resources.CommonControls_ClientDisplay.CommonControls_ViewTRFImage_ascx_11%> </span></a>
                            <ul class="sub ws-normal">
                                <li class="h-35">
                                    <asp:LinkButton runat="server" CssClass="h-35" ToolTip="Click here to view TRF image" ID="LnkTRF"
                                        Font-Underline="True" meta:resourcekey="LnkTRFResource1"><%=Resources.CommonControls_ClientDisplay.CommonControls_ViewTRFImage_ascx_12%></asp:LinkButton></li>
                                <li class="h-35">
                                    <asp:LinkButton runat="server" CssClass="h-35" ToolTip="Click here to view photo image" ID="LnkPhoto"
                                        Font-Underline="True" meta:resourcekey="LnkPhotoResource1"><%=Resources.CommonControls_ClientDisplay.CommonControls_ViewTRFImage_ascx_13%></asp:LinkButton></li>
                                <li class="h-35">
                                    <asp:LinkButton runat="server" CssClass="h-35" ToolTip="Click here to view Sensitive Test Remarks"
                                        ID="LnkSensitiveRemarks" Font-Underline="True" meta:resourcekey="LnkPhotoResource1"><%=Resources.CommonControls_ClientDisplay.CommonControls_ViewTRFImage_ascx_17%></asp:LinkButton></li>
                                <li class="h-35">
                                    <div id="divOutsourceDoc">
                                        <asp:LinkButton runat="server" CssClass="h-35" ToolTip="Click here to view outsource document" ID="LnkOutDoc"
                                            Font-Underline="True" meta:resourcekey="LnkOutDocResource1"><%=Resources.CommonControls_ClientDisplay.CommonControls_ViewTRFImage_ascx_14%></asp:LinkButton>
                                    </div>
                                </li>
                                <li class="h-35">
                                    <div id="divLnkHistory">
                                        <asp:LinkButton runat="server" CssClass="h-35" ToolTip="Click here to view history" ID="LnkHistory"
                                            Font-Underline="True" meta:resourcekey="LnkHistoryResource1"><%=Resources.CommonControls_ClientDisplay.CommonControls_ViewTRFImage_ascx_15%></asp:LinkButton>
                                    </div>
                                </li>
                                <li class="h-35">
                                    <div id="divLnkDevicevalue">
                                        <asp:LinkButton runat="server" CssClass="h-35" ToolTip="Click here to view device value" ID="LnkDevicevalue"
                                            OnClientClick="javascript:displayProgress();" OnClick="Devicevalues_Click" 
                                            Font-Underline="True" meta:resourcekey="LnkDevicevalueResource1"><%=Resources.CommonControls_ClientDisplay.CommonControls_ViewTRFImage_ascx_16%></asp:LinkButton>
                                    </div>
                                </li>
                                <li class="h-35">
                                    <div id="divLnkTestPatientHistory" runat="server">
                                        <asp:LinkButton runat="server" CssClass="h-35" ToolTip="Click here to view Patient Test History" ID="LnkTestPatientHistory" Font-Underline="True">View Clinical History</asp:LinkButton>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="Devicevalue" runat="server" Style="display: none; height: 450px; width: 600px;"
                        CssClass="modalPopup dataheaderPopup" ScrollBars="Auto" 
                        meta:resourcekey="DevicevalueResource2">
                        <table align="center">
                            <tr>
                                <td id="Td4" style="height: 400px; width: 580px" class="v-top">
                                    <asp:GridView ID="grdDevicegroupname" runat="server" AutoGenerateColumns="false"
                                        OnRowDataBound="grdDevicegroupname_RowDataBound" Width="100%" BackColor="White"
                                        BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" Font-Names="Verdana"
                                        Font-Size="9pt" GridLines="Both" meta:resourcekey="grdDevicegroupnameResource1">
                                        <RowStyle ForeColor="#000066" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Group Name" ItemStyle-HorizontalAlign="Left"  meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="a-left h-25">
                                                                <asp:Label runat="server" ID="lblGroupNames" Text='<%# DataBinder.Eval(Container.DataItem, "GroupName") %>'  meta:resourcekey="lblGroupNamesResource1"></asp:Label>
                                                                <asp:Label runat="server" Visible="false" ID="lblOrgID" Text='<%# DataBinder.Eval(Container.DataItem, "OrgID") %>' meta:resourcekey="lblOrgIDResource1"></asp:Label>
                                                                <b>
                                                                    <%--<asp:Label ID="lblRowID" runat="server" Text='<% Container.DataItemIndex %>'></asp:Label>--%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="grdDevicevalues" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                    BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                                                    CellPadding="3" Font-Names="Verdana" Font-Size="9pt" GridLines="Both"  meta:resourcekey="grdDevicevaluesResource1" >
                                                                    <RowStyle ForeColor="#000066" />
                                                                    <Columns>
                                                                        <asp:BoundField DataField="DeviceID" HeaderText="Device Name" 
                                                                            meta:resourcekey="BoundFieldResource8" />
                                                                        <asp:BoundField DataField="Name" HeaderText="Investigation Name" 
                                                                            meta:resourcekey="BoundFieldResource9" />
                                                                        <asp:BoundField DataField="Value" HeaderText="Value" 
                                                                            meta:resourcekey="BoundFieldResource10" />
                                                                        <asp:BoundField DataField="DeviceValue" HeaderText="Device Value" 
                                                                            meta:resourcekey="BoundFieldResource11" />
                                                                        <asp:BoundField DataField="ErrorCode" HeaderText="Error Code" 
                                                                            meta:resourcekey="BoundFieldResource12" />
                                                                        <asp:BoundField DataField="ErrorCategory" HeaderText="Error Category" 
                                                                            meta:resourcekey="BoundFieldResource13" />
                                                                        <asp:BoundField DataField="ErrorDescription" HeaderText="Error Description" 
                                                                            meta:resourcekey="BoundFieldResource14" />
                                                                    </Columns>
                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-center">
                                    <asp:Button ID="btndeviceclose" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" Width="70px" 
                                        meta:resourcekey="btndevicecloseResource1" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <ajc:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="modalBackground"
                        DropShadow="false" PopupControlID="Devicevalue" CancelControlID="btndeviceclose"
                        TargetControlID="LnkDevicevalues" Enabled="True" Drag="false">
                    </ajc:ModalPopupExtender>
                    <input type="button" id="LnkDevicevalues" runat="server" style="display: none;" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="Panel1" runat="server" Style="display: none; height: 450px; width: 600px;"
                        CssClass="modalPopup dataheaderPopup" ScrollBars="Auto" 
                        meta:resourcekey="Panel1Resource1">
                        <table class="a-center">
                            <tr>
                                <td>
                                    <table class="w-100p">
                                        <tr>
                                            <td>
                                                <asp:GridView ID="grdDeviceinvname" runat="server" AutoGenerateColumns="False" Width="100%"
                                                    BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                                    CellPadding="3" Font-Names="Verdana" Font-Size="9pt" GridLines="Both">
                                                    <RowStyle ForeColor="#000066" />
                                                    <Columns>
                                                        <asp:BoundField DataField="DeviceID" HeaderText="Device Name" 
                                                            meta:resourcekey="BoundFieldResource1" />
                                                        <asp:BoundField DataField="Name" HeaderText="Investigation Name" 
                                                            meta:resourcekey="BoundFieldResource2" />
                                                        <asp:BoundField DataField="Value" HeaderText="Value" 
                                                            meta:resourcekey="BoundFieldResource3" />
                                                        <asp:BoundField DataField="DeviceValue" HeaderText="Device Value" 
                                                            meta:resourcekey="BoundFieldResource4" />
                                                        <asp:BoundField DataField="ErrorCode" HeaderText="Error Code" 
                                                            meta:resourcekey="BoundFieldResource5" />
                                                        <asp:BoundField DataField="ErrorCategory" HeaderText="Error Category" 
                                                            meta:resourcekey="BoundFieldResource6" />
                                                        <asp:BoundField DataField="ErrorDescription" HeaderText="Error Description" 
                                                            meta:resourcekey="BoundFieldResource7" />
                                                    </Columns>
                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-center">
                                    <asp:Button ID="btnclo" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" Width="70px" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <ajc:ModalPopupExtender ID="ModalPopupExtender2" runat="server" BackgroundCssClass="modalBackground"
                        DropShadow="false" PopupControlID="Panel1" CancelControlID="btnclo" TargetControlID="btncl"
                        Enabled="True" Drag="false">
                    </ajc:ModalPopupExtender>
                    <input type="button" id="btncl" runat="server" style="display: none;" />
                </td>
            </tr>
            <tr>
                <td class="a-center" id="tdTRF" runat="server">
                    <asp:Panel ID="pnlOthers" runat="server" Style="display: none; height: 540px; overflow: scroll;
                        width: 649px;" CssClass="modalPopup dataheaderPopup" 
                        meta:resourcekey="pnlOthersResource1">
                        <div id="divFullImage">
                            <table cellpadding="2" cellspacing="1" class="dataheader2 defaultfontcolor w-100p">
                                <tr id="trDropDown" runat="server">
                                    <td runat="server">
                                        <select id="ddlFileList" runat="server" class="ddl" style="width: 130px;" title="Select File Name to View">
                                        </select>
                                    </td>
                                </tr>
                                <tr id="trPicPatient" runat="server">
                                    <td id="PicPatient" class="w-2p" runat="server">
                                        <img id="imgPatient" runat="server" alt="Patient Photo" src="~/Images/noTRF.png" />
                                    </td>
                                </tr>
                                <tr id="trPDF" runat="server">
                                    <td runat="server">
                                        <iframe id="ifPDF" runat="server" width="640" height="460"></iframe>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    <button id="btnClose" runat="server" class="btn"><%=Resources.CommonControls_ClientDisplay.CommonControls_ViewTRFImage_ascx_01%></button>
                                       <%-- <input id="btnClose" runat="server" class="btn" type="button" value="Close" />--%>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </asp:Panel>
                    <ajc:ModalPopupExtender ID="mpeOthers" runat="server" BackgroundCssClass="modalBackground"
                        DropShadow="false" PopupControlID="pnlOthers" CancelControlID="btnClose" TargetControlID="LnkTRF"
                        Enabled="True">
                    </ajc:ModalPopupExtender>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="Panelphoto" runat="server" Style="display: none; height: 200px; width: 140px;"
                        CssClass="modalPopup dataheaderPopup" 
                        meta:resourcekey="PanelphotoResource1">
                        <div id="divphoto">
                            <table cellpadding="2" cellspacing="1" class="dataheader2 defaultfontcolor w-100p a-center">
                                <tr>
                                    <td id="Td1" class="w-2p">
                                        <img id="imgPatientphoto" runat="server" alt="Patient Photo" src="~/Images/nophoto.png" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-center">
                                    <button id="Butclose" runat="server" class="btn"><%=Resources.CommonControls_ClientDisplay.CommonControls_ViewTRFImage_ascx_01%></button>
                                        <%--<input id="Butclose" runat="server" class="btn" type="button" value="Close" />--%>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </asp:Panel>
                    <ajc:ModalPopupExtender ID="MPEphoto" runat="server" BackgroundCssClass="modalBackground"
                        DropShadow="false" PopupControlID="Panelphoto" CancelControlID="Butclose" TargetControlID="LnkPhoto"
                        Enabled="True">
                    </ajc:ModalPopupExtender>
                </td>
            </tr>
            <tr>
                <td class="a-center" id="td2" runat="server">
                    <asp:Panel ID="pnlOutDoc" runat="server" Style="display: none; height: 440px; width: 649px;"
                        ScrollBars="Vertical" CssClass="modalPopup dataheaderPopup" 
                        meta:resourcekey="pnlOutDocResource1">
                        <div id="div1">
                            <table cellpadding="2" cellspacing="1" class="dataheader2 defaultfontcolor w-100p">
                                <tr id="trddlOutsourceDoc" runat="server">
                                    <td runat="server">
                                        <select id="ddlOutsourceDocList" runat="server" class="ddl" style="width: 130px;"
                                            title="Select File Name to View">
                                        </select>
                                    </td>
                                </tr>
                                <tr id="trPicPatient1" runat="server">
                                    <td id="Td3" class="w-2p" runat="server">
                                        <img id="imgPatient1" runat="server" alt="Patient Photo" src="~/Images/no_Docs.png" />
                                    </td>
                                </tr>
                                <tr id="trPDF1" runat="server">
                                    <td runat="server">
                                        <iframe id="ifPDF1" runat="server" width="640" height="460"></iframe>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    <button id="btnClose1" runat="server" class="btn" ><%=Resources.CommonControls_ClientDisplay.CommonControls_ViewTRFImage_ascx_01%></button>
                                                    
                                        <%--<input id="btnClose1" runat="server" class="btn" type="button" value="Close" />--%>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </asp:Panel>
                    <ajc:ModalPopupExtender ID="mpopOutDoc" runat="server" BackgroundCssClass="modalBackground"
                        DropShadow="false" PopupControlID="pnlOutDoc" CancelControlID="btnClose1" TargetControlID="LnkOutDoc"
                        Enabled="True">
                    </ajc:ModalPopupExtender>
                </td>
            </tr>
            <tr>
                <td class="a-center" id="tdViewHistory" runat="server">
                    <asp:Panel ID="PnlViewHistory" runat="server" Style="display: none; height: 540px;
                        width: 649px;" CssClass="modalPopup dataheaderPopup" 
                        meta:resourcekey="PnlViewHistoryResource1">
                        <div id="divViewHistory">
                            <table cellpadding="2" cellspacing="1" class="dataheader2 defaultfontcolor a-center w-100p">
                                <tr>
                                    <td class="w-100p">
                                        <His:History ID="UcHistory" runat="server" />
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                <button  id="btnPrint" runat="server" class="btn"  onclick="popupprintEMRHistory();" ><%=Resources.CommonControls_ClientDisplay.CommonControls_ViewTRFImage_ascx_02%></button>
                                                    <%--<input id="btnPrint" runat="server" class="btn" type="button" value=" Print " onclick="popupprintEMRHistory();" />--%>
                                                </td>
                                                <td>
                                                <button id="Btclose" runat="server" class="btn" ><%=Resources.CommonControls_ClientDisplay.CommonControls_ViewTRFImage_ascx_01%> </button>
</button>
                                                    <%--<input id="Btclose" runat="server" class="btn" type="button" value=" Close " />--%>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </asp:Panel>
                    <ajc:ModalPopupExtender ID="mpeViewHistory" runat="server" BackgroundCssClass="modalBackground"
                        DropShadow="false" PopupControlID="PnlViewHistory" CancelControlID="Btclose"
                        TargetControlID="LnkHistory" Enabled="True">
                    </ajc:ModalPopupExtender>
                </td>
            </tr>
            <tr>
                <td class="a-center" id="tdSensitiveRemarks" runat="server">
                    <asp:Panel ID="PnlSensitiveRemarks" runat="server" Style="display: none; height: 350px;
                        width: 650px;" CssClass="modalPopup dataheaderPopup">
                        <div id="divSensitiveRemarks">
                            <table id="tblSensitiveRemarks"> 
                                <tfoot>
                                    <tr>
                                        <td>
                                            <input id="butnclose" runat="server" class="btn" type="button" value=" Close " />
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </asp:Panel>
                    <ajc:ModalPopupExtender ID="mpeSensitiveRemarks" runat="server" BackgroundCssClass="modalBackground"
                        DropShadow="false" PopupControlID="PnlSensitiveRemarks" TargetControlID="LnkSensitiveRemarks"
                        Enabled="True" CancelControlID="butnclose">
                    </ajc:ModalPopupExtender>
                </td>
            </tr>
        </table>
        <input type="hidden" id="hdnOrgID" runat="server" value="0" />
        <input type="hidden" id="hdnVisitID" runat="server" value="0" />
    </ContentTemplate>
</asp:UpdatePanel>
