<%@ WebHandler Language="C#" Class="AjaxHandler" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Collections.Generic;

public class AjaxHandler : IHttpHandler, IRequiresSessionState
{

    string userID = "";
    public void ProcessRequest(HttpContext context)
    {
        HttpRequest request = context.Request;
        HttpResponse response = context.Response;
        System.Web.SessionState.HttpSessionState session = context.Session;


        if (session[GlobalSetting.SessionKey.LoginID] != null)
            userID = session[GlobalSetting.SessionKey.LoginID].ToString();


        if (string.IsNullOrEmpty(userID))
        {
            response.Clear();
            response.StatusCode = 403;
            response.Headers.Add("Access-Control-Allow-Origin", "http://localhost:8080");
            response.Headers.Add("Access-Control-Allow-Credentials", "true");
            response.End();
        }

        string result = "";
        Newtonsoft.Json.Converters.IsoDateTimeConverter IsoDateTimeConverter = new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat };

        try
        {
            string action = request.Form["action"].ToString();

            switch (action)
            {
                case "saveSample":
                    string sampleString = request["SampleInfo"];
                    var sampleInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<SampleInfo>(sampleString, IsoDateTimeConverter);
                    sampleInfo.CreateUser = userID;
                    new Sample().Save(sampleInfo);
                    result = "{\"message\":\"Done.\"}";
                    break;
                case "getSample":
                    string SampleNo = request["SampleNo"];
                    result = Newtonsoft.Json.JsonConvert.SerializeObject(new Sample().Get(SampleNo), IsoDateTimeConverter);
                    break;
                case "saveClient":
                    var ClientInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<ClientInfo>(request["ClientInfo"], IsoDateTimeConverter);
                    new Client().Save(ClientInfo);
                    result = "{\"message\":\"Done.\"}";
                    break;
                case "getClient":
                    string Code = request["Code"];
                    result = Newtonsoft.Json.JsonConvert.SerializeObject(new Client().Get(Code), IsoDateTimeConverter);
                    break;
                case "saveHeader":
                    string HeaderInfoString = request["HeaderInfo"];
                    var HeaderInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<HeaderInfo>(HeaderInfoString, IsoDateTimeConverter);
                    HeaderInfo.CreateUser = userID;
                    new Header().Save(HeaderInfo);
                    result = "{\"message\":\"Done.\"}";
                    break;
                case "getUser":
                    string StaffNo = request["StaffNo"];
                    result = Newtonsoft.Json.JsonConvert.SerializeObject(new UserProfile().Get(StaffNo), IsoDateTimeConverter);
                    break;
                case "saveUser":
                    var UserProfileInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<UserProfileInfo>(request["UserProfileInfo"]);
                    new UserProfile().Save(UserProfileInfo);
                    result = "{\"message\":\"Done.\"}";
                    break;
                case "changePassword":
                    var originPassword = request["OriginPassword"];
                    var newPassword = request["NewPassword"];
                    new UserProfile().ChangePassword(userID, originPassword, newPassword);
                    result = "{\"message\":\"Done.\"}";
                    break;
                case "getHeader":
                    Code = request["Code"];
                    result = Newtonsoft.Json.JsonConvert.SerializeObject(new Header().Get(Code), IsoDateTimeConverter);
                    break;

                case "getGeneralMasterList":
                    string[] masterNames = Newtonsoft.Json.JsonConvert.DeserializeObject<string[]>(request["categories"]);
                    result = Newtonsoft.Json.JsonConvert.SerializeObject(new GeneralMaster().GetGeneralMasterList(masterNames));
                    break;

                case "saveGeneralMaster":
                    List<GeneralMasterInfo> GeneralMasterList = Newtonsoft.Json.JsonConvert.DeserializeObject<List<GeneralMasterInfo>>(request["GeneralMasterList"]);
                    new GeneralMaster().Save(GeneralMasterList);
                    result = "{\"message\":\"Done.\"}";
                    break;

                case "getGeneralMaster":
                    string category = request["category"];
                    result = Newtonsoft.Json.JsonConvert.SerializeObject(new GeneralMaster().getGeneralMaster(category));
                    break; 
                    
                case "refreshList":
                    string table = request["Table"];
                    string input = request["Input"];
                    result = Newtonsoft.Json.JsonConvert.SerializeObject(new GeneralMaster().RefreshTableList(table, input), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                    break;
                     

                default:
                    break;

            }


            Log.Info(action);
        }
        catch (Exception e)
        {
            result = "{\"message\":\"" + e.Message.Replace("\r\n", "") + "\"}";
            Log.Error(e.Message);
            Log.Error(e.StackTrace);
        }

        response.Clear();
        response.Headers.Add("Access-Control-Allow-Origin", "http://localhost:8080");
        response.Headers.Add("Access-Control-Allow-Credentials", "true");
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
