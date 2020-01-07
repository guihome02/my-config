vcl 4.0;

import std;

backend default {
    .host = "172.18.0.1";
    .port = "50000";
}

# Hosts allowed to send BAN requests
acl invalidators {
    "localhost";
    # Add any other IP addresses that your application runs on and that you
    # want to allow invalidation requests from. For instance:
    # "192.168.1.0"/24;
}

include "fos/fos_purge.vcl";
sub vcl_recv {
    call fos_purge_recv;
}

include "fos/fos_refresh.vcl";
sub vcl_recv {
    call fos_refresh_recv;
}

include "fos/fos_ban.vcl";
sub vcl_recv {
    call fos_ban_recv;
}
sub vcl_backend_response {
    call fos_ban_backend_response;
}
sub vcl_deliver {
    call fos_ban_deliver;
}

include "fos/fos_tags_xkey.vcl";
sub vcl_recv {
    call fos_tags_xkey_recv;
}

include "fos/fos_user_context.vcl";
include "fos/fos_user_context_url.vcl";
sub vcl_recv {
    call fos_user_context_recv;
}
sub vcl_backend_response {
    call fos_user_context_backend_response;
}
sub vcl_deliver {
    call fos_user_context_deliver;
}

include "fos/fos_custom_ttl.vcl";
sub vcl_backend_response {
    call fos_custom_ttl_backend_response;
}

include "fos/fos_debug.vcl";
sub vcl_deliver {
    call fos_debug_deliver;
}
