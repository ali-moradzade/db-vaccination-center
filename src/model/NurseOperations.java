package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class NurseOperations
{
	private static final String dbName = "db-vaccination-centre";
	public static final String userid = "root";
	public static final String passwd = "";

	public static void main(String[] args)
	{
		//TODO: test nurse procedures
	}

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

	public static void sign_in_as_nurse(
			String user_name_param,
			String password_param)
	{
		String param = String.format(
				"('%s', '%s')",
				user_name_param,
				password_param);
		String query = "call sign_in_as_nurse" + param;
		boolean result = executeUpdateQuery(query);
		if (result == true)
			System.out.println("signed in successfully!");
	}

	public static void create_vial(
			String creator_nurse_national_code_param,
			String serial_number_param,
			String vaccination_center_name_param,
			String brand_name_param,
			String production_location_param,
			String production_date_param)
	{
		String param = String.format(
				"('%s', '%s', '%s', '%s', '%s', '%s')",
				creator_nurse_national_code_param,
				serial_number_param,
				vaccination_center_name_param,
				brand_name_param,
				production_location_param,
				production_date_param);
		String query = "call create_vial" + param;

		boolean result = executeUpdateQuery(query);
		if (result == true)
			System.out.println("vial created successfully!");
	}

	public static void injects(
			String nurse_national_code_param,
			String national_code_param,
			String date_param,
			String vaccination_center_name_param,
			String serial_number_param,
			String point_param)
	{
		String param = String.format(
				"('%s', '%s', '%s', '%s', '%s', '%s')",
				nurse_national_code_param,
				national_code_param,
				date_param,
				vaccination_center_name_param,
				serial_number_param,
				point_param);
		String query = "call injects" + param;

		boolean result = executeUpdateQuery(query);
		if (result == true)
			System.out.println("injection ended successfully!");
	}
}
