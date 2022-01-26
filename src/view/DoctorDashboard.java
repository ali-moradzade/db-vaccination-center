package view;

import java.util.Scanner;

public class DoctorDashboard
{
	public static int showDashboard()
	{
		Scanner input = new Scanner(System.in);
		System.out.println("Your Dashboard (as a doctor):");
		System.out.printf("1. %s\n2. %s\n3. %s\n4. %s\n> ",
				"Create Brand",
				"Create Vaccination Center",
				"Delete Account",
				"Exit");
		int option = input.nextInt();
		while (option < 1 || option > 4)
		{
			System.out.println("\nInvalid option. try again.");
			System.out.print("> ");
			option = input.nextInt();
		}
		return option;
	}

	//		// used for testing
	//		public static void main(String[] args)
	//		{
	//			System.out.println(showDashboard());
	//		}
}
