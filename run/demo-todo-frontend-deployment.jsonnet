local params = import 'params.jsonnet';

{
  apiVersion: 'apps/v1',
  kind: 'Deployment',
  metadata: {
    name: params.demo_todo_frontend.name,
    labels: {
      'versionlens.com/version': std.extVar('VERSION_NAME'),
    },
  },
  spec: {
    replicas: params.demo_todo_frontend.replicas,
    selector: {
      matchLabels: {
        app: params.demo_todo_frontend.name,
      },
    },
    template: {
      metadata: {
        labels: {
          app: params.demo_todo_frontend.name,
          'versionlens.com/version': std.extVar('VERSION_NAME'),
        },
      },
      spec: {
        tolerations: [
          {
            key: 'versionlens.com/free-tier',
            operator: 'Exists',
            effect: 'NoSchedule',
          },
        ],
        containers: [
          {
            name: params.demo_todo_frontend.name,
            image: params.demo_todo_frontend.registry + '/' + params.demo_todo_frontend.image + ':' + params.demo_todo_frontend.tag,
            imagePullPolicy: 'Always',
            ports: [
              {
                containerPort: params.demo_todo_frontend.containerPort,
              },
            ],
            env: [
              {
                name: 'VITE_GRAPHQL_HTTP_HOST',
                value: 'https://demo-todo-backend--' + std.extVar('VERSION_URL'),
              },
            ],
            resources: {
              limits: {
                memory: '256Mi',
              },
            },
            // livenessProbe: {
            //   httpGet: {
            //     path: '/_alive',
            //     port: 8000,
            //   },
            //   initialDelaySeconds: 20,
            // },
          },
        ],
      },
    },
  },
}
