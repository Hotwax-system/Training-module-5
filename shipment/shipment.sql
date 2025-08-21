create database order_shipment;
use order_shipment;
show tables;

-- This table is usefull to store the information about order shipment 
CREATE TABLE shipment (
    shipment_id VARCHAR(40) PRIMARY KEY,
    shipment_type_id VARCHAR(40),
    status_id VARCHAR(40),
    primary_order_id VARCHAR(40),
    primary_return_id VARCHAR(40),
    primary_ship_group_seq_id VARCHAR(20),
    picklist_bin_id VARCHAR(40),
    estimated_ready_date DATE,
    estimated_ship_date DATE,
    estimated_ship_work_eff_id VARCHAR(40),
    estimated_arrival_date DATE,
    estimated_arrival_work_eff_id VARCHAR(40),
    latest_cancel_date DATE,
    estimated_ship_cost DECIMAL(12, 2),
    currency_uom_id VARCHAR(10),
    handling_instructions TEXT,
    origin_facility_id VARCHAR(40),
    destination_facility_id VARCHAR(40),
    origin_contact_mech_id VARCHAR(40),
    origin_telecom_number_id VARCHAR(40),
    destination_contact_mech_id VARCHAR(40),
    destination_telecom_number_id VARCHAR(40),
    party_id_to VARCHAR(40),
    party_id_from VARCHAR(40),
    additional_shipping_charge DECIMAL(12, 2),
    addtl_shipping_charge_desc TEXT,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by_user_login VARCHAR(40),
    last_modified_date DATETIME,
    last_modified_by_user_login VARCHAR(40),
    last_updated_stamp DATETIME,
    last_updated_tx_stamp DATETIME,
    created_stamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_tx_stamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    external_id VARCHAR(40),
    carrier_party_id VARCHAR(40),
    shipment_method_type_id VARCHAR(40)
);


-- This table is used to store the information about the item for each shipment.
CREATE TABLE shipment_item (
    shipment_id VARCHAR(40) NOT NULL,
    shipment_item_seq_id VARCHAR(20) NOT NULL,
    product_id VARCHAR(40),
    quantity DECIMAL(18, 2),
    shipment_content_description TEXT,
    last_updated_stamp TIMESTAMP,
    last_updated_tx_stamp TIMESTAMP,
    created_stamp TIMESTAMP,
    created_tx_stamp TIMESTAMP,
    serial_number VARCHAR(100),
    available_to_promise VARCHAR(20),
    external_id VARCHAR(100),
    PRIMARY KEY (shipment_id, shipment_item_seq_id)
);

-- This table is used to store the information about shipment type like incoming_shipment , sales_shipment etc.
CREATE TABLE shipment_type (
    shipment_type_id VARCHAR(40) PRIMARY KEY,
    has_table CHAR(1),
    description TEXT,
    last_updated_stamp TIMESTAMP,
    last_updated_tx_stamp TIMESTAMP,
    created_stamp TIMESTAMP,
    created_tx_stamp TIMESTAMP
);

-- This table is used to store the information about shipment status like shipment_delivered shipment_shipped etc.
CREATE TABLE shipment_status (
    status_id VARCHAR(40) PRIMARY KEY,
    shipment_id VARCHAR(40),
    status_date TIMESTAMP,
    change_by_user_login_id VARCHAR(40),
    last_updated_stamp TIMESTAMP,
    last_updated_tx_stamp TIMESTAMP,
    created_stamp TIMESTAMP,
    created_tx_stamp TIMESTAMP
);

-- This table is used to store the information about shipment contact mech type like ship_from address , ship_from_email etc.
CREATE TABLE shipment_contact_mech_type (
    shipment_contact_mech_type_id VARCHAR(40) PRIMARY KEY,
    description TEXT,
    last_updated_stamp TIMESTAMP,
    last_updated_tx_stamp TIMESTAMP,
    created_stamp TIMESTAMP,
    created_tx_stamp TIMESTAMP
);


-- This table is used to store the  information about the shipment contact mech.
CREATE TABLE shipment_contact_mech (
    shipment_id VARCHAR(40),
    shipment_contact_mech_type_id VARCHAR(40),
    contact_mech_id VARCHAR(40),
    last_updated_stamp TIMESTAMP,
    last_updated_tx_stamp TIMESTAMP,
    created_stamp TIMESTAMP,
    created_tx_stamp TIMESTAMP,
    PRIMARY KEY (shipment_id, shipment_contact_mech_type_id, contact_mech_id),
    FOREIGN KEY (shipment_id) REFERENCES shipment(shipment_id),
    FOREIGN KEY (shipment_contact_mech_type_id) REFERENCES shipment_contact_mech_type(shipment_contact_mech_type_id)
);


-- This table is used to issue the items which can we usefull to calculate the issued items.
CREATE TABLE item_issuance (
    item_issuance_id VARCHAR(40) PRIMARY KEY,
    order_id VARCHAR(40),
    order_item_seq_id VARCHAR(40),
    ship_group_seq_id VARCHAR(40),
    inventory_item_id VARCHAR(40),
    shipment_id VARCHAR(40),
    shipment_item_seq_id VARCHAR(40),
    fixed_asset_id VARCHAR(40),
    maint_hist_seq_id VARCHAR(40),
    issued_date_time TIMESTAMP,
    issued_by_user_login_id VARCHAR(40),
    quantity DECIMAL(18, 2),
    cancel_quantity DECIMAL(18, 2),
    last_updated_stamp TIMESTAMP,
    last_updated_tx_stamp TIMESTAMP,
    created_stamp TIMESTAMP,
    created_tx_stamp TIMESTAMP,
    return_id VARCHAR(40),
    return_item_seq_id VARCHAR(40),
    issuance_type_id VARCHAR(40),
    work_effort_id VARCHAR(40),
    current_status_id VARCHAR(40),
    cancelled_date_time TIMESTAMP,
    cancelled_by_user_login_id VARCHAR(40),
    transfer_quantity DECIMAL(18, 2),
    returned_excess_issued_qty DECIMAL(18, 2),
    wegs_reference_number VARCHAR(40),
    location_seq_id VARCHAR(40),
    delivered_to_party VARCHAR(40),
    FOREIGN KEY (shipment_id) REFERENCES shipment(shipment_id)
);






