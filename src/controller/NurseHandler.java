package controller;

import java.util.Scanner;

import model.NurseOperations;

public class NurseHandler
{
	public static void singIn()
	{
		Scanner input = new Scanner(System.in);

		System.out.print("Enter your username: ");
		String username = input.nextLine();

		System.out.print("Enter your password: ");
		String password = input.nextLine();

		NurseOperations.signInAsNurse(username, password);
	}
}
