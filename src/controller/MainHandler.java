package controller;

import view.Start;
import view.UserDashboard;

public class MainHandler
{
	public static void main(String[] args)
	{
		int option = Start.showMenu();
		System.out.println();
		boolean flag = true;

		while (flag)
		{
			flag = false;
			switch (option)
			{
				case 1:
					boolean signedUp = UserHandler.signUp();
					if (signedUp)
					{
						System.out.println(
								"\nRedirecting to Main page for login ..\n");
						flag = true;
					}
					break;
				case 2:
					boolean signedIn = UserHandler.signIn();
					if (signedIn)
					{
						System.out.println("\nRedirecting to your dashboard ...\n");
						int choose = UserDashboard.showDashboard();
						UserHandler.dashboard(choose);
					}
					else {
						flag = true;
					}
					break;
				case 3:
					DoctorHandler.singIn();
					break;
				case 4:
					NurseHandler.singIn();
					break;
			}
			if (flag)
				option = Start.showMenu();
		}
		
		System.out.println("\nprogram finished successfully!");
	}
}
