using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Item
/// </summary>
public class Item
{
    public string value = string.Empty;
    public string key = string.Empty;
    public string id = string.Empty;
    public bool visible;
    public string[] childlist = null;
    public List<Item> child = new List<Item>();
    public string parentid = string.Empty;
}
