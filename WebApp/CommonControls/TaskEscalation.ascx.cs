using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Data;

public partial class CommonControls_TaskEscalation : BaseControl
{
    public CommonControls_TaskEscalation()
        : base("CommonControls_TaskEscalation_ascx")
    {
    }
    private const string ASCENDING = " ASC";
    private const string DESCENDING = " DESC";
    long returnCode = -1;
    long StartIndex = -1;
    long EndIndex = -1;
    long TotalCount = -1;
    int PageSize = 10;
    List<TaskEscalation> lstTaskEscalation = new List<TaskEscalation>();
    Tasks_BL taskBL;
    // Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!Page.IsPostBack)
        {
            hdnStartIndex.Value = "";
            hdnEndIndex.Value = "";
            btnPrevious.Visible = false;
            btnNext.Visible = false;
            btnPreviousTop.Visible = false;
            btnNextTop.Visible = false;
            loadData();
        }
    }

    public void loadData()
    {
        StartIndex = 1;
        EndIndex = PageSize;
        hdnStartIndex.Value = StartIndex.ToString();
        hdnEndIndex.Value = EndIndex.ToString();
        taskBL = new Tasks_BL(base.ContextInfo);
        taskBL.getTaskEscalation(OrgID, RoleID, StartIndex, EndIndex, out TotalCount, out lstTaskEscalation);
        if (lstTaskEscalation != null)
        {
            if (lstTaskEscalation.Count > 0)
            {
                hdnTotalCount.Value = TotalCount.ToString();
                lblTaskEscalation.Visible = true;
                gvTaskEscalation.DataSource = lstTaskEscalation;
                gvTaskEscalation.DataBind();                
            }
            else
            {
                lblTaskEscalation.Visible = false;
            }
            if (TotalCount > EndIndex)
            {
                btnNext.Visible = true;
                btnNextTop.Visible = true;
            }
            else
            {
                btnNext.Visible = false;
                btnNextTop.Visible = false;
                btnPrevious.Visible = false;
                btnPreviousTop.Visible = false;
            }
        }
        //lblTaskEscalation.Visible = true;
        //gvTaskEscalation.DataSource = lstTaskEscalation;
        //gvTaskEscalation.DataBind();
    }

    protected void btnPreviousTop_Click(object sender, EventArgs e)
    {
        StartIndex = Convert.ToInt64(hdnStartIndex.Value) - PageSize;
        EndIndex = Convert.ToInt64(hdnEndIndex.Value) - PageSize;

        if (StartIndex >= 1)
        {
            btnNext.Visible = true;
            btnNextTop.Visible = true;
            hdnStartIndex.Value = StartIndex.ToString();
            hdnEndIndex.Value = EndIndex.ToString();
            taskBL = new Tasks_BL(base.ContextInfo);
            taskBL.getTaskEscalation(OrgID, RoleID, StartIndex, EndIndex, out TotalCount, out lstTaskEscalation);
            if (lstTaskEscalation.Count <= 0)
            {
                lblTaskEscalation.Visible = false;
            }
            else
            {
                lblTaskEscalation.Visible = true;
                gvTaskEscalation.DataSource = lstTaskEscalation;
                gvTaskEscalation.DataBind();
            }
            if (StartIndex == 1)
            {
                btnPrevious.Visible = false;
                btnNext.Visible = true;
                btnNextTop.Visible = true;
                btnPreviousTop.Visible = false;
            }
        }
    }

    protected void btnNextTop_Click(object sender, EventArgs e)
    {

        StartIndex = Convert.ToInt64(hdnStartIndex.Value) + PageSize;
        EndIndex = Convert.ToInt64(hdnEndIndex.Value) + PageSize;

        if (Convert.ToInt64(hdnTotalCount.Value) >= StartIndex)
        {
            btnNext.Visible = true;
            btnPrevious.Visible = true;
            btnNextTop.Visible = true;
            btnPreviousTop.Visible = true;

            hdnStartIndex.Value = StartIndex.ToString();
            hdnEndIndex.Value = EndIndex.ToString();
            taskBL = new Tasks_BL(base.ContextInfo);
            taskBL.getTaskEscalation(OrgID, RoleID, StartIndex, EndIndex, out TotalCount, out lstTaskEscalation);
            if (lstTaskEscalation.Count <= 0)
            {
                lblTaskEscalation.Visible = false;
            }
            else
            {
                lblTaskEscalation.Visible = true;
                gvTaskEscalation.DataSource = lstTaskEscalation;
                gvTaskEscalation.DataBind();
            }
            if (EndIndex > Convert.ToInt64(hdnTotalCount.Value))
            {
                btnNext.Visible = false;
                btnPrevious.Visible = true;

                btnNextTop.Visible = false;
                btnPreviousTop.Visible = true;
            }
        }
    }

    protected void btnPrevious_Click(object sender, EventArgs e)
    {

        StartIndex = Convert.ToInt64(hdnStartIndex.Value) - PageSize;
        EndIndex = Convert.ToInt64(hdnEndIndex.Value) - PageSize;

        if (StartIndex >= 1)
        {
            btnNext.Visible = true;
            btnNextTop.Visible = true;
            hdnStartIndex.Value = StartIndex.ToString();
            hdnEndIndex.Value = EndIndex.ToString();
            taskBL = new Tasks_BL(base.ContextInfo);
            taskBL.getTaskEscalation(OrgID, RoleID, StartIndex, EndIndex, out TotalCount, out lstTaskEscalation);
            if (lstTaskEscalation.Count <= 0)
            {
                lblTaskEscalation.Visible = false;
            }
            else
            {
                lblTaskEscalation.Visible = true;
                gvTaskEscalation.DataSource = lstTaskEscalation;
                gvTaskEscalation.DataBind();
            }

            if (StartIndex == 1)
            {
                btnPrevious.Visible = false;
                btnNext.Visible = true;
                btnNextTop.Visible = true;
                btnPreviousTop.Visible = false;

            }
        }
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {

        StartIndex = Convert.ToInt64(hdnStartIndex.Value) + PageSize;
        EndIndex = Convert.ToInt64(hdnEndIndex.Value) + PageSize;

        if (Convert.ToInt64(hdnTotalCount.Value) >= StartIndex)
        {
            btnNext.Visible = true;
            btnPrevious.Visible = true;
            btnNextTop.Visible = true;
            btnPreviousTop.Visible = true;

            hdnStartIndex.Value = StartIndex.ToString();
            hdnEndIndex.Value = EndIndex.ToString();
            taskBL = new Tasks_BL(base.ContextInfo);
            taskBL.getTaskEscalation(OrgID, RoleID, StartIndex, EndIndex, out TotalCount, out lstTaskEscalation);
            if (lstTaskEscalation.Count <= 0)
            {
                lblTaskEscalation.Visible = false;
            }
            else
            {
                lblTaskEscalation.Visible = true;
                gvTaskEscalation.DataSource = lstTaskEscalation;
                gvTaskEscalation.DataBind();
            }
            if (EndIndex > Convert.ToInt64(hdnTotalCount.Value))
            {
                btnNext.Visible = false;
                btnPrevious.Visible = true;
                btnNextTop.Visible = false;
                btnPreviousTop.Visible = true;
            }
        }
    }
    protected void tmrPostback_Tick(object sender, EventArgs e)
    {
        loadData();
    }

    protected void gvTaskEscalation_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Del")
        {
            CLogger.LogInfo("Called in grid row command");
            GridViewRow selectedRow = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            GridViewRow row = gvTaskEscalation.Rows[selectedRow.RowIndex];
            string taskId = ((Label)row.FindControl("lblTaskId")).Text;
            if (taskId != string.Empty)
            {
                Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
                taskBL.UpdateTask(Convert.ToInt64(taskId), TaskHelper.TaskStatus.Deleted, LID);
                loadData();
            }
        }
    }

    protected void gvTaskEscalation_Sorting(object sender, GridViewSortEventArgs e)
    {
        List<TaskEscalation> lstTaskEscalation = new List<TaskEscalation>();
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        DataTable dtTaskEscalation = new DataTable();
        taskBL.getTaskEscalation(OrgID, RoleID, StartIndex, EndIndex, out TotalCount, out lstTaskEscalation);
        Utilities.ConvertFrom(lstTaskEscalation, out dtTaskEscalation);


        if (dtTaskEscalation != null)
        {
            DataView dataView = new DataView(dtTaskEscalation);
            dataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection);
            gvTaskEscalation.DataSource = dataView;
            gvTaskEscalation.DataBind();
        }


        //gvTaskEscalation.Sort(e.SortExpression, SortDirection.Ascending);
    }

    private string ConvertSortDirectionToSql(SortDirection sortDirection)
    {
        string newSortDirection = String.Empty;
        switch (sortDirection)
        {
            case SortDirection.Ascending:
                newSortDirection = "ASC";
                break;

            case SortDirection.Descending:
                newSortDirection = "DESC";
                break;
        }
        return newSortDirection;
    }
}
