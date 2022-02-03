/^CREATE/ {
	print "public static void ", $3
}
/^[ \t]/ {
	print "\tString", $1","
}
/^)/ {
	print ")"
	print "{}"
}
