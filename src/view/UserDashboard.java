package view;

import java.util.Scanner;

public class UserDashboard
{
	public static int showDashboard()
	{
		Scanner input = new Scanner(System.in);
		System.out.println("Your dashboard (as a user):");
		System.out.printf("1. %s\n2. %s\n3. %s\n4. %s\n5. %s\n> ",
				"changePassword",
				"showVaccinationCenterPoints",
				"showEachDayInjections",
				"showEachBrandVaccinatedPeople",
				"exit");
		int option = input.nextInt();
		while (option < 1 || option > 5)
		{
			System.out.println("\nInvalid option. try again.");
			System.out.print("> ");
			option = input.nextInt();
		}
		return option;
	}

	public static void main(String[] args)
	{
		System.out.println(showDashboard());
	}
}
