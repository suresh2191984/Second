<%@ Page Language="C#" AutoEventWireup="true"  EnableEventValidation ="false" CodeFile="ProcedurePlanning.aspx.cs"
    Inherits="Patient_ProcedurePlanning"  %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/SurgeryforProcedurePlanning.ascx" TagName="SurgeryPlan"
    TagPrefix="uc8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>
    
    </title>
    <script type ="text/javascript">
        function showIPTreatmentPlanOthersChildBlock_Control(SelectedChildID) {

            if (SelectedChildID == 0) {

                document.getElementById('SurgeryPlan_IPTreatmentPlanOthersChild').style.display = "block";
            }

            else {
                document.getElementById('SurgeryPlan_IPTreatmentPlanOthersChild').style.display = "none";
            }
        }


        function showIPTreatmentPlanChild_Control(SelectedMasterID) {
//            //debugger;

            //            var masterIDOther = document.getElementById("ddlIPTreatmentPlanMaster").options[document.getElementById("ddlIPTreatmentPlanMaster").selectedIndex].value;
            //            var MasterTextOther = document.getElementById("ddlIPTreatmentPlanMaster").options[document.getElementById("ddlIPTreatmentPlanMaster").selectedIndex].text;
    
            if (SelectedMasterID == 0) {


                document.getElementById('SurgeryPlan_tdIPTreatmentPlanChild').style.display = "none";

               // document.getElementById('SurgeryPlan_td1').style.display = "block";
                document.getElementById('SurgeryPlan_IPTreatmentPlanOthersBlock').style.display = "block";
                document.getElementById('SurgeryPlan_ddlIPTreatmentPlanChild').options.length = 1;
            }
            else {

                document.getElementById('SurgeryPlan_tdIPTreatmentPlanChild').style.display = "block";

               // document.getElementById('SurgeryPlan_td1').style.display = "none";
                document.getElementById('SurgeryPlan_IPTreatmentPlanOthersBlock').style.display = "none";
                document.getElementById('SurgeryPlan_IPTreatmentPlanOthersChild').style.display = "none";
                var HidValue = document.getElementById('SurgeryPlan_hdnIPTreatmentPlanChild').value;
                var MasterID = SelectedMasterID;


                var list = HidValue.split('^');
                var ddlTreatmentPlanChild = document.getElementById('SurgeryPlan_ddlIPTreatmentPlanChild');
              //  ddlTreatmentPlanChild.options.length = 0;
                if (document.getElementById('SurgeryPlan_hdnIPTreatmentPlanChild').value != "") {


                    for (var count = 0; count < list.length; count++) {

                        var IPTreatmentPlanChild = list[count].split('~');

                        if (MasterID == IPTreatmentPlanChild[2]) {

                            var opt = document.createElement("option");
                            document.getElementById('SurgeryPlan_ddlIPTreatmentPlanChild').options.add(opt);
                            opt.text = IPTreatmentPlanChild[1];
                            opt.value = IPTreatmentPlanChild[0];


                            //                        document.getElementById("ddlIPTreatmentPlanChild").databind();

                        }
                    }

                }
            }
        }

        function showIPTreatmentPlanOthersBlock() {
            if (document.getElementById('SurgeryPlan_IPTreatmentPlanOthersBlock').style.display == "none") {
                document.getElementById('SurgeryPlan_IPTreatmentPlanOthersBlock').style.display = "block";
            }
            else {
                document.getElementById('SurgeryPlan_IPTreatmentPlanOthersBlock').style.display = "none";
            }
        }




    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
       
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <%--<uc3:PatientHeader ID="patientHeader" runat="server" />--%>
                <uc6:UserHeader ID="UserHeader1" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: none;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata1">
                        <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <div>
                           <uc8:SurgeryPlan ID="SurgeryPlan" runat ="server" />
                        </div>
                        <br />
                        
                      
                    </div>
                    <input type="hidden" id="hdnStatus" runat="server" />
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
