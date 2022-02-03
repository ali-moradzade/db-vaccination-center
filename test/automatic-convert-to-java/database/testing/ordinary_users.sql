# =================================
# testing ordinary users operations

# =======
# sign_up

SELECT *
FROM system_information;

CALL sign_up('0009831004', 'ali', 'asad',
             '2000-01-01', 'M', 'N',
             '1234567a');

CALL sign_up('0009831007', 'mehran', 'mahabadi',
             '2000-01-01', 'M', 'N',
             '1234567a');

CALL sign_up('0009831011', 'amirmohammad', 'babaei',
             '2000-01-01', 'M', 'N',
             '1234567a');

CALL sign_up('0009831020', 'mohammad', 'hassannejadi',
             '2000-01-01', 'M', 'N',
             '1234567a');

CALL sign_up('0009831024', 'farzad', 'radnia',
             '2000-01-01', 'M', 'N',
             '1234567a');

CALL sign_up('0009831041', 'amirreza', 'tarabkhah',
             '2000-01-01', 'M', 'N',
             '1234567a');

CALL sign_up('0009831042', 'hadi', 'abbasi',
             '2000-01-01', 'M', 'N',
             '1234567a');

CALL sign_up('0009831057', 'nima', 'mohammadi',
             '2000-01-01', 'M', 'N',
             '1234567a');

CALL sign_up('0009831058', 'ali', 'moradzade',
             '2000-01-01', 'M', 'N',
             '1234567a');

CALL sign_up('0009831059', 'abolfazl', 'moradi-fejooni',
             '2000-01-01', 'M', 'N',
             '1234567a');

CALL sign_up('0009831113', 'amir', 'khosravi-nezhad',
             '2000-01-01', 'M', 'N',
             '1234567a');

SELECT *
FROM system_information;

# =======
# sign_in

CALL sign_in('0009831024', '12345678a');
CALL sign_in('0009831041', '12345678a');
CALL sign_in('0009831057', '12345678a');
CALL sign_in('0009831059', '12345678a');
CALL sign_in('0009831113', '12345678a');

# ===============
# change_password

SELECT user_name, password
FROM system_information;

CALL change_password('0009831024', '12345678a', 'abcdefg1');
CALL change_password('0009831041', '12345678a', 'abcdefg1');
CALL change_password('0009831057', '12345678a', 'abcdefg1');
CALL change_password('0009831059', '12345678a', 'abcdefg1');
CALL change_password('0009831113', '12345678a', 'abcdefg1');

SELECT user_name, password
FROM system_information;

# ===============================
# show_vaccination_centers_points

# CREATE PROCEDURE show_vaccination_centers_points(
#     name_param VARCHAR(20)
# );

SELECT *
FROM vaccination_center;

CALL show_vaccination_center_points('abbasi-vacc-center');
CALL show_vaccination_center_points('asad-vacc-center');
CALL show_vaccination_center_points('babaei-vacc-center');
CALL show_vaccination_center_points('morad-vacc-center');

# ========================
# show_each_day_injections

# CREATE PROCEDURE show_each_day_injections(
#     date DATE
# );

SELECT *
from injection;

CALL show_each_day_injections('1400-10-10');
