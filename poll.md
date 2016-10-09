Release 1 : Query to extract voting data

1.// Hitung jumlah vote untuk sen. olympia snowe yang memiliki id 524
=> SELECT COUNT(*) FROM votes WHERE politician_id = 524;  (* // 22

2.// Lakukan JOIN tanpa menggunakan id 524. Query kedua tabel votes dan congress_members
=> SELECT * FROM votes INNER JOIN congress_members ON votes.politician_id = congress_members.id AND congress_members.id != 524;  

3.// Berapa banyak vote untuk Erik Paulsen ?
=> SELECT id FROM congress_members where name LIKE '%erik%'; // 339
=> SELECT COUNT(*) FROM votes WHERE politician_id = 339; // 21 (*

4.// Buatlah daftar peserta congress yang mendapatkan vote terbanyak. jangan sertakan field created_at dan updated_at.
=> select v.politician_id, c.name, count(v.politician_id) as RANK from votes v inner join congress_members c on v.politician_id = c.id group by v.politician_id, c.name order by RANK desc;

5.// Buatlah daftar semua anggota congress yang setidaknya mendapatkan beberapa vote dalam urutan yang paling sedikit. dan juga jangan sertakan field yang memiliki tipe date.
=> select v.politician_id, c.name, count(v.politician_id) as RANK from votes v inner join congress_members c on v.politician_id = c.id GROUP by v.politician_id, c.name ORDER by RANK asc;
