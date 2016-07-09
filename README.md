> In this repo i will be demonstrating autoscaling in openshift v3

### Create an app to test , say nginx
```sh
oc run nginx --image=nginx --limits=cpu=200m,memory=400Mi --requests=cpu=100m,memory=200Mi
oc expose dc nginx --port=80
````

### Create horizontal scaler object and link with nginx deployment
```yml
apiVersion: extensions/v1beta1
kind: HorizontalPodAutoscaler
metadata:
  name: frontend-scaler 
spec:
  scaleRef:
    kind: DeploymentConfig 
    name: nginx
    apiVersion: v1 
    subresource: scale
  minReplicas: 1 
  maxReplicas: 10 
  cpuUtilization:
    targetPercentage: 5
```


### Pump  some test traffic
```sh
ab -n 1000000 -c 75 http://nginx-qa.apps.10.2.2.2.xip.io
```


>  Watch the number of pods increasing after a while.  
> Happy Scaling!
