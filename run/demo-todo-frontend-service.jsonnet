local params = import 'params.jsonnet';

{
  apiVersion: 'v1',
  kind: 'Service',
  metadata: {
    name: params.demo_todo_frontend.name,
    labels: {
      'versionlens.com/version': std.extVar('VERSION_NAME'),
    },
  },
  spec: {
    ports: [
      {
        port: 80,
        targetPort: params.demo_todo_frontend.containerPort,
      },
    ],
    selector: {
      app: params.demo_todo_frontend.name,
    },
    type: 'NodePort',
  },
}
