CREATE TABLE Usuario(
    id INT PRIMARY KEY,
    nombre NVARCHAR(100)
)

CREATE TABLE Libro(
    id INT PRIMARY KEY,
    titulo NVARCHAR(200),
    autor NVARCHAR(100),
)

CREATE TABLE Prestamo(
    id INT PRIMARY KEY,
    id_usuario INT,
    id_libro INT,
    fecha_prestamo DATE,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id),
    FOREIGN KEY (id_libro) REFERENCES Libro(id)
)

SELECT DISTINCT(u.nombre)
FROM Usuario u
JOIN Prestamo p ON u.id = p.id_usuario;

SELECT DISTINCT(l.titulo)
FROM Libro l
JOIN Prestamo p ON l.id = p.id_libro
WHERE p.id_usuario = 3;

SELECT u.nombre, COUNT(DISTINCT(p.id_libro)) AS cantidad_libros
FROM Usuario u
JOIN Prestamo p ON u.id = p.id_usuario
WHERE cantidad_libros < 100
GROUP BY u.nombre;

SELECT u.nombre
FROM Usuario u
WHERE NOT EXISTS(
    SELECT 1
    FROM Libro l
    WHERE l.autor = 'Borges'
    AND NOT EXISTS(
        SELECT 1 
        FROM Prestamo p
        WHERE p.id_usuario = u.id_usuario
        AND p.id_libro = l.id_libro
    )
);
