<%@ WebHandler Language="C#" Class="ClientSesssionHandler" %>

using System;
using System.Web;
using System.IO;
using System.Web.SessionState;
using Newtonsoft;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Collections.Generic;

public class ClientSesssionHandler : HandlerBase
{
    public ClientSesssionHandler()
    {
        base.NeedAuthorization = false;
    }
    
    protected override void SetResponse()
    {
        base.SetResponse();
        Response.ContentType = "text/javascript";
    }
    
    protected override string getAction()
    {
        return "";
    }
    
    protected override void action(string action)
    {

        Dictionary<string, string> sessionDict = new Dictionary<string, string>();
        sessionDict.Add("UserID", string.Format("{0}", UserID));
        //sessionDict.Add("Role", string.Format("{0}", Role));


        Result = string.Format(@"window.loginInfo = {0};", JsonConvert.SerializeObject(sessionDict));
        
        
    }

}