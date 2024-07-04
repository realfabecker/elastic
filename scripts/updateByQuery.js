
(async() => {
    const axios = require('axios')
    const payload = (fromDate, toDate) => {
        const f = fromDate.toISOString().substr(0,10)
        const t = toDate.toISOString().substr(0,10)    
        return {
            "script": {
                "source": "ctx._source.lighthouseResult.audits.remove('finalScreenshot')"
            },
            "query": {
                "range": {
                    "syncTime": {
                        "gte": `${f}T00:00:00.000Z`,
                        "lte": `${t}T23:59:59.000Z`
                    }
                }
            }
        }
    }

    const updateByQuery = (body) => {
        console.log(JSON.stringify(body, undefined, "   "));
        const url = "https://localhost:9200/magazord_pagespeed/_update_by_query";
        return axios.post(url, body, {
            auth: {
                username: ":user",
                password: ":pass"
            }
        })
    }

    let s = new Date(2023,0,1);
    let t = new Date(s.getTime())
    t.setDate(s.getDate() + 5);
    try {
        do {
            await updateByQuery(payload(s,t))
            s = new Date(t.getTime());
            s.setDate(t.getDate()+1)
            
            t = new Date(s.getTime())
            t.setDate(s.getDate() + 15);
        } while (s < new Date());
    } catch(e) {
        console.log(e)
    }    
})()
