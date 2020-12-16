$.fn.extend {
  integrateDatepicker: (selector)->
    selector = selector || '.datepicker'
    $(@).find(selector).datepicker({format: 'mm/dd/yyyy'})
}
$(document).ready () ->
  $('body').integrateDatepicker()