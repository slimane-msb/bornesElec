CREATE TABLE Example (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    age INT CHECK (age >= 0),
    salary DECIMAL(10, 2) DEFAULT 0.00,
    appointment_time TIME,
    phone_number CHAR(10),

    is_active BOOLEAN DEFAULT TRUE,
    status ENUM('active', 'inactive', 'banned') DEFAULT 'active',
    
    FOREIGN KEY (department_id) REFERENCES Departments(id),
    UNIQUE (name, email)
)




CREATE TABLE ExampleTable (
    -- Identifiers
    id INT AUTO_INCREMENT PRIMARY KEY,
    uuid BINARY(16) NOT NULL UNIQUE,

    -- Basic Data Types
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- Numeric Data Types
    age INT CHECK (age >= 0),
    salary DECIMAL(10, 2) DEFAULT 0.00,
    percentage FLOAT(5, 2),
    score DOUBLE,
    
    -- Boolean
    is_active BOOLEAN DEFAULT TRUE,
    
    -- Date and Time
    birthdate DATE,
    appointment_time TIME,
    
    -- Miscellaneous
    email VARCHAR(255) UNIQUE,
    phone_number CHAR(10),
    profile_picture BLOB,

    -- Enum (MySQL specific)
    status ENUM('active', 'inactive', 'banned') DEFAULT 'active',
    
    -- Foreign Key Example
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(id),

    -- Composite Key Example
    UNIQUE (name, email)
);

