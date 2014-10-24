package de.mirkosertic.dockerado;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.github.dockerjava.api.DockerClient;
import com.github.dockerjava.api.command.*;

public class DeleteContainerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest aRequest, HttpServletResponse aResponse) throws ServletException, IOException {
        String theRequestPath = aRequest.getPathTranslated();
        int theLastSlash = theRequestPath.lastIndexOf("/");
        String theContainerID = theRequestPath.substring(theLastSlash + 1);

        DockerClient theClient = DockerClientHolder.INSTANCE.getClient();

        KillContainerCmd theKillCmd = theClient.killContainerCmd(theContainerID);

        theKillCmd.exec();

        RemoveContainerCmd theRemoveCmd = theClient.removeContainerCmd(theContainerID).withForce(true);

        theRemoveCmd.exec();

        aResponse.sendRedirect("../containerlist/");
    }
}
