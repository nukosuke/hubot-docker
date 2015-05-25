# Description
#   A hubot script that manage docker container
#
# Configuration:
#   DOCKER_HOST
#   DOCKER_PORT
#
# Commands:
#   hubot docker ps - show container list
#   hubot docker run <image> - 
#   hubot docker start <container> - 
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
    config =
        host: process.env.DOCKER_HOST or '127.0.0.1'
        port: process.env.DOCKER_PORT or 2375

    robot.docker = new Docker config

    robot.respond /docker ps/, (msg) ->
        #TODO: authenticate user
        #TODO: (all) flag
        robot.docker.listContainers {all: true}, (err, containers) ->
            t = new Table
            _.forEach containers, (cont) ->
                ports = []
                _.forEach cont.Ports, (p) ->
                    ports.push "#{p.IP}:#{p.PublicPort}->#{p.PrivatePort}/#{p.Type}"
                
                t.cell 'CONTAINER ID', cont.Id.slice 12
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
        robot.docker.createContainer
        msg.reply 

    robot.respond /docker start /, (msg) ->
        cont = robot.docker.getContainer 
        msg.reply
        
    robot.respond /docker stop /, (msg) ->
        cont = robot.docker.getContainer
        msg.reply

    robot.respond /docker images/, (msg) ->
        msg.reply
###
