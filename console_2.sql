-- 1. List all donors and their email addresses
SELECT first_name, last_name, organization_name, email
FROM donors
ORDER BY donor_type, last_name, organization_name;

-- Ensure an index exists on (donor_type, last_name, organization_name) for faster sorting.

-- 2. List programs with budgets over $10,000
SELECT name, budget
FROM programs
WHERE budget > 10000;

-- Add an index on the `budget` column if filtering on it is frequent.

-- 3. Show all donations in descending order by amount
SELECT donor_id, program_id, amount, donation_date
FROM donations
ORDER BY amount DESC;

-- Add an index on the `amount` column for faster sorting.

-- 4. Donors with example.com email
SELECT first_name, last_name, organization_name, email
FROM donors
WHERE email LIKE '%example.com%';

-- Consider a full-text index on the `email` column for faster pattern matching.

-- 5. Programs with "Youth" in name or description
SELECT name, description
FROM programs
WHERE name ILIKE '%Youth%'
   OR description ILIKE '%Youth%';

-- Add a full-text index on `name` and `description` for faster searches.

-- 6. Donations from 2023
SELECT donation_id, donor_id, program_id, amount, donation_date
FROM donations
WHERE donation_date >= '2023-01-01' AND donation_date < '2024-01-01';

-- Replace `EXTRACT(YEAR FROM donation_date)` with a range filter to allow index usage.

-- 7. Total amount donated by each donor
SELECT
    d.donor_id,
    COALESCE(d.first_name || ' ' || d.last_name, d.organization_name) AS donor_name,
    SUM(don.amount) AS total_donated
FROM donors d
LEFT JOIN donations don ON d.donor_id = don.donor_id
GROUP BY d.donor_id, donor_name
ORDER BY total_donated DESC;

-- Ensure indexes exist on `donors.donor_id` and `donations.donor_id`.

-- 8. Program with most total donations
SELECT
    p.program_id,
    p.name,
    COUNT(d.donation_id) AS donation_count,
    SUM(d.amount) AS total_amount
FROM programs p
LEFT JOIN donations d ON p.program_id = d.program_id
GROUP BY p.program_id, p.name
ORDER BY total_amount DESC
LIMIT 1;

-- Ensure indexes exist on `programs.program_id` and `donations.program_id`.

-- 9. Donors with multiple donations
SELECT
    d.donor_id,
    COALESCE(d.first_name || ' ' || d.last_name, d.organization_name) AS donor_name,
    COUNT(don.donation_id) AS donation_count
FROM donors d
JOIN donations don ON d.donor_id = don.donor_id
GROUP BY d.donor_id, donor_name
HAVING COUNT(don.donation_id) > 1
ORDER BY donation_count DESC;

-- Ensure indexes exist on `donations.donor_id`.

-- 10. Program donation report with percentages
WITH program_totals AS (
    SELECT
        p.program_id,
        p.name,
        SUM(d.amount) AS total_amount
    FROM programs p
    LEFT JOIN donations d ON p.program_id = d.program_id
    GROUP BY p.program_id, p.name
),
total_donations AS (
    SELECT SUM(amount) AS grand_total
    FROM donations
)
SELECT
    pt.name,
    pt.total_amount,
    ROUND((pt.total_amount / td.grand_total * 100)::numeric, 2) AS percentage
FROM program_totals pt
CROSS JOIN total_donations td
WHERE pt.total_amount IS NOT NULL
ORDER BY pt.total_amount DESC;

-- Ensure indexes exist on `donations.program_id` and `programs.program_id`.