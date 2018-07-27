using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using Dapper;

/// <summary>
/// Summary description for Sample
/// </summary>
public class GeneralMaster
{
    SqlConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlServerConnString"].ConnectionString);
    SqlTransaction transaction;
    bool isSubTable = false;

    public Dictionary<string, List<GeneralCodeDesc>> GetGeneralMasterList(string[] masterNames)
    {
        Dictionary<string, List<GeneralCodeDesc>> dict = new Dictionary<string, List<GeneralCodeDesc>>();

        foreach (string masterName in masterNames)
        {
            switch (masterName)
            {
                //case "Relationship":
                //    dict.Add(masterName, this.getGeneralMaster(masterName));
                //    break;
                //case "Role":
                //    dict.Add(masterName, this.GetRoleList());
                //    break;
                //case "TransactionType":
                //    dict.Add(masterName, new POManagement().getTransactionList());
                //    break;
                //case "Supplier":
                //    dict.Add(masterName, new POManagement().GetSupplierList());
                //    break;
                //case "Currency":
                //    dict.Add(masterName, new PRManagement().GetCurrencyList());
                //    break;
                //case "PriceTerm":
                //    dict.Add(masterName, new POManagement().GetPriceTermList());
                //    break;
                //case "PaymentTerm":
                //    dict.Add(masterName, new POManagement().GetPaymentList());
                //    break;
                //case "Unit":
                //    dict.Add(masterName, new POManagement().GetUnitList());
                //    break;
                //default:
                //    dict.Add(masterName, this.getGeneralMaster(masterName));
                //    break;
            }
        }

        return dict;
    } 

    public List<GeneralCodeDesc> GetRoleList()
    {
        db.Open();
        String query = "select RoleCode Code, RoleName [Desc] from RoleHeader order by RoleName";
        var obj = (List<GeneralCodeDesc>)db.Query<GeneralCodeDesc>(query);
        db.Close();
        return obj;
    }

    public List<GeneralCodeDesc> RefreshTableList(string tableName, string input)
    {
        switch (tableName)
        {
            case "Sample":
                return this.RefreshSampleList(input);
            case "Client":
                return new Client().GetCodeDescList(input);
            case "UserProfile":
                return new UserProfile().GetCodeDescList(input);
            case "Header":
                return new Header().GetCodeDescList(input);
            case "GeneralMaster":
                return this.getGeneralMasterCategory(tableName, input); 
            default:
                return this.getGeneralMaster(tableName, input);
        }

        return null;
    }


    private List<GeneralCodeDesc> RefreshSampleList(string SampleNo)
    {
        db.Open();
        string query = @"(select SampleNo Code, SampleText [Desc] from [Sample] where @SampleNo = SampleNo)
                        union
                    (select top 10 SampleNo Code, SampleText [Desc] from [Sample]
                    where (@SampleNo = '' or SampleNo like '%' + @SampleNo + '%' ))  order by SampleNo";
        var obj = (List<GeneralCodeDesc>)db.Query<GeneralCodeDesc>(query, new { SampleNo = SampleNo });
        db.Close();
        return obj;
    }

    private List<GeneralCodeDesc> getGeneralMasterCategory(string category, string desc)
    {
        this.db.Open();

        try
        {
            string query = @" 
SELECT  distinct [Category] Code
,[Category] Code
FROM [dbo].[GeneralMaster]
where (@desc = '' or Category like '%' + @desc + '%' ) 
                ";
            List<GeneralCodeDesc> result = (List<GeneralCodeDesc>)this.db.Query<GeneralCodeDesc>(query, new { category = category, desc = desc });
            return result;
        }
        catch
        {
            throw;
        }
        finally
        {
            this.db.Close();
        }
    }


    private List<GeneralCodeDesc> getGeneralMaster(string category, string desc)
    {
        this.db.Open();

        try
        {
            string query = @" 
SELECT [Code] Code
,[EngDesc] [Desc]
FROM [dbo].[GeneralMaster]
where Category = @Category 
and (@desc = '' or EngDesc like '%' + @desc + '%' )
order by Seq
                ";
            List<GeneralCodeDesc> result = (List<GeneralCodeDesc>)this.db.Query<GeneralCodeDesc>(query, new { category = category, desc = desc });
            return result;
        }
        catch
        {
            throw;
        }
        finally
        {
            this.db.Close();
        }
    }


    public List<GeneralMasterInfo> getGeneralMaster(string category)
    {
        this.db.Open();

        try
        {
            string query = @" 
SELECT
* 
FROM [dbo].[GeneralMaster]
where Category = @Category  
order by Seq
";
            List<GeneralMasterInfo> result = (List<GeneralMasterInfo>)this.db.Query<GeneralMasterInfo>(query, new { category = category });
            return result;
        }
        catch
        {
            throw;
        }
        finally
        {
            this.db.Close();
        }
    }

