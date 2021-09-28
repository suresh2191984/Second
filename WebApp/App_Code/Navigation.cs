using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Attune.Podium.BusinessEntities;
using System.Web.UI;
using System.Web;
using System.Collections;
using Attune.Solution.BusinessComponent;

    public class Navigation
    {

        
        

        public long GetLandingPage(List<Role> userRole,out string relPathPage)
        {
            long returnCode = 0;
            relPathPage = string.Empty;            
            GateWay navigationDAL = new GateWay();
            
            if (userRole.Count == 1)
            {
            returnCode= navigationDAL.GetLandingPage(userRole.First().RoleID, out relPathPage);
            }
            else if (userRole.Count > 1)
            {
                //navigationDAL.GetRoleSelectorPage()
            }
            return returnCode;
        }

    public long GetLandingPage(long RoleID, out string relPathPage)
    {
        long returnCode = 0;
        relPathPage = string.Empty;
        GateWay navigationDAL = new GateWay();


        returnCode = navigationDAL.GetLandingPage(RoleID, out relPathPage);

        return returnCode;
    }

        public string GetURIPath(string ActionName,int orgID,Hashtable queryString)
        {
            string relativePath = string.Empty;
            string fullPath = string.Empty;
            string strquery = string.Empty;
            PathFinder pathFinder = PathFinder.GetPathFinder(orgID);
            relativePath = pathFinder.GetPath("RegistrationSucess");
            foreach (string s in queryString.Keys)
            {
                strquery += s + "=" + HttpContext.Current.Server.HtmlEncode(queryString[s].ToString());
            }
            fullPath = strquery == string.Empty ? relativePath : relativePath + "?" + strquery;
            return fullPath;

        }
        //public long GetSessionConfidential(List<Role> userRole, out string Showconfidential)
        //{
        //    long returnCode = 0;
            
        //    Showconfidential = string.Empty;
        //    GateWay navigationDAL = new GateWay();

        //    if (userRole.Count == 1)
        //    {
        //       // navigationDAL.GetSessionConfidential(userRole.First(), out Showconfidential);
        //    }
        //    else if (userRole.Count > 1)
        //    {
        //        //navigationDAL.GetRoleSelectorPage()
        //    }
        //    return returnCode;
        //}

            
   }
    



