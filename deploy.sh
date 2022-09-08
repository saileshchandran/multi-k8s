docker build -t saileshchandran/multi-client:latest -t saileshchandran/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t saileshchandran/multi-server:latest -t saileshchandran/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t saileshchandran/multi-worker:latest -t saileshchandran/mulit-worker:$SHA -f ./worker/Dockerfile ./worker

docker push saileshchandran/multi-client:latest
docker push saileshchandran/multi-server:latest
docker push saileshchandran/multi-worker:latest

docker push saileshchandran/multi-client:$SHA
docker push saileshchandran/multi-server:$SHA
docker push saileshchandran/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=saileshchandran/multi-server:$SHA
kubectl set image deployments/client-deployment client=saileshchandran/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=saileshchandran/multi-worker:$SHA


