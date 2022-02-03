BEGIN {
	FS=","
}
{
	center_name = $3"-vacc-center"
	printf "call create_vaccination_center('%s', '%s', \n\t'%s');\n", center_name, $1, "address"
}
