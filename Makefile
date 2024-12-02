IMAGE_NAME ?= hackartist/dx-builder

run:
	docker run -it --rm --name dx-hydrate -p 8080:8080 hackartist/dx-builder bash -c "source /root/.cargo/env && dx serve --addr 0.0.0.0"

builder:
	docker build -t $(IMAGE_NAME) .
