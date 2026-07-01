# CLIProxyAPI

A Helm chart for [CLIProxyAPI](https://github.com/router-for-me/CLIProxyAPI) — a proxy
server that exposes OpenAI/Gemini/Claude/Codex-compatible endpoints backed by multiple
AI provider accounts.

## Installing

```sh
helm install my-cliproxyapi ./charts/cliproxyapi
```

## Configuration

The application's `config.yaml` is generated from the `config` value and mounted into the
container at `/CLIProxyAPI/config.yaml`. Any key from CLIProxyAPI's
[`config.example.yaml`](https://github.com/router-for-me/CLIProxyAPI/blob/main/config.example.yaml)
may be added under `config`.

| Key | Default | Description |
| --- | --- | --- |
| `replicaCount` | `1` | Number of pod replicas. |
| `image.repository` | `eceasy/cli-proxy-api` | Container image repository. |
| `image.tag` | `""` | Image tag. Defaults to the chart `appVersion`. |
| `image.pullPolicy` | `IfNotPresent` | Image pull policy. |
| `service.type` | `ClusterIP` | Kubernetes Service type. |
| `service.port` | `8317` | Service port. |
| `ingress.enabled` | `false` | Enable an Ingress resource. |
| `ingress.className` | `""` | IngressClass name. |
| `ingress.annotations` | `{}` | Annotations for the Ingress. |
| `ingress.hosts` | see `values.yaml` | Host and path rules. |
| `ingress.tls` | `[]` | TLS configuration. |
| `persistence.enabled` | `false` | Create/mount a PVC for the auth directory. |
| `persistence.existingClaim` | `""` | Use an existing PVC instead of creating one. |
| `persistence.storageClass` | `""` | StorageClass for the PVC (`"-"` disables dynamic provisioning). |
| `persistence.accessModes` | `[ReadWriteOnce]` | PVC access modes. |
| `persistence.size` | `1Gi` | PVC size. |
| `persistence.mountPath` | `/root/.cli-proxy-api` | Mount path; keep in sync with `config.auth-dir`. |
| `resources` | `{}` | Pod resource requests/limits. |
| `config` | see `values.yaml` | Contents of the application `config.yaml`. |

### Persistence

CLIProxyAPI stores OAuth tokens and per-credential state in its auth directory
(`config.auth-dir`, default `/root/.cli-proxy-api`). Enable `persistence` so this data
survives pod restarts, and keep `persistence.mountPath` and `config.auth-dir` pointing at
the same path.

### Ingress

```yaml
ingress:
  enabled: true
  className: nginx
  hosts:
    - host: cliproxyapi.example.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: cliproxyapi-tls
      hosts:
        - cliproxyapi.example.com
```
