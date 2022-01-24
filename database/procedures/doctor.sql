DELIMITER $$

CREATE PROCEDURE create_brand(
    name_param VARCHAR(20),
    creator_doctor_national_code_param CHAR(10),
    doses_param INT,
    doses_interval_days_param TIME
)
BEGIN
    IF creator_doctor_national_code_param NOT IN (
        SELECT user_name
        FROM system_information
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'user does not exist!', MYSQL_ERRNO = 9002;
    END IF;

    IF creator_doctor_national_code_param NOT IN (
        SELECT national_code
        FROM doctor
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'user must be doctor to create brand.', MYSQL_ERRNO = 9002;
    END IF;

    IF name_param IN (
        SELECT name
        FROM brand
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'brand exists!', MYSQL_ERRNO = 9002;
    END IF;

    INSERT INTO brand(name, creator_doctor_national_code, doses, doses_interval_days)
    VALUES (name_param,
            creator_doctor_national_code_param,
            doses_param,
            doses_interval_days_param);
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE create_vaccination_center(
    name_param VARCHAR(20),
    creator_doctor_param VARCHAR(20),
    address_param VARCHAR(50)
)
BEGIN
    IF creator_doctor_param NOT IN (
        SELECT user_name
        FROM system_information
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'user does not exist!', MYSQL_ERRNO = 9002;
    END IF;

    IF creator_doctor_param NOT IN (
        SELECT national_code
        FROM doctor
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'user must be doctor to create brand.', MYSQL_ERRNO = 9002;
    END IF;

    IF name_param IN (
        SELECT name
        FROM vaccination_center
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'vaccination center exists!', MYSQL_ERRNO = 9002;
    END IF;

    INSERT INTO vaccination_center(name, creator_doctor, address)
    VALUES (name_param, creator_doctor, address_param);
END $$

DELIMITER ;