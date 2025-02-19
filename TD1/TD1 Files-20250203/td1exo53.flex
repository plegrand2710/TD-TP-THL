%option nounput noinput
%option case-insensitive
%{
#include "proto-color.h"
#include <stdio.h>
#include <ctype.h>
#include <stdbool.h>

bool contient_z = false;
bool contient_q = false;

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
    int z_count = 0;
    int q_count = 0;

    for (int i = 0; yytext[i] != '\0'; i++) {
        if (tolower(yytext[i]) == 'z') {
            z_count++;
        }
        if (tolower(yytext[i]) == 'q') {
            q_count++;
        }
    }

    if (z_count == 1 && q_count == 1) {
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
