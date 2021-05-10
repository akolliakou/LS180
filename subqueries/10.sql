-- Our subquery-based solution:

-- SELECT MAX(bid_counts.count) FROM
--   (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;
-- was actually faster than the simpler equivalent without subqueries:

-- SELECT COUNT(bidder_id) AS max_bid FROM bids
--   GROUP BY bidder_id
--   ORDER BY max_bid DESC
--   LIMIT 1;
-- In this exercise, we will demonstrate this fact.

-- Run EXPLAIN ANALYZE on the two statements above. Compare the planning time, 
-- execution time, and the total time required to run these two statements. 
-- Also compare the total "costs". Which statement is more efficient and why?

EXPLAIN ANALYZE SELECT MAX(bid_counts.count) FROM
(SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;


-- Subquery
--                                                   QUERY PLAN                                                   
-- ---------------------------------------------------------------------------------------------------------------
--  Aggregate  (cost=37.15..37.16 rows=1 width=8) (actual time=0.041..0.042 rows=1 loops=1)
--    ->  HashAggregate  (cost=32.65..34.65 rows=200 width=12) (actual time=0.037..0.039 rows=6 loops=1)
--          Group Key: bids.bidder_id
--          Batches: 1  Memory Usage: 40kB
--          ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.017..0.020 rows=26 loops=1)
--  Planning Time: 1.355 ms
--  Execution Time: 0.127 ms
-- (7 rows)

EXPLAIN ANALYZE SELECT COUNT(bidder_id) AS max_bid FROM bids
GROUP BY bidder_id
ORDER BY max_bid DESC
LIMIT 1;

-- ORDER BY and LIMIT
--                                                      QUERY PLAN                                                      
-- ---------------------------------------------------------------------------------------------------------------------
--  Limit  (cost=35.65..35.65 rows=1 width=12) (actual time=0.112..0.114 rows=1 loops=1)
--    ->  Sort  (cost=35.65..36.15 rows=200 width=12) (actual time=0.110..0.111 rows=1 loops=1)
--          Sort Key: (count(bidder_id)) DESC
--          Sort Method: top-N heapsort  Memory: 25kB
--          ->  HashAggregate  (cost=32.65..34.65 rows=200 width=12) (actual time=0.052..0.056 rows=6 loops=1)
--                Group Key: bidder_id
--                Batches: 1  Memory Usage: 40kB
--                ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.015..0.021 rows=26 loops=1)
--  Planning Time: 0.178 ms
--  Execution Time: 0.221 ms
-- (10 rows)



