%option nounput noinput
%option case-insensitive
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
q[^u\s]*   { printf("%s\n", yytext); }  
[^a-zA-Z]+ { ; }

%%

int yywrap(void) { return 1; }

int main(int argc, char *argv[]) { 
    while (yylex() != 0); 
    return 0; 
}
