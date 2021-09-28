<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintProductBarcode.aspx.cs"
    Inherits="LabConsumptionInventory_PrintProductBarcode" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />

    <script>
        function HidePatientHeater() {
            $("#Attuneheader_patientBanner").hide();
            return false;
        }

        function CallPrint() {
            $('#tblSearchPanel').hide();
            var txtBarcodeCount = Number($('#txtNoOfBarcode').val());

            var prtContent = document.getElementById('divBarCodePrint');
            var WinPrint = window.open('', '', 'letf=0,top=0,right=0,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write('<html><head>');
            WinPrint.document.write('<link rel="stylesheet" type="text/css" href="../PlatForm/StyleSheets/Common.css" />');
            WinPrint.document.write('</head><body>');
            for (var i = 0; i < txtBarcodeCount; i++) {
                WinPrint.document.write(prtContent.innerHTML);
                
            }
            WinPrint.document.write('</body></html>');
            setTimeout(function() {
                WinPrint.document.close();
                WinPrint.focus();
                WinPrint.print();
            }, 1000);
            //WinPrint.close();
            $('#tblSearchPanel').show();
        }

        
        function RenderBarcode() {
            var BarcodeValue = $('#hdnBarcodeValue').val().split('~#');         
            var txtBarcodeCount = Number($('#txtNoOfBarcode').val());
          //  var divToPrint = document.getElementById("tblBarcode");

            var prtContent = document.getElementById('divBarCodePrint');
            var WinPrint = window.open('', '', 'letf=0,top=0,right=0,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write('<html><head>');
            WinPrint.document.write('<link rel="stylesheet" type="text/css" href="../PlatForm/StyleSheets/Common.css" />');
            WinPrint.document.write('</head><body>');
            for (var i = 0; i < txtBarcodeCount; i++) {
                WinPrint.document.write(prtContent.innerHTML);
            }
            WinPrint.document.write('</body></html>');
            setTimeout(function() {
                WinPrint.document.close();
                WinPrint.focus();
                WinPrint.print();
            }, 1000);
            //WinPrint.close();
            $('#tblSearchPanel').show();
            
//            newWin = window.open("");
//           // var i;
//            for(var i=0;i < txtBarcodeCount;i++)
//            {
//            newWin.document.write(divToPrint.outerHTML);
//            }
//            
//            newWin.print();
//            newWin.close();
          /*  $("#tblBarcode").empty();
            $('[id$="divBarCodePrint"]').empty();

           var mytable = $('<table width="80%"></table>')
          
           var cols = 1;  
           var rows = txtBarcodeCount / cols;


            for (var i = 0; i < rows; i++) {
            
                var row = $('<tr></tr>').appendTo(mytable);
                for (var j = 0; j < cols; j++) {
                    $('<td></td>').text(BarcodeValue[0]).appendTo(row);
                }

                var row2 = $('<tr></tr>').appendTo(mytable);
                for (var j = 0; j < cols; j++) {                    
                    $('<td>').html("<img id='tdBnoImg' src='" + BarcodeValue[2] + "'/>").appendTo(row2);
                }

                var row3 = $('<tr></tr>').appendTo(mytable);
                for (var j = 0; j < cols; j++) {
                    $('<td></td>').text(BarcodeValue[1]+'  '+BarcodeValue[3]).appendTo(row3);
                }
                var row4 = $('<tr></tr>').appendTo(mytable);
                for (var j = 0; j < cols; j++) {
                    $('<td></td>').text(BarcodeValue[4]).appendTo(row4);
                }
                var row5 = $('<tr></tr>').appendTo(mytable);
                for (var j = 0; j < cols; j++) {
                    $('<td>Exp. Date:</td>').text('Exp. Date:'+BarcodeValue[5]).appendTo(row5);
                }
                var row6 = $('<tr></tr>').appendTo(mytable);
                for (var j = 0; j < cols; j++) {
                    $('<td></td>').text(BarcodeValue[6]).appendTo(row6);
                }
            }


            $('[id$="divBarCodePrint"]').append(mytable);
        */
        }
        
    </script>

    <div class="contentdata">
        <table class="searchPanel w-100p" id="tblSearchPanel">
            <tr class="panelHeader">
                <td>
                    <table class="w-40p">
                        <tr>
                            <td class="a-left">
                                <asp:Label ID="lblBarcode" runat="server" 
                                    Text="No of Barcode Print" 
                                    meta:resourcekey="lblBarcodeResource1"></asp:Label>
                            </td>
                            <td>
                               <asp:TextBox ID="txtNoOfBarcode" CssClass="mini" onkeydown="return validatenumber(event);" value="1"      runat="server"  MaxLength="5" ></asp:TextBox>
                            </td>
                            <td >
                                <asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btn" 
                                    OnClientClick="CallPrint();return false;" 
                                    meta:resourcekey="btnPrintResource1" />                                    
                                
                            </td>
                            <td class="w-80">
                              <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn"                                     
                                    meta:resourcekey="btnBackResource1" onclick="btnBack_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div>
            <div id="divBarCodePrint" runat="server">
            </div>
            <asp:HiddenField ID="hdnBarcodeValue" runat="server" />
        </div>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>
