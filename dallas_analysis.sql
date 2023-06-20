create database uk;

use uk;

select * from host_dallas_df;
select * from review_dallas_df;
select * from df_dallas_availability;

SELECT 
  CASE WHEN host_is_superhost = 'True' THEN 'Super Host' ELSE 'Normal Host' END AS host_type,
  AVG(host_acceptance_rate) AS acceptance_rate
FROM 
  host_dallas_edf
GROUP BY 
  host_type;
  
  
  
-- within an hour        1686
-- within a few hours     200
-- within a day           135
-- a few days or more      39
SELECT 
  CASE WHEN host_is_superhost = 'True' THEN 'Super Host' ELSE 'Other Host' END AS host_type,
  CASE WHEN host_response_time = 'within an hour' THEN 'super_fast'
	WHEN host_response_time = 'within a few hours' THEN 'fast'
    WHEN host_response_time = 'within a day' THEN 'slow'
  ELSE 'super_slow' END AS response_rate
FROM 
  host_dallas_edf
GROUP BY 
  host_type;

SELECT 
  CASE WHEN host_is_superhost = 'True' THEN 'Super Host' ELSE 'Other Host' END AS host_type,
  avg(CASE WHEN host_has_profile_pic='True' then 1 ELSE 0 END) AS profile_picture_rate
FROM 
  host_dallas_edf
GROUP BY 
  host_type;

SELECT 
  CASE WHEN host_is_superhost = 'True' THEN 'Super Host' ELSE 'Other Host' END AS host_type,
  avg(CASE WHEN host_identity_verified='True' then 1 ELSE 0 END) AS identity_rate
FROM 
  host_dallas_edf
GROUP BY 
  host_type;

select * from review_dallas_df;
use uk;
SELECT
  CASE WHEN host_is_superhost = 'True' THEN 'Super Host' ELSE 'Other Host' END AS host_type,
  SUM(CASE WHEN comments LIKE '%excellent%' or '%great%' THEN 1 ELSE 0 END) AS good_comments,
  SUM(CASE WHEN comments LIKE '%dirty%' or '%bad%' THEN 1 ELSE 0 END) AS bad_comments
FROM 
	review_dallas_df r right join listing_ l on r.id=l.id right join host_dallas_edf h on h.host_id=l.host_id
GROUP BY
  host_type;
select * from host_dellas_df;
SELECT
    CASE
        WHEN host_is_superhost = 'True' THEN 'Super Host'
        ELSE 'Other Host'
    END AS host_type,
    AVG(bedrooms) AS avg_bedrooms,
    AVG(beds) AS avg_beds
FROM host_dallas_edf h left join listing_ l on h.host_id=l.host_id
GROUP BY host_type;


SELECT
    CASE
        WHEN host_is_superhost = 'TRUE' THEN 'Super Host'
        ELSE 'Other Host'
    END AS host_type,
    AVG(host_response_rate) AS avg_response_rate,
    AVG(host_acceptance_rate) AS avg_acceptance_rate,
    AVG(CASE WHEN host_identity_verified = 'TRUE' THEN 1 ELSE 0 END) AS avg_identity_verified,
    AVG(CASE WHEN host_has_profile_pic = 'TRUE' THEN 1 ELSE 0 END) AS avg_has_profile_pic,
    AVG(CASE WHEN host_is_superhost = 'TRUE' THEN review_scores_rating ELSE 0 END) AS avg_superhost_review_score,
    AVG(CASE WHEN host_is_superhost = 'FALSE' THEN review_scores_rating ELSE 0 END) AS avg_other_host_review_score,
    AVG(CASE WHEN host_is_superhost = 'TRUE' THEN host_listings_count ELSE 0 END) AS avg_superhost_listings_count,
    AVG(CASE WHEN host_is_superhost = 'FALSE' THEN host_listings_count ELSE 0 END) AS avg_other_host_listings_count,
    AVG(CASE WHEN host_is_superhost = 'TRUE' THEN review_scores_value ELSE 0 END) AS avg_superhost_reviews_per_month,
    AVG(CASE WHEN host_is_superhost = 'FALSE' THEN review_scores_value ELSE 0 END) AS avg_other_host_reviews_per_month
FROM host_dallas_edf
join listing_
on listing_.host_id=host_dallas_edf.host_id
GROUP BY host_type;