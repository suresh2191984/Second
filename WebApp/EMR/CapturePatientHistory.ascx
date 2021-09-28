<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CapturePatientHistory.ascx.cs"
    Inherits="EMR_CapturePatientHistory" %>
<style>
    .patientTextarea
    {
        width: 150px;
    }
    .tblPatientHistory td
    {
        padding: 2px 0;
    }
    .divhight
    {
        width: 1000px;
    }
</style>
<div id="divPatientClinicalHistory">
    
    <table id="tblClinicalHistory" class="dataheader2 gridView w-100p tblCliHisClass">
       
    </table>
</div>
<div id="divNoRecordsFound" class="NoRecordsFoundClass" style="font-family: Arial Black; font-size: 14pt; margin-top: 80px;display: none;">
    No Records Found
</div>
