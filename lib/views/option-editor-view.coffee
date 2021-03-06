{ScrollView} = require "atom-space-pen-views"
git = require '../git'
CodeLine = require '../models/code-line'
$ = require 'jquery'
App = require '../app'

module.exports =
	class OptionEdtiorView extends ScrollView
		@content: ->
			@div class: 'option-editor', =>
				@div outlet: 'container', =>
					@h1 'Option Editor'

					# 危険な時間指定
					@form id: 'SetTime', =>
						@label "Time:"
						@input type: "time", step: "3600", id: 'startTime', outlet: "startTime", value: "22:00"
						@text("~")
						@input type: "time", step: "3600", id: 'endTime', outlet: "endTime", value: "03:00"

					@h3 'priority'

					@table =>
							@form id: 'time', =>
								@tr =>
									@td =>
										@label "Time:"
								@tr =>
								@td =>
									@input type: "range", min: "0", max: "10", id: 'timePriority',outlet: "timePriority",value: "10"
							@form id: 'member', =>
								@tr =>
									@td =>
										@label "Member:"
								@tr =>
									@td =>
										@input type: "range", min: "0", max: "10", id: 'memberPriority', outlet: "memberPriority",value: "10"
							@form id: 'nummod', =>
								@tr =>
									@td =>
										@label "NumMod:"
								@tr =>
									@td =>
										@input type: "range", min: "0", max: "10", id: 'NummodPriority', outlet: "nummodPriority",value: "10"

		initialize: ->
			# イベントの購読はここに書きます
			@timePriority.on 'input', => @updatePriority()
			@nummodPriority.on 'input', => @updatePriority()
			@memberPriority.on 'input', => @updatePriority()
			@startTime.on 'input', => @updateTime()
			@endTime.on 'input', => @updateTime()


		updatePriority: ->
			App.instance().algorithm.changePriority(parseInt(@timePriority.val(),10),parseInt(@memberPriority.val(),10),parseInt(@nummodPriority.val(),10))

		updateTime: ->
			App.instance().algorithm.changeTime(parseInt(@startTime.val(),10),parseInt(@endTime.val(),10))
