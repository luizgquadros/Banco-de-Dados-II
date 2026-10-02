CREATE DATABASE biblioteca_db;

USE biblioteca_db;

CREATE TABLE autores (
    id_autor int PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    nacionalidade VARCHAR(50)
);

CREATE TABLE categorias (
    id_categoria int PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT
);

CREATE TABLE editoras (
    id_editora int PRIMARY KEY,
    nome VARCHAR(150) NOT NULL UNIQUE,
    cidade VARCHAR(100)
);

CREATE TABLE livros (
    id_livro int PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    ano_publicacao INT,
    id_categoria INT NOT NULL,
    id_editora INT NOT NULL,
    CONSTRAINT fk_livro_categoria FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    CONSTRAINT fk_livro_editora FOREIGN KEY (id_editora) REFERENCES editoras(id_editora)
);

CREATE TABLE livro_autor (
    id_livro INT NOT NULL,
    id_autor INT NOT NULL,
    PRIMARY KEY (id_livro, id_autor),
    CONSTRAINT fk_la_livro FOREIGN KEY (id_livro) REFERENCES livros(id_livro) ON DELETE CASCADE,
    CONSTRAINT fk_la_autor FOREIGN KEY (id_autor) REFERENCES autores(id_autor) ON DELETE CASCADE
);

CREATE TABLE exemplares (
    id_exemplar int PRIMARY KEY,
    id_livro INT NOT NULL,
    codigo_patrimonio VARCHAR(50) UNIQUE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'DISPONIVEL' 
        CHECK (status IN ('DISPONIVEL', 'EMPRESTADO', 'EM_MANUTENCAO', 'PERDIDO')),
    CONSTRAINT fk_exemplar_livro FOREIGN KEY (id_livro) REFERENCES livros(id_livro) ON DELETE CASCADE
);

CREATE TABLE usuarios (
    id_usuario int PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    data_cadastro DATE NOT NULL DEFAULT (CURRENT_DATE)
);

