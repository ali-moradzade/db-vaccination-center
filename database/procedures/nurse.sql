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