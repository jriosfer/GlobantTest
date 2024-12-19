-- DDL 
CREATE TABLE department (
    id            INTEGER NOT NULL,
    department    VARCHAR2(512) NOT NULL,
    creation_date TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    created_by    VARCHAR2(128) NOT NULL,
    updated_date  TIMESTAMP WITH LOCAL TIME ZONE,
    updated_by    VARCHAR2(128)
);

COMMENT ON COLUMN department.id IS
    'Department Code';

COMMENT ON COLUMN department.department IS
    'Department Name or Business area name';

COMMENT ON COLUMN department.creation_date IS
    'Record''s creation date';

COMMENT ON COLUMN department.created_by IS
    'Record created  by';

COMMENT ON COLUMN department.updated_date IS
    'Record''s update  date';

COMMENT ON COLUMN department.updated_by IS
    'Record updated by';

ALTER TABLE department ADD CONSTRAINT department_pk PRIMARY KEY ( id );

CREATE TABLE employee (
    id            INTEGER NOT NULL,
	name          varchar2(65) NOT NULL,
    creation_date TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    created_by    VARCHAR2(128) NOT NULL,
    updated_date  TIMESTAMP WITH LOCAL TIME ZONE,
    updated_by    VARCHAR2(128),
    department_id INTEGER NOT NULL,
    job_id        INTEGER NOT NULL,
    datetime      TIMESTAMP WITH LOCAL TIME ZONE
);

COMMENT ON COLUMN employee.id IS
    'employee''s ID';

COMMENT ON COLUMN employee.creation_date IS
    'Record''s creation date';

COMMENT ON COLUMN employee.created_by IS
    'Record created  by';

COMMENT ON COLUMN employee.updated_date IS
    'Record''s update  date';

COMMENT ON COLUMN employee.updated_by IS
    'Record updated by';

ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY ( id );

CREATE TABLE job (
    id            INTEGER NOT NULL,
    job           VARCHAR2(512) NOT NULL,
    creation_date TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    created_by    VARCHAR2(128) NOT NULL,
    updated_date  TIMESTAMP WITH LOCAL TIME ZONE,
    updated_by    VARCHAR2(128)
);

COMMENT ON COLUMN job.id IS
    'Job ID';

COMMENT ON COLUMN job.job IS
    'Name of the job';

COMMENT ON COLUMN job.creation_date IS
    'Record''s creation date';

COMMENT ON COLUMN job.created_by IS
    'Record created  by';

COMMENT ON COLUMN job.updated_date IS
    'Record''s update  date';

COMMENT ON COLUMN job.updated_by IS
    'Record updated by';

ALTER TABLE job ADD CONSTRAINT job_pk PRIMARY KEY ( id );

ALTER TABLE employee
    ADD CONSTRAINT employee_department_fk FOREIGN KEY ( department_id )
        REFERENCES department ( id );

ALTER TABLE employee
    ADD CONSTRAINT employee_job_fk FOREIGN KEY ( job_id )
        REFERENCES job ( id );


CREATE OR REPLACE EDITIONABLE TRIGGER BIU_DEPARTMENT
    BEFORE INSERT OR UPDATE ON DEPARTMENT
FOR EACH ROW
BEGIN
   if :new.CREATION_DATE is null then 
     :new.CREATION_DATE:= systimestamp; 
     :new.created_by := v('APP_USER');
   end if; 
   :new.UPDATED_DATE := systimestamp; 
   :new.updated_by := v('APP_USER');
END;
/
CREATE OR REPLACE EDITIONABLE TRIGGER BIU_JOB 
    BEFORE INSERT OR UPDATE ON JOB
FOR EACH ROW
BEGIN
   if :new.CREATION_DATE is null then 
     :new.CREATION_DATE:= systimestamp; 
     :new.created_by := v('APP_USER');
   end if; 
   :new.UPDATED_DATE := systimestamp; 
   :new.updated_by := v('APP_USER');
END;
/
CREATE OR REPLACE EDITIONABLE TRIGGER BIU_EMPLOYEE
    BEFORE INSERT OR UPDATE ON EMPLOYEE
FOR EACH ROW
BEGIN
   if :new.CREATION_DATE is null then 
     :new.CREATION_DATE:= systimestamp; 
     :new.created_by := v('APP_USER');
   end if; 
   :new.UPDATED_DATE := systimestamp; 
   :new.updated_by := v('APP_USER');
END;
/