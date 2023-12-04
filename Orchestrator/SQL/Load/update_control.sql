-- Record run
INSERT INTO update_control (last_source_id, last_timestamp)
SELECT
    id,
	times
FROM measurements_delta
ORDER BY id DESC
LIMIT (1);