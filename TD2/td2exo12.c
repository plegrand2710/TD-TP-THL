#include <stdio.h>
#include <string.h>
#include <ctype.h>

void classify_word(const char *word) {
    if (strcmp(word, "a") == 0 || strcmp(word, "an") == 0 || strcmp(word, "the") == 0) {
        printf("ART: %s\n", word);
    } else if (strcmp(word, "cut") == 0 || strcmp(word, "cuts") == 0) {
        printf("TRANS_VRB: %s\n", word);
    } else if (strcmp(word, "bill") == 0 || strcmp(word, "bills") == 0) {
        printf("COMM_NOUN: %s\n", word);
    } else if (strcmp(word, "Bell") == 0 || strcmp(word, "Verizon") == 0) {
        printf("PROP_NOUN: %s\n", word);
    } else {
        printf("UNKNOWN: %s\n", word);
    }
}

int main() {
    char c;
    char word[256];
    int index = 0;

    while ((c = getchar()) != EOF) {
        if (isalpha(c)) {
            word[index++] = c;
        } else {
            if (index > 0) {
                word[index] = '\0';
                classify_word(word);
                index = 0;
            }

            if (c == '.') {
                printf("PONCT: .\n");
            } else if (c == '\n') {
                printf("NEWLINE\n");
            }
        }
    }

    // Traiter le dernier mot si le fichier ne se termine pas par un espace ou un saut de ligne
    if (index > 0) {
        word[index] = '\0';
        classify_word(word);
    }

    return 0;
}

