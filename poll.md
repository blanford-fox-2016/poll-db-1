sqlite3 congress_poll_results.db
> .schema

#RELEASE 1
1. Hitung jumlah vote untuk Sen. Olympia Snowie : **SELECT count() FROM votes WHERE politician_id = 524;** (Output 22)
2. Join table votes dan table congress_members : **SELECT * FROM votes INNER JOIN congress_members ON votes.politician_id = congress_members.id;**
3. Menemukan id Erik Paulse dengan perintah :  **SELECT id FROM congress_members where name LIKE '%erik%';** (Output 339)
   Kemudian menghitung jumlah votenya dgn perintah : **SELECT count() FROM votes WHERE politician_id = 339;** (Output 21)
4. Membuat daftar peraih vote terbanyak : **SELECT congress_members.name, congress_members.id, count(votes.politician_id) FROM votes JOIN congress_members on votes.politician_id = congress_members.id GROUP BY votes.politician_id ORDER BY count(votes.politician_id) DESC;**
5. Membuat daftar peraih vote mulai dari paling sedikit : **SELECT congress_members.name, congress_members.id, count(votes.politician_id) FROM votes JOIN congress_members on votes.politician_id = congress_members.id GROUP BY votes.politician_id ORDER BY count(votes.politician_id);**

#RELEASE 2
1. List politisi dengan vote terbanyak **SELECT congress_members.name AS "Politicians Names", CONCAT(voters.first_name,' ', voters.last_name) AS "Voters Name", voters.gender AS SELECTs Gender"FROM voters JOIN votes ON voters.id = votes.voter_id JOIN congress_members ON votes.politician_id = congress_members.id WHERE voters.id = votes.voter_id AND votes.politician_id in (select votes.politician_id FROM votes GROUP BY votes.politician_id ORDER BY count(votes.politician_id) DESC);**


2. Banyak vote yang diterima anggota congress dengan grade dibawah 9 : **SELECT congress_members.name AS "Politicianss Name", congress_members.location, congress_members.grade_current, count(votes.politician_id) AS "Count Votes" FROM votes JOIN congress_members ON votes.politician_id = congress_members.id WHERE congress_members.grade_current < 9 GROUP BY votes.politician_id ORDER BY count(votes.politician_id);**

3. 10 Negara bagian dengan voters terbanyak : **SELECT congress_members.name AS "Politicians Name", congress_members.location AS "States", CONCAT(voters.first_name , ' ', voters.last_name) AS "Voters Name", voters.gender AS "Voters Gender" FROM voters JOIN votes ON voters.id = votes.voter_id JOIN congress_members ON votes.politician_id = congress_members.id WHERE voters.id = votes.voter_id AND votes.politician_id IN (SELECT votes.politician_id FROM votes GROUP BY votes.politician_id ORDER BY count(votes.politician_id) DESC LIMIT 10) ORDER BY congress_members.id;**

4. List orang yang vote lebih dari 2 kali : **SELECT voters.id, CONCAT(voters.first_name ,' ', voters.last_name) AS "Voters Name", COUNT(votes.id) AS count FROM voters JOIN votes ON votes.voter_id = voters.id GROUP BY voters.id HAVING count > 2;**

5. Orang yang vote politisi sama dua kali : **SELECT voters.id AS voter_id, CONCAT(voters.first_name, ' ', voters.last_name) AS voter_name, congress_members.id AS congress_name_id, congress_members.name AS congress_name, COUNT(votes.id) AS count FROM voters JOIN votes ON votes.voter_id = voters.id JOIN congress_members ON congress_members.id = votes.politician_id GROUP BY voters.id, congress_members.id HAVING count > 1;**
