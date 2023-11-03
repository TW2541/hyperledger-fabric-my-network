if [ $# -lt 1 ]; then
  echo "Usage: $0 <network-status> "
  echo "network-status usage :"
  echo "    up : this will create crypto material artifacts and deploy up using docker-compose"
  echo "    down : this will stopped all artifacts container"
  echo "    status : this will logs all artifacts container"
  exit 1
fi

NETWORKSTATUS=$1

if [ "$NETWORKSTATUS" == "up" ]
then
    echo "Building crypto material artifacts"
    cd ./artifacts

    # Create Artifacts
    bash ./create-artifacts.sh

    echo "Deploying using docker-compose"

    # Create container and run
    docker-compose up -d

elif [ "$NETWORKSTATUS" == "down" ]
then
    echo "Stopping all artifacts container"
    cd ./artifacts

    # Down all container
    docker-compose down

elif [ "$NETWORKSTATUS" == "log" ]
then
    echo "Opening docker-compose logs"
    cd ./artifacts

    # Down all container
    docker-compose logs -f

else
    echo "Invalid Parameter"
    exit 1
fi
