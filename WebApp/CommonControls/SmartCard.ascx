<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SmartCard.ascx.cs" Inherits="CommonControls_SmartCard" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<ajc:ModalPopupExtender ID="mpeSmartCard" runat="server" TargetControlID="btnDummy"
    PopupControlID="pnlSmartCard" BackgroundCssClass="modalBackground" DynamicServicePath=""
    Enabled="True" />
<input type="button" id="btnDummy" runat="server" style="display: none;" />
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <triggers>
        <asp:PostBackTrigger ControlID="btnUctlFinish" />
    </triggers>
    <contenttemplate>
        <table>
            <tr id="rowIssueSmartCard" visible="False" runat="server">
                <td runat="server">
                    &nbsp;<asp:CheckBox ID="chkIssueSmartCard" Text="Issue Smart Card" runat="server" />
                  &nbsp;</td>
                    <td>
                    <asp:Label ID="lblSmardNO" runat="server" Text="" Style="font-weight:bold;"  ></asp:Label> 
                    </td>
                    
                     <td id="tdReissue" style="display:none;">
                     <asp:CheckBox ID="chkRe_Issue" Text="Re-Issue Smart Card" runat="server" /></td>
                  
            </tr>
            <tr id="rowReIssueSmartCard" visible="False" runat="server">
                <td runat="server">
                <table>
                <tr>
                <td><asp:CheckBox ID="chkReIssueSmartCard" Text="Re-Issue Smart Card" runat="server" /></td>
                <td>
                    <asp:DropDownList ID="ddlReIssueReason" runat="server">
                    <asp:ListItem Text="Select a reason" Value="0" />
                    <asp:ListItem Text="Card Lost" Value="1" />
                    <asp:ListItem Text="Card Damaged" Value="2" />
                    <asp:ListItem Text="Other" Value="3" />
                    </asp:DropDownList>
                </td>
                </tr>
                </table>
                </td>
            </tr>
            <tr id="rowUpdateSmartCardNo" visible="False" runat="server">
                <td runat="server">
                    &nbsp;<asp:CheckBox ID="chkUpdateSmartCardNo" Text="Update Smart Card No" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
        </table>
        <asp:Panel ID="pnlSmartCard" Width="300px" runat="server" CssClass="modalPopup dataheaderPopup"
            Style="display: block" meta:resourcekey="pnlSmartCardResource1">
            <table id ="tblID" visible="false" runat="server" class="w-100p"><tr><td>
            <div id="divIDCard" visible="false" runat ="server">
                <asp:Label ID ="lblIDTable" Text="" runat ="server"></asp:Label>
            </div>
            <br />
            <br />
            </td></tr>
            <tr><td class="a-center">
            <asp:Button ID="btnIDPrint" Text ="Print" runat ="server" />&nbsp;
            <asp:Button id="btnIDCancel" runat="server" 
                                              Text="Cancel" 
                                            OnClick="btnCancel_Click" /></td></tr></table>
            <div id="divSmartCard" style ="display :block" runat ="server">
            <div id="divSCDetail" runat="server">
                <table id="tblSmartCard" style="font-family:Arial;" class="font10">
                    <tr>
                        <td>
                            <asp:Label ID="lblPatientName" runat="server" Font-Bold="True" 
                                meta:resourcekey="lblPatientNameResource1" />
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblNo" runat="server" Text="Member ID: " 
                                meta:resourcekey="lblNoResource1" />
                            <asp:Label ID="lblPatientNumber" runat="server" 
                                meta:resourcekey="lblPatientNumberResource1" />
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                           <asp:Label ID="lblDOB" runat="server" meta:resourcekey="lblDOBResource1" /> 
                            <asp:Label ID="lblPatientSex" runat="server" 
                                meta:resourcekey="lblPatientSexResource1" />
                        </td>
                        <td>
                            
                        </td>
                    </tr>
                    <tr>
                    <td><asp:Label ID="lblArea" runat="server" meta:resourcekey="lblAreaResource1" />
                    </td><td></td>
                    </tr>
                    <tr>
                    <td><asp:Label ID="lblIssuedOn" runat="server" 
                            meta:resourcekey="lblIssuedOnResource1" />
                    </td><td></td>
                    </tr>
                </table>
            </div>
            <br />
            <div id="div1" runat="server" style="display: none;">
                <table style="border: solid thin black;">
                    <tr>
                        <td class="a-center">
                            <asp:Label ID="Label1" Text="Please verify & swipe the printed SmartCard over Card Reader while the cursor is in the below textbox"
                                runat="server" meta:resourcekey="LabelResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center">
                            <asp:Label ID="Label2" runat="server" Text="SmartCard No." 
                                meta:resourcekey="lblScNoResource1" />
                            <asp:TextBox ID="TextBox1" runat="server" meta:resourcekey="txtScNoResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center">
                                <asp:Label ID="Label3" runat="server" 
                                Text="Is Smart Card Issued to Patient" 
                                meta:resourcekey="lblIsCardIssuedResource1" />
                            <asp:RadioButton ID="RadioButton1" runat="server" GroupName="rdogrp" Text="Yes" 
                                meta:resourcekey="rdoYesResource1" />
                            <asp:RadioButton ID="RadioButton2" runat="server" GroupName="rdogrp" Text="No" 
                                meta:resourcekey="rdoNoResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center">
                            <table>
                                <tr>
                                    <td class="a-center">
                                        <asp:Button id="Button3" Enabled="False" runat="server" 
                                              Text="Finish" CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                            OnClick="btnFinish_Click" meta:resourcekey="btnUctlFinishResource1"  />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
            <table id="tblPrint" runat="server">
                <tr runat="server">
                    <td runat="server">
                        <input id="btnPrint" type="button" value="Print Smart Card" runat="server" />
                    </td>
                    <td runat="server">
                         <asp:Button id="btnCancel" runat="server" 
                                              Text="Cancel" 
                                            OnClick="btnCancel_Click" />
                    </td>
                </tr>
            </table>
            <br />
            <div id="divScNo" runat="server" style="display: none;">
                <table style="border: solid thin black;">
                    <tr>
                        <td class="a-center">
                            <asp:Label Text="Please verify & swipe the printed SmartCard over Card Reader while the cursor is in the below textbox"
                                runat="server" meta:resourcekey="LabelResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center">
                            <asp:Label ID="lblScNo" runat="server" Text="SmartCard No." 
                                meta:resourcekey="lblScNoResource1" />
                            <asp:TextBox ID="txtScNo" runat="server" meta:resourcekey="txtScNoResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center">
                                <asp:Label ID="lblIsCardIssued" runat="server" 
                                Text="Is Smart Card Issued to Patient" 
                                meta:resourcekey="lblIsCardIssuedResource1" />
                            <asp:RadioButton ID="rdoYes" runat="server" GroupName="rdogrp" Text="Yes" 
                                meta:resourcekey="rdoYesResource1" />
                            <asp:RadioButton ID="rdoNo" runat="server" GroupName="rdogrp" Text="No" 
                                meta:resourcekey="rdoNoResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center">
                            <table>
                                <tr>
                                    <td class="a-center">
                                        <asp:Button id="btnUctlFinish" Enabled="False" runat="server" 
                                              Text="Finish" CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                            OnClick="btnFinish_Click" meta:resourcekey="btnUctlFinishResource1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
            </div>
            <asp:HiddenField ID="hdnURL" runat="server" />
            <asp:HiddenField ID="hdnPatientID" runat="server" />
            <asp:HiddenField ID="hdnSmartCardPrintConfig" runat="server" />
        </asp:Panel>
        
    </contenttemplate>
