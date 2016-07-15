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
            Files.walkFileTree(path, new CustomSimpleFileVisitor());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

}   