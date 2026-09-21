#include "../include/mystrfunctions.h"

int mystrlen(const char* s)
{
    int length = 0;

    while (*s != '\0')
    {
        length++;
        s++;
    }

    return length;
}

int mystrcpy(char* dest, const char* src)
{
    int i = 0;

    while (src[i] != '\0')
    {
        dest[i] = src[i];
        i++;
    }

    dest[i] = '\0';

    return 0;
}

int mystrncpy(char* dest, const char* src, int n)
{
    int i = 0;

    while (i < n && src[i] != '\0')
    {
        dest[i] = src[i];
        i++;
    }

    while (i < n)
    {
        dest[i] = '\0';
        i++;
    }

    return 0;
}

int mystrcat(char* dest, const char* src)
{
    int dest_length = 0;
    int i = 0;

    while (dest[dest_length] != '\0')
    {
        dest_length++;
    }

    while (src[i] != '\0')
    {
        dest[dest_length + i] = src[i];
        i++;
    }

    dest[dest_length + i] = '\0';

    return 0;
}
