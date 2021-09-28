<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SecPrescriptionPage.ascx.cs"
    Inherits="CommonControls_SecPrescriptionPage" %>
<style type="text/css">
    .sspFonts
    {
        font-family: Arial,sans-serif;
        font-size: 14px;
        font-weight: normal;
        color: #000000;
    }
    .ColonTD
    {
        width: 5%;  
        height: 20%;       
    }
    .CaptionTD
    {
        width: 20%;
        height: 20%;
    }
    .ContentTD
    {
        width: 25%;
        height: 20%;
    }    
    .tbFormat
    {
        left: 20%;
        right: 20%;
    }
    .ColonWidth
    {
        width:20%;
    }
    .LabelWidth
    {
        width:40%;
    }
    .style1
    {
        width: 354px;
    }
    .style3
    {
        width: 317px;
    }
    .style5
    {
        width: 324px;
    }
    .style6
    {
        width: 6px;
        vertical-align: top;
    }
    .style7
    {
        width: 4px;
        vertical-align: top;
    }
</style>
<div class="dataheader2">
    <table class="w-100p">
        <tr class="a-left">
            <td class="a-center" id="tdSecPage" runat="server">
                <table class="w-95p">
                    <%--  <tr>
      <td align="center">
        <asp:Label ID="lblMessage" runat="server"></asp:Label>
          <br />
                        <asp:Label ID="lblOrgName" CssClass="sspFonts" style="font-weight: 700" runat="server"></asp:Label>
            </td>
      </tr>--%>
                    <tr>
                        <td>
                            <table id="tblSecPage" style="font-family:Tahoma;" class="w-100p" runat="server">
                                <tr class="a-left">
                                    <td class="v-top style1">
                                        <asp:Label ID="SblDateTime" runat="server" Text="Date & Time" Font-Size="X-Small" />
                                    </td>
                                    <td class="style6">
                                        :
                                    </td>
                                    <td class="v-top LabelWidth">
                                        <asp:Label ID="lblDateTime" runat="server" Font-Size="X-Small" />
                                    </td>
                                    <td class="v-top style3">
                                        <asp:Label ID="SlblPatientNo" runat="server" Text="Patient No" Font-Size="X-Small" />
                                    </td>
                                    <td class="style7">
                                        :
                                    </td>
                                    <td class="v-top style5">
                                        <asp:Label ID="lblPatientNo" runat="server" Style="font-weight: 700" Font-Size="X-Small" />
                                    </td>
                                </tr>
                                <tr class="a-left">
                                    <td class="v-top style1">
                                        <asp:Label ID="SlblPatientName" runat="server" Text="Patient Name" Font-Size="X-Small" />
                                    </td>
                                    <td class="style6">
                                        :
                                    </td>
                                    <td class="v-top LabelWidth">
                                        <asp:Label ID="lblPatientName" runat="server" Style="font-weight: 800" Font-Size="X-Small" />
                                    </td>
                                    <td class="v-top style3">
                                        <asp:Label ID="SlblAge_Sex" runat="server" Text="Age/Sex" Font-Size="X-Small" />
                                    </td>
                                    <td class="style7">
                                        :
                                    </td>
                                    <td class="v-top style5">
                                        <asp:Label ID="lblAge_Sex" runat="server" Font-Size="X-Small" />
                                    </td>
                                </tr>
                                <tr class="a-left">
                                    <td class="v-top style1">
                                        <asp:Label ID="SlblPatientAddress" runat="server" Text="Address" Font-Size="X-Small" />
                                    </td>
                                    <td class="style6 v-top">
                                        :
                                    </td>
                                    <td class="v-top LabelWidth">
                                        <asp:Label ID="lblPatientAddress" runat="server" Font-Size="X-Small" />
                                    </td>
                                    <td class="v-top style3">
                                        <asp:Label ID="SlblContactNo" runat="server" Text="Contact No." Font-Size="X-Small" />
                                    </td>
                                    <td class="style7">
                                        :
                                    </td>
                                    <td class="v-top style5">
                                        <asp:Label ID="lblContactNo" runat="server" Font-Size="X-Small" />
                                    </td>
                                </tr>
                                <tr class="a-left">
                                    <td class="v-top style1">
                                        <asp:Label ID="SlblConsultant" runat="server" Text="Consultant" Font-Size="X-Small" />
                                    </td>
                                    <td class="style6">
                                        :
                                    </td>
                                    <td class="v-top LabelWidth">
                                        <asp:Label ID="lblConsultant" runat="server" Style="font-weight: 700" Font-Size="X-Small" />
                                    </td>
                                    <td class="style3">
                                        <asp:Label ID="SlblPanelName" runat="server" Text="Panel" Font-Size="X-Small" Visible="false" />
                                    </td>                                    
                                    <td class="style7" >
                                        <asp:Label ID="Label1" runat="server" Text=":" Font-Size="X-Small" Visible="false" /> 
                                    </td>
                                    <td class="style5">
                                        <asp:Label ID="lblPanelName" runat="server" Font-Size="X-Small" Visible="false" />
                                    </td>
                                </tr>
                                <tr class="a-left">
                                    <td class="v-top style1">
                                        <asp:Label ID="SlblDepartment" runat="server" Text="Department" Font-Size="X-Small" />
                                    </td>
                                    <td class="style6">
                                        :
                                    </td>
                                    <td class="v-top LabelWidth">
                                        <asp:Label ID="lblDepartment" runat="server" Font-Size="X-Small" />
                                    </td>
                                    <td class="v-top style3">
                                        <asp:Label ID="SlblVisitType" runat="server" Text="VisitId / VisitType" Font-Size="X-Small" />
                                    </td>
                                    <td class="style7">
                                        :
                                    </td>
                                    <td class="v-top style5">
                                        <asp:Label ID="lblVisitType" runat="server" Font-Size="X-Small" />
                                    </td>
                                </tr>
                                <tr class="a-left">
                                   <td class="v-top style1">
                                        <b>
                                            <asp:Label ID="SlblAvailablity" runat="server" Text="Availablity" Font-Size="X-Small" /></b>
                                    </td>
                                    <td class="style6">
                                        :
                                    </td>
                                    <td class="v-top LabelWidth">
                                        <asp:Label ID="lblAvailablity" runat="server" Font-Size="X-Small" />
                                    </td>
                                    <td class="v-top style3">
                                        <asp:Label ID="SlblAmount" runat="server" Text="Amount" Font-Size="X-Small" />
                                    </td>
                                    <td class="style7">
                                        :
                                    </td>
                                    <td class="v-top style5">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <td><hr coolspan="6" /></td>
        
        <tr>
            <td id="tdSmartPage" runat="server">
                <div id="divSmartCardPrint" runat="server">
                    <table class="w-100p">
                        <tr>
                            <td>
                                <table id="tbSmartCardFormat" class="w-100p font16" runat="server">
                                    <tr>
                                        <td class="a-center" colspan="6">
                                            <asp:Image ID="imgBillLogo" runat="server" Visible="False" />
                                        </td>
                                    </tr>
                                    <tr class="a-center">
                                        <td id="tdOrgAddress" runat="server" colspan="6" style="font-weight:bold">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-left CaptionTD">
                                            <asp:Label ID="lblPatientName1" runat="server" Text="Name">
                                            </asp:Label>
                                        </td>
                                        <td class="ColonTD">
                                            :
                                        </td>
                                        <td class="a-left ContentTD">
                                            <asp:Label ID="lblPatientNameText" runat="server" Text="">
                                            </asp:Label>
                                        </td>
                                        <td class="a-left CaptionTD">
                                            <asp:Label ID="lblPatientNumber" runat="server" Text="Hosp. Number">
                                            </asp:Label>
                                        </td>
                                        <td class="ColonTD">
                                            :
                                        </td>
                                        <td class="a-left ContentTD">
                                            <asp:Label ID="lblPatientNumberText" runat="server" Text="">
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-left CaptionTD v-top">
                                            <asp:Label ID="lblPatientAddress1" runat="server" Text="Address">
                                            </asp:Label>
                                        </td>
                                        <td class="ColonTD v-top">
                                            :
                                        </td>
                                        <td class="ContentTD a-left">
                                            <asp:Label ID="lblPatientAddressText" runat="server" Text="">
                                            </asp:Label>
                                        </td>
                                        <td class="CaptionTD a-left v-top" >
                                            <asp:Label ID="lblAgeSex" runat="server" Text="Age/ Sex">
                                            </asp:Label>
                                        </td>
                                        <td class="v-top">
                                            :
                                        </td>
                                        <td class="a-left ContentTD v-top">
                                            <asp:Label ID="lblAgeSexText" runat="server" Text="">
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-left CaptionTD">
                                            <asp:Label ID="lblConsultant1" runat="server" Text="Consultant">
                                            </asp:Label>
                                        </td>
                                        <td class="ColonTD">
                                            :
                                        </td>
                                        <td class="a-left CaptionTD">
                                            <asp:Label ID="lblConsultantText" runat="server" Text="">
                                            </asp:Label>
                                        </td>
                                        <td class="a-left CaptionTD">
                                            <asp:Label ID="lblContactNumber" runat="server" Text="Contact Number">
                                            </asp:Label>
                                        </td>
                                        <td class="ColonTD">
                                            :
                                        </td>
                                        <td class="a-left CaptionTD">
                                            <asp:Label ID="lblContactNumberText" runat="server" Text="">
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-left CaptionTD">
                                            <asp:Label ID="lblRefBy" runat="server" Text="Refer By">
                                            </asp:Label>
                                        </td>
                                        <td class="ColonTD">
                                            :
                                        </td>
                                        <td class="a-left CaptionTD">
                                            <asp:Label ID="Label2" runat="server" Text="">
                                            </asp:Label>
                                        </td>
                                        <td class="a-left CaptionTD">
                                            <asp:Label ID="lblDate" runat="server" Text="Date">
                                            </asp:Label>
                                        </td>
                                        <td class="ColonTD">
                                            :
                                        </td>
                                        <td class="a-left CaptionTD">
                                            <asp:Label ID="lblDateText" runat="server" Text="">
                                            </asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
</div>
