%option nounput noinput
%{
#include <stdio.h>

int line_number = 1;
int non_blank_line_number = 1;

void print_numbers(int full, int non_blank) {
    printf("%6d\t%6s\t", full, non_blank ? " " : "");
}
%}

%%

^[ \t]*\n {
    print_numbers(line_number++, 0);
    printf("%s", yytext);
}

^.*\n {
    print_numbers(line_number++, non_blank_line_number++);
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

