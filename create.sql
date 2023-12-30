-- Create STORAGE
CREATE TABLESPACE assignment2
  DATAFILE 'assignment2.dat' SIZE 40M 
  ONLINE;

-- Create Users
CREATE USER groupUser IDENTIFIED BY groupPassword ACCOUNT UNLOCK
	DEFAULT TABLESPACE assignment2
	QUOTA 20M ON assignment2;

CREATE USER testUser IDENTIFIED BY testPassword ACCOUNT UNLOCK
	DEFAULT TABLESPACE assignment2
	QUOTA 5M ON assignment2;

-- Create ROLES
CREATE ROLE applicationAdmin;
CREATE ROLE applicationUser;

-- Grant PRIVILEGES
GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE TRIGGER, CREATE PROCEDURE TO applicationAdmin;
GRANT CONNECT, RESOURCE TO applicationUser;

GRANT applicationAdmin TO groupUser;
GRANT applicationUser TO testUser;

connect groupUser/groupPassword;



--create single-value tables APPLANCE,CATEGORY and COST
CREATE TABLE APPLIANCE (
  idappliance int NOT NULL,
  PRIMARY KEY (idappliance)
);

CREATE TABLE CATEGORY (
  idcategory int NOT NULL,
  category varchar(45) not null,
  PRIMARY KEY (idcategory)
);

CREATE TABLE COST (
  idcost int NOT NULL,
  cost number(10,2) NOT NULL,
  PRIMARY KEY (idcost)
);

-- create association table APPLIANCE_CATEGORY
  CREATE TABLE APPLIANCE_CATEGORY (
  starttime timestamp NOT NULL,
  endtime timestamp DEFAULT NULL,
  appliance_idapp int NOT NULL,
  category_idcat int NOT NULL,
  PRIMARY KEY (appliance_idapp,category_idcat),
  CONSTRAINT fk_app_cat_a FOREIGN KEY (appliance_idapp) REFERENCES APPLIANCE (idappliance),
  CONSTRAINT fk_app_cat_c FOREIGN KEY (category_idcat) REFERENCES CATEGORY (idcategory)
);

-- create association table APPLIANCE_COST
  CREATE TABLE APPLIANCE_COST (
  starttime timestamp NOT NULL,
  endtime timestamp DEFAULT NULL,
  appliance_idapp int NOT NULL,
  cost_icost int NOT NULL,
  PRIMARY KEY (appliance_idapp,cost_icost),
  CONSTRAINT fk_app_cost_a FOREIGN KEY (appliance_idapp) REFERENCES APPLIANCE (idappliance),
  CONSTRAINT fk_app_cost_c  FOREIGN KEY (cost_icost) REFERENCES COST (idcost)
);



--create single-value tables TECHNICIAN, NAME and PHONE
CREATE TABLE TECHNICIAN (
  idtechnician int NOT NULL,
  PRIMARY KEY (idtechnician)
);

CREATE TABLE NAME (
  idname int NOT NULL,
  name varchar(45) not null,
  PRIMARY KEY (idname)
);

CREATE TABLE PHONE (
  idphone int NOT NULL,
  phone varchar(45) NOT NULL,
  PRIMARY KEY (idphone)
);


-- create association table TECHNICIAN_NAME
  CREATE TABLE TECHNICIAN_NAME (
  starttime timestamp NOT NULL,
  endtime timestamp DEFAULT NULL,
  technician_idtech int NOT NULL,
  name_idname int NOT NULL,
  PRIMARY KEY (technician_idtech,name_idname),
  CONSTRAINT fk_tech_name_t FOREIGN KEY (technician_idtech) REFERENCES TECHNICIAN (idtechnician),
  CONSTRAINT fk_tech_name_n FOREIGN KEY (name_idname) REFERENCES NAME (idname)
);

-- create association table TECHNICIAN_PHONE
  CREATE TABLE TECHNICIAN_PHONE (
  starttime timestamp NOT NULL,
  endtime timestamp DEFAULT NULL,
  technician_idtech int NOT NULL,
  phone_idphone int NOT NULL,
  PRIMARY KEY (technician_idtech,phone_idphone),
  CONSTRAINT fk_tech_phone_t FOREIGN KEY (technician_idtech) REFERENCES TECHNICIAN (idtechnician),
  CONSTRAINT fk_tech_phone_p  FOREIGN KEY (phone_idphone) REFERENCES PHONE (idphone)
);


