syn clear cIncluded
syn region	cIncluded	contained start=+"[^("]+ skip=+\\\\\|\\"+ end=+"+ contains=fortranLeftMargin,fortranContinueMark,fortranSerialNumber
