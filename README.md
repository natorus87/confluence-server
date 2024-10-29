
# Confluence Docker Image

This repository provides a Docker image for **Atlassian Confluence Server** based on version `8.5.5`, with an upgrade option to version `8.5.16`. The Dockerfile is designed to manually update Confluence to a specific version by downloading and installing the latest release package. This approach is useful as Atlassian no longer provides Docker images for newer versions.

## Features

- **Base Image**: `atlassian/confluence-server:8.5.5`
- **Customizable Version**: The Confluence version to upgrade can be specified via the `APP_VERSION` build argument.
- **Utility Tools**: The image includes `curl`, `nano`, `wget`, and `unzip` for easier handling of Confluence updates and troubleshooting within the container.

## Getting Started

### Prerequisites

Ensure you have Docker installed on your machine. 

### Build the Image

To build the Docker image, you can specify the Confluence version using the `APP_VERSION` argument.

```bash
docker build -t my-confluence-image --build-arg APP_VERSION=8.5.16 .
```

### Run the Container

Once the image is built, you can run the Confluence container with the following command:

```bash
docker run -d --name confluence -p 8090:8090 -p 8091:8091 my-confluence-image
```

This will start Confluence and make it accessible on ports `8090` and `8091`.

## Configuration

The image is configured to set up Confluence in the directory `/opt/atlassian/confluence` and use `/var/atlassian/application-data/confluence` as the working directory.

### Environment Variables

The following environment variables can be customized:

- `APP_VERSION`: Version of Confluence to install (default: `8.5.16`).
- Database-related environment variables:
  - `POSTGRES_DB`
  - `POSTGRES_USER`
  - `POSTGRES_PASSWORD`

## Volumes

For persistent data, consider mounting a volume to `/var/atlassian/application-data/confluence`:

```bash
docker run -d --name confluence -p 8090:8090 -v confluence-data:/var/atlassian/application-data/confluence my-confluence-image
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

**Note**: Atlassian Confluence is a proprietary software. You must have a valid license to use Confluence Server. This Docker image does not grant any license to Confluence itself.
