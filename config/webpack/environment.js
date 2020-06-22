const { environment } = require('@rails/webpacker')
const jquery = require('./plugins/jquery')
const webpack = require('webpack')

environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: 'popper.js/dist/popper'
  })
)

environment.plugins.prepend('jquery', jquery)
module.exports = environment
