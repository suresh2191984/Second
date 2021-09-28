<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DispatchReportLIMS.aspx.cs"
    Inherits="Reports_DispatchReportLIMS" EnableEventValidation="false" meta:resourcekey="PageResource1"%>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/IncomeFromOtherSource.ascx" TagName="IncomeFromOtherSource"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dispatch Report</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />

    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
     <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                          <table id="tblDispatch" runat="server" class="a-center w-100p">
                            <tr class="a-center">
                                <td class="a-left">
                                    <%--<asp:UpdatePanel ID="updatePanel1" runat="server">
                                        <ContentTemplate>--%>
                                            <div class="dataheaderWider">
                                                <table id="tbl" class="w-100p">
                                                    <tr id="trTrustedOrg" runat="server" style="display: table-row;" >
                                                        <td class="w-12p" runat="server">
                                                            <asp:Label ID="lblOrgs" runat="server" Text="Select organization" meta:resourcekey="lblOrgsResource1"></asp:Label>
                                                           
                                                        </td>
                                                        <td class="w-15p" runat="server">
                                                         <asp:DropDownList ID="ddlTrustedOrg" AutoPostBack="True" onchange="javascript:clearContextText();"
                                                                runat="server" CssClass="ddl" Width="150px" TabIndex="1">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="w-7p" runat="server">
                                                            <asp:Label ID="lblLoc" Text="Location" runat="server" meta:resourcekey="lblLocResource1"></asp:Label>
                                                           
                                                        </td>
                                                        <td class="w-15p" runat="server">
                                                         <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddlsmall" TabIndex="2">
                                                            </asp:DropDownList>
                                                        </td>
                                                        
                                                        <td class="w-10p" runat="server">
                                                            <asp:Label ID="lblReferingOrg" Text="Reference Hospital" runat="server" meta:resourcekey="lblReferingOrgResource1"></asp:Label>
                                                        </td>
                                                        <td class="w-14p" runat="server">
                                                            <asp:TextBox ID="txtReferringHospital" runat="server" CssClass="Txtboxsmall" onfocus="return SetContextValue();"
                                                                onBlur="return ClearFields();" TabIndex="3"></asp:TextBox>
                                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtenderReferringHospital" runat="server"
                                                                TargetControlID="txtReferringHospital" EnableCaching="False" FirstRowSelected="True"
                                                                CompletionInterval="1" MinimumPrefixLength="1" CompletionListCssClass="wordWheel listMain .box"
                                                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                ServiceMethod="GetQuickBillRefOrg" ServicePath="~/WebService.asmx" OnClientItemSelected="GetReferingOrgID"
                                                                DelimiterCharacters="" Enabled="True">
                                                            </ajc:AutoCompleteExtender>
                                                            <asp:HiddenField ID="hdnReferringHospitalID" runat="server" Value="0" />
                                                        </td>
                                                        
                                                        <td class="w-10p" runat="server">
                                                                        <asp:Label ID="lblReferringPhysician" runat="server" Text="Referring Physician" meta:resourcekey="lblReferringPhysicianResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="w-20p a-left" runat="server">
                                                                        <asp:TextBox ID="txtReferringPhysician" runat="server" CssClass="Txtboxsmall" onBlur="return ClearFields();"
                                                                            onfocus="return SetContextValue();" TabIndex="4"></asp:TextBox>
                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenderReferringPhysician" runat="server"
                                                                            CompletionInterval="1" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                            CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                            Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" OnClientItemSelected="GetReferingPhysicianID"
                                                                            ServiceMethod="GetRateCardForBilling" ServicePath="~/OPIPBilling.asmx" TargetControlID="txtReferringPhysician">
                                                                        </ajc:AutoCompleteExtender>
                                                                        <asp:HiddenField ID="hdnPhysicianID" runat="server" Value="0" />
                                                                    </td>
                                                        
                                                    </tr>
                                                    <tr>
                                                        <td colspan="8">
                                                            <table class="w-100p">
                                                                <tr>
                                                                    
                                                                    <td class="w-7p a-left">
                                                                        <asp:Label ID="lblClientType" runat="server" Text="Client type" 
                                                                            meta:resourcekey="lblClientTypeResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="w-15p">
                                                                        <asp:DropDownList ID="ddlClientType" runat="server" CssClass="ddl" 
                                                                            Width="150px" TabIndex="5" meta:resourcekey="ddlClientTypeResource1">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td class="w-7p">
                                                                        <asp:Label ID="lblClient" runat="server" Text="Client Name" 
                                                                            meta:resourcekey="lblClientResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="w-15p">
                                                                        <asp:TextBox ID="txtClient" runat="server" autocomplete="off" CssClass="Txtboxsmall"
                                                                            onblur="javascript:ClearValue(this.id);ConverttoUpperCase(this.id);" onfocus="setContextClientValue();"
                                                                              OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" Width="150px" TabIndex="6" 
                                                                            meta:resourcekey="txtClientResource1"></asp:TextBox>
                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClient" runat="server" CompletionInterval="1"
                                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                            CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                            Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" OnClientItemSelected="SelectedClientID"
                                                                            ServiceMethod="GetClientList" ServicePath="~/WebService.asmx" TargetControlID="txtClient">
                                                                        </ajc:AutoCompleteExtender>
                                                                        
                                                                        <asp:HiddenField ID="hdnSelectedClientID" runat="server" />
                                                                        
                                                                    </td>
                                                                    
                                                                   <td class="w-10p"> <asp:Label ID="lbldesptch" runat="server" Text="Dispatch Type" 
                                                                           meta:resourcekey="lbldesptchResource1"/></td>
                                                                   
                                                                    <td>
                                                            <asp:DropDownList ID="ddldespatch" runat="server" CssClass="ddl" Width="150px" 
                                                                            TabIndex="7" meta:resourcekey="ddldespatchResource1"/>
                                                        </td>
                                                                </tr>
                                                                <tr>                                                                
                                                                 <td class="w-12p">
                                                                        <asp:Label ID="lblContactType" Text="Contact Type" runat="server" 
                                                                            meta:resourcekey="lblContactTypeResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="w-15p">
                                                                        <asp:DropDownList runat="server" ID="drplstPerson" Width="150px" CssClass="ddl" 
                                                                            onChange="SetContextKey();" TabIndex="8" 
                                                                            meta:resourcekey="drplstPersonResource1">
                                                                        </asp:DropDownList>
                                                                      
                                                                    </td>
                                                                    <td class="w-7p">
                                                                        <asp:Label ID="lblPersonName" Text="Courier Name" runat="server" 
                                                                            ></asp:Label>
                                                                    </td>
                                                                    <td  style="display: table-cell;" id="tdtxtPrsn" class="w-15p">
                                                                        <asp:TextBox ID="txtPersonName" runat="server" CssClass="Txtboxsmall" 
                                                                            Width="150px" TabIndex="10" meta:resourcekey="txtPersonNameResource1"
                                                                           ></asp:TextBox>
                                                                    
                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtPersonName"
                                                                            EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" FirstRowSelected="True"
                                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetSpecifiedDeptEmployee"
                                                                            OnClientItemSelected="GetEmpID" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                                            DelimiterCharacters="" Enabled="True">
                                                                        </ajc:AutoCompleteExtender>
                                                                          <input type="hidden" id="hdnEmpID" runat="server" value="0" ></input>
                                                                              <input id="hdnAddDepart" runat="server" type="hidden"></input>
                                                                    </td>
                                                                   
                                                                     <td class="w-10p">
                                                            <asp:Label ID="lbldespatchmode" runat="server" Text="Dispatch Mode" meta:resourcekey="lbldespatchmodeResource1" 
                                                                 />
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlDespatchMode" runat="server" CssClass="ddl" 
                                                                Width="150px" meta:resourcekey="ddlDespatchModeResource1" >
                                                            </asp:DropDownList>
                                                        </td>
                                                        
                                                                </tr>
                                                                <tr>                                                               
                                                               
                                                        
                                                        <td class="w-7p">
                                                            <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" 
                                                                meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox CssClass="Txtboxsmall" Width="70px" ID="txtFDate" runat="server" 
                                                                TabIndex="11" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server" 
                                                                meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox CssClass="Txtboxsmall" Width="70px" ID="txtTDate" runat="server" 
                                                                TabIndex="12" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                        </td>
                                                                
                                                                 <td class="w-8p a-left">
                                                                        <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                            onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                                            OnClick="btnSubmit_Click" TabIndex="13" 
                                                                            meta:resourcekey="btnSubmitResource1" />
                                                                    </td>
                                                                    
                                                                    <td>
                                                                        <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                                            ToolTip="Save As Excel" OnClick="imgBtnXL_Click" TabIndex="14" 
                                                                            Visible="False" meta:resourcekey="imgBtnXLResource1" />&nbsp;
                                                                               <asp:LinkButton ID="lnkExportXL" Text="Export To XL" Visible="False" 
                                        runat="server" Font-Bold="True" Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel" Font-Underline="True"
                                        meta:resourcekey="lnkExportXLResource11" onclick="lnkExportXL_Click"/>
                                                        &nbsp;&nbsp;
                                                        <asp:ImageButton ID="imgprint" runat="server" ImageUrl="~/Images/printer.gif" Visible="False" OnClientClick="return popupprint();"
                                                            ToolTip="Print" meta:resourcekey="btnPrintResource1" />&nbsp;
                                                            <b id="B1" runat="server">
                                                            <asp:LinkButton ID="lnkPrint" Text="Print Report" Font-Underline="True" Visible="False" 
                                        runat="server" Font-Bold="True" Font-Size="12px" ForeColor="Black" ToolTip="Print" OnClientClick="return popupprint();"
                                        meta:resourcekey="lnkExportXLResource2"></asp:LinkButton></b>
                                                                        &nbsp;<asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" 
                                                                            Font-Underline="True" OnClick="lnkBack_Click" TabIndex="15" 
                                                                            meta:resourcekey="lnkBackResource1">Back&nbsp;&nbsp;</asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                </table>
                                            </div>
                                            
                                            
                                                    <asp:UpdateProgress ID="Progressbar" runat="server">
                                                <ProgressTemplate>
                                                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" 
                                                        meta:resourcekey="imgProgressbarResource1" />
                                                    <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" 
                                                        meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                            <div id="divPrint"  runat="server" style="display: none;" >
                                                <table class="w-100p">
                                                    <tr>
                                                        <td class="a-right paddingR10">
                                                            <b id="printText" runat="server">
                                                                <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" 
                                                                meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>
                                                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                                ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            
                                             <div id="divOPDWCR" runat="server" >
                                                <div id="prnReport" runat="server" >
                                                 
                                                        <div id="divHeader" runat="server" style="display: none;" >
                                                                    <table id="tblHeader" cellpadding="0" cellspacing="0" border="0" width="100%"  >
                                                                     <tr>
                                                                    <td class="a-center">
                                                                        <asp:Label ID="lblHeader" runat="server" Text=""></asp:Label>
                                                                    </td>
                                                                    </tr>
                                                                    <tr>
                                                                    <td class="a-center">
                                                                        <asp:Label ID="lblorg" runat="server" Text=""></asp:Label>
                                                                    </td>
                                                                    </tr>
                                                                    <tr>
                                                                    <td class="a-center">
                                                                        <asp:Label ID="lblRefDoc" runat="server" Text=""></asp:Label>
                                                                    </td>
                                                                    </tr>
                                                                    <tr>
                                                                    <td class="a-center">
                                                                        <asp:Label ID="lbldate" runat="server" Text=""></asp:Label>
                                                                    </td>
                                                                    </tr>
                                                                    </table> 
                                                                    </div>
                                                                    <table class="w-100p">
                                                                        <tr>
                                                                            <td class="a-center" >
                                                                                <asp:GridView ID="gvOrgwiseDispatch" 
                                                                                    OnRowDataBound="gvOrgwiseDispatch_RowDataBound"  
                                                                                    OnPageIndexChanging="gvOrgwiseDispatch_PageIndexChanging" AllowGrouping="true" 
                                                                                    GroupColumnName="PatientName" runat="server" AutoGenerateColumns="False" 
                                                                                     ForeColor="#333333" Font-Size="Small" CssClass="w-100p gridView"  
                                                                                    meta:resourcekey="gvOrgwiseDispatchResource1">
                                                                                    <Columns>
                                                                                    
                                                                                     <asp:TemplateField HeaderText="S.No" 
                                                                                            meta:resourcekey="TemplateFieldResourceSno41">
                                                                                             <HeaderStyle Wrap="true" Width="30px" />
                                                                                        <ItemTemplate>
                                                                                        
                                                                                        <asp:Label ID="lblRowId" runat="server" Text='<%# Eval("RowID") %>' 
                                                                                                meta:resourcekey="lblrowidResource1" />
                                                                                         </ItemTemplate>
                                                                                         <ItemStyle  Wrap="true" Width="30px" HorizontalAlign="Center" />
                                                                                    </asp:TemplateField>
                                                                                     <asp:TemplateField HeaderText="Despatch Type"  
                                                                                            meta:resourcekey="TemplateFieldDespatch3" >
                                                                                              <HeaderStyle Wrap="true" Width="50px" />
                                                                                        <ItemTemplate>
                                                                                       
                                                                                        <asp:Label ID="lblDespatchType" runat="server"  Text='<%# Eval("Status") %>' 
                                                                                                meta:resourcekey="lblDespatchType1" />
                                                                                         </ItemTemplate>
                                                                                         <ItemStyle  Wrap="true" Width="50px" />
                                                                                    </asp:TemplateField>
                                                                                     
                                                                                    <asp:TemplateField HeaderText="Visit Number" 
                                                                                            meta:resourcekey="TemplateFieldResource41">
                                                                                            <HeaderStyle Wrap="true" Width="50px" />
                                                                                        <ItemTemplate>
                                                                                        
                                                                                        <asp:Label ID="lblPatientVisitId" runat="server"  
                                                                                                Text='<%# Eval("VisitState") %>' 
                                                                                                meta:resourcekey="lblPatientVisitIdResource1" />
                                                                                         </ItemTemplate>
                                                                                         <ItemStyle  Wrap="true" Width="50px" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Reg Location" meta:resourcekey="RegLocationResource4" Visible="False" >
                                                                                     <HeaderStyle Wrap="true" Width="100px" HorizontalAlign ="Center"  />
                                                                                        <ItemTemplate>
                                                                                        <asp:Label ID="lblLocation" runat="server"  Text='<%# Eval("Location") %>' 
                                                                                                meta:resourcekey="lblLocationResource1" />
                                                                                         </ItemTemplate>
                                                                                         <ItemStyle  Wrap="true" Width="100px" />
                                                                                    </asp:TemplateField>
                                                                                     <asp:BoundField  HeaderText="Reg Date" DataField="RegistrationDate" DataFormatString="{0:dd/MM/yy hh:mm tt}" >
                                                                                     <HeaderStyle Width="70px" Wrap="true"   />
                                                                                     </asp:BoundField>
                                                                                   <asp:TemplateField HeaderText="Service Details" 
                                                                                            meta:resourcekey="ServiceDetails2">
                                                                                            <HeaderStyle Wrap="true" Width="100px" />
                                                                                        <ItemTemplate>
                                                                                        
                                                                                        <asp:Label ID="lblServicedetails" runat="server"  
                                                                                                Text='<%# Eval("InvestigationName") %>' 
                                                                                                meta:resourcekey="lblServicedetailsResource1" />
                                                                                         </ItemTemplate>
                                                                                           <ItemStyle  Wrap="true" Width="100px" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Reg Remarks" 
                                                                                            meta:resourcekey="RegRemarksResource2">
                                                                                            <HeaderStyle Wrap="true" Width="70px" />
                                                                                        <ItemTemplate>
                                                                                        <asp:Label ID="lblRegRemarks" runat="server"  
                                                                                                Text='<%# Eval("Description") %>' 
                                                                                                meta:resourcekey="lblRegRemarksResource1" />
                                                                                         </ItemTemplate>
                                                                                         <ItemStyle Wrap="true" Width="70px" />
                                                                                       </asp:TemplateField>
                                                                                      <asp:TemplateField HeaderText="Due Amount" 
                                                                                            meta:resourcekey="DueAmountResource3">
                                                                                            <HeaderStyle Wrap="true" Width="60px" />
                                                                                        <ItemTemplate>
                                                                                        
                                                                                        <asp:Label ID="lblDueAmount" runat="server"  Text='<%# Eval("Due") %>' 
                                                                                                meta:resourcekey="lblDueAmountResource1" />
                                                                                         </ItemTemplate>
                                                                                         <ItemStyle  Wrap="true" Width="60px" HorizontalAlign="Center"  />
                                                                                    </asp:TemplateField>
                                                                                      <asp:TemplateField HeaderText="Patient Name" 
                                                                                            meta:resourcekey="patientNameResource3">
                                                                                            <HeaderStyle Wrap="true" Width="70px" />
                                                                                        <ItemTemplate>
                                                                                        
                                                                                        <asp:Label ID="lblPatientName" runat="server"  Text='<%# Eval("PatientName") %>' 
                                                                                                meta:resourcekey="lblPatientNameResource1" />
                                                                                         </ItemTemplate>
                                                                                         <ItemStyle  Wrap="true" Width="70px" />
                                                                                    </asp:TemplateField>
                                                                                     <asp:TemplateField HeaderText="Address" 
                                                                                            meta:resourcekey="AddressResource3" Visible="False" >
                                                                                            <HeaderStyle Wrap="true" Width="100px" />    
                                                                                        <ItemTemplate>
                                                                                        
                                                                                        <asp:Label ID="lblAddress" runat="server"  Text='<%# Eval("Address") %>' 
                                                                                                meta:resourcekey="lblAddressResource1" />
                                                                                         </ItemTemplate>
                                                                                         <ItemStyle  Wrap="true" Width="100px" />
                                                                                    </asp:TemplateField>
                                                                                     <asp:TemplateField HeaderText="Contact No" Visible="False"  
                                                                                            meta:resourcekey="ContactNo2">
                                                                                             <ItemStyle  Wrap="true" Width="80px" />
                                                                                        <ItemTemplate>
                                                                                        <asp:Label ID="lblContactNo" runat="server"  
                                                                                                Text='<%# Eval("MLCNo") %>' 
                                                                                                meta:resourcekey="lblContactNoResource1" />
                                                                                               
                                                                                         </ItemTemplate>
                                                                                          <ItemStyle  Wrap="true" Width="80px" />
                                                                                    </asp:TemplateField>
                                                                                     <asp:TemplateField HeaderText="Despatch Personnel" 
                                                                                            meta:resourcekey="DespatchPersonnelResource10">
                                                                                            <HeaderStyle Wrap="true" Width="100px" />
                                                                                        <ItemTemplate>
                                                                                        
                                                                                        <asp:Label ID="lblReceiverName" runat="server"  Text='<%# Eval("ReceiverName") %>' 
                                                                                                meta:resourcekey="lblReceiverNameResource1" />
                                                                                         </ItemTemplate>
                                                                                         <ItemStyle  Wrap="true" Width="100px"  HorizontalAlign ="Center" />
                                                                                    </asp:TemplateField>
                                                                                     <asp:TemplateField HeaderText="Receivd By" 
                                                                                            meta:resourcekey="AcknowledgedByResource10">
                                                                                            <HeaderStyle Wrap="true" Width="100px" />
                                                                                        <ItemTemplate>
                                                                                        
                                                                                        <asp:Label ID="lblAcknowledgedBy" runat="server"
                                                                                                meta:resourcekey="lblAcknowledgedBy1" />
                                                                                         </ItemTemplate>
                                                                                         <ItemStyle  Wrap="true" Width="100px" />
                                                                                    </asp:TemplateField>
                                                                                     <asp:TemplateField HeaderText="ACK Remarks" 
                                                                                            meta:resourcekey="ACKRemarksResource10">
                                                                                        <ItemTemplate>
                                                                                        
                                                                                        <asp:Label ID="lblACKRemarks" runat="server"  
                                                                                                meta:resourcekey="lblACKRemarksResource1" />
                                                                                         </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                                                                                                        
                                                                                    
                                                                                     
                                                                                   <%-- <asp:TemplateField HeaderText="InvestigationName" >
                                                                                        <ItemTemplate>
                                                                                        
                                                                                        <asp:Label ID="lblinvestigationname" runat="server"  Text='<%# Eval("InvestigationName") %>' 
                                                                                                 />
                                                                                         </ItemTemplate>
                                                                                    </asp:TemplateField>--%>
                                                                                     <asp:TemplateField HeaderText="ClientId" Visible="False" 
                                                                                            meta:resourcekey="TemplateFieldResource5">
                                                                                        <ItemTemplate>
                                                                                        
                                                                                        <asp:Label ID="lblClientId" runat="server"  Text='<%# Eval("ClientId") %>' 
                                                                                                meta:resourcekey="lblClientIdResource1" />
                                                                                         </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                     <asp:TemplateField HeaderText="ClientName" Visible="False" 
                                                                                            meta:resourcekey="TemplateFieldResource6">
                                                                                        <ItemTemplate>                                                                                        
                                                                                        <asp:Label ID="lblClientName" runat="server"  Text='<%# Eval("ClientName") %>' 
                                                                                                meta:resourcekey="lblClientNameResource1" />
                                                                                         </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                     <asp:TemplateField HeaderText="RefphysicianName" Visible="False"
                                                                                            meta:resourcekey="TemplateFieldResource7">
                                                                                        <ItemTemplate>
                                                                                        
                                                                                        <asp:Label ID="lblRefphysicianName" runat="server"  
                                                                                                Text='<%# Eval("RefphysicianName") %>' 
                                                                                                meta:resourcekey="lblRefphysicianNameResource1" />
                                                                                         </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                  
                                                                                     <asp:TemplateField HeaderText="ReferingPhysicianID" Visible="False" 
                                                                                            meta:resourcekey="TemplateFieldResource8">
                                                                                        <ItemTemplate>
                                                                                        
                                                                                        <asp:Label ID="lblReferingPhysicianID" runat="server"  
                                                                                                Text='<%# Eval("ReferingPhysicianID") %>' 
                                                                                                meta:resourcekey="lblReferingPhysicianIDResource1" />
                                                                                         </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                     <asp:TemplateField HeaderText="Status"  Visible="False"  meta:resourcekey="TemplateFieldResource9">
                                                                                        <ItemTemplate>
                                                                                        
                                                                                        <asp:Label ID="lblStatus" runat="server"  Text='<%# Eval("Status") %>' 
                                                                                                meta:resourcekey="lblStatusResource1" />
                                                                                         </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                     <asp:TemplateField HeaderText="clientTypeID" Visible="False" 
                                                                                            meta:resourcekey="TemplateFieldResource11">
                                                                                        <ItemTemplate>
                                                                                        
                                                                                        <asp:Label ID="lblclientTypeID" runat="server"  Text='<%# Eval("clientTypeID") %>' 
                                                                                                meta:resourcekey="lblclientTypeIDResource1" />
                                                                                         </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    
                                                                                     <asp:TemplateField HeaderText="clientTypeName" Visible="False" 
                                                                                            meta:resourcekey="TemplateFieldResource12">
                                                                                        <ItemTemplate>
                                                                                        
                                                                                        <asp:Label ID="lblclientTypeName" runat="server"  
                                                                                                Text='<%# Eval("clientTypeName") %>' 
                                                                                                meta:resourcekey="lblclientTypeNameResource1" />
                                                                                         </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    <%-- <asp:TemplateField HeaderText="RegistrationDate" 
                                                                                            meta:resourcekey="TemplateFieldResource13">
                                                                                        <ItemTemplate>
                                                                                    
                                                                                                  <asp:Label ID="lblRegistrationDate" runat="server"  Text='<%# Eval("RegistrationDate")%>' 
                                                                                                      />
                                                                                         </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    --%>
                                                                                    
                                                                            
                                                                                    
                                                                                    
                                                                                    <%-- <asp:TemplateField HeaderText="SampleCollectedDate" 
                                                                                            meta:resourcekey="TemplateFieldResource14">
                                                                                        <ItemTemplate>
                                                                                        
                                                                                        <asp:Label ID="lblSampleCollectedDate" runat="server"  
                                                                                                Text='<%# Eval("SampleCollectedDate") %>' 
                                                                                                meta:resourcekey="lblSampleCollectedDateResource1"  />
                                                                                         </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    
                                                                                     <asp:TemplateField HeaderText="ApprovedAt" 
                                                                                            meta:resourcekey="TemplateFieldResource15">
                                                                                        <ItemTemplate>
                                                                                        
                                                                                        <asp:Label ID="lblApprovedAt" runat="server"  Text='<%# Eval("ApprovedAt") %>' 
                                                                                                meta:resourcekey="lblApprovedAtResource1" />
                                                                                         </ItemTemplate>
                                                                                    </asp:TemplateField>--%>
                                                                                    <%-- <asp:BoundField  HeaderText="DispatchDate" DataField="DespatchDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" />
                                                                                   --%>  <%-- <asp:TemplateField HeaderText="DispatchDate" 
                                                                                            meta:resourcekey="TemplateFieldResource161">
                                                                                        <ItemTemplate>
                                                                                        
                                                                                        <asp:Label ID="lblDespatchDate" runat="server"  Text='<%# Eval("DespatchDate") %>' 
                                                                                           meta:resourcekey="lblDespatchDateResource11" />
                                                                                         </ItemTemplate>
                                                                                    </asp:TemplateField>--%>
                                                                                    
                                                                                                                                                                      
                                                                                    </Columns>
                                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                                </asp:GridView>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                                                     
                                                
                                                
                                                
                                                </div>
                                                <table class="w-100p">
                                                <tr id="GrdFooter" runat="server" style="display: none;" class="dataheaderInvCtrl">
                                                                        <td class="defaultfontcolor a-center">
                                                                            <asp:Label ID="Label4" runat="server" Text="Page"></asp:Label><asp:Label ID="lblCurrent"
                                                                                runat="server" Font-Bold="True" ForeColor="Red"></asp:Label><asp:Label ID="Label5"
                                                                                    runat="server" Text="Of"></asp:Label><asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label><asp:Button
                                                                                        ID="btnPrevious" runat="server" Text="Previous" CssClass="btn" OnClick="btnPrevious_Click" />
                                                                            <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn" OnClick="btnNext_Click" />
                                                                            <asp:HiddenField ID="hdnCurrent" runat="server" />
                                                                            <asp:Label ID="Label6" runat="server" Text="Enter The Page To Go:"></asp:Label><asp:TextBox
                                                                                ID="txtpageNo" runat="server" Width="30px"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                                                AutoComplete="off"></asp:TextBox><asp:Button ID="Button1" runat="server" Text="Go"
                                                                                    CssClass="btn" OnClick="btnGo1_Click" OnClientClick="javascript:return validatePageNumber();" />
                                                                            <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                                                                        </td>
                                                                    </tr>
                                                </table>
                                                
                                                </div>
                                            
                                            
                                        <%--</ContentTemplate>
                                         <Triggers>
                                            <asp:PostBackTrigger ControlID="imgBtnXL" />
                                            <asp:PostBackTrigger ControlID="lnkExportXL" />
                                        </Triggers>
                                    </asp:UpdatePanel>--%>
                                </td>
                            </tr>
                        </table>
                    </div>
      <Attune:Attunefooter ID="Attunefooter" runat="server" />        
    </form>
