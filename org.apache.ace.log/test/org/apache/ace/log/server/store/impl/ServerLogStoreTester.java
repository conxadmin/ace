/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package org.apache.ace.log.server.store.impl;

import static org.apache.ace.test.utils.TestUtils.UNIT;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.ace.feedback.AuditEvent;
import org.apache.ace.feedback.Descriptor;
import org.apache.ace.feedback.Event;
import org.apache.ace.test.utils.TestUtils;
import org.osgi.service.event.EventAdmin;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

public class ServerLogStoreTester {
    private LogStoreImpl m_logStore;
    private File m_dir;

    @BeforeMethod(alwaysRun = true)
    protected void setUp() throws Exception {
        m_dir = File.createTempFile("logstore", "txt");
        m_dir.delete();
        m_dir.mkdirs();
        m_logStore = new LogStoreImpl(m_dir, "log");
        TestUtils.configureObject(m_logStore, EventAdmin.class);
        m_logStore.start();
    }

    @AfterMethod(alwaysRun = true)
    protected void tearDown() throws IOException {
        delete(m_dir);
    }

    @SuppressWarnings("serial")
    @Test(groups = { UNIT })
    public void testLog() throws IOException {
        Map<String, String> props = new HashMap<String, String>();
        props.put("test", "bar");

        List<Descriptor> ranges = m_logStore.getDescriptors();
        assert ranges.isEmpty() : "New store should have no ranges.";
        List<Event> events = new ArrayList<Event>();
        for (String target : new String[] { "g1", "g2", "g3" }) {
            for (long log : new long[] { 1, 2, 3, 5 }) {
                for (long id : new long[] { 1, 2, 3, 20 }) {
                    events.add(new Event(target, log, id, System.currentTimeMillis(), AuditEvent.FRAMEWORK_STARTED, props));
                }
            }
        }
        m_logStore.put(events);
        assert m_logStore.getDescriptors().size() == 3 * 4 : "Incorrect amount of ranges returned from store";
        List<Event> stored = new ArrayList<Event>();
        for (Descriptor range : m_logStore.getDescriptors()) {
            for (Descriptor range2 : m_logStore.getDescriptors(range.getTargetID())) {
                stored.addAll(m_logStore.get(m_logStore.getDescriptor(range2.getTargetID(), range2.getStoreID())));
            }
        }

        Set<String> in = new HashSet<String>();
        for (Event event : events) {
            in.add(event.toRepresentation());
        }
        Set<String> out = new HashSet<String>();
        for (Event event : stored) {
            out.add(event.toRepresentation());
        }
        assert in.equals(out) : "Stored events differ from the added.";
    }

    @Test(groups = { TestUtils.UNIT })
    public void testLogWithSpecialCharacters() throws IOException {
        String targetID = "myta\0rget";
        Event event = new Event(targetID, 1, 1, System.currentTimeMillis(), AuditEvent.FRAMEWORK_STARTED);
        List<Event> events = new ArrayList<Event>();
        events.add(event);
        m_logStore.put(events);
        assert m_logStore.getDescriptors().size() == 1 : "Incorrect amount of ranges returned from store: expected 1, found " + m_logStore.getDescriptors().size();
        assert m_logStore.getDescriptors(targetID).size() == 1 : "We expect to find a single event: expected 1, found " + m_logStore.getDescriptors(targetID).size();
    }

    private void delete(File root) {
        if (root.isDirectory()) {
            for (File child : root.listFiles()) {
                delete(child);
            }
        }
        root.delete();
    }
}
