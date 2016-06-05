function displayServiceInfo(serviceName) {
	console.log('displayServiceInfo', serviceName);
	$('#detailed_info').text("Detailed info for: " + serviceName);

	$.get("/admin/consul/service?name=" + serviceName, function (data) {
		$('#detailed_info').text("Detailed info for: " + serviceName + "\n\n" + JSON.stringify(data, null, 2));
	});
}

function displayHealthInfo(checkId) {
	console.log('health', checkId, healthStates);
	var info = '', healthState;
	for (var i=0 ; i<healthStates.length ; i++) {
		healthState = healthStates[i];
		console.log("A", healthState, healthState.CheckID);

		if (healthState.CheckID == checkId) {
			console.warn("FF");
			info = healthState;
		} else {
			console.error("NOT EQUAL", healthState.CheckID, checkId);
		}
	}
	var output = "Name: " + info.Name + "\n\nOutput: " + info.Output + "\n\nInfo: " + JSON.stringify(info);
	$('#detailed_info').text(output);
}
