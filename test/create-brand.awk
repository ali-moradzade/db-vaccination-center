BEGIN{
	FS=","
}
{
	brand = $2"-"$3"-brand"
	printf "Call create_brand('%s', '%s', \n\t'%s', '%s');\n", brand, $1, "3", "30"
}
