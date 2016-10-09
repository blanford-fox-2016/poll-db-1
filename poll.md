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

#Release 2

1. Siapa anggota Congress yang mendapatkan vote terbanyak? List nama mereka dan jumlah vote-nya. Siapa saja yang memilih politisi tersebut? List nama mereka, dan jenis kelamin mereka.


select congress_members.name as "Congress Name",
(voters.first_name || ' ' || voters.last_name) as "Voters Name",
voters.gender as "Voters Gender"
from voters
join votes
on voters.id = votes.voter_id
join congress_members
on votes.politician_id = congress_members.id
where voters.id = votes.voter_id
and votes.politician_id
in
(select votes.politician_id
from votes
group by votes.politician_id
order by count(votes.politician_id) desc limit 1);

2. Berapa banyak vote yang diterima anggota Congress yang memiliki grade di bawah 9 (gunakan field grade_current)? Ambil nama, lokasi, grade_current dan jumlah vote.

select congress_members.name as "Congress Name",
congress_members.location,
congress_members.grade_current,
count(votes.politician_id) as "Count Votes"
from votes
join congress_members
on votes.politician_id = congress_members.id
where congress_members.grade_current < 9
group by votes.politician_id
order by count(votes.politician_id);

3. Apa saja 10 negara bagian yang memiliki voters terbanyak? List semua orang yang melakukan vote di negara bagian yang paling populer. (Akan menjadi daftar yang panjang, kamu bisa gunakan hasil dari query pertama untuk menyederhanakan query berikut ini.)

select congress_members.name as "Congress Name",
congress_members.location as "Location Congress",
(voters.first_name || ' ' || voters.last_name) as "Voters Name",
voters.gender as "Voters Gender"
from voters
join votes
on voters.id = votes.voter_id
join congress_members
on votes.politician_id = congress_members.id
where voters.id = votes.voter_id
and votes.politician_id
in
(select votes.politician_id
from votes
group by votes.politician_id
order by count(votes.politician_id) desc limit 10)
order by congress_members.id;

4. List orang-orang yang vote lebih dari dua kali. Harusnya mereka hanya bisa vote untuk posisi Senator dan satu lagi untuk wakil. Wow, kita dapat si tukang curang! Segera laporkan ke KPK!!

SELECT voters.id,
(voters.first_name || ' ' || voters.last_name) as voter_name,
COUNT(votes.id) AS count
FROM voters
JOIN votes
ON votes.voter_id = voters.id
GROUP BY voters.id
HAVING count > 2;

5. Apakah ada orang yang melakukan vote kepada politisi yang sama dua kali? Siapa namanya dan siapa nama politisinya?

SELECT voters.id as voter_id,
(voters.first_name || ' ' || voters.last_name) as voter_name,
congress_members.id as congress_name_id,
congress_members.name as congress_name,
COUNT(votes.id) AS count
FROM voters
JOIN votes
ON votes.voter_id = voters.id
JOIN congress_members
ON congress_members.id = votes.politician_id
GROUP BY voters.id, congress_members.id
HAVING count > 1;
