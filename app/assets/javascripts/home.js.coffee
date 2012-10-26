# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
  $("#keywords-select").select2
   tags: ["services", "promotion", "careers", "team", "agency", "company", "clients", "enquiries", "solutions", "benefits", "product", "brochure"]
   tokenSeparators: [","]
    
  $("#cl-btn").click ->
   $("#keywords-select").select2 "val", ""

  $("#neg-keywords-select").select2
   tags: ["plesk", "cpanel", "forum", "domain for sale", "in construction"]
   tokenSeparators: [","]
    
  $("#cl-btn-n").click ->
   $("#neg-keywords-select").select2 "val", ""
