package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class UsersOperations
{
	private static final String dbName = "db-vaccination-centre";
	public static final String userid = "root";
	public static final String passwd = "";

	public static void main(String[] args)
	{
		//		signUp("0009831057", "nima", "mohammadi",
		//				"2000-01-01", "M", "N",
		//				"1234567a");
		//		sign_in("0009831058", "1234567a");
		//		change_password("0009831058", "1234567a", "1234567b");
		//		show_vaccination_center_points("morad-vacc-center");
		//		show_each_day_injections("1400-10-10");
		show_each_brand_vaccinated_people("ali-moradzade-brand");
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

	public static void signUp(
			String national_code_param,
			String first_name_param,
			String last_name_param,
			String birth_date_param,
			String gender_param,
			String special_disease_param,
			String password_param)
	{
		String param = String.format(
				"('%s', '%s', '%s', '%s', '%s', '%s', '%s')",
				national_code_param,
				first_name_param,
				last_name_param,
				birth_date_param,
				gender_param,
				special_disease_param,
				password_param);
		String query = "call sign_up" + param;

		boolean result = executeUpdateQuery(query);
		if (result == true)
			System.out.println("signed up successfully!");
	}

	public static void sign_in(
			String user_name_param,
			String password_param)
	{
		String param = String.format(
				"('%s', '%s')",
				user_name_param,
				password_param);
		String query = "call sign_in" + param;

		boolean result = executeUpdateQuery(query);
		if (result == true)
			System.out.println("signed in successfully!");
	}

	public static void change_password(
			String user_name_param,
			String old_password_param,
			String new_password_param)
	{
		String param = String.format(
				"('%s','%s', '%s')",
				user_name_param,
				old_password_param,
				new_password_param);
		String query = "call change_password" + param;

		boolean result = executeUpdateQuery(query);
		if (result == true)
			System.out.println("password changed successfully!");
	}

	public static void show_vaccination_center_points(
			String name_param)
	{
		String param = String.format(
				"('%s')",
				name_param);
		String query = "call show_vaccination_center_points" + param;

		try (Connection connection = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/" + dbName, userid,
				passwd);
				Statement statement = connection.createStatement();)
		{
			ResultSet rs = statement
					.executeQuery(query);
			while (rs.next())
			{
				System.out.printf("%23s: %s\n%23s: %s\n",
						"vaccination center name", rs.getString(1),
						"points", rs.getString(2));
			}
		}
		catch (Exception sqle)
		{
			System.out.println(sqle.getMessage());
		}
	}

	public static void show_each_day_injections(
			String date)
	{
		String param = String.format(
				"('%s')",
				date);
		String query = "call show_each_day_injections" + param;

		try (Connection connection = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/" + dbName, userid,
				passwd);
				Statement statement = connection.createStatement();)
		{
			ResultSet rs = statement
					.executeQuery(query);
			while (rs.next())
			{
				System.out.printf("%s: %s\n%s: %s\n",
						"date", rs.getString(1),
						"number", rs.getString(2));
			}
		}
		catch (Exception sqle)
		{
			System.out.println(sqle.getMessage());
		}
	}

	public static void show_each_brand_vaccinated_people(String name_param)
	{
		String param = String.format(
				"('%s')",
				name_param);
		String query = "call show_each_brand_vaccinated_people" + param;
		try (Connection connection = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/" + dbName, userid,
				passwd);
				Statement statement = connection.createStatement();)
		{
			ResultSet rs = statement
					.executeQuery(query);
			while (rs.next())
			{
				System.out.printf("%s: %s\n",
						"number", rs.getString(1));
			}
		}
		catch (Exception sqle)
		{
			System.out.println(sqle.getMessage());
		}
	}
}
