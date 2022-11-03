---
layout: ""
page_title: "hpegl_vmaas_load_balancer_profile Resource - vmaas-terraform-resources"
subcategory: "vmaas"
description: |-
    loadbalancer Profile resource facilitates creating, updating
          and deleting NSX-T Network Load Balancer Profiles.
---

# Resource hpegl_vmaas_load_balancer_profile

-> Compatible version >= 5.4.6

loadbalancer Profile resource facilitates creating, updating
		and deleting NSX-T Network Load Balancer Profiles.
`hpegl_vmaas_load_balancer_profile` resource supports NSX-T Load balancer Profile creation.

For creating an NSX-T Load balancer Profile, use the following examples.

-> NSX-T Profile having HTTP, HTTPS, UDP, TCP, COOKIE, SOURCEIP, GENERIC, SERVER and CLIENT considered as different Profile types. You can create any one of them at a given time

## Example usage for creating NSX-T Load balancer Profile for HTTP with all possible attributes

```terraform
# (C) Copyright 2022 Hewlett Packard Enterprise Development LP


# APPLICATION Profile for HTTP service
resource "hpegl_vmaas_load_balancer_profile" "tf_APPLICATION-HTTP" {
  lb_id        = data.hpegl_vmaas_load_balancer.tf_lb.id
  name         = "tf_APPLICATION-HTTP"
  description  = "APPLICATION-HTTP-Profile creating using tf"
  profile_type = "application-profile"
  http_profile {
    service_type         = "LBHttpProfile"
    http_idle_timeout    = 30
    request_header_size  = 1024
    response_header_size = 4096
    redirection          = "https"
    x_forwarded_for      = "INSERT"
    request_body_size    = 20
    response_timeout     = 60
    ntlm_authentication  = true
  }
  config {
    tags {
      tag   = "tag1"
      scope = "scope1"
    }
    tags {
      tag   = "tag2"
      scope = "scope2"
    }
  }
}
```

## Example usage for creating NSX-T Load balancer Profile for TCP with all possible attributes

```terraform
# (C) Copyright 2022 Hewlett Packard Enterprise Development LP


# APPLICATION Profile for TCP service
resource "hpegl_vmaas_load_balancer_profile" "tf_APPLICATION-TCP" {
  lb_id        = data.hpegl_vmaas_load_balancer.tf_lb.id
  name         = "tf_APPLICATION-TCP"
  description  = "APPLICATION-TCP creating using tf"
  profile_type = "application-profile"
  tcp_profile {
    service_type             = "LBFastTcpProfile"
    fast_tcp_idle_timeout    = 1800
    connection_close_timeout = 8
    ha_flow_mirroring        = true
  }
  config {
    tags {
      tag   = "tag1"
      scope = "scope1"
    }
  }
}
```

## Example usage for creating NSX-T Load balancer Profile for UDP with all possible attributes

```terraform
# (C) Copyright 2022 Hewlett Packard Enterprise Development LP

# APPLICATION Profile for UDP service
resource "hpegl_vmaas_load_balancer_profile" "tf_APPLICATION-UDP" {
  lb_id        = data.hpegl_vmaas_load_balancer.tf_lb.id
  name         = "tf_APPLICATION-UDP"
  description  = "tf_APPLICATION-UDP creating using tf"
  profile_type = "application-profile"
  udp_profile {
    service_type          = "LBFastUdpProfile"
    fast_udp_idle_timeout = 30
    ha_flow_mirroring     = true
  }
  config {
    tags {
      tag   = "tag1"
      scope = "scope1"
    }
  }
}
```

## Example usage for creating NSX-T Load balancer Profile for COOKIE with all possible attributes

