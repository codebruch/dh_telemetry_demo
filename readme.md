CLEAN DEMO
Prep:
- Zeppelin cartelemetrydata bash in Zeppelin demo_setup
- Zeppelin s4materials bash in Zeppelin demo_setup
Doing:
- Vora Tools: CAR_TELEMETRY_COLLECTION creation in Vora mit carTelemetrydata json source
  Pipeline Modeler: Start TelemetryDataRefinery --> created CSV auf HDFS
  
	oder: 
	
  Modeler:    Run task DH_Demo_Prep --> TelemetryJSON2CSV
  Hana Studio:Create Vora table of Telemetry Data
  	      Create Virtual Table  	
- Modeler:    Run Task DH_Demo_Prep --> EnrichedMaterials
  Modeler:    Check DH_Demo_prep DataSet MATERIALS_ENRICHED Data preview        
- Vora Tools: DEMO_MAT_ENR (roh) manuell anlegen (check structure) / SQL Editor 
- Modeler:    Run DH_Demo_prep --> DEMO_MAT_VORA
- Modeler:    Run DH_Demo_prep --> TelemetryDistinctMac

Next Steps: 

- Hana Studio:Create Virtual Table for DEMO MAT VORA
- Vora Tools: Create Relational Table with Materials and Mac
- Hana Studio:Create Virtual Table with Materials and Mac
- Modeler:    Join Virtual Tables DEMO MAT VORA + telemetry Data 
- Somewhere:  Enrich TelemetryDistinctMac with Nice Materials
- ?? View / Join / ?:    Join DEMO_MAT_ENR and TelemetryDistinctMac ....
