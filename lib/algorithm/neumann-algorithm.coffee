AlgorithmBase = require './algorithm-base'
MidnightRule = require './midnight-rule'
UnreliableMembersRule = require './unreliable-members-rule'

module.exports =
	class NeumannAlgorithm extends AlgorithmBase
		rules = [
			new MidnightRule(16, 3, 10), # 16時～3時に書かれたコードは危険とする
			new UnreliableMembersRule(10),
			new EditHistoryRule(10),
		]

		@evaluate: (codeLines) =>
			for codeLine in codeLines
				# 評価対象を絞り込む場合はその初日をインスタンスvalidDateに入れてください
				# 例) validDate = new Date("2016-07-01")
				if validDate? && codeLine.timestamp < validDate
					codeLine.suspicious = 0
				else
					for rule in rules
						codeLine.suspicious += rule.evaluate(codeLine,codeLines)

			return codeLines
