#include <stdio.h>
#include <stdlib.h>
#include <libintl.h>
#include <locale.h>

int main(void) {
	int c;
	int translating = 0;
	const char *txtdir = "/usr/share/locale/";
	const char *txtdom = getenv("TEXTDOMAIN");
	const char *tmp = NULL;
	unsigned char last_c = 0;
	char* buffer = NULL;
	int buf_len = 0, i = 0;
	setlocale(LC_ALL, "");
	tmp = getenv("TEXTDOMAINDIR");
	if(tmp != NULL) {
		txtdir = tmp;
	}
	tmp = getenv("GETTEXT_DOMAIN");
	if(tmp != NULL) {
		txtdom = tmp;
	}
	
	bindtextdomain(txtdom, txtdir);
	textdomain(txtdom);
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
