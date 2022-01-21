# ali moradzade 9831058

# ==============================
# making our tables

create table person
(
    national_code   varchar(20),
    first_name      varchar(20),
    last_name       varchar(20),
    birth_date      date,
    gender          char(1),
    special_disease char(2),
    primary key (national_code)
);

create table nurse
(
    national_code   varchar(20),
    first_name      varchar(20),
    last_name       varchar(20),
    birth_date      date,
    gender          char(1),
    special_disease varchar(250),
    degree_level    int,
    nursing_code    char(2),
    primary key (national_code)
);

create table doctor
(
    national_code         varchar(20),
    first_name            varchar(20),
    last_name             varchar(20),
    birth_date            date,
    gender                char(1),
    special_disease       char(2),
    medical_system_number int,
    primary key (national_code)
);

create table vaccination_center
(
    name    varchar(20),
    address varchar(50),
    primary key (name, address)
);

create table health_center
(
    health_center_code int,
    name               varchar(20),
    address            varchar(50),
    primary key (health_center_code)
);

create table injection
(
    injection_id  char(10),
    national_code varchar(20),
    name          varchar(20),
    address       varchar(50),
    time          time,
    point         int,
    primary key (injection_id, national_code, name, address),
    foreign key (national_code) references person (national_code),
    foreign key (name, address) references vaccination_center (name, address),
    check ( point between 1 and 5)
);

create table company
(
    name        varchar(20),
    nationality varchar(20),
    kind        varchar(10),
    primary key (name)
);

create table brand
(
    name         varchar(20),
    company_name varchar(20),
    primary key (name, company_name),
    foreign key (company_name) references company (name)
);

create table vial
(
    serial_number       char(20),
    brand_name          varchar(20),
    health_center_code  int,
    production_location varchar(20),
    production_date     date,
    primary key (brand_name, serial_number, health_center_code),
    foreign key (brand_name) references brand (name),
    foreign key (health_center_code) references health_center (health_center_code)
);

