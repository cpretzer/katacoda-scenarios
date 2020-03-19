In this final step, we'll take a look at some of the [Linkerd CLI](https://linkerd.io/2/reference/cli/) commands that you can use to monitor and debug your emojivoto application.

The Linkerd CLI was introduced in step three, and this step takes a much deeper look at the commands made available by the CLI.

First, let's look at status of each of the deployments. The output from this command shows us the _golden metrics_ of the deployments which are:
- Success rates
- Request rates
- Latency distribution percentiles

`linkerd stat -n emojivoto deploy`

Next, we can use the *top* command to get a real-time view of which paths are being called for the application:

`linkerd top -n emojivoto deploy`

To dig deeper and more granular, we can use the *tap* command to see all the traffic that is going in and out of the *web* deployment:

`linkerd tap -n emojivoto deploy/web`

You can think of _tap_ as _tcpdump_ for your containers!