<script language="javascript" type="text/javascript">

    function clearContextText() {
        $('#divOPDWCR').hide();

    }
    function SetContextKey() {
        var deptName = document.getElementById('drplstPerson').options[document.getElementById('drplstPerson').selectedIndex].text;
        var deptCode = document.getElementById('drplstPerson').options[document.getElementById('drplstPerson').selectedIndex].value;
        var depart = document.getElementById('hdnAddDepart').value.split('^');
        var flag = 0;
        for (var i = 0; i < depart.length; i++) {
            if (depart[i] != "") {
                if (deptCode == depart[i].split('~')[1]) {
                    flag = 1;
                    break;
                }
            }
        }
        if (flag == 1) {
            document.getElementById('hdnEmpID').value = "-1";

        }
        else {

            $find('AutoCompleteExtender3').set_contextKey(deptCode);
        }
        return;
    }

    function alpha(e) {
        var k;
        document.all ? k = e.keyCode : k = e.which;
        return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || k == 46 || (k >= 48 && k <= 57));
    }


    function GetEmpID(source, eventArgs) {
        var strVal = eventArgs.get_value();
        document.getElementById('txtPersonName').value = eventArgs.get_text();
        document.getElementById('hdnEmpID').value = strVal.split('~')[0].trim();
    }
    function SelectedClientID(source, eventArgs) {

        document.getElementById('<%= hdnSelectedClientID.ClientID %>').value = eventArgs.get_value();
    }
    function ClearValue(obj) {
        if (document.getElementById(obj).value == "") {
            document.getElementById('<%= hdnSelectedClientID.ClientID %>').value = "0";
        }
    }
    function ClearFields() {
        if (document.getElementById('<%= txtReferringHospital.ClientID %>').value.trim() == "") {
            document.getElementById('<%= hdnReferringHospitalID.ClientID %>').value = "0";
        }
        if (document.getElementById('<%= txtReferringPhysician.ClientID %>').value.trim() == "") {
            document.getElementById('<%= hdnPhysicianID.ClientID %>').value = "0";
        }
    }
    function GetReferingPhysicianID(source, eventArgs) {
        document.getElementById('<%= txtReferringPhysician.ClientID %>').value = eventArgs.get_text();
        document.getElementById('<%= hdnPhysicianID.ClientID %>').value = eventArgs.get_value().split('^')[0];
    }
    function GetReferingOrgID(source, eventArgs) {
        document.getElementById('<%= txtReferringHospital.ClientID %>').value = eventArgs.get_text();
        document.getElementById('<%= hdnReferringHospitalID.ClientID %>').value = eventArgs.get_value();
    }
    function validateToDate() {

        if (document.getElementById('<%= txtFDate.ClientID %>').value == '') {
            alert('Provide / select value for From date');
            document.getElementById('<%= txtFDate.ClientID %>').focus();
            return false;
        }
        if (document.getElementById('<%= txtTDate.ClientID %>').value == '') {
            alert('Provide / select value for To date');
            document.getElementById('<%= txtTDate.ClientID %>').focus();
            return false;
        }
    }

    function popupprint() {
        document.getElementById("divHeader").style.display = "block";
        var prtContent = document.getElementById('prnReport');
        var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
        //alert(WinPrint);
        WinPrint.document.write(prtContent.innerHTML);
        WinPrint.document.close();
        WinPrint.focus();
        WinPrint.print();
        WinPrint.close();
    }
    </script>
