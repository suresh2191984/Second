<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LotManagement.aspx.cs" Inherits="QMS_LotManagement" EnableEventValidation ="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AttuneHeaderV1.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1">
    <title>Lot Management</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
        name='viewport'>
    <!-- Bootstrap 3.3.4 -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- FontAwesome 4.3.0 -->
    <link href="bootstrap/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Ionicons 2.0.0 -->
    <!--<link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />-->
    <!-- bootstrap datepicker -->
    <link href="Script/bootstrap-toggle.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css" type="text/css" />
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="plugins/iCheck/all.css" type="text/css">
    <!-- Include the plugin's CSS and JS: -->
    <link rel="stylesheet" href="../qms/plugins/multiselect/css/bootstrap-multiselect.css" type="text/css" />
    <!-- Theme style -->
    <link href="dist/css/AdminLTE.css" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins 
         folder instead of downloading all of them to reduce the load. -->
    <link href="dist/css/skins/_all-skins.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/animated.css" rel="stylesheet" type="text/css" />
    <link href="Script/bootstrap-toggle.min.css" rel="stylesheet" type="text/css" />
    <link href="dist/css/custom.css" rel="stylesheet" type="text/css" />
    <link href="dataTable/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <link href="Script/bootstrap-toggle.min.css" rel="stylesheet" type="text/css" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style type="text/css">
        .hide_Column
        {
            display: none;
        }
         .multiselect-container
        {
            max-height: 250px; /* you can change as you need it */
            overflow: auto;
        }
        .Red
        {
            color:Red;
        }
    </style>
