CREATE TABLE accounts(
    ID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Credit INT NOT NULL,
    Currency VARCHAR(3) NOT NULL
);

INSERT INTO accounts(Name, Credit, Currency) VALUES ('Albert', 1000, 'RUB');
INSERT INTO accounts(Name, Credit, Currency) VALUES ('Maxim', 1000, 'RUB');
INSERT INTO accounts(Name, Credit, Currency) VALUES ('Munir', 1000, 'RUB');

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
UPDATE accounts SET Credit = Credit - 500 WHERE ID = 1;
UPDATE accounts SET Credit = Credit + 500 WHERE ID = 3;
SELECT * FROM accounts;
ROLLBACK;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
UPDATE accounts SET Credit = Credit - 700 WHERE ID = 2;
UPDATE accounts SET Credit = Credit + 700 WHERE ID = 1;
SELECT * FROM accounts;
ROLLBACK;

    BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
    UPDATE accounts SET Credit = Credit - 100 WHERE ID = 2;
    UPDATE accounts SET Credit = Credit + 100 WHERE ID = 3;
    SELECT * FROM accounts;
    ROLLBACK;