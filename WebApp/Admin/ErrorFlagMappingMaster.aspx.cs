using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Data.OleDb;
using System.IO;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
//using Attune.Podium.DataAccessLayer;
using Attune.Solution.DAL;
using Attune.Solution.BusinessComponent;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml;
using System.Xml.Linq;
using System.Xml.XPath;
using System.Xml.Serialization;
using System.Drawing;

public partial class Admin_ErrorFlagMappingMaster : BasePage
{
    #region Properties
    const string cnstSsnErrorMapInfo = "ErrorFlagMappingInfo";
    const string cnstSsnInstrumentInfo = "InstrumentInfo";
    const string cnstSsnEditedErrorMapInfo = "EditedErrorFlagInfo";
    const string cnstSsnDeletedErrorMapInfo = "DeletedErrorFlagInfo";
    //const string cnstSsnIsEditMode = "IsEditMode";
    const int cnstClmnIndex_EqID = 2;
    const int cnstClmnIndex_ErrCode = 3;
    const int cnstAutoCompleteStartCharlen = 2;

    //key1-EquipmentID, key2-ErrorSymbol
    private Dictionary<long, Dictionary<string, DeviceErrorFlags>> ErrorMappintInfo = new Dictionary<long, Dictionary<string, DeviceErrorFlags>>();

    //private Dictionary<long, InstrumentInfoErrorFlag> InstrumnetInfo = new Dictionary<long, InstrumentInfoErrorFlag>();
    private Dictionary<long, InstrumentInfoErrorFlag> InstrumnetInfo = new Dictionary<long, InstrumentInfoErrorFlag>();

    //key - EquipmentID + | + ErrorCode,  val - ErrorCode
    private Dictionary<string, string> EditedItemSymbols = new Dictionary<string, string>();


    ////key - EquipmentID + | + ErrorCode,  val - ErrorCode
    //private Dictionary<string, string> DeletedItemSymbols = new Dictionary<string, string>();

    //private bool IsEditMode = false;

    internal int orgid
    {
        get
        {
            int tmp = base.OrgID;
            return tmp;
        }
    }

    internal int LocId
    {
        get
        {
            int tmp = base.ILocationID;
            return tmp;
        }
    }

    private int currentPageNo;

    #endregion Properties

    #region Methods

