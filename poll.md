#release 1
1. Hitung jumlah vote untuk Sen.
Olympia Snowe yang memiliki id 524.

select count(id)
from votes
where politician_id = 524;

2. Sekarang lakukan JOIN tanpa menggunakan id 524. Query kedua tabel votes dan congress_members.

select *
from votes
join congress_members
on votes.politician_id = congress_members.id;

3. Sekarang gimana dengan representative Erik Paulsen? Berapa banyak vote yang dia dapatkan?

select count(votes.id)
from votes
join congress_members
on votes.politician_id = congress_members.id
where congress_members.name like "%Erik Paulsen%";

4. Buatlah daftar peserta Congress yang mendapatkan vote terbanyak. Jangan sertakan field created_at dan updated_at.

select congress_members.name, congress_members.id, count(votes.politician_id)
from votes
join congress_members
on votes.politician_id = congress_members.id
group by votes.politician_id
order by count(votes.politician_id) desc
limit 1;

5. Sekarang buatlah sebuah daftar semua anggota Congress yang setidaknya mendapatkan beberapa vote dalam urutan dari yang paling sedikit. Dan juga jangan sertakan field-field yang memiliki tipe date.

select congress_members.name, congress_members.id, count(votes.politician_id), votes.created_at, votes.updated_at
from votes
join congress_members
on votes.politician_id = congress_members.id
group by votes.politician_id
order by count(votes.politician_id) asc;
