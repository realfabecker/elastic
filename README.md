# Elastic

## Bulk Update Remove Property

```bash
curl --request POST \
  --url 'https://localhost:9200/index_name/_bulk?pretty=' \
  --header 'Authorization: Basic XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' \
  --header 'Content-Type: application/json' \
  --data '{ "update": { "_id": "8fd4d160-39f3-11ef-8722-7dfe4c91a440", "_index": "index_name" }}
{ "script" : {"source": "ctx._source.remove('\''lighthouseResult.audits.finalScreenshot.details.data'\'')"} }
'
```

## Remove document property

```bash
curl --request POST \
  --url 'https://localhost:9200/index_name/_update/8fd4d160-39f3-11ef-8722-7dfe4c91a440?pretty=' \
  --header 'Authorization: Basic XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' \
  --header 'Content-Type: application/json' \
  --data '{
	"script": {
		"source": "ctx._source.lighthouseResult.audits.remove('\''finalScreenshot'\'')"
	}
}' 
```

## Update by Query Filter Id

```bash
curl --request POST \
  --url 'https://localhost:9200/index_name/_update_by_query?pretty=&max_docs=1' \
  --header 'Authorization: Basic XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' \
  --header 'Content-Type: application/json' \
  --data '{
	"script": {
		"source": "ctx._source.lighthouseResult.audits.remove('\''finalScreenshot'\'')"
	},
	"query" : {
		"ids" : {
			"values": ["37bfb272-39f7-11ef-8722-7dfe4c91a440"]
		}
	}
}'
```

## Search Ranged Documents

```bash
curl --request POST \
  --url 'https://localhost:9200/index_name/_search?pretty=' \
  --header 'Authorization: Basic XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' \
  --header 'Content-Type: application/json' \
  --data '{
	"_source": [
		"_id"
	],
	"sort": {
		"syncTime": "asc"
	},
	"query": {
		"range": {
			"syncTime": {
				"gte": "2023-09-04T00:00:00.000Z",
				"lte": "2023-09-19T23:59:59.000Z"
			}
		}
	}
}'
```

## Count Ranged Documents

```bash
curl --request POST \
  --url 'https://localhost:9200/index_name/_count?pretty=' \
  --header 'Authorization: Basic XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' \
  --header 'Content-Type: application/json' \
  --data '{
	"query": {
		"range": {
			"syncTime": {
				"gte": "2024-01-26T00:00:00.000Z",
				"lte": "2024-02-10T23:59:59.000Z"
			}
		}
	}
}'
```

## Update by Query Filter Range Date


```bash
curl --request POST \
  --url 'https://localhost:9200/index_name/_update_by_query?pretty=' \
  --header 'Authorization: Basic XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' \
  --header 'Content-Type: application/json' \
  --data '{
	"script": {
		"source": "ctx._source.lighthouseResult.audits.remove('\''finalScreenshot'\'')"
	},
	"query": {
		"range": {
			"syncTime": {
				"gte": "2023-02-01T00:00:00.000Z",
				"lte": "2023-02-31T23:59:59.000Z"
			}
		}
	}
}'
```

## Update by Query Filter Range Date & Id

```bash
curl --request POST \
  --url 'https://localhost:9200/index_name/_update_by_query?pretty=' \
  --header 'Authorization: Basic XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' \
  --header 'Content-Type: application/json' \
  --data '{
	"script": {
		"source": "ctx._source.lighthouseResult.audits.remove('\''finalScreenshot'\'')"
	},
	"query": {
		"bool": {
			"must": [
				{
					"ids": {
						"values": [
							"4148ae00-ed20-11ea-b236-459144b40d0d"
						]
					}
				},
				{
					"range": {
						"syncTime": {
							"gte": "2020-09-02T13:28:57.825Z",
							"lte": "2020-09-03T13:28:57.825Z"
						}
					}
				}
			]
		}
	}
}'
```

