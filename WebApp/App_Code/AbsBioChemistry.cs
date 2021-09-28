using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for AbsBioChemistry
/// </summary>
public class AbsBioChemistry:IInvestigation
{
    public Hashtable CreateMicroBiology()
    {
        Hashtable ht = new Hashtable();

        ht.Add("1001", "");

        ht.Add("1002", "1001");
        ht.Add("1003", "1002");
        ht.Add("1004", "1003");
        ht.Add("1005", "1003");
        ht.Add("1006", "1003");
        ht.Add("1007", "1003");
        ht.Add("1008", "1003");
        ht.Add("1009", "1003");
        ht.Add("1010", "1003");
        ht.Add("1011", "1003");

        ht.Add("3999", " ");
        ht.Add("4000","3999");
        ht.Add("4001","4000");
        ht.Add("4002","4001");
        ht.Add("4003","4002");
        ht.Add("4004","4002");
        ht.Add("4005","4002");

        return ht;
    }


    public Hashtable CreateHemotology()
    {
        Hashtable ht = new Hashtable();


        ht.Add("2001", "");

        ht.Add("2002", "2001");
        ht.Add("2003", "2001");
        ht.Add("2004", "2001");
        ht.Add("2005", "2004");
        ht.Add("2006", "2004");
        ht.Add("2007", "2004");
        ht.Add("2008", "2004");
        ht.Add("2009", "2004");
        ht.Add("2010", "2004");
        ht.Add("2011", "2004");
        ht.Add("2012", "2004");

      
        ht.Add("2013", "2001");
        ht.Add("2014", "2001");
        ht.Add("2015", "2001");
        ht.Add("2055", "2001");

        ht.Add("2016", "2001");
        ht.Add("2017", "2016");

        ht.Add("2018", "2017");
        ht.Add("2019", "2017");
        ht.Add("2020", "2017");
        ht.Add("2021", "2017");
        ht.Add("2022", "2017");


        ht.Add("2023", "2016");
        ht.Add("2024", "2023");
        ht.Add("2025", "2023");
        ht.Add("2026", "2023");

        ht.Add("2027", "2016");
        ht.Add("2028", "2027");
        ht.Add("2029", "2027");


        ht.Add("2030", "2016");

        ht.Add("2031", "2001");
        ht.Add("2032", "2001");
        ht.Add("2033", "2001");
        ht.Add("2034", "2001");
        ht.Add("2035", "2001");


        ht.Add("2036", "2001");

        ht.Add("2037", "2036");
        ht.Add("2038", "2036");
        ht.Add("2039", "2036");
        ht.Add("2040", "2036");
        ht.Add("2041", "2036");

        ht.Add("2042", "2001");

        ht.Add("2043", "2042");
        ht.Add("2044", "2042");
        ht.Add("2045", "2042");
        ht.Add("2046", "2042");
        ht.Add("2047", "2042");
        ht.Add("2048", "2042");
        ht.Add("2049", "2042");

        ht.Add("2050", "2042");
        ht.Add("2051", "2042");
        ht.Add("2052", "2042");
        ht.Add("2053", "2042");
        ht.Add("2054", "2042");



       
        return ht;
    }



