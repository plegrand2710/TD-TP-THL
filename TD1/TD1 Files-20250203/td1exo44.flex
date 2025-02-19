%option nounput noinput

%{
#include <stdio.h>
#include <ctype.h>  
#include "proto-color.h"

int total_mot = 0;  
int v_mot = 0;    
int ponctuation = 0;
int ligne = 0;    


void echo(char *lex_cat) {
    fprintf(stdout, GREEN("[%s:%s]"), lex_cat, yytext);
}


void echonl() {
    fprintf(stdout, RED("[\\n]") "\n");
}
%}


espace        [ \t\n\r\f\v]
ponctuation   [.,!?;:(){}[]'\"`-]

%%
{espace}+ {
    if (yytext[0] == '\n') {
        ligne++; 
    }
}

{ponctuation}+ {
    ponctuation++;  
}

[a-zA-Z]+ {
    total_mot++; 
    if (tolower(yytext[0]) == 'v') {
        v_mot++; 
    }
}

. {;}

%%

int yywrap(void) {
    return 1;
}

int main(int argc, char *argv[]) {
    ligne = 1;  
    
    while (yylex() != 0);

    printf("Nombre total de mots : %d\n", total_mot);
    printf("Nombre de mots commençant par 'V' : %d\n", v_mot);
    printf("Nombre de caractères de ponctuation : %d\n", ponctuation);
    printf("Nombre de lignes : %d\n", ligne);

    return 0;
}

