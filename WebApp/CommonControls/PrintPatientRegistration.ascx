<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PrintPatientRegistration.ascx.cs" Inherits="CommonControls_PrintPatientRegistration" %>
<style type="text/css">
    .fontSizes
    {
        font-size: 14px;
        font-family: Verdana, Arial;
    }
    .rowHeight
    {
        height: 30;
    }
</style>
<table width="700px" class="fontSizes" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
        <td align="center">
            <table width="700px" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" height="60">
                    <asp:Label ID="lblOrganizationName" runat="server" Style="font-weight: bold; font-size: 14px;"></asp:Label>
                        <br />
                        <asp:Label ID="lblOrgAddress" runat="server" Style="font-weight: bold; font-size: 14px;"></asp:Label>
                    </td>
                </tr>
            </table>
            </td>
       </tr>
       <tr><td>&nbsp;</td></tr>
       <tr>
       <td align="center">                 
            <table width="700px" border="0" class="fontSizes" cellspacing="0" cellpadding="0"
                align="left">
                
                <tr>
                    <td align="center" style="font-weight: bold" colspan="6" height="32">
                       <asp:Label ID="lblPatientidentify" Font-Underline="true" Text="PATIENT IDENTIFICATION SET" runat="server"></asp:Label>
                    </td>
                </tr>
               
                <tr>
                    <td align="right" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="lblMRDNotxt" Text="Medical Record No" runat="server"></asp:Label>
                    </td>
                    <td>:</td>
                    
                    <td align="left" nowrap="nowrap" colspan="4">
                        <asp:Label ID="lblMRDNo" runat="server"></asp:Label>
                    </td>
                    
                </tr>
                <tr><td>&nbsp;</td></tr>
                
                <tr>
                    <td align="right" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="lblNametxt" Text="Name" runat="server"></asp:Label>
                    </td>
                    <td>:</td>
                    <td align="left" nowrap="nowrap" colspan="4">
                        <asp:Label ID="lblName" runat="server"></asp:Label>
                    </td>
                </tr>
                 <tr><td>&nbsp;</td></tr>
                <tr>
                    <td align="right" nowrap="nowrap" style="font-weight: bold">
                        
                            <asp:Label ID="lblPlaceOfBirthtxt" Text="Place Of Birth" runat="server"></asp:Label>
                    </td>
                    <td>:</td>
                    <td align="left" nowrap="nowrap" colspan="4">
                        <asp:Label ID="lblPlaceofbirth" runat="server"></asp:Label>
                    </td>
                </tr>
                 <tr><td>&nbsp;</td></tr>
                <tr>
                    <td align="right" nowrap="nowrap" style="font-weight: bold">
                       
                           <asp:Label ID="lblDOBwithDateandTime" Text="DOB with Date and Time" runat="server"></asp:Label>
                    </td>
                    <td>:</td>
                    <td align="left" nowrap="nowrap" colspan="4">
                        <asp:Label ID="lblDOB" runat="server"></asp:Label>
                    </td>
                </tr>
                 <tr><td>&nbsp;</td></tr>
                <tr>
                    <td align="right" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="lblSextxt" Text="Sex" runat="server"></asp:Label>
                    </td>
                    <td>:</td>
                    <td align="left" nowrap="nowrap" colspan="4">
                        
                        <asp:Label ID="lblSex" runat="server"></asp:Label>
                    </td>
                </tr>
                 <tr><td>&nbsp;</td></tr>
                 <tr>
                    <td align="right" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="lblReligiontxt" Text="Religion" runat="server"></asp:Label>
                    </td>
                    <td>:</td>
                    <td align="left" nowrap="nowrap" colspan="4">
                        
                        <asp:Label ID="lblReligion" runat="server"></asp:Label>
                    </td>
                </tr>
                 <tr><td>&nbsp;</td></tr>
                 <tr>
                    <td align="right" nowrap="nowrap" style="font-weight: bold">
                         <asp:Label ID="lblAddresstxt" Text="Address" runat="server"></asp:Label>
                    </td>
                    <td>:</td>
                    <td align="left" nowrap="nowrap" colspan="4">
                        
                        <asp:Label ID="lblAddress" runat="server"></asp:Label>
                    </td>
                </tr>
                 <tr><td>&nbsp;</td></tr>
                <tr>
                    <td align="right" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="lblAddressline3" Text="Addressline3" runat="server"></asp:Label>
                    </td>
                    <td>:</td>
                    <td align="left" nowrap="nowrap" colspan="4">
                        
                        <asp:Label ID="lbladd3" runat="server"></asp:Label>
                    </td>
                </tr>
                 <tr><td>&nbsp;</td></tr>
                <tr>
                    <td align="right" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="lblAddressline2" Text="Addressline2" runat="server"></asp:Label>
                    </td>
                    <td>:</td>
                    <td align="left" nowrap="nowrap" colspan="4">
                        
                        <asp:Label ID="lbladd2" runat="server"></asp:Label>
                    </td>
                </tr>
                 <tr><td>&nbsp;</td></tr>
                <tr>
                    <td align="right" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="lblAddressline1" Text="Addressline1" runat="server"></asp:Label>
                    </td>
                    <td>:</td>
                    <td align="left" nowrap="nowrap" colspan="4">
                        
                        <asp:Label ID="lbladd1" runat="server"></asp:Label>
                    </td>
                </tr>
                 <tr><td>&nbsp;</td></tr>
                <tr>
                    <td align="right" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="lblCitytxt" Text="City" runat="server"></asp:Label>
                    </td>
                    <td>:</td>
                    <td align="left" nowrap="nowrap" colspan="4">
                        
                        <asp:Label ID="lblCity" runat="server"></asp:Label>
                    </td>
                </tr>
                 <tr><td>&nbsp;</td></tr>
                <tr>
                    <td align="right" nowrap="nowrap" style="font-weight: bold">
                       <asp:Label ID="lblProvincetxt" Text="Province" runat="server"></asp:Label>
                    </td>
                    <td>:</td>
                    <td align="left" nowrap="nowrap" colspan="4">
                        
                        <asp:Label ID="lblProvince" runat="server"></asp:Label>
                    </td>
                </tr>
                 <tr><td>&nbsp;</td></tr>
                <tr>
                    <td align="right" nowrap="nowrap" style="font-weight: bold">
                      <asp:Label ID="lblPostalCodetxt" Text="Postal Code" runat="server"></asp:Label>
                    </td>
                    <td>:</td>
                    <td align="left" nowrap="nowrap" colspan="4">
                        
                        <asp:Label ID="lblPostalCode" runat="server"></asp:Label>
                    </td>
                </tr>
                 <tr><td>&nbsp;</td></tr>
                 <tr>
                    <td align="right" nowrap="nowrap" style="font-weight: bold">
                       <asp:Label ID="lblTelephonetxt" Text="Telephone" runat="server"></asp:Label>
                    </td>
                    <td>:</td>
                    <td align="left" nowrap="nowrap" colspan="4">
                        
                        <asp:Label ID="lblTelephone" runat="server"></asp:Label>
                    </td>
                </tr>
                 <tr><td>&nbsp;</td></tr>
                <tr>
                    <td align="right" nowrap="nowrap" style="font-weight: bold">
                      <asp:Label ID="lblCitizanCountrytxt" Text="Citizan/Country" runat="server"></asp:Label>
                    </td>
                    <td>:</td>
                    <td align="left" nowrap="nowrap" colspan="4">
                        
                        <asp:Label ID="lblCitizanorCountry" runat="server"></asp:Label>
                    </td>
                </tr>
                 <tr><td>&nbsp;</td></tr>
                <tr>
                    <td align="right" nowrap="nowrap" style="font-weight: bold">
                       <asp:Label ID="lblIDCardNotxt" Text="ID Card No" runat="server"></asp:Label>
                    </td>
                    <td>:</td>
                    <td align="left" nowrap="nowrap" colspan="4">
                        
                        <asp:Label ID="lblIDNo" runat="server"></asp:Label>
                    </td>
                </tr>
                 <tr><td>&nbsp;</td></tr>
                <tr>
                    <td align="right" nowrap="nowrap" style="font-weight: bold">
                      <asp:Label ID="lblEducationtxt" Text="Education" runat="server"></asp:Label>
                    </td>
                    <td>:</td>
                    <td align="left" nowrap="nowrap" colspan="4">
                        <asp:Label ID="lblEducation" runat="server"></asp:Label>
                    </td>
                </tr>
                 <tr><td>&nbsp;</td></tr>
                <tr>
                    <td align="right" nowrap="nowrap" style="font-weight: bold">
                      <asp:Label ID="lblOccupationtxt" Text="Occupation" runat="server"></asp:Label> 
                    </td>
                    <td>:</td>
                    <td align="left" nowrap="nowrap" colspan="4">
                        
                        <asp:Label ID="lblOccupation" runat="server"></asp:Label>
                    </td>
                </tr>
                 <tr><td>&nbsp;</td></tr>
                <tr>
                    <td align="right" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="lblMaritalStatustxt" Text="Marital Status" runat="server"></asp:Label> 
                    </td> <td>:</td>                    
                    <td align="left" nowrap="nowrap" colspan="4" >
                        <asp:Label ID="lblMaritalStatus" runat="server"></asp:Label>                        
                    </td>
               </tr>
                <tr><td>&nbsp;</td></tr>
                     <%--<td align="left" nowrap="nowrap" style="font-weight: bold">
                        Nationality
                    </td>
                    
                    <td align="left" colspan="4">
                        <asp:Label ID="lblNationality" runat="server"></asp:Label>
                    </td>--%>
                    
              <tr>
                    <td align="right" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="lblRelativeAddresstxt" Text="Relative's Address" runat="server"></asp:Label> 
                    </td><td>:</td>                    
                    <td align="left" nowrap="nowrap" colspan="4" >
                        <asp:Label ID="lblRelativeAddress" runat="server"></asp:Label>                        
                    </td>
               </tr>
                <tr><td>&nbsp;</td></tr>
               <tr>
                    <td align="right" valign="top" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="lblALLERGYtxt" Text="ALLERGY" runat="server"></asp:Label> 
                    </td> <td valign="top">:</td>                   
                    <td align="left" nowrap="nowrap" colspan="4" >
                        <asp:Label ID="lblALLERGY" runat="server"></asp:Label>                        
                    </td>
               </tr>
                <tr><td>&nbsp;</td></tr>
               <tr>
               <%--<td colspan="5">
               <asp:Label ID="lblConditionaply" Text="THIS IS PRINTED ONLY FOR NEW PATIENTS AND PLACED IN PHYSICAL FILE REPRINTED ONLY IF THERE IS AN
UPDATE OR THIS PAGE IS NOT IN THE FILE" Font-Size="X-Small" runat="server"></asp:Label> 
               </td>--%>
               </tr>
                
            </table>
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
</table>
