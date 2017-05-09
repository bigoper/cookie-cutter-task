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

INSERT INTO globality.members (id, f_name, l_name, email, mobile) VALUES (1, 'Daniel',     'Li',         'daniel@gmail.com',        '424-653-4711');
INSERT INTO globality.members (id, f_name, l_name, email, mobile) VALUES (2, 'Loren',    'Who',    'loren@gmail.com',       '424-653-4712');
INSERT INTO globality.members (id, f_name, l_name, email, mobile) VALUES (3, 'Miriam',     'Bell',         'miriam.b@gmail.com',   '424-653-4713');
