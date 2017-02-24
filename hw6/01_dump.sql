DROP TABLE IF EXISTS Keyword;
CREATE TABLE Keyword(
  id INT PRIMARY KEY,
  value TEXT,
  parent_id INT REFERENCES Keyword DEFAULT NULL
);

CREATE OR REPLACE FUNCTION InsertKeyword(vertex_id INT, parent_id INT, value TEXT)
RETURNS INT AS $$
DECLARE _result INT;
BEGIN
INSERT INTO Keyword(id, value, parent_id) VALUES (vertex_id, value, parent_id) RETURNING id INTO _result;
RETURN _result;
END;
$$ LANGUAGE plpgsql;

-- Процедура генерирует случайное дерево из 50 вершин
CREATE OR REPLACE FUNCTION GenerateData()
RETURNS VOID AS $$
DECLARE
  _id INT;
  _parent_id INT;
  _value TEXT;
BEGIN
PERFORM InsertKeyword(0, NULL, 'root');
FOR _id IN 1..49 LOOP
  _parent_id = floor((random()*_id));
  _value = md5(random()::TEXT);
  PERFORM InsertKeyword(_id, _parent_id, _value);
END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT GenerateData();
