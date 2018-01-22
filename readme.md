CLEAN DEMO
Prep:
- Zeppelin cartelemetrydata bash in Zeppelin demo_setup
- Zeppelin s4materials bash in Zeppelin demo_setup
Doing:
- Vora Tools: CAR_TELEMETRY_COLLECTION creation in Vora mit carTelemetrydata json source
  Pipeline Modeler: Start TelemetryDataRefinery --> created CSV auf HDFS
	oder: 
  Modeler:    Run task DH_Demo_Prep --> TelemetryJSON2CSV
- Modeler:    Run Task DH_Demo_Prep --> EnrichedMaterials
  Modeler:    Check DH_Demo_prep DataSet MATERIALS_ENRICHED Data preview
- Vora Tools: DEMO_MAT_ENR (roh) manuell anlegen (check structure) / SQL Editor 
- Modeler:    Run DH_Demo_prep --> DEMO_MAT_VORA
- Modeler:    Run DH_Demo_prep --> TelemetryDistinctMac
Next Steps: 
- Somewhere:  Enrich TelemetryDistinctMac with Outliner Materials
- Modeler:    Join Vora DEMO_MAT_ENR and TelemetryDistinctMac ....
