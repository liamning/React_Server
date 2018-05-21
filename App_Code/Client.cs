using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient; 
using System.Web;
using Dapper;


public class Client: SQLBase<ClientInfo>
{
	#region Standar Function

    public List<GeneralCodeDesc> GetCodeDescList(string input)
    {
        db.Open();
        String query = "select top 10 Code, Name [Desc] from Client where (@Code = '' or Code like '%' + @Code + '%') order by Code";
        var obj = (List<GeneralCodeDesc>)db.Query<GeneralCodeDesc>(query, new { Code = input });
        db.Close();
        return obj;
    }

    public ClientInfo Get(string Code)
    {
        db.Open();

        string query = "select * from Client "
        + " where Code = @Code ";

        var obj = (List<ClientInfo>)db.Query<ClientInfo>(query, new { Code = Code });
        db.Close();

        if (obj.Count > 0)
            return obj[0];
        else
            return null;
    }

    protected override bool IsExisted(ClientInfo info)
    { 
        String query = "select count(*)  from Client " 
		+ " where Code = @Code ";
        var obj = (List<int>)db.Query<int>(query, info, this.transaction);
         
        return obj[0] > 0;
    }

    protected override void Update(ClientInfo info)
    {
        string query = " UPDATE [dbo].[Client] SET  "
		+ " [Name] = @Name " 
		+ ", [Address] = @Address " 
		+ ", [Phone] = @Phone " 
		+ ", [Fax] = @Fax " 
		+ ", [ContactPerson] = @ContactPerson " 
		+ " where Code = @Code ";

        db.Execute(query, info, this.transaction);
		
    }

    protected override void Insert(ClientInfo info)
    {
        string query = "INSERT INTO [dbo].[Client] ( [Code] " 
		+ ",[Name] " 
		+ ",[Address] " 
		+ ",[Phone] " 
		+ ",[Fax] " 
		+ ",[ContactPerson] " 
		+") "
		+ "VALUES ( @Code "
		+ ",@Name " 
		+ ",@Address " 
		+ ",@Phone " 
		+ ",@Fax " 
		+ ",@ContactPerson " 
		+") ";

        db.Execute(query, info, this.transaction);
		
    }
	#endregion 

}