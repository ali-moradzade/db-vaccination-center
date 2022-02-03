CREATE PROCEDURE sign_up(
    national_code_param CHAR(10),
    first_name_param VARCHAR(20),
    last_name_param VARCHAR(20),
    birth_date_param DATE,
    gender_param CHAR(1),
    special_disease_param CHAR(255),
    password_param VARCHAR(255)
)
CREATE PROCEDURE sign_in(
    user_name_param VARCHAR(20),
    password_param VARCHAR(255)
)
CREATE PROCEDURE change_password(
    user_name_param VARCHAR(20),
    old_password_param VARCHAR(255),
    new_password_param VARCHAR(255)
)
CREATE PROCEDURE show_vaccination_center_points(
    name_param VARCHAR(20)
)
CREATE PROCEDURE show_each_day_injections(
    date DATE
)
CREATE PROCEDURE show_each_brand_vaccinated_people(
    name_param VARCHAR(20)
)
