import psycopg2 as pg_driver

db = pg_driver.connect(user="db", password="q", host="localhost", dbname="db")

cur = db.cursor()

def fun1(researcher_id):
  cur.execute("SELECT researcher_id, conference_id FROM Participant")
  for p in cur.fetchall():
    if p[0] != researcher_id:
      continue
    cur.execute("SELECT conference_id, name FROM Conference")
    for c in cur.fetchall():
      if c[0] == p[1]:
        yield c, p

def fun2(researcher_id):
  for conference, participant in fun1(researcher_id):
    cur.execute("SELECT researcher_id, name FROM Researcher")
    for r in cur.fetchall():
      if r[0] == participant[0]:
        yield r, conference, participant

for row in fun2(100):
  print row

# На SQL: (P JOIN C ON (C.conference_id = P.conference_id)) JOIN R ON (P.researcher_id = R.researcher_id)
