using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient; 
using System.Web;
using Dapper;


public class UserProfile
{
	#region Standar Function
    SqlConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlServerConnString"].ConnectionString);


    public List<GeneralCodeDesc> GetCodeDescList(string StaffNo)
    { 
        db.Open();
        String query = "select top 10 StaffNo Code, StaffNo [Desc] from UserProfile where (@StaffNo = '' or StaffNo like '%' + @StaffNo + '%') order by StaffNo";
        var obj = (List<GeneralCodeDesc>)db.Query<GeneralCodeDesc>(query, new { StaffNo = StaffNo });
        db.Close();

        return obj;
    }


    public bool IsExisted(UserProfileInfo info)
    {
        db.Open();
        String query = "select count(*)  from UserProfile " 
		+ " where StaffNo = @StaffNo ";
        var obj = (List<int>)db.Query<int>(query, info);
        db.Close();
        return obj[0] > 0;
    }

    public void Save(UserProfileInfo info)
    {
        if(this.IsExisted(info))
            this.Update(info);
        else
            this.Insert(info); 
    }


    public UserProfileInfo Get(string StaffNo)
    {
        db.Open();

        string query = "select * from UserProfile "
        + " where StaffNo = @StaffNo ";

        var obj = (List<UserProfileInfo>)db.Query<UserProfileInfo>(query, new { StaffNo = StaffNo });
        db.Close();

        if (obj.Count > 0)
            return obj[0];
        else
            return null;
    }


    public UserProfileInfo Login(string StaffNo, string Password)
    {
        db.Open();

        string query = "select * from UserProfile "
        + " where StaffNo = @StaffNo and Password=@Password ";

        var obj = (List<UserProfileInfo>)db.Query<UserProfileInfo>(query, new { StaffNo = StaffNo, Password = Password });
        db.Close();

        if (obj.Count > 0)
            return obj[0];
        else
            return null;
    }

    public void Delete(string StaffNo)
    {
		db.Open();

        string query = "delete  from UserProfile " 
		+ " where StaffNo = @StaffNo ";
		
        db.Execute(query, new {  StaffNo = StaffNo  });
        db.Close();
    }
	
    public void Update(UserProfileInfo info)
    {
        db.Open();

        string query = " UPDATE [dbo].[UserProfile] SET  "
		+ " [StaffName] = @StaffName " 
		+ ", [Password] = @Password " 
		+ ", [Role] = @Role " 
		+ ", [Age] = @Age " 
		+ ", [Gender] = @Gender " 
		+ ", [Mobile] = @Mobile " 
		+ ", [Email] = @Email " 
		+ ", [Location] = @Location " 
		+ ", [CreateUser] = @CreateUser " 
		+ ", [CreateDate] = @CreateDate " 
		+ ", [LastUpdateUser] = @LastUpdateUser " 
		+ ", [LastUpdateDate] = @LastUpdateDate " 
		+ " where StaffNo = @StaffNo ";

         
        db.Execute(query, info);
        db.Close();
    }

    public void Insert(UserProfileInfo info)
    {
        db.Open();

        string query = "INSERT INTO [dbo].[UserProfile] ( [StaffNo] " 
		+ ",[StaffName] " 
		+ ",[Password] " 
		+ ",[Role] " 
		+ ",[Age] " 
		+ ",[Gender] " 
		+ ",[Mobile] " 
		+ ",[Email] " 
		+ ",[Location] " 
		+ ",[CreateUser] " 
		+ ",[CreateDate] " 
		+ ",[LastUpdateUser] " 
		+ ",[LastUpdateDate] " 
		+") "
		+ "VALUES ( @StaffNo "
		+ ",@StaffName " 
		+ ",@Password " 
		+ ",@Role " 
		+ ",@Age " 
		+ ",@Gender " 
		+ ",@Mobile " 
		+ ",@Email " 
		+ ",@Location " 
		+ ",@CreateUser " 
		+ ",@CreateDate " 
		+ ",@LastUpdateUser " 
		+ ",@LastUpdateDate " 
		+") ";


        db.Execute(query, info);
        db.Close();
    }
	#endregion 

    
    public void ChangePassword(string staffNo, string originPassword, string newPassword)
    {
        db.Open();

        string query = " UPDATE [dbo].[UserProfile] SET  "
        + " [Password] = @NewPassword "
        + " where StaffNo = @StaffNo and Password = @OriginPassword ";

        db.Execute(query, new { StaffNo = staffNo, OriginPassword = originPassword, NewPassword = newPassword });
        db.Close();
    }


}