-- Internship Recruiting Dashboard
-- Author: Mohammed Ali | github.com/adnan-swe-dev

-- 1. Full pipeline funnel
SELECT status,
       COUNT(*) AS count
FROM applications
GROUP BY status
ORDER BY CASE status
  WHEN 'None' THEN 1
  WHEN 'Screen' THEN 2
  WHEN 'Interview' THEN 3
  WHEN 'Offer' THEN 4
  WHEN 'Rejected' THEN 5 END;

-- 2. Conversion rate by source
SELECT source,
       COUNT(*) AS apps,
       SUM(CASE WHEN status IN ('Screen','Interview','Offer') THEN 1 ELSE 0 END) AS converted,
       ROUND(100.0 * SUM(CASE WHEN status IN ('Screen','Interview','Offer') THEN 1 ELSE 0 END) / COUNT(*), 1) AS conv_rate_pct
FROM applications
GROUP BY source
ORDER BY conv_rate_pct DESC;

-- 3. Networking vs cold outreach
SELECT network,
       COUNT(*) AS apps,
       SUM(CASE WHEN status IN ('Screen','Interview','Offer') THEN 1 ELSE 0 END) AS converted,
       ROUND(100.0 * SUM(CASE WHEN status IN ('Screen','Interview','Offer') THEN 1 ELSE 0 END) / COUNT(*), 1) AS conv_rate_pct
FROM applications
GROUP BY network;

-- 4. Average response time by company
SELECT company,
       status,
       ROUND(AVG(CAST(days AS REAL)), 1) AS avg_days
FROM applications
WHERE days IS NOT NULL AND days != ''
GROUP BY company
ORDER BY avg_days DESC;

-- 5. Applications by industry
SELECT industry,
       COUNT(*) AS apps,
       SUM(CASE WHEN status IN ('Interview','Offer') THEN 1 ELSE 0 END) AS interviews
FROM applications
GROUP BY industry
ORDER BY interviews DESC;
