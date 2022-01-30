package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class DoctorOperations
{
	private static final String dbName = InitializeConfiguration.dbName;
	private static final String userid = InitializeConfiguration.userid;
	private static final String passwd = InitializeConfiguration.passwd;

	//	public static void main(String[] args)
	//	{
	//TODO: test doctor procedures
	//	}

	public static boolean executeUpdateQuery(String query)
	{
		try (Connection connection = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/" + dbName, userid,
				passwd);
				Statement statement = connection.createStatement();)
		{
			statement.executeQuery(query);
		}
		catch (Exception sqle)
		{
			System.out.println(sqle.getMessage());
			return false;
		}
		return true;
	}

	public static boolean signInAsDoctor(
			String user_name_param,
			String password_param)
	{
		String param = String.format(
				"('%s', '%s')",
				user_name_param,
				password_param);
		String query = "call sign_in_as_doctor" + param;
		boolean result = executeUpdateQuery(query);
		if (result == true)
			System.out.println("signed in successfully!");

		return result;
	}

	public static void createBrand(
			String name_param,
			String creator_doctor_national_code_param,
			String doses_param,
			String doses_interval_days_param)
	{
		String param = String.format(
				"('%s', '%s', '%s', '%s')",
				name_param,
				creator_doctor_national_code_param,
				doses_param,
				doses_interval_days_param);
		String query = "call create_brand" + param;
		boolean result = executeUpdateQuery(query);
		if (result == true)
			System.out.println("brand created successfully!");
	}

	public static void createVaccinationCenter(
			String name_param,
			String creator_doctor_param,
			String address_param)
	{
		String param = String.format(
				"('%s', '%s', '%s')",
				name_param,
				creator_doctor_param,
				address_param);
		String query = "call create_vaccination_center" + param;
		boolean result = executeUpdateQuery(query);
		if (result == true)
			System.out.println("vaccination center created successfully!");
	}

	public static void deleteAccount(
			String doctor_national_code_param,
			String user_name_param)
	{
		String param = String.format(
				"('%s', '%s')",
				doctor_national_code_param,
				user_name_param);
		String query = "call delete_account" + param;

		boolean result = executeUpdateQuery(query);
		if (result == true)
			System.out.println("account deleted successfully!");
	}
}
