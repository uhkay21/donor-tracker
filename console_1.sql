-- Create donors table
CREATE TABLE donors
(
    donor_id SERIAL PRIMARY KEY
    , donor_type VARCHAR(20) NOT NULL
    , first_name VARCHAR(50)
    , last_name VARCHAR(50)
    , organization_name VARCHAR(100)
    , email VARCHAR(100) NOT NULL
    , phone VARCHAR(20)
    , address_line1 VARCHAR(20)
    , city VARCHAR(50)
    , state VARCHAR(20)
    , postal_code VARCHAR (20)
    , preferred_contact_method VARCHAR (20)
    , donor_notes TEXT
    , created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    , updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create programs table
CREATE TABLE programs
(
    program_id SERIAL PRIMARY KEY
    , name VARCHAR(100) NOT NULL
    , description TEXT
    , start_date DATE
    , end_date DATE
    , budget DECIMAL(10, 2)
    , status VARCHAR(20)
    , created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    , updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create donations table
CREATE TABLE donations
(
    donation_id SERIAL PRIMARY KEY
    , donor_id INTEGER REFERENCES donors(donor_id)
    , program_id INTEGER REFERENCES programs(program_id)
    , amount DECIMAL(10,2) NOT NULL
    , donation_date DATE NOT NULL
    , payment_method VARCHAR(50)
    , is_recurring BOOLEAN DEFAULT FALSE
    , notes TEXT
    , created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    , updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert donors
INSERT INTO donors (donor_type, first_name, last_name, organization_name, email, phone, address_line1, city, state, postal_code, preferred_contact_method, donor_notes)
VALUES
('Individual', 'John', 'Doe', NULL, 'john.doe@example.com', '123-456-7890', '123 Elm St', 'Springfield', 'IL', '62701', 'Email', 'Regular donor'),
('Individual', 'Jane', 'Smith', NULL, 'jane.smith@example.com', '234-567-8901', '456 Oak St', 'Springfield', 'IL', '62702', 'Phone', 'Prefers phone contact'),
('Organization', NULL, NULL, 'Helping Hands', 'contact@helpinghands.org', '345-678-9012', '789 Pine St', 'Springfield', 'IL', '62703', 'Email', 'Corporate sponsor'),
('Individual', 'Alice', 'Johnson', NULL, 'alice.johnson@example.com', '456-789-0123', '101 Maple St', 'Springfield', 'IL', '62704', 'Email', 'First-time donor'),
('Individual', 'Bob', 'Brown', NULL, 'bob.brown@example.com', '567-890-1234', '202 Birch St', 'Springfield', 'IL', '62705', 'Email', 'Prefers email contact'),
('Organization', NULL, NULL, 'Good Neighbors', 'info@goodneighbors.org', '678-901-2345', '303 Cedar St', 'Springfield', 'IL', '62706', 'Email', 'Corporate sponsor'),
('Individual', 'Charlie', 'Davis', NULL, 'charlie.davis@example.com', '789-012-3456', '404 Walnut St', 'Springfield', 'IL', '62707', 'Phone', 'Prefers phone contact'),
('Individual', 'Diana', 'Evans', NULL, 'diana.evans@example.com', '890-123-4567', '505 Ash St', 'Springfield', 'IL', '62708', 'Email', 'Regular donor'),
('Organization', NULL, NULL, 'Community Builders', 'support@communitybuilders.org', '901-234-5678', '606 Cherry St', 'Springfield', 'IL', '62709', 'Email', 'Corporate sponsor'),
('Individual', 'Eve', 'Foster', NULL, 'eve.foster@example.com', '012-345-6789', '707 Poplar St', 'Springfield', 'IL', '62710', 'Email', 'First-time donor');

-- Insert programs
INSERT INTO programs (name, description, start_date, end_date, budget, status)
VALUES
('Food Drive', 'Annual food drive for local shelters', '2024-01-01', '2024-12-31', 5000.00, 'Active'),
('School Supplies', 'Providing school supplies to underprivileged children', '2024-02-01', '2024-08-31', 3000.00, 'Active'),
('Health Fair', 'Community health fair with free screenings', '2024-03-01', '2024-03-31', 2000.00, 'Active'),
('Holiday Gifts', 'Holiday gift program for families in need', '2024-11-01', '2024-12-31', 4000.00, 'Active'),
('Job Training', 'Job training and placement services', '2024-04-01', '2024-10-31', 6000.00, 'Active');

-- Insert donations
INSERT INTO donations (donor_id, program_id, amount, donation_date, payment_method, is_recurring, notes)
VALUES
(1, 1, 100.00, '2024-01-15', 'Credit Card', FALSE, 'First donation'),
(2, 2, 200.00, '2024-02-20', 'Credit Card', TRUE, 'Monthly donation'),
(3, 3, 500.00, '2024-03-10', 'Bank Transfer', FALSE, 'Corporate donation'),
(4, 4, 150.00, '2024-11-05', 'Credit Card', FALSE, 'First donation'),
(5, 5, 250.00, '2024-04-15', 'Credit Card', TRUE, 'Monthly donation'),
(6, 1, 1000.00, '2024-01-20', 'Bank Transfer', FALSE, 'Corporate donation'),
(7, 2, 300.00, '2024-02-25', 'Credit Card', FALSE, 'One-time donation'),
(8, 3, 400.00, '2024-03-15', 'Credit Card', TRUE, 'Monthly donation'),
(9, 4, 500.00, '2024-11-10', 'Bank Transfer', FALSE, 'Corporate donation'),
(10, 5, 600.00, '2024-04-20', 'Credit Card', FALSE, 'One-time donation'),
(1, 2, 150.00, '2024-02-10', 'Credit Card', FALSE, 'Second donation'),
(2, 3, 250.00, '2024-03-05', 'Credit Card', TRUE, 'Monthly donation'),
(3, 4, 350.00, '2024-11-15', 'Bank Transfer', FALSE, 'Corporate donation'),
(4, 5, 450.00, '2024-04-25', 'Credit Card', FALSE, 'Second donation'),
(5, 1, 550.00, '2024-01-30', 'Credit Card', TRUE, 'Monthly donation');