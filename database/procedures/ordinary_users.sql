DELIMITER $$

CREATE PROCEDURE sign_up(
    IN national_code_param CHAR(10),
    IN first_name_param VARCHAR(20),
    IN last_name_param VARCHAR(20),
    IN birth_date_param DATE,
    IN gender_param CHAR(1),
    IN special_disease_param CHAR(255),
    IN password_param VARCHAR(255)
)
BEGIN
    START TRANSACTION;

    IF national_code_param IN (
        SELECT user_name
        FROM system_information
    ) THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'You have an account! log into your account.', MYSQL_ERRNO = 9000;
    END IF;

    IF (national_code_param, first_name_param, last_name_param, birth_date_param, gender_param,
        special_disease_param) NOT IN (
           SELECT *
           FROM person
       ) THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Person with given information does not exist.', MYSQL_ERRNO = 9000;
    END IF;

    IF NOT (password_param RLIKE '.*[0-9].*' AND
            password_param RLIKE '.*[a-z].*' AND
            LENGTH(password_param) >= 8
        ) THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Entered password must be at least 8 characters and and\n '
                '\thave at least one character and digit.', MYSQL_ERRNO = 9000;
    END IF;

    INSERT INTO system_information(user_name, password, creation_date)
    VALUES (national_code_param, password_param, NOW());
    COMMIT;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sign_in(
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
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE change_password(
    user_name_param VARCHAR(20),
    old_password_param VARCHAR(255),
    new_password_param VARCHAR(255)
)
BEGIN
    IF user_name_param NOT IN (
        SELECT user_name
        FROM system_information
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
                    'user does not exist!' , MYSQL_ERRNO = 9002;
    END IF;
    IF (user_name_param, old_password_param) NOT IN (
        SELECT user_name, password
        FROM system_information
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
                    'your old password is incorrect!' , MYSQL_ERRNO = 9002;
    END IF;
    IF NOT (new_password_param RLIKE '.*[0-9].*' AND
            new_password_param RLIKE '.*[a-z].*' AND
            LENGTH(new_password_param) >= 8
        ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
                    'Entered password must contain at least a number,\n'
                        'a letter, and have at least 8 characters length.', MYSQL_ERRNO = 9002;
    END IF;

    UPDATE system_information
    SET system_information.password = new_password_param
    WHERE system_information.user_name = user_name_param;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE show_vaccination_center_points(
    name_param VARCHAR(20)
)
BEGIN
    IF name_param NOT IN (
        SELECT name
        FROM vaccination_center
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'no such vaccination system!', MYSQL_ERRNO = 9002;
    END IF;

    SELECT vaccination_center_name, SUM(point)
    FROM injection
    WHERE vaccination_center_name = name_param;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE show_each_day_injections(
    date_param DATE
)
BEGIN
    SELECT date, COUNT(national_code)
    FROM injection
    WHERE date = date_param
    GROUP BY date DESC;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE show_each_brand_vaccinated_people(
    name_param VARCHAR(20)
)
BEGIN
    IF name_param NOT IN (
        SELECT name
        FROM brand
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'no such brand!', MYSQL_ERRNO = 9002;
    END IF;

    SELECT COUNT(national_code)
    FROM injection
    WHERE serial_number IN (
        SELECT serial_number
        FROM vial
                 NATURAL JOIN brand
        WHERE brand.name = name_param
    );
END $$

DELIMITER ;