using System;
using System.Collections.Generic;
public class HeaderInfo
{
	public string Code { get; set; }
	public string Description { get; set; }
	public DateTime? HeaderDate { get; set; }
	public DateTime? HeaderDateTime { get; set; }
	public string Combo1 { get; set; }
	public string CreateUser { get; set; }
	public DateTime? UpdateDate { get; set; }
	public string UpdateUser { get; set; }
	public DateTime? SampleTime { get; set; }

    public List<BodyInfo> BodyList;

	public class FieldName
	{
		public const string Code = "Code";
		public const string Description = "Description";
		public const string HeaderDate = "HeaderDate";
		public const string HeaderDateTime = "HeaderDateTime";
		public const string Combo1 = "Combo1";
		public const string CreateUser = "CreateUser";
		public const string UpdateDate = "UpdateDate";
		public const string UpdateUser = "UpdateUser";
		public const string SampleTime = "SampleTime";
	}
}
