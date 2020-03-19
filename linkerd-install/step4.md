In this step, we'll install a sample application called emojivoto and inject the pods with the linkerd proxy.

`curl -sL https://run.linkerd.io/emojivoto.yml | kubectl apply -f -`

At this point, the containers will be starting and the application will _not_ be part of the
Linkerd service mesh. First, let's watch the namespace until the pods are all
started:

`kubectl get po -n emojivoto -w`

Next, let's take a look at the *web* service:

`kubectl -n emojivoto port-forward svc/web-svc 8080:80`

## Manual injection

Next, we'll manually inject one of the deployments using the `linkerd inject` command.

The command below is three commands where the output of the first two is piped
to the last. Let's break each one down. 

First, the *kubectl get -n emojivoto deploy emoji -oyaml* command uses kubectl to get the yaml for the deployment and
writes it to *stdout*.

That output is piped to the command that does all the
hard work of injecting the linkerd proxy in to the deployment specification by
adding an annotation: _linkerd.io/inject: enabled_ to the pod spec in the YAML.
The resulting injected YAML is written to *stdout*. 

At this point, none of the YAML has been applied. We have simply retrieved the YAML of the emoji deployment
from the kubernetes server and modified it by adding the annotation

The final kubectl apply command reads the value from *stdout* and senbds it to the cluster
to update the emoji deployment.

`kubectl get -n emojivoto deploy emoji -o yaml | linkerd inject - | kubectl apply -f -`

Let's look at the pods in the emojivoto namespace to make sure that the emoji deployment is injected.

`kubectl wait po -n emojivoto --all --for=condition=Ready`

When the command is complete, we can see all the pods running with the proxy injected:

`kubectl get po -n emojivoto`

Using the *linkerd inject* command for all the deployments in a large application can be tedious, but never fear.

Linkerd addresses that by allowing you to specify the _linkerd.io/injectL: enabled_
annotation at the namespace level. Let's try that now by manually editing the
namespace:

`kubectl annotate ns emojivoto linkerd.io/inject=enabled`

Then make sure that the annotation was applied to the namespace:

`kubectl get ns emojivoto -oyaml | grep \"linkerd.io/inject\"`

Now let's restart all the deployments in the *emojivoto* namespace:

`kubectl rollout restart deploy -n emojivoto`

And watch as the pods are restarted with the linkerd proxy:

`kubectl get po -n emojivoto -w`

Once the rollout is complete, you should see that all the deployments have *2/2* containers.