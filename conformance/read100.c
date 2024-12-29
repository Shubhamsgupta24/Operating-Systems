#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <filename> <data>\n", argv[0]);
        return 1;
    }

    // Extract filename and data from arguments
    char *filename = argv[1];
    char *data = argv[2];
    int data_len = strlen(data);

    int fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd == -1) {
        perror("Error opening file");
        return 1;
    }

    // Write data to the file
    if (write(fd, data, data_len) != data_len) {
        perror("Error writing to file");
        close(fd);
        return 1;
    }

    close(fd);

    return 0;
}

