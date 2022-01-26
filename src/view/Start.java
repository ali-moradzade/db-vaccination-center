package view;

import java.util.Scanner;

public class Start
{
	public static int showMenu()
	{
		System.out.println("Welcome to Vaccination System!");

		System.out.printf("\n%s:\n1. %s\n2. %s\n3. %s\n4. %s\n> ",
				"choose your option",
				"sign up",
				"sign in",
				"sign in (as a dcotor)",
				"sign in (as a nurse)");

		Scanner input = new Scanner(System.in);
		int result = input.nextInt();
		while (result <= 0 || result >= 5)
		{
			System.out.println("\ninvalid option, try again.");
			System.out.print("> ");
			result = input.nextInt();
		}

		return result;
	}

	public static void showSignUpPage()
	{
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
	}

	public static void showLoginPage()
	{
		Scanner input = new Scanner(System.in);

		System.out.print("Enter your username: ");
		String username = input.nextLine();

		System.out.print("Enter your password: ");
		String password = input.nextLine();
	}

	/**
	 * testing our methods.
	 * @param args
	 */
	public static void main(String[] args)
	{
		//		System.out.println(showMenu());
		//		showLoginPage();
		showSignUpPage();
	}
}
