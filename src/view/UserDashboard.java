package view;

import java.util.Scanner;

public class UserDashboard
{
	public enum UserOptions
	{
		changePassword,
		showVaccinationCenterPoints,
		showEachDayInjections,
		showEachBrandVaccinatedPeople,
		exit
	};

	private static final int USER_NUMBER_OF_OPTIONS = UserOptions
			.values().length;

	public static UserOptions showDashboard()
	{
		Scanner input = new Scanner(System.in);
		System.out.println("Your Dashboard (as a user):");
		System.out.printf("1. %s\n2. %s\n3. %s\n4. %s\n5. %s\n> ",
				"Change Password",
				"Show Vaccination Center Points",
				"Show each Day Injections",
				"Show each Brand Vaccinated People",
				"Exit");
		int option = input.nextInt();
		while (option < 1 || option > USER_NUMBER_OF_OPTIONS)
		{
			System.out.println("\nInvalid option. try again.");
			System.out.print("> ");
			option = input.nextInt();
		}
		return UserOptions.values()[option - 1];
	}

	// used for testing
	public static void main(String[] args)
	{
		System.out.println(showDashboard());
	}
}
