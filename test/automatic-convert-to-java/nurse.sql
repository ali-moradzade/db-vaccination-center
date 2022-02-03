CREATE PROCEDURE sign_in_as_nurse(
    user_name_param VARCHAR(20),
    password_param VARCHAR(255)
)
CREATE PROCEDURE create_vial(
    creator_nurse_national_code_param CHAR(10),
    serial_number_param VARCHAR(20),
    vaccination_center_name_param VARCHAR(20),
    brand_name_param VARCHAR(20),
    production_location_param VARCHAR(20),
    production_date_param DATE
)
CREATE PROCEDURE injects(
    nurse_national_code_param CHAR(10),
    national_code_param CHAR(10),
    date_param DATE,
    vaccination_center_name_param VARCHAR(20),
    serial_number_param VARCHAR(20),
    point_param INT
)
