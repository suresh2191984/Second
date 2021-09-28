using System;
using System.Text;
public abstract class PathFinder
{
public static PathFinder GetPathFinder(int orgID)
{
switch(orgID)
{
case 1:
return new GraceHospital();
break;
};
return null;
}
public virtual string GetPath(string actionName)
{
return string.Empty;
}
}
