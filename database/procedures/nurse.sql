DELIMITER $$

CREATE PROCEDURE sign_in_as_nurse(
    user_name_param VARCHAR(20),
    password_param VARCHAR(255)
)
BEGIN
    IF user_name_param NOT IN (
        SELECT user_name
        FROM system_information
    ) THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'User not found! Please sign up first.', MYSQL_ERRNO = 9000;
    END IF;

    IF NOT EXISTS(
            SELECT *
            FROM system_information
            WHERE (user_name_param, password_param) = (user_name, password)
        ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Your password is not correct. Please try again.', MYSQL_ERRNO = 9001;
    END IF;
    IF user_name_param NOT IN (
        SELECT national_code
        FROM nurse
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'You are not a nurse!', MYSQL_ERRNO = 9001;
    END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE create_vial(
    creator_nurse_national_code_param CHAR(10),
    serial_number_param VARCHAR(20),
    vaccination_center_name_param VARCHAR(20),
    brand_name_param VARCHAR(20),
    production_location_param VARCHAR(20),
    production_date_param DATE
)
BEGIN
    IF creator_nurse_national_code_param NOT IN (
        SELECT user_name
        FROM system_information
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'user does not exist!', MYSQL_ERRNO = 9002;
    END IF;

    IF creator_nurse_national_code_param NOT IN (
        SELECT national_code
        FROM nurse
        WHERE nursing_code = 'matron'
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'user must be nurse and his/her nursing code must be matron to create vial.',
                MYSQL_ERRNO = 9002;
    END IF;

    IF serial_number_param IN (
        SELECT serial_number
        FROM vial
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'vial exists!', MYSQL_ERRNO = 9002;
    END IF;

    INSERT INTO vial(creator_nurse_national_code, serial_number, vaccination_center_name, brand_name,
                     production_location, production_date)
    VALUES (creator_nurse_national_code_param, serial_number_param, vaccination_center_name_param,
            brand_name_param, production_location_param, production_date_param);
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE injects(
    nurse_national_code_param CHAR(10),
    national_code_param CHAR(10),
    date_param DATE,
    vaccination_center_name_param VARCHAR(20),
    serial_number_param VARCHAR(20),
    point_param INT
)
BEGIN
    START TRANSACTION;
    IF NOT point_param BETWEEN 1 AND 5 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'point must be between a and 5', MYSQL_ERRNO = 9002;

    END IF;

    INSERT INTO injection(nurse_national_code, national_code, date, vaccination_center_name, serial_number, point)
    VALUES (nurse_national_code_param, national_code_param, date_param, vaccination_center_name_param,
            serial_number_param, point_param);
    COMMIT;
END $$

DELIMITER ;
