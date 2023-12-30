
-- Views For Technicians
CREATE OR REPLACE VIEW TECHNICIAN_VIEW AS 
SELECT TECHNICIAN.idtechnician, NAME.name, PHONE.phone
FROM TECHNICIAN
LEFT JOIN TECHNICIAN_NAME ON TECHNICIAN.idtechnician = TECHNICIAN_NAME.technician_idtech
LEFT JOIN NAME ON TECHNICIAN_NAME.name_idname = NAME.idname 
LEFT JOIN TECHNICIAN_PHONE ON TECHNICIAN.idtechnician = TECHNICIAN_PHONE.technician_idtech
LEFT JOIN PHONE ON TECHNICIAN_PHONE.phone_idphone = PHONE.idphone
WHERE
    (TECHNICIAN_NAME.ENDTIME IS NULL)
    AND
    (TECHNICIAN_PHONE.ENDTIME IS NULL);

-- Sequences for inserting new name and phone entries 
CREATE SEQUENCE name_sequence
START WITH 1
INCREMENT BY 1
NOCACHE;
CREATE SEQUENCE phone_sequence
START WITH 1
INCREMENT BY 1
NOCACHE;

-- INSERT Trigger For TECHNICIAN_VIEW
CREATE OR REPLACE TRIGGER InsertTechnicianView
INSTEAD OF INSERT ON TECHNICIAN_VIEW
FOR EACH ROW
BEGIN
    INSERT INTO TECHNICIAN (idtechnician)
    VALUES (:NEW.idtechnician);

    INSERT INTO NAME (idname, name)
    VALUES (name_sequence.NEXTVAL, :NEW.name);
    
    INSERT INTO TECHNICIAN_NAME (technician_idtech, name_idname, starttime)
    VALUES (:NEW.idtechnician, name_sequence.CURRVAL, SYSDATE);

    INSERT INTO PHONE (idphone, phone)
    VALUES (phone_sequence.NEXTVAL, :NEW.phone);

    INSERT INTO TECHNICIAN_PHONE (technician_idtech, phone_idphone, starttime)
    VALUES (:NEW.idtechnician, phone_sequence.CURRVAL, SYSDATE);
END;
/

-- UPDATE Trigger For TECHNICIAN_VIEW
CREATE OR REPLACE TRIGGER UpdateTechnicianView
INSTEAD OF UPDATE ON TECHNICIAN_VIEW
FOR EACH ROW
BEGIN
  
    INSERT INTO NAME (idname, name)
    VALUES (name_sequence.NEXTVAL, :NEW.name);

    UPDATE TECHNICIAN_NAME
    SET endtime = SYSDATE
    WHERE technician_idtech = :NEW.idtechnician AND endtime IS NULL;

    INSERT INTO TECHNICIAN_NAME (technician_idtech, name_idname, starttime)
    VALUES (:NEW.idtechnician, name_sequence.CURRVAL, SYSDATE);

    INSERT INTO PHONE (idphone, phone)
    VALUES (phone_sequence.NEXTVAL, :NEW.phone);

    UPDATE TECHNICIAN_PHONE
    SET endtime = SYSDATE
    WHERE technician_idtech = :NEW.idtechnician AND endtime IS NULL;

    INSERT INTO TECHNICIAN_PHONE (technician_idtech, phone_idphone, starttime)
    VALUES (:NEW.idtechnician, phone_sequence.CURRVAL, SYSDATE);
END;
/

-- DELETE Trigger For TECHNICIAN_VIEW
CREATE OR REPLACE TRIGGER DeleteTechnicianView
INSTEAD OF DELETE ON TECHNICIAN_VIEW
FOR EACH ROW
BEGIN
  
    UPDATE TECHNICIAN_NAME
    SET endtime = SYSDATE
    WHERE technician_idtech = :OLD.idtechnician AND endtime IS NULL;
    
    UPDATE TECHNICIAN_PHONE
    SET endtime = SYSDATE
    WHERE technician_idtech = :OLD.idtechnician AND endtime IS NULL;

    DELETE FROM TECHNICIAN
    WHERE idtechnician = :OLD.idtechnician;
