package controller;

import java.util.Scanner;

import model.NurseOperations;
import view.NurseDashboard;
import view.NurseDashboard.NurseOptions;

public class NurseHandler
{
	public static boolean singIn()
	{
		System.out.println("Signing In (as a nurse) ...\n");
		Scanner input = new Scanner(System.in);

		System.out.print("Enter your username: ");
		String username = input.nextLine();

		System.out.print("Enter your password: ");
		String password = input.nextLine();

		return NurseOperations.signInAsNurse(username, password);
	}

	public static void dashboard()
	{
		NurseOptions option = NurseDashboard.showDashboard();

		boolean flag = true;
		while (flag)
		{
			switch (option)
			{
				case createVial:
					createVial();
					break;
				case injects:
					injects();
					break;
				case exit:
					System.out.println("\nexiting your dashboard ...");
					flag = false;
					break;
			}
			if (flag)
			{
				System.out.println();
				option = NurseDashboard.showDashboard();
			}
		}
	}

	public static void createVial()
	{
		System.out.println("\nCreating a Vial ...\n");
		Scanner input = new Scanner(System.in);

		System.out.print("enter creator nurse national code: ");
		String creator_nurse_national_code_param = input.nextLine();

		System.out.print("enter serial number of vial: ");
		String serial_number_param = input.nextLine();

		System.out.print("enter vaccination center name: ");
		String vaccination_center_name_param = input.nextLine();

		System.out.print("enter brand name: ");
		String brand_name_param = input.nextLine();

		System.out.print("enter production location: ");
		String production_location_param = input.nextLine();

		System.out.print("enter production date: ");
		String production_date_param = input.nextLine();

		NurseOperations.createVial(creator_nurse_national_code_param,
				serial_number_param,
				vaccination_center_name_param,
				brand_name_param,
				production_location_param,
				production_date_param);
	}

	public static void injects()
	{
		System.out.println("\nInjecting ...\n");
		Scanner input = new Scanner(System.in);

		System.out.print("enter nurse national code: ");
		String nurse_national_code_param = input.nextLine();

		System.out.print("enter person national code: ");
		String national_code_param = input.nextLine();

		System.out.print("enter date: ");
		String date_param = input.nextLine();

		System.out.print("enter vaccination center name: ");
		String vaccination_center_name_param = input.nextLine();

		System.out.print("enter serial number: ");
		String serial_number_param = input.nextLine();

		System.out.print("enter point: ");
		String point_param = input.nextLine();

		NurseOperations.injects(nurse_national_code_param,
				national_code_param,
				date_param,
				vaccination_center_name_param,
				serial_number_param,
				point_param);
	}
}
