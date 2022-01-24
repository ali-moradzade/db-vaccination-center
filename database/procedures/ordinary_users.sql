DELIMITER $$

CREATE PROCEDURE sign_up(
    IN national_code_param CHAR(10),
    IN password_param VARCHAR(255),
    IN first_name_param VARCHAR(20),
    IN last_name_param VARCHAR(20),
    IN birth_date_param DATE,
    IN gender_param CHAR(1),
    IN special_disease_param CHAR(255),
    OUT result VARCHAR(255)
)
BEGIN
    START TRANSACTION;
    SET result = '';

    IF national_code_param IN (
        SELECT user_name
        FROM system_information
    ) THEN
        SET result = 'This username is already taken.\n';
    END IF;

    IF (national_code_param, first_name_param, last_name_param, birth_date_param, gender_param,
        special_disease_param) NOT IN (
           SELECT *
           FROM person
       ) THEN
        SET result = CONCAT(result, 'Person with given information does not exist.\n');
    END IF;

    IF NOT (
                password_param RLIKE '.*[0-9].*' AND
                password_param RLIKE '.*[a-z].*' AND
                LENGTH(password_param) >= 8
        ) THEN
        SET result = CONCAT(result,
                            'Entered password must be at least 8 characters and and\n '
                                'have at least one character and digit.');
    END IF;

    IF STRCMP(result, '') <> 0 THEN
        ROLLBACK;
    ELSE
        INSERT INTO system_information(user_name, password, creation_date)
        VALUES (national_code_param, password_param, NOW());

        INSERT INTO account(national_code, user_name) VALUES (national_code, national_code);

        SET result = 'Signed up successfully!';
        COMMIT;
    END IF;
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
    new_password_param VARCHAR(255)
)
BEGIN
    IF NOT (
                new_password_param RLIKE '.*[0-9].*' AND
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
