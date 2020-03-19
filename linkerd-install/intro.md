In this introductory level track, you'll learn how to install [Linkerd](https://linkerd.io) to a test cluster that has been provisioned for you.

The first step introduces the environment, including the kubernetes cluster. 

In the second step, you will:
- Learn how to check that you can install Linkerd to your cluster
- Install the Linkerd control plane to your cluster
- Verify that the installation is healthy and running properly

The third step introduces the web and CLI interfaces for Linkerd.

In the fourth step, you'll install a sample application and learn how to inject data plane proxies in to the deployments. This will introduce you to the `sidecar pattern` where the proxy runs in the same pod as the service.

Finally, the fifth step will teach you about the different Linkerd commands that you can use to view and consume the _golden metrics_ of the emojivoto application.