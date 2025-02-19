%option nounput noinput
%option case-insensitive
%{
#include "proto-color.h"
#include <stdio.h>
#include <ctype.h>
#include <stdbool.h>

bool contient_z = false;
bool contient_q = false;
bool contient_x = false;

void echo(char *lex_cat) {
    fprintf(stdout, GREEN("[%s:%s]"), lex_cat, yytext);
}

void echonl() {
    fprintf(stdout, RED("[\\n]")"\n");
}
%}

%%
[a-zA-Z]+ {
    contient_z = false;  
    contient_q = false;
    contient_x = false;

    for (int i = 0; yytext[i] != '\0'; i++) {
        if (tolower(yytext[i]) == 'z') {
            contient_z = true;
        }
        if (tolower(yytext[i]) == 'q') {
            contient_q = true;
        }
        if (tolower(yytext[i]) == 'x') {
            contient_x = true;
        }
    }


    if (contient_z && contient_q && contient_x) {
        printf("%s\n", yytext);
    }
}

[^a-zA-Z]+ { ; }

%%

int yywrap(void) { return 1; }

int main(int argc, char *argv[]) { 
    while (yylex() != 0); 
    return 0; 
}
