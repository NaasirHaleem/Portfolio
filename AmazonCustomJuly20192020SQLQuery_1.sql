-- Select * From [AmazonCustomTransaction07162019-07152020]

UPDATE [AmazonCustomTransaction07162019-07152020]

SET date_time = LEFT(date_time,12)

Where settlement_id > 1

Select * From [AmazonCustomTransaction07162019-07152020]