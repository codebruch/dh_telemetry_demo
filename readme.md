CLEAN DEMO
Prep:
- Zeppelin: 
	cartelemetrydata bash in Zeppelin demo_setup 
	(s4materials bash in Zeppelin demo_setup) 
	macmat bash in Zeppelin (aus CSV TODO) 
Doing:
- Modeler: 
	Create / Execute Task A_ConvertTelemetryData CSV with Pipeline Flowgraph 
- Vora Tools: 
	Create Collection A_VORA_CAR_TELEMETRY_ARCHIVE creation in Vora mit carTelemetrydata json source (Just for Display)
- Hana Studio: 
	Create Virtual Table A_HANA_CAR_TELEMETRY_ARCHIVE with view on CAR_TELEMETRY_ARCHIVE in Vora
- Modeler: 
	Create Dataset B_HANA_MAT_BASIC
	Create Dataset B_HANA_MAT_BEW
	Create Dataset B_HANA_MAT_TEXT
	Create Dataset B_HANA_MAT_BASIC
	Create Dataset B_HDFS_MAT_BASIC
	Create Dataset B_HDFS_MAT_BEW
	Create Dataset B_HDFS_MAT_TEXT
	Create Dataset B_HDFS_MAT_BASIC
	Create Dataset C_HDFS_MAC_MAT (aus CSV TODO) 
- Modeler:
	Create Dataset C_HDFS_MAT_ENRICH (For Join all above)
  	Create / Run Task C_MAT_ENRICH
	

- Vora Tools:  Create RElTab C_VORA_MAT_ENRICH  
- Hana Studio: Create VirtTab C_HANA_MAT_ENRICH  

- XS Classic:  


