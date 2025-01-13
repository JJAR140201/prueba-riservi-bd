USE reservacion;
-- Esquema de la Base de Datos para Reservaciones

-- Crear tabla de Clientes
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(15)
);

-- Crear tabla de Horarios Disponibles
CREATE TABLE Horarios_Disponibles (
    id_horario INT AUTO_INCREMENT PRIMARY KEY,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL
);

-- Crear tabla de Horario de Reservas
CREATE TABLE Horario_Reservas (
    id_horario_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_horario INT NOT NULL,
    estado ENUM('disponible', 'reservado') DEFAULT 'disponible',
    FOREIGN KEY (id_horario) REFERENCES Horarios_Disponibles(id_horario)
);

-- Crear tabla de Reservaciones
CREATE TABLE Reservaciones (
    id_reservacion INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_horario_reserva INT NOT NULL,
    fecha_reserva DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_horario_reserva) REFERENCES Horario_Reservas(id_horario_reserva)
);

-- Inserciones para poblar las tablas

-- Insertar datos en la tabla de Clientes
INSERT INTO Clientes (nombre, email, telefono)
VALUES 
('Juan Perez', 'juan.perez@example.com', '1234567890'),
('Maria Lopez', 'maria.lopez@example.com', '0987654321'),
('Carlos Sanchez', 'carlos.sanchez@example.com', '1122334455');

-- Insertar datos en la tabla de Horarios Disponibles
INSERT INTO Horarios_Disponibles (hora_inicio, hora_fin)
VALUES 
('08:00:00', '09:00:00'),
('09:00:00', '10:00:00'),
('10:00:00', '11:00:00');

-- Insertar datos en la tabla de Horario de Reservas
INSERT INTO Horario_Reservas (id_horario, estado)
VALUES 
(1, 'disponible'),
(2, 'disponible'),
(3, 'reservado');

-- Insertar datos en la tabla de Reservaciones
INSERT INTO Reservaciones (id_cliente, id_horario_reserva, fecha_reserva)
VALUES 
(1, 3, '2025-01-15'),
(2, 2, '2025-01-16');

-- Consultas SQL

-- 1. Verificar los horarios disponibles para un día específico (Jueves)
SELECT HD.id_horario, HD.hora_inicio, HD.hora_fin, HR.estado
FROM Horarios_Disponibles HD
JOIN Horario_Reservas HR ON HD.id_horario = HR.id_horario
WHERE HR.estado = 'disponible' AND DAYNAME(CURDATE()) = 'Thursday';

-- Crear una nueva reservación para un cliente utilizando un id_horario_reserva válido
INSERT INTO Reservaciones (id_cliente, id_horario_reserva, fecha_reserva)
VALUES 
(1, 4, '2025-01-15'); -- Cliente 1 usa id_horario_reserva = 4

-- 3. Actualizar una reservación existente
UPDATE Reservaciones
SET id_horario_reserva = 3, fecha_reserva = '2025-01-16'
WHERE id_reservacion = 1;

-- 4. Cancelar (eliminar) una reservación
DELETE FROM Reservaciones
WHERE id_reservacion = 1;