    public Hashtable CreateBioChemistry()
    {
        Hashtable ht = new Hashtable();

        ht.Add("3001", "");

        //Electrolyte
        ht.Add("3002", "3001");
        ht.Add("3003", "3002");
        ht.Add("3004", "3002");
        ht.Add("3005", "3002");
        ht.Add("3006", "3002");
        ht.Add("3007", "3002");
        ht.Add("3008", "3002");
        ht.Add("3009", "3002");

        //Blood Sugar
        ht.Add("3010", "3001");
        ht.Add("3011", "3010");
        ht.Add("3012", "3010");
        ht.Add("3013", "3010");
        ht.Add("3014", "3010");

        ht.Add("3015", "3010");
        ht.Add("3016", "3015");


        //Renal Function
        ht.Add("3017", "3001");
        ht.Add("3018", "3017");
        ht.Add("3019", "3017");
        ht.Add("3020", "3017");
        ht.Add("3021", "3017");
        ht.Add("3022", "3017");
            
        //Spot Na+,k+
        ht.Add("3023", "3017");
        ht.Add("3024", "3023");
        ht.Add("3025", "3023");
        ht.Add("3026", "3023");
        ht.Add("3027", "3023");
        ht.Add("3028", "3023");
        ht.Add("3029", "3023");

        //Liver Function
        ht.Add("3030", "3001");

        //Bilrubin       
        ht.Add("3031", "3030");
        ht.Add("3032", "3031");
        ht.Add("3033", "3031");
        ht.Add("3034", "3031");

        //Protein
        ht.Add("3035", "3030");
        ht.Add("3036", "3035");
        ht.Add("3037", "3035");
        ht.Add("3038", "3035");
        ht.Add("3039", "3035");


        ht.Add("3040", "3030");
        ht.Add("3041", "3030");
        ht.Add("3042", "3030");
        ht.Add("3043", "3030");
        ht.Add("3044", "3030");

        //Cardoiac Enzymes
        ht.Add("3045", "3001");
        ht.Add("3046", "3045");
        ht.Add("3047", "3045");
        ht.Add("3048", "3045");
        ht.Add("3049", "3045");
        ht.Add("3050", "3045");
        ht.Add("3051", "3045");

        //Lipid Profile
        ht.Add("3052", "3001");
        ht.Add("3053", "3052");
        ht.Add("3054", "3052");
        ht.Add("3055", "3052");
        ht.Add("3056", "3052");
        ht.Add("3057", "3052");
        ht.Add("3058", "3052");


        //General
        ht.Add("3059", "3001");
        ht.Add("3060", "3059");
        ht.Add("3061", "3059");
        ht.Add("3062", "3059");
        ht.Add("3063", "3059");
        ht.Add("3064", "3059");
        ht.Add("3065", "3059");
        ht.Add("3066", "3059");
        ht.Add("3067", "3059");
        ht.Add("3068", "3059");
        ht.Add("3069", "3059");
        ht.Add("3070", "3059");

        //Tumor Markers
        ht.Add("3071", "3001");

        ht.Add("3072", "3071");
        ht.Add("3073", "3071");
        ht.Add("3074", "3071");
        ht.Add("3075", "3071");
        ht.Add("3076", "3071");
        
        //Hormone Assays

        ht.Add("3077", "3001");

        //Thyroid Profile
        ht.Add("3078", "3077");

        ht.Add("3079", "3078");
        ht.Add("3080", "3078");
        ht.Add("3081", "3078");
        ht.Add("3082", "3078");
        ht.Add("3083", "3078");
        ht.Add("3084", "3078");
        ht.Add("3085", "3078");
        ht.Add("3086", "3078");
        ht.Add("3087", "3078");

        //General
        ht.Add("3088", "3077");
        ht.Add("3089", "3088");
        ht.Add("3090", "3088");
        ht.Add("3091", "3088");
        ht.Add("3092", "3088");
        ht.Add("3093", "3088");

        //Adrenal
        ht.Add("3094", "3077");
        ht.Add("3095", "3094");
        ht.Add("3096", "3094");
        ht.Add("3097", "3094");
        ht.Add("3098", "3094");
        ht.Add("3099", "3094");
        ht.Add("3100", "3094");
        ht.Add("3101", "3094");
        ht.Add("3102", "3094");
        ht.Add("3103", "3094");
        ht.Add("3104", "3094");
        ht.Add("3105", "3094");
        ht.Add("3106", "3094");
        ht.Add("3107", "3094");
        ht.Add("3108", "3094");
        ht.Add("3109", "3094");
        

        //Sex Steroids
        ht.Add("3111", "3077");
        ht.Add("3112", "3111");
        ht.Add("3113", "3111");
        ht.Add("3114", "3111");
        ht.Add("3115", "3111");
        ht.Add("3116", "3111");
        ht.Add("3117", "3111");
        ht.Add("3118", "3111");
        ht.Add("3119", "3111");
        ht.Add("3120", "3111");
        ht.Add("3121", "3111");
        ht.Add("3122", "3111");
        ht.Add("3123", "3111");
        ht.Add("3124", "3111");

        //Pregnancy
        ht.Add("3125", "3124");
        ht.Add("3126", "3125");

        //Stool Analysis
        ht.Add("3127", "3077");

        ht.Add("3128", "3127");
        ht.Add("3129", "3127");
        ht.Add("3130", "3127");
        ht.Add("3131", "3127");
        ht.Add("3132", "3127");
        ht.Add("3133", "3127");
        ht.Add("3134", "3127");
        ht.Add("3135", "3127");
        ht.Add("3136", "3127");
        ht.Add("3137", "3127");
        


        return ht;
    }


