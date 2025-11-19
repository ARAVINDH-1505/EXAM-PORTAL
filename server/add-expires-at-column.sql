-- Add missing expires_at column to sessions table
USE Exam_DB_Cursor;

-- Add the expires_at column (will fail if column already exists, which is fine)
ALTER TABLE `sessions` 
ADD COLUMN `expires_at` DATETIME NOT NULL AFTER `started_at`;

-- Verify the column was added
DESCRIBE `sessions`;

