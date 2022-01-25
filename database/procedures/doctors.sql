DELIMITER $$

CREATE PROCEDURE sign_in_as_doctor(
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
        FROM doctor
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'You are not a doctor!', MYSQL_ERRNO = 9001;
    END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE create_brand(
    name_param VARCHAR(20),
    creator_doctor_national_code_param CHAR(10),
    doses_param INT,
    doses_interval_days_param INT
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
    VALUES (name_param, creator_doctor_param, address_param);
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE delete_account(
    doctor_national_code_param CHAR(10),
    user_name_param CHAR(10)
)
BEGIN
    IF doctor_national_code_param NOT IN (
        SELECT national_code
        FROM doctor
        WHERE national_code IN (
            SELECT user_name
            FROM system_information
        )
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'just doctors can delete accounts!', MYSQL_ERRNO = 9002;
    END IF;

    IF user_name_param NOT IN (
        SELECT user_name
        FROM system_information
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'user not found!', MYSQL_ERRNO = 9002;
    END IF;

    DELETE
    FROM system_information
    WHERE user_name = user_name_param;
END;

DELIMITER ;