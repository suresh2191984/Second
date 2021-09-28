<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="CorporateBilling.aspx.cs"
    Inherits="Reception_CorporateBilling" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%--<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="PatientHeader" TagPrefix="uc8" %>--%>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/ProceduresBill.ascx" TagName="ipTreatmentBillDetails"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/CorpRateConsultationDynamicDetails.ascx" TagName="ipConsultationDetails"
    TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/CorpRateInvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="ucinv1" %>
<%@ Register Src="../CommonControls/CorpoRateDisplayAllData.ascx" TagName="DisplayAllData"
    TagPrefix="uc17" %>
<%@ Register Src="../CommonControls/CorpoRateGeneralBillItems.ascx" TagName="gbi"
    TagPrefix="ucGBI" %>
<%@ Register Src="../CommonControls/ReferedPhysician.ascx" TagName="ReferedPhysician"
    TagPrefix="uc16" %>
<%@ Register Src="../CommonControls/CorpoRatePackageProfileControl.ascx" TagName="PackageProfileControl"
    TagPrefix="uc9" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Out Patient Billing</title>
    <%--    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />--%>

    <script type="text/javascript" src="../Scripts/animatedcollapse.js"></script>

    <%--    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>
--%>
    <link href="../StyleSheets/DHEBAdder.css" rel="Stylesheet" type="text/css" />
    <%--    <script src="../Scripts/Common.js" type="text/javascript"></script>--%>
