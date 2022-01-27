package view;

import java.util.Scanner;

public class NurseDashboard
{
	public enum NurseOptions
	{
		createVial,
		injects,
		exit
	};

	private static final int NUMBER_OF_NURSE_OPERATIONS = NurseOptions
			.values().length;

	public static NurseOptions showDashboard()
	{
		Scanner input = new Scanner(System.in);

		System.out.println("Your Dashboard (as a nurse):");
		System.out.printf("1. %s\n2. %s\n3. %s\n> ",
				"Create Vial",
				"Injects",
				"Exit");
		int option = input.nextInt();
		while (option < 1 || option > 3)
		{
			System.out.println("\nInvalid option. try again.");
			System.out.print("> ");
			option = input.nextInt();
		}
		return NurseOptions.values()[option - 1];
	}

	// used for testing
	public static void main(String[] args)
	{
		System.out.println(showDashboard());
	}
}
