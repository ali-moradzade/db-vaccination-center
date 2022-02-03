BEGIN{
	FS=","
}
{
	printf "Call sign_in_as_doctor('%s', '%s');\n", $1, $4
}
