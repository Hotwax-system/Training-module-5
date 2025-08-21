CREATE DATABASE CDP;
use CDP;

-- This table is used to store the Type of party type (Person,group etc)
CREATE TABLE party_type (
    party_type_id VARCHAR(40) NOT NULL,
    parent_type_id VARCHAR(40),
    description VARCHAR(255),
    PRIMARY KEY (party_type_id),
    FOREIGN KEY (parent_type_id) REFERENCES party_type(party_type_id)
);

-- This table is resposible to store information about party Or the table is used to store the party details.
CREATE TABLE party (
    party_id VARCHAR(40) NOT NULL,
    party_type_id VARCHAR(40),
    external_id VARCHAR(40),
    description LONGTEXT,
    status_id VARCHAR(40),
    created_date DATETIME(3),
    created_by_user_login VARCHAR(250),
    PRIMARY KEY (party_id),
    FOREIGN KEY (party_type_id) REFERENCES party_type(party_type_id)
);

-- This table is used to store the information about the party with type person
CREATE TABLE person (
    party_id VARCHAR(40) NOT NULL,
    salutation VARCHAR(100),
    first_name VARCHAR(100),
    middle_name VARCHAR(100),
    last_name VARCHAR(100),
    personal_title VARCHAR(100),
    suffix VARCHAR(100),
    nickname VARCHAR(100),
    first_name_local VARCHAR(100),
    middle_name_local VARCHAR(100),
    last_name_local VARCHAR(100),
    member_id VARCHAR(40),
    gender CHAR(1),
    birth_date DATE,
    height DOUBLE,
    weight DOUBLE,
    marital_status_enum_id VARCHAR(40),
    comments VARCHAR(255),
    occupation VARCHAR(100),
    PRIMARY KEY (party_id),
    FOREIGN KEY (party_id) REFERENCES party(party_id)
);

-- This table is used to store the information about the party and there associate group
CREATE TABLE party_group (
    party_id VARCHAR(40) NOT NULL,
    group_name VARCHAR(100),
    group_name_local VARCHAR(100),
    office_site_name VARCHAR(100),
    annual_revenue DECIMAL(18,2),
    num_employees DECIMAL(20,0),
    ticker_symbol VARCHAR(10),
    comments VARCHAR(255),
    logo_image_url VARCHAR(2000),
    PRIMARY KEY (party_id),
    FOREIGN KEY (party_id) REFERENCES party(party_id)
);

-- This table is resposible to store the information about the role type for party like (customer , packer , picker etc).
CREATE TABLE role_type (
    role_type_id VARCHAR(40) NOT NULL,
    parent_type_id VARCHAR(40),
    description VARCHAR(255),
    PRIMARY KEY (role_type_id),
    FOREIGN KEY (parent_type_id) REFERENCES role_type(role_type_id)
);

-- This table is responsible to store the information about the association of party with role 
CREATE TABLE party_role (
    party_id VARCHAR(40) NOT NULL,
    role_type_id VARCHAR(40) NOT NULL,
    PRIMARY KEY (party_id, role_type_id),
    FOREIGN KEY (party_id) REFERENCES party(party_id),
    FOREIGN KEY (role_type_id) REFERENCES role_type(role_type_id)
);

-- This table is responsible to store the information about status for the party and the change's .
CREATE TABLE party_status (
    status_id VARCHAR(40) NOT NULL,
    party_id VARCHAR(40) NOT NULL,
    status_date DATETIME(3) NOT NULL,
    change_by_user_login_id VARCHAR(250),
    PRIMARY KEY (status_id, party_id, status_date),
    FOREIGN KEY (party_id) REFERENCES party(party_id)
);

-- This table is used to store the information about contact mech type for party like (postal_address , email , telecom_number etc)
CREATE TABLE contact_mech_type (
    contact_mech_type_id VARCHAR(40) NOT NULL,
    parent_type_id VARCHAR(40),
    description VARCHAR(255),
    PRIMARY KEY (contact_mech_type_id),
    FOREIGN KEY (parent_type_id) REFERENCES contact_mech_type(contact_mech_type_id)
);

