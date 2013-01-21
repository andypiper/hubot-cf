## Hubot Cloud Foundry helpers 

###  Adds a number of helpful [Cloud Foundry](http://cloudfoundry.org)-related status commands to [hubot](http://hubot.github.com)

#### Commands:
Return CF Core information about the specified *API endpoint* 
    
    hubot cf core <API endpoint>

(more commands coming soon)
    
#### License:
Apache 2: http://www.apache.org/licenses/LICENSE-2.0.html

#### Installation:

**Script only**

```curl|wget https://github.com/andypiper/hubot-cf/raw/master/src/scripts/cf.coffee``` to your hubot installation's ```scripts``` folder.

**npm module**

In your deployed ```hubot``` directory

    npm install hubot-cf

And add an entry for ```hubot-cf``` to ```package.json```:

    "dependencies": {
    "coffee-script": "~> 1.4.0",
    "optparse": "1.0.3",
    "scoped-http-client": "0.9.7",
    "log": "1.3.0",
    "connect": "2.3.4",
    "connect_router": "1.8.6",
    "hubot-cf": "0.0.1"
    }
    
Also create or update the ```external-scripts.json``` file:

    ["hubot-cf"]
    
… and run hubot as normal.
