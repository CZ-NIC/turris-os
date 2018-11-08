#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <libintl.h>
#include <locale.h>

int main(int argc, char **argv) {
	int c;
	int translating = 0;
	int verbose = 0;
	if((argc > 1) && (strcmp(argv[1], "-v")==0))
		verbose = 1;
	const char *txtdir = "/usr/share/locale/";
	const char *txtdom = NULL;
	unsigned char last_c = 0;
	char* buffer = NULL;
	int buf_len = 0, i = 0;
	setlocale(LC_ALL, "");
	if(getenv("TEXTDOMAIN") != NULL) {
		asprintf(&txtdom, "%s", getenv("TEXTDOMAIN"));
	}
	if(getenv("TEXTDOMAINDIR") != NULL) {
		asprintf(&txtdir, "%s", getenv("TEXTDOMAINDIR"));
	}
	if(getenv("GETTEXT_DOMAIN") != NULL) {
		asprintf(&txtdom, "%s", getenv("GETTEXT_DOMAIN"));
	}
	if(verbose && txtdom)
		printf("Setting text domain to '%s' and domain dir to '%s'\n", txtdom, txtdir);
	textdomain(txtdom);
	bindtextdomain(txtdom, txtdir);
	if(verbose)
		printf("Text domain set to '%s'\n", textdomain(NULL));
	while((c=getchar()) != EOF) {
		if(translating) {
			if((c == ')') && (last_c != '\\') ) {
				if(i > 0) {
					buffer[i] = 0;
					printf("%s", gettext(buffer));
				}
				translating = 0;
				last_c = 0;
				i = 0;
			} else {
				if(i >= buf_len) {
					buf_len = buf_len + 4094;
					buffer = realloc(buffer, buf_len + 3);
				}
				if((c != '\\') || (last_c == '\\')) {
					buffer[i] = c;
					i++;
				}
				last_c = c;
			}
		} else {
			if(last_c == '_') {
				if (c == '(') {
					translating = 1;
				} else {
					printf("_%c", c);
					last_c = c;
				}
			} else {
				if(c == '_') {
					last_c = '_';
				} else {
					printf("%c", c);
				}
			}
		}
	}
	return 0;
}
