select *
from lots;

select lot_no, product_type, shift
from lots
where product_type = 'Logic';

select lot_no, start_date
from lots
order by start_date, lot_no;