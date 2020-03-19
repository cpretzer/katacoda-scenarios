Verify that kubernetes is running:

`kubectl version --short`

Download the Linkerd CLI and install Linkerd to a cluster

`curl -sL https://run.linkerd.io/install | sh`

Follow the instructions in the output to add the linkerd executable to the `PATH` environment variable

Check the linkerd version
`linkerd version`