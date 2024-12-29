#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    int fd = open(argv[1], O_RDONLY);
    if (fd == -1) {
        perror("Error opening file");
        return 1;
    }

    // Seek to byte number 5
    if (lseek(fd, 5, SEEK_SET) == -1) {
        perror("Error seeking file");
        close(fd);
        return 1;
    }

    // Read 6 bytes
    char data[7];
    if (read(fd, data, 6) == -1) {
        perror("Error reading from file");
        close(fd);
        return 1;
    }
    data[6] = '\0'; // Null-terminate string
    // printf("%s\n", data);
    
    close(fd);

    return 0;
}