    #region Control Events
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                LoadBasic();
                LoadAllInstrumentInfo();
                LoadAllErrorFlagInfo();
                LoadMetaInstrumentName();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:GetData();", true);//Load Grid Items
            }
            else
            {
                InstrumnetInfo = (Dictionary<long, InstrumentInfoErrorFlag>)Session[cnstSsnInstrumentInfo];
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while page load", ex);
        }
    }

    protected void btn_AddErrorFlag_Click(object sender, EventArgs e)
    {
        ErrorMappintInfo = (Dictionary<long, Dictionary<string, DeviceErrorFlags>>)Session[cnstSsnErrorMapInfo];
        EditedItemSymbols = (Dictionary<string, string>)ViewState[cnstSsnEditedErrorMapInfo];

        if (EditedItemSymbols == null)
            EditedItemSymbols = new Dictionary<string, string>();

        DeviceErrorFlags errorFlagInfo = GetErrorFlagInfo();

        AddOrEditErrorFlagInfo(errorFlagInfo);

        string msg = "";
        if (!IsEditMode())
            msg = "Error Flag Mapping info Added..!";
        else
            msg = "Error Flag Mapping info Updated..!";

        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "script", "alert('" + msg + "');", true);
       
        Reset();
    }

    protected void btn_Save_Click(object sender, EventArgs e)
    {
        Save();
    }

    //protected void btnImport_Click(object sender, EventArgs e)
    //{
    //    if (ful_Import.HasFile)
    //    {
    //        if (ImportFromExcel())
    //            mpeGetPath.Hide();
    //    }

    //}

    protected void btn_Close_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Admin/Home.aspx");
    }

    protected void gv_EditErrorFlagInfo_Click(object sender, EventArgs e)
    {
        string id = ((LinkButton)(sender)).ID;

        GridViewRow row = (GridViewRow)((LinkButton)(sender)).NamingContainer;
        string eqpId = row.Cells[cnstClmnIndex_EqID].Text;
        string errorCode = row.Cells[cnstClmnIndex_ErrCode].Text.ToString();


        DeviceErrorFlags errorFlagInfo = GetErrorFlagInfo(eqpId, errorCode);
        if (errorFlagInfo == null)
            return;

        LoadControlForEdit(errorFlagInfo);

        //gv_ErrorMappingVal.DeleteRow(
    }

    protected void gv_DeleteErrorFlagInfo_Click(object sender, EventArgs e)
    {
        GridViewRow row = (GridViewRow)((LinkButton)(sender)).NamingContainer;
        string eqpId = row.Cells[cnstClmnIndex_EqID].Text.ToString();
        string errorCode = row.Cells[cnstClmnIndex_ErrCode].Text.ToString();


        DeviceErrorFlags errorFlagInfo = GetErrorFlagInfo(eqpId, errorCode);
        if (errorFlagInfo == null)
            return;

        DeleteErrorFlagInfo(errorFlagInfo.InstrumentID, errorFlagInfo.ErrorCode);
                
    }

    #endregion Control Events
    private void LoadBasic()
    {
        hdnOrgId.Value = this.OrgID.ToString();
        hdnILocID.Value = this.ILocationID.ToString();
    }

    private void LoadAllErrorFlagInfo()
    {
        ErrorMappintInfo = new Dictionary<long, Dictionary<string, DeviceErrorFlags>>();

        Master_BL oBL = new Master_BL(base.ContextInfo);

        List<DeviceErrorFlags> errorFlags = new List<DeviceErrorFlags>();
        errorFlags = oBL.GetAllErrorFlagInfo(orgid, LocId);
        if (errorFlags != null)
        {
            foreach (DeviceErrorFlags eMapInfo in errorFlags)
            {
                AddOrEditErrorFlagInfo(eMapInfo);
            }
        }
       
        //#endregion For Future Validtion
        Session[cnstSsnErrorMapInfo] = ErrorMappintInfo;
    }

    private void LoadAllInstrumentInfo()
    {
        InstrumnetInfo = new Dictionary<long, InstrumentInfoErrorFlag>();
        //var s = LocId;

        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('" + LocId.ToString() + "');", true);
        Master_BL oBL = new Master_BL(base.ContextInfo);
        var instruments = oBL.GetAllInstrumenrtInfo_BL(orgid, LocId);
        if (instruments != null)
        {
            //InstrumnetInfo.AddRange(instruments);

            foreach (InstrumentInfoErrorFlag instrumentInfo in instruments)
            {
                if (!InstrumnetInfo.ContainsKey(instrumentInfo.InstrumentID))
                    InstrumnetInfo.Add(instrumentInfo.InstrumentID, instrumentInfo);
            }
        }

        #region For Future Validtion
        StringBuilder str = new StringBuilder();
        for (int i = 0; i < instruments.Count; i++)
        {
            var obj = instruments[i];


            if (i != 0)
                str.Append(",");

            str.Append(obj.InstrumentID + "|" + obj.InstrumentName + "|" + obj.ProductCode);
        }
        hdnInstrumentKeys.Value = str.ToString();
        #endregion For Future Validtion
        
        Session[cnstSsnInstrumentInfo] = InstrumnetInfo;
    }   
    
    public void LoadMetaInstrumentName()
    {
        //AutoCompleteExtender1.ContextKey = txt_EqpName_Or_Code.Text + "~";
        //AutoCompleteExtender2.ContextKey = txt_EqpName_Or_Code.Text + "~";
    }

    private List<DeviceErrorFlags> GetErrorFlagInfoToLst(bool isNeedDeleteModeAlso)
    {
        List<DeviceErrorFlags> eMapLst = new List<DeviceErrorFlags>();
        for (int i = 0; i < ErrorMappintInfo.Count; i++)
        {
            var pKey = ErrorMappintInfo.ElementAt(i).Key;
            foreach (KeyValuePair<string, DeviceErrorFlags> Pair in ErrorMappintInfo[pKey])
            {
                if (!isNeedDeleteModeAlso && Pair.Value.operationType == ErrFlgOperationType.Delete)
                    continue;

                eMapLst.Add(Pair.Value);
            }
        }
        return eMapLst;
    }

    private void LoadControlForEdit(DeviceErrorFlags errorFlagInfo)
    {
        txt_EqpName_Or_Code.Text = errorFlagInfo.ProductName;
        hf_EqpName_Or_Code.Value = errorFlagInfo.InstrumentID.ToString();

        txt_Error_Code.Text = errorFlagInfo.ErrorCode;
        txt_Error_Desc.Text = errorFlagInfo.ErrorDescription;
        txt_ErrorRslt_Val.Text = errorFlagInfo.ResultValue;

        //this.IsEditMode = true;
        //ViewState[cnstSsnIsEditMode] = this.IsEditMode;
    }

    #region Get Basic Info

    private DeviceErrorFlags GetErrorFlagInfo()
    {

        DeviceErrorFlags info = new DeviceErrorFlags();

        InstrumentInfoErrorFlag instrumentInfo;
        if (FindInstrumentInfo(txt_EqpName_Or_Code.Text, out instrumentInfo))
        {
            info.ProductName = instrumentInfo.InstrumentName;
            info.InstrumentID = instrumentInfo.InstrumentID;
            info.DeviceCode = instrumentInfo.ProductCode;
            //info.EquipmentId = instrumentInfo.InstrumentID;
        }
        info.ErrorCode = txt_Error_Code.Text;
        info.ErrorDescription = txt_Error_Desc.Text;
        info.ResultValue = txt_ErrorRslt_Val.Text;
        info.OrgID = this.orgid;

        bool _isEditMode = IsEditMode();

        bool isNewlyAdded = false;
        if (_isEditMode)
        {
            if (ErrorMappintInfo.ContainsKey(info.InstrumentID) && ErrorMappintInfo[info.InstrumentID].ContainsKey(info.ErrorCode))
            {
                if (ErrorMappintInfo[info.InstrumentID][info.ErrorCode].operationType == ErrFlgOperationType.Add)
                    isNewlyAdded = true;
            }
        }

        if (_isEditMode && !isNewlyAdded)
        {
            info.operationType = ErrFlgOperationType.Modify;
        }
        else
        {
            info.operationType = ErrFlgOperationType.Add;
        }
        return info;

    }

    private bool IsEditMode()
    {
        bool _isEditMode = false;
        if (hdnIsEditMode.Value == "1" && hdnEditId.Value != "")
            _isEditMode = true;

        return _isEditMode;
    }

    private bool FindInstrumentInfo(string eqFindStr, out InstrumentInfoErrorFlag instrumentInfo)
    {
        instrumentInfo = null;

        var searchStr = eqFindStr.ToUpper();
        foreach (KeyValuePair<long, InstrumentInfoErrorFlag> pair in InstrumnetInfo)
        {
            var obj = pair.Value;

            if (obj.InstrumentName.ToUpper() == searchStr || obj.ProductCode.ToUpper() == searchStr)
            {
                instrumentInfo = obj;
                return true;
            }
        }

        return false;
    }

    private bool FindInstrumentInfo(out InstrumentInfoErrorFlag instrumentInfo)
    {
        instrumentInfo = null;

        //instrumentInfo = InstrumnetInfo.Find(I => I.ProductCode == eqFindStr || I.InstrumentName == eqFindStr);
        //if (instrumentInfo != null)
        //    return true;
        var idStr = hf_EqpName_Or_Code.Value;
        long id;
        if (!long.TryParse(idStr.ToString(), out id))
            return false;

        if (!InstrumnetInfo.ContainsKey(id))
            return false;

        instrumentInfo = InstrumnetInfo[id];
        return true;
    }

    private string GetKeyForEditErrorInfo(DeviceErrorFlags errorFlagInfo)
    {
        return GetKeyForEditErrorInfo(errorFlagInfo.InstrumentID.ToString(), errorFlagInfo.ErrorCode);
    }

    private string GetKeyForEditErrorInfo(string eqipId, string errorCode)
    {
        return DeviceErrorFlags.GetDeviceErrorFlagId(eqipId, errorCode);
        //string speperetor = "|";
        //return eqipId + speperetor + errorCode;
    }

    #endregion Get Basic Info

    #region Add/Edit/Delete
    private void AddOrEditErrorFlagInfo(DeviceErrorFlags errorFlagInfo)
    {
        #region Add/Edit

        string key = GetKeyForEditErrorInfo(errorFlagInfo);
        bool _isEditMode = IsEditMode();
        if (_isEditMode && errorFlagInfo.operationType == ErrFlgOperationType.Modify)
        {
            #region Edit


            #region To Remove existing item - if change error codeinstrument Id

            var array = hdnEditId.Value.ToString().Split('|');

            long old_iId;
            long.TryParse(array[0], out old_iId);
            string old_errorCode = array[1];

            if (old_iId != errorFlagInfo.InstrumentID || old_errorCode != errorFlagInfo.ErrorCode)
            {
                ErrorMappintInfo[old_iId].Remove(old_errorCode);
            }
            #endregion remove existing item

            if (!EditedItemSymbols.ContainsKey(key))
            {
                EditedItemSymbols.Add(key, errorFlagInfo.ErrorCode);
                ViewState[cnstSsnEditedErrorMapInfo] = EditedItemSymbols;
            }
            #endregion Edit
        }

        #region Add/Modify
        if (ErrorMappintInfo.ContainsKey(errorFlagInfo.InstrumentID))
        {
            if (!ErrorMappintInfo[errorFlagInfo.InstrumentID].ContainsKey(errorFlagInfo.ErrorCode))
                ErrorMappintInfo[errorFlagInfo.InstrumentID].Add(errorFlagInfo.ErrorCode, errorFlagInfo);
            else
                ErrorMappintInfo[errorFlagInfo.InstrumentID][errorFlagInfo.ErrorCode] = errorFlagInfo;
        }
        else
        {
            ErrorMappintInfo.Add(errorFlagInfo.InstrumentID, new Dictionary<string, DeviceErrorFlags>() { { errorFlagInfo.ErrorCode, errorFlagInfo } });
        }
        #endregion Add/Modify

        Session[cnstSsnErrorMapInfo] = ErrorMappintInfo;
        #endregion Add/Edit
    }

    private void DeleteErrorFlagInfo(long eqpId, string errorCode)
    {
        string key = GetKeyForEditErrorInfo(eqpId.ToString(), errorCode);
        if (ErrorMappintInfo.ContainsKey(eqpId) && ErrorMappintInfo[eqpId].ContainsKey(errorCode))
        {
            //ErrorMappintInfo[eqpId].Remove(symbol);
            ErrorMappintInfo[eqpId][errorCode].operationType = ErrFlgOperationType.Delete;

            //if (DeletedItemSymbols.ContainsKey(key))
            //    DeletedItemSymbols.Add(key, errorCode);

            Session[cnstSsnErrorMapInfo] = ErrorMappintInfo;
            //ViewState[cnstSsnDeletedErrorMapInfo] = DeletedItemSymbols;
        }


    }

    #endregion Add/Edit/Delete

    private DeviceErrorFlags GetErrorFlagInfo(string eqpIdStr, string errorCode)
    {
        long eqId = 0;
        if (!long.TryParse(eqpIdStr, out eqId))
            return null;

        if (ErrorMappintInfo.ContainsKey(eqId) && ErrorMappintInfo[eqId].ContainsKey(errorCode))
            return ErrorMappintInfo[eqId][errorCode];

        return null;
    }

    private void Save()
    {
        try
        {
            ErrorMappintInfo = (Dictionary<long, Dictionary<string, DeviceErrorFlags>>)Session[cnstSsnErrorMapInfo];
            EditedItemSymbols = (Dictionary<string, string>)ViewState[cnstSsnEditedErrorMapInfo];
            //DeletedItemSymbols = (Dictionary<string, string>)ViewState[cnstSsnDeletedErrorMapInfo];

            bool isNeedDeleteModeAlso = true;
            List<DeviceErrorFlags> eMapLst = GetErrorFlagInfoToLst(isNeedDeleteModeAlso);

            Master_BL oBL = new Master_BL(base.ContextInfo);
            oBL.SaveErrorFlagMapping_BL(orgid, eMapLst);

            for (int i = 0; i < ErrorMappintInfo.Count; i++)
            {
                var sub = ErrorMappintInfo.ElementAt(i).Value;
                for (int j = 0; j < sub.Count; j++)
                {
                    var obj = sub.ElementAt(j).Value;
                    if (obj.operationType != ErrFlgOperationType.Delete)
                        obj.operationType = ErrFlgOperationType.None;
                }
            }

            //Response.Write("<script>alert('Error Flag Mapping info saved successfully..');</script>");

            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "script", "alert('Error Flag Mapping info saved successfully..!');", true);

            EditedItemSymbols = new Dictionary<string, string>();
            ViewState[cnstSsnEditedErrorMapInfo] = EditedItemSymbols;
            Session[cnstSsnErrorMapInfo] = ErrorMappintInfo;
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Error Flag Mapping info saved successfully..');", true);

            //var str = "Error Flag Mapping info saved successfully..";
            ////ScriptManager.RegisterStartupScript(this.GetType(), "alert", "Error Flag Mapping info saved successfully..");
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "ShowAlertMsg('" + str + "')", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Save Error Flag mapping Info", ex);
        }
    }

    private void Reset()
    {
        txt_EqpName_Or_Code.Text = "";
        txt_Error_Code.Text = "";
        txt_Error_Desc.Text = "";
        txt_ErrorRslt_Val.Text = "";
        btn_AddErrorFlag.Text = "Add";

        hf_EqpName_Or_Code.Value = "";
        hdnEditId.Value = "";
        hdnIsEditMode.Value = "0";
        //ViewState[cnstSsnIsEditMode] = this.IsEditMode;
    }

    #region Import/Export

    #region Import
    //private bool ImportFromExcel()
    //{
    //    ErrorMappintInfo = (Dictionary<long, Dictionary<string, DeviceErrorFlag>>)Session[cnstSsnErrorMapInfo];

    //    DataTable dt;
    //    if (!GetExcelAsDataTbl(out dt))
    //    {
    //        ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('Unable to Import File..');", true);

    //        return false;
    //    }


    //    StringBuilder errorStr;
    //    if (!IsValidExcelFile(dt, out errorStr))
    //    {
    //        ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('" + errorStr.ToString() + "');", true);
    //        return false;
    //    }

    //    LoadErrorInfoFromDataTable(dt);

    //    Session[cnstSsnErrorMapInfo] = ErrorMappintInfo;
        
    //    return true;
    //}

    //private bool GetExcelAsDataTbl(out DataTable xlTbl)
    //{
    //    xlTbl = new DataTable();

    //    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:openfileDialog();", true);

    //    string path = "";

    //    if (ful_Import.HasFile)
    //    {
    //        path = System.IO.Path.GetFullPath(ful_Import.PostedFile.FileName);
    //        path = System.IO.Path.GetFileName(ful_Import.PostedFile.FileName).ToLower();
    //    }

    //    if (string.IsNullOrEmpty(path))
    //        return false;

    //    try
    //    {
    //        if (!GetDataTableFromCSV(path, out xlTbl))
    //            return false;

    //        return true;
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Import DeviceCodeMapping", ex);
    //        return false;
    //    }
    //}

    //private bool IsValidExcelFile(DataTable tbl, out StringBuilder str)
    //{
    //    int clmnCnt = 6;

    //    str = new StringBuilder();
    //    if (tbl == null)
    //    {
    //        str.Append("Datas are Empty");
    //        return false;
    //    }

    //    if (tbl.Columns.Count != clmnCnt)
    //    {
    //        str.Append("Invalid Column Count");
    //        return false;
    //    }

    //    string productName = "";
    //    bool isheaderOver = false;
    //    foreach (DataRow row in tbl.Rows)
    //    {
    //        if (!isheaderOver)
    //        {
    //            isheaderOver = true;
    //            continue;
    //        }

    //        //string[] mandatoryFlds=new string[] {0,1,2,3,}
    //        for (int i = 0; i < clmnCnt; i++)
    //        {
    //            var val = row.ItemArray[i];

    //            if (val == null)
    //            {
    //                str.Append("Cell Value Should Not Empty..");
    //                return false;
    //            }

    //            var valStr = val.ToString();

    //            //string iCode="";

    //            switch (i)
    //            {
    //                case 0:
    //                    int v = 0;
    //                    if (!int.TryParse(valStr, out v))
    //                    {
    //                        str.Append("Invalid S.No Value..");
    //                        return false;
    //                    }
    //                    break;
    //                case 1:
    //                    if (string.IsNullOrEmpty(valStr) || valStr.Trim().Length == 0)
    //                    {
    //                        str.Append("Invalid Equipment Name Value..");
    //                        return false;
    //                    }
    //                    productName = valStr;
    //                    break;

    //                case 2:
    //                    if (string.IsNullOrEmpty(valStr) || valStr.Trim().Length == 0)
    //                    {
    //                        str.Append("Invalid Equipment Code..");
    //                        return false;
    //                    }

    //                    bool isAvail = false;
    //                    for (int j = 0; j < InstrumnetInfo.Count; j++)
    //                    {
    //                        var obj = InstrumnetInfo.ElementAt(j).Value;
    //                        if (obj.InstrumentName == productName || obj.ProductCode == valStr)
    //                        {
    //                            isAvail = true;
    //                            break;
    //                        }
    //                    }
    //                    if (!isAvail)
    //                    {
    //                        str.Append("Invalid Equipment Info..");
    //                        return false;
    //                    }
    //                    break;

    //                case 3:
    //                    if (string.IsNullOrEmpty(valStr) || valStr.Trim().Length == 0)
    //                    {
    //                        str.Append("Invalid Error Code..");
    //                        return false;
    //                    }

    //                    InstrumentInfoErrorFlag iObj;
    //                    if (!FindInstrumentInfo(productName, out iObj))
    //                    {
    //                        str.Append("Invalid Instrunemt Info..");
    //                        return false;
    //                    }

    //                    if (ErrorMappintInfo.ContainsKey(iObj.InstrumentID) && ErrorMappintInfo[iObj.InstrumentID].ContainsKey(valStr))
    //                    {
    //                        str.Append("EquipmentName-'" + productName + "' and EquipmentCode-'" + valStr + "' already available.. So process is terminated..");
    //                        return false;
    //                    }
    //                    break;
    //                case 4:
    //                    if (string.IsNullOrEmpty(valStr) || valStr.Trim().Length == 0)
    //                    {
    //                        str.Append("Invalid Error Description..");
    //                        return false;
    //                    }
    //                    break;
    //                case 5:
    //                    if (string.IsNullOrEmpty(valStr) || valStr.Trim().Length == 0)
    //                    {
    //                        str.Append("Invalid Result Value..");
    //                        return false;
    //                    }

    //                    string ptrn = @"[a-zA-Z]";

    //                    if (string.IsNullOrEmpty(valStr) || valStr.Trim().Length == 0)
    //                    {
    //                        str.Append("Invalid Result Value..");
    //                        return false;
    //                    }
    //                    if (!System.Text.RegularExpressions.Regex.IsMatch(valStr, ptrn))
    //                    {
    //                        str.Append("Result Value should be in Alphabets..");
    //                        return false;
    //                    }
    //                    break;
    //                default:
    //                    break;
    //            }
    //        }
    //    }
    //    return true;
    //}

    private void LoadErrorInfoFromDataTable(DataTable dt)
    {
        foreach (DataRow row in dt.Rows)
        {
            DeviceErrorFlags def = new DeviceErrorFlags();
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                var val = row.ItemArray[i];
                switch (i)
                {
                    case 0:
                        def.SNO = int.Parse(val.ToString());
                        break;
                    case 1:
                        def.ProductName = val.ToString().Trim();
                        break;
                    case 2:
                        def.DeviceCode = val.ToString().Trim();
                        break;
                    case 3:
                        def.ErrorCode = val.ToString().Trim();
                        break;
                    case 4:
                        def.ErrorDescription = val.ToString().Trim();
                        break;
                    case 5:
                        def.ResultValue = val.ToString().Trim();
                        break;

                    default:

                        break;
                }


            }

            def.OrgID = this.orgid;
            for (int j = 0; j < InstrumnetInfo.Count; j++)
            {
                var obj = InstrumnetInfo.ElementAt(j).Value;
                if (obj.InstrumentName == def.ProductName && obj.ProductCode != def.DeviceCode)
                {
                    def.InstrumentID = obj.InstrumentID;
                }
            }
            def.operationType = ErrFlgOperationType.Add;

            AddOrEditErrorFlagInfo(def);
        }


    }

    private bool GetDataTableFromCSV(string path, out DataTable dt)
    {
        dt = new DataTable();
        try
        {
            string fileName = path;

            string extension = "";
            int pos = path.LastIndexOf(".");
            if (pos != -1)
            {
                extension = path.Substring(pos, 4);
            }
            if (extension.ToLower() != ".csv")
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ScriptKey", "alert('Invalid File Format. Please Check!'); ", true);
                return false;
            }
            //else
            //{
            //    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ScriptKey", "alert('Invalid File Format. Please Check!'); ", true);
            //    alertmessage();
            //    return;
            //}
            string DatetimeNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("yyyyMMddHHmmssfff");
            fileName = fileName.Replace(".csv", "") + "_" + DatetimeNow + extension;
            string newfilepath = Server.MapPath("~/ExcelTest/" + fileName);
            ful_Import.SaveAs(newfilepath);

            string full = System.IO.Path.GetFullPath(newfilepath);
            string tempfull = newfilepath;
            string file = System.IO.Path.GetFileName(full);
            string dir = System.IO.Path.GetDirectoryName(full);
            string temp = newfilepath;

            temp = temp.Replace(".csv", ".txt");
            System.IO.File.Move(full, temp.Replace(".csv", ".txt"));
            full = temp;

            //Change File Name here

            fileName = fileName.Replace(".csv", ".txt");
            //CacheTempFull = full;
            //CacheTempFileName = fileName;
            dt = ReadCsvFile(full, "test", ",");

            return true;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable ReadCsvFile(string File, string TableName, string delimiter)
    {

        //The DataSet to Return
        DataTable result = new DataTable();

        //Open the file in a stream reader.
        StreamReader sReader = new StreamReader(File);

        //Split the first line into the columns       
        string[] columns = sReader.ReadLine().Split(delimiter.ToCharArray());

        //Cycle the colums, adding those that don't exist yet 
        //and sequencing the one that do.
        foreach (string col in columns)
        {
            bool added = false;
            string next = "";
            int i = 0;
            while (!added)
            {
                //Build the column name and remove any unwanted characters.
                string columnname = col + next;
                columnname = columnname.Replace("#", "");
                columnname = columnname.Replace("'", "");
                columnname = columnname.Replace("&", "");

                //See if the column already exists
                if (!result.Columns.Contains(columnname))
                {
                    //if it doesn't then we add it here and mark it as added
                    result.Columns.Add(columnname);
                    added = true;
                }
                else
                {
                    //if it did exist then we increment the sequencer and try again.
                    i++;
                    next = "_" + i.ToString();
                }
            }
        }

        //Read the rest of the data in the file.        
        string AllData = sReader.ReadToEnd();

        //Split off each row at the Carriage Return/Line Feed
        //Default line ending in most windows exports.  
        //You may have to edit this to match your particular file.
        //This will work for Excel, Access, etc. default exports.
        string[] rows = AllData.Split("\r\n".ToCharArray());

        //Now add each row to the DataSet        
        foreach (string r in rows)
        {
            if (!string.IsNullOrEmpty(r))
            {
                //Split the row at the delimiter.
                string[] items = r.Split(delimiter.ToCharArray());
                //Add the item
                result.Rows.Add(items);
            }
        }

        // int val = Convert.ToInt16("dsfsdf");

        sReader.Close();

        //Return the imported data.  


        return result;
    }
    #endregion Import

    #region Export
    private void ExportToExcel()
    {
        ErrorMappintInfo = (Dictionary<long, Dictionary<string, DeviceErrorFlags>>)Session[cnstSsnErrorMapInfo];

        List<DeviceErrorFlags> lstDEF = GetErrorFlagInfoToLst(false);
        DataTable tbl = ToDataTable(lstDEF);
        string prefix = string.Empty;
        prefix = "DeviceErrorFlag_";
        string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";

        //DataSet dsrpt = (DataSet)ViewState["report"];
        if (tbl != null)
        {
            Attune.Podium.ExcelExportManager.ExcelHelper.ToExcel(tbl, rptDate, Page.Response);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('Device Flag Info Exported..');", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('Unable to Export..');", true);
        }
    }

    public DataTable ToDataTable(List<DeviceErrorFlags> lstDEF)
    {
        string fn_SNO = "SNO";
        string fn_EqpmntName = "EquipmentName";
        string fn_EqpmntCode = "EquipmentCode";
        string fn_ErrCode = "ErrorCodeSendFromInstrument";
        string fn_ErrDesc = "ErrorDescription";
        string fn_EResult = "ResultValue";

        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn(fn_SNO));
        dt.Columns.Add(new DataColumn(fn_EqpmntName));
        dt.Columns.Add(new DataColumn(fn_EqpmntCode));
        dt.Columns.Add(new DataColumn(fn_ErrCode));
        dt.Columns.Add(new DataColumn(fn_ErrDesc));
        dt.Columns.Add(new DataColumn(fn_EResult));

        if (lstDEF.Count != 0)
        {
            int cnt = 0;
            foreach (DeviceErrorFlags item in lstDEF)
            {
                DataRow dr = dt.NewRow();
                dr[fn_SNO] = cnt++;
                dr[fn_EqpmntName] = item.ProductName;
                dr[fn_EqpmntCode] = item.DeviceCode;
                dr[fn_ErrCode] = item.ErrorCode;
                dr[fn_ErrDesc] = item.ErrorDescription;
                dr[fn_EResult] = item.ResultValue;

                dt.Rows.Add(dr);
            }
        }
        else
            dt.Rows.Add();

        return dt;
    }
    #endregion Export

    private DataTable GetDataTable(string sql, string connectionString)
    {
        DataTable dt = null;

        try
        {
            System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection(connectionString);
            conn.Open();
            dt = conn.GetOleDbSchemaTable(System.Data.OleDb.OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });
            return dt;
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }


    #endregion Import/Export
    #endregion Methods

    protected void gv_ErrorMappingVal_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            //gv_ErrorMappingVal.PageIndex = e.NewPageIndex;
            // Added by Perumal on 29 Oct 2011 - Start
            currentPageNo = e.NewPageIndex + 1;
            // Added by Perumal on 29 Oct 2011 - End

            ErrorMappintInfo = (Dictionary<long, Dictionary<string, DeviceErrorFlags>>)Session[cnstSsnErrorMapInfo];
            if (ErrorMappintInfo == null)
                return;
        }        
    }

    protected void lbtn_Export_ErrorMapping_Click(object sender, EventArgs e)
    {
        ExportToExcel();
    }

    public void lbtn_Import_ErrorMapping_Click(object sender, EventArgs e)
    {

        //System.Threading.Thread.Sleep(5000);
        //ImportFromExcel();
        mpeGetPath.Show();//a
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        //required to avoid the run time error "  
        //Control 'GridView1' of type 'Grid View' must be placed inside a form tag with runat=server."  
    } 
}

