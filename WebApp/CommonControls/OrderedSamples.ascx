<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OrderedSamples.ascx.cs"
    Inherits="CommonControls_OrderedSamples" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

<%--<script src="../Scripts_New/Common.js" type="text/javascript"></script>--%>

<script src="../Scripts/CommonBilling.js" type="text/javascript"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" type="text/javascript"></script>

 <script src="../QMS/dataTable/jquery.dataTables.min.js?v=1" type="text/javascript"></script>
<%--<script src="../Scripts/jquery.dataTables.min.js" type="text/javascript"></script>--%>
<%--<script src="../Scripts_New/bid.js" type="text/javascript"></script>--%>

<style>
.show{display: block !important;}
.w-75p {
    width: 75% !important;
}
.w-50p {
    width: 50% !important;
}
.w-49p{width: 49px;}
.paddingT100 {
    padding-top: 100px;
}
.paddingT50 {
    padding-top: 50px;
}
	/*******************Common.Css Modal PopUP Jquery****************************/
 .modalDiag 
    {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 1; /* Sit on top */
        left: 0;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /* Enable scroll if needed */
        background-color: rgb(0,0,0); /* Fallback color */
        background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    }
	
 .closeModalDiag {
		color: white;
		float: right;
		font-size: 12px;
		font-weight: bold;
		padding: 3px;
		border: 1px solid #fff;
		border-radius: 5px;
		width: 15px;
		height: 15px;
		text-align: center;
    }
    .closeModalDiag:hover,
    .closeModalDiag:focus {
        color: #ccc;
        text-decoration: none;
        cursor: pointer;
		padding: 3px;
		border: 1px solid #fff;
		border-radius: 5px;
		width: 15px;
		height: 15px;
		text-align: center;
    }
    /* modaldiag1 Body */
    .modalDiag-body {
        padding: 16px 16px !important;overflow:auto;}

/*******************End of Common.Css ****************************/
/*******************Green Theme Modal PopUP Jquery****************************/
    /* modaldiag1 Header */
    .modalDiag-header {
        padding: 12px 16px !important;
        background-color: #008080;
        color: white;
    }

    /* modaldiag1 Footer */
    .modalDiag-footer {
        padding: 12px 16px !important;
        background-color: #008080;
        color: white;
    }

    /* modaldiag1 Content */
    .modalDiag-content {
        position: relative;
        background-color: #fefefe;
        margin: auto;
        padding: 0;
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
        -webkit-animation-name: animatetop;
        -webkit-animation-duration: 0.7s;
        animation-name: animatetop;
        animation-duration: 0.7s;
        border-radius: 10px;
    }
    .modalDiag-content1 {
        position: relative;
        background-color: #fefefe;
        margin: auto;
        padding: 0;
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
        -webkit-animation-name: animaterevtop;
        -webkit-animation-duration: 0.7s;
        animation-name: animaterevtop;
        animation-duration: 0.7s;
        border-radius: 10px;
    }

    /* Add Animation */
    @-webkit-keyframes animatetop {
        from {top:-300px; opacity:0} 
        to {top:0; opacity:1}
    }

    @keyframes animatetop {
       from {top:-300px; opacity:0} 
        to {top:0; opacity:1}
    }
    @-webkit-keyframes animaterevtop {
        from {top:0; opacity:1}
        to {top:-300px; opacity:0}
    }
    @keyframes animaterevtop {
        from {top:0; opacity:1}
        to {top:-300px; opacity:0}
    }

/*******************End of Green Theme Modal PopUP Jquery****************************/

/*******************Blue Theme Modal PopUP Jquery****************************/
    /* modaldiag1 Header */
    .modalDiag-header {
        padding: 12px 16px !important;
        background-color: #3B90D0;
        color: white;
    }

    /* modaldiag1 Footer */
    .modalDiag-footer {
        padding: 12px 16px !important;
        background-color: #3B90D0;
        color: white;
    }

    /* modaldiag1 Content */
    .modalDiag-content {
        position: relative;
        background-color: #fefefe;
        margin: auto;
        padding: 0;
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
        -webkit-animation-name: animatetop;
        -webkit-animation-duration: 0.7s;
        animation-name: animatetop;
        animation-duration: 0.7s;
        border-radius: 10px;
    }
    .modalDiag-content1 {
        position: relative;
        background-color: #fefefe;
        margin: auto;
        padding: 0;
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
        -webkit-animation-name: animaterevtop;
        -webkit-animation-duration: 0.7s;
        animation-name: animaterevtop;
        animation-duration: 0.7s;
        border-radius: 10px;
    }
    /* Add Animation */
    @-webkit-keyframes animatetop {
        from {top:-300px; opacity:0} 
        to {top:0; opacity:1}
    }

    @keyframes animatetop {
       from {top:-300px; opacity:0} 
        to {top:0; opacity:1}
    }
    @-webkit-keyframes animaterevtop {
        from {top:0; opacity:1}
        to {top:-300px; opacity:0}
    }
    @keyframes animaterevtop {
        from {top:0; opacity:1}
        to {top:-300px; opacity:0}
    }

/*******************End of Blue Theme Modal PopUP Jquery****************************/


