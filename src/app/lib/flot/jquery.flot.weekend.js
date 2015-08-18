weekendAreas = function weekendAreas(axes) {

	var markings = [],
		d = new Date(axes.xaxis.min);

	// go to the first Saturday

	d.setUTCDate(d.getUTCDate() - ((d.getUTCDay() + 1) % 7))
	d.setUTCSeconds(0);
	d.setUTCMinutes(0);
	d.setUTCHours(0);

	var i = d.getTime();

	// when we don't set yaxis, the rectangle automatically
	// extends to infinity upwards and downwards

	do {
		markings.push({ xaxis: { from: i, to: i + 2 * 24 * 60 * 60 * 1000 }, color: '#f9f9f9' });
		i += 7 * 24 * 60 * 60 * 1000;
	} while (i < axes.xaxis.max);

	return markings;
}

module.exports.weekendAreas = weekendAreas;
