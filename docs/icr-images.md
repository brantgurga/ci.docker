
# IBM Container Registry (ICR)

Open Liberty container images are available from IBM Container Registry (ICR) at `icr.io/appcafe/open-liberty`. Our recommendation is to use ICR instead of Docker Hub, since ICR doesn't impose rate limits on image pulls. Images can be pulled from ICR without authentication. Only images with Universal Base Image (UBI) as the Operating System are available in ICR at the moment.

The images for the latest release and the last two quarterly releases are available at all times and are refreshed regularly.

Available image tags are listed below. The tags follow this naming convention: 
```
<fixpack_version_optional>-<liberty_image_flavour>-<java_version>-<java_type>-ubi
```

Append a tag to `icr.io/appcafe/open-liberty` to pull a specific image. For example: 
```
icr.io/appcafe/open-liberty:22.0.0.3-kernel-slim-java17-openj9-ubi
```

Available images can also be listed using [IBM Cloud CLI](https://cloud.ibm.com/docs/cli?topic=cli-getting-started). Log in with your IBMid prior to running this command: 
```
ibmcloud cr images --restrict appcafe/open-liberty
```

## Latest version

```
kernel-slim-java8-openj9-ubi
kernel-slim-java8-ibmjava-ubi
kernel-slim-java11-openj9-ubi
kernel-slim-java17-openj9-ubi

full-java8-openj9-ubi
full-java8-ibmjava-ubi
full-java11-openj9-ubi
full-java17-openj9-ubi
```

## 22.0.0.3 

```
22.0.0.3-kernel-slim-java8-openj9-ubi
22.0.0.3-kernel-slim-java8-ibmjava-ubi
22.0.0.3-kernel-slim-java11-openj9-ubi
22.0.0.3-kernel-slim-java17-openj9-ubi

22.0.0.3-full-java8-openj9-ubi
22.0.0.3-full-java8-ibmjava-ubi
22.0.0.3-full-java11-openj9-ubi
22.0.0.3-full-java17-openj9-ubi
```

## 21.0.0.12

```
21.0.0.12-kernel-slim-java8-openj9-ubi
21.0.0.12-kernel-slim-java8-ibmjava-ubi
21.0.0.12-kernel-slim-java11-openj9-ubi
21.0.0.12-kernel-slim-java17-openj9-ubi

21.0.0.12-full-java8-openj9-ubi
21.0.0.12-full-java8-ibmjava-ubi
21.0.0.12-full-java11-openj9-ubi
21.0.0.12-full-java17-openj9-ubi
```
