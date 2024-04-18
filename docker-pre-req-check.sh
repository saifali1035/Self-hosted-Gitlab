if command -v docker &> /dev/null; then
        dversion=`docker -v | awk '{print $3}'`
        echo "Docker is installed and version is $dversion"
    if command -v docker-compose &> /dev/null; then
        dcversion=`docker compose version | awk '{print $4}'`
        echo "Docker compose is installed and version is $dcversion"
    else 
        echo "Docker compose is not installed"
    fi
else 
    echo "Docker is not installed"
fi