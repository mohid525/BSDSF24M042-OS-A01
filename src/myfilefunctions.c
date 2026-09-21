#define _POSIX_C_SOURCE 200809L

#include "../include/myfilefunctions.h"

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int wordCount(FILE* file, int* lines, int* words, int* chars)
{
    int current;
    int inside_word = 0;
    int saw_character = 0;
    int last_character = '\n';

    if (file == NULL || lines == NULL ||
        words == NULL || chars == NULL)
    {
        return -1;
    }

    *lines = 0;
    *words = 0;
    *chars = 0;

    rewind(file);

    while ((current = fgetc(file)) != EOF)
    {
        saw_character = 1;
        last_character = current;
        (*chars)++;

        if (current == '\n')
        {
            (*lines)++;
        }

        if (isspace((unsigned char)current))
        {
            inside_word = 0;
        }
        else if (!inside_word)
        {
            (*words)++;
            inside_word = 1;
        }
    }

    if (ferror(file))
    {
        return -1;
    }

    if (saw_character && last_character != '\n')
    {
        (*lines)++;
    }

    return 0;
}

int mygrep(FILE* fp, const char* search_str, char*** matches)
{
    char* line = NULL;
    size_t capacity = 0;
    char** result = NULL;
    int match_count = 0;

    if (fp == NULL || search_str == NULL || matches == NULL)
    {
        return -1;
    }

    *matches = NULL;
    rewind(fp);

    while (getline(&line, &capacity, fp) != -1)
    {
        if (strstr(line, search_str) != NULL)
        {
            char* copy;
            char** expanded;

            copy = malloc(strlen(line) + 1);

            if (copy == NULL)
            {
                free(line);

                for (int i = 0; i < match_count; i++)
                {
                    free(result[i]);
                }

                free(result);
                return -1;
            }

            strcpy(copy, line);

            expanded = realloc(
                result,
                sizeof(char*) * (match_count + 2)
            );

            if (expanded == NULL)
            {
                free(copy);
                free(line);

                for (int i = 0; i < match_count; i++)
                {
                    free(result[i]);
                }

                free(result);
                return -1;
            }

            result = expanded;
            result[match_count] = copy;
            match_count++;
            result[match_count] = NULL;
        }
    }

    free(line);

    if (ferror(fp))
    {
        for (int i = 0; i < match_count; i++)
        {
            free(result[i]);
        }

        free(result);
        return -1;
    }

    *matches = result;
    return match_count;
}
