%option nounput noinput
%{
#include <stdio.h>
#include <string.h>
#include "proto-color.h"


void echo(char *lex_cat) {
    fprintf(stdout, GREEN("[%s:%s]"), lex_cat, yytext);
}

void echonl() {
    fprintf(stdout, RED("[\\n]")"\n");
}


%}

%%

^[ \t\r\n]*$          ;  

^[^ \t\r\n]+[ \t\r\n]*$ {

    char *line_end = yytext + strlen(yytext) - 1;
    while (line_end >= yytext && (*line_end == ' ' || *line_end == '\t' || *line_end == '\r')) {
        line_end--;  
    }
    *(line_end + 1) = '\0';  
    printf("%s", yytext);   
    echonl();         
}

\n                     { echonl(); }  

%%

int yywrap(void) {
    return 1;
}

int main(int argc, char *argv[]) {
    while (yylex() != 0);
    return 0;
}

