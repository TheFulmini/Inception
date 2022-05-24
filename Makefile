VOLUME_PATH=$(HOME)/data

all:	up

up:	volumes
	docker-compose -f srcs/docker-compose.yml up -d build

volumes:
	grep -q "afulmini.42.fr" /etc/hosts || sudo sed -i '1 i\127.0.0.1	afulmini.42.fr' /etc/hosts
	[ -d /home/afulmini/data ] || \
	( sudo mkdir -p /home/afulmini && \
	sudo cp -rp srcs/requirements/tools/data /home/sabrugie/. && \
	sudo chown -R 82:82 $(VOLUME_PATH)/wp && \
	sudo chown -R 100:101 $(VOLUME_PATH)/db )

down:
	docker-compose -f srcs/docker-compose.yml down
	docker system prune -a

re:	down all 
