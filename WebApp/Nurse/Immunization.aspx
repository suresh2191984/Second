<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Immunization.aspx.cs" Inherits="Nurse_Immunization" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    
    <script src="../Scripts/bid.js" type="text/javascript"></script>
    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>
    <script src="../Scripts/Common.js" type="text/javascript"></script>
    <script src ="../scripts/MessageHandler.js" language ="javascript" type ="text/javascript" ></script>


    <script language="javascript" type="text/javascript">
        function PreviousComplicatedItems() {

            if (document.getElementById('<%=txtothers.ClientID %>').value != '') {
                var PreCompStatus = 0;
                var HidPreValue = document.getElementById('<%=HdnVaccList.ClientID %>').value;
                //alert(HidPreValue);
                var Prelist = HidPreValue.split('^');
                var CompName = document.getElementById('<%=txtothers.ClientID %>').value;

                if (document.getElementById('<%=HdnVaccList.ClientID %>').value != "") {
                    for (var count = 0; count < Prelist.length; count++) {
                        var PrelineList = Prelist[count].split('^');
                        //alert('Prelist : ' + Prelist);
                        //alert('test : ' + PrelineList);
                        if (PrelineList != '') {
                            if (PrelineList == CompName) {
                                PreCompStatus = 1;
                            }
                        }
                    }
                }
                else {
                    var row = document.getElementById('<%=tblVaccList.ClientID %>').insertRow(1);
                    row.id = CompName;
                    //alert('no : ' + CompName);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    cell1.innerHTML = "<img id='imgbtns1' style='cursor:pointer;' OnClick=PreDeleteclick('" + escape(CompName) + "'); src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = CompName;
                    document.getElementById('<%=HdnVaccList.ClientID %>').value += CompName + "^";
                    document.getElementById('<%=txtothers.ClientID %>').value = '';
                    PreCompStatus = 0;
                    return false;
                }
            }
            else {
            
                var userMsg = SListForApplicationMessages.Get('Nurse\\Immunization.aspx_1');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Provide atleast one vaccination');
                return false ;
                }
                document.getElementById('<%=txtothers.ClientID %>').focus();
                return false;
            }
            if (PreCompStatus == 0) {
                var row = document.getElementById('<%=tblVaccList.ClientID %>').insertRow(1);
                row.id = CompName;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                cell1.innerHTML = "<img id='imgbtns1' style='cursor:pointer;' OnClick=PreDeleteclick('" + escape(CompName) + "'); src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = CompName;
                document.getElementById('<%=HdnVaccList.ClientID %>').value += CompName + "^";
                document.getElementById('<%=txtothers.ClientID %>').value = '';
                return false;
            }
            else if (PreCompStatus == 1) {
             var userMsg = SListForApplicationMessages.Get('Nurse\\Immunization.aspx_2');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert("Already Added!");
                return false ;
                }
                document.getElementById('<%=txtothers.ClientID %>').value = '';
                document.getElementById('<%=txtothers.ClientID %>').focus();
                return false;
            }
        }

        function PreDeleteclick(DeleteItem) {
            document.getElementById(unescape(DeleteItem)).style.display = "none";
            var HidPreValue = document.getElementById('<%=HdnVaccList.ClientID %>').value;
            var Prelist = HidPreValue.split('^');
            var newPreList = '';
            if (document.getElementById('<%=HdnVaccList.ClientID %>').value != "") {
                for (var icount = 0; icount < Prelist.length; icount++) {
                    var ComplicateList = Prelist[icount].split('~');
                    if (ComplicateList != '') {
                        if (ComplicateList != DeleteItem) {
                            newPreList += Prelist[icount] + "^";
                        }
                    }
                }
                document.getElementById('<%=HdnVaccList.ClientID %>').value = newPreList;
            }
        }
    </script>
