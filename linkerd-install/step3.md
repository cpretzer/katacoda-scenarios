# Linkerd Interfaces: CLI and Dashboard

Linkerd has two interfaces for getting metrics and observing the state of the workloads that are part of the service mesh.

*Note* We are going to take some preliminary steps that are not part of the normal workflow. These steps allow the dashboard
to be displayed within the Katacoda environment. _These steps are not part of a typical production deployment._

## Preliminary steps
- Change the `linkerd-web` Service type from `ClusterIP` to `LoadBalancer` to get a public IP address.

`kubectl edit svc/linkerd-web -n linkerd`

In the editor change the `type: ClusterIP` field to `type: LoadBalancer`, then save the file and exit by typing `:` then `x` followed by `enter`.

- Change the `enforced-host` argument of the `linkerd-web` container to allow access using the hostname that Katacoda generates. 

Before taking this step, it's important to understand what is changing. Linkerd includes a mechanism that protects against 
[DNS Rebinding attacks](https://linkerd.io/2/tasks/exposing-dashboard/#dns-rebinding-protection) by enforcing that the host name match a
regex pattern. The default value only allows requests from `localhost`, `127.0.0.1`, and `linkerd-web.linkerd.svc.cluster.local` (and partial forms of that pattern).

Here is the default value:
` - -enforced-host=^(localhost|127\.0\.0\.1|linkerd-web\.linkerd\.svc\.cluster\.local|linkerd-web\.linkerd\.svc|\[::1\])(:\d+)?$`

After this edit, the value will be unset:
`- -enforced-host=`

`kubectl edit deploy/linkerd-web -n linkerd`

In the editor type `/` then `enforce` then press enter. You may have to press `n` once or twice to get to the line that looks like the following, usually around line 58:

` - -enforced-host=^(localhost|127\.0\.0\.1|linkerd-web\.linkerd\.svc\.cluster\.local|linkerd-web\.linkerd\.svc|\[::1\])(:\d+)?$`

Move the cursor to the carat `^` just after the equal sign of of `enforced-host=`, then press `shift + d`. Once the line looks like the line below you can exit by pressing `:` followed by `x` and `enter`

When the editor successfully exits, Kubernetes will detect the change and re-schedule the workload with a new pod.

## View the Linkerd Dashboard

Check the browser tab to make sure that the dashboard displays

## Using the Linkerd CLI to view metrics

Use the linkerd top command to see the high-level metrics for the deployments

`linkerd -n linkerd top deploy/linkerd-web`