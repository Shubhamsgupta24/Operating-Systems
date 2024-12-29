#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    int fd = open(argv[1], O_RDWR | O_APPEND);
    if (fd == -1) {
        perror("Error opening file");
        return 1;
    }

    // Write 10 bytes at the end of the file
    char data[11] = "abcdefghij";
    if (write(fd, data, 10) == -1) {
        perror("Error writing to file");
        close(fd);
        return 1;
    }

    close(fd);

    return 0;
}

