# Self-hosted-Gitlab
We will be seeing diffrecnt ways to host gitlab in this project.

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