/*******************Black Theme Modal PopUP Jquery****************************/
    /* modaldiag1 Header */
   .modalDiag-header {
		padding: 12px 16px !important;
		background-color: #3B90D0;
		color: white;
	}

    /* modaldiag1 Footer */
    .modalDiag-footer {
        padding: 12px 16px !important;
        background-color: #777777;
        color: white;
    }

    /* modaldiag1 Content */
    .modalDiag-content {
        position: relative;
        background-color: #fefefe;
        margin: auto;
        padding: 0;
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
        -webkit-animation-name: animatetop;
        -webkit-animation-duration: 0.7s;
        animation-name: animatetop;
        animation-duration: 0.7s;
        border-radius: 10px;
    }
    .modalDiag-content1 {
        position: relative;
        background-color: #fefefe;
        margin: auto;
        padding: 0;
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
        -webkit-animation-name: animaterevtop;
        -webkit-animation-duration: 0.7s;
        animation-name: animaterevtop;
        animation-duration: 0.7s;
        border-radius: 10px;
    }
    /* Add Animation */
    @-webkit-keyframes animatetop {
        from {top:-300px; opacity:0} 
        to {top:0; opacity:1}
    }

    @keyframes animatetop {
       from {top:-300px; opacity:0} 
        to {top:0; opacity:1}
    }
    @-webkit-keyframes animaterevtop {
        from {top:0; opacity:1}
        to {top:-300px; opacity:0}
    }
    @keyframes animaterevtop {
        from {top:0; opacity:1}
        to {top:-300px; opacity:0}
    }

/*******************End of Black Theme Modal PopUP Jquery****************************/
</style>
<!-- Language converter -->
<style type="text/css">
.History_ModalPopup
{
height: 475px !important;
}
.ui-autocomplete {
	z-index: 10000001;
}
 .hide_Column
        {
            display: none;
        }
        .multiselect-container
        {
            max-height: 250px; /* you can change as you need it */
            overflow: auto;
            width: 160px ! important;
        }
        .required
        {
            padding-right: 25px;
            color: Red;
            background-position: right top;
        }
         .flow
        {
            float:left;
        }
        .alignCenter
        {
            text-align:center;
        }
    .marginT20{margin-top: 20px;} .marginB20{margin-bottom: 20px;}
</style>
<script type="text/javascript">
{
        
        function ClearPopUp1() {

            var otable = document.getElementById('tblGroupHistory');
            while (otable.rows.length > 1) {
                otable.deleteRow(otable.rows.length - 1);
            }
            var modal = $find('OrderedSamples1_ModalPopupShow');
            modal.hide();
            //        document.getElementById('billPart_btnDummy').click();
        }

        }
</script>

