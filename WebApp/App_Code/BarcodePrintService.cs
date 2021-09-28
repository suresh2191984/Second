using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;

/// <summary>
/// Summary description for BarcodePrintService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class BarcodePrintService : System.Web.Services.WebService
{

    public BarcodePrintService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod(EnableSession = true)]
    public void GetBarcodePrintDetails(Int32 OrgID, Int64 OrgAddressID, String MachineID, out List<BarcodeAttributes> lstBarcodeAttributes)
    {
        long returnCode = -1;
        lstBarcodeAttributes = new List<BarcodeAttributes>();
        try
        {
            GateWay objGateWay = new GateWay();
            returnCode = objGateWay.GetBarcodePrintJobDetails(OrgID, OrgAddressID, MachineID, out lstBarcodeAttributes);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetBarcodePrintDetails", ex);
        }
    }

    [WebMethod(EnableSession = true)]
    public BarcodeAttributes[] GetBarcodeDetails(string BatchNo)
    {
        long returnCode = -1;
        List<BarcodeAttributes> lstBarcodeAttributes = new List<BarcodeAttributes>();
        try
        {
            GateWay objGateWay = new GateWay();
            returnCode = objGateWay.GetBarcodeDetails(BatchNo, out lstBarcodeAttributes);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetBarcodeDetails", ex);
        }
        return lstBarcodeAttributes.ToArray();
    }

    [WebMethod(EnableSession = true)]
    public long UpdateBarcodePrintStatus1(List<BarcodeAttributes> lstBarcodeAttributes, Int32 OrgID, Int64 OrgAddressID, String MachineID)
    {
        int returnStatus = -1;
        try
        {
            GateWay objGateWay = new GateWay();
            //objGateWay.UpdateBarcodePrintStatusDetails(OrgID, OrgAddressID, MachineID, lstBarcodeAttributes, out returnStatus);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in UpdateBarcodePrintStatus", ex);
        }
        return returnStatus;
    }

    [WebMethod(EnableSession = true)]
    public long UpdateBarcodePrintStatus(String ID)
    {
        int returnStatus = -1;
        try
        {
            GateWay objGateWay = new GateWay();
            objGateWay.UpdateBarcodePrintStatus(ID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in UpdateBarcodePrintStatus", ex);
        }
        return returnStatus;
    }

}

