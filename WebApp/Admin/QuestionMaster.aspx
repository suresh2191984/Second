<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QuestionMaster.aspx.cs" Inherits="Admin_QuestionMaster" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="../QMS/Script/jquery-2.1.4.min.js" type="text/javascript"></script>

    <script src="../Scripts/FormBuilder/Controls.js" type="text/javascript"></script>
    
   <%-- <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>--%>
    
    
<script type="text/javascript">
    // When the user scrolls down 20px from the top of the document, show the button
    window.onscroll = function() { scrollFunction() };

    function scrollFunction() {
        if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
            document.getElementById("myBtn").style.display = "block";
        } else {
            document.getElementById("myBtn").style.display = "none";
        }
    }

    // When the user clicks on the button, scroll to the top of the document
    function topFunction() {
        //document.body.scrollTop = 0;
        //document.documentElement.scrollTop = 0;
        $('html,body').animate({ scrollTop: 0 }, 'slow');
    }
  

 
</script>
</head>
<body>
    <form id="form1" runat="server">
      <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
          <div class="content">
          <ul id="tabs" class="nav nav-tabs nav-justified">
    <li class="nav-item">
        <a class="nav-link active" data-toggle="tab"  href="#panel1" role="tab">Templates</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" data-toggle="tab" href="#panel2" role="tab">Mapped Templates</a>
    </li>
<%--    <li class="nav-item">
        <a class="nav-link" data-toggle="tab" href="#panel3" role="tab">Contact</a>
    </li>--%>
</ul>
<!-- Tab panels -->
<div class="tab-content card">
    <!--Panel 1-->
    <div class="tab-pane fade in show active" id="panel1" role="tabpanel">
        <br>
     <div  id="divlist">  
    <table id="tblTemplates" class="table table-bordered table-striped">

    <!--Table head-->
    <thead class="mdb-color darken-3">
        <tr class="text-white">
            <th>SNo</th>
            <th>Template Name</th>
            <th>Actions</th>
        </tr>
    </thead>
    <!--Table head-->

    <!--Table body-->
    <tbody>
    
    </tbody>
    <!--Table body-->
    <div clss="row">
 <div class="form-group">
    <button id="btnCreate" class="btn" action="add" onclick="addTemplates(this);">Create New<i class="fa fa-plus" style="padding-left:10px;"></i></button>
    </div>
    </div>
</table>
     </div> 
<div style="display:none;"  id="divCreate" >


<div class="col-lg-4 card card-custom bordered">
   <div class="col-lg-12">
    <div class="form-group">
    <button class="btn" id="btnCancelTemplate" onclick="addTemplates(this);">Close<i class="fa fa-times" style="padding-left:10px;"></i></button>
   <%-- <button type="button" class="btn btn-link">Link</button>--%>
    </div>
</div>
  <div class="col-lg-12">
  <div class="form-group">
    <label>Template Name:</label>
    
    
    </div>
     <div class="form-group">
    
      
      <input type="text" class="form-control" id="txtTemplate"  value="" />
    </div>
    </div>
    <div class="col-lg-12">
  <div class="form-group">
    <label>Description:</label>
    
    
    </div>
     <div class="form-group">
    
      
      <input type="text" class="form-control" id="txDescription"  value="" />
    </div>
    </div>

    <div class="col-lg-6">
    <div class="form-group">
      <label for="inputState">Control Type:</label>
      </div>
      
      <div class="form-group">
      <select id="ddlControl" class="form-control" onclick="">
   <option value="input">TextBox</option>
    <option value="textarea">TextArea</option>
     <option value="select">DropDown</option>
      <option value="radio-group">Radio Group</option>
      <option value="header">Header</option>
       <option value="number">Number</option>
        <option value="NwithUnits">Number With Units</option>
      </select>
    </div>
    
    </div>
   
   <div class="col-lg-12"> 
   <div class="col-lg-3">
     <div style="margin-top:36px;" class="form-group">
    
      <input type="button" id="btnAdd" onclick="getcontrol();"  class="btn btn-primary" value="Add" />
    
  </div>
  
  </div>
   <div class="col-lg-4">
     <div style="margin-top:36px;" class="form-group">
    
      <input  type="button" onclick="onpreviewclick();" class="btn btn-info btn-lg" value="Preview" data-toggle="modal" data-target="#myModal" />
    
  </div>
   </div>
  
   <div class="col-lg-4">
     <div style="margin-top:36px;" class="form-group">
    
      <input type="button" id="btnSaveTemplate" onclick="SaveTemplates();"  class="btn btn-success" value="Add" />
    
  </div>
  
  </div>

   
    
   </div>
   </div>
    <div id="controls-content"  class="col-lg-8 card card-custom card-back">
   <%--<div  class="card-body">

  </div>--%>
