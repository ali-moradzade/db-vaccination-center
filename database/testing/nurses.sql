# =============================
# testing our nurses procedures

# ================
# sign_in_as_nurse

# CREATE PROCEDURE sign_in_as_nurse(
#     user_name_param VARCHAR(20),
#     password_param VARCHAR(255)
# );

SELECT *
FROM person
         NATURAL JOIN nurse;

SELECT *
FROM system_information
WHERE user_name IN (
    SELECT national_code
    FROM nurse
);

CALL sign_in_as_nurse('0009831007', '1234567a');
CALL sign_in_as_nurse('0009831020', '1234567a');

# ===========
# create_vial

# CREATE PROCEDURE create_vial(
#     creator_nurse_national_code_param CHAR(10),
#     serial_number_param VARCHAR(20),
#     vaccination_center_name_param VARCHAR(20),
#     brand_name_param VARCHAR(20),
#     production_location_param VARCHAR(20),
#     production_date_param DATE
# );

SELECT *
FROM person,
     system_information
WHERE national_code = system_information.user_name
  AND national_code IN (
    SELECT national_code
    FROM nurse
    WHERE nursing_code = 'matron'
);

SELECT *
FROM vaccination_center;

SELECT *
FROM brand;

CALL create_vial('0009831007', 'vial-00001',
                 'morad-vacc-center', 'ali-moradzade-brand',
                 'saave', '1400-01-01');

SELECT *
FROM vial;

# =======
# injects

# CREATE PROCEDURE injects(
#     nurse_national_code_param CHAR(10),
#     national_code_param CHAR(10),
#     date_param DATE,
#     vaccination_center_name_param VARCHAR(20),
#     serial_number_param VARCHAR(20),
#     point_param INT
# );

SELECT *
FROM nurse;

SELECT *
FROM vaccination_center;

SELECT *
FROM vial;

SELECT *
FROM person;

CALL injects('0009831020', '0009831004', '1400-10-10',
             'morad-vacc-center', 'vial-00001', '5');
CALL injects('0009831020', '0009831011', '1400-10-10',
             'morad-vacc-center', 'vial-00001', '3');
CALL injects('0009831020', '0009831058', '1400-10-10',
             'morad-vacc-center', 'vial-00001', '3');

SELECT *
FROM injection;
