# MinIo ALStor

## Prerequisites

### License
MinIO AIStor requires a license to run.<br>
To request a free tier license, go to the MinIO AIStor pricing page and select Get Started under the Free tier.<br>
Save the license to `minio.license` inside `.docker/minio` directory.

### Tools
Before installing the project, make sure the following tools are available on your machine:

- Docker Engine installed and running
- Docker Compose plugin available
- Makefile installed
- An existing Docker Traefik network, since the project relies on an external network named `traefik-network`

Quick check:

```bash
docker --version
docker compose version
make --version
```

### ENV
In the `.env` file, put the right trafik network name in TRAEFIK_NETWORK

```env
TRAEFIK_NETWORK=traefik-network
```

## Configuration

The project uses a local `.env` file to define the MinIO instance settings and the hosts exposed through Traefik.

Example configuration included in the repository:

```env
PROJECT_NAME=minio
CONSOLE_HOST=minio.localhost
API_URL=minio-api.localhost
TRAEFIK_NETWORK=traefik-network
```

Update these values as needed for your local environment or Traefik domain.

## Installation

1. Clone the repository:

```bash
git clone <repo-url>
cd minio-docker
```

2. Check the configuration:

```bash
make config
```

3. Start the stack with Docker Compose:

```bash
docker compose up -d
```

Or using the Makefile:

```bash
make up
```

The `make up` command automatically runs the initialization and build steps before starting the containers:

```bash
make up
```

## Available services

Once the containers are running, the MinIO interface is available at:

- Console: `https://minio.localhost`
- S3 API: `https://minio-api.localhost`

Default credentials:

- Username: `minioadmin`
- Password: `minioadmin`

## Management

Useful commands:

```bash
make logs
make ps
make shell
```

- `make logs` shows container logs
- `make ps` lists running containers
- `make shell` opens a shell inside the MinIO container

## Notes

- The MinIO service is exposed through Traefik on the external network `traefik-network`.
- The project expects a Traefik infrastructure to already be in place for TLS certificate management and routing.
