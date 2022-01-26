package controller;

import java.util.Scanner;

import model.DoctorOperations;
import view.DoctorDashboard;

public class DoctorHandler
{
	public static boolean singIn()
	{
		System.out.println("Signing In (as a doctor) ...\n");
		Scanner input = new Scanner(System.in);

		System.out.print("enter your username: ");
		String username = input.nextLine();

		System.out.print("enter your password: ");
		String password = input.nextLine();

		return DoctorOperations.signInAsDoctor(username, password);
	}

	public static void dashboard()
	{
		int option = DoctorDashboard.showDashboard();

		boolean flag = true;
		while (flag)
		{
			switch (option)
			{
				// createBrand
				case 1:
					createBrand();
					break;
				// createVaccinationCenter
				case 2:
					createVaccinationCenter();
					break;
				// deleteAccount
				case 3:
					deleteAccount();
					break;
				// exit
				case 4:
					System.out.println("exiting your dashboard ...");
					flag = false;
					break;
			}

			if (flag)
			{
				System.out.println();
				option = DoctorDashboard.showDashboard();
			}
		}
	}

	public static void createBrand()
	{
		System.out.println("\nCreating Brand ...\n");
		Scanner input = new Scanner(System.in);

		System.out.print("enter brand name: ");
		String name_param = input.nextLine();

		System.out.print("enter creator doctor national code: ");
		String creator_doctor_national_code_param = input.nextLine();

		System.out.print("enter number of doses: ");
		String doses_param = input.nextLine();

		System.out.print("enter doses interval days: ");
		String doses_interval_days_param = input.nextLine();

		DoctorOperations.createBrand(name_param,
				creator_doctor_national_code_param,
				doses_param,
				doses_interval_days_param);
	}

	public static void createVaccinationCenter()
	{
		System.out.println("\nCreating new Vaccination Center ...\n");
		Scanner input = new Scanner(System.in);

		System.out.print("enter vaccination center name: ");
		String name_param = input.nextLine();

		System.out.print("enter creator doctor national code: ");
		String creator_doctor_param = input.nextLine();

		System.out.print("enter address of vaccination center: ");
		String address_param = input.nextLine();

		DoctorOperations.createVaccinationCenter(name_param,
				creator_doctor_param,
				address_param);
	}

	public static void deleteAccount()
	{
		System.out.println("\nDeleting Account ...\n");
		Scanner input = new Scanner(System.in);

		System.out.print("enter doctor national code: ");
		String doctor_national_code_param = input.nextLine();

		System.out.print("enter user national code: ");
		String user_name_para = input.nextLine();

		DoctorOperations.deleteAccount(doctor_national_code_param,
				user_name_para);
	}
}
