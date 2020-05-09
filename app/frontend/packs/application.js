// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import 'jquery'
import '@fancyapps/fancybox'

require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
const images = require.context('../images', true)
const imagePath = (name) => images(name, true)
const svgs = require.context('../svgs', true)
const svgPath = (name) => svgs(name, true)

// Tailwind.
import './../styles/application.css'

$.fancybox.defaults.infobar = false
$.fancybox.defaults.toolbar = false
$.fancybox.defaults.hash = false

document.addEventListener("turbolinks:before-cache", function() {
  $('.js-remove-before-navigation').remove()
})

// Main App.
import Covid from '../covid'
window.Covid = Covid
Covid.initialize();
