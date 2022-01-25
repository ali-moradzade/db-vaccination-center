# ================================
# inserting our people to database
INSERT INTO person(national_code, first_name, last_name, birth_date, gender, special_disease)
VALUES ('0009831004', 'ali', 'asad', '2000-1-1', 'M', 'N');

INSERT INTO person(national_code, first_name, last_name, birth_date, gender, special_disease)
VALUES ('0009831007', 'mehran', 'mahabadi', '2000-1-1', 'M', 'N');

INSERT INTO person(national_code, first_name, last_name, birth_date, gender, special_disease)
VALUES ('0009831011', 'amirmohammad', 'babaei', '2000-1-1', 'M', 'N');

INSERT INTO person(national_code, first_name, last_name, birth_date, gender, special_disease)
VALUES ('0009831020', 'mohammad', 'hassannejadi', '2000-1-1', 'M', 'N');

INSERT INTO person(national_code, first_name, last_name, birth_date, gender, special_disease)
VALUES ('0009831024', 'farzad', 'radnia', '2000-1-1', 'M', 'N');

INSERT INTO person(national_code, first_name, last_name, birth_date, gender, special_disease)
VALUES ('0009831041', 'amirreza', 'tarabkhah', '2000-1-1', 'M', 'N');

INSERT INTO person(national_code, first_name, last_name, birth_date, gender, special_disease)
VALUES ('0009831042', 'hadi', 'abbasi', '2000-1-1', 'M', 'N');

INSERT INTO person(national_code, first_name, last_name, birth_date, gender, special_disease)
VALUES ('0009831057', 'nima', 'mohammadi', '2000-1-1', 'M', 'N');

INSERT INTO person(national_code, first_name, last_name, birth_date, gender, special_disease)
VALUES ('0009831058', 'ali', 'moradzade', '2000-1-1', 'M', 'N');

INSERT INTO person(national_code, first_name, last_name, birth_date, gender, special_disease)
VALUES ('0009831059', 'abolfazal', 'moradi-fejooni', '2000-1-1', 'M', 'N');

INSERT INTO person(national_code, first_name, last_name, birth_date, gender, special_disease)
VALUES ('0009831113', 'amir', 'khosravi-nezhad', '2000-1-1', 'M', 'N');

# =====================
# inserting our doctors

INSERT INTO doctor(national_code, medical_system_number)
VALUES ('0009831004', '00001');

INSERT INTO doctor(national_code, medical_system_number)
VALUES ('0009831011', '00002');

INSERT INTO doctor(national_code, medical_system_number)
VALUES ('0009831042', '00003');

INSERT INTO doctor(national_code, medical_system_number)
VALUES ('0009831058', '00004');

# ====================
# inserting our nurses

INSERT INTO nurse(national_code, degree_level, nursing_code)
VALUES ('0009831007', '00000001', 'matron');

INSERT INTO nurse(national_code, degree_level, nursing_code)
VALUES ('0009831020', '00000002', 'supervisor');