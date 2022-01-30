# Vaccination Center
This is my final project of the Database Design course at AUT.\
Vaccination Center is a basic version of vaccination center that supports many things.  
All error handling, logic and type checkings are done by MySQL, and the java program just, creates a view and some handlers to connect the program to its database.  

you can read project description from [Here](db-final-fall-1400.pdf)

# Features

## General Operations:
- Siging up in the system
- Login as a user
- Login as a doctor
- Login as a nurse

## User Operations:
- Change password
- Show vaccinations center points
- Show each day injections
- Show each brand vaccinated people

## Doctor Operations:
- Create brand
- Create vaccisnation center
- Delete ordinary user or nurse account

## Nurse Operations:
- Create vial
- Inject vial
  

# How To Use
You first need to create a new user in MySQL as follows: (note: if your password policy is set to strong you should change password here and in in model.InitializeConfiguration class)
```sql 
mysql> CREATE USER 'ali'@'localhost' IDENTIFIED BY '1234';
```

and then create database
```sql
mysql> CREATE DATABASE db_vaccination_center;
```

and then grant all permission to the new user:
```sql
mysql> GRANT ALL PRIVILEGES ON db_vaccination_center.* TO ali@localhost;
mysql> FLUSH PRIVILEGES;
```

You can always change the configurations as you wish:

``` java 
{
    public static final String dbName = "db_vaccination_center";
	public static final String userid = "ali";
	public static final String passwd = "1234";
}
```

# Creating tables, procedures and adding data
You can use commands below to set up the initial data for our database:
```bash
$ # cloning the project and going to its directory
$ git clone https://github.com/ali-moradzade/db-vaccination-center.git
$ cd db-vaccination-center
$
$ # use the command below to run all the scripts needed to create tables, procedures and inserting data
$ # (note: this command will ask your database password for user ali, remember that our password is 1234)
$ cat database/create_tables.sql database/procedures/*.sql database/testing/insert_data.sql | mysql -u ali -p db_vaccination_center
```

at this momdent all of our tables are created and initialized with the data in `database/testing/insert_data.sql` file.

# Requirements for running program
  - mysql-connector-java
  
you need to have MySQL connector for java, download it from [Here](https://dev.mysql.com/downloads/connector/j/)
and then change the path in the `.classpath` file to point to your downloaed connector.
<br/>

# Test this program
The java project is in the form of eclipse project, so if you have eclipse you can eaily import this project and run the `controller.MainHandler` class.

# Uninstalling
You can drop the database if you don't like it:

```bash
$ # this will ask our password: 1234, and then starts interactive mysql program in terminal
$ mysql -u ali -p
$ 
$ # in the interactive mysql command line insert the following command:
$ mysql> drop database db_vaccination_center;
$
$ # so we deleted our database, now enter \q or quit to exit mysql inetractive program
$ mysql> quit
```
Done. we deleted our database and its information completely.