END;
/

-- DELETE Trigger For TECHNICIAN_VIEW
CREATE OR REPLACE TRIGGER DeleteTechnicianView
INSTEAD OF DELETE ON TECHNICIAN_VIEW
FOR EACH ROW
BEGIN
    UPDATE TECHNICIAN_NAME
    SET endtime = SYSDATE
    WHERE technician_idtech = :OLD.idtechnician AND endtime IS NULL;

    UPDATE TECHNICIAN_PHONE
    SET endtime = SYSDATE
    WHERE technician_idtech = :OLD.idtechnician AND endtime IS NULL;

    DELETE FROM TECHNICIAN
    WHERE idtechnician = :OLD.idtechnician;
END;
/

-- Views For Appliances
CREATE OR REPLACE VIEW APPLIANCE_VIEW AS 
SELECT A.idappliance, C.category, CO.cost
FROM APPLIANCE A
LEFT JOIN APPLIANCE_CATEGORY AC ON A.idappliance = AC.appliance_idapp
LEFT JOIN CATEGORY C ON AC.category_idcat = C.idcategory
LEFT JOIN APPLIANCE_COST ACO ON A.idappliance = ACO.appliance_idapp
LEFT JOIN COST CO ON ACO.cost_icost = CO.idcost
WHERE AC.endtime IS NULL AND ACO.endtime IS NULL;

-- Sequences for inserting new category and cost entries 
CREATE SEQUENCE category_sequence
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE cost_sequence
START WITH 1
INCREMENT BY 1
NOCACHE;

-- INSERT Trigger For APPLIANCE_VIEW
CREATE OR REPLACE TRIGGER InsertApplianceView
INSTEAD OF INSERT ON APPLIANCE_VIEW
FOR EACH ROW
BEGIN
    
    INSERT INTO APPLIANCE (idappliance)
    VALUES (:NEW.idappliance);

    INSERT INTO CATEGORY (idcategory, category)
    VALUES (category_sequence.NEXTVAL, :NEW.category);
    
    INSERT INTO APPLIANCE_CATEGORY (appliance_idapp, category_idcat, starttime)
    VALUES (:NEW.idappliance, category_sequence.CURRVAL, SYSDATE);

    INSERT INTO COST (idcost, cost)
    VALUES (cost_sequence.NEXTVAL, :NEW.cost);

    INSERT INTO APPLIANCE_COST (appliance_idapp, cost_icost, starttime)
    VALUES (:NEW.idappliance, cost_sequence.CURRVAL, SYSDATE);
END;
/

-- UPDATE Trigger For APPLIANCE_VIEW
CREATE OR REPLACE TRIGGER UpdateApplianceView
INSTEAD OF UPDATE ON APPLIANCE_VIEW
FOR EACH ROW
BEGIN

    INSERT INTO CATEGORY (idcategory, category)
    VALUES (category_sequence.NEXTVAL, :NEW.category);

    UPDATE APPLIANCE_CATEGORY
    SET endtime = SYSDATE
    WHERE appliance_idapp = :NEW.idappliance AND endtime IS NULL;

    INSERT INTO APPLIANCE_CATEGORY (appliance_idapp, category_idcat, starttime)
    VALUES (:NEW.idappliance, category_sequence.CURRVAL, SYSDATE);

    INSERT INTO COST (idcost, cost)
    VALUES (cost_sequence.NEXTVAL, :NEW.cost);

    UPDATE APPLIANCE_COST
    SET endtime = SYSDATE
    WHERE appliance_idapp = :NEW.idappliance AND endtime IS NULL;

    INSERT INTO APPLIANCE_COST (appliance_idapp, cost_icost, starttime)
    VALUES (:NEW.idappliance, cost_sequence.CURRVAL, SYSDATE);
END;
/

