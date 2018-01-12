sap.ui.define([
	"sap/ui/core/mvc/Controller",
	"sap/ui/model/json/JSONModel",
	"sap/m/MessageBox"
], function(Controller, JSONModel, MessageBox) {
	"use strict";

	return Controller.extend("BitcoinOrderbook.controller.Main", {
		onInit: function() {
			//var oView = this.getView();
			var oPage = this.getView().byId("page");
			var model = new JSONModel();
			this.getView().setModel(model);

			//Popover ist das Fenster mit den Infos wenn man ein Element aus dem Diagramm auswählt https://sapui5.hana.ondemand.com/#/api/sap.viz.ui5.controls.Popover
			//In oVizFrame werden die Paramater für das Popover gesetzt
			var oVizFrame = new sap.viz.ui5.controls.VizFrame({
				height: "400px",
				width: "100%",
				vizType: "stacked_bar",
				uiConfig: {
					applicationSet: "fiori"
				}
			});
			var oPopover = new sap.viz.ui5.controls.Popover({});
			oPopover.connect(oVizFrame.getVizUid());
			oPage.addContent(oVizFrame);
			var self = this;
			this.onAPI();
			setInterval(function() {
				self.onAPI();
			}, 10000);
		},

		onAPI: function() {
			var self = this;
			$.ajax({
					type: 'GET',
					url: "/bitfinex",
					async: false
				}).done(function(results) {
					//Stellt die Daten der API in der Konsole des Browser dar
					console.log(results);
					
					//bids darstellen 
					self.getView().getModel().setProperty("/bids", results.bids);

					//asks darstellen
					self.getView().getModel().setProperty("/asks", results.asks);
					
					//Kurs Meldungen
					var aResults = results.asks;
					var bResults = results.bids;

					for (var i = 0; i < bResults.length; i++) {//Gehe die Schleife solange durch wie das Array bResults Elemente hat
						if (bResults[i].price < 15000 && bCount == false) { //Wenn der Wert an der Stelle i vom Array bResults[].price < 15000 ist dann ...
							setTimeout(function(){self.onAlert();}, 1000);
						}
					}
					//if (bResults === 13950) {
					//	self.onMessage();
					//}

				})
				.fail(function(err) {
					if (err !== undefined) {
						var oErrorResponse = $.parseJSON(err.responseText);
						sap.m.MessageToast.show(oErrorResponse.message, {
							duration: 6000
						});
					} else {
						sap.m.MessageToast.show("Unknown error!");
					}
				});
		},
		
		onAlert: function(bCount) {
			var bCompact = !!this.getView().$().closest(".sapUiSizeCompact").length;
			bCount = true;
			MessageBox.alert(
				"Kurs niedrig",
				{
					styleClass: bCompact ? "sapUiSizeCompact" : ""
				}
			);
			return bCount;
		}
	});
});