ALTER TABLE productos
ADD COLUMN IF NOT EXISTS costo NUMERIC(12,2);

UPDATE productos
SET costo = precio
WHERE costo IS NULL;

ALTER TABLE productos
ALTER COLUMN costo SET NOT NULL;
 
 -- Insertar roles si no existen
INSERT INTO roles (nombre) 
SELECT 'ROLE_ADMIN' WHERE NOT EXISTS (SELECT 1 FROM roles WHERE nombre = 'ROLE_ADMIN');

INSERT INTO roles (nombre) 
SELECT 'ROLE_VENDEDOR' WHERE NOT EXISTS (SELECT 1 FROM roles WHERE nombre = 'ROLE_VENDEDOR');

-- Insertar usuario admin si no existe
-- password = Admin123* encriptado con BCrypt
INSERT INTO usuarios (username, password, activo, rol_id)
SELECT 'admin', 
       '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', 
       true, 
       (SELECT id FROM roles WHERE nombre = 'ROLE_ADMIN')
WHERE NOT EXISTS (SELECT 1 FROM usuarios WHERE username = 'admin');