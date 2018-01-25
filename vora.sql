DROP  COLLECTION "VORA"."CAR_TELEMETRY_COLLECTION";
CREATE COLLECTION "VORA"."CAR_TELEMETRY_COLLECTION";
ALTER COLLECTION "VORA"."CAR_TELEMETRY_COLLECTION" ADD DATASOURCE HDFS('hdfs://spark-hdfs-adapter:8020/car_telemetrydata/car_telemetry.json');
LOAD COLLECTION "VORA"."CAR_TELEMETRY_COLLECTION";

CREATE TABLE "VORA"."CAR_TELEMETRY_ARCHIVE" ( speed INTEGER ,battery INTEGER ,gear INTEGER ,usern VARCHAR(64) ,timest VARCHAR(512) ,macaddress VARCHAR(64) )  STORE IN MEMORY