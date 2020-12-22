{
    "Sample_01": {
        "class": "Tenant",
        "A1": {
            "class": "Application",
            "template": "http",
            "serviceMain": {
                "class": "Service_HTTP",
                "virtualAddresses": [
                    "10.0.2.101"
                ],
                "persistenceMethods": [],
                "profileMultiplex": {
                    "bigip": "/Common/oneconnect"
                },
                "pool": "web_pool"
            },
            "web_pool": {
                "class": "Pool",
                "monitors": [
                    "http"
                ],
                "members": [
                    {
                        "servicePort": 80,
                        "addressDiscovery": "consul",
                        "updateInterval": 10,
                        "uri": "http://10.0.2.100:8500/v1/catalog/service/nginx"
                    }
                ]
            }
        }
    },
    "class": "ADC",
    "schemaVersion": "3.22.0",
    "updateMode": "selective"
}