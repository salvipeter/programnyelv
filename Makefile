all: programnyelv.html

programnyelv.html: programnyelv.md
	echo "<!DOCTYPE html>\n<head>\n<link rel='stylesheet' type='text/css' href='programnyelv.css' media='all'/>\n<meta http-equiv='Content-Type' content='text/html;charset=utf8'/>\n<title>Egy programnyelv felépítése</title>\n</head>\n<body>\n" > $@
	markdown $< >> $@
	echo "</body>\n</html>\n" >> $@
