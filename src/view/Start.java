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
}
