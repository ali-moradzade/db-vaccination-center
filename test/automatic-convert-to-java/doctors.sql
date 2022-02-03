CREATE PROCEDURE sign_in_as_doctor(
    user_name_param VARCHAR(20),
    password_param VARCHAR(255)
)
CREATE PROCEDURE create_brand(
    name_param VARCHAR(20),
    creator_doctor_national_code_param CHAR(10),
    doses_param INT,
    doses_interval_days_param INT
)
CREATE PROCEDURE create_vaccination_center(
    name_param VARCHAR(20),
    creator_doctor_param VARCHAR(20),
    address_param VARCHAR(50)
)
CREATE PROCEDURE delete_account(
    doctor_national_code_param CHAR(10),
    user_name_param CHAR(10)
)