    public bool IsExisted(GeneralMasterInfo info)
    {
        if (!this.isSubTable)
            db.Open();

        String query = "select count(*)  from GeneralMaster "
        + " where Category = @Category and Seq = @Seq ";
        var obj = (List<int>)db.Query<int>(query, info, this.transaction);


        if (!this.isSubTable)
            db.Close();

        return obj[0] > 0;
    }

    public void Save(List<GeneralMasterInfo> list)
    {
        foreach (var info in list)
        {
            if (this.IsExisted(info))
                this.Update(info);
            else
                this.Insert(info);
        }
        
    }

    public void Update(GeneralMasterInfo info)
    {

        if (!this.isSubTable)
            db.Open();

        string query = " UPDATE [dbo].[GeneralMaster] SET  "
        + " [Category] = @Category "
        + ", [CategoryDesc] = @CategoryDesc "
        + ", [Seq] = @Seq "
        + ", [Code] = @Code "
        + ", [EngDesc] = @EngDesc "
        + ", [ChiDesc] = @ChiDesc "
        + ", [IsLocked] = @IsLocked "
        + ", [CreateUser] = @CreateUser "
        + ", [CreateDate] = @CreateDate "
        + ", [LastModifiedUser] = @LastModifiedUser "
        + ", [LastModifiedDate] = @LastModifiedDate "
        + " where ID = @ID ";


        db.Execute(query, info, this.transaction);


        if (!this.isSubTable)
            db.Close();
    }

    public void Insert(GeneralMasterInfo info)
    {

        if (!this.isSubTable)
            db.Open();

        string query = "INSERT INTO [dbo].[GeneralMaster] (  "
        + " [Category] "
        + ",[CategoryDesc] "
        + ",[Seq] "
        + ",[Code] "
        + ",[EngDesc] "
        + ",[ChiDesc] "
        + ",[IsLocked] "
        + ",[CreateUser] "
        + ",[CreateDate] "
        + ",[LastModifiedUser] "
        + ",[LastModifiedDate] "
        + ") "
        + "VALUES (  "
        + " @Category "
        + ",@CategoryDesc "
        + ",(select isnull(max(seq), 0) + 1 from [dbo].[GeneralMaster] where Category=@Category) "
        + ",@Code "
        + ",@EngDesc "
        + ",@ChiDesc "
        + ",@IsLocked "
        + ",@CreateUser "
        + ",@CreateDate "
        + ",@LastModifiedUser "
        + ",@LastModifiedDate "
        + ") ";


        db.Execute(query, info, this.transaction);

        if (!this.isSubTable)
            db.Close();
    }


//    private List<GeneralCodeDesc> getLocationList()
//    {
//        this.db.Open();

//        try
//        {
//            string query = @"
//                select '-' Code, '-' [Desc]
//                union all
//                select CustomerCode [Code], CustomerName [Desc] from " + GlobalSetting.TMSWorkshopCompanyDBPolicyValue + @".[dbo].[TmsCustomer]
//                ";
//            List<GeneralCodeDesc> result = (List<GeneralCodeDesc>)this.db.Query<GeneralCodeDesc>(query);
//            return result;
//        }
//        catch
//        {
//            throw;
//        }
//        finally
//        {
//            this.db.Close();
//        }
//    }

//    private List<GeneralCodeDesc> RefreshLocationList(string LocationCode)
//    {
//        db.Open();
//        string query = @"(select CustomerCode Code, CustomerName [Desc] from " + GlobalSetting.TMSWorkshopCompanyDBPolicyValue + @".[dbo].[TmsCustomer] where @Code = CustomerCode)
//                    union
//                (select top 10 CustomerCode Code, CustomerName [Desc] from " + GlobalSetting.TMSWorkshopCompanyDBPolicyValue + @".[dbo].[TmsCustomer]
//                where (@Code = '' or CustomerCode like '%' + @Code + '%' or CustomerName like '%' + @Code + '%'))  order by CustomerCode";
//        var obj = (List<GeneralCodeDesc>)db.Query<GeneralCodeDesc>(query, new { Code = LocationCode });
//        db.Close();
//        return obj;
//    }

//    private List<GeneralCodeDesc> RefreshSupplierList(string supplierCode)
//    {
//        string query = @"(select SupplierCode Code, SupplierName [Desc] from " + GlobalSetting.TMSWorkshopCompanyDBPolicyValue + @".[dbo].[TmsSupplier] where @Code = SupplierCode)
//                    union
//                (select top 10 SupplierCode Code, SupplierName [Desc] from " + GlobalSetting.TMSWorkshopCompanyDBPolicyValue + @".[dbo].[TmsSupplier]
//                where (@Code = '' or SupplierCode like '%' + @Code + '%' ))  order by SupplierCode";
//        var obj = (List<GeneralCodeDesc>)db.Query<GeneralCodeDesc>(query, new { Code = supplierCode });
//        db.Close();
//        return obj;
//    }

}