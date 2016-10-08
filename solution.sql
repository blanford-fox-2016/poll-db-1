CREATE TABLE congress_members (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(64) NOT NULL,
  party VARCHAR(64) NOT NULL,
  location VARCHAR(64) NOT NULL,
  grade_1996 REAL,
  grade_current REAL,
  years_in_congress INTEGER,
  dw1_score REAL
, created_at DATETIME, updated_at DATETIME);
CREATE TABLE voters (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(64) NOT NULL,
    last_name  VARCHAR(64) NOT NULL,
    gender VARCHAR(64) NOT NULL,
    party VARCHAR(64) NOT NULL,
    party_duration INTEGER,
    age INTEGER,
    married INTEGER,
    children_count INTEGER,
    homeowner INTEGER,
    employed INTEGER,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
  );
CREATE TABLE votes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    voter_id INTEGER,
    politician_id INTEGER,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    FOREIGN KEY(voter_id) REFERENCES voters(id),
    FOREIGN KEY(politician_id) REFERENCES congress_members(id)
  );

--Release 1
1. select count(*) from votes where politician_id = 524;
2. select * from votes (inner join)join congress_members on votes.politician_id = congress_members.id;
3. SELECT COUNT(*) FROM congress_members, votes WHERE votes.politician_id = congress_members.id AND congress_members.name LIKE '%Erik Paulsen%';
4. select count(*) as total_votes,congress_members.name from congress_members,votes where congress_members.id = votes.politician_id group by congress_members.name order by total_votes desc;
5. select count(*) as total_votes,congress_members.name,congress_members.pa
rty,congress_members.location,congress_members.grade_1996,congress_members.grade
_current,congress_members.years_in_congress,congress_members.dw1_score from cong
ress_members,votes where congress_members.id = votes.politician_id group by cong
ress_members.name order by total_votes;
--Release 2
1.select count(*) as total_votes,
  congress_members.name,
  tb_1.name
from
congress_members,voters,votes, (SELECT votes.id as id, voters.first_name as name  FROM voters, votes WHERE voters.id = votes.voter_id ) as tb_1
where
congress_members.id = votes.politician_id
and
voters.id = votes.voter_id
and
tb_1.id = voters.id
group by congress_members.name
order by total_votes;
