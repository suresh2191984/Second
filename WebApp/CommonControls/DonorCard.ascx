<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DonorCard.ascx.cs" Inherits="CommonControls_DonorCard" %>
<%--<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc1" %>--%>
<style type="text/css">
    .sspFonts
    {
        font-family: Arial,sans-serif;
        font-size: 14px;
        font-weight: normal;
        color: #000000;
    }
    .style1
    {
        height: 18px;
        width: 129px;
    }
    .style4
    {
        width: 209px;
    }
    #tblSecPage
    {
        width: 139%;
        margin-right: 44px;
    }
    .style5
    {
        width: 129px;
    }
    .style6
    {
        width: 74px;
    }
    .style7
    {
        height: 18px;
        width: 74px;
    }
</style>
<div class="dataheader2">
    <br />
    <table class="w-100p">
        <tr class="a-left">
            <td class="a-center">
                <table class="w-25p">
                    <tr>
                        <td class="style4">
                            <table id="tblSecPage" runat="server">
                               <tr>
                                    <td colspan="3" class="a-center">
                                        <asp:Label ID="lblDonorID" Text="Donor Card" runat="server" 
                                            Font-Underline="True" meta:resourcekey="lblDonorIDResource1"></asp:Label>
                                    </td>
                                    
                                </tr>
                                <tr>
                                    <td colspan="3" class="a-center">
                                        <img id="imgDonor" runat="server" alt="Donor Photo"/>
                                        
                                    </td>
                                    
                                </tr>
                    <%--            ~/Images/ProfileDefault.jpg" />--%>
                                <tr class="a-left">
                                    <td class="a-left style6 v-top">
                                        <asp:Label ID="SlblDonorNo" runat="server" Text="Donor No :" 
                                            Font-Size="X-Small" meta:resourcekey="SlblDonorNoResource1" />
                                    </td>
                                    <td class="v-top a-center style5">
                                        <asp:Label ID="lblDonorNo" runat="server" Style="font-weight: 700" 
                                            Font-Size="X-Small" meta:resourcekey="lblDonorNoResource2" />
                                    </td>
                                </tr>
                                <tr class="a-left">
                                    <td class="v-top a-left style7">
                                        <asp:Label ID="SlblName" runat="server" Text="Name :" Font-Size="X-Small" 
                                            meta:resourcekey="SlblNameResource1" />
                                    </td>
                                    <td class="v-top a-center style1">
                                        <asp:Label ID="lblName" runat="server" Style="font-weight: 800" 
                                            Font-Size="X-Small" meta:resourcekey="lblNameResource2" />
                                    </td>
                                </tr>
                                <tr class="a-left">
                                    <td class="v-top a-left style6">
                                        <asp:Label ID="SlblAge_Sex" runat="server" Text="Age/Sex :" Font-Size="X-Small" 
                                            meta:resourcekey="SlblAge_SexResource1" />
                                    </td>
                                    <td class="v-top a-center style1">
                                        <asp:Label ID="lblAge_Sex" runat="server" Style="font-weight: 800" 
                                            Font-Size="X-Small" meta:resourcekey="lblAge_SexResource2" />
                                    </td>
                                </tr>
                                <tr class="a-left">
                                    <td class="v-top a-left style6">
                                        <asp:Label ID="SlblBloodGrp" runat="server" Text="Blood Group :" 
                                            Font-Size="X-Small" meta:resourcekey="SlblBloodGrpResource1" />
                                    </td>
                                    <td class="v-top a-center style5">
                                        <asp:Label ID="lblBloodGrp" runat="server" Style="font-weight: 800" 
                                            Font-Size="X-Small" meta:resourcekey="lblBloodGrpResource2" />
                                    </td>
                                </tr>
                                <tr class="a-left">
                                    <td class="v-top a-left style6">
                                        <asp:Label ID="SlblPatientAddress" runat="server" Text="Address :" 
                                            Font-Size="X-Small" meta:resourcekey="SlblPatientAddressResource1" />
                                    </td>
                                    <td class="v-top a-center style1">
                                        <asp:Label ID="lblPatientAddress" runat="server" Style="font-weight: 800" 
                                            Font-Size="X-Small" meta:resourcekey="lblPatientAddressResource2" />
                                    </td>
                                </tr>
                                <tr class="a-left">
                                    <td class="v-top a-left style6">
                                        <asp:Label ID="SlblContactNo" runat="server" Text="Contact No :" 
                                            Font-Size="X-Small" meta:resourcekey="SlblContactNoResource1" />
                                    </td>
                                    <td class="v-top a-center style5">
                                        <asp:Label ID="lblContactNo" runat="server" Style="font-weight: 800" 
                                            Font-Size="X-Small" meta:resourcekey="lblContactNoResource2" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <br />
</div>
