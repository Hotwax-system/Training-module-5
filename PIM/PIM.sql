-- the table is responsible for storing the data about the product type (finish_good , digital_good etc) 
CREATE TABLE product_type (
    product_type_id VARCHAR(40) PRIMARY KEY,       
    description VARCHAR(100),                  
    is_physical BOOLEAN DEFAULT FALSE,          
    is_virtual BOOLEAN DEFAULT FALSE       
);

-- The table is resposible to store the information about products
CREATE TABLE product (
    product_id VARCHAR(40) PRIMARY KEY,
    product_internal_name VARCHAR(100) NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    from_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    thru_date DATE,
    release_date DATE,
    brand_name VARCHAR(100),
    introduction_date DATE,
    product_type_id VARCHAR(40),
        FOREIGN KEY (product_type_id) REFERENCES product_type(product_type_id)
);

-- The product can be know as different name and id so this multiple ids for the same product is stored in this table
CREATE TABLE good_identification (
    good_identification_id VARCHAR(40) PRIMARY KEY,
    product_id VARCHAR(40) NOT NULL,
    sku VARCHAR(100),
    upc VARCHAR(100),
    gtin VARCHAR(100),
    from_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    thru_date DATETIME ,
        FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- this table is used to store the information about the type of product feature like seleted_feature , standard_feature etc
CREATE TABLE product_feature_type (
    product_feature_type_id VARCHAR(40) PRIMARY KEY, 
    description VARCHAR(100)  
);

-- this table is used to store the information about the product feature
CREATE TABLE product_feature (
    product_feature_id VARCHAR(40) PRIMARY KEY,    
    product_feature_type_id VARCHAR(40) NOT NULL,     
    description VARCHAR(100),         
        FOREIGN KEY (product_feature_type_id)
        REFERENCES product_feature_type(product_feature_type_id)
);

-- This table is usefull to stor the information about applicability of the feature on products
CREATE TABLE product_feature_appl (
    product_id VARCHAR(40) NOT NULL,  
    product_feature_id VARCHAR(40) NOT NULL,   
    from_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    thru_date DATE,
    PRIMARY KEY (product_id, product_feature_id, from_date),  
        FOREIGN KEY (product_id) REFERENCES product(product_id),
        FOREIGN KEY (product_feature_id) REFERENCES product_feature(product_feature_id)
);

-- This table is used to store the information about the type of prices for a product
CREATE TABLE price_type (
    price_type_id VARCHAR(40) PRIMARY KEY,   
    description   VARCHAR(100)                
);


-- This table is used to store the information about the product price
CREATE TABLE product_price (
    product_price_id VARCHAR(40) PRIMARY KEY,
    product_id VARCHAR(40) NOT NULL,
    price_type_id VARCHAR(30) NOT NULL,
    price_amount DECIMAL(10, 2) NOT NULL,
    currency_uom_id VARCHAR(10) DEFAULT 'INR',
    from_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    thru_date DATE,
        FOREIGN KEY (product_id) REFERENCES product(product_id),
        FOREIGN KEY (price_type_id) REFERENCES price_type(price_type_id)
);

-- This table is used to store the information about the category type for each category
CREATE TABLE product_category_type (
    product_category_type_id VARCHAR(40) PRIMARY KEY,  
    description VARCHAR(100)
);

-- This table is used to store the information about the product and the category
CREATE TABLE product_category (
    product_category_id VARCHAR(40) PRIMARY KEY,  
    product_category_type_id VARCHAR(40) NOT NULL,     
    category_name VARCHAR(100) NOT NULL,    
    description VARCHAR(255),           
        FOREIGN KEY (product_category_type_id)
        REFERENCES product_category_type(product_category_type_id)
);

-- This table is used to store the information about the product and the member category
CREATE TABLE product_category_member (
    product_id VARCHAR(40) NOT NULL,  
    product_category_id VARCHAR(40) NOT NULL,     
    from_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    thru_date DATE,
    PRIMARY KEY (product_id, product_category_id, from_date),
        FOREIGN KEY (product_id) REFERENCES product(product_id),
        FOREIGN KEY (product_category_id) REFERENCES product_category(product_category_id)
);


-- This table is used to store the information about product association type like verient, package etc
CREATE TABLE product_assoc_type (
    product_assoc_type_id VARCHAR(40) PRIMARY KEY,  
    description VARCHAR(100)      
);


-- This table is used to store the information about product association
CREATE TABLE product_assoc (
    product_id VARCHAR(40) NOT NULL,    
    product_id_to VARCHAR(40) NOT NULL,     
    product_assoc_type_id VARCHAR(40) NOT NULL,  
    from_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    thru_date DATE,
    PRIMARY KEY (product_id, product_id_to, product_assoc_type_id, from_date),
        FOREIGN KEY (product_id) REFERENCES product(product_id),
        FOREIGN KEY (product_id_to) REFERENCES product(product_id),
        FOREIGN KEY (product_assoc_type_id) REFERENCES product_assoc_type(product_assoc_type_id)
);









