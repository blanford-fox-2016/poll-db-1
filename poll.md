release 1
nomor 1
select congress_members.id, congress_members.name, count(votes.politician_id) from congress_members join votes on congress_members.id = votes.politician_id where congress_members.id = 524;

//kedua
select count(politician_id) from votes where politician_id = 524;

nomor 2
select * from congress_members join votes on congress_members.id = votes.politician_id

nomor 3
select congress_members.id, congress_members.name, count(votes.politician_id) from congress_members join votes on congress_members.id = votes.politician_id where congress_members.name like "%erik paulsen%";

nomor 4
select congress_members.id, congress_members.name, count(votes.politician_id) from congress_members join votes on congress_members.id = votes.politician_id group by congress_members.id having count(votes.politician_id) = (select count(votes.politician_id) from congress_members join votes on congress_members.id = votes.politician_id group by congress_members.id order by count(votes.politician_id) desc limit 1);


nomor 5
select congress_members.id, congress_members.name, congress_members.created_at, congress_members.updated_at, votes.politician_id from congress_members join votes on congress_members.id = votes.politician_id;


release 2
nomor 1
select congress_members.id, congress_members.name, count(votes.politician_id), voters.first_name, voters.last_name, voters.gender from congress_members join votes on congress_members.id = votes.politician_id join voters on voters.id = votes.voter_id group by congress_members.id having count(votes.politician_id) = (select count(votes.politician_id) from congress_members join votes on congress_members.id = votes.politician_id group by congress_members.id order by count(votes.politician_id) desc limit 1);

nomor 2
select congress_members.id, congress_members.name, congress_members.location, congress_members.grade_current, count(votes.politician_id) from congress_members join votes on congress_members.id = votes.politician_id where congress_members.grade_current<9 group by congress_members.id;

nomor 3
select congress_members.id, congress_members.name, count(votes.politician_id) from congress_members join votes on congress_members.id = votes.politician_id group by congress_members.id order by count(votes.politician_id) DESC limit 10;

nomor 4
select voters.id, voters.first_name, voters.last_name, count(voter_id) from voters join votes on voters.id = votes.voter_id group by voters.id having count(voter_id) > 1;

nomor 5
select voters.id, congress_members.name, voters.first_name, voters.last_name, count(voter_id) from voters join votes on voters.id = votes.voter_id join congress_members on congress_members.id = votes.politician_id group by voters.id,politician_id having count(voter_id) > 1;
