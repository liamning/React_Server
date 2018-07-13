using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient; 
using System.Web;
using Dapper;


public class Header
{
	#region Standar Function
    SqlConnection db; 
	SqlTransaction transaction;
	bool isSubTable = false;
	
    public Header()
    { 
		this.db = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlServerConnString"].ConnectionString); 
    }
    public Header(SqlConnection db, SqlTransaction transaction)
    { 
		this.isSubTable = true;
		this.db = db;
		this.transaction = transaction;
    }

    public List<GeneralCodeDesc> GetCodeDescList(string Code)
    { 
        db.Open();
        String query = "select top 10 Code Code, Code [Desc] from Header where (@Code = '' or Code like '%' + @Code + '%') order by Code";
        var obj = (List<GeneralCodeDesc>)db.Query<GeneralCodeDesc>(query, new { Code = Code });
        db.Close();
        return obj;
    }


    public bool IsExisted(HeaderInfo info)
    { 
        String query = "select count(*)  from Header " 
		+ " where Code = @Code ";
        var obj = (List<int>)db.Query<int>(query, info, this.transaction);
         
		
        return obj[0] > 0;
    }

    public void Save(HeaderInfo info)
    {
        this.db.Open();
        try
        {

            this.transaction = this.db.BeginTransaction();

            if (this.IsExisted(info))
                this.Update(info);
            else
                this.Insert(info);

            Body bodyObj = new Body(this.db, this.transaction);

            if (info.BodyList != null)
            foreach (var bodyItem in info.BodyList)
            {
                bodyObj.Save(bodyItem);
            }
            this.transaction.Commit();
        }
        catch {
            this.transaction.Rollback();
            throw;
        }
        finally {
            this.db.Close();
        }
    }

	 
    public HeaderInfo Get(string Code)
    {
		db.Open();

        string query = "select * from Header " 
		+ " where Code = @Code ";
		
        var obj = (List<HeaderInfo>)db.Query<HeaderInfo>(query, new {  Code = Code  });
        db.Close();
		
        if (obj.Count > 0){
            obj[0].BodyList = new Body(this.db, this.transaction).Get(Code);

            return obj[0];
        }
         
        else
            return null;
    }

    public void Delete(string Code)
    {
		if(!this.isSubTable)
			db.Open();

        string query = "delete  from Header " 
		+ " where Code = @Code ";
		
        db.Execute(query, new {  Code = Code  }, this.transaction);
		
		
		if(!this.isSubTable)
			db.Close();
    }
	
    public void Update(HeaderInfo info)
    { 

        string query = " UPDATE [dbo].[Header] SET  "
		+ " [Description] = @Description " 
		+ ", [HeaderDate] = @HeaderDate " 
		+ ", [HeaderDateTime] = @HeaderDateTime " 
		+ ", [Combo1] = @Combo1 " 
		+ ", [CreateUser] = @CreateUser " 
		+ ", [UpdateDate] = @UpdateDate " 
		+ ", [UpdateUser] = @UpdateUser " 
		+ ", [SampleTime] = @SampleTime " 
		+ " where Code = @Code ";

         
        db.Execute(query, info, this.transaction);
		
		 
    }

    public void Insert(HeaderInfo info)
    { 

        string query = "INSERT INTO [dbo].[Header] ( [Code] " 
		+ ",[Description] " 
		+ ",[HeaderDate] " 
		+ ",[HeaderDateTime] " 
		+ ",[Combo1] " 
		+ ",[CreateUser] " 
		+ ",[UpdateDate] " 
		+ ",[UpdateUser] " 
		+ ",[SampleTime] " 
		+") "
		+ "VALUES ( @Code "
		+ ",@Description " 
		+ ",@HeaderDate " 
		+ ",@HeaderDateTime " 
		+ ",@Combo1 " 
		+ ",@CreateUser " 
		+ ",@UpdateDate " 
		+ ",@UpdateUser " 
		+ ",@SampleTime " 
		+") ";


        db.Execute(query, info, this.transaction);
		 
    }
	#endregion 

}