<table class="w-100p">
    <tr>
        <td class="a-left h-23" style="color: #000;">
            <div id="ACX2plus1" style="display: none;">
                <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                    onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);" />
                <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);">
                    <asp:Label ID="Rs_Investi" runat="server" Text="Investigations Ordered For Current Visit"
                        meta:resourcekey="Rs_InvestiResource1"></asp:Label></span>
            </div>
            <div id="ACX2minus1" style="display: block;">
                <img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                    style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);" />
                <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);">
                    &nbsp;<asp:Label ID="Rs_Investi1" runat="server" Text="Investigations Ordered For Current Visit"
                        meta:resourcekey="Rs_Investi1Resource1"></asp:Label></span>
            </div>
        </td>
    </tr>
    <tr class="tablerow" id="ACX2responses1" style="display: table-row;">
        <td colspan="2">
            <asp:Label ID="lblInvStatus" runat="server" Font-Size="Medium" Font-Bold="True" Text="No Investigations Ordered for Current Visit"
                Visible="False" meta:resourcekey="lblInvStatusResource1"></asp:Label>
            <div class="dataheader2">
                <asp:DataList ID="dlInvName" runat="server" class="w-100p" RepeatColumns="3" ItemStyle-Wrap="true"
                    RepeatDirection="Horizontal" meta:resourcekey="dlInvNameResource1" OnItemDataBound="dlInvName_ItemDataBound">
                    <ItemStyle Wrap="True"></ItemStyle>
                    <ItemTemplate>
                        <table class="w-100p searchPanel">
                            <tr>
                                <td class="v-top a-left h-20" style="border-style: solid; border-collapse: collapse;">
                                    <img src="../Images/bullet.png" alt="" align="middle" />
                                    &nbsp;
                                    <input id="lblInvestigationID" type="hidden" runat="server" value='<%# Eval("InvestigationID ")%>' />
                                    <input id="lblPatientStatus1" type="hidden" runat="server" value='<%# Eval("ReferredType ")%>' />
                                    <input id="lblType" type="hidden" runat="server" value='<%# Eval("Type ")%>' />
                                    <input id="btnInvName" type="button" runat="server" value='<%# Eval("InvestigationName")%>'
                                        class="a-center font11" style="background-color: Transparent; border-style: none;
                                        text-decoration: underline; cursor: pointer;" />
                                        <asp:Label ID="lblInvName1" runat="server" meta:resourcekey="lblInvName1Resource1"
                                            Text='<%# Eval("InvestigationName") %>' Visible="False"></asp:Label>
                                    <%--
                                    
                                     
                                     <input id="btnDeleteSample" runat="server" value="Delete" type="button" style="background-color: Transparent;
                                color: Blue; border-style: none; text-decoration: underline; cursor: pointer;
                                font-size: 11px;" onclick="onSampleDelete(this);" title="Click here to remove details" />&nbsp;
                                     
                                     
                                     
                                     --%>
                                        <input id="lbInvName" runat="server" type="hidden" value='<%# Eval("InvestigationName") %>'></input>
                                        <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusResource1" Style="display: none;"
                                            Text='<%# Eval("Status") %>'></asp:Label>
                                    <asp:Label ID="Label1" runat="server" meta:resourcekey="Label1Resource1"  Text="(" Style="background-color: Transparent;
                                        border-style: none;"></asp:Label>
                                    <asp:Label ID="lblStatusDisplayText" runat="server" meta:resourcekey="lblStatusDisplayTextResource1" Text='<%# Eval("DisplayStatus")%>'></asp:Label>
                                        <asp:Label ID="Label2" runat="server" meta:resourcekey="Label2Resource1" Text=")"></asp:Label>
                                        <asp:Label ID="lblPatientStatus" runat="server" meta:resourcekey="lblPatientStatusResource1"
                                            Style="font-size: 13px;"></asp:Label>
                                    <asp:Label ID="lblPackageName" runat="server" Text="" meta:resourcekey="lblPackageNameResource1"></asp:Label>
                                    <input id="isSpecialTest" runat="server" type="hidden" value='<%#Eval("RemarksID") %>' />
                                     <input type="button" id="BtnSpecimen" runat="server" style="color:Red;display:none;  font-size:10pt; font-weight:bold; text-decoration:underline; background-color:Transparent;"  value="Specimen" />
                                </td>
                                <td> 
                                
                                 
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
            </div>
            <div id="dvInvstigationDetails" style="display: block;">
                <asp:Panel ID="PanelGroup" runat="server" Style="height: 220px; width: 650px;" CssClass="modalPopup dataheaderPopup"
                    meta:resourcekey="PanelGroupResource1">
                    <asp:Panel ID="table_GroupItem" runat="server" Style="height: 180px; width: 650px;"
                        ScrollBars="Auto" meta:resourcekey="table_GroupItemResource1">
                        <table id="Group" class="a-center">
                            <tr>
                                <td>
                                    <asp:Label ID="Lbl_GroupName" runat="server" meta:resourcekey="Lbl_GroupNameResource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <table id="tblGroupHistory" class='dataheaderInvCtrl a-center w-100p f-11' nowrap='nowrap'
                            style='border: none'>
                            <tbody>
                                <tr class='dataheader1'>
                                    <th scope='col' class="a-left w-7p paddingL2">
                                        <%=Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_01 %>
                                    </th>
                                    <th scope='col' class="a-left w-55p paddingL5">
                                        <%=Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_02 %>
                                    </th>
                                    <th scope='col' class="a-left w-55p paddingL2">
                                        <%=Resources.CommonControls_ClientDisplay.CommonControls_OrderedSamples_ascx_03 %>
                                    </th>
                                </tr>
                                <tbody>
                        </table>
                    </asp:Panel>
                    <div id="Btn_Close">
                        <table class="a-center">
                            <tr>
                                <td class="a-center">
                                    <input id="Button2" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                        type="button" value="Close" onclick="return ClearPopUp1();" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:Panel>
                <ajc:ModalPopupExtender ID="ModalPopupShow" runat="server" BackgroundCssClass="modalBackground"
                    DropShadow="false" PopupControlID="PanelGroup" Enabled="True" TargetControlID="btnDummy">
                </ajc:ModalPopupExtender>
                <input type="button" id="btnDummy" runat="server" style="display: none;" />
            </div>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;
          <%-- <input type="button" id="btnspec" class="btn btn-primary" onclick="openModalJQ('mymodaldiag2', 'myModalclass2');" value="Specimen" style="color:Red;  font-size:10pt; font-weight:bold; text-decoration:underline; background-color:Transparent;" runat="server" />--%>
           <div id="mymodaldiag2" class="modalDiag paddingT100">
    <!-- modaldiag1 content --> 
             <div id="myModalclass2" class="w-75p" >
        <div class="modalDiag-header">
            <span class="bold w-100p"><span class="marginT5">Specimen Entry</span><span onclick="closeModdalDialog('mymodaldiag2', 'myModalclass2');" class="closeModalDiag pointer pull-right">X</span></span>
        </div>
        <div class="modalDiag-body">
                    <div id="divSpecimen">
                       <asp:Panel ID="pnlSpecimen" runat="server" CssClass="w-100p">
     
                          
                                <table class="w-100p">
                                    
                                    <tr>
                                        <td>
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <label for="txtSpecimen">Specimen</label>
                                                    </td>
                                                    <td class="margin0 padding0 a-left">
                                                      <input type="text" class="TxtEnterkeyPress" id="txtSpecimen1" />
                                                      <img src="../Images/starbutton.png" alt="" align="middle" />
                                                      <input type="hidden" id="hdnspecimenid" runat="server" />
                                                        <input type="hidden" id="hdnspecimenname" runat="server" />
                                                    </td>
                                                    <td class="margin0 padding0 a-left">
                                                               <label id='lblContainerCount' for="txtContainercount">Container Count</label>                                                   
                                                    </td>
                                                    <td class="a-left w-20p">                                                       
                                                       
                                                        <input type="text" class="TxtEnterkeyPress txtsmall w-20p" maxlength="2" id="txtContainercount" onkeypress="return ValidateOnlyNumeric(this);"  />                                                            
                                         <img src="../Images/starbutton.png" alt="" align="middle" />
                                                       

                                                    </td>
                                                    <td id='itSpecimenAurobic' >
                                                    <label style="font-weight:bold">No of Containers :</label>
                                                    <label id="lblTCCount" runat="server"></label>
                                                    </td>
                                                    <td class="a-left">
                                                     <input type="button" id="btnspecAdd" onclick="addspecimentabledetails1();" value="Add" class="btn" runat="server" />
                                                    </td>
                                                </tr>
                                                
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                 <div class="gridTable bounceinup marginT20" id="divspectab">
                            <div class="table-responsive">
                              <table class="w-100p gridView" id="TblSpecimen" style="display:none;">
                                  <thead>
                                        <tr>
                                            <th class="hide_Column">TestID</th>
                                            <th class="">TestName</th>
                                             <th class="hide_Column">TestType</th>
                                            <th class="hide_Column">SpecialSampleID</th>
                                            <th>Specimen</th>
                                            <th>Container Count</th>
                                            <th>Action</th>                                          
 
                                        </tr>
                                  </thead>
                                  <tbody>
                  
                                    </tbody>
                              </table>
                           </div>
                    </div>
                    <br /><br />
                    
                   
                    <div class="w-100p">
                    <div id="dvClinicalNotes" class="w-50p inline-block">
                        <label id="lblCnotes" style="vertical-align:top" runat="server">Clinical Notes</label>
                      <textarea name="textarea" id="txtClinicalNotes" style="height:50px; width:250px;" rows="80" cols="25"></textarea>
                    </div>
                    <div id="dvClinicalDiagnosys" class="w-49p inline-block">
                        <label id="lblcdiag" style="vertical-align:top" runat="server">Clinical Diagnosis</label>
                        <textarea name="textarea" id="txtClinicalDiag" style="height:50px;width:250px;" rows="80" cols="25"></textarea>
                    </div>
                      
                    <%-- <input type="text" maxlength="500" style=" vertical-align:text-top; height:80px; vertical-align :text-top" class="txtsmall w-30p" id="txtClinicalNotes" style="height:60px;vertical-align:top;" /> --%>
                     &nbsp;&nbsp;&nbsp;&nbsp;
                       
                     <%--<input type="text" maxlength="500" class="txtsmall w-30p" style=" vertical-align:text-top; height:80px; vertical-align:text-top" style="height:60px;vertical-align:top" id="txtClinicalDiag" /> --%>
                    </div>
                    <br /><br />
                                <div class="a-center">
                                 <input type="button" id="btncspeclear" value="Clear" class="btn" runat="server" onclick="btnspecclear();" />
                                                 <input type="button" id="btnspecSave" onclick="saveSpecimendetails1();" value="Save" class="btn" runat="server" />
                                    <%--   <input type="button" id="btnspecclose" value="Close" class="btn" runat="server" />--%>
                                         
                                    </div>
                         
                        </asp:Panel>
                  <%--   <ajc:ModalPopupExtender ID="MPESpecimen" runat="server" BackgroundCssClass="modalBackground"
                            DropShadow="false" PopupControlID="pnlSpecimen" CancelControlID="btnspecclose" TargetControlID="btncspeclear"
                            Enabled="True">
                        </ajc:ModalPopupExtender>--%>
                        
                    </div>
                    
                     </div>
    </div>
    </div>
        </td>
    </tr>
      <asp:HiddenField ID="HdnIsFlagActive" runat="server" />
      <asp:HiddenField ID="hdnPatientStatus" runat="server" />
      <input type="hidden" runat="server" value="N" id="hdnIsSpecialTest" />
      <asp:HiddenField ID="hdnSpecimenValues" runat="server" />
