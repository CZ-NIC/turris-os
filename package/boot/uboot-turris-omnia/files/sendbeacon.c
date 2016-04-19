/*
 This program sends "beacon" to stop boot of Marvell Armada 385
 so it waits for kwboot to load up U-Boot.

 Copyright (C) 2016 CZ.NIC

 Procedure:
   1) Connect the serial line to the router
   2) Run the program.
   3) Power up the router within 5 sec.
   4) Wait for the program to finish and run kwboot ... to load up U-Boot.
*/

#include <errno.h>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>

#define error_message(args...) fprintf(stderr, args)

int set_interface_attribs(int fd, int speed, int parity)
{
	struct termios tty;
	memset(&tty, 0, sizeof tty);
	if(tcgetattr(fd, &tty) != 0) {
		error_message("error %d from tcgetattr", errno);
		return -1;
	}

	cfsetospeed(&tty, speed);
	cfsetispeed(&tty, speed);

	tty.c_cflag = (tty.c_cflag & ~CSIZE) | CS8;     // 8-bit chars
	tty.c_lflag = 0;
	tty.c_oflag = 0;
	tty.c_cc[VMIN]  = 0;
	tty.c_cc[VTIME] = 5;
	tty.c_cflag |= (CLOCAL | CREAD);
	tty.c_cflag &= ~(PARENB | PARODD);
	tty.c_cflag |= parity;
	tty.c_cflag &= ~CSTOPB;
	tty.c_cflag &= ~CRTSCTS;

	if(tcsetattr(fd, TCSANOW, &tty) != 0) {
		error_message("error %d from tcsetattr", errno);
		return -1;
	}
	return 0;
}

void set_blocking(int fd, int block)
{
	struct termios tty;
	memset(&tty, 0, sizeof tty);
	if(tcgetattr(fd, &tty) != 0) {
		error_message("error %d from tggetattr", errno);
		return;
	}

	tty.c_cc[VMIN] = block ? 1 : 0;
	tty.c_cc[VTIME] = 5;

	if(tcsetattr(fd, TCSANOW, &tty) != 0)
		error_message("error %d setting term attributes", errno);
}


void main(int argc, char** argv)
{
	if(argc < 2) {
		error_message("error: syntax %s <port>", argv[0]);
		exit(1);
	}
	char *portname = argv[1];

	int fd = open(portname, O_RDWR | O_NOCTTY | O_SYNC);
	if(fd < 0) {
		error_message("error %d opening %s: %s", errno, portname, strerror(errno));
		return;
	}

	set_interface_attribs(fd, B115200, 0);
	set_blocking(fd, 0);

	printf("Sending beacon in loop. \
You have 5-10 seconds to power up Omnia.\n");

	char buf [8]= {0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0xbb};
	int i;
	for(i=0;i<10000;i++)
		write(fd, buf, 8);
	close(fd);
}


