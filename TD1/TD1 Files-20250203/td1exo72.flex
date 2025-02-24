%option nounput noinput
%{
#include <stdio.h>
#include <string.h>
#include "proto-color.h"

int empty_line_seen = 0;
%}

%%

(\\n[ \\t\\r]*)+\\n  { printf("\\n"); }

^[^ \\t\\r\\n]+[ \\t\\r\\n]*$ {
    empty_line_seen = 0;
    char *line_end = yytext + strlen(yytext) - 1;
    *(strpbrk(yytext, " \t\r") ? strpbrk(yytext, " \t\r") : line_end + 1) = '\0';
    printf("%s\\n", yytext);
}

\\n { }

%%

int yywrap(void) {
    return 1;
}

int main(int argc, char *argv[]) {
    yylex();
    return 0;
}



