# Self-hosted-Gitlab
We will be seeing diffrecnt ways to host gitlab in this project.

# Prerequisites
Docker and docker compose installation.
Use file **docker-pre-req-check.sh** to check both.
```BASH
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
```


# 1st Way - Using Docker Compose.

Docker compose is a tool bundled with docker, best suited for multi-container applications.

Lets create a **YAML** file named **docker-compose.yml** to specify services, networks and volumes.

```YAML
version: '3.6'
services:
  gitlab:
    image: gitlab/gitlab-ee:latest
    container_name: gitlab
    restart: always
    hostname: 'gitlab.example.com'
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        # Add any other gitlab.rb configuration here, each on its own line
        external_url 'https://gitlab.example.com'
    ports:
      - '80:80'
      - '443:443'
      - '22:22'
    volumes:
      - '$GITLAB_HOME/config:/etc/gitlab'
      - '$GITLAB_HOME/logs:/var/log/gitlab'
      - '$GITLAB_HOME/data:/var/opt/gitlab'
    shm_size: '256m'
```

We will create one **service** named **gitlab**, with conatiner named gitlab and image as **gitlab/gitlab-ee:latest**.
```YAML
version: '3.6'
services:
  gitlab:
    image: gitlab/gitlab-ee:latest
    container_name: gitlab
```

We will set restart as always so incase the container inside the service goes in error state or exits because of any reason, it will get restrated aleays.
```YAML
restart: always
```

Setting up custom **hostname** as **'gitlab.example.com'**
```YAML
hostname: 'gitlab.example.com'
```

Setting up external hostname in main configuration file of gitlab that is **gitlab.rb**
```YAML
environment:
      GITLAB_OMNIBUS_CONFIG: |
        # Add any other gitlab.rb configuration here, each on its own line
        external_url 'https://gitlab.example.com'
```

Ports that need to be opened are 22,443 and 80 for SSH, HTTP and HTTPs.
```YAML
    ports:
      - '80:80'
      - '443:443'
      - '22:22'
```
We declared our **GITLAB_HOME** earlier using **gitlab-pre-req.sh** file.
Following volumes need to be set for gitlab to save data and other files.
**/etc/gitlab** for storing the GitLab **configuration files**.
**/var/log/gitlab** is where gitlab store **logs**.
**/var/opt/gitlab**is where gitlab **application data** is stored.

```YAML
    volumes:
      - '$GITLAB_HOME/config:/etc/gitlab'
      - '$GITLAB_HOME/logs:/var/log/gitlab'
      - '$GITLAB_HOME/data:/var/opt/gitlab'
```

Set the dedicated memory for the conatiner as 256m.

```YAML
shm_size: '256m'
```

