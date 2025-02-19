%option nounput noinput

%{
#include "proto-color.h"
#include <stdio.h>

void echo(char *lex_cat) {
    fprintf(stdout, GREEN("[%s:%s]"), lex_cat, yytext);
}

void echonl() {
    fprintf(stdout, RED("[\\n]")"\n");
}
%}

%%
[-+=%/]		{ echo("OP"); }
\>|\<		{ echo("CMP");}
[(){},;\[\]]	{ echo("SEP");}
[a-zA-Z][a-zA-Z0-9]*	{ echo("SYMB"); }
[0-9]*		{ echo("NUM"); }
"for"|"do"|"while"		{ echo("KW"); }

%%

int yywrap(void) { return 1; }
int main(int argc, char *argv[]) { while (yylex()!=0) ; return 0; } 