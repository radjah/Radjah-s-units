select id_place,id_sig, count(id_sig) as sigcount
from connector conn inner join contact cnt on conn.id = cnt.id_conn
group by id_place,id_sig
order by id_place,id_sig