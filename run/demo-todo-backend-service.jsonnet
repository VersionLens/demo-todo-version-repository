local params = import 'params.json';

{
  apiVersion: 'v1',
  kind: 'Service',
  metadata: {
    name: params.demo_todo_backend.name,
    labels: {
      "versionlens.com/version": std.extVar("VERSION_NAME")
    }
  },
  spec: {
    ports: [
      {
        port: 80,
        targetPort: params.demo_todo_backend.containerPort,
      },
    ],
    selector: {
      app: params.demo_todo_backend.name,
    },
    type: 'NodePort',
  },
}