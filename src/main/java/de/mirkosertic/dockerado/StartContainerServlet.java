package de.mirkosertic.dockerado;

import java.io.IOException;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.github.dockerjava.api.DockerClient;
import com.github.dockerjava.api.command.CreateContainerResponse;
import com.github.dockerjava.api.command.InspectImageResponse;
import com.github.dockerjava.api.command.StartContainerCmd;
import com.github.dockerjava.api.model.ContainerConfig;
import com.github.dockerjava.api.model.ExposedPort;
import com.github.dockerjava.api.model.Ports;

public class StartContainerServlet extends HttpServlet {

    private AtomicInteger nextPort = new AtomicInteger(9000);

    @Override
    protected void doGet(HttpServletRequest aRequest, HttpServletResponse aResponse) throws ServletException, IOException {
        String theRequestPath = aRequest.getPathInfo();
        int theLastSlash = theRequestPath.lastIndexOf("/");
        String theImageName = theRequestPath.substring(theLastSlash + 1);

        DockerClient theClient = DockerClientHolder.INSTANCE.getClient();

        InspectImageResponse theImageInfo = theClient.inspectImageCmd(theImageName).exec();
        Ports thePorts = new Ports();
        ContainerConfig theConfig = theImageInfo.getConfig();
        if (theConfig == null) {
            theConfig = theImageInfo.getContainerConfig();
        }
        if (theConfig != null) {
            try {
                ExposedPort[] theExposedPorts = theConfig.getExposedPorts();
                if (theExposedPorts != null) {
                    for (ExposedPort thePort : theExposedPorts) {
                        thePorts.bind(thePort, Ports.Binding(nextPort.getAndIncrement()));
                    }
                }
            } catch (Exception e) {
            }
        }

        CreateContainerResponse theResponse = theClient.createContainerCmd(theImageName).withAttachStdout(true).withAttachStdin(true).withAttachStderr(true).withTty(true).withCmd("/bin/bash").exec();

        StartContainerCmd theStartContainerCommand = theClient.startContainerCmd(theResponse.getId()).withPortBindings(thePorts);

        theStartContainerCommand.exec();

        aResponse.sendRedirect("../containerlist/");
    }
}
