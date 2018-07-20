using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient; 
using System.Web;
using Dapper;


public class Body
{
	#region Standar Function
    SqlConnection db; 
	SqlTransaction transaction;
	bool isSubTable = false;
	
    public Body()
    { 
		this.db = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlServerConnString"].ConnectionString); 
    }
    public Body(SqlConnection db, SqlTransaction transaction)
    { 
		this.isSubTable = true;
		this.db = db;
		this.transaction = transaction;
    }

    public List<string> GetHeaderCodeList(string HeaderCode)
    { 
        db.Open();
        String query = "select top 10 HeaderCode from Body where (@HeaderCode = '' or HeaderCode like '%' + @HeaderCode + '%') order by HeaderCode";
        var obj = (List<string>)db.Query<string>(query, new { HeaderCode = HeaderCode });
        db.Close();
        return obj;
    }


    public bool IsExisted(BodyInfo info)
    {
		if(!this.isSubTable)
			db.Open();
		
        String query = "select count(*)  from Body " 
		+ " where HeaderCode = @HeaderCode and Line = @Line";
        var obj = (List<int>)db.Query<int>(query, info, this.transaction);
        
		
		if(!this.isSubTable)
			db.Close();
		
        return obj[0] > 0;
    }

    public void Save(BodyInfo info)
    {
        if(this.IsExisted(info))
            this.Update(info);
        else
            this.Insert(info); 
    }


    public List<BodyInfo> Get(string HeaderCode)
    {
        db.Open();

        string query = @"
select Body.*,  EngDesc Combo1Desc
from Body 
join GeneralMaster on Category='Gender' and Code = Combo1
where HeaderCode = @HeaderCode 
order by Line";

        var obj = (List<BodyInfo>)db.Query<BodyInfo>(query, new { HeaderCode = HeaderCode });
        db.Close();

        return obj;
    }

    public void Delete(string HeaderCode)
    {
		if(!this.isSubTable)
			db.Open();

        string query = "delete  from Body " 
		+ " where HeaderCode = @HeaderCode ";
		
        db.Execute(query, new {  HeaderCode = HeaderCode  }, this.transaction);
		
		
		if(!this.isSubTable)
			db.Close();
    }
	
    public void Update(BodyInfo info)
    {
	
		if(!this.isSubTable)
			db.Open();

        string query = " UPDATE [dbo].[Body] SET [BodyDateTime] = @BodyDateTime " 
		+ ", [Combo1] = @Combo1 " 
		+ ", [CreateUser] = @CreateUser " 
		+ ", [UpdateDate] = @UpdateDate " 
		+ ", [UpdateUser] = @UpdateUser " 
		+ ", [SampleTime] = @SampleTime "
        + " where HeaderCode = @HeaderCode and  [Line] = @Line ";

         
        db.Execute(query, info, this.transaction);
		
		
		if(!this.isSubTable)
			db.Close();
    }

    public void Insert(BodyInfo info)
    {
	
		if(!this.isSubTable)
			db.Open();

        string query = "INSERT INTO [dbo].[Body] ( [HeaderCode] " 
		+ ",[Line] " 
		+ ",[BodyDateTime] " 
		+ ",[Combo1] " 
		+ ",[CreateUser] " 
		+ ",[UpdateDate] " 
		+ ",[UpdateUser] " 
		+ ",[SampleTime] " 
		+") "
		+ "VALUES ( @HeaderCode "
        + ",(select ISNULL(max(Line),0) + 1 from [dbo].[Body] where HeaderCode = @HeaderCode) " 
		+ ",@BodyDateTime " 
		+ ",@Combo1 " 
		+ ",@CreateUser " 
		+ ",@UpdateDate " 
		+ ",@UpdateUser " 
		+ ",@SampleTime " 
		+") ";


        db.Execute(query, info, this.transaction);
		
		if(!this.isSubTable)
			db.Close();
    }
	#endregion 

}