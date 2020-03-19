Check that linkerd can be installed to the cluster
`linkerd check --pre`

Use the Linkerd CLI to generate YAML files and pipe the output to kubectl

`linkerd install | kubectl apply -f -`

Run the linkerd check command without the --pre flag to see the status of the installation.

`linkerd check`

Check all the deployments in the linkerd namespace

`kubectl -n linkerd get deploy`

Check all the pods in the linkerd namespace

`kubectl -n linkerd get po`