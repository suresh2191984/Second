<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PreBillPrintPage.aspx.cs" Inherits="Admin_PreBillPrintPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Patient Visit Details</title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="contentdata">
   
                    <asp:Panel  ID="PnlPatientDetail" runat="server" GroupingText="Patient Details"
                            meta:resourcekey="PnlPatientDetailResource1">
                            
                                    <table class="w-100p">

                                               <tr> 
                                                 <td class="w-7p">
                                                    <asp:Label ID="PatientName" runat="server" Text="Patient Name:"
                                                        AccessKey="N" meta:resourcekey="lblNameResource1"></asp:Label>
                                                </td>
                                                <td>
                                                 <asp:Label ID="Label1" runat="server" Text="Patient Name"
                                                        AccessKey="N" meta:resourcekey="lblNameResource1"></asp:Label>
                                                </td>
                                                </tr>
                                                 <tr>
                                                 <td class="w-7p">
                                                    <asp:Label ID="Sex" runat="server" Text="Gender:"
                                                        AccessKey="N" meta:resourcekey="lblNameResource1"></asp:Label>
                                                </td>
                                                <td>
                                                <asp:Label ID="Label2" runat="server" Text="Gender"
                                                        AccessKey="N" meta:resourcekey="lblNameResource1"></asp:Label>
                                                </td>
                                                 </tr>
                                                 <tr>
                                                 <td class="w-7p">
                                                    <asp:Label ID="DOB" runat="server" Text="DOB:"
                                                        AccessKey="N" meta:resourcekey="lblNameResource1"></asp:Label>
                                                </td>
                                                <td>
                                                <asp:Label ID="Label3" runat="server" Text="DOB"
                                                        AccessKey="N" meta:resourcekey="lblNameResource1"></asp:Label>
                                                </td>
                                                </tr>
                                                <tr>
                                                 <td class="w-7p">
                                                    <asp:Label ID="Age" runat="server" Text="Age:"
                                                        AccessKey="N" meta:resourcekey="lblNameResource1"></asp:Label>
                                                </td>
                                                <td>
                                                <asp:Label ID="Label7" runat="server" Text="Age"
                                                        AccessKey="N" meta:resourcekey="lblNameResource1"></asp:Label>
                                                </td>
                                                </tr>
                                               <%-- <tr>
                                                 <td class="w-7p">
                                                    <asp:Label ID="ClientName" runat="server" Text="ClientName:"
                                                        AccessKey="N" meta:resourcekey="lblNameResource1"></asp:Label>
                                                </td>
                                               <%-- <td>
                                                <asp:Label ID="Label4" runat="server" Text="ClientName"
                                                        AccessKey="N" meta:resourcekey="lblNameResource1"></asp:Label>
                                                </td>
                                                </tr>--%>
                                                <tr>
                                                 <td class="w-7p">
                                                    <asp:Label ID="OrgID" runat="server" Text="OrgID:"
                                                        AccessKey="N" meta:resourcekey="lblNameResource1"></asp:Label>
                                                </td>
                                                <td>
                                                <asp:Label ID="Label5" runat="server" Text="OrgID"
                                                        AccessKey="N" meta:resourcekey="lblNameResource1"></asp:Label>
                                                </td>
                                                </tr>
                                                
                                                </table>
                                           <asp:GridView ID="GridView1" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White"
                                             runat="server" AutoGenerateColumns="false" Height="66px" PagerSettings-Mode="NextPrevious" AllowPaging="True"
                                                                    EmptyDataText="No Matching Records Found" CellPadding="3" CellSpacing="3" 
                                                                    meta:resourcekey="GridView1Resource1" Width="397px">
                                                                    <PagerStyle HorizontalAlign="Center" />
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                                                                        PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                                        
                                             <Columns>
                                             
                                           <%--<asp:BoundField DataField="FinalBillID" HeaderText="FinalBillID" 
                                                     ItemStyle-Width="30" >
                                                 <ItemStyle Width="30px" />
                                                 </asp:BoundField>--%>
                                          <%-- <asp:BoundField DataField="RoleID" HeaderText="RoleID" meta:resourcekey="BoundFieldResource1"
                                           ItemStyle-Width="150" >
                                           <HeaderStyle HorizontalAlign="Left" />
                                                 <ItemStyle Width="150px" />
                                                 </asp:BoundField>--%>
                                           <asp:BoundField DataField="Name" HeaderText="Name" meta:resourcekey="BoundFieldResource2"
                                           ItemStyle-Width="150" >
                                           <HeaderStyle HorizontalAlign="Left" />
                                                 <ItemStyle Width="150px" />
                                                 </asp:BoundField>
                                           <asp:BoundField DataField="FeeType" HeaderText="FeeType" meta:resourcekey="BoundFieldResource3"
                                           ItemStyle-Width="150" >
                                           <HeaderStyle HorizontalAlign="Left" />
                                                 <ItemStyle Width="150px" />
                                                 </asp:BoundField>
                                           <asp:BoundField DataField="Rate" HeaderText="Rate" meta:resourcekey="BoundFieldResource4"
                                           ItemStyle-Width="150" >
                                           <HeaderStyle HorizontalAlign="Left" />
                                                 <ItemStyle Width="150px" />
                                                 </asp:BoundField>
                                           
                                           </Columns>
                                              <%-- <HeaderStyle BackColor="#3AC0F2" ForeColor="White" />--%>
                                         </asp:GridView>    
                                   
                              </asp:Panel>
                              </div>
                             
                   
<%--    <input type="hidden" runat="server" id="hdnName" />
    <input type="hidden" runat="server" id="hdnRate" />--%>
    </form>
</body>
</html>
