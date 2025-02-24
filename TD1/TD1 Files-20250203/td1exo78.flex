%option nounput noinput

%{
#include <stdio.h>

char *newline_format = "\n"; // Par défaut, mode Unix
%}

%%

\n { printf("%s", newline_format); }

\r { printf("%s", newline_format); }

\r\n { printf("%s", newline_format); }

. { printf("%s", yytext); }

%%

int yywrap(void) {
    return 1;
}

int main(int argc, char *argv[]) {
    if (argc > 1) {
        if (strcmp(argv[1], "unix") == 0) {
            newline_format = "\n";
        } else if (strcmp(argv[1], "mac") == 0) {
            newline_format = "\r";
        } else if (strcmp(argv[1], "dos") == 0) {
            newline_format = "\r\n";
        } else {
            fprintf(stderr, "Usage: %s [unix|mac|dos]\n", argv[0]);
            return 1;
        }
    }

    yylex();
    return 0;
}

