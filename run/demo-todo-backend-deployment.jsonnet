local params = import 'params.jsonnet';

{
  apiVersion: 'apps/v1',
  kind: 'Deployment',
  metadata: {
    name: params.demo_todo_backend.name,
    labels: {
      'versionlens.com/version': std.extVar('VERSION_NAME'),
    },
  },
  spec: {
    replicas: params.demo_todo_backend.replicas,
    selector: {
      matchLabels: {
        app: params.demo_todo_backend.name,
      },
    },
    template: {
      metadata: {
        labels: {
          app: params.demo_todo_backend.name,
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
            name: params.demo_todo_backend.name,
            image: params.demo_todo_backend.registry + '/' + params.demo_todo_backend.image + ':' + params.demo_todo_backend.tag,
            imagePullPolicy: 'Always',
            ports: [
              {
                containerPort: params.demo_todo_backend.containerPort,
              },
            ],
            env: [
              {
                name: 'VERSION_URL',
                value: std.extVar('VERSION_URL'),
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
