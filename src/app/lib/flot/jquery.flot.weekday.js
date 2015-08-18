dayOfWeek = ["Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"];
lastDay = "";

weekday = function weekday(val, axis) {
	day = dayOfWeek[new Date(val).getDay()];
	if (day == lastDay){
		return '';
	}
	else {
		lastDay = day;
		return day;
	}
}

module.exports.weekday = weekday
