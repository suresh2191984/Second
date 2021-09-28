using System;
using System.Text;
public class GraceHospital: PathFinder
{
public override string GetPath(string actionName)
{
switch(actionName)
{
case "RegistrationSucess": return "/Reception/PatientVisit.aspx";
};
return null;
}
}
