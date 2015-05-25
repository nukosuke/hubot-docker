# Description
#   A hubot script that manage docker container
#
# Configuration:
#   DOCKER_SOCK
#   DOCKER_HOST
#   DOCKER_PORT
#
# Commands:
#   hubot docker ps - show container list
#   hubot docker run <image> - <what the respond trigger does>
#   hubot docker start <container> - <what the hear trigger does>
#   hubot docker stop <container> -
#   hubot docker rm <container> -
#   hubot docker images - show image list
#   hubot docker rmi <image> - 
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   Yosuke Tamura <tamura.yosuke.tp8@gmail.com>

_      = require 'lodash'
Docker = require 'dockerode'
Table  = require 'easy-table'

module.exports = (robot) ->
    host = process.env.DOCKER_HOST or '127.0.0.1'
    port = process.env.DOCKER_PORT or 2375

    robot.docker =
        api: new Docker host: host, port: port
        containers: []

    robot.respond /docker ps/, (msg) ->
        #TODO authenticate user
        robot.docker.api.listContainers {all: false}, (err, containers) ->
            #TODO: all flag
            t = new Table
            _.forEach containers, (cont) ->
                #TODO: cut first 12 character
                ports = []
                _.forEach cont.Ports, (p) ->
                    ports.push "#{p.IP}:#{p.PublicPort}->#{p.PrivatePort}/#{p.Type}"
                
                t.cell 'CONTAINER ID', cont.Id
                t.cell 'IMAGE'       , cont.Image
                t.cell 'COMMAND'     , cont.Command
                t.cell 'CREATED'     , cont.Created
                t.cell 'STATUS'      , cont.Status
                t.cell 'PORTS'       , ports.join ','
                t.cell 'NAMES'       , cont.Names
                t.newRow()
            msg.reply t.toString()

### TODO    
    robot.respond /docker run /, (msg) ->
        robot.docker.api.createContainer
        msg.reply 

    robot.respond /docker start /, (msg) ->
        cont = robot.docker.api.getContainer 
        msg.reply
        
    robot.respond /docker stop /, (msg) ->
        cont = robot.docker.api.getContainer
        msg.reply

    robot.respond /docker images/, (msg) ->
        
        msg.reply
###
