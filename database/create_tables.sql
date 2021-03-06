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
    special_disease CHAR(1),
    PRIMARY KEY (national_code),
    CHECK (national_code RLIKE '[0-9]{10}'),
    CHECK (gender RLIKE '[FfMm]'),
    CHECK ( special_disease RLIKE '[YyNn]')
);

CREATE TABLE doctor
(
    national_code         CHAR(10),
    medical_system_number CHAR(5) NOT NULL UNIQUE,
    PRIMARY KEY (national_code),
    FOREIGN KEY (national_code) REFERENCES person (national_code),
    CHECK (medical_system_number RLIKE '[0-9]{5}')
);

CREATE TABLE nurse
(
    national_code CHAR(10),
    degree_level  CHAR(8) UNIQUE,
    nursing_code  VARCHAR(20) NOT NULL,
    PRIMARY KEY (national_code),
    FOREIGN KEY (national_code) REFERENCES person (national_code),
    CHECK (degree_level RLIKE '[0-9]{8}'),
    CHECK (nursing_code IN ('matron', 'supervisor', 'nurse', 'practical'))
);

CREATE TABLE system_information
(
    user_name     VARCHAR(20),
    password      VARCHAR(255),
    creation_date DATETIME,
    PRIMARY KEY (user_name),
    FOREIGN KEY (user_name) REFERENCES person (national_code),
    CHECK (password RLIKE '.*[0-9].*' AND password RLIKE '.*[a-z].*' AND LENGTH(password) >= 8)
);

CREATE TABLE vaccination_center
(
    name           VARCHAR(20),
    creator_doctor VARCHAR(20) NOT NULL,
    address        VARCHAR(50) NOT NULL,
    PRIMARY KEY (name),
    FOREIGN KEY (creator_doctor) REFERENCES doctor (national_code)
);

CREATE TABLE brand
(
    name                         VARCHAR(20),
    creator_doctor_national_code CHAR(10),
    doses                        INT,
    doses_interval_days          INT,
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
    national_code           CHAR(10),
    nurse_national_code     CHAR(10),
    vaccination_center_name VARCHAR(20),
    serial_number           VARCHAR(20),
    point                   INT,
    date                    DATE,
    PRIMARY KEY (national_code, date),
    FOREIGN KEY (nurse_national_code) REFERENCES nurse (national_code),
    FOREIGN KEY (national_code) REFERENCES person (national_code),
    FOREIGN KEY (vaccination_center_name) REFERENCES vaccination_center (name),
    FOREIGN KEY (serial_number) REFERENCES vial (serial_number),
    CHECK ( point BETWEEN 1 AND 5)
);
