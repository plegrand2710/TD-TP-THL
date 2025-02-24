%option nounput noinput
%{
#include <stdio.h>

%}

%%

\t {
    printf("^I");
}

[\x00-\x08\x0B\x0C\x0E-\x1F\x7F] {
    printf("^%c", yytext[0] + 64);
}

\n {
    printf("\n");
}

. {
    printf("%s", yytext);
}

%%

int yywrap(void) {
    return 1;
}

int main(int argc, char *argv[]) {
    yylex();
    return 0;
}

