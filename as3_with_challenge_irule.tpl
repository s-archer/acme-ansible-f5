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
                "pool": "web_pool",
                "iRules": [ "challenge_irule" ]
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
            "challenge_irule": {
                "class": "iRule",
                "remark": "provide challenge to lets encrypt",
                "iRule": "when HTTP_REQUEST {\nif { [HTTP::uri] starts_with \"/.well-known/acme-challenge/\" }\n{\nHTTP::respond 200 content \"{{ challenge_data }}\"\n} else {\nHTTP::redirect https://[getfield [HTTP::host] \":\" 1]:443[HTTP::uri]\n}\n}"
            }
        }
    },
    "class": "ADC",
    "schemaVersion": "3.22.0",
    "updateMode": "selective"
}