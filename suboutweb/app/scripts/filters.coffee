module = angular.module("suboutFilters", [])
module.filter "timestamp", ->
      
module.filter "timestamp", ->
  (input) ->
    new Date(input).getTime()

module.filter "stringToDate", ->
  (input) ->
    Date.parse(input)

module.filter "soShortDate", ($filter) ->
  (input) ->
    return "" unless input
    $filter('date')(Date.parse(input), 'MM/dd/yyyy')

module.filter "soCurrency", ($filter) ->
  (input) ->
    $filter('currency')(input).replace(/\.\d\d/, "")

module.filter "websiteUrl", ->
  (url) ->
    if /^https?/i.test(url)
      url
    else
      "http://#{url}"

evaluation = (input, evaluation) ->
  evaluator = Evaluators[evaluation.type]
  if $.isFunction(evaluator)
    evaluator input, evaluation
  else
    alert "Evaluator doesn't exist."
    true

Evaluators = {}
Evaluators.range = (input, evaluation) ->
  property = input[evaluation.property]
  if property
    (property >= evaluation.params.min) and (property <= evaluation.params.max)
  else
    true

Evaluators.today = (input, evaluation) ->
  property = input[evaluation.property]
  if property
    current_time = new Date().getTime()
    current_day = parseInt(current_time / (3600 * 24 * 1000))
    property_day = parseInt(property / (3600 * 24 * 1000))
    current_day is property_day
  else
    true

Evaluators.compare = (input, evaluation) ->
  property = input[evaluation.property]
  if property
    compare = "'#{property}'
      #{evaluation.params.operator}
      '#{evaluation.params.value}'"
    eval_ compare
  else
    true

Evaluators.like = (input, evaluation) ->
  property = input[evaluation.property]
  if property
    reg = new RegExp(evaluation.params.value.toLowerCase())
    reg.test property.toLowerCase()
  else
    true