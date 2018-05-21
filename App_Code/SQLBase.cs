using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient; 
using System.Web;
using Dapper;

/// <summary>
/// Summary description for SQLBase
/// </summary>
public class SQLBase<BaseInfo> where BaseInfo : class
{
#region Standar Function

    protected SqlConnection db;
    protected SqlTransaction transaction;
	protected bool isSubTable = false;
	
    public SQLBase()
    { 
		this.db = new SqlConnection(GlobalSetting.ConnectionString); 
    }
    public SQLBase(SqlConnection db, SqlTransaction transaction)
    { 
		this.isSubTable = true;
		this.db = db;
		this.transaction = transaction;
    }

    protected virtual bool IsExisted(BaseInfo info)
    {
        return false;
    }
    protected virtual void Insert(BaseInfo info) { }
    protected virtual void Update(BaseInfo info) { }
    protected virtual void DeleteNotIn(List<BaseInfo> list) { }

    public void Save(BaseInfo info)
    {
        if (!this.isSubTable)
        {
            this.db.Open();
            this.transaction = db.BeginTransaction();
        }  
        try
        {
            if (this.IsExisted(info))
                this.Update(info);
            else
                this.Insert(info);
             
            this.transaction.Commit();
        }
        catch {
            this.transaction.Rollback();
            throw;
        }
        finally {

            if (!this.isSubTable)
                db.Close();
        }
              
    }
     
    public void Save(List<BaseInfo> infoList)
    {
        if (!this.isSubTable)
        {
            this.db.Open();
            this.transaction = db.BeginTransaction();
        }
        try
        {
            List<BaseInfo> notIn = new List<BaseInfo>();
            foreach (var info in infoList)
            {
                notIn.Add(info);
                if (this.IsExisted(info))
                    this.Update(info);
                else
                    this.Insert(info);
            }

            this.DeleteNotIn(notIn);

            this.transaction.Commit();
        }
        catch
        {
            this.transaction.Rollback();
            throw;
        }
        finally
        {
            if (!this.isSubTable)
                db.Close();
        }

    }


	#endregion 
}