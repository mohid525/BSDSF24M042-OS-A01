#include <stdio.h>
#include <stdlib.h>

#include "../include/mystrfunctions.h"
#include "../include/myfilefunctions.h"

static void free_matches(char **matches, int count)
{
    for (int i = 0; i < count; i++)
    {
        free(matches[i]);
    }

    free(matches);
}

int main(void)
{
    char destination[100] = "Hello";
    char copied[100];

    int lines;
    int words;
    int chars;

    printf("--- Testing String Functions ---\n");

    printf("Length: %d\n", mystrlen("Operating System"));

    mystrcpy(copied, "Linux");
    printf("Copied string: %s\n", copied);

    mystrncpy(copied, "Assembly", 8);
    copied[8] = '\0';
    printf("Copied with limit: %s\n", copied);

    mystrcat(destination, " Linux");
    printf("Concatenated string: %s\n", destination);

    printf("\n--- Testing File Functions ---\n");

    const char *data_path = "test.txt";
    FILE *file = fopen(data_path, "r");

    if (file == NULL)
    {
        data_path = "/usr/local/share/libmyutils/test.txt";
        file = fopen(data_path, "r");
    }

    if (file == NULL)
    {
        perror("fopen");
        return 1;
    }

    if (wordCount(file, &lines, &words, &chars) == -1)
    {
        printf("wordCount failed\n");
        fclose(file);
        return 1;
    }

    printf("Lines: %d\n", lines);
    printf("Words: %d\n", words);
    printf("Characters: %d\n", chars);

    char **matches = NULL;

    int match_count = mygrep(file, "Linux", &matches);

    if (match_count == -1)
    {
        printf("mygrep failed\n");
        fclose(file);
        return 1;
    }

    printf("\nMatching lines: %d\n", match_count);

    for (int i = 0; i < match_count; i++)
    {
        printf("%s", matches[i]);
    }

    free_matches(matches, match_count);
    fclose(file);

    return 0;
}
