
    
    function fnGetLabInvestigationPatientSearch(ILocationID, OrgID, RoleID, currentPageNo, PageSize, PatientId, PatientName, intVisitType,
                 SourceName, wardno, Status, InvID, Fromdate, Todate, Priority, Visitnumber, Patnumber, Type, deptID, Result, pRefPhyID, pLocationID, IsTimed, ProtocalGroupID, allocatedtasks, SampleID) {
            //debugger;
            try {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetEnterResultTask",                                                                                                                                                                                                                                                                                 //InvID,Fromdate, Todate, Priority, Visitnumber, Patnumber, Type, deptID, Result, 0, 0, objLoginDetail, IsTimed, ProtocalGroupID, allocatedtasks
                    contentType: "application/json; charset=utf-8",
                    data: "{ 'OrgAddID': '" + ILocationID + "','OrgID': '" + OrgID + "','RoleID': '" + RoleID + "','currentPageNo': '" + currentPageNo + "','PageSize': '" + PageSize + "','PatientId': '" + PatientId + "','PatientName': '" + PatientName + "','intVisitType': '" + intVisitType + "','lngSourceId': '" + SourceName + "','wardno': '" + wardno + "','status': '" + Status + "','invname': '" + InvID + "','fdate': '" + Fromdate + "','tdate': '" + Todate + "','priority': '" + Priority + "','VisitNumber': '" + Visitnumber + "','PatNumber': '" + Patnumber + "','Type': '" + Type + "','DeptID': '" + deptID + "','pTaskAction': '" + Result + "','pRefPhyID': '" + pRefPhyID + "','pLocationID': '" + pLocationID + "','IsTimed': '" + IsTimed + "','ProtocalGroupID': '" + ProtocalGroupID + "','tasks': '" + allocatedtasks + "','SampleID': '" + SampleID + "'}",
                    dataType: "json",
                    success: fnAjaxGetEnterResultTask,
                    error: function(xhr, ajaxOptions, thrownError) {
                       // debugger;
                        alert("Error");
                        return false;
                    }
                });
            }
            catch (e) {

            }
        }
        //AccompaniedBy, Age, OutVisitID, VisitDate, ComplaintName, ReportTat
        function fnAjaxGetEnterResultTask(result) {
            //debugger;
            try {
                var oTable;
                if (result != "[]" && result.d.length > 0) {
                    oTable = $('#tblEnterResult').dataTable({

                        "bDestroy": true,
                        "bAutoWidth": false,
                        "aaData": result.d,
                        "sDom": '<"H"Tfr>t<ip>',
                        //"sDom": '<"H"lr>t<"F"ip>',
                        "bFilter": true,
                        "bInfo": false,
                        "bProcessing": true,
                        //"bServerSide": true,

                        "aoColumns": [
                                { "mDataProp": "AccompaniedBy",
                                    "mRender": function(data, type, full) {
                                        return '<a href=../Investigation/InvestigationCapture.aspx?DeptId=' + full.DeptID + '&vid=' + full.PatientVisitId + '&gUID=' + full.UID + '&RNo=' + full.Labno + '&InvCount=' + full.RateID + '&REType=' + full.ResultEntryType + '">' + full.AccompaniedBy + '</a>';
                                    }
                                },
                                { "mDataProp": "Age" },
                                { "mDataProp": "VisitDate",
                                    "mRender": function(data, type, full) {
                                        //debugger;
                                        var dtStart = new Date(parseInt(data.substr(6)));
                                        var dtStartWrapper = moment(dtStart);
                                        return dtStartWrapper.format('DD/MM/YYYY HH:mm');
                                    }
                                },
                                { "mDataProp": "ComplaintName" },
                                { "mDataProp": "ReportTat",
                                    "mRender": function(data, type, full) {
                                        //debugger;
                                        var dtReport = new Date(parseInt(data.substr(6)));
                                        var dtReportWrapper = moment(dtReport);
                                        return dtReportWrapper.format('DD/MM/YYYY HH:mm');
                                    }

}],

                        "bPaginate": true,
                        "sPaginationType": "full_numbers",
                        "fnDrawCallback": function() {        //After table is redrawn, customize the pagination control to consistently show 2-digit page numbers to reduce button wandering near the 10th page.
                            $('.paginate_button, .paginate_active').each(function() {
                                var pgNbr = $(this).text();
                                if (pgNbr.length == 1 && pgNbr >= '1' && pgNbr <= '9')
                                    $(this).prepend('0');
                            });
                        },
                        "bSort": false,
                        "bJQueryUI": true,
                        "iDisplayLength": 10,
                        "bLengthChange": false,
                        //"sDom": '<"top"<"dataTables_paginate">fpi<"clear">><"clear">rt<"bottom">',
                        "SDom": '<"top"fp>rt<"bottom"><"clear">'
                        //"bPaginationType": "bootstrap"
                    });
                    if (document.getElementById('hdnReportdateconfig').value = "N") {
                        oTable.fnSetColumnVis(4, false);
                    }
                    //} );
                }
                $('#tblEnterResult').show();
            }
            catch (e) {
                alert(0);
            }
        }
        $('#tblEnterResult tbody tr').live('mouseover', function(event) {
            var oTable = $("#tblEnterResult").dataTable();
            var aPos = oTable.fnGetPosition(this);
            var aData = oTable.fnGetData(aPos);
            var VID = aData["PatientVisitId"];
            var Orgid = aData["OrgID"];
            var LocationID = aData["ILocationID"];
            var Labno = aData["Labno"];
            //ShowStatus(VID);
            //MouseOver(VID, Orgid, LocationID, Labno);
            this.setAttribute(MouseOver(VID, Orgid, LocationID, Labno, event));
        });
        //                $('#tblEnterResult tbody tr').live('mouseout', function() {
        //                //document.getElementById('jsonDiv').style.display = "none";
        //                hideTooltip();
        //                });
        function MouseOver(VID, Orgid, LocationID, Labno, e) {
            try {
                //debugger;
                //text = "";
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetInvestigationshowincollecttasks",
                    contentType: "application/json; charset=utf-8",
                    data: "{ 'visitID': '" + VID + "','orgID':'" + 0 + "','LocationID':'" + 1 + "','Labno':'" + Labno + "'}",
                    dataType: "json",
                    success: function(result) {
                        $("#jsonDiv").html('');
                        var data = result.d;
                        // var text = '<table border="1"><tbody>';
                        var text = "<table class=\"taskDetailstip\"><tbody>";
                        text += '<tr class=\'tasktipHeader\'><td style=\"font-weight: bold;\"> <strong>InvestigationList</strong></td>';
                        text += '<td  style=\"font-weight: bold;\"><strong>Status</strong></td></tr>';
                        jQuery.each(data, function(rec) {
                            text = text + " <tr> <td> " + this.InvestigationName + "</td> <td> " + this.DisplayStatus + "</td> </tr> ";
                        });
                        //text +='<tr><td>' + result.d[0].InvestigationName + '</td><td>' + result.d[0].Status + '</td></tr>'
                        text += '</tbody></table>';
                        //return text
                        document.getElementById('jsonDiv').style.display = "block";
                        showTooltipnew(e, text);
                    }
                    //                    },
                    //                    error: function(xhr, ajaxOptions, thrownError) {
                    //                        alert("Error in Webservice-GetInvestigationshowincollecttasks");
                    //                        return false;
                    //                    }

                });
                //                $("#tblEnterResult tbody tr").on("mouseover", function(event) {

                //});
                $('#tblEnterResult tbody td').on('mouseout', function() {
                    hideTooltip();
                });

            }
            catch (e) {
                alert(1);
            }
            return false
        }
        
        
        
        var datadiv_tooltip = false;
        var datadiv_tooltipShadow = false;
        var datadiv_shadowSize = 4;
        var datadiv_tooltipMaxWidth = 200;
        var datadiv_tooltipMinWidth = 100;
        var datadiv_iframe = false;
        var tooltip_is_msie = (navigator.userAgent.indexOf('MSIE') >= 0 && navigator.userAgent.indexOf('opera') == -1 && document.all) ? true : false;
        function showTooltipnew(e, tooltipTxt) {
            //debugger;

            var bodyWidth = Math.max(document.body.clientWidth, document.documentElement.clientWidth) - 20;
            var position = [0, 0];
            if (typeof window.pageYOffset != 'undefined') {
                position = [window.pageXOffset, window.pageYOffset];
            }
            else if (typeof document.documentElement.scrollTop != 'undefined' && document.documentElement.scrollTop > 0) {
                position = [document.documentElement.scrollLeft, document.documentElement.scrollTop];
            }
            else if (typeof document.body.scrollTop != 'undefined') {
                position = [document.body.scrollLeft, document.body.scrollTop];
            }
            if (!datadiv_tooltip) {
                datadiv_tooltip = document.createElement('DIV');
                datadiv_tooltip.id = 'datadiv_tooltip';
                datadiv_tooltipShadow = document.createElement('DIV');
                datadiv_tooltipShadow.id = 'datadiv_tooltipShadow';

                document.body.appendChild(datadiv_tooltip);
                document.body.appendChild(datadiv_tooltipShadow);

                if (tooltip_is_msie) {
                    datadiv_iframe = document.createElement('IFRAME');
                    datadiv_iframe.frameborder = '5';
                    datadiv_iframe.style.backgroundColor = '#FFFFFF';
                    datadiv_iframe.src = '#';
                    datadiv_iframe.style.zIndex = 100;
                    datadiv_iframe.style.position = 'absolute';
                    document.body.appendChild(datadiv_iframe);
                }

            }

            datadiv_tooltip.style.display = 'block';
            datadiv_tooltipShadow.style.display = 'block';
            if (tooltip_is_msie) datadiv_iframe.style.display = 'block';

            var st = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
            if (navigator.userAgent.toLowerCase().indexOf('safari') >= 0) st = 0;
            var leftPos = e.clientX + 10;

            datadiv_tooltip.style.width = null; // Reset style width if it's set 
            datadiv_tooltip.innerHTML = tooltipTxt;
            var divh = datadiv_tooltip.clientHeight;
            var pageX = e.clientX + position[0];
            var pageY = e.clientY + position[1];
            //            datadiv_tooltip.style.left = leftPos + 'px';
            //            datadiv_tooltip.style.top = e.clientY + 10 + st + 'px';
            if (pageY < 300) {
                datadiv_tooltip.style.left = leftPos + 'px';
                datadiv_tooltip.style.top = pageY + 'px';
            }
            else {
                datadiv_tooltip.style.left = leftPos + 'px';
                datadiv_tooltip.style.top = pageY - divh + 'px';
            }

            //            datadiv_tooltipShadow.style.left = leftPos + datadiv_shadowSize + 'px';
            //            datadiv_tooltipShadow.style.top = e.clientY + 10 + st + datadiv_shadowSize + 'px';
            if (pageY < 300) {
                datadiv_tooltipShadow.style.left = leftPos + datadiv_shadowSize + 'px';
                datadiv_tooltipShadow.style.top = pageY + datadiv_shadowSize + 'px';
            }
            else {
                datadiv_tooltipShadow.style.left = leftPos + datadiv_shadowSize + 'px';
                datadiv_tooltipShadow.style.top = pageY - divh + datadiv_shadowSize + 'px';
            }

            if (datadiv_tooltip.offsetWidth > datadiv_tooltipMaxWidth) {	/* Exceeding max width of tooltip ? */
                datadiv_tooltip.style.width = datadiv_tooltipMaxWidth + 'px';
            }

            var tooltipWidth = datadiv_tooltip.offsetWidth;
            if (tooltipWidth < datadiv_tooltipMinWidth) tooltipWidth = datadiv_tooltipMinWidth;


            datadiv_tooltip.style.width = tooltipWidth + 'px';
            datadiv_tooltipShadow.style.width = datadiv_tooltip.offsetWidth + 'px';
            datadiv_tooltipShadow.style.height = datadiv_tooltip.offsetHeight + 'px';

            if ((leftPos + tooltipWidth) > bodyWidth) {
                datadiv_tooltip.style.left = (datadiv_tooltipShadow.style.left.replace('px', '') - ((leftPos + tooltipWidth) - bodyWidth)) + 'px';
                datadiv_tooltipShadow.style.left = (datadiv_tooltipShadow.style.left.replace('px', '') - ((leftPos + tooltipWidth) - bodyWidth) + datadiv_shadowSize) + 'px';
            }

            if (tooltip_is_msie) {
                datadiv_iframe.style.left = datadiv_tooltip.style.left;
                datadiv_iframe.style.top = datadiv_tooltip.style.top;
                datadiv_iframe.style.width = datadiv_tooltip.offsetWidth + 'px';
                datadiv_iframe.style.height = datadiv_tooltip.offsetHeight + 'px';

            }

        }
        function hideTooltip() {
            //debugger;
            if (!datadiv_tooltip) {
                datadiv_tooltip = document.createElement('DIV');
                datadiv_tooltip.id = 'datadiv_tooltip';
                datadiv_tooltipShadow = document.createElement('DIV');
                datadiv_tooltipShadow.id = 'datadiv_tooltipShadow';

                document.body.appendChild(datadiv_tooltip);
                document.body.appendChild(datadiv_tooltipShadow);

                if (tooltip_is_msie) {
                    datadiv_iframe = document.createElement('IFRAME');
                    datadiv_iframe.frameborder = '5';
                    datadiv_iframe.style.backgroundColor = '#FFFFFF';
                    datadiv_iframe.src = '#';
                    datadiv_iframe.style.zIndex = 100;
                    datadiv_iframe.style.position = 'absolute';
                    document.body.appendChild(datadiv_iframe);
                }

            }
            datadiv_tooltip.style.display = 'none';
            datadiv_tooltipShadow.style.display = 'none';
            if (tooltip_is_msie) datadiv_iframe.style.display = 'none';
        }
        //GetCollectSampleTask
        function fnGetCollectSampleTask(RoleID, OrgID, LID, strDate, category, orgAddrId, specialityId, PatientNumber, InvLocationID, startRowIndex, pageSize, DeptID, Clientid, Preference, ProtocalGroupID) {
            //debugger;
            try {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetCollectSampleTask", //InvID,Fromdate, Todate, Priority, Visitnumber, Patnumber, Type, deptID, Result, 0, 0, objLoginDetail, IsTimed, ProtocalGroupID, allocatedtasks
                    contentType: "application/json; charset=utf-8",
                    data: "{ 'RoleID': '" + RoleID + "','OrgID': '" + OrgID + "','UID': '" + LID + "','TaskDate': '" + strDate + "','category': '" + category + "','orgAddrId': '" + orgAddrId + "','specId': '" + specialityId + "','PatientNumber': '" + PatientNumber + "','InvLocationID': '" + InvLocationID + "','startRowIndex': '" + startRowIndex + "','pageSize': '" + pageSize + "','DeptID': '" + DeptID + "','ClientID': '" + Clientid + "','Preference': '" + Preference + "','ProtocalGroupID': '" + ProtocalGroupID + "'}",
                    dataType: "json",
                    success: fnAjaxGetApprovalTask,
                    error: function(xhr, ajaxOptions, thrownError) {
                       // debugger;
                        alert("Error");
                        return false;
                    }
                });
            } catch (e) {

            }
        }
        function fnGetApprovalTask(RoleID, OrgID, LID, strDate, category, orgAddrId, specialityId, PatientNumber, InvLocationID, startRowIndex, pageSize, DeptID, Clientid, allocatedtasks, Preference, ProtocalGroupID) {
            //debugger;
            try {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetApprovalTask", //InvID,Fromdate, Todate, Priority, Visitnumber, Patnumber, Type, deptID, Result, 0, 0, objLoginDetail, IsTimed, ProtocalGroupID, allocatedtasks
                    contentType: "application/json; charset=utf-8",
                    data: "{ 'RoleID': '" + RoleID + "','OrgID': '" + OrgID + "','UID': '" + LID + "','TaskDate': '" + strDate + "','category': '" + category + "','orgAddrId': '" + orgAddrId + "','specId': '" + specialityId + "','PatientNumber': '" + PatientNumber + "','InvLocationID': '" + InvLocationID + "','startRowIndex': '" + startRowIndex + "','pageSize': '" + pageSize + "','DeptID': '" + DeptID + "','ClientID': '" + Clientid + "','allocated': '" + allocatedtasks + "','Preference': '" + Preference + "','ProtocalGroupID': '" + ProtocalGroupID + "'}",
                    dataType: "json",
                    success: fnAjaxGetApprovalTask,
                    error: function(xhr, ajaxOptions, thrownError) {
                        //debugger;
                        alert("Error");
                        return false;
                    }
                });
            } catch (e) {

            }
        }
        //AccompaniedBy, Age, OutVisitID, VisitDate, ComplaintName, ReportTat
        function fnAjaxGetApprovalTask(result) {
            //debugger;
            try {
                var oTable;
                if (result != "[]" && result.d.length > 0) {
                    oTable = $('#tblApprovalTask').dataTable({

                        "bDestroy": true,
                        "bAutoWidth": false,
                        "aaData": result.d,
                        "bFilter": true,
                        "bInfo": false,
                        "bProcessing": true,

                        "aoColumns": [{
                            "mDataProp": "TaskDescription",
                            "mRender": function(data, type, full) {
                                //debugger;
                                var str = full.RedirectURL;
                                var res = str.replace("~\\", "../");
                                return '<a href=' + res + "&LNo=" + full.RefernceID + "&ClID=" + document.getElementById('uctlTaskList_hdnSelectedClientID').value + "&ClName=" + document.getElementById('uctlTaskList_hdnSelectedClientName').value + "&RNo=" + full.RefernceID + "&POrgID=" + full.OrgID + '">' + full.TaskDescription + '</a>';
                            }
                        },
                        //{ "mDataProp": "Age" },
                    {
                    "mDataProp": "TaskDate",
                    "mRender": function(data, type, full) {
                        //debugger;
                        var dtStart = new Date(parseInt(data.substr(6)));
                        var dtStartWrapper = moment(dtStart);
                        return dtStartWrapper.format('DD/MM/YYYY HH:mm');
                    }
                }, {
                    "mDataProp": "Category"
                }, {
                    "mDataProp": "Location"
                }, {
                    "mDataProp": "HighlightColor"
                }, {
                    "mDataProp": "URLStatus"
                }, {
                    "mDataProp": "ReportTatDate",
                    "mRender": function(data, type, full) {
                        //debugger;
                        var dtReport = new Date(parseInt(data.substr(6)));
                        var dtReportWrapper = moment(dtReport);
                        return dtReportWrapper.format('DD/MM/YYYY HH:mm');
                    }

                }
                ],

                        "bPaginate": true,
                        "sPaginationType": "full_numbers",
                        "fnDrawCallback": function() { //After table is redrawn, customize the pagination control to consistently show 2-digit page numbers to reduce button wandering near the 10th page.
                            $('.paginate_button, .paginate_active').each(function() {
                                var pgNbr = $(this).text();
                                if (pgNbr.length == 1 && pgNbr >= '1' && pgNbr <= '9')
                                    $(this).prepend('0');
                            });
                        },
                        "bSort": false,
                        "bJQueryUI": true,
                        "iDisplayLength": 10,
                        "bLengthChange": false,
                        "SDom": '<"top"fpi>rt<"bottom"><"clear">'
                    });
                    if (document.getElementById('uctlTaskList_hdnReportdateconfig1').value = "N") {
                        oTable.fnSetColumnVis(6, false);
                    }
                    $('#tblApprovalTask').show();
                }

            } catch (e) {
                alert(0);
            }
        }

        $("#tblApprovalTask tbody tr").live("mouseover", function(event) {
            //alert('hai');
            //debugger;
            var oTable = $("#tblApprovalTask").dataTable();
            var aPos = oTable.fnGetPosition(this);
            var aData = oTable.fnGetData(aPos);
            var VID = aData["PatientVisitID"];
            var Orgid = aData["OrgID"];
            var LocationID = aData["LocationID"];
            var Labno = aData["RefernceID"];
            //ShowStatus(VID);
            //MouseOver(VID, Orgid, LocationID, Labno);
            this.setAttribute(MouseOver(VID, Orgid, LocationID, Labno, event));
        });

        $("#tblApprovalTask tbody tr").live("mouseout", function(event) {
            hideTooltip();
        });