test-build:
	-kubectl create ns test--build--${service}
	kubectl apply -n test--build--${service} -f build-secrets
	argo -n test--build--${service} submit -f build/${service}/build_params.yaml --log build/${service}/build.argo.yaml 

test-build-nofollow:
	-kubectl create ns test--build--${service}
	kubectl apply -n test--build--${service} -f build-secrets
	argo -n test--build--${service} submit -f build/${service}/build_params.yaml build/${service}/build.argo.yaml

delete-test-build:
	-kubectl delete ns test--build--${service}

test-build-all:
	make test-build-nofollow service=demo-todo-backend
	make test-build-nofollow service=demo-todo-frontend
	
delete-test-build-all:
	make delete-test-build service=demo-todo-backend
	make delete-test-build service=demo-todo-frontend
