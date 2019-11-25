note
	description: "Summary description for {COMPOSITE_EXP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMPOSITE_EXP[G]

inherit
	EXPRESSION
	COMPOSITE[G]

feature -- Attributes
	value: STRING
		deferred
		end

end
