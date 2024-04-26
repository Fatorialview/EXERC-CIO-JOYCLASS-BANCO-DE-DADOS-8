CREATE DATABASE academia;

CREATE TABLE Alunos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    data_nascimento DATE,
    telefone VARCHAR(20)
);


CREATE TABLE Instrutores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    area_especialidade VARCHAR(50)
);


CREATE TABLE Aulas (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    id_instrutor INT REFERENCES Instrutores(id)
);


CREATE TABLE Matriculas (
    id SERIAL PRIMARY KEY,
    id_aluno INT REFERENCES Alunos(id),
    id_aula INT REFERENCES Aulas(id),
    data_matricula DATE DEFAULT CURRENT_DATE
);


CREATE OR REPLACE FUNCTION atualiza_qtd_matriculados()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Aulas
    SET qtd_matriculados = qtd_matriculados + 1
    WHERE id = NEW.id_aula;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_atualiza_qtd_matriculados
AFTER INSERT ON Matriculas
FOR EACH ROW
EXECUTE PROCEDURE atualiza_qtd_matriculados();