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

DELIMITER $$

CREATE PROCEDURE give_point(
    national_code_param CHAR(10),
    vaccination_center_name_param VARCHAR(20),
    brand_name_param VARCHAR(20),
    point_param INT,
    dose_number_param INT
)
BEGIN
    IF (national_code_param, vaccination_center_name_param, brand_name_param, point_param, dose_number_param) IN (
        SELECT *
        FROM points
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'you had given point for that dose and vaccination center.', MYSQL_ERRNO = 9002;
    END IF;

    INSERT INTO points(national_code, vaccination_center_name, brand_name, point, dose_number)
    VALUES (national_code_param, vaccination_center_name_param, brand_name_param, point_param, dose_number_param);
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE show_vaccination_centers_points(
    name_param VARCHAR(20)
)
BEGIN
    SELECT vaccination_center_name, point
    FROM points
    WHERE vaccination_center_name = name_param
    GROUP BY vaccination_center_name;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE show_each_day_injections(
    date DATE
)
BEGIN
    SELECT date, COUNT(national_code)
    FROM injection
    GROUP BY date DESC;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE show_each_brand_vaccinated_people(
    name_param VARCHAR(20)
)
BEGIN
    #     DECLARE number_of_doses INT;
#
#     SELECT doses
#     INTO number_of_doses
#     FROM brand
#     WHERE brand.name = name_param;

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