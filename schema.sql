-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/jTaXQ5
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE card_holder (
    id INT PRIMARY KEY NOT NULL,
    name VARCHAR(100)   NOT NULL
);

CREATE TABLE credit_card (
    card VARCHAR(30) PRIMARY KEY NOT NULL,
    cardholder_id INT   NOT NULL,
	FOREIGN KEY (cardholder_id) REFERENCES card_holder(id)
);

CREATE TABLE merchant_category (
    id INT PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE merchant (
    id INT PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    id_merchant_category INT NOT NULL,
	FOREIGN KEY (id_merchant_category) REFERENCES merchant_category(id)
);

CREATE TABLE transactions (
    id INT PRIMARY KEY NOT NULL,
    date TIMESTAMP NOT NULL,
    amount DECIMAL NOT NULL,
    card VARCHAR NOT NULL,
    id_merchant INT NOT NULL,
	FOREIGN KEY (id_merchant) REFERENCES merchant(id)
);

SELECT * FROM card_holder