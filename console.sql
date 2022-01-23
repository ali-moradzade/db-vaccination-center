# ali moradzade 9831058

# ====================
# 1. making our tables

CREATE TABLE person
(
    national_code   CHAR(10) UNIQUE,
    first_name      VARCHAR(20) NOT NULL,
    last_name       VARCHAR(20) NOT NULL,
    birth_date      DATE,
    gender          CHAR(1)     NOT NULL,
    special_disease CHAR(255),
    PRIMARY KEY (national_code),
    CHECK (national_code RLIKE '[0-9]{10}'),
    CHECK (gender RLIKE '[FM]')
);

CREATE TABLE doctor
(
    national_code         CHAR(10) UNIQUE,
    first_name            VARCHAR(20) NOT NULL,
    last_name             VARCHAR(20) NOT NULL,
    birth_date            DATE,
    gender                CHAR(1)     NOT NULL,
    special_disease       CHAR(255),
    medical_system_number CHAR(5)     NOT NULL UNIQUE,
    PRIMARY KEY (national_code),
    CHECK (national_code RLIKE '[0-9]{10}'),
    CHECK (gender RLIKE '[FM]'),
    CHECK (medical_system_number RLIKE '[0-9]{5}')
);

CREATE TABLE nurse
(
    national_code   CHAR(10) UNIQUE,
    first_name      VARCHAR(20) NOT NULL,
    last_name       VARCHAR(20) NOT NULL,
    birth_date      DATE,
    gender          CHAR(1)     NOT NULL,
    special_disease VARCHAR(255),
    degree_level    CHAR(8) UNIQUE,
    nursing_code    VARCHAR(20) NOT NULL,
    PRIMARY KEY (national_code),
    CHECK (national_code RLIKE '[0-9]{10}'),
    CHECK (gender RLIKE '[FM]'),
    CHECK (degree_level RLIKE '[0-9]{8}'),
    CHECK (nursing_code IN ('matron', 'supervisor', 'nurse', 'practical'))
);

CREATE TABLE system_information
(
    user_name     VARCHAR(20),
    password      VARCHAR(255),
    creation_date DATETIME,
    PRIMARY KEY (user_name),
    CHECK (password RLIKE '.*[0-9].*' AND password RLIKE '.*[a-z].*' AND LENGTH(password) >= 8)
);

CREATE TABLE account
(
    national_code CHAR(10),
    user_name     VARCHAR(20),
    PRIMARY KEY (national_code, user_name),
    FOREIGN KEY (national_code) REFERENCES person (national_code),
    FOREIGN KEY (user_name) REFERENCES system_information (user_name)
);

CREATE TABLE deletes
(
    user_name            VARCHAR(20),
    doctor_national_code CHAR(10),
    PRIMARY KEY (user_name, doctor_national_code),
    FOREIGN KEY (user_name) REFERENCES account (user_name),
    FOREIGN KEY (doctor_national_code) REFERENCES doctor (national_code)
);

CREATE TABLE vaccination_center
(
    name           VARCHAR(20),
    creator_doctor VARCHAR(20),
    address        VARCHAR(50) NOT NULL,
    PRIMARY KEY (name),
    FOREIGN KEY (creator_doctor) REFERENCES doctor (national_code)
);

CREATE TABLE brand
(
    name                         VARCHAR(20),
    creator_doctor_national_code CHAR(10),
    doses                        INT,
    doses_interval_days          TIME,
    PRIMARY KEY (name),
    FOREIGN KEY (creator_doctor_national_code) REFERENCES doctor (national_code)
);

CREATE TABLE vial
(
    creator_nurse_national_code CHAR(10),
    serial_number               VARCHAR(20),
    vaccination_center_name     VARCHAR(20),
    brand_name                  VARCHAR(20),
    production_location         VARCHAR(20) NOT NULL,
    production_date             DATE,
    PRIMARY KEY (serial_number),
    FOREIGN KEY (creator_nurse_national_code) REFERENCES nurse (national_code),
    FOREIGN KEY (vaccination_center_name) REFERENCES vaccination_center (name),
    FOREIGN KEY (brand_name) REFERENCES brand (name)
);

CREATE TABLE injection
(
    nurse_national_code     CHAR(10),
    national_code           CHAR(10),
    date                    DATE,
    vaccination_center_name VARCHAR(20),
    serial_number           VARCHAR(20),
    PRIMARY KEY (nurse_national_code, national_code, date, vaccination_center_name, serial_number),
    FOREIGN KEY (nurse_national_code) REFERENCES nurse (national_code),
    FOREIGN KEY (national_code) REFERENCES person (national_code),
    FOREIGN KEY (vaccination_center_name) REFERENCES vaccination_center (name),
    FOREIGN KEY (serial_number) REFERENCES vial (serial_number)
);

# ==========================
# 2. creating our procedures

# ========================
# 2.1 all users operations
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

# ======================
# 2.2 doctors operations
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

# =====================
# 2.3 nurses operations
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
