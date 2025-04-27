-- Banco de dados Universidade.
CREATE DATABASE Universidade;
USE Universidade;

-- Tabela Grupo.
CREATE TABLE Grupo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    grade VARCHAR(255) NOT NULL,
    semestre INT(2) NOT NULL,
    ano INT(4) NOT NULL,
    curso_id INT,
    seção_id INT,
    FOREIGN KEY (curso_id) REFERENCES Curso(id),
    FOREIGN KEY (seção_id) REFERENCES Seção(id),
);

-- Tabela Instrutor.
CREATE TABLE Instrutor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    salario DECIMAL(9,2) NOT NULL,
    departamento_id INT,
    FOREIGN KEY (departamento_id) REFERENCES Departamento(id)
);

-- Tabela Requisitos.
CREATE TABLE Requisitos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descricao TEXT NOT NULL,
    curso_id INT,
    FOREIGN KEY (curso_id) REFERENCES Curso(id)
);

-- Tabela Professor.
CREATE TABLE Professor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    especialidade VARCHAR(255),
    salario DECIMAL(9,2) NOT NULL,
    semestre INT(2) NOT NULL,
    ano INT(4) NOT NULL,
    curso_id INT,
    seção_id INT,
    FOREIGN KEY (curso_id) REFERENCES Curso(id),
    FOREIGN KEY (seção_id) REFERENCES Seção(id),
);

-- Tabela Seção.
CREATE TABLE Secao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    semestre INT(2) NOT NULL,
    ano INT(4) NOT NULL,
    predio VARCHAR(255) NOT NULL,
    curso_id INT,
    instrutor_id INT,
    horario_id INT,
    FOREIGN KEY (curso_id) REFERENCES Curso(id),
    FOREIGN KEY (instrutor_id) REFERENCES Instrutor(id),
    FOREIGN KEY (horário_id) REFERENCES Horário(id)
);

-- Tabela Sala de aula.
CREATE TABLE SalaDeAula (
    id INT AUTO_INCREMENT PRIMARY KEY,
    predio VARCHAR(255) NOT NULL,
    numero INT NOT NULL,
    capacidade INT
);

-- Tabela Horário.
CREATE TABLE Horario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dia_semana VARCHAR(255) NOT NULL,
    horario_inicio TIME NOT NULL,
    horario_fim TIME NOT NULL,
    sala_id INT,
    FOREIGN KEY (sala_id) REFERENCES SalaDeAula(id)
);

-- Tabela Estudante.
CREATE TABLE Estudante (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    nota DECIMAL(4,2),
    curso_id INT,
    grupo_id INT,
    departamento_id INT,
    FOREIGN KEY (curso_id) REFERENCES Curso(id),
    FOREIGN KEY (grupo_id) REFERENCES Grupo(id),
    FOREIGN KEY (departamento_id) REFERENCES Departamento(id)
);

-- Tabela Curso.
CREATE TABLE Curso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    nota DECIMAL(4,2),
    departamento_id INT,
    FOREIGN KEY (departamento_id) REFERENCES Departamento(id)
);

-- Tabela Departamento.
CREATE TABLE Departamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    predio VARCHAR(255) NOT NULL,
    orçamento INT(12) NOT NULL
);

-- Tabela Conselheiro.
CREATE TABLE Conselheiro (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    instrutor_id INT, 
    estudante_id INT,
    FOREIGN KEY (estudante_id) REFERENCES Estudante(id),
    FOREIGN KEY (instrutor_id) REFERENCES Instrutor(id)
);



USE Universidade;

-- Contas de usuário e associá-las ao banco de dados.
CREATE USER 'User_A'@'localhost' IDENTIFIED BY 'senhaA';
CREATE USER 'User_B'@'localhost' IDENTIFIED BY 'senhaB';
CREATE USER 'User_C'@'localhost' IDENTIFIED BY 'senhaC';
CREATE USER 'User_D'@'localhost' IDENTIFIED BY 'senhaD';
CREATE USER 'User_E'@'localhost' IDENTIFIED BY 'senhaE';



USE Universidade;

-- Conceder privilégios para todas as tabelas, exceto SalaDeAula.
GRANT SELECT, INSERT, UPDATE, DELETE ON Universidade.* TO 'User_A'@'localhost';
REVOKE SELECT, INSERT, UPDATE, DELETE ON Universidade.SalaDeAula FROM 'User_A'@'localhost';

-- Permitir que o User_A conceda privilégios para outros usuários.
GRANT GRANT OPTION ON Universidade.* TO 'User_A'@'localhost';
REVOKE GRANT OPTION ON Universidade.SalaDeAula FROM 'User_A'@'localhost';

-- Aplicar as mudanças
FLUSH PRIVILEGES;


USE Universidade;
-- Mostrar privilégios.
SHOW GRANTS FOR 'User_A'@'localhost';
