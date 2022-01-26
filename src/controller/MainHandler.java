package controller;

import view.Start;
import view.UserDashboard;

public class MainHandler
{
	public static void main(String[] args)
	{
		System.out.println("Welcome to Vaccination System!");

		int option = Start.showMenu();
		System.out.println();
		boolean flag = true;

		while (flag)
		{
			switch (option)
			{
				case 1:
					UserHandler.signUp();
					System.out.println(
							"\nRedirecting to Main page for login ...");
					flag = true;
					break;
				case 2:
					boolean signedIn = UserHandler.signIn();
					if (signedIn)
					{
						System.out.println(
								"\nRedirecting to your dashboard ...\n");
						UserHandler.dashboard();
					}
					break;
				case 3:
					boolean signedInAsDoctor = DoctorHandler.singIn();
					if (signedInAsDoctor)
					{
						System.out.println(
								"\nRedirecting to your dashboard ...\n");
						DoctorHandler.dashboard();
					}
					break;
				case 4:
					NurseHandler.singIn();
					break;
				case 5:
					System.out.println("Exiting from the System ...");
					flag = false;
					break;
			}
			if (flag)
			{
				clearScreen();
				option = Start.showMenu();
			}
		}

		System.out.println("\nprogram finished successfully!");
	}
}
