all : build

build :
	docker-compose -f ./srcs/docker-compose.yml up --build -d 

restart :	stop build

rebuild	:	clean build

stop :
	docker-compose -f ./srcs/docker-compose.yml stop

clean :	stop 
	docker-compose -f ./srcs/docker-compose.yml rm -f
	docker system prune -af	

down :
	docker-compose -f ./srcs/docker-compose.yml down --volumes

fclean:	stop clean down

re: fclean all

