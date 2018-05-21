<%@ WebHandler Language="C#" Class="JsonHandler" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Collections.Generic;

public class JsonHandler : IHttpHandler, IRequiresSessionState
{

    string userID = "";
    public void ProcessRequest(HttpContext context)
    {
        HttpRequest request = context.Request;
        HttpResponse response = context.Response;
        System.Web.SessionState.HttpSessionState session = context.Session;


        if (session[GlobalSetting.SessionKey.LoginID] != null)
            userID = session[GlobalSetting.SessionKey.LoginID].ToString();


        string result = "";
        Newtonsoft.Json.Converters.IsoDateTimeConverter IsoDateTimeConverter = new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat };

        try
        { 

            string table = request["Table"];
            string input = request["Input"];
            result = Newtonsoft.Json.JsonConvert.SerializeObject(new GeneralMaster().RefreshTableList(table, input), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
          
        }
        catch (Exception e)
        {
            result = "{\"message\":\"" + e.Message.Replace("\r\n", "") + "\"}";
            Log.Error(e.Message);
            Log.Error(e.StackTrace);
        }

        response.Clear();
        response.Headers.Add("Access-Control-Allow-Origin", "*");
        response.ContentType = "application/json;charset=UTF-8;";
        response.Write(result);
        response.End();
    }



    public bool IsReusable
    {
        get
        {
            return false;
        }
    }


}


//case "genPOHeader":
//    DetId = request["DetId"];
//    PRNo = request["PRNo"];
//    PONo = request["PONo"];
//    Incharge = userID;
//    tmpDate = DateTime.Now;
//    new PRManagement().GenPOHeader(PONo, PRNo, DetId, Incharge, tmpDate);
//    result = "{\"message\":\"Done.\"}";
//    break;
//case "getAutoGenPONo":
//    string fmt = new AutoGenNo().GetAutoGen("1").AutoGenNoFormat;
//    string year = DateTime.Now.Year.ToString();
//    string month = DateTime.Now.Month.ToString("00");

//    fmt = System.Text.RegularExpressions.Regex.Replace(fmt, "{YYYY}", year);
//    fmt = System.Text.RegularExpressions.Regex.Replace(fmt, "{MM}", month);
//    PONo = new AutoGenNo().getLastRunningNumber("PO", fmt, userID).ToString(fmt);
//    PONo = System.Text.RegularExpressions.Regex.Replace(PONo, "{", "");
//    PONo = System.Text.RegularExpressions.Regex.Replace(PONo, "}", "");
//    result = "{\"message\":\""+PONo+"\"}";
//    break;
