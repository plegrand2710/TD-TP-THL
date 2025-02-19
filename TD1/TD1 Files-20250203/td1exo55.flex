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
[a-f]{4} {
    printf("règle 2 : %s\n", yytext);  
}

[a-f0IZSG]+ {
    printf("règle 1 : %s\n", yytext);  
}

[^a-f0IZSG]+ {;}
%%

int yywrap(void) { return 1; }

int main(int argc, char *argv[]) { 
    while (yylex() != 0); 
    return 0; 
}
