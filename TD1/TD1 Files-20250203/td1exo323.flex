%option nounput noinput

%{
#include <stdio.h>
#include "proto-color.h"

int level = 0;
void echo(char *lex_cat) {
    fprintf(stdout, GREEN("[%s:%s]"), lex_cat, yytext);
}

void echonl() {
    fprintf(stdout, RED("[\\n]")"\n");
}
%}

%x COMMENT

%%
"/*"	{BEGIN(COMMENT);
	level++;
	SET_COLOR(level);
	<COMMENT>"/*" {
		level++;
		SET_COLOR(level);
		ECHO;}
		<COMMENT>"*/" {
			level--;
			ECHO;
			SET_COLOR(level);
			if(level==0) BEGIN(INITIAL);
		}
	<COMMENT>./\n ECHO;
	./\n ECHO;

%%

int yywrap(void) { return 1; }

int main(int argc, char *argv[]) { 
    while (yylex() != 0); 
    return 0; 
}
