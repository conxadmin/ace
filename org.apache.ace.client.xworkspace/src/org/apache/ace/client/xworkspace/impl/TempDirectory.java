package org.apache.ace.client.xworkspace.impl;

import java.io.IOException;
import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;

class TempDirectory {
    final Path path;

    public TempDirectory() {
        try {
            path = Files.createTempDirectory("apache_ace_xworkspace");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public Path getPath() {
        return path;
    }

    public void deleteOnExit() {
        Runtime.getRuntime().addShutdownHook(new Thread() {
            @Override
            public void run() {
                delete();
            }
        });
    }

    public void delete() {
        if (!Files.exists(path)) {
            return;
        }
        try {
        	ClassLoader tccl = Thread.currentThread().getContextClassLoader();
        	try {
        	    Thread.currentThread().setContextClassLoader(getClass().getClassLoader());
        	    /*
        	     * Start threads, or establish connections, here, now
        	     */
                Files.walkFileTree(path, new CustomSimpleFileVisitor());
        	} finally {
        	    Thread.currentThread().setContextClassLoader(tccl);
        	}
        } catch (Exception e) {
            //throw new RuntimeException(e);
        } catch (Error e) {
            //throw new RuntimeException(e);
        }
    }

}   