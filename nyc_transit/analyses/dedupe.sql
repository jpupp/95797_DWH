SELECT * FROM {{ref('events')}}
-- Keeping only the rows with the latest 'insert_timestamp' for each 'event_id'
qualify row_number() over (partition by event_id order by insert_timestamp desc)= 1;