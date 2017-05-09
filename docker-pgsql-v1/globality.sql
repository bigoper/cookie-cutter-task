-- noinspection SqlDialectInspectionForFile
CREATE SCHEMA globality;

SET SCHEMA 'globality';

CREATE TABLE members
(
    id SERIAL,
    f_name CHAR(24),
    l_name CHAR(24),
    email VARCHAR(55),
    mobile VARCHAR(15)
);
COMMENT ON TABLE globality.members IS 'demo data for test';

INSERT INTO globality.members (id, f_name, l_name, email, mobile) VALUES (1, 'avi',     'ivgi',         'ivgiavi@gmail.com',        '424-653-4911');
INSERT INTO globality.members (id, f_name, l_name, email, mobile) VALUES (2, 'amit',    'ben natan',    'amit@globality.com',       '424-653-4922');
INSERT INTO globality.members (id, f_name, l_name, email, mobile) VALUES (3, 'run',     'test',         'run.test@globality.com',   '424-653-4933');