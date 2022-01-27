package view;

import java.util.Scanner;

public class Start
{
	public enum StartOptions
	{
		singUp,
		singIn,
		signInAsDoctor,
		signInAsNurse,
		exit
	};

	private static final int NUMBER_OF_OPTIONS = StartOptions.values().length;

	public static StartOptions showMenu()
	{
		System.out.printf("\n%s:\n1. %s\n2. %s\n3. %s\n4. %s\n5. %s\n> ",
				"Choose Your Option",
				"Sign Up",
				"Sign In",
				"Sign In (as a dcotor)",
				"Sign In (as a nurse)",
				"Exit from the System");

		Scanner input = new Scanner(System.in);
		int result = input.nextInt();
		while (result < 1 || result > NUMBER_OF_OPTIONS)
		{
			System.out.println("\ninvalid option, try again.");
			System.out.print("> ");
			result = input.nextInt();
		}

		return StartOptions.values()[result - 1];
	}

	// use for testing
	public static void main(String[] args)
	{
		System.out.println(showMenu());
	}
}
