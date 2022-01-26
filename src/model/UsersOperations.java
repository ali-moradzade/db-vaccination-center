package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class UsersOperations
{
	private static final String dbName = "db-vaccination-centre";
	private static final String userid = "root";
	private static final String passwd = "";

	//	public static void main(String[] args)
	//	{
	//		signUp("0009831057", "nima", "mohammadi",
	//				"2000-01-01", "M", "N",
	//				"1234567a");
	//		sign_in("0009831058", "1234567a");
	//		change_password("0009831058", "1234567a", "1234567b");
	//		show_vaccination_center_points("morad-vacc-center");
	//		show_each_day_injections("1400-10-10");
	//		show_each_brand_vaccinated_people("ali-moradzade-brand");
	//	}

	private static boolean executeUpdateQuery(String query)
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

	public static boolean signUp(
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
		return result;
	}

	public static boolean signIn(
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
		
		System.out.println();
		return result;
	}

	public static boolean changePassword(
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

		System.out.println();
		return result;
	}

	public static void showVaccinationCenterPoints(
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
		System.out.println();
	}

	public static void showEachDayInjections(
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
		System.out.println();
	}

	public static void showEachBrandVaccinatedPeople(String name_param)
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
		System.out.println();
	}
}