```terraform
# (C) Copyright 2022 Hewlett Packard Enterprise Development LP


# PERSISTENCE Profile for COOKIE service
resource "hpegl_vmaas_load_balancer_profile" "tf_PERSISTENCE-COOKIE" {
  lb_id        = data.hpegl_vmaas_load_balancer.tf_lb.id
  name         = "tf_PERSISTENCE-COOKIE"
  description  = "PERSISTENCE-COOKIE creating using tf"
  profile_type = "persistence-profile"
  cookie_profile {
    service_type      = "LBCookiePersistenceProfile"
    cookie_name       = "cookie1"
    cookie_fallback   = true
    cookie_garbling   = true
    cookie_mode       = "INSERT"
    cookie_type       = "LBPersistenceCookieTime"
    cookie_domain     = "domain1"
    cookie_path       = "http://cookie.com"
    max_idle_time     = 60
    share_persistence = true
  }
  config {
    tags {
      tag   = "tag1"
      scope = "scope1"
    }
  }
}
```

## Example usage for creating NSX-T Load balancer Profile for GENERIC with all possible attributes

```terraform
# (C) Copyright 2022 Hewlett Packard Enterprise Development LP

# PERSISTENCE Profile for GENERIC service
resource "hpegl_vmaas_load_balancer_profile" "tf_PERSISTENCE-GENERIC" {
  lb_id        = data.hpegl_vmaas_load_balancer.tf_lb.id
  name         = "tf_PERSISTENCE-GENERIC"
  description  = "PERSISTENCE-GENERIC creating using tf"
  profile_type = "persistence-profile"
  generic_profile {
    service_type              = "LBGenericPersistenceProfile"
    share_persistence         = false
    ha_persistence_mirroring  = false
    persistence_entry_timeout = 30
  }
  config {
    tags {
      tag   = "tag1"
      scope = "scope1"
    }
  }
}
```

## Example usage for creating NSX-T Load balancer Profile for SOURCEIP with all possible attributes

```terraform
# (C) Copyright 2022 Hewlett Packard Enterprise Development LP

# PERSISTENCE Profile for SOURCEIP service
resource "hpegl_vmaas_load_balancer_profile" "tf_PERSISTENCE-SOURCEIP" {
  lb_id        = data.hpegl_vmaas_load_balancer.tf_lb.id
  name         = "tf_PERSISTENCE-SOURCEIP"
  description  = "PERSISTENCE-SOURCEIP creating using tf"
  profile_type = "persistence-profile"
  sourceip_profile {
    service_type              = "LBSourceIpPersistenceProfile"
    share_persistence         = false
    ha_persistence_mirroring  = false
    persistence_entry_timeout = 300
    purge_entries_when_full   = true
  }
  config {
    tags {
      tag   = "tag1"
      scope = "scope1"
    }
  }
}
```

## Example usage for creating NSX-T Load balancer Profile for SERVER with all possible attributes

```terraform
# (C) Copyright 2022 Hewlett Packard Enterprise Development LP

# SSL Profile for SERVER service
resource "hpegl_vmaas_load_balancer_profile" "tf_SSL-SERVER" {
  lb_id        = data.hpegl_vmaas_load_balancer.tf_lb.id
  name         = "tf_SSL-SERVER"
  description  = "SSL-SERVER creating using tf"
  profile_type = "ssl-profile"
  server_profile {
    service_type  = "LBServerSslProfile"
    ssl_suite     = "BALANCED"
    session_cache = true
  }
  config {
    tags {
      tag   = "tag1"
      scope = "scope1"
    }
  }
}
```

## Example usage for creating NSX-T Load balancer Profile for CLIENT with all possible attributes

```terraform
# (C) Copyright 2022 Hewlett Packard Enterprise Development LP

# SSL Profile for CLIENT service
resource "hpegl_vmaas_load_balancer_profile" "tf_SSL-CLIENT" {
  lb_id        = data.hpegl_vmaas_load_balancer.tf_lb.id
  name         = "tf_SSL-CLIENT"
  description  = "SSL-CLIENT creating using tf"
  profile_type = "ssl-profile"
  client_profile {
    service_type                = "LBClientSslProfile"
    ssl_suite                   = "BALANCED"
    session_cache               = true
    session_cache_entry_timeout = 300
    prefer_server_cipher        = true
  }
  config {
    tags {
      tag   = "tag1"
      scope = "scope1"
    }
  }
}
```