</asp:UpdatePanel>

<script type="text/javascript">

    function ShowSmartCardPopup() {
        $find('<%= mpeSmartCard.ClientID %>').show();
    }


    function ClientSidePrint(idDiv, idBtnPrint) {

        var w = 80;
        var h = 140;
        var l = (window.screen.availWidth - w) / 2;
        var t = (window.screen.availHeight - h) / 2;

        var sOption = "toolbar=no,location=no,directories=no,menubar=no,scrollbars=yes,width=" + w + ",height=" + h + ",left=" + l + ",top=" + t;
        document.getElementById(idBtnPrint).value = 'Re-Print Smart Card';
        document.getElementById('<%= divScNo.ClientID %>').style.display = 'block';
        document.getElementById('<%= txtScNo.ClientID %>').focus();
        var sDivText = window.document.getElementById(idDiv).innerHTML;
        var objWindow = window.open("", "Print", sOption);
        objWindow.document.write(sDivText);
        objWindow.document.close();
        objWindow.print();
        objWindow.close();
    }
    function PrintIDCard(idDiv, idBtnPrint) {

        var w = 80;
        var h = 140;
        var l = (window.screen.availWidth - w) / 2;
        var t = (window.screen.availHeight - h) / 2;

        var sOption = "toolbar=no,location=no,directories=no,menubar=no,scrollbars=yes,width=" + w + ",height=" + h + ",left=" + l + ",top=" + t;
        var sDivText = window.document.getElementById(idDiv).innerHTML;
        var objWindow = window.open("", "Print", sOption);
        objWindow.document.write(sDivText);
        objWindow.document.close();
        objWindow.print();
        objWindow.close();
        
    }


    var continouskey = 0;
    function ValidateSmartCardNo(e) {

        if (e.keyCode == 17) {
            continouskey = 1;
            return true;
        }

        if (e.keyCode == 9) {
            continouskey = 0;
            return true;
        }
        if (continouskey == 1) {
            if (e.keyCode == 86 || e.keyCode == 118) {

                document.getElementById('<%= btnUctlFinish.ClientID %>').disabled = false;
                continouskey = 0;
                return true;
            }
            else {
                continouskey = 0;
                document.getElementById('<%= txtScNo.ClientID %>').value = "";
                return false;
            }
        }
        else {
            continouskey = 0;
            document.getElementById('<%= txtScNo.ClientID %>').value = "";
            return false;
        }


    }
    function ClearSmartCardNo(txtid) {
        document.getElementById(txtid).value = "";

    }

    function ValidateYes(id) {

        if (document.getElementById(id).checked == true) {

            document.getElementById('<%= btnUctlFinish.ClientID %>').disabled = false;
            document.getElementById('<%= txtScNo.ClientID %>').disabled = false;
        }

    }

    function ValidateNo(id) {

        if (document.getElementById(id).checked == true) {

            document.getElementById('<%= btnUctlFinish.ClientID %>').disabled = false;
            document.getElementById('<%= txtScNo.ClientID %>').disabled = true;
            document.getElementById('<%= txtScNo.ClientID %>').value = ""
        }

    }
    
    function CheckSCNoExists() {

        if (document.getElementById('<%= txtScNo.ClientID %>').value == "") {
            document.getElementById('<%= btnUctlFinish.ClientID %>').disabled = true;
            return false;
        }
        if (document.getElementById('<%= txtScNo.ClientID %>').length != "") {
            document.getElementById('<%= btnUctlFinish.ClientID %>').disabled = false;
            return true;
        } else {
        document.getElementById('<%= btnUctlFinish.ClientID %>').disabled = true;
            return false;
        }
      }


