using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient; 
using System.Web;
using Dapper;


public class Client
{
	#region Standar Function
    SqlConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlServerConnString"].ConnectionString);


    public List<GeneralCodeDesc> GetCodeDescList(string input)
    {
        db.Open();
        String query = "select top 10 Code, Code [Desc] from Client where (@Code = '' or Code like '%' + @Code + '%') order by Code";
        var obj = (List<GeneralCodeDesc>)db.Query<GeneralCodeDesc>(query, new { Code = input });
        db.Close();
        return obj;
    }

    public List<string> GetCodeList(string Code)
    { 
        db.Open();
        String query = "select top 10 Code from Client where (@Code = '' or Code like '%' + @Code + '%') order by Code";
        var obj = (List<string>)db.Query<string>(query, new { Code = Code });
        db.Close();
        return obj;
    }


    public bool IsExisted(ClientInfo info)
    {
        db.Open();
        String query = "select count(*)  from Client " 
		+ " where Code = @Code ";
        var obj = (List<int>)db.Query<int>(query, info);
        db.Close();
        return obj[0] > 0;
    }

    public void Save(ClientInfo info)
    {
        if(this.IsExisted(info))
            this.Update(info);
        else
            this.Insert(info); 
    }

	 
    public ClientInfo Get(string Code)
    {
		db.Open();

        string query = "select * from Client " 
		+ " where Code = @Code ";
		
        var obj = (List<ClientInfo>)db.Query<ClientInfo>(query, new {  Code = Code  });
        db.Close();
		
        if (obj.Count > 0)
            return obj[0];
        else
            return null;
    }

    public void Delete(string Code)
    {
		db.Open();

        string query = "delete  from Client " 
		+ " where Code = @Code ";
		
        db.Execute(query, new {  Code = Code  });
        db.Close();
    }
	
    public void Update(ClientInfo info)
    {
        db.Open();

        string query = " UPDATE [dbo].[Client] SET  "
		+ " [Name] = @Name " 
		+ ", [Address] = @Address " 
		+ ", [Phone] = @Phone " 
		+ ", [Fax] = @Fax " 
		+ ", [ContactPerson] = @ContactPerson " 
		+ ", [RegistrationDate] = @RegistrationDate " 
		+ " where Code = @Code ";

         
        db.Execute(query, info);
        db.Close();
    }

    public void Insert(ClientInfo info)
    {
        db.Open();

        string query = "INSERT INTO [dbo].[Client] ( [Code] " 
		+ ",[Name] " 
		+ ",[Address] " 
		+ ",[Phone] " 
		+ ",[Fax] " 
		+ ",[ContactPerson] " 
		+ ",[RegistrationDate] " 
		+") "
		+ "VALUES ( @Code "
		+ ",@Name " 
		+ ",@Address " 
		+ ",@Phone " 
		+ ",@Fax " 
		+ ",@ContactPerson " 
		+ ",@RegistrationDate " 
		+") ";


        db.Execute(query, info);
        db.Close();
    }
	#endregion 

}