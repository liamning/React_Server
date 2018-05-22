using System;
public class ClientInfo
{
	public string Code { get; set; }
	public string Name { get; set; }
	public string Address { get; set; }
	public string Phone { get; set; }
	public string Fax { get; set; }
	public string ContactPerson { get; set; }
	public DateTime? RegistrationDate { get; set; }
	public class FieldName
	{
		public const string Code = "Code";
		public const string Name = "Name";
		public const string Address = "Address";
		public const string Phone = "Phone";
		public const string Fax = "Fax";
		public const string ContactPerson = "ContactPerson";
		public const string RegistrationDate = "RegistrationDate";
	}
}
