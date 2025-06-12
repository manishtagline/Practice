CREATE DATABASE servletprac;
CREATE TABLE Employee (
    employeeId INT PRIMARY KEY auto_increment,
    employeeName VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    designation VARCHAR(50),
    leaveBalance INT
);


CREATE TABLE leave_requests (
    leaveId INT PRIMARY KEY AUTO_INCREMENT,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    reason VARCHAR(255),
    status VARCHAR(50),
    employee_id INT NOT NULL,

    CONSTRAINT fk_employee
        FOREIGN KEY (employee_id)
        REFERENCES employee(employeeId)
        ON DELETE CASCADE
);

