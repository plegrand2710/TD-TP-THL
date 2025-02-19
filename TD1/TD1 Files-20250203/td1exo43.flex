%option nounput noinput

%{
#include <stdio.h>
#include "proto-color.h"

void echo(char *lex_cat) {
    fprintf(stdout, GREEN("[%s:%s]"), lex_cat, yytext);
}

void echonl() {
    fprintf(stdout, RED("[\\n]")"\n");
}
%}

espace    [ \t\n\r\f\v]
ponctuation    [.,!?;:(){}[]'\"`]

%%
{espace}+

{ponctuation}+   

[a-zA-Z]+      { printf("%c", tolower(yytext[0])); }  

.      €                 ;  

%%

int yywrap(void) { return 1; }

int main(int argc, char *argv[]) { 
    while (yylex() != 0); 
    return 0; 
}
