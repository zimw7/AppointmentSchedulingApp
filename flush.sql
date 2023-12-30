-- Cleanup for assignment2

DROP USER groupUser CASCADE;
DROP USER testUser;
DROP ROLE applicationAdmin;
DROP ROLE applicationUser;
DROP TABLESPACE assignment2 INCLUDING CONTENTS AND DATAFILES;

drop VIEW APPLIANCE_VIEW;
drop VIEW TECHNICIAN_VIEW;

drop TRIGGER InsertTechnicianView;
drop TRIGGER UpdateTechnicianView;
drop TRIGGER DeleteTechnicianView;



drop TRIGGER InsertApplianceView;
drop TRIGGER UpdateApplianceView;
drop TRIGGER DeleteApplianceView;

drop SEQUENCE name_sequence;
drop SEQUENCE phone_sequence;
drop SEQUENCE category_sequence;
drop SEQUENCE cost_sequence

-- End of File