</table>
<script type="text/javascript">
    var SpecFeeID;
    var SpecFeeName;
    var SpecFeetype;

    $(function() {
    
        var arr = [];
    });


    function Specimenautocomplete() {
        $("[id*='txtSpecimen1']").autocomplete({

            source: function(request, response) {
                $.ajax({
                    type: "Post",
                    contentType: "application/json;charser=utf-8",
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
                            $("[id*=hdnspecimenid]").val("");
                            $("[id*=hdnspecimenname]").val("");
                            // Clear();
                        }
                    }
                    ,
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
                    $("[id*=hdnspecimenid]").val("");
                    $("[id*=hdnspecimenname]").val("");
                }
                else {
                    $("[id*=hdnspecimenid]").val(i.item.val);
                    $("[id*=hdnspecimenname]").val(i.item.label);

                }
            },
            minLength: 2

        });

    }

    function CallSpecimenValues(ID, Type, Name) {

        SpecFeeID = ID;
        SpecFeeName = Name;
        SpecFeetype = Type;
        //closeModdalDialog('mymodaldiag2', 'myModalclass2');
        openModalJQ('mymodaldiag2', 'myModalclass2');
        event.preventDefault();
       
    }



    //var modalClassdiag = document.getElementById('mymodaldiag1');
    var arrModalDiag = ["mymodaldiag1", "mymodaldiag2"];
    var arrModalDiagClass = ["myModalclass1", "myModalclass2"];
    function openModalJQ(modalId, modalClassID) {
        var modaldiag = modalId;
        var modalClassdiag = modalClassID;
        $('#' + modalClassdiag).removeClass("modalDiag-content1");
        $('#' + modalClassdiag).addClass("modalDiag-content");
        $('#' + modaldiag).removeClass("hide").addClass("modalDiag show");

       GetLastSpecimenvalue();
        var lastSepcimentvalues = sessionStorage.getItem('hdnSpecimendetails');
        if (lastSepcimentvalues != '' && lastSepcimentvalues != null) {
            $('[id$="OrderedSamples1_hdnSpecimenValues"]').val(lastSepcimentvalues);
            GetSpecimenTable();
        }
    }
    function closeModdalDialog(modalId, modalClassID) {
        //  if ($('#billPart_btnspecAdd').val() == 'Add' && $("#billPart_hdnSpecimenValues").val() != "") {
        var txt = $('[id$="billPart_hdnSpecimenValues"]').val();
        var flag = 0;
        if (txt != '' && txt != null) {

            var row = txt.split('~');
            $.each(row, function(id, column) {
                var cols = column.split(',');
                var obj = {};
                if (cols != '') {
                    if (cols[0] == SpecFeeID) {
                        flag = 1

                    }
                }
            });
        }
        else { flag = 0; }


        //  if (flag == 1) {
        var modaldiag = modalId;
        var modalClassdiag = modalClassID;
        $('#' + modalClassdiag).addClass("modalDiag-content1");
        // btnspecsaveclear();
        setTimeout(function() {
            $('#' + modaldiag).removeClass("show").addClass("hide");
        }, 700);
        //} 
    }
    document.addEventListener('click', function(e) {
        //alert(e.target.id);
        for (i = 0; i < arrModalDiag.length; i++) {
            if (e.target.id == arrModalDiag[i]) {
                modalPopupHide(i);
            }
        }
    });
    $('body').keydown(function(evt) {
        if (evt.keyCode === 27) {
            for (i = 0; i < arrModalDiagClass.length; i++) {
                if ($('#' + arrModalDiagClass[i]).hasClass("modalDiag-content")) {
                    modalPopupHide(i);
                }
            }
        }
    });
    function modalPopupHide(i) {
        if ($('#billPart_btnspecAdd').val() != 'Update') {
            if ($("#billPart_hdnSpecimenValues").val() != "") {
                btnspecsaveclear();
                var temp = i;
                $('#' + arrModalDiagClass[i]).removeClass("modalDiag-content").addClass("modalDiag-content1");
                setTimeout(function() {
                    $('#' + arrModalDiag[i]).removeClass("show").addClass("hide");
                }, 700);
                //alert();
                sleep(1000);
            }
        }
    }



    function addspecimentabledetails1() {
        $('#divspectab').show();
        var Speccount = 0;
        var SpecisExists = 0;
        var SpecialSampleID;
        var SpecimenName;
        var SampleCount;
        var TestID = 0;
        var TestName;
        var TestType;
        var TTable = null;
        $('#lblTCCount').html('0');

        SpecialSampleID = $("[id*=hdnspecimenid]").val();
        SpecimenName =  $("[id*=hdnspecimenname]").val();
        SampleCount = $("[id*=txtContainercount]").val(); 
        TestID = SpecFeeID;
        TestName = SpecFeeName;
        TestType = SpecFeetype;


        if (SpecialSampleID <= 0) {
            alert('please choose specimen!');
            $('#txtSpecimen').val('');
            return false;
        }

        if (SampleCount <= 0) {
            alert('please enter specimen count!');
            $('#txtContainercount').val('');
            return false;
        }

        if ($(this).attr('value') == 'Update') {
            $.each(arr, function(id, val) {

                if (val.SpecialSampleID == SpecialSampleID) {
                    arr[id].SpecimenName = SpecimenName;
                    arr[id].SampleCount = SampleCount;
                }

            });

            $.each(arr, function(id, val) {

                Speccount = parseInt(Speccount) + parseInt(val.SampleCount);

            });
            $('#billPart_lblTCCount').html(Speccount);
        }

        else {

            $.each(arr, function(id, val) {

                if (SpecisExists == 0 && SpecialSampleID == val.SpecialSampleID) {
                    SpecisExists = 1;
                }
                Speccount = parseInt(Speccount) + parseInt(val.SampleCount);

            });

            if (SpecisExists == 1) {
                alert('Specimen Already Exist!');
                $("[id*=hdnspecimenid]").val();
                $("[id*=hdnspecimenname]").val();
                $("[id*=txtContainercount]").val();
                $("[id*=txtSpecimen]").val();
                
               
                return false;
            }

            else if (SpecisExists == 0) {

                arr.push(
        {
            TestID: TestID,
            TestName: TestName,
            TestType: TestType,
            SpecialSampleID: SpecialSampleID,
            SpecimenName: SpecimenName,
            SampleCount: SampleCount
        });

                Speccount = parseInt(Speccount) + parseInt(SampleCount);

            }
            $('#lblTCCount').html(Speccount);
        }

        $('#TblSpecimen').show();



        TTable = $('#TblSpecimen').dataTable({
            paging: false,
            "searching": false,
            "Info": false,
            "paging": false,
            "ordering": false,
            "info": false,
            data: arr,
            "bDestroy": true,
            "fnDrawCallback": function() {
                $('.deleteIcons').click(function() {
                    var id = $(this).attr('SpecialSampleID');
                    var row = $(this).closest("tr").get(0);
                    TTable.fnDeleteRow(TTable.fnGetPosition(row));
                    arr = $.grep(arr, function(ind, val) {
                        return ind.SpecialSampleID != id;

                    });
                    Speccount = 0;
                    $.each(arr, function(id, val) {

                        Speccount = parseInt(Speccount) + parseInt(val.SampleCount);

                    });
                    $('#lblTCCount').html(Speccount);
                })

                $('.EditIcons').click(function() {
                $('[id*="btnspecAdd"]').attr('value', 'Update');
                    $("[id*=hdnspecimenid]").val($(this).attr('SpecialSampleID'));
                    $("[id*=hdnspecimenname]").val($(this).attr('SpecimenName'));
                    $("[id*=txtContainercount]").val($(this).attr('SampleCount'));
                    $("[id*=txtSpecimen]").val($(this).attr('SpecimenName'));
                    var id = $(this).attr('SpecialSampleID');
                    var row = $(this).closest("tr").get(0);
                    TTable.fnDeleteRow(TTable.fnGetPosition(row));
                    arr = $.grep(arr, function(ind, val) {
                        return ind.SpecialSampleID != id;

                    });
                })
            },
            columns: [
        { 'data': 'TestID',
            "sClass": "hide_Column"

        },
          { 'data': 'TestName', "sClass": "alignCenter" },
           { 'data': 'TestType',
               "sClass": "hide_Column"

           },

                                            { 'data': 'SpecialSampleID',
                                                "sClass": "hide_Column"

                                            },
                                            { 'data': 'SpecimenName', "sClass": "alignCenter" },
                                             { 'data': 'SampleCount', "sClass": "alignCenter" },

                                            {

                                                "mRender": function(data, type, full, meta) {

                                                    var txt = '<input TestID="' + full.TestID + '" TestName="' + full.TestName + '" TestType="' + full.TestType + '" SampleCount="' + full.SampleCount + '" SpecimenName="' + full.SpecimenName + '" SpecialSampleID="' + full.SpecialSampleID + '" type="button" class="EditIcons alignCenter" value ="Edit" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer" >';
                                                    txt = txt + '<label size="5"> / </label>';
                                                    txt = txt + '<input TestID="' + full.TestID + '" SpecialSampleID= "' + full.SpecialSampleID + '" type="button" class="deleteIcons alignCenter" value ="Delete" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer" >';
                                                    return txt;
                                                }

}]
        });

        $("[id*=hdnspecimenid]").val('');
        $("[id*=hdnspecimenname]").val('');
        $("[id*=txtContainercount]").val('');
        $("[id*=txtSpecimen]").val('');
        
       
        $('[id*="btnspecAdd"]').attr('value', 'Add');

    }

    var Specarray = [];
    var Specheaders = [];
    function saveSpecimendetails1() {


        var table = $('#TblSpecimen').DataTable();
        var FeeID = 0;
        var Feetype = '';
        var Isspecialtest = '';
        ////Isspecialtest = $("#billPart_hdnIsSpecialTest").val();

        if ($('#OrderedSamples1_btnspecAdd').val() == 'Add') {

            if (!table.data().count()) {
                alert('Empty specimen details cannot be save!');
                table.destroy();
                $('#TblSpecimen').hide();
                return false;
            }
            $('#TblSpecimen').show();
            var ClinicalNotes = $('#txtClinicalNotes').val();
            var ClinicalDiag = $('#txtClinicalDiag').val();

            $('#TblSpecimen th').each(function(index, item) {
                Specheaders[index] = $(item).html().split(" ").join("");
            });
            Specheaders[6] = 'ClinicalNotes';
            Specheaders[7] = 'ClinicalDiagnosis';

            var lstItem = '';
            $('#TblSpecimen tr').has('td').each(function() {
                var arrayItem = {};
                var text = '';
                $('td', $(this)).each(function(index, item) {
                    if (index <= 5) {
                        arrayItem[Specheaders[index]] = $(item).html();
                        text = text + ',' + $(item).html();
                    }
                });
                arrayItem[Specheaders[6]] = ClinicalNotes;
                arrayItem[Specheaders[7]] = ClinicalDiag;

                if (ClinicalNotes != '') {
                    text = text + ',' + ClinicalNotes;
                }
                if (ClinicalDiag != '') {
                    text = text + ',' + ClinicalDiag;
                }


                Specarray.push(arrayItem);
                lstItem = lstItem + text.substring(1, text.length) + '~';
            });
            lstItem = lstItem.substring(0, lstItem.length - 1);
            // $("#billPart_hdnSpecimenValues").val(lstItem);
            $('#OrderedSamples1_btnspecclose').click();
            // SpecFeeID = '';
            // SpecFeetype = '';
            AddSpecimenDetails();
            if (Specarray != '') {
                InsertHistoSpecimenDetails();
                alert('Saved Sucessfully!');
                closeModdalDialog('mymodaldiag2', 'myModalclass2');
            }
            Specarray = [];
            btnspecsaveclear();
            return false;
        }
        else {
            alert('Please update the specimen details!');
            return false;
        }
    }


    function AddSpecimenDetails() {
        var isEmpty = hasEmptyValues(Specarray);
        var SpecValue = '';
        if (isEmpty == true) {

            var totalList = GetSpecimenList();

            $.each(totalList, function(id, val) {

                SpecValue += val.TestID + ',' + val.TestName + ',' + val.TestType + ',' + val.SpecialSampleID + ',' + val.Specimen + ',' + val.ContainerCount + ',' + val.ClinicalNotes + ',' + val.ClinicalDiagnosis + '~';

            });

            SpecValue = SpecValue.substring(0, SpecValue.length - 1);
            if ($("#OrderedSamples1_hdnSpecimenValues").val() == '') {
                $("#OrderedSamples1_hdnSpecimenValues").val(SpecValue);
            }
            else {
                document.getElementById('OrderedSamples1_hdnSpecimenValues').value = SpecValue;

            }

        }
        return false;
    }

    function hasEmptyValues(ary) {
        var l = ary.length,
        i = 0;

        if (l == 0) {
            return false;
        }

        return true;
    }

    function GetSpecimenTable() {
       // GetLastSpecimenvalue();
        var txt = $('[id$="OrderedSamples1_hdnSpecimenValues"]').val();
        var arr1 = [];
        if (txt != '') {
            var row = txt.split('~');
            $.each(row, function(id, column) {
                var col = column.split(',');
                var obj = {};
                if (col != '') {
                    obj.TestID = col[0];
                    obj.TestName = col[1];
                    obj.TestType = col[2];
                    obj.SpecialSampleID = col[3];
                    obj.SpecimenName = col[4];
                    obj.SampleCount = col[5];
                    obj.ClinicalNotes = col[6];
                    obj.ClinicalDiagnosis = col[7];
                    arr1.push(obj);
                }
            });
        }
        loadTable(arr1);

    }

    function loadTable(arr1) {

if (arr1.length > 0){
        $('#TblSpecimen').show();


        arr = arr1;
        TTable = $('#TblSpecimen').dataTable({
            paging: false,
            "searching": false,
            "Info": false,
            "paging": false,
            "ordering": false,
            "info": false,
            data: arr,
            "bDestroy": true,
            "fnDrawCallback": function() {
                $('.deleteIcons').click(function() {
                    var id = $(this).attr('SpecialSampleID');
                    var row = $(this).closest("tr").get(0);
                    TTable.fnDeleteRow(TTable.fnGetPosition(row));
                    arr = $.grep(arr, function(ind, val) {
                        return ind.SpecialSampleID != id;

                    });
                    Speccount = 0;
                    $.each(arr, function(id, val) {

                        Speccount = parseInt(Speccount) + parseInt(val.SampleCount);

                    });
                    $('#lblTCCount').html(Speccount);
                })

                $('.EditIcons').click(function() {
                    $('[id*="btnspecAdd"]').attr('value', 'Update');
                    $("[id*=hdnspecimenid]").val($(this).attr('SpecialSampleID'));
                    $("[id*=hdnspecimenname]").val($(this).attr('SpecimenName'));
                    $("[id*=txtContainercount]").val($(this).attr('SampleCount'));
                    $("[id*=txtSpecimen]").val($(this).attr('SpecimenName'));
                    var id = $(this).attr('SpecialSampleID');
                    var row = $(this).closest("tr").get(0);
                    TTable.fnDeleteRow(TTable.fnGetPosition(row));
                    arr = $.grep(arr, function(ind, val) {
                        return ind.SpecialSampleID != id;

                    });
                })
            },
            columns: [
        { 'data': 'TestID',
            "sClass": "hide_Column"

        },
          { 'data': 'TestName', "sClass": "alignCenter" },
           { 'data': 'TestType',
               "sClass": "hide_Column"

           },

                                            { 'data': 'SpecialSampleID',
                                                "sClass": "hide_Column"

                                            },
                                            { 'data': 'SpecimenName', "sClass": "alignCenter" },
                                             { 'data': 'SampleCount', "sClass": "alignCenter" },

                                            {

                                                "mRender": function(data, type, full, meta) {

                                                    var txt = '<input TestID="' + full.TestID + '" TestName="' + full.TestName + '" TestType="' + full.TestType + '" SampleCount="' + full.SampleCount + '" SpecimenName="' + full.SpecimenName + '" SpecialSampleID="' + full.SpecialSampleID + '" type="button" class="EditIcons alignCenter" value ="Edit" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer" >';
                                                    txt = txt + '<label size="5"> / </label>';
                                                    txt = txt + '<input TestID="' + full.TestID + '" SpecialSampleID= "' + full.SpecialSampleID + '" type="button" class="deleteIcons alignCenter" value ="Delete" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer" >';
                                                    return txt;
                                                }

}]
});

if (arr != null) {
    $("[id*='txtClinicalNotes']").val(arr[0].ClinicalNotes);

    $("[id*='txtClinicalDiag']").val(arr[0].ClinicalDiagnosis);
}
}
else{
$('#TblSpecimen tbody').empty();
 $("[id*='txtClinicalNotes']").val('');

    $("[id*='txtClinicalDiag']").val('');
arr=[];

}
    }

    function GetSpecimenList() {
        var txt = $('[id$="OrderedSamples1_hdnSpecimenValues"]').val();
        var arr = [];

        if (txt != '') {
            var TCode = Specarray[0].TestID;
            var row = txt.split('~');
            $.each(row, function(id, column) {
                var cols = column.split(',');
                var obj = {};
                if (cols != '') {
                    if (cols[0] != TCode) {
                        obj.TestID = cols[0];
                        obj.TestName = cols[1];
                        obj.TestType = cols[2];
                        obj.SpecialSampleID = cols[3];
                        obj.Specimen = cols[4];
                        obj.ContainerCount = cols[5];
                        obj.ClinicalNotes = cols[6];
                        obj.ClinicalDiagnosis = cols[7];
                        arr.push(obj);
                    }
                }
            });

            $.each(Specarray, function(id, val) {
                arr.push(val);
            });

        }
        else {
            arr = Specarray;

        }
        return arr;
    }

    function InsertHistoSpecimenDetails() {
        var HistoList=[];
        var orgid1=$("[id*='hdorgid']").val();
        var orgaddressid1=$("[id*='hdnorgaddressid']").val();
        if ($('[id$="OrderedSamples1_hdnSpecimenValues"]').val() != '') {
            var val = $('[id*="OrderedSamples1_hdnSpecimenValues"]').val();
            $('[id*="hdnSpecimendetails"]').val(val);

            if (val != null) {
                sessionStorage.setItem('hdnSpecimendetails', val);
            }
            
            var lst = val.split('~');
            var visitid = $("[id*='hdnVisitID']").val();
            if (lst != '') {
            
            $.each(lst, function(id, value) {
            var items = value.split(',');
            if (items != '') {
                var obj = {};
                    obj.ID = items[0];
                    obj.PatientVisitID = visitid;
                    obj.Type = items[2];
                    obj.SampleID = items[3];
                    obj.SampleName = items[4];
                    obj.SampleCount = items[5];
                    obj.ClinicalNotes = items[6];
                    obj.ClinicalDiagnosis = items[7];
                    HistoList.push(obj);
                }
            });
            }
        }
        if (HistoList.length > 0) {
            $.ajax({
                type: "POST",
                url: '../OPIPBilling.asmx/InsertHistoSpecimenDetails',
                data: JSON.stringify({ 'OrgID': orgid1, 'OrgAddressID': orgaddressid1, 'lstspec': HistoList }),
                contentType: "application/json;charser=utf-8",
                dataType: "json",
                success: function(Result) {
                    if (Result.d > 0) {
                        //  alert('rgr');

                        ValidationWindow("Saved Successfully !! ", "Alert");

                        $("[id*=BTNCheck]").click();
                       // window.location.reload()

                    }

                },

                error: function(Result) {

                    alert("Error");

                }


            });
        }
    }


    function GetLastSpecimenvalue() {

        $.ajax({
            type: "POST",
            url: '../OPIPBilling.asmx/GetHistoSpecimenDetails',
            data: JSON.stringify({ 'OrgID': $("[id*='hdorgid']").val(), 'PatientVisitID': $("[id*='hdnVisitID']").val(), 'TestID': SpecFeeID, 'Type': SpecFeetype }),
            contentType: "application/json;charser=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var data1 = data.d;
                var arr = [];
                $.each(data1, function(id, column) {

                    var obj = {};
                    if (column != '') {

                        obj.TestID = column.ID;
                        obj.TestName = SpecFeeName;
                        obj.TestType = column.Type;
                        obj.SpecialSampleID = column.SampleID;
                        obj.SpecimenName = column.SampleName;
                        obj.SampleCount = column.SampleCount;
                        obj.ClinicalNotes = column.ClinicalNotes;
                        obj.ClinicalDiagnosis = column.ClinicalDiagnosis;
                        arr.push(obj);

                    }
                });
               // if (arr.length > 0) {
                    loadTable(arr);
               // }



            },
            error: function(e) {

                alert("Error");

            }
        });
        
       
    }
    
 </script>   
    