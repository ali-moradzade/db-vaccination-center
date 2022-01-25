# =================================
# testing ordinary users operations

# =======
# sign_up

SELECT *
from system_information;

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
