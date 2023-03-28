ALTER TABLE accounts ADD BankName VARCHAR(50);

UPDATE accounts SET BankName = 'SberBank' WHERE ID IN (1, 3);
UPDATE accounts SET BankName = 'Tinkoff' WHERE ID = 2;

CREATE OR REPLACE FUNCTION transfer_money(from_account INT, to_account INT, amount INT)
    RETURNS TABLE (
        ID INTEGER, 
        Name VARCHAR(255),
        Credit INTEGER,
        Currency VARCHAR(3)
    )
AS
$$
BEGIN
    IF (SELECT BankName FROM accounts WHERE accounts.id=from_account) <> (SELECT BankName FROM accounts WHERE accounts.id=to_account) THEN
        UPDATE accounts SET Credit = accounts.Credit - amount - 30 WHERE accounts.id = from_account;
    ELSE
        UPDATE accounts SET Credit = accounts.Credit - amount WHERE accounts.id = from_account;
    END IF;
    UPDATE accounts SET Credit = accounts.Credit + amount WHERE accounts.id = to_account;
    RETURN QUERY SELECT accounts.id, accounts.name, accounts.credit, accounts.currency FROM accounts;
END
$$
LANGUAGE plpgsql;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT * FROM transfer_money(1, 3, 500);
SELECT * FROM accounts;
ROLLBACK;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT * FROM transfer_money(2, 1, 700);
SELECT * FROM accounts;
ROLLBACK;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT * FROM transfer_money(2, 3, 100);
SELECT * FROM accounts;
ROLLBACK;