<%-- <div class="card-footer text-muted">
        <input  type="button" onclick="onpreviewclick();" class="btn btn-info btn-lg" value="Preview" data-toggle="modal" data-target="#myModal" />
    </div>--%>
  </div>
 </div>
  
    </div>
    <!--/.Panel 1-->
    <!--Panel 2-->
    <div class="tab-pane fade" id="panel2" role="tabpanel">
        <br>
     <div id="divMapList">
        <table id="tblMappedList" class="table table-bordered table-striped">

    <!--Table head-->
    <thead class="mdb-color darken-3">
        <tr class="text-white">
            <th>SNo</th>
            <th>Template Name</th>
            <th>Investigation</th>
            <th>Type</th>
            <th>Actions</th>
        </tr>
    </thead>
    <!--Table head-->

    <!--Table body-->
    <tbody>
    
    </tbody>
    <!--Table body-->
    <div clss="row">
    <div class="form-group">
    <button id="Button1" class="btn" action="add" onclick="addMapping(this);">New Mapping<i class="fa fa-plus" style="padding-left:10px;"></i></button>
    </div>
    </div>
</table>

    </div>
    <div id="divmap" style="display:none;">
     <div clss="row">
    <div class="form-group">
    <button id="Button3" class="btn" action="cancel" onclick="addMapping(this);">Close<i class="fa fa-times" style="padding-left:10px;"></i></button>
    </div>
    </div>
    <div class="col-lg-3">
  <div class="form-group">
    <label>Template:</label>
    
    
    </div>
     <div class="form-group">
    
      
      
            <select id="ddlTemplate" class="form-control" >
   
      </select>
    </div>
    </div>

    <div class="col-lg-4">
    <div class="form-group">
      <label for="inputState">Tests:</label>
      </div>
      
      <div class="form-group">
      <input type="text" id="txtTestName" class="form-control"   value="" />
    </div>
    
    </div>
    <div class="col-lg-4">
     <div style="margin-top:36px;" class="form-group">
    
      <input type="button" id="Button2" onclick="SaveTemplateMapping();"  class="btn btn-primary" value="Save" />
    
  </div>
  
  </div>
  
   </div>
  
   

   
    
  
    </div>
    <!--/.Panel 2-->
    <!--Panel 3-->

    <!--/.Panel 3-->
</div>
          
<%--   <div class="card">
    <div class="card-body">
  
    </div>
</div>
     

  
    
    
   <div class="card">
   <div class="card-header success-color white-text">
        Featured
    </div>
    <div id="controls-content1" class="card-body">

  </div>
      <div class="card-footer text-muted">
        <input  type="button" onclick="onpreviewclick();" class="btn btn-info btn-lg" value="Preview" data-toggle="modal" data-target="#myModal" />
    </div>
  </div>--%>

   
    <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Form Preview</h4>
        </div>
        <div id="preview-content" class="modal-body">
          
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
    </div>
   <%-- <input type="button" onclick="topFunction()" id="myBtn" value="Top" title="Go to top"/>--%>
    <button type="button" id="myBtn" onclick="topFunction();" ><i class="fa fa-arrow-up fa-lg iedit" aria-hidden="true"></i></button>
     </div>
     <input type="hidden" value="0" id="hdnInvID"/>
     <input type="hidden" value="" id="hdnInvType"/>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />  
    </form>
    
    <link href="../Scripts/FormBuilder/FormBuilder.css" rel="stylesheet" type="text/css" />

    <script src="../QMS/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <link href="../QMS/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
   <%-- <link href="QMS/bootstrap/css/font-awesome.min.css" rel="stylesheet" type="text/css" />--%>
    <link href="../QMS/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

 
    <script src="../Scripts/FormBuilder/FormBulder.js" type="text/javascript"></script>
       <script src="../QMS/dataTable/jquery.dataTables.min.js" type="text/javascript"></script>

    <link href="../QMS/dataTable/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.datatables.net/fixedheader/3.1.3/css/fixedHeader.dataTables.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(function() {
            $('#tabs li a').click(function() {
                var t = $(this).attr('href');

                if (!$(this).hasClass('active')) { //this is the start of our condition
                    $('#tabs li a').removeClass('active');
                    $('#tabs li a').removeClass('show');
                    $(this).addClass('show active');

                    $('.tab-pane').removeClass('show');
                    $(t).addClass('in show active');
                }
            });
            getTemplates(0, 0, '', 'All');
            InvAutoComplete();
        });
    </script>
    
