{
    "class": "ADC",
    "schemaVersion": "3.22.0",
    "updateMode": "selective",
    "Sample_01": {
        "class": "Tenant",
        "A1": {
            "class": "Application",
            "template": "https",
            "serviceMain": {
                "class": "Service_HTTPS",
                "virtualPort": 443,
                "serverTLS": "TlsServerLetsEncrypt",
                "virtualAddresses": [
                    "10.0.2.101"
                ],
                "pool": "web_pool",
                "persistenceMethods": [],
                "profileMultiplex": {
                    "bigip": "/Common/oneconnect"
                }
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
            },
            "TlsServerLetsEncrypt": {
                "class": "TLS_Server",
                "label": "Lets Encrypt Demo",
                "certificates": [{
                    "certificate": "vs1LeCert"
                }]
            },
            "vs1LeCert": {
                "class": "Certificate",
                "remark": "remark",
                "certificate": {{ lookup('file', cn + '.pem.crt') | to_json }},
                "privateKey": {{ lookup('file', cn + '.pem.key') | to_json }}
            }
        }
    }
}