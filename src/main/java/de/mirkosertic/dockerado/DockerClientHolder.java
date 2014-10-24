package de.mirkosertic.dockerado;

import com.github.dockerjava.api.DockerClient;
import com.github.dockerjava.core.DockerClientConfig;
import com.github.dockerjava.jaxrs.DockerClientBuilder;

public class DockerClientHolder {

    public static final DockerClientHolder INSTANCE = new DockerClientHolder();

    private DockerClient client;

    private DockerClientHolder() {
        DockerClientConfig.DockerClientConfigBuilder configBuilder = DockerClientConfig.createDefaultConfigBuilder();
        configBuilder.withUri("http://127.0.0.1:2375");
        DockerClientConfig config = configBuilder.build();
        client = DockerClientBuilder.getInstance(config).build();
    }

    public DockerClient getClient() {
        return client;
    }
}