function ValidateSmartCardRdo() {
    if (document.getElementById('<%= rdoYes.ClientID %>').checked == false && document.getElementById('<%= rdoNo.ClientID %>').checked == false) {
        var userMsg = SListForApplicationMessages.Get('CommonControls\\SmartCard.ascx_1');
        if (userMsg != null) {
            alert(userMsg);
        } else {
            alert('Check whether Smart Card issued to Patient');
        }
        document.getElementById('<%= rdoYes.ClientID %>').focus();
           return false;
       }
       return true;
   }
   function SetSmartNo(SmartNo) {
       var AutoSelectSmartCard;
       AutoSelectSmartCard = document.getElementById('<%= hdnSmartCardPrintConfig.ClientID %>').value;
       if (SmartNo != "") {
           document.getElementById('<%= lblSmardNO.ClientID %>').innerHTML = " Smard Card no : " + SmartNo;
           document.getElementById('<%= chkIssueSmartCard.ClientID %>').checked = true;
           document.getElementById('<%= chkIssueSmartCard.ClientID %>').disabled = true;
           document.getElementById('<%= tdReissue.ClientID %>').style.display = "block";
       }
       else {
           document.getElementById('<%= lblSmardNO.ClientID %>').innerHTML = SmartNo;
           document.getElementById('<%= chkIssueSmartCard.ClientID %>').checked = false;
           document.getElementById('<%= chkIssueSmartCard.ClientID %>').disabled = false;
           document.getElementById('<%= tdReissue.ClientID %>').style.display = "none"
       }
       if (AutoSelectSmartCard == "Y") {
           document.getElementById('<%= chkIssueSmartCard.ClientID %>').checked = true;
       }
   }
   
</script>

