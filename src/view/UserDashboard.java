package view;

import java.util.Scanner;

public class UserDashboard
{
	public static int showDashboard()
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
		while (option < 1 || option > 5)
		{
			System.out.println("\nInvalid option. try again.");
			System.out.print("> ");
			option = input.nextInt();
		}
		return option;
	}

	//	// used for testing
	//	public static void main(String[] args)
	//	{
	//		System.out.println(showDashboard());
	//	}
}
