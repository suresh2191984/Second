using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CallAbstract
/// </summary>
public class CallAbstract:AbsBioChemistry
{
    public Hashtable CallCreateMicroBiology()
    {

        return CreateMicroBiology();

    }

    public Hashtable CallCreateHemotology()
    {

        return CreateHemotology();

    }


    public Hashtable CallCreateBioChemistry()
    {

        return CreateBioChemistry();

    }


    public Hashtable CallClinicalPathology()
    {

        return CreateClinicalPathology();

    }



    public Item callgetItem(Hashtable ht, string id)
    {
        return getItem(ht, id);
    }


    public Item callgetChild(Hashtable ht, string id)
    {
        return getChild(ht, id);
    }
}