</head>
<body class="skin-black-light sidebar-mini">
    <div class="wrapper">
        <form id="form1" runat="server" enctype="multipart/form-data" method="post">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="test" runat="server" UpdateMode="Always">
            <ContentTemplate>
             <uc1:MainHeader ID="MainHeader" runat="server" />
   
                <!-- Content Wrapper. Contains page content -->
                <div class="content-wrapper">
                    <!-- Content Header (Page header) -->
                    <!-- Main content -->
                    <section class="content">
            
          <div class="fadeindown">
           <div class="row">
                <div class="col-md-12">
                     <h4 class="strong">Lot Management</h4>
                </div>
            </div>
          <!-- Tab -->
						<div class="nav-tabs-custom">
							<ul class="nav nav-tabs">
							  <li class="active"><a data-toggle="tab" href="#tab_1" class="uniquetestcode">Vendor</a></li>
							  <li><a data-toggle="tab" href="#tab_2" class="uniquetestcode">Manufacturer</a></li>
							  <li><a data-toggle="tab" href="#tab_3" class="uniquetestcode">Lots</a></li>
							</ul>
							<div class="tab-content tab-scroll">
							  <div id="tab_1" class="tab-pane active">
								 <div class="row">
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                 <asp:Label ID="lblVendorName"  runat="server" Text="Vendor Name" localize="LotManagement_lblVendorName"></asp:Label>
                                                 <span class="Red">*</span>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:TextBox ID="txtVendorName" Val-Key="VendorName" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:Label ID="lblVendorCode" runat="server" Text="Vendor Code" localize="LotManagement_lblVendorCode"></asp:Label>
                                                <span class="Red">*</span>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                           <div class="input-group">
                                                 <asp:TextBox ID="txtVendorCode" Val-Key="Vendorcode" runat="server" CssClass="form-control" onkeyup="uniquevalues('txtVendorCode','VendorCode',event);" ></asp:TextBox>
                                                                                                     <span class="input-group-btn">
        <button class=" form-control btn-primary Check_Testcode" type="button" id="check_vendor" ><i class="fa fa-question" ></i></button>
      </span> 
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:Label ID="lblPanNo" runat="server" Text="PAN No" localize="LotManagement_lblPanNo"></asp:Label>
                                            </div>
                                    </div>
                                     <div class="col-xs-6 col-sm-2 col-md-2">
                                           <asp:TextBox ID="txtPanNo" runat="server" Val-Key="PanNo" CssClass="form-control" ></asp:TextBox>
                                    </div>
                                    </div>
                                    <div class="row">
                                    <!--Row-->
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:Label ID="lblSpocName" runat="server" Text="SPOC Name" localize="LotManagement_lblSpocName"></asp:Label>
                                                <span class="Red">*</span>
                                            </div>
                                    </div>
                                     <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                 <asp:TextBox ID="txtSpocName" Val-Key="SPOCName" runat="server" CssClass="form-control" onkeypress="return SpecialCharRestrictionwithspace(event)" ></asp:TextBox>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:Label ID="lblEmailId" runat="server" Text="Email ID" localize="LotManagement_lblEmailId" ></asp:Label>
                                                <span class="Red">*</span>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                            <%--<input type="text"id="txtEmailId" runat="server" class="form-control"  />--%>
                                                 <asp:TextBox ID="txtEmailId" Val-Key="EmailID" runat="server" CssClass="form-control"  onkeypress="return alpha(event,email+bksp+alt)"></asp:TextBox>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:Label ID="lblMobileNo" runat="server" Text="Mobile No" localize="LotManagement_lblMobileNo"></asp:Label>
                                            </div>
                                    </div>
                                     <div class="col-xs-6 col-sm-2 col-md-2">
                                         <div class="form-group">
                                            <asp:TextBox ID="txtMobileNo" Val-Key="MobileNumber" runat="server"  CssClass="form-control" ></asp:TextBox>
                                         </div>
                                    </div>
                                    </div>
                                    <div class="row">
                                    <!--Row-->
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:Label ID="lblLandlineNo" runat="server" Text="Landline No" localize="LotManagement_lblLandlineNo"></asp:Label>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                       <div class="form-group">
                                             <asp:TextBox ID="txtLandlineNo" Val-Key="Landlineno"  runat="server" CssClass="form-control" ></asp:TextBox>
                                         </div>
                                    </div>
                                     <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:Label ID="lblFaxNo" runat="server" Text="Fax No" localize="LotManagement_lblFaxNo"></asp:Label>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                       <div class="form-group">
                                           <asp:TextBox ID="txtFaxNo" runat="server" Val-Key="FaxNo" CssClass="form-control" ></asp:TextBox>
                                         </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:Label ID="lblCountry" runat="server" Text="Country" localize="LotManagement_lblCountry"></asp:Label>
                                                <span class="Red">*</span>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                       <div class="form-group">
                                            <asp:DropDownList ID="ddlCountry" runat="server" CssClass="form-control">
                                                <%-- <asp:ListItem Text="India"></asp:ListItem>
                                                 <asp:ListItem Text="SriLanka"></asp:ListItem>--%>
                                             </asp:DropDownList>
                                         </div>
                                    </div>
                                    <!--Row-->
                                   </div>
                                    <div class="row">
                                    <!--Row-->
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:Label ID="lblState" runat="server" Text="State" localize="LotManagement_lblState"></asp:Label>
                                                <span class="Red">*</span>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                       <div class="form-group">
                                              <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control">
                                              <asp:ListItem Value="0">---select---</asp:ListItem>
                                               <%--  <asp:ListItem Text="TamilNadu"></asp:ListItem>
                                                 <asp:ListItem Text="Kerala"></asp:ListItem>
                                                 <asp:ListItem Text="Andra"></asp:ListItem>
                                                 <asp:ListItem Text="Karnadaka"></asp:ListItem>--%>
                                             </asp:DropDownList>
                                         </div>
                                    </div>
                                     <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:Label ID="lblCity" runat="server" Text="City" localize="LotManagement_lblCity"></asp:Label>
                                                <span class="Red">*</span>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                       <div class="form-group">
                                            <asp:TextBox ID="txtCity" Val-Key="CityName" runat="server" CssClass="form-control" />
                                       </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:Label ID="lblPostalCode" runat="server" Text="Postal/Zip Code" localize="LotManagement_lblPostalCode"></asp:Label>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                       <div class="form-group">
                                            <asp:TextBox ID="txtPostalCode" Val-Key="PostalCode" runat="server"  CssClass="form-control"></asp:TextBox>
                                         </div>
                                    </div>
                                    <!--Row-->
                                   </div>
                                     <div class="row">
                                    <!--Row-->
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:Label ID="lblAddress" runat="server" Text="Address" localize="LotManagement_lblAddress"></asp:Label>
                                                <span class="Red">*</span>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                       <div class="form-group">
                                              <asp:TextBox ID="txtAddress" Val-Key="Address" runat="server" TextMode="MultiLine" CssClass="form-control" ></asp:TextBox>
                                         </div>
                                    </div>
                                    <%-- <div class="col-xs-12 col-sm-8 col-md-8">
                                            <div class="form-group">
                                                <label>
                                                  <input type="checkbox" class="minimal">
                                                </label>
                                                <asp:Label ID="lblCheckAddress" runat="server" Text="Check This Current Address is same as this"></asp:Label>
                                            </div>
                                    </div>--%>
                                    
                                    <!--Row-->
                                   </div>
                                   <div class="row">
                                        <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:Label ID="lblTerms" runat="server" Text="Terms & Conditions" localize="LotManagement_lblTerms"></asp:Label>
                                            </div>
                                        </div>
                                        <div class="col-xs-6 col-sm-6 col-md-6">
                                            <div class="form-group">
                                                  <asp:TextBox ID="txtTerms" Val-Key="Termsandconditions" runat="server" Rows="5" Columns="10" TextMode="MultiLine" CssClass="form-control" ></asp:TextBox>
                                            </div>
                                         </div>
                                    </div>
                                <!-- Row -->
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group text-center">
                                             <input  id="btnClear" type ="button"  class="btn btn-default" value="Clear" onclick="ClearVendor();" localize="LotManagement_btnClear" />
                                                <input id="btnSave" type ="button"  class="btn btn-success" value="Save" localize="LotManagement_btnSave" />
                                                <input id="btnupdate" type ="button"   class="btn btn-success" value="Update" style="display:none" localize="LotManagement_btnupdate" /> 
                                        </div>
                                    </div>
                                </div>
                                <!-- Row -->
                              <%--  <div class="row slideinleft">
                                    <div class="form-group text-center">
                                    <div class="col-xs-6 col-sm-3 col-md-2">
                                       <div class="form-group">
                                         <div class="icon-addon addon-md">
                                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search"></asp:TextBox>
                                             <asp:Label ID="lblSearch2" runat="server" CssClass="glyphicon glyphicon-search"></asp:Label>
                                        </div>
                                       </div>
                                       </div>
                                    </div>
                                </div>--%>
                                  <!-- Row -->
                                     <div class="gridTable bounceinup" id="VendorDetails">
                                            <div class="table-responsive">
                                              <table class="table tbl-grid table-bordered form-inline table-striped" id="tblVendorDetails">
                                                  <thead>
                                                        <tr>
                                                            <th class="hide_Column">VendorID</th>
                                                            <th localize="LotManagement_lblVendorName">Vendor Name</th>
                                                            <th localize="LotManagement_lblVendorCode">Vendor Code</th>
                                                            <th localize="LotManagement_lblSpocName">SPOC Name</th>
                                                            <th class="hide_Column">PanNo</th>
                                                            <th class="hide_Column">Landlineno</th>
                                                             <th class="hide_Column">FaxNo</th>
                                                             <th class="hide_Column">PostalCode</th>
                                                             <th class="hide_Column">TempAddress</th>
                                                             <th class="hide_Column">Termsandconditions</th>
                                                             <th class="hide_Column">CountryID</th>
                                                             <th class="hide_Column">StateID</th>
                                                             <th class="hide_Column">CityID</th>
                                                            <th localize="LotManagement_lblManufactEmail">Email ID</th>
                                                            <th localize="LotManagement_lblMobileNo">Mobile No</th>
                                                            <th localize="LotManagement_lblCity">City</th>
                                                            <th localize="Edit">Edit</th>
                                                            <th class="hide_Column">Delete</th>
                                                            <th localize="Status">Status</th>
                                                        </tr>
                                                  </thead>
                                                  <tbody>
                                                     
                                                    </tbody>
                                              </table>
                                           </div>
                                    </div>
                                    
							  </div><!-- /.tab-pane -->
							  <div id="tab_2" class="tab-pane">
								<div id="divManu">
								<div class="row">
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                 <asp:Label ID="lblManufactName" runat="server" Text="Manufacturer Name" localize="LotManagement_lblManufactName"></asp:Label>
                                                  <span class="Red">*</span>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:TextBox ID="txtManufactName" Val-Key="ManufacturerName" runat="server" CssClass="form-control"   ></asp:TextBox>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:Label ID="lblManufactCode" runat="server" Text="Manufacturer Code" localize="LotManagement_lblManufactCode"></asp:Label>
                                                 <span class="Red">*</span>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                           <div class="input-group">
                                                 <asp:TextBox ID="txtManufactCode" Val-Key="ManufacturerCode" runat="server" CssClass="form-control"  onkeyup="uniquevalues('txtManufactCode','Manufacture',event);"  ></asp:TextBox>
                                                                                                                                        <span class="input-group-btn">
        <button class=" form-control btn-primary Check_Testcode" type="button" id="Check_Manucode" ><i class="fa fa-question" ></i></button>
      </span> 
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:Label ID="lblManufactEmail" runat="server" Text="Email"></asp:Label>
                                            </div>
                                    </div>
                                     <div class="col-xs-6 col-sm-2 col-md-2">
                                           <asp:TextBox ID="txtManufactEmail" Val-Key="EmailID" runat="server" CssClass="form-control"  onkeypress="return alpha(event,email+bksp+alt)"></asp:TextBox>
                                    </div>
                                    </div>
                                    <div class="row">
                                        <!--Row-->
                                        <div class="col-xs-6 col-sm-2 col-md-2">
                                                <div class="form-group">
                                                    <asp:Label ID="lblManufactPhone" runat="server" Text="Phone" localize="LotManagement_lblManufactPhone"></asp:Label>
                                                </div>
                                        </div>
                                         <div class="col-xs-6 col-sm-2 col-md-2">
                                                <div class="form-group">
                                                     <asp:TextBox ID="txtManufactPhone" Val-Key="MobileNumber"  onkeypress="return OnlyNumbers(event);" onkeyup="return LimitTextValidation(txtManufactPhone, 12)"  runat="server" CssClass="form-control"></asp:TextBox>
                                                </div>
                                        </div>
                                   
                                    </div>
                                   
                                 
                                <!-- Row -->
                                <div class="row">
                                    <div class="form-group text-center">
                                         <input  id="btnManuFactClear" type ="button"  class="btn btn-default" value="Clear" onclick="clear1();" localize="LotManagement_btnManuFactClear" />
                                            <input id="btnManuFactSave" type ="button"  class="btn btn-success" value="Save" localize="LotManagement_btnManuFactSave" />
                                            <input id="btnManuFactUpdate" type ="button"  class="btn btn-success" value="Update" style="display:none;" localize="LotManagement_btnManuFactUpdate" />
                                    </div>
                                </div>
                                <!-- Row -->
                                <%--<div class="row slideinleft">
                                    <div class="form-group text-center">
                                    <div class="col-xs-6 col-sm-3 col-md-2">
                                       <div class="form-group">
                                         <div class="icon-addon addon-md">
                                                <asp:TextBox ID="txtManufactSearch" runat="server" CssClass="form-control" placeholder="Search"></asp:TextBox>
                                             <asp:Label ID="lblManufactSearch" runat="server" CssClass="glyphicon glyphicon-search"></asp:Label>
                                        </div>
                                       </div>
                                       </div>
                                    </div>
                                </div>--%>
                                  <!-- Row -->
                                  </div>
                                     <div class="gridTable bounceinup" id="Manufacturerdetails">
                                            <div class="table-responsive" >
                                              <table class="table tbl-grid table-bordered form-inline table-striped" id="tblManufacturerdetails">
                                                  <thead>
                                                        <tr>
                                                            <th class="hide_Column">MacID</th>
                                                            <th localize="LotManagement_lblManufactName">Manufacturer Name</th>
                                                            <th localize="LotManagement_lblManufactCode">Manufacturer Code</th>
                                                            <th localize="LotManagement_lblEmailId">Email</th>
                                                            <th localize="LotManagement_lblManufactPhone">Phone</th>
                                                            <th localize="Edit">Edit</th>
                                                            <th localize="Status">Status</th>
                                                        </tr>
                                                  </thead>
                                                  <tbody>
                                                     
                                                    </tbody>
                                              </table>
                                           </div>
                                    </div>
								
							  </div><!-- /.tab-pane -->
							  <div id="tab_3" class="tab-pane">
								
								<div class="row">
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                 <asp:Label ID="lblLotName" runat="server" Text="Lot Name" localize="LotManagement_lblLotName"></asp:Label>
                                            <span class="Red">*</span>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:TextBox ID="txtLotName" Val-Key="LotName" runat="server" CssClass="form-control" ></asp:TextBox>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:Label ID="lblLotNo" runat="server" Text="Lot Number" localize="LotManagement_lblLotNo"></asp:Label>
                                            <span class="Red">*</span>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                           <div class="input-group">
                                                 <asp:TextBox ID="txtLotNo" Val-Key="LotCode" runat="server" CssClass="form-control"  onkeyup="uniquevalues('txtLotNo','LotNumber',event);" ></asp:TextBox>
                                                                <span class="input-group-btn">
        <button class=" form-control btn-primary Check_Testcode" type="button" id="Check_Testcode" ><i class="fa fa-question" ></i></button>
      </span> 
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:Label ID="lblManufacturer" runat="server" Text="Manufacturer" localize="LotManagement_lblManufacturer"></asp:Label>
                                            </div>
                                    </div>
                                     <div class="col-xs-6 col-sm-2 col-md-2">
                                           <asp:DropDownList ID="ddlManufacturer" runat="server" CssClass="form-control">
                                                         <%--<asp:ListItem Text="Biorad1"></asp:ListItem>
                                                         <asp:ListItem Text="Biorad1"></asp:ListItem>--%>
                                                     </asp:DropDownList>
                                    </div>
                                    </div>
                                    <div class="row">
                                    <!--Row-->
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:Label ID="lblVendor" runat="server" Text="Vendor" localize="LotManagement_lblVendor"></asp:Label>
                                           <span class="Red">*</span>
                                            </div>
                                    </div>
                                     <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                 <asp:DropDownList ID="ddlVendor" runat="server" CssClass="form-control">
                                                        <%-- <asp:ListItem Text="AIMS"></asp:ListItem>
                                                         <asp:ListItem Text="AIMS"></asp:ListItem>--%>
                                                     </asp:DropDownList>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:Label ID="lblDescription" runat="server" Text="Description" localize="LotManagement_lblDescription"></asp:Label>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                 <asp:TextBox ID="txtDescription" Val-Key="LotDescription" runat="server" CssClass="form-control" ></asp:TextBox>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:Label ID="lblExpiryDate" runat="server" Text="Expiry Date" localize="LotManagement_lblExpiryDate"></asp:Label>
                                            <span class="Red">*</span>
                                            </div>
                                    </div>
                                     <div class="col-xs-6 col-sm-2 col-md-2">
                                         <div class="form-group">
                                               <div class="input-group date">
                                              <asp:TextBox ID="txtExpiryDate" runat="server" ReadOnly="true" CssClass="form-control pull-right"></asp:TextBox>
                                              <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                              </div>
                                            </div>
                                         </div>
                                    </div>
                                    </div>
                                    <div class="row">
                                    <!--Row-->
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:Label ID="lblLevel" runat="server" Text="Level" localize="LotManagement_lblLevel"></asp:Label>
                                           <span class="Red">*</span>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                       <div class="form-group">
                                           <%--  <asp:DropDownList ID="ddlLevel" runat="server" CssClass="form-control">
                                                        <%-- <asp:ListItem Value="1">C1</asp:ListItem>
                                                         <asp:ListItem Value="2">C2</asp:ListItem>
                                                         <asp:ListItem Value="3">C3</asp:ListItem>--%>
                                                     </asp:DropDownList>
                           <asp:DropDownList ID="ddlLevel" runat="server"  CssClass="chosen-select form-control" multiple="multiple" style="width:50%">
                          
                         
                                 </asp:DropDownList>
                                         </div>
                                    </div>
                                     <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <asp:Label ID="Label18" runat="server" Text="Instrument" localize="LotManagement_Label18"></asp:Label>
                                            </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                       <div class="form-group">
                                       <asp:DropDownList ID="ddlAnalyte" runat="server"  CssClass="chosen-select form-control" multiple="multiple" style="width:50%">
                 
                                 </asp:DropDownList>
                                 <span class="Red">*</span>
                                         </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                           </div>
                                    <div class="col-xs-6 col-sm-2 col-md-2">
                                            <div class="form-group">
                                                <label>
                                                  <input type="checkbox" class="minimal" id="LotExpiryID">
                                                </label>
                                                <asp:Label ID="lblLotExpiryAlert" runat="server" Text="Lot Expiry Alert" localize="LotManagement_lblLotExpiryAlert"></asp:Label>
                                            </div>
                                    </div>
                                    
                                    <!--Row-->
                                   </div>
                                 
                                <!-- Row -->
                                <div class="row">
                                    <div class="form-group text-center">
                                         <input id="btnLotsClear" type ="button"  class="btn btn-default"  value="Clear" onclick="ClearLots();" localize="LotManagement_btnLotsClear"/>
                                            <input id="btnLotsSave" type ="button"   class="btn btn-success" value="Save" localize="LotManagement_btnLotsSave"/>
                                            <input id="btnLotsUpdate" type ="button" class="btn btn-success" value="Update" style="display:none;" localize="LotManagement_btnLotsUpdate" />
                                    </div>
                                </div>
                                <!-- Row -->
                              <%--  <div class="row slideinleft">
                                    <div class="form-group text-center">
                                    <div class="col-xs-6 col-sm-3 col-md-2">
                                       <div class="form-group">
                                         <div class="icon-addon addon-md">
                                                <asp:TextBox ID="txtLotsSearch" runat="server" CssClass="form-control" placeholder="Search"></asp:TextBox>
                                             <asp:Label ID="lblLotsSearch" runat="server" CssClass="glyphicon glyphicon-search"></asp:Label>
                                        </div>
                                       </div>
                                       </div>
                                    </div>
                                </div>--%>
                                  <!-- Row -->
                                     <div class="gridTable bounceinup" id="lotDetails">
                                            <div class="table-responsive">
                                              <table class="table tbl-grid table-bordered form-inline table-striped" id="tbllotDetails">
                                                  <thead>
                                                        <tr>
                                                            <th class="hide_Column">LotID</th>
                                                            <th localize="LotManagement_lblLotName">Lot Name</th>
                                                            <th localize="LotManagement_lblLotNo">Lot Number</th>
                                                            <th localize="LotManagement_lblManufacturer">Manufacturer</th>
                                                            <th localize="LotManagement_lblLevel">Level</th>
                                                            <th localize="LotManagement_Label18">Instrument</th>
                                                            <th class="hide_Column">Description</th>
                                                            <th localize="LotManagement_lblExpiryDate">Expiry Date</th>
                                                            <th localize="LotManagement_lblLotExpiryAlert">Lot Expiry Alert</th>
                                                            <th class="hide_Column">VendorName</th>
                                                            <th class="hide_Column">MacID</th>
                                                            <th class="hide_Column">vendorid</th>
                                                           
                                                            <th>Action</th>
                                                            <%--<th>Delete</th>--%>
                                                        </tr>
                                                  </thead>
                                                  <tbody>
                                                     
                                                    </tbody>
                                              </table>
                                           </div>
                                    </div>
								
							  </div><!-- /.tab-pane -->
							</div><!-- /.tab-content -->
						  </div>
         
           
            
            
           </div>
           <asp:HiddenField id="hdnVendorID" runat="server" value=""></asp:HiddenField>
           <asp:HiddenField id="hdnMacID" runat="server" value=""></asp:HiddenField>
           <asp:HiddenField id="hdnLotID" runat="server" value=""></asp:HiddenField>
            </ContentTemplate>
        </asp:UpdatePanel>
        </form>
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    <footer class="main-footer">
        <div class="pull-right hidden-xs">
          <b>Version</b> 2.0
        </div>
        <strong>Copyright &copy; 2016-2017 <a href="http://attunelive.com">Attune</a>.</strong> All rights reserved.
      </footer>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="Script/ControlLength.js" type="text/javascript"></script>
    <script src="plugins/iCheck/icheck.min.js" type="text/javascript"></script>

    <!-- Include the plugin's CSS and JS: -->

    <script src="../QMS/Script/bootstrap-multiselect.js" type="text/javascript"></script>


    <script src="Resource/local_resorce.js" type="text/javascript"></script>

    <script src="plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>

    <!-- AdminLTE App -->

    <script src="dist/js/app.min.js" type="text/javascript"></script>

    <script src="dist/js/animatedfn.js" type="text/javascript"></script>

    <script src="dist/js/animated.js" type="text/javascript"></script>

    <!-- AdminLTE for demo purposes -->

    <script src="dist/js/demo.js" type="text/javascript"></script>

    <script type="text/javascript" src="Script/LotManagement.js"></script>

    <script src="dataTable/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="Script/bootstrap-toggle.min.js" type="text/javascript"></script>
<link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <script src="Script/QC_Common.js" type="text/javascript"></script>
    <script src="Script/moment.js" type="text/javascript"></script>
    <%-- <script src="Script/bootstrap-toggle.min.js" type="text/javascript"></script>--%>

    <script type="text/javascript">
        $(function() {
            //Date picker
//            $('.datepicker').datepicker({
//                autoclose: true
//            });

        $("#txtExpiryDate").datepicker({
                minDate: 1,
                defaultDate: "+1d",
                onSelect: function(theDate) {
                $("#txtExpiryDate").datepicker('option', 'minDate', 'getDate');
                },
                dateFormat: 'dd/mm/yy'
            });
            //iCheck for checkbox and radio inputs
            $('input[type="checkbox"].minimal').iCheck({
                checkboxClass: 'icheckbox_minimal-blue',
                radioClass: 'iradio_minimal-blue'
            });
            
//            $('.multiselect').multiselect({
//                includeSelectAllOption: true,
//                buttonWidth: '100%',
//                maxHeight: 100
//            });
        });
    </script>

</body>
</html>
