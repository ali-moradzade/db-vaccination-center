package controller;

import java.util.Scanner;

import model.UsersOperations;
import view.UserDashboard;

public class UserHandler
{
	public static boolean signUp()
	{
		System.out.println("Signing up ...\n");
		Scanner input = new Scanner(System.in);

		System.out.print("enter your national code: ");
		String national_code_param = input.nextLine();

		System.out.print("enter your password: ");
		String password_param = input.nextLine();

		System.out.print("enter your first name: ");
		String first_name_param = input.nextLine();

		System.out.print("enter your last name: ");
		String last_name_param = input.nextLine();

		System.out.print("enter your birth date: ");
		String birth_date_param = input.nextLine();

		System.out.print("enter your gender (M/F): ");
		String gender_param = input.nextLine();

		System.out.print("enter your special disease: ");
		String special_disease_param = input.nextLine();

		return UsersOperations.signUp(national_code_param,
				first_name_param,
				last_name_param,
				birth_date_param,
				gender_param,
				special_disease_param,
				password_param);
	}

	public static boolean signIn()
	{
		System.out.println("Signing In ...\n");
		Scanner input = new Scanner(System.in);

		System.out.print("enter your username: ");
		String username = input.nextLine();

		System.out.print("enter your password: ");
		String password = input.nextLine();

		return UsersOperations.signIn(username, password);
	}

	public static void dashboard()
	{
		int option = UserDashboard.showDashboard();

		boolean flag = true;
		while (flag)
		{
			switch (option)
			{
				// changePassword
				case 1:
					changePassword();
					break;
				// showVaccinationCenterPoints
				case 2:
					showVaccinationCenterPoints();
					break;
				// showEachDayInjections
				case 3:
					showEachDayInjections();
					break;
				// showEachBrandVaccinatedPeople
				case 4:
					showEachBrandVaccinatedPeople();
					break;
				// exit
				case 5:
					System.out.println("\nexiting your dashboard ...");
					flag = false;
					break;
			}

			if (flag)
			{
				System.out.println();
				option = UserDashboard.showDashboard();
			}
		}
	}

	private static void changePassword()
	{
		System.out.println("\nChanging your password ...\n");
		Scanner input = new Scanner(System.in);

		System.out.print("enter your user name: ");
		String user_name_param = input.nextLine();
		System.out.print("enter your old password: ");
		String old_password_param = input.nextLine();
		System.out.print("enter your new password: ");
		String new_password_para = input.nextLine();

		UsersOperations.changePassword(user_name_param, old_password_param,
				new_password_para);
	}

	private static void showVaccinationCenterPoints()
	{
		System.out.println("\nShowing Vaccination Center Points ...\n");
		Scanner input = new Scanner(System.in);

		System.out.print("enter vaccination center name: ");
		String name_param = input.nextLine();

		UsersOperations.showVaccinationCenterPoints(name_param);
	}

	private static void showEachDayInjections()
	{
		System.out.println("\nShowing each Day Injections ...\n");
		Scanner input = new Scanner(System.in);

		System.out.print("enter date: ");
		String date = input.nextLine();

		UsersOperations.showEachDayInjections(date);
	}

	private static void showEachBrandVaccinatedPeople()
	{
		System.out.println("\nShowing each Brand Vaccinated People ...\n");
		Scanner input = new Scanner(System.in);

		System.out.print("enter brand name: ");
		String name_param = input.nextLine();

		UsersOperations.showEachBrandVaccinatedPeople(name_param);
	}
}
