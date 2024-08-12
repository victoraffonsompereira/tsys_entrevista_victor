
create user ERDTEST_VICTOR identified by ERDTEST_VICTOR;

create table ERDTEST_VICTOR.Account (
       account_number   number,
       balance          number(15,2)
);
ALTER TABLE ERDTEST_VICTOR.Account ADD CONSTRAINT account_pk PRIMARY KEY (account_number); -- index

create table ERDTEST_VICTOR.card (
       card_number    number,
       account_number number,
       expiry_date    date,
       security_code  number
);
ALTER TABLE ERDTEST_VICTOR.card ADD CONSTRAINT card_pk PRIMARY KEY (card_number); -- index
ALTER TABLE ERDTEST_VICTOR.card ADD CONSTRAINT card_acc_fk FOREIGN KEY (account_number) REFERENCES ERDTEST_VICTOR.account(account_number);

CREATE TABLE ERDTEST_VICTOR.Account_Statement (
    acc_stmt_number          VARCHAR2(50),
    account_number           number,
    bill_cycle_code          VARCHAR2(10),
    month_cycle              VARCHAR2(10),
    year_cycle               VARCHAR2(10),
    total_due_amount         NUMBER(15, 2),
    billing_date             DATE
);
ALTER TABLE ERDTEST_VICTOR.Account_Statement ADD CONSTRAINT accstms_pk PRIMARY KEY (acc_stmt_number); -- index
ALTER TABLE ERDTEST_VICTOR.Account_Statement ADD CONSTRAINT accstms_fk FOREIGN KEY (account_number) REFERENCES ERDTEST_VICTOR.account(account_number);

create table ERDTEST_VICTOR.transaction (
       transaction_id      number,
       card_number         number null,
       account             number null,
       transaction_nature  varchar2(10),
       transaction_type    varchar2(10),
       transaction_date    date,
       transaction_amount  number,
       transaction_desc    varchar2(255)
);
ALTER TABLE ERDTEST_VICTOR.transaction ADD CONSTRAINT transaction_pk PRIMARY KEY (transaction_id); -- index
ALTER TABLE ERDTEST_VICTOR.transaction ADD CONSTRAINT transaction_fk_card FOREIGN KEY (card_number) REFERENCES ERDTEST_VICTOR.card(card_number);
ALTER TABLE ERDTEST_VICTOR.transaction ADD CONSTRAINT transaction_fk_acc FOREIGN KEY (account) REFERENCES ERDTEST_VICTOR.account(account_number);

CREATE TABLE ERDTEST_VICTOR.Transaction_Account_Statement (
    transaction_id           number,
    acc_stmt_number          VARCHAR2(50)
);
ALTER TABLE ERDTEST_VICTOR.Transaction_Account_Statement ADD CONSTRAINT trans_acc_stmt_pk   PRIMARY KEY (transaction_id,acc_stmt_number); -- index
ALTER TABLE ERDTEST_VICTOR.Transaction_Account_Statement ADD CONSTRAINT trans_acc_stmt_fk_1 FOREIGN KEY (transaction_id) REFERENCES ERDTEST_VICTOR.Transaction(transaction_id);
ALTER TABLE ERDTEST_VICTOR.Transaction_Account_Statement ADD CONSTRAINT trans_acc_stmt_fk_2 FOREIGN KEY (acc_stmt_number) REFERENCES ERDTEST_VICTOR.Account_Statement(acc_stmt_number);


-- indexes
create index ERDTEST_VICTOR.transaction_idx1 on ERDTEST_VICTOR.transaction (card_number,account);
create index ERDTEST_VICTOR.transaction_idx2 on ERDTEST_VICTOR.transaction (transaction_nature);
create index ERDTEST_VICTOR.transaction_idx3 on ERDTEST_VICTOR.transaction (transaction_type);

create index ERDTEST_VICTOR.Account_Statement_idx1 on ERDTEST_VICTOR.Account_Statement (acc_stmt_number,account_number);

create index ERDTEST_VICTOR.card_idx1 on ERDTEST_VICTOR.card (card_number,account_number);
