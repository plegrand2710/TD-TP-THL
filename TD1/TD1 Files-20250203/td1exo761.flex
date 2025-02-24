%option nounput noinput

%{
int car_pos = 0;
%}

%%

\t  { 
    int spaces = 8 - (car_pos % 8);
    printf("%*s", spaces, " ");
    car_pos += spaces;
}

\n  { ECHO; car_pos = 0; }

.   { ECHO; car_pos++; }

%%

int yywrap(void) { return 1; }

int main(int argc, char *argv[]) {
    while (yylex() != 0);
    return 0;
}

