oc run nginx --image=nginx --limits=cpu=200m,memory=400Mi --requests=cpu=100m,memory=200Mi
oc expose dc nginx --port=80