</head>
<body >
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>    
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index:2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>"  class="logostyle" />
                </div>
            </div>
                <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <uc3:PatientHeader ID="patientHeader" runat="server" />
         </div>
                    <div style="float: right;"  class="Rightheader"></div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
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
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                    
                   
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <div class="dataheader2">
                                    
                                        &nbsp;&nbsp;<table width="500px" cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td style="width: 150px;">
                                                   <asp:Label  ID="Rs_PatientName" Text="Patient Name" runat="server" 
                                                        meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPName" runat="server" meta:resourcekey="lblPNameResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 150px;">
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td style="width: 150px;">
                                                    <asp:Label  ID="Rs_PatientAge" Text="Patient Age" runat="server" 
                                                        meta:resourcekey="Rs_PatientAgeResource1"></asp:Label></td>
                                                <td>
                                                    <asp:Label ID="lblPAge" runat="server" meta:resourcekey="lblPAgeResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 150px;">
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            
                                        </table>
                                    </div>
                                    
                                    
                                    <asp:Panel ID="Panel2" runat="server" CssClass="collapsePanelHeader" 
                                        Height="30px" meta:resourcekey="Panel2Resource1"> 
                                        <div style="cursor: pointer; vertical-align: middle;">
                                            <div style="float: left; margin-left: 20px;">
                                                <asp:Label ID="Label1" runat="server" meta:resourcekey="Label1Resource1">(Click to View Previous Vaccination Details...)</asp:Label>&nbsp;<asp:ImageButton 
                                                    ID="Image1" OnClientClick="ChangeSecImage();" runat="server" 
                                                    ImageUrl="../Images/collapse.jpg" AlternateText="(Click to View Details...)" 
                                                    meta:resourcekey="Image1Resource1"/>
                                            </div>
                                            <div style="float: right; vertical-align: middle;">
                                            </div>
                                        </div>
                                    </asp:Panel>
                                    <asp:Panel ID="Panel1" runat="server" CssClass="collapsePanel" Height="0px" 
                                        meta:resourcekey="Panel1Resource1">
                                    <div id="divDetails" runat="server" class="dataheader2">
                                        <table width="75%">
                                        <tr align="center">
                                        <td align="left">
                                        <asp:GridView ID="grdDetails" runat="server" AutoGenerateColumns="False"
                                            Width="75%" ForeColor="#333333" CssClass="mytable1" 
                                                meta:resourcekey="grdDetailsResource1">
                                            <Columns>
                                                <asp:BoundField DataField="VaccinationID" HeaderText="Vaccination ID" 
                                                    Visible="False" meta:resourcekey="BoundFieldResource1" />
                                                <asp:BoundField DataField="VaccinationName" HeaderText="Vaccinations Given" 
                                                    meta:resourcekey="BoundFieldResource2" >
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ImmunizedPeriod" 
                                                    HeaderText="Vacciation Given Period" meta:resourcekey="BoundFieldResource3">
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:BoundField>
                                            </Columns>
                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                            <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                        </asp:GridView>
                                        </td>
                                        </tr>
                                        </table>
                                        
                                    </div>
                                    </asp:Panel>
                                    
                                    <ajc:CollapsiblePanelExtender ID="cpeDemo" runat="Server"
                                        TargetControlID="Panel1"
                                        ExpandControlID="Panel2"
                                        CollapseControlID="Panel2" 
                                        Collapsed="True"
                                        TextLabelID="Label1"
                                        ImageControlID="Image1"    
                                        ExpandedText="(Click to Hide Previous Vaccination Details...)"
                                        CollapsedText="(Click to View Previous Vaccination Details...)"
                                        ExpandedImage="../Images/collapse.jpg"
                                        CollapsedImage="../Images/expand.jpg"
                                        SuppressPostBack="True"
                                        SkinID="CollapsiblePanelDemo" Enabled="True" />
                                    
                                    <div class="dataheader2">
                                    <br />
                                        &nbsp;&nbsp;<asp:Label ID="Rs_Info" 
                                            Text="Choose the required vaccination to immunate" runat="server" 
                                            meta:resourcekey="Rs_InfoResource1"></asp:Label>
                                    <br />
                                    <br />
                                        <asp:CheckBoxList ID="chkImmunize" runat="server" RepeatColumns="4" 
                                            meta:resourcekey="chkImmunizeResource1">
                                        
                                        </asp:CheckBoxList>                                         
                                    <br />
                                    <asp:TextBox ID="txtothers" runat="server" meta:resourcekey="txtothersResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                    <asp:Button ID="btnAddPregn" runat="server" CssClass="btn" OnClientClick="return PreviousComplicatedItems();"
                                        onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" 
                                            Text="Add" meta:resourcekey="btnAddPregnResource1" />
                                    <asp:HiddenField ID="HdnVaccList" runat="server" />
                                    <br />
                                    <br />
                                    <table id="tblVaccList" class="dataheaderInvCtrl" runat="server" width="50%"
                                        cellspacing="0" border="2">
                                        <tr Class="colorforcontent">
                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;">
                                            </td>
                                            <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 25%;">
                                                <asp:Label ID="Rs_VaccinationName" Text="Vaccination Name" runat="server" 
                                                    meta:resourcekey="Rs_VaccinationNameResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                    
                                    </div>
                                    <div class="dataheader2">
                                        <br />
                                            &nbsp;&nbsp;
                                            <asp:Button ID="btnSave" Text="Save" CssClass="btn" 
                                                onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" runat="server" 
                                            onclick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                            <asp:Button ID="btnCancel" Text="Cancel" CssClass="btn" 
                                                onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" runat="server" 
                                            onclick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                        <br />
                                        <br />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
         <asp:HiddenField ID ="hdnMessages" runat ="server" />
    </div>
    </form>
</body>
</html>
