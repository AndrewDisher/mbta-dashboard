export function labelFormat(params) {
  var myValue = Math.round(+params.value[0] * 10) / 10;
  var formattedValue = `${myValue.toLocaleString('en-US')}`;
  return (formattedValue);
}

export function barTooltip(params) {
  var tooltip = "<strong style = 'color: #28bf46;'>" + `${params.value[1]}` + "</strong>" + "<br>" +
  "<strong style = 'color: #28bf46;' >" + `${params.name}%` + "</strong>" + " of all Average Weekday Boardings";
  return (tooltip);
}
