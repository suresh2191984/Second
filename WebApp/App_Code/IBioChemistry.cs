using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for IBioChemistry
/// </summary>
public interface IInvestigation
{
    Hashtable CreateMicroBiology();

    Hashtable CreateHemotology();

    Hashtable CreateBioChemistry();

    Hashtable CreateClinicalPathology();
}
