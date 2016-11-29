#this is the First file


create index ssnx on invn_view_work.SCRA_20150930 (Field1);

update invn_view_work.SCRA_20150930
set Field1 = concat(0,Field1)
where CHAR_LENGTH(Field1) = 8;

update invn_view_work.SCRA_20150930
set Field1 = concat(00,Field1)
where CHAR_LENGTH(Field1) = 7;

update invn_view_work.SCRA_20150930
set Field1 = concat(000,Field1)
where CHAR_LENGTH(Field1) = 6;

update invn_view_work.SCRA_20150930
set Field1 = concat(0000,Field1)
where CHAR_LENGTH(Field1) = 5;


#only pulled active inventory, but some have old close accounts
select  i.data_id, 
        i.placedetail_status,
        i.place_id,
        d.pri_ssn,
        i.data_status, 
        ia.lastpayment, 
        ia.chargeoff,
        j.judgment_date,
        s.*
from invn_view_work.SCRA_20150930 s
left join vwInventory_debtor d on d.pri_ssn = s.Field1
left join vwInventory i on i.data_id = d.data_id 
left join vwInventory_account ia on ia.data_id = d.data_id
left join vwInventory_judgment j on j.data_id = d.data_id
-- where s.Field8 <>'Z'
where s.Field8 = 'x'
order by s.Field1, i.data_id
;


-- 
-- #who has more than 1 account?
-- select s.pri_ssn
-- from invn_view_work.SCRA_20150930 s
-- inner join vwInventory_debtor d on d.pri_ssn = s.pri_ssn
-- inner join vwInventory i on i.data_id = d.data_id and i.data_status < 900000
-- group by s.pri_ssn
-- having count(i.data_id) > 1;
-- 
-- 
-- select * 
-- from invn_view_work.SCRA_20150429

-- small change here


select * from invn_view_work.SCRA_20150930