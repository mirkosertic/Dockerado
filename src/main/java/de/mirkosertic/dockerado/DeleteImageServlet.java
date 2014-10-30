package de.mirkosertic.dockerado;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.github.dockerjava.api.DockerClient;
import com.github.dockerjava.api.command.RemoveImageCmd;

public class DeleteImageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest aRequest, HttpServletResponse aResponse) throws ServletException, IOException {
        String theRequestPath = aRequest.getPathInfo();
        int theLastSlash = theRequestPath.lastIndexOf("/");
        String theImageID = theRequestPath.substring(theLastSlash + 1);

        DockerClient theClient = DockerClientHolder.INSTANCE.getClient();

        RemoveImageCmd theRemoveCmd = theClient.removeImageCmd(theImageID).withForce(true);

        theRemoveCmd.exec();

        aResponse.sendRedirect("../imagelist/");
    }
}
