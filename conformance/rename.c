#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <oldname> <newname>\n", argv[0]);
        return 1;
    }

    if (rename(argv[1], argv[2]) == -1) {
        perror("Error renaming file");
        return 1;
    }

    return 0;
}

