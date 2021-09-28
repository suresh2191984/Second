<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReferralLetter.aspx.cs" Inherits="Referrals_ReferralLetter" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Src="~/CommonControls/ConsultingName.ascx" TagName="consulting" TagPrefix="uc7" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/ReferralTemplate.ascx" TagName="ReferralTemplate"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/FitnessTemplate.ascx" TagName="FitnessTemplate"
    TagPrefix="uc8" %>
    <%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function confirmRedirect() {
            if (window.confirm('Are you sure?') == true) {
                __doPostBack('RedirectConfirmationPostBack', '');
            }
        }
        function FCKeditor_OnComplete(editorInstance) {
             
            editorInstance.Events.AttachEvent('OnFocus', FCKeditor_OnFocus);
            editorInstance.Events.AttachEvent('OnBlur', FCKeditor_OnBlur);           
            
        }
        function FCKeditor_OnFocus(editorInstance) {
             editorInstance.EditorDocument.body.style.cssText += 'background-color:#fff;';           
            
        }
        function FCKeditor_OnBlur(editorInstance) {
            editorInstance.EditorDocument.body.style.cssText += 'background-color:#fff;';        
           
          
           
        }

    

        function pValidationReferrals() {
            if (document.getElementById("RefID").value == '') {

                alert('Select a Referral to proceed');
                return false;
            }
        }

        function PrintReferral(pageSrc) {
            document.getElementById('trReferralTemplate').style.display = 'block';

            var prtContent = document.getElementById('trReferralTemplate');

            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0,Addressbar=no');
            //alert(WinPrint);
            //var WinPrint = window.open('', '', 'letf=0,top=0,width=900,height=900,toolbar=0,scrollbars=0,status=0,Addressbar=no');
            WinPrint.document.write(prtContent.innerHTML);

            WinPrint.document.close();

            WinPrint.focus();

            WinPrint.print();
            document.getElementById('trReferralTemplate').style.display = 'none';

            WinPrint.close();
            if (pageSrc != '') {
                window.location.href = pageSrc;
            }
        }


        function PrintFitness(PageID) {
            //alert(PageID);
            document.getElementById('trPrintFitness').style.display = 'block';

            var prtContent = document.getElementById('trPrintFitness');

            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0,Addressbar=no');
            //alert(WinPrint);
            //var WinPrint = window.open('', '', 'letf=0,top=0,width=900,height=900,toolbar=0,scrollbars=0,status=0,Addressbar=no');
            WinPrint.document.write(prtContent.innerHTML);

            WinPrint.document.close();

            WinPrint.focus();

            WinPrint.print();
            document.getElementById('trPrintFitness').style.display = 'none';

            WinPrint.close();
            if (PageID != '') {
                window.location.href = PageID;

            }
        }


        function showFCKRefLetter() {
            if (document.getElementById('ddlReferralphysician').value == 0) {
                document.getElementById('divFckRefLetter').style.display = 'none';
                return false;
            }
            else {
                document.getElementById('divFckRefLetter').style.display = 'block';
                return true;
            }

        }

        function avoiddoubleentry() {

            var TemplateType = document.getElementById("ddlTemplateType").options[document.getElementById("ddlTemplateType").selectedIndex].text;

            if (TemplateType == "Referral") {
                if (document.getElementById('ddlReferingOrg').value.trim() == 0) {
                    document.getElementById('ddlReferingOrg').focus();
                alert('Provide the Organization referred to ');
                    return false;
                }


                if (document.getElementById('ddlSpeciality').value.trim() == 0) {
                    document.getElementById('ddlSpeciality').focus();
                alert('Provide the Speciality');
                    return false;
                }
                if (document.getElementById('ddlReferralphysician').value.trim() == 0) {
                    document.getElementById('ddlReferralphysician').focus();
                alert('Provide the Physician referred to ');
                    return false;
                }
            }


        }

        function Validation() {

            if (document.getElementById("hdnIstrustedOrg").value == "N") {

                var TemplateType = document.getElementById("ddlTemplateType").options[document.getElementById("ddlTemplateType").selectedIndex].text;

                if (TemplateType == "Referral") {


                    if (document.getElementById("txtReferingOrg").value.trim() == "") {
                        document.getElementById('txtReferingOrg').focus();
                alert('Provide the Organization referred to ');
                        return false;
                    }

                    if (document.getElementById("txtRefToPhy").value.trim() == "") {
                        document.getElementById('txtRefToPhy').focus();
                alert('Provide the Physician referred to ');
                        return false;
                    }
                }
            }
            else {
                var TemplateType = document.getElementById("ddlTemplateType").options[document.getElementById("ddlTemplateType").selectedIndex].text;

                if (TemplateType == "Referral") {
                    if (document.getElementById('ddlReferingOrg').value.trim() == 0) {
                        document.getElementById('ddlReferingOrg').focus();
                alert('Provide the Organization referred to ');
                        return false;
                    }


                    if (document.getElementById('ddlSpeciality').value.trim() == 0) {
                        document.getElementById('ddlSpeciality').focus();
                alert('Provide the Speciality');
                        return false;
                    }
                    if (document.getElementById('ddlReferralphysician').value.trim() == 0) {
                        document.getElementById('ddlReferralphysician').focus();
                alert('Provide the Physician referred to ');
                        return false;
                    }
                }
            }

        }

        
    </script>

