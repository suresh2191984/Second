<%@ WebHandler Language="C#" Class="setAction" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.PlatForm.Common;
using System.Web.SessionState;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.BL;


public class setAction : IHttpHandler, IReadOnlySessionState
{

    string hdnLocationID, hdnTolocationID, hdnStatus, InventoryLocationID, strRoleID = string.Empty;
    string IsTransfer = string.Empty;
   
    string IsSubstoreReturn = string.Empty;
   
    string IndentType = string.Empty;
    string l1, l2, l3 = string.Empty;

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";

        hdnLocationID = context.Request.QueryString["hdnLocationID"];
        hdnTolocationID = context.Request.QueryString["hdnTolocationID"];
        hdnStatus = context.Request.QueryString["hdnStatus"];
        InventoryLocationID = context.Request.QueryString["InventoryLocationID"];
        strRoleID = context.Request.QueryString["RoleID"];
        IsTransfer = context.Request.QueryString["IsTransfer"];
       
        IsSubstoreReturn = context.Request.QueryString["IsSubStoreReturn"];
       
        IndentType = context.Request.QueryString["InventoryIndentType"];
        List<ActionMaster> lstActionMaster = new List<ActionMaster>();
        long returnCode = 0;
        if (!string.IsNullOrEmpty(context.Session["RoleID"].ToString()))
        {
            if (IsTransfer=="Y")
            {
                returnCode = new ActionManager_BL(new Attune_BaseClass().ContextInfo).GetActions(Int64.Parse(context.Session["RoleID"].ToString()), (int)TaskHelper.SearchType.StockIssueType, out lstActionMaster);

            }
            else if (IsSubstoreReturn == "Y")
            {
                returnCode = new ActionManager_BL(new Attune_BaseClass().ContextInfo).GetActions(Int64.Parse(context.Session["RoleID"].ToString()), (int)TaskHelper.SearchType.SubstoreReturnSearch, out lstActionMaster);
            }
            else
            {
                returnCode = new ActionManager_BL(new Attune_BaseClass().ContextInfo).GetActions(Int64.Parse(context.Session["RoleID"].ToString()), (int)TaskHelper.SearchType.IntendSearch, out lstActionMaster);
            }
        }
        List<ActionMaster> lstActionMaster_pos = new List<ActionMaster>();

