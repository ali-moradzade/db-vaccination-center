# ==========================
# testing doctors procedures

SELECT *
FROM person
WHERE national_code IN (
    SELECT national_code
    FROM doctor
);

# =================
# sign_up_as_doctor

# sign_in_as_doctor(
#     user_name_param VARCHAR(20),
#     password_param VARCHAR(255)
# );

SELECT national_code, first_name, last_name, password
FROM person
         NATURAL JOIN doctor
         INNER JOIN system_information si ON person.national_code = si.user_name;

CALL sign_in_as_doctor('0009831004', '1234567a');
CALL sign_in_as_doctor('0009831011', '1234567a');
CALL sign_in_as_doctor('0009831042', '1234567a');
CALL sign_in_as_doctor('0009831058', '1234567a');

# ============
# create_brand

# create_brand(
#     name_param VARCHAR(20),
#     creator_doctor_national_code_param CHAR(10),
#     doses_param INT,
#     doses_interval_days_param TIME
# );

SELECT *
FROM brand;

CALL create_brand('ali-asad-brand', '0009831004',
                  '3', '30');
CALL create_brand('amir-babaei-brand', '0009831011',
                  '3', '31');
CALL create_brand('hadi-abbasi-brand', '0009831042',
                  '3', '32');
CALL create_brand('ali-moradzade-brand', '0009831058',
                  '3', '33');
SELECT *
FROM brand;

# =========================
# create_vaccination_center

# CREATE PROCEDURE create_vaccination_center(
#     name_param VARCHAR(20),
#     creator_doctor_param VARCHAR(20),
#     address_param VARCHAR(50)
# );

SELECT *
FROM vaccination_center;

CALL create_vaccination_center('asad-vacc-center', '0009831004',
                               'address');
CALL create_vaccination_center('babaei-vacc-center', '0009831011',
                               'address');
CALL create_vaccination_center('abbasi-vacc-center', '0009831042',
                               'address');
CALL create_vaccination_center('morad-vacc-center', '0009831058',
                               'address');

SELECT *
FROM vaccination_center;

# ======================
# testing delete account

# CREATE PROCEDURE delete_account(
#     doctor_national_code_param CHAR(10),
#     user_name_param CHAR(10)
# );

SELECT *
FROM system_information;

CALL delete_account('0009831058', '0009831057');

SELECT *
FROM system_information;
