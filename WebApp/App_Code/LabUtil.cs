using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;
using System.Xml.XPath;
using System.IO;
using Attune.Solution.BusinessComponent;
using System.Net;
using System.Threading;
using System.Globalization;
/// <summary>
/// Summary description for LabUtil
/// </summary>
public class LabUtil : BasePage
{
    public LabUtil()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public List<PatientInvSample> GroupCollectSampleDetails(List<PatientInvSample> lstPatInvSample)
    {
        List<PatientInvSample> lstGroupedSampleDetails = new List<PatientInvSample>();
        List<PatientInvSample> lstfirstSampleDetails = new List<PatientInvSample>();
        try
        {
            Dictionary<string, PatientInvSample> dictPatientInvSample = new Dictionary<string, PatientInvSample>();
            Dictionary<string, PatientInvSample> dictPatientInvSample1 = new Dictionary<string, PatientInvSample>();
            string key = string.Empty;
            string key1 = string.Empty;
            string[] lstInvDetails;
            string[] lstInvName;
            string[] lstInvIdNType;
            string[] InvDetails1;
            string pInvID = string.Empty;
            string pGRPID = string.Empty;
            string invName = string.Empty;
            string invIdNType = string.Empty;
            string[] lstInvDetails1;
            string[] lstInvName1;
            string[] lstInvIdNType1;
            string invName1 = string.Empty;
            string invIdNType1 = string.Empty;
            PatientInvSample oNewPatientInvSample;
            PatientInvSample objNewPatientInvSamples;

            string rval;
            rval = GetConfigValue("LoadSampleWithProLoc", OrgID);
            foreach (PatientInvSample oPatientInvSample in lstPatInvSample)
            {
                if (oPatientInvSample.IsMLNumber == "Y")
                {
                    InvDetails1 = oPatientInvSample.InvestigtionName.Split('~');
                    pInvID = InvDetails1[3];
                    pGRPID = InvDetails1[0];
                    if (InvDetails1[2] == "INV")
                    {
                        key = oPatientInvSample.SampleCode + "~" + oPatientInvSample.RecSampleLocID + "~" + oPatientInvSample.SampleContainerID + "~" + pInvID + "~INV";
                    }
                    else if (InvDetails1[2] == "GRP")
                    {
                        key = oPatientInvSample.SampleCode + "~" + oPatientInvSample.RecSampleLocID + "~" + oPatientInvSample.SampleContainerID + "~" + pGRPID + "~GRP";
                    }
                }
                else
                {
                    if (oPatientInvSample.Type == "GRP" && oPatientInvSample.IsHistoPathSample == "Y")
                    {
                        key = oPatientInvSample.InvestigationID + "~" + oPatientInvSample.SampleCode + "~" + oPatientInvSample.RecSampleLocID + "~" + oPatientInvSample.SampleContainerID;
                    }
                    else
                    {
                        key = oPatientInvSample.SampleCode + "~" + oPatientInvSample.RecSampleLocID + "~" + oPatientInvSample.SampleContainerID;
                    }
                }
                lstInvDetails = oPatientInvSample.InvestigtionName.Split('~');
                invName = lstInvDetails[1];
                invIdNType = lstInvDetails[0] + "~" + lstInvDetails[2] + "~" + lstInvDetails[3] + "~" + lstInvDetails[4] + "~" + lstInvDetails[5] + "~" + lstInvDetails[6];
                if (dictPatientInvSample.ContainsKey(key))
                {
                    oNewPatientInvSample = dictPatientInvSample[key];
                    //lstInvName = oNewPatientInvSample.InvestigtionName.Split(',');
                    lstInvName = oNewPatientInvSample.ConsignmentNo.Split('^');
                    lstInvIdNType = oNewPatientInvSample.InvestigationID.Split('|');
                    if (!lstInvName.Contains(invName))
                    {
                        oNewPatientInvSample.InvestigtionName = oNewPatientInvSample.InvestigtionName + "," + invName;
                        oNewPatientInvSample.ConsignmentNo = oNewPatientInvSample.ConsignmentNo + "^" + invName;
                    }
                    if (!lstInvIdNType.Contains(invIdNType))
                        oNewPatientInvSample.InvestigationID = oNewPatientInvSample.InvestigationID + "|" + invIdNType;
                }
                else
                {
                    oNewPatientInvSample = oPatientInvSample;
                    oNewPatientInvSample.InvestigtionName = invName;
                    oNewPatientInvSample.InvestigationID = invIdNType;
                    oNewPatientInvSample.ConsignmentNo = invName;
                }
                dictPatientInvSample[key] = oNewPatientInvSample;
            }
            foreach (PatientInvSample objPatientInvSample in lstPatInvSample)
            {
                if (objPatientInvSample.AddExtraTube == "Y")
                {
                    key1 = objPatientInvSample.SampleCode + "~" + objPatientInvSample.RecSampleLocID + "~" + objPatientInvSample.SampleContainerID;
                    if (objPatientInvSample.InvestigtionName.Contains('~'))
                    {
                        lstInvDetails1 = objPatientInvSample.InvestigtionName.Split('~');
                        //invName1 = lstInvDetails1[1];
                        invName1 = "-";
                        invIdNType1 = lstInvDetails1[0] + "~" + lstInvDetails1[2] + "~" + lstInvDetails1[3] + "~" + lstInvDetails1[4] + "~" + lstInvDetails1[5];

                        if (dictPatientInvSample1.ContainsKey(key1))
                        {
                            objNewPatientInvSamples = dictPatientInvSample1[key1];
                            lstInvName1 = objNewPatientInvSamples.InvestigtionName.Split(',');
                            lstInvIdNType1 = objNewPatientInvSamples.InvestigationID.Split('|');
                            if (!lstInvName1.Contains(invName1))
                                objNewPatientInvSamples.InvestigtionName = objNewPatientInvSamples.InvestigtionName + "," + invName1;
                            if (!lstInvIdNType1.Contains(invIdNType1))
                                objNewPatientInvSamples.InvestigationID = objNewPatientInvSamples.InvestigationID + "|" + invIdNType1;
                        }
                        else
                        {
                            objNewPatientInvSamples = objPatientInvSample;
                            objNewPatientInvSamples.InvestigtionName = invName1;
                            objNewPatientInvSamples.InvestigationID = invIdNType1;
                        }
                        dictPatientInvSample1[key1] = objNewPatientInvSamples;
                    }
                }
            }
            lstGroupedSampleDetails = new List<PatientInvSample>(dictPatientInvSample.Values);
            lstfirstSampleDetails = new List<PatientInvSample>(dictPatientInvSample1.Values);
            foreach (PatientInvSample objPatientinvSample in lstfirstSampleDetails)
            {
                /****************Changed by Arivalagan.kk for less than 9 barcode number exception************/
                //objPatientinvSample.BarcodeNumber = objPatientinvSample.BarcodeNumber.Remove(9, 2);
                if (objPatientinvSample.BarcodeNumber.Length >= 9)
                {
                    objPatientinvSample.BarcodeNumber = objPatientinvSample.BarcodeNumber.Remove(9, 2);
                }
                else 
                {
                    objPatientinvSample.BarcodeNumber = objPatientinvSample.BarcodeNumber;
                }
                /****************Changed by Arivalagan.kk for less than 9 barcode number exception************/
                lstGroupedSampleDetails.Add(objPatientinvSample);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while grouping collect sample details", ex);
            throw ex;
        }
        return lstGroupedSampleDetails;
    }
    public List<PatientInvSample> GroupCollectSampleDetailsDeptSharing(List<PatientInvSample> lstPatInvSample)
    {
        List<PatientInvSample> lstGroupedSampleDetails = new List<PatientInvSample>();
        List<PatientInvSample> lstfirstSampleDetails = new List<PatientInvSample>();
        try
        {
            Dictionary<string, PatientInvSample> dictPatientInvSample = new Dictionary<string, PatientInvSample>();
            Dictionary<string, PatientInvSample> dictPatientInvSample1 = new Dictionary<string, PatientInvSample>();
            string key = string.Empty;
            string key1 = string.Empty;
            string[] lstInvDetails;
            string[] lstInvName;
            string[] lstInvIdNType;
            string[] InvDetails1;
            string pInvID = string.Empty;
            string pGRPID = string.Empty;
            string invName = string.Empty;
            string invIdNType = string.Empty;
            string[] lstInvDetails1;
            string[] lstInvName1;
            string[] lstInvIdNType1;
            string invName1 = string.Empty;
            string invIdNType1 = string.Empty;
            PatientInvSample oNewPatientInvSample;
            PatientInvSample objNewPatientInvSamples;

            string rval;
            rval = GetConfigValue("LoadSampleWithProLoc", OrgID);
            foreach (PatientInvSample oPatientInvSample in lstPatInvSample)
            {
                if (oPatientInvSample.IsMLNumber == "Y")
                {
                    InvDetails1 = oPatientInvSample.InvestigtionName.Split('~');
                    pInvID = InvDetails1[3];
                    pGRPID = InvDetails1[0];
                    if (InvDetails1[2] == "INV")
                    {
                        key = oPatientInvSample.SampleCode + "~" + oPatientInvSample.SampleContainerID + "~" + oPatientInvSample.IsShareAble + "~" + oPatientInvSample.IsSecondaryBarCode + "~" + pInvID + "~INV";
                    }
                    else if (InvDetails1[2] == "GRP")
                    {
                        key = oPatientInvSample.SampleCode + "~" + oPatientInvSample.SampleContainerID + "~" + oPatientInvSample.IsShareAble +"~" + oPatientInvSample.IsSecondaryBarCode + "~" + pGRPID + "~GRP";
                    }
                }
                else
                {

                    key = oPatientInvSample.SampleCode + "~" + oPatientInvSample.SampleContainerID + "~" + oPatientInvSample.IsShareAble + "~" + oPatientInvSample.IsSecondaryBarCode;
                }
                lstInvDetails = oPatientInvSample.InvestigtionName.Split('~');
                invName = lstInvDetails[1];
                invIdNType = lstInvDetails[0] + "~" + lstInvDetails[2] + "~" + lstInvDetails[3] + "~" + lstInvDetails[4] + "~" + lstInvDetails[5] + "~" + lstInvDetails[6];
                if (dictPatientInvSample.ContainsKey(key))
                {
                    oNewPatientInvSample = dictPatientInvSample[key];
                    //lstInvName = oNewPatientInvSample.InvestigtionName.Split(',');
                    lstInvName = oNewPatientInvSample.ConsignmentNo.Split('^');
                    lstInvIdNType = oNewPatientInvSample.InvestigationID.Split('|');
                    if (!lstInvName.Contains(invName))
                    {
                        oNewPatientInvSample.InvestigtionName = oNewPatientInvSample.InvestigtionName + "," + invName;
                        oNewPatientInvSample.ConsignmentNo = oNewPatientInvSample.ConsignmentNo + "^" + invName;
                    }
                    if (!lstInvIdNType.Contains(invIdNType))
                        oNewPatientInvSample.InvestigationID = oNewPatientInvSample.InvestigationID + "|" + invIdNType;
                }
                else
                {
                    oNewPatientInvSample = oPatientInvSample;
                    oNewPatientInvSample.InvestigtionName = invName;
                    oNewPatientInvSample.InvestigationID = invIdNType;
                    oNewPatientInvSample.ConsignmentNo = invName;
                }
                dictPatientInvSample[key] = oNewPatientInvSample;
            }
            foreach (PatientInvSample objPatientInvSample in lstPatInvSample)
            {
                if (objPatientInvSample.AddExtraTube == "Y")
                {
                    key1 = objPatientInvSample.SampleCode + "~" + objPatientInvSample.RecSampleLocID + "~" + objPatientInvSample.SampleContainerID;
                    if (objPatientInvSample.InvestigtionName.Contains('~'))
                    {
                        lstInvDetails1 = objPatientInvSample.InvestigtionName.Split('~');
                        //invName1 = lstInvDetails1[1];
                        invName1 = "-";
                        invIdNType1 = lstInvDetails1[0] + "~" + lstInvDetails1[2] + "~" + lstInvDetails1[3] + "~" + lstInvDetails1[4] + "~" + lstInvDetails1[5];

                        if (dictPatientInvSample1.ContainsKey(key1))
                        {
                            objNewPatientInvSamples = dictPatientInvSample1[key1];
                            lstInvName1 = objNewPatientInvSamples.InvestigtionName.Split(',');
                            lstInvIdNType1 = objNewPatientInvSamples.InvestigationID.Split('|');
                            if (!lstInvName1.Contains(invName1))
                                objNewPatientInvSamples.InvestigtionName = objNewPatientInvSamples.InvestigtionName + "," + invName1;
                            if (!lstInvIdNType1.Contains(invIdNType1))
                                objNewPatientInvSamples.InvestigationID = objNewPatientInvSamples.InvestigationID + "|" + invIdNType1;
                        }
                        else
                        {
                            objNewPatientInvSamples = objPatientInvSample;
                            objNewPatientInvSamples.InvestigtionName = invName1;
                            objNewPatientInvSamples.InvestigationID = invIdNType1;
                        }
                        dictPatientInvSample1[key1] = objNewPatientInvSamples;
                    }
                }
            }
            lstGroupedSampleDetails = new List<PatientInvSample>(dictPatientInvSample.Values);
            lstfirstSampleDetails = new List<PatientInvSample>(dictPatientInvSample1.Values);
            foreach (PatientInvSample objPatientinvSample in lstfirstSampleDetails)
            {
                /****************Changed by Arivalagan.kk for less than 9 barcode number exception************/
                //objPatientinvSample.BarcodeNumber = objPatientinvSample.BarcodeNumber.Remove(9, 2);
                if (objPatientinvSample.BarcodeNumber.Length >= 9)
                {
                    objPatientinvSample.BarcodeNumber = objPatientinvSample.BarcodeNumber.Remove(9, 2);
                }
                else
                {
                    objPatientinvSample.BarcodeNumber = objPatientinvSample.BarcodeNumber;
                }
                /****************Changed by Arivalagan.kk for less than 9 barcode number exception************/
                lstGroupedSampleDetails.Add(objPatientinvSample);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while grouping collect sample details", ex);
            throw ex;
        }
        return lstGroupedSampleDetails;
    }
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }

    public List<PatientInvSample> GetAutoAlicotedSampleForOutSourcing(List<PatientInvSample> lstPatInvSample)
    {
        List<PatientInvSample> lstSampleNAlicotedSample = new List<PatientInvSample>();
        List<PatientInvSample> lstSample = new List<PatientInvSample>();
        List<PatientInvSample> lstAlicotedSample = new List<PatientInvSample>();
        List<PatientInvSample> lsttempAlicotedSample = new List<PatientInvSample>();
        PatientInvSample objPatientInvSample;
        try
        {
            lstSample = lstPatInvSample;
            lstAlicotedSample = lstPatInvSample.FindAll(p => p.IsOutsourcingSample == "Y");
            foreach (PatientInvSample oPatientInvSample in lstSample)
            {
                oPatientInvSample.IsAlicotedSample = "N";
            }
            foreach (PatientInvSample oAlicotedSample in lstAlicotedSample)
            {
                objPatientInvSample = new PatientInvSample();

                objPatientInvSample.Action = oAlicotedSample.Action;
                objPatientInvSample.BarcodeNumber = oAlicotedSample.BarcodeNumber;
                objPatientInvSample.CollectedDateTime = oAlicotedSample.CollectedDateTime;
                objPatientInvSample.CollectedLocID = oAlicotedSample.CollectedLocID;
                objPatientInvSample.CreatedAt = oAlicotedSample.CreatedAt;
                objPatientInvSample.CreatedBy = oAlicotedSample.CreatedBy;
                objPatientInvSample.InvestigationID = oAlicotedSample.InvestigationID;
                objPatientInvSample.InvestigtionName = oAlicotedSample.InvestigtionName;
                objPatientInvSample.InvSampleStatusDesc = oAlicotedSample.InvSampleStatusDesc;
                objPatientInvSample.InvSampleStatusID = oAlicotedSample.InvSampleStatusID;
                objPatientInvSample.IPInvSampleCollectionMasterID = oAlicotedSample.IPInvSampleCollectionMasterID;
                objPatientInvSample.IsAlicotedSample = oAlicotedSample.IsAlicotedSample;
                objPatientInvSample.IsOutsourcingSample = oAlicotedSample.IsOutsourcingSample;
                objPatientInvSample.LocationName = oAlicotedSample.LocationName;
                objPatientInvSample.ModifiedAt = oAlicotedSample.ModifiedAt;
                objPatientInvSample.ModifiedBy = oAlicotedSample.ModifiedBy;
                objPatientInvSample.OrgID = oAlicotedSample.OrgID;
                objPatientInvSample.Outsource = oAlicotedSample.Outsource;
                objPatientInvSample.PatientVisitID = oAlicotedSample.PatientVisitID;
                objPatientInvSample.Reason = oAlicotedSample.Reason;
                objPatientInvSample.Recorgid = oAlicotedSample.Recorgid;
                objPatientInvSample.RecSampleLocID = oAlicotedSample.RecSampleLocID;
                objPatientInvSample.SampleCode = oAlicotedSample.SampleCode;
                objPatientInvSample.SampleConditionID = oAlicotedSample.SampleConditionID;
                objPatientInvSample.SampleContainerID = oAlicotedSample.SampleContainerID;
                objPatientInvSample.SampleContainerName = oAlicotedSample.SampleContainerName;
                objPatientInvSample.SampleDesc = oAlicotedSample.SampleDesc;
                objPatientInvSample.SampleID = oAlicotedSample.SampleID;
                objPatientInvSample.SampleMappingID = oAlicotedSample.SampleMappingID;
                objPatientInvSample.SampleRelationshipID = oAlicotedSample.SampleRelationshipID;
                objPatientInvSample.UID = oAlicotedSample.UID;
                objPatientInvSample.VmUnitID = oAlicotedSample.VmUnitID;
                objPatientInvSample.VmValue = oAlicotedSample.VmValue;
                objPatientInvSample.IsAlicotedSample = "Y";
                lsttempAlicotedSample.Add(objPatientInvSample);
            }
            lstSampleNAlicotedSample = lstSample.Concat(lsttempAlicotedSample).ToList();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while GetAutoAlicotedSampleForOutSourcing in collect sample details", ex);
            throw ex;
        }
        return lstSampleNAlicotedSample;
    }

    #region Code added for XML conversion -  begin

    public void ConvertStringToXml(string rawData, out string xmlContent, out string xmlValue, out string xmlString)
    {
        xmlContent = string.Empty;
        xmlValue = string.Empty;
        xmlString = string.Empty;
        try
        {
            string[] lstReferenceRange = rawData.Split('#');
            if (lstReferenceRange.Count() > 0)
            {
                using (var sw = new StringWriter())
                {
                    using (var xw = XmlWriter.Create(sw))
                    {
                        xw.WriteStartDocument();
                        xw.WriteStartElement("referenceranges");
                        foreach (string rangeType in lstReferenceRange)
                        {
                            if (!String.IsNullOrEmpty(rangeType))
                            {
                                string[] ReferenceRange = rangeType.Split('$');
                                string[] lstSubCatagory = ReferenceRange[1].Split('@');
                                xw.WriteStartElement(ReferenceRange[0]);
                                foreach (string subCatagory in lstSubCatagory)
                                {
                                    if (!String.IsNullOrEmpty(subCatagory))
                                    {
                                        string[] CatagoryAgeMain = subCatagory.Split('|');
                                        //Age
                                        if (CatagoryAgeMain[1].ToString() == "Age")
                                        {
                                            Array CatagoryAgeSubarr = CatagoryAgeMain[0].Split('^');
                                            //xw.WriteStartElement(ReferenceRange[0]);
                                            for (int j = 0; j < CatagoryAgeSubarr.Length - 1; j++)
                                            {
                                                Array CatagoryAgeSubarrAge = CatagoryAgeSubarr.GetValue(j).ToString().Split('~');
                                                xw.WriteStartElement("property");
                                                xw.WriteAttributeString("type", "age");
                                                xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                xw.WriteAttributeString("mode", CatagoryAgeSubarrAge.GetValue(3).ToString());

                                                if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "lst")
                                                {
                                                    xw.WriteStartElement("lst");
                                                }
                                                else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "lsq")
                                                {
                                                    xw.WriteStartElement("lsq");
                                                }
                                                else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "eql")
                                                {
                                                    xw.WriteStartElement("eql");
                                                }
                                                else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "grt")
                                                {
                                                    xw.WriteStartElement("grt");
                                                }
                                                else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "grq")
                                                {
                                                    xw.WriteStartElement("grq");
                                                }
                                                else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "btw")
                                                {
                                                    xw.WriteStartElement("btw");
                                                }

                                                if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()) == "lst")
                                                {
                                                    xw.WriteAttributeString("mode", ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()));
                                                    xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                    xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                    xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(6).ToString());
                                                    xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(7).ToString());
                                                    xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(8).ToString());
                                                    xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(5).ToString());
                                                }
                                                else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()) == "lsq")
                                                {
                                                    xw.WriteAttributeString("mode", ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()));
                                                    xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                    xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                    xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(6).ToString());
                                                    xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(7).ToString());
                                                    xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(8).ToString());
                                                    xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(5).ToString());
                                                }
                                                else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()) == "eql")
                                                {
                                                    xw.WriteAttributeString("mode", ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()));
                                                    xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                    xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                    xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(6).ToString());
                                                    xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(7).ToString());
                                                    xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(8).ToString());
                                                    xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(5).ToString());
                                                }
                                                else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()) == "grt")
                                                {
                                                    xw.WriteAttributeString("mode", ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()));
                                                    xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                    xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                    xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(6).ToString());
                                                    xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(7).ToString());
                                                    xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(8).ToString());
                                                    xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(5).ToString());
                                                }
                                                else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()) == "grq")
                                                {
                                                    xw.WriteAttributeString("mode", ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()));
                                                    xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                    xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                    xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(6).ToString());
                                                    xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(7).ToString());
                                                    xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(8).ToString());
                                                    xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(5).ToString());
                                                }
                                                else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()) == "btw")
                                                {
                                                    xw.WriteAttributeString("mode", ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()));
                                                    xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                    xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                    xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(6).ToString());
                                                    xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(7).ToString());
                                                    xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(8).ToString());
                                                    xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(5).ToString());
                                                }
                                                else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()) == "ref")
                                                {
                                                    xw.WriteAttributeString("mode", ConvertOperator(CatagoryAgeSubarrAge.GetValue(4).ToString()));
                                                    xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                    xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                    xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(6).ToString());
                                                    xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(7).ToString());
                                                    xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(8).ToString());
                                                    xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(5).ToString());
                                                }
                                                xw.WriteString(CatagoryAgeSubarrAge.GetValue(2).ToString());
                                                xw.WriteEndElement();
                                                xw.WriteEndElement();
                                            }
                                            //xw.WriteEndElement();
                                        }
                                        //Common
                                        if (CatagoryAgeMain[1].ToString() == "Common")
                                        {
                                            Array CatagoryAgeSubarr = CatagoryAgeMain[0].Split('^');

                                            //xw.WriteStartElement(ReferenceRange[0]);
                                            for (int j = 0; j < CatagoryAgeSubarr.Length - 1; j++)
                                            {
                                                Array CatagoryAgeSubarrAge = CatagoryAgeSubarr.GetValue(j).ToString().Split('~');
                                                xw.WriteStartElement("property");
                                                xw.WriteAttributeString("type", "common");
                                                xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(0).ToString());

                                                if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "lst")
                                                {
                                                    xw.WriteStartElement("lst");
                                                    xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                    xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(4).ToString());
                                                    xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(5).ToString());
                                                    xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                }
                                                else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "lsq")
                                                {
                                                    xw.WriteStartElement("lsq");
                                                    xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                    xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(4).ToString());
                                                    xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(5).ToString());
                                                    xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                }
                                                else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "eql")
                                                {
                                                    xw.WriteStartElement("eql");
                                                    xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                    xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(4).ToString());
                                                    xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(5).ToString());
                                                    xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                }
                                                else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "grt")
                                                {
                                                    xw.WriteStartElement("grt");
                                                    xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                    xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(4).ToString());
                                                    xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(5).ToString());
                                                    xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                }
                                                else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "grq")
                                                {
                                                    xw.WriteStartElement("grq");
                                                    xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                    xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(4).ToString());
                                                    xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(5).ToString());
                                                    xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                }
                                                else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "btw")
                                                {
                                                    xw.WriteStartElement("btw");
                                                    xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                    xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(4).ToString());
                                                    xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(5).ToString());
                                                    xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                }
                                                else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(1).ToString()) == "ref")
                                                {
                                                    xw.WriteStartElement("ref");
                                                    xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                    xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(4).ToString());
                                                    xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(5).ToString());
                                                    xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                }
                                                xw.WriteString(CatagoryAgeSubarrAge.GetValue(2).ToString());
                                                xw.WriteEndElement();
                                                xw.WriteEndElement();
                                            }
                                            //xw.WriteEndElement();
                                        }
                                        //Other
                                        if (CatagoryAgeMain[1].ToString() == "Other")
                                        {

                                            Array CatagoryAgeSubarr = CatagoryAgeMain[0].Split('^');

                                            //xw.WriteStartElement(ReferenceRange[0]);
                                            for (int j = 0; j < CatagoryAgeSubarr.Length - 1; j++)
                                            {
                                                Array CatagoryAgeSubarrAge = CatagoryAgeSubarr.GetValue(j).ToString().Split('~');
                                                xw.WriteStartElement("property");
                                                xw.WriteAttributeString("type", "other");
                                                xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                if (CatagoryAgeSubarrAge.Length > 12)
                                                {
                                                    xw.WriteAttributeString("ResultType", CatagoryAgeSubarrAge.GetValue(12).ToString());
                                                    if (CatagoryAgeSubarrAge.GetValue(6) != null && CatagoryAgeSubarrAge.GetValue(6).ToString() != "")
                                                    {
                                                        xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(6).ToString());
                                                    }
                                                    if (CatagoryAgeSubarrAge.GetValue(12).ToString() == "Numeric")
                                                    {
                                                        if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(2).ToString()) == "lst")
                                                        {
                                                            xw.WriteStartElement("lst");
                                                            xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                            xw.WriteAttributeString("Normal", CatagoryAgeSubarrAge.GetValue(4).ToString());
                                                            if (CatagoryAgeSubarrAge.GetValue(6) != null && CatagoryAgeSubarrAge.GetValue(6).ToString() != "")
                                                            {
                                                                xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(6).ToString());
                                                                xw.WriteAttributeString("ageopr", ConvertOperator(CatagoryAgeSubarrAge.GetValue(7).ToString()));
                                                                xw.WriteAttributeString("agerange", CatagoryAgeSubarrAge.GetValue(8).ToString());
                                                            }
                                                            xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(9).ToString());
                                                            xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(10).ToString());
                                                            xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(11).ToString());
                                                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                        }
                                                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(2).ToString()) == "lsq")
                                                        {
                                                            xw.WriteStartElement("lsq");
                                                            xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                            xw.WriteAttributeString("Normal", CatagoryAgeSubarrAge.GetValue(4).ToString());
                                                            if (CatagoryAgeSubarrAge.GetValue(6) != null && CatagoryAgeSubarrAge.GetValue(6).ToString() != "")
                                                            {
                                                                xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(6).ToString());
                                                                xw.WriteAttributeString("ageopr", ConvertOperator(CatagoryAgeSubarrAge.GetValue(7).ToString()));
                                                                xw.WriteAttributeString("agerange", CatagoryAgeSubarrAge.GetValue(8).ToString());
                                                            }
                                                            xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(9).ToString());
                                                            xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(10).ToString());
                                                            xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(11).ToString());
                                                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                        }
                                                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(2).ToString()) == "eql")
                                                        {
                                                            xw.WriteStartElement("eql");
                                                            xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                            xw.WriteAttributeString("Normal", CatagoryAgeSubarrAge.GetValue(4).ToString());
                                                            if (CatagoryAgeSubarrAge.GetValue(6) != null && CatagoryAgeSubarrAge.GetValue(6).ToString() != "")
                                                            {
                                                                xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(6).ToString());
                                                                xw.WriteAttributeString("ageopr", ConvertOperator(CatagoryAgeSubarrAge.GetValue(7).ToString()));
                                                                xw.WriteAttributeString("agerange", CatagoryAgeSubarrAge.GetValue(8).ToString());
                                                            }
                                                            xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(9).ToString());
                                                            xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(10).ToString());
                                                            xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(11).ToString());
                                                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                        }
                                                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(2).ToString()) == "grt")
                                                        {
                                                            xw.WriteStartElement("grt");
                                                            xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                            xw.WriteAttributeString("Normal", CatagoryAgeSubarrAge.GetValue(4).ToString());
                                                            if (CatagoryAgeSubarrAge.GetValue(6) != null && CatagoryAgeSubarrAge.GetValue(6).ToString() != "")
                                                            {
                                                                xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(6).ToString());
                                                                xw.WriteAttributeString("ageopr", ConvertOperator(CatagoryAgeSubarrAge.GetValue(7).ToString()));
                                                                xw.WriteAttributeString("agerange", CatagoryAgeSubarrAge.GetValue(8).ToString());
                                                            }
                                                            xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(9).ToString());
                                                            xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(10).ToString());
                                                            xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(11).ToString());
                                                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                        }
                                                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(2).ToString()) == "grq")
                                                        {
                                                            xw.WriteStartElement("grq");
                                                            xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                            xw.WriteAttributeString("Normal", CatagoryAgeSubarrAge.GetValue(4).ToString());
                                                            if (CatagoryAgeSubarrAge.GetValue(6) != null && CatagoryAgeSubarrAge.GetValue(6).ToString() != "")
                                                            {
                                                                xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(6).ToString());
                                                                xw.WriteAttributeString("ageopr", ConvertOperator(CatagoryAgeSubarrAge.GetValue(7).ToString()));
                                                                xw.WriteAttributeString("agerange", CatagoryAgeSubarrAge.GetValue(8).ToString());
                                                            }
                                                            xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(9).ToString());
                                                            xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(10).ToString());
                                                            xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(11).ToString());
                                                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                        }
                                                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(2).ToString()) == "btw")
                                                        {
                                                            xw.WriteStartElement("btw");
                                                            xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                            xw.WriteAttributeString("Normal", CatagoryAgeSubarrAge.GetValue(4).ToString());
                                                            if (CatagoryAgeSubarrAge.GetValue(6) != null && CatagoryAgeSubarrAge.GetValue(6).ToString() != "")
                                                            {
                                                                xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(6).ToString());
                                                                xw.WriteAttributeString("ageopr", ConvertOperator(CatagoryAgeSubarrAge.GetValue(7).ToString()));
                                                                xw.WriteAttributeString("agerange", CatagoryAgeSubarrAge.GetValue(8).ToString());
                                                            }
                                                            xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(9).ToString());
                                                            xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(10).ToString());
                                                            xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(11).ToString());
                                                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                        }
                                                        else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(2).ToString()) == "ref")
                                                        {
                                                            xw.WriteStartElement("ref");
                                                            xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                            xw.WriteAttributeString("Normal", CatagoryAgeSubarrAge.GetValue(4).ToString());
                                                            if (CatagoryAgeSubarrAge.GetValue(6) != null && CatagoryAgeSubarrAge.GetValue(6).ToString() != "")
                                                            {
                                                                xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(6).ToString());
                                                                xw.WriteAttributeString("ageopr", ConvertOperator(CatagoryAgeSubarrAge.GetValue(7).ToString()));
                                                                xw.WriteAttributeString("agerange", CatagoryAgeSubarrAge.GetValue(8).ToString());
                                                            }
                                                            xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(9).ToString());
                                                            xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(10).ToString());
                                                            xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(11).ToString());
                                                            xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                        }
                                                    }
                                                    else if (CatagoryAgeSubarrAge.GetValue(12).ToString() == "Text")
                                                    {
                                                        if (CatagoryAgeSubarrAge.GetValue(5).ToString() == "Y")
                                                        {
                                                            xw.WriteStartElement("ref");
                                                            xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                            xw.WriteAttributeString("Normal", CatagoryAgeSubarrAge.GetValue(4).ToString());
                                                            if (CatagoryAgeSubarrAge.GetValue(6) != null && CatagoryAgeSubarrAge.GetValue(6).ToString() != "")
                                                            {
                                                                xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(6).ToString());
                                                                xw.WriteAttributeString("ageopr", ConvertOperator(CatagoryAgeSubarrAge.GetValue(7).ToString()));
                                                                xw.WriteAttributeString("agerange", CatagoryAgeSubarrAge.GetValue(8).ToString());
                                                            }
                                                            xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(9).ToString());
                                                            xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(10).ToString());
                                                            xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(11).ToString());
                                                            xw.WriteAttributeString("value", "");
                                                        }
                                                        else
                                                        {
                                                            xw.WriteStartElement("txt");
                                                            xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                            xw.WriteAttributeString("Normal", CatagoryAgeSubarrAge.GetValue(4).ToString());
                                                            if (CatagoryAgeSubarrAge.GetValue(6) != null && CatagoryAgeSubarrAge.GetValue(6).ToString() != "")
                                                            {
                                                                xw.WriteAttributeString("agetype", CatagoryAgeSubarrAge.GetValue(6).ToString());
                                                                xw.WriteAttributeString("ageopr", ConvertOperator(CatagoryAgeSubarrAge.GetValue(7).ToString()));
                                                                xw.WriteAttributeString("agerange", CatagoryAgeSubarrAge.GetValue(8).ToString());
                                                            }
                                                            xw.WriteAttributeString("data", CatagoryAgeSubarrAge.GetValue(9).ToString());
                                                            xw.WriteAttributeString("result", CatagoryAgeSubarrAge.GetValue(10).ToString());
                                                            xw.WriteAttributeString("device", CatagoryAgeSubarrAge.GetValue(11).ToString());
                                                            xw.WriteAttributeString("value", "");
                                                        }
                                                    }
                                                }
                                                else
                                                {
                                                    if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(2).ToString()) == "lst")
                                                    {
                                                        xw.WriteStartElement("lst");
                                                        xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                        xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                    }
                                                    else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(2).ToString()) == "lsq")
                                                    {
                                                        xw.WriteStartElement("lsq");
                                                        xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                        xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                    }
                                                    else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(2).ToString()) == "eql")
                                                    {
                                                        xw.WriteStartElement("eql");
                                                        xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                        xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                    }
                                                    else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(2).ToString()) == "grt")
                                                    {
                                                        xw.WriteStartElement("grt");
                                                        xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                        xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                    }
                                                    else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(2).ToString()) == "grq")
                                                    {
                                                        xw.WriteStartElement("grq");
                                                        xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                        xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                    }
                                                    else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(2).ToString()) == "btw")
                                                    {
                                                        xw.WriteStartElement("btw");
                                                        xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                        xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                    }
                                                    else if (ConvertOperator(CatagoryAgeSubarrAge.GetValue(2).ToString()) == "ref")
                                                    {
                                                        xw.WriteStartElement("ref");
                                                        xw.WriteAttributeString("gender", CatagoryAgeSubarrAge.GetValue(0).ToString());
                                                        xw.WriteAttributeString("value", CatagoryAgeSubarrAge.GetValue(3).ToString());
                                                    }
                                                }

                                                xw.WriteString(CatagoryAgeSubarrAge.GetValue(1).ToString());
                                                xw.WriteEndElement();
                                                xw.WriteEndElement();
                                            }
                                            //xw.WriteEndElement();
                                        }
                                    }
                                }
                                xw.WriteEndElement();
                            }
                        }
                        xw.WriteEndElement();
                        xw.WriteEndDocument();
                        xw.Close();
                    }
                    xmlContent += sw.ToString();
                }
                ConvertXmlToString(xmlContent, out xmlValue, out xmlString);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while converting string to xml", ex);
            throw ex;
        }
    }

    public decimal ConvertResultValue(string result, out bool isNumericValue)
    {
        isNumericValue = false;
        decimal returnValue = 0;
        try
        {
            if (!string.IsNullOrEmpty(result))
            {
                decimal numericResult = 0;
                string opr = string.Empty;
                if (result.Contains("<") || result.ToLower().Contains("below"))
                {
                    opr = "lst";
                    result = result.Replace("<", "").Replace("Below", "").Replace("below", "");
                }
                if (result.Contains(">") || result.ToLower().Contains("above"))
                {
                    opr = "grt";
                    result = result.Replace(">", "").Replace("Above", "").Replace("above", "");
                }
                if (result.Contains(','))
                {
                    string[] lstresultinter = result.Split(',');
                    if (lstresultinter.Length > 1)
                    {
                        result = lstresultinter[1].ToString();
                    }
                }
                if (decimal.TryParse(result, out numericResult))
                {
                    isNumericValue = true;
                    if (opr == "lst")
                    {
                        numericResult = numericResult - 1;
                    }
                    else if (opr == "grt")
                    {
                        numericResult = numericResult + 1;
                    }
                    returnValue = numericResult;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while converting result values", ex);
        }
        return returnValue;
    }

    public decimal IsSpecialResultValue(string result, out bool isSpecialValue)
    {
        isSpecialValue = false;
        decimal returnValue = 0;
        try
        {
            if (!string.IsNullOrEmpty(result) && (result.Contains("<") || result.ToLower().Contains("below") || result.Contains(">") || result.ToLower().Contains("above")))
            {
                isSpecialValue = true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while checking is special result values", ex);
        }
        return returnValue;
    }

    public string ConvertOperator(string symbol)
    {
        string ReturnValue = "";
        try
        {
            switch (symbol)
            {
                case "<":
                    ReturnValue = "lst";
                    break;
                case "<=":
                    ReturnValue = "lsq";
                    break;
                case "=":
                    ReturnValue = "eql";
                    break;
                case ">":
                    ReturnValue = "grt";
                    break;
                case "=>":
                    ReturnValue = "grq";
                    break;
                case "Between":
                    ReturnValue = "btw";
                    break;
                case "Source":
                    ReturnValue = "ref";
                    break;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while converting operator", ex);
            throw ex;
        }
        return ReturnValue;
    }

    public string ConvertStringOptr(string symbol)
    {
        string ReturnValue = "";
        try
        {
            switch (symbol)
            {
                case "lst":
                    ReturnValue = "<";
                    break;
                case "lsq":
                    ReturnValue = "<=";
                    break;
                case "eql":
                    ReturnValue = "=";
                    break;
                case "grt":
                    ReturnValue = ">";
                    break;
                case "grq":
                    ReturnValue = "=>";
                    break;
                case "btw":
                    ReturnValue = "Between";
                    break;
                case "ref":
                    ReturnValue = "Source";
                    break;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while converting string to operator", ex);
            throw ex;
        }
        return ReturnValue;

    }
    public void ConvertXmlToExtend(string rawData, out string xmlContent, out string ReferenceRange, out string ReferenceRangeString, string Tempxml)
    {
        ReferenceRange = string.Empty;
        ReferenceRangeString = string.Empty;
        xmlContent = Tempxml;
        var RangeRR = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_011 == null ? "Reference Range" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_011;
        var RangeCR = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_012 == null ? "Critical Range" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_012;
        var RangeAAR = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_013 == null ? "Auto Authorization Range" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_013;
        var RangeDR = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_014 == null ? "Domain Range" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_014;
        var RangePR = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_015 == null ? "Printable Range" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_015;
        var RangePRR = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_069 == null ? "Panic Range" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_069;
        var RangeRIR = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_017 == null ? "Results Interpretation Range" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_017;

        var varAge = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_054 == null ? "Age" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_054;
        var varCommon = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_055 == null ? "Common" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_055;
        var varOther = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_056 == null ? "Other" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_056;
        var varBoth = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_058 == null ? "Both" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_058;
        var varFemale = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_059 == null ? "Female" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_059;
        var varMale = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_060 == null ? "Male" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_060;
        var varDays = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061 == null ? "Day(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061;
        var varMonths = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062 == null ? "Month(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062;
        var varWeeks = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063 == null ? "Week(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063;
        var varYears = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064 == null ? "Year(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064;
        var varbetween = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_079 == null ? "Between" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_079;
        var varsource = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_080 == null ? "Source" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_080;
        if (rawData != null && rawData != "")
        {
            ConvertStringToXml(rawData, out xmlContent, out ReferenceRange, out ReferenceRangeString);
        }
        else
        {
            ConvertXmlToString(xmlContent, out ReferenceRange, out ReferenceRangeString);
        }
        ReferenceRange = ReferenceRange.Replace("Reference Range", RangeRR);
        ReferenceRange = ReferenceRange.Replace("Critical Range", RangeCR);
        ReferenceRange = ReferenceRange.Replace("Auto Authorization Range", RangeAAR);
        ReferenceRange = ReferenceRange.Replace("Domain Range", RangeDR);
        ReferenceRange = ReferenceRange.Replace("Printable Range", RangePR);
        ReferenceRange = ReferenceRange.Replace("Panic Range", RangePRR);
        ReferenceRange = ReferenceRange.Replace("Results Interpretation Range", RangeRIR);
        ReferenceRange = ReferenceRange.Replace("Age", varAge);
        ReferenceRange = ReferenceRange.Replace("Common", varCommon);
        ReferenceRange = ReferenceRange.Replace("Other", varOther);
        ReferenceRange = ReferenceRange.Replace("Both", varBoth);
        ReferenceRange = ReferenceRange.Replace("Female", varFemale);
        ReferenceRange = ReferenceRange.Replace("Male", varMale);
        ReferenceRange = ReferenceRange.Replace("Day(s)", varDays);
        ReferenceRange = ReferenceRange.Replace("Month(s)", varMonths);
        ReferenceRange = ReferenceRange.Replace("Week(s)", varWeeks);
        ReferenceRange = ReferenceRange.Replace("Year(s)", varYears);
        ReferenceRange = ReferenceRange.Replace("Between", varbetween);
        ReferenceRange = ReferenceRange.Replace("Source", varsource);
    }
    public void ConvertXmlToString(string xmlData, out string ReferenceRange, out string ReferenceRangeString)
    {
        long returnCode = -1;
        try
        {
            ReferenceRange = string.Empty;
            ReferenceRangeString = string.Empty;

            XElement xe = XElement.Parse(xmlData);

            MetaData oMetaData = new MetaData();
            string LangCode = "en-GB";
            List<MetaData> lstDomain = new List<MetaData>();
            List<MetaData> lstMetaData = new List<MetaData>();
            
            oMetaData = new MetaData();
            lstDomain = new List<MetaData>();
            oMetaData.Domain = "TestReferenceRangeType";
            lstDomain.Add(oMetaData);
            lstMetaData = new List<MetaData>();
            returnCode = new MetaData_BL(new BaseClass().ContextInfo).LoadMetaData_New(lstDomain, LangCode, out lstMetaData);

            if (lstMetaData.Count > 0)
            {
                List<MetaData> lstReferenceRangeType = ((from child in lstMetaData
                                                         where child.Domain == "TestReferenceRangeType" && child.Code != "0"
                                                         select child).Distinct()).ToList();
                Int32 itemCount = 0;
                if (lstReferenceRangeType != null && lstReferenceRangeType.Count > 0)
                {
                    foreach (MetaData oRRMetaData in lstReferenceRangeType)
                    {
                        var ageRange = from age in xe.Elements(oRRMetaData.Code).Elements("property")
                                       where (string)age.Attribute("type") == "age"
                                       select age;
                        var commonRange = from common in xe.Elements(oRRMetaData.Code).Elements("property")
                                          where (string)common.Attribute("type") == "common"
                                          select common;

                        var otherRange = from otherWithNumeric in xe.Elements(oRRMetaData.Code).Elements("property")
                                         where (string)otherWithNumeric.Attribute("type") == "other" && (string)otherWithNumeric.Attribute("ResultType") == null && (string)otherWithNumeric.Attribute("agetype") == null
                                         select otherWithNumeric;

                        var otherRangeWithNumeric = from otherWithNumeric in xe.Elements(oRRMetaData.Code).Elements("property")
                                                    where (string)otherWithNumeric.Attribute("type") == "other" && (string)otherWithNumeric.Attribute("ResultType") == "Numeric" && (string)otherWithNumeric.Attribute("agetype") == null
                                                    select otherWithNumeric;

                        var otherRangeWithText = from otherWithText in xe.Elements(oRRMetaData.Code).Elements("property")
                                                 where (string)otherWithText.Attribute("type") == "other" && (string)otherWithText.Attribute("ResultType") == "Text" && (string)otherWithText.Attribute("agetype") == null
                                                 select otherWithText;

                        var otherNumericWithAge = from otherWithNumeric in xe.Elements(oRRMetaData.Code).Elements("property")
                                                  where (string)otherWithNumeric.Attribute("type") == "other" && (string)otherWithNumeric.Attribute("ResultType") == "Numeric" && (string)otherWithNumeric.Attribute("agetype") != null
                                                  select otherWithNumeric;

                        var otherTextWithAge = from otherWithText in xe.Elements(oRRMetaData.Code).Elements("property")
                                               where (string)otherWithText.Attribute("type") == "other" && (string)otherWithText.Attribute("ResultType") == "Text" && (string)otherWithText.Attribute("agetype") != null
                                               select otherWithText;

                        if ((otherRange != null && otherRange.Count() > 0) || (ageRange != null && ageRange.Count() > 0) || (commonRange != null && commonRange.Count() > 0) || (otherRangeWithText != null && otherRangeWithText.Count() > 0) || (otherRangeWithNumeric != null && otherRangeWithNumeric.Count() > 0) || (otherNumericWithAge != null && otherNumericWithAge.Count() > 0) || (otherTextWithAge != null && otherTextWithAge.Count() > 0))
                        {
                            if (itemCount != 0 && !string.IsNullOrEmpty(ReferenceRangeString))
                            {
                                ReferenceRange += "<br/>";
                                ReferenceRangeString += "#";
                            }
                            if (oRRMetaData.DisplayText == "Reference Range")
                            {
                                oRRMetaData.DisplayText = "<b><span style='font-weight: bold'>Reference Range</span></b> ";
                            }
                            if (oRRMetaData.DisplayText == "Domain Range")
                            {
                                oRRMetaData.DisplayText = "<b><span style='color: Blue'>Domain Range</span></b> ";
                            }
                            if (oRRMetaData.DisplayText == "Auto Authorization Range")
                            {
                                oRRMetaData.DisplayText = "<b><span style='color: DarkGreen'>Auto Authorization Range</span></b> ";
                            }
                            if (oRRMetaData.DisplayText == "Panic Range")
                            {
                                oRRMetaData.DisplayText = "<b><span style='color: Red'>Panic Range</span></b> ";
                            }
                            if (oRRMetaData.DisplayText == "Printable Range")
                            {
                                oRRMetaData.DisplayText = "<b><span style='font-weight: bold'>Printable Range</span></b> ";
                            }
                            if (oRRMetaData.DisplayText == "Results Interpretation Range")
                            {
                                oRRMetaData.DisplayText = "<b><span style='font-weight: bold'>Results Interpretation Range</span></b> ";
                            }
                            ReferenceRange += oRRMetaData.DisplayText + "<br/>";
                            ReferenceRangeString += oRRMetaData.Code + "$";
                        }

                        if (ageRange != null && ageRange.Count() > 0)
                        {
                            foreach (var lst in ageRange)
                            {
                                if (lst.Element("lst") != null)
                                {
                                    if (lst.Element("lst").Attribute("mode").Value != "ref")
                                    {
                                        ReferenceRange += lst.Element("lst").Attribute("gender").Value + ": " + ConvertStringOptr("lst") + " " + lst.Element("lst").Value + " " + lst.Element("lst").Attribute("agetype").Value + " : " + (ConvertStringOptr(lst.Element("lst").Attribute("mode").Value)) + " " + lst.Element("lst").Attribute("value").Value + (lst.Element("lst").Attribute("data") != null && lst.Element("lst").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("lst").Attribute("data").Value : string.Empty) + (lst.Element("lst").Attribute("result") != null && lst.Element("lst").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("lst").Attribute("result").Value : string.Empty) + (lst.Element("lst").Attribute("device") != null && lst.Element("lst").Attribute("device").Value != "" ? " Device: " + lst.Element("lst").Attribute("device").Value : string.Empty) + "<br/>";
                                        ReferenceRangeString += lst.Element("lst").Attribute("gender").Value + "~" + ConvertStringOptr("lst") + "~" + lst.Element("lst").Value + "~" + lst.Element("lst").Attribute("agetype").Value + "~" + (ConvertStringOptr(lst.Element("lst").Attribute("mode").Value)) + "~" + lst.Element("lst").Attribute("value").Value + "~" + (lst.Element("lst").Attribute("data") != null ? lst.Element("lst").Attribute("data").Value : string.Empty) + "~" + (lst.Element("lst").Attribute("result") != null ? lst.Element("lst").Attribute("result").Value : string.Empty) + "~" + (lst.Element("lst").Attribute("device") != null ? lst.Element("lst").Attribute("device").Value : string.Empty) + "^";
                                    }
                                    else
                                    {
                                        ReferenceRange += lst.Element("lst").Attribute("value").Value + "<br/>";
                                        ReferenceRangeString += lst.Element("lst").Attribute("gender").Value + "~" + ConvertStringOptr("lst") + "~" + lst.Element("lst").Value + "~" + lst.Element("lst").Attribute("agetype").Value + "~" + (ConvertStringOptr(lst.Element("lst").Attribute("mode").Value)) + "~" + lst.Element("lst").Attribute("value").Value + "~~~~" + "^";
                                    }
                                }
                                if (lst.Element("lsq") != null)
                                {
                                    if (lst.Element("lsq").Attribute("mode").Value != "ref")
                                    {
                                        ReferenceRange += lst.Element("lsq").Attribute("gender").Value + ": " + ConvertStringOptr("lsq") + " " + lst.Element("lsq").Value + " " + lst.Element("lsq").Attribute("agetype").Value + " : " + (ConvertStringOptr(lst.Element("lsq").Attribute("mode").Value)) + " " + lst.Element("lsq").Attribute("value").Value + (lst.Element("lsq").Attribute("data") != null && lst.Element("lsq").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("lsq").Attribute("data").Value : string.Empty) + (lst.Element("lsq").Attribute("result") != null && lst.Element("lsq").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("lsq").Attribute("result").Value : string.Empty) + (lst.Element("lsq").Attribute("device") != null && lst.Element("lsq").Attribute("device").Value != "" ? " Device: " + lst.Element("lsq").Attribute("device").Value : string.Empty) + "<br/>";
                                        ReferenceRangeString += lst.Element("lsq").Attribute("gender").Value + "~" + ConvertStringOptr("lsq") + "~" + lst.Element("lsq").Value + "~" + lst.Element("lsq").Attribute("agetype").Value + "~" + (ConvertStringOptr(lst.Element("lsq").Attribute("mode").Value)) + "~" + lst.Element("lsq").Attribute("value").Value + "~" + (lst.Element("lsq").Attribute("data") != null ? lst.Element("lsq").Attribute("data").Value : string.Empty) + "~" + (lst.Element("lsq").Attribute("result") != null ? lst.Element("lsq").Attribute("result").Value : string.Empty) + "~" + (lst.Element("lsq").Attribute("device") != null ? lst.Element("lsq").Attribute("device").Value : string.Empty) + "^";
                                    }
                                    else
                                    {
                                        ReferenceRange += lst.Element("lsq").Attribute("value").Value + "<br/>";
                                        ReferenceRangeString += lst.Element("lsq").Attribute("gender").Value + "~" + ConvertStringOptr("lsq") + "~" + lst.Element("lsq").Value + "~" + lst.Element("lsq").Attribute("agetype").Value + "~" + (ConvertStringOptr(lst.Element("lsq").Attribute("mode").Value)) + "~" + lst.Element("lsq").Attribute("value").Value + "~~~~" + "^";
                                    }
                                }
                                if (lst.Element("eql") != null)
                                {
                                    if (lst.Element("eql").Attribute("mode").Value != "ref")
                                    {
                                        ReferenceRange += lst.Element("eql").Attribute("gender").Value + ": " + ConvertStringOptr("eql") + " " + lst.Element("eql").Value + " " + lst.Element("eql").Attribute("agetype").Value + " : " + (ConvertStringOptr(lst.Element("eql").Attribute("mode").Value)) + " " + lst.Element("eql").Attribute("value").Value + (lst.Element("eql").Attribute("data") != null && lst.Element("eql").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("eql").Attribute("data").Value : string.Empty) + (lst.Element("eql").Attribute("result") != null && lst.Element("eql").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("eql").Attribute("result").Value : string.Empty) + (lst.Element("eql").Attribute("device") != null && lst.Element("eql").Attribute("device").Value != "" ? " Device: " + lst.Element("eql").Attribute("device").Value : string.Empty) + "<br/>";
                                        ReferenceRangeString += lst.Element("eql").Attribute("gender").Value + "~" + ConvertStringOptr("eql") + "~" + lst.Element("eql").Value + "~" + lst.Element("eql").Attribute("agetype").Value + "~" + (ConvertStringOptr(lst.Element("eql").Attribute("mode").Value)) + "~" + lst.Element("eql").Attribute("value").Value + "~" + (lst.Element("eql").Attribute("data") != null ? lst.Element("eql").Attribute("data").Value : string.Empty) + "~" + (lst.Element("eql").Attribute("result") != null ? lst.Element("eql").Attribute("result").Value : string.Empty) + "~" + (lst.Element("eql").Attribute("device") != null ? lst.Element("eql").Attribute("device").Value : string.Empty) + "^";
                                    }
                                    else
                                    {
                                        ReferenceRange += lst.Element("eql").Attribute("value").Value + "<br/>";
                                        ReferenceRangeString += lst.Element("eql").Attribute("gender").Value + "~" + ConvertStringOptr("eql") + "~" + lst.Element("eql").Value + "~" + lst.Element("eql").Attribute("agetype").Value + "~" + (ConvertStringOptr(lst.Element("eql").Attribute("mode").Value)) + "~" + lst.Element("eql").Attribute("value").Value + "~~~~" + "^";
                                    }
                                }
                                if (lst.Element("grt") != null)
                                {
                                    if (lst.Element("grt").Attribute("mode").Value != "ref")
                                    {
                                        ReferenceRange += lst.Element("grt").Attribute("gender").Value + ": " + ConvertStringOptr("grt") + " " + lst.Element("grt").Value + " " + lst.Element("grt").Attribute("agetype").Value + " : " + (ConvertStringOptr(lst.Element("grt").Attribute("mode").Value)) + " " + lst.Element("grt").Attribute("value").Value + (lst.Element("grt").Attribute("data") != null && lst.Element("grt").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("grt").Attribute("data").Value : string.Empty) + (lst.Element("grt").Attribute("result") != null && lst.Element("grt").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("grt").Attribute("result").Value : string.Empty) + (lst.Element("grt").Attribute("device") != null && lst.Element("grt").Attribute("device").Value != "" ? " Device: " + lst.Element("grt").Attribute("device").Value : string.Empty) + "<br/>";
                                        ReferenceRangeString += lst.Element("grt").Attribute("gender").Value + "~" + ConvertStringOptr("grt") + "~" + lst.Element("grt").Value + "~" + lst.Element("grt").Attribute("agetype").Value + "~" + (ConvertStringOptr(lst.Element("grt").Attribute("mode").Value)) + "~" + lst.Element("grt").Attribute("value").Value + "~" + (lst.Element("grt").Attribute("data") != null ? lst.Element("grt").Attribute("data").Value : string.Empty) + "~" + (lst.Element("grt").Attribute("result") != null ? lst.Element("grt").Attribute("result").Value : string.Empty) + "~" + (lst.Element("grt").Attribute("device") != null ? lst.Element("grt").Attribute("device").Value : string.Empty) + "^";
                                    }
                                    else
                                    {
                                        ReferenceRange += lst.Element("grt").Attribute("value").Value + "<br/>";
                                        ReferenceRangeString += lst.Element("grt").Attribute("gender").Value + "~" + ConvertStringOptr("grt") + "~" + lst.Element("grt").Value + "~" + lst.Element("grt").Attribute("agetype").Value + "~" + (ConvertStringOptr(lst.Element("grt").Attribute("mode").Value)) + "~" + lst.Element("grt").Attribute("value").Value + "~~~~" + "^";
                                    }
                                }
                                if (lst.Element("grq") != null)
                                {
                                    if (lst.Element("grq").Attribute("mode").Value != "ref")
                                    {
                                        ReferenceRange += lst.Element("grq").Attribute("gender").Value + ": " + ConvertStringOptr("grq") + " " + lst.Element("grq").Value + " " + lst.Element("grq").Attribute("agetype").Value + " : " + (ConvertStringOptr(lst.Element("grq").Attribute("mode").Value)) + " " + lst.Element("grq").Attribute("value").Value + (lst.Element("grq").Attribute("data") != null && lst.Element("grq").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("grq").Attribute("data").Value : string.Empty) + (lst.Element("grq").Attribute("result") != null && lst.Element("grq").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("grq").Attribute("result").Value : string.Empty) + (lst.Element("grq").Attribute("device") != null && lst.Element("grq").Attribute("device").Value != "" ? " Device: " + lst.Element("grq").Attribute("device").Value : string.Empty) + "<br/>";
                                        ReferenceRangeString += lst.Element("grq").Attribute("gender").Value + "~" + ConvertStringOptr("grq") + "~" + lst.Element("grq").Value + "~" + lst.Element("grq").Attribute("agetype").Value + "~" + (ConvertStringOptr(lst.Element("grq").Attribute("mode").Value)) + "~" + lst.Element("grq").Attribute("value").Value + "~" + (lst.Element("grq").Attribute("data") != null ? lst.Element("grq").Attribute("data").Value : string.Empty) + "~" + (lst.Element("grq").Attribute("result") != null ? lst.Element("grq").Attribute("result").Value : string.Empty) + "~" + (lst.Element("grq").Attribute("device") != null ? lst.Element("grq").Attribute("device").Value : string.Empty) + "^";
                                    }
                                    else
                                    {
                                        ReferenceRange += lst.Element("grq").Attribute("value").Value + "<br/>";
                                        ReferenceRangeString += lst.Element("grq").Attribute("gender").Value + "~" + ConvertStringOptr("grq") + "~" + lst.Element("grq").Value + "~" + lst.Element("grq").Attribute("agetype").Value + "~" + (ConvertStringOptr(lst.Element("grq").Attribute("mode").Value)) + "~" + lst.Element("grq").Attribute("value").Value + "~~~~" + "^";
                                    }
                                }
                                if (lst.Element("btw") != null)
                                {
                                    string[] between = lst.Element("btw").Value.Split('-');
                                    if (lst.Element("btw").Attribute("mode").Value != "ref")
                                    {
                                        ReferenceRange += lst.Element("btw").Attribute("gender").Value + ": " + ConvertStringOptr("btw") + " " + AddSpace(lst.Element("btw").Value) + " " + lst.Element("btw").Attribute("agetype").Value + " : " + (ConvertStringOptr(lst.Element("btw").Attribute("mode").Value)) + " " + lst.Element("btw").Attribute("value").Value + (lst.Element("btw").Attribute("data") != null && lst.Element("btw").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("btw").Attribute("data").Value : string.Empty) + (lst.Element("btw").Attribute("result") != null && lst.Element("btw").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("btw").Attribute("result").Value : string.Empty) + (lst.Element("btw").Attribute("device") != null && lst.Element("btw").Attribute("device").Value != "" ? " Device: " + lst.Element("btw").Attribute("device").Value : string.Empty) + "<br/>";
                                        ReferenceRangeString += lst.Element("btw").Attribute("gender").Value + "~" + ConvertStringOptr("btw") + "~" + AddSpace(lst.Element("btw").Value) + "~" + lst.Element("btw").Attribute("agetype").Value + "~" + (ConvertStringOptr(lst.Element("btw").Attribute("mode").Value)) + "~" + lst.Element("btw").Attribute("value").Value + "~" + (lst.Element("btw").Attribute("data") != null ? lst.Element("btw").Attribute("data").Value : string.Empty) + "~" + (lst.Element("btw").Attribute("result") != null ? lst.Element("btw").Attribute("result").Value : string.Empty) + "~" + (lst.Element("btw").Attribute("device") != null ? lst.Element("btw").Attribute("device").Value : string.Empty) + "^";
                                    }
                                    else
                                    {
                                        ReferenceRange += lst.Element("btw").Attribute("value").Value + "<br/>";
                                        ReferenceRangeString += lst.Element("btw").Attribute("gender").Value + "~" + ConvertStringOptr("btw") + "~" + lst.Element("btw").Value + "~" + lst.Element("btw").Attribute("agetype").Value + "~" + (ConvertStringOptr(lst.Element("btw").Attribute("mode").Value)) + "~" + lst.Element("btw").Attribute("value").Value + "~~~~" + "^";
                                    }
                                }
                            }
                            ReferenceRangeString += "|Age@";
                        }

                        if (commonRange != null && commonRange.Count() > 0)
                        {
                            foreach (var lst in commonRange)
                            {
                                if (lst.Element("lst") != null)
                                {
                                    ReferenceRange += lst.Element("lst").Attribute("value").Value + ": < " + lst.Element("lst").Value + (lst.Element("lst").Attribute("data") != null && lst.Element("lst").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("lst").Attribute("data").Value : string.Empty) + (lst.Element("lst").Attribute("result") != null && lst.Element("lst").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("lst").Attribute("result").Value : string.Empty) + (lst.Element("lst").Attribute("device") != null && lst.Element("lst").Attribute("device").Value != "" ? " Device: " + lst.Element("lst").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("lst").Attribute("value").Value + "~" + "<" + "~" + lst.Element("lst").Value + "~" + (lst.Element("lst").Attribute("data") != null ? lst.Element("lst").Attribute("data").Value : string.Empty) + "~" + (lst.Element("lst").Attribute("result") != null ? lst.Element("lst").Attribute("result").Value : string.Empty) + "~" + (lst.Element("lst").Attribute("device") != null ? lst.Element("lst").Attribute("device").Value : string.Empty) + "^";
                                }

                                if (lst.Element("lsq") != null)
                                {
                                    ReferenceRange += lst.Element("lsq").Attribute("value").Value + ": <= " + lst.Element("lsq").Value + (lst.Element("lsq").Attribute("data") != null && lst.Element("lsq").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("lsq").Attribute("data").Value : string.Empty) + (lst.Element("lsq").Attribute("result") != null && lst.Element("lsq").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("lsq").Attribute("result").Value : string.Empty) + (lst.Element("lsq").Attribute("device") != null && lst.Element("lsq").Attribute("device").Value != "" ? " Device: " + lst.Element("lsq").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("lsq").Attribute("value").Value + "~" + "<=" + "~" + lst.Element("lsq").Value + "~" + (lst.Element("lsq").Attribute("data") != null ? lst.Element("lsq").Attribute("data").Value : string.Empty) + "~" + (lst.Element("lsq").Attribute("result") != null ? lst.Element("lsq").Attribute("result").Value : string.Empty) + "~" + (lst.Element("lsq").Attribute("device") != null ? lst.Element("lsq").Attribute("device").Value : string.Empty) + "^";
                                }

                                if (lst.Element("eql") != null)
                                {
                                    ReferenceRange += lst.Element("eql").Attribute("value").Value + ": = " + lst.Element("eql").Value + (lst.Element("eql").Attribute("data") != null && lst.Element("eql").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("eql").Attribute("data").Value : string.Empty) + (lst.Element("eql").Attribute("result") != null && lst.Element("eql").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("eql").Attribute("result").Value : string.Empty) + (lst.Element("eql").Attribute("device") != null && lst.Element("eql").Attribute("device").Value != "" ? " Device: " + lst.Element("eql").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("eql").Attribute("value").Value + "~" + "=" + "~" + lst.Element("eql").Value + "~" + (lst.Element("eql").Attribute("data") != null ? lst.Element("eql").Attribute("data").Value : string.Empty) + "~" + (lst.Element("eql").Attribute("result") != null ? lst.Element("eql").Attribute("result").Value : string.Empty) + "~" + (lst.Element("eql").Attribute("device") != null ? lst.Element("eql").Attribute("device").Value : string.Empty) + "^";
                                }

                                if (lst.Element("grt") != null)
                                {
                                    ReferenceRange += lst.Element("grt").Attribute("value").Value + ": > " + lst.Element("grt").Value + (lst.Element("grt").Attribute("data") != null && lst.Element("grt").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("grt").Attribute("data").Value : string.Empty) + (lst.Element("grt").Attribute("result") != null && lst.Element("grt").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("grt").Attribute("result").Value : string.Empty) + (lst.Element("grt").Attribute("device") != null && lst.Element("grt").Attribute("device").Value != "" ? " Device: " + lst.Element("grt").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("grt").Attribute("value").Value + "~" + ">" + "~" + lst.Element("grt").Value + "~" + (lst.Element("grt").Attribute("data") != null ? lst.Element("grt").Attribute("data").Value : string.Empty) + "~" + (lst.Element("grt").Attribute("result") != null ? lst.Element("grt").Attribute("result").Value : string.Empty) + "~" + (lst.Element("grt").Attribute("device") != null ? lst.Element("grt").Attribute("device").Value : string.Empty) + "^";
                                }


                                if (lst.Element("grq") != null)
                                {
                                    ReferenceRange += lst.Element("grq").Attribute("value").Value + ": => " + lst.Element("grq").Value + (lst.Element("grq").Attribute("data") != null && lst.Element("grq").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("grq").Attribute("data").Value : string.Empty) + (lst.Element("grq").Attribute("result") != null && lst.Element("grq").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("grq").Attribute("result").Value : string.Empty) + (lst.Element("grq").Attribute("device") != null && lst.Element("grq").Attribute("device").Value != "" ? " Device: " + lst.Element("grq").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("grq").Attribute("value").Value + "~" + "=>" + "~" + lst.Element("grq").Value + "~" + (lst.Element("grq").Attribute("data") != null ? lst.Element("grq").Attribute("data").Value : string.Empty) + "~" + (lst.Element("grq").Attribute("result") != null ? lst.Element("grq").Attribute("result").Value : string.Empty) + "~" + (lst.Element("grq").Attribute("device") != null ? lst.Element("grq").Attribute("device").Value : string.Empty) + "^";
                                }

                                if (lst.Element("btw") != null)
                                {
                                    ReferenceRange += lst.Element("btw").Attribute("value").Value + ": " + lst.Element("btw").Value + (lst.Element("btw").Attribute("data") != null && lst.Element("btw").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("btw").Attribute("data").Value : string.Empty) + (lst.Element("btw").Attribute("result") != null && lst.Element("btw").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("btw").Attribute("result").Value : string.Empty) + (lst.Element("btw").Attribute("device") != null && lst.Element("btw").Attribute("device").Value != "" ? " Device: " + lst.Element("btw").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("btw").Attribute("value").Value + "~" + ConvertStringOptr("btw") + "~" + lst.Element("btw").Value + "~" + (lst.Element("btw").Attribute("data") != null ? lst.Element("btw").Attribute("data").Value : string.Empty) + "~" + (lst.Element("btw").Attribute("result") != null ? lst.Element("btw").Attribute("result").Value : string.Empty) + "~" + (lst.Element("btw").Attribute("device") != null ? lst.Element("btw").Attribute("device").Value : string.Empty) + "^";
                                }
                                if (lst.Element("ref") != null)
                                {
                                    ReferenceRange += lst.Element("ref").Value + "<br/>";
                                    ReferenceRangeString += lst.Element("ref").Attribute("value").Value + "~" + ConvertStringOptr("ref") + "~" + lst.Element("ref").Value + "~~~" + "^";
                                }
                            }
                            ReferenceRangeString += "|Common@";
                        }

                        if (otherNumericWithAge != null && otherNumericWithAge.Count() > 0)
                        {
                            foreach (var lst in otherNumericWithAge)
                            {
                                string ResulType = "Numeric";

                                if (lst.Element("lst") != null)
                                {
                                    ReferenceRange += lst.Element("lst").Attribute("gender").Value + ": " + ConvertStringOptr(lst.Element("lst").Attribute("ageopr").Value) + " " + lst.Element("lst").Attribute("agerange").Value + " " + lst.Element("lst").Attribute("agetype").Value + " : " + lst.Element("lst").Value + ": < " + lst.Element("lst").Attribute("value").Value + (lst.Element("lst").Attribute("data") != null && lst.Element("lst").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("lst").Attribute("data").Value : string.Empty) + (lst.Element("lst").Attribute("result") != null && lst.Element("lst").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("lst").Attribute("result").Value : string.Empty) + (lst.Element("lst").Attribute("device") != null && lst.Element("lst").Attribute("device").Value != "" ? " Device: " + lst.Element("lst").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("lst").Attribute("gender").Value + "~" + lst.Element("lst").Value + "~" + "<" + "~" + lst.Element("lst").Attribute("value").Value + "~" + (lst.Element("lst").Attribute("Normal") != null ? lst.Element("lst").Attribute("Normal").Value : string.Empty) + "~~" + lst.Element("lst").Attribute("agetype").Value + "~" + ConvertStringOptr(lst.Element("lst").Attribute("ageopr").Value) + "~" + lst.Element("lst").Attribute("agerange").Value + "~" + (lst.Element("lst").Attribute("data") != null ? lst.Element("lst").Attribute("data").Value : string.Empty) + "~" + (lst.Element("lst").Attribute("result") != null ? lst.Element("lst").Attribute("result").Value : string.Empty) + "~" + (lst.Element("lst").Attribute("device") != null ? lst.Element("lst").Attribute("device").Value : string.Empty) + "~" + ResulType + "^";
                                }
                                if (lst.Element("lsq") != null)
                                {
                                    ReferenceRange += lst.Element("lsq").Attribute("gender").Value + ": " + ConvertStringOptr(lst.Element("lsq").Attribute("ageopr").Value) + " " + lst.Element("lsq").Attribute("agerange").Value + " " + lst.Element("lsq").Attribute("agetype").Value + " : " + lst.Element("lsq").Value + ": <= " + lst.Element("lsq").Attribute("value").Value + (lst.Element("lsq").Attribute("data") != null && lst.Element("lsq").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("lsq").Attribute("data").Value : string.Empty) + (lst.Element("lsq").Attribute("result") != null && lst.Element("lsq").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("lsq").Attribute("result").Value : string.Empty) + (lst.Element("lsq").Attribute("device") != null && lst.Element("lsq").Attribute("device").Value != "" ? " Device: " + lst.Element("lsq").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("lsq").Attribute("gender").Value + "~" + lst.Element("lsq").Value + "~" + "<=" + "~" + lst.Element("lsq").Attribute("value").Value + "~" + (lst.Element("lsq").Attribute("Normal") != null ? lst.Element("lsq").Attribute("Normal").Value : string.Empty) + "~~" + lst.Element("lsq").Attribute("agetype").Value + "~" + ConvertStringOptr(lst.Element("lsq").Attribute("ageopr").Value) + "~" + lst.Element("lsq").Attribute("agerange").Value + "~" + (lst.Element("lsq").Attribute("data") != null ? lst.Element("lsq").Attribute("data").Value : string.Empty) + "~" + (lst.Element("lsq").Attribute("result") != null ? lst.Element("lsq").Attribute("result").Value : string.Empty) + "~" + (lst.Element("lsq").Attribute("device") != null ? lst.Element("lsq").Attribute("device").Value : string.Empty) + "~" + ResulType + "^";
                                }

                                if (lst.Element("eql") != null)
                                {
                                    ReferenceRange += lst.Element("eql").Attribute("gender").Value + ": " + ConvertStringOptr(lst.Element("eql").Attribute("ageopr").Value) + " " + lst.Element("eql").Attribute("agerange").Value + " " + lst.Element("eql").Attribute("agetype").Value + " : " + lst.Element("eql").Value + ": = " + lst.Element("eql").Attribute("value").Value + (lst.Element("eql").Attribute("data") != null && lst.Element("eql").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("eql").Attribute("data").Value : string.Empty) + (lst.Element("eql").Attribute("result") != null && lst.Element("eql").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("eql").Attribute("result").Value : string.Empty) + (lst.Element("eql").Attribute("device") != null && lst.Element("eql").Attribute("device").Value != "" ? " Device: " + lst.Element("eql").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("eql").Attribute("gender").Value + "~" + lst.Element("eql").Value + "~" + "=" + "~" + lst.Element("eql").Attribute("value").Value + "~" + (lst.Element("eql").Attribute("Normal") != null ? lst.Element("eql").Attribute("Normal").Value : string.Empty) + "~~" + lst.Element("eql").Attribute("agetype").Value + "~" + ConvertStringOptr(lst.Element("eql").Attribute("ageopr").Value) + "~" + lst.Element("eql").Attribute("agerange").Value + "~" + (lst.Element("eql").Attribute("data") != null ? lst.Element("eql").Attribute("data").Value : string.Empty) + "~" + (lst.Element("eql").Attribute("result") != null ? lst.Element("eql").Attribute("result").Value : string.Empty) + "~" + (lst.Element("eql").Attribute("device") != null ? lst.Element("eql").Attribute("device").Value : string.Empty) + "~" + ResulType + "^";
                                }

                                if (lst.Element("grt") != null)
                                {
                                    ReferenceRange += lst.Element("grt").Attribute("gender").Value + ": " + ConvertStringOptr(lst.Element("grt").Attribute("ageopr").Value) + " " + lst.Element("grt").Attribute("agerange").Value + " " + lst.Element("grt").Attribute("agetype").Value + " : " + lst.Element("grt").Value + ": > " + lst.Element("grt").Attribute("value").Value + (lst.Element("grt").Attribute("data") != null && lst.Element("grt").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("grt").Attribute("data").Value : string.Empty) + (lst.Element("grt").Attribute("result") != null && lst.Element("grt").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("grt").Attribute("result").Value : string.Empty) + (lst.Element("grt").Attribute("device") != null && lst.Element("grt").Attribute("device").Value != "" ? " Device: " + lst.Element("grt").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("grt").Attribute("gender").Value + "~" + lst.Element("grt").Value + "~" + ">" + "~" + lst.Element("grt").Attribute("value").Value + "~" + (lst.Element("grt").Attribute("Normal") != null ? lst.Element("grt").Attribute("Normal").Value : string.Empty) + "~~" + lst.Element("grt").Attribute("agetype").Value + "~" + ConvertStringOptr(lst.Element("grt").Attribute("ageopr").Value) + "~" + lst.Element("grt").Attribute("agerange").Value + "~" + (lst.Element("grt").Attribute("data") != null ? lst.Element("grt").Attribute("data").Value : string.Empty) + "~" + (lst.Element("grt").Attribute("result") != null ? lst.Element("grt").Attribute("result").Value : string.Empty) + "~" + (lst.Element("grt").Attribute("device") != null ? lst.Element("grt").Attribute("device").Value : string.Empty) + "~" + ResulType + "^";
                                }

                                if (lst.Element("grq") != null)
                                {
                                    ReferenceRange += lst.Element("grq").Attribute("gender").Value + ": " + ConvertStringOptr(lst.Element("grq").Attribute("ageopr").Value) + " " + lst.Element("grq").Attribute("agerange").Value + " " + lst.Element("grq").Attribute("agetype").Value + " : " + lst.Element("grq").Value + ": => " + lst.Element("grq").Attribute("value").Value + (lst.Element("grq").Attribute("data") != null && lst.Element("grq").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("grq").Attribute("data").Value : string.Empty) + (lst.Element("grq").Attribute("result") != null && lst.Element("grq").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("grq").Attribute("result").Value : string.Empty) + (lst.Element("grq").Attribute("device") != null && lst.Element("grq").Attribute("device").Value != "" ? " Device: " + lst.Element("grq").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("grq").Attribute("gender").Value + "~" + lst.Element("grq").Value + "~" + "=>" + "~" + lst.Element("grq").Attribute("value").Value + "~" + (lst.Element("grq").Attribute("Normal") != null ? lst.Element("grq").Attribute("Normal").Value : string.Empty) + "~~" + lst.Element("grq").Attribute("agetype").Value + "~" + ConvertStringOptr(lst.Element("grq").Attribute("ageopr").Value) + "~" + lst.Element("grq").Attribute("agerange").Value + "~" + (lst.Element("grq").Attribute("data") != null ? lst.Element("grq").Attribute("data").Value : string.Empty) + "~" + (lst.Element("grq").Attribute("result") != null ? lst.Element("grq").Attribute("result").Value : string.Empty) + "~" + (lst.Element("grq").Attribute("device") != null ? lst.Element("grq").Attribute("device").Value : string.Empty) + "~" + ResulType + "^";
                                }

                                if (lst.Element("btw") != null)
                                {
                                    ReferenceRange += lst.Element("btw").Attribute("gender").Value + ": " + ConvertStringOptr(lst.Element("btw").Attribute("ageopr").Value) + " " + lst.Element("btw").Attribute("agerange").Value + " " + lst.Element("btw").Attribute("agetype").Value + " : " + lst.Element("btw").Value + ": " + lst.Element("btw").Attribute("value").Value + (lst.Element("btw").Attribute("data") != null && lst.Element("btw").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("btw").Attribute("data").Value : string.Empty) + (lst.Element("btw").Attribute("result") != null && lst.Element("btw").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("btw").Attribute("result").Value : string.Empty) + (lst.Element("btw").Attribute("device") != null && lst.Element("btw").Attribute("device").Value != "" ? " Device: " + lst.Element("btw").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("btw").Attribute("gender").Value + "~" + lst.Element("btw").Value + "~" + ConvertStringOptr("btw") + "~" + lst.Element("btw").Attribute("value").Value + "~" + (lst.Element("btw").Attribute("Normal") != null ? lst.Element("btw").Attribute("Normal").Value : string.Empty) + "~~" + lst.Element("btw").Attribute("agetype").Value + "~" + ConvertStringOptr(lst.Element("btw").Attribute("ageopr").Value) + "~" + lst.Element("btw").Attribute("agerange").Value + "~" + (lst.Element("btw").Attribute("data") != null ? lst.Element("btw").Attribute("data").Value : string.Empty) + "~" + (lst.Element("btw").Attribute("result") != null ? lst.Element("btw").Attribute("result").Value : string.Empty) + "~" + (lst.Element("btw").Attribute("device") != null ? lst.Element("btw").Attribute("device").Value : string.Empty) + "~" + ResulType + "^";
                                }
                                if (lst.Element("ref") != null)
                                {
                                    ReferenceRange += ConvertStringOptr(lst.Element("ref").Attribute("ageopr").Value) + " " + lst.Element("ref").Attribute("agerange").Value + " " + lst.Element("ref").Attribute("agetype").Value + " : " + lst.Element("ref").Value + "<br/>";
                                    ReferenceRangeString += lst.Element("ref").Attribute("gender").Value + "~" + lst.Element("ref").Value + "~" + ConvertStringOptr("ref") + "~" + lst.Element("ref").Attribute("value").Value + "~" + (lst.Element("ref").Attribute("Normal") != null ? lst.Element("ref").Attribute("Normal").Value : string.Empty) + "~Y~" + lst.Element("ref").Attribute("agetype").Value + "~" + ConvertStringOptr(lst.Element("ref").Attribute("ageopr").Value) + "~" + lst.Element("ref").Attribute("agerange").Value + "~~~~" + ResulType + "^";
                                }
                            }

                            ReferenceRangeString += "|Other@";
                        }
                        if (otherTextWithAge != null && otherTextWithAge.Count() > 0)
                        {
                            foreach (var lst in otherTextWithAge)
                            {
                                string ResulType = string.Empty;
                                ResulType = "Text";

                                if (lst.Element("txt") != null)
                                {
                                    ReferenceRange += lst.Element("txt").Attribute("gender").Value + ": " + ConvertStringOptr(lst.Element("txt").Attribute("ageopr").Value) + " " + lst.Element("txt").Attribute("agerange").Value + " " + lst.Element("txt").Attribute("agetype").Value + " : " + lst.Element("txt").Value + (lst.Element("txt").Attribute("data") != null && lst.Element("txt").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("txt").Attribute("data").Value : string.Empty) + (lst.Element("txt").Attribute("result") != null && lst.Element("txt").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("txt").Attribute("result").Value : string.Empty) + (lst.Element("txt").Attribute("device") != null && lst.Element("txt").Attribute("device").Value != "" ? " Device: " + lst.Element("txt").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("txt").Attribute("gender").Value + "~" + lst.Element("txt").Value + "~~~" + lst.Element("txt").Attribute("Normal").Value + "~~" + lst.Element("txt").Attribute("agetype").Value + "~" + ConvertStringOptr(lst.Element("txt").Attribute("ageopr").Value) + "~" + lst.Element("txt").Attribute("agerange").Value + "~" + (lst.Element("txt").Attribute("data") != null ? lst.Element("txt").Attribute("data").Value : string.Empty) + "~" + (lst.Element("txt").Attribute("result") != null ? lst.Element("txt").Attribute("result").Value : string.Empty) + "~" + (lst.Element("txt").Attribute("device") != null ? lst.Element("txt").Attribute("device").Value : string.Empty) + "~" + ResulType + "^";
                                }
                                if (lst.Element("ref") != null)
                                {
                                    ReferenceRange += ConvertStringOptr(lst.Element("ref").Attribute("ageopr").Value) + " " + lst.Element("ref").Attribute("agerange").Value + " " + lst.Element("ref").Attribute("agetype").Value + " : " + lst.Element("ref").Value + "<br/>";
                                    ReferenceRangeString += lst.Element("ref").Attribute("gender").Value + "~" + lst.Element("ref").Value + "~" + ConvertStringOptr("ref") + "~~" + lst.Element("ref").Attribute("Normal").Value + "~Y~" + lst.Element("ref").Attribute("agetype").Value + "~" + ConvertStringOptr(lst.Element("ref").Attribute("ageopr").Value) + "~" + lst.Element("ref").Attribute("agerange").Value + "~~~~" + ResulType + "^";
                                }
                            }
                            ReferenceRangeString += "|Other@";
                        }
                        if (otherRangeWithNumeric != null && otherRangeWithNumeric.Count() > 0)
                        {
                            foreach (var lst in otherRangeWithNumeric)
                            {
                                string ResulType = "Numeric";

                                if (lst.Element("lst") != null)
                                {
                                    ReferenceRange += lst.Element("lst").Attribute("gender").Value + ": " + lst.Element("lst").Value + ": < " + lst.Element("lst").Attribute("value").Value + (lst.Element("lst").Attribute("data") != null && lst.Element("lst").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("lst").Attribute("data").Value : string.Empty) + (lst.Element("lst").Attribute("result") != null && lst.Element("lst").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("lst").Attribute("result").Value : string.Empty) + (lst.Element("lst").Attribute("device") != null && lst.Element("lst").Attribute("device").Value != "" ? " Device: " + lst.Element("lst").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("lst").Attribute("gender").Value + "~" + lst.Element("lst").Value + "~" + "<" + "~" + lst.Element("lst").Attribute("value").Value + "~" + (lst.Element("lst").Attribute("Normal") != null ? lst.Element("lst").Attribute("Normal").Value : string.Empty) + "~~~~~" + (lst.Element("lst").Attribute("data") != null ? lst.Element("lst").Attribute("data").Value : string.Empty) + "~" + (lst.Element("lst").Attribute("result") != null ? lst.Element("lst").Attribute("result").Value : string.Empty) + "~" + (lst.Element("lst").Attribute("device") != null ? lst.Element("lst").Attribute("device").Value : string.Empty) + "~" + ResulType + "^";

                                }
                                if (lst.Element("lsq") != null)
                                {
                                    ReferenceRange += lst.Element("lsq").Attribute("gender").Value + ": " + lst.Element("lsq").Value + ": <= " + lst.Element("lsq").Attribute("value").Value + (lst.Element("lsq").Attribute("data") != null && lst.Element("lsq").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("lsq").Attribute("data").Value : string.Empty) + (lst.Element("lsq").Attribute("result") != null && lst.Element("lsq").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("lsq").Attribute("result").Value : string.Empty) + (lst.Element("lsq").Attribute("device") != null && lst.Element("lsq").Attribute("device").Value != "" ? " Device: " + lst.Element("lsq").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("lsq").Attribute("gender").Value + "~" + lst.Element("lsq").Value + "~" + "<=" + "~" + lst.Element("lsq").Attribute("value").Value + "~" + (lst.Element("lsq").Attribute("Normal") != null ? lst.Element("lsq").Attribute("Normal").Value : string.Empty) + "~~~~~" + (lst.Element("lsq").Attribute("data") != null ? lst.Element("lsq").Attribute("data").Value : string.Empty) + "~" + (lst.Element("lsq").Attribute("result") != null ? lst.Element("lsq").Attribute("result").Value : string.Empty) + "~" + (lst.Element("lsq").Attribute("device") != null ? lst.Element("lsq").Attribute("device").Value : string.Empty) + "~" + ResulType + "^";
                                }

                                if (lst.Element("eql") != null)
                                {
                                    ReferenceRange += lst.Element("eql").Attribute("gender").Value + ": " + lst.Element("eql").Value + ": = " + lst.Element("eql").Attribute("value").Value + (lst.Element("eql").Attribute("data") != null && lst.Element("eql").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("eql").Attribute("data").Value : string.Empty) + (lst.Element("eql").Attribute("result") != null && lst.Element("eql").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("eql").Attribute("result").Value : string.Empty) + (lst.Element("eql").Attribute("device") != null && lst.Element("eql").Attribute("device").Value != "" ? " Device: " + lst.Element("eql").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("eql").Attribute("gender").Value + "~" + lst.Element("eql").Value + "~" + "=" + "~" + lst.Element("eql").Attribute("value").Value + "~" + (lst.Element("eql").Attribute("Normal") != null ? lst.Element("eql").Attribute("Normal").Value : string.Empty) + "~~~~~" + (lst.Element("eql").Attribute("data") != null ? lst.Element("eql").Attribute("data").Value : string.Empty) + "~" + (lst.Element("eql").Attribute("result") != null ? lst.Element("eql").Attribute("result").Value : string.Empty) + "~" + (lst.Element("eql").Attribute("device") != null ? lst.Element("eql").Attribute("device").Value : string.Empty) + "~" + ResulType + "^";
                                }

                                if (lst.Element("grt") != null)
                                {
                                    ReferenceRange += lst.Element("grt").Attribute("gender").Value + ": " + lst.Element("grt").Value + ": > " + lst.Element("grt").Attribute("value").Value + (lst.Element("grt").Attribute("data") != null && lst.Element("grt").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("grt").Attribute("data").Value : string.Empty) + (lst.Element("grt").Attribute("result") != null && lst.Element("grt").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("grt").Attribute("result").Value : string.Empty) + (lst.Element("grt").Attribute("device") != null && lst.Element("grt").Attribute("device").Value != "" ? " Device: " + lst.Element("grt").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("grt").Attribute("gender").Value + "~" + lst.Element("grt").Value + "~" + ">" + "~" + lst.Element("grt").Attribute("value").Value + "~" + (lst.Element("grt").Attribute("Normal") != null ? lst.Element("grt").Attribute("Normal").Value : string.Empty) + "~~~~~" + (lst.Element("grt").Attribute("data") != null ? lst.Element("grt").Attribute("data").Value : string.Empty) + "~" + (lst.Element("grt").Attribute("result") != null ? lst.Element("grt").Attribute("result").Value : string.Empty) + "~" + (lst.Element("grt").Attribute("device") != null ? lst.Element("grt").Attribute("device").Value : string.Empty) + "~" + ResulType + "^";
                                }


                                if (lst.Element("grq") != null)
                                {
                                    ReferenceRange += lst.Element("grq").Attribute("gender").Value + ": " + lst.Element("grq").Value + ": => " + lst.Element("grq").Attribute("value").Value + (lst.Element("grq").Attribute("data") != null && lst.Element("grq").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("grq").Attribute("data").Value : string.Empty) + (lst.Element("grq").Attribute("result") != null && lst.Element("grq").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("grq").Attribute("result").Value : string.Empty) + (lst.Element("grq").Attribute("device") != null && lst.Element("grq").Attribute("device").Value != "" ? " Device: " + lst.Element("grq").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("grq").Attribute("gender").Value + "~" + lst.Element("grq").Value + "~" + "=>" + "~" + lst.Element("grq").Attribute("value").Value + "~" + (lst.Element("grq").Attribute("Normal") != null ? lst.Element("grq").Attribute("Normal").Value : string.Empty) + "~~~~~" + (lst.Element("grq").Attribute("data") != null ? lst.Element("grq").Attribute("data").Value : string.Empty) + "~" + (lst.Element("grq").Attribute("result") != null ? lst.Element("grq").Attribute("result").Value : string.Empty) + "~" + (lst.Element("grq").Attribute("device") != null ? lst.Element("grq").Attribute("device").Value : string.Empty) + "~" + ResulType + "^";
                                }

                                if (lst.Element("btw") != null)
                                {
                                    ReferenceRange += lst.Element("btw").Attribute("gender").Value + ": " + lst.Element("btw").Value + ": " + lst.Element("btw").Attribute("value").Value + (lst.Element("btw").Attribute("data") != null && lst.Element("btw").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("btw").Attribute("data").Value : string.Empty) + (lst.Element("btw").Attribute("result") != null && lst.Element("btw").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("btw").Attribute("result").Value : string.Empty) + (lst.Element("btw").Attribute("device") != null && lst.Element("btw").Attribute("device").Value != "" ? " Device: " + lst.Element("btw").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("btw").Attribute("gender").Value + "~" + lst.Element("btw").Value + "~" + ConvertStringOptr("btw") + "~" + lst.Element("btw").Attribute("value").Value + "~" + (lst.Element("btw").Attribute("Normal") != null ? lst.Element("btw").Attribute("Normal").Value : string.Empty) + "~~~~~" + (lst.Element("btw").Attribute("data") != null ? lst.Element("btw").Attribute("data").Value : string.Empty) + "~" + (lst.Element("btw").Attribute("result") != null ? lst.Element("btw").Attribute("result").Value : string.Empty) + "~" + (lst.Element("btw").Attribute("device") != null ? lst.Element("btw").Attribute("device").Value : string.Empty) + "~" + ResulType + "^";
                                }
                                if (lst.Element("ref") != null)
                                {
                                    ReferenceRange += lst.Element("ref").Value + "<br/>";
                                    ReferenceRangeString += lst.Element("ref").Attribute("gender").Value + "~" + lst.Element("ref").Value + "~" + ConvertStringOptr("ref") + "~" + lst.Element("ref").Attribute("value").Value + "~" + (lst.Element("ref").Attribute("Normal") != null ? lst.Element("ref").Attribute("Normal").Value : string.Empty) + "~Y~~~~~~~" + ResulType + "^";
                                }
                            }

                            ReferenceRangeString += "|Other@";
                        }
                        if (otherRangeWithText != null && otherRangeWithText.Count() > 0)
                        {
                            foreach (var lst in otherRangeWithText)
                            {
                                string ResulType = "Text";

                                if (lst.Element("txt") != null)
                                {
                                    ReferenceRange += lst.Element("txt").Attribute("gender").Value + ": " + lst.Element("txt").Value + (lst.Element("txt").Attribute("data") != null && lst.Element("txt").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("txt").Attribute("data").Value : string.Empty) + (lst.Element("txt").Attribute("result") != null && lst.Element("txt").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("txt").Attribute("result").Value : string.Empty) + (lst.Element("txt").Attribute("device") != null && lst.Element("txt").Attribute("device").Value != "" ? " Device: " + lst.Element("txt").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("txt").Attribute("gender").Value + "~" + lst.Element("txt").Value + "~~~" + lst.Element("txt").Attribute("Normal").Value + "~~~~~" + (lst.Element("txt").Attribute("data") != null ? lst.Element("txt").Attribute("data").Value : string.Empty) + "~" + (lst.Element("txt").Attribute("result") != null ? lst.Element("txt").Attribute("result").Value : string.Empty) + "~" + (lst.Element("txt").Attribute("device") != null ? lst.Element("txt").Attribute("device").Value : string.Empty) + "~" + ResulType + "^";
                                }
                                if (lst.Element("ref") != null)
                                {
                                    ReferenceRange += lst.Element("ref").Value + "<br/>";
                                    ReferenceRangeString += lst.Element("ref").Attribute("gender").Value + "~" + lst.Element("ref").Value + "~" + ConvertStringOptr("ref") + "~~" + lst.Element("ref").Attribute("Normal").Value + "~Y~~~~~~~" + ResulType + "^";
                                }
                            }
                            ReferenceRangeString += "|Other@";
                        }
                        if (otherRange != null && otherRange.Count() > 0)
                        {
                            foreach (var lst in otherRange)
                            {
                                string ResulType = "Numeric";

                                if (lst.Element("lst") != null)
                                {
                                    ReferenceRange += lst.Element("lst").Attribute("gender").Value + ": " + lst.Element("lst").Value + ": < " + lst.Element("lst").Attribute("value").Value + (lst.Element("lst").Attribute("data") != null && lst.Element("lst").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("lst").Attribute("data").Value : string.Empty) + (lst.Element("lst").Attribute("result") != null && lst.Element("lst").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("lst").Attribute("result").Value : string.Empty) + (lst.Element("lst").Attribute("device") != null && lst.Element("lst").Attribute("device").Value != "" ? " Device: " + lst.Element("lst").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("lst").Attribute("gender").Value + "~" + lst.Element("lst").Value + "~" + "<" + "~" + lst.Element("lst").Attribute("value").Value + "~~~~~~" + (lst.Element("lst").Attribute("data") != null ? lst.Element("lst").Attribute("data").Value : string.Empty) + "~" + (lst.Element("lst").Attribute("result") != null ? lst.Element("lst").Attribute("result").Value : string.Empty) + "~" + (lst.Element("lst").Attribute("device") != null ? lst.Element("lst").Attribute("device").Value : string.Empty) + "~" + ResulType + "^";

                                }
                                if (lst.Element("lsq") != null)
                                {
                                    ReferenceRange += lst.Element("lsq").Attribute("gender").Value + ": " + lst.Element("lsq").Value + ": <= " + lst.Element("lsq").Attribute("value").Value + (lst.Element("lsq").Attribute("data") != null && lst.Element("lsq").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("lsq").Attribute("data").Value : string.Empty) + (lst.Element("lsq").Attribute("result") != null && lst.Element("lsq").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("lsq").Attribute("result").Value : string.Empty) + (lst.Element("lsq").Attribute("device") != null && lst.Element("lsq").Attribute("device").Value != "" ? " Device: " + lst.Element("lsq").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("lsq").Attribute("gender").Value + "~" + lst.Element("lsq").Value + "~" + "<=" + "~" + lst.Element("lsq").Attribute("value").Value + "~~~~~~" + (lst.Element("lsq").Attribute("data") != null ? lst.Element("lsq").Attribute("data").Value : string.Empty) + "~" + (lst.Element("lsq").Attribute("result") != null ? lst.Element("lsq").Attribute("result").Value : string.Empty) + "~" + (lst.Element("lsq").Attribute("device") != null ? lst.Element("lsq").Attribute("device").Value : string.Empty) + "~" + ResulType + "^";
                                }

                                if (lst.Element("eql") != null)
                                {
                                    ReferenceRange += lst.Element("eql").Attribute("gender").Value + ": " + lst.Element("eql").Value + ": = " + lst.Element("eql").Attribute("value").Value + (lst.Element("eql").Attribute("data") != null && lst.Element("eql").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("eql").Attribute("data").Value : string.Empty) + (lst.Element("eql").Attribute("result") != null && lst.Element("eql").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("eql").Attribute("result").Value : string.Empty) + (lst.Element("eql").Attribute("device") != null && lst.Element("eql").Attribute("device").Value != "" ? " Device: " + lst.Element("eql").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("eql").Attribute("gender").Value + "~" + lst.Element("eql").Value + "~" + "=" + "~" + lst.Element("eql").Attribute("value").Value + "~~~~~~" + (lst.Element("eql").Attribute("data") != null ? lst.Element("eql").Attribute("data").Value : string.Empty) + "~" + (lst.Element("eql").Attribute("result") != null ? lst.Element("eql").Attribute("result").Value : string.Empty) + "~" + (lst.Element("eql").Attribute("device") != null ? lst.Element("eql").Attribute("device").Value : string.Empty) + "~" + ResulType + "^";
                                }

                                if (lst.Element("grt") != null)
                                {
                                    ReferenceRange += lst.Element("grt").Attribute("gender").Value + ": " + lst.Element("grt").Value + ": > " + lst.Element("grt").Attribute("value").Value + (lst.Element("grt").Attribute("data") != null && lst.Element("grt").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("grt").Attribute("data").Value : string.Empty) + (lst.Element("grt").Attribute("result") != null && lst.Element("grt").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("grt").Attribute("result").Value : string.Empty) + (lst.Element("grt").Attribute("device") != null && lst.Element("grt").Attribute("device").Value != "" ? " Device: " + lst.Element("grt").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("grt").Attribute("gender").Value + "~" + lst.Element("grt").Value + "~" + ">" + "~" + lst.Element("grt").Attribute("value").Value + "~~~~~~" + (lst.Element("grt").Attribute("data") != null ? lst.Element("grt").Attribute("data").Value : string.Empty) + "~" + (lst.Element("grt").Attribute("result") != null ? lst.Element("grt").Attribute("result").Value : string.Empty) + "~" + (lst.Element("grt").Attribute("device") != null ? lst.Element("grt").Attribute("device").Value : string.Empty) + "~" + ResulType + "^";
                                }


                                if (lst.Element("grq") != null)
                                {
                                    ReferenceRange += lst.Element("grq").Attribute("gender").Value + ": " + lst.Element("grq").Value + ": => " + lst.Element("grq").Attribute("value").Value + (lst.Element("grq").Attribute("data") != null && lst.Element("grq").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("grq").Attribute("data").Value : string.Empty) + (lst.Element("grq").Attribute("result") != null && lst.Element("grq").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("grq").Attribute("result").Value : string.Empty) + (lst.Element("grq").Attribute("device") != null && lst.Element("grq").Attribute("device").Value != "" ? " Device: " + lst.Element("grq").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("grq").Attribute("gender").Value + "~" + lst.Element("grq").Value + "~" + "=>" + "~" + lst.Element("grq").Attribute("value").Value + "~~~~~~" + (lst.Element("grq").Attribute("data") != null ? lst.Element("grq").Attribute("data").Value : string.Empty) + "~" + (lst.Element("grq").Attribute("result") != null ? lst.Element("grq").Attribute("result").Value : string.Empty) + "~" + (lst.Element("grq").Attribute("device") != null ? lst.Element("grq").Attribute("device").Value : string.Empty) + "~" + ResulType + "^";
                                }

                                if (lst.Element("btw") != null)
                                {
                                    ReferenceRange += lst.Element("btw").Attribute("gender").Value + ": " + lst.Element("btw").Value + ": " + lst.Element("btw").Attribute("value").Value + (lst.Element("btw").Attribute("data") != null && lst.Element("btw").Attribute("data").Value != "" ? " Interpretation: " + lst.Element("btw").Attribute("data").Value : string.Empty) + (lst.Element("btw").Attribute("result") != null && lst.Element("btw").Attribute("result").Value != "" ? " Show Result From: " + lst.Element("btw").Attribute("result").Value : string.Empty) + (lst.Element("btw").Attribute("device") != null && lst.Element("btw").Attribute("device").Value != "" ? " Device: " + lst.Element("btw").Attribute("device").Value : string.Empty) + "<br/>";
                                    ReferenceRangeString += lst.Element("btw").Attribute("gender").Value + "~" + lst.Element("btw").Value + "~" + ConvertStringOptr("btw") + "~" + lst.Element("btw").Attribute("value").Value + "~~~~~~" + (lst.Element("btw").Attribute("data") != null ? lst.Element("btw").Attribute("data").Value : string.Empty) + "~" + (lst.Element("btw").Attribute("result") != null ? lst.Element("btw").Attribute("result").Value : string.Empty) + "~" + (lst.Element("btw").Attribute("device") != null ? lst.Element("btw").Attribute("device").Value : string.Empty) + "~" + ResulType + "^";
                                }
                                if (lst.Element("ref") != null)
                                {
                                    ReferenceRange += lst.Element("ref").Value + "<br/>";
                                    ReferenceRangeString += lst.Element("ref").Attribute("gender").Value + "~" + lst.Element("ref").Value + "~" + ConvertStringOptr("ref") + "~" + lst.Element("ref").Attribute("value").Value + "~~Y~~~~~~~" + ResulType + "^";
                                }
                            }

                            ReferenceRangeString += "|Other@";
                        }

                        itemCount = itemCount + 1;
                        if (ReferenceRangeString.EndsWith("@"))
                        {
                            ReferenceRangeString = ReferenceRangeString.Substring(0, ReferenceRangeString.Length - 1);
                        }
                    }
                }
            }
            //ReferenceRange = ReferenceRange.EndsWith("\n") ? ReferenceRange.Substring(0, ReferenceRange.Length - 2) : ReferenceRange;
            if (ReferenceRange == "")
            {
                //if (xe.Elements("referencerange").Elements("property") != null)
                //{
                //    ReferenceRange = "NIL";
                //}
                //else
                //{
                ReferenceRange = xmlData;
                ReferenceRangeString = xmlData;
                //}
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while converting xml to string", ex);
            throw ex;
        }
    }

    public static bool TryParseXml(string xml)
    {
        try
        {
            XElement xe = XElement.Parse(xml);
            return true;
        }
        catch (XmlException e)
        {
            return false;
        }
    }

    string AddSpace(string text)
    {
        string spacedText = string.Empty;
        try
        {
            string[] rawText = text.Split('-');
            if (rawText.Count() == 2)
            {
                spacedText = rawText[0] + " - " + rawText[1];
            }
            else
            {
                spacedText = text;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while adding space", ex);
        }
        return spacedText;
    }
    #endregion

    public void ValidateResultold(string xmlData, string IsExcludeAutoApproval, int orgid, out string textColor, out string RangeColor1, List<ReferenceRangeType> lstReferenceRangeType)
    {
        long returnCode = -1;
        textColor = "white";
        string RangeColor = "white";
        RangeColor1 = "white";


        try
        {

            string[] CatagoryAgeMain = xmlData.Split('|');
            int AutoApprovalId = 0;
            int.TryParse(CatagoryAgeMain[8], out AutoApprovalId);

            string LangCode = "en-GB";
           // List<ReferenceRangeType> lstReferenceRangeType = new List<ReferenceRangeType>();
            List<ReferenceRangeType> lstNewReferenceRangeType = null;
            List<ReferenceRangeType> lstRangeType = null;
           // returnCode = new Investigation_BL().getReferencerangetype(orgid, LangCode, out lstReferenceRangeType);

            if (lstReferenceRangeType.Count > 0)
            {
                List<ReferenceRangeType> objlstReferenceRangeType = ((from child in lstReferenceRangeType
                                                                      select new ReferenceRangeType
                                                                      {
                                                                          Code = child.Code,
                                                                          Bound = child.Bound,
                                                                          Type = child.Type
                                                                      }).Distinct()).ToList();
                if (lstReferenceRangeType != null && objlstReferenceRangeType.Count > 0)
                {
                    bool isValidationRequired = true;
                    foreach (ReferenceRangeType oRRMetaData in objlstReferenceRangeType)
                    {
                        isValidationRequired = true;
                        XElement xe = XElement.Parse(CatagoryAgeMain[0]);
                        var Range = from range in xe.Elements(oRRMetaData.Code).Elements("property")
                                    select range;
                        if (Range != null && Range.Count() > 0)
                        {
                            //if (oRRMetaData == "domainrange" && Range != null)
                            //{
                            if (oRRMetaData.Code == "autoauthorizationrange" && (AutoApprovalId <= 0 || IsExcludeAutoApproval == "Y"))
                            {
                                isValidationRequired = false;
                            }
                            if (isValidationRequired)
                            {
                                if (oRRMetaData.Bound == "Inclusive")
                                {
                                    Getstatus(xmlData, oRRMetaData.Code, out RangeColor, "Range");
                                }
                                else
                                {
                                    Getstatus(xmlData, oRRMetaData.Code, out RangeColor, "Reference");
                                }
                                RangeColor1 = RangeColor;
                                lstRangeType = lstReferenceRangeType.FindAll(RR => RR.Code == oRRMetaData.Code && !String.IsNullOrEmpty(RR.Type)).ToList();

                                if (lstRangeType != null && lstRangeType.Count > 0)
                                {
                                    lstNewReferenceRangeType = lstRangeType.FindAll(RR => RR.Code == oRRMetaData.Code && RR.Type == RangeColor).ToList();
                                }
                                else
                                {
                                    lstNewReferenceRangeType = lstReferenceRangeType.FindAll(RR => RR.Code == oRRMetaData.Code && String.IsNullOrEmpty(RR.Type)).ToList();
                                }
                                if (lstNewReferenceRangeType != null && lstNewReferenceRangeType.Count > 0)
                                {
                                    if (RangeColor == "white" && oRRMetaData.Bound == "Inclusive")
                                    {
                                        textColor = lstNewReferenceRangeType[0].Color;
                                        if (oRRMetaData.Code == "autoauthorizationrange")
                                        {
                                            RangeColor1 = "Auto";
                                        }
                                        else
                                        {
                                            RangeColor1 = "P";
                                        }
                                        break;
                                    }
                                    else if (RangeColor != "white" && oRRMetaData.Bound == "Exclusive")
                                    {
                                        textColor = lstNewReferenceRangeType[0].Color;
                                        break;
                                    }
                                    //else if (RangeColor == "Black" && oRRMetaData.Bound == "Exclusive")
                                    //{
                                    //    textColor = lstNewReferenceRangeType[0].Color;
                                    //    break;
                                    //}
                                }


                            }
                        }

                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Validate user result", ex);
        }
    }

    public void ValidateResult(string xmlData, string IsExcludeAutoApproval, int orgid, out string textColor, out string RangeColor1, List<ReferenceRangeType> lstReferenceRangeType)
    {
        long returnCode = -1;
        textColor = "white";
        string RangeColor = "white";
        RangeColor1 = "white";
        string Isautoauthorized = "No";


        try
        {

            string[] CatagoryAgeMain = xmlData.Split('|');
            int AutoApprovalId = 0;
            int.TryParse(CatagoryAgeMain[8], out AutoApprovalId);

            string LangCode = "en-GB";
           // List<ReferenceRangeType> lstReferenceRangeType = new List<ReferenceRangeType>();
            List<ReferenceRangeType> lstNewReferenceRangeType = null;
            List<ReferenceRangeType> lstRangeType = null;
           // returnCode = new Investigation_BL().getReferencerangetype(orgid, LangCode, out lstReferenceRangeType);

            if (lstReferenceRangeType.Count > 0)
            {
                List<ReferenceRangeType> objlstReferenceRangeType = ((from child in lstReferenceRangeType
                                                                      select new ReferenceRangeType
                                                                      {
                                                                          Code = child.Code,
                                                                          Bound = child.Bound,
                                                                          Type = child.Type
                                                                      }).Distinct()).ToList();
                if (lstReferenceRangeType != null && objlstReferenceRangeType.Count > 0)
                {
                    bool isValidationRequired = true;
                    foreach (ReferenceRangeType oRRMetaData in objlstReferenceRangeType)
                    {
                        isValidationRequired = true;
                        XElement xe = XElement.Parse(CatagoryAgeMain[0]);
                        var Range = from range in xe.Elements(oRRMetaData.Code).Elements("property")
                                    select range;
                        if (Range != null && Range.Count() > 0)
                        {
                            //if (oRRMetaData == "domainrange" && Range != null)
                            //{
                            if (oRRMetaData.Code == "autoauthorizationrange" && (AutoApprovalId <= 0 || IsExcludeAutoApproval == "Y"))
                            {
                                isValidationRequired = false;
                            }
                            if (isValidationRequired)
                            {
                                if (oRRMetaData.Bound == "Inclusive")
                                {
                                    Getstatus(xmlData, oRRMetaData.Code, out RangeColor, "Range");
                                }
                                else
                                {
                                    Getstatus(xmlData, oRRMetaData.Code, out RangeColor, "Reference");
                                }
                                RangeColor1 = RangeColor;
                                lstRangeType = lstReferenceRangeType.FindAll(RR => RR.Code == oRRMetaData.Code && !String.IsNullOrEmpty(RR.Type)).ToList();

                                if (lstRangeType != null && lstRangeType.Count > 0)
                                {
                                    lstNewReferenceRangeType = lstRangeType.FindAll(RR => RR.Code == oRRMetaData.Code && RR.Type == RangeColor).ToList();
                                }
                                else
                                {
                                    lstNewReferenceRangeType = lstReferenceRangeType.FindAll(RR => RR.Code == oRRMetaData.Code && String.IsNullOrEmpty(RR.Type)).ToList();
                                }
                                if (lstNewReferenceRangeType != null && lstNewReferenceRangeType.Count > 0 && oRRMetaData.Code == "autoauthorizationrange")
                                {
                                    if (RangeColor == "white" && oRRMetaData.Bound == "Inclusive")
                                    {
                                        Isautoauthorized = "Yes";
                                        textColor = lstNewReferenceRangeType[0].Color;
                                    }
                                }

                                else
                                {
                                    if (lstNewReferenceRangeType != null && lstNewReferenceRangeType.Count > 0)
                                    {
                                        if (RangeColor == "white" && oRRMetaData.Bound == "Inclusive")
                                        {
                                            textColor = lstNewReferenceRangeType[0].Color;
                                            if (Isautoauthorized == "Yes")
                                            {
                                                RangeColor1 = "AutoW";
                                            }
                                            else
                                            {
                                                RangeColor1 = "P";
                                            }
                                            break;
                                        }
                                        else if (RangeColor != "white" && oRRMetaData.Bound == "Exclusive")
                                        {
                                            if (Isautoauthorized == "Yes")
                                            {
                                                RangeColor1 = "Auto" + RangeColor;
                                                textColor = lstNewReferenceRangeType[0].Color;
                                            }
                                            else
                                            {
                                                textColor = lstNewReferenceRangeType[0].Color;

                                            }
                                            break;
                                        }
                                        //else if (RangeColor == "Black" && oRRMetaData.Bound == "Exclusive")
                                        //{
                                        //    textColor = lstNewReferenceRangeType[0].Color;
                                        //    break;
                                        //}
                                    }
                                    else if (RangeColor == "white" && oRRMetaData.Bound == "Exclusive")
                                    {
                                        if (Isautoauthorized == "Yes")
                                        {
                                            textColor = RangeColor;
                                            RangeColor1 = "Auto" + RangeColor;

                                        }
                                        else
                                        {
                                            textColor = RangeColor;

                                        }
                                        break;
                                    }

                                }
                            }
                        }

                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Validate user result", ex);
        }
    }

    double ConvertToDays(double age, string agetype)
    {
        double ageInDays = 0;
        if (agetype == "Week(s)")
        {
            agetype = "Weeks";
        }
        else if (agetype == "Month(s)")
        {
            agetype = "Months";
        }
        else if (agetype == "Year(s)")
        {
            agetype = "Years";
        }
        else if (agetype == "Day(s)")
        {
            agetype = "Days";
        }

        switch (agetype)
        {
            case "Weeks":
                ageInDays = Math.Round(age * 7);
                break;
            case "Months":
                ageInDays = Math.Round(age * 30.416666667);
                break;
            case "Years":
                ageInDays = Math.Round(age * 365);
                break;
            case "Days":
                ageInDays = Math.Round(age);
                break;
        }
        return ageInDays;

    }


    public void Getstatus(string xmlData, string code, out string domain, string Rangetype)
    {
        string[] CatagoryAgeMain = xmlData.Split('|');
        Array userarr = CatagoryAgeMain[1].Split('~');
        string pGender = userarr.GetValue(0).ToString();
        pGender = !string.IsNullOrEmpty(pGender) && pGender != "0" ? pGender : string.Empty;
        string pAgetype = userarr.GetValue(2).ToString();
        string txtControl = CatagoryAgeMain[2].ToString();
        bool isNumericValue = false;
        decimal rangeValue = ConvertResultValue(CatagoryAgeMain[3], out isNumericValue);

        if (pAgetype == "Year(s)")
        {
            pAgetype = "Years";
        }
        else if (pAgetype == "Week(s)")
        {
            pAgetype = "Weeks";
        }
        else if (pAgetype == "Month(s)")
        {
            pAgetype = "Months";
        }
        else if (pAgetype == "Day(s)")
        {
            pAgetype = "Days";
        }
        double pAge = 0;
        double patientAgeInDays = 0;
        bool inCompleteRegistration = true;
        if (userarr.GetValue(1) != null && userarr.GetValue(1) != "")
        {
            pAge = Convert.ToDouble(userarr.GetValue(1));
            patientAgeInDays = ConvertToDays(pAge, pAgetype);
            inCompleteRegistration = false;
        }
        domain = "white";
        #region Domain range
        if (TryParseXml(CatagoryAgeMain[0]))
        {


            XElement xe = XElement.Parse(CatagoryAgeMain[0]);

            var commonRange = from common in xe.Elements(code).Elements("property")
                              where (string)common.Attribute("type") == "common" && ((string)common.Attribute("value")).ToLower() == pGender.ToLower()
                              select common;

            var commonRangeBoth = from common in xe.Elements(code).Elements("property")
                                  where (string)common.Attribute("type") == "common" && ((string)common.Attribute("value")).ToLower() == "Both".ToLower()
                                  select common;

            var otherRange = from other in xe.Elements(code).Elements("property")
                             where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == pGender.ToLower() && (string)other.Attribute("ResultType") != "Text" && (string)other.Attribute("agetype") == null
                             select other;

            var otherRangeBoth = from other in xe.Elements(code).Elements("property")
                                 where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == "Both".ToLower() && (string)other.Attribute("ResultType") != "Text" && (string)other.Attribute("agetype") == null
                                 select other;

            var otherRangeText = from other in xe.Elements(code).Elements("property")
                                 where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == pGender.ToLower() && (string)other.Attribute("ResultType") == "Text" && (string)other.Attribute("agetype") == null
                                 select other;

            var otherRangeBothText = from other in xe.Elements(code).Elements("property")
                                     where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == "Both".ToLower() && (string)other.Attribute("ResultType") == "Text" && (string)other.Attribute("agetype") == null
                                     select other;

            if (!inCompleteRegistration)
            {

                var ageRange = from age in xe.Elements(code).Elements("property")
                               where (string)age.Attribute("type") == "age" && ((string)age.Attribute("value")).ToLower() == pGender.ToLower()
                               select age;

                var ageRangeBoth = from age in xe.Elements(code).Elements("property")
                                   where (string)age.Attribute("type") == "age" && ((string)age.Attribute("value")).ToLower() == "Both".ToLower()
                                   select age;

                var otherRangeWithAge = from other in xe.Elements(code).Elements("property")
                                        where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == pGender.ToLower() && (string)other.Attribute("ResultType") != "Text" && (string)other.Attribute("agetype") != null
                                        select other;

                var otherRangeBothWithAge = from other in xe.Elements(code).Elements("property")
                                            where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == "Both".ToLower() && (string)other.Attribute("ResultType") != "Text" && (string)other.Attribute("agetype") != null
                                            select other;
                var otherRangeTextWithAge = from other in xe.Elements(code).Elements("property")
                                            where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == pGender.ToLower() && (string)other.Attribute("ResultType") == "Text" && (string)other.Attribute("agetype") != null
                                            select other;

                var otherRangeBothTextWithAge = from other in xe.Elements(code).Elements("property")
                                                where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == "Both".ToLower() && (string)other.Attribute("ResultType") == "Text" && (string)other.Attribute("agetype") != null
                                                select other;

                if (ageRange != null && ageRange.Count() > 0)
                {
                    //textColor = "Red";
                    if (Rangetype == "Reference")
                    {
                        GetRefAgeRange(ageRange, patientAgeInDays, "", rangeValue, out domain);
                        if (domain == "A" || domain == "L")
                        {
                            return;
                        }
                    }
                    else
                    {
                        GetAgeRange(ageRange, patientAgeInDays, rangeValue, out domain);
                    }

                }
                else if (ageRangeBoth != null && ageRangeBoth.Count() > 0)
                {
                    //textColor = "Red";
                    if (Rangetype == "Reference")
                    {
                        GetRefAgeRange(ageRangeBoth, patientAgeInDays, "str", rangeValue, out domain);
                        if (domain == "A" || domain == "L")
                        {
                            return;
                        }
                    }
                    else
                    {
                        GetAgeRange(ageRangeBoth, patientAgeInDays, rangeValue, out domain);
                    }
                }
                else if (commonRange != null && commonRange.Count() > 0)
                {
                    if (Rangetype == "Reference")
                    {
                        GetRefCommonRange(commonRange, rangeValue, out  domain);
                        if (domain == "A" || domain == "L")
                        {
                            return;
                        }
                    }
                    else
                    {
                        GetCommonRange(commonRange, "", rangeValue, out  domain);
                    }
                }
                else if (commonRangeBoth != null && commonRangeBoth.Count() > 0)
                {
                    if (Rangetype == "Reference")
                    {
                        GetRefCommonRange(commonRangeBoth, rangeValue, out  domain);
                        if (domain == "A" || domain == "L")
                        {
                            return;
                        }
                    }
                    else
                    {
                        GetCommonRange(commonRangeBoth, "", rangeValue, out  domain);
                    }
                }
                if ((otherRange != null && otherRange.Count() > 0) || (otherRangeText != null && otherRangeText.Count() > 0) || (otherRangeWithAge != null && otherRangeWithAge.Count() > 0) || (otherRangeTextWithAge != null && otherRangeTextWithAge.Count() > 0))
                {
                    if (otherRangeWithAge != null && otherRangeWithAge.Count() > 0)
                    {
                        if (Rangetype == "Reference")
                        {
                            GetRefOtherAgeRange(otherRangeWithAge, patientAgeInDays, "", rangeValue, out domain);
                            if (domain == "A" || domain == "L")
                            {
                                return;
                            }
                        }
                        else
                        {
                            GetOtherAgeRange(otherRangeWithAge, patientAgeInDays, rangeValue, out domain);
                        }
                    }
                    if (otherRangeTextWithAge != null && otherRangeTextWithAge.Count() > 0)
                    {
                        if (Rangetype == "Reference")
                        {
                            GetRefOtherRangeAgeText(otherRangeTextWithAge, CatagoryAgeMain, patientAgeInDays, rangeValue, out  domain);
                            if (domain == "A" || domain == "L")
                            {
                                return;
                            }
                        }
                        else
                        {
                            GetOtherRangeAgeText(otherRangeTextWithAge, CatagoryAgeMain, patientAgeInDays, rangeValue, out  domain);
                        }
                    }
                    if (otherRange != null && otherRange.Count() > 0)
                    {
                        if (Rangetype == "Reference")
                        {
                            GetRefOtherRange(otherRange, "", rangeValue, out  domain);
                            if (domain == "A" || domain == "L")
                            {
                                return;
                            }
                        }
                        else
                        {
                            //LastAttribute.Value
                            GetCommonRange(otherRange, "LastAttribute", rangeValue, out  domain);
                        }
                    }
                    if (otherRangeText != null && otherRangeText.Count() > 0)
                    {
                        if (Rangetype == "Reference")
                        {
                            GetRefOtherRangeText(otherRangeText, CatagoryAgeMain, pGender, code, rangeValue, out  domain);
                            if (domain == "A" || domain == "L")
                            {
                                return;
                            }
                        }
                        else
                        {
                            GetOtherRange(otherRangeText, CatagoryAgeMain, pGender, code, rangeValue, out  domain);
                        }
                    }
                }
                else if ((otherRangeBoth != null && otherRangeBoth.Count() > 0) || (otherRangeBothText != null && otherRangeBothText.Count() > 0) || (otherRangeBothWithAge != null && otherRangeBothWithAge.Count() > 0) || (otherRangeBothTextWithAge != null && otherRangeBothTextWithAge.Count() > 0))
                {
                    if (otherRangeBothWithAge != null && otherRangeBothWithAge.Count() > 0)
                    {
                        if (Rangetype == "Reference")
                        {
                            GetRefOtherAgeRange(otherRangeBothWithAge, patientAgeInDays, "", rangeValue, out domain);
                            if (domain == "A" || domain == "L")
                            {
                                return;
                            }
                        }
                        else
                        {
                            GetOtherAgeRange(otherRangeBothWithAge, patientAgeInDays, rangeValue, out domain);
                        }
                    }
                    if (otherRangeBothTextWithAge != null && otherRangeBothTextWithAge.Count() > 0)
                    {
                        if (Rangetype == "Reference")
                        {
                            GetRefOtherRangeAgeText(otherRangeBothTextWithAge, CatagoryAgeMain, patientAgeInDays, rangeValue, out  domain);
                            if (domain == "A" || domain == "L")
                            {
                                return;
                            }
                        }
                        else
                        {
                            GetOtherRangeAgeText(otherRangeBothTextWithAge, CatagoryAgeMain, patientAgeInDays, rangeValue, out  domain);
                        }
                    }
                    if (otherRangeBoth != null && otherRangeBoth.Count() > 0)
                    {
                        if (Rangetype == "Reference")
                        {
                            GetRefOtherRange(otherRangeBoth, "LastAttribute", rangeValue, out  domain);
                            if (domain == "A" || domain == "L")
                            {
                                return;
                            }
                        }
                        else
                        {
                            //LastAttribute.Value)
                            GetCommonRange(otherRangeBoth, "LastAttribute", rangeValue, out  domain);
                        }

                    }

                    if (otherRangeBothText != null && otherRangeBothText.Count() > 0)
                    {
                        if (Rangetype == "Reference")
                        {
                            GetRefOtherRangeText(otherRangeBothText, CatagoryAgeMain, "Both", code, rangeValue, out  domain);
                            if (domain == "A" || domain == "L")
                            {
                                return;
                            }
                        }
                        else
                        {
                            GetOtherRange(otherRangeBothText, CatagoryAgeMain, "Both", code, rangeValue, out  domain);
                        }
                    }
                }
            }
            else
            {
                if (commonRange != null && commonRange.Count() > 0)
                {
                    if (Rangetype == "Reference")
                    {
                        GetRefCommonRange(commonRange, rangeValue, out  domain);
                        if (domain == "A" || domain == "L")
                        {
                            return;
                        }
                    }
                    else
                    {
                        GetCommonRange(commonRange, "", rangeValue, out  domain);
                    }
                }

                if (commonRangeBoth != null && commonRangeBoth.Count() > 0)
                {
                    if (Rangetype == "Reference")
                    {
                        GetRefCommonRange(commonRangeBoth, rangeValue, out  domain);
                        if (domain == "A" || domain == "L")
                        {
                            return;
                        }
                    }
                    else
                    {
                        GetCommonRange(commonRangeBoth, "", rangeValue, out  domain);
                    }
                }


                if (otherRange != null && otherRange.Count() > 0)
                {
                    if (Rangetype == "Reference")
                    {
                        GetRefOtherRange(otherRange, "", rangeValue, out  domain);
                        if (domain == "A" || domain == "L")
                        {
                            return;
                        }
                    }
                    else
                    {
                        //LastAttribute.Value
                        GetCommonRange(otherRange, "LastAttribute", rangeValue, out  domain);
                    }
                }

                if (otherRangeBoth != null && otherRangeBoth.Count() > 0)
                {
                    if (Rangetype == "Reference")
                    {
                        GetRefOtherRange(otherRangeBoth, "LastAttribute", rangeValue, out  domain);
                        if (domain == "A" || domain == "L")
                        {
                            return;
                        }
                    }
                    else
                    {
                        //LastAttribute.Value)
                        GetCommonRange(otherRangeBoth, "LastAttribute", rangeValue, out  domain);
                    }

                }

                if (otherRangeText != null && otherRangeText.Count() > 0)
                {
                    if (Rangetype == "Reference")
                    {
                        GetRefOtherRangeText(otherRangeText, CatagoryAgeMain, pGender, code, rangeValue, out  domain);
                        if (domain == "A" || domain == "L")
                        {
                            return;
                        }
                    }
                    else
                    {
                        GetOtherRange(otherRangeText, CatagoryAgeMain, pGender, code, rangeValue, out  domain);
                    }
                }

                if (otherRangeBothText != null && otherRangeBothText.Count() > 0)
                {
                    if (Rangetype == "Reference")
                    {
                        GetRefOtherRangeText(otherRangeBothText, CatagoryAgeMain, "Both", code, rangeValue, out  domain);
                        if (domain == "A" || domain == "L")
                        {
                            return;
                        }
                    }
                    else
                    {
                        GetOtherRange(otherRangeBothText, CatagoryAgeMain, "Both", code, rangeValue, out  domain);
                    }
                }
            }
        }


        #endregion
    }

    public void GetAgeRange(IEnumerable<XElement> ageRange, double patientAgeInDays, decimal rangeValue, out string domain)
    {
        domain = "Black";
        foreach (var lst in ageRange)
        {
            if (domain == "Black")
            {


                if (lst.Element("lst") != null)
                {
                    if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("lst").Value), lst.Element("lst").Attribute("agetype").Value))
                    {
                        switch (ConvertRangeStringOptr(lst.Element("lst").FirstAttribute.Value))
                        {
                            case "<":

                                if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;

                            case "<=":

                                if (rangeValue <= Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case "=":

                                if (rangeValue == Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case "=>":

                                if (rangeValue >= Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case ">":

                                if (rangeValue > Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case " ":

                                string[] between = lst.Element("lst").LastAttribute.Value.Split('-');
                                if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;


                        }


                    }


                }

                if (lst.Element("lsq") != null)
                {
                    if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("lsq").Value), lst.Element("lsq").Attribute("agetype").Value))
                    {

                        switch (ConvertRangeStringOptr(lst.Element("lsq").FirstAttribute.Value))
                        {
                            case "<":

                                if (rangeValue < Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;

                            case "<=":

                                if (rangeValue <= Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case "=":

                                if (rangeValue == Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case "=>":

                                if (rangeValue >= Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case ">":

                                if (rangeValue > Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case " ":

                                string[] between = lst.Element("lsq").LastAttribute.Value.Split('-');
                                if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;


                        }
                    }



                }

                if (lst.Element("eql") != null)
                {

                    if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("eql").Value), lst.Element("eql").Attribute("agetype").Value))
                    {

                        switch (ConvertRangeStringOptr(lst.Element("eql").FirstAttribute.Value))
                        {
                            case "<":

                                if (rangeValue < Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;

                            case "<=":

                                if (rangeValue <= Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case "=":

                                if (rangeValue == Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case "=>":

                                if (rangeValue >= Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case ">":

                                if (rangeValue > Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case " ":

                                string[] between = lst.Element("eql").LastAttribute.Value.Split('-');
                                if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;


                        }
                    }

                }

                if (lst.Element("grt") != null)
                {


                    if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("grt").Value), lst.Element("grt").Attribute("agetype").Value))
                    {

                        switch (ConvertRangeStringOptr(lst.Element("grt").FirstAttribute.Value))
                        {
                            case "<":

                                if (rangeValue < Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;

                            case "<=":

                                if (rangeValue <= Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case "=":

                                if (rangeValue == Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case "=>":

                                if (rangeValue >= Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case ">":

                                if (rangeValue > Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case " ":

                                string[] between = lst.Element("grt").LastAttribute.Value.Split('-');
                                if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;


                        }
                    }




                }


                if (lst.Element("grq") != null)
                {



                    if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("grq").Value), lst.Element("grq").Attribute("agetype").Value))
                    {

                        switch (ConvertRangeStringOptr(lst.Element("grq").FirstAttribute.Value))
                        {
                            case "<":

                                if (rangeValue < Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;

                            case "<=":

                                if (rangeValue <= Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case "=":

                                if (rangeValue == Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case "=>":

                                if (rangeValue >= Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case ">":

                                if (rangeValue > Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case " ":

                                string[] between = lst.Element("grq").LastAttribute.Value.Split('-');
                                if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;


                        }
                    }




                }

                if (lst.Element("btw") != null)
                {

                    string[] between = lst.Element("btw").Value.Split('-');


                    if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("btw").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("btw").Attribute("agetype").Value))
                    {


                        switch (ConvertRangeStringOptr(lst.Element("btw").FirstAttribute.Value))
                        {
                            case "<":

                                if (rangeValue < Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;

                            case "<=":

                                if (rangeValue <= Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case "=":

                                if (rangeValue == Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case "=>":

                                if (rangeValue >= Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case ">":

                                if (rangeValue > Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;
                            case " ":

                                string[] between1 = lst.Element("btw").LastAttribute.Value.Split('-');
                                if (rangeValue >= Convert.ToDecimal(between1[0]) && rangeValue <= Convert.ToDecimal(between1[1]))
                                {
                                    domain = "white";
                                }
                                else
                                {
                                    domain = "Black";
                                }

                                break;


                        }
                    }



                }

            }

        }
    }

    public void GetOtherAgeRange(IEnumerable<XElement> commonRange, double patientAgeInDays, decimal rangeValue, out string domain)
    {
        domain = "Black";
        decimal lstrangevalue;
        foreach (var lst in commonRange)
        {
            if (domain == "Black")
            {
                if (lst.Element("lst") != null)
                {
                    if (lst.Element("lst").Attribute("ageopr").Value == "lst")
                    {
                        if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("lst").LastAttribute.Value);
                            if (rangeValue < lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("lst").Attribute("ageopr").Value == "lsq")
                    {
                        if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("lst").LastAttribute.Value);
                            if (rangeValue < lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("lst").Attribute("ageopr").Value == "eql")
                    {
                        if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("lst").LastAttribute.Value);
                            if (rangeValue < lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("lst").Attribute("ageopr").Value == "grt")
                    {
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("lst").LastAttribute.Value);
                            if (rangeValue < lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("lst").Attribute("ageopr").Value == "grq")
                    {
                        if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("lst").LastAttribute.Value);
                            if (rangeValue < lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("lst").Attribute("ageopr").Value == "btw")
                    {
                        string[] between = lst.Element("lst").Attribute("agerange").Value.Split('-');
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("lst").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("lst").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("lst").LastAttribute.Value);
                            if (rangeValue < lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                }

                if (lst.Element("lsq") != null)
                {
                    if (lst.Element("lsq").Attribute("ageopr").Value == "lst")
                    {
                        if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("lsq").Attribute("agerange").Value), lst.Element("lsq").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value);
                            if (rangeValue <= lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("lsq").Attribute("ageopr").Value == "lsq")
                    {
                        if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("lsq").Attribute("agerange").Value), lst.Element("lsq").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value);
                            if (rangeValue <= lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("lsq").Attribute("ageopr").Value == "eql")
                    {
                        if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("lsq").Attribute("agerange").Value), lst.Element("lsq").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value);
                            if (rangeValue <= lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("lsq").Attribute("ageopr").Value == "grt")
                    {
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("lsq").Attribute("agerange").Value), lst.Element("lsq").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value);
                            if (rangeValue <= lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("lsq").Attribute("ageopr").Value == "grq")
                    {
                        if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("lsq").Attribute("agerange").Value), lst.Element("lsq").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value);
                            if (rangeValue <= lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("lsq").Attribute("ageopr").Value == "btw")
                    {
                        string[] between = lst.Element("lsq").Attribute("agerange").Value.Split('-');
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("lsq").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("lsq").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value);
                            if (rangeValue <= lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                }

                if (lst.Element("eql") != null)
                {
                    if (lst.Element("eql").Attribute("ageopr").Value == "lst")
                    {
                        if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("eql").LastAttribute.Value);
                            if (rangeValue == lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("eql").Attribute("ageopr").Value == "lsq")
                    {
                        if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("eql").LastAttribute.Value);
                            if (rangeValue == lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("eql").Attribute("ageopr").Value == "eql")
                    {
                        if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("eql").LastAttribute.Value);
                            if (rangeValue == lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("eql").Attribute("ageopr").Value == "grt")
                    {
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("eql").LastAttribute.Value);
                            if (rangeValue == lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("eql").Attribute("ageopr").Value == "grq")
                    {
                        if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("eql").LastAttribute.Value);
                            if (rangeValue == lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("eql").Attribute("ageopr").Value == "btw")
                    {
                        string[] between = lst.Element("eql").Attribute("agerange").Value.Split('-');
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("eql").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("eql").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("eql").LastAttribute.Value);
                            if (rangeValue == lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                }

                if (lst.Element("grt") != null)
                {
                    if (lst.Element("grt").Attribute("ageopr").Value == "lst")
                    {
                        if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("grt").LastAttribute.Value);
                            if (rangeValue > lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("grt").Attribute("ageopr").Value == "lsq")
                    {
                        if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("grt").LastAttribute.Value);
                            if (rangeValue > lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("grt").Attribute("ageopr").Value == "eql")
                    {
                        if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("grt").LastAttribute.Value);
                            if (rangeValue > lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("grt").Attribute("ageopr").Value == "grt")
                    {
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("grt").LastAttribute.Value);
                            if (rangeValue > lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("grt").Attribute("ageopr").Value == "grq")
                    {
                        if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("grt").LastAttribute.Value);
                            if (rangeValue > lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("grt").Attribute("ageopr").Value == "btw")
                    {
                        string[] between = lst.Element("grt").Attribute("agerange").Value.Split('-');
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("grt").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("grt").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("grt").LastAttribute.Value);
                            if (rangeValue > lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                }


                if (lst.Element("grq") != null)
                {
                    if (lst.Element("grq").Attribute("ageopr").Value == "lst")
                    {
                        if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("grq").LastAttribute.Value);
                            if (rangeValue >= lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("grq").Attribute("ageopr").Value == "lsq")
                    {
                        if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("grq").LastAttribute.Value);
                            if (rangeValue >= lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("grq").Attribute("ageopr").Value == "eql")
                    {
                        if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("grq").LastAttribute.Value);
                            if (rangeValue >= lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("grq").Attribute("ageopr").Value == "grt")
                    {
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("grq").LastAttribute.Value);
                            if (rangeValue >= lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("grq").Attribute("ageopr").Value == "grq")
                    {
                        if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("grq").LastAttribute.Value);
                            if (rangeValue >= lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("grq").Attribute("ageopr").Value == "btw")
                    {
                        string[] between = lst.Element("grq").Attribute("agerange").Value.Split('-');
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("grq").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("grq").Attribute("agetype").Value))
                        {
                            lstrangevalue = Convert.ToDecimal(lst.Element("grq").LastAttribute.Value);
                            if (rangeValue >= lstrangevalue)
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                }

                if (lst.Element("btw") != null)
                {
                    if (lst.Element("btw").Attribute("ageopr").Value == "lst")
                    {
                        if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                        {
                            string[] between1 = lst.Element("btw").LastAttribute.Value.Split('-');
                            if (rangeValue >= Convert.ToDecimal(between1[0]) && rangeValue <= Convert.ToDecimal(between1[1]))
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("btw").Attribute("ageopr").Value == "lsq")
                    {
                        if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                        {
                            string[] between1 = lst.Element("btw").LastAttribute.Value.Split('-');
                            if (rangeValue >= Convert.ToDecimal(between1[0]) && rangeValue <= Convert.ToDecimal(between1[1]))
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("btw").Attribute("ageopr").Value == "eql")
                    {
                        if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                        {
                            string[] between1 = lst.Element("btw").LastAttribute.Value.Split('-');
                            if (rangeValue >= Convert.ToDecimal(between1[0]) && rangeValue <= Convert.ToDecimal(between1[1]))
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("btw").Attribute("ageopr").Value == "grt")
                    {
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                        {
                            string[] between1 = lst.Element("btw").LastAttribute.Value.Split('-');
                            if (rangeValue >= Convert.ToDecimal(between1[0]) && rangeValue <= Convert.ToDecimal(between1[1]))
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("btw").Attribute("ageopr").Value == "grq")
                    {
                        if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                        {
                            string[] between1 = lst.Element("btw").LastAttribute.Value.Split('-');
                            if (rangeValue >= Convert.ToDecimal(between1[0]) && rangeValue <= Convert.ToDecimal(between1[1]))
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                    else if (lst.Element("btw").Attribute("ageopr").Value == "btw")
                    {
                        string[] between = lst.Element("btw").Attribute("agerange").Value.Split('-');
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("btw").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("btw").Attribute("agetype").Value))
                        {
                            string[] between1 = lst.Element("btw").LastAttribute.Value.Split('-');
                            if (rangeValue >= Convert.ToDecimal(between1[0]) && rangeValue <= Convert.ToDecimal(between1[1]))
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }
                }
            }
        }
    }

    public void GetCommonRange(IEnumerable<XElement> commonRange, string addstr, decimal rangeValue, out string domain)
    {
        domain = "Black";
        decimal lstrangevalue;
        foreach (var lst in commonRange)
        {
            if (domain == "Black")
            {

                if (lst.Element("lst") != null)
                {

                    if (addstr == "")
                    {
                        lstrangevalue = Convert.ToDecimal(lst.Element("lst").Value);
                    }
                    else
                    {
                        lstrangevalue = Convert.ToDecimal(lst.Element("lst").LastAttribute.Value);
                    }
                    if (rangeValue < lstrangevalue)
                    {
                        domain = "white";
                    }
                    else
                    {
                        domain = "Black";
                    }


                }

                if (lst.Element("lsq") != null)
                {

                    if (addstr == "")
                    {
                        lstrangevalue = Convert.ToDecimal(lst.Element("lsq").Value);
                    }
                    else
                    {
                        lstrangevalue = Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value);
                    }

                    if (rangeValue <= lstrangevalue)
                    {
                        domain = "white";
                    }
                    else
                    {
                        domain = "Black";
                    }

                }

                if (lst.Element("eql") != null)
                {

                    if (addstr == "")
                    {
                        lstrangevalue = Convert.ToDecimal(lst.Element("eql").Value);
                    }
                    else
                    {
                        lstrangevalue = Convert.ToDecimal(lst.Element("eql").LastAttribute.Value);
                    }
                    if (rangeValue == lstrangevalue)
                    {
                        domain = "white";
                    }
                    else
                    {
                        domain = "Black";
                    }
                }

                if (lst.Element("grt") != null)
                {

                    if (addstr == "")
                    {
                        lstrangevalue = Convert.ToDecimal(lst.Element("grt").Value);
                    }
                    else
                    {
                        lstrangevalue = Convert.ToDecimal(lst.Element("grt").LastAttribute.Value);
                    }
                    if (rangeValue > lstrangevalue)
                    {
                        domain = "white";
                    }
                    else
                    {
                        domain = "Black";
                    }
                }


                if (lst.Element("grq") != null)
                {

                    if (addstr == "")
                    {
                        lstrangevalue = Convert.ToDecimal(lst.Element("grq").Value);
                    }
                    else
                    {
                        lstrangevalue = Convert.ToDecimal(lst.Element("grq").LastAttribute.Value);
                    }
                    if (rangeValue >= lstrangevalue)
                    {
                        domain = "white";
                    }
                    else
                    {
                        domain = "Black";
                    }
                }

                if (lst.Element("btw") != null)
                {
                    string[] between;

                    if (addstr == "")
                    {
                        between = lst.Element("btw").Value.Split('-');
                    }
                    else
                    {
                        between = lst.Element("btw").LastAttribute.Value.Split('-');
                    }
                    if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                    {
                        domain = "white";
                    }
                    else
                    {
                        domain = "Black";
                    }
                }

            }
        }

    }

    public void GetOtherRangeAgeText(IEnumerable<XElement> otherRangeBothText, string[] CatagoryAgeMain, double patientAgeInDays, decimal rangeValue, out string domain)
    {
        domain = "Black";
        foreach (var lst in otherRangeBothText)
        {
            if (domain == "Black")
            {

                if (lst.Element("txt") != null)
                {

                    if (CatagoryAgeMain[3].ToString().ToLower() == lst.Element("txt").Value.ToString().ToLower())
                    {
                        domain = "white";
                    }
                    else
                    {
                        domain = "Black";
                    }
                }
            }
        }
    }

    public void GetOtherRange(IEnumerable<XElement> otherRangeBothText, string[] CatagoryAgeMain, string addstr, string code, decimal rangeValue, out string domain)
    {
        domain = "Black";
        foreach (var lst in otherRangeBothText)
        {
            if (domain == "Black")
            {

                if (lst.Element("txt") != null)
                {

                    if (CatagoryAgeMain[3].ToString().ToLower() == lst.Element("txt").Value.ToString().ToLower())
                    {
                        domain = "white";
                    }
                    else if (TryParseXml(CatagoryAgeMain[0]))
                    {
                        XElement xe1 = XElement.Parse(CatagoryAgeMain[0]);

                        var otherRangeBothText1 = from other in xe1.Elements(code).Elements("property")
                                                  where (string)other.Attribute("type") == "other" && (string)other.Attribute("value") == addstr && (string)other.Attribute("ResultType") == "Text"
                                                  select other;

                        foreach (var lst1 in otherRangeBothText1)
                        {
                            if (CatagoryAgeMain[3].ToString().ToLower() == lst1.Element("txt").Value.ToString().ToLower())
                            {
                                domain = "white";
                            }
                            else
                            {
                                domain = "Black";
                            }
                        }
                    }

                }

            }
        }
    }

    public void GetRIRAgeRange(IEnumerable<XElement> ageRange, double patientAgeInDays, decimal deviceValue, string deviceID, out string result, out string resultType)
    {
        result = string.Empty;
        resultType = string.Empty;
        try
        {
            foreach (var lst in ageRange)
            {
                if (lst.Element("lst") != null)
                {
                    if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("lst").Value), lst.Element("lst").Attribute("agetype").Value))
                    {
                        switch (ConvertRangeStringOptr(lst.Element("lst").FirstAttribute.Value))
                        {
                            case "<":
                                if (deviceValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                {
                                    if (lst.Element("lst").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("lst").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("lst").Attribute("data").Value;
                                            resultType = lst.Element("lst").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("lst").Attribute("data").Value;
                                        resultType = lst.Element("lst").Attribute("result").Value;
                                    }
                                }
                                break;

                            case "<=":

                                if (deviceValue <= Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                {
                                    if (lst.Element("lst").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("lst").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("lst").Attribute("data").Value;
                                            resultType = lst.Element("lst").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("lst").Attribute("data").Value;
                                        resultType = lst.Element("lst").Attribute("result").Value;
                                    }
                                }

                                break;
                            case "=":

                                if (deviceValue == Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                {
                                    if (lst.Element("lst").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("lst").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("lst").Attribute("data").Value;
                                            resultType = lst.Element("lst").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("lst").Attribute("data").Value;
                                        resultType = lst.Element("lst").Attribute("result").Value;
                                    }
                                }

                                break;
                            case "=>":

                                if (deviceValue >= Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                {
                                    if (lst.Element("lst").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("lst").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("lst").Attribute("data").Value;
                                            resultType = lst.Element("lst").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("lst").Attribute("data").Value;
                                        resultType = lst.Element("lst").Attribute("result").Value;
                                    }
                                }

                                break;
                            case ">":

                                if (deviceValue > Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                {
                                    if (lst.Element("lst").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("lst").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("lst").Attribute("data").Value;
                                            resultType = lst.Element("lst").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("lst").Attribute("data").Value;
                                        resultType = lst.Element("lst").Attribute("result").Value;
                                    }
                                }

                                break;
                            case " ":

                                string[] between = lst.Element("lst").LastAttribute.Value.Split('-');
                                if (deviceValue >= Convert.ToDecimal(between[0]) && deviceValue <= Convert.ToDecimal(between[1]))
                                {
                                    if (lst.Element("lst").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("lst").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("lst").Attribute("data").Value;
                                            resultType = lst.Element("lst").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("lst").Attribute("data").Value;
                                        resultType = lst.Element("lst").Attribute("result").Value;
                                    }
                                }
                                break;
                        }
                    }
                }

                if (lst.Element("lsq") != null)
                {
                    if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("lsq").Value), lst.Element("lsq").Attribute("agetype").Value))
                    {
                        switch (ConvertRangeStringOptr(lst.Element("lsq").FirstAttribute.Value))
                        {
                            case "<":

                                if (deviceValue < Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                {
                                    if (lst.Element("lsq").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("lsq").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("lsq").Attribute("data").Value;
                                            resultType = lst.Element("lsq").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("lsq").Attribute("data").Value;
                                        resultType = lst.Element("lsq").Attribute("result").Value;
                                    }
                                }

                                break;

                            case "<=":

                                if (deviceValue <= Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                {
                                    if (lst.Element("lsq").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("lsq").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("lsq").Attribute("data").Value;
                                            resultType = lst.Element("lsq").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("lsq").Attribute("data").Value;
                                        resultType = lst.Element("lsq").Attribute("result").Value;
                                    }
                                }

                                break;
                            case "=":

                                if (deviceValue == Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                {
                                    if (lst.Element("lsq").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("lsq").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("lsq").Attribute("data").Value;
                                            resultType = lst.Element("lsq").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("lsq").Attribute("data").Value;
                                        resultType = lst.Element("lsq").Attribute("result").Value;
                                    }
                                }

                                break;
                            case "=>":

                                if (deviceValue >= Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                {
                                    if (lst.Element("lsq").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("lsq").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("lsq").Attribute("data").Value;
                                            resultType = lst.Element("lsq").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("lsq").Attribute("data").Value;
                                        resultType = lst.Element("lsq").Attribute("result").Value;
                                    }
                                }

                                break;
                            case ">":

                                if (deviceValue > Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                {
                                    if (lst.Element("lsq").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("lsq").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("lsq").Attribute("data").Value;
                                            resultType = lst.Element("lsq").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("lsq").Attribute("data").Value;
                                        resultType = lst.Element("lsq").Attribute("result").Value;
                                    }
                                }

                                break;
                            case " ":

                                string[] between = lst.Element("lsq").LastAttribute.Value.Split('-');
                                if (deviceValue >= Convert.ToDecimal(between[0]) && deviceValue <= Convert.ToDecimal(between[1]))
                                {
                                    if (lst.Element("lsq").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("lsq").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("lsq").Attribute("data").Value;
                                            resultType = lst.Element("lsq").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("lsq").Attribute("data").Value;
                                        resultType = lst.Element("lsq").Attribute("result").Value;
                                    }
                                }

                                break;
                        }
                    }
                }

                if (lst.Element("eql") != null)
                {
                    if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("eql").Value), lst.Element("eql").Attribute("agetype").Value))
                    {

                        switch (ConvertRangeStringOptr(lst.Element("eql").FirstAttribute.Value))
                        {
                            case "<":

                                if (deviceValue < Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                {
                                    if (lst.Element("eql").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("eql").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("eql").Attribute("data").Value;
                                            resultType = lst.Element("eql").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("eql").Attribute("data").Value;
                                        resultType = lst.Element("eql").Attribute("result").Value;
                                    }
                                }

                                break;

                            case "<=":

                                if (deviceValue <= Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                {
                                    if (lst.Element("eql").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("eql").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("eql").Attribute("data").Value;
                                            resultType = lst.Element("eql").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("eql").Attribute("data").Value;
                                        resultType = lst.Element("eql").Attribute("result").Value;
                                    }
                                }

                                break;
                            case "=":

                                if (deviceValue == Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                {
                                    if (lst.Element("eql").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("eql").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("eql").Attribute("data").Value;
                                            resultType = lst.Element("eql").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("eql").Attribute("data").Value;
                                        resultType = lst.Element("eql").Attribute("result").Value;
                                    }
                                }

                                break;
                            //clarify
                            case "=>":

                                if (deviceValue >= Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                {
                                    if (lst.Element("eql").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("eql").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("eql").Attribute("data").Value;
                                            resultType = lst.Element("eql").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("eql").Attribute("data").Value;
                                        resultType = lst.Element("eql").Attribute("result").Value;
                                    }
                                }

                                break;
                            case ">":

                                if (deviceValue > Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                {
                                    if (lst.Element("eql").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("eql").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("eql").Attribute("data").Value;
                                            resultType = lst.Element("eql").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("eql").Attribute("data").Value;
                                        resultType = lst.Element("eql").Attribute("result").Value;
                                    }
                                }

                                break;
                            case " ":

                                string[] between = lst.Element("eql").LastAttribute.Value.Split('-');
                                if (deviceValue >= Convert.ToDecimal(between[0]) && deviceValue <= Convert.ToDecimal(between[1]))
                                {
                                    if (lst.Element("eql").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("eql").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("eql").Attribute("data").Value;
                                            resultType = lst.Element("eql").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("eql").Attribute("data").Value;
                                        resultType = lst.Element("eql").Attribute("result").Value;
                                    }

                                }

                                break;
                        }
                    }
                }

                if (lst.Element("grt") != null)
                {
                    if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("grt").Value), lst.Element("grt").Attribute("agetype").Value))
                    {
                        switch (ConvertRangeStringOptr(lst.Element("grt").FirstAttribute.Value))
                        {
                            case "<":

                                if (deviceValue < Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                {
                                    if (lst.Element("grt").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("grt").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("grt").Attribute("data").Value;
                                            resultType = lst.Element("grt").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("grt").Attribute("data").Value;
                                        resultType = lst.Element("grt").Attribute("result").Value;
                                    }
                                }

                                break;

                            case "<=":

                                if (deviceValue <= Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                {
                                    if (lst.Element("grt").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("grt").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("grt").Attribute("data").Value;
                                            resultType = lst.Element("grt").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("grt").Attribute("data").Value;
                                        resultType = lst.Element("grt").Attribute("result").Value;
                                    }
                                }

                                break;
                            case "=":

                                if (deviceValue == Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                {
                                    if (lst.Element("grt").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("grt").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("grt").Attribute("data").Value;
                                            resultType = lst.Element("grt").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("grt").Attribute("data").Value;
                                        resultType = lst.Element("grt").Attribute("result").Value;
                                    }
                                }

                                break;
                            case "=>":

                                if (deviceValue >= Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                {
                                    if (lst.Element("grt").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("grt").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("grt").Attribute("data").Value;
                                            resultType = lst.Element("grt").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("grt").Attribute("data").Value;
                                        resultType = lst.Element("grt").Attribute("result").Value;
                                    }
                                }

                                break;
                            case ">":

                                if (deviceValue > Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                {
                                    if (lst.Element("grt").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("grt").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("grt").Attribute("data").Value;
                                            resultType = lst.Element("grt").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("grt").Attribute("data").Value;
                                        resultType = lst.Element("grt").Attribute("result").Value;
                                    }
                                }

                                break;
                            case " ":

                                string[] between = lst.Element("grt").LastAttribute.Value.Split('-');
                                if (deviceValue >= Convert.ToDecimal(between[0]) && deviceValue <= Convert.ToDecimal(between[1]))
                                {
                                    if (lst.Element("grt").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("grt").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("grt").Attribute("data").Value;
                                            resultType = lst.Element("grt").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("grt").Attribute("data").Value;
                                        resultType = lst.Element("grt").Attribute("result").Value;
                                    }
                                }

                                break;
                        }
                    }
                }

                if (lst.Element("grq") != null)
                {
                    if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("grq").Value), lst.Element("grq").Attribute("agetype").Value))
                    {
                        switch (ConvertRangeStringOptr(lst.Element("grq").FirstAttribute.Value))
                        {
                            case "<":

                                if (deviceValue < Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                {
                                    if (lst.Element("grq").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("grq").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("grq").Attribute("data").Value;
                                            resultType = lst.Element("grq").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("grq").Attribute("data").Value;
                                        resultType = lst.Element("grq").Attribute("result").Value;
                                    }
                                }

                                break;

                            case "<=":

                                if (deviceValue <= Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                {
                                    if (lst.Element("grq").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("grq").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("grq").Attribute("data").Value;
                                            resultType = lst.Element("grq").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("grq").Attribute("data").Value;
                                        resultType = lst.Element("grq").Attribute("result").Value;
                                    }
                                }

                                break;

                            //clarify
                            case "=":

                                if (deviceValue == Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                {
                                    if (lst.Element("grq").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("grq").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("grq").Attribute("data").Value;
                                            resultType = lst.Element("grq").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("grq").Attribute("data").Value;
                                        resultType = lst.Element("grq").Attribute("result").Value;
                                    }
                                }

                                break;
                            case "=>":

                                if (deviceValue >= Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                {
                                    if (lst.Element("grq").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("grq").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("grq").Attribute("data").Value;
                                            resultType = lst.Element("grq").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("grq").Attribute("data").Value;
                                        resultType = lst.Element("grq").Attribute("result").Value;
                                    }
                                }

                                break;
                            case ">":

                                if (deviceValue > Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                {
                                    if (lst.Element("grq").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("grq").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("grq").Attribute("data").Value;
                                            resultType = lst.Element("grq").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("grq").Attribute("data").Value;
                                        resultType = lst.Element("grq").Attribute("result").Value;
                                    }
                                }

                                break;
                            case " ":

                                string[] between = lst.Element("grq").LastAttribute.Value.Split('-');
                                if (deviceValue >= Convert.ToDecimal(between[0]) && deviceValue <= Convert.ToDecimal(between[1]))
                                {
                                    if (lst.Element("grq").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("grq").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("grq").Attribute("data").Value;
                                            resultType = lst.Element("grq").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("grq").Attribute("data").Value;
                                        resultType = lst.Element("grq").Attribute("result").Value;
                                    }
                                }

                                break;
                        }
                    }
                }

                if (lst.Element("btw") != null)
                {
                    string[] between = lst.Element("btw").Value.Split('-');

                    if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("btw").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("btw").Attribute("agetype").Value))
                    {
                        switch (ConvertRangeStringOptr(lst.Element("btw").FirstAttribute.Value))
                        {
                            case "<":

                                if (deviceValue < Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                {
                                    if (lst.Element("btw").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("btw").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("btw").Attribute("data").Value;
                                            resultType = lst.Element("btw").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("btw").Attribute("data").Value;
                                        resultType = lst.Element("btw").Attribute("result").Value;
                                    }
                                }

                                break;

                            case "<=":

                                if (deviceValue <= Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                {
                                    if (lst.Element("btw").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("btw").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("btw").Attribute("data").Value;
                                            resultType = lst.Element("btw").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("btw").Attribute("data").Value;
                                        resultType = lst.Element("btw").Attribute("result").Value;
                                    }
                                }

                                break;
                            case "=":

                                if (deviceValue == Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                {
                                    if (lst.Element("btw").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("btw").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("btw").Attribute("data").Value;
                                            resultType = lst.Element("btw").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("btw").Attribute("data").Value;
                                        resultType = lst.Element("btw").Attribute("result").Value;
                                    }
                                }

                                break;
                            case "=>":

                                if (deviceValue >= Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                {
                                    if (lst.Element("btw").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("btw").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("btw").Attribute("data").Value;
                                            resultType = lst.Element("btw").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("btw").Attribute("data").Value;
                                        resultType = lst.Element("btw").Attribute("result").Value;
                                    }
                                }

                                break;
                            case ">":

                                if (deviceValue > Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                {
                                    if (lst.Element("btw").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("btw").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("btw").Attribute("data").Value;
                                            resultType = lst.Element("btw").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("btw").Attribute("data").Value;
                                        resultType = lst.Element("btw").Attribute("result").Value;
                                    }
                                }

                                break;
                            case " ":

                                string[] between1 = lst.Element("btw").LastAttribute.Value.Split('-');
                                if (deviceValue >= Convert.ToDecimal(between1[0]) && deviceValue <= Convert.ToDecimal(between1[1]))
                                {
                                    if (lst.Element("btw").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("btw").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("btw").Attribute("data").Value;
                                            resultType = lst.Element("btw").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("btw").Attribute("data").Value;
                                        resultType = lst.Element("btw").Attribute("result").Value;
                                    }
                                }

                                break;
                        }
                    }
                }
                if (result != string.Empty)
                {
                    break;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while validating interpretation range", ex);
        }
    }

    public void GetRIRCommonRange(IEnumerable<XElement> commonRange, decimal deviceValue, string deviceID, out string result, out string resultType)
    {
        result = string.Empty;
        resultType = string.Empty;
        try
        {
            foreach (var lst in commonRange)
            {
                if (lst.Element("lst") != null)
                {
                    if (deviceValue < Convert.ToDecimal(lst.Element("lst").Value))
                    {
                        if (lst.Element("lst").Attribute("device").Value != "")
                        {
                            if (lst.Element("lst").Attribute("device").Value == deviceID)
                            {
                                result = lst.Element("lst").Attribute("data").Value;
                                resultType = lst.Element("lst").Attribute("result").Value;
                            }
                        }
                        else
                        {
                            result = lst.Element("lst").Attribute("data").Value;
                            resultType = lst.Element("lst").Attribute("result").Value;
                        }
                    }
                }

                if (lst.Element("lsq") != null)
                {

                    if (deviceValue <= Convert.ToDecimal(lst.Element("lsq").Value))
                    {
                        if (lst.Element("lsq").Attribute("device").Value != "")
                        {
                            if (lst.Element("lsq").Attribute("device").Value == deviceID)
                            {
                                result = lst.Element("lsq").Attribute("data").Value;
                                resultType = lst.Element("lsq").Attribute("result").Value;
                            }
                        }
                        else
                        {
                            result = lst.Element("lsq").Attribute("data").Value;
                            resultType = lst.Element("lsq").Attribute("result").Value;
                        }
                    }

                }

                if (lst.Element("eql") != null)
                {
                    if (deviceValue == Convert.ToDecimal(lst.Element("eql").Value))
                    {
                        if (lst.Element("eql").Attribute("device").Value != "")
                        {
                            if (lst.Element("eql").Attribute("device").Value == deviceID)
                            {
                                result = lst.Element("eql").Attribute("data").Value;
                                resultType = lst.Element("eql").Attribute("result").Value;
                            }
                        }
                        else
                        {
                            result = lst.Element("eql").Attribute("data").Value;
                            resultType = lst.Element("eql").Attribute("result").Value;
                        }
                    }
                }

                if (lst.Element("grt") != null)
                {
                    if (deviceValue > Convert.ToDecimal(lst.Element("grt").Value))
                    {
                        if (lst.Element("grt").Attribute("device").Value != "")
                        {
                            if (lst.Element("grt").Attribute("device").Value == deviceID)
                            {
                                result = lst.Element("grt").Attribute("data").Value;
                                resultType = lst.Element("grt").Attribute("result").Value;
                            }
                        }
                        else
                        {
                            result = lst.Element("grt").Attribute("data").Value;
                            resultType = lst.Element("grt").Attribute("result").Value;
                        }
                    }
                }


                if (lst.Element("grq") != null)
                {
                    if (deviceValue >= Convert.ToDecimal(lst.Element("grq").Value))
                    {
                        if (lst.Element("grq").Attribute("device").Value != "")
                        {
                            if (lst.Element("grq").Attribute("device").Value == deviceID)
                            {
                                result = lst.Element("grq").Attribute("data").Value;
                                resultType = lst.Element("grq").Attribute("result").Value;
                            }
                        }
                        else
                        {
                            result = lst.Element("grq").Attribute("data").Value;
                            resultType = lst.Element("grq").Attribute("result").Value;
                        }
                    }
                }

                if (lst.Element("btw") != null)
                {
                    string[] between = lst.Element("btw").Value.Split('-');


                    if (deviceValue >= Convert.ToDecimal(between[0]) && deviceValue <= Convert.ToDecimal(between[1]))
                    {
                        if (lst.Element("btw").Attribute("device").Value != "")
                        {
                            if (lst.Element("btw").Attribute("device").Value == deviceID)
                            {
                                result = lst.Element("btw").Attribute("data").Value;
                                resultType = lst.Element("btw").Attribute("result").Value;
                            }
                        }
                        else
                        {
                            result = lst.Element("btw").Attribute("data").Value;
                            resultType = lst.Element("btw").Attribute("result").Value;
                        }
                    }
                }
                if (result != string.Empty)
                {
                    break;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in validating interpretation range", ex);
        }
    }

    public void GetRIROtherAgeRange(IEnumerable<XElement> otherRangeBoth, double patientAgeInDays, decimal deviceValue, string deviceID, out string result, out string resultType)
    {
        result = string.Empty;
        resultType = string.Empty;
        try
        {
            decimal rangeval;
            foreach (var lst in otherRangeBoth)
            {
                if (lst.Element("lst") != null)
                {
                    if (lst.Element("lst").Attribute("ageopr").Value == "lst")
                    {
                        if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("lst").Attribute("value").Value);

                            if (deviceValue < rangeval)
                            {
                                if (lst.Element("lst").Attribute("device").Value != "")
                                {
                                    if (lst.Element("lst").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("lst").Attribute("data").Value;
                                        resultType = lst.Element("lst").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("lst").Attribute("data").Value;
                                    resultType = lst.Element("lst").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("lst").Attribute("ageopr").Value == "lsq")
                    {
                        if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("lst").Attribute("value").Value);

                            if (deviceValue < rangeval)
                            {
                                if (lst.Element("lst").Attribute("device").Value != "")
                                {
                                    if (lst.Element("lst").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("lst").Attribute("data").Value;
                                        resultType = lst.Element("lst").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("lst").Attribute("data").Value;
                                    resultType = lst.Element("lst").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("lst").Attribute("ageopr").Value == "eql")
                    {
                        if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("lst").Attribute("value").Value);

                            if (deviceValue < rangeval)
                            {
                                if (lst.Element("lst").Attribute("device").Value != "")
                                {
                                    if (lst.Element("lst").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("lst").Attribute("data").Value;
                                        resultType = lst.Element("lst").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("lst").Attribute("data").Value;
                                    resultType = lst.Element("lst").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("lst").Attribute("ageopr").Value == "grt")
                    {
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("lst").Attribute("value").Value);

                            if (deviceValue < rangeval)
                            {
                                if (lst.Element("lst").Attribute("device").Value != "")
                                {
                                    if (lst.Element("lst").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("lst").Attribute("data").Value;
                                        resultType = lst.Element("lst").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("lst").Attribute("data").Value;
                                    resultType = lst.Element("lst").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("lst").Attribute("ageopr").Value == "grq")
                    {
                        if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("lst").Attribute("value").Value);

                            if (deviceValue < rangeval)
                            {
                                if (lst.Element("lst").Attribute("device").Value != "")
                                {
                                    if (lst.Element("lst").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("lst").Attribute("data").Value;
                                        resultType = lst.Element("lst").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("lst").Attribute("data").Value;
                                    resultType = lst.Element("lst").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("lst").Attribute("ageopr").Value == "btw")
                    {
                        string[] between = lst.Element("lst").Attribute("agerange").Value.Split('-');
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("lst").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("lst").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("lst").Attribute("value").Value);

                            if (deviceValue < rangeval)
                            {
                                if (lst.Element("lst").Attribute("device").Value != "")
                                {
                                    if (lst.Element("lst").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("lst").Attribute("data").Value;
                                        resultType = lst.Element("lst").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("lst").Attribute("data").Value;
                                    resultType = lst.Element("lst").Attribute("result").Value;
                                }
                            }
                        }
                    }
                }

                if (lst.Element("lsq") != null)
                {
                    if (lst.Element(("lsq")).Attribute("ageopr").Value == "lst")
                    {
                        if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element(("lsq")).Attribute("agerange").Value), lst.Element(("lsq")).Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("lsq").Attribute("value").Value);

                            if (deviceValue <= rangeval)
                            {
                                if (lst.Element("lsq").Attribute("device").Value != "")
                                {
                                    if (lst.Element("lsq").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("lsq").Attribute("data").Value;
                                        resultType = lst.Element("lsq").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("lsq").Attribute("data").Value;
                                    resultType = lst.Element("lsq").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element(("lsq")).Attribute("ageopr").Value == "lsq")
                    {
                        if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element(("lsq")).Attribute("agerange").Value), lst.Element(("lsq")).Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("lsq").Attribute("value").Value);

                            if (deviceValue <= rangeval)
                            {
                                if (lst.Element("lsq").Attribute("device").Value != "")
                                {
                                    if (lst.Element("lsq").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("lsq").Attribute("data").Value;
                                        resultType = lst.Element("lsq").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("lsq").Attribute("data").Value;
                                    resultType = lst.Element("lsq").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element(("lsq")).Attribute("ageopr").Value == "eql")
                    {
                        if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element(("lsq")).Attribute("agerange").Value), lst.Element(("lsq")).Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("lsq").Attribute("value").Value);

                            if (deviceValue <= rangeval)
                            {
                                if (lst.Element("lsq").Attribute("device").Value != "")
                                {
                                    if (lst.Element("lsq").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("lsq").Attribute("data").Value;
                                        resultType = lst.Element("lsq").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("lsq").Attribute("data").Value;
                                    resultType = lst.Element("lsq").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element(("lsq")).Attribute("ageopr").Value == "grt")
                    {
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element(("lsq")).Attribute("agerange").Value), lst.Element(("lsq")).Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("lsq").Attribute("value").Value);

                            if (deviceValue <= rangeval)
                            {
                                if (lst.Element("lsq").Attribute("device").Value != "")
                                {
                                    if (lst.Element("lsq").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("lsq").Attribute("data").Value;
                                        resultType = lst.Element("lsq").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("lsq").Attribute("data").Value;
                                    resultType = lst.Element("lsq").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element(("lsq")).Attribute("ageopr").Value == "grq")
                    {
                        if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element(("lsq")).Attribute("agerange").Value), lst.Element(("lsq")).Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("lsq").Attribute("value").Value);

                            if (deviceValue <= rangeval)
                            {
                                if (lst.Element("lsq").Attribute("device").Value != "")
                                {
                                    if (lst.Element("lsq").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("lsq").Attribute("data").Value;
                                        resultType = lst.Element("lsq").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("lsq").Attribute("data").Value;
                                    resultType = lst.Element("lsq").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element(("lsq")).Attribute("ageopr").Value == "btw")
                    {
                        string[] between = lst.Element(("lsq")).Attribute("agerange").Value.Split('-');
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element(("lsq")).Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element(("lsq")).Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("lsq").Attribute("value").Value);

                            if (deviceValue <= rangeval)
                            {
                                if (lst.Element("lsq").Attribute("device").Value != "")
                                {
                                    if (lst.Element("lsq").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("lsq").Attribute("data").Value;
                                        resultType = lst.Element("lsq").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("lsq").Attribute("data").Value;
                                    resultType = lst.Element("lsq").Attribute("result").Value;
                                }
                            }
                        }
                    }
                }

                if (lst.Element("eql") != null)
                {
                    if (lst.Element("eql").Attribute("ageopr").Value == "lst")
                    {
                        if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("eql").Attribute("value").Value);
                            if (deviceValue == rangeval)
                            {
                                if (lst.Element("eql").Attribute("device").Value != "")
                                {
                                    if (lst.Element("eql").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("eql").Attribute("data").Value;
                                        resultType = lst.Element("eql").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("eql").Attribute("data").Value;
                                    resultType = lst.Element("eql").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("eql").Attribute("ageopr").Value == "lsq")
                    {
                        if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("eql").Attribute("value").Value);
                            if (deviceValue == rangeval)
                            {
                                if (lst.Element("eql").Attribute("device").Value != "")
                                {
                                    if (lst.Element("eql").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("eql").Attribute("data").Value;
                                        resultType = lst.Element("eql").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("eql").Attribute("data").Value;
                                    resultType = lst.Element("eql").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("eql").Attribute("ageopr").Value == "eql")
                    {
                        if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("eql").Attribute("value").Value);
                            if (deviceValue == rangeval)
                            {
                                if (lst.Element("eql").Attribute("device").Value != "")
                                {
                                    if (lst.Element("eql").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("eql").Attribute("data").Value;
                                        resultType = lst.Element("eql").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("eql").Attribute("data").Value;
                                    resultType = lst.Element("eql").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("eql").Attribute("ageopr").Value == "grt")
                    {
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("eql").Attribute("value").Value);
                            if (deviceValue == rangeval)
                            {
                                if (lst.Element("eql").Attribute("device").Value != "")
                                {
                                    if (lst.Element("eql").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("eql").Attribute("data").Value;
                                        resultType = lst.Element("eql").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("eql").Attribute("data").Value;
                                    resultType = lst.Element("eql").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("eql").Attribute("ageopr").Value == "grq")
                    {
                        if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("eql").Attribute("value").Value);
                            if (deviceValue == rangeval)
                            {
                                if (lst.Element("eql").Attribute("device").Value != "")
                                {
                                    if (lst.Element("eql").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("eql").Attribute("data").Value;
                                        resultType = lst.Element("eql").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("eql").Attribute("data").Value;
                                    resultType = lst.Element("eql").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("eql").Attribute("ageopr").Value == "btw")
                    {
                        string[] between = lst.Element("eql").Attribute("agerange").Value.Split('-');
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("eql").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("eql").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("eql").Attribute("value").Value);
                            if (deviceValue == rangeval)
                            {
                                if (lst.Element("eql").Attribute("device").Value != "")
                                {
                                    if (lst.Element("eql").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("eql").Attribute("data").Value;
                                        resultType = lst.Element("eql").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("eql").Attribute("data").Value;
                                    resultType = lst.Element("eql").Attribute("result").Value;
                                }
                            }
                        }
                    }
                }

                if (lst.Element("grt") != null)
                {
                    if (lst.Element("grt").Attribute("ageopr").Value == "lst")
                    {
                        if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("grt").Attribute("value").Value);
                            if (deviceValue > rangeval)
                            {
                                if (lst.Element("grt").Attribute("device").Value != "")
                                {
                                    if (lst.Element("grt").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("grt").Attribute("data").Value;
                                        resultType = lst.Element("grt").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("grt").Attribute("data").Value;
                                    resultType = lst.Element("grt").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("grt").Attribute("ageopr").Value == "lsq")
                    {
                        if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("grt").Attribute("value").Value);
                            if (deviceValue > rangeval)
                            {
                                if (lst.Element("grt").Attribute("device").Value != "")
                                {
                                    if (lst.Element("grt").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("grt").Attribute("data").Value;
                                        resultType = lst.Element("grt").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("grt").Attribute("data").Value;
                                    resultType = lst.Element("grt").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("grt").Attribute("ageopr").Value == "eql")
                    {
                        if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("grt").Attribute("value").Value);
                            if (deviceValue > rangeval)
                            {
                                if (lst.Element("grt").Attribute("device").Value != "")
                                {
                                    if (lst.Element("grt").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("grt").Attribute("data").Value;
                                        resultType = lst.Element("grt").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("grt").Attribute("data").Value;
                                    resultType = lst.Element("grt").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("grt").Attribute("ageopr").Value == "grt")
                    {
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("grt").Attribute("value").Value);
                            if (deviceValue > rangeval)
                            {
                                if (lst.Element("grt").Attribute("device").Value != "")
                                {
                                    if (lst.Element("grt").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("grt").Attribute("data").Value;
                                        resultType = lst.Element("grt").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("grt").Attribute("data").Value;
                                    resultType = lst.Element("grt").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("grt").Attribute("ageopr").Value == "grq")
                    {
                        if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("grt").Attribute("value").Value);
                            if (deviceValue > rangeval)
                            {
                                if (lst.Element("grt").Attribute("device").Value != "")
                                {
                                    if (lst.Element("grt").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("grt").Attribute("data").Value;
                                        resultType = lst.Element("grt").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("grt").Attribute("data").Value;
                                    resultType = lst.Element("grt").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("grt").Attribute("ageopr").Value == "btw")
                    {
                        string[] between = lst.Element("grt").Attribute("agerange").Value.Split('-');
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("grt").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("grt").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("grt").Attribute("value").Value);
                            if (deviceValue > rangeval)
                            {
                                if (lst.Element("grt").Attribute("device").Value != "")
                                {
                                    if (lst.Element("grt").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("grt").Attribute("data").Value;
                                        resultType = lst.Element("grt").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("grt").Attribute("data").Value;
                                    resultType = lst.Element("grt").Attribute("result").Value;
                                }
                            }
                        }
                    }
                }


                if (lst.Element("grq") != null)
                {
                    if (lst.Element("grq").Attribute("ageopr").Value == "lst")
                    {
                        if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("grq").Attribute("value").Value);
                            if (deviceValue >= rangeval)
                            {
                                if (lst.Element("grq").Attribute("device").Value != "")
                                {
                                    if (lst.Element("grq").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("grq").Attribute("data").Value;
                                        resultType = lst.Element("grq").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("grq").Attribute("data").Value;
                                    resultType = lst.Element("grq").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("grq").Attribute("ageopr").Value == "lsq")
                    {
                        if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("grq").Attribute("value").Value);
                            if (deviceValue >= rangeval)
                            {
                                if (lst.Element("grq").Attribute("device").Value != "")
                                {
                                    if (lst.Element("grq").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("grq").Attribute("data").Value;
                                        resultType = lst.Element("grq").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("grq").Attribute("data").Value;
                                    resultType = lst.Element("grq").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("grq").Attribute("ageopr").Value == "eql")
                    {
                        if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("grq").Attribute("value").Value);
                            if (deviceValue >= rangeval)
                            {
                                if (lst.Element("grq").Attribute("device").Value != "")
                                {
                                    if (lst.Element("grq").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("grq").Attribute("data").Value;
                                        resultType = lst.Element("grq").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("grq").Attribute("data").Value;
                                    resultType = lst.Element("grq").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("grq").Attribute("ageopr").Value == "grt")
                    {
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("grq").Attribute("value").Value);
                            if (deviceValue >= rangeval)
                            {
                                if (lst.Element("grq").Attribute("device").Value != "")
                                {
                                    if (lst.Element("grq").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("grq").Attribute("data").Value;
                                        resultType = lst.Element("grq").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("grq").Attribute("data").Value;
                                    resultType = lst.Element("grq").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("grq").Attribute("ageopr").Value == "grq")
                    {
                        if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("grq").Attribute("value").Value);
                            if (deviceValue >= rangeval)
                            {
                                if (lst.Element("grq").Attribute("device").Value != "")
                                {
                                    if (lst.Element("grq").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("grq").Attribute("data").Value;
                                        resultType = lst.Element("grq").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("grq").Attribute("data").Value;
                                    resultType = lst.Element("grq").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("grq").Attribute("ageopr").Value == "btw")
                    {
                        string[] between = lst.Element("grq").Attribute("agerange").Value.Split('-');
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("grq").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("grq").Attribute("agetype").Value))
                        {
                            rangeval = Convert.ToDecimal(lst.Element("grq").Attribute("value").Value);
                            if (deviceValue >= rangeval)
                            {
                                if (lst.Element("grq").Attribute("device").Value != "")
                                {
                                    if (lst.Element("grq").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("grq").Attribute("data").Value;
                                        resultType = lst.Element("grq").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("grq").Attribute("data").Value;
                                    resultType = lst.Element("grq").Attribute("result").Value;
                                }
                            }
                        }
                    }
                }

                if (lst.Element("btw") != null)
                {
                    if (lst.Element("btw").Attribute("ageopr").Value == "lst")
                    {
                        if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                        {
                            string[] between1 = lst.Element("btw").Attribute("value").Value.Split('-');
                            if (deviceValue >= Convert.ToDecimal(between1[0]) && deviceValue <= Convert.ToDecimal(between1[1]))
                            {
                                if (lst.Element("btw").Attribute("device").Value != "")
                                {
                                    if (lst.Element("btw").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("btw").Attribute("data").Value;
                                        resultType = lst.Element("btw").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("btw").Attribute("data").Value;
                                    resultType = lst.Element("btw").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("btw").Attribute("ageopr").Value == "lsq")
                    {
                        if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                        {
                            string[] between1 = lst.Element("btw").Attribute("value").Value.Split('-');
                            if (deviceValue >= Convert.ToDecimal(between1[0]) && deviceValue <= Convert.ToDecimal(between1[1]))
                            {
                                if (lst.Element("btw").Attribute("device").Value != "")
                                {
                                    if (lst.Element("btw").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("btw").Attribute("data").Value;
                                        resultType = lst.Element("btw").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("btw").Attribute("data").Value;
                                    resultType = lst.Element("btw").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("btw").Attribute("ageopr").Value == "eql")
                    {
                        if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                        {
                            string[] between1 = lst.Element("btw").Attribute("value").Value.Split('-');
                            if (deviceValue >= Convert.ToDecimal(between1[0]) && deviceValue <= Convert.ToDecimal(between1[1]))
                            {
                                if (lst.Element("btw").Attribute("device").Value != "")
                                {
                                    if (lst.Element("btw").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("btw").Attribute("data").Value;
                                        resultType = lst.Element("btw").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("btw").Attribute("data").Value;
                                    resultType = lst.Element("btw").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("btw").Attribute("ageopr").Value == "grt")
                    {
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                        {
                            string[] between1 = lst.Element("btw").Attribute("value").Value.Split('-');
                            if (deviceValue >= Convert.ToDecimal(between1[0]) && deviceValue <= Convert.ToDecimal(between1[1]))
                            {
                                if (lst.Element("btw").Attribute("device").Value != "")
                                {
                                    if (lst.Element("btw").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("btw").Attribute("data").Value;
                                        resultType = lst.Element("btw").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("btw").Attribute("data").Value;
                                    resultType = lst.Element("btw").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("btw").Attribute("ageopr").Value == "grq")
                    {
                        if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                        {
                            string[] between1 = lst.Element("btw").Attribute("value").Value.Split('-');
                            if (deviceValue >= Convert.ToDecimal(between1[0]) && deviceValue <= Convert.ToDecimal(between1[1]))
                            {
                                if (lst.Element("btw").Attribute("device").Value != "")
                                {
                                    if (lst.Element("btw").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("btw").Attribute("data").Value;
                                        resultType = lst.Element("btw").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("btw").Attribute("data").Value;
                                    resultType = lst.Element("btw").Attribute("result").Value;
                                }
                            }
                        }
                    }
                    else if (lst.Element("btw").Attribute("ageopr").Value == "btw")
                    {
                        string[] between = lst.Element("btw").Attribute("agerange").Value.Split('-');
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("btw").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("btw").Attribute("agetype").Value))
                        {
                            string[] between1 = lst.Element("btw").Attribute("value").Value.Split('-');
                            if (deviceValue >= Convert.ToDecimal(between1[0]) && deviceValue <= Convert.ToDecimal(between1[1]))
                            {
                                if (lst.Element("btw").Attribute("device").Value != "")
                                {
                                    if (lst.Element("btw").Attribute("device").Value == deviceID)
                                    {
                                        result = lst.Element("btw").Attribute("data").Value;
                                        resultType = lst.Element("btw").Attribute("result").Value;
                                    }
                                }
                                else
                                {
                                    result = lst.Element("btw").Attribute("data").Value;
                                    resultType = lst.Element("btw").Attribute("result").Value;
                                }
                            }
                        }
                    }
                }
                if (result != string.Empty)
                {
                    break;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in interpretation range", ex);
        }
    }

    public void GetRIROtherRange(IEnumerable<XElement> otherRangeBoth, decimal deviceValue, string deviceID, out string result, out string resultType)
    {
        result = string.Empty;
        resultType = string.Empty;
        try
        {
            decimal rangeval;
            foreach (var lst in otherRangeBoth)
            {
                if (lst.Element("lst") != null)
                {
                    rangeval = Convert.ToDecimal(lst.Element("lst").Attribute("value").Value);

                    if (deviceValue < rangeval)
                    {
                        if (lst.Element("lst").Attribute("device").Value != "")
                        {
                            if (lst.Element("lst").Attribute("device").Value == deviceID)
                            {
                                result = lst.Element("lst").Attribute("data").Value;
                                resultType = lst.Element("lst").Attribute("result").Value;
                            }
                        }
                        else
                        {
                            result = lst.Element("lst").Attribute("data").Value;
                            resultType = lst.Element("lst").Attribute("result").Value;
                        }
                    }
                }

                if (lst.Element("lsq") != null)
                {
                    rangeval = Convert.ToDecimal(lst.Element("lsq").Attribute("value").Value);

                    if (deviceValue <= rangeval)
                    {
                        if (lst.Element("lsq").Attribute("device").Value != "")
                        {
                            if (lst.Element("lsq").Attribute("device").Value == deviceID)
                            {
                                result = lst.Element("lsq").Attribute("data").Value;
                                resultType = lst.Element("lsq").Attribute("result").Value;
                            }
                        }
                        else
                        {
                            result = lst.Element("lsq").Attribute("data").Value;
                            resultType = lst.Element("lsq").Attribute("result").Value;
                        }
                    }
                }

                if (lst.Element("eql") != null)
                {
                    rangeval = Convert.ToDecimal(lst.Element("eql").Attribute("value").Value);

                    if (deviceValue == rangeval)
                    {
                        if (lst.Element("eql").Attribute("device").Value != "")
                        {
                            if (lst.Element("eql").Attribute("device").Value == deviceID)
                            {
                                result = lst.Element("eql").Attribute("data").Value;
                                resultType = lst.Element("eql").Attribute("result").Value;
                            }
                        }
                        else
                        {
                            result = lst.Element("eql").Attribute("data").Value;
                            resultType = lst.Element("eql").Attribute("result").Value;
                        }
                    }
                }

                if (lst.Element("grt") != null)
                {
                    rangeval = Convert.ToDecimal(lst.Element("grt").Attribute("value").Value);

                    if (deviceValue > rangeval)
                    {
                        if (lst.Element("grt").Attribute("device").Value != "")
                        {
                            if (lst.Element("grt").Attribute("device").Value == deviceID)
                            {
                                result = lst.Element("grt").Attribute("data").Value;
                                resultType = lst.Element("grt").Attribute("result").Value;
                            }
                        }
                        else
                        {
                            result = lst.Element("grt").Attribute("data").Value;
                            resultType = lst.Element("grt").Attribute("result").Value;
                        }
                    }
                }


                if (lst.Element("grq") != null)
                {
                    rangeval = Convert.ToDecimal(lst.Element("grq").Attribute("value").Value);

                    if (deviceValue >= rangeval)
                    {
                        if (lst.Element("grq").Attribute("device").Value != "")
                        {
                            if (lst.Element("grq").Attribute("device").Value == deviceID)
                            {
                                result = lst.Element("grq").Attribute("data").Value;
                                resultType = lst.Element("grq").Attribute("result").Value;
                            }
                        }
                        else
                        {
                            result = lst.Element("grq").Attribute("data").Value;
                            resultType = lst.Element("grq").Attribute("result").Value;
                        }
                    }
                }

                if (lst.Element("btw") != null)
                {
                    string[] between;
                    between = lst.Element("btw").Attribute("value").Value.Split('-');

                    if (deviceValue >= Convert.ToDecimal(between[0]) && deviceValue <= Convert.ToDecimal(between[1]))
                    {
                        if (lst.Element("btw").Attribute("device").Value != "")
                        {
                            if (lst.Element("btw").Attribute("device").Value == deviceID)
                            {
                                result = lst.Element("btw").Attribute("data").Value;
                                resultType = lst.Element("btw").Attribute("result").Value;
                            }
                        }
                        else
                        {
                            result = lst.Element("btw").Attribute("data").Value;
                            resultType = lst.Element("btw").Attribute("result").Value;
                        }
                    }
                }
                if (result != string.Empty)
                {
                    break;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in validating interpretation range", ex);
        }
    }

    public void GetRIROtherRangeAgeText(IEnumerable<XElement> otherRangeBothText, string[] CatagoryAgeMain, double patientAgeInDays, decimal deviceValue, string deviceID, out string result, out string resultType)
    {
        result = string.Empty;
        resultType = string.Empty;
        try
        {
            foreach (var lst in otherRangeBothText)
            {
                if (result == string.Empty)
                {

                    if (lst.Element("txt") != null)
                    {
                        if (lst.Element("txt").Attribute("ageopr").Value == "lst")
                        {
                            if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("txt").Attribute("agerange").Value), lst.Element("txt").Attribute("agetype").Value))
                            {
                                if (CatagoryAgeMain[3].ToString().ToLower() == lst.Element("txt").Value.ToString().ToLower())
                                {
                                    if (lst.Element("txt").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("txt").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("txt").Attribute("data").Value;
                                            resultType = lst.Element("txt").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("txt").Attribute("data").Value;
                                        resultType = lst.Element("txt").Attribute("result").Value;
                                    }
                                }
                            }
                        }
                        else if (lst.Element("txt").Attribute("ageopr").Value == "lsq")
                        {
                            if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("txt").Attribute("agerange").Value), lst.Element("txt").Attribute("agetype").Value))
                            {
                                if (CatagoryAgeMain[3].ToString().ToLower() == lst.Element("txt").Value.ToString().ToLower())
                                {
                                    if (lst.Element("txt").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("txt").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("txt").Attribute("data").Value;
                                            resultType = lst.Element("txt").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("txt").Attribute("data").Value;
                                        resultType = lst.Element("txt").Attribute("result").Value;
                                    }
                                }
                            }
                        }
                        else if (lst.Element("txt").Attribute("ageopr").Value == "eql")
                        {
                            if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("txt").Attribute("agerange").Value), lst.Element("txt").Attribute("agetype").Value))
                            {
                                if (CatagoryAgeMain[3].ToString().ToLower() == lst.Element("txt").Value.ToString().ToLower())
                                {
                                    if (lst.Element("txt").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("txt").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("txt").Attribute("data").Value;
                                            resultType = lst.Element("txt").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("txt").Attribute("data").Value;
                                        resultType = lst.Element("txt").Attribute("result").Value;
                                    }
                                }
                            }
                        }
                        else if (lst.Element("txt").Attribute("ageopr").Value == "grt")
                        {
                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("txt").Attribute("agerange").Value), lst.Element("txt").Attribute("agetype").Value))
                            {
                                if (CatagoryAgeMain[3].ToString().ToLower() == lst.Element("txt").Value.ToString().ToLower())
                                {
                                    if (lst.Element("txt").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("txt").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("txt").Attribute("data").Value;
                                            resultType = lst.Element("txt").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("txt").Attribute("data").Value;
                                        resultType = lst.Element("txt").Attribute("result").Value;
                                    }
                                }
                            }
                        }
                        else if (lst.Element("txt").Attribute("ageopr").Value == "grq")
                        {
                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("txt").Attribute("agerange").Value), lst.Element("txt").Attribute("agetype").Value))
                            {
                                if (CatagoryAgeMain[3].ToString().ToLower() == lst.Element("txt").Value.ToString().ToLower())
                                {
                                    if (lst.Element("txt").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("txt").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("txt").Attribute("data").Value;
                                            resultType = lst.Element("txt").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("txt").Attribute("data").Value;
                                        resultType = lst.Element("txt").Attribute("result").Value;
                                    }
                                }
                            }
                        }
                        else if (lst.Element("txt").Attribute("ageopr").Value == "btw")
                        {
                            string[] between = lst.Element("txt").Attribute("agerange").Value.Split('-');
                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("txt").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("txt").Attribute("agetype").Value))
                            {
                                if (CatagoryAgeMain[3].ToString().ToLower() == lst.Element("txt").Value.ToString().ToLower())
                                {
                                    if (lst.Element("txt").Attribute("device").Value != "")
                                    {
                                        if (lst.Element("txt").Attribute("device").Value == deviceID)
                                        {
                                            result = lst.Element("txt").Attribute("data").Value;
                                            resultType = lst.Element("txt").Attribute("result").Value;
                                        }
                                    }
                                    else
                                    {
                                        result = lst.Element("txt").Attribute("data").Value;
                                        resultType = lst.Element("txt").Attribute("result").Value;
                                    }
                                }
                            }
                        }
                    }
                }
                if (result != string.Empty)
                {
                    break;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in validating interpretation range", ex);
        }
    }

    public void GetRIROtherRangeText(IEnumerable<XElement> otherRangeBothText, string[] CatagoryAgeMain, decimal deviceValue, string deviceID, out string result, out string resultType)
    {
        result = string.Empty;
        resultType = string.Empty;
        try
        {
            foreach (var lst in otherRangeBothText)
            {
                if (result == string.Empty)
                {

                    if (lst.Element("txt") != null)
                    {
                        if (CatagoryAgeMain[3].ToString().ToLower() == lst.Element("txt").Value.ToString().ToLower())
                        {
                            if (lst.Element("txt").Attribute("device").Value != "")
                            {
                                if (lst.Element("txt").Attribute("device").Value == deviceID)
                                {
                                    result = lst.Element("txt").Attribute("data").Value;
                                    resultType = lst.Element("txt").Attribute("result").Value;
                                }
                            }
                            else
                            {
                                result = lst.Element("txt").Attribute("data").Value;
                                resultType = lst.Element("txt").Attribute("result").Value;
                            }
                        }
                    }
                }
                if (result != string.Empty)
                {
                    break;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in validating interpretation range", ex);
        }
    }

    public void GetRefAgeRange(IEnumerable<XElement> ageRange, double patientAgeInDays, string addstr, decimal rangeValue, out string textColor)
    {
        textColor = "white";
        foreach (var lst in ageRange)
        {


            if (lst.Element("lst") != null)
            {
                if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("lst").Value), lst.Element("lst").Attribute("agetype").Value))
                {
                    switch (ConvertRangeStringOptr(lst.Element("lst").FirstAttribute.Value))
                    {
                        case "<":

                            if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                            }

                            break;

                        case "<=":

                            if (rangeValue <= Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                            }

                            break;
                        case "=":

                            if (rangeValue == Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";

                                if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                {

                                    textColor = "L";
                                }

                            }

                            break;
                        case "=>":

                            if (rangeValue >= Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                                if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                {
                                    textColor = "L";
                                }

                            }

                            break;
                        case ">":

                            if (rangeValue > Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";

                                if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                                {

                                    textColor = "L";
                                }
                            }

                            break;
                        case " ":

                            string[] between = lst.Element("lst").LastAttribute.Value.Split('-');
                            if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";

                                if (rangeValue < Convert.ToDecimal(between[0]))
                                {

                                    textColor = "L";
                                }

                            }

                            break;


                    }


                }


            }

            if (lst.Element("lsq") != null)
            {
                if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("lsq").Value), lst.Element("lsq").Attribute("agetype").Value))
                {

                    switch (ConvertRangeStringOptr(lst.Element("lsq").FirstAttribute.Value))
                    {
                        case "<":

                            if (rangeValue < Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                            }

                            break;

                        case "<=":

                            if (rangeValue <= Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";

                            }

                            break;
                        case "=":

                            if (rangeValue == Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                                if (rangeValue < Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                {

                                    textColor = "L";
                                }
                            }

                            break;
                        case "=>":

                            if (rangeValue >= Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                                if (rangeValue < Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                {
                                    textColor = "L";
                                }

                            }

                            break;
                        case ">":

                            if (rangeValue > Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                                if (rangeValue < Convert.ToDecimal(lst.Element("lsq").LastAttribute.Value))
                                {
                                    textColor = "L";
                                }

                            }

                            break;
                        case " ":

                            string[] between = lst.Element("lsq").LastAttribute.Value.Split('-');
                            if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";

                                if (rangeValue < Convert.ToDecimal(between[0]))
                                {
                                    textColor = "L";
                                }

                            }

                            break;


                    }
                }



            }

            if (lst.Element("eql") != null)
            {

                if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("eql").Value), lst.Element("eql").Attribute("agetype").Value))
                {

                    switch (ConvertRangeStringOptr(lst.Element("eql").FirstAttribute.Value))
                    {
                        case "<":

                            if (rangeValue < Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                            }

                            break;

                        case "<=":

                            if (rangeValue <= Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                            }

                            break;
                        case "=":

                            if (rangeValue == Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";

                                if (rangeValue < Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                {

                                    textColor = "L";
                                }

                            }

                            break;
                        //clarify
                        case "=>":

                            if (rangeValue >= Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";

                                if (rangeValue < Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                {
                                    textColor = "L";
                                }

                            }

                            break;
                        case ">":

                            if (rangeValue > Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";

                                if (rangeValue < Convert.ToDecimal(lst.Element("eql").LastAttribute.Value))
                                {
                                    textColor = "L";
                                }

                            }

                            break;
                        case " ":

                            string[] between = lst.Element("eql").LastAttribute.Value.Split('-');
                            if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                                if (rangeValue < Convert.ToDecimal(between[0]))
                                {
                                    textColor = "L";
                                }

                            }

                            break;


                    }
                }




            }

            if (lst.Element("grt") != null)
            {


                if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("grt").Value), lst.Element("grt").Attribute("agetype").Value))
                {

                    switch (ConvertRangeStringOptr(lst.Element("grt").FirstAttribute.Value))
                    {
                        case "<":

                            if (rangeValue < Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                            }

                            break;

                        case "<=":

                            if (rangeValue <= Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                            }

                            break;
                        case "=":

                            if (rangeValue == Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";

                                if (rangeValue < Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                {
                                    textColor = "L";
                                }
                            }

                            break;
                        case "=>":

                            if (rangeValue >= Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                                if (rangeValue < Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                {
                                    textColor = "L";
                                }

                            }

                            break;
                        case ">":

                            if (rangeValue > Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                                if (rangeValue < Convert.ToDecimal(lst.Element("grt").LastAttribute.Value))
                                {
                                    textColor = "L";
                                }

                            }

                            break;
                        case " ":

                            string[] between = lst.Element("grt").LastAttribute.Value.Split('-');
                            if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                                if (rangeValue < Convert.ToDecimal(between[0]))
                                {
                                    textColor = "L";
                                }

                            }

                            break;


                    }
                }




            }


            if (lst.Element("grq") != null)
            {



                if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("grq").Value), lst.Element("grq").Attribute("agetype").Value))
                {

                    switch (ConvertRangeStringOptr(lst.Element("grq").FirstAttribute.Value))
                    {
                        case "<":

                            if (rangeValue < Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";

                            }

                            break;

                        case "<=":

                            if (rangeValue <= Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";

                            }

                            break;

                        //clarify
                        case "=":

                            if (rangeValue == Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";

                                if (rangeValue < Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                {

                                    textColor = "L";
                                }

                            }

                            break;
                        case "=>":

                            if (rangeValue >= Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";

                                if (rangeValue < Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                {
                                    textColor = "L";
                                }

                            }

                            break;
                        case ">":

                            if (rangeValue > Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";

                                if (rangeValue < Convert.ToDecimal(lst.Element("grq").LastAttribute.Value))
                                {
                                    textColor = "L";
                                }

                            }

                            break;
                        case " ":

                            string[] between = lst.Element("grq").LastAttribute.Value.Split('-');
                            if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                                if (rangeValue < Convert.ToDecimal(between[0]))
                                {
                                    textColor = "L";
                                }

                            }

                            break;


                    }
                }




            }

            if (lst.Element("btw") != null)
            {

                string[] between = lst.Element("btw").Value.Split('-');

                if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("btw").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("btw").Attribute("agetype").Value))
                {


                    switch (ConvertRangeStringOptr(lst.Element("btw").FirstAttribute.Value))
                    {
                        case "<":

                            if (rangeValue < Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";

                            }

                            break;

                        case "<=":

                            if (rangeValue <= Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";

                            }

                            break;
                        case "=":

                            if (rangeValue == Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";

                                if (rangeValue < Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                {

                                    textColor = "L";
                                }

                            }

                            break;
                        case "=>":

                            if (rangeValue >= Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";

                                if (rangeValue < Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                {

                                    textColor = "L";
                                }


                            }

                            break;
                        case ">":

                            if (rangeValue > Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";

                                if (rangeValue < Convert.ToDecimal(lst.Element("btw").LastAttribute.Value))
                                {

                                    textColor = "L";
                                }

                            }

                            break;
                        case " ":

                            string[] between1 = lst.Element("btw").LastAttribute.Value.Split('-');
                            if (rangeValue >= Convert.ToDecimal(between1[0]) && rangeValue <= Convert.ToDecimal(between1[1]))
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                                if (rangeValue <= Convert.ToDecimal(between1[0]))
                                {
                                    textColor = "L";
                                }

                            }

                            break;


                    }
                }



            }
            if (textColor != "white")
            {
                break;
            }
        }
    }

    public void GetRefCommonRange(IEnumerable<XElement> commonRange, decimal rangeValue, out string textColor)
    {
        textColor = "white";
        foreach (var lst in commonRange)
        {


            if (lst.Element("lst") != null)
            {
                if (rangeValue < Convert.ToDecimal(lst.Element("lst").Value))
                {
                    textColor = "white";
                }
                else
                {
                    textColor = "A";

                }
            }

            if (lst.Element("lsq") != null)
            {

                if (rangeValue <= Convert.ToDecimal(lst.Element("lsq").Value))
                {
                    textColor = "white";
                }
                else
                {
                    textColor = "A";
                }

            }

            if (lst.Element("eql") != null)
            {
                if (rangeValue == Convert.ToDecimal(lst.Element("eql").Value))
                {
                    textColor = "white";
                }
                else
                {
                    textColor = "A";

                    if (rangeValue < Convert.ToDecimal(lst.Element("eql").Value))
                    {

                        textColor = "L";
                    }

                }
            }

            if (lst.Element("grt") != null)
            {
                if (rangeValue > Convert.ToDecimal(lst.Element("grt").Value))
                {
                    textColor = "white";
                }
                else
                {
                    textColor = "A";

                    if (rangeValue < Convert.ToDecimal(lst.Element("grt").Value))
                    {
                        textColor = "L";
                    }
                }
            }


            if (lst.Element("grq") != null)
            {
                if (rangeValue >= Convert.ToDecimal(lst.Element("grq").Value))
                {
                    textColor = "white";
                }
                else
                {
                    textColor = "A";
                    if (rangeValue < Convert.ToDecimal(lst.Element("grq").Value))
                    {
                        textColor = "L";
                    }
                }
            }

            if (lst.Element("btw") != null)
            {
                string[] between = lst.Element("btw").Value.Split('-');


                if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                {
                    textColor = "white";
                }
                else
                {
                    textColor = "A";
                    if (rangeValue <= Convert.ToDecimal(between[0]))
                    {
                        textColor = "L";
                    }

                }
            }
            if (textColor != "white")
            {
                break;
            }
        }

    }

    public void GetRefOtherAgeRange(IEnumerable<XElement> otherRangeBoth, double patientAgeInDays, string addstr, decimal rangeValue, out string textColor)
    {
        textColor = "white";

        var normalOtherRange = from other in otherRangeBoth
                               where (string)other.Elements().First().Attribute("Normal") == "Y"
                               select other;
        if (normalOtherRange != null && normalOtherRange.Count() > 0)
        {
            otherRangeBoth = normalOtherRange;
        }
        decimal rangeval;
        foreach (var lst in otherRangeBoth)
        {


            if (lst.Element("lst") != null)
            {
                if (lst.Element("lst").Attribute("ageopr").Value == "lst")
                {
                    if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("lst").Attribute("value").Value);

                        if (rangeValue < rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                        }
                    }
                }
                else if (lst.Element("lst").Attribute("ageopr").Value == "lsq")
                {
                    if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("lst").Attribute("value").Value);

                        if (rangeValue < rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                        }
                    }
                }
                else if (lst.Element("lst").Attribute("ageopr").Value == "eql")
                {
                    if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("lst").Attribute("value").Value);

                        if (rangeValue < rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                        }
                    }
                }
                else if (lst.Element("lst").Attribute("ageopr").Value == "grt")
                {
                    if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("lst").Attribute("value").Value);

                        if (rangeValue < rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                        }
                    }
                }
                else if (lst.Element("lst").Attribute("ageopr").Value == "grq")
                {
                    if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("lst").Attribute("value").Value);

                        if (rangeValue < rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                        }
                    }
                }
                else if (lst.Element("lst").Attribute("ageopr").Value == "btw")
                {
                    string[] between = lst.Element("lst").Attribute("agerange").Value.Split('-');
                    if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("lst").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("lst").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("lst").Attribute("value").Value);

                        if (rangeValue < rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                        }
                    }
                }
            }

            if (lst.Element("lsq") != null)
            {
                if (lst.Element(("lsq")).Attribute("ageopr").Value == "lst")
                {
                    if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element(("lsq")).Attribute("agerange").Value), lst.Element(("lsq")).Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("lsq").Attribute("value").Value);

                        if (rangeValue <= rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                        }
                    }
                }
                else if (lst.Element(("lsq")).Attribute("ageopr").Value == "lsq")
                {
                    if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element(("lsq")).Attribute("agerange").Value), lst.Element(("lsq")).Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("lsq").Attribute("value").Value);

                        if (rangeValue <= rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                        }
                    }
                }
                else if (lst.Element(("lsq")).Attribute("ageopr").Value == "eql")
                {
                    if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element(("lsq")).Attribute("agerange").Value), lst.Element(("lsq")).Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("lsq").Attribute("value").Value);

                        if (rangeValue <= rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                        }
                    }
                }
                else if (lst.Element(("lsq")).Attribute("ageopr").Value == "grt")
                {
                    if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element(("lsq")).Attribute("agerange").Value), lst.Element(("lsq")).Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("lsq").Attribute("value").Value);

                        if (rangeValue <= rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                        }
                    }
                }
                else if (lst.Element(("lsq")).Attribute("ageopr").Value == "grq")
                {
                    if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element(("lsq")).Attribute("agerange").Value), lst.Element(("lsq")).Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("lsq").Attribute("value").Value);

                        if (rangeValue <= rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                        }
                    }
                }
                else if (lst.Element(("lsq")).Attribute("ageopr").Value == "btw")
                {
                    string[] between = lst.Element(("lsq")).Attribute("agerange").Value.Split('-');
                    if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element(("lsq")).Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element(("lsq")).Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("lsq").Attribute("value").Value);

                        if (rangeValue <= rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                        }
                    }
                }
            }

            if (lst.Element("eql") != null)
            {
                if (lst.Element("eql").Attribute("ageopr").Value == "lst")
                {
                    if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("eql").Attribute("value").Value);
                        if (rangeValue == rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
                else if (lst.Element("eql").Attribute("ageopr").Value == "lsq")
                {
                    if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("eql").Attribute("value").Value);
                        if (rangeValue == rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
                else if (lst.Element("eql").Attribute("ageopr").Value == "eql")
                {
                    if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("eql").Attribute("value").Value);
                        if (rangeValue == rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
                else if (lst.Element("eql").Attribute("ageopr").Value == "grt")
                {
                    if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("eql").Attribute("value").Value);
                        if (rangeValue == rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
                else if (lst.Element("eql").Attribute("ageopr").Value == "grq")
                {
                    if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("eql").Attribute("value").Value);
                        if (rangeValue == rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
                else if (lst.Element("eql").Attribute("ageopr").Value == "btw")
                {
                    string[] between = lst.Element("eql").Attribute("agerange").Value.Split('-');
                    if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("eql").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("eql").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("eql").Attribute("value").Value);
                        if (rangeValue == rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
            }

            if (lst.Element("grt") != null)
            {
                if (lst.Element("grt").Attribute("ageopr").Value == "lst")
                {
                    if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("grt").Attribute("value").Value);
                        if (rangeValue > rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
                else if (lst.Element("grt").Attribute("ageopr").Value == "lsq")
                {
                    if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("grt").Attribute("value").Value);
                        if (rangeValue > rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
                else if (lst.Element("grt").Attribute("ageopr").Value == "eql")
                {
                    if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("grt").Attribute("value").Value);
                        if (rangeValue > rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
                else if (lst.Element("grt").Attribute("ageopr").Value == "grt")
                {
                    if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("grt").Attribute("value").Value);
                        if (rangeValue > rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
                else if (lst.Element("grt").Attribute("ageopr").Value == "grq")
                {
                    if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("grt").Attribute("value").Value);
                        if (rangeValue > rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
                else if (lst.Element("grt").Attribute("ageopr").Value == "btw")
                {
                    string[] between = lst.Element("grt").Attribute("agerange").Value.Split('-');
                    if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("grt").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("grt").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("grt").Attribute("value").Value);
                        if (rangeValue > rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
            }


            if (lst.Element("grq") != null)
            {
                if (lst.Element("grq").Attribute("ageopr").Value == "lst")
                {
                    if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("grq").Attribute("value").Value);
                        if (rangeValue >= rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
                else if (lst.Element("grq").Attribute("ageopr").Value == "lsq")
                {
                    if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("grq").Attribute("value").Value);
                        if (rangeValue >= rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
                else if (lst.Element("grq").Attribute("ageopr").Value == "eql")
                {
                    if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("grq").Attribute("value").Value);
                        if (rangeValue >= rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
                else if (lst.Element("grq").Attribute("ageopr").Value == "grt")
                {
                    if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("grq").Attribute("value").Value);
                        if (rangeValue >= rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
                else if (lst.Element("grq").Attribute("ageopr").Value == "grq")
                {
                    if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("grq").Attribute("value").Value);
                        if (rangeValue >= rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
                else if (lst.Element("grq").Attribute("ageopr").Value == "btw")
                {
                    string[] between = lst.Element("grq").Attribute("agerange").Value.Split('-');
                    if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("grq").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("grq").Attribute("agetype").Value))
                    {
                        rangeval = Convert.ToDecimal(lst.Element("grq").Attribute("value").Value);
                        if (rangeValue >= rangeval)
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(lst.Element("lst").LastAttribute.Value))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
            }

            if (lst.Element("btw") != null)
            {
                if (lst.Element("btw").Attribute("ageopr").Value == "lst")
                {
                    if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                    {
                        string[] between1 = lst.Element("btw").Attribute("value").Value.Split('-');
                        if (rangeValue >= Convert.ToDecimal(between1[0]) && rangeValue <= Convert.ToDecimal(between1[1]))
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(between1[0]))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
                else if (lst.Element("btw").Attribute("ageopr").Value == "lsq")
                {
                    if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                    {
                        string[] between1 = lst.Element("btw").Attribute("value").Value.Split('-');
                        if (rangeValue >= Convert.ToDecimal(between1[0]) && rangeValue <= Convert.ToDecimal(between1[1]))
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(between1[0]))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
                else if (lst.Element("btw").Attribute("ageopr").Value == "eql")
                {
                    if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                    {
                        string[] between1 = lst.Element("btw").Attribute("value").Value.Split('-');
                        if (rangeValue >= Convert.ToDecimal(between1[0]) && rangeValue <= Convert.ToDecimal(between1[1]))
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(between1[0]))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
                else if (lst.Element("btw").Attribute("ageopr").Value == "grt")
                {
                    if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                    {
                        string[] between1 = lst.Element("btw").Attribute("value").Value.Split('-');
                        if (rangeValue >= Convert.ToDecimal(between1[0]) && rangeValue <= Convert.ToDecimal(between1[1]))
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(between1[0]))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
                else if (lst.Element("btw").Attribute("ageopr").Value == "grq")
                {
                    if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                    {
                        string[] between1 = lst.Element("btw").Attribute("value").Value.Split('-');
                        if (rangeValue >= Convert.ToDecimal(between1[0]) && rangeValue <= Convert.ToDecimal(between1[1]))
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(between1[0]))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
                else if (lst.Element("btw").Attribute("ageopr").Value == "btw")
                {
                    string[] between = lst.Element("btw").Attribute("agerange").Value.Split('-');
                    if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("btw").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("btw").Attribute("agetype").Value))
                    {
                        string[] between1 = lst.Element("btw").Attribute("value").Value.Split('-');
                        if (rangeValue >= Convert.ToDecimal(between1[0]) && rangeValue <= Convert.ToDecimal(between1[1]))
                        {
                            textColor = "white";
                            break;
                        }
                        else
                        {
                            textColor = "A";
                            if (rangeValue < Convert.ToDecimal(between1[0]))
                            {
                                textColor = "L";
                            }
                        }
                    }
                }
            }
        }
    }

    public void GetRefOtherRange(IEnumerable<XElement> otherRangeBoth, string addstr, decimal rangeValue, out string textColor)
    {
        textColor = "white";

        var normalOtherRange = from other in otherRangeBoth
                               where (string)other.Elements().First().Attribute("Normal") == "Y"
                               select other;
        if (normalOtherRange != null && normalOtherRange.Count() > 0)
        {
            otherRangeBoth = normalOtherRange;
        }
        decimal rangeval;
        //Below  Code  Modified by Arivalagan.kk for  Range  issue  fix///
        decimal rslt;
        foreach (var lst in otherRangeBoth)
        {
            if (lst.Element("lst") != null)
            {
                //Below  Code  Modified by Arivalagan.kk for  Range  issue  fix///
                bool result = decimal.TryParse(lst.Element("lst").Value, out rslt);

                if (addstr == "")
                {
                    if (result == true)
                    {
                        rangeval = Convert.ToDecimal(lst.Element("lst").Value);
                    }
                    else
                    {
                        rangeval = Convert.ToDecimal(lst.Element("lst").Attribute("value").Value);
                    }
                }
                else
                {
                    rangeval = Convert.ToDecimal(lst.Element("lst").Attribute("value").Value);
                }

                if (rangeValue < rangeval)
                {
                    textColor = "white";
                    break;
                }
                else
                {
                    textColor = "A";
                }
            }

            if (lst.Element("lsq") != null)
            {
                if (addstr == "")
                {
                    bool result = decimal.TryParse(lst.Element("lsq").Value, out rslt);
                    if (result == true)
                    {
                        rangeval = Convert.ToDecimal(lst.Element("lsq").Value);
                    }
                    else
                    {
                        rangeval = Convert.ToDecimal(lst.Element("lsq").Attribute("value").Value);
                    }

                }
                else
                {
                    rangeval = Convert.ToDecimal(lst.Element("lsq").Attribute("value").Value);
                }

                if (rangeValue <= rangeval)
                {
                    textColor = "white";
                    break;
                }
                else
                {
                    textColor = "A";
                }
            }

            if (lst.Element("eql") != null)
            {
                if (addstr == "")
                {
                    bool result = decimal.TryParse(lst.Element("eql").Value, out rslt);
                    if (result == true)
                    {
                        rangeval = Convert.ToDecimal(lst.Element("eql").Value);
                    }
                    else
                    {
                        rangeval = Convert.ToDecimal(lst.Element("eql").Attribute("value").Value);
                    }
                }
                else
                {
                    rangeval = Convert.ToDecimal(lst.Element("eql").Attribute("value").Value);
                }
                if (rangeValue == rangeval)
                {
                    textColor = "white";
                    break;
                }
                else
                {
                    textColor = "A";
                }
            }

            if (lst.Element("grt") != null)
            {
                if (addstr == "")
                {
                    bool result = decimal.TryParse(lst.Element("grt").Value, out rslt);
                    if (result == true)
                    {
                        rangeval = Convert.ToDecimal(lst.Element("grt").Value);
                    }
                    else
                    {
                        rangeval = Convert.ToDecimal(lst.Element("grt").Attribute("value").Value);
                    }

                }
                else
                {
                    rangeval = Convert.ToDecimal(lst.Element("grt").Attribute("value").Value);
                }
                if (rangeValue > rangeval)
                {
                    textColor = "white";
                    break;
                }
                else
                {
                    textColor = "A";
                }
            }


            if (lst.Element("grq") != null)
            {
                if (addstr == "")
                {
                    bool result = decimal.TryParse(lst.Element("grq").Value, out rslt);
                    if (result == true)
                    {
                        rangeval = Convert.ToDecimal(lst.Element("grq").Value);
                    }
                    else
                    {
                        rangeval = Convert.ToDecimal(lst.Element("grq").Attribute("value").Value);
                    }

                }
                else
                {
                    rangeval = Convert.ToDecimal(lst.Element("grq").Attribute("value").Value);
                }
                if (rangeValue >= rangeval)
                {
                    textColor = "white";
                    break;
                }
                else
                {
                    textColor = "A";
                }
            }
            //End  Code  Modified by Arivalagan.kk for  Range  issue  fix///
            if (lst.Element("btw") != null)
            {
                string[] between;
                if (addstr == "")
                {
                    between = lst.Element("btw").Value.Split('-');
                }
                else
                {
                    between = lst.Element("btw").Attribute("value").Value.Split('-');
                }

                if (rangeValue >= Convert.ToDecimal(between[0]) && rangeValue <= Convert.ToDecimal(between[1]))
                {
                    textColor = "white";
                    break;
                }
                else if (rangeValue < Convert.ToDecimal(between[0]))
                {
                    textColor = "L";
                    break;
                }
                else if (rangeValue > Convert.ToDecimal(between[1]))
                {
                    textColor = "A";
                    break;
                }
            }
            //if (textColor != "white")
            //{
            //    break;
            //}
        }
    }

    public void GetRefOtherRangeAgeText(IEnumerable<XElement> otherRangeBothText, string[] CatagoryAgeMain, double patientAgeInDays, decimal rangeValue, out string textColor)
    {
        textColor = "white";
        var normalOtherRange = from other in otherRangeBothText
                               where (string)other.Elements().First().Attribute("Normal") == "Y"
                               select other;
        if (normalOtherRange != null && normalOtherRange.Count() > 0)
        {
            otherRangeBothText = normalOtherRange;
        }
        foreach (var lst in otherRangeBothText)
        {
            if (textColor != "Red")
            {

                if (lst.Element("txt") != null)
                {
                    if (lst.Element("txt").Attribute("ageopr").Value == "lst")
                    {
                        if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("txt").Attribute("agerange").Value), lst.Element("txt").Attribute("agetype").Value))
                        {
                            if (CatagoryAgeMain[3].ToString().ToLower() == lst.Element("txt").Value.ToString().ToLower())
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                            }
                        }
                    }
                    else if (lst.Element("txt").Attribute("ageopr").Value == "lsq")
                    {
                        if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("txt").Attribute("agerange").Value), lst.Element("txt").Attribute("agetype").Value))
                        {
                            if (CatagoryAgeMain[3].ToString().ToLower() == lst.Element("txt").Value.ToString().ToLower())
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                            }
                        }
                    }
                    else if (lst.Element("txt").Attribute("ageopr").Value == "eql")
                    {
                        if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("txt").Attribute("agerange").Value), lst.Element("txt").Attribute("agetype").Value))
                        {
                            if (CatagoryAgeMain[3].ToString().ToLower() == lst.Element("txt").Value.ToString().ToLower())
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                            }
                        }
                    }
                    else if (lst.Element("txt").Attribute("ageopr").Value == "grt")
                    {
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("txt").Attribute("agerange").Value), lst.Element("txt").Attribute("agetype").Value))
                        {
                            if (CatagoryAgeMain[3].ToString().ToLower() == lst.Element("txt").Value.ToString().ToLower())
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                            }
                        }
                    }
                    else if (lst.Element("txt").Attribute("ageopr").Value == "grq")
                    {
                        if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("txt").Attribute("agerange").Value), lst.Element("txt").Attribute("agetype").Value))
                        {
                            if (CatagoryAgeMain[3].ToString().ToLower() == lst.Element("txt").Value.ToString().ToLower())
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                            }
                        }
                    }
                    else if (lst.Element("txt").Attribute("ageopr").Value == "btw")
                    {
                        string[] between = lst.Element("txt").Attribute("agerange").Value.Split('-');
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("txt").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("txt").Attribute("agetype").Value))
                        {
                            if (CatagoryAgeMain[3].ToString().ToLower() == lst.Element("txt").Value.ToString().ToLower())
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                            }
                        }
                    }
                }
            }
            if (textColor != "white")
            {
                break;
            }
        }
    }

    public void GetRefOtherRangeText(IEnumerable<XElement> otherRangeBothText, string[] CatagoryAgeMain, string addstr, string code, decimal rangeValue, out string textColor)
    {
        textColor = "white";
        foreach (var lst in otherRangeBothText)
        {
            if (textColor != "Red")
            {

                if (lst.Element("txt") != null)
                {
                    if (CatagoryAgeMain[3].ToString().ToLower() == lst.Element("txt").Value.ToString().ToLower())
                    {
                        textColor = "white";
                    }
                    else if (TryParseXml(CatagoryAgeMain[0]))
                    {
                        XElement xe1 = XElement.Parse(CatagoryAgeMain[0]);

                        var otherRangeText1 = from other in xe1.Elements(code).Elements("property")
                                              where (string)other.Attribute("type") == "other" && (string)other.Attribute("value") == addstr && (string)other.Attribute("ResultType") == "Text"
                                              select other;

                        foreach (var lst1 in otherRangeText1)
                        {
                            if (CatagoryAgeMain[3].ToString().ToLower() == lst1.Element("txt").Value.ToString().ToLower())
                            {
                                textColor = "white";
                            }
                            else
                            {
                                textColor = "A";
                            }
                        }
                    }
                }
            }
            if (textColor != "white")
            {
                break;
            }
        }
    }

    public string ConvertRangeStringOptr(string symbol)
    {
        string ReturnValue = "";
        switch (symbol)
        {
            case "lst":
                ReturnValue = "<";
                break;
            case "lsq":
                ReturnValue = "<=";
                break;
            case "eql":
                ReturnValue = "=";
                break;
            case "grt":
                ReturnValue = ">";
                break;
            case "grq":
                ReturnValue = "=>";
                break;
            case "btw":
                ReturnValue = " ";
                break;
            case "ref":
                ReturnValue = "Source";
                break;
        }
        return ReturnValue;

    }

    public void ConvertXmlToString(string xmlData, string uom, string Gender, string Age, out string NormalReferenceRange, out string OtherReferenceRange, out string PrintableRange)
    {
        NormalReferenceRange = string.Empty;
        OtherReferenceRange = string.Empty;
        PrintableRange = string.Empty;
        try
        {
            string ReferenceRange = string.Empty;
            List<string> lstRangeType = new List<string>();
            lstRangeType.Add("referencerange");
            lstRangeType.Add("printablerange");
            uom = uom == "" ? "" : uom;
            string pGender = string.Empty;
            pGender = !string.IsNullOrEmpty(Gender) && Gender != "0" ? ((Gender == "F" || Gender == "Female") ? "Female" : "Male") : string.Empty;
            if (Gender == "N")
            {
                pGender = "NA";
            }
            string[] lstAge = Age.Split(' ');
            string pAge = string.Empty;
            string pAgetype = string.Empty;
            if (lstAge != null && lstAge.Count() > 0)
            {
                pAge = lstAge[0];
                pAgetype = lstAge.Count() > 1 && lstAge[1] != null ? lstAge[1].Replace("(", "").Replace(")", "") : "";
            }
            string[] CatagoryAgeMain = xmlData.Split('|');

            XElement xe = XElement.Parse(xmlData);

            foreach (string oRangeType in lstRangeType)
            {
                ReferenceRange = string.Empty;

                var Range = from range in xe.Elements(oRangeType).Elements("property")
                            select range;
                if (Range != null && Range.Count() > 0)
                {
                    var commonRange = from common in xe.Elements(oRangeType).Elements("property")
                                      where (string)common.Attribute("type") == "common" && ((string)common.Attribute("value")).ToLower() == pGender.ToLower()
                                      select common;

                    var commonRangeBoth = from common in xe.Elements(oRangeType).Elements("property")
                                          where (string)common.Attribute("type") == "common" && ((string)common.Attribute("value")).ToLower() == "Both".ToLower()
                                          select common;

                    var otherRange = from other in xe.Elements(oRangeType).Elements("property")
                                     where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == pGender.ToLower() && (string)other.Attribute("ResultType") != "Text" && (string)other.Attribute("agetype") == null
                                     select other;

                    var otherRangeBoth = from other in xe.Elements(oRangeType).Elements("property")
                                         where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == "Both".ToLower() && (string)other.Attribute("ResultType") != "Text" && (string)other.Attribute("agetype") == null
                                         select other;

                    var otherRangeText = from other in xe.Elements(oRangeType).Elements("property")
                                         where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == pGender.ToLower() && (string)other.Attribute("ResultType") == "Text" && (string)other.Attribute("agetype") == null
                                         select other;

                    var otherRangeBothText = from other in xe.Elements(oRangeType).Elements("property")
                                             where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == "Both".ToLower() && (string)other.Attribute("ResultType") == "Text" && (string)other.Attribute("agetype") == null
                                             select other;

                    if (!string.IsNullOrEmpty(pAge))
                    {
                        double patientAgeInDays = ConvertToDays(Convert.ToDouble(pAge), pAgetype);

                        var ageRange = from age in xe.Elements(oRangeType).Elements("property")
                                       where (string)age.Attribute("type") == "age" && ((string)age.Attribute("value")).ToLower() == pGender.ToLower()
                                       select age;

                        var ageRangeBoth = from age in xe.Elements(oRangeType).Elements("property")
                                           where (string)age.Attribute("type") == "age" && ((string)age.Attribute("value")).ToLower() == "Both".ToLower()
                                           select age;

                        var otherRangeWithAge = from other in xe.Elements(oRangeType).Elements("property")
                                                where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == pGender.ToLower() && (string)other.Attribute("ResultType") != "Text" && (string)other.Attribute("agetype") != null
                                                select other;

                        var otherRangeBothWithAge = from other in xe.Elements(oRangeType).Elements("property")
                                                    where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == "Both".ToLower() && (string)other.Attribute("ResultType") != "Text" && (string)other.Attribute("agetype") != null
                                                    select other;
                        var otherRangeTextWithAge = from other in xe.Elements(oRangeType).Elements("property")
                                                    where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == pGender.ToLower() && (string)other.Attribute("ResultType") == "Text" && (string)other.Attribute("agetype") != null
                                                    select other;

                        var otherRangeBothTextWithAge = from other in xe.Elements(oRangeType).Elements("property")
                                                        where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == "Both".ToLower() && (string)other.Attribute("ResultType") == "Text" && (string)other.Attribute("agetype") != null
                                                        select other;

                        if (ageRange != null && ageRange.Count() > 0)
                        {
                            foreach (var lst in ageRange)
                            {
                                if (lst.Element("lst") != null)
                                {
                                    if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("lst").Value), lst.Element("lst").Attribute("agetype").Value))
                                    {
                                        if (lst.Element("lst").Attribute("mode").Value != "ref")
                                        {
                                            ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("lst").FirstAttribute.Value)) + " " + lst.Element("lst").LastAttribute.Value + "<br>";
                                        }
                                        else
                                        {
                                            ReferenceRange += lst.Element("lst").LastAttribute.Value + "<br>";
                                        }
                                    }
                                }
                                if (lst.Element("lsq") != null)
                                {
                                    if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("lsq").Value), lst.Element("lsq").Attribute("agetype").Value))
                                    {
                                        if (lst.Element("lsq").Attribute("mode").Value != "ref")
                                        {
                                            ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("lsq").FirstAttribute.Value)) + " " + lst.Element("lsq").LastAttribute.Value + "<br>";
                                        }
                                        else
                                        {
                                            ReferenceRange += lst.Element("lsq").LastAttribute.Value + "<br>";
                                        }
                                    }
                                }
                                if (lst.Element("eql") != null)
                                {
                                    if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("eql").Value), lst.Element("eql").Attribute("agetype").Value))
                                    {
                                        if (lst.Element("eql").Attribute("mode").Value != "ref")
                                        {
                                            ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("eql").FirstAttribute.Value)) + " " + lst.Element("eql").LastAttribute.Value + "<br>";
                                        }
                                        else
                                        {
                                            ReferenceRange += lst.Element("eql").LastAttribute.Value + "<br>";
                                        }
                                    }
                                }
                                if (lst.Element("grt") != null)
                                {
                                    if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("grt").Value), lst.Element("grt").Attribute("agetype").Value))
                                    {
                                        if (lst.Element("grt").Attribute("mode").Value != "ref")
                                        {
                                            ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("grt").FirstAttribute.Value)) + " " + lst.Element("grt").LastAttribute.Value + "<br>";
                                        }
                                        else
                                        {
                                            ReferenceRange += lst.Element("grt").LastAttribute.Value + "<br>";
                                        }
                                    }
                                }
                                if (lst.Element("grq") != null)
                                {
                                    if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("grq").Value), lst.Element("grq").Attribute("agetype").Value))
                                    {
                                        if (lst.Element("grq").Attribute("mode").Value != "ref")
                                        {
                                            ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("grq").FirstAttribute.Value)) + " " + lst.Element("grq").LastAttribute.Value + "<br>";
                                        }
                                        else
                                        {
                                            ReferenceRange += lst.Element("grq").LastAttribute.Value + "<br>";
                                        }
                                    }
                                }
                                if (lst.Element("btw") != null)
                                {
                                    string[] between = lst.Element("btw").Value.Split('-');
                                    if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("btw").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("btw").Attribute("agetype").Value))
                                    {
                                        if (lst.Element("btw").Attribute("mode").Value != "ref")
                                        {
                                            ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("btw").FirstAttribute.Value)) + " " + lst.Element("btw").LastAttribute.Value + "<br>";
                                        }
                                        else
                                        {
                                            ReferenceRange += lst.Element("btw").LastAttribute.Value + "<br>";
                                        }
                                    }
                                }
                            }
                        }
                        else if (ageRangeBoth != null && ageRangeBoth.Count() > 0)
                        {
                            foreach (var lst in ageRangeBoth)
                            {
                                if (lst.Element("lst") != null)
                                {
                                    if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("lst").Value), lst.Element("lst").Attribute("agetype").Value))
                                    {
                                        if (lst.Element("lst").Attribute("mode").Value != "ref")
                                        {
                                            ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("lst").FirstAttribute.Value)) + " " + lst.Element("lst").LastAttribute.Value + "<br>";
                                        }
                                        else
                                        {
                                            ReferenceRange += lst.Element("lst").LastAttribute.Value + "<br>";
                                        }
                                    }
                                }

                                if (lst.Element("lsq") != null)
                                {
                                    if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("lsq").Value), lst.Element("lsq").Attribute("agetype").Value))
                                    {
                                        if (lst.Element("lsq").Attribute("mode").Value != "ref")
                                        {
                                            ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("lsq").FirstAttribute.Value)) + " " + lst.Element("lsq").LastAttribute.Value + "<br>";
                                        }
                                        else
                                        {
                                            ReferenceRange += lst.Element("lsq").LastAttribute.Value + "<br>";
                                        }
                                    }
                                }

                                if (lst.Element("eql") != null)
                                {
                                    if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("eql").Value), lst.Element("eql").Attribute("agetype").Value))
                                    {
                                        if (lst.Element("eql").Attribute("mode").Value != "ref")
                                        {
                                            ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("eql").FirstAttribute.Value)) + " " + lst.Element("eql").LastAttribute.Value + "<br>";
                                        }
                                        else
                                        {
                                            ReferenceRange += lst.Element("eql").LastAttribute.Value + "<br>";
                                        }
                                    }
                                }

                                if (lst.Element("grt") != null)
                                {
                                    if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("grt").Value), lst.Element("grt").Attribute("agetype").Value))
                                    {
                                        if (lst.Element("grt").Attribute("mode").Value != "ref")
                                        {
                                            ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("grt").FirstAttribute.Value)) + " " + lst.Element("grt").LastAttribute.Value + "<br>";
                                        }
                                        else
                                        {
                                            ReferenceRange += lst.Element("grt").LastAttribute.Value + "<br>";
                                        }
                                    }
                                }

                                if (lst.Element("grq") != null)
                                {
                                    if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("grq").Value), lst.Element("grq").Attribute("agetype").Value))
                                    {
                                        if (lst.Element("grq").Attribute("mode").Value != "ref")
                                        {
                                            ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("grq").FirstAttribute.Value)) + " " + lst.Element("grq").LastAttribute.Value + "<br>";
                                        }
                                        else
                                        {
                                            ReferenceRange += lst.Element("grq").LastAttribute.Value + "<br>";
                                        }
                                    }
                                }

                                if (lst.Element("btw") != null)
                                {
                                    string[] between = lst.Element("btw").Value.Split('-');
                                    if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("btw").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("btw").Attribute("agetype").Value))
                                    {
                                        if (lst.Element("btw").Attribute("mode").Value != "ref")
                                        {
                                            ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("btw").FirstAttribute.Value)) + " " + lst.Element("btw").LastAttribute.Value + "<br>";
                                        }
                                        else
                                        {
                                            ReferenceRange += lst.Element("btw").LastAttribute.Value + "<br>";
                                        }
                                    }
                                }
                            }
                        }
                        else if (commonRange != null && commonRange.Count() > 0)
                        {
                            foreach (var lst in commonRange)
                            {
                                if (lst.Element("lst") != null)
                                {
                                    ReferenceRange += " < " + lst.Element("lst").Value + "<br>";
                                }
                                if (lst.Element("lsq") != null)
                                {
                                    ReferenceRange += " <= " + lst.Element("lsq").Value + "<br>";
                                }
                                if (lst.Element("eql") != null)
                                {
                                    ReferenceRange += " = " + lst.Element("eql").Value + "<br>";
                                }
                                if (lst.Element("grt") != null)
                                {
                                    ReferenceRange += " > " + lst.Element("grt").Value + "<br>";
                                }
                                if (lst.Element("grq") != null)
                                {
                                    ReferenceRange += " => " + lst.Element("grq").Value + "<br>";
                                }
                                if (lst.Element("btw") != null)
                                {
                                    ReferenceRange += "" + lst.Element("btw").Value + "<br>";
                                }
                                if (lst.Element("ref") != null)
                                {
                                    ReferenceRange += lst.Element("ref").Value + "<br>";
                                }
                            }
                        }
                        else if (commonRangeBoth != null && commonRangeBoth.Count() > 0)
                        {
                            foreach (var lst in commonRangeBoth)
                            {
                                if (lst.Element("lst") != null)
                                {
                                    ReferenceRange += " < " + lst.Element("lst").Value + "<br>";
                                }
                                if (lst.Element("lsq") != null)
                                {
                                    ReferenceRange += " <= " + lst.Element("lsq").Value + "<br>";
                                }
                                if (lst.Element("eql") != null)
                                {
                                    ReferenceRange += " = " + lst.Element("eql").Value + "<br>";
                                }
                                if (lst.Element("grt") != null)
                                {
                                    ReferenceRange += " > " + lst.Element("grt").Value + "<br>";
                                }
                                if (lst.Element("grq") != null)
                                {
                                    ReferenceRange += " => " + lst.Element("grq").Value + "<br>";
                                }
                                if (lst.Element("btw") != null)
                                {
                                    ReferenceRange += "" + lst.Element("btw").Value + "<br>";
                                }
                                if (lst.Element("ref") != null)
                                {
                                    ReferenceRange += lst.Element("ref").Value + "<br>";
                                }
                            }
                        }
                        if ((otherRange != null && otherRange.Count() > 0) || (otherRangeText != null && otherRangeText.Count() > 0) || (otherRangeWithAge != null && otherRangeWithAge.Count() > 0) || (otherRangeTextWithAge != null && otherRangeTextWithAge.Count() > 0))
                        {
                            if (otherRangeWithAge != null && otherRangeWithAge.Count() > 0)
                            {
                                foreach (var lst in otherRangeWithAge)
                                {
                                    if (lst.Element("lst") != null)
                                    {
                                        if (lst.Element("lst").Attribute("ageopr").Value == "lst")
                                        {
                                            if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lst").Value + ": < " + lst.Element("lst").Attribute("value").Value + "<br>";
                                                if (lst.Element("lst").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " < " + lst.Element("lst").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("lst").Attribute("ageopr").Value == "lsq")
                                        {
                                            if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lst").Value + ": < " + lst.Element("lst").Attribute("value").Value + "<br>";
                                                if (lst.Element("lst").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " < " + lst.Element("lst").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("lst").Attribute("ageopr").Value == "eql")
                                        {
                                            if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lst").Value + ": < " + lst.Element("lst").Attribute("value").Value + "<br>";
                                                if (lst.Element("lst").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " < " + lst.Element("lst").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("lst").Attribute("ageopr").Value == "grt")
                                        {
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lst").Value + ": < " + lst.Element("lst").Attribute("value").Value + "<br>";
                                                if (lst.Element("lst").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " < " + lst.Element("lst").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("lst").Attribute("ageopr").Value == "grq")
                                        {
                                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lst").Value + ": < " + lst.Element("lst").Attribute("value").Value + "<br>";
                                                if (lst.Element("lst").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " < " + lst.Element("lst").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("lst").Attribute("ageopr").Value == "btw")
                                        {
                                            string[] between = lst.Element("lst").Attribute("agerange").Value.Split('-');
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("lst").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("lst").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lst").Value + ": < " + lst.Element("lst").Attribute("value").Value + "<br>";
                                                if (lst.Element("lst").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " < " + lst.Element("lst").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                    }
                                    if (lst.Element("lsq") != null)
                                    {
                                        if (lst.Element("lsq").Attribute("ageopr").Value == "lst")
                                        {
                                            if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("lsq").Attribute("agerange").Value), lst.Element("lsq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lsq").Value + ": <= " + lst.Element("lsq").Attribute("value").Value + "<br>";
                                                if (lst.Element("lsq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " <= " + lst.Element("lsq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("lsq").Attribute("ageopr").Value == "lsq")
                                        {
                                            if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("lsq").Attribute("agerange").Value), lst.Element("lsq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lsq").Value + ": <= " + lst.Element("lsq").Attribute("value").Value + "<br>";
                                                if (lst.Element("lsq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " <= " + lst.Element("lsq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("lsq").Attribute("ageopr").Value == "eql")
                                        {
                                            if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("lsq").Attribute("agerange").Value), lst.Element("lsq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lsq").Value + ": <= " + lst.Element("lsq").Attribute("value").Value + "<br>";
                                                if (lst.Element("lsq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " <= " + lst.Element("lsq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("lsq").Attribute("ageopr").Value == "grt")
                                        {
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("lsq").Attribute("agerange").Value), lst.Element("lsq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lsq").Value + ": <= " + lst.Element("lsq").Attribute("value").Value + "<br>";
                                                if (lst.Element("lsq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " <= " + lst.Element("lsq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("lsq").Attribute("ageopr").Value == "grq")
                                        {
                                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("lsq").Attribute("agerange").Value), lst.Element("lsq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lsq").Value + ": <= " + lst.Element("lsq").Attribute("value").Value + "<br>";
                                                if (lst.Element("lsq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " <= " + lst.Element("lsq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("lsq").Attribute("ageopr").Value == "btw")
                                        {
                                            string[] between = lst.Element("lsq").Attribute("agerange").Value.Split('-');
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("lsq").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("lsq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lsq").Value + ": <= " + lst.Element("lsq").Attribute("value").Value + "<br>";
                                                if (lst.Element("lsq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " <= " + lst.Element("lsq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                    }

                                    if (lst.Element("eql") != null)
                                    {
                                        if (lst.Element("eql").Attribute("ageopr").Value == "lst")
                                        {
                                            if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("eql").Value + ": = " + lst.Element("eql").Attribute("value").Value + "<br>";
                                                if (lst.Element("eql").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " = " + lst.Element("eql").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("eql").Attribute("ageopr").Value == "lsq")
                                        {
                                            if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("eql").Value + ": = " + lst.Element("eql").Attribute("value").Value + "<br>";
                                                if (lst.Element("eql").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " = " + lst.Element("eql").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("eql").Attribute("ageopr").Value == "eql")
                                        {
                                            if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("eql").Value + ": = " + lst.Element("eql").Attribute("value").Value + "<br>";
                                                if (lst.Element("eql").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " = " + lst.Element("eql").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("eql").Attribute("ageopr").Value == "grt")
                                        {
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("eql").Value + ": = " + lst.Element("eql").Attribute("value").Value + "<br>";
                                                if (lst.Element("eql").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " = " + lst.Element("eql").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("eql").Attribute("ageopr").Value == "grq")
                                        {
                                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("eql").Value + ": = " + lst.Element("eql").Attribute("value").Value + "<br>";
                                                if (lst.Element("eql").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " = " + lst.Element("eql").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("eql").Attribute("ageopr").Value == "btw")
                                        {
                                            string[] between = lst.Element("eql").Attribute("agerange").Value.Split('-');
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("eql").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("eql").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("eql").Value + ": = " + lst.Element("eql").Attribute("value").Value + "<br>";
                                                if (lst.Element("eql").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " = " + lst.Element("eql").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                    }

                                    if (lst.Element("grt") != null)
                                    {
                                        if (lst.Element("grt").Attribute("ageopr").Value == "lst")
                                        {
                                            if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grt").Value + ": > " + lst.Element("grt").Attribute("value").Value + "<br>";
                                                if (lst.Element("grt").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += "> " + lst.Element("grt").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("grt").Attribute("ageopr").Value == "lsq")
                                        {
                                            if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grt").Value + ": > " + lst.Element("grt").Attribute("value").Value + "<br>";
                                                if (lst.Element("grt").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += "> " + lst.Element("grt").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("grt").Attribute("ageopr").Value == "eql")
                                        {
                                            if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grt").Value + ": > " + lst.Element("grt").Attribute("value").Value + "<br>";
                                                if (lst.Element("grt").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += "> " + lst.Element("grt").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("grt").Attribute("ageopr").Value == "grt")
                                        {
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grt").Value + ": > " + lst.Element("grt").Attribute("value").Value + "<br>";
                                                if (lst.Element("grt").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += "> " + lst.Element("grt").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("grt").Attribute("ageopr").Value == "grq")
                                        {
                                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grt").Value + ": > " + lst.Element("grt").Attribute("value").Value + "<br>";
                                                if (lst.Element("grt").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += "> " + lst.Element("grt").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("grt").Attribute("ageopr").Value == "btw")
                                        {
                                            string[] between = lst.Element("grt").Attribute("agerange").Value.Split('-');
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("grt").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("grt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grt").Value + ": > " + lst.Element("grt").Attribute("value").Value + "<br>";
                                                if (lst.Element("grt").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += "> " + lst.Element("grt").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                    }

                                    if (lst.Element("grq") != null)
                                    {
                                        if (lst.Element("grq").Attribute("ageopr").Value == "lst")
                                        {
                                            if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grq").Value + ": >= " + lst.Element("grq").Attribute("value").Value + "<br>";
                                                if (lst.Element("grq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " >= " + lst.Element("grq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("grq").Attribute("ageopr").Value == "lsq")
                                        {
                                            if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grq").Value + ": >= " + lst.Element("grq").Attribute("value").Value + "<br>";
                                                if (lst.Element("grq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " >= " + lst.Element("grq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("grq").Attribute("ageopr").Value == "eql")
                                        {
                                            if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grq").Value + ": >= " + lst.Element("grq").Attribute("value").Value + "<br>";
                                                if (lst.Element("grq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " >= " + lst.Element("grq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("grq").Attribute("ageopr").Value == "grt")
                                        {
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grq").Value + ": >= " + lst.Element("grq").Attribute("value").Value + "<br>";
                                                if (lst.Element("grq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " >= " + lst.Element("grq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("grq").Attribute("ageopr").Value == "grq")
                                        {
                                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grq").Value + ": >= " + lst.Element("grq").Attribute("value").Value + "<br>";
                                                if (lst.Element("grq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " >= " + lst.Element("grq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("grq").Attribute("ageopr").Value == "btw")
                                        {
                                            string[] between = lst.Element("grq").Attribute("agerange").Value.Split('-');
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("grq").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("grq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grq").Value + ": >= " + lst.Element("grq").Attribute("value").Value + "<br>";
                                                if (lst.Element("grq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " >= " + lst.Element("grq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                    }

                                    if (lst.Element("btw") != null)
                                    {
                                        if (lst.Element("btw").Attribute("ageopr").Value == "lst")
                                        {
                                            if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("btw").Value + ": " + lst.Element("btw").Attribute("value").Value + "<br>";
                                                if (lst.Element("btw").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " " + lst.Element("btw").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("btw").Attribute("ageopr").Value == "lsq")
                                        {
                                            if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("btw").Value + ": " + lst.Element("btw").Attribute("value").Value + "<br>";
                                                if (lst.Element("btw").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " " + lst.Element("btw").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("btw").Attribute("ageopr").Value == "eql")
                                        {
                                            if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("btw").Value + ": " + lst.Element("btw").Attribute("value").Value + "<br>";
                                                if (lst.Element("btw").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " " + lst.Element("btw").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("btw").Attribute("ageopr").Value == "grt")
                                        {
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("btw").Value + ": " + lst.Element("btw").Attribute("value").Value + "<br>";
                                                if (lst.Element("btw").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " " + lst.Element("btw").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("btw").Attribute("ageopr").Value == "grq")
                                        {
                                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("btw").Value + ": " + lst.Element("btw").Attribute("value").Value + "<br>";
                                                if (lst.Element("btw").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " " + lst.Element("btw").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("btw").Attribute("ageopr").Value == "btw")
                                        {
                                            string[] between = lst.Element("btw").Attribute("agerange").Value.Split('-');
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("btw").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("btw").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("btw").Value + ": " + lst.Element("btw").Attribute("value").Value + "<br>";
                                                if (lst.Element("btw").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " " + lst.Element("btw").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                    }
                                    if (lst.Element("ref") != null)
                                    {
                                        if (lst.Element("ref").Attribute("ageopr").Value == "lst")
                                        {
                                            if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("ref").Attribute("agerange").Value), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("ref").Attribute("ageopr").Value == "lsq")
                                        {
                                            if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("ref").Attribute("agerange").Value), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("ref").Attribute("ageopr").Value == "eql")
                                        {
                                            if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("ref").Attribute("agerange").Value), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("ref").Attribute("ageopr").Value == "grt")
                                        {
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("ref").Attribute("agerange").Value), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("ref").Attribute("ageopr").Value == "grq")
                                        {
                                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("ref").Attribute("agerange").Value), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("ref").Attribute("ageopr").Value == "btw")
                                        {
                                            string[] between = lst.Element("ref").Attribute("agerange").Value.Split('-');
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("ref").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                    }
                                }
                            }
                            if (otherRangeTextWithAge != null && otherRangeTextWithAge.Count() > 0)
                            {
                                foreach (var lst in otherRangeTextWithAge)
                                {
                                    if (lst.Element("txt") != null)
                                    {
                                        if (lst.Element("txt").Attribute("ageopr").Value == "lst")
                                        {
                                            if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("txt").Attribute("agerange").Value), lst.Element("txt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("txt").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("txt").Attribute("ageopr").Value == "lsq")
                                        {
                                            if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("txt").Attribute("agerange").Value), lst.Element("txt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("txt").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("txt").Attribute("ageopr").Value == "eql")
                                        {
                                            if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("txt").Attribute("agerange").Value), lst.Element("txt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("txt").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("txt").Attribute("ageopr").Value == "grt")
                                        {
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("txt").Attribute("agerange").Value), lst.Element("txt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("txt").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("txt").Attribute("ageopr").Value == "grq")
                                        {
                                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("txt").Attribute("agerange").Value), lst.Element("txt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("txt").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("txt").Attribute("ageopr").Value == "btw")
                                        {
                                            string[] between = lst.Element("txt").Attribute("agerange").Value.Split('-');
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("txt").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("txt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("txt").Value + "<br>";
                                            }
                                        }
                                    }
                                    if (lst.Element("ref") != null)
                                    {
                                        if (lst.Element("ref").Attribute("ageopr").Value == "lst")
                                        {
                                            if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("ref").Attribute("agerange").Value), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("ref").Attribute("ageopr").Value == "lsq")
                                        {
                                            if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("ref").Attribute("agerange").Value), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("ref").Attribute("ageopr").Value == "eql")
                                        {
                                            if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("ref").Attribute("agerange").Value), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("ref").Attribute("ageopr").Value == "grt")
                                        {
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("ref").Attribute("agerange").Value), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("ref").Attribute("ageopr").Value == "grq")
                                        {
                                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("ref").Attribute("agerange").Value), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("ref").Attribute("ageopr").Value == "btw")
                                        {
                                            string[] between = lst.Element("ref").Attribute("agerange").Value.Split('-');
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("ref").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                    }
                                }
                            }
                            if (otherRange != null && otherRange.Count() > 0)
                            {
                                foreach (var lst in otherRange)
                                {
                                    if (lst.Element("lst") != null)
                                    {
                                        ReferenceRange += lst.Element("lst").Value + ": < " + lst.Element("lst").Attribute("value").Value + "<br>";
                                        if (lst.Element("lst").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += " < " + lst.Element("lst").Attribute("ConvReferencevalue").Value + "<br>";
                                        }
                                    }
                                    if (lst.Element("lsq") != null)
                                    {
                                        ReferenceRange += lst.Element("lsq").Value + ": <= " + lst.Element("lsq").Attribute("value").Value + "<br>";
                                        if (lst.Element("lsq").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += " <= " + lst.Element("lsq").Attribute("ConvReferencevalue").Value + "<br>";
                                        }
                                    }

                                    if (lst.Element("eql") != null)
                                    {
                                        ReferenceRange += lst.Element("eql").Value + ": = " + lst.Element("eql").Attribute("value").Value + "<br>";
                                        if (lst.Element("eql").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += " = " + lst.Element("eql").Attribute("ConvReferencevalue").Value + "<br>";
                                        }
                                    }

                                    if (lst.Element("grt") != null)
                                    {
                                        ReferenceRange += lst.Element("grt").Value + ": > " + lst.Element("grt").Attribute("value").Value + "<br>";
                                        if (lst.Element("grt").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += "> " + lst.Element("grt").Attribute("ConvReferencevalue").Value + "<br>";
                                        }
                                    }


                                    if (lst.Element("grq") != null)
                                    {
                                        ReferenceRange += lst.Element("grq").Value + ": >= " + lst.Element("grq").Attribute("value").Value + "<br>";
                                        if (lst.Element("grq").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += " >= " + lst.Element("grq").Attribute("ConvReferencevalue").Value + "<br>";
                                        }
                                    }

                                    if (lst.Element("btw") != null)
                                    {
                                        ReferenceRange += lst.Element("btw").Value + ": " + lst.Element("btw").Attribute("value").Value + "<br>";
                                        if (lst.Element("btw").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += " " + lst.Element("btw").Attribute("ConvReferencevalue").Value + "<br>";
                                        }
                                    }
                                    if (lst.Element("ref") != null)
                                    {
                                        ReferenceRange += lst.Element("ref").Value + "<br>";
                                    }
                                }
                            }
                            if (otherRangeText != null && otherRangeText.Count() > 0)
                            {
                                foreach (var lst in otherRangeText)
                                {
                                    if (lst.Element("txt") != null)
                                    {
                                        ReferenceRange += lst.Element("txt").Value + "<br>";
                                    }
                                    if (lst.Element("ref") != null)
                                    {
                                        ReferenceRange += lst.Element("ref").Value + "<br>";
                                    }
                                }
                            }
                        }
                        else if ((otherRangeBoth != null && otherRangeBoth.Count() > 0) || (otherRangeBothText != null && otherRangeBothText.Count() > 0) || (otherRangeBothWithAge != null && otherRangeBothWithAge.Count() > 0) || (otherRangeBothTextWithAge != null && otherRangeBothTextWithAge.Count() > 0))
                        {
                            if (otherRangeBothWithAge != null && otherRangeBothWithAge.Count() > 0)
                            {
                                foreach (var lst in otherRangeBothWithAge)
                                {
                                    if (lst.Element("lst") != null)
                                    {
                                        if (lst.Element("lst").Attribute("ageopr").Value == "lst")
                                        {
                                            if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lst").Value + ": < " + lst.Element("lst").Attribute("value").Value + "<br>";
                                                if (lst.Element("lst").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " < " + lst.Element("lst").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("lst").Attribute("ageopr").Value == "lsq")
                                        {
                                            if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lst").Value + ": < " + lst.Element("lst").Attribute("value").Value + "<br>";
                                                if (lst.Element("lst").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " < " + lst.Element("lst").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("lst").Attribute("ageopr").Value == "eql")
                                        {
                                            if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lst").Value + ": < " + lst.Element("lst").Attribute("value").Value + "<br>";
                                                if (lst.Element("lst").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " < " + lst.Element("lst").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("lst").Attribute("ageopr").Value == "grt")
                                        {
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lst").Value + ": < " + lst.Element("lst").Attribute("value").Value + "<br>";
                                                if (lst.Element("lst").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " < " + lst.Element("lst").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("lst").Attribute("ageopr").Value == "grq")
                                        {
                                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("lst").Attribute("agerange").Value), lst.Element("lst").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lst").Value + ": < " + lst.Element("lst").Attribute("value").Value + "<br>";
                                                if (lst.Element("lst").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " < " + lst.Element("lst").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("lst").Attribute("ageopr").Value == "btw")
                                        {
                                            string[] between = lst.Element("lst").Attribute("agerange").Value.Split('-');
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("lst").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("lst").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lst").Value + ": < " + lst.Element("lst").Attribute("value").Value + "<br>";
                                                if (lst.Element("lst").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " < " + lst.Element("lst").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                    }
                                    if (lst.Element("lsq") != null)
                                    {
                                        if (lst.Element("lsq").Attribute("ageopr").Value == "lst")
                                        {
                                            if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("lsq").Attribute("agerange").Value), lst.Element("lsq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lsq").Value + ": <= " + lst.Element("lsq").Attribute("value").Value + "<br>";
                                                if (lst.Element("lsq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " <= " + lst.Element("lsq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("lsq").Attribute("ageopr").Value == "lsq")
                                        {
                                            if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("lsq").Attribute("agerange").Value), lst.Element("lsq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lsq").Value + ": <= " + lst.Element("lsq").Attribute("value").Value + "<br>";
                                                if (lst.Element("lsq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " <= " + lst.Element("lsq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("lsq").Attribute("ageopr").Value == "eql")
                                        {
                                            if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("lsq").Attribute("agerange").Value), lst.Element("lsq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lsq").Value + ": <= " + lst.Element("lsq").Attribute("value").Value + "<br>";
                                                if (lst.Element("lsq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " <= " + lst.Element("lsq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("lsq").Attribute("ageopr").Value == "grt")
                                        {
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("lsq").Attribute("agerange").Value), lst.Element("lsq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lsq").Value + ": <= " + lst.Element("lsq").Attribute("value").Value + "<br>";
                                                if (lst.Element("lsq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " <= " + lst.Element("lsq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("lsq").Attribute("ageopr").Value == "grq")
                                        {
                                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("lsq").Attribute("agerange").Value), lst.Element("lsq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lsq").Value + ": <= " + lst.Element("lsq").Attribute("value").Value + "<br>";
                                                if (lst.Element("lsq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " <= " + lst.Element("lsq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("lsq").Attribute("ageopr").Value == "btw")
                                        {
                                            string[] between = lst.Element("lsq").Attribute("agerange").Value.Split('-');
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("lsq").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("lsq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("lsq").Value + ": <= " + lst.Element("lsq").Attribute("value").Value + "<br>";
                                                if (lst.Element("lsq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " <= " + lst.Element("lsq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                    }

                                    if (lst.Element("eql") != null)
                                    {
                                        if (lst.Element("eql").Attribute("ageopr").Value == "lst")
                                        {
                                            if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("eql").Value + ": = " + lst.Element("eql").Attribute("value").Value + "<br>";
                                                if (lst.Element("eql").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " = " + lst.Element("eql").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("eql").Attribute("ageopr").Value == "lsq")
                                        {
                                            if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("eql").Value + ": = " + lst.Element("eql").Attribute("value").Value + "<br>";
                                                if (lst.Element("eql").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " = " + lst.Element("eql").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("eql").Attribute("ageopr").Value == "eql")
                                        {
                                            if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("eql").Value + ": = " + lst.Element("eql").Attribute("value").Value + "<br>";
                                                if (lst.Element("eql").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " = " + lst.Element("eql").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("eql").Attribute("ageopr").Value == "grt")
                                        {
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("eql").Value + ": = " + lst.Element("eql").Attribute("value").Value + "<br>";
                                                if (lst.Element("eql").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " = " + lst.Element("eql").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("eql").Attribute("ageopr").Value == "grq")
                                        {
                                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("eql").Attribute("agerange").Value), lst.Element("eql").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("eql").Value + ": = " + lst.Element("eql").Attribute("value").Value + "<br>";
                                                if (lst.Element("eql").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " = " + lst.Element("eql").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("eql").Attribute("ageopr").Value == "btw")
                                        {
                                            string[] between = lst.Element("eql").Attribute("agerange").Value.Split('-');
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("eql").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("eql").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("eql").Value + ": = " + lst.Element("eql").Attribute("value").Value + "<br>";
                                                if (lst.Element("eql").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " = " + lst.Element("eql").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                    }

                                    if (lst.Element("grt") != null)
                                    {
                                        if (lst.Element("grt").Attribute("ageopr").Value == "lst")
                                        {
                                            if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grt").Value + ": > " + lst.Element("grt").Attribute("value").Value + "<br>";
                                                if (lst.Element("grt").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += "> " + lst.Element("grt").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("grt").Attribute("ageopr").Value == "lsq")
                                        {
                                            if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grt").Value + ": > " + lst.Element("grt").Attribute("value").Value + "<br>";
                                                if (lst.Element("grt").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += "> " + lst.Element("grt").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("grt").Attribute("ageopr").Value == "eql")
                                        {
                                            if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grt").Value + ": > " + lst.Element("grt").Attribute("value").Value + "<br>";
                                                if (lst.Element("grt").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += "> " + lst.Element("grt").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("grt").Attribute("ageopr").Value == "grt")
                                        {
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grt").Value + ": > " + lst.Element("grt").Attribute("value").Value + "<br>";
                                                if (lst.Element("grt").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += "> " + lst.Element("grt").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("grt").Attribute("ageopr").Value == "grq")
                                        {
                                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("grt").Attribute("agerange").Value), lst.Element("grt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grt").Value + ": > " + lst.Element("grt").Attribute("value").Value + "<br>";
                                                if (lst.Element("grt").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += "> " + lst.Element("grt").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("grt").Attribute("ageopr").Value == "btw")
                                        {
                                            string[] between = lst.Element("grt").Attribute("agerange").Value.Split('-');
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("grt").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("grt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grt").Value + ": > " + lst.Element("grt").Attribute("value").Value + "<br>";
                                                if (lst.Element("grt").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += "> " + lst.Element("grt").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                    }

                                    if (lst.Element("grq") != null)
                                    {
                                        if (lst.Element("grq").Attribute("ageopr").Value == "lst")
                                        {
                                            if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grq").Value + ": >= " + lst.Element("grq").Attribute("value").Value + "<br>";
                                                if (lst.Element("grq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " >= " + lst.Element("grq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("grq").Attribute("ageopr").Value == "lsq")
                                        {
                                            if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grq").Value + ": >= " + lst.Element("grq").Attribute("value").Value + "<br>";
                                                if (lst.Element("grq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " >= " + lst.Element("grq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("grq").Attribute("ageopr").Value == "eql")
                                        {
                                            if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grq").Value + ": >= " + lst.Element("grq").Attribute("value").Value + "<br>";
                                                if (lst.Element("grq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " >= " + lst.Element("grq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("grq").Attribute("ageopr").Value == "grt")
                                        {
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grq").Value + ": >= " + lst.Element("grq").Attribute("value").Value + "<br>";
                                                if (lst.Element("grq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " >= " + lst.Element("grq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("grq").Attribute("ageopr").Value == "grq")
                                        {
                                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("grq").Attribute("agerange").Value), lst.Element("grq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grq").Value + ": >= " + lst.Element("grq").Attribute("value").Value + "<br>";
                                                if (lst.Element("grq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " >= " + lst.Element("grq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("grq").Attribute("ageopr").Value == "btw")
                                        {
                                            string[] between = lst.Element("grq").Attribute("agerange").Value.Split('-');
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("grq").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("grq").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("grq").Value + ": >= " + lst.Element("grq").Attribute("value").Value + "<br>";
                                                if (lst.Element("grq").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " >= " + lst.Element("grq").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                    }

                                    if (lst.Element("btw") != null)
                                    {
                                        if (lst.Element("btw").Attribute("ageopr").Value == "lst")
                                        {
                                            if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("btw").Value + ": " + lst.Element("btw").Attribute("value").Value + "<br>";
                                                if (lst.Element("btw").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " " + lst.Element("btw").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("btw").Attribute("ageopr").Value == "lsq")
                                        {
                                            if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("btw").Value + ": " + lst.Element("btw").Attribute("value").Value + "<br>";
                                                if (lst.Element("btw").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " " + lst.Element("btw").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("btw").Attribute("ageopr").Value == "eql")
                                        {
                                            if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("btw").Value + ": " + lst.Element("btw").Attribute("value").Value + "<br>";
                                                if (lst.Element("btw").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " " + lst.Element("btw").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("btw").Attribute("ageopr").Value == "grt")
                                        {
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("btw").Value + ": " + lst.Element("btw").Attribute("value").Value + "<br>";
                                                if (lst.Element("btw").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " " + lst.Element("btw").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("btw").Attribute("ageopr").Value == "grq")
                                        {
                                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("btw").Attribute("agerange").Value), lst.Element("btw").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("btw").Value + ": " + lst.Element("btw").Attribute("value").Value + "<br>";
                                                if (lst.Element("btw").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " " + lst.Element("btw").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                        else if (lst.Element("btw").Attribute("ageopr").Value == "btw")
                                        {
                                            string[] between = lst.Element("btw").Attribute("agerange").Value.Split('-');
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("btw").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("btw").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("btw").Value + ": " + lst.Element("btw").Attribute("value").Value + "<br>";
                                                if (lst.Element("btw").LastAttribute.Name == "ConvReferencevalue")
                                                {
                                                    OtherReferenceRange += " " + lst.Element("btw").Attribute("ConvReferencevalue").Value + "<br>";
                                                }
                                            }
                                        }
                                    }
                                    if (lst.Element("ref") != null)
                                    {
                                        if (lst.Element("ref").Attribute("ageopr").Value == "lst")
                                        {
                                            if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("ref").Attribute("agerange").Value), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("ref").Attribute("ageopr").Value == "lsq")
                                        {
                                            if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("ref").Attribute("agerange").Value), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("ref").Attribute("ageopr").Value == "eql")
                                        {
                                            if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("ref").Attribute("agerange").Value), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("ref").Attribute("ageopr").Value == "grt")
                                        {
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("ref").Attribute("agerange").Value), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("ref").Attribute("ageopr").Value == "grq")
                                        {
                                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("ref").Attribute("agerange").Value), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("ref").Attribute("ageopr").Value == "btw")
                                        {
                                            string[] between = lst.Element("ref").Attribute("agerange").Value.Split('-');
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("ref").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                    }
                                }
                            }
                            if (otherRangeBothTextWithAge != null && otherRangeBothTextWithAge.Count() > 0)
                            {
                                foreach (var lst in otherRangeBothTextWithAge)
                                {
                                    if (lst.Element("txt") != null)
                                    {
                                        if (lst.Element("txt").Attribute("ageopr").Value == "lst")
                                        {
                                            if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("txt").Attribute("agerange").Value), lst.Element("txt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("txt").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("txt").Attribute("ageopr").Value == "lsq")
                                        {
                                            if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("txt").Attribute("agerange").Value), lst.Element("txt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("txt").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("txt").Attribute("ageopr").Value == "eql")
                                        {
                                            if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("txt").Attribute("agerange").Value), lst.Element("txt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("txt").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("txt").Attribute("ageopr").Value == "grt")
                                        {
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("txt").Attribute("agerange").Value), lst.Element("txt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("txt").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("txt").Attribute("ageopr").Value == "grq")
                                        {
                                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("txt").Attribute("agerange").Value), lst.Element("txt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("txt").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("txt").Attribute("ageopr").Value == "btw")
                                        {
                                            string[] between = lst.Element("txt").Attribute("agerange").Value.Split('-');
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("txt").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("txt").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("txt").Value + "<br>";
                                            }
                                        }
                                    }
                                    if (lst.Element("ref") != null)
                                    {
                                        if (lst.Element("ref").Attribute("ageopr").Value == "lst")
                                        {
                                            if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("ref").Attribute("agerange").Value), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("ref").Attribute("ageopr").Value == "lsq")
                                        {
                                            if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("ref").Attribute("agerange").Value), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("ref").Attribute("ageopr").Value == "eql")
                                        {
                                            if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("ref").Attribute("agerange").Value), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("ref").Attribute("ageopr").Value == "grt")
                                        {
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("ref").Attribute("agerange").Value), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("ref").Attribute("ageopr").Value == "grq")
                                        {
                                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("ref").Attribute("agerange").Value), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                        else if (lst.Element("ref").Attribute("ageopr").Value == "btw")
                                        {
                                            string[] between = lst.Element("ref").Attribute("agerange").Value.Split('-');
                                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(between[0]), lst.Element("ref").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("ref").Attribute("agetype").Value))
                                            {
                                                ReferenceRange += lst.Element("ref").Value + "<br>";
                                            }
                                        }
                                    }
                                }
                            }
                            if (otherRangeBoth != null && otherRangeBoth.Count() > 0)
                            {
                                foreach (var lst in otherRangeBoth)
                                {
                                    if (lst.Element("lst") != null)
                                    {
                                        ReferenceRange += lst.Element("lst").Value + ": < " + lst.Element("lst").Attribute("value").Value + "<br>";
                                        if (lst.Element("lst").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += " < " + lst.Element("lst").Attribute("ConvReferencevalue").Value + "<br>";
                                        }
                                    }
                                    if (lst.Element("lsq") != null)
                                    {
                                        ReferenceRange += lst.Element("lsq").Value + ": <= " + lst.Element("lsq").Attribute("value").Value + "<br>";
                                        if (lst.Element("lsq").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += " <= " + lst.Element("lsq").Attribute("ConvReferencevalue").Value + "<br>";
                                        }
                                    }

                                    if (lst.Element("eql") != null)
                                    {
                                        ReferenceRange += lst.Element("eql").Value + ": = " + lst.Element("eql").Attribute("value").Value + "<br>";
                                        if (lst.Element("eql").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += " = " + lst.Element("eql").Attribute("ConvReferencevalue").Value + "<br>";
                                        }
                                    }

                                    if (lst.Element("grt") != null)
                                    {
                                        ReferenceRange += lst.Element("grt").Value + ": > " + lst.Element("grt").Attribute("value").Value + "<br>";
                                        if (lst.Element("grt").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += " > " + lst.Element("grt").Attribute("ConvReferencevalue").Value + "<br>";
                                        }
                                    }


                                    if (lst.Element("grq") != null)
                                    {
                                        ReferenceRange += lst.Element("grq").Value + ": >= " + lst.Element("grq").Attribute("value").Value + "<br>";
                                        if (lst.Element("grq").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += " >= " + lst.Element("grq").Attribute("ConvReferencevalue").Value + "<br>";
                                        }
                                    }

                                    if (lst.Element("btw") != null)
                                    {
                                        ReferenceRange += lst.Element("btw").Value + ": " + lst.Element("btw").Attribute("value").Value + "<br>";
                                        if (lst.Element("btw").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += " " + lst.Element("btw").Attribute("ConvReferencevalue").Value + "<br>";
                                        }
                                    }
                                    if (lst.Element("ref") != null)
                                    {
                                        ReferenceRange += lst.Element("ref").Value + "<br>";
                                    }
                                }
                            }

                            if (otherRangeBothText != null && otherRangeBothText.Count() > 0)
                            {
                                foreach (var lst in otherRangeBothText)
                                {
                                    if (lst.Element("txt") != null)
                                    {
                                        ReferenceRange += lst.Element("txt").Value + "<br>";
                                    }
                                    if (lst.Element("ref") != null)
                                    {
                                        ReferenceRange += lst.Element("ref").Value + "<br>";
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        if (commonRange != null && commonRange.Count() > 0)
                        {
                            foreach (var lst in commonRange)
                            {
                                if (lst.Element("lst") != null)
                                {
                                    ReferenceRange += " < " + lst.Element("lst").Value + "<br>";
                                }
                                if (lst.Element("lsq") != null)
                                {
                                    ReferenceRange += " <= " + lst.Element("lsq").Value + "<br>";
                                }
                                if (lst.Element("eql") != null)
                                {
                                    ReferenceRange += " = " + lst.Element("eql").Value + "<br>";
                                }
                                if (lst.Element("grt") != null)
                                {
                                    ReferenceRange += " > " + lst.Element("grt").Value + "<br>";
                                }
                                if (lst.Element("grq") != null)
                                {
                                    ReferenceRange += " => " + lst.Element("grq").Value + "<br>";
                                }
                                if (lst.Element("btw") != null)
                                {
                                    ReferenceRange += "" + lst.Element("btw").Value + "<br>";
                                }
                                if (lst.Element("ref") != null)
                                {
                                    ReferenceRange += lst.Element("ref").Value + "<br>";
                                }
                            }
                        }
                        else if (commonRangeBoth != null && commonRangeBoth.Count() > 0)
                        {
                            foreach (var lst in commonRangeBoth)
                            {
                                if (lst.Element("lst") != null)
                                {
                                    ReferenceRange += " < " + lst.Element("lst").Value + "<br>";
                                }
                                if (lst.Element("lsq") != null)
                                {
                                    ReferenceRange += " <= " + lst.Element("lsq").Value + "<br>";
                                }
                                if (lst.Element("eql") != null)
                                {
                                    ReferenceRange += " = " + lst.Element("eql").Value + "<br>";
                                }
                                if (lst.Element("grt") != null)
                                {
                                    ReferenceRange += " > " + lst.Element("grt").Value + "<br>";
                                }
                                if (lst.Element("grq") != null)
                                {
                                    ReferenceRange += " => " + lst.Element("grq").Value + "<br>";
                                }
                                if (lst.Element("btw") != null)
                                {
                                    ReferenceRange += "" + lst.Element("btw").Value + "<br>";
                                }
                                if (lst.Element("ref") != null)
                                {
                                    ReferenceRange += lst.Element("ref").Value + "<br>";
                                }
                            }
                        }
                        if ((otherRange != null && otherRange.Count() > 0) || (otherRangeText != null && otherRangeText.Count() > 0))
                        {
                            if (otherRange != null && otherRange.Count() > 0)
                            {
                                foreach (var lst in otherRange)
                                {
                                    if (lst.Element("lst") != null)
                                    {
                                        ReferenceRange += lst.Element("lst").Value + ": < " + lst.Element("lst").Attribute("value").Value + "<br>";
                                        if (lst.Element("lst").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += " < " + lst.Element("lst").Attribute("ConvReferencevalue").Value + "<br>";
                                        }
                                    }
                                    if (lst.Element("lsq") != null)
                                    {
                                        ReferenceRange += lst.Element("lsq").Value + ": <= " + lst.Element("lsq").Attribute("value").Value + "<br>";
                                        if (lst.Element("lsq").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += " <= " + lst.Element("lsq").Attribute("ConvReferencevalue").Value + "<br>";
                                        }
                                    }

                                    if (lst.Element("eql") != null)
                                    {
                                        ReferenceRange += lst.Element("eql").Value + ": = " + lst.Element("eql").Attribute("value").Value + "<br>";
                                        if (lst.Element("eql").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += " = " + lst.Element("eql").Attribute("ConvReferencevalue").Value + "<br>";
                                        }
                                    }

                                    if (lst.Element("grt") != null)
                                    {
                                        ReferenceRange += lst.Element("grt").Value + ": > " + lst.Element("grt").Attribute("value").Value + "<br>";
                                        if (lst.Element("grt").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += "> " + lst.Element("grt").Attribute("ConvReferencevalue").Value + "<br>";
                                            //lst.Element("grt").Value + ":
                                        }
                                    }


                                    if (lst.Element("grq") != null)
                                    {
                                        ReferenceRange += lst.Element("grq").Value + ": >= " + lst.Element("grq").Attribute("value").Value + "<br>";
                                        if (lst.Element("grq").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += " >= " + lst.Element("grq").Attribute("ConvReferencevalue").Value + "<br>";
                                        }
                                    }

                                    if (lst.Element("btw") != null)
                                    {
                                        ReferenceRange += lst.Element("btw").Value + ": " + lst.Element("btw").Attribute("value").Value + "<br>";
                                        if (lst.Element("btw").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += " " + lst.Element("btw").Attribute("ConvReferencevalue").Value + "<br>";
                                        }
                                    }
                                    if (lst.Element("ref") != null)
                                    {
                                        ReferenceRange += lst.Element("ref").Value + "<br>";
                                    }
                                }
                            }

                            if (otherRangeText != null && otherRangeText.Count() > 0)
                            {
                                foreach (var lst in otherRangeText)
                                {
                                    if (lst.Element("txt") != null)
                                    {
                                        ReferenceRange += lst.Element("txt").Value + "<br>";
                                    }
                                    if (lst.Element("ref") != null)
                                    {
                                        ReferenceRange += lst.Element("ref").Value + "<br>";
                                    }
                                }
                            }
                        }
                        else if ((otherRangeBoth != null && otherRangeBoth.Count() > 0) || (otherRangeBothText != null && otherRangeBothText.Count() > 0))
                        {
                            if (otherRangeBoth != null && otherRangeBoth.Count() > 0)
                            {
                                foreach (var lst in otherRangeBoth)
                                {
                                    if (lst.Element("lst") != null)
                                    {
                                        //ReferenceRange += lst.Element("lst").FirstAttribute.Value + " :  " + lst.Element("lst").Value + " < " + lst.Element("lst").LastAttribute.Value + " " + uom + "\n";
                                        ReferenceRange += lst.Element("lst").Value + ": < " + lst.Element("lst").Attribute("value").Value + "<br>";
                                        if (lst.Element("lst").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += " < " + lst.Element("lst").Attribute("ConvReferencevalue").Value + "<br>";
                                            //lst.Element("lst").Value + ":
                                        }
                                    }
                                    if (lst.Element("lsq") != null)
                                    {
                                        //ReferenceRange += lst.Element("lsq").FirstAttribute.Value + " :  " + lst.Element("lsq").Value + " <= " + lst.Element("lsq").LastAttribute.Value + " " + uom + "\n";
                                        ReferenceRange += lst.Element("lsq").Value + ": <= " + lst.Element("lsq").Attribute("value").Value + "<br>";
                                        if (lst.Element("lsq").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += " <= " + lst.Element("lsq").Attribute("ConvReferencevalue").Value + "<br>";
                                            //lst.Element("lsq").Value + ":
                                        }
                                    }

                                    if (lst.Element("eql") != null)
                                    {
                                        //ReferenceRange += lst.Element("eql").FirstAttribute.Value + " :  " + lst.Element("eql").Value + " = " + lst.Element("eql").LastAttribute.Value + " " + uom + "\n";
                                        ReferenceRange += lst.Element("eql").Value + ": = " + lst.Element("eql").Attribute("value").Value + "<br>";
                                        if (lst.Element("eql").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += " = " + lst.Element("eql").Attribute("ConvReferencevalue").Value + "<br>";
                                            //lst.Element("eql").Value + ":
                                        }
                                    }

                                    if (lst.Element("grt") != null)
                                    {
                                        //ReferenceRange += lst.Element("grt").FirstAttribute.Value + " :  " + lst.Element("grt").Value + " > " + lst.Element("grt").LastAttribute.Value + " " + uom + "\n";
                                        ReferenceRange += lst.Element("grt").Value + ": > " + lst.Element("grt").Attribute("value").Value + "<br>";
                                        if (lst.Element("grt").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += " > " + lst.Element("grt").Attribute("ConvReferencevalue").Value + "<br>";
                                            //lst.Element("grt").Value + ":
                                        }
                                    }


                                    if (lst.Element("grq") != null)
                                    {
                                        //ReferenceRange += lst.Element("grq").FirstAttribute.Value + " :  " + lst.Element("grq").Value + " >= " + lst.Element("grq").LastAttribute.Value + " " + uom + "\n";
                                        ReferenceRange += lst.Element("grq").Value + ": >= " + lst.Element("grq").Attribute("value").Value + "<br>";
                                        if (lst.Element("grq").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += " >= " + lst.Element("grq").Attribute("ConvReferencevalue").Value + "<br>";
                                            //lst.Element("grq").Value + ":
                                        }
                                    }

                                    if (lst.Element("btw") != null)
                                    {
                                        //ReferenceRange += lst.Element("btw").FirstAttribute.Value + " :  " + lst.Element("btw").Value + " Between " + lst.Element("btw").LastAttribute.Value + " " + uom + "\n";
                                        ReferenceRange += lst.Element("btw").Value + ": " + lst.Element("btw").Attribute("value").Value + "<br>";
                                        if (lst.Element("btw").LastAttribute.Name == "ConvReferencevalue")
                                        {
                                            OtherReferenceRange += " " + lst.Element("btw").Attribute("ConvReferencevalue").Value + "<br>";
                                            //lst.Element("btw").Value + ":
                                        }
                                    }
                                    if (lst.Element("ref") != null)
                                    {
                                        ReferenceRange += lst.Element("ref").Value + "<br>";
                                    }
                                }
                            }

                            if (otherRangeBothText != null && otherRangeBothText.Count() > 0)
                            {
                                foreach (var lst in otherRangeBothText)
                                {
                                    if (lst.Element("txt") != null)
                                    {
                                        ReferenceRange += lst.Element("txt").Value + "<br>";
                                    }
                                    if (lst.Element("ref") != null)
                                    {
                                        ReferenceRange += lst.Element("ref").Value + "<br>";
                                    }
                                }
                            }
                        }
                    }
                    if (ReferenceRange == "")
                    {
                        XElement xer = XElement.Parse(xmlData);

                        if (xe.Elements(oRangeType).Elements("property") != null)
                        {
                            string AllUom = string.Empty;
                            string AllReferenceRange = string.Empty;
                            ConvertXmlToShowAllRange(xmlData, oRangeType, out  AllReferenceRange, uom, pGender);
                            ReferenceRange = AllReferenceRange;
                        }
                        else
                        {
                            ReferenceRange = xmlData;
                        }
                    }
                }
                if (oRangeType == "referencerange")
                {
                    NormalReferenceRange = ReferenceRange;
                }
                else if (oRangeType == "printablerange")
                {
                    PrintableRange = ReferenceRange;
                }
            }
        }
        catch (Exception ex)
        {
            NormalReferenceRange = string.Empty;
            PrintableRange = string.Empty;
            CLogger.LogError("Error while parsing reference range xml", ex);
        }
    }

    public void ValidateInterpretationRange(string xmlData, string Gender, string Age, decimal deviceValue, string deviceID, out string result, out string resultType)
    {
        result = string.Empty;
        resultType = string.Empty;
        try
        {
            List<string> lstRangeType = new List<string>();
            lstRangeType.Add("resultsinterpretationrange");
            string pGender = string.Empty;
            pGender = !string.IsNullOrEmpty(Gender) && Gender != "0" ? ((Gender == "F" || Gender == "Female") ? "Female" : "Male") : string.Empty;
            string[] lstAge = Age.Split(' ');
            string pAge = string.Empty;
            string pAgetype = string.Empty;
            if (lstAge != null && lstAge.Count() > 0)
            {
                pAge = lstAge[0];
                pAgetype = lstAge.Count() > 1 && lstAge[1] != null ? lstAge[1].Replace("(", "").Replace(")", "") : "";
            }
            string[] CatagoryAgeMain = xmlData.Split('|');

            XElement xe = XElement.Parse(xmlData);

            foreach (string oRangeType in lstRangeType)
            {
                result = string.Empty;

                var Range = from range in xe.Elements(oRangeType).Elements("property")
                            select range;
                if (Range != null && Range.Count() > 0)
                {
                    var commonRange = from common in xe.Elements(oRangeType).Elements("property")
                                      where (string)common.Attribute("type") == "common" && ((string)common.Attribute("value")).ToLower() == pGender.ToLower()
                                      select common;

                    var commonRangeBoth = from common in xe.Elements(oRangeType).Elements("property")
                                          where (string)common.Attribute("type") == "common" && ((string)common.Attribute("value")).ToLower() == "Both".ToLower()
                                          select common;

                    var otherRange = from other in xe.Elements(oRangeType).Elements("property")
                                     where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == pGender.ToLower() && (string)other.Attribute("ResultType") != "Text" && (string)other.Attribute("agetype") == null
                                     select other;

                    var otherRangeBoth = from other in xe.Elements(oRangeType).Elements("property")
                                         where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == "Both".ToLower() && (string)other.Attribute("ResultType") != "Text" && (string)other.Attribute("agetype") == null
                                         select other;

                    var otherRangeText = from other in xe.Elements(oRangeType).Elements("property")
                                         where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == pGender.ToLower() && (string)other.Attribute("ResultType") == "Text" && (string)other.Attribute("agetype") == null
                                         select other;

                    var otherRangeBothText = from other in xe.Elements(oRangeType).Elements("property")
                                             where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == "Both".ToLower() && (string)other.Attribute("ResultType") == "Text" && (string)other.Attribute("agetype") == null
                                             select other;

                    if (!string.IsNullOrEmpty(pAge))
                    {
                        double patientAgeInDays = ConvertToDays(Convert.ToDouble(pAge), pAgetype);

                        var ageRange = from age in xe.Elements(oRangeType).Elements("property")
                                       where (string)age.Attribute("type") == "age" && ((string)age.Attribute("value")).ToLower() == pGender.ToLower()
                                       select age;

                        var ageRangeBoth = from age in xe.Elements(oRangeType).Elements("property")
                                           where (string)age.Attribute("type") == "age" && ((string)age.Attribute("value")).ToLower() == "Both".ToLower()
                                           select age;

                        var otherRangeWithAge = from other in xe.Elements(oRangeType).Elements("property")
                                                where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == pGender.ToLower() && (string)other.Attribute("ResultType") != "Text" && (string)other.Attribute("agetype") != null
                                                select other;

                        var otherRangeBothWithAge = from other in xe.Elements(oRangeType).Elements("property")
                                                    where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == "Both".ToLower() && (string)other.Attribute("ResultType") != "Text" && (string)other.Attribute("agetype") != null
                                                    select other;
                        var otherRangeTextWithAge = from other in xe.Elements(oRangeType).Elements("property")
                                                    where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == pGender.ToLower() && (string)other.Attribute("ResultType") == "Text" && (string)other.Attribute("agetype") != null
                                                    select other;

                        var otherRangeBothTextWithAge = from other in xe.Elements(oRangeType).Elements("property")
                                                        where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == "Both".ToLower() && (string)other.Attribute("ResultType") == "Text" && (string)other.Attribute("agetype") != null
                                                        select other;

                        if (ageRange != null && ageRange.Count() > 0)
                        {
                            GetRIRAgeRange(ageRange, patientAgeInDays, deviceValue, deviceID, out result, out resultType);
                            return;
                        }
                        else if (ageRangeBoth != null && ageRangeBoth.Count() > 0)
                        {
                            GetRIRAgeRange(ageRangeBoth, patientAgeInDays, deviceValue, deviceID, out result, out resultType);
                            return;
                        }
                        else if (commonRange != null && commonRange.Count() > 0)
                        {
                            GetRIRCommonRange(commonRange, deviceValue, deviceID, out result, out resultType);
                            return;
                        }
                        else if (commonRangeBoth != null && commonRangeBoth.Count() > 0)
                        {
                            GetRIRCommonRange(commonRangeBoth, deviceValue, deviceID, out result, out resultType);
                            return;
                        }
                        if ((otherRange != null && otherRange.Count() > 0) || (otherRangeText != null && otherRangeText.Count() > 0) || (otherRangeWithAge != null && otherRangeWithAge.Count() > 0) || (otherRangeTextWithAge != null && otherRangeTextWithAge.Count() > 0))
                        {
                            if (otherRangeWithAge != null && otherRangeWithAge.Count() > 0)
                            {
                                GetRIROtherAgeRange(otherRangeWithAge, patientAgeInDays, deviceValue, deviceID, out result, out resultType);
                                return;
                            }
                            if (otherRangeTextWithAge != null && otherRangeTextWithAge.Count() > 0)
                            {
                                GetRIROtherRangeAgeText(otherRangeTextWithAge, CatagoryAgeMain, patientAgeInDays, deviceValue, deviceID, out result, out resultType);
                                return;
                            }
                            if (otherRange != null && otherRange.Count() > 0)
                            {
                                GetRIROtherRange(otherRange, deviceValue, deviceID, out result, out resultType);
                                return;
                            }
                            if (otherRangeText != null && otherRangeText.Count() > 0)
                            {
                                GetRIROtherRangeText(otherRangeText, CatagoryAgeMain, deviceValue, deviceID, out result, out resultType);
                                return;
                            }
                        }
                        else if ((otherRangeBoth != null && otherRangeBoth.Count() > 0) || (otherRangeBothText != null && otherRangeBothText.Count() > 0) || (otherRangeBothWithAge != null && otherRangeBothWithAge.Count() > 0) || (otherRangeBothTextWithAge != null && otherRangeBothTextWithAge.Count() > 0))
                        {
                            if (otherRangeBothWithAge != null && otherRangeBothWithAge.Count() > 0)
                            {
                                GetRIROtherAgeRange(otherRangeBothWithAge, patientAgeInDays, deviceValue, deviceID, out result, out resultType);
                                return;
                            }
                            if (otherRangeBothTextWithAge != null && otherRangeBothTextWithAge.Count() > 0)
                            {
                                GetRIROtherRangeAgeText(otherRangeBothTextWithAge, CatagoryAgeMain, patientAgeInDays, deviceValue, deviceID, out result, out resultType);
                                return;
                            }
                            if (otherRangeBoth != null && otherRangeBoth.Count() > 0)
                            {
                                GetRIROtherRange(otherRangeBoth, deviceValue, deviceID, out result, out resultType);
                                return;
                            }

                            if (otherRangeBothText != null && otherRangeBothText.Count() > 0)
                            {
                                GetRIROtherRangeText(otherRangeBothText, CatagoryAgeMain, deviceValue, deviceID, out result, out resultType);
                                return;
                            }
                        }
                    }
                    else
                    {
                        if (commonRange != null && commonRange.Count() > 0)
                        {
                            GetRIRCommonRange(commonRange, deviceValue, deviceID, out result, out resultType);
                            return;
                        }
                        else if (commonRangeBoth != null && commonRangeBoth.Count() > 0)
                        {
                            GetRIRCommonRange(commonRangeBoth, deviceValue, deviceID, out result, out resultType);
                            return;
                        }
                        if ((otherRange != null && otherRange.Count() > 0) || (otherRangeText != null && otherRangeText.Count() > 0))
                        {
                            if (otherRange != null && otherRange.Count() > 0)
                            {
                                GetRIROtherRange(otherRange, deviceValue, deviceID, out result, out resultType);
                                return;
                            }
                            if (otherRangeText != null && otherRangeText.Count() > 0)
                            {
                                GetRIROtherRangeText(otherRangeText, CatagoryAgeMain, deviceValue, deviceID, out result, out resultType);
                                return;
                            }
                        }
                        else if ((otherRangeBoth != null && otherRangeBoth.Count() > 0) || (otherRangeBothText != null && otherRangeBothText.Count() > 0))
                        {
                            if (otherRangeBoth != null && otherRangeBoth.Count() > 0)
                            {
                                GetRIROtherRange(otherRangeBoth, deviceValue, deviceID, out result, out resultType);
                                return;
                            }

                            if (otherRangeBothText != null && otherRangeBothText.Count() > 0)
                            {
                                GetRIROtherRangeText(otherRangeBothText, CatagoryAgeMain, deviceValue, deviceID, out result, out resultType);
                                return;
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while parsing reference range xml", ex);
        }
    }

    public void ConvertXmlToShowAllRange(string xmlData, string oRangeType, out string ReferenceRange, string uom, string pGender)
    {
        ReferenceRange = string.Empty;
        try
        {
            uom = uom == "" ? "" : uom;

            string[] CatagoryAgeMain = xmlData.Split('|');

            XElement xe = XElement.Parse(xmlData);

            #region Reference Range
            var ageRange = from age in xe.Elements(oRangeType).Elements("property")
                           where (string)age.Attribute("type") == "age" && ((string)age.Attribute("value")).ToLower() == pGender.ToLower()
                           select age;

            var commonRange = from common in xe.Elements(oRangeType).Elements("property")
                              where (string)common.Attribute("type") == "common" && ((string)common.Attribute("value")).ToLower() == pGender.ToLower()
                              select common;

            var otherRange = from other in xe.Elements(oRangeType).Elements("property")
                             where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == pGender.ToLower()
                             select other;

            var ageRangeBoth = from age in xe.Elements(oRangeType).Elements("property")
                               where (string)age.Attribute("type") == "age" && ((string)age.Attribute("value")).ToLower() == "Both".ToLower()
                               select age;

            var commonRangeBoth = from common in xe.Elements(oRangeType).Elements("property")
                                  where (string)common.Attribute("type") == "common" && ((string)common.Attribute("value")).ToLower() == "Both".ToLower()
                                  select common;

            var otherRangeBoth = from other in xe.Elements(oRangeType).Elements("property")
                                 where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == "Both".ToLower()
                                 select other;

            if (ageRange != null)
            {
                foreach (var lst in ageRange)
                {
                    if (lst.Element("lst") != null)
                    {
                        if (lst.Element("lst").Attribute("mode").Value != "ref")
                        {
                            ReferenceRange += lst.Element("lst").Attribute("gender").Value + ": " + ConvertRangeStringOptr("lst") + " " + lst.Element("lst").Value + " " + lst.Element("lst").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("lst").FirstAttribute.Value)) + " " + lst.Element("lst").LastAttribute.Value + "<br>";
                        }
                        else
                        {
                            ReferenceRange += lst.Element("lst").LastAttribute.Value;
                        }
                    }
                    if (lst.Element("lsq") != null)
                    {
                        if (lst.Element("lsq").Attribute("mode").Value != "ref")
                        {
                            ReferenceRange += lst.Element("lsq").Attribute("gender").Value + ": " + ConvertRangeStringOptr("lsq") + " " + lst.Element("lsq").Value + " " + lst.Element("lsq").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("lsq").FirstAttribute.Value)) + " " + lst.Element("lsq").LastAttribute.Value + "<br>";
                        }
                        else
                        {
                            ReferenceRange += lst.Element("lsq").LastAttribute.Value;
                        }
                    }
                    if (lst.Element("eql") != null)
                    {
                        if (lst.Element("eql").Attribute("mode").Value != "ref")
                        {
                            ReferenceRange += lst.Element("eql").Attribute("gender").Value + ": " + ConvertRangeStringOptr("eql") + " " + lst.Element("eql").Value + " " + lst.Element("eql").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("eql").FirstAttribute.Value)) + " " + lst.Element("eql").LastAttribute.Value + "<br>";
                        }
                        else
                        {
                            ReferenceRange += lst.Element("eql").LastAttribute.Value;
                        }
                    }
                    if (lst.Element("grt") != null)
                    {
                        if (lst.Element("grt").Attribute("mode").Value != "ref")
                        {
                            ReferenceRange += lst.Element("grt").Attribute("gender").Value + ": " + ConvertRangeStringOptr("grt") + " " + lst.Element("grt").Value + " " + lst.Element("grt").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("grt").FirstAttribute.Value)) + " " + lst.Element("grt").LastAttribute.Value + "<br>";
                        }
                        else
                        {
                            ReferenceRange += lst.Element("grt").LastAttribute.Value;
                        }
                    }
                    if (lst.Element("grq") != null)
                    {
                        if (lst.Element("grq").Attribute("mode").Value != "ref")
                        {
                            ReferenceRange += lst.Element("grq").Attribute("gender").Value + ": " + ConvertRangeStringOptr("grq") + " " + lst.Element("grq").Value + " " + lst.Element("grq").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("grq").FirstAttribute.Value)) + " " + lst.Element("grq").LastAttribute.Value + "<br>";
                        }
                        else
                        {
                            ReferenceRange += lst.Element("grq").LastAttribute.Value;
                        }
                    }
                    if (lst.Element("btw") != null)
                    {
                        if (lst.Element("btw").Attribute("mode").Value != "ref")
                        {
                            ReferenceRange += lst.Element("btw").Attribute("gender").Value + ": " + ConvertRangeStringOptr("btw") + " " + AddSpace(lst.Element("btw").Value) + " " + lst.Element("btw").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("btw").FirstAttribute.Value)) + " " + AddSpace(lst.Element("btw").LastAttribute.Value) + "<br>";
                        }
                        else
                        {
                            ReferenceRange += lst.Element("btw").LastAttribute.Value;
                        }
                    }
                }
            }

            if (ageRangeBoth != null)
            {
                foreach (var lst in ageRangeBoth)
                {
                    if (lst.Element("lst") != null)
                    {
                        if (lst.Element("lst").Attribute("mode").Value != "ref")
                        {
                            ReferenceRange += lst.Element("lst").Attribute("gender").Value + ": " + ConvertRangeStringOptr("lst") + " " + lst.Element("lst").Value + " " + lst.Element("lst").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("lst").FirstAttribute.Value)) + " " + lst.Element("lst").LastAttribute.Value + "<br>";
                        }
                        else
                        {
                            ReferenceRange += lst.Element("lst").LastAttribute.Value;
                        }
                    }
                    if (lst.Element("lsq") != null)
                    {
                        if (lst.Element("lsq").Attribute("mode").Value != "ref")
                        {
                            ReferenceRange += lst.Element("lsq").Attribute("gender").Value + ": " + ConvertRangeStringOptr("lsq") + " " + lst.Element("lsq").Value + " " + lst.Element("lsq").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("lsq").FirstAttribute.Value)) + " " + lst.Element("lsq").LastAttribute.Value + "<br>";
                        }
                        else
                        {
                            ReferenceRange += lst.Element("lsq").LastAttribute.Value;
                        }
                    }
                    if (lst.Element("eql") != null)
                    {
                        if (lst.Element("eql").Attribute("mode").Value != "ref")
                        {
                            ReferenceRange += lst.Element("eql").Attribute("gender").Value + ": " + ConvertRangeStringOptr("eql") + " " + lst.Element("eql").Value + " " + lst.Element("eql").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("eql").FirstAttribute.Value)) + " " + lst.Element("eql").LastAttribute.Value + "<br>";
                        }
                        else
                        {
                            ReferenceRange += lst.Element("eql").LastAttribute.Value;
                        }
                    }
                    if (lst.Element("grt") != null)
                    {
                        if (lst.Element("grt").Attribute("mode").Value != "ref")
                        {
                            ReferenceRange += lst.Element("grt").Attribute("gender").Value + ": " + ConvertRangeStringOptr("grt") + " " + lst.Element("grt").Value + " " + lst.Element("grt").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("grt").FirstAttribute.Value)) + " " + lst.Element("grt").LastAttribute.Value + "<br>";
                        }
                        else
                        {
                            ReferenceRange += lst.Element("grt").LastAttribute.Value;
                        }
                    }
                    if (lst.Element("grq") != null)
                    {
                        if (lst.Element("grq").Attribute("mode").Value != "ref")
                        {
                            ReferenceRange += lst.Element("grq").Attribute("gender").Value + ": " + ConvertRangeStringOptr("grq") + " " + lst.Element("grq").Value + " " + lst.Element("grq").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("grq").FirstAttribute.Value)) + " " + lst.Element("grq").LastAttribute.Value + "<br>";
                        }
                        else
                        {
                            ReferenceRange += lst.Element("grq").LastAttribute.Value;
                        }
                    }
                    if (lst.Element("btw") != null)
                    {
                        if (lst.Element("btw").Attribute("mode").Value != "ref")
                        {
                            ReferenceRange += lst.Element("btw").Attribute("gender").Value + ": " + ConvertRangeStringOptr("btw") + " " + AddSpace(lst.Element("btw").Value) + " " + lst.Element("btw").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("btw").FirstAttribute.Value)) + " " + AddSpace(lst.Element("btw").LastAttribute.Value) + "<br>";
                        }
                        else
                        {
                            ReferenceRange += lst.Element("btw").LastAttribute.Value;
                        }
                    }
                }
            }

            if (commonRange != null)
            {
                foreach (var lst in commonRange)
                {
                    if (lst.Element("lst") != null)
                    {
                        ReferenceRange += lst.Element("lst").FirstAttribute.Value + ": < " + lst.Element("lst").Value + "<br>";
                    }
                    if (lst.Element("lsq") != null)
                    {
                        ReferenceRange += lst.Element("lsq").FirstAttribute.Value + ": <= " + lst.Element("lsq").Value + "<br>";
                    }
                    if (lst.Element("eql") != null)
                    {
                        ReferenceRange += lst.Element("eql").FirstAttribute.Value + ": = " + lst.Element("eql").Value + "<br>";
                    }
                    if (lst.Element("grt") != null)
                    {
                        ReferenceRange += lst.Element("grt").FirstAttribute.Value + ": > " + lst.Element("grt").Value + "<br>";
                    }
                    if (lst.Element("grq") != null)
                    {
                        ReferenceRange += lst.Element("grq").FirstAttribute.Value + ": => " + lst.Element("grq").Value + "<br>";
                    }
                    if (lst.Element("btw") != null)
                    {
                        ReferenceRange += lst.Element("btw").FirstAttribute.Value + ": " + AddSpace(lst.Element("btw").Value) + "<br>";
                    }
                    if (lst.Element("ref") != null)
                    {
                        ReferenceRange += lst.Element("ref").Value + "<br>";
                    }
                }
            }

            if (commonRangeBoth != null)
            {
                foreach (var lst in commonRangeBoth)
                {
                    if (lst.Element("lst") != null)
                    {
                        ReferenceRange += lst.Element("lst").FirstAttribute.Value + ": < " + lst.Element("lst").Value + "<br>";
                    }
                    if (lst.Element("lsq") != null)
                    {
                        ReferenceRange += lst.Element("lsq").FirstAttribute.Value + ": <= " + lst.Element("lsq").Value + "<br>";
                    }
                    if (lst.Element("eql") != null)
                    {
                        ReferenceRange += lst.Element("eql").FirstAttribute.Value + ": = " + lst.Element("eql").Value + "<br>";
                    }
                    if (lst.Element("grt") != null)
                    {
                        ReferenceRange += lst.Element("grt").FirstAttribute.Value + ": > " + lst.Element("grt").Value + "<br>";
                    }
                    if (lst.Element("grq") != null)
                    {
                        ReferenceRange += lst.Element("grq").FirstAttribute.Value + ": => " + lst.Element("grq").Value + "<br>";
                    }
                    if (lst.Element("btw") != null)
                    {
                        ReferenceRange += lst.Element("btw").FirstAttribute.Value + ": " + AddSpace(lst.Element("btw").Value) + "<br>";
                    }
                    if (lst.Element("ref") != null)
                    {
                        ReferenceRange += lst.Element("ref").Value + "<br>";
                    }
                }
            }

            if (otherRange != null)
            {
                foreach (var lst in otherRange)
                {
                    if (lst.Element("lst") != null)
                    {
                        ReferenceRange += lst.Element("lst").FirstAttribute.Value + ": " + lst.Element("lst").Value + ": < " + lst.Element("lst").LastAttribute.Value + "<br>";

                    }
                    if (lst.Element("lsq") != null)
                    {
                        ReferenceRange += lst.Element("lsq").FirstAttribute.Value + ": " + lst.Element("lsq").Value + ": <= " + lst.Element("lsq").LastAttribute.Value + "<br>";
                    }
                    if (lst.Element("eql") != null)
                    {
                        ReferenceRange += lst.Element("eql").FirstAttribute.Value + ": " + lst.Element("eql").Value + ": = " + lst.Element("eql").LastAttribute.Value + "<br>";
                    }
                    if (lst.Element("grt") != null)
                    {
                        ReferenceRange += lst.Element("grt").FirstAttribute.Value + ": " + lst.Element("grt").Value + ": > " + lst.Element("grt").LastAttribute.Value + "<br>";
                    }
                    if (lst.Element("grq") != null)
                    {
                        ReferenceRange += lst.Element("grq").FirstAttribute.Value + ": " + lst.Element("grq").Value + ": >= " + lst.Element("grq").LastAttribute.Value + "<br>";
                    }
                    if (lst.Element("btw") != null)
                    {
                        ReferenceRange += lst.Element("btw").FirstAttribute.Value + ": " + lst.Element("btw").Value + ": " + AddSpace(lst.Element("btw").LastAttribute.Value) + "<br>";
                    }
                    if (lst.Element("ref") != null)
                    {
                        ReferenceRange += lst.Element("ref").Value + "<br>";
                    }
                }
            }

            if (otherRangeBoth != null)
            {
                foreach (var lst in otherRangeBoth)
                {
                    if (lst.Element("lst") != null)
                    {
                        ReferenceRange += lst.Element("lst").FirstAttribute.Value + ": " + lst.Element("lst").Value + ": < " + lst.Element("lst").LastAttribute.Value + "<br>";
                    }
                    if (lst.Element("lsq") != null)
                    {
                        ReferenceRange += lst.Element("lsq").FirstAttribute.Value + ": " + lst.Element("lsq").Value + ": <= " + lst.Element("lsq").LastAttribute.Value + "<br>";
                    }
                    if (lst.Element("eql") != null)
                    {
                        ReferenceRange += lst.Element("eql").FirstAttribute.Value + ": " + lst.Element("eql").Value + ": = " + lst.Element("eql").LastAttribute.Value + "<br>";
                    }
                    if (lst.Element("grt") != null)
                    {
                        ReferenceRange += lst.Element("grt").FirstAttribute.Value + ": " + lst.Element("grt").Value + ": > " + lst.Element("grt").LastAttribute.Value + "<br>";
                    }
                    if (lst.Element("grq") != null)
                    {
                        ReferenceRange += lst.Element("grq").FirstAttribute.Value + ": " + lst.Element("grq").Value + ": >= " + lst.Element("grq").LastAttribute.Value + "<br>";
                    }
                    if (lst.Element("btw") != null)
                    {
                        ReferenceRange += lst.Element("btw").FirstAttribute.Value + ": " + lst.Element("btw").Value + ": " + AddSpace(lst.Element("btw").LastAttribute.Value) + "<br>";
                    }
                    if (lst.Element("ref") != null)
                    {
                        ReferenceRange += lst.Element("ref").Value + "<br>";
                    }
                }
            }

            if (ReferenceRange == "")
            {
                XElement xer = XElement.Parse(xmlData);

                if (xe.Elements(oRangeType).Elements("property") != null)
                {
                    ReferenceRange = "";
                }
                else
                {
                    ReferenceRange = xmlData;
                }
            }
            #endregion
        }
        catch (Exception ex)
        {
            ReferenceRange = string.Empty;
            CLogger.LogError("Error while parsing reference range xml", ex);
        }
    }

    public string ReplaceNumberWithCommas(string resultValue)
    {
        try
        {
            double d = 0;
            string textValue = resultValue;
            textValue = textValue.Replace(",", "");
            bool isNumber = Double.TryParse(textValue, out d);
            if (isNumber)
            {
                string[] lstTextValue = textValue.Split('.');
                if (lstTextValue[0] != null)
                {
                    double dd = 0;
                    bool isPreNumber = Double.TryParse(lstTextValue[0], out dd);
                    if (isPreNumber)
                    {
                        var cultureInfo = new CultureInfo("hi-IN");// Need to be changed;
                        var numberFormatInfo = (NumberFormatInfo)cultureInfo.NumberFormat.Clone();
                        numberFormatInfo.CurrencySymbol = "";

                        string commaValue = dd.ToString("C0", numberFormatInfo);
                        if (lstTextValue.Count() > 1 && lstTextValue[1] != null)
                        {
                            resultValue = commaValue + "." + lstTextValue[1];
                        }
                        else
                        {
                            resultValue = commaValue;
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While replacing number with comma", ex);
        }
        return resultValue;
    }
    public string CreateOrganDrugDetailsXML(List<VitekDeviceIntegrationResult> lstVitekDeviceIntegrationResult, string InvestigationName, int OrgID)
    {
        XmlDocument xmlDoc = new XmlDocument();
        XmlElement xmlElement;
        XmlNode xmlNode;
        xmlDoc.LoadXml("<InvestigationResults></InvestigationResults>");
        xmlElement = xmlDoc.CreateElement("InvestigationDetails");
        try
        {
            if (lstVitekDeviceIntegrationResult != null && lstVitekDeviceIntegrationResult.Count > 0)
            {
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "InvestigationName", "");

                //Investigation  name node
                xmlNode.InnerText = InvestigationName;
                xmlElement.AppendChild(xmlNode);

                //Investigation id node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "InvestigationID", "");
                xmlNode.InnerText = Convert.ToString(lstVitekDeviceIntegrationResult[0].InvestigationID);
                xmlElement.AppendChild(xmlNode);

                XmlElement xmlElementOrgan = xmlDoc.CreateElement("OrganDetails");
                XmlNode xmlNodeOrgan;
                XmlAttribute xmlOrganAttrName;
                XmlAttribute xmlOrganAttrCode;
                XmlAttribute xmlOrganAttrDrugCode;
                XmlAttribute xmlOrganAttrDrugName;
                XmlAttribute xmlOrganAttrSensitivity;
                XmlAttribute xmlOrganAttrZone;
                XmlAttribute xmlOrganAttrFamily;
                XmlAttribute xmlOrganAttrNameSeq;
                XmlAttribute xmlOrganAttrFamilySeq;
                string organismFound = string.Empty;

                List<string> lstOrganismDetails = (from VD in lstVitekDeviceIntegrationResult
                                                   select VD.OrganismName).Distinct().ToList();

                List<InvOrganismDrugMapping> lstOrganismDrugDetails;
                BaseClass oBaseClass = new BaseClass();
                oBaseClass.ContextInfo.OrgID = OrgID;
                Investigation_BL oInvestigationBL = new Investigation_BL(oBaseClass.ContextInfo);
                long returnCode = -1;
                foreach (string organismName in lstOrganismDetails)
                {
                    lstOrganismDrugDetails = new List<InvOrganismDrugMapping>();
                    returnCode = oInvestigationBL.GetOrganismDrugDetails(lstVitekDeviceIntegrationResult[0].InvestigationID, 0, organismName, "Device", out lstOrganismDrugDetails);

                    List<VitekDeviceIntegrationResult> lstOrganismResult = (from VD in lstVitekDeviceIntegrationResult
                                                                            where VD.OrganismName == organismName
                                                                            select VD).ToList();
                    if (lstOrganismDrugDetails != null && lstOrganismDrugDetails.Count > 0)
                    {
                        List<VitekDeviceIntegrationResult> lstOrganismDrugResult;
                        string organismCode = string.Empty;
                        string drugCode = string.Empty;
                        string sensitivity = string.Empty;
                        string micValue = string.Empty;
                        foreach (InvOrganismDrugMapping obj in lstOrganismDrugDetails)
                        {
                            lstOrganismDrugResult = (from OR in lstOrganismResult
                                                     where OR.OrganismName == obj.OrganismName && OR.DrugName == obj.DrugName
                                                     select OR).ToList();
                            organismCode = string.Empty;
                            drugCode = string.Empty;
                            sensitivity = string.Empty;
                            micValue = string.Empty;
                            if (lstOrganismDrugResult != null && lstOrganismDrugResult.Count > 0)
                            {
                                organismCode = lstOrganismDrugResult[0].OrganismCode;
                                drugCode = lstOrganismDrugResult[0].DrugCode;
                                sensitivity = lstOrganismDrugResult[0].Sensitivity;
                                micValue = lstOrganismDrugResult[0].MicValue;
                            }
                            else
                            {
                                organismCode = obj.OrganismCode;
                                drugCode = obj.DrugCode;
                            }
                            xmlNodeOrgan = xmlDoc.CreateNode(XmlNodeType.Element, "Organ", "");

                            xmlOrganAttrName = xmlDoc.CreateAttribute("Name");
                            xmlOrganAttrName.Value = obj.OrganismName;
                            xmlNodeOrgan.Attributes.Append(xmlOrganAttrName);

                            if (organismFound == string.Empty)
                            {
                                organismFound = obj.OrganismName;
                            }
                            else
                            {
                                if (!organismFound.Contains(obj.OrganismName))
                                {
                                    organismFound = organismFound + ", " + obj.OrganismName;
                                }
                            }

                            xmlOrganAttrCode = xmlDoc.CreateAttribute("Code");
                            xmlOrganAttrCode.Value = organismCode;
                            xmlNodeOrgan.Attributes.Append(xmlOrganAttrCode);

                            xmlOrganAttrDrugCode = xmlDoc.CreateAttribute("DrugCode");
                            xmlOrganAttrDrugCode.Value = drugCode;
                            xmlNodeOrgan.Attributes.Append(xmlOrganAttrDrugCode);

                            xmlOrganAttrDrugName = xmlDoc.CreateAttribute("DrugName");
                            xmlOrganAttrDrugName.Value = obj.DrugName;
                            xmlNodeOrgan.Attributes.Append(xmlOrganAttrDrugName);

                            xmlOrganAttrNameSeq = xmlDoc.CreateAttribute("NameSeq");
                            xmlOrganAttrNameSeq.Value = Convert.ToString(obj.SequenceNo);
                            xmlNodeOrgan.Attributes.Append(xmlOrganAttrNameSeq);

                            //xmlOrganAttrFamily = xmlDoc.CreateAttribute("Family");
                            //xmlOrganAttrFamily.Value = obj["Family"];
                            //xmlNodeOrgan.Attributes.Append(xmlOrganAttrFamily);

                            //xmlOrganAttrFamilySeq = xmlDoc.CreateAttribute("FamilySeq");
                            //xmlOrganAttrFamilySeq.Value = obj["FamilySeq"];
                            //xmlNodeOrgan.Attributes.Append(xmlOrganAttrFamilySeq);

                            xmlOrganAttrSensitivity = xmlDoc.CreateAttribute("Sensitivity");
                            xmlOrganAttrSensitivity.Value = sensitivity;
                            xmlNodeOrgan.Attributes.Append(xmlOrganAttrSensitivity);

                            xmlOrganAttrZone = xmlDoc.CreateAttribute("Zone");
                            xmlOrganAttrZone.Value = micValue;
                            xmlNodeOrgan.Attributes.Append(xmlOrganAttrZone);

                            xmlElementOrgan.AppendChild(xmlNodeOrgan);
                        }
                        List<string> lstDrugName = (from OD in lstOrganismDrugDetails
                                                    select OD.DrugName).Distinct().ToList();
                        List<VitekDeviceIntegrationResult> lstMissingOrganismResult = (from OR in lstOrganismResult
                                                                                       where !lstDrugName.Contains(OR.DrugName)
                                                                                       select OR).Distinct().ToList();
                        if (lstMissingOrganismResult != null && lstMissingOrganismResult.Count > 0)
                        {
                            foreach (VitekDeviceIntegrationResult obj in lstMissingOrganismResult)
                            {
                                xmlNodeOrgan = xmlDoc.CreateNode(XmlNodeType.Element, "Organ", "");

                                xmlOrganAttrName = xmlDoc.CreateAttribute("Name");
                                xmlOrganAttrName.Value = obj.OrganismName;
                                xmlNodeOrgan.Attributes.Append(xmlOrganAttrName);

                                if (organismFound == string.Empty)
                                {
                                    organismFound = obj.OrganismName;
                                }
                                else
                                {
                                    if (!organismFound.Contains(obj.OrganismName))
                                    {
                                        organismFound = organismFound + ", " + obj.OrganismName;
                                    }
                                }

                                xmlOrganAttrCode = xmlDoc.CreateAttribute("Code");
                                xmlOrganAttrCode.Value = obj.OrganismCode;
                                xmlNodeOrgan.Attributes.Append(xmlOrganAttrCode);

                                xmlOrganAttrDrugCode = xmlDoc.CreateAttribute("DrugCode");
                                xmlOrganAttrDrugCode.Value = obj.DrugCode;
                                xmlNodeOrgan.Attributes.Append(xmlOrganAttrDrugCode);

                                xmlOrganAttrDrugName = xmlDoc.CreateAttribute("DrugName");
                                xmlOrganAttrDrugName.Value = obj.DrugName;
                                xmlNodeOrgan.Attributes.Append(xmlOrganAttrDrugName);

                                xmlOrganAttrNameSeq = xmlDoc.CreateAttribute("NameSeq");
                                xmlOrganAttrNameSeq.Value = "99";
                                xmlNodeOrgan.Attributes.Append(xmlOrganAttrNameSeq);

                                //xmlOrganAttrFamily = xmlDoc.CreateAttribute("Family");
                                //xmlOrganAttrFamily.Value = obj["Family"];
                                //xmlNodeOrgan.Attributes.Append(xmlOrganAttrFamily);

                                //xmlOrganAttrFamilySeq = xmlDoc.CreateAttribute("FamilySeq");
                                //xmlOrganAttrFamilySeq.Value = obj["FamilySeq"];
                                //xmlNodeOrgan.Attributes.Append(xmlOrganAttrFamilySeq);

                                xmlOrganAttrSensitivity = xmlDoc.CreateAttribute("Sensitivity");
                                xmlOrganAttrSensitivity.Value = obj.Sensitivity;
                                xmlNodeOrgan.Attributes.Append(xmlOrganAttrSensitivity);

                                xmlOrganAttrZone = xmlDoc.CreateAttribute("Zone");
                                xmlOrganAttrZone.Value = obj.MicValue;
                                xmlNodeOrgan.Attributes.Append(xmlOrganAttrZone);

                                xmlElementOrgan.AppendChild(xmlNodeOrgan);
                            }
                        }
                    }
                    else
                    {
                        foreach (VitekDeviceIntegrationResult obj in lstOrganismResult)
                        {
                            xmlNodeOrgan = xmlDoc.CreateNode(XmlNodeType.Element, "Organ", "");

                            xmlOrganAttrName = xmlDoc.CreateAttribute("Name");
                            xmlOrganAttrName.Value = obj.OrganismName;
                            xmlNodeOrgan.Attributes.Append(xmlOrganAttrName);

                            if (organismFound == string.Empty)
                            {
                                organismFound = obj.OrganismName;
                            }
                            else
                            {
                                if (!organismFound.Contains(obj.OrganismName))
                                {
                                    organismFound = organismFound + ", " + obj.OrganismName;
                                }
                            }

                            xmlOrganAttrCode = xmlDoc.CreateAttribute("Code");
                            xmlOrganAttrCode.Value = obj.OrganismCode;
                            xmlNodeOrgan.Attributes.Append(xmlOrganAttrCode);

                            xmlOrganAttrDrugCode = xmlDoc.CreateAttribute("DrugCode");
                            xmlOrganAttrDrugCode.Value = obj.DrugCode;
                            xmlNodeOrgan.Attributes.Append(xmlOrganAttrDrugCode);

                            xmlOrganAttrDrugName = xmlDoc.CreateAttribute("DrugName");
                            xmlOrganAttrDrugName.Value = obj.DrugName;
                            xmlNodeOrgan.Attributes.Append(xmlOrganAttrDrugName);

                            //xmlOrganAttrNameSeq = xmlDoc.CreateAttribute("NameSeq");
                            //xmlOrganAttrNameSeq.Value = obj["NameSeq"];
                            //xmlNodeOrgan.Attributes.Append(xmlOrganAttrNameSeq);

                            //xmlOrganAttrFamily = xmlDoc.CreateAttribute("Family");
                            //xmlOrganAttrFamily.Value = obj["Family"];
                            //xmlNodeOrgan.Attributes.Append(xmlOrganAttrFamily);

                            //xmlOrganAttrFamilySeq = xmlDoc.CreateAttribute("FamilySeq");
                            //xmlOrganAttrFamilySeq.Value = obj["FamilySeq"];
                            //xmlNodeOrgan.Attributes.Append(xmlOrganAttrFamilySeq);

                            xmlOrganAttrSensitivity = xmlDoc.CreateAttribute("Sensitivity");
                            xmlOrganAttrSensitivity.Value = obj.Sensitivity;
                            xmlNodeOrgan.Attributes.Append(xmlOrganAttrSensitivity);

                            xmlOrganAttrZone = xmlDoc.CreateAttribute("Zone");
                            xmlOrganAttrZone.Value = obj.MicValue;
                            xmlNodeOrgan.Attributes.Append(xmlOrganAttrZone);

                            xmlElementOrgan.AppendChild(xmlNodeOrgan);

                        }
                    }
                }
                xmlElement.AppendChild(xmlElementOrgan);

                //if (!String.IsNullOrEmpty(txtOtherOrganism.Text.Trim()))
                //{
                //    if (organismFound == string.Empty)
                //    {
                //        organismFound = txtOtherOrganism.Text.Trim();
                //    }
                //    else
                //    {
                //        organismFound = organismFound + ", " + txtOtherOrganism.Text.Trim();
                //    }
                //}
                //Organism Isolated
                if (!String.IsNullOrEmpty(organismFound.Trim()))
                {
                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "OrganismIsolated", "");
                    xmlNode.InnerText = organismFound.Trim();
                    xmlElement.AppendChild(xmlNode);
                }
                xmlDoc.DocumentElement.AppendChild(xmlElement);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while creating xml", ex);
        }
        return xmlDoc.InnerXml;

    }

    public void ConvertXmlToString(string xmlData, string uom, string Gender, string Age, string AgeDays, out string ReferenceRange, out string OtherReferenceRange)
    {
        ReferenceRange = string.Empty;
        OtherReferenceRange = string.Empty;
        try
        {
            uom = uom == "" ? "" : uom;
            string pGender = string.Empty;
            pGender = !string.IsNullOrEmpty(Gender) && Gender != "0" && Gender != "U" ? (Gender == "F" ? "Female" : "Male") : string.Empty;
            string[] lstAge = Age.Split(' ');
            string pAge = string.Empty;
            string pAgetype = string.Empty;
            double patientAgeInDays = 0;
            if (lstAge != null && lstAge.Count() > 0)
            {
                pAge = lstAge[0];
                pAgetype = lstAge[1].Replace("(", "").Replace(")", "");
            }
            if (AgeDays == "")
            {
                AgeDays = "-1";
            }
            if (AgeDays != "-1")
            {
                patientAgeInDays = Convert.ToDouble(AgeDays);
            }
            else
            {
                patientAgeInDays = ConvertToDays(Convert.ToDouble(pAge), pAgetype);
            }

            if (!String.IsNullOrEmpty(pGender) && pGender != "U")
            {

                string[] CatagoryAgeMain = xmlData.Split('|');

                XElement xe = XElement.Parse(xmlData);

                var ageRange = from age in xe.Elements("referencerange").Elements("property")
                               where (string)age.Attribute("type") == "age" && ((string)age.Attribute("value")).ToLower() == pGender.ToLower()
                               select age;

                var ageRangeBoth = from age in xe.Elements("referencerange").Elements("property")
                                   where (string)age.Attribute("type") == "age" && ((string)age.Attribute("value")).ToLower() == "Both".ToLower()
                                   select age;

                var commonRange = from common in xe.Elements("referencerange").Elements("property")
                                  where (string)common.Attribute("type") == "common" && ((string)common.Attribute("value")).ToLower() == pGender.ToLower()
                                  select common;

                var commonRangeBoth = from common in xe.Elements("referencerange").Elements("property")
                                      where (string)common.Attribute("type") == "common" && ((string)common.Attribute("value")).ToLower() == "Both".ToLower()
                                      select common;

                var otherRange = from other in xe.Elements("referencerange").Elements("property")
                                 where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == pGender.ToLower() && (string)other.Attribute("ResultType") != "Text"
                                 select other;

                var otherRangeBoth = from other in xe.Elements("referencerange").Elements("property")
                                     where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == "Both".ToLower() && (string)other.Attribute("ResultType") != "Text"
                                     select other;

                var otherRangeText = from other in xe.Elements("referencerange").Elements("property")
                                     where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == pGender.ToLower() && (string)other.Attribute("ResultType") == "Text"
                                     select other;

                var otherRangeBothText = from other in xe.Elements("referencerange").Elements("property")
                                         where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == "Both".ToLower() && (string)other.Attribute("ResultType") == "Text"
                                         select other;

                if (otherRangeText != null)
                {
                    foreach (var lst in otherRangeText)
                    {
                        if (lst.Element("txt") != null)
                        {
                            ReferenceRange += lst.Element("txt").Value + "<br>";
                        }
                    }
                }

                if (otherRangeBothText != null)
                {
                    foreach (var lst in otherRangeBothText)
                    {
                        if (lst.Element("txt") != null)
                        {
                            ReferenceRange += lst.Element("txt").Value + "<br>";
                        }
                    }
                }

                if (ageRange != null)
                {
                    foreach (var lst in ageRange)
                    {
                        if (lst.Element("lst") != null)
                        {
                            if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("lst").Value), lst.Element("lst").Attribute("agetype").Value))
                            {
                                ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("lst").FirstAttribute.Value)) + " " + lst.Element("lst").LastAttribute.Value + "<br>";
                            }
                        }
                        if (lst.Element("lsq") != null)
                        {
                            if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("lsq").Value), lst.Element("lsq").Attribute("agetype").Value))
                            {
                                ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("lsq").FirstAttribute.Value)) + " " + lst.Element("lsq").LastAttribute.Value + "<br>";
                            }
                        }
                        if (lst.Element("eql") != null)
                        {
                            if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("eql").Value), lst.Element("eql").Attribute("agetype").Value))
                            {
                                ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("eql").FirstAttribute.Value)) + " " + lst.Element("eql").LastAttribute.Value + "<br>";
                            }
                        }
                        if (lst.Element("grt") != null)
                        {
                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("grt").Value), lst.Element("grt").Attribute("agetype").Value))
                            {
                                ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("grt").FirstAttribute.Value)) + " " + lst.Element("grt").LastAttribute.Value + "<br>";
                            }
                        }
                        if (lst.Element("grq") != null)
                        {
                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("grq").Value), lst.Element("grq").Attribute("agetype").Value))
                            {
                                ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("grq").FirstAttribute.Value)) + " " + lst.Element("grq").LastAttribute.Value + "<br>";
                            }
                        }
                        if (lst.Element("btw") != null)
                        {
                            string[] between = lst.Element("btw").Value.Split('-');
                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(between[0]), lst.Element("btw").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("btw").Attribute("agetype").Value))
                            {
                                ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("btw").FirstAttribute.Value)) + " " + lst.Element("btw").LastAttribute.Value + "<br>";
                            }
                        }
                    }
                }

                if (commonRange != null)
                {
                    foreach (var lst in commonRange)
                    {
                        if (lst.Element("lst") != null)
                        {
                            ReferenceRange += " < " + lst.Element("lst").Value + "<br>";
                        }
                        if (lst.Element("lsq") != null)
                        {
                            ReferenceRange += " <= " + lst.Element("lsq").Value + "<br>";
                        }
                        if (lst.Element("eql") != null)
                        {
                            ReferenceRange += " = " + lst.Element("eql").Value + "<br>";
                        }
                        if (lst.Element("grt") != null)
                        {
                            ReferenceRange += " > " + lst.Element("grt").Value + "<br>";
                        }
                        if (lst.Element("grq") != null)
                        {
                            ReferenceRange += " => " + lst.Element("grq").Value + "<br>";
                        }
                        if (lst.Element("btw") != null)
                        {
                            ReferenceRange += "" + lst.Element("btw").Value + "<br>";
                        }
                    }
                }

                if (commonRangeBoth != null)
                {
                    foreach (var lst in commonRangeBoth)
                    {
                        if (lst.Element("lst") != null)
                        {
                            ReferenceRange += " < " + lst.Element("lst").Value + "<br>";
                        }
                        if (lst.Element("lsq") != null)
                        {
                            ReferenceRange += " <= " + lst.Element("lsq").Value + "<br>";
                        }
                        if (lst.Element("eql") != null)
                        {
                            ReferenceRange += " = " + lst.Element("eql").Value + "<br>";
                        }
                        if (lst.Element("grt") != null)
                        {
                            ReferenceRange += " > " + lst.Element("grt").Value + "<br>";
                        }
                        if (lst.Element("grq") != null)
                        {
                            ReferenceRange += " => " + lst.Element("grq").Value + "<br>";
                        }
                        if (lst.Element("btw") != null)
                        {
                            ReferenceRange += "" + lst.Element("btw").Value + "<br>";
                        }
                    }
                }

                if (otherRange != null)
                {
                    foreach (var lst in otherRange)
                    {
                        if (lst.Element("lst") != null)
                        {
                            ReferenceRange += lst.Element("lst").Value + ": < " + lst.Element("lst").Attribute("value").Value + "<br>";
                            if (lst.Element("lst").LastAttribute.Name == "ConvReferencevalue")
                            {
                                OtherReferenceRange += " < " + lst.Element("lst").Attribute("ConvReferencevalue").Value + "<br>";
                            }
                        }
                        if (lst.Element("lsq") != null)
                        {
                            ReferenceRange += lst.Element("lsq").Value + ": <= " + lst.Element("lsq").Attribute("value").Value + "<br>";
                            if (lst.Element("lsq").LastAttribute.Name == "ConvReferencevalue")
                            {
                                OtherReferenceRange += " <= " + lst.Element("lsq").Attribute("ConvReferencevalue").Value + "<br>";
                            }
                        }

                        if (lst.Element("eql") != null)
                        {
                            ReferenceRange += lst.Element("eql").Value + ": = " + lst.Element("eql").Attribute("value").Value + "<br>";
                            if (lst.Element("eql").LastAttribute.Name == "ConvReferencevalue")
                            {
                                OtherReferenceRange += " = " + lst.Element("eql").Attribute("ConvReferencevalue").Value + "<br>";
                            }
                        }

                        if (lst.Element("grt") != null)
                        {
                            ReferenceRange += lst.Element("grt").Value + ": > " + lst.Element("grt").Attribute("value").Value + "<br>";
                            if (lst.Element("grt").LastAttribute.Name == "ConvReferencevalue")
                            {
                                OtherReferenceRange += "> " + lst.Element("grt").Attribute("ConvReferencevalue").Value + "<br>";
                                //lst.Element("grt").Value + ":
                            }
                        }


                        if (lst.Element("grq") != null)
                        {
                            ReferenceRange += lst.Element("grq").Value + ": >= " + lst.Element("grq").Attribute("value").Value + "<br>";
                            if (lst.Element("grq").LastAttribute.Name == "ConvReferencevalue")
                            {
                                OtherReferenceRange += " >= " + lst.Element("grq").Attribute("ConvReferencevalue").Value + "<br>";
                            }
                        }

                        if (lst.Element("btw") != null)
                        {
                            ReferenceRange += lst.Element("btw").Value + ": " + lst.Element("btw").Attribute("value").Value + "<br>";
                            if (lst.Element("btw").LastAttribute.Name == "ConvReferencevalue")
                            {
                                OtherReferenceRange += " " + lst.Element("btw").Attribute("ConvReferencevalue").Value + "<br>";
                            }
                        }
                    }
                }

                if (otherRangeBoth != null)
                {
                    foreach (var lst in otherRangeBoth)
                    {
                        if (lst.Element("lst") != null)
                        {
                            //ReferenceRange += lst.Element("lst").FirstAttribute.Value + " :  " + lst.Element("lst").Value + " < " + lst.Element("lst").LastAttribute.Value + " " + uom + "\n";
                            ReferenceRange += lst.Element("lst").Value + ": < " + lst.Element("lst").Attribute("value").Value + "<br>";
                            if (lst.Element("lst").LastAttribute.Name == "ConvReferencevalue")
                            {
                                OtherReferenceRange += " < " + lst.Element("lst").Attribute("ConvReferencevalue").Value + "<br>";
                                //lst.Element("lst").Value + ":
                            }
                        }
                        if (lst.Element("lsq") != null)
                        {
                            //ReferenceRange += lst.Element("lsq").FirstAttribute.Value + " :  " + lst.Element("lsq").Value + " <= " + lst.Element("lsq").LastAttribute.Value + " " + uom + "\n";
                            ReferenceRange += lst.Element("lsq").Value + ": <= " + lst.Element("lsq").Attribute("value").Value + "<br>";
                            if (lst.Element("lsq").LastAttribute.Name == "ConvReferencevalue")
                            {
                                OtherReferenceRange += " <= " + lst.Element("lsq").Attribute("ConvReferencevalue").Value + "<br>";
                                //lst.Element("lsq").Value + ":
                            }
                        }

                        if (lst.Element("eql") != null)
                        {
                            //ReferenceRange += lst.Element("eql").FirstAttribute.Value + " :  " + lst.Element("eql").Value + " = " + lst.Element("eql").LastAttribute.Value + " " + uom + "\n";
                            ReferenceRange += lst.Element("eql").Value + ": = " + lst.Element("eql").Attribute("value").Value + "<br>";
                            if (lst.Element("eql").LastAttribute.Name == "ConvReferencevalue")
                            {
                                OtherReferenceRange += " = " + lst.Element("eql").Attribute("ConvReferencevalue").Value + "<br>";
                                //lst.Element("eql").Value + ":
                            }
                        }

                        if (lst.Element("grt") != null)
                        {
                            //ReferenceRange += lst.Element("grt").FirstAttribute.Value + " :  " + lst.Element("grt").Value + " > " + lst.Element("grt").LastAttribute.Value + " " + uom + "\n";
                            ReferenceRange += lst.Element("grt").Value + ": > " + lst.Element("grt").Attribute("value").Value + "<br>";
                            if (lst.Element("grt").LastAttribute.Name == "ConvReferencevalue")
                            {
                                OtherReferenceRange += " > " + lst.Element("grt").Attribute("ConvReferencevalue").Value + "<br>";
                                //lst.Element("grt").Value + ":
                            }
                        }


                        if (lst.Element("grq") != null)
                        {
                            //ReferenceRange += lst.Element("grq").FirstAttribute.Value + " :  " + lst.Element("grq").Value + " >= " + lst.Element("grq").LastAttribute.Value + " " + uom + "\n";
                            ReferenceRange += lst.Element("grq").Value + ": >= " + lst.Element("grq").Attribute("value").Value + "<br>";
                            if (lst.Element("grq").LastAttribute.Name == "ConvReferencevalue")
                            {
                                OtherReferenceRange += " >= " + lst.Element("grq").Attribute("ConvReferencevalue").Value + "<br>";
                                //lst.Element("grq").Value + ":
                            }
                        }

                        if (lst.Element("btw") != null)
                        {
                            //ReferenceRange += lst.Element("btw").FirstAttribute.Value + " :  " + lst.Element("btw").Value + " Between " + lst.Element("btw").LastAttribute.Value + " " + uom + "\n";
                            ReferenceRange += lst.Element("btw").Value + ": " + lst.Element("btw").Attribute("value").Value + "<br>";
                            if (lst.Element("btw").LastAttribute.Name == "ConvReferencevalue")
                            {
                                OtherReferenceRange += " " + lst.Element("btw").Attribute("ConvReferencevalue").Value + "<br>";
                                //lst.Element("btw").Value + ":
                            }
                        }
                    }
                }

                if (ageRangeBoth != null)
                {
                    foreach (var lst in ageRangeBoth)
                    {
                        if (lst.Element("lst") != null)
                        {
                            if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("lst").Value), lst.Element("lst").Attribute("agetype").Value))
                            {
                                ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("lst").FirstAttribute.Value)) + " " + lst.Element("lst").LastAttribute.Value + "<br>";
                            }
                        }

                        if (lst.Element("lsq") != null)
                        {
                            if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("lsq").Value), lst.Element("lsq").Attribute("agetype").Value))
                            {
                                ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("lsq").FirstAttribute.Value)) + " " + lst.Element("lsq").LastAttribute.Value + "<br>";

                            }
                        }

                        if (lst.Element("eql") != null)
                        {
                            if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("eql").Value), lst.Element("eql").Attribute("agetype").Value))
                            {
                                ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("eql").FirstAttribute.Value)) + " " + lst.Element("eql").LastAttribute.Value + "<br>";
                            }
                        }

                        if (lst.Element("grt") != null)
                        {
                            if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("grt").Value), lst.Element("grt").Attribute("agetype").Value))
                            {
                                ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("grt").FirstAttribute.Value)) + " " + lst.Element("grt").LastAttribute.Value + "<br>";

                            }
                        }

                        if (lst.Element("grq") != null)
                        {
                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("grq").Value), lst.Element("grq").Attribute("agetype").Value))
                            {
                                ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("grq").FirstAttribute.Value)) + " " + lst.Element("grq").LastAttribute.Value + "<br>";
                            }
                        }

                        if (lst.Element("btw") != null)
                        {
                            string[] between = lst.Element("btw").Value.Split('-');
                            if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(between[0]), lst.Element("btw").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("btw").Attribute("agetype").Value))
                            {
                                ReferenceRange += " " + (ConvertRangeStringOptr(lst.Element("btw").FirstAttribute.Value)) + " " + lst.Element("btw").LastAttribute.Value + "<br>";
                            }
                        }
                    }
                }
                if (ReferenceRange == "")
                {
                    XElement xer = XElement.Parse(xmlData);

                    if (xe.Elements("referencerange").Elements("property") != null)
                    {
                        string AllUom = string.Empty;
                        string AllReferenceRange = string.Empty;
                        ConvertXmlToShowAllRange(xmlData, out  AllReferenceRange, uom, pGender);
                        ReferenceRange = AllReferenceRange;
                    }
                    else
                    {
                        ReferenceRange = xmlData;
                    }
                }
            }

        }
        catch (Exception ex)
        {
            ReferenceRange = string.Empty;
            CLogger.LogError("Error while parsing reference range xml", ex);
        }

    }
    public void ConvertXmlToShowAllRange(string xmlData, out string ReferenceRange, string uom, string pGender)
    {
        ReferenceRange = string.Empty;
        try
        {
            uom = uom == "" ? "" : uom;

            string[] CatagoryAgeMain = xmlData.Split('|');
            //&& (string)age.Attribute("mode") == pAgetype

            XElement xe = XElement.Parse(xmlData);

            #region Reference Range
            var ageRange = from age in xe.Elements("referencerange").Elements("property")
                           where (string)age.Attribute("type") == "age" && ((string)age.Attribute("value")).ToLower() == pGender.ToLower()
                           //&& ((string)age.Attribute("mode")).ToLower() == pAgetype.ToLower()
                           select age;

            var commonRange = from common in xe.Elements("referencerange").Elements("property")
                              where (string)common.Attribute("type") == "common" && ((string)common.Attribute("value")).ToLower() == pGender.ToLower()
                              select common;

            var otherRange = from other in xe.Elements("referencerange").Elements("property")
                             where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == pGender.ToLower()
                             select other;

            var ageRangeBoth = from age in xe.Elements("referencerange").Elements("property")
                               where (string)age.Attribute("type") == "age" && ((string)age.Attribute("value")).ToLower() == "Both".ToLower()
                               //&& ((string)age.Attribute("mode")).ToLower() == pAgetype.ToLower()
                               select age;

            var commonRangeBoth = from common in xe.Elements("referencerange").Elements("property")
                                  where (string)common.Attribute("type") == "common" && ((string)common.Attribute("value")).ToLower() == "Both".ToLower()
                                  select common;

            var otherRangeBoth = from other in xe.Elements("referencerange").Elements("property")
                                 where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == "Both".ToLower()
                                 select other;

            if (ageRange != null)
            {
                foreach (var lst in ageRange)
                {
                    if (lst.Element("lst") != null)
                    {
                        //if (pAgeint < Convert.ToInt32(lst.Element("lst").Value))
                        if (true)
                        {
                            ReferenceRange += lst.Element("lst").Attribute("gender").Value + ": " + ConvertRangeStringOptr("lst") + " " + lst.Element("lst").Value + " " + lst.Element("lst").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("lst").FirstAttribute.Value)) + " " + lst.Element("lst").LastAttribute.Value + "<br>";
                        }

                    }
                    if (lst.Element("lsq") != null)
                    {
                        //if (pAgeint <= Convert.ToInt32(lst.Element("lsq").Value))
                        if (true)
                        {
                            ReferenceRange += lst.Element("lsq").Attribute("gender").Value + ": " + ConvertRangeStringOptr("lsq") + " " + lst.Element("lsq").Value + " " + lst.Element("lsq").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("lsq").FirstAttribute.Value)) + " " + lst.Element("lsq").LastAttribute.Value + "<br>";
                        }
                    }
                    if (lst.Element("eql") != null)
                    {
                        //if (pAgeint == Convert.ToInt32(lst.Element("eql").Value))
                        if (true)
                        {
                            ReferenceRange += lst.Element("eql").Attribute("gender").Value + ": " + ConvertRangeStringOptr("eql") + " " + lst.Element("eql").Value + " " + lst.Element("eql").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("eql").FirstAttribute.Value)) + " " + lst.Element("eql").LastAttribute.Value + "<br>";
                        }
                    }
                    if (lst.Element("grt") != null)
                    {
                        //if (pAgeint > Convert.ToInt32(lst.Element("grt").Value))
                        if (true)
                        {
                            ReferenceRange += lst.Element("grt").Attribute("gender").Value + ": " + ConvertRangeStringOptr("grt") + " " + lst.Element("grt").Value + " " + lst.Element("grt").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("grt").FirstAttribute.Value)) + " " + lst.Element("grt").LastAttribute.Value + "<br>";
                        }
                    }
                    if (lst.Element("grq") != null)
                    {
                        //if (pAgeint >= Convert.ToInt32(lst.Element("grq").Value))
                        if (true)
                        {
                            ReferenceRange += lst.Element("grq").Attribute("gender").Value + ": " + ConvertRangeStringOptr("grq") + " " + lst.Element("grq").Value + " " + lst.Element("grq").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("grq").FirstAttribute.Value)) + " " + lst.Element("grq").LastAttribute.Value + "<br>";
                        }
                    }
                    if (lst.Element("btw") != null)
                    {
                        string[] between = lst.Element("btw").Value.Split('-');
                        //if (pAgeint >= Convert.ToDecimal(between[0]) && pAgeint <= Convert.ToDecimal(between[1]))
                        if (true)
                        {
                            ReferenceRange += lst.Element("btw").Attribute("gender").Value + ": " + ConvertRangeStringOptr("btw") + " " + AddSpace(lst.Element("btw").Value) + " " + lst.Element("btw").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("btw").FirstAttribute.Value)) + " " + AddSpace(lst.Element("btw").LastAttribute.Value) + "<br>";
                        }
                    }
                }
            }

            if (ageRangeBoth != null)
            {
                foreach (var lst in ageRangeBoth)
                {
                    if (lst.Element("lst") != null)
                    {
                        //if (pAgeint < Convert.ToInt32(lst.Element("lst").Value))
                        if (true)
                        {
                            ReferenceRange += lst.Element("lst").Attribute("gender").Value + ": " + ConvertRangeStringOptr("lst") + " " + lst.Element("lst").Value + " " + lst.Element("lst").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("lst").FirstAttribute.Value)) + " " + lst.Element("lst").LastAttribute.Value + "<br>";
                        }
                    }
                    if (lst.Element("lsq") != null)
                    {
                        //if (pAgeint <= Convert.ToInt32(lst.Element("lsq").Value))
                        if (true)
                        {
                            ReferenceRange += lst.Element("lsq").Attribute("gender").Value + ": " + ConvertRangeStringOptr("lsq") + " " + lst.Element("lsq").Value + " " + lst.Element("lsq").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("lsq").FirstAttribute.Value)) + " " + lst.Element("lsq").LastAttribute.Value + "<br>";
                        }
                    }
                    if (lst.Element("eql") != null)
                    {
                        //if (pAgeint == Convert.ToInt32(lst.Element("eql").Value))
                        if (true)
                        {
                            ReferenceRange += lst.Element("eql").Attribute("gender").Value + ": " + ConvertRangeStringOptr("eql") + " " + lst.Element("eql").Value + " " + lst.Element("eql").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("eql").FirstAttribute.Value)) + " " + lst.Element("eql").LastAttribute.Value + "<br>";
                        }
                    }
                    if (lst.Element("grt") != null)
                    {
                        //if (pAgeint > Convert.ToInt32(lst.Element("grt").Value))
                        if (true)
                        {
                            ReferenceRange += lst.Element("grt").Attribute("gender").Value + ": " + ConvertRangeStringOptr("grt") + " " + lst.Element("grt").Value + " " + lst.Element("grt").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("grt").FirstAttribute.Value)) + " " + lst.Element("grt").LastAttribute.Value + "<br>";
                        }
                    }
                    if (lst.Element("grq") != null)
                    {
                        //if (pAgeint >= Convert.ToInt32(lst.Element("grq").Value))
                        if (true)
                        {
                            ReferenceRange += lst.Element("grq").Attribute("gender").Value + ": " + ConvertRangeStringOptr("grq") + " " + lst.Element("grq").Value + " " + lst.Element("grq").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("grq").FirstAttribute.Value)) + " " + lst.Element("grq").LastAttribute.Value + "<br>";
                        }
                    }
                    if (lst.Element("btw") != null)
                    {
                        string[] between = lst.Element("btw").Value.Split('-');
                        //if (pAgeint >= Convert.ToDecimal(between[0]) && pAgeint <= Convert.ToDecimal(between[1]))
                        if (true)
                        {
                            ReferenceRange += lst.Element("btw").Attribute("gender").Value + ": " + ConvertRangeStringOptr("btw") + " " + AddSpace(lst.Element("btw").Value) + " " + lst.Element("btw").Attribute("agetype").Value + " : " + (ConvertRangeStringOptr(lst.Element("btw").FirstAttribute.Value)) + " " + AddSpace(lst.Element("btw").LastAttribute.Value) + "<br>";
                        }
                    }
                }
            }

            if (commonRange != null)
            {
                foreach (var lst in commonRange)
                {
                    if (lst.Element("lst") != null)
                    {
                        ReferenceRange += lst.Element("lst").FirstAttribute.Value + ": < " + lst.Element("lst").Value + "<br>";
                    }
                    if (lst.Element("lsq") != null)
                    {
                        ReferenceRange += lst.Element("lsq").FirstAttribute.Value + ": <= " + lst.Element("lsq").Value + "<br>";
                    }
                    if (lst.Element("eql") != null)
                    {
                        ReferenceRange += lst.Element("eql").FirstAttribute.Value + ": = " + lst.Element("eql").Value + "<br>";
                    }
                    if (lst.Element("grt") != null)
                    {
                        ReferenceRange += lst.Element("grt").FirstAttribute.Value + ": > " + lst.Element("grt").Value + "<br>";
                    }
                    if (lst.Element("grq") != null)
                    {
                        ReferenceRange += lst.Element("grq").FirstAttribute.Value + ": => " + lst.Element("grq").Value + "<br>";
                    }
                    if (lst.Element("btw") != null)
                    {
                        ReferenceRange += lst.Element("btw").FirstAttribute.Value + ": " + AddSpace(lst.Element("btw").Value) + "<br>";
                    }
                }
            }

            if (commonRangeBoth != null)
            {
                foreach (var lst in commonRangeBoth)
                {
                    if (lst.Element("lst") != null)
                    {
                        ReferenceRange += lst.Element("lst").FirstAttribute.Value + ": < " + lst.Element("lst").Value + "<br>";
                    }
                    if (lst.Element("lsq") != null)
                    {
                        ReferenceRange += lst.Element("lsq").FirstAttribute.Value + ": <= " + lst.Element("lsq").Value + "<br>";
                    }
                    if (lst.Element("eql") != null)
                    {
                        ReferenceRange += lst.Element("eql").FirstAttribute.Value + ": = " + lst.Element("eql").Value + "<br>";
                    }
                    if (lst.Element("grt") != null)
                    {
                        ReferenceRange += lst.Element("grt").FirstAttribute.Value + ": > " + lst.Element("grt").Value + "<br>";
                    }
                    if (lst.Element("grq") != null)
                    {
                        ReferenceRange += lst.Element("grq").FirstAttribute.Value + ": => " + lst.Element("grq").Value + "<br>";
                    }
                    if (lst.Element("btw") != null)
                    {
                        ReferenceRange += lst.Element("btw").FirstAttribute.Value + ": " + AddSpace(lst.Element("btw").Value) + "<br>";
                    }
                }
            }

            if (otherRange != null)
            {
                foreach (var lst in otherRange)
                {
                    if (lst.Element("lst") != null)
                    {
                        ReferenceRange += lst.Element("lst").FirstAttribute.Value + ": " + lst.Element("lst").Value + ": < " + lst.Element("lst").LastAttribute.Value + "<br>";

                    }
                    if (lst.Element("lsq") != null)
                    {
                        ReferenceRange += lst.Element("lsq").FirstAttribute.Value + ": " + lst.Element("lsq").Value + ": <= " + lst.Element("lsq").LastAttribute.Value + "<br>";
                    }
                    if (lst.Element("eql") != null)
                    {
                        ReferenceRange += lst.Element("eql").FirstAttribute.Value + ": " + lst.Element("eql").Value + ": = " + lst.Element("eql").LastAttribute.Value + "<br>";
                    }
                    if (lst.Element("grt") != null)
                    {
                        ReferenceRange += lst.Element("grt").FirstAttribute.Value + ": " + lst.Element("grt").Value + ": > " + lst.Element("grt").LastAttribute.Value + "<br>";
                    }
                    if (lst.Element("grq") != null)
                    {
                        ReferenceRange += lst.Element("grq").FirstAttribute.Value + ": " + lst.Element("grq").Value + ": >= " + lst.Element("grq").LastAttribute.Value + "<br>";
                    }
                    if (lst.Element("btw") != null)
                    {
                        ReferenceRange += lst.Element("btw").FirstAttribute.Value + ": " + lst.Element("btw").Value + ": " + AddSpace(lst.Element("btw").LastAttribute.Value) + "<br>";
                    }
                }
            }

            if (otherRangeBoth != null)
            {
                foreach (var lst in otherRangeBoth)
                {
                    if (lst.Element("lst") != null)
                    {
                        ReferenceRange += lst.Element("lst").FirstAttribute.Value + ": " + lst.Element("lst").Value + ": < " + lst.Element("lst").LastAttribute.Value + "<br>";
                    }
                    if (lst.Element("lsq") != null)
                    {
                        ReferenceRange += lst.Element("lsq").FirstAttribute.Value + ": " + lst.Element("lsq").Value + ": <= " + lst.Element("lsq").LastAttribute.Value + "<br>";
                    }
                    if (lst.Element("eql") != null)
                    {
                        ReferenceRange += lst.Element("eql").FirstAttribute.Value + ": " + lst.Element("eql").Value + ": = " + lst.Element("eql").LastAttribute.Value + "<br>";
                    }
                    if (lst.Element("grt") != null)
                    {
                        ReferenceRange += lst.Element("grt").FirstAttribute.Value + ": " + lst.Element("grt").Value + ": > " + lst.Element("grt").LastAttribute.Value + "<br>";
                    }
                    if (lst.Element("grq") != null)
                    {
                        ReferenceRange += lst.Element("grq").FirstAttribute.Value + ": " + lst.Element("grq").Value + ": >= " + lst.Element("grq").LastAttribute.Value + "<br>";
                    }
                    if (lst.Element("btw") != null)
                    {
                        ReferenceRange += lst.Element("btw").FirstAttribute.Value + ": " + lst.Element("btw").Value + ": " + AddSpace(lst.Element("btw").LastAttribute.Value) + "<br>";
                    }
                }
            }

            if (ReferenceRange == "")
            {
                XElement xer = XElement.Parse(xmlData);

                if (xe.Elements("referencerange").Elements("property") != null)
                {
                    ReferenceRange = "";
                }
                else
                {
                    ReferenceRange = xmlData;
                }
            }
            #endregion
        }
        catch (Exception ex)
        {
            ReferenceRange = string.Empty;
            CLogger.LogError("Error while parsing reference range xml", ex);
        }
    }
    public void ValidateResult(string xmlData, string IsExcludeAutoApproval, int orgid, string Agedays, out string textColor, out string RangeColor1, out string IsSensitive, int autocount, List<ReferenceRangeType> lstReferenceRangeType)
    {
        long returnCode = -1;
        textColor = "white";
        string RangeColor = "white";
        RangeColor1 = "white";
        string IsSensitive1 = "N";
        IsSensitive = "N";

        try
        {

            string[] CatagoryAgeMain = xmlData.Split('|');
            int AutoApprovalId = 0;
            //int PreviousVisitCount = autocount;
	    int PreviousVisitCount = 1;
            int.TryParse(CatagoryAgeMain[8], out AutoApprovalId);

            string LangCode = "en-GB";
           // List<ReferenceRangeType> lstReferenceRangeType = new List<ReferenceRangeType>();
            List<ReferenceRangeType> lstNewReferenceRangeType = null;
            List<ReferenceRangeType> lstRangeType = null;
            //returnCode = new Investigation_BL().getReferencerangetype(orgid, LangCode, out lstReferenceRangeType);

            if (lstReferenceRangeType.Count > 0)
            {
                List<ReferenceRangeType> objlstReferenceRangeType = ((from child in lstReferenceRangeType
                                                                      select new ReferenceRangeType
                                                                      {
                                                                          Code = child.Code,
                                                                          Bound = child.Bound,
                                                                          Type = child.Type
                                                                      }).Distinct()).ToList();
                if (lstReferenceRangeType != null && objlstReferenceRangeType.Count > 0)
                {
                    bool isValidationRequired = true;
                    foreach (ReferenceRangeType oRRMetaData in objlstReferenceRangeType)
                    {
                        isValidationRequired = true;
                        XElement xe = XElement.Parse(CatagoryAgeMain[0]);
                        var Range = from range in xe.Elements(oRRMetaData.Code).Elements("property")
                                    select range;
                        if (Range != null && Range.Count() > 0)
                        {
                            //if (oRRMetaData == "domainrange" && Range != null)
                            //{
                            if (oRRMetaData.Code == "sensitiveresultrange")
                            {
                                Getstatus(xmlData, oRRMetaData.Code, Agedays, out RangeColor, "Range");
                                if (RangeColor == "white")
                                {
                                    IsSensitive1 = "Y";
                                    IsSensitive = "Y";
                                }
                                else
                                {
                                    IsSensitive1 = "N";
                                    IsSensitive = "N";
                                }
                                RangeColor = "white";
                                RangeColor1 = "white";
                                isValidationRequired = false;
                            }
                            if (oRRMetaData.Code == "autoauthorizationrange" && (AutoApprovalId <= 0 || IsExcludeAutoApproval == "Y"))
                            {
                                isValidationRequired = false;
                            }
                            if (Agedays == "undefined")
                            {
                                Agedays = "";
                            }
                            if (isValidationRequired)
                            {
                                if (oRRMetaData.Bound == "Inclusive")
                                {

                                    Getstatus(xmlData, oRRMetaData.Code, Agedays, out RangeColor, "Range");
                                }
                                else
                                {
                                    Getstatus(xmlData, oRRMetaData.Code, Agedays, out RangeColor, "Reference");
                                }
                                RangeColor1 = RangeColor;
                                lstRangeType = lstReferenceRangeType.FindAll(RR => RR.Code == oRRMetaData.Code && !String.IsNullOrEmpty(RR.Type)).ToList();

                                if (lstRangeType != null && lstRangeType.Count > 0)
                                {
                                    lstNewReferenceRangeType = lstRangeType.FindAll(RR => RR.Code == oRRMetaData.Code && RR.Type == RangeColor).ToList();
                                }
                                else
                                {
                                    lstNewReferenceRangeType = lstReferenceRangeType.FindAll(RR => RR.Code == oRRMetaData.Code && String.IsNullOrEmpty(RR.Type)).ToList();
                                }
                                if (lstNewReferenceRangeType != null && lstNewReferenceRangeType.Count > 0)
                                {
                                    if (RangeColor == "white" && oRRMetaData.Bound == "Inclusive")
                                    {
                                        textColor = lstNewReferenceRangeType[0].Color;
                                        if (oRRMetaData.Code == "autoauthorizationrange")
                                        {
                                            if (PreviousVisitCount == 1)//added by jegan --
                                                RangeColor1 = "Auto";
                                            else
                                            {
                                                RangeColor1 = "";
                                                textColor = "white";
                                            }

                                        }
                                        else
                                        {
                                            RangeColor1 = "P";
                                        }
                                        break;
                                    }
                                    else if (RangeColor != "white" && oRRMetaData.Bound == "Exclusive")
                                    {
                                        textColor = lstNewReferenceRangeType[0].Color;
                                        break;
                                    }
                                    //else if (RangeColor == "Black" && oRRMetaData.Bound == "Exclusive")
                                    //{
                                    //    textColor = lstNewReferenceRangeType[0].Color;
                                    //    break;
                                    //}
                                }


                            }
                        }

                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Validate user result", ex);
        }
    }
    public void Getstatus(string xmlData, string code, string Agedays, out string domain, string Rangetype)
    {
        string[] CatagoryAgeMain = xmlData.Split('|');
        Array userarr = CatagoryAgeMain[1].Split('~');
        string pGender = userarr.GetValue(0).ToString();
        string pAgetype = userarr.GetValue(2).ToString();
        string txtControl = CatagoryAgeMain[2].ToString();
        decimal rangeValue;
        double patientAgeInDays;
        decimal.TryParse(CatagoryAgeMain[3], out rangeValue);
        double pAge;
        if (userarr.GetValue(1) == "" || userarr.GetValue(1) == null)
        {
            pAge = 0;
        }
        else
        {
            pAge = Convert.ToDouble(userarr.GetValue(1));
        }
       

        if (pAgetype == "Year(s)")
        {
            pAgetype = "Years";
        }
        else if (pAgetype == "Week(s)")
        {
            pAgetype = "Weeks";
        }
        else if (pAgetype == "Month(s)")
        {
            pAgetype = "Months";
        }
        else if (pAgetype == "Day(s)")
        {
            pAgetype = "Days";
        }
        if (Agedays == "")
        {
            Agedays = "-1";
        }
        if (Agedays != "-1")
        {
            patientAgeInDays = Convert.ToDouble(Agedays);
        }
        else
        {
            patientAgeInDays = ConvertToDays(pAge, pAgetype);
        }
        domain = "white";
        #region Domain range
        if (TryParseXml(CatagoryAgeMain[0]))
        {


            XElement xe = XElement.Parse(CatagoryAgeMain[0]);


            var ageRange = from age in xe.Elements(code).Elements("property")
                           where (string)age.Attribute("type") == "age" && ((string)age.Attribute("value")).ToLower() == pGender.ToLower() //&& (string)age.Attribute("mode") == pAgetype
                           select age;

            var ageRangeBoth = from age in xe.Elements(code).Elements("property")
                               where (string)age.Attribute("type") == "age" && ((string)age.Attribute("value")).ToLower() == "Both".ToLower() //&& (string)age.Attribute("mode") == pAgetype
                               select age;


            var commonRange = from common in xe.Elements(code).Elements("property")
                              where (string)common.Attribute("type") == "common" && ((string)common.Attribute("value")).ToLower() == pGender.ToLower()
                              select common;

            var commonRangeBoth = from common in xe.Elements(code).Elements("property")
                                  where (string)common.Attribute("type") == "common" && ((string)common.Attribute("value")).ToLower() == "Both".ToLower()
                                  select common;

            var otherRange = from other in xe.Elements(code).Elements("property")
                             where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == pGender.ToLower() && (string)other.Attribute("ResultType") != "Text"
                             select other;

            var otherRangeBoth = from other in xe.Elements(code).Elements("property")
                                 where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == "Both".ToLower() && (string)other.Attribute("ResultType") != "Text"
                                 select other;

            //------------------------Shobana Changes Starts----------//		 

            var otherRangeText = from other in xe.Elements(code).Elements("property")
                                 where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == pGender.ToLower() && (string)other.Attribute("ResultType") == "Text"
                                 select other;

            var otherRangeBothText = from other in xe.Elements(code).Elements("property")
                                     where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == "Both".ToLower() && (string)other.Attribute("ResultType") == "Text"
                                     select other;
            //------------------------Shobana Changes Ends----------//	

            if (ageRange != null && ageRange.Count() > 0)
            {
                //textColor = "Red";
                if (Rangetype == "Reference")
                {
                    GetRefAgeRange(ageRange, patientAgeInDays, "", rangeValue, out domain);
                    if (domain == "A" || domain == "L")
                    {
                        return;
                    }
                }
                else
                {
                    GetAgeRange(ageRange, patientAgeInDays, rangeValue, out domain);
                }

            }


            if (ageRangeBoth != null && ageRangeBoth.Count() > 0)
            {
                //textColor = "Red";
                if (Rangetype == "Reference")
                {
                    GetRefAgeRange(ageRangeBoth, patientAgeInDays, "str", rangeValue, out domain);
                    if (domain == "A" || domain == "L")
                    {
                        return;
                    }
                }
                else
                {
                    GetAgeRange(ageRangeBoth, patientAgeInDays, rangeValue, out domain);
                }
            }



            if (commonRange != null && commonRange.Count() > 0)
            {
                if (Rangetype == "Reference")
                {
                    GetRefCommonRange(commonRange, rangeValue, out  domain);
                    if (domain == "A" || domain == "L")
                    {
                        return;
                    }
                }
                else
                {
                    GetCommonRange(commonRange, "", rangeValue, out  domain);
                }
            }

            if (commonRangeBoth != null && commonRangeBoth.Count() > 0)
            {
                if (Rangetype == "Reference")
                {
                    GetRefCommonRange(commonRangeBoth, rangeValue, out  domain);
                    if (domain == "A" || domain == "L")
                    {
                        return;
                    }
                }
                else
                {
                    GetCommonRange(commonRangeBoth, "", rangeValue, out  domain);
                }
            }


            if (otherRange != null && otherRange.Count() > 0)
            {
                if (Rangetype == "Reference")
                {
                    GetRefOtherRange(otherRange, "", rangeValue, out  domain);
                    if (domain == "A" || domain == "L")
                    {
                        return;
                    }
                }
                else
                {
                    //LastAttribute.Value
                    GetCommonRange(otherRange, "LastAttribute", rangeValue, out  domain);
                }
            }

            if (otherRangeBoth != null && otherRangeBoth.Count() > 0)
            {
                if (Rangetype == "Reference")
                {
                    GetRefOtherRange(otherRangeBoth, "LastAttribute", rangeValue, out  domain);
                    if (domain == "A" || domain == "L")
                    {
                        return;
                    }
                }
                else
                {
                    //LastAttribute.Value)
                    GetCommonRange(otherRangeBoth, "LastAttribute", rangeValue, out  domain);
                }

            }

            if (otherRangeText != null && otherRangeText.Count() > 0)
            {
                if (Rangetype == "Reference")
                {
                    GetRefOtherRangeText(otherRangeText, CatagoryAgeMain, pGender, code, rangeValue, out  domain);
                    if (domain == "A" || domain == "L")
                    {
                        return;
                    }
                }
                else
                {
                    GetOtherRange(otherRangeText, CatagoryAgeMain, pGender, code, rangeValue, out  domain);
                }
            }

            if (otherRangeBothText != null && otherRangeBothText.Count() > 0)
            {
                if (Rangetype == "Reference")
                {
                    GetRefOtherRangeText(otherRangeBothText, CatagoryAgeMain, "Both", code, rangeValue, out  domain);
                    if (domain == "A" || domain == "L")
                    {
                        return;
                    }
                }
                else
                {
                    GetOtherRange(otherRangeBothText, CatagoryAgeMain, "Both", code, rangeValue, out  domain);
                }
            }
        }


        #endregion
    }
    public decimal ConvertResultValue(string result)
    {
        decimal returnValue = 0;
        try
        {
            if (!string.IsNullOrEmpty(result))
            {
                decimal numericResult = 0;
                string opr = string.Empty;
                if (result.Contains("<") || result.ToLower().Contains("below"))
                {
                    opr = "lst";
                    result = result.Replace("<", "").Replace("Below", "").Replace("below", "");
                }
                if (result.Contains(">") || result.ToLower().Contains("above"))
                {
                    opr = "grt";
                    result = result.Replace(">", "").Replace("Above", "").Replace("above", "");
                }
                if (decimal.TryParse(result, out numericResult))
                {
                    if (opr == "lst")
                    {
                        numericResult = numericResult - Convert.ToDecimal(0.0001);
                    }
                    else if (opr == "grt")
                    {
                        numericResult = numericResult + Convert.ToDecimal(0.0001);
                    }
                    returnValue = numericResult;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while converting result values", ex);
        }
        return returnValue;
    }
    //Added by Vijayalakshmi.M For Mobile API
    public void ValidateResult(long VisitID, long InvestigationID, string Value, int OrgID, string ReferenceRange, string Age, out List<VisitDetails> lstVisitdetails, out string textColor, out string Abnormal, List<ReferenceRangeType> lstReferenceRangeType)
    {
        long returnCode = -1;
        textColor = "white";
        Abnormal = "N";
        string RangeColor = "white";
        string RangeColor1 = "white";
        string Isautoauthorized = "No";
        lstVisitdetails = new List<VisitDetails>();

        try
        {
            string LangCode = "en-GB";
            //List<ReferenceRangeType> lstReferenceRangeType = new List<ReferenceRangeType>();
            List<ReferenceRangeType> lstNewReferenceRangeType = null;
            List<ReferenceRangeType> lstRangeType = null;

            string xmlData = string.Empty;
           // returnCode = new Investigation_BL().getReferencerangetype(OrgID, LangCode, out lstReferenceRangeType);

            if (lstReferenceRangeType.Count > 0)
            {
                List<ReferenceRangeType> objlstReferenceRangeType = ((from child in lstReferenceRangeType
                                                                      select new ReferenceRangeType
                                                                      {
                                                                          Code = child.Code,
                                                                          Bound = child.Bound,
                                                                          Type = child.Type
                                                                      }).Distinct()).ToList();
                if (lstReferenceRangeType != null && objlstReferenceRangeType.Count > 0)
                {
                    bool isValidationRequired = true;
                    foreach (ReferenceRangeType oRRMetaData in objlstReferenceRangeType)
                    {
                        isValidationRequired = true;
                        string[] CatagoryAgeMain = ReferenceRange.Split('|');
                        int AutoApprovalId = 0;
                        // int.TryParse(CatagoryAgeMain[8], out AutoApprovalId);
                        XElement xe = XElement.Parse(CatagoryAgeMain[0]);
                        var Range = from range in xe.Elements(oRRMetaData.Code).Elements("property")
                                    select range;
                        if (Range != null && Range.Count() > 0)
                        {
                            //if (oRRMetaData == "domainrange" && Range != null)
                            //{
                            //if (oRRMetaData.Code == "autoauthorizationrange" && (AutoApprovalId <= 0 || IsExcludeAutoApproval == "Y"))
                            //{
                            //    isValidationRequired = false;
                            //}
                            if (isValidationRequired)
                            {
                                if (oRRMetaData.Bound == "Inclusive")
                                {
                                    Getstatus(ReferenceRange, oRRMetaData.Code, out RangeColor, "Range", Value, Age);
                                }
                                else
                                {
                                    Getstatus(ReferenceRange, oRRMetaData.Code, out RangeColor, "Reference", Value, Age);
                                }
                                RangeColor1 = RangeColor;
                                lstRangeType = lstReferenceRangeType.FindAll(RR => RR.Code == oRRMetaData.Code && !String.IsNullOrEmpty(RR.Type)).ToList();

                                if (lstRangeType != null && lstRangeType.Count > 0)
                                {
                                    lstNewReferenceRangeType = lstRangeType.FindAll(RR => RR.Code == oRRMetaData.Code && RR.Type == RangeColor).ToList();
                                }
                                else
                                {
                                    lstNewReferenceRangeType = lstReferenceRangeType.FindAll(RR => RR.Code == oRRMetaData.Code && String.IsNullOrEmpty(RR.Type)).ToList();
                                }
                                if (lstNewReferenceRangeType != null && lstNewReferenceRangeType.Count > 0 && oRRMetaData.Code == "autoauthorizationrange")
                                {
                                    if (RangeColor == "white" && oRRMetaData.Bound == "Inclusive")
                                    {
                                        Isautoauthorized = "Yes";
                                    }
                                }

                                else
                                {
                                    if (lstNewReferenceRangeType != null && lstNewReferenceRangeType.Count > 0)
                                    {
                                        if (RangeColor == "white" && oRRMetaData.Bound == "Inclusive")
                                        {
                                            textColor = lstNewReferenceRangeType[0].Color;
                                            if (Isautoauthorized == "Yes")
                                            {
                                                RangeColor1 = "AutoW";
                                            }
                                            else
                                            {
                                                RangeColor1 = "P";
                                            }
                                            break;
                                        }
                                        else if (RangeColor != "white" && oRRMetaData.Bound == "Exclusive")
                                        {
                                            if (Isautoauthorized == "Yes")
                                            {
                                                RangeColor1 = "Auto" + RangeColor;
                                                textColor = lstNewReferenceRangeType[0].Color;
                                            }
                                            else
                                            {
                                                textColor = lstNewReferenceRangeType[0].Color;

                                            }
                                            break;
                                        }
                                        //else if (RangeColor == "Black" && oRRMetaData.Bound == "Exclusive")
                                        //{
                                        //    textColor = lstNewReferenceRangeType[0].Color;
                                        //    break;
                                        //}
                                    }
                                    else if (RangeColor == "white" && oRRMetaData.Bound == "Exclusive")
                                    {
                                        if (Isautoauthorized == "Yes")
                                        {
                                            textColor = RangeColor;
                                            RangeColor1 = "Auto" + RangeColor;

                                        }
                                        else
                                        {
                                            textColor = RangeColor;

                                        }
                                        break;
                                    }


                                }
                            }
                        }

                    }
                }
                //return textColor;
            }
            if (textColor == "white")
            {
                Abnormal = "N";
            }
            else if (textColor == "lightpink")
            {
                Abnormal = "L";
            }
            else if (textColor == "Yellow")
            {
                Abnormal = "A";
            }
            else if (textColor == "Red")
            {
                Abnormal = "P";
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Validate user result", ex);
        }
    }

    public void Getstatus(string ReferenceRange, string code, out string domain, string Rangetype, string Value, string Age)
    {
        string[] CatagoryAgeMain = ReferenceRange.Split('|');
        //  string[] CategoryAge = Age.Split('~');
        Array userarr = Age.Split('~');
        string pGender = userarr.GetValue(0).ToString();
        pGender = !string.IsNullOrEmpty(pGender) && pGender != "0" ? pGender : string.Empty;
        Array AgeType = Age.Split(' ');
        string Agevalue = AgeType.GetValue(0).ToString();
        Array catagoryAge = Agevalue.Split('~');
        string pAgetype = AgeType.GetValue(1).ToString();
        // string txtControl = CatagoryAgeMain[2].ToString();
        bool isNumericValue = false;
        decimal rangeValue = Convert.ToDecimal(Value);
        string Agedays = string.Empty;
        if (pGender == "F")
        {
            pGender = "Female";
        }
        else if (pGender == "M")
        {
            pGender = "Male";
        }

        if (pAgetype == "Year(s)")
        {
            pAgetype = "Years";
        }
        else if (pAgetype == "Week(s)")
        {
            pAgetype = "Weeks";
        }
        else if (pAgetype == "Month(s)")
        {
            pAgetype = "Months";
        }
        else if (pAgetype == "Day(s)")
        {
            pAgetype = "Days";
        }

        double pAge = 0;
        double patientAgeInDays = 0;
        bool inCompleteRegistration = true;
        if (catagoryAge.GetValue(1) != null && catagoryAge.GetValue(1) != "")
        {
            pAge = Convert.ToDouble(catagoryAge.GetValue(1));
            // patientAgeInDays = ConvertToDays(pAge, pAgetype);
            inCompleteRegistration = false;
        }
        if (Agedays == "")
        {
            Agedays = "-1";
        }
        if (Agedays != "-1")
        {
            patientAgeInDays = Convert.ToDouble(Agedays);
        }
        else
        {
            patientAgeInDays = ConvertToDays(pAge, pAgetype);
        }
        domain = "white";
        #region Domain range
        if (TryParseXml(CatagoryAgeMain[0]))
        {


            XElement xe = XElement.Parse(CatagoryAgeMain[0]);

            var commonRange = from common in xe.Elements(code).Elements("property")
                              where (string)common.Attribute("type") == "common" && ((string)common.Attribute("value")).ToLower() == pGender.ToLower()
                              select common;

            var commonRangeBoth = from common in xe.Elements(code).Elements("property")
                                  where (string)common.Attribute("type") == "common" && ((string)common.Attribute("value")).ToLower() == "Both".ToLower()
                                  select common;

            var otherRange = from other in xe.Elements(code).Elements("property")
                             where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == pGender.ToLower() && (string)other.Attribute("ResultType") != "Text" && (string)other.Attribute("agetype") == null
                             select other;

            var otherRangeBoth = from other in xe.Elements(code).Elements("property")
                                 where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == "Both".ToLower() && (string)other.Attribute("ResultType") != "Text" && (string)other.Attribute("agetype") == null
                                 select other;

            var otherRangeText = from other in xe.Elements(code).Elements("property")
                                 where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == pGender.ToLower() && (string)other.Attribute("ResultType") == "Text" && (string)other.Attribute("agetype") == null
                                 select other;

            var otherRangeBothText = from other in xe.Elements(code).Elements("property")
                                     where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == "Both".ToLower() && (string)other.Attribute("ResultType") == "Text" && (string)other.Attribute("agetype") == null
                                     select other;

            if (!inCompleteRegistration)
            {

                var ageRange = from age in xe.Elements(code).Elements("property")
                               where (string)age.Attribute("type") == "age" && ((string)age.Attribute("value")).ToLower() == pGender.ToLower()
                               select age;

                var ageRangeBoth = from age in xe.Elements(code).Elements("property")
                                   where (string)age.Attribute("type") == "age" && ((string)age.Attribute("value")).ToLower() == "Both".ToLower()
                                   select age;

                var otherRangeWithAge = from other in xe.Elements(code).Elements("property")
                                        where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == pGender.ToLower() && (string)other.Attribute("ResultType") != "Text" && (string)other.Attribute("agetype") != null
                                        select other;

                var otherRangeBothWithAge = from other in xe.Elements(code).Elements("property")
                                            where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == "Both".ToLower() && (string)other.Attribute("ResultType") != "Text" && (string)other.Attribute("agetype") != null
                                            select other;
                var otherRangeTextWithAge = from other in xe.Elements(code).Elements("property")
                                            where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == pGender.ToLower() && (string)other.Attribute("ResultType") == "Text" && (string)other.Attribute("agetype") != null
                                            select other;

                var otherRangeBothTextWithAge = from other in xe.Elements(code).Elements("property")
                                                where (string)other.Attribute("type") == "other" && ((string)other.Attribute("value")).ToLower() == "Both".ToLower() && (string)other.Attribute("ResultType") == "Text" && (string)other.Attribute("agetype") != null
                                                select other;

                if (ageRange != null && ageRange.Count() > 0)
                {
                    //textColor = "Red";
                    if (Rangetype == "Reference")
                    {
                        GetRefAgeRange(ageRange, patientAgeInDays, "", rangeValue, out domain);
                        if (domain == "A" || domain == "L")
                        {
                            return;
                        }
                    }
                    else
                    {
                        GetAgeRange(ageRange, patientAgeInDays, rangeValue, out domain);
                    }

                }
                else if (ageRangeBoth != null && ageRangeBoth.Count() > 0)
                {
                    //textColor = "Red";
                    if (Rangetype == "Reference")
                    {
                        GetRefAgeRange(ageRangeBoth, patientAgeInDays, "str", rangeValue, out domain);
                        if (domain == "A" || domain == "L")
                        {
                            return;
                        }
                    }
                    else
                    {
                        GetAgeRange(ageRangeBoth, patientAgeInDays, rangeValue, out domain);
                    }
                }
                else if (commonRange != null && commonRange.Count() > 0)
                {
                    if (Rangetype == "Reference")
                    {
                        GetRefCommonRange(commonRange, rangeValue, out  domain);
                        if (domain == "A" || domain == "L")
                        {
                            return;
                        }
                    }
                    else
                    {
                        GetCommonRange(commonRange, "", rangeValue, out  domain);
                    }
                }
                else if (commonRangeBoth != null && commonRangeBoth.Count() > 0)
                {
                    if (Rangetype == "Reference")
                    {
                        GetRefCommonRange(commonRangeBoth, rangeValue, out  domain);
                        if (domain == "A" || domain == "L")
                        {
                            return;
                        }
                    }
                    else
                    {
                        GetCommonRange(commonRangeBoth, "", rangeValue, out  domain);
                    }
                }
                if ((otherRange != null && otherRange.Count() > 0) || (otherRangeText != null && otherRangeText.Count() > 0) || (otherRangeWithAge != null && otherRangeWithAge.Count() > 0) || (otherRangeTextWithAge != null && otherRangeTextWithAge.Count() > 0))
                {
                    if (otherRangeWithAge != null && otherRangeWithAge.Count() > 0)
                    {
                        if (Rangetype == "Reference")
                        {
                            GetRefOtherAgeRange(otherRangeWithAge, patientAgeInDays, "", rangeValue, out domain);
                            if (domain == "A" || domain == "L")
                            {
                                return;
                            }
                        }
                        else
                        {
                            GetOtherAgeRange(otherRangeWithAge, patientAgeInDays, rangeValue, out domain);
                        }
                    }
                    if (otherRangeTextWithAge != null && otherRangeTextWithAge.Count() > 0)
                    {
                        if (Rangetype == "Reference")
                        {
                            GetRefOtherRangeAgeText(otherRangeTextWithAge, CatagoryAgeMain, patientAgeInDays, rangeValue, out  domain);
                            if (domain == "A" || domain == "L")
                            {
                                return;
                            }
                        }
                        else
                        {
                            GetOtherRangeAgeText(otherRangeTextWithAge, CatagoryAgeMain, patientAgeInDays, rangeValue, out  domain);
                        }
                    }
                    if (otherRange != null && otherRange.Count() > 0)
                    {
                        if (Rangetype == "Reference")
                        {
                            GetRefOtherRange(otherRange, "", rangeValue, out  domain);
                            if (domain == "A" || domain == "L")
                            {
                                return;
                            }
                        }
                        else
                        {
                            //LastAttribute.Value
                            GetCommonRange(otherRange, "LastAttribute", rangeValue, out  domain);
                        }
                    }
                    if (otherRangeText != null && otherRangeText.Count() > 0)
                    {
                        if (Rangetype == "Reference")
                        {
                            GetRefOtherRangeText(otherRangeText, CatagoryAgeMain, pGender, code, rangeValue, out  domain);
                            if (domain == "A" || domain == "L")
                            {
                                return;
                            }
                        }
                        else
                        {
                            GetOtherRange(otherRangeText, CatagoryAgeMain, pGender, code, rangeValue, out  domain);
                        }
                    }
                }
                else if ((otherRangeBoth != null && otherRangeBoth.Count() > 0) || (otherRangeBothText != null && otherRangeBothText.Count() > 0) || (otherRangeBothWithAge != null && otherRangeBothWithAge.Count() > 0) || (otherRangeBothTextWithAge != null && otherRangeBothTextWithAge.Count() > 0))
                {
                    if (otherRangeBothWithAge != null && otherRangeBothWithAge.Count() > 0)
                    {
                        if (Rangetype == "Reference")
                        {
                            GetRefOtherAgeRange(otherRangeBothWithAge, patientAgeInDays, "", rangeValue, out domain);
                            if (domain == "A" || domain == "L")
                            {
                                return;
                            }
                        }
                        else
                        {
                            GetOtherAgeRange(otherRangeBothWithAge, patientAgeInDays, rangeValue, out domain);
                        }
                    }
                    if (otherRangeBothTextWithAge != null && otherRangeBothTextWithAge.Count() > 0)
                    {
                        if (Rangetype == "Reference")
                        {
                            GetRefOtherRangeAgeText(otherRangeBothTextWithAge, CatagoryAgeMain, patientAgeInDays, rangeValue, out  domain);
                            if (domain == "A" || domain == "L")
                            {
                                return;
                            }
                        }
                        else
                        {
                            GetOtherRangeAgeText(otherRangeBothTextWithAge, CatagoryAgeMain, patientAgeInDays, rangeValue, out  domain);
                        }
                    }
                    if (otherRangeBoth != null && otherRangeBoth.Count() > 0)
                    {
                        if (Rangetype == "Reference")
                        {
                            GetRefOtherRange(otherRangeBoth, "LastAttribute", rangeValue, out  domain);
                            if (domain == "A" || domain == "L")
                            {
                                return;
                            }
                        }
                        else
                        {
                            //LastAttribute.Value)
                            GetCommonRange(otherRangeBoth, "LastAttribute", rangeValue, out  domain);
                        }

                    }

                    if (otherRangeBothText != null && otherRangeBothText.Count() > 0)
                    {
                        if (Rangetype == "Reference")
                        {
                            GetRefOtherRangeText(otherRangeBothText, CatagoryAgeMain, "Both", code, rangeValue, out  domain);
                            if (domain == "A" || domain == "L")
                            {
                                return;
                            }
                        }
                        else
                        {
                            GetOtherRange(otherRangeBothText, CatagoryAgeMain, "Both", code, rangeValue, out  domain);
                        }
                    }
                }
            }
            else
            {
                if (commonRange != null && commonRange.Count() > 0)
                {
                    if (Rangetype == "Reference")
                    {
                        GetRefCommonRange(commonRange, rangeValue, out  domain);
                        if (domain == "A" || domain == "L")
                        {
                            return;
                        }
                    }
                    else
                    {
                        GetCommonRange(commonRange, "", rangeValue, out  domain);
                    }
                }

                if (commonRangeBoth != null && commonRangeBoth.Count() > 0)
                {
                    if (Rangetype == "Reference")
                    {
                        GetRefCommonRange(commonRangeBoth, rangeValue, out  domain);
                        if (domain == "A" || domain == "L")
                        {
                            return;
                        }
                    }
                    else
                    {
                        GetCommonRange(commonRangeBoth, "", rangeValue, out  domain);
                    }
                }


                if (otherRange != null && otherRange.Count() > 0)
                {
                    if (Rangetype == "Reference")
                    {
                        GetRefOtherRange(otherRange, "", rangeValue, out  domain);
                        if (domain == "A" || domain == "L")
                        {
                            return;
                        }
                    }
                    else
                    {
                        //LastAttribute.Value
                        GetCommonRange(otherRange, "LastAttribute", rangeValue, out  domain);
                    }
                }

                if (otherRangeBoth != null && otherRangeBoth.Count() > 0)
                {
                    if (Rangetype == "Reference")
                    {
                        GetRefOtherRange(otherRangeBoth, "LastAttribute", rangeValue, out  domain);
                        if (domain == "A" || domain == "L")
                        {
                            return;
                        }
                    }
                    else
                    {
                        //LastAttribute.Value)
                        GetCommonRange(otherRangeBoth, "LastAttribute", rangeValue, out  domain);
                    }

                }

                if (otherRangeText != null && otherRangeText.Count() > 0)
                {
                    if (Rangetype == "Reference")
                    {
                        GetRefOtherRangeText(otherRangeText, CatagoryAgeMain, pGender, code, rangeValue, out  domain);
                        if (domain == "A" || domain == "L")
                        {
                            return;
                        }
                    }
                    else
                    {
                        GetOtherRange(otherRangeText, CatagoryAgeMain, pGender, code, rangeValue, out  domain);
                    }
                }

                if (otherRangeBothText != null && otherRangeBothText.Count() > 0)
                {
                    if (Rangetype == "Reference")
                    {
                        GetRefOtherRangeText(otherRangeBothText, CatagoryAgeMain, "Both", code, rangeValue, out  domain);
                        if (domain == "A" || domain == "L")
                        {
                            return;
                        }
                    }
                    else
                    {
                        GetOtherRange(otherRangeBothText, CatagoryAgeMain, "Both", code, rangeValue, out  domain);
                    }
                }
            }
        }


        #endregion
    }
    //End

public void LogDataCalls(string Logdata)
    {
        try
        {
            object lockobj = new object();
            string ParameterCollections = string.Empty;
            string Formatstring = string.Empty;
            string DisplayType = "LogsData";
            Utilities objUtilities = new Utilities();
            string KeyValue = string.Empty;
            objUtilities.GetApplicationValue(DisplayType, out KeyValue);
            if (KeyValue == "Y")
            {
                //thisFolder-->"D:\\Application\\Solution\\WepApp\\App_Data\\09-May-2012" 
                string thisFolder = HttpContext.Current.Request.PhysicalApplicationPath + "App_Data\\" + System.DateTime.Now.ToString("dd-MMM-yyyy") + "";
                if (Directory.Exists(thisFolder) == false)
                {
                    Directory.CreateDirectory(thisFolder);
                }
                //fileName-->D:\\Application\\Solution\\WepApp\\App_Data\\09-May-2012\\DatabaseCalls_09-May-2012 13.txt
                string fileName = thisFolder + "\\LogsData" + System.DateTime.Now.ToString("dd-MMM-yyyy HH") + ".Txt";                
                DateTime Enddateandtime = DateTime.Now;                
                Formatstring = Enddateandtime.ToString("dd/MMM/yyyy HH.mm.ss") + " # " + Logdata.ToString() ;
                lock (lockobj)
                {
                    File.AppendAllText(fileName, Formatstring);
                    File.AppendAllText(fileName, Environment.NewLine);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("There is a problem in logging the database calls.", ex);
        }
    }

}
