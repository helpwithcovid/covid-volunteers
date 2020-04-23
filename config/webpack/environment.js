const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

const aliases = require('./aliases')

environment.config.merge(aliases)
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery'
  })
)

module.exports = environment
