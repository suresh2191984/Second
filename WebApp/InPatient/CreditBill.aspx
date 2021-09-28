<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CreditBill.aspx.cs" Inherits="InPatient_CreditBill" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/FinalBillHeader.ascx" TagName="FinalBillHeader"
    TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc8" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script language="javascript" type="text/javascript">
        function funCalDiscount(hdnAmt, lblResultAmt, txtDiscountPercent) {
            phdnAmt = document.getElementById(hdnAmt).value;
            ptxtDiscountPercent = document.getElementById(txtDiscountPercent).value;
            plblResultAmt = document.getElementById(lblResultAmt);
            if (Number(ptxtDiscountPercent) > 0) {
                var discountAmt = (Number(phdnAmt) * (Number(ptxtDiscountPercent) / 100));
                var AmtAftDiscount = Number(phdnAmt) - Number(discountAmt);
                plblResultAmt.innerHTML = Number(AmtAftDiscount).toFixed(2);

            }
            else {
                plblResultAmt.innerHTML = 0;
            }
            TotalAmountAfterDiscount();


        }
        function TotalAmountAfterDiscount() {
            var temoTotal = 0.00;
            var lblTotal2 = document.getElementById('hdnTotalAmt2').value;
            var x = document.getElementById('hdnValues').value.split('^');
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    y = x[i].split("~");
                    temoTotal = format_number(Number((document.getElementById(y[1]).innerHTML), 2) + Number(temoTotal), 2);

                }

            }
            document.getElementById(lblTotal2).innerHTML = Number(temoTotal).toFixed(2);

        }

        function PrintCreditBill() {


            //document.getElementById('bdnSave').style.visibility = 'hidden';
            document.getElementById('btnPrint').style.visibility = 'hidden';
            document.getElementById('btnBack').style.visibility = 'hidden';

            var prtContent = document.getElementById('PrintArea');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,sta­tus=0');
            WinPrint.document.write(prtContent.innerHTML);

            //document.getElementById('bdnSave').style.visibility = 'visible';
            document.getElementById('btnPrint').style.visibility = 'visible';
            document.getElementById('btnBack').style.visibility = 'visible';

            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            return false;


        }

        ////////////////////////////
        function ChkPercent(obj) {
            if (obj.value > 100.0) {
                obj.value = "";
                obj.value = 100.00;
                return false;
            }

        }

        function expandTextBox(id) {
            document.getElementById(id).rows = "5";
            document.getElementById(id).cols = "23";
            ConverttoUpperCase(id);
        }
        function collapseTextBox(id) {
            document.getElementById(id).rows = "1";
            document.getElementById(id).cols = "23";
            ConverttoUpperCase(id);

        }

        ////////////////////////////
         

    </script>

    <style type="text/css">
        .style1
        {
            background-color: #2c88b1;
            width: 100%;
            color: #FFFFFF;
            margin-left: 15px;
            height: 56px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="header">
        <div class="logoleft" style="z-index: 2;">
            <div class="logowrapper">
                <img alt="" src="<%=LogoPath%>" class="logostyle" />
            </div>
        </div>
        <div class="middleheader">
            <uc4:MainHeader ID="MainHeader" runat="server" />
            <uc8:PatientHeader ID="PatientHeader" runat="server" />
        </div>
        <div style="float: right;" class="Rightheader">
        </div>
    </div>
    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
        <tr>
            <td width="15%" valign="top" id="menu" style="display: block;">
                <div id="navigation">
                    <uc121:LeftMenu ID="LeftMenu1" runat="server" />
                </div>
            </td>
            <td width="85%" valign="top" class="tdspace">
                <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                    style="cursor: pointer;" runat="server" />
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            <Top:TopHeader ID="TopHeader1" runat="server" />
                        </td>
                    </tr>
                </table>
                <div id="PrintArea" runat="server" class="contentdata">
                    <table width="100%">
                        <tr>
                            <td>
                            </td>
                            <td colspan="2">
                                <table border="0" width="100%">
                                    <tr>
                                        <td align="center" colspan="17">
                                            <asp:Label ID="lblBillHeader" Text="CREDIT BILL" Font-Size="22px" Font-Bold="true"
                                                runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <asp:Label ID="lblBillNotxt" Text="BILL NO:" Font-Bold="true" runat="server"></asp:Label>
                                            <asp:Label ID="lblBillNo" Font-Bold="true" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="lblDatetxt" Text="Date:" runat="server"></asp:Label>
                                            <asp:Label ID="lblDate" runat="server"></asp:Label>
                                            <br />
                                            <asp:Label ID="lblRetired" Text="RETIRED EMPLOYEE" Visible="false" Font-Bold="true"
                                                Font-Underline="true" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <table width="100%" class="dataheader2" border="0" style="font-size: 11px; font-family: Verdana;"
                                    cellspacing="0" cellpadding="0" align="center" runat="server">
                                    <tr>
                                        <td align="center" class="dataheader1" nowrap="nowrap" colspan="8">
                                            <asp:Label ID="lblHospitalExpenses" nowrap="nowrap" Text="STATEMENT OF HOSPITALIZATION EXPENSES"
                                                Font-Bold="true" Font-Size="Medium" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="10%">
                                        </td>
                                        <td align="left" width="15%">
                                            <asp:Label ID="lblPatientNametxt" Text="NAME" runat="server"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblName" runat="server" Style="font-weight: 700"></asp:Label>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td align="left" width="15%">
                                            <asp:Label ID="lblDOAtxt" Text="D.O.A" runat="server"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblDOA" runat="server" Style="font-weight: 700"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblAgeSextxt" Text="AGE&SEX" runat="server"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblAgeSex" runat="server" Style="font-weight: 700"></asp:Label>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblDODtxt" Text="D.O.D" runat="server"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblDOD" runat="server" Style="font-weight: 700"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblIPNotxt" Text="IP.NO" runat="server"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblIPNo" runat="server" Style="font-weight: 700"></asp:Label>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblREGNOtxt" Text="REG.NO" runat="server"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblREGNO" runat="server" Style="font-weight: 700"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td align="left">
                                         <asp:Label ID="lblLetterNoTxt" runat="server" Text="LETTER NO"></asp:Label>
                                        <%-- <uc3:FinalBillHeader ID="FinalBillHeader1" runat="server"  /> --%>
                                        </td>
                                        <td align="left">
                                       <asp:Label ID="lblLetterNo" runat="server" Style="font-weight: 700"></asp:Label>
                                        </td>
                                        
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td align="left">
                                         <asp:Label ID="lblCrpNameTxt" runat="server" Text="CORPORATE NAME"></asp:Label>
                                        </td>
                                        <td align="left">
                                         <asp:Label ID="lblCrpName" runat="server" Style="font-weight: 700"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr id="trLetterNo" runat="server">
                                        <td>
                                        </td>
                                        <td style="display:none">
                                         <uc3:FinalBillHeader ID="FinalBillHeader1" runat="server"  />   
                                        </td>
                                        <td align="left">
                                       
                                        </td>
                                        
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td align="left">
                                         
                                        </td>
                                        <td align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="8">
                                            <asp:GridView ID="grdParentGrid" runat="server" AutoGenerateColumns="false" Width="100%"
                                                OnRowDataBound="grdParentGrid_RowDataBound" Font-Names="Verdana" Font-Size="11px"
                                                Style="margin-bottom: 0px">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Room Based Rates">
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td align="left" style="display:none">
                                                                    <asp:Label ID="lblRoomTypeID" Text='<%# Eval("RoomTypeID") %>' Style="font-weight: bold; font-size: 10px;" runat="server"></asp:Label>
                                                                 </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                        OnRowDataBound="grdResult_RowDataBound" Font-Names="Verdana" Font-Size="11px"
                                                                        ShowFooter="True">
                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                        <PagerStyle CssClass="dataheader1" />
                                                                        <Columns>
                                                                        
                                                                            <asp:TemplateField HeaderText="Fee Type" Visible="false">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblGrdFeetype" runat="server" Style="text-align: left;" Text='<%# Eval("Feetype") %>'
                                                                                        meta:resourcekey="chkIDResource1" />
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Fee ID" Visible="false">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblGrdFeeId" runat="server" Style="text-align: left;" Text='<%# Eval("FeeID") %>'
                                                                                        meta:resourcekey="chkIDResource1" />
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Description" ItemStyle-Width="25%">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="chkID" runat="server" Style="text-align: left;" Text='<%# Eval("Description") %>'
                                                                                        meta:resourcekey="chkIDResource1" />
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Details" ItemStyle-Width="18%">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblUnitPrice" runat="server" Style="text-align: left;" Text='<%# Eval("Unitprice") %>' />
                                                                                    <asp:Label ID="lblstar" runat="server" Style="text-align: center;" Text="*" />
                                                                                    <asp:Label ID="lblQty" runat="server" Style="text-align: left;" Text='<%# Eval("Unit") %>' />
                                                                                    <asp:Label ID="lblQtymode" ForeColor="Red" Text='<%# Eval("Feetype") %>' runat="server" />
                                                                                </ItemTemplate>
                                                                                <FooterTemplate>
                                                                                    <asp:Label ID="lblTotalAmt1txt" runat="server" Font-Bold="true" Style="text-align: right;" Text="Total Amount"></asp:Label>
                                                                                </FooterTemplate>
                                                                                <FooterStyle CssClass="dataheader1" />
                                                                                <ItemStyle HorizontalAlign="Center" />
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Actual Amount" ItemStyle-Width="12%">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblActualAmt" runat="server" Style="text-align: right;" Text='<%# Eval("ActualAmount","{0:0.00}") %>' />
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                <FooterTemplate>
                                                                                    <asp:Label ID="lblActualTotalAmt1" runat="server" Font-Bold="true" Style="text-align: right;" Text="0.00"></asp:Label>
                                                                                </FooterTemplate>
                                                                                <FooterStyle CssClass="dataheader1" />
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Amount" ItemStyle-Width="12%">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblAmt" runat="server" Style="text-align: right;" Text='<%# Eval("Amount","{0:0.00}") %>' />
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                <FooterTemplate>
                                                                                    <asp:Label ID="lblTotalAmt1" runat="server" Font-Bold="true" Style="text-align: right;" Text="0.00"></asp:Label>
                                                                                </FooterTemplate>
                                                                                <FooterStyle CssClass="dataheader1" />
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                            </asp:TemplateField>
                                                                           
                                                                            <asp:TemplateField HeaderText="Discount/Enhancement (%)" ItemStyle-Width="15%" >
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblDiscountPercent" Text='<%# Eval("DiscountPercent") %>' Style="text-align: right;"
                                                                                        runat="server" Width="85px" MaxLength="6"></asp:Label>
                                                                                </ItemTemplate>
                                                                               
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                            </asp:TemplateField>
                                                                           
                                                                            <asp:TemplateField HeaderText="Remarks" ItemStyle-Width="30%">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblRemarks" runat="server" Text='<%# Eval("Remarks") %>' Style="text-align:center;" />
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Center" />
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                        <FooterStyle HorizontalAlign="Right" />
                                                                    </asp:GridView>
                                                                </td>
                                                           
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                   
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    
                                                <tr>
                                                
                                                <td nowrap="nowrap" colspan="8" align="right" >
                                                 <asp:Label ID="lblGrantTotaltxt" runat="server" Text="Grant Total" Font-Size="Small" Font-Bold="true" Style="text-align: right;" />=
                                                 <asp:Label ID="lblGrantTotal" runat="server" Font-Bold="true" Font-Size="Small" Style="text-align: right;" />
                                                </td>
                                                </tr>
                                    
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="8" align="center">
                                <%--<asp:Button ID="bdnSave" runat="server" Text="Save" class="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" OnClick="bdnSave_Click" Height="26px" />--%>
                                <asp:Button ID="btnPrint" runat="server" Text="Print" class="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" OnClientClick=" return PrintCreditBill();" Height="26px" />
                                <asp:Button ID="btnBack" runat="server" Text="Back" class="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" OnClick="btnBack_Click" Height="26px" />
                            </td> 
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnValues" runat="server" />
    <asp:HiddenField ID="hdnClientId" runat="server" />
    <asp:HiddenField ID="hdnTotalAmt2" runat="server" />
    </form>
</body>
</html>
