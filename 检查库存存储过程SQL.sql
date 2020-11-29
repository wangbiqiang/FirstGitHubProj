CREATE PROCEDURE `pre_flush_store`(
  startTime DATETIME,
	endTime DATETIME,
	roomId1 BIGINT,
	hotelId1 BIGINT)
BEGIN
	DECLARE
			tempTime DATETIME;
	DECLARE
		store1 INT;
	DECLARE
		count1 INT;
		SET tempTime=startTime;
WHILE (
	DATE_FORMAT(tempTime, '%Y-%m-%d') <= DATE_FORMAT(endTime, '%Y-%m-%d')
) DO
	SELECT
		COUNT(id) INTO count1
	FROM
		itrip_hotel_temp_store
	WHERE
		roomId = roomId1
	AND DATE_FORMAT(recordDate, '%Y-%m-%d') = DATE_FORMAT(tempTime, '%Y-%m-%d');
SELECT tempTime;
SELECT roomId1;	
SELECT count1;	
IF (count1=0) THEN
	SELECT
	  store INTO store1
	FROM
		itrip_product_store
	WHERE
		productId = roomId1 AND productType = 1;
SELECT store1;
SELECT roomId1;
INSERT INTO itrip_hotel_temp_store (
	hotelId,
	roomId,
	recordDate,
	store,
	creationDate
)
VALUES
	(
		hotelId1,
		roomId1,
		tempTime,
		store1,
		NOW()
	);
END IF;
SET tempTime=DATE_ADD(tempTime, INTERVAL 1 DAY);
END WHILE;
END;

