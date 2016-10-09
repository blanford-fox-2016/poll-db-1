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

Release 1
======================================================
1.
SELECT COUNT( * ) 
  FROM votes
 WHERE politician_id = 524;

2.
SELECT *
  FROM congress_members,
       votes
 WHERE congress_members.id = votes.politician_id;
 
3.
SELECT COUNT( * ) 
  FROM congress_members,
       votes
 WHERE congress_members.id = votes.politician_id AND 
       congress_members.name LIKE "%Erik Paulsen%";

4. 
SELECT
        COUNT( * ) AS total_vote,
       name,
       party,
       location,
       grade_1996,
       grade_current,
       dw1_score
  FROM congress_members,
       votes
 WHERE congress_members.id = votes.politician_id
 GROUP BY congress_members.id
 ORDER BY total_vote DESC
 LIMIT 10

5.
SELECT COUNT( * ) AS total_vote,
       name,
       party,
       location,
       grade_1996,
       grade_current,
       dw1_score
  FROM congress_members,
       votes
 WHERE congress_members.id = votes.politician_id
 GROUP BY congress_members.id
 ORDER BY total_vote ASC;
 LIMIT 10


Release 2
======================================================
1. 
 SELECT table_1.total_vote,
       congress_members.name,
       ( voters.first_name || " " || voters.last_name ) as voter_name
  FROM votes
       LEFT JOIN
       (
           SELECT count( * ) AS total_vote,
                  votes.politician_id
             FROM votes
            GROUP BY votes.politician_id
       )
       AS table_1 ON votes.politician_id = table_1.politician_id
       JOIN
       congress_members ON congress_members.id = votes.politician_id
       JOIN
       voters ON voters.id = votes.voter_id
 ORDER BY total_vote, congress_members.name;

2. 