<script language="javascript" type="text/javascript">

    function pageLoad() {
        $("#txtFDate").datepicker({
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '2008:2050'
        }); // Will run at every postback/AsyncPostback
        $("#txtTDate").datepicker({
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '2008:2050'
        });
        
        
    }
    function setContextClientValue() {
        var sval = document.getElementById('<%= ddlClientType.ClientID %>').value + "^" + document.getElementById('<%= ddlTrustedOrg.ClientID %>').value;
        $find('<%= AutoCompleteExtenderClient.ClientID %>').set_contextKey(sval);
        return false;
    }
    function SetContextValue() {
        var sval = document.getElementById('<%= ddlTrustedOrg.ClientID %>').value;
        $find('<%= AutoCompleteExtenderReferringHospital.ClientID %>').set_contextKey(sval);
        $find('<%= AutoCompleteExtenderReferringPhysician.ClientID %>').set_contextKey("RPH^" + sval);
        return false;
    }

//    $(function() {
//        $("#txtFDate").datepicker({
//            changeMonth: true,
//            changeYear: true,
//            maxDate: 0,
//            yearRange: '2008:2050'
//        });
//        $("#txtTDate").datepicker({
//            changeMonth: true,
//            changeYear: true,
//            maxDate: 0,
//            yearRange: '2008:2050'
//        })
//    });
    $(function() {
        $("#txtFDate").datepicker({
            dateFormat: 'dd/mm/yy',
            defaultDate: "+1w",
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '1900:2100',
            onClose: function(selectedDate) {
                $("#txtTDate").datepicker("option", "minDate", selectedDate);

                var date = $("#txtFDate").datepicker('getDate');
                //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                // $("#txtTo").datepicker("option", "maxDate", d);

            }
        });
        $("#txtTDate").datepicker({
            dateFormat: 'dd/mm/yy',
            defaultDate: "+1w",
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '1900:2100',
            onClose: function(selectedDate) {
                $("#txtFDate").datepicker("option", "maxDate", selectedDate);
            }
        })
    }); 

                      
</script>
</body>
</html>
<%--<script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>--%>



                      

