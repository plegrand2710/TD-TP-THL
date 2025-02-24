#include <ctype.h>
#include <stdio.h>
#include <string.h>

// Définition des catégories lexicales
#define WORD 1001
#define ART 1002
#define TRANS_VRB 1003
#define COMM_NOUN 1004
#define PROP_NOUN 1005

// Fonction pour classer un mot dans une catégorie
int classify_word(const char *word) {
    // Articles
    if (strcmp(word, "a") == 0 || strcmp(word, "an") == 0 || strcmp(word, "the") == 0) {
        return ART;
    }
    // Verbes transitifs
    else if (strcmp(word, "cut") == 0 || strcmp(word, "cuts") == 0) {
        return TRANS_VRB;
    }
    // Noms communs
    else if (strcmp(word, "bill") == 0 || strcmp(word, "bills") == 0) {
        return COMM_NOUN;
    }
    // Noms propres
    else if (strcmp(word, "Bell") == 0 || strcmp(word, "Verizon") == 0) {
        return PROP_NOUN;
    }
    // Autres mots
    else {
        return WORD;
    }
}

// Analyseur lexical
int yylex() {
    char yytext[256];
    int yylen = 0;
    int c;

    // Ignorer les espaces
    while ((c = getchar()) == ' ');

    // Fin de fichier
    if (c == EOF) {
        return c;
    }

    // Retour à la ligne
    if (c == '\n') {
        fprintf(stderr, "[\\n]%c", c);
        return c;
    }

    // Ponctuation
    if (c == '.') {
        fprintf(stderr, "[%c]", c);
        return c;
    }

    // Lire un mot
    while (isalpha(c)) {
        yytext[yylen++] = c;
        c = getchar();
    }
    if (c != EOF) ungetc(c, stdin);
    yytext[yylen] = '\0';

    // Classifier le mot
    int token = classify_word(yytext);
    switch (token) {
        case ART:
            fprintf(stderr, "[ART: %s]", yytext);
            break;
        case TRANS_VRB:
            fprintf(stderr, "[TRANS_VRB: %s]", yytext);
            break;
        case COMM_NOUN:
            fprintf(stderr, "[COMM_NOUN: %s]", yytext);
            break;
        case PROP_NOUN:
            fprintf(stderr, "[PROP_NOUN: %s]", yytext);
            break;
        default:
            fprintf(stderr, "[WORD: %s]", yytext);
    }

    return token;
}

// Fonction principale
int main(int argc, char *argv[]) {
    while (yylex() != EOF);
    return 0;
}

