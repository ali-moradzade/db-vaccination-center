package controller;

import view.Start;
import view.Start.StartOptions;

public class MainHandler
{
	public static void main(String[] args)
	{
		System.out.println("Welcome to Vaccination System!");

		StartOptions option = Start.showMenu();
		System.out.println();
		boolean flag = true;

		while (flag)
		{
			switch (option)
			{
				case singUp:
					UserHandler.signUp();
					System.out.println(
							"\nRedirecting to Main page for login ...");
					flag = true;
					break;
				case singIn:
					boolean signedIn = UserHandler.signIn();
					if (signedIn)
					{
						System.out.println(
								"\nRedirecting to your dashboard ...\n");
						UserHandler.dashboard();
					}
					break;
				case signInAsDoctor:
					boolean signedInAsDoctor = DoctorHandler.singIn();
					if (signedInAsDoctor)
					{
						System.out.println(
								"\nRedirecting to your dashboard ...\n");
						DoctorHandler.dashboard();
					}
					break;
				case signInAsNurse:
					boolean signedInAsNurse = NurseHandler.singIn();
					if (signedInAsNurse)
					{
						System.out.println(
								"\nRedirecting to your dashboard ...\n");
						NurseHandler.dashboard();
					}
					break;
				case exit:
					System.out.println("Exiting from the System ...");
					flag = false;
					break;
			}
			if (flag)
				option = Start.showMenu();
		}

		System.out.println("\nprogram finished successfully!");
	}
}