CREATE TABLE emprestimos (
    id_emprestimo int PRIMARY KEY,
    id_exemplar INT NOT NULL,
    id_usuario INT NOT NULL,
    data_emprestimo DATE NOT NULL DEFAULT (CURRENT_DATE),
    data_prevista_devolucao DATE NOT NULL,
    data_devolucao_real DATE,
    valor_multa DECIMAL(10, 2) DEFAULT 0.00,
    status VARCHAR(20) NOT NULL DEFAULT 'ATIVO' 
        CHECK (status IN ('ATIVO', 'CONCLUIDO', 'ATRASADO')),
    CONSTRAINT fk_emprestimo_exemplar FOREIGN KEY (id_exemplar) REFERENCES exemplares(id_exemplar),
    CONSTRAINT fk_emprestimo_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

INSERT INTO autores (id_autor, nome, nacionalidade) VALUES
(1, 'Machado de Assis', 'Brasileiro'),
(2, 'George Orwell', 'Britânico'),
(3, 'Clarice Lispector', 'Brasileira'),
(4, 'Jorge Amado', 'Brasileiro'),
(5, 'J. K. Rowling', 'Britânica'),
(6, 'Gabriel García Márquez', 'Colombiano'),
(7, 'José Saramago', 'Português'),
(8, 'Agatha Christie', 'Britânica'),
(9, 'Stephen King', 'Americano'),
(10, 'Fiódor Dostoiévski', 'Russo');

INSERT INTO categorias (id_categoria, nome, descricao) VALUES
(1, 'Ficção Científica', 'Obras baseadas em conceitos científicos e futuristas'),
(2, 'Romance', 'Narrativas focadas em relações pessoais e desenvolvimento de personagens'),
(3, 'Literatura Brasileira', 'Clássicos da Literatura Brasileira'),
(4, 'Fantasia', 'Obras com elementos mágicos e mundos imaginários'),
(5, 'Mistério', 'Narrativas envolvendo enigmas e investigações'),
(6, 'Terror', 'Obras voltadas ao suspense e ao horror'),
(7, 'Drama', 'Narrativas com conflitos e situações emocionais'),
(8, 'Aventura', 'Histórias envolvendo viagens, desafios e descobertas'),
(9, 'Literatura Estrangeira', 'Obras clássicas e contemporâneas de autores estrangeiros'),
(10, 'Distopia', 'Narrativas sobre sociedades futuristas ou opressivas');

INSERT INTO editoras (id_editora, nome, cidade) VALUES
(1, 'Companhia das Letras', 'São Paulo'),
(2, 'Editora Rocco', 'Rio de Janeiro'),
(3, 'Penguin Classics', 'Londres'),
(4, 'Editora Record', 'Rio de Janeiro'),
(5, 'Aleph', 'São Paulo'),
(6, 'DarkSide Books', 'Rio de Janeiro'),
(7, 'Intrínseca', 'Rio de Janeiro'),
(8, 'Globo Livros', 'São Paulo'),
(9, 'Editora 34', 'São Paulo'),
(10, 'HarperCollins Brasil', 'Rio de Janeiro');

INSERT INTO livros (id_livro, titulo, isbn, ano_publicacao, id_categoria, id_editora) VALUES
(1, 'Dom Casmurro', '9788535914840', 1899, 3, 1),
(2, '1984', '9788535914849', 1949, 10, 3),
(3, 'A Hora da Estrela', '9788532511010', 1977, 3, 2),
(4, 'Capitães da Areia', '9788535911695', 1937, 3, 4),
(5, 'Harry Potter e a Pedra Filosofal', '9788532530784', 1997, 4, 2),
(6, 'Cem Anos de Solidão', '9788501012074', 1967, 9, 8),
(7, 'Ensaio sobre a Cegueira', '9788535914841', 1995, 7, 9),
(8, 'Assassinato no Expresso do Oriente', '9788595081510', 1934, 5, 10),
(9, 'O Iluminado', '9788581050482', 1977, 6, 6),
(10, 'Crime e Castigo', '9788535911696', 1866, 9, 9);

INSERT INTO livro_autor (id_livro, id_autor) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO exemplares (id_exemplar, id_livro, codigo_patrimonio, status) VALUES
(1, 1, 'PAT-2026-001', 'DISPONIVEL'),
(2, 1, 'PAT-2026-002', 'EMPRESTADO'),
(3, 2, 'PAT-2026-003', 'DISPONIVEL'),
(4, 3, 'PAT-2026-004', 'EMPRESTADO'),
(5, 4, 'PAT-2026-005', 'DISPONIVEL'),
(6, 5, 'PAT-2026-006', 'EMPRESTADO'),
(7, 6, 'PAT-2026-007', 'EMPRESTADO'),
(8, 7, 'PAT-2026-008', 'DISPONIVEL');

INSERT INTO usuarios (id_usuario, nome, email, telefone) VALUES
(1, 'Ana Silvia', 'ana.silvia@gmail.com', '11-98765-4321'),
(2, 'Carlos Oliveira', 'carlos@gmail.com', '21-97654-3210'),
(3, 'Mariana Souza', 'mariana@gmail.com', '11-96543-2109'),
(4, 'João Pedro', 'joao.pedro@gmail.com', '11-95432-1098'),
(5, 'Beatriz Santos', 'beatriz@gmail.com', '21-94321-0987'),
(6, 'Lucas Ferreira', 'lucas@gmail.com', '11-93210-9876'),
(7, 'Gabriela Costa', 'gabriela@gmail.com', '31-92109-8765'),
(8, 'Rafael Almeida', 'rafael@gmail.com', '41-91098-7654');

INSERT INTO emprestimos (id_emprestimo, id_exemplar, id_usuario, data_emprestimo, 
data_prevista_devolucao, data_devolucao_real, valor_multa, status) VALUES

(1, 2, 1, '2026-09-01', '2026-09-15', NULL, 0.00, 'ATIVO'),

(2, 4, 2, '2026-08-10', '2026-08-24', '2026-08-28', 5.00, 'CONCLUIDO'),

(3, 6, 3, '2026-09-05', '2026-09-19', NULL, 0.00, 'ATRASADO'),

(4, 7, 4, '2026-09-10', '2026-09-24', NULL, 0.00, 'ATRASADO'),

(5, 1, 5, '2026-07-01', '2026-07-15', '2026-07-14', 0.00, 'CONCLUIDO'),

(6, 3, 6, '2026-08-01', '2026-08-15', '2026-08-14', 0.00, 'CONCLUIDO'),

(7, 5, 7, '2026-09-15', '2026-09-29', NULL, 0.00, 'ATIVO'),

(8, 8, 8, '2026-09-20', '2026-10-04', NULL, 0.00, 'ATIVO');