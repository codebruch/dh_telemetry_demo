DROP  COLLECTION "VORA"."CAR_TELEMETRY_COLLECTION";
CREATE COLLECTION "VORA"."CAR_TELEMETRY_COLLECTION";
ALTER COLLECTION "VORA"."CAR_TELEMETRY_COLLECTION" ADD DATASOURCE HDFS('hdfs://spark-hdfs-adapter:8020/car_telemetrydata/car_telemetry.json');
LOAD COLLECTION "VORA"."CAR_TELEMETRY_COLLECTION";

drop table "VORA"."CAR_TELEMETRY_ARCHIVE";
CREATE TABLE "VORA"."CAR_TELEMETRY_ARCHIVE" ( speed VARCHAR(32) ,battery VARCHAR(32) ,gear VARCHAR(32) ,testcase VARCHAR(32) , timest VARCHAR(64) ,macaddress VARCHAR(64) )  STORE IN MEMORY;
ALTER TABLE "VORA"."CAR_TELEMETRY_ARCHIVE" ADD DATASOURCE HDFS('hdfs://spark-hdfs-adapter:8020/car_telemetrydata/CarTelemetryStructuredDataExtract.csv')  DELIMITED BY ',';
LOAD TABLE "VORA"."CAR_TELEMETRY_ARCHIVE";


drop table "VORA"."CAR_TELEMETRY_TRAINING";
CREATE TABLE "VORA"."CAR_TELEMETRY_TRAINING" ( speed VARCHAR(32) ,battery VARCHAR(32) ,gear VARCHAR(32) ,testcase VARCHAR(32) , timest VARCHAR(64) ,macaddress VARCHAR(64) )  STORE IN MEMORY;
ALTER TABLE "VORA"."CAR_TELEMETRY_TRAINING" ADD DATASOURCE HDFS('hdfs://spark-hdfs-adapter:8020/car_telemetry_solution/CarTelemetryStructuredTrainingData.csv')  DELIMITED BY ',';
LOAD TABLE "VORA"."CAR_TELEMETRY_TRAINING";




select *  from "VORA"."CAR_TELEMETRY_COLLECTION" where "deviceType"='AnkiCar' 
and "param"='status'
and "_MessageGateway_TimeISO8601" IS NOT MISSING limit 10


select distinct("value.user"), count(*) from "VORA"."CAR_TELEMETRY_COLLECTION" where "deviceType"='AnkiCar' 
and "param"='status'
and "_MessageGateway_TimeISO8601" IS NOT MISSING group by "value.user" 