        if (!lstActionMaster.Equals(null))
        {
            if (lstActionMaster.Count > 0)
            {
                
                if (IsSubstoreReturn == "Y")
                {

                    if (hdnTolocationID == InventoryLocationID.ToString() && hdnStatus == "Pending")
                    {
                        lstActionMaster_pos = lstActionMaster.FindAll(P => (P.ActionCode == "Approved") || (P.ActionCode == "View SubStoreReturn"));
                        foreach (ActionMaster src in lstActionMaster_pos)
                        {
                            if ((src.ActionCode == "Approved"))
                            {
                                l1 += src.ActionName + '@';
                                l2 += "/StockIntend/SubStoreReturnDetail.aspx" + "~" + src.ActionID + '@';
                                l3 += src.ActionCode.Trim() + '@';
                            }
                            if ((src.ActionCode == "View SubStoreReturn"))
                            {
                                l1 += src.ActionName + '@';
                                l2 += "/StockIntend/ViewSubStoreStockdetails.aspx" + "~" + src.ActionID + '@';
                                l3 += src.ActionCode.Trim() + '@';
                            }
                        }
                    }
                    else
                    {
                        lstActionMaster_pos = lstActionMaster.FindAll(P => (P.ActionCode == "View SubStoreReturn"));
                        foreach (ActionMaster src in lstActionMaster_pos)
                        {
                            if ((src.ActionCode == "View SubStoreReturn"))
                            {
                                l1 += src.ActionName + '@';
                                l2 += "/StockIntend/ViewSubStoreStockdetails.aspx" + "~" + src.ActionID + '@';
                                l3 += src.ActionCode.Trim() + '@';
                            }
                        }
                    }


                    if (!string.IsNullOrEmpty(l1) && l1.Length > 0)
                    {
                        l1 = l1.Substring(0, (l1.Length - 1));
                    }
                    if (!string.IsNullOrEmpty(l2) && l2.Length > 0)
                    {
                        l2 = l2.Substring(0, (l2.Length - 1));
                    }
                    if (!string.IsNullOrEmpty(l3) && l3.Length > 0)
                    {
                        l3 = l3.Substring(0, (l3.Length - 1));
                    }
                    context.Response.Write(l1 + '|' + l2 + '|' + l3);
                }
                //end
                else
                {
                    //end
                if (hdnTolocationID == InventoryLocationID.ToString() && hdnStatus == "Pending")
                {
                    lstActionMaster_pos = lstActionMaster.FindAll(P => (P.ActionCode == "View Intend") || (P.ActionCode == "Approve Intend"));
                    foreach (ActionMaster src in lstActionMaster_pos)
                    {
                        if ((src.ActionCode == "View Intend"))
                        {
                            l1 += src.ActionName + '@';
                            l2 += "/StockIntend/ViewIssuedIndentdetails.aspx" + "~" + src.ActionID + '@';
                            l3 += src.ActionCode.Trim() + '@';

                        }

                        else if ((src.ActionCode == "Approve Intend"))
                        {
                            l1 += src.ActionName + '@';
                            l2 += "/StockIntend/ViewIntendDetail.aspx" + "~" + src.ActionID + '@';
                            l3 += src.ActionCode.Trim() + '@';
                        }
                    }
                }
                else if (hdnLocationID == InventoryLocationID.ToString() && ((hdnStatus == "Approved") || (hdnStatus == "Pending")))
                {
                    int orgid = int.Parse(context.Session["OrgID"].ToString());
                    if (hdnStatus.Equals("Pending") && !GetInventoryConfigDetailsValue("Required_intend_Approval", orgid,0).Equals("Y"))
                    {
                        lstActionMaster_pos = lstActionMaster.FindAll(P => (P.ActionCode == "Issue Intend") || (P.ActionCode == "View Intend"));
                        foreach (ActionMaster src in lstActionMaster_pos)
                        {
                            if ((src.ActionCode == "Issue Intend"))
                            {
                                l1 += src.ActionName + '@';
                                l2 += "/StockIntend/IssueStock.aspx" + "~" + src.ActionID + '@';
                                l3 += src.ActionCode.Trim() + '@';
                            }
                            else if ((src.ActionCode == "View Intend"))
                            {
                                l1 += src.ActionName + '@';
                                l2 += "/StockIntend/ViewIssuedIndentdetails.aspx" + "~" + src.ActionID + '@';
                                l3 += src.ActionCode.Trim() + '@';
                            }
                        }
                    }
                    else if (hdnStatus.Equals("Approved"))
                    {
                        lstActionMaster_pos = lstActionMaster.FindAll(P => (P.ActionCode == "Issue Intend") || (P.ActionCode == "View Intend"));
                        foreach (ActionMaster src in lstActionMaster_pos)
                        {
                            if ((src.ActionCode == "Issue Intend"))
                            {
                                l1 += src.ActionName + '@';
                                l2 += "/StockIntend/IssueStock.aspx" + "~" + src.ActionID + '@';
                                l3 += src.ActionCode.Trim() + '@';
                            }
                            else if ((src.ActionCode == "View Intend"))
                            {
                                l1 += src.ActionName + '@';
                                l2 += "/StockIntend/ViewIssuedIndentdetails.aspx" + "~" + src.ActionID + '@';
                                l3 += src.ActionCode.Trim() + '@';
                            }
                        }
                    }
                    else
                    {
                        lstActionMaster_pos = lstActionMaster.FindAll(P => (P.ActionCode == "View Intend"));
                        foreach (ActionMaster src in lstActionMaster_pos)
                        {
                            if ((src.ActionCode == "View Intend"))
                            {
                                l1 += src.ActionName + '@';
                                l2 += "/StockIntend/ViewIssuedIndentdetails.aspx" + "~" + src.ActionID + '@';
                                l3 += src.ActionCode.Trim() + '@';
                            }
                        } 
                    }
                }
                else if (hdnLocationID == InventoryLocationID.ToString() && hdnStatus == "Issued")
                {
                    lstActionMaster_pos = lstActionMaster.FindAll(P => (P.ActionCode == "View Intend"));
                    foreach (ActionMaster src in lstActionMaster_pos)
                    {
                        if ((src.ActionCode == "View Intend"))
                        {
                            l1 += src.ActionName + '@';
                            l2 += "/StockIntend/ViewIssuedIndentdetails.aspx" + "~" + src.ActionID + '@';
                            l3 += src.ActionCode.Trim() + '@';
                        }
                    }
                }
                else if ((hdnTolocationID == InventoryLocationID.ToString()) && (hdnStatus == "Issued" || hdnStatus == "Partial Issued"))
                {
                    lstActionMaster_pos = lstActionMaster.FindAll(P => (P.ActionCode == "View Intend") || (P.ActionCode == "Received Indent"));
                    if (IndentType != "0")
                    {
                        foreach (ActionMaster src in lstActionMaster_pos)
                        {
                            if ((src.ActionCode == "View Intend"))
                            {
                                l1 += src.ActionName + '@';
                                l2 += "/StockIntend/ViewIssuedIndentdetails.aspx" + "~" + src.ActionID + '@';
                                l3 += src.ActionCode.Trim() + '@';
                            }
                            else if ((src.ActionCode == "Received Indent"))
                            {
                                l1 += src.ActionName + '@';
                                l2 += "/StockIntend/ReceivedIndent.aspx" + "~" + src.ActionID + '@';
                                l3 += src.ActionCode.Trim() + '@';
                            }
                        }
                    }
                    else
                    {
                        foreach (ActionMaster src in lstActionMaster_pos)
                        {
                            if ((src.ActionCode == "View Intend"))
                            {
                                l1 += src.ActionName + '@';
                                l2 += "/StockIntend/ViewIssuedIndentdetails.aspx" + "~" + src.ActionID + '@';
                                l3 += src.ActionCode.Trim() + '@';
                            }
                        }

                    }
                }
                else if (hdnLocationID == InventoryLocationID.ToString() && hdnStatus == "Partial Issued")
                {
                    lstActionMaster_pos = lstActionMaster.FindAll(P => (P.ActionCode == "View Intend") || (P.ActionCode == "Issue Intend"));
                    foreach (ActionMaster src in lstActionMaster_pos)
                    {
                        if ((src.ActionCode == "View Intend"))
                        {
                            l1 += src.ActionName + '@';
                            l2 += "/StockIntend/ViewIssuedIndentdetails.aspx" + "~" + src.ActionID + '@';
                            l3 += src.ActionCode.Trim() + '@';
                        }
                        else if ((src.ActionCode == "Issue Intend"))
                        {
                            l1 += src.ActionName + '@';
                            l2 += "/StockIntend/IssueStock.aspx" + "~" + src.ActionID + '@';
                            l3 += src.ActionCode.Trim() + '@';
                        }
                    }
                }
                else if (hdnTolocationID == InventoryLocationID.ToString() && hdnStatus == "Received")
                {
                    lstActionMaster_pos = lstActionMaster.FindAll(P => (P.ActionCode == "View Intend"));
                    foreach (ActionMaster src in lstActionMaster_pos)
                    {
                        if ((src.ActionCode == "View Intend"))
                        {
                            l1 += src.ActionName + '@';
                            l2 += "/StockIntend/ViewIssuedIndentdetails.aspx" + "~" + src.ActionID + '@';
                            l3 += src.ActionCode.Trim() + '@';
                        }
                    }
                }
                else if (hdnLocationID == InventoryLocationID.ToString() && hdnStatus == "Pending")
                {
                    lstActionMaster_pos = lstActionMaster.FindAll(P => (P.ActionCode == "View Intend") || (P.ActionCode == "Issue Intend"));
                    foreach (ActionMaster src in lstActionMaster_pos)
                    {
                        if ((src.ActionCode == "View Intend"))
                        {
                            l1 += src.ActionName + '@';
                            l2 += "/StockIntend/ViewIssuedIndentdetails.aspx" + "~" + src.ActionID + '@';
                            l3 += src.ActionCode.Trim() + '@';
                        }
                        else if ((src.ActionCode == "Issue Intend"))
                        {
                            l1 += src.ActionName + '@';
                            l2 += "/StockIntend/IssueStock.aspx" + "~" + src.ActionID + '@';
                            l3 += src.ActionCode.Trim() + '@';
                        }
                    }
                }
                else
                {
                    lstActionMaster_pos = lstActionMaster.FindAll(P => (P.ActionCode == "View Intend"));
                    foreach (ActionMaster src in lstActionMaster_pos)
                    {
                        if ((src.ActionCode == "View Intend"))
                        {
                            l1 += src.ActionName + '@';
                            l2 += "/StockIntend/ViewIssuedIndentdetails.aspx" + "~" + src.ActionID + '@';
                            l3 += src.ActionCode.Trim() + '@';
                        }
                    }
                }

                if (!string.IsNullOrEmpty(l1) && l1.Length > 0)
                {
                    l1 = l1.Substring(0, (l1.Length - 1));
                }
                if (!string.IsNullOrEmpty(l2) && l2.Length > 0)
                {
                    l2 = l2.Substring(0, (l2.Length - 1));
                }
                if (!string.IsNullOrEmpty(l3) && l3.Length > 0)
                {
                    l3 = l3.Substring(0, (l3.Length - 1));
                }
                context.Response.Write(l1 + '|' + l2 + '|' + l3);
            }
        }
    }
        
    }
    
    public string GetInventoryConfigDetailsValue(string configKey, int orgID, int OrgAddressID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        Configuration_BL objGateway = new Configuration_BL(new Attune_BaseClass().ContextInfo);
        List<InventoryConfig> lstConfig = new List<InventoryConfig>();

        returncode = objGateway.GetInventoryConfigDetails(configKey, orgID, OrgAddressID, out lstConfig);
        if (lstConfig!=null && lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }


    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}