</body>
<style type="text/css">
                 .content {
    min-height: 250px;
    padding: 10px;
    margin-right: auto;
    margin-left: auto;
}
       /* #controls-content 
        {max-width:700px;}*/
    .panel-heading span
    {
        display:none;
        }
    .panel:hover .panel-heading span
    {
      display:block; 
      display: inline-block;  
    }
    .panel 
    { margin-left: 30px;
      margin-top:3px;
      border: none;
 
      
      }
    .panel-body .form-group {
    margin-bottom: 15px;
    margin-top: 15px;}
    .padding-right-no
    {
      padding-right: 0px; }
   /* .panel {
    margin-bottom: 3px;
    }*/
 .panel-default>.panel-heading {
    background-color:transparent;
     }
    body
    {background: #dad9d9;}
    .margin-5
    {margin-right:5px;}
    .clickable
    {
        
        cursor:pointer;
        }
        
        
    .panel:hover 
    {
        border:1px solid #c5c5c5; 
        box-shadow: 0 1px 12px rgba(56, 56, 56, 0.05); 
    }
   .panel-title {
    margin-top: 5px;
   }
    .panel-heading span:second-child {
     border-bottom-left-radius: 5px;
       } 
       .panel-heading span i
       {
       margin-top: 6px;
       }
   
       .closeBack
       {  background-color: #fdd;
         }
    .panel-body
    {padding-bottom: 0px;}
   .panel-heading span  {
    margin-top: -10px;
    width: 32px;
    height: 32px;
    padding: 0 6px; 
    border-radius: 0;
    border-color: #c5c5c5;
    background-color: #fff; 
    color: #c5c5c5;
    line-height: 32px;
    font-size: 16px;
    border-left:1px solid #c5c5c5;
    border-bottom:1px solid #c5c5c5;
} 
   .panel1
   {    background-color: #f9f9f9;}
/*   #controls-content .panel-title
   {
   line-height: 27px;
   font-size: 16px;
   font-weight: 400;
   color:#666;
   }*/
       .iframe-container {    
    padding-bottom: 60%;
    padding-top: 30px; height: 0; overflow: hidden;
}
 
.iframe-container iframe,
.iframe-container object,
.iframe-container embed {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
}
.panel button
{
    background-color:#f5f5f5;
    
    }
    .card
    {    box-shadow: 0 2px 5px 0 rgba(0,0,0,.16), 0 2px 10px 0 rgba(0,0,0,.12);
        border: 0;
    border-radius: .25rem;
    font-weight: 400;}
    .card
    {
        margin-top: 10px;
           position: relative;
    display: flex;
    -webkit-box-orient: vertical;
    -webkit-box-direction: normal;
    flex-direction: column;
    min-width: 0;
    word-wrap: break-word;
    background-color: #fff;
    background-clip: border-box;
        }
    .card-header {
    padding: .75rem 1.25rem;
    margin-bottom: 0;
    border-bottom: 1px solid rgba(0,0,0,.125);
    }
    .card .card-body {
    position: relative;
}
.card-body {
    -webkit-box-flex: 1;
   
    flex: 1 1 auto;
    padding: 1.25rem;
}
.card-header 
{
        color: #fff!important;
    padding: .75rem 1.25rem;
    margin-bottom: 0;
    border-bottom: 1px solid rgba(0,0,0,.125);
}
.success-color {
    /*background-color: #00c851!important;*/
    background-color: #365e77!important;
}
.card-header:first-child {
    border-radius: calc(.25rem - 1px) calc(.25rem - 1px) 0 0;
}
.card-footer {
    padding: .75rem 1.25rem;
    border-top: 1px solid rgba(0,0,0,.125);
    color: #fff!important;
}
.card-footer:last-child {
    border-radius: 0 0 calc(.25rem - 1px) calc(.25rem - 1px);
}

.waves-effect {
    position: relative;
    cursor: pointer;
    overflow: hidden;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    -webkit-tap-highlight-color: transparent;
    z-index: 1;
}
#myBtn {
  display: none;
  position: fixed;
  bottom: 20px;
  right: 30px;
  z-index: 99;
  font-size: 18px;
  border: none;
  outline: none;
  background-color: red;
  color: white;
  cursor: pointer;
  padding: 15px;
  border-radius: 4px;
}

#myBtn:hover {
  background-color: #555;
}
.nav-tabs {
    border: 0;
    padding: .7rem;
    /*margin-left: 1rem;
    margin-right: 1rem;*/
    margin-bottom: -20px;
    background-color: #2bbbad;
    z-index: 2;
    position: relative;
    border-radius: 2px;
   /* box-shadow: 0 5px 11px 0 rgba(0,0,0,.18), 0 4px 15px 0 rgba(0,0,0,.15);*/
}
.tab-content {
    padding: 1rem;
    z-index: 1;
    border-radius: 0 0 .3rem .3rem;
    min-height:465px;
    max-height:465px;
   
}
.tab-content>.tab-pane {
    display: none;
    max-height:465px;
    overflow:auto;
}
.nav-tabs .nav-link {
    transition: all .4s;
    border: 0;
    color: #fff;
}
.nav-tabs .nav-link {
    border-top-left-radius: .25rem;
    border-top-right-radius: .25rem;
}
.nav-tabs .nav-link:focus, .nav-tabs .nav-link:hover {
    border-color: #e9ecef #e9ecef #dee2e6;
}
.fade {
    opacity: 0;
    transition: opacity .15s linear;
}
.nav-tabs .nav-link.active {
    background-color: #55c9be;
    color: #fff;
    -webkit-transition: all 1s;
    transition: all 1s;
    border-radius: 2px;
}
.nav-tabs .nav-link.active {
    color: #495057;
        border-bottom:0px;
}
.nav-link {
    display: block;
    padding: .5rem 1rem;
}
.nav-tabs.nav-justified>.active>a, .nav-tabs.nav-justified>.active>a:focus, .nav-tabs.nav-justified>.active>a:hover {
    border: 0px;
}
.nav-tabs .nav-item.open .nav-link, .nav-tabs .nav-link.active {
    background-color: rgb(85, 201, 190);
    color: #fff;
    -webkit-transition: all 1s;
    transition: all 1s;
    border-radius: 2px;
}
.nav>li>a:hover {
    text-decoration: none;
     background-color: rgb(85, 201, 190);
    color: #fff;
}
.nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li.active>a:hover
{background-color: rgb(85, 201, 190);
    color: #fff;
   border-color: transparent;}
   .nav-tabs.nav-justified>li>a {
   border-bottom: 0px; 
    
}
.btn {
    padding: .84rem 2.14rem;
    font-size: .81rem;
    -webkit-transition: all .2s ease-in-out;
    transition: all .2s ease-in-out;
    margin: .375rem;
    border: 0;
    border-radius: .125rem;
    cursor: pointer;
    text-transform: uppercase;
    white-space: normal;
    word-wrap: break-word;
    color: #fff!important;
    font-weight: 400;
    text-align: center;
    font-size: smaller;
    box-shadow: 0 2px 5px 0 rgba(0,0,0,.16), 0 2px 10px 0 rgba(0,0,0,.12);
}
label
{color:#5f5a5a;}
.card-custom
{
    
        min-height: 435px;
        max-height: 435px;
        margin-top:-19px;
        box-shadow:none;
        border-radius:unset;
        overflow-y:auto;
    
    }
    .bordered
    {
      border-right: 2px solid #ccc;  
        
    }
    .isreq
    {
    margin-left:10px;
    }
    </style>
</html>
