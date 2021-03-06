#= require_self
#= require ./helpers
#= require_tree ./templates
#= require ./routers
#= require ./models
#= require ./collections
#= require_tree ./regions
#= require_tree ./views
#= require_tree ./initializers

@DotLedgerData = {}
@DotLedger = new Marionette.Application()

Backbone.Marionette.Renderer.render = (template, data)->
  JST["dot_ledger/templates/#{template}"](data)

DotLedger.addRegions
  headerRegion: "header",
  notificationsRegion: "#notifications",
  mainRegion: "#main"
  footerRegion: "footer"
