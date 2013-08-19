/* htcnetup.c
 * LuoXiaoqiu <qilvilu@gmail.com>
 * An activater for HTC android phone Internet pass-through.
 */

#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<errno.h>
 
#include<sys/types.h>
#include<sys/socket.h>
#include<unistd.h>//close()
#include<netinet/in.h>//struct sockaddr_in
#include<arpa/inet.h>//inet_ntoa

#define DEST_PORT 6000


/* activater process*/
void process_info(int s)
{
        int send_num;
        int recv_num;         
        char recv_buf[4];

        /*the first handshaking*/ 
        printf("begin send 0x00020000:\n");
        send_num = send(s,"\x00\x02\x00\x00",4,0);
        if (send_num < 0){
        	perror("send");
                exit(1);
        } else {
		printf("send 0x00020000 sucess!\n");
        }

        printf("begin recv 0x80020000:\n");
        recv_num = recv(s,recv_buf,sizeof(recv_buf),0);
        if(recv_num < 0){
                perror("recv");
                exit(1);
        } else {
                recv_buf[recv_num]='\0';
                printf("recv sucess:%s\n",recv_buf);
		if (strcmp(recv_buf, "\x80\x02\x00\x00") != 0){
			perror("0x80020000 handshaking failure");
                        exit(1);
		} else {
			printf("recv 0x80020000 sucess!\n");

			/*the second handshaking*/ 
        		printf("begin send 0x00030000:\n");
			send_num = send(s,"\x00\x03\x00\x00",4,0);
                 	if (send_num < 0){
                          	perror("send");
                          	exit(1);
                  	} else {
                          	printf("send 0x00030000 sucess!\n");
                  	}
		}
	}


	printf("begin recv 0x80030000:\n");
        recv_num = recv(s,recv_buf,sizeof(recv_buf),0);
	if(recv_num < 0){
                perror("recv");
                exit(1);
        } else {
                recv_buf[recv_num]='\0';
                printf("recv sucess:%s\n",recv_buf);
		if (strcmp(recv_buf, "\x80\x03\x00\x00") != 0){
			perror("0x80030000 handshaking failure");
                        exit(1);
		} else {
			printf("recv 0x80030000 sucess!\n");

			/*the third handshaking*/ 
        		printf("begin send 0x00050000:\n");
			send_num = send(s,"\x00\x05\x00\x00",4,0);
                  	if (send_num < 0){
                          	perror("send");
                          	exit(1);
                  	} else {
				printf("send 0x00050000 sucess!\n");
                  	}
         
 		}
	}
	printf("the activater process success!\n");
}



int main(int argc,char *argv[])
{
        int sock_fd;
        struct sockaddr_in addr_serv;

	/* check args */
	if(argc != 2)
	{
	printf("usage: htcnetup <IPaddress>\n");
	exit(1);
	}


        sock_fd = socket(AF_INET,SOCK_STREAM,0);
        if(sock_fd < 0){
               perror("sock");
                exit(1);
        } else {
                printf("sock sucessful:\n");
        }
        memset(&addr_serv,0,sizeof(addr_serv));
        addr_serv.sin_family = AF_INET;
        addr_serv.sin_port =  htons(DEST_PORT);
        addr_serv.sin_addr.s_addr = inet_addr(argv[1]);
       if( connect(sock_fd,(struct sockaddr *)&addr_serv,sizeof(struct sockaddr)) < 0){
                perror("connect");
                printf("connect (%d)\n",errno);
                exit(1);
       } else {
                printf("connect sucessful\n");
       }
        process_info(sock_fd);
        close(sock_fd);
}
