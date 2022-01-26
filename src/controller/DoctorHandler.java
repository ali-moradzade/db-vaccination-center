package controller;

import java.util.Scanner;

import model.DoctorOperations;

public class DoctorHandler
{
	public static void singIn()
	{
		Scanner input = new Scanner(System.in);

		System.out.print("Enter your username: ");
		String username = input.nextLine();

		System.out.print("Enter your password: ");
		String password = input.nextLine();

		DoctorOperations.signInAsDoctor(username, password);
	}
}
