using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Collections;
using System.Text;

public partial class CommonControls_VaccinationHistory : BaseControl 
{
    public string ComplaintHeader { get; set; }
    public string DefaultComplaintID { get; set; }
    public int ComplaintID { get; set; }
    public string ComplaintName { get; set; }
    public string AddBtnVisible { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {

        //lblComplaint.Text = ComplaintHeader;

    }

    
    
    public void SetData(List<PatientHistoryAttribute> lsthisPHA, long ID)
    {
        var lstvaccination = from s in lsthisPHA
                             where s.HistoryID == 1064
                             select s;

        List<EMRAttributeClass> vaccination = (from d in lstvaccination
                                               where d.AttributeID == 121
                                               select new EMRAttributeClass
                                               {
                                                   AttributeName = d.AttributeName,
                                                   AttributevalueID = d.AttributevalueID,
                                                   AttributeValueName = d.AttributeValueName
                                               }).ToList();

        //lstEMRvalue.Name = "History";
        //lstEMRvalue.Attributename = "Vaccination";
        //lstEMRvalue.Attributeid = 121;
        //lstEMRvalue.Attributevaluename = vaccination[0].AttributeName;
        //EMR20.Bind(lstEMRvalue, vaccination);


        drpVaccination.DataSource = vaccination.ToList();
        drpVaccination.DataTextField = "AttributeValueName";
        drpVaccination.DataValueField = "AttributevalueID";
        drpVaccination.DataBind();
        drpVaccination.Items.Insert(0, "--Select--");

        List<EMRAttributeClass> reaction = (from d in lstvaccination
                                            where d.AttributeID == 122
                                            select new EMRAttributeClass
                                            {
                                                AttributeName = d.AttributeName,
                                                AttributevalueID = d.AttributevalueID,
                                                AttributeValueName = d.AttributeValueName
                                            }).ToList();

        //lstEMRvalue.Name = "History";
        //lstEMRvalue.Attributename = "Vaccination";
        //lstEMRvalue.Attributeid = 122;
        //lstEMRvalue.Attributevaluename = reaction[0].AttributeName;
        //EMR21.Bind(lstEMRvalue, reaction);


        ddlAnaphylacticReaction.DataSource = reaction.ToList();
        ddlAnaphylacticReaction.DataTextField = "AttributeValueName";
        ddlAnaphylacticReaction.DataValueField = "AttributevalueID";
        ddlAnaphylacticReaction.DataBind();
        ddlAnaphylacticReaction.Items.Insert(0, "--Select--");

        rdoNo_1064.Checked = true;
    }

    public void EditData(List<PatientPastVaccinationHistory> lstPatientPastVaccinationHistory, long ID)
    {
        string ddlVaccination, Year, ddlMonth=string.Empty, Doses, Booster=string.Empty, ddlVaccinationid;
        if (lstPatientPastVaccinationHistory.Count > 0)
        {
            rdoYes_1064.Checked = true;
            divrdoYes_1064.Style.Add("display", "block");
            string retrivePPV = string.Empty;
            int ppvCount = 1;
            for (int l = 0; l < lstPatientPastVaccinationHistory.Count; l++)
            {
                ppvCount = ppvCount + 1;

                ddlVaccination = lstPatientPastVaccinationHistory[l].VaccinationName;
                ddlVaccinationid = lstPatientPastVaccinationHistory[l].VaccinationID.ToString();
                Year = lstPatientPastVaccinationHistory[l].YearOfVaccination.ToString();


                if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 1)
                {
                    ddlMonth = "January";
                }
                else if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 2)
                {
                    ddlMonth = "Febrauary";
                }
                else if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 3)
                {
                    ddlMonth = "March";
                }
                else if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 4)
                {
                    ddlMonth = "April";
                }
                else if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 5)
                {
                    ddlMonth = "May";
                }
                else if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 6)
                {
                    ddlMonth = "June";
                }
                else if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 7)
                {
                    ddlMonth = "July";
                }
                else if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 8)
                {
                    ddlMonth = "August";
                }
                else if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 9)
                {
                    ddlMonth = "September";
                }
                else if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 10)
                {
                    ddlMonth = "October";
                }
                else if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 11)
                {
                    ddlMonth = "November";
                }
                else if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 12)
                {
                    ddlMonth = "December";
                }
                else
                {

                }

                Doses = lstPatientPastVaccinationHistory[l].VaccinationDose.ToString();

                if (lstPatientPastVaccinationHistory[l].IsBooster == "N")
                {
                    Booster = "No";
                }
                else if (lstPatientPastVaccinationHistory[l].IsBooster == "Y")
                {
                    Booster = "Yes";
                }
                else
                {
                }

                retrivePPV += ppvCount + "~" + ddlVaccination + "~" + Year + "~" + ddlMonth + "~" + Doses + "~" + Booster + "~" + ddlVaccinationid + "^";

            }
            HdnVaccination.Value = retrivePPV;

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ppvTable", "javascript:LoadPriorVaccinationsItems();", true);
        }
    }
    public long GetData(out List<PatientHistory> attribute, out List<PatientPastVaccinationHistory> attrvalue)
    {
        int returnval = -1;
        attribute = new List<PatientHistory>();
        attrvalue = new List<PatientPastVaccinationHistory>();
        PatientHistory hisPKGDVH = new PatientHistory();
        PatientHistoryAttribute hisPKGAttVH = new PatientHistoryAttribute();
        List<PatientPastVaccinationHistory> lstSavePriorVacc = new List<PatientPastVaccinationHistory>();
        if (rdoYes_1064.Checked == true)
        {
            hisPKGDVH.HistoryID = 1064;
            hisPKGDVH.ComplaintId = 0;
            hisPKGDVH.Description = "VACCINATION HISTORY";
            hisPKGDVH.HistoryName = "VACCINATION HISTORY";
            //lstSavePriorVacc.Add(hisPKGDVH);
            attribute.Add(hisPKGDVH);

            attrvalue = getPriorVaccinations();
            //attrvalue.Add(objpatientcomplaintattribute);
        }
        return returnval;
    }
    public List<PatientPastVaccinationHistory> getPriorVaccinations()
    {
        List<PatientPastVaccinationHistory> lstPriVacc = new List<PatientPastVaccinationHistory>();
        string HidPrivLine = HdnVaccination.Value;
        foreach (string splitString in HidPrivLine.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');
                if (lineItems.Length > 0)
                {
                    PatientPastVaccinationHistory objVac = new PatientPastVaccinationHistory();
                    objVac.VaccinationName = lineItems[1];
                    if (lineItems[1] != "")
                    {
                        if (lineItems[2] == "")
                        {
                            objVac.YearOfVaccination = 0;
                        }
                        else
                        {
                            objVac.YearOfVaccination = Convert.ToInt32(lineItems[2]);
                        }
                    }
                    objVac.MonthName = lineItems[3];
                    if (objVac.MonthName == "January")
                    {
                        objVac.MonthOfVaccination = 1;
                    }
                    else if (objVac.MonthName == "Febrauary")
                    {
                        objVac.MonthOfVaccination = 2;
                    }
                    else if (objVac.MonthName == "March")
                    {
                        objVac.MonthOfVaccination = 3;
                    }
                    else if (objVac.MonthName == "April")
                    {
                        objVac.MonthOfVaccination = 4;
                    }
                    else if (objVac.MonthName == "May")
                    {
                        objVac.MonthOfVaccination = 5;
                    }
                    else if (objVac.MonthName == "June")
                    {
                        objVac.MonthOfVaccination = 6;
                    }
                    else if (objVac.MonthName == "July")
                    {
                        objVac.MonthOfVaccination = 7;
                    }
                    else if (objVac.MonthName == "August")
                    {
                        objVac.MonthOfVaccination = 8;
                    }
                    else if (objVac.MonthName == "September")
                    {
                        objVac.MonthOfVaccination = 9;
                    }
                    else if (objVac.MonthName == "October")
                    {
                        objVac.MonthOfVaccination = 10;
                    }
                    else if (objVac.MonthName == "November")
                    {
                        objVac.MonthOfVaccination = 11;
                    }
                    else if (objVac.MonthName == "December")
                    {
                        objVac.MonthOfVaccination = 12;
                    }
                    else
                    {
                    }
                    objVac.VaccinationDose = lineItems[4];
                    objVac.IsBooster = "Y";
                    objVac.VaccinationID = Convert.ToInt32(lineItems[6]);
                    lstPriVacc.Add(objVac);
                }
            }
        }
        return lstPriVacc;
    }

}
