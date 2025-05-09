CREATE TABLE menu_day (
    id_menu_day INT IDENTITY(1,1) PRIMARY KEY,
    menu_name varchar(50),
    workday DATE NOT NULL,
    limit_hour TIME NOT NULL,
    day_status INT NOT NULL

);

CREATE TABLE menu_day_detail (
    id_menu_day_detail INT IDENTITY(1,1) PRIMARY KEY,
    id_menu_day INT NOT NULL,
    meal VARCHAR(50) NOT NULL,
    meal_options VARCHAR(300) NULL
);
