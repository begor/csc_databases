DROP TABLE IF EXISTS PaperSubmission;
DROP TABLE IF EXISTS Conference;
DROP TABLE IF EXISTS Venue;

PRAGMA foreign_keys = ON;

CREATE TABLE Conference(
    name TEXT PRIMARY KEY,
    description TEXT
);

CREATE TABLE Venue(
    id INTEGER PRIMARY KEY,
    name TEXT,
    city TEXT,
    country TEXT,
    lat NUMERIC(7,5),
    lon NUMERIC(8,5),
    UNIQUE(lat, lon)
);

CREATE TABLE PaperSubmission(
  id INTEGER PRIMARY KEY,
  conference TEXT,
  year INTEGER,
  title TEXT,
  isbn TEXT,
  page INTEGER,
  venue_id INTEGER,
  FOREIGN KEY(conference) REFERENCES Conference(name),
  FOREIGN KEY(venue_id) REFERENCES Venue(id),
  UNIQUE(conference, year, title),
  UNIQUE(title, isbn),
  UNIQUE(page, isbn)
);