-- DELETE Trigger For APPLIANCE_VIEW
CREATE OR REPLACE TRIGGER DeleteApplianceView
INSTEAD OF DELETE ON APPLIANCE_VIEW
FOR EACH ROW
BEGIN

    UPDATE APPLIANCE_CATEGORY
    SET endtime = SYSDATE
    WHERE appliance_idapp = :OLD.idappliance AND endtime IS NULL;

    UPDATE APPLIANCE_COST
    SET endtime = SYSDATE
    WHERE appliance_idapp = :OLD.idappliance AND endtime IS NULL;

    DELETE FROM APPLIANCE
    WHERE idappliance = :OLD.idappliance;
END;
/

INSERT INTO TECHNICIAN_VIEW (idtechnician, name, phone) VALUES (1, 'John Doe', '123-456-7890');
INSERT INTO TECHNICIAN_VIEW (idtechnician, name, phone) VALUES (2, 'Jane Smith', '987-654-3210');
INSERT INTO TECHNICIAN_VIEW (idtechnician, name, phone) VALUES (10, 'Zimeng', '123-123-1233');


INSERT INTO APPLIANCE_VIEW (idappliance, category, cost) VALUES (1, 'Refrigerator', 1200.00);
INSERT INTO APPLIANCE_VIEW (idappliance, category, cost) VALUES (2, 'Washing Machine', 800.00);



ALTER TABLE TECHNICIAN_NAME DROP CONSTRAINT fk_tech_name_t;
ALTER TABLE TECHNICIAN_NAME
ADD CONSTRAINT fk_tech_name_t FOREIGN KEY (technician_idtech) REFERENCES TECHNICIAN (idtechnician) ON DELETE CASCADE;

ALTER TABLE TECHNICIAN_PHONE DROP CONSTRAINT fk_tech_phone_t;
ALTER TABLE TECHNICIAN_PHONE
ADD CONSTRAINT fk_tech_phone_t FOREIGN KEY (technician_idtech) REFERENCES TECHNICIAN (idtechnician) ON DELETE CASCADE;



ALTER TABLE TECHNICIAN_NAME DROP CONSTRAINT fk_tech_name_t;
ALTER TABLE TECHNICIAN_NAME ADD CONSTRAINT fk_tech_name_t
    FOREIGN KEY (technician_idtech) REFERENCES TECHNICIAN (idtechnician) ON DELETE CASCADE;

ALTER TABLE TECHNICIAN_NAME DROP CONSTRAINT fk_tech_name_n;
ALTER TABLE TECHNICIAN_NAME ADD CONSTRAINT fk_tech_name_n
    FOREIGN KEY (name_idname) REFERENCES NAME (idname) ON DELETE CASCADE;

ALTER TABLE TECHNICIAN_PHONE DROP CONSTRAINT fk_tech_phone_t;
ALTER TABLE TECHNICIAN_PHONE ADD CONSTRAINT fk_tech_phone_t
    FOREIGN KEY (technician_idtech) REFERENCES TECHNICIAN (idtechnician) ON DELETE CASCADE;

ALTER TABLE TECHNICIAN_PHONE DROP CONSTRAINT fk_tech_phone_p;
ALTER TABLE TECHNICIAN_PHONE ADD CONSTRAINT fk_tech_phone_p
    FOREIGN KEY (phone_idphone) REFERENCES PHONE (idphone) ON DELETE CASCADE;
    
    
    
ALTER TABLE APPLIANCE_CATEGORY DROP CONSTRAINT fk_app_cat_a;
ALTER TABLE APPLIANCE_CATEGORY ADD CONSTRAINT fk_app_cat_a FOREIGN KEY (appliance_idapp) REFERENCES APPLIANCE (idappliance) ON DELETE CASCADE;

ALTER TABLE APPLIANCE_COST DROP CONSTRAINT fk_app_cost_a;
ALTER TABLE APPLIANCE_COST ADD CONSTRAINT fk_app_cost_a FOREIGN KEY (appliance_idapp) REFERENCES APPLIANCE (idappliance) ON DELETE CASCADE;

    
    
    