-- This table is resposible to store the information about contact mechanism like (postal_address ,email, telecom_number etc)
CREATE TABLE contact_mech (
    contact_mech_id VARCHAR(40) NOT NULL,
    contact_mech_type_id VARCHAR(40),
    info_string VARCHAR(255),
    PRIMARY KEY (contact_mech_id),
    FOREIGN KEY (contact_mech_type_id) REFERENCES contact_mech_type(contact_mech_type_id)
);

-- Create telecom_number Table that store the telecom Number of any user or party
CREATE TABLE telecom_number (
    contact_mech_id VARCHAR(40) NOT NULL,
    country_code VARCHAR(10),
    area_code VARCHAR(10),
    contact_number VARCHAR(60),
    ask_for_name VARCHAR(100),
    PRIMARY KEY (contact_mech_id),
    FOREIGN KEY (contact_mech_id) REFERENCES contact_mech(contact_mech_id)
);

-- Create postal_address Table that store the postal addresses of any users that contain to_name, attn_name, address1, house_number etc.
CREATE TABLE postal_address (
    contact_mech_id VARCHAR(40) NOT NULL,
    to_name VARCHAR(100),
    attn_name VARCHAR(100),
    address1 VARCHAR(255),
    address2 VARCHAR(255),
    house_number DECIMAL(20,0),
    house_number_ext VARCHAR(60),
    directions VARCHAR(255),
    city VARCHAR(100),
    city_geo_id VARCHAR(40),
    postal_code VARCHAR(60),
    postal_code_ext VARCHAR(60),
    country_geo_id VARCHAR(40),
    state_province_geo_id VARCHAR(40),
    county_geo_id VARCHAR(40),
    municipality_geo_id VARCHAR(40),
    postal_code_geo_id VARCHAR(40),
    geo_point_id VARCHAR(40),
    PRIMARY KEY (contact_mech_id),
    FOREIGN KEY (contact_mech_id) REFERENCES contact_mech(contact_mech_id)
);

-- This table is used to store association for party and contact mechanism .
CREATE TABLE party_contact_mech (
    party_id VARCHAR(40) NOT NULL,
    contact_mech_id VARCHAR(40) NOT NULL,
    from_date DATETIME(3) NOT NULL,
    thru_date DATETIME(3),
    role_type_id VARCHAR(40),
    comments VARCHAR(255),
    PRIMARY KEY (party_id, contact_mech_id, from_date),
    FOREIGN KEY (party_id) REFERENCES party(party_id),
    FOREIGN KEY (contact_mech_id) REFERENCES contact_mech(contact_mech_id)
);

-- This table is used to store the information about contact mech purpose type (billing_address, shiping_address).
CREATE TABLE contact_mech_purpose_type (
    contact_mech_purpose_type_id VARCHAR(40) NOT NULL,
    parent_type_id VARCHAR(40),
    description VARCHAR(255),
    PRIMARY KEY (contact_mech_purpose_type_id),
    FOREIGN KEY (parent_type_id) REFERENCES contact_mech_purpose_type(contact_mech_purpose_type_id)
);

-- This table is used to store the information about the association of party , contact_mech , and the purpose.
CREATE TABLE party_contact_mech_purpose (
    party_id VARCHAR(40) NOT NULL,
    contact_mech_id VARCHAR(40) NOT NULL,
    contact_mech_purpose_type_id VARCHAR(40) NOT NULL,
    from_date DATETIME(3) NOT NULL,
    thru_date DATETIME(3),
    PRIMARY KEY (
        party_id,
        contact_mech_id,
        contact_mech_purpose_type_id,
        from_date
    ),
    FOREIGN KEY (party_id) REFERENCES party(party_id),
    FOREIGN KEY (contact_mech_id) REFERENCES contact_mech(contact_mech_id),
    FOREIGN KEY (contact_mech_purpose_type_id) REFERENCES contact_mech_purpose_type(contact_mech_purpose_type_id)
);