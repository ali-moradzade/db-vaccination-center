BEGIN{
	FS=","
}
{
	printf "Call sign_up('%s', '%s', '%s', \n\t'2000-01-01', 'M', 'N',\n\t'1234567a');\n\n", $1, $2, $3
}
