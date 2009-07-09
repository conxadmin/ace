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
package org.apache.ace.server;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ace.client.repository.object.LicenseObject;
import org.apache.ace.client.repository.repository.LicenseRepository;
import org.apache.ace.client.services.LicenseDescriptor;
import org.apache.ace.client.services.LicenseService;

import com.google.gwt.user.server.rpc.RemoteServiceServlet;

public class LicenseServiceImpl extends RemoteServiceServlet implements LicenseService {
    /**
     * Generated serialVersionUID
     */
    private static final long serialVersionUID = -8435568874637903362L;

    public LicenseDescriptor[] getLicenses() throws Exception {
        LicenseRepository lr = Activator.getService(getThreadLocalRequest(), LicenseRepository.class);
        
        List<LicenseDescriptor> result = new ArrayList<LicenseDescriptor>();
        
        for (LicenseObject l : lr.get()) {
            result.add(new LicenseDescriptor(l.getName()));
        }
        
        return result.toArray(new LicenseDescriptor[result.size()]);
    }

    public void addLicense(String name) throws Exception {
        LicenseRepository gr = Activator.getService(getThreadLocalRequest(), LicenseRepository.class);
        
        Map<String, String> props = new HashMap<String, String>();
        props.put(LicenseObject.KEY_NAME, name);
        gr.create(props, null);
    }
}