<!-- schema generated by tfplugindocs -->
## Schema

### Required

- `lb_id` (Number) Parent lb ID, lb_id can be obtained by using LB datasource/resource.
- `name` (String) Network loadbalancer Profile Name

### Optional

- `client_profile` (Block List, Max: 1) Client Profile configuration (see [below for nested schema](#nestedblock--client_profile))
- `config` (Block List) profile Configuration (see [below for nested schema](#nestedblock--config))
- `cookie_profile` (Block List, Max: 1) Cookie Profile configuration (see [below for nested schema](#nestedblock--cookie_profile))
- `description` (String) Creating the Network Load balancer Profile
- `generic_profile` (Block List, Max: 1) Generic Profile configuration (see [below for nested schema](#nestedblock--generic_profile))
- `http_profile` (Block List, Max: 1) HTTP Profile configuration (see [below for nested schema](#nestedblock--http_profile))
- `profile_type` (String) Network Loadbalancer Supported values are `application-profile`, `ssl-profile`, `persistence-profile`
- `server_profile` (Block List, Max: 1) Server Profile configuration (see [below for nested schema](#nestedblock--server_profile))
- `sourceip_profile` (Block List, Max: 1) SourceIP Profile configuration (see [below for nested schema](#nestedblock--sourceip_profile))
- `tcp_profile` (Block List, Max: 1) TCP Profile configuration (see [below for nested schema](#nestedblock--tcp_profile))
- `udp_profile` (Block List, Max: 1) UDP Profile configuration (see [below for nested schema](#nestedblock--udp_profile))

### Read-Only

- `id` (String) The ID of this resource.

<a id="nestedblock--client_profile"></a>
### Nested Schema for `client_profile`

Required:

- `service_type` (String) Provide the  Supported values for serviceType
- `ssl_suite` (String) Provide the  Supported values for ssl_suite

Optional:

- `prefer_server_cipher` (Boolean) During SSL handshake as part of the SSL client sends an ordered listof ciphers that it can support (or prefers) and typically server selects the first one from the topof that list it can also support.For Perfect Forward Secrecy(PFS), server could override the client's preference
- `session_cache` (Boolean) To allow the SSL client and server to reuse previously negotiated security parameters avoidingthe expensive public key operation during an SSL handshake
- `session_cache_entry_timeout` (Number) Enter the cache timeout in seconds to specify how long the SSL sessionparameters must be kept and can be reused


<a id="nestedblock--config"></a>
### Nested Schema for `config`

Optional:

- `tags` (Block List) tags Configuration (see [below for nested schema](#nestedblock--config--tags))

<a id="nestedblock--config--tags"></a>
### Nested Schema for `config.tags`

Optional:

- `scope` (String) scope for Network Load balancer Profile
- `tag` (String) tag for Network Load balancer Profile



<a id="nestedblock--cookie_profile"></a>
### Nested Schema for `cookie_profile`

Required:

- `cookie_mode` (String) The cookie persistence mode
- `cookie_name` (String) cookie_name for Network Load balancer Profile
- `cookie_type` (String) Provide the  Supported values for cookie_type
- `service_type` (String) Provide the  Supported values for serviceType

Optional:

- `cookie_domain` (String) Enter the domain name. HTTP cookie domain can be configured only in the `INSERT` mode
- `cookie_fallback` (Boolean) Cookie fallback enabled means,so that the client request is rejectedif cookie points to a server that is in a DISABLED or is in a DOWN state
- `cookie_garbling` (Boolean) When garbling is disabled, the cookie server IP addressand port information is in a plain text
- `cookie_path` (String) Enter the cookie URL path. HTTP cookie path can be set only in the `INSERT` mode
- `max_idle_time` (Number) Enter the time in seconds that the cookie type can be idle before a cookie expires
- `share_persistence` (Boolean) Toggle the button to share the persistence so thatall virtual servers this profile is associated with can share the persistence table


<a id="nestedblock--generic_profile"></a>
### Nested Schema for `generic_profile`

Required:

- `service_type` (String) Provide the  Supported values for serviceType

Optional:

- `ha_persistence_mirroring` (Boolean) Toggle the button to synchronize persistence entries to the HA peer.When HA persistence mirroring is enabled,the client IP persistence remains in the case of load balancer failover.
- `persistence_entry_timeout` (Number) Persistence expiration time in seconds,counted from the time all the connections are completed
- `share_persistence` (Boolean) Toggle the button to share the persistence sothat all virtual servers this profile is associated with can share the persistence table


<a id="nestedblock--http_profile"></a>
### Nested Schema for `http_profile`

Required:

- `redirection` (String) If a website is temporarily down or has moved, incoming requestsfor that virtual server can be temporarily redirected to a URL specified here.
- `service_type` (String) Provide the Supported values for serviceTypes
- `x_forwarded_for` (String) When this value is set, the x_forwarded_for header in the incoming request will be inserted or replaced.

Optional:

- `http_idle_timeout` (Number) Timeout in seconds to specify how long an HTTP application can remain idle
- `ntlm_authentication` (Boolean) Toggle the button for the load balancer to turn off TCP multiplexing and enable HTTP keep-alive.
- `request_body_size` (String) Enter value for the maximum size of the buffer used to store the HTTP request body
- `request_header_size` (Number) Specify the maximum buffer size in bytes used to store HTTP request headers
- `response_header_size` (Number) Specify the maximum buffer size in bytes used to store HTTP response headers.
- `response_timeout` (Number) Number of seconds waiting for the server response before the connection is closed.


<a id="nestedblock--server_profile"></a>
### Nested Schema for `server_profile`

Required:

- `service_type` (String) Provide the  Supported values for serviceType
- `session_cache` (Boolean) To allow the SSL client and server to reuse previously negotiated security parameters avoidingthe expensive public key operation during an SSL handshake
- `ssl_suite` (String) Provide the  Supported values for ssl_suite


<a id="nestedblock--sourceip_profile"></a>
### Nested Schema for `sourceip_profile`

Required:

- `service_type` (String) Provide the  Supported values for serviceType

Optional:

- `ha_persistence_mirroring` (Boolean) Toggle the button to synchronize persistence entries to the HA peer.When HA persistence mirroring is enabled,the client IP persistence remains in the case of load balancer failover
- `persistence_entry_timeout` (Number) Persistence expiration time in seconds, counted from the time all the connections are completed
- `purge_entries_when_full` (Boolean) When this option is enabled, the oldest entry isdeleted to accept the newest entry in the persistence table
- `share_persistence` (Boolean) Toggle the button to share the persistence so that all virtual serversthis profile is associated with can share the persistence table


<a id="nestedblock--tcp_profile"></a>
### Nested Schema for `tcp_profile`

Required:

- `service_type` (String) Provide the  Supported values for serviceType

Optional:

- `connection_close_timeout` (Number) Timeout in seconds to specify how long a closed TCP connection
- `fast_tcp_idle_timeout` (Number) Timeout in seconds to specify how long an idle TCP connection in ESTABLISHED
- `ha_flow_mirroring` (Boolean) Toggle the button to make all the flows to the associated virtual server mirrored to the HA standby node


<a id="nestedblock--udp_profile"></a>
### Nested Schema for `udp_profile`

Required:

- `service_type` (String) Provide the  Supported values for serviceType

Optional:

- `fast_udp_idle_timeout` (Number) Timeout in seconds to specify how long an idle UDP connection in ESTABLISHED
- `ha_flow_mirroring` (Boolean) Toggle the button to make all the flows to the associated virtual server mirrored to the HA standby node