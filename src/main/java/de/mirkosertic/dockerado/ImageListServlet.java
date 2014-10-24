package de.mirkosertic.dockerado;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.github.dockerjava.api.DockerClient;
import com.github.dockerjava.api.model.Image;

public class ImageListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest aRequest, HttpServletResponse aResponse) throws ServletException, IOException {

        DockerClient theClient = DockerClientHolder.INSTANCE.getClient();

        List<Image> theImages = theClient.listImagesCmd().exec();

        aRequest.setAttribute("data", theImages);

        aRequest.getRequestDispatcher("/images.jsp").forward(aRequest, aResponse);
    }
}