## Get Oldest Document

```bash
curl --request POST \
  --url 'https://localhost:9200/index_name/_search?pretty=' \
  --header 'Authorization: Basic XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' \
  --header 'Content-Type: application/json' \
  --data '{
   "size": 1,
   "sort": { "syncTime": "asc"},
   "query": {
      "match_all": {}
   }
}'
```

## Search Ranged Documents (Search)

```bash
curl --request POST \
  --url 'https://localhost:9200/index_name/_search?pretty=' \
  --header 'Authorization: Basic XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' \
  --header 'Content-Type: application/json' \
  --data '{
	"size": 0,
	"sort": {
		"syncTime": "asc"
	},
	"query": {
		"range": {
			"syncTime": {
				"gte": "2020-09-02T13:28:57.825Z",
				"lte": "2020-09-03T13:28:57.825Z"
			}
		}
	}
}'
```

## List indices info

```bash
curl --request GET \
  --url https://localhost:9200/_cat/indices \
  --header 'Authorization: Basic XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' \
  --header 'Content-Type: application/json' \
  --data '{
  "index": "index_name",
  "timeout": "10s",
  "body": 
      {
        "size": 0,
        "aggs": {
            "avg_performance": {
                "filter": {
                    "bool": {
                        "must": [
                            {
                                "range": {
                                    "syncTime": {
                                        "from": ":syncTimeFrom",
                                        "to": null,
                                        "include_lower": false,
                                        "include_upper": true,
                                        "boost": 1
                                    }
                                }
                            }
                        ],
                        "adjust_pure_negative": true,
                        "boost": 1
                    }
                },
                "aggs": {
                    "geral": {
                        "terms": {
                            "field": "strategy.keyword",
                            "size": 5,
                            "show_term_doc_count_error": true
                        },
                        "aggs": {
                            "avg_transfer_size": {
                                "avg": {
                                    "field": "lighthouseResult.audits.resourceSummary.items.total.transferSize"
                                }
                            }
                        }
                    },
                    "cliente": {
                        "filter": {
                            "term": {
                                "cliente_zord_id": 1
                            }
                        },
                        "aggs": {
                            "strategy": {
                                "terms": {
                                    "field": "strategy.keyword",
                                    "size": 5,
                                    "show_term_doc_count_error": true
                                },
                                "aggs": {
                                    "avg_transfer_size": {
                                        "avg": {
                                            "field": "lighthouseResult.audits.resourceSummary.items.total.transferSize"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}'
```

## Perform Index Search

```
curl --request POST \
  --url https://localhost:9200/index_name/_search \
  --header 'Authorization: Basic XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' \
  --header 'Content-Type: application/json' \
  --data '{
	"size": 0,
	"aggs": {
		"avg_performance": {
			"filter": {
				"bool": {
					"must": [
						{
							"range": {
								"syncTime": {
									"from": "2023-01-01T23:59:59",
									"to": null,
									"include_lower": false,
									"include_upper": true,
									"boost": 1
								}
							}
						}
					],
					"adjust_pure_negative": true,
					"boost": 1
				}
			},
			"aggs": {
				"geral": {
					"terms": {
						"field": "strategy.keyword",
						"size": 5,
						"show_term_doc_count_error": true
					},
					"aggs": {
						"avg_transfer_size": {
							"avg": {
								"field": "lighthouseResult.audits.resourceSummary.items.total.transferSize"
							}
						}
					}
				},
				"cliente": {
					"filter": {
						"term": {
							"cliente_zord_id": 1
						}
					},
					"aggs": {
						"strategy": {
							"terms": {
								"field": "strategy.keyword",
								"size": 5,
								"show_term_doc_count_error": true
							},
							"aggs": {
								"avg_transfer_size": {
									"avg": {
										"field": "lighthouseResult.audits.resourceSummary.items.total.transferSize"
									}
								}
							}
						}
					}
				}
			}
		}
	}
}'
```