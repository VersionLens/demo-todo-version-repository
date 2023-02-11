{
  demo_todo_backend: {
    containerPort: 8000,
    image: 'versionlens/demo-todo-backend-arm64',
    name: 'demo-todo-backend',
    registry: 'docker.io',
    replicas: 1,
    tag: std.extVar('DEMO_TODO_BACKEND_SHA'),
  },
  demo_todo_frontend: {
    containerPort: 5173,
    image: 'versionlens/demo-todo-frontend-arm64',
    name: 'demo-todo-frontend',
    registry: 'docker.io',
    replicas: 1,
    tag: std.extVar('DEMO_TODO_FRONTEND_SHA'),
  },
}