    public Hashtable CreateClinicalPathology()
    {
        Hashtable ht = new Hashtable();

        ht.Add("4001", "");

        //Urine Analysis

        ht.Add("4002", "4001");

        ht.Add("4003", "4002");
        ht.Add("4004", "4002");
        ht.Add("4005", "4002");

        //Cells
        ht.Add("4006", "4002");
        ht.Add("4007", "4006");
        ht.Add("4008", "4006");
        ht.Add("4009", "4006");
        ht.Add("4010", "4006");


        //Casts
        ht.Add("4011", "4006");
        ht.Add("4150", "4011");
        ht.Add("4151", "4011");
        ht.Add("4152", "4011");
        ht.Add("4153", "4011");
        ht.Add("4154", "4011");
        ht.Add("4156", "4011");
        ht.Add("4012", "4006");


        //Chemistry
        ht.Add("4013", "4002");
        ht.Add("4014", "4013");
        ht.Add("4015", "4013");
        ht.Add("4016", "4013");
        ht.Add("4017", "4013");
        ht.Add("4018", "4013");
        ht.Add("4019", "4013");
        ht.Add("4020", "4013");
        ht.Add("4021", "4013");
        ht.Add("4022", "4013");
        ht.Add("4023", "4013");
        ht.Add("4024", "4013");

        //Urine MicroScopic
        ht.Add("4025", "4002");
        ht.Add("4026", "4025");
        ht.Add("4027", "4025");
        ht.Add("4028", "4025");
        ht.Add("4029", "4025");
        ht.Add("4030", "4025");
        ht.Add("4031", "4025");

        //Casts
        ht.Add("4032", "4025");
        ht.Add("4033", "4032");

        //24 hrs Urine Sample
        ht.Add("4034", "4002");
        ht.Add("4035", "4034");
        ht.Add("4036", "4034");
        ht.Add("4037", "4034");
        ht.Add("4038", "4034");
        ht.Add("4039", "4034");
        ht.Add("4040", "4034");
        ht.Add("4041", "4034");
        ht.Add("4042", "4034");
        ht.Add("4043", "4034");
        ht.Add("4044", "4034");


        //Body Fluid Analysis
        ht.Add("4045", "4001");

        ht.Add("4046", "4045");
        ht.Add("4047", "4045");
        ht.Add("4048", "4045");
        ht.Add("4049", "4045");

        //Cells
        ht.Add("4050", "4046");
        ht.Add("4051", "4050");
        ht.Add("4052", "4050");

        //Differntial Count
        ht.Add("4053", "4050");

        ht.Add("4054", "4053");
        ht.Add("4055", "4053");
        ht.Add("4056", "4053");

        ht.Add("4057", "4050");
        ht.Add("4058", "4050");


        //Chemistry
        ht.Add("4059", "4046");

        ht.Add("4060", "4059");
        ht.Add("4061", "4059");
        ht.Add("4062", "4059");
        ht.Add("4063", "4059");
        ht.Add("4064", "4059");
        ht.Add("4065", "4059");


        //Immunological
        ht.Add("4066", "4046");
        ht.Add("4067", "4066");
        ht.Add("4068", "4066");
        ht.Add("4069", "4066");
        ht.Add("4070", "4066");
        ht.Add("4071", "4066");
        ht.Add("4072", "4066");

        //Cytology
        ht.Add("4073", "4046");

        ht.Add("4074", "4073");
        ht.Add("4075", "4073");
        ht.Add("4076", "4073");

        //Others
        ht.Add("4078", "4046");

        //AFB
        //ht.Add("4079", "4078");
        ht.Add("4080", "4078");
        ht.Add("4081", "4078");


        //Serology
        ht.Add("4082", "4001");
        ht.Add("4083", "4082");

        ht.Add("4084", "4083");
        ht.Add("4085", "4083");

        //Hepatatis
        ht.Add("4086", "4082");
        ht.Add("4126", "4086");
        ht.Add("4127", "4086");
        ht.Add("4128", "4086");
        ht.Add("4129", "4086");
        ht.Add("4130", "4086");
        ht.Add("4131", "4086");
        ht.Add("4132", "4086");
        ht.Add("4133", "4086");
        ht.Add("4134", "4086");
        ht.Add("4135", "4086");

        ht.Add("4087", "4082");
        ht.Add("4088", "4082");
        ht.Add("4089", "4082");
        ht.Add("4090", "4082");
        ht.Add("4091", "4082");
        ht.Add("4092", "4082");

        //Widal
        ht.Add("4093", "4082");
        ht.Add("4094", "4093");
        ht.Add("4121", "4093");
        ht.Add("4122", "4093");
        ht.Add("4123", "4093");
        ht.Add("4124", "4093");
        

        //Collagen Vascular
        ht.Add("4096", "4082");
        ht.Add("4097", "4096");
        ht.Add("4098", "4096");

        //ANCA
        ht.Add("4099", "4096");
        ht.Add("4100", "4099");
        ht.Add("4101", "4099");

        //Semen Analysis
        ht.Add("4102", "4002");


        //Macroscopic
        ht.Add("4103", "4102");
        ht.Add("4104", "4103");
        ht.Add("4105", "4103");
        ht.Add("4106", "4103");
        ht.Add("4107", "4103");
        ht.Add("4108", "4103");


        //Microscopic
        ht.Add("4109", "4102");
        ht.Add("4110", "4109");

        //Motility
        ht.Add("4111", "4109");
        ht.Add("4112", "4111");
        ht.Add("4113", "4111");
        ht.Add("4114", "4111");
        ht.Add("4115", "4111");
        ht.Add("4116", "4111");
        

        //Morphology
        ht.Add("4117", "4102");

        ht.Add("4118", "4117");
        ht.Add("4119", "4117");
        ht.Add("4120", "4117");


        return ht;
    }


    public Item getItem(Hashtable ht, string id)
    {
        Item itemobj = null;
        if (ht != null)
        {
            if (ht.Contains(id))
            {
                itemobj = (Item)ht[id];
            }
        }
        return itemobj;
    }

    public Item getChild(Hashtable ht, string childid)
    {
        Item itemobj = null;
        if (ht != null)
        {
            if (ht.Contains(childid))
            {
                itemobj = (Item)ht[childid];
            }
        }
        return itemobj;
    }


}

