/^CREATE/ {
	print "String param = String.format(" 
	printf "\t\"()\",\n"

	procedure = $3
	procedure = substr(procedure, 0, length(procedure) - 1)
}
/^[ \t]/ {
	printf "\t%s,\n", $1
}
/^)/ {
	print ");"
	print "String query = \"call", procedure"\"","+ param;"
}
