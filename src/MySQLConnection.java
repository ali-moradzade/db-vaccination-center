import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class MySQLConnection
{
	public static void main(String[] args)
	{
		//		JDBCexample("test", "root", "");
		example2("test", "root", "");
	}

	public static void JDBCexample(String dbName, String userid, String passwd)
	{
		try (Connection connection = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/" + dbName, userid, passwd);
				Statement statement = connection.createStatement();)
		{
			// ================= executing an update ================= 
			//			try
			//			{
			//				statement.executeUpdate(
			//						"insert into instructor values(’77987’,’Kim’,’Physics’,98000)");
			//			}
			//			catch (SQLException sqle)
			//			{
			//				System.out.println("Could not insert tuple. " + sqle);
			//			}
			//			
			//			
			// ================= executing a query ================= 
			ResultSet rs = statement
					.executeQuery("select name\n" +
							"from instructor\n" +
							"where salary > some (select salary\n" +
							"                     from instructor\n" +
							"                     where dept_name = 'Biology')");
			int count = 1;
			while (rs.next())
			{
				System.out.printf("%d- %s%n", count, rs.getString("name"));
				count++;
			}

			System.out.println("============");
			ResultSetMetaData rsmd = rs.getMetaData();
			for (int i = 1; i <= rsmd.getColumnCount(); i++)
			{
				System.out.print(rsmd.getColumnName(i) + " ");
				System.out.println(rsmd.getColumnTypeName(i));
			}
		}
		catch (Exception sqle)
		{
			System.out.println("Exception : " + sqle);
		}
	}

	public static void example2(String dbName, String userid, String passwd)
	{
		try (Connection connection = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/" + dbName, userid, passwd);
				Statement statement = connection.createStatement();)
		{
			ResultSet rs = statement
					.executeQuery("" +
							"select dept_name,\n" +
							"       (\n" +
							"           select count(*)\n" +
							"           from instructor\n" +
							"           where department.dept_name = instructor.dept_name\n" +
							"       ) as num_instructors\n" +
							"from department;\n");
			while (rs.next())
				System.out.printf("%-10s %s%n", rs.getString("dept_name"),
						rs.getString("num_instructors"));

			printMetadDataAndHeader(rs);

			rs = statement
					.executeQuery("" +
							"with dept_total(dept_name, value) as (\n" +
							"    select dept_name, sum(salary)\n" +
							"    from instructor\n" +
							"    group by dept_name),\n" +
							"     dept_total_avg(value) as (\n" +
							"         select avg(dept_total.value)\n" +
							"         from dept_total)\n" +
							"select dept_name\n" +
							"from dept_total,\n" +
							"     dept_total_avg\n" +
							"where dept_total.value > dept_total_avg.value;\n");
			while (rs.next())
				System.out.printf("%s%n", rs.getString("dept_name"));

			printMetadDataAndHeader(rs);

			rs = statement.executeQuery("" +
					"select dept_name, avg_salary\n" +
					"from (\n" +
					"         select dept_name, avg(salary) as avg_salary\n" +
					"         from instructor\n" +
					"         group by dept_name\n" +
					"     ) as dept_avg\n" +
					"where dept_avg.avg_salary > 80000;\n");
			while (rs.next())
				System.out.printf("%-15s %15.2f%n", rs.getString("dept_name"),
						rs.getFloat("avg_salary"));

			printMetadDataAndHeader(rs);
		}
		catch (Exception sqlException)
		{
			System.out.println("Exception : " + sqlException);
		}
	}

	public static void printMetadDataAndHeader(ResultSet rs) throws SQLException
	{
		System.out.println();
		printMetadata(rs);
		printSeparator();
	}

	public static void printSeparator()
	{
		String result = IntStream.range(1, 40).mapToObj(index -> "" + '*')
				.collect(Collectors.joining());
		System.out.println(result);
	}

	public static void printMetadata(ResultSet rs) throws SQLException
	{
		ResultSetMetaData rsmd = rs.getMetaData();
		for (int i = 1; i <= rsmd.getColumnCount(); i++)
		{
			System.out.printf("%-20s%-20s%n",
					rsmd.getColumnName(i), rsmd.getColumnTypeName(i));
		}
	}
}
