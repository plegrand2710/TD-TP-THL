%option nounput noinput
%{
#include <stdio.h>

int current_position = 0;

%}

%%

^[^\t\n]{0,7}\t  { printf("%*s", 8 - (current_position % 8), " "); current_position = 8; }


\n {
    printf("\n");
    current_position = 0;
}

. {
    printf("%s", yytext);
    current_position++;
}

%%

int yywrap(void) {
    return 1;
}

int main(int argc, char *argv[]) {
    yylex();
    return 0;
}