</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">

    <script type="text/javascript">

        animatedcollapse.addDiv('divDuechart', 'fade=1,height=1%');
        animatedcollapse.init();

        function ProcessCallBackError(arg) {

            //alert('error'+arg);
            //document.getElementById("txtdummy").value = arg;
            alert('Result value cannot be blank ');
        }

        function changefuncion() {
            var typ = document.getElementById("<%= ddlTypes.ClientID %>").value;
            var Cons = document.getElementById('divConsultation');
            var Inves = document.getElementById('divInvestigation');
            var Treat = document.getElementById('divTreatmentBill');
            var Refer = document.getElementById('divRefering');
            var gbi = document.getElementById('divGBI');
            var immu = document.getElementById('divImmunization');
            var pkg = document.getElementById('divHealthPackage');

            if (typ == "CON") {
                Cons.style.display = "block";
                Inves.style.display = "none";
                Treat.style.display = "none";
                Refer.style.display = "block";
                immu.style.display = "none";
                gbi.style.display = "none";
                pkg.style.display = "none";
            }
            else if (typ == "PRO") {
                Cons.style.display = "none";
                Inves.style.display = "none";
                Treat.style.display = "block";
                Refer.style.display = "block";
                immu.style.display = "none";
                gbi.style.display = "none";
                pkg.style.display = "none";
            }
            else if (typ == "INV") {
                Cons.style.display = "none";
                Inves.style.display = "block";
                Treat.style.display = "none";
                Refer.style.display = "block";
                immu.style.display = "none";
                gbi.style.display = "none";
                pkg.style.display = "none";
            }
            else if (typ == "GENERAL") {
                Cons.style.display = "none";
                Inves.style.display = "none";
                Treat.style.display = "none";
                Refer.style.display = "block";
                immu.style.display = "none";
                gbi.style.display = "block";
                pkg.style.display = "none";
            }
            else if (typ == "IMM") {
                Cons.style.display = "none";
                Inves.style.display = "none";
                Treat.style.display = "none";
                Refer.style.display = "block";
                immu.style.display = "block";
                gbi.style.display = "none";
                pkg.style.display = "none";
            }
            else if (typ == "PKG") {
                Cons.style.display = "none";
                Inves.style.display = "none";
                Treat.style.display = "none";
                Refer.style.display = "block";
                immu.style.display = "none";
                gbi.style.display = "none";
                pkg.style.display = "block";
            }

            else {
                Cons.style.display = "none";
                Inves.style.display = "none";
                Treat.style.display = "none";
                Refer.style.display = "none";
                gbi.style.display = "none";
                immu.style.display = "none";
                pkg.style.display = "none";
            }
        }

        function selImmunization() {
            CmdAddBillItemsType_onclick('IMU', 0, 0, "Immunization", 1, 0, 0);
        }
        
    </script>

    <asp:ScriptManager ID="scrpt" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="slidingTopWrap">
            <div id="slidingTopContent">
                <div id="basketWrap">
                    <div id="basketTitleWrap">
                        <table class="w-100p">
                            <tr>
                                <td class="w-50p a-left">
                                    <asp:Label ID="lblPatientName" runat="server" meta:resourcekey="lblPatientNameResource1"></asp:Label><asp:HiddenField
                                        ID="hdnPName" runat="server" />
                                </td>
                                <td class="w-50p a-right">
                                </td>
                            </tr>
                        </table>
                    </div>
                    <table style="display: none" runat="server" id="PaidInv">
                        <tr>
                            <td class="bold h-20" style="color: #000;">
                                Already Ordered Investigation
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:DataList ID="dlInvName" runat="server" CellPadding="4" GridLines="Horizontal"
                                    RepeatColumns="2" RepeatDirection="Horizontal" meta:resourcekey="dlInvNameResource1">
                                    <ItemTemplate>
                                        <table>
                                            <tr>
                                                <td>
                                                    <%# DataBinder.Eval(Container.DataItem, "InvestigationName")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:DataList>
                            </td>
                        </tr>
                    </table>
                    <div id="basketItemsWrap">
                        <ul>
                            <li>
                                <uc17:DisplayAllData ID="dspData" runat="server" />
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <table class="w-100p">
            <tr>
                <td class="dataheaderInvCtrl">
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="Rs_SelectRateType" Text="Select Rate Type" runat="server" meta:resourcekey="Rs_SelectRateTypeResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlCorporate" runat="server" meta:resourcekey="ddlCorporateResource1"
                                    CssClass="ddlsmall">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Label ID="Rs_SelectClient" Text="Select Client" runat="server" meta:resourcekey="Rs_SelectClientResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlClients" runat="server" meta:resourcekey="ddlClientsResource1"
                                    CssClass="ddlsmall">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                    <div id="divRefering" style="display: none">
                        <uc16:ReferedPhysician ID="Rfrdoctor" runat="server" />
                    </div>
                </td>
            </tr>
            <tr>
                <td class="dataheaderInvCtrl">
                    <asp:Label ID="Rs_SelectPaymentType" Text="Select Payment Type" runat="server" meta:resourcekey="Rs_SelectPaymentTypeResource1"></asp:Label>
                    <asp:DropDownList ID="ddlTypes" CssClass="ddlsmall" runat="server" onChange="changefuncion()"
                        meta:resourcekey="ddlTypesResource1">
                        <asp:ListItem Text="--Select--" Value="SEL" meta:resourcekey="ListItemResource1"></asp:ListItem>
                        <asp:ListItem Text="Consultation" Value="CON" meta:resourcekey="ListItemResource2"></asp:ListItem>
                        <asp:ListItem Text="General Bill Items" Value="GENERAL" meta:resourcekey="ListItemResource3"></asp:ListItem>
                        <asp:ListItem Text="Health Package" Value="PKG" meta:resourcekey="ListItemResource4"></asp:ListItem>
                        <asp:ListItem Text="Immunization" Value="IMM" meta:resourcekey="ListItemResource5"></asp:ListItem>
                        <asp:ListItem Text="Investigation" Value="INV" meta:resourcekey="ListItemResource6"></asp:ListItem>
                        <asp:ListItem Text="Procedures" Value="PRO" meta:resourcekey="ListItemResource7"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    <div id="divConsultation" style="display: none;" runat="server" class="dataheaderInvCtrl">
                        <uc10:ipConsultationDetails ID="ipConsultation" runat="server" />
                    </div>
                    <div id="divInvestigation" style="display: none;" class="dataheaderInvCtrl">
                        <ucinv1:InvestigationControl ID="InvestigationControl2" runat="server" />
                    </div>
                    <div id="divTreatmentBill" style="display: none;" class="dataheaderInvCtrl">
                        <uc9:ipTreatmentBillDetails ID="ipTreatmentBill" runat="server" />
                    </div>
                    <div id="divGBI" style="display: none;" class="dataheaderInvCtrl">
                        <ucGBI:gbi ID="ucGBI" runat="server" />
                    </div>
                    <div id="divImmunization" style="display: none;" class="dataheaderInvCtrl">
                        &nbsp;&nbsp;&nbsp;
                        <asp:Label ID="lblBirthWeeks" runat="server" Text="Age" meta:resourcekey="lblBirthWeeksResource1"></asp:Label>
                        &nbsp;&nbsp; : &nbsp;<asp:TextBox ID="txtBirthWeeks" runat="server" meta:resourcekey="txtBirthWeeksResource1"></asp:TextBox>
                        &nbsp;&nbsp;&nbsp;<input type="button" id="btnAddImmu" value="Add" onclick="selImmunization();"
                            class="btn" />
                    </div>
                    <div id="divHealthPackage" style="display: none;" class="dataheaderInvCtrl a-center">
                        <uc9:PackageProfileControl ID="PackageProfileControl" runat="server" />
                    </div>
                    <br />
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" OnClick="btnSave_Click"
                        meta:resourcekey="btnSaveResource1" />
                    <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="btn" OnClick="btnClose_Click"
                        meta:resourcekey="btnCloseResource1" />
                    <br />
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>