</head>
<body >
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
         <div id="header">
            <div class="logoleft" style="z-index:2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>"  class="logostyle" />
                </div>
            </div>
                <div class="middleheader">
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:PatientHeader ID="patientHeader" runat="server" />
            </div>
                    <div style="float: right;"  class="Rightheader"></div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
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
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                  
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <table cellpadding="4" cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td>
                                            <table id="tblTreatment" cellpadding="0" cellspacing="0" border="0" width="100%"
                                                style="display: none" runat="server">
                                                <tr class="defaultfontcolor" runat="server">
                                                    <td runat="server">
                                                        <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                                            <tr style="height: 10px;">
                                                                <td style="font-weight: normal; color: #000;" align="center">
                                                                    <input type="hidden" id="RefID" name="RefID" />
                                                                    <asp:HiddenField ID="hdnRefID" runat="server" />
                                                                    <asp:GridView ID="gvReferral" runat="server" AutoGenerateColumns="False" DataKeyNames="ReferralID"
                                                                        OnRowDataBound="gvReferral_RowDataBound">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Select">
                                                                                <ItemTemplate>
                                                                                    <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="PatientSelect" />
                                                                                </ItemTemplate>
                                                                                <ItemStyle Width="5%"></ItemStyle>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField Visible="False">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblReferralID" runat="server" Text='<%#Bind("ReferralID") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <ItemStyle Width="14%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Type">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblResultTemplateType" runat="server" Text='<%#Bind("ResultTemplateType") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <ItemStyle Width="14%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Refered To OrgName">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblReferedToOrgName" runat="server" Text='<%#Bind("ReferedToOrgName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <ItemStyle Width="14%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Refered To PhysicianName">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblReferedToPhysicianName" runat="server" Text='<%#Bind("ReferedToPhysicianName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <ItemStyle Width="14%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Referral/Medical For">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblResultName" runat="server" Text='<%#Bind("ResultName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <ItemStyle Width="14%" />
                                                                            </asp:TemplateField>
                                                                            
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                            <td align="center"><table><tr>
                                                                <td   align="center">
                                                                    <asp:Button ID="btnEditReferral" runat="server" Text="Edit" CssClass="btn" OnClientClick="return pValidationReferrals()"
                                                                        OnClick="btnEditReferral_Click" />
                                                                </td>
                                                                <td  align="center">
                                                                    <asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btn" OnClientClick="return pValidationReferrals()"
                                                                        OnClick="btnPrint_Click" />
                                                                </td>
                                                                </tr></table></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <table cellpadding="4" cellspacing="0" border="0" width="100%" style="display: none;"
                                    id="TbTrustedOrg" runat="server">
                                    <tr runat="server">
                                        <td runat="server">
                                            <table cellpadding="4" cellspacing="0" border="0" width="100%" runat="server" style="display: none;"
                                                id="TbRefCF">
                                                <tr runat="server">
                                                    <td style="width: 100px;" runat="server">
                                                        <asp:Label ID="lblTemplateType" runat="server" Text="Template Type"></asp:Label>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:DropDownList ID="ddlTemplateType" runat="server" AutoPostBack="True" 
                                                            OnSelectedIndexChanged="ddlTemplateType_SelectedIndexChanged">
                                                            <asp:ListItem>--Select--</asp:ListItem>
                                                            <asp:ListItem>Referral</asp:ListItem>
                                                            <asp:ListItem>Fitness</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td runat="server">
                                                        <div id="divlblTemplateName" visible="False" runat="server">
                                                            <asp:Label ID="lblTemplateName" runat="server" Text="Template Name"></asp:Label>
                                                        </div>
                                                    </td>
                                                    <td runat="server">
                                                        <div id="divddlRTemplateName" visible="False" runat="server">
                                                            <asp:DropDownList ID="ddlRTemplateName" runat="server" AutoPostBack="True" 
                                                                OnSelectedIndexChanged="ddlRTemplateName_SelectedIndexChanged">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </td>                                                    
                                                      <td runat="server">
                                                        <div id="divRefByPhysican1" visible="False" runat="server">
                                                            <asp:Label ID="lblRefByPhysican" runat="server" Text="Referral By Physician"></asp:Label>
                                                        </div>
                                                    </td>
                                                    <td runat="server">
                                                        <div id="divRefByPhysican2" visible="False" runat="server">
                                                            <asp:DropDownList ID="ddlRefByPhysican" runat="server">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn" OnClick="btnBack_Click"
                                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"/>
                                                    </td>
                                                    
                                                </tr>
                                                <tr id="TrTrustedReffOrg" style="display: none;" runat="server">
                                                    <td class="defaultfontcolor" runat="server">
                                                        <asp:Label ID="lblReferingOrgs" runat="server" Text="Refering Org"></asp:Label>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:DropDownList runat="server" CssClass="ddlTheme12" ID="ddlReferingOrg" AutoPostBack="True"
                                                            OnSelectedIndexChanged="ddlReferingOrg_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:Label ID="lblViewCaseSheet" runat="server" Text="Allow View Case Sheet in Referring Org"></asp:Label>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:CheckBox ID="chkCaseSheet" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr id="TrSpeciality" runat="server">
                                                    <td id="divSpeciality" visible="False" runat="server">
                                                        <asp:Label ID="lblSpecialityTO" runat="server" Text="Speciality"></asp:Label>
                                                    </td>
                                                    <td id="divSpeciality1" visible="False" runat="server">
                                                        <asp:DropDownList ID="ddlSpeciality" CssClass="ddlTheme12" runat="server" AutoPostBack="True"
                                                            OnSelectedIndexChanged="ddlSpeciality_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td id="divRefPhysician" visible="False" runat="server">
                                                        <asp:Label ID="lblRefToPhysician" runat="server" Text="Referral To Physician"></asp:Label>
                                                    </td>
                                                    <td id="divRefPhysician1" visible="False" runat="server">
                                                        <asp:DropDownList ID="ddlReferralphysician" CssClass="ddlTheme12" runat="server">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td style="height: 10px" runat="server">
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td style="height: 10px" runat="server">
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td style="height: 10px" runat="server">
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td runat="server">
                                        </td>
                                    </tr>
                                </table>
                                <table cellpadding="4" cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td>
                                            <table cellpadding="4" cellspacing="0" border="0" width="100%" id="tbreferrel" runat="server"
                                                style="display: none;">
                                                <tr runat="server">
                                                    <td runat="server">
                                                        <asp:Label ID="lblReferingOrg" runat="server" Text="Refering Org"></asp:Label>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:TextBox ID="txtReferingOrg" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:Label ID="lblSpeciality" runat="server" Text="Speciality"></asp:Label>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:TextBox ID="txtSpeciality" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr runat="server">
                                                    <td runat="server">
                                                        <asp:Label ID="lblRefToPhy" runat="server" Text="Referral To Physician"></asp:Label>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:TextBox ID="txtRefToPhy" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table cellpadding="4" cellspacing="0" border="0" width="100%" id="tbfckreferrelNotes"
                                                runat="server" style="display: none;">
                                                <tr runat="server">
                                                    <td runat="server">
                                                        <FCKeditorV2:FCKeditor ID="fckreferrelNotes" runat="server" Width="100%" 
                                                            Height="200px">
                                                        </FCKeditorV2:FCKeditor>
                                                    </td>
                                                </tr>
                                                <tr id="trReferralTemplate" style="display: none;" runat="server">
                                                    <td runat="server">
                                                        <uc2:ReferralTemplate ID="ReferralTemplate1" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr id="trPrintFitness" style="display: none;" runat="server">
                                                    <td runat="server">
                                                        <uc8:FitnessTemplate ID="FitnessTemplate1" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr runat="server">
                                                    <td align="center" runat="server">
                                                        <asp:Button ID="btnOkRefCf" runat="server" Text="OK" Width="100px" CssClass="btn"
                                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnOkRefCf_Click"
                                                            OnClientClick="return Validation();" />
                                                        <asp:Button ID="btnEditRefCf" runat="server" Width="100px" Text="Edit Diagnose" CssClass="btn"
                                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnEditRefCf_Click" />
                                                        <asp:Button ID="btnSave" runat="server" Text="More Referral Letter" Width="130px" CssClass="btn"
                                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="return Validation();"
                                                            OnClick="btnSave_Click" />
                                                        <asp:HiddenField ID="hdnIstrustedOrg" runat="server" />
                                                        <asp:HiddenField ID="hdnVisitPurposeID" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
