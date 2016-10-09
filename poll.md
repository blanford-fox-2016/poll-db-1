sqlite3 congress_poll_results.db
> .schema

#RELEASE 1
1. Hitung jumlah vote untuk Sen. Olympia Snowie : **SELECT count() FROM votes WHERE politician_id = 524;** (Output 22)
2. Join table votes dan table congress_members : **SELECT * FROM votes INNER JOIN congress_members ON votes.politician_id = congress_members.id;**
3. Menemukan id Erik Paulse dengan perintah :  **SELECT id FROM congress_members where name LIKE '%erik%';** (Output 339)
   Kemudian menghitung jumlah votenya dgn perintah : **SELECT count() FROM votes WHERE politician_id = 339;** (Output 21)
4. Membuat daftar peraih vote terbanyak : **SELECT congress_members.name, congress_members.id, count(votes.politician_id) FROM votes JOIN congress_members on votes.politician_id = congress_members.id GROUP BY votes.politician_id ORDER BY count(votes.politician_id) DESC;**
5. Membuat daftar peraih vote mulai dari paling sedikit : **SELECT congress_members.name, congress_members.id, count(votes.politician_id) FROM votes JOIN congress_members on votes.politician_id = congress_members.id GROUP BY votes.politician_id ORDER BY count(votes.politician_id);**
