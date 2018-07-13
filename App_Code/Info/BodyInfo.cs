using System;
public class BodyInfo
{
	public string HeaderCode { get; set; }
	public int Line { get; set; }
    public DateTime? BodyDateTime { get; set; }
    public string Combo1 { get; set; }
    public string Combo1Desc { get; set; }
	public string CreateUser { get; set; }
	public DateTime? UpdateDate { get; set; }
	public string UpdateUser { get; set; }
	public DateTime? SampleTime { get; set; }
	public class FieldName
	{
		public const string HeaderCode = "HeaderCode";
		public const string Line = "Line";
		public const string BodyDateTime = "BodyDateTime";
		public const string Combo1 = "Combo1";
		public const string CreateUser = "CreateUser";
		public const string UpdateDate = "UpdateDate";
		public const string UpdateUser = "UpdateUser";
		public const string SampleTime = "SampleTime";
	}
}
