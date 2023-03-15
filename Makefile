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

apply-code-sever-rbac:
	kubectl -n ${namespace} apply -f code-server-rbac.yaml

patch-code-server-frontend:
	kubectl -n ${namespace} patch deployment demo-todo-frontend --patch-file code-server-frontend-patch.yaml

patch-code-server-backend:
	kubectl -n ${namespace} patch deployment demo-todo-backend --patch-file code-server-backend-patch.yaml

port-forward-code-server:
	kubectl -n ${namespace} port-forward pod/${pod} 8443:8443 --address 0.0